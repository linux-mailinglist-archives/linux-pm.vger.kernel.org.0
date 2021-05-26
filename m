Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1F391E27
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 19:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhEZRcd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 13:32:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52432 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhEZRcd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 13:32:33 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 135f6987e03f87f7; Wed, 26 May 2021 19:30:59 +0200
Received: from kreacher.localnet (89-64-80-240.dynamic.chello.pl [89.64.80.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A6C3D669748;
        Wed, 26 May 2021 19:30:58 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] cpufreq: intel_pstate: hybrid: Fix build with CONFIG_ACPI unset
Date:   Wed, 26 May 2021 19:30:58 +0200
Message-ID: <5486161.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.240
X-CLIENT-HOSTNAME: 89-64-80-240.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdekfedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppeekledrieegrdektddrvdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrvdegtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephihurdgtrdgthhgvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehrughunhhlrghpsehi
 nhhfrhgruggvrggurdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One of the previous commits introducing hybrid processor support to
intel_pstate broke build with CONFIG_ACPI unset.

Fix that and while at it make empty stubs of two functions related
to ACPI CPPC static inline and fix a spelling mistake in the name of
one of them.

Fixes: eb3693f0521e ("cpufreq: intel_pstate: hybrid: CPU-specific scaling factor")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/cpufreq/intel_pstate.c |   91 +++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -369,7 +369,7 @@ static void intel_pstate_set_itmt_prio(i
 	}
 }
 
-static int intel_pstate_get_cppc_guranteed(int cpu)
+static int intel_pstate_get_cppc_guaranteed(int cpu)
 {
 	struct cppc_perf_caps cppc_perf;
 	int ret;
@@ -385,7 +385,7 @@ static int intel_pstate_get_cppc_gurante
 }
 
 #else /* CONFIG_ACPI_CPPC_LIB */
-static void intel_pstate_set_itmt_prio(int cpu)
+static inline void intel_pstate_set_itmt_prio(int cpu)
 {
 }
 #endif /* CONFIG_ACPI_CPPC_LIB */
@@ -470,6 +470,20 @@ static void intel_pstate_exit_perf_limit
 
 	acpi_processor_unregister_performance(policy->cpu);
 }
+
+static bool intel_pstate_cppc_perf_valid(u32 perf, struct cppc_perf_caps *caps)
+{
+	return perf && perf <= caps->highest_perf && perf >= caps->lowest_perf;
+}
+
+static bool intel_pstate_cppc_perf_caps(struct cpudata *cpu,
+					struct cppc_perf_caps *caps)
+{
+	if (cppc_get_perf_caps(cpu->cpu, caps))
+		return false;
+
+	return caps->highest_perf && caps->lowest_perf <= caps->highest_perf;
+}
 #else /* CONFIG_ACPI */
 static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
@@ -486,26 +500,12 @@ static inline bool intel_pstate_acpi_pm_
 #endif /* CONFIG_ACPI */
 
 #ifndef CONFIG_ACPI_CPPC_LIB
-static int intel_pstate_get_cppc_guranteed(int cpu)
+static inline int intel_pstate_get_cppc_guaranteed(int cpu)
 {
 	return -ENOTSUPP;
 }
 #endif /* CONFIG_ACPI_CPPC_LIB */
 
-static bool intel_pstate_cppc_perf_valid(u32 perf, struct cppc_perf_caps *caps)
-{
-	return perf && perf <= caps->highest_perf && perf >= caps->lowest_perf;
-}
-
-static bool intel_pstate_cppc_perf_caps(struct cpudata *cpu,
-					struct cppc_perf_caps *caps)
-{
-	if (cppc_get_perf_caps(cpu->cpu, caps))
-		return false;
-
-	return caps->highest_perf && caps->lowest_perf <= caps->highest_perf;
-}
-
 static void intel_pstate_hybrid_hwp_perf_ctl_parity(struct cpudata *cpu)
 {
 	pr_debug("CPU%d: Using PERF_CTL scaling for HWP\n", cpu->cpu);
@@ -530,7 +530,6 @@ static void intel_pstate_hybrid_hwp_perf
  */
 static void intel_pstate_hybrid_hwp_calibrate(struct cpudata *cpu)
 {
-	struct cppc_perf_caps caps;
 	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
 	int perf_ctl_turbo = pstate_funcs.get_turbo();
@@ -548,33 +547,39 @@ static void intel_pstate_hybrid_hwp_cali
 	pr_debug("CPU%d: HWP_CAP guaranteed = %d\n", cpu->cpu, cpu->pstate.max_pstate);
 	pr_debug("CPU%d: HWP_CAP highest = %d\n", cpu->cpu, cpu->pstate.turbo_pstate);
 
-	if (intel_pstate_cppc_perf_caps(cpu, &caps)) {
-		if (intel_pstate_cppc_perf_valid(caps.nominal_perf, &caps)) {
-			pr_debug("CPU%d: Using CPPC nominal\n", cpu->cpu);
-
-			/*
-			 * If the CPPC nominal performance is valid, it can be
-			 * assumed to correspond to cpu_khz.
-			 */
-			if (caps.nominal_perf == perf_ctl_max_phys) {
-				intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
-				return;
-			}
-			scaling = DIV_ROUND_UP(cpu_khz, caps.nominal_perf);
-		} else if (intel_pstate_cppc_perf_valid(caps.guaranteed_perf, &caps)) {
-			pr_debug("CPU%d: Using CPPC guaranteed\n", cpu->cpu);
-
-			/*
-			 * If the CPPC guaranteed performance is valid, it can
-			 * be assumed to correspond to max_freq.
-			 */
-			if (caps.guaranteed_perf == perf_ctl_max) {
-				intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
-				return;
+#ifdef CONFIG_ACPI
+	if (IS_ENABLED(CONFIG_ACPI_CPPC_LIB)) {
+		struct cppc_perf_caps caps;
+
+		if (intel_pstate_cppc_perf_caps(cpu, &caps)) {
+			if (intel_pstate_cppc_perf_valid(caps.nominal_perf, &caps)) {
+				pr_debug("CPU%d: Using CPPC nominal\n", cpu->cpu);
+
+				/*
+				 * If the CPPC nominal performance is valid, it
+				 * can be assumed to correspond to cpu_khz.
+				 */
+				if (caps.nominal_perf == perf_ctl_max_phys) {
+					intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
+					return;
+				}
+				scaling = DIV_ROUND_UP(cpu_khz, caps.nominal_perf);
+			} else if (intel_pstate_cppc_perf_valid(caps.guaranteed_perf, &caps)) {
+				pr_debug("CPU%d: Using CPPC guaranteed\n", cpu->cpu);
+
+				/*
+				 * If the CPPC guaranteed performance is valid,
+				 * it can be assumed to correspond to max_freq.
+				 */
+				if (caps.guaranteed_perf == perf_ctl_max) {
+					intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
+					return;
+				}
+				scaling = DIV_ROUND_UP(max_freq, caps.guaranteed_perf);
 			}
-			scaling = DIV_ROUND_UP(max_freq, caps.guaranteed_perf);
 		}
 	}
+#endif
 	/*
 	 * If using the CPPC data to compute the HWP-to-frequency scaling factor
 	 * doesn't work, use the HWP_CAP gauranteed perf for this purpose with
@@ -944,7 +949,7 @@ static ssize_t show_base_frequency(struc
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	int ratio, freq;
 
-	ratio = intel_pstate_get_cppc_guranteed(policy->cpu);
+	ratio = intel_pstate_get_cppc_guaranteed(policy->cpu);
 	if (ratio <= 0) {
 		u64 cap;
 



