Return-Path: <linux-pm+bounces-22509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CC2A3CAE0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1301D170105
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8150D25D528;
	Wed, 19 Feb 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKvBsUwb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA525C711;
	Wed, 19 Feb 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999014; cv=none; b=WvgOYR5vvVIZXhh91pY/jD5hOGI4PoDCvqDOj6BdMlyaCtATWd1Q5+wVn739UrV87hkCjhxVv0U7H6J8S7VZ/3q5yAN3OOWJh0NeWAvLZhyzoxy6EEogyTPO2R8zHDm16DggU/LCKQ2DdHx1GPGoe2CVlll59nJ7ACKW5XZBAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999014; c=relaxed/simple;
	bh=ETSMkzh+U8M9kBaMN6LhmB+rrB4XedydSyvC26hgCLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0d55iW51EjWxfxQn9NPEymUCLo+Jc0YdmS3swvai8XdWVJSrx6NXC5xvTwaRJgh1tMKzjJo+KuNi4gHrvLsSNiubI7Io+t3uh8WcycrBXYt5UxVZMJHNG0cm8DKbzf7kzm7mhkSG31XeBOrgxD51iHicCOLZ+4PWEFxEzz7pd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKvBsUwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0FC4CED1;
	Wed, 19 Feb 2025 21:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999013;
	bh=ETSMkzh+U8M9kBaMN6LhmB+rrB4XedydSyvC26hgCLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKvBsUwbfTrOjt1bvrI5g/AsGrDzv+BRRAuJIKIkZmtWCqLa+7KUK/fu6RyPCWKNf
	 p3CSa8K+FeV6F5ExkeB7++VWeaGig5HszY2j5O+1Kztsyk+1RqbdrPye9ONx3zrCFq
	 2B7Ri61zdtxHohVYappHd8hTOojJnITs0XTZwAcw+KIQuMhG1CS2eIQ27BZn+oYydO
	 1KTBC1id+aTZ+TLuJHxMvkDcJtvaKZFqr8v+kVfLS9LCz5NzH9v2O++1mGWd/UC4ar
	 EFcvBp32xNZvhuOeBl7Qcn+BMc6H3j/lLSCtM0YU9xYZuFPVthudE00xc4mEt4E/uo
	 h8xwDTGKJt7Fg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v4 18/19] cpufreq/amd-pstate: Stop caching EPP
Date: Wed, 19 Feb 2025 15:03:01 -0600
Message-ID: <20250219210302.442954-19-superm1@kernel.org>
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

EPP values are cached in the cpudata structure per CPU. This is needless
though because they are also cached in the CPPC request variable.

Drop the separate cache for EPP values and always reference the CPPC
request variable when needed.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 20 ++++++++++----------
 drivers/cpufreq/amd-pstate.h |  1 -
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f152636cecbeb..408e63aff377a 100644
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
@@ -1195,9 +1194,11 @@ static ssize_t show_energy_performance_preference(
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
@@ -1560,7 +1561,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		epp = 0;
 	else
-		epp = READ_ONCE(cpudata->epp_cached);
+		epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
 	perf = READ_ONCE(cpudata->perf);
 
@@ -1605,7 +1606,6 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
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


