Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780EE13CE05
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 21:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAOUUw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 15:20:52 -0500
Received: from foss.arm.com ([217.140.110.172]:42190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgAOUUv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jan 2020 15:20:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFC48328;
        Wed, 15 Jan 2020 12:20:50 -0800 (PST)
Received: from [192.168.0.17] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27B583F718;
        Wed, 15 Jan 2020 12:20:49 -0800 (PST)
Subject: Re: [PATCH] sched/fair: remove redundant call to cpufreq_update_util
To:     Vincent Guittot <vincent.guittot@linaro.org>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1579083620-24943-1-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <dd966dc1-db11-dd64-6b88-13e0dcf45fd7@arm.com>
Date:   Wed, 15 Jan 2020 21:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579083620-24943-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/01/2020 11:20, Vincent Guittot wrote:
> With commit bef69dd87828 ("sched/cpufreq: Move the cfs_rq_util_change() call to cpufreq_update_util()")
> update_load_avg() has become the central point for calling cpufreq (not
> including the update of blocked load). This change helps to simplify
> further the number of call to cpufreq_update_util() and to remove last
> redundant ones. With update_load_avg(), we are now sure that
> cpufreq_update_util() will be called after every task attachment to a
> cfs_rq and especially after propagating this event down to the util_avg of
> the root cfs_rq, which is the level that is used by cpufreq governors like
> schedutil to set the frequency of a CPU.
> 
> The SCHED_CPUFREQ_MIGRATION flag forces an early call to cpufreq when the
> migration happens in a cgroup whereas util_avg of root cfs_rq is not yet
> updated and this call is duplicated with the one that happens immediately
> after when the migration event reaches the root cfs_rq. The dedicated flag
> SCHED_CPUFREQ_MIGRATION is now useless and can be removed. The interface of
> attach_entity_load_avg() can also be simplified accordingly.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

LGTM. Doesn't this allow to get rid of the 'int flags' in
cfs_rq_util_change() as well?

8<---

 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 328d59e8afba..f82f4fde0cd3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3110,7 +3110,7 @@ static inline void update_cfs_group(struct sched_entity *se)
 }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
-static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
+static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 
@@ -3129,7 +3129,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq, flags);
+		cpufreq_update_util(rq, 0);
 	}
 }
 
@@ -3556,7 +3556,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
+	cfs_rq_util_change(cfs_rq);
 
 	trace_pelt_cfs_tp(cfs_rq);
 }
@@ -3577,7 +3577,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
+	cfs_rq_util_change(cfs_rq);
 
 	trace_pelt_cfs_tp(cfs_rq);
 }
@@ -3618,7 +3618,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		update_tg_load_avg(cfs_rq, 0);
 
 	} else if (decayed) {
-		cfs_rq_util_change(cfs_rq, 0);
+		cfs_rq_util_change(cfs_rq);
 
 		if (flags & UPDATE_TG)
 			update_tg_load_avg(cfs_rq, 0);
@@ -3851,7 +3851,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
-	cfs_rq_util_change(cfs_rq, 0);
+	cfs_rq_util_change(cfs_rq);
 }
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
-- 
2.17.1
