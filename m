Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8E68B0D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 15:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfGONiK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 09:38:10 -0400
Received: from foss.arm.com ([217.140.110.172]:49202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730879AbfGONiK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jul 2019 09:38:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28ED228;
        Mon, 15 Jul 2019 06:38:09 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC13F3F71F;
        Mon, 15 Jul 2019 06:38:06 -0700 (PDT)
Date:   Mon, 15 Jul 2019 14:38:01 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v11 1/5] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190715133801.yohhd2hywzsv3uyf@e110439-lin>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-2-patrick.bellasi@arm.com>
 <20190708110838.4ohd7pqx5ngkzcsu@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708110838.4ohd7pqx5ngkzcsu@queper01-lin>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-Jul 12:08, Quentin Perret wrote:
> Hi Patrick,

Hi Quentin!

> On Monday 08 Jul 2019 at 09:43:53 (+0100), Patrick Bellasi wrote:
> > +static inline int uclamp_scale_from_percent(char *buf, u64 *value)
> > +{
> > +	*value = SCHED_CAPACITY_SCALE;
> > +
> > +	buf = strim(buf);
> > +	if (strncmp("max", buf, 4)) {
> > +		s64 percent;
> > +		int ret;
> > +
> > +		ret = cgroup_parse_float(buf, 2, &percent);
> > +		if (ret)
> > +			return ret;
> > +
> > +		percent <<= SCHED_CAPACITY_SHIFT;
> > +		*value = DIV_ROUND_CLOSEST_ULL(percent, 10000);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static inline u64 uclamp_percent_from_scale(u64 value)
> > +{
> > +	return DIV_ROUND_CLOSEST_ULL(value * 10000, SCHED_CAPACITY_SCALE);
> > +}
> 
> FWIW, I tried the patches and realized these conversions result in a
> 'funny' behaviour from a user's perspective. Things like this happen:
> 
>    $ echo 20 > cpu.uclamp.min
>    $ cat cpu.uclamp.min
>    20.2
>    $ echo 20.2 > cpu.uclamp.min
>    $ cat cpu.uclamp.min
>    20.21
> 
> Having looked at the code, I get why this is happening, but I'm not sure
> if a random user will. It's not an issue per se, but it's just a bit
> weird.

Yes, that's what we get if we need to use a "two decimal digit
precision percentage" to represent a 1024 range in kernel space.

I don't think the "percent <=> utilization" conversion code can be
made more robust. The only possible alternative I see to get back
exactly what we write in, is to store the actual request in kernel
space, alongside its conversion to the SCHED_CAPACITY_SCALE required by the
actual scheduler code.

Something along these lines (on top of what we have in this series):

---8<---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ddc5fcd4b9cf..82b28cfa5c3f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7148,40 +7148,35 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 	}
 }

-static inline int uclamp_scale_from_percent(char *buf, u64 *value)
+static inline int uclamp_scale_from_percent(char *buf, s64 *percent, u64 *scale)
 {
-	*value = SCHED_CAPACITY_SCALE;
+	*scale = SCHED_CAPACITY_SCALE;

 	buf = strim(buf);
 	if (strncmp("max", buf, 4)) {
-		s64 percent;
 		int ret;

-		ret = cgroup_parse_float(buf, 2, &percent);
+		ret = cgroup_parse_float(buf, 2, percent);
 		if (ret)
 			return ret;

-		percent <<= SCHED_CAPACITY_SHIFT;
-		*value = DIV_ROUND_CLOSEST_ULL(percent, 10000);
+		*scale = *percent << SCHED_CAPACITY_SHIFT;
+		*scale = DIV_ROUND_CLOSEST_ULL(*scale, 10000);
 	}

 	return 0;
 }

-static inline u64 uclamp_percent_from_scale(u64 value)
-{
-	return DIV_ROUND_CLOSEST_ULL(value * 10000, SCHED_CAPACITY_SCALE);
-}
-
 static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes,
 				    loff_t off)
 {
 	struct task_group *tg;
 	u64 min_value;
+	s64 percent;
 	int ret;

-	ret = uclamp_scale_from_percent(buf, &min_value);
+	ret = uclamp_scale_from_percent(buf, &percent, &min_value);
 	if (ret)
 		return ret;
 	if (min_value > SCHED_CAPACITY_SCALE)
@@ -7197,6 +7192,9 @@ static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_eff(of_css(of));

+	/* Keep track of the actual requested value */
+	tg->uclamp_pct[UCLAMP_MIN] = percent;
+
 	rcu_read_unlock();
 	mutex_unlock(&uclamp_mutex);

@@ -7209,9 +7207,10 @@ static ssize_t cpu_uclamp_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg;
 	u64 max_value;
+	s64 percent;
 	int ret;

-	ret = uclamp_scale_from_percent(buf, &max_value);
+	ret = uclamp_scale_from_percent(buf, &percent, &max_value);
 	if (ret)
 		return ret;
 	if (max_value > SCHED_CAPACITY_SCALE)
@@ -7227,6 +7226,9 @@ static ssize_t cpu_uclamp_max_write(struct kernfs_open_file *of,
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_eff(of_css(of));

+	/* Keep track of the actual requested value */
+	tg->uclamp_pct[UCLAMP_MAX] = percent;
+
 	rcu_read_unlock();
 	mutex_unlock(&uclamp_mutex);

@@ -7251,7 +7253,7 @@ static inline void cpu_uclamp_print(struct seq_file *sf,
 		return;
 	}

-	percent = uclamp_percent_from_scale(util_clamp);
+	percent = tg->uclamp_pct[clamp_id];
 	percent = div_u64_rem(percent, 100, &rem);
 	seq_printf(sf, "%llu.%u\n", percent, rem);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0e37f4a4e536..4f9b0c660310 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -395,6 +395,8 @@ struct task_group {
 	struct cfs_bandwidth	cfs_bandwidth;

 #ifdef CONFIG_UCLAMP_TASK_GROUP
+	/* The two decimal precision [%] value requested from user-space */
+	unsigned int		uclamp_pct[UCLAMP_CNT];
 	/* Clamp values requested for a task group */
 	struct uclamp_se	uclamp_req[UCLAMP_CNT];
 	/* Effective clamp values used for a task group */
---8<---

> I guess one way to fix this would be to revert back to having a
> 1024-scale for the cgroup interface too ... Though I understand Tejun
> wanted % for consistency with other things.

Yes that would be another option, which will also keep aligned the per-task
and system-wide APIs with the CGroups one. Although, AFAIU, having two
different APIs is not considered a major issue.

> So, I'm not sure if this is still up for discussion, but in any case I
> wanted to say I support your original idea of using a 1024-scale for the
> cgroups interface, since that would solve the 'issue' above and keeps
> things consistent with the per-task API too.


Right, I'm personally more leaning toward either going back to use
SCHED_CAPACITY_SCALE or the add the small change I suggested above.

Tejun, Peter: any preference? Alternative suggestions?

> Thanks,
> Quentin

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
