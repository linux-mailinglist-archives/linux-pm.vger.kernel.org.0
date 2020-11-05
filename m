Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80352A7F2C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 13:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgKEM4l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 07:56:41 -0500
Received: from foss.arm.com ([217.140.110.172]:59976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730660AbgKEM4k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0430B142F;
        Thu,  5 Nov 2020 04:56:40 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C40583F719;
        Thu,  5 Nov 2020 04:56:38 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 1/8] cppc_cpufreq: fix misspelling, code style and readability issues
Date:   Thu,  5 Nov 2020 12:55:17 +0000
Message-Id: <20201105125524.4409-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105125524.4409-1-ionela.voinescu@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix a few trivial issues in the cppc_cpufreq driver:

 - indentation of function arguments
 - consistent use of tabs (vs space) in defines
 - spelling: s/Offest/Offset, s/trasition/transition
 - order of local variables, from long pointers to structures to
   short ret and i (index) variables, to improve readability

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f29e8d0553a8..0b6058ab695f 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -26,8 +26,8 @@
 /* Minimum struct length needed for the DMI processor entry we want */
 #define DMI_ENTRY_PROCESSOR_MIN_LENGTH	48
 
-/* Offest in the DMI processor structure for the max frequency */
-#define DMI_PROCESSOR_MAX_SPEED  0x14
+/* Offset in the DMI processor structure for the max frequency */
+#define DMI_PROCESSOR_MAX_SPEED		0x14
 
 /*
  * These structs contain information parsed from per CPU
@@ -97,10 +97,10 @@ static u64 cppc_get_dmi_max_khz(void)
  * For perf/freq > Nominal, we use the ratio perf:freq at Nominal for conversion
  */
 static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
-					unsigned int perf)
+					     unsigned int perf)
 {
-	static u64 max_khz;
 	struct cppc_perf_caps *caps = &cpu->perf_caps;
+	static u64 max_khz;
 	u64 mul, div;
 
 	if (caps->lowest_freq && caps->nominal_freq) {
@@ -121,10 +121,10 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
 }
 
 static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
-					unsigned int freq)
+					     unsigned int freq)
 {
-	static u64 max_khz;
 	struct cppc_perf_caps *caps = &cpu->perf_caps;
+	static u64 max_khz;
 	u64  mul, div;
 
 	if (caps->lowest_freq && caps->nominal_freq) {
@@ -146,11 +146,11 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
 }
 
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
-		unsigned int target_freq,
-		unsigned int relation)
+				   unsigned int target_freq,
+				   unsigned int relation)
 {
-	struct cppc_cpudata *cpu;
 	struct cpufreq_freqs freqs;
+	struct cppc_cpudata *cpu;
 	u32 desired_perf;
 	int ret = 0;
 
@@ -171,7 +171,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	if (ret)
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
-				cpu->cpu, ret);
+			 cpu->cpu, ret);
 
 	return ret;
 }
@@ -193,13 +193,13 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 	ret = cppc_set_perf(cpu_num, &cpu->perf_ctrls);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-				cpu->perf_caps.lowest_perf, cpu_num, ret);
+			 cpu->perf_caps.lowest_perf, cpu_num, ret);
 }
 
 /*
  * The PCC subspace describes the rate at which platform can accept commands
  * on the shared PCC channel (including READs which do not count towards freq
- * trasition requests), so ideally we need to use the PCC values as a fallback
+ * transition requests), so ideally we need to use the PCC values as a fallback
  * if we don't have a platform specific transition_delay_us
  */
 #ifdef CONFIG_ARM64
@@ -241,8 +241,8 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
 
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	struct cppc_cpudata *cpu;
 	unsigned int cpu_num = policy->cpu;
+	struct cppc_cpudata *cpu;
 	int ret = 0;
 
 	cpu = all_cpu_data[policy->cpu];
@@ -252,7 +252,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	if (ret) {
 		pr_debug("Err reading CPU%d perf capabilities. ret:%d\n",
-				cpu_num, ret);
+			 cpu_num, ret);
 		return ret;
 	}
 
@@ -313,7 +313,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	ret = cppc_set_perf(cpu_num, &cpu->perf_ctrls);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-				cpu->perf_caps.highest_perf, cpu_num, ret);
+			 cpu->perf_caps.highest_perf, cpu_num, ret);
 
 	return ret;
 }
@@ -450,8 +450,8 @@ static void cppc_check_hisi_workaround(void)
 
 static int __init cppc_cpufreq_init(void)
 {
-	int i, ret = 0;
 	struct cppc_cpudata *cpu;
+	int i, ret = 0;
 
 	if (acpi_disabled)
 		return -ENODEV;
-- 
2.17.1

