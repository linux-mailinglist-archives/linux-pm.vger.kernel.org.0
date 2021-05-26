Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05773391B05
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhEZPCj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 11:02:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42472 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhEZPCj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 11:02:39 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 85484518f3fbafac; Wed, 26 May 2021 17:01:05 +0200
Received: from kreacher.localnet (89-64-80-240.dynamic.chello.pl [89.64.80.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3E7CA66971B;
        Wed, 26 May 2021 17:01:05 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] cpufreq: intel_pstate: hybrid: Fix build with CONFIG_ACPI unset
Date:   Wed, 26 May 2021 17:01:04 +0200
Message-ID: <4337451.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.240
X-CLIENT-HOSTNAME: 89-64-80-240.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdekfedgkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepkeelrdeigedrkedtrddvgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrddvgedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeihuhdrtgdrtghhvghnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhguuhhnlhgrphesihhn
 fhhrrgguvggrugdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One of the previous commits introducing hybrid processor support to
intel_pstate broke build with CONFIG_ACPI unset.

Fix that and while at it fix up empty stubs of two functions related
to ACPI CPPC.

Fixes: eb3693f0521e ("cpufreq: intel_pstate: hybrid: CPU-specific scaling factor")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   97 +++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -385,9 +385,14 @@ static int intel_pstate_get_cppc_gurante
 }
 
 #else /* CONFIG_ACPI_CPPC_LIB */
-static void intel_pstate_set_itmt_prio(int cpu)
+static inline void intel_pstate_set_itmt_prio(int cpu)
 {
 }
+
+static inline int intel_pstate_get_cppc_guranteed(int cpu)
+{
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_ACPI_CPPC_LIB */
 
 static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
@@ -470,27 +475,6 @@ static void intel_pstate_exit_perf_limit
 
 	acpi_processor_unregister_performance(policy->cpu);
 }
-#else /* CONFIG_ACPI */
-static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
-{
-}
-
-static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
-{
-}
-
-static inline bool intel_pstate_acpi_pm_profile_server(void)
-{
-	return false;
-}
-#endif /* CONFIG_ACPI */
-
-#ifndef CONFIG_ACPI_CPPC_LIB
-static int intel_pstate_get_cppc_guranteed(int cpu)
-{
-	return -ENOTSUPP;
-}
-#endif /* CONFIG_ACPI_CPPC_LIB */
 
 static bool intel_pstate_cppc_perf_valid(u32 perf, struct cppc_perf_caps *caps)
 {
@@ -505,6 +489,20 @@ static bool intel_pstate_cppc_perf_caps(
 
 	return caps->highest_perf && caps->lowest_perf <= caps->highest_perf;
 }
+#else /* CONFIG_ACPI */
+static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
+{
+}
+
+static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
+{
+}
+
+static inline bool intel_pstate_acpi_pm_profile_server(void)
+{
+	return false;
+}
+#endif /* CONFIG_ACPI */
 
 static void intel_pstate_hybrid_hwp_perf_ctl_parity(struct cpudata *cpu)
 {
@@ -530,7 +528,6 @@ static void intel_pstate_hybrid_hwp_perf
  */
 static void intel_pstate_hybrid_hwp_calibrate(struct cpudata *cpu)
 {
-	struct cppc_perf_caps caps;
 	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
 	int perf_ctl_turbo = pstate_funcs.get_turbo();
@@ -548,33 +545,39 @@ static void intel_pstate_hybrid_hwp_cali
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



