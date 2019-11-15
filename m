Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971A7FE74A
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 22:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKOVxJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 16:53:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKOVxJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 16:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A4jOdU6HLXqfSiSXZdPDkCfOqhWexiGyttevCOaFFok=; b=SAVJrvXIHsjEcTFPtqUX8QXZg
        tuTX4gJ1cQDOpSENtXz4t8sA9pdRBjtUc1WfmEhKuijaqB+vSDVYxLZku+LvHUhL6SkoFZqCKaX23
        2Ml7HS54RsBVm77246u7XmqVcwcAnJ1blyK6lUcCxOZJ2aZqyVGQqzfdML6UGYx73257HcRHy/e5P
        tgnT9ATDWSPsRhY294hIwfsn7MAlqDWitQLbA/+2emRFfGIr1I7ucpx/6u4Dt0H9TAuigrNenbA5u
        0ec6dhJgNcHZ/RqVAC5c21SCPyB2B0WRdBq17Oo6w39qw8KzeuEC9XbrO4Imj8vwQ0PS/j5ETx8ZZ
        66+u623FQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVjW8-00035B-Bm; Fri, 15 Nov 2019 21:52:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 842EC980E13; Fri, 15 Nov 2019 22:52:28 +0100 (CET)
Date:   Fri, 15 Nov 2019 22:52:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, mgorman@suse.de, dsmythies@telus.net,
        linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
Message-ID: <20191115215228.GN3079@worktop.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> which might be inefficient when cpufreq driver has rate limitation.
> 
> When a task is attached on a CPU, we have call path:
> 
> update_load_avg()
>   update_cfs_rq_load_avg()
>     cfs_rq_util_change -- > trig frequency update
>   attach_entity_load_avg()
>     cfs_rq_util_change -- > trig frequency update
> 
> The 1st frequency update will not take into account the utilization of the
> newly attached task and the 2nd one might be discard because of rate
> limitation of the cpufreq driver.
> 
> update_cfs_rq_load_avg() is only called by update_blocked_averages()
> and update_load_avg() so we can move the call to
> cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> interesting to notice that update_load_avg() already calls directly
> cfs_rq_util_change() for !SMP case.
> 
> This changes will also ensure that cpufreq_update_util() is called even
> when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> irq, rt or dl pelt signals.
> 
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---

OK, but shall we write it like so instead?

---
 kernel/sched/fair.c | 111 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 545bcb90b4de..7a762266c335 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3508,9 +3508,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif

-	if (decayed)
-		cfs_rq_util_change(cfs_rq, 0);
-
 	return decayed;
 }

@@ -3620,8 +3617,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
 		update_tg_load_avg(cfs_rq, 0);

-	} else if (decayed && (flags & UPDATE_TG))
-		update_tg_load_avg(cfs_rq, 0);
+	} else if (decayed) {
+		cfs_rq_util_change(cfs_rq, 0);
+
+		if (flags & UPDATE_TG)
+			update_tg_load_avg(cfs_rq, 0);
+	}
 }

 #ifndef CONFIG_64BIT
@@ -7428,6 +7429,28 @@ static inline bool others_have_blocked(struct rq *rq) { return false; }
 static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
 #endif

+static bool __update_blocked_others(struct rq *rq, bool *done)
+{
+	const struct sched_class *curr_class;
+	u64 now = rq_clock_pelt(rq);
+	bool decayed;
+
+	/*
+	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
+	 * DL and IRQ signals have been updated before updating CFS.
+	 */
+	curr_class = rq->curr->sched_class;
+
+	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
+		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
+		  update_irq_load_avg(rq, 0);
+
+	if (others_have_blocked(rq))
+		*done = false;
+
+	return decayed;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED

 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
@@ -7447,29 +7470,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	return true;
 }

-static void update_blocked_averages(int cpu)
+static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
-	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq, *pos;
-	const struct sched_class *curr_class;
-	struct rq_flags rf;
-	bool done = true;
-
-	rq_lock_irqsave(rq, &rf);
-	update_rq_clock(rq);
-
-	/*
-	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
-	 * that RT, DL and IRQ signals have been updated before updating CFS.
-	 */
-	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
-
-	/* Don't need periodic decay once load/util_avg are null */
-	if (others_have_blocked(rq))
-		done = false;
+	bool decayed = false;
+	int cpu = cpu_of(rq);

 	/*
 	 * Iterates the task_group tree in a bottom up fashion, see
@@ -7478,9 +7483,13 @@ static void update_blocked_averages(int cpu)
 	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
 		struct sched_entity *se;

-		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
+		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq, 0);

+			if (cfs_rq == &rq->cfs)
+				decayed = true;
+		}
+
 		/* Propagate pending load changes to the parent, if any: */
 		se = cfs_rq->tg->se[cpu];
 		if (se && !skip_blocked_update(se))
@@ -7495,11 +7504,10 @@ static void update_blocked_averages(int cpu)

 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
-			done = false;
+			*done = false;
 	}

-	update_blocked_load_status(rq, !done);
-	rq_unlock_irqrestore(rq, &rf);
+	return decayed;
 }

 /*
@@ -7549,29 +7557,16 @@ static unsigned long task_h_load(struct task_struct *p)
 			cfs_rq_load_avg(cfs_rq) + 1);
 }
 #else
-static inline void update_blocked_averages(int cpu)
+static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
-	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq = &rq->cfs;
-	const struct sched_class *curr_class;
-	struct rq_flags rf;
-
-	rq_lock_irqsave(rq, &rf);
-	update_rq_clock(rq);
-
-	/*
-	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
-	 * that RT, DL and IRQ signals have been updated before updating CFS.
-	 */
-	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	bool decayed;

-	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+	decayed = update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+	if (cfs_rq_has_blocked(cfs_rq))
+		*done = false;

-	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
-	rq_unlock_irqrestore(rq, &rf);
+	return decayed;
 }

 static unsigned long task_h_load(struct task_struct *p)
@@ -7580,6 +7575,24 @@ static unsigned long task_h_load(struct task_struct *p)
 }
 #endif

+static void update_blocked_averages(int cpu)
+{
+	bool decayed = false, done = true;
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+
+	decayed |= __update_blocked_others(rq, &done);
+	decayed |= __update_blocked_fair(rq, &done);
+
+	update_blocked_load_status(rq, !done);
+	if (decayed)
+		cpufreq_update_util(rq, 0);
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 /********** Helpers for find_busiest_group ************************/

 /*

