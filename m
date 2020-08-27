Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C17254962
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgH0P2N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 11:28:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53246 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgH0P1u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 11:27:50 -0400
Received: from 89-64-89-85.dynamic.chello.pl (89.64.89.85) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id d8641ec3ba7b54ca; Thu, 27 Aug 2020 17:27:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v3 2/5] cpufreq: intel_pstate: Update cached EPP in the active mode
Date:   Thu, 27 Aug 2020 17:13:04 +0200
Message-ID: <2228512.FFnbCeqPFy@kreacher>
In-Reply-To: <2240881.fzTuzKk6Gz@kreacher>
References: <2240881.fzTuzKk6Gz@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Make intel_pstate update the cached EPP value when setting the EPP
via sysfs in the active mode just like it is the case in the passive
mode, for consistency, but also for the benefit of subsequent
changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: No changes

v2 -> v3:
   * Do not change the read part of the EPP sysfs interface.
   * Change the subject and update the changelog.

---
 drivers/cpufreq/intel_pstate.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index bcda1e700a73..e540448e0bd0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -644,6 +644,8 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw
 
 static int intel_pstate_set_epp(struct cpudata *cpu, u32 epp)
 {
+	int ret;
+
 	/*
 	 * Use the cached HWP Request MSR value, because in the active mode the
 	 * register itself may be updated by intel_pstate_hwp_boost_up() or
@@ -659,7 +661,11 @@ static int intel_pstate_set_epp(struct cpudata *cpu, u32 epp)
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
@@ -762,10 +768,8 @@ static ssize_t store_energy_performance_preference(
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
 
@@ -2378,6 +2382,12 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	 */
 	policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
+	if (hwp_active) {
+		struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+		cpu->epp_cached = intel_pstate_get_epp(cpu, 0);
+	}
+
 	return 0;
 }
 
@@ -2585,7 +2595,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
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




