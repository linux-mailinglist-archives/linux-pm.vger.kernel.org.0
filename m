Return-Path: <linux-pm+bounces-22283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B94CA38EDA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5641892CAC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279881C7001;
	Mon, 17 Feb 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISTODcCf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37111DFE0C;
	Mon, 17 Feb 2025 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830072; cv=none; b=usOiig4xn6l0Zfm6sc5TqZG7gezWBKyy1V0vo6ouZ9EpvHmS9yBQdbdDg6Ysw4LX01TMhMDxnwGgCG/gGOEb2tLGCfZPHE1xEvPtkaUStTKUZMNAK1MH39HI/OQFkYYZj8Nr1iVfW3kBBF6nQPnXxzCo9d0sd11GaXzkdkirvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830072; c=relaxed/simple;
	bh=4+EsuSMFzTIZV2rxHQ6HUvxk96Xy8TbFkE5Q3qjs4jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVyhd8/qZLgW9YBBRshyzEhu7wjQmNpNmHdZqRiGryA35zjNIbYRAl2KLbykmpPANmFUyPUeV0QbXSZocn3WEpuOx+edO1On3SEIVsJGnzL2w0zd0LcvlvBeAj0C7N/xBMxgZRb8lCDQMol/abKYiate1/DfyoWzeyu/3ODoRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISTODcCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B717DC4CEE2;
	Mon, 17 Feb 2025 22:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830071;
	bh=4+EsuSMFzTIZV2rxHQ6HUvxk96Xy8TbFkE5Q3qjs4jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISTODcCfT3+LXIpktjC4BHK0QpysWBO1ZrlTYxBnFi3+Q9kjYi05Z5uDkz66MgJAs
	 LVwH5vJ+4PezW6S3p2Yukqr8g45Gq4wghqDiT3M7S1743ptkL2vENSakipKBfUfntL
	 unqGuWfMF5fB96czgT3nNGd8TeWctPET9UFPJTwYC6CtIg+IU5MGQklAKrFw4PR5F0
	 QuIQwz4TZwfZIh5SOvNYzUjKZ6s/7Sdhap2FBkO/WG1rJRc4y9Z9t0vOxD25Dp+tvv
	 XoTxCWkqU9DYXgxuY1zamQ2XeTwTHigPDVH6UmhSFD96yEK/fIO/6qspxsDtqJRaCu
	 7UG49967Ku9QA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 18/18] cpufreq/amd-pstate: Stop caching EPP
Date: Mon, 17 Feb 2025 16:07:07 -0600
Message-ID: <20250217220707.1468365-19-superm1@kernel.org>
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

EPP values are cached in the cpudata structure per CPU. This is needless
though because they are also cached in the CPPC request variable.

Drop the separate cache for EPP values and always reference the CPPC
request variable when needed.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 27 ++++++++++++++-------------
 drivers/cpufreq/amd-pstate.h |  1 -
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4660dd3f04796..48ec5e6527c68 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -268,8 +268,6 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 	}
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
-	if (epp != cpudata->epp_cached)
-		WRITE_ONCE(cpudata->epp_cached, epp);
 
 	return 0;
 }
@@ -318,7 +316,6 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
 	}
 
 	/* update both so that msr_update_perf() can effectively check */
-	WRITE_ONCE(cpudata->epp_cached, epp);
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	return ret;
@@ -335,9 +332,12 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
+	u8 epp_cached;
 	u64 value;
 	int ret;
 
+
+	epp_cached = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = cpudata->perf;
 
@@ -348,10 +348,10 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK,
 						    cpudata->cppc_req_cached),
 					  policy->boost_enabled,
-					  epp != cpudata->epp_cached);
+					  epp != epp_cached);
 	}
 
-	if (epp == cpudata->epp_cached)
+	if (epp == epp_cached)
 		return 0;
 
 	perf_ctrls.energy_perf = epp;
@@ -360,7 +360,6 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 		pr_debug("failed to set energy perf value (%d)\n", ret);
 		return ret;
 	}
-	WRITE_ONCE(cpudata->epp_cached, epp);
 
 	value = READ_ONCE(cpudata->cppc_req_cached);
 	value &= ~AMD_CPPC_EPP_PERF_MASK;
@@ -1203,9 +1202,11 @@ static ssize_t show_energy_performance_preference(
 				struct cpufreq_policy *policy, char *buf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u8 preference;
+	u8 preference, epp;
+
+	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
-	switch (cpudata->epp_cached) {
+	switch (epp) {
 	case AMD_CPPC_EPP_PERFORMANCE:
 		preference = EPP_INDEX_PERFORMANCE;
 		break;
@@ -1568,7 +1569,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		epp = 0;
 	else
-		epp = READ_ONCE(cpudata->epp_cached);
+		epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
 	perf = READ_ONCE(cpudata->perf);
 
@@ -1604,22 +1605,22 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	int ret;
+	u8 epp;
+
+	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
 	ret = amd_pstate_cppc_enable(policy);
 	if (ret)
 		return ret;
-
-
-	ret = amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
+	ret = amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, epp, false);
 	if (ret)
 		return ret;
 
 	cpudata->suspended = false;
 
 	return 0;
-
 }
 
 static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 1a52582dbac9d..13918853f0a82 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -100,7 +100,6 @@ struct amd_cpudata {
 	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
-	u8	epp_cached;
 	u32	policy;
 	bool	suspended;
 	u8	epp_default;
-- 
2.43.0


