Return-Path: <linux-pm+bounces-22279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB5A38ECF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1981893648
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5041DED44;
	Mon, 17 Feb 2025 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyfw1v0y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CE01C6FED;
	Mon, 17 Feb 2025 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830067; cv=none; b=SdNZMk1tHdtqWxuw6e49iN3aPL/6+fMyYZF5PGl461bMMVJKVMOMjLVyHL4LXBvN1Zz5VI5NGfpyTtuqgfTIjmL4Vn0EPtFkikQdv9GduMlxE9kZGY8cuI12Aq92tHcRj1FaGUxxe+hOSFX3O0ghnTycaQMUHzT7a2IOp0P0bPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830067; c=relaxed/simple;
	bh=8b/C2Z5XXeeSbxzKyUe0eHPJYIACJogJ2mylDT5u0Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWGvffEsHxJFsmQYIwhOgfD9V8ktNCZFlMe41rdHTXepHQtuy5wHMeYDGdO6f8IqVyQ6xUFJcCmtKRgTwGy9Sudlki6BCwBh8BljGaKfNXBu7qBbcXz4Uu0Z42wBqzYgWFjAlJjZuQwAdmlFrpmozH19p+olZOULh3nHmvnW0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyfw1v0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE14DC4CEE4;
	Mon, 17 Feb 2025 22:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830067;
	bh=8b/C2Z5XXeeSbxzKyUe0eHPJYIACJogJ2mylDT5u0Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyfw1v0yDCJHrlapQvFxBq42I5zIyvZ5OYRxg45Cw9LW4sMrJtxlQNjPuK8vp7ZSO
	 /n3K9cIUXGCCNODNxFJAV4r4BHiDi0b+ROnBP5mw03Ma0PUKBnJIhh/quY0qSIc3Ef
	 oi8xoHk3PG9e+UVB/1W2QEep9HMq5dnkz2E7u3qLYMarmqBmRVBXU2omvKZQI3FzKw
	 RV77REveu04WUX0VT+UUnWcGo0LtizHwHa5uWXmdts3Q/bEXv8vmlcOQKBL+vNSKrQ
	 rbHXdC43wAMs+BNPSx9XFo2j6nUpiMUZdobRBIBchpvDyVFPxEyjAxISNhab+nbMRM
	 prtfvYde7gaHw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 14/18] cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and *_set_epp functions
Date: Mon, 17 Feb 2025 16:07:03 -0600
Message-ID: <20250217220707.1468365-15-superm1@kernel.org>
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
v3:
 * Add tag
 * Update commit message
---
 drivers/cpufreq/amd-pstate-trace.h |  13 +++-
 drivers/cpufreq/amd-pstate.c       | 116 ++++++++++++++++++-----------
 2 files changed, 80 insertions(+), 49 deletions(-)

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
index 4eb3ba6dfdbd9..eb54960f313be 100644
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
@@ -1528,7 +1573,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_req_cached, value);
 	}
-	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
+	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
 	if (ret)
 		return ret;
 
@@ -1569,14 +1614,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
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
 
@@ -1616,12 +1655,6 @@ static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
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
@@ -1649,14 +1682,7 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
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


