Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798212AC191
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 17:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgKIQ5H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 11:57:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46558 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgKIQ5G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 11:57:06 -0500
Received: from 89-64-87-89.dynamic.chello.pl (89.64.87.89) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id b729a6806886ddaf; Mon, 9 Nov 2020 17:57:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v2 4/4] cpufreq: intel_pstate: Take CPUFREQ_GOV_FLAG_STRICT_TARGET into account
Date:   Mon, 09 Nov 2020 17:55:42 +0100
Message-ID: <2345253.LYi3vV7ftd@kreacher>
In-Reply-To: <13269660.K2JYd4sGFX@kreacher>
References: <13269660.K2JYd4sGFX@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make intel_pstate take the new CPUFREQ_GOV_FLAG_STRICT_TARGET
governor flag into account when it operates in the passive mode with
HWP enabled, so as to fix the "powersave" governor behavior in that
case (currently, HWP is allowed to scale the performance all the way
up to the policy max limit when the "powersave" governor is used,
but it should be constrained to the policy min limit then).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2527,7 +2527,7 @@ static void intel_cpufreq_trace(struct c
 }
 
 static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pstate,
-				     bool fast_switch)
+				     bool strict, bool fast_switch)
 {
 	u64 prev = READ_ONCE(cpu->hwp_req_cached), value = prev;
 
@@ -2539,7 +2539,7 @@ static void intel_cpufreq_adjust_hwp(str
 	 * field in it, so opportunistically update the max too if needed.
 	 */
 	value &= ~HWP_MAX_PERF(~0L);
-	value |= HWP_MAX_PERF(cpu->max_perf_ratio);
+	value |= HWP_MAX_PERF(strict ? target_pstate : cpu->max_perf_ratio);
 
 	if (value == prev)
 		return;
@@ -2562,14 +2562,16 @@ static void intel_cpufreq_adjust_perf_ct
 			      pstate_funcs.get_val(cpu, target_pstate));
 }
 
-static int intel_cpufreq_update_pstate(struct cpudata *cpu, int target_pstate,
-				       bool fast_switch)
+static int intel_cpufreq_update_pstate(struct cpufreq_policy *policy,
+				       int target_pstate, bool fast_switch)
 {
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	int old_pstate = cpu->pstate.current_pstate;
 
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	if (hwp_active) {
-		intel_cpufreq_adjust_hwp(cpu, target_pstate, fast_switch);
+		intel_cpufreq_adjust_hwp(cpu, target_pstate,
+					 policy->strict_target, fast_switch);
 		cpu->pstate.current_pstate = target_pstate;
 	} else if (target_pstate != old_pstate) {
 		intel_cpufreq_adjust_perf_ctl(cpu, target_pstate, fast_switch);
@@ -2609,7 +2611,7 @@ static int intel_cpufreq_target(struct c
 		break;
 	}
 
-	target_pstate = intel_cpufreq_update_pstate(cpu, target_pstate, false);
+	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, false);
 
 	freqs.new = target_pstate * cpu->pstate.scaling;
 
@@ -2628,7 +2630,7 @@ static unsigned int intel_cpufreq_fast_s
 
 	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
 
-	target_pstate = intel_cpufreq_update_pstate(cpu, target_pstate, true);
+	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, true);
 
 	return target_pstate * cpu->pstate.scaling;
 }



