Return-Path: <linux-pm+bounces-22971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99846A45732
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00E218980CB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453EF1E1E05;
	Wed, 26 Feb 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKWZX3Fd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD831E1DFE;
	Wed, 26 Feb 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556207; cv=none; b=kTCsr+2V5TSw3OoAoDLSHrED3FJlRYD3OHYQEOFPWe51NVVT3fE00MU4nabUGbJ0dO8ija3Rr8t8OFCnFAcJT1IX5yXHKGyS/KBqHj3aAZsT3SAc71e+xUn+SOWyqUav7XCwefGfZShjLSUnC76Wvqeknx3qZQy7Zl2cW4aN9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556207; c=relaxed/simple;
	bh=tHMEHdR9gJv1rEz04S9UOsdOOKCypTfDr177SyS3vic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJw2VoVz3tLQahjKExzD+WBPXFECq+7XJjRSaP0db9MuPZH6pvAXLUOHhNhp78LCVTFPF2qg4gkAcTMdmdHH/9apAforyqQkzhtzwAQkbY4R2rB77U5HB9e2LDQc3kgkvRgiYb5NuQr+6boNgucSwkzIxMo70jzceSBx0LwJijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKWZX3Fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD43C4CEEB;
	Wed, 26 Feb 2025 07:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556206;
	bh=tHMEHdR9gJv1rEz04S9UOsdOOKCypTfDr177SyS3vic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKWZX3FdOUzIRyYwncNihTYlaHP0SFukViM885w6/rNBCgx8VV7lnL4bAJaX9IZEa
	 8N9g6ZAJV77z6ea9x6trDL6iMHjMla0lXodED3DuQB+r72gyA4wCDMd8Rkm6wHtZ8T
	 8whKH9UslXE8BL5KthstMA7Ee9PPhUvZ762iJSjZGnMrhPT+J2WglR+n4YGxIvpwYn
	 ihgkAZ5zOis7XqXkr7NLRG77Ij/0meHjL92sjvFf/NWnlFTp/S2+sdgHGkrtqTPk1Q
	 219MAaJudsSS34yZ5/lTLcTpZ9b8CngxBpm5GVAT/4T0Aw/6DbtlgBrCGR9JJM0M/W
	 eW459rczexgdQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 18/19] cpufreq/amd-pstate: Stop caching EPP
Date: Wed, 26 Feb 2025 01:49:33 -0600
Message-ID: <20250226074934.1667721-19-superm1@kernel.org>
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

EPP values are cached in the cpudata structure per CPU. This is needless
though because they are also cached in the CPPC request variable.

Drop the separate cache for EPP values and always reference the CPPC
request variable when needed.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Rebase on earlier patch changes
---
 drivers/cpufreq/amd-pstate.c | 19 ++++++++++---------
 drivers/cpufreq/amd-pstate.h |  1 -
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 89e6d32223c9b..24a1f9e129b61 100644
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
@@ -1174,9 +1173,11 @@ static ssize_t show_energy_performance_preference(
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
@@ -1539,7 +1540,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		epp = 0;
 	else
-		epp = READ_ONCE(cpudata->epp_cached);
+		epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
 	perf = READ_ONCE(cpudata->perf);
 
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 1557e1afea79c..fbe1c08d3f061 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -102,7 +102,6 @@ struct amd_cpudata {
 	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
-	u8	epp_cached;
 	u32	policy;
 	bool	suspended;
 	u8	epp_default;
-- 
2.43.0


