Return-Path: <linux-pm+bounces-21510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3D4A2B480
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFAF3A7787
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B21246350;
	Thu,  6 Feb 2025 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbO8tj7S"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612B24634C;
	Thu,  6 Feb 2025 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879043; cv=none; b=GEVy+fO/XIY/YBXMGnLhFJ8nyOHsAWe+xUmPgokEECIFjTMEHtW2X+8vVTHBvp3lczDXRvXkNzOaJWR6WbRJa23kwm6D6b5dqfQ941V51BvTTW6ycFECz1HDQXptHLFhokVakzse3RI35xTt2gvEJKusGvVppbtLcdkEi1cwrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879043; c=relaxed/simple;
	bh=6yZ8qTdVouNCiIKHB3w8w1TOr7DR8ltTSCBoE2vw5fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etJl9Ouhl6hJJqsYXFqO9FP+fTXmjD3WmuwKaa+se23hlEbCEWDl99v3ePP/95KwvELdS5fSowHYNxaDpR8vZrDf3hnv7IpkPXn2YjZ/6sDDWao0DTVU7EN2yCG3guoTre6vBl0MPikiN2uj2ux4aM5tHzY9g15apojQQbOulcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbO8tj7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51194C4CEDD;
	Thu,  6 Feb 2025 21:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879042;
	bh=6yZ8qTdVouNCiIKHB3w8w1TOr7DR8ltTSCBoE2vw5fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbO8tj7SMu/07p1twP2iPymXiFeQn/OVjg+H0tW6C2HlDbsbDlq8XdAxpKkJJ+AiF
	 i5nu8TQFU6zf01Ev8eFFugMXxvkQ2YLJSCczjU1/rK6UyXvI3Sqc4W04MGyMvcMKCD
	 DjhjC27caopkdDGb7OnyUd3ya6/1y+gS2707cNpzXT/yivzBfirL3Qsq3mgZSa6jvq
	 TBzQJS2RQIueVtoLztuyviOHnLPw2fAlq09AhT1yJR6OOYKdEFF94MjQOkoUsk2EO+
	 9P6+k6ASY/rNSpXSnIUqVqUewRUVtcIsavAeZlvh7AA4c6yucPOEicU0ILwPPBIS3B
	 1CqYvYJRvsakA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 06/14] cpufreq/amd-pstate-ut: Use _free macro to free put policy
Date: Thu,  6 Feb 2025 15:56:51 -0600
Message-ID: <20250206215659.3350066-7-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206215659.3350066-1-superm1@kernel.org>
References: <20250206215659.3350066-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Using a scoped cleanup macro simplifies cleanup code.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index d9ab98c6f56b1..adaa62fb2b04e 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/fs.h>
+#include <linux/cleanup.h>
 
 #include <acpi/cppc_acpi.h>
 
@@ -127,10 +128,11 @@ static void amd_pstate_ut_check_perf(u32 index)
 	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
 	u64 cap1 = 0;
 	struct cppc_perf_caps cppc_perf;
-	struct cpufreq_policy *policy = NULL;
 	struct amd_cpudata *cpudata = NULL;
 
 	for_each_possible_cpu(cpu) {
+		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
 			break;
@@ -141,7 +143,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 			if (ret) {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s cppc_get_perf_caps ret=%d error!\n", __func__, ret);
-				goto skip_test;
+				return;
 			}
 
 			highest_perf = cppc_perf.highest_perf;
@@ -153,7 +155,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 			if (ret) {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
-				goto skip_test;
+				return;
 			}
 
 			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
@@ -166,7 +168,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 		    !cpudata->hw_prefcore) {
 			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
 				__func__, cpu, highest_perf, cpudata->perf.highest_perf);
-			goto skip_test;
+			return;
 		}
 		if ((nominal_perf != READ_ONCE(cpudata->perf.nominal_perf)) ||
 			(lowest_nonlinear_perf != READ_ONCE(cpudata->perf.lowest_nonlinear_perf)) ||
@@ -176,7 +178,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 				__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
 				lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
 				lowest_perf, cpudata->perf.lowest_perf);
-			goto skip_test;
+			return;
 		}
 
 		if (!((highest_perf >= nominal_perf) &&
@@ -187,15 +189,11 @@ static void amd_pstate_ut_check_perf(u32 index)
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
@@ -206,10 +204,11 @@ static void amd_pstate_ut_check_perf(u32 index)
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
@@ -223,14 +222,14 @@ static void amd_pstate_ut_check_freq(u32 index)
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
@@ -242,20 +241,16 @@ static void amd_pstate_ut_check_freq(u32 index)
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


