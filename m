Return-Path: <linux-pm+bounces-21518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BBA2B490
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BE01886A22
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C56323C363;
	Thu,  6 Feb 2025 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbrE3SW/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74338239073;
	Thu,  6 Feb 2025 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879050; cv=none; b=E0Bg8deGhxJx3MLKn/V/UMT99LGJRfCnDZpxGgYk1oRp2+66VYwc9KCBMARrqDTlSXQTZcWW79L7Oo4HLG2MdhoQfubbW2TbCHTIfMmUXN9Ce6odEM47Nxkki+vKFcChUHp4up40G2V8q9o0/npfTlFMo7oyvH1v6v54eCBISUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879050; c=relaxed/simple;
	bh=yIcIWxMCnVhrCupZDwm9Xp9HA/NW0ZMVV/DWEg+1D0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=En6IqnODpR2yWyqmtcReqvFSGlhGp3dUp+oFswW26z14YMmUmnHEA+kBbhmIhf0pOkydVE0U0OYRtmeJ/eKeBVk5sF0S4SJglwl9TYn3Ac9H8sRbkHwavX/Bd/WcIsfbpHnk81Y2oGH2pubf748BL91HB5r15RfBPdugX8gk0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbrE3SW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E99C4CEDF;
	Thu,  6 Feb 2025 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879049;
	bh=yIcIWxMCnVhrCupZDwm9Xp9HA/NW0ZMVV/DWEg+1D0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbrE3SW/TRK5Qe77Wd3tcJI3FjIlf+Dx4AvwR9MKr6gDvTHr/sujHxRNrbEx9dAvm
	 NuFeV0ovHIMmpLIIcpb+ZTVjJkSLeh2x9igzz6Bf/ATc55LnieF1Ey9ostL9zY9dhs
	 9vtsAOLEWKHkRTIYluHBF/oUNeDvotHLRJqzeB+6ZixK55WXyiHLa3squIV58PKbBZ
	 wVJAeZ1FCPthXJWCyuvlNg9WeWUoy7cXcr4l+gBko47vg4HmBULxhTZa966nlve+t1
	 UHG8//gnsbkTROqNos0jSYj8qi+WNvgVdWklDgWUkVl9LW3opr94m603CBuqgGgtoY
	 c5YOsD2i3AEtA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 14/14] cpufreq/amd-pstate: Stop caching EPP
Date: Thu,  6 Feb 2025 15:56:59 -0600
Message-ID: <20250206215659.3350066-15-superm1@kernel.org>
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

EPP values are cached in the cpudata structure per CPU. This is needless
though because they are also cached in the CPPC request variable.

Drop the separate cache for EPP values and always reference the CPPC
request variable when needed.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 30 ++++++++++++++++--------------
 drivers/cpufreq/amd-pstate.h |  1 -
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 697fa1b80cf24..38e5e925a7aed 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -268,8 +268,6 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 	}
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
-	if (epp != cpudata->epp_cached)
-		WRITE_ONCE(cpudata->epp_cached, epp);
 
 	return 0;
 }
@@ -320,7 +318,6 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
 	}
 
 	/* update both so that msr_update_perf() can effectively check */
-	WRITE_ONCE(cpudata->epp_cached, epp);
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	return ret;
@@ -337,11 +334,14 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
+	u8 epp_cached;
 	u64 value;
 	int ret;
 
 	lockdep_assert_held(&cpudata->lock);
 
+	epp_cached = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
+
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = cpudata->perf;
 
@@ -352,10 +352,10 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
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
@@ -364,7 +364,6 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 		pr_debug("failed to set energy perf value (%d)\n", ret);
 		return ret;
 	}
-	WRITE_ONCE(cpudata->epp_cached, epp);
 
 	value = READ_ONCE(cpudata->cppc_req_cached);
 	value &= ~AMD_CPPC_EPP_PERF_MASK;
@@ -1218,9 +1217,11 @@ static ssize_t show_energy_performance_preference(
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
@@ -1588,7 +1589,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
 		epp = 0;
 	else
-		epp = READ_ONCE(cpudata->epp_cached);
+		epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
 	perf = READ_ONCE(cpudata->perf);
 
@@ -1624,23 +1625,24 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = cpudata->perf;
 	int ret;
+	u8 epp;
+
+	guard(mutex)(&cpudata->lock);
+
+	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
 	ret = amd_pstate_cppc_enable(policy);
 	if (ret)
 		return ret;
-
-	guard(mutex)(&cpudata->lock);
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
index 16ce631a6c3d5..c95b4081a3ff6 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -100,7 +100,6 @@ struct amd_cpudata {
 	struct cpufreq_policy *policy;
 
 	/* EPP feature related attributes*/
-	u8	epp_cached;
 	bool	suspended;
 	u8	epp_default;
 };
-- 
2.43.0


