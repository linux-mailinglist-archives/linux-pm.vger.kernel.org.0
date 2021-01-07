Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC02ED6E7
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 19:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbhAGSpP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 13:45:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59348 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbhAGSpN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 13:45:13 -0500
Received: from 89-64-81-64.dynamic.chello.pl (89.64.81.64) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 83169161bdda93df; Thu, 7 Jan 2021 19:44:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v1 2/3] cpufreq: intel_pstate: Change intel_pstate_get_hwp_max() argument
Date:   Thu, 07 Jan 2021 19:43:30 +0100
Message-ID: <2241039.bdjsIDbar3@kreacher>
In-Reply-To: <5701645.lOV4Wx5bFT@kreacher>
References: <5701645.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All of the callers of intel_pstate_get_hwp_max() access the struct
cpudata object that corresponds to the given CPU already and the
function itself needs to access that object (in order to update
hwp_cap_cached), so modify the code to pass a struct cpudata pointer
to it instead of the CPU number.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -819,13 +819,13 @@ static struct freq_attr *hwp_cpufreq_att
 	NULL,
 };
 
-static void intel_pstate_get_hwp_max(unsigned int cpu, int *phy_max,
+static void intel_pstate_get_hwp_max(struct cpudata *cpu, int *phy_max,
 				     int *current_max)
 {
 	u64 cap;
 
-	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
-	WRITE_ONCE(all_cpu_data[cpu]->hwp_cap_cached, cap);
+	rdmsrl_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
+	WRITE_ONCE(cpu->hwp_cap_cached, cap);
 	if (global.no_turbo || global.turbo_disabled)
 		*current_max = HWP_GUARANTEED_PERF(cap);
 	else
@@ -1213,7 +1213,7 @@ static void update_qos_request(enum freq
 			continue;
 
 		if (hwp_active)
-			intel_pstate_get_hwp_max(i, &turbo_max, &max_state);
+			intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
 		else
 			turbo_max = cpu->pstate.turbo_pstate;
 
@@ -1723,7 +1723,7 @@ static void intel_pstate_get_cpu_pstates
 	if (hwp_active && !hwp_mode_bdw) {
 		unsigned int phy_max, current_max;
 
-		intel_pstate_get_hwp_max(cpu->cpu, &phy_max, &current_max);
+		intel_pstate_get_hwp_max(cpu, &phy_max, &current_max);
 		cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
 		cpu->pstate.turbo_pstate = phy_max;
 	} else {
@@ -2208,7 +2208,7 @@ static void intel_pstate_update_perf_lim
 	 * rather than pure ratios.
 	 */
 	if (hwp_active) {
-		intel_pstate_get_hwp_max(cpu->cpu, &turbo_max, &max_state);
+		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
 	} else {
 		max_state = global.no_turbo || global.turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
@@ -2323,7 +2323,7 @@ static void intel_pstate_verify_cpu_poli
 	if (hwp_active) {
 		int max_state, turbo_max;
 
-		intel_pstate_get_hwp_max(cpu->cpu, &turbo_max, &max_state);
+		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
 		max_freq = max_state * cpu->pstate.scaling;
 	} else {
 		max_freq = intel_pstate_get_max_freq(cpu);
@@ -2710,7 +2710,7 @@ static int intel_cpufreq_cpu_init(struct
 	if (hwp_active) {
 		u64 value;
 
-		intel_pstate_get_hwp_max(policy->cpu, &turbo_max, &max_state);
+		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
 		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
 		rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);



