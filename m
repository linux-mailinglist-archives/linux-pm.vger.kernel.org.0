Return-Path: <linux-pm+bounces-22957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97457A4570B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2F93A2B2D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210DE26FDB4;
	Wed, 26 Feb 2025 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSJeAkDe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96C26FDA9;
	Wed, 26 Feb 2025 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556188; cv=none; b=jpwr/WInhCWt5ug/BCfYbeZkNg+p/jSBs7CFO4Yn4nAv2YGBJilG9TGYVTdxELBxQWooPD3X0NUU9Eluflzry+kDib5VQu6EyhBCixY3/pKEkb+MOnohijs1fWtEp+Iziop4tcstNpCNRoqmBG0+24DBaZhNR2K7j+WoScgL3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556188; c=relaxed/simple;
	bh=h78Ff6bcEkgsh6uZSEShBWTdWNLqpuXsX+Fu1wUedHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSmLYbOKkPjYPPcWUzcp8Vl3HWRwYX9TwZm2H7eDdV8cyc5zYkf3V9qKlnaeltQGhpNYblYUm3LHJ5faBt+OtQ74CyKB6jDc5det1K/AGW7EGKIH8bYo0oCvAZAx7ghQIQsoq8dSkWoWLLAeL4MVz1ScxyxP/UTXfdvfAD5c3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSJeAkDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78848C4CEEC;
	Wed, 26 Feb 2025 07:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556187;
	bh=h78Ff6bcEkgsh6uZSEShBWTdWNLqpuXsX+Fu1wUedHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSJeAkDeUcROL++6WYqh5vCh1Tqc1Ia20KjokfBMs9N3Tqs41puUpIheyTw8WsNZ5
	 gBos1iXwXYZDy9x43T+DSgpRcnrUjVracsDpA+lWT7SBRob1PMYs7Mbdr/f2lm1uyf
	 sOQEcWNsb67jojqLEjkZFbVx1ceDRFkda/x3H/ifS1vv6e6ycD+qdmOk0XKdMUSqSh
	 gVjKdqNj8qkoIn1QsYdZA2PSj2YXI2+uQS4vpBzxd5fJQ0LxPwO0tugIcvXj7OI+uy
	 QCBqp0sj6TCrzAQGK7JzLGhgjEd9voOC8mPuSP29Ss7M8XMVdFEpj98QFFfoQoqAK/
	 tN1RcI7gdLDog==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 04/19] cpufreq/amd-pstate: Move perf values into a union
Date: Wed, 26 Feb 2025 01:49:19 -0600
Message-ID: <20250226074934.1667721-5-superm1@kernel.org>
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

By storing perf values in a union all the writes and reads can
be done atomically, removing the need for some concurrency protections.

While making this change, also drop the cached frequency values,
using inline helpers to calculate them on demand from perf value.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Use suggestion for union docstring
 * Flush out for quirk case
 * Use perf variable in unit test
v4:
 * Rebase on earlier changes
v3:
 * Pick up tag
v2:
 * cache perf variable in unit tests
 * Drop unnecessary check from amd_pstate_update_min_max_limit()
 * Consistency with READ_ONCE()
 * Drop unneeded policy checks
 * add kdoc
---
 drivers/cpufreq/amd-pstate-ut.c |  18 +--
 drivers/cpufreq/amd-pstate.c    | 205 ++++++++++++++++++--------------
 drivers/cpufreq/amd-pstate.h    |  51 +++++---
 3 files changed, 158 insertions(+), 116 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 445278cf40b61..5f6a92a816e61 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -129,6 +129,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 	struct cppc_perf_caps cppc_perf;
 	struct cpufreq_policy *policy = NULL;
 	struct amd_cpudata *cpudata = NULL;
+	union perf_cached cur_perf;
 
 	for_each_possible_cpu(cpu) {
 		policy = cpufreq_cpu_get(cpu);
@@ -162,19 +163,20 @@ static void amd_pstate_ut_check_perf(u32 index)
 			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
 		}
 
-		if (highest_perf != READ_ONCE(cpudata->highest_perf) && !cpudata->hw_prefcore) {
+		cur_perf = READ_ONCE(cpudata->perf);
+		if (highest_perf != cur_perf.highest_perf && !cpudata->hw_prefcore) {
 			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
-				__func__, cpu, highest_perf, cpudata->highest_perf);
+				__func__, cpu, highest_perf, cur_perf.highest_perf);
 			goto skip_test;
 		}
-		if ((nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
-			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
-			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
+		if (nominal_perf != cur_perf.nominal_perf ||
+		   (lowest_nonlinear_perf != cur_perf.lowest_nonlinear_perf) ||
+		   (lowest_perf != cur_perf.lowest_perf)) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
-				__func__, cpu, nominal_perf, cpudata->nominal_perf,
-				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
-				lowest_perf, cpudata->lowest_perf);
+				__func__, cpu, nominal_perf, cur_perf.nominal_perf,
+				lowest_nonlinear_perf, cur_perf.lowest_nonlinear_perf,
+				lowest_perf, cur_perf.lowest_perf);
 			goto skip_test;
 		}
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fb28b27558882..bd8bcda4e6eb0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -142,18 +142,17 @@ static struct quirk_entry quirk_amd_7k62 = {
 	.lowest_freq = 550,
 };
 
-static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
+static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
 {
-	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
-					cpudata->nominal_freq);
+	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
 
-	return (u8)clamp(perf_val, cpudata->lowest_perf, cpudata->highest_perf);
+	return (u8)clamp(perf_val, perf.lowest_perf, perf.highest_perf);
 }
 
-static inline u32 perf_to_freq(struct amd_cpudata *cpudata, u8 perf_val)
+static inline u32 perf_to_freq(union perf_cached perf, u32 nominal_freq, u8 perf_val)
 {
-	return DIV_ROUND_UP_ULL((u64)cpudata->nominal_freq * perf_val,
-				cpudata->nominal_perf);
+	return DIV_ROUND_UP_ULL((u64)nominal_freq * perf_val,
+				perf.nominal_perf);
 }
 
 static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
@@ -347,7 +346,9 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
 	}
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
+		union perf_cached perf = READ_ONCE(cpudata->perf);
+
+		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  epp,
 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
 					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
@@ -425,6 +426,7 @@ static inline int amd_pstate_cppc_enable(bool enable)
 
 static int msr_init_perf(struct amd_cpudata *cpudata)
 {
+	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 cap1, numerator;
 
 	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
@@ -436,19 +438,21 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	WRITE_ONCE(cpudata->highest_perf, numerator);
-	WRITE_ONCE(cpudata->max_limit_perf, numerator);
-	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
-	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
-	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
+	perf.highest_perf = numerator;
+	perf.max_limit_perf = numerator;
+	perf.min_limit_perf = AMD_CPPC_LOWEST_PERF(cap1);
+	perf.nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
+	perf.lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
+	perf.lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
+	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
-	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
 	return 0;
 }
 
 static int shmem_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 numerator;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
@@ -459,14 +463,14 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	WRITE_ONCE(cpudata->highest_perf, numerator);
-	WRITE_ONCE(cpudata->max_limit_perf, numerator);
-	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
-	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
-		   cppc_perf.lowest_nonlinear_perf);
-	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	perf.highest_perf = numerator;
+	perf.max_limit_perf = numerator;
+	perf.min_limit_perf = cppc_perf.lowest_perf;
+	perf.nominal_perf = cppc_perf.nominal_perf;
+	perf.lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
+	perf.lowest_perf = cppc_perf.lowest_perf;
+	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
-	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -549,14 +553,14 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
 {
 	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
-	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	union perf_cached perf = READ_ONCE(cpudata->perf);
 
 	if (!policy)
 		return;
 
 	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
 
-	policy->cur = perf_to_freq(cpudata, des_perf);
+	policy->cur = perf_to_freq(perf, cpudata->nominal_freq, des_perf);
 
 	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
 		min_perf = des_perf;
@@ -565,7 +569,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 
 	/* limit the max perf when core performance boost feature is disabled */
 	if (!cpudata->boost_supported)
-		max_perf = min_t(u8, nominal_perf, max_perf);
+		max_perf = min_t(u8, perf.nominal_perf, max_perf);
 
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
 		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
@@ -602,39 +606,41 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 	return 0;
 }
 
-static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
+static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u8 max_limit_perf, min_limit_perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
 
-	max_limit_perf = freq_to_perf(cpudata, policy->max);
-	min_limit_perf = freq_to_perf(cpudata, policy->min);
+	perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
+	perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
+		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
 
-	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
-	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
 	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
 	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
-
-	return 0;
+	WRITE_ONCE(cpudata->perf, perf);
 }
 
 static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 				  unsigned int target_freq, bool fast_switch)
 {
 	struct cpufreq_freqs freqs;
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
+	union perf_cached perf;
 	u8 des_perf;
 
+	cpudata = policy->driver_data;
+
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
 
+	perf = READ_ONCE(cpudata->perf);
+
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
-	des_perf = freq_to_perf(cpudata, target_freq);
+	des_perf = freq_to_perf(perf, cpudata->nominal_freq, target_freq);
 
 	WARN_ON(fast_switch && !policy->fast_switch_enabled);
 	/*
@@ -645,8 +651,8 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 	if (!fast_switch)
 		cpufreq_freq_transition_begin(policy, &freqs);
 
-	amd_pstate_update(cpudata, cpudata->min_limit_perf, des_perf,
-			  cpudata->max_limit_perf, fast_switch,
+	amd_pstate_update(cpudata, perf.min_limit_perf, des_perf,
+			  perf.max_limit_perf, fast_switch,
 			  policy->governor->flags);
 
 	if (!fast_switch)
@@ -675,9 +681,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long target_perf,
 				   unsigned long capacity)
 {
-	u8 max_perf, min_perf, des_perf, cap_perf, min_limit_perf;
+	u8 max_perf, min_perf, des_perf, cap_perf;
 	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata;
+	union perf_cached perf;
 
 	if (!policy)
 		return;
@@ -687,8 +694,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
 
-	cap_perf = READ_ONCE(cpudata->highest_perf);
-	min_limit_perf = READ_ONCE(cpudata->min_limit_perf);
+	perf = READ_ONCE(cpudata->perf);
+	cap_perf = perf.highest_perf;
 
 	des_perf = cap_perf;
 	if (target_perf < capacity)
@@ -699,10 +706,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	else
 		min_perf = cap_perf;
 
-	if (min_perf < min_limit_perf)
-		min_perf = min_limit_perf;
+	if (min_perf < perf.min_limit_perf)
+		min_perf = perf.min_limit_perf;
 
-	max_perf = cpudata->max_limit_perf;
+	max_perf = perf.max_limit_perf;
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
@@ -713,11 +720,12 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u32 nominal_freq, max_freq;
 	int ret = 0;
 
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	max_freq = perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf));
+	max_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
 
 	if (on)
 		policy->cpuinfo.max_freq = max_freq;
@@ -888,30 +896,30 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
 }
 
 /*
- * amd_pstate_init_freq: Initialize the max_freq, min_freq,
- *                       nominal_freq and lowest_nonlinear_freq for
- *                       the @cpudata object.
+ * amd_pstate_init_freq: Initialize the nominal_freq and lowest_nonlinear_freq
+ *			 for the @cpudata object.
  *
- *  Requires: highest_perf, lowest_perf, nominal_perf and
- *            lowest_nonlinear_perf members of @cpudata to be
- *            initialized.
+ * Requires: all perf members of @cpudata to be initialized.
  *
- *  Returns 0 on success, non-zero value on failure.
+ * Returns 0 on success, non-zero value on failure.
  */
 static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
-	int ret;
-	u32 min_freq, max_freq;
-	u32 nominal_freq, lowest_nonlinear_freq;
+	u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
 	struct cppc_perf_caps cppc_perf;
+	union perf_cached perf;
+	int ret;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
+	perf = READ_ONCE(cpudata->perf);
 
-	if (quirks && quirks->lowest_freq)
+	if (quirks && quirks->lowest_freq) {
 		min_freq = quirks->lowest_freq;
-	else
+		perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
+		WRITE_ONCE(cpudata->perf, perf);
+	} else
 		min_freq = cppc_perf.lowest_freq;
 
 	if (quirks && quirks->nominal_freq)
@@ -924,8 +932,8 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 
-	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
-	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
+	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
+	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
 
 	/**
@@ -952,6 +960,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata;
+	union perf_cached perf;
 	struct device *dev;
 	int ret;
 
@@ -987,8 +996,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
 	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
 
-	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
+	perf = READ_ONCE(cpudata->perf);
+
+	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
+							      cpudata->nominal_freq,
+							      perf.lowest_perf);
+	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
+							      cpudata->nominal_freq,
+							      perf.highest_perf);
 
 	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
 
@@ -1069,23 +1084,27 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
 static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
+	union perf_cached perf;
 
+	cpudata = policy->driver_data;
+	perf = READ_ONCE(cpudata->perf);
 
-	return sysfs_emit(buf, "%u\n", perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf)));
+	return sysfs_emit(buf, "%u\n",
+			  perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf));
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
 						     char *buf)
 {
-	int freq;
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
+	union perf_cached perf;
 
-	freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
-	if (freq < 0)
-		return freq;
+	cpudata = policy->driver_data;
+	perf = READ_ONCE(cpudata->perf);
 
-	return sysfs_emit(buf, "%u\n", freq);
+	return sysfs_emit(buf, "%u\n",
+			  perf_to_freq(perf, cpudata->nominal_freq, perf.lowest_nonlinear_perf));
 }
 
 /*
@@ -1095,12 +1114,11 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 					    char *buf)
 {
-	u8 perf;
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
 
-	perf = READ_ONCE(cpudata->highest_perf);
+	cpudata = policy->driver_data;
 
-	return sysfs_emit(buf, "%u\n", perf);
+	return sysfs_emit(buf, "%u\n", cpudata->perf.highest_perf);
 }
 
 static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
@@ -1431,6 +1449,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata;
+	union perf_cached perf;
 	struct device *dev;
 	u64 value;
 	int ret;
@@ -1464,8 +1483,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
-	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
+	perf = READ_ONCE(cpudata->perf);
+
+	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
+							      cpudata->nominal_freq,
+							      perf.lowest_perf);
+	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
+							      cpudata->nominal_freq,
+							      perf.highest_perf);
+
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
@@ -1526,6 +1552,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf;
 	u8 epp;
 
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
@@ -1536,15 +1563,16 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	else
 		epp = READ_ONCE(cpudata->epp_cached);
 
+	perf = READ_ONCE(cpudata->perf);
 	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
-					  cpudata->min_limit_perf,
-					  cpudata->max_limit_perf,
+		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf, epp,
+					  perf.min_limit_perf,
+					  perf.max_limit_perf,
 					  policy->boost_enabled);
 	}
 
-	return amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
-				      cpudata->max_limit_perf, epp, false);
+	return amd_pstate_update_perf(cpudata, perf.min_limit_perf, 0U,
+				      perf.max_limit_perf, epp, false);
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
@@ -1576,20 +1604,18 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u8 max_perf;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
 	int ret;
 
 	ret = amd_pstate_cppc_enable(true);
 	if (ret)
 		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
 
-	max_perf = READ_ONCE(cpudata->highest_perf);
-
 	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
+		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  cpudata->epp_cached,
 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
-					  max_perf, policy->boost_enabled);
+					  perf.highest_perf, policy->boost_enabled);
 	}
 
 	return amd_pstate_epp_update_limit(policy);
@@ -1613,22 +1639,21 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u8 min_perf;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
 
 	if (cpudata->suspended)
 		return 0;
 
-	min_perf = READ_ONCE(cpudata->lowest_perf);
-
 	guard(mutex)(&amd_pstate_limits_lock);
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
+		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
-					  min_perf, min_perf, policy->boost_enabled);
+					  perf.lowest_perf, perf.lowest_perf,
+					  policy->boost_enabled);
 	}
 
-	return amd_pstate_update_perf(cpudata, min_perf, 0, min_perf,
+	return amd_pstate_update_perf(cpudata, perf.lowest_perf, 0, perf.lowest_perf,
 				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
 }
 
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 0149933692458..83532a0079a81 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -13,6 +13,36 @@
 /*********************************************************************
  *                        AMD P-state INTERFACE                       *
  *********************************************************************/
+
+/**
+ * union perf_cached - A union to cache performance-related data.
+ * @highest_perf: the maximum performance an individual processor may reach,
+ *		  assuming ideal conditions
+ *		  For platforms that support the preferred core feature, the highest_perf value maybe
+ * 		  configured to any value in the range 166-255 by the firmware (because the preferred
+ * 		  core ranking is encoded in the highest_perf value). To maintain consistency across
+ * 		  all platforms, we split the highest_perf and preferred core ranking values into
+ * 		  cpudata->perf.highest_perf and cpudata->prefcore_ranking.
+ * @nominal_perf: the maximum sustained performance level of the processor,
+ *		  assuming ideal operating conditions
+ * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
+ *			   savings are achieved
+ * @lowest_perf: the absolute lowest performance level of the processor
+ * @min_limit_perf: Cached value of the performance corresponding to policy->min
+ * @max_limit_perf: Cached value of the performance corresponding to policy->max
+ */
+union perf_cached {
+	struct {
+		u8	highest_perf;
+		u8	nominal_perf;
+		u8	lowest_nonlinear_perf;
+		u8	lowest_perf;
+		u8	min_limit_perf;
+		u8	max_limit_perf;
+	};
+	u64	val;
+};
+
 /**
  * struct  amd_aperf_mperf
  * @aperf: actual performance frequency clock count
@@ -30,20 +60,9 @@ struct amd_aperf_mperf {
  * @cpu: CPU number
  * @req: constraint request to apply
  * @cppc_req_cached: cached performance request hints
- * @highest_perf: the maximum performance an individual processor may reach,
- *		  assuming ideal conditions
- *		  For platforms that do not support the preferred core feature, the
- *		  highest_pef may be configured with 166 or 255, to avoid max frequency
- *		  calculated wrongly. we take the fixed value as the highest_perf.
- * @nominal_perf: the maximum sustained performance level of the processor,
- *		  assuming ideal operating conditions
- * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
- *			   savings are achieved
- * @lowest_perf: the absolute lowest performance level of the processor
+ * @perf: cached performance-related data
  * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
  * 		  priority.
- * @min_limit_perf: Cached value of the performance corresponding to policy->min
- * @max_limit_perf: Cached value of the performance corresponding to policy->max
  * @min_limit_freq: Cached value of policy->min (in khz)
  * @max_limit_freq: Cached value of policy->max (in khz)
  * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
@@ -68,13 +87,9 @@ struct amd_cpudata {
 	struct	freq_qos_request req[2];
 	u64	cppc_req_cached;
 
-	u8	highest_perf;
-	u8	nominal_perf;
-	u8	lowest_nonlinear_perf;
-	u8	lowest_perf;
+	union perf_cached perf;
+
 	u8	prefcore_ranking;
-	u8	min_limit_perf;
-	u8	max_limit_perf;
 	u32	min_limit_freq;
 	u32	max_limit_freq;
 	u32	nominal_freq;
-- 
2.43.0


