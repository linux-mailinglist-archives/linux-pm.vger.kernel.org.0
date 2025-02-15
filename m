Return-Path: <linux-pm+bounces-22127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4383A36A29
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3303B1249
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1411624E1;
	Sat, 15 Feb 2025 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGzqzaMx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1611624D5;
	Sat, 15 Feb 2025 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580782; cv=none; b=sRlLiYQBU2reBsQdznZaPHt6cOfMjzhlbFgh+cCRQreFlnz5DV3ja9G8cvoXTanDpa6WN8DWsIDsi3NV99hTQ4rJILIUwGqkkhikUiJppjgjVG4Z0nSUXGp6C2SgOiG8xVvpWoiiBKudyAPBZdi88mwBz0RcIZleY2c9ci8R2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580782; c=relaxed/simple;
	bh=7kCU3HruIC3kBA94IIkD6K1Qepj9gnh6hUKZyrIUzxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx/4iapqx1PFEAt+lh2ypyStU91pS6dZgtlRYz5IDXtvHg9vp7nQXH6Fu//p5nFVacOa9otj+14Q8gV726+NFKFDJDBnJULkpWrMNtGzJpDLViRR8tKFGO3Ve97al77A0Uah1eNm26no2aacNdInsf85nxmrDysW3ojuX4J156s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGzqzaMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DE7C4AF09;
	Sat, 15 Feb 2025 00:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580782;
	bh=7kCU3HruIC3kBA94IIkD6K1Qepj9gnh6hUKZyrIUzxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGzqzaMxVKhmG4ge8jffmDjTnMzBh6d9Mqsme6GZ0WddaUVeMwAUTVDCXHgf3N7c4
	 wFhc66IS19G2grpGZ8oWZpUOKQc/a7+Z8Wyc2qoJbxdjLj5m+acYj11Okau20YljIk
	 /QOch30idXcC8P9VLg3SDOAsDpPtNBv9OuPXOFINqnFqaaKCabUbV6lyNlY7Rw4Gjx
	 W2qtqRlBaEMGsfV6XuwukcFfR8ySUOyg0WEHyVh0p1HHlDTKHsFetFeNhW1FPuRzS/
	 NtEVgcdRylSTgJCwjxBbSxF8R4pLJZFzCIpKZSZTTUSz9MVqRldMpW4AlzPjg92PhW
	 W/RXsIonmkIyA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 06/17] cpufreq/amd-pstate-ut: Use _free macro to free put policy
Date: Fri, 14 Feb 2025 18:52:33 -0600
Message-ID: <20250215005244.1212285-7-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005244.1212285-1-superm1@kernel.org>
References: <20250215005244.1212285-1-superm1@kernel.org>
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


