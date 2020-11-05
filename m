Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2F2A860E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 19:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgKESZU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 13:25:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:65252 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKESZU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 13:25:20 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.514)
 id 4ff6dc8dccf7dc57; Thu, 5 Nov 2020 19:25:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Take target_min and target_max into account
Date:   Thu, 05 Nov 2020 19:25:10 +0100
Message-ID: <3200924.ySlC381xRO@kreacher>
In-Reply-To: <7417968.Ghue05m4RV@kreacher>
References: <7417968.Ghue05m4RV@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the intel_pstate driver take the new target_min and target_max
cpufreq policy parameters into accout when it operates in the passive
mode with HWP enabled, so as to fix the "powersave" governor behavior
in that case (currently, HWP is allowed to scale the performance all
the way up to the policy max limit when the "powersave" governor is
used, but it should be contrained to the policy min limit then).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2527,7 +2527,7 @@ static void intel_cpufreq_trace(struct c
 }
 
 static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pstate,
-				     bool fast_switch)
+				     u32 target_max, bool fast_switch)
 {
 	u64 prev = READ_ONCE(cpu->hwp_req_cached), value = prev;
 
@@ -2539,7 +2539,7 @@ static void intel_cpufreq_adjust_hwp(str
 	 * field in it, so opportunistically update the max too if needed.
 	 */
 	value &= ~HWP_MAX_PERF(~0L);
-	value |= HWP_MAX_PERF(cpu->max_perf_ratio);
+	value |= HWP_MAX_PERF(target_max);
 
 	if (value == prev)
 		return;
@@ -2562,19 +2562,31 @@ static void intel_cpufreq_adjust_perf_ct
 			      pstate_funcs.get_val(cpu, target_pstate));
 }
 
-static int intel_cpufreq_update_pstate(struct cpudata *cpu, int target_pstate,
-				       bool fast_switch)
+static int intel_cpufreq_update_pstate(struct cpufreq_policy *policy,
+				       int target_pstate, bool fast_switch)
 {
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	int old_pstate = cpu->pstate.current_pstate;
 
-	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	if (hwp_active) {
-		intel_cpufreq_adjust_hwp(cpu, target_pstate, fast_switch);
-		cpu->pstate.current_pstate = target_pstate;
+		int min_pstate = max(cpu->pstate.min_pstate, cpu->min_perf_ratio);
+		int max_pstate = max(min_pstate, cpu->max_perf_ratio);
+		int target_min = DIV_ROUND_UP(policy->target_min,
+					      cpu->pstate.scaling);
+		int target_max = policy->target_max / cpu->pstate.scaling;
+
+		target_min = clamp_t(int, target_min, min_pstate, max_pstate);
+		target_max = clamp_t(int, target_max, min_pstate, max_pstate);
+
+		target_pstate = clamp_t(int, target_pstate, target_min, target_max);
+
+		intel_cpufreq_adjust_hwp(cpu, target_pstate, target_max, fast_switch);
 	} else if (target_pstate != old_pstate) {
+		target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+
 		intel_cpufreq_adjust_perf_ctl(cpu, target_pstate, fast_switch);
-		cpu->pstate.current_pstate = target_pstate;
 	}
+	cpu->pstate.current_pstate = target_pstate;
 
 	intel_cpufreq_trace(cpu, fast_switch ? INTEL_PSTATE_TRACE_FAST_SWITCH :
 			    INTEL_PSTATE_TRACE_TARGET, old_pstate);
@@ -2609,7 +2621,7 @@ static int intel_cpufreq_target(struct c
 		break;
 	}
 
-	target_pstate = intel_cpufreq_update_pstate(cpu, target_pstate, false);
+	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, false);
 
 	freqs.new = target_pstate * cpu->pstate.scaling;
 
@@ -2628,7 +2640,7 @@ static unsigned int intel_cpufreq_fast_s
 
 	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
 
-	target_pstate = intel_cpufreq_update_pstate(cpu, target_pstate, true);
+	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, true);
 
 	return target_pstate * cpu->pstate.scaling;
 }



