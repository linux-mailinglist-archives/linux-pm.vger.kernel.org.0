Return-Path: <linux-pm+bounces-22138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FECA36A42
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89F118921E8
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9BF1AB531;
	Sat, 15 Feb 2025 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/yWif4G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E81AAA1A;
	Sat, 15 Feb 2025 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580793; cv=none; b=csNwCEwioayYvHDgjgPgxgIRVkg2QCZRNDn/BYfW4A1c6gVF8Tz7IZIYP35ymsTqCVHMiu5YtxxCT0wxvfyrRJ7tqtZfsRPP7sawmSuQ6hUg57ab23EL8UAjteP/qI9rx0dUJMPXjhsVBh8QTuqYcg+LAi78ewkt3fPtWgfmlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580793; c=relaxed/simple;
	bh=TSSw9OFmPPLgUn+9ZNp1J6vfcAnCljMBOaiSYDvNWdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkmy7Cv+GYpe+Be4FRj4NgiM+VehN5G7l0QwcIeE4wW7sf+uXbqplrLQjytG2OLaGD7syTc2Ap8NFz20wZgKdfjj2Swg1JtQWdBU+eQXC0xvE/295HFcqqcPAYZBOKZd2FMHTdRkOOEL0UhYuqSh2SyNaWhzL0NWgxuwdb++U6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/yWif4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43D5C4CEE2;
	Sat, 15 Feb 2025 00:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580793;
	bh=TSSw9OFmPPLgUn+9ZNp1J6vfcAnCljMBOaiSYDvNWdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/yWif4G8cAb9NXF4TEECa+56T5Z/rCtN1a1Aw1pKbwcZ/aXNBd3MYUyiDQCepno0
	 P50UBKNIli1Nz7rwm8l2bAb99ODKQMmBm+KxQht50sZqqVpp64FlZT0jPdKOCaLfCt
	 6u1a6YqrgunYtnpJy+MnR1upEjVvqioFcGluGXRCbr3G5l0JX7nwcTorJFz0bAik+h
	 UVSOwtr95rpKtRLzlrvsWXKXXllLzc6HKDykB3HEcGrVug6OJjTcPBuIr18EDMhHvD
	 To9kLkW634b+nE1CWoFWMBERXYvIXsQAj1M/sYTuyv2xW6uqQ0sBDiD1nDiNV3wgy2
	 JOatGUgK1JIGA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 17/17] cpufreq/amd-pstate: Stop caching EPP
Date: Fri, 14 Feb 2025 18:52:44 -0600
Message-ID: <20250215005244.1212285-18-superm1@kernel.org>
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
index 1117dd4a6addd..aafd765c43f30 100644
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
@@ -1202,9 +1201,11 @@ static ssize_t show_energy_performance_preference(
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
@@ -1567,7 +1568,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		epp = 0;
 	else
-		epp = READ_ONCE(cpudata->epp_cached);
+		epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
 	perf = READ_ONCE(cpudata->perf);
 
@@ -1603,22 +1604,22 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
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


