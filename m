Return-Path: <linux-pm+bounces-22272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B3A38EC4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33101748EE
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8821B4152;
	Mon, 17 Feb 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAgUOqnA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279851B4132;
	Mon, 17 Feb 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830061; cv=none; b=EQ8B1InLm3DuwvvMXjxGLZrS3BIKPJEVarpT25JUVv7Gzy7VZ5Y5s/NlYC5rPmxZswABSXMIXEVyQeS2Ia424HCTE3z6r1N/oI86YbV/4OTGnNWyDBL398zU/yqY9BxxQmOfYGtqPOkd2b9wmgEWckHilGXcCWKrLJNHInxHb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830061; c=relaxed/simple;
	bh=aBXnfQs6AuKO3OaYjx1C8aapR23T2MTc3b/J8fq7PC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMkUGkK82wTSPvDduIstU8Js2+vMhrNZclemddpKQt2jdBRa7/4ZA4d8HdBl+570dXO42XlQDgP6eH4G3BAzY4/mhR1iNXvWcu4H4EAgqCEcUEyl7qvorG0gO19kT9W/ITwjLSLXSpMV4UgauU9l5pDA7T+GDZvK4lRBcQvj45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAgUOqnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5281CC4CEE2;
	Mon, 17 Feb 2025 22:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830061;
	bh=aBXnfQs6AuKO3OaYjx1C8aapR23T2MTc3b/J8fq7PC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAgUOqnAqez+sNhyv2T+eNqYgXytgRHG97D2mrGFmLYzq8wcuVndtTE+KxzjaC1iK
	 tSq0Pkyy6PcZYX3M6V2By9m83a+2HuQJFVfD1y9CHxrHbNYnosXEEVfvSz6P2DG+Ik
	 64W8YNbHo3WcZXBQLH5Pe98DeHvhxSX3K3dYprh7QdiQLLLlA+0td9BKTKJvErHiOu
	 Uum8Myo3GI+tJ0ps0me1ruiKYdXNi5dVfldmYSgiuCxlX94uHuw2qYLRp0Oe2AELp2
	 t99nd/W6hRQJwbcIZluRJ4W+5WwDaVlrG+7eAfS908O3eQqtLk44mMe9AZMLiUAWJr
	 coPeW6tUzTXjQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 07/18] cpufreq/amd-pstate-ut: Use _free macro to free put policy
Date: Mon, 17 Feb 2025 16:06:56 -0600
Message-ID: <20250217220707.1468365-8-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217220707.1468365-1-superm1@kernel.org>
References: <20250217220707.1468365-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Using a scoped cleanup macro simplifies cleanup code.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index ba3e06f349c6d..9f790c7254d52 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/fs.h>
+#include <linux/cleanup.h>
 
 #include <acpi/cppc_acpi.h>
 
@@ -127,11 +128,12 @@ static void amd_pstate_ut_check_perf(u32 index)
 	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
 	u64 cap1 = 0;
 	struct cppc_perf_caps cppc_perf;
-	struct cpufreq_policy *policy = NULL;
 	struct amd_cpudata *cpudata = NULL;
 	union perf_cached cur_perf;
 
 	for_each_possible_cpu(cpu) {
+		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
 			break;
@@ -142,7 +144,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 			if (ret) {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s cppc_get_perf_caps ret=%d error!\n", __func__, ret);
-				goto skip_test;
+				return;
 			}
 
 			highest_perf = cppc_perf.highest_perf;
@@ -154,7 +156,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 			if (ret) {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
-				goto skip_test;
+				return;
 			}
 
 			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
@@ -167,7 +169,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 		if (highest_perf != cur_perf.highest_perf && !cpudata->hw_prefcore) {
 			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
 				__func__, cpu, highest_perf, cpudata->perf.highest_perf);
-			goto skip_test;
+			return;
 		}
 		if (nominal_perf != cur_perf.nominal_perf ||
 		   (lowest_nonlinear_perf != cur_perf.lowest_nonlinear_perf) ||
@@ -177,7 +179,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 				__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
 				lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
 				lowest_perf, cpudata->perf.lowest_perf);
-			goto skip_test;
+			return;
 		}
 
 		if (!((highest_perf >= nominal_perf) &&
@@ -188,15 +190,11 @@ static void amd_pstate_ut_check_perf(u32 index)
 			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
 				__func__, cpu, highest_perf, nominal_perf,
 				lowest_nonlinear_perf, lowest_perf);
-			goto skip_test;
+			return;
 		}
-		cpufreq_cpu_put(policy);
 	}
 
 	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-	return;
-skip_test:
-	cpufreq_cpu_put(policy);
 }
 
 /*
@@ -207,10 +205,11 @@ static void amd_pstate_ut_check_perf(u32 index)
 static void amd_pstate_ut_check_freq(u32 index)
 {
 	int cpu = 0;
-	struct cpufreq_policy *policy = NULL;
 	struct amd_cpudata *cpudata = NULL;
 
 	for_each_possible_cpu(cpu) {
+		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
 			break;
@@ -224,14 +223,14 @@ static void amd_pstate_ut_check_freq(u32 index)
 			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
 				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
 				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
-			goto skip_test;
+			return;
 		}
 
 		if (cpudata->lowest_nonlinear_freq != policy->min) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d cpudata_lowest_nonlinear_freq=%d policy_min=%d, they should be equal!\n",
 				__func__, cpu, cpudata->lowest_nonlinear_freq, policy->min);
-			goto skip_test;
+			return;
 		}
 
 		if (cpudata->boost_supported) {
@@ -243,20 +242,16 @@ static void amd_pstate_ut_check_freq(u32 index)
 				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
 					__func__, cpu, policy->max, policy->cpuinfo.max_freq,
 					cpudata->nominal_freq);
-				goto skip_test;
+				return;
 			}
 		} else {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
-			goto skip_test;
+			return;
 		}
-		cpufreq_cpu_put(policy);
 	}
 
 	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-	return;
-skip_test:
-	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_set_mode(enum amd_pstate_mode mode)
-- 
2.43.0


