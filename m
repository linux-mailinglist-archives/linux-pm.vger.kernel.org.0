Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71B4D41B1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfJKNpp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 09:45:45 -0400
Received: from foss.arm.com ([217.140.110.172]:60958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbfJKNpp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 09:45:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAD1C337;
        Fri, 11 Oct 2019 06:45:44 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 16AFF3F68E;
        Fri, 11 Oct 2019 06:45:42 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, douglas.raillard@arm.com,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: [RFC PATCH v3 5/6] sched/cpufreq: Boost schedutil frequency ramp up
Date:   Fri, 11 Oct 2019 14:44:59 +0100
Message-Id: <20191011134500.235736-6-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011134500.235736-1-douglas.raillard@arm.com>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In some situations, it can be interesting to spend temporarily more
power if that can give a useful frequency boost.

Use the new sugov_cpu_ramp_boost() function to drive an energy-aware
boost, on top of the minimal required frequency.

As that boost number is not accurate (and cannot be without a crystal
ball), we only use it in a way that allows direct control over the power
it is going to cost. This allows keeping a platform-independent level of
control over the average power, while allowing for frequency bursts when
we know a (set of) tasks can make use of it.

In shared policies, the maximum of all CPU's boost is used. Since the
extra power expenditure is bounded, it cannot skyrocket even on
platforms with a large number of cores in the same frequency domain
and/or very high ratio between lowest and highest OPP cost.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c118f85d1f3d..7c1a749fb6ef 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -226,6 +226,9 @@ static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
  * @sg_policy: schedutil policy object to compute the new frequency for.
  * @util: Current CPU utilization.
  * @max: CPU capacity.
+ * @boost: Extra power that can be spent on top of the minimum amount of power
+ *	required to meet capacity requirements, as a percentage between 0 and
+ *	EM_COST_MARGIN_SCALE.
  *
  * If the utilization is frequency-invariant, choose the new frequency to be
  * proportional to it, that is
@@ -244,7 +247,8 @@ static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
  * cpufreq driver limitations.
  */
 static unsigned int get_next_freq(struct sugov_policy *sg_policy,
-				  unsigned long util, unsigned long max)
+				  unsigned long util, unsigned long max,
+				  unsigned long boost)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq = arch_scale_freq_invariant() ?
@@ -257,7 +261,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	 * Try to get a higher frequency if one is available, given the extra
 	 * power we are ready to spend.
 	 */
-	freq = em_pd_get_higher_freq(pd, freq, 0);
+	freq = em_pd_get_higher_freq(pd, freq, boost);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
@@ -539,6 +543,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	unsigned long util, max;
 	unsigned int next_f;
 	bool busy;
+	unsigned long ramp_boost = 0;
 
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
@@ -552,10 +557,10 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
 
 	util = sugov_get_util(sg_cpu);
-	sugov_cpu_ramp_boost_update(sg_cpu);
+	ramp_boost = sugov_cpu_ramp_boost_update(sg_cpu);
 	max = sg_cpu->max;
 	util = sugov_iowait_apply(sg_cpu, time, util, max);
-	next_f = get_next_freq(sg_policy, util, max);
+	next_f = get_next_freq(sg_policy, util, max, ramp_boost);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
@@ -587,6 +592,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util = 0, max = 1;
 	unsigned int j;
+	unsigned long ramp_boost = 0;
+	unsigned long j_ramp_boost = 0;
 
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
@@ -594,7 +601,11 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
 		j_util = sugov_get_util(j_sg_cpu);
 		if (j_sg_cpu == sg_cpu)
-			sugov_cpu_ramp_boost_update(sg_cpu);
+			j_ramp_boost = sugov_cpu_ramp_boost_update(sg_cpu);
+		else
+			j_ramp_boost = sugov_cpu_ramp_boost(j_sg_cpu);
+		ramp_boost = max(ramp_boost, j_ramp_boost);
+
 		j_max = j_sg_cpu->max;
 		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
 
@@ -605,7 +616,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	}
 
 
-	return get_next_freq(sg_policy, util, max);
+	return get_next_freq(sg_policy, util, max, ramp_boost);
 }
 
 static void
-- 
2.23.0

