Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3836124C36E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgHTQjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 12:39:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47954 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgHTQjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 12:39:11 -0400
Received: from 89-64-87-57.dynamic.chello.pl (89.64.87.57) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 7dcc2d20ba34ff81; Thu, 20 Aug 2020 18:39:08 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 2/4] cpufreq: intel_pstate: Always return last EPP value from sysfs
Date:   Thu, 20 Aug 2020 18:37:11 +0200
Message-ID: <2549178.0mQMFifXHc@kreacher>
In-Reply-To: <2283366.Lr8yYYnyev@kreacher>
References: <2283366.Lr8yYYnyev@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Make the energy_performance_preference policy attribute in sysfs
always return the last EPP value written to it instead of the one
currently in the HWP Request MSR to avoid possible confusion when
the performance scaling algorithm is used in the active mode with
HWP enabled (in which case the EPP is forced to 0 regardless of
what value it has been set to via sysfs).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index bcda1e700a73..3d18934fa975 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -606,13 +606,10 @@ static const unsigned int epp_values[] = {
 
 static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw_epp)
 {
-	s16 epp;
+	s16 epp = cpu_data->epp_cached;
 	int index = -EINVAL;
 
 	*raw_epp = 0;
-	epp = intel_pstate_get_epp(cpu_data, 0);
-	if (epp < 0)
-		return epp;
 
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		if (epp == HWP_EPP_PERFORMANCE)
@@ -644,6 +641,8 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw
 
 static int intel_pstate_set_epp(struct cpudata *cpu, u32 epp)
 {
+	int ret;
+
 	/*
 	 * Use the cached HWP Request MSR value, because in the active mode the
 	 * register itself may be updated by intel_pstate_hwp_boost_up() or
@@ -659,7 +658,11 @@ static int intel_pstate_set_epp(struct cpudata *cpu, u32 epp)
 	 * function, so it cannot run in parallel with the update below.
 	 */
 	WRITE_ONCE(cpu->hwp_req_cached, value);
-	return wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+	ret = wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+	if (!ret)
+		cpu->epp_cached = epp;
+
+	return ret;
 }
 
 static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
@@ -762,10 +765,8 @@ static ssize_t store_energy_performance_preference(
 			cpufreq_stop_governor(policy);
 			ret = intel_pstate_set_epp(cpu, epp);
 			err = cpufreq_start_governor(policy);
-			if (!ret) {
-				cpu->epp_cached = epp;
+			if (!ret)
 				ret = err;
-			}
 		}
 	}
 
@@ -2378,6 +2379,13 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	 */
 	policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
+
+	if (hwp_active) {
+		struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+		cpu->epp_cached = intel_pstate_get_epp(cpu, 0);
+	}
+
 	return 0;
 }
 
@@ -2585,7 +2593,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
 		rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);
-		cpu->epp_cached = (value & GENMASK_ULL(31, 24)) >> 24;
+		cpu->epp_cached = intel_pstate_get_epp(cpu, value);
 	} else {
 		turbo_max = cpu->pstate.turbo_pstate;
 		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
-- 
2.26.2




