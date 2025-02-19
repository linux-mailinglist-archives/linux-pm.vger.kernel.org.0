Return-Path: <linux-pm+bounces-22498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBBDA3CAD1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB75189C324
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDCE257434;
	Wed, 19 Feb 2025 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqHgJgBH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE9925742C;
	Wed, 19 Feb 2025 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999004; cv=none; b=b45mlKS3/dEebgzrMIZJE0wVUP/AiIPXkhzBE3BtgNTr3kEkbEU9PecRmTU07YlAXgZwXZHKprqkqdXUk84APm5cl6gOWAjJjdL1kEjbOyHW/iNlYnDEP4kBjF5iQP41QPeYZ2xEaF+96upNkxzoKZjeokf1YAyoFM+2/T9EvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999004; c=relaxed/simple;
	bh=aBXnfQs6AuKO3OaYjx1C8aapR23T2MTc3b/J8fq7PC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjCO50wfwK82NTzCjW3Mivv6AKT5zOPepV7D8bcMt4nT8P0ljxHd6Aeoju5iz2og4/6pIpfzxXJ1QKpvGZTzBZAJrRksYC51iEZZJhJ1+m+q8BXcyF8PTmTkeRbkrDDoSfqro1swfaqe2flJY4VS2yLu26bHy0/LIaLgf+WFtH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqHgJgBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A9CC4CEE7;
	Wed, 19 Feb 2025 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999003;
	bh=aBXnfQs6AuKO3OaYjx1C8aapR23T2MTc3b/J8fq7PC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqHgJgBHJn+kNiqYgWvPMxwUOdT6+mmB87jRhwfLOukpp0T6YosImirVUhwhvgOp8
	 WAKrGjrnLZBwOPyDZHHS7LRwT74Zq4gion19Ju6eDY0rSH0Oya9ZGFr3ksq7Mb2nrt
	 XnUu0B63DfZUmp/Rs2q7s+RgnIe+oVroq3lc+eKaxTbCVqFAsQZCD5lCOh+yctGI3p
	 Ue/T46804TqHo4QOhan3kNHJc7oIuBm0ueF94WdG6sXWAjvOe0HuF1r4KBaktStNik
	 J89gSjJc21htTL4diJwgoLowxdgVRs0xh6DzeDGP1bdnTYRn5/x9HLEXConI/KJ0SL
	 l00m7Y69xzIVQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v4 07/19] cpufreq/amd-pstate-ut: Use _free macro to free put policy
Date: Wed, 19 Feb 2025 15:02:50 -0600
Message-ID: <20250219210302.442954-8-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219210302.442954-1-superm1@kernel.org>
References: <20250219210302.442954-1-superm1@kernel.org>
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


