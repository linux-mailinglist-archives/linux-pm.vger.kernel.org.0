Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711D52DA14E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 21:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502716AbgLNUKl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 15:10:41 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43956 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502801AbgLNUKc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 15:10:32 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id a63a85a8384da918; Mon, 14 Dec 2020 21:09:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: [PATCH v2 2/3] cpufreq: Add special-purpose fast-switching callback for drivers
Date:   Mon, 14 Dec 2020 21:08:00 +0100
Message-ID: <10727653.HtF45dgyQg@kreacher>
In-Reply-To: <3827230.0GnL3RTcl1@kreacher>
References: <20360841.iInq7taT2Z@kreacher> <3827230.0GnL3RTcl1@kreacher>
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
today the driver has to assume that it should not allow the frequency
to fall below the one requested by the governor (or the required
capacity may not be provided) which may not be the case and which may
lead to excessive energy usage in some scenarios.

Second, the hints passed by these drivers to the hardware need not be
in terms of the frequency, so representing the utilization numbers
coming from the scheduler as frequency before passing them to those
drivers is not really useful.

Address the two points above by adding a special-purpose replacement
for the ->fast_switch callback, called ->adjust_perf, allowing the
governor to pass abstract performance level (rather than frequency)
values for the minimum (required) and target (desired) performance
along with the CPU capacity to compare them to.

Also update the schedutil governor to use the new callback instead
of ->fast_switch if present and if the utilization mertics are
frequency-invariant (that is requisite for the direct mapping
between the utilization and the CPU performance levels to be a
reasonable approximation).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
 - Do not share optimization code between the freq and perf paths.
 - Fall back from perf to freq if scale invariance is not supported.

Changes with respect to the RFC:
 - Don't pass "busy" to ->adjust_perf().
 - Use a special 'update_util' hook for the ->adjust_perf() case in
   schedutil (this still requires an additional branch because of the
   shared common code between this case and the "frequency" one, but
   IMV this version is cleaner nevertheless).

---
 drivers/cpufreq/cpufreq.c        |   40 ++++++++++++++++++++++
 include/linux/cpufreq.h          |   14 ++++++++
 include/linux/sched/cpufreq.h    |    5 ++
 kernel/sched/cpufreq_schedutil.c |   68 +++++++++++++++++++++++++++++++++------
 4 files changed, 117 insertions(+), 10 deletions(-)

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
+	void		(*adjust_perf)(unsigned int cpu,
+				       unsigned long min_perf,
+				       unsigned long target_perf,
+				       unsigned long capacity);
 
 	/*
 	 * Caches and returns the lowest driver-supported frequency greater than
@@ -588,6 +597,11 @@ struct cpufreq_governor {
 /* Pass a target to the cpufreq driver */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq);
+void cpufreq_driver_adjust_perf(unsigned int cpu,
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
@@ -2097,6 +2097,46 @@ unsigned int cpufreq_driver_fast_switch(
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
+/**
+ * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
+ * @cpu: Target CPU.
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
+void cpufreq_driver_adjust_perf(unsigned int cpu,
+				 unsigned long min_perf,
+				 unsigned long target_perf,
+				 unsigned long capacity)
+{
+	cpufreq_driver->adjust_perf(cpu, min_perf, target_perf, capacity);
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
@@ -432,13 +432,10 @@ static inline void ignore_dl_rate_limit(
 		sg_policy->limits_changed = true;
 }
 
-static void sugov_update_single(struct update_util_data *hook, u64 time,
-				unsigned int flags)
+static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
+					      u64 time, unsigned int flags)
 {
-	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
-	unsigned int cached_freq = sg_policy->cached_raw_freq;
-	unsigned int next_f;
 
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
@@ -446,11 +443,25 @@ static void sugov_update_single(struct u
 	ignore_dl_rate_limit(sg_cpu, sg_policy);
 
 	if (!sugov_should_update_freq(sg_policy, time))
-		return;
+		return false;
 
 	sugov_get_util(sg_cpu);
 	sugov_iowait_apply(sg_cpu, time);
 
+	return true;
+}
+
+static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
+				     unsigned int flags)
+{
+	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+	unsigned int cached_freq = sg_policy->cached_raw_freq;
+	unsigned int next_f;
+
+	if (!sugov_update_single_common(sg_cpu, time, flags))
+		return;
+
 	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
@@ -477,6 +488,38 @@ static void sugov_update_single(struct u
 	}
 }
 
+static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
+				     unsigned int flags)
+{
+	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	unsigned long prev_util = sg_cpu->util;
+
+	/*
+	 * Fall back to the "frequency" path if frequency invariance is not
+	 * supported, because the direct mapping between the utilization and
+	 * the performance levels depends on the frequency invariance.
+	 */
+	if (!arch_scale_freq_invariant()) {
+		sugov_update_single_freq(hook, time, flags);
+		return;
+	}
+
+	if (!sugov_update_single_common(sg_cpu, time, flags))
+		return;
+
+	/*
+	 * Do not reduce the target performance level if the CPU has not been
+	 * idle recently, as the reduction is likely to be premature then.
+	 */
+	if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
+		sg_cpu->util = prev_util;
+
+	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
+				   map_util_perf(sg_cpu->util), sg_cpu->max);
+
+	sg_cpu->sg_policy->last_freq_update_time = time;
+}
+
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
@@ -815,6 +858,7 @@ static void sugov_exit(struct cpufreq_po
 static int sugov_start(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
+	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
 	unsigned int cpu;
 
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
@@ -834,13 +878,17 @@ static int sugov_start(struct cpufreq_po
 		sg_cpu->sg_policy		= sg_policy;
 	}
 
+	if (policy_is_shared(policy))
+		uu = sugov_update_shared;
+	else if (policy->fast_switch_enabled && cpufreq_driver_has_adjust_perf())
+		uu = sugov_update_single_perf;
+	else
+		uu = sugov_update_single_freq;
+
 	for_each_cpu(cpu, policy->cpus) {
 		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
 
-		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
-					     policy_is_shared(policy) ?
-							sugov_update_shared :
-							sugov_update_single);
+		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
 	}
 	return 0;
 }
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



