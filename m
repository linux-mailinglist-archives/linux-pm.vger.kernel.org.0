Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4891E29E9
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 20:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgEZSUm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 14:20:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64106 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgEZSUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 14:20:42 -0400
Received: from 89-64-86-86.dynamic.chello.pl (89.64.86.86) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 5bdc457a80a12290; Tue, 26 May 2020 20:20:38 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Francisco Jerez <francisco.jerez.plata@intel.com>
Subject: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive mode with HWP enabled
Date:   Tue, 26 May 2020 20:20:37 +0200
Message-ID: <2931539.RsFqoHxarq@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Allow intel_pstate to work in the passive mode with HWP enabled and
make it set the HWP minimum performance limit to 75% of the P-state
value corresponding to the target frequency supplied by the cpufreq
governor, so as to prevent the HWP algorithm and the CPU scheduler
from working against each other at least when the schedutil governor
is in use.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a replacement for https://patchwork.kernel.org/patch/11563615/ that
uses the HWP floor (minimum performance limit) as the feedback to the HWP
algorithm (instead of the EPP).

The INTEL_CPUFREQ_TRANSITION_DELAY_HWP is still 5000 and the previous comments
still apply to it.

In addition to that, the 75% fraction used in intel_cpufreq_adjust_hwp() can be
adjusted too, but I would like to use a value with a power-of-2 denominator for
that (so the next candidate would be 7/8).

Everyone who can do that is kindly requested to test this and let me know
the outcome.

Of course, the documentation still needs to be updated.  Also, the EPP can be
handled in analogy with the active mode now, but that part can be added in a
separate patch on top of this one.

Thanks!

---
 drivers/cpufreq/intel_pstate.c |  119 ++++++++++++++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 31 deletions(-)

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
@@ -2175,7 +2176,10 @@ static int intel_pstate_verify_policy(st
 
 static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
-	intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
+	if (hwp_active)
+		intel_pstate_hwp_force_min_perf(policy->cpu);
+	else
+		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
 }
 
 static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
@@ -2183,12 +2187,10 @@ static void intel_pstate_stop_cpu(struct
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
@@ -2318,13 +2320,58 @@ static void intel_cpufreq_trace(struct c
 		fp_toint(cpu->iowait_boost * 100));
 }
 
+static void intel_cpufreq_update_hwp_request(struct cpudata *cpu, u32 min_perf)
+{
+	u64 value, prev;
+
+	rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &prev);
+	value = prev;
+
+	value &= ~HWP_MIN_PERF(~0L);
+	value |= HWP_MIN_PERF(min_perf);
+
+	/*
+	 * The entire MSR needs to be updated in order to update the HWP min
+	 * field in it, so opportunistically update the max too if needed.
+	 */
+	value &= ~HWP_MAX_PERF(~0L);
+	value |= HWP_MAX_PERF(cpu->max_perf_ratio);
+
+	if (value != prev)
+		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+}
+
+/**
+ * intel_cpufreq_adjust_hwp - Adjust the HWP reuqest register.
+ * @cpu: Target CPU.
+ * @target_pstate: P-state corresponding to the target frequency.
+ *
+ * Set the HWP minimum performance limit to 75% of @target_pstate taking the
+ * global min and max policy limits into account.
+ *
+ * The purpose of this is to avoid situations in which the kernel and the HWP
+ * algorithm work against each other by giving a hint about the expectations of
+ * the former to the latter.
+ */
+static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pstate)
+{
+	u32 min_perf;
+
+	min_perf = max_t(u32, (3 * target_pstate) / 4, cpu->min_perf_ratio);
+	min_perf = min_t(u32, min_perf, cpu->max_perf_ratio);
+	if (min_perf != cpu->pstate.current_pstate) {
+		cpu->pstate.current_pstate = min_perf;
+		intel_cpufreq_update_hwp_request(cpu, min_perf);
+	}
+}
+
 static int intel_cpufreq_target(struct cpufreq_policy *policy,
 				unsigned int target_freq,
 				unsigned int relation)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
+	int target_pstate, old_pstate = cpu->pstate.current_pstate;
 	struct cpufreq_freqs freqs;
-	int target_pstate, old_pstate;
 
 	update_turbo_state();
 
@@ -2332,26 +2379,33 @@ static int intel_cpufreq_target(struct c
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
+
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
-	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
-	old_pstate = cpu->pstate.current_pstate;
-	if (target_pstate != cpu->pstate.current_pstate) {
-		cpu->pstate.current_pstate = target_pstate;
-		wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
-			      pstate_funcs.get_val(cpu, target_pstate));
+
+	if (hwp_active) {
+		intel_cpufreq_adjust_hwp(cpu, target_pstate);
+	} else {
+		target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+		if (target_pstate != old_pstate) {
+			cpu->pstate.current_pstate = target_pstate;
+			wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
+				      pstate_funcs.get_val(cpu, target_pstate));
+		}
 	}
-	freqs.new = target_pstate * cpu->pstate.scaling;
 	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET, old_pstate);
+
+	freqs.new = target_pstate * cpu->pstate.scaling;
+
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -2361,14 +2415,19 @@ static unsigned int intel_cpufreq_fast_s
 					      unsigned int target_freq)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
-	int target_pstate, old_pstate;
+	int target_pstate, old_pstate = cpu->pstate.current_pstate;
 
 	update_turbo_state();
 
 	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
-	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
-	old_pstate = cpu->pstate.current_pstate;
-	intel_pstate_update_pstate(cpu, target_pstate);
+
+	if (hwp_active) {
+		intel_cpufreq_adjust_hwp(cpu, target_pstate);
+	} else {
+		target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+		intel_pstate_update_pstate(cpu, target_pstate);
+	}
+
 	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate);
 	return target_pstate * cpu->pstate.scaling;
 }
@@ -2389,7 +2448,6 @@ static int intel_cpufreq_cpu_init(struct
 		return ret;
 
 	policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
-	policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
 	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
 	policy->cur = policy->cpuinfo.min_freq;
 
@@ -2401,10 +2459,13 @@ static int intel_cpufreq_cpu_init(struct
 
 	cpu = all_cpu_data[policy->cpu];
 
-	if (hwp_active)
+	if (hwp_active) {
 		intel_pstate_get_hwp_max(policy->cpu, &turbo_max, &max_state);
-	else
+		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
+	} else {
 		turbo_max = cpu->pstate.turbo_pstate;
+		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
+	}
 
 	min_freq = DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
 	min_freq *= cpu->pstate.scaling;
@@ -2505,9 +2566,6 @@ static int intel_pstate_register_driver(
 
 static int intel_pstate_unregister_driver(void)
 {
-	if (hwp_active)
-		return -EBUSY;
-
 	cpufreq_unregister_driver(intel_pstate_driver);
 	intel_pstate_driver_cleanup();
 
@@ -2815,12 +2873,11 @@ static int __init intel_pstate_setup(cha
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



