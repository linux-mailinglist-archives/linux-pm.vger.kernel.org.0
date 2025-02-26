Return-Path: <linux-pm+bounces-22967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B779FA45721
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7E6178C40
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED3B280A36;
	Wed, 26 Feb 2025 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kERbFl56"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973BC280A31;
	Wed, 26 Feb 2025 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556201; cv=none; b=C/DsjWPxzBRC8A10/+9b2C2l9MYhhHzU9EkGtpNNF948hZDQA/4qU+yaMDjPTZ1OHAxVmVveISqGmO5gibhhcczJ3CCPbfSk3BK1zsfA60jm2B8cW4MMI9q09wr/5qJCbonp7ku0hK87SAIZJ0sGpmXMW3oWpW2bnsFNJ3q6vjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556201; c=relaxed/simple;
	bh=vtMxuWJwSrrAP3uQZh3pVmPApHmtY5Bfq3fnSMPKSbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1xCS5NaV8mn6YOdaS87c8Md0s8d/wIv9a3YF3gKqk23v5n9Lw93FlaHF5Sif308oFd+v06ymjmZG5DyudIJ3CPqP2KZf5xjUsxl7Mp7yzswCx6JFdQPQztVpnVT8P2gqtHlUq+VCu44+1RwxkSFrFHFBuvTksiBivShWkzce/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kERbFl56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611BFC4CEE2;
	Wed, 26 Feb 2025 07:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556201;
	bh=vtMxuWJwSrrAP3uQZh3pVmPApHmtY5Bfq3fnSMPKSbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kERbFl56Fvdjtamvpt6fPf+wwXpDZwlcUQ6r7jasIOqtt5lmneZLjr+wDUnZQU3V2
	 DXBmK6a6EMCyDPhc9DpIqsV8bbx1dxoC9U1jj/3HJmjhKn036ooYA+3nXC4wVJUJmJ
	 qgV+YB4x0xoajdBWi43tCagm/78EeG8yka9CteNK1Uu675fbTZKt9LSbhCAYDxDlJc
	 2QuUff+sjC3qhCzNqoI5NIcJW4Viqwp3ee8ItUM04MNrH+cH7aLdKDYaz56vJ0YRbH
	 Az+fveL99iUekCXb5Ce6plg8/mwyhkn4XrprH5j8uO+SR6aulWOcimvKrS1pr52BKW
	 2J5GmwajLtlUQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 14/19] cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and *_set_epp functions
Date: Wed, 26 Feb 2025 01:49:29 -0600
Message-ID: <20250226074934.1667721-15-superm1@kernel.org>
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
index 0c686af5e062d..66b61ce124e21 100644
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
@@ -1531,7 +1576,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_req_cached, value);
 	}
-	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
+	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
 	if (ret)
 		return ret;
 
@@ -1572,14 +1617,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
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
 
@@ -1611,20 +1650,12 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
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
@@ -1652,14 +1683,7 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
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


