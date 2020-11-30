Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE62C8CFB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 19:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbgK3Sjs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 13:39:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61374 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388112AbgK3Sjs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 13:39:48 -0500
Received: from 89-64-87-210.dynamic.chello.pl (89.64.87.210) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 6703218980216aac; Mon, 30 Nov 2020 19:39:05 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: [RFC][PATCH 2/2] cpufreq: intel_pstate: Implement the ->adjust_perf() callback
Date:   Mon, 30 Nov 2020 19:37:55 +0100
Message-ID: <9641625.O8ij7EI7nc@kreacher>
In-Reply-To: <1817571.2o5Kk4Ohv2@kreacher>
References: <1817571.2o5Kk4Ohv2@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make intel_pstate expose the ->adjust_perf() callback when it
operates in the passive mode with HWP enabled which causes the
schedutil governor to use that callback instead of ->fast_switch().

The minimum and target performance-level values passed by the
governor to ->adjust_perf() are converted to HWP.REQ.MIN and
HWP.REQ.DESIRED, respectively, which allows the processor to
adjust its configuration to maximize energy-efficiency while
providing sufficient capacity.

The "busy" argument of ->adjust_perf() is used to omit updates
that are likely to cause performance to drop below the expected
level.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   77 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2526,20 +2526,19 @@ static void intel_cpufreq_trace(struct c
 		fp_toint(cpu->iowait_boost * 100));
 }
 
-static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pstate,
-				     bool strict, bool fast_switch)
+static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 min, u32 max,
+				     u32 desired, bool fast_switch)
 {
 	u64 prev = READ_ONCE(cpu->hwp_req_cached), value = prev;
 
 	value &= ~HWP_MIN_PERF(~0L);
-	value |= HWP_MIN_PERF(target_pstate);
+	value |= HWP_MIN_PERF(min);
 
-	/*
-	 * The entire MSR needs to be updated in order to update the HWP min
-	 * field in it, so opportunistically update the max too if needed.
-	 */
 	value &= ~HWP_MAX_PERF(~0L);
-	value |= HWP_MAX_PERF(strict ? target_pstate : cpu->max_perf_ratio);
+	value |= HWP_MAX_PERF(max);
+
+	value &= ~HWP_DESIRED_PERF(~0L);
+	value |= HWP_DESIRED_PERF(desired);
 
 	if (value == prev)
 		return;
@@ -2569,11 +2568,15 @@ static int intel_cpufreq_update_pstate(s
 	int old_pstate = cpu->pstate.current_pstate;
 
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
-	if (hwp_active)
-		intel_cpufreq_adjust_hwp(cpu, target_pstate,
-					 policy->strict_target, fast_switch);
-	else if (target_pstate != old_pstate)
+	if (hwp_active) {
+		int max_pstate = policy->strict_target ?
+				 	target_pstate : cpu->max_perf_ratio;
+
+		intel_cpufreq_adjust_hwp(cpu, target_pstate, max_pstate, 0,
+					 fast_switch);
+	} else if (target_pstate != old_pstate) {
 		intel_cpufreq_adjust_perf_ctl(cpu, target_pstate, fast_switch);
+	}
 
 	cpu->pstate.current_pstate = target_pstate;
 
@@ -2634,6 +2637,54 @@ static unsigned int intel_cpufreq_fast_s
 	return target_pstate * cpu->pstate.scaling;
 }
 
+static void intel_cpufreq_adjust_perf(unsigned int cpunum, bool busy,
+				      unsigned long min_perf,
+				      unsigned long target_perf,
+				      unsigned long capacity)
+{
+	struct cpudata *cpu = all_cpu_data[cpunum];
+	int old_pstate = cpu->pstate.current_pstate;
+	int cap_pstate, min_pstate, max_pstate, target_pstate;
+
+	update_turbo_state();
+	cap_pstate = global.turbo_disabled ? cpu->pstate.max_pstate :
+					     cpu->pstate.turbo_pstate;
+
+	/* Optimization: Avoid unnecessary divisions. */
+
+	target_pstate = cap_pstate;
+	if (target_perf < capacity) {
+		target_pstate = DIV_ROUND_UP(cap_pstate * target_perf, capacity);
+		/*
+		 * Do not reduce the target P-state if the CPU has been busy
+		 * recently, as the reduction is likely to be premature then.
+		 */
+		if (target_pstate < old_pstate && busy)
+			target_pstate = old_pstate;
+	}
+
+	min_pstate = cap_pstate;
+	if (min_perf < capacity)
+		min_pstate = DIV_ROUND_UP(cap_pstate * min_perf, capacity);
+
+	if (min_pstate < cpu->pstate.min_pstate)
+		min_pstate = cpu->pstate.min_pstate;
+
+	if (min_pstate < cpu->min_perf_ratio)
+		min_pstate = cpu->min_perf_ratio;
+
+	max_pstate = min(cap_pstate, cpu->max_perf_ratio);
+	if (max_pstate < min_pstate)
+		max_pstate = min_pstate;
+
+	target_pstate = clamp_t(int, target_pstate, min_pstate, max_pstate);
+
+	intel_cpufreq_adjust_hwp(cpu, min_pstate, max_pstate, target_pstate, true);
+
+	cpu->pstate.current_pstate = target_pstate;
+	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate);
+}
+
 static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	int max_state, turbo_max, min_freq, max_freq, ret;
@@ -3032,6 +3083,8 @@ static int __init intel_pstate_init(void
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.flags |= CPUFREQ_NEED_UPDATE_LIMITS;
+			intel_cpufreq.fast_switch = NULL;
+			intel_cpufreq.adjust_perf = intel_cpufreq_adjust_perf;
 			if (!default_driver)
 				default_driver = &intel_pstate;
 



