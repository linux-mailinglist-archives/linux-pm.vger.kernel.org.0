Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74212506CF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 19:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHXRsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 13:48:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58178 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXRsL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 13:48:11 -0400
Received: from 89-64-88-199.dynamic.chello.pl (89.64.88.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 9859b31d30dcfd9f; Mon, 24 Aug 2020 19:48:09 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v2 5/5] cpufreq: intel_pstate: Restore cached EPP value during offline
Date:   Mon, 24 Aug 2020 19:47:59 +0200
Message-ID: <6584670.ihXX3PbFol@kreacher>
In-Reply-To: <4169555.5IIHXK4Dsd@kreacher>
References: <4169555.5IIHXK4Dsd@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Because hwp_req_cached contains the effective EPP value (0) when the
"performance" scaling algorithm is used in the active mode, replace
it with the cached EPP value during CPU offline to prevent it from
being used (unexpectedly) after switching over from the active mode
to the passive mode.

Also rename intel_pstate_hwp_force_min_perf() because it will do more
than just forcing the minimum performance now.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: New patch.

---
 drivers/cpufreq/intel_pstate.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 37731d45f0ea..61d7179bccdd 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -904,14 +904,25 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
-static void intel_pstate_hwp_force_min_perf(int cpu)
+static void intel_pstate_hwp_offline(int cpu)
 {
-	u64 value;
+	struct cpudata *cpudata = all_cpu_data[cpu];
+	u64 value = READ_ONCE(cpudata->hwp_req_cached);
 	int min_perf;
 
-	value = all_cpu_data[cpu]->hwp_req_cached;
+	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
+		/*
+		 * In case the EPP has been set to "performance" by the
+		 * active mode "performance" scaling algorithm, replace that
+		 * temporary value with the cached EPP one.
+		 */
+		value &= ~GENMASK_ULL(31, 24);
+		value |= HWP_ENERGY_PERF_PREFERENCE(cpudata->epp_cached);
+		WRITE_ONCE(cpudata->hwp_req_cached, value);
+	}
+
 	value &= ~GENMASK_ULL(31, 0);
-	min_perf = HWP_LOWEST_PERF(all_cpu_data[cpu]->hwp_cap_cached);
+	min_perf = HWP_LOWEST_PERF(cpudata->hwp_cap_cached);
 
 	/* Set hwp_max = hwp_min */
 	value |= HWP_MAX_PERF(min_perf);
@@ -2313,7 +2324,7 @@ static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
 	 * performance on CPU offline to prevent that from happening.
 	 */
 	if (hwp_active)
-		intel_pstate_hwp_force_min_perf(policy->cpu);
+		intel_pstate_hwp_offline(policy->cpu);
 	else
 		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
 
-- 
2.26.2




