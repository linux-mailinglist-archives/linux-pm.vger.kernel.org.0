Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C08033D846
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 16:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhCPPxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 11:53:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42880 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhCPPwq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 11:52:46 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 4c2fc4c98a265c13; Tue, 16 Mar 2021 16:52:44 +0100
Received: from kreacher.localnet (89-64-82-37.dynamic.chello.pl [89.64.82.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BA6F9668BE1;
        Tue, 16 Mar 2021 16:52:43 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Clean up frequency computations
Date:   Tue, 16 Mar 2021 16:52:43 +0100
Message-ID: <1662840.8zf6FDN98U@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefvddgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevudefgfeguedtjedvhfetveegleduveeuvedvjeekleefhfduhfefheekffefveenucfkphepkeelrdeigedrkedvrdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekvddrfeejpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeihuhdrtgdrtghhvghnsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that some computations related to frequency in intel_pstate
can be simplified if (a) intel_pstate_get_hwp_max() updates the
relevant members of struct cpudata by itself and (b) the "turbo
disabled" check is moved from it to its callers, so modify the code
accordingly and while at it rename intel_pstate_get_hwp_max() to
intel_pstate_get_hwp_cap() which better reflects its purpose and
provide a simplified variat of it, __intel_pstate_get_hwp_cap(),
suitable for the initialization path.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  101 ++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 56 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -819,19 +819,21 @@ static struct freq_attr *hwp_cpufreq_att
 	NULL,
 };
 
-static void intel_pstate_get_hwp_max(struct cpudata *cpu, int *phy_max,
-				     int *current_max)
+static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
 {
 	u64 cap;
 
 	rdmsrl_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
 	WRITE_ONCE(cpu->hwp_cap_cached, cap);
-	if (global.no_turbo || global.turbo_disabled)
-		*current_max = HWP_GUARANTEED_PERF(cap);
-	else
-		*current_max = HWP_HIGHEST_PERF(cap);
+	cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(cap);
+	cpu->pstate.turbo_pstate = HWP_HIGHEST_PERF(cap);
+}
 
-	*phy_max = HWP_HIGHEST_PERF(cap);
+static void intel_pstate_get_hwp_cap(struct cpudata *cpu)
+{
+	__intel_pstate_get_hwp_cap(cpu);
+	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
+	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 }
 
 static void intel_pstate_hwp_set(unsigned int cpu)
@@ -1195,12 +1197,13 @@ static ssize_t store_no_turbo(struct kob
 
 static void update_qos_request(enum freq_qos_req_type type)
 {
-	int max_state, turbo_max, freq, i, perf_pct;
 	struct freq_qos_request *req;
 	struct cpufreq_policy *policy;
+	int i;
 
 	for_each_possible_cpu(i) {
 		struct cpudata *cpu = all_cpu_data[i];
+		unsigned int freq, perf_pct;
 
 		policy = cpufreq_cpu_get(i);
 		if (!policy)
@@ -1213,9 +1216,7 @@ static void update_qos_request(enum freq
 			continue;
 
 		if (hwp_active)
-			intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
-		else
-			turbo_max = cpu->pstate.turbo_pstate;
+			intel_pstate_get_hwp_cap(cpu);
 
 		if (type == FREQ_QOS_MIN) {
 			perf_pct = global.min_perf_pct;
@@ -1224,8 +1225,7 @@ static void update_qos_request(enum freq
 			perf_pct = global.max_perf_pct;
 		}
 
-		freq = DIV_ROUND_UP(turbo_max * perf_pct, 100);
-		freq *= cpu->pstate.scaling;
+		freq = DIV_ROUND_UP(cpu->pstate.turbo_freq * perf_pct, 100);
 
 		if (freq_qos_update_request(req, freq) < 0)
 			pr_warn("Failed to update freq constraint: CPU%d\n", i);
@@ -1715,21 +1715,17 @@ static void intel_pstate_get_cpu_pstates
 {
 	cpu->pstate.min_pstate = pstate_funcs.get_min();
 	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical();
-	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	cpu->pstate.scaling = pstate_funcs.get_scaling();
 
 	if (hwp_active && !hwp_mode_bdw) {
-		unsigned int phy_max, current_max;
-
-		intel_pstate_get_hwp_max(cpu, &phy_max, &current_max);
-		cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
-		cpu->pstate.turbo_pstate = phy_max;
-		cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(READ_ONCE(cpu->hwp_cap_cached));
+		__intel_pstate_get_hwp_cap(cpu);
 	} else {
-		cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 		cpu->pstate.max_pstate = pstate_funcs.get_max();
+		cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	}
+
 	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
+	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 
 	if (pstate_funcs.get_aperf_mperf_shift)
 		cpu->aperf_mperf_shift = pstate_funcs.get_aperf_mperf_shift();
@@ -2204,18 +2200,21 @@ static void intel_pstate_update_perf_lim
 	int max_freq;
 
 	/*
-	 * HWP needs some special consideration, because on BDX the
-	 * HWP_REQUEST uses abstract value to represent performance
-	 * rather than pure ratios.
+	 * HWP needs some special consideration, because HWP_REQUEST uses
+	 * abstract values to represent performance rather than pure ratios.
 	 */
-	if (hwp_active) {
-		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
+	if (hwp_active)
+		intel_pstate_get_hwp_cap(cpu);
+
+	if (global.no_turbo || global.turbo_disabled) {
+		max_state = cpu->pstate.max_pstate;
+		max_freq = cpu->pstate.max_freq;
 	} else {
-		max_state = global.no_turbo || global.turbo_disabled ?
-			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
-		turbo_max = cpu->pstate.turbo_pstate;
+		max_state = cpu->pstate.turbo_pstate;
+		max_freq = cpu->pstate.turbo_freq;
 	}
-	max_freq = max_state * cpu->pstate.scaling;
+
+	turbo_max = cpu->pstate.turbo_pstate;
 
 	max_policy_perf = max_state * policy_max / max_freq;
 	if (policy_max == policy_min) {
@@ -2322,10 +2321,9 @@ static void intel_pstate_verify_cpu_poli
 
 	update_turbo_state();
 	if (hwp_active) {
-		int max_state, turbo_max;
-
-		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
-		max_freq = max_state * cpu->pstate.scaling;
+		intel_pstate_get_hwp_cap(cpu);
+		max_freq = global.no_turbo || global.turbo_disabled ?
+				cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 	} else {
 		max_freq = intel_pstate_get_max_freq(cpu);
 	}
@@ -2416,25 +2414,15 @@ static int __intel_pstate_cpu_init(struc
 	cpu->max_perf_ratio = 0xFF;
 	cpu->min_perf_ratio = 0;
 
-	policy->min = cpu->pstate.min_pstate * cpu->pstate.scaling;
-	policy->max = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
-
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	update_turbo_state();
 	global.turbo_disabled_mf = global.turbo_disabled;
 	policy->cpuinfo.max_freq = global.turbo_disabled ?
-			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
-	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
-
-	if (hwp_active) {
-		unsigned int max_freq;
-
-		max_freq = global.turbo_disabled ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
-		if (max_freq < policy->cpuinfo.max_freq)
-			policy->cpuinfo.max_freq = max_freq;
-	}
+
+	policy->min = policy->cpuinfo.min_freq;
+	policy->max = policy->cpuinfo.max_freq;
 
 	intel_pstate_init_acpi_perf_limits(policy);
 
@@ -2683,10 +2671,10 @@ static void intel_cpufreq_adjust_perf(un
 
 static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	int max_state, turbo_max, min_freq, max_freq, ret;
 	struct freq_qos_request *req;
 	struct cpudata *cpu;
 	struct device *dev;
+	int ret, freq;
 
 	dev = get_cpu_device(policy->cpu);
 	if (!dev)
@@ -2711,30 +2699,31 @@ static int intel_cpufreq_cpu_init(struct
 	if (hwp_active) {
 		u64 value;
 
-		intel_pstate_get_hwp_max(cpu, &turbo_max, &max_state);
 		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
+
+		intel_pstate_get_hwp_cap(cpu);
+
 		rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);
+
 		cpu->epp_cached = intel_pstate_get_epp(cpu, value);
 	} else {
-		turbo_max = cpu->pstate.turbo_pstate;
 		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
 	}
 
-	min_freq = DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
-	min_freq *= cpu->pstate.scaling;
-	max_freq = DIV_ROUND_UP(turbo_max * global.max_perf_pct, 100);
-	max_freq *= cpu->pstate.scaling;
+	freq = DIV_ROUND_UP(cpu->pstate.turbo_freq * global.min_perf_pct, 100);
 
 	ret = freq_qos_add_request(&policy->constraints, req, FREQ_QOS_MIN,
-				   min_freq);
+				   freq);
 	if (ret < 0) {
 		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
 		goto free_req;
 	}
 
+	freq = DIV_ROUND_UP(cpu->pstate.turbo_freq * global.max_perf_pct, 100);
+
 	ret = freq_qos_add_request(&policy->constraints, req + 1, FREQ_QOS_MAX,
-				   max_freq);
+				   freq);
 	if (ret < 0) {
 		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
 		goto remove_min_req;



