Return-Path: <linux-pm+bounces-22505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84466A3CADB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA553B2021
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01B25A2CB;
	Wed, 19 Feb 2025 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSoKwyEc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BF25A2BF;
	Wed, 19 Feb 2025 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999010; cv=none; b=s16gcfk51168mE8/Wou49IuaoqD19m+YKSCc2y19PhZ1cfJ2BvZcaaD9TZ2MpXwjlG7mT5yuwLwySYnvhDuejWjWL1UhlNO7hyLmSRq4NX+minB54/fxu5WQKiDrS0mJkYpUxy0G/EU68Yx90FUPFJpID/H57AFTjcaxE0SSkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999010; c=relaxed/simple;
	bh=vOxJ4hXaO/lIGAke3nv/1AqkLy3LazHnoLwRyWWK1UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QS0/ZAOFOtl7L5T3OCubL0jCxQtdxdoCP5lu1nPWMAGjYOTwwwoDbNReC1fwJaXvQ+0kHnxLytUIlx7rExXlzd1Ro+KPVugn3v5ATlF2OaxwDFdrdOanx/O/KLWkQ9ip0iceZ0RNrAuTkO2wPV9qPAcPM4EQSZ1hnc/QEHPzEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSoKwyEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711DFC4CED1;
	Wed, 19 Feb 2025 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999010;
	bh=vOxJ4hXaO/lIGAke3nv/1AqkLy3LazHnoLwRyWWK1UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSoKwyEcEKo+7XqLDsTBq2SYN2VMlnt87pVr/y0rSMfJFUDpnHh6F5EywJn4E2OfB
	 +XAgZExA5RFiqleGC72bAiei0G4iV6muhKbd6yL9teT3ZieJ8VeQ9N+jkqE57RjLOH
	 3QSWPNt3I5iDzYLUoZqyIBWB6d/H6Pm6+UwVHboHrNDHG3L6FybKRZIgXT2PwV8k+P
	 Oux0Hu7VV2TOxmlq152JF2jKDHB/bh4HoavkfBvxvv8x0dZKaOmOE/1zOdX/AWOu8K
	 Z+ZmD/beN1zaSfqtgcqmntwJLAQWC7wEDbxACb2YF0cXYo9tqnBKq6a15euEPzTMzV
	 UHkQz6Qv2Ejqw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v4 14/19] cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and *_set_epp functions
Date: Wed, 19 Feb 2025 15:02:57 -0600
Message-ID: <20250219210302.442954-15-superm1@kernel.org>
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

The EPP tracing is done by the caller today, but this precludes the
information about whether the CPPC request has changed.

Move it into the update_perf and set_epp functions and include information
about whether the request has changed from the last one.
amd_pstate_update_perf() and amd_pstate_set_epp() now require the policy
as an argument instead of the cpudata.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * Drop unused variables
v3:
 * Add tag
 * Update commit message
---
 drivers/cpufreq/amd-pstate-trace.h |  13 +++-
 drivers/cpufreq/amd-pstate.c       | 118 +++++++++++++++++------------
 2 files changed, 80 insertions(+), 51 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
index f457d4af2c62e..32e1bdc588c52 100644
--- a/drivers/cpufreq/amd-pstate-trace.h
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -90,7 +90,8 @@ TRACE_EVENT(amd_pstate_epp_perf,
 		 u8 epp,
 		 u8 min_perf,
 		 u8 max_perf,
-		 bool boost
+		 bool boost,
+		 bool changed
 		 ),
 
 	TP_ARGS(cpu_id,
@@ -98,7 +99,8 @@ TRACE_EVENT(amd_pstate_epp_perf,
 		epp,
 		min_perf,
 		max_perf,
-		boost),
+		boost,
+		changed),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, cpu_id)
@@ -107,6 +109,7 @@ TRACE_EVENT(amd_pstate_epp_perf,
 		__field(u8, min_perf)
 		__field(u8, max_perf)
 		__field(bool, boost)
+		__field(bool, changed)
 		),
 
 	TP_fast_assign(
@@ -116,15 +119,17 @@ TRACE_EVENT(amd_pstate_epp_perf,
 		__entry->min_perf = min_perf;
 		__entry->max_perf = max_perf;
 		__entry->boost = boost;
+		__entry->changed = changed;
 		),
 
-	TP_printk("cpu%u: [%hhu<->%hhu]/%hhu, epp=%hhu, boost=%u",
+	TP_printk("cpu%u: [%hhu<->%hhu]/%hhu, epp=%hhu, boost=%u, changed=%u",
 		  (unsigned int)__entry->cpu_id,
 		  (u8)__entry->min_perf,
 		  (u8)__entry->max_perf,
 		  (u8)__entry->highest_perf,
 		  (u8)__entry->epp,
-		  (bool)__entry->boost
+		  (bool)__entry->boost,
+		  (bool)__entry->changed
 		 )
 );
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4f97c8c104b62..da6c39564c9ea 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -228,9 +228,10 @@ static u8 shmem_get_epp(struct amd_cpudata *cpudata)
 	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, epp);
 }
 
-static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
+static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 			   u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
 	u64 value, prev;
 
 	value = prev = READ_ONCE(cpudata->cppc_req_cached);
@@ -242,6 +243,18 @@ static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
 	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
 	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
 
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		union perf_cached perf = READ_ONCE(cpudata->perf);
+
+		trace_amd_pstate_epp_perf(cpudata->cpu,
+					  perf.highest_perf,
+					  epp,
+					  min_perf,
+					  max_perf,
+					  policy->boost_enabled,
+					  value != prev);
+	}
+
 	if (value == prev)
 		return 0;
 
@@ -256,24 +269,26 @@ static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
 	}
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
-	WRITE_ONCE(cpudata->epp_cached, epp);
+	if (epp != cpudata->epp_cached)
+		WRITE_ONCE(cpudata->epp_cached, epp);
 
 	return 0;
 }
 
 DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
 
-static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
+static inline int amd_pstate_update_perf(struct cpufreq_policy *policy,
 					  u8 min_perf, u8 des_perf,
 					  u8 max_perf, u8 epp,
 					  bool fast_switch)
 {
-	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
+	return static_call(amd_pstate_update_perf)(policy, min_perf, des_perf,
 						   max_perf, epp, fast_switch);
 }
 
-static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
+static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
 	u64 value, prev;
 	int ret;
 
@@ -281,6 +296,19 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
 	value &= ~AMD_CPPC_EPP_PERF_MASK;
 	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
 
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		union perf_cached perf = cpudata->perf;
+
+		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
+					  epp,
+					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
+						    cpudata->cppc_req_cached),
+					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK,
+						    cpudata->cppc_req_cached),
+					  policy->boost_enabled,
+					  value != prev);
+	}
+
 	if (value == prev)
 		return 0;
 
@@ -299,15 +327,29 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
 
 DEFINE_STATIC_CALL(amd_pstate_set_epp, msr_set_epp);
 
-static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u8 epp)
+static inline int amd_pstate_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
-	return static_call(amd_pstate_set_epp)(cpudata, epp);
+	return static_call(amd_pstate_set_epp)(policy, epp);
 }
 
-static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
+static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
-	int ret;
+	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
+	int ret;
+
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		union perf_cached perf = cpudata->perf;
+
+		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
+					  epp,
+					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
+						    cpudata->cppc_req_cached),
+					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK,
+						    cpudata->cppc_req_cached),
+					  policy->boost_enabled,
+					  epp != cpudata->epp_cached);
+	}
 
 	if (epp == cpudata->epp_cached)
 		return 0;
@@ -339,17 +381,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
 		return -EBUSY;
 	}
 
-	if (trace_amd_pstate_epp_perf_enabled()) {
-		union perf_cached perf = READ_ONCE(cpudata->perf);
-
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
-					  epp,
-					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
-					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
-					  policy->boost_enabled);
-	}
-
-	return amd_pstate_set_epp(cpudata, epp);
+	return amd_pstate_set_epp(policy, epp);
 }
 
 static inline int msr_cppc_enable(bool enable)
@@ -492,15 +524,16 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
+static int shmem_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
 	u64 value, prev;
 	int ret;
 
 	if (cppc_state == AMD_PSTATE_ACTIVE) {
-		int ret = shmem_set_epp(cpudata, epp);
+		int ret = shmem_set_epp(policy, epp);
 
 		if (ret)
 			return ret;
@@ -515,6 +548,18 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
 	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
 	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
 
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		union perf_cached perf = READ_ONCE(cpudata->perf);
+
+		trace_amd_pstate_epp_perf(cpudata->cpu,
+					  perf.highest_perf,
+					  epp,
+					  min_perf,
+					  max_perf,
+					  policy->boost_enabled,
+					  value != prev);
+	}
+
 	if (value == prev)
 		return 0;
 
@@ -592,7 +637,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 				cpudata->cpu, fast_switch);
 	}
 
-	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
+	amd_pstate_update_perf(policy, min_perf, des_perf, max_perf, 0, fast_switch);
 }
 
 static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
@@ -1530,7 +1575,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_req_cached, value);
 	}
-	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
+	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
 	if (ret)
 		return ret;
 
@@ -1571,14 +1616,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 		epp = READ_ONCE(cpudata->epp_cached);
 
 	perf = READ_ONCE(cpudata->perf);
-	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf, epp,
-					  perf.min_limit_perf,
-					  perf.max_limit_perf,
-					  policy->boost_enabled);
-	}
 
-	return amd_pstate_update_perf(cpudata, perf.min_limit_perf, 0U,
+	return amd_pstate_update_perf(policy, perf.min_limit_perf, 0U,
 				      perf.max_limit_perf, epp, false);
 }
 
@@ -1610,20 +1649,12 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
 {
-	struct amd_cpudata *cpudata = policy->driver_data;
-	union perf_cached perf = READ_ONCE(cpudata->perf);
 	int ret;
 
 	ret = amd_pstate_cppc_enable(true);
 	if (ret)
 		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
 
-	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
-					  cpudata->epp_cached,
-					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
-					  perf.highest_perf, policy->boost_enabled);
-	}
 
 	return amd_pstate_epp_update_limit(policy);
 }
@@ -1651,14 +1682,7 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	if (cpudata->suspended)
 		return 0;
 
-	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
-					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
-					  perf.lowest_perf, perf.lowest_perf,
-					  policy->boost_enabled);
-	}
-
-	return amd_pstate_update_perf(cpudata, perf.lowest_perf, 0, perf.lowest_perf,
+	return amd_pstate_update_perf(policy, perf.lowest_perf, 0, perf.lowest_perf,
 				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
 }
 
-- 
2.43.0


