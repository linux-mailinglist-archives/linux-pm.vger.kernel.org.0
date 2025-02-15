Return-Path: <linux-pm+bounces-22134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B41BA36A46
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3561713F9
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED441A2393;
	Sat, 15 Feb 2025 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGO9fGJv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF61A0BFE;
	Sat, 15 Feb 2025 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580789; cv=none; b=a1w3/27fjENHwKN4lwR+vZhTBDNz8+wTpgJxH/WakrsRc7aPJSLrvFLbbmO5qQypte5/tNCAs5knDB+wWjnuG8qkDMt5RUuBDmn76almjwrIQUBwB/BaYx3g0UE1RLiuTi+h1gW41BEjJRnMCeofsKLrM2pGAxET+s06Qzzl3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580789; c=relaxed/simple;
	bh=xa5s+b3CD92mIAYIux4N48yI34NMBpkHGHebglRhq8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2Tp8dgvarKidt351Ks76Qmah/DaSybFrNYrY9RU31Th6t3UqF/MHTqF4ySNJV3xJQl1RJoCYFCuh/qWN5AMEsAuT+VZ2wL2Wm+gJrDMU5GkgNS/sYAU6EaRVWLVKlA90aj7/uEpP0e1HXDsZNfB1IRopd410Gm/aAAaKt8I7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGO9fGJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BF6C4CEE6;
	Sat, 15 Feb 2025 00:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580789;
	bh=xa5s+b3CD92mIAYIux4N48yI34NMBpkHGHebglRhq8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGO9fGJvTB39HZ/02QpQD+JIOyYIRy+lX2zlYmSS33BBBjmq809VzPC6q4mwsOlE6
	 B6BOdkG6xLp2Dol1pfjf4Y3nQCSQCyJHg5PvyTQUpfGF7jkzaSyjABMD0O7mdfSUvl
	 SM2v9Lpe9xPu4MqIlJHODktG2LG9SmRUU6fMMGt838Jzst5TSYsWWkHN9BYRBovyWa
	 gyIikQna8IDVaP53yNWM7wUPGrdh+nWuBu/8Z0TB5GFwkvzXO6e3l/mOkHfESwchmr
	 a+JOZcNeOXij5NhzuFlXikza9ZqtElnvKPnPm4ONlupZG4BiOY5GPZB8agMLuZrELF
	 6YZtkyrINvUpg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 13/17] cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and *_set_epp functions
Date: Fri, 14 Feb 2025 18:52:40 -0600
Message-ID: <20250215005244.1212285-14-superm1@kernel.org>
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

The EPP tracing is done by the caller today, but this precludes the
information about whether the CPPC request has changed.

Move it into the update_perf and set_epp functions and include information
about whether the request has changed from the last one.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-trace.h |  13 +++-
 drivers/cpufreq/amd-pstate.c       | 119 +++++++++++++++++------------
 2 files changed, 81 insertions(+), 51 deletions(-)

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
index 9517da9b7e692..1304bdc23e809 100644
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
@@ -1527,7 +1572,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_req_cached, value);
 	}
-	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
+	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
 	if (ret)
 		return ret;
 
@@ -1568,14 +1613,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
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
 
@@ -1615,14 +1654,7 @@ static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
 	if (ret)
 		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
 
-	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
-					  cpudata->epp_cached,
-					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
-					  perf.highest_perf, policy->boost_enabled);
-	}
-
-	return amd_pstate_update_perf(cpudata, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
+	return amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
 }
 
 static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
@@ -1648,14 +1680,7 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
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


