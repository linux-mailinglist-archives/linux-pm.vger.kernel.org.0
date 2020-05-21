Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3688D1DD411
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgEURPf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 13:15:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43194 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgEURPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 13:15:34 -0400
Received: from 89-64-86-91.dynamic.chello.pl (89.64.86.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 0e4a05c61a7d924c; Thu, 21 May 2020 19:15:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Francisco Jerez <francisco.jerez.plata@intel.com>
Subject: [RFC/RFT][PATCH] cpufreq: intel_pstate: Work in passive mode with HWP enabled
Date:   Thu, 21 May 2020 19:15:30 +0200
Message-ID: <3169564.ZRsPWhXyMD@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Allow intel_pstate to work in the passive mode with HWP enabled and
make it translate the target frequency supplied by the cpufreq
governor in use into an EPP value to be written to the HWP request
MSR (high frequencies are mapped to low EPP values that mean more
performance-oriented HWP operation) as a hint for the HWP algorithm
in the processor, so as to prevent it and the CPU scheduler from
working against each other at least when the schedutil governor is
in use.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a prototype not intended for production use (based on linux-next).

Please test it if you can (on HWP systems, of course) and let me know the
results.

The INTEL_CPUFREQ_TRANSITION_DELAY_HWP value has been guessed and it very well
may turn out to be either too high or too low for the general use, which is one
reason why getting as much testing coverage as possible is key here.

If you can play with different INTEL_CPUFREQ_TRANSITION_DELAY_HWP values,
please do so and let me know the conclusions.

Cheers,
Rafael

---
 drivers/cpufreq/intel_pstate.c |  169 +++++++++++++++++++++++++++++++----------
 1 file changed, 131 insertions(+), 38 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -36,6 +36,7 @@
 #define INTEL_PSTATE_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
 
 #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
+#define INTEL_CPUFREQ_TRANSITION_DELAY_HWP	5000
 #define INTEL_CPUFREQ_TRANSITION_DELAY		500
 
 #ifdef CONFIG_ACPI
@@ -95,6 +96,8 @@ static inline int32_t percent_ext_fp(int
 	return div_ext_fp(percent, 100);
 }
 
+#define HWP_EPP_TO_BYTE(x)	(((u64)x >> 24) & 0xFF)
+
 /**
  * struct sample -	Store performance sample
  * @core_avg_perf:	Ratio of APERF/MPERF which is the actual average
@@ -2175,7 +2178,10 @@ static int intel_pstate_verify_policy(st
 
 static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
-	intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
+	if (hwp_active)
+		intel_pstate_hwp_force_min_perf(policy->cpu);
+	else
+		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
 }
 
 static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
@@ -2183,12 +2189,10 @@ static void intel_pstate_stop_cpu(struct
 	pr_debug("CPU %d exiting\n", policy->cpu);
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
-	if (hwp_active) {
+	if (hwp_active)
 		intel_pstate_hwp_save_state(policy);
-		intel_pstate_hwp_force_min_perf(policy->cpu);
-	} else {
-		intel_cpufreq_stop_cpu(policy);
-	}
+
+	intel_cpufreq_stop_cpu(policy);
 }
 
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
@@ -2296,7 +2300,8 @@ static int intel_cpufreq_verify_policy(s
 #define	INTEL_PSTATE_TRACE_TARGET 10
 #define	INTEL_PSTATE_TRACE_FAST_SWITCH 90
 
-static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_type, int old_pstate)
+static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_type,
+				int from, int to)
 {
 	struct sample *sample;
 
@@ -2309,8 +2314,8 @@ static void intel_cpufreq_trace(struct c
 	sample = &cpu->sample;
 	trace_pstate_sample(trace_type,
 		0,
-		old_pstate,
-		cpu->pstate.current_pstate,
+		from,
+		to,
 		sample->mperf,
 		sample->aperf,
 		sample->tsc,
@@ -2318,40 +2323,110 @@ static void intel_cpufreq_trace(struct c
 		fp_toint(cpu->iowait_boost * 100));
 }
 
-static int intel_cpufreq_target(struct cpufreq_policy *policy,
-				unsigned int target_freq,
-				unsigned int relation)
+static void intel_cpufreq_update_hwp_request(struct cpudata *cpu, u8 new_epp)
 {
-	struct cpudata *cpu = all_cpu_data[policy->cpu];
-	struct cpufreq_freqs freqs;
-	int target_pstate, old_pstate;
+	u64 value, prev;
 
-	update_turbo_state();
+	prev = READ_ONCE(cpu->hwp_req_cached);
+	value = prev;
 
-	freqs.old = policy->cur;
-	freqs.new = target_freq;
+	/*
+	 * The entire MSR needs to be updated in order to update the EPP field
+	 * in it, so opportunistically update the min and max too if needed.
+	 */
+	value &= ~HWP_MIN_PERF(~0L);
+	value |= HWP_MIN_PERF(cpu->min_perf_ratio);
+
+	value &= ~HWP_MAX_PERF(~0L);
+	value |= HWP_MAX_PERF(cpu->max_perf_ratio);
+
+	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
+		intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET,
+				    HWP_EPP_TO_BYTE(prev), new_epp);
+
+		value &= ~GENMASK_ULL(31, 24);
+		value |= HWP_ENERGY_PERF_PREFERENCE(new_epp);
+	}
+
+	if (value != prev) {
+		WRITE_ONCE(cpu->hwp_req_cached, value);
+		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+	}
+}
+
+/**
+ * intel_cpufreq_adjust_hwp_request - Adjust the HWP reuqest register.
+ * @cpu: Target CPU.
+ * @max_freq: Maximum frequency to consider.
+ * @target_freq: Target frequency selected by the governor.
+ *
+ * Translate the target frequency into a new EPP value to be written into the
+ * HWP request MSR of @cpu as a hint for the HW-driven P-state selection.
+ *
+ * The purpose of this is to avoid situations in which the kernel and the HWP
+ * algorithm work against each other by giving a hint about the expectations of
+ * the former to the latter.
+ *
+ * The mapping betweeen the target frequencies and the hint values need not be
+ * exact, but it must be monotonic, so that higher target frequencies always
+ * indicate more performance-oriented P-state selection.
+ */
+static void intel_cpufreq_adjust_hwp_request(struct cpudata *cpu, s64 max_freq,
+					     unsigned int target_freq)
+{
+	s64 epp_fp = div_fp(255 * (max_freq - target_freq), max_freq);
+
+	intel_cpufreq_update_hwp_request(cpu, fp_toint(epp_fp));
+}
+
+static int intel_cpufreq_adjust_pstate(struct cpudata *cpu,
+				       unsigned int target_freq,
+				       unsigned int relation)
+{
+	int old_pstate = cpu->pstate.current_pstate;
+	int target_pstate;
 
-	cpufreq_freq_transition_begin(policy, &freqs);
 	switch (relation) {
 	case CPUFREQ_RELATION_L:
-		target_pstate = DIV_ROUND_UP(freqs.new, cpu->pstate.scaling);
+		target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
 		break;
 	case CPUFREQ_RELATION_H:
-		target_pstate = freqs.new / cpu->pstate.scaling;
+		target_pstate = target_freq / cpu->pstate.scaling;
 		break;
 	default:
-		target_pstate = DIV_ROUND_CLOSEST(freqs.new, cpu->pstate.scaling);
+		target_pstate = DIV_ROUND_CLOSEST(target_freq, cpu->pstate.scaling);
 		break;
 	}
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
-	old_pstate = cpu->pstate.current_pstate;
-	if (target_pstate != cpu->pstate.current_pstate) {
+	if (target_pstate != old_pstate) {
 		cpu->pstate.current_pstate = target_pstate;
-		wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
+		wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
 			      pstate_funcs.get_val(cpu, target_pstate));
 	}
-	freqs.new = target_pstate * cpu->pstate.scaling;
-	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET, old_pstate);
+	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET, old_pstate, target_pstate);
+	return target_pstate * cpu->pstate.scaling;
+}
+
+static int intel_cpufreq_target(struct cpufreq_policy *policy,
+				unsigned int target_freq,
+				unsigned int relation)
+{
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+	struct cpufreq_freqs freqs;
+
+	update_turbo_state();
+
+	freqs.old = policy->cur;
+	freqs.new = target_freq;
+
+	cpufreq_freq_transition_begin(policy, &freqs);
+
+	if (hwp_active)
+		intel_cpufreq_adjust_hwp_request(cpu, policy->cpuinfo.max_freq,
+						 target_freq);
+	else
+		freqs.new = intel_cpufreq_adjust_pstate(cpu, target_freq, relation);
+
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -2365,11 +2440,18 @@ static unsigned int intel_cpufreq_fast_s
 
 	update_turbo_state();
 
+	if (hwp_active) {
+		intel_cpufreq_adjust_hwp_request(cpu, policy->cpuinfo.max_freq,
+						 target_freq);
+		return target_freq;
+	}
+
 	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	old_pstate = cpu->pstate.current_pstate;
 	intel_pstate_update_pstate(cpu, target_pstate);
-	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate);
+	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate,
+			    target_pstate);
 	return target_pstate * cpu->pstate.scaling;
 }
 
@@ -2389,7 +2471,6 @@ static int intel_cpufreq_cpu_init(struct
 		return ret;
 
 	policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
-	policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
 	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
 	policy->cur = policy->cpuinfo.min_freq;
 
@@ -2401,10 +2482,19 @@ static int intel_cpufreq_cpu_init(struct
 
 	cpu = all_cpu_data[policy->cpu];
 
-	if (hwp_active)
+	if (hwp_active) {
+		u64 value;
+
+		rdmsrl_on_cpu(policy->cpu, MSR_HWP_REQUEST, &value);
+		WRITE_ONCE(cpu->hwp_req_cached, value);
+		cpu->epp_saved = HWP_EPP_TO_BYTE(value);
+
 		intel_pstate_get_hwp_max(policy->cpu, &turbo_max, &max_state);
-	else
+		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
+	} else {
 		turbo_max = cpu->pstate.turbo_pstate;
+		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
+	}
 
 	min_freq = DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
 	min_freq *= cpu->pstate.scaling;
@@ -2449,6 +2539,13 @@ static int intel_cpufreq_cpu_exit(struct
 	freq_qos_remove_request(req);
 	kfree(req);
 
+	if (hwp_active) {
+		struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+		/* Restore the original HWP EPP value. */
+		intel_cpufreq_update_hwp_request(cpu, cpu->epp_saved);
+	}
+
 	return intel_pstate_cpu_exit(policy);
 }
 
@@ -2505,9 +2602,6 @@ static int intel_pstate_register_driver(
 
 static int intel_pstate_unregister_driver(void)
 {
-	if (hwp_active)
-		return -EBUSY;
-
 	cpufreq_unregister_driver(intel_pstate_driver);
 	intel_pstate_driver_cleanup();
 
@@ -2815,12 +2909,11 @@ static int __init intel_pstate_setup(cha
 	if (!str)
 		return -EINVAL;
 
-	if (!strcmp(str, "disable")) {
+	if (!strcmp(str, "disable"))
 		no_load = 1;
-	} else if (!strcmp(str, "passive")) {
+	else if (!strcmp(str, "passive"))
 		default_driver = &intel_cpufreq;
-		no_hwp = 1;
-	}
+
 	if (!strcmp(str, "no_hwp")) {
 		pr_info("HWP disabled\n");
 		no_hwp = 1;



