Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0370F2F0D51
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 08:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbhAKHky (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 02:40:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:43170 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAKHky (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 02:40:54 -0500
IronPort-SDR: 5GbOYVGaLC+3LC4GYd2gMW3kqPung0RmyFOvr6xXp1mCLEZqmEAqEY23tqhg2tpa6QTnD4BhtR
 MRhVTBw4QlIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="164901398"
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="164901398"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 23:40:12 -0800
IronPort-SDR: svIfTYNFBk4qwxUjpKkbRcodt3qGQWGl1AFWoZEsnbG0arR43xQ9ia1bxK0Yn/OzawQYQVzVjK
 UELJFJ+z8krA==
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="571328551"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 23:40:10 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][v2] cpufreq: intel_pstate: Add parameter to get guarantee frequency
Date:   Mon, 11 Jan 2021 15:43:29 +0800
Message-Id: <f03c683e06109a00ef3e3ecdd068759dfb4ac0b7.1610338353.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1610338353.git.yu.c.chen@intel.com>
References: <cover.1610338353.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add input parameter to receive guarantee pstate from intel_pstate_get_hwp_max()
for later use.

No functional change intended.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index eaf32ef7a030..bd3dd1be73ba 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -830,7 +830,7 @@ static struct freq_attr *hwp_cpufreq_attrs[] = {
 };
 
 static void intel_pstate_get_hwp_max(struct cpudata *cpu, int *phy_max,
-				     int *current_max)
+				     int *current_max, int *guar_max)
 {
 	u64 cap;
 
@@ -842,6 +842,7 @@ static void intel_pstate_get_hwp_max(struct cpudata *cpu, int *phy_max,
 		*current_max = HWP_HIGHEST_PERF(cap);
 
 	*phy_max = HWP_HIGHEST_PERF(cap);
+	*guar_max = HWP_GUARANTEED_PERF(cap);
 }
 
 static void intel_pstate_hwp_set(unsigned int cpu)
@@ -1205,7 +1206,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 
 static void update_qos_request(enum freq_qos_req_type type)
 {
-	int max_state, turbo_max, freq, i, perf_pct;
+	int max_state, turbo_max, guar_state, freq, i, perf_pct;
 	struct freq_qos_request *req;
 	struct cpufreq_policy *policy;
 
@@ -1223,7 +1224,7 @@ static void update_qos_request(enum freq_qos_req_type type)
 			continue;
 
 		if (hwp_active)
-			intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
+			intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state, &guar_state);
 		else
 			turbo_max = cpu->pstate.turbo_pstate;
 
@@ -1731,9 +1732,9 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
 
 	if (hwp_active && !hwp_mode_bdw) {
-		unsigned int phy_max, current_max;
+		unsigned int phy_max, current_max, guar_state;
 
-		intel_pstate_get_hwp_max(cpu, &phy_max, &current_max);
+		intel_pstate_get_hwp_max(cpu, &phy_max, &current_max, &guar_state);
 		cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
 		cpu->pstate.turbo_pstate = phy_max;
 	} else {
@@ -2209,7 +2210,7 @@ static void intel_pstate_update_perf_limits(struct cpudata *cpu,
 					    unsigned int policy_max)
 {
 	int32_t max_policy_perf, min_policy_perf;
-	int max_state, turbo_max;
+	int max_state, turbo_max, guar_state;
 	int max_freq;
 
 	/*
@@ -2218,7 +2219,7 @@ static void intel_pstate_update_perf_limits(struct cpudata *cpu,
 	 * rather than pure ratios.
 	 */
 	if (hwp_active) {
-		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
+		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state, &guar_state);
 	} else {
 		max_state = global.no_turbo || global.turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
@@ -2331,9 +2332,9 @@ static void intel_pstate_verify_cpu_policy(struct cpudata *cpu,
 
 	update_turbo_state();
 	if (hwp_active) {
-		int max_state, turbo_max;
+		int max_state, turbo_max, guar_state;
 
-		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
+		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state, &guar_state);
 		max_freq = max_state * cpu->pstate.scaling;
 	} else {
 		max_freq = intel_pstate_get_max_freq(cpu);
@@ -2691,7 +2692,7 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
 
 static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	int max_state, turbo_max, min_freq, max_freq, ret;
+	int max_state, turbo_max, guar_state, min_freq, max_freq, ret;
 	struct freq_qos_request *req;
 	struct cpudata *cpu;
 	struct device *dev;
@@ -2719,7 +2720,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (hwp_active) {
 		u64 value;
 
-		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
+		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state, &guar_state);
 		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
 		rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);
-- 
2.17.1

