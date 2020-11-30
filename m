Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A95E2C8CFF
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 19:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbgK3Sjv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 13:39:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64724 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388079AbgK3Sju (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 13:39:50 -0500
Received: from 89-64-87-210.dynamic.chello.pl (89.64.87.210) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 1d60de8b7b518a00; Mon, 30 Nov 2020 19:39:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: [RFC][PATCH 1/2] cpufreq: Add special-purpose fast-switching callback for drivers
Date:   Mon, 30 Nov 2020 19:37:01 +0100
Message-ID: <2174134.tL5yAn4CWt@kreacher>
In-Reply-To: <1817571.2o5Kk4Ohv2@kreacher>
References: <1817571.2o5Kk4Ohv2@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

First off, some cpufreq drivers (eg. intel_pstate) can pass hints
beyond the current target frequency to the hardware and there are no
provisions for doing that in the cpufreq framework.  In particular,
today the driver has to assume that it should allow the frequency to
fall below the one requested by the governor (or the required capacity
may not be provided) which may not be the case and which may lead to
excessive energy usage in some scenarios.

Second, the hints passed by these drivers to the hardware neeed not
be in terms of the frequency, so representing the utilization numbers
coming from the scheduler as frequency before passing them to those
drivers is not really useful.

Address the two points above by adding a special-purpose replacement
for the ->fast_switch callback, called ->adjust_perf, allowing the
governor to pass abstract performance level (rather than frequency)
values for the minimum (required) and target (desired) performance
along with the information whether or not the given CPU has been
busy since the last update (which may allow the driver to skip the
update in some cases).

Also update the schedutil governor to use the new callback instead
of ->fast_switch if present.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c        |   41 +++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h          |   14 +++++++++++++
 include/linux/sched/cpufreq.h    |    5 ++++
 kernel/sched/cpufreq_schedutil.c |   40 ++++++++++++++++++++++++++------------
 4 files changed, 88 insertions(+), 12 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -320,6 +320,15 @@ struct cpufreq_driver {
 					unsigned int index);
 	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
 				       unsigned int target_freq);
+	/*
+	 * ->fast_switch() replacement for drivers that use an internal
+	 * representation of performance levels and can pass hints other than
+	 * the target performance level to the hardware.
+	 */
+	void		(*adjust_perf)(unsigned int cpu, bool busy,
+				       unsigned long min_perf,
+				       unsigned long target_perf,
+				       unsigned long capacity);
 
 	/*
 	 * Caches and returns the lowest driver-supported frequency greater than
@@ -588,6 +597,11 @@ struct cpufreq_governor {
 /* Pass a target to the cpufreq driver */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq);
+void cpufreq_driver_adjust_perf(unsigned int cpu, bool busy,
+				unsigned long min_perf,
+				unsigned long target_perf,
+				unsigned long capacity);
+bool cpufreq_driver_has_adjust_perf(void);
 int cpufreq_driver_target(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
 				 unsigned int relation);
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2094,6 +2094,47 @@ unsigned int cpufreq_driver_fast_switch(
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
+/**
+ * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
+ * @cpu: Target CPU.
+ * @busy: Whether or not @CPU has been busy since the previous update.
+ * @min_perf: Minimum (required) performance level (units of @capacity).
+ * @target_perf: Terget (desired) performance level (units of @capacity).
+ * @capacity: Capacity of the target CPU.
+ *
+ * Carry out a fast performance level switch of @cpu without sleeping.
+ *
+ * The driver's ->adjust_perf() callback invoked by this function must be
+ * suitable for being called from within RCU-sched read-side critical sections
+ * and it is expected to select a suitable performance level equal to or above
+ * @min_perf and preferably equal to or below @target_perf.
+ *
+ * This function must not be called if policy->fast_switch_enabled is unset.
+ *
+ * Governors calling this function must guarantee that it will never be invoked
+ * twice in parallel for the same CPU and that it will never be called in
+ * parallel with either ->target() or ->target_index() or ->fast_switch() for
+ * the same CPU.
+ */
+void cpufreq_driver_adjust_perf(unsigned int cpu, bool busy,
+				 unsigned long min_perf,
+				 unsigned long target_perf,
+				 unsigned long capacity)
+{
+	cpufreq_driver->adjust_perf(cpu, busy, min_perf, target_perf, capacity);
+}
+
+/**
+ * cpufreq_driver_has_adjust_perf - Check "direct fast switch" callback.
+ *
+ * Return 'true' if the ->adjust_perf callback is present for the
+ * current driver or 'false' otherwise.
+ */
+bool cpufreq_driver_has_adjust_perf(void)
+{
+	return !!cpufreq_driver->adjust_perf;
+}
+
 /* Must set freqs->new to intermediate frequency */
 static int __target_intermediate(struct cpufreq_policy *policy,
 				 struct cpufreq_freqs *freqs, int index)
Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -40,6 +40,7 @@ struct sugov_policy {
 	struct task_struct	*thread;
 	bool			work_in_progress;
 
+	bool			direct_fast_switch;
 	bool			limits_changed;
 	bool			need_freq_update;
 };
@@ -454,6 +455,25 @@ static void sugov_update_single(struct u
 	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
 	util = sugov_iowait_apply(sg_cpu, time, util, max);
+
+	/*
+	 * This code runs under rq->lock for the target CPU, so it won't run
+	 * concurrently on two different CPUs for the same target and it is not
+	 * necessary to acquire the lock in the fast switch case.
+	 */
+	if (sg_policy->direct_fast_switch) {
+		/*
+		 * In this case, any optimizations that can be done are up to
+		 * the driver.
+		 */
+		cpufreq_driver_adjust_perf(sg_cpu->cpu,
+					   sugov_cpu_is_busy(sg_cpu),
+					   map_util_perf(sg_cpu->bw_dl),
+					   map_util_perf(util), max);
+		sg_policy->last_freq_update_time = time;
+		return;
+	}
+
 	next_f = get_next_freq(sg_policy, util, max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
@@ -466,11 +486,6 @@ static void sugov_update_single(struct u
 		sg_policy->cached_raw_freq = cached_freq;
 	}
 
-	/*
-	 * This code runs under rq->lock for the target CPU, so it won't run
-	 * concurrently on two different CPUs for the same target and it is not
-	 * necessary to acquire the lock in the fast switch case.
-	 */
 	if (sg_policy->policy->fast_switch_enabled) {
 		sugov_fast_switch(sg_policy, time, next_f);
 	} else {
@@ -655,10 +670,6 @@ static int sugov_kthread_create(struct s
 	struct cpufreq_policy *policy = sg_policy->policy;
 	int ret;
 
-	/* kthread only required for slow path */
-	if (policy->fast_switch_enabled)
-		return 0;
-
 	kthread_init_work(&sg_policy->work, sugov_work);
 	kthread_init_worker(&sg_policy->worker);
 	thread = kthread_create(kthread_worker_fn, &sg_policy->worker,
@@ -736,9 +747,14 @@ static int sugov_init(struct cpufreq_pol
 		goto disable_fast_switch;
 	}
 
-	ret = sugov_kthread_create(sg_policy);
-	if (ret)
-		goto free_sg_policy;
+	if (policy->fast_switch_enabled) {
+		sg_policy->direct_fast_switch = cpufreq_driver_has_adjust_perf();
+	} else {
+		/* kthread only required for slow path */
+		ret = sugov_kthread_create(sg_policy);
+		if (ret)
+			goto free_sg_policy;
+	}
 
 	mutex_lock(&global_tunables_lock);
 
Index: linux-pm/include/linux/sched/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/sched/cpufreq.h
+++ linux-pm/include/linux/sched/cpufreq.h
@@ -28,6 +28,11 @@ static inline unsigned long map_util_fre
 {
 	return (freq + (freq >> 2)) * util / cap;
 }
+
+static inline unsigned long map_util_perf(unsigned long util)
+{
+	return util + (util >> 2);
+}
 #endif /* CONFIG_CPU_FREQ */
 
 #endif /* _LINUX_SCHED_CPUFREQ_H */



