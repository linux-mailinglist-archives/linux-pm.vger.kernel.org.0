Return-Path: <linux-pm+bounces-22962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB25A45717
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E207A741F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C4272928;
	Wed, 26 Feb 2025 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaVL8ONB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92937272924;
	Wed, 26 Feb 2025 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556194; cv=none; b=DyyJQ3HZXo0RHM5V6b1qNTkNx3nFC8kwFNTpSTT+aIrokgwFXZ668T2dw2KEW+Cz20fTwg0Jk9xsZUbMLp4mdqf+189cFDdY/q9XeqA67/aIrIBu3K1/OpkELcFQa6MdNl8uYXrZ3RzG+b2i/6r/ejFv8tQ96C9vtZx/hHQ7aNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556194; c=relaxed/simple;
	bh=Q9vnlr16LPJsaaaQcIaxKEsHF/dgnRxRXNH3cGTXpUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvvr48z1/+/4vw9KSUdDmhrxDjs/IKNKezAF0JKKCR6RpyuGWgcvljdoMX4yNIhRtyav7WKCAcDwJCHuapelCt5o+Twt/fSgisjvVUNLQSmXOyMlQwmlqbeCpeodkwYVF1skgTU/uUQmkETSGF4lNGZ4QUIz6YtNbgwtwUB0biI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaVL8ONB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ACAC4CED6;
	Wed, 26 Feb 2025 07:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556194;
	bh=Q9vnlr16LPJsaaaQcIaxKEsHF/dgnRxRXNH3cGTXpUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaVL8ONBSqDWRKKmOvqVYV3uVMrxgcbez4F2W+fPtF0v9bOa9nf/gDrRSkcJHzWgA
	 LaYfyK3BOoIUnGL6hbsvzLeTm9C4sBF+hEol0GG87ItYk2UnSLjexwb3HtplBr5RYB
	 fSgV1U9vAKMCQdiG5JdWlrT5pkhJT8MUKVHEtLRCTC+fbX+0SbcShLbR7xR84GXXvx
	 KJdyVGpj3xgmMxS0s1iEXQh+8XvwWwryFkndVqpOFRvO1/y1Z2Ng/051ui73q2loBA
	 5Mki//Srdt9ExDppE9k8HD0NZ6aoRkSvHz+knK6tErH5OVJ/sJNqz0qbs2+bgazbUr
	 Z9jbw4bp5NVmw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 09/19] cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL enums
Date: Wed, 26 Feb 2025 01:49:24 -0600
Message-ID: <20250226074934.1667721-10-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226074934.1667721-1-superm1@kernel.org>
References: <20250226074934.1667721-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Enums are effectively used as a boolean and don't show
the return value of the failing call.

Instead of using enums switch to returning the actual return
code from the unit test.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Add tag
---
 drivers/cpufreq/amd-pstate-ut.c | 143 ++++++++++++--------------------
 1 file changed, 55 insertions(+), 88 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index b3693a4c28d26..cd9a472e8dc3c 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -32,30 +32,20 @@
 
 #include "amd-pstate.h"
 
-/*
- * Abbreviations:
- * amd_pstate_ut: used as a shortform for AMD P-State unit test.
- * It helps to keep variable names smaller, simpler
- */
-enum amd_pstate_ut_result {
-	AMD_PSTATE_UT_RESULT_PASS,
-	AMD_PSTATE_UT_RESULT_FAIL,
-};
 
 struct amd_pstate_ut_struct {
 	const char *name;
-	void (*func)(u32 index);
-	enum amd_pstate_ut_result result;
+	int (*func)(u32 index);
 };
 
 /*
  * Kernel module for testing the AMD P-State unit test
  */
-static void amd_pstate_ut_acpi_cpc_valid(u32 index);
-static void amd_pstate_ut_check_enabled(u32 index);
-static void amd_pstate_ut_check_perf(u32 index);
-static void amd_pstate_ut_check_freq(u32 index);
-static void amd_pstate_ut_check_driver(u32 index);
+static int amd_pstate_ut_acpi_cpc_valid(u32 index);
+static int amd_pstate_ut_check_enabled(u32 index);
+static int amd_pstate_ut_check_perf(u32 index);
+static int amd_pstate_ut_check_freq(u32 index);
+static int amd_pstate_ut_check_driver(u32 index);
 
 static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 	{"amd_pstate_ut_acpi_cpc_valid",   amd_pstate_ut_acpi_cpc_valid   },
@@ -78,51 +68,46 @@ static bool get_shared_mem(void)
 /*
  * check the _CPC object is present in SBIOS.
  */
-static void amd_pstate_ut_acpi_cpc_valid(u32 index)
+static int amd_pstate_ut_acpi_cpc_valid(u32 index)
 {
-	if (acpi_cpc_valid())
-		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-	else {
-		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+	if (!acpi_cpc_valid()) {
 		pr_err("%s the _CPC object is not present in SBIOS!\n", __func__);
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
-static void amd_pstate_ut_pstate_enable(u32 index)
+/*
+ * check if amd pstate is enabled
+ */
+static int amd_pstate_ut_check_enabled(u32 index)
 {
-	int ret = 0;
 	u64 cppc_enable = 0;
+	int ret;
+
+	if (get_shared_mem())
+		return 0;
 
 	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
 	if (ret) {
-		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d error!\n", __func__, ret);
-		return;
+		return ret;
 	}
-	if (cppc_enable)
-		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-	else {
-		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+
+	if (!cppc_enable) {
 		pr_err("%s amd pstate must be enabled!\n", __func__);
+		return -EINVAL;
 	}
-}
 
-/*
- * check if amd pstate is enabled
- */
-static void amd_pstate_ut_check_enabled(u32 index)
-{
-	if (get_shared_mem())
-		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-	else
-		amd_pstate_ut_pstate_enable(index);
+	return 0;
 }
 
 /*
  * check if performance values are reasonable.
  * highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0
  */
-static void amd_pstate_ut_check_perf(u32 index)
+static int amd_pstate_ut_check_perf(u32 index)
 {
 	int cpu = 0, ret = 0;
 	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
@@ -142,9 +127,8 @@ static void amd_pstate_ut_check_perf(u32 index)
 		if (get_shared_mem()) {
 			ret = cppc_get_perf_caps(cpu, &cppc_perf);
 			if (ret) {
-				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s cppc_get_perf_caps ret=%d error!\n", __func__, ret);
-				return;
+				return ret;
 			}
 
 			highest_perf = cppc_perf.highest_perf;
@@ -154,9 +138,8 @@ static void amd_pstate_ut_check_perf(u32 index)
 		} else {
 			ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
 			if (ret) {
-				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
-				return;
+				return ret;
 			}
 
 			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
@@ -169,32 +152,30 @@ static void amd_pstate_ut_check_perf(u32 index)
 		if (highest_perf != cur_perf.highest_perf && !cpudata->hw_prefcore) {
 			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
 				__func__, cpu, highest_perf, cur_perf.highest_perf);
-			return;
+			return -EINVAL;
 		}
 		if (nominal_perf != cur_perf.nominal_perf ||
 		   (lowest_nonlinear_perf != cur_perf.lowest_nonlinear_perf) ||
 		   (lowest_perf != cur_perf.lowest_perf)) {
-			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
 				__func__, cpu, nominal_perf, cur_perf.nominal_perf,
 				lowest_nonlinear_perf, cur_perf.lowest_nonlinear_perf,
 				lowest_perf, cur_perf.lowest_perf);
-			return;
+			return -EINVAL;
 		}
 
 		if (!((highest_perf >= nominal_perf) &&
 			(nominal_perf > lowest_nonlinear_perf) &&
 			(lowest_nonlinear_perf >= lowest_perf) &&
 			(lowest_perf > 0))) {
-			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
 				__func__, cpu, highest_perf, nominal_perf,
 				lowest_nonlinear_perf, lowest_perf);
-			return;
+			return -EINVAL;
 		}
 	}
 
-	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+	return 0;
 }
 
 /*
@@ -202,7 +183,7 @@ static void amd_pstate_ut_check_perf(u32 index)
  * max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0
  * check max freq when set support boost mode.
  */
-static void amd_pstate_ut_check_freq(u32 index)
+static int amd_pstate_ut_check_freq(u32 index)
 {
 	int cpu = 0;
 	struct amd_cpudata *cpudata = NULL;
@@ -219,39 +200,33 @@ static void amd_pstate_ut_check_freq(u32 index)
 			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
 			(cpudata->lowest_nonlinear_freq >= policy->cpuinfo.min_freq) &&
 			(policy->cpuinfo.min_freq > 0))) {
-			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
 				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
 				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
-			return;
+			return -EINVAL;
 		}
 
 		if (cpudata->lowest_nonlinear_freq != policy->min) {
-			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d cpudata_lowest_nonlinear_freq=%d policy_min=%d, they should be equal!\n",
 				__func__, cpu, cpudata->lowest_nonlinear_freq, policy->min);
-			return;
+			return -EINVAL;
 		}
 
 		if (cpudata->boost_supported) {
-			if ((policy->max == policy->cpuinfo.max_freq) ||
-					(policy->max == cpudata->nominal_freq))
-				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-			else {
-				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+			if ((policy->max != policy->cpuinfo.max_freq) &&
+			    (policy->max != cpudata->nominal_freq)) {
 				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
 					__func__, cpu, policy->max, policy->cpuinfo.max_freq,
 					cpudata->nominal_freq);
-				return;
+				return -EINVAL;
 			}
 		} else {
-			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
-			return;
+			return -EINVAL;
 		}
 	}
 
-	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+	return 0;
 }
 
 static int amd_pstate_set_mode(enum amd_pstate_mode mode)
@@ -263,32 +238,28 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
 	return amd_pstate_update_status(mode_str, strlen(mode_str));
 }
 
-static void amd_pstate_ut_check_driver(u32 index)
+static int amd_pstate_ut_check_driver(u32 index)
 {
 	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;
-	int ret;
 
 	for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {
-		ret = amd_pstate_set_mode(mode1);
+		int ret = amd_pstate_set_mode(mode1);
 		if (ret)
-			goto out;
+			return ret;
 		for (mode2 = AMD_PSTATE_DISABLE; mode2 < AMD_PSTATE_MAX; mode2++) {
 			if (mode1 == mode2)
 				continue;
 			ret = amd_pstate_set_mode(mode2);
-			if (ret)
-				goto out;
+			if (ret) {
+				pr_err("%s: failed to update status for %s->%s\n", __func__,
+					amd_pstate_get_mode_string(mode1),
+					amd_pstate_get_mode_string(mode2));
+				return ret;
+			}
 		}
 	}
-out:
-	if (ret)
-		pr_warn("%s: failed to update status for %s->%s: %d\n", __func__,
-			amd_pstate_get_mode_string(mode1),
-			amd_pstate_get_mode_string(mode2), ret);
-
-	amd_pstate_ut_cases[index].result = ret ?
-					    AMD_PSTATE_UT_RESULT_FAIL :
-					    AMD_PSTATE_UT_RESULT_PASS;
+
+	return 0;
 }
 
 static int __init amd_pstate_ut_init(void)
@@ -296,16 +267,12 @@ static int __init amd_pstate_ut_init(void)
 	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
 
 	for (i = 0; i < arr_size; i++) {
-		amd_pstate_ut_cases[i].func(i);
-		switch (amd_pstate_ut_cases[i].result) {
-		case AMD_PSTATE_UT_RESULT_PASS:
+		int ret = amd_pstate_ut_cases[i].func(i);
+
+		if (ret)
+			pr_err("%-4d %-20s\t fail: %d!\n", i+1, amd_pstate_ut_cases[i].name, ret);
+		else
 			pr_info("%-4d %-20s\t success!\n", i+1, amd_pstate_ut_cases[i].name);
-			break;
-		case AMD_PSTATE_UT_RESULT_FAIL:
-		default:
-			pr_info("%-4d %-20s\t fail!\n", i+1, amd_pstate_ut_cases[i].name);
-			break;
-		}
 	}
 
 	return 0;
-- 
2.43.0


