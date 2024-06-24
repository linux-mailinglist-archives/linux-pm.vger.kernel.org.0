Return-Path: <linux-pm+bounces-9890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E41914760
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 12:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F011F2392B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9399136E09;
	Mon, 24 Jun 2024 10:24:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3B61369A7;
	Mon, 24 Jun 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224658; cv=none; b=Un/WuPyJSJmcPleHNHXUgsA9MJdlQbd/93Lguv8zDI90/DVdBOhLKKtQmZpb4qAp42lBjYP4T5cQh/XS3tFx3JEmvGiYipdh1AwYNUwPcwJYi6RklMrcy9NOvmscetD9PcxJGhmdNco8leJvLrf2kGnmNWRe+5lno2Io2zhKfRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224658; c=relaxed/simple;
	bh=pf3cQlwDx91QO9IKX3PfiD+j0eC+XqjlE+xssVCqY7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZoNhgAm7DGMdYHOCT/L32+sVlq3KXhIPmw/9JIi9qgDOyK0mAAS8LId1+Kzgd+zVmo2pEW6SRP5OhrdimG2PgQL9PzGpsXTXpPVoqI0Z6UlA5rdmCoWpvRqC3xzLBsz6HiXqlobboPeHgNbaKG395zyMitIA6XHvZu+KsWGO3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83772DA7;
	Mon, 24 Jun 2024 03:24:40 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C60E3F766;
	Mon, 24 Jun 2024 03:24:12 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Youssef Esmat <youssefesmat@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/7] sched/fair: Use util biases for utilization and frequency
Date: Mon, 24 Jun 2024 11:23:53 +0100
Message-Id: <4eb24fc71fb858ebe15e8e170f366b8c1eab1781.1719223916.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719223916.git.hongyan.xia2@arm.com>
References: <cover.1719223916.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new util_avg_bias for task and runqueue utilization. We also
maintain separate util_est and util_est_uclamp signals.

Now that we have the uclamp sum aggregated CFS util value, we do not
need to consult uclamp buckets to know how the frequency should be
clamped. We simply look at the aggregated top level rq->cfs.avg.util_avg
+ rq->cfs.avg.util_avg_bias and rq->cfs.avg.util_est_uclamp to know what
frequency to choose and how to place tasks.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/cpufreq_schedutil.c |  12 +-
 kernel/sched/fair.c              | 303 +++++++++++--------------------
 kernel/sched/sched.h             |  20 +-
 kernel/sched/syscalls.c          |  14 +-
 4 files changed, 117 insertions(+), 232 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece6244f9d2..65fdcf4d73d1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -197,7 +197,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 
 static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
 {
-	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
+	unsigned long min, max, util = cpu_util_cfs_boost_uclamp(sg_cpu->cpu);
 
 	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
 	util = max(util, boost);
@@ -385,11 +385,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
-	 *
-	 * Except when the rq is capped by uclamp_max.
 	 */
-	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
+	if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
 	    !sg_policy->need_freq_update) {
 		next_f = sg_policy->next_freq;
 
@@ -439,11 +436,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	/*
 	 * Do not reduce the target performance level if the CPU has not been
 	 * idle recently, as the reduction is likely to be premature then.
-	 *
-	 * Except when the rq is capped by uclamp_max.
 	 */
-	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
+	if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0fa48466e02e..a25de0044af8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4869,6 +4869,15 @@ static inline unsigned long task_util_est_uclamp(struct task_struct *p)
 {
 	return max(task_util_uclamp(p), _task_util_est_uclamp(p));
 }
+
+static inline unsigned long root_cfs_util_uclamp(struct rq *rq)
+{
+	long ret = READ_ONCE(rq->cfs.avg.util_avg);
+
+	ret += READ_ONCE(rq->cfs.avg.util_avg_bias);
+
+	return max(ret, 0L);
+}
 #else
 static inline long task_util_bias(struct task_struct *p)
 {
@@ -4889,6 +4898,11 @@ static inline unsigned long task_util_est_uclamp(struct task_struct *p)
 {
 	return task_util_est(p);
 }
+
+static inline unsigned long root_cfs_util_uclamp(struct rq *rq)
+{
+	return READ_ONCE(rq->cfs.avg.util_avg);
+}
 #endif
 
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
@@ -5032,134 +5046,29 @@ static inline unsigned long get_actual_cpu_capacity(int cpu)
 }
 
 static inline int util_fits_cpu(unsigned long util,
-				unsigned long uclamp_min,
-				unsigned long uclamp_max,
+				unsigned long util_uclamp,
 				int cpu)
 {
 	unsigned long capacity = capacity_of(cpu);
-	unsigned long capacity_orig;
-	bool fits, uclamp_max_fits;
-
-	/*
-	 * Check if the real util fits without any uclamp boost/cap applied.
-	 */
-	fits = fits_capacity(util, capacity);
-
-	if (!uclamp_is_used())
-		return fits;
 
-	/*
-	 * We must use arch_scale_cpu_capacity() for comparing against uclamp_min and
-	 * uclamp_max. We only care about capacity pressure (by using
-	 * capacity_of()) for comparing against the real util.
-	 *
-	 * If a task is boosted to 1024 for example, we don't want a tiny
-	 * pressure to skew the check whether it fits a CPU or not.
-	 *
-	 * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
-	 * should fit a little cpu even if there's some pressure.
-	 *
-	 * Only exception is for HW or cpufreq pressure since it has a direct impact
-	 * on available OPP of the system.
-	 *
-	 * We honour it for uclamp_min only as a drop in performance level
-	 * could result in not getting the requested minimum performance level.
-	 *
-	 * For uclamp_max, we can tolerate a drop in performance level as the
-	 * goal is to cap the task. So it's okay if it's getting less.
-	 */
-	capacity_orig = arch_scale_cpu_capacity(cpu);
-
-	/*
-	 * We want to force a task to fit a cpu as implied by uclamp_max.
-	 * But we do have some corner cases to cater for..
-	 *
-	 *
-	 *                                 C=z
-	 *   |                             ___
-	 *   |                  C=y       |   |
-	 *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _  uclamp_max
-	 *   |      C=x        |   |      |   |
-	 *   |      ___        |   |      |   |
-	 *   |     |   |       |   |      |   |    (util somewhere in this region)
-	 *   |     |   |       |   |      |   |
-	 *   |     |   |       |   |      |   |
-	 *   +----------------------------------------
-	 *         CPU0        CPU1       CPU2
-	 *
-	 *   In the above example if a task is capped to a specific performance
-	 *   point, y, then when:
-	 *
-	 *   * util = 80% of x then it does not fit on CPU0 and should migrate
-	 *     to CPU1
-	 *   * util = 80% of y then it is forced to fit on CPU1 to honour
-	 *     uclamp_max request.
-	 *
-	 *   which is what we're enforcing here. A task always fits if
-	 *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
-	 *   the normal upmigration rules should withhold still.
-	 *
-	 *   Only exception is when we are on max capacity, then we need to be
-	 *   careful not to block overutilized state. This is so because:
-	 *
-	 *     1. There's no concept of capping at max_capacity! We can't go
-	 *        beyond this performance level anyway.
-	 *     2. The system is being saturated when we're operating near
-	 *        max capacity, it doesn't make sense to block overutilized.
-	 */
-	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
-	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
-	fits = fits || uclamp_max_fits;
+	if (fits_capacity(util_uclamp, capacity))
+		return 1;
 
-	/*
-	 *
-	 *                                 C=z
-	 *   |                             ___       (region a, capped, util >= uclamp_max)
-	 *   |                  C=y       |   |
-	 *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _ uclamp_max
-	 *   |      C=x        |   |      |   |
-	 *   |      ___        |   |      |   |      (region b, uclamp_min <= util <= uclamp_max)
-	 *   |_ _ _|_ _|_ _ _ _| _ | _ _ _| _ | _ _ _ _ _ uclamp_min
-	 *   |     |   |       |   |      |   |
-	 *   |     |   |       |   |      |   |      (region c, boosted, util < uclamp_min)
-	 *   +----------------------------------------
-	 *         CPU0        CPU1       CPU2
-	 *
-	 * a) If util > uclamp_max, then we're capped, we don't care about
-	 *    actual fitness value here. We only care if uclamp_max fits
-	 *    capacity without taking margin/pressure into account.
-	 *    See comment above.
-	 *
-	 * b) If uclamp_min <= util <= uclamp_max, then the normal
-	 *    fits_capacity() rules apply. Except we need to ensure that we
-	 *    enforce we remain within uclamp_max, see comment above.
-	 *
-	 * c) If util < uclamp_min, then we are boosted. Same as (b) but we
-	 *    need to take into account the boosted value fits the CPU without
-	 *    taking margin/pressure into account.
-	 *
-	 * Cases (a) and (b) are handled in the 'fits' variable already. We
-	 * just need to consider an extra check for case (c) after ensuring we
-	 * handle the case uclamp_min > uclamp_max.
-	 */
-	uclamp_min = min(uclamp_min, uclamp_max);
-	if (fits && (util < uclamp_min) &&
-	    (uclamp_min > get_actual_cpu_capacity(cpu)))
+	if (fits_capacity(util, capacity))
 		return -1;
 
-	return fits;
+	return 0;
 }
 
 static inline int task_fits_cpu(struct task_struct *p, int cpu)
 {
-	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
-	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
 	unsigned long util = task_util_est(p);
+	unsigned long util_uclamp = task_util_est_uclamp(p);
 	/*
 	 * Return true only if the cpu fully fits the task requirements, which
 	 * include the utilization but also the performance hints.
 	 */
-	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
+	return (util_fits_cpu(util, util_uclamp, cpu) > 0);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -6737,18 +6646,19 @@ static inline void hrtick_update(struct rq *rq)
 #endif
 
 #ifdef CONFIG_SMP
+static unsigned long cpu_util_cfs_uclamp(int cpu);
+
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long  rq_util_min, rq_util_max;
+	unsigned long util, util_uclamp;
 
 	if (!sched_energy_enabled())
 		return false;
 
-	rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
-	rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+	util = cpu_util_cfs(cpu);
+	util_uclamp = uclamp_is_used() ? cpu_util_cfs_uclamp(cpu) : util;
 
-	/* Return true only if the utilization doesn't fit CPU's capacity */
-	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
+	return !util_fits_cpu(util, util_uclamp, cpu);
 }
 
 /*
@@ -7534,9 +7444,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
  * maximize capacity.
  */
 static int
-select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
+select_idle_capacity(struct task_struct *p,
+		     unsigned long task_util,
+		     unsigned long task_util_uclamp,
+		     struct sched_domain *sd,
+		     int target)
 {
-	unsigned long task_util, util_min, util_max, best_cap = 0;
+	unsigned long best_cap = 0;
 	int fits, best_fits = 0;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
@@ -7544,17 +7458,13 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	task_util = task_util_est(p);
-	util_min = uclamp_eff_value(p, UCLAMP_MIN);
-	util_max = uclamp_eff_value(p, UCLAMP_MAX);
-
 	for_each_cpu_wrap(cpu, cpus, target) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
 			continue;
 
-		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
+		fits = util_fits_cpu(task_util, task_util_uclamp, cpu);
 
 		/* This CPU fits with all requirements */
 		if (fits > 0)
@@ -7582,8 +7492,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 }
 
 static inline bool asym_fits_cpu(unsigned long util,
-				 unsigned long util_min,
-				 unsigned long util_max,
+				 unsigned long util_uclamp,
 				 int cpu)
 {
 	if (sched_asym_cpucap_active())
@@ -7591,7 +7500,7 @@ static inline bool asym_fits_cpu(unsigned long util,
 		 * Return true only if the cpu fully fits the task requirements
 		 * which include the utilization and the performance hints.
 		 */
-		return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
+		return (util_fits_cpu(util, util_uclamp, cpu) > 0);
 
 	return true;
 }
@@ -7603,18 +7512,18 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	bool has_idle_core = false;
 	struct sched_domain *sd;
-	unsigned long task_util, util_min, util_max;
+	unsigned long task_util, task_util_uclamp;
+	bool asym = sched_asym_cpucap_active();
 	int i, recent_used_cpu, prev_aff = -1;
 
 	/*
 	 * On asymmetric system, update task utilization because we will check
 	 * that the task fits with CPU's capacity.
 	 */
-	if (sched_asym_cpucap_active()) {
+	if (asym) {
 		sync_entity_load_avg(&p->se);
 		task_util = task_util_est(p);
-		util_min = uclamp_eff_value(p, UCLAMP_MIN);
-		util_max = uclamp_eff_value(p, UCLAMP_MAX);
+		task_util_uclamp = task_util_est_uclamp(p);
 	}
 
 	/*
@@ -7623,7 +7532,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	lockdep_assert_irqs_disabled();
 
 	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
-	    asym_fits_cpu(task_util, util_min, util_max, target))
+	    asym_fits_cpu(task_util, task_util_uclamp, target))
 		return target;
 
 	/*
@@ -7631,7 +7540,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
-	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
+	    asym_fits_cpu(task_util, task_util_uclamp, prev)) {
 
 		if (!static_branch_unlikely(&sched_cluster_active) ||
 		    cpus_share_resources(prev, target))
@@ -7652,7 +7561,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    in_task() &&
 	    prev == smp_processor_id() &&
 	    this_rq()->nr_running <= 1 &&
-	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
+	    asym_fits_cpu(task_util, task_util_uclamp, prev)) {
 		return prev;
 	}
 
@@ -7664,7 +7573,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
-	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
+	    asym_fits_cpu(task_util, task_util_uclamp, recent_used_cpu)) {
 
 		if (!static_branch_unlikely(&sched_cluster_active) ||
 		    cpus_share_resources(recent_used_cpu, target))
@@ -7678,7 +7587,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * For asymmetric CPU capacity systems, our domain of interest is
 	 * sd_asym_cpucapacity rather than sd_llc.
 	 */
-	if (sched_asym_cpucap_active()) {
+	if (asym) {
 		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
 		/*
 		 * On an asymmetric CPU capacity system where an exclusive
@@ -7689,7 +7598,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		 * capacity path.
 		 */
 		if (sd) {
-			i = select_idle_capacity(p, sd, target);
+			i = select_idle_capacity(p, task_util, task_util_uclamp,
+						 sd, target);
 			return ((unsigned)i < nr_cpumask_bits) ? i : target;
 		}
 	}
@@ -7832,16 +7742,67 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 	return min(util, arch_scale_cpu_capacity(cpu));
 }
 
+/* This is basically a copy-paste from cpu_util(), but instead using uclamp values. */
+static unsigned long
+cpu_util_uclamp(int cpu, struct task_struct *p, int dst_cpu, int boost)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	unsigned long util = root_cfs_util_uclamp(rq);
+
+	if (boost) {
+		unsigned long runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
+		unsigned long util_raw = READ_ONCE(cfs_rq->avg.util_avg);
+
+		util = max(util, util_raw ? util * runnable / util_raw : 0);
+	}
+
+	if (p) {
+		if (task_cpu(p) == cpu && !p->se.on_rq) {
+			util += task_util_bias(p);
+			if ((long)util < 0)
+				util = 0;
+		}
+		if (task_cpu(p) == cpu && dst_cpu != cpu)
+			lsub_positive(&util, task_util_uclamp(p));
+		else if (task_cpu(p) != cpu && dst_cpu == cpu)
+			util += task_util_uclamp(p);
+	}
+
+	if (sched_feat(UTIL_EST)) {
+		unsigned long util_est = READ_ONCE(cfs_rq->avg.util_est_uclamp);
+
+		if (dst_cpu == cpu)
+			util_est += _task_util_est_uclamp(p);
+		else if (p && unlikely(task_on_rq_queued(p) || current == p))
+			lsub_positive(&util_est, _task_util_est_uclamp(p));
+
+		util = max(util, util_est);
+	}
+
+	return min(util, arch_scale_cpu_capacity(cpu));
+}
+
 unsigned long cpu_util_cfs(int cpu)
 {
 	return cpu_util(cpu, NULL, -1, 0);
 }
 
-unsigned long cpu_util_cfs_boost(int cpu)
+static unsigned long cpu_util_cfs_uclamp(int cpu)
+{
+	return cpu_util_uclamp(cpu, NULL, -1, 0);
+}
+
+static unsigned long cpu_util_cfs_boost(int cpu)
 {
 	return cpu_util(cpu, NULL, -1, 1);
 }
 
+unsigned long cpu_util_cfs_boost_uclamp(int cpu)
+{
+	return cpu_util_uclamp(cpu, NULL, -1, 1);
+}
+
 /*
  * cpu_util_without: compute cpu utilization without any contributions from *p
  * @cpu: the CPU which utilization is requested
@@ -7952,33 +7913,15 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 	int cpu;
 
 	for_each_cpu(cpu, pd_cpus) {
-		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
-		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
+		unsigned long util = cpu_util_uclamp(cpu, p, dst_cpu, 1);
 		unsigned long eff_util, min, max;
 
 		/*
-		 * Performance domain frequency: utilization clamping
-		 * must be considered since it affects the selection
-		 * of the performance domain frequency.
-		 * NOTE: in case RT tasks are running, by default the min
-		 * utilization can be max OPP.
+		 * NOTE: in case RT tasks are running, by default the
+		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
 		eff_util = effective_cpu_util(cpu, util, &min, &max);
 
-		/* Task's uclamp can modify min and max value */
-		if (tsk && uclamp_is_used()) {
-			min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
-
-			/*
-			 * If there is no active max uclamp constraint,
-			 * directly use task's one, otherwise keep max.
-			 */
-			if (uclamp_rq_is_idle(cpu_rq(cpu)))
-				max = uclamp_eff_value(p, UCLAMP_MAX);
-			else
-				max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
-		}
-
 		eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
 		max_util = max(max_util, eff_util);
 	}
@@ -8052,8 +7995,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
-	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
-	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
 	int prev_fits = -1, best_fits = -1;
@@ -8081,16 +8022,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!task_util_est(p) && p_util_min == 0)
+	if (!task_util_est_uclamp(p))
 		goto unlock;
 
 	eenv_task_busy_time(&eenv, p, prev_cpu);
 
 	for (; pd; pd = pd->next) {
-		unsigned long util_min = p_util_min, util_max = p_util_max;
-		unsigned long cpu_cap, cpu_actual_cap, util;
+		unsigned long cpu_cap, cpu_actual_cap, util, util_uclamp;
 		unsigned long cur_delta, max_spare_cap = 0;
-		unsigned long rq_util_min, rq_util_max;
 		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
@@ -8109,8 +8048,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		eenv.pd_cap = 0;
 
 		for_each_cpu(cpu, cpus) {
-			struct rq *rq = cpu_rq(cpu);
-
 			eenv.pd_cap += cpu_actual_cap;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
@@ -8120,36 +8057,18 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				continue;
 
 			util = cpu_util(cpu, p, cpu, 0);
+			util_uclamp = uclamp_is_used() ?
+				      cpu_util_uclamp(cpu, p, cpu, 0) : util;
 			cpu_cap = capacity_of(cpu);
 
-			/*
-			 * Skip CPUs that cannot satisfy the capacity request.
-			 * IOW, placing the task there would make the CPU
-			 * overutilized. Take uclamp into account to see how
-			 * much capacity we can get out of the CPU; this is
-			 * aligned with sched_cpu_util().
-			 */
-			if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
-				/*
-				 * Open code uclamp_rq_util_with() except for
-				 * the clamp() part. I.e.: apply max aggregation
-				 * only. util_fits_cpu() logic requires to
-				 * operate on non clamped util but must use the
-				 * max-aggregated uclamp_{min, max}.
-				 */
-				rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
-				rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
-
-				util_min = max(rq_util_min, p_util_min);
-				util_max = max(rq_util_max, p_util_max);
-			}
-
-			fits = util_fits_cpu(util, util_min, util_max, cpu);
+			fits = util_fits_cpu(util, util_uclamp, cpu);
+			if (fits == 1)
+				lsub_positive(&cpu_cap, util_uclamp);
+			else if (fits == -1)
+				lsub_positive(&cpu_cap, util);
 			if (!fits)
 				continue;
 
-			lsub_positive(&cpu_cap, util);
-
 			if (cpu == prev_cpu) {
 				/* Always use prev_cpu as a candidate. */
 				prev_spare_cap = cpu_cap;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5f93a6b1b563..c02ab8a54d66 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3089,9 +3089,8 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 	return READ_ONCE(rq->avg_dl.util_avg);
 }
 
-
 extern unsigned long cpu_util_cfs(int cpu);
-extern unsigned long cpu_util_cfs_boost(int cpu);
+extern unsigned long cpu_util_cfs_boost_uclamp(int cpu);
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
 {
@@ -3121,21 +3120,6 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
 }
 
-/* Is the rq being capped/throttled by uclamp_max? */
-static inline bool uclamp_rq_is_capped(struct rq *rq)
-{
-	unsigned long rq_util;
-	unsigned long max_util;
-
-	if (!static_branch_likely(&sched_uclamp_used))
-		return false;
-
-	rq_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
-	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
-
-	return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
-}
-
 /*
  * When uclamp is compiled in, the aggregation at rq level is 'turned off'
  * by default in the fast path and only gets turned on once userspace performs
@@ -3205,8 +3189,6 @@ uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
-
 static inline bool uclamp_is_used(void)
 {
 	return false;
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b42775ef9..d6696d06829d 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -303,13 +303,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	}
 
 	if (min) {
-		/*
-		 * The minimum utilization returns the highest level between:
-		 * - the computed DL bandwidth needed with the IRQ pressure which
-		 *   steals time to the deadline task.
-		 * - The minimum performance requirement for CFS and/or RT.
-		 */
-		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
+		*min = irq + cpu_bw_dl(rq);
 
 		/*
 		 * When an RT task is runnable and uclamp is not used, we must
@@ -328,12 +322,8 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	util = util_cfs + cpu_util_rt(rq);
 	util += cpu_util_dl(rq);
 
-	/*
-	 * The maximum hint is a soft bandwidth requirement, which can be lower
-	 * than the actual utilization because of uclamp_max requirements.
-	 */
 	if (max)
-		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
+		*max = scale;
 
 	if (util >= scale)
 		return scale;
-- 
2.34.1


