Return-Path: <linux-pm+bounces-22124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5646A36A23
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601E5188EF4B
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B116F14A08E;
	Sat, 15 Feb 2025 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlRjdCdD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39B146A6F;
	Sat, 15 Feb 2025 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580779; cv=none; b=Nua6yWPmAO9hobYNfW/MbSJsItqY28uZ8lnCIXR65vVhQ+hth6LOdH1M9TRL4cmBiLxpCN7rLoB/yD3uLDDciGJ1lxpCLi0U8FDeh3ZT0lOuZO5XEeYtf6wqHKSPs/sgbkkdzBCoLvuiW0I/UpheHhZS1eDl3QVAT+sxTExGQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580779; c=relaxed/simple;
	bh=VCefPa8Yw/ggbl3WtzYt6C0eTikV4mGhOY5MYdAyN9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6QYhNvUVSAX0WWGhbRCdu9tbWB5jbZ4Wla5M7u2hjHxAnVGexcLOVvEiYfRGtZr/olUQiEs5emHqZCKLzhP9Qy97GMQxKkldYnQUbjbV/scpJyC/leam6Pe03fN1BoptG5Z1NJkhn4OjFWIhpriK0efhJWx7d198WtYV+lUQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlRjdCdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A17DC4CEE2;
	Sat, 15 Feb 2025 00:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580779;
	bh=VCefPa8Yw/ggbl3WtzYt6C0eTikV4mGhOY5MYdAyN9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FlRjdCdDu9Wy8r8V8S3260w+TAIoEcrPS3G5wfLSNmfN6+Eqy5nONLup66Z5lqyZd
	 JR1MkUwxHxyUydVYfxMmtyQJXijgc77oQ8xRiOVX8LVgDGy/TZl/MLfoBSlSV1UvHF
	 3kTtaRcBhcv7ptFgj2hb21+U3Y+1+KgZwXEeVPVwg2UTM8yjOz1xrYOca5Y8/exRCx
	 qKSsnYIaMLiMuwzbQ11+DL5Z0ccoEfCZeLA7cpVlMMzzCQv3xNhDBF5gB9UMnC62Bl
	 IL8JTJfDGzyvG1p3wW3jDMryZbFk6IxIUuuYY+coMuc6FoMFreOAiJIxXwkFywVQGT
	 u64gYmI/2NOkg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 03/17] cpufreq/amd-pstate: Move perf values into a union
Date: Fri, 14 Feb 2025 18:52:30 -0600
Message-ID: <20250215005244.1212285-4-superm1@kernel.org>
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

By storing perf values in a union all the writes and reads can
be done atomically, removing the need for some concurrency protections.

While making this change, also drop the cached frequency values,
using inline helpers to calculate them on demand from perf value.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * cache perf variable in unit tests
 * Drop unnecessary check from amd_pstate_update_min_max_limit()
 * Consistency with READ_ONCE()
 * Drop unneeded policy checks
 * add kdoc
---
 drivers/cpufreq/amd-pstate-ut.c |  18 +--
 drivers/cpufreq/amd-pstate.c    | 197 ++++++++++++++++++--------------
 drivers/cpufreq/amd-pstate.h    |  49 +++++---
 3 files changed, 152 insertions(+), 112 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 445278cf40b61..ba3e06f349c6d 100644
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
+				__func__, cpu, highest_perf, cpudata->perf.highest_perf);
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
+				__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
+				lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
+				lowest_perf, cpudata->perf.lowest_perf);
 			goto skip_test;
 		}
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index bcebdc4167fe0..8c3b54030ec56 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -142,18 +142,17 @@ static struct quirk_entry quirk_amd_7k62 = {
 	.lowest_freq = 550,
 };
 
-static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
+static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
 {
-	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
-					cpudata->nominal_freq);
+	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
 
-	return clamp_t(u8, perf_val, cpudata->lowest_perf, cpudata->highest_perf);
+	return clamp_t(u8, perf_val, perf.lowest_perf, perf.highest_perf);
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
@@ -888,25 +896,24 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
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
 	u32 min_freq, nominal_freq, lowest_nonlinear_freq;
 	struct cppc_perf_caps cppc_perf;
+	union perf_cached perf;
+	int ret;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
+	perf = READ_ONCE(cpudata->perf);
 
 	if (quirks && quirks->nominal_freq)
 		nominal_freq = quirks->nominal_freq;
@@ -918,6 +925,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	if (quirks && quirks->lowest_freq) {
 		min_freq = quirks->lowest_freq;
+		perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
 	} else
 		min_freq = cppc_perf.lowest_freq;
 
@@ -933,7 +941,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 		return -EINVAL;
 	}
 
-	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
+	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
 
 	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
@@ -948,6 +956,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata;
+	union perf_cached perf;
 	struct device *dev;
 	int ret;
 
@@ -983,8 +992,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
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
 
@@ -1065,23 +1080,27 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
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
+			  perf_to_freq(perf, cpudata->nominal_freq, perf.max_limit_perf));
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
@@ -1091,12 +1110,11 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
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
@@ -1427,6 +1445,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata;
+	union perf_cached perf;
 	struct device *dev;
 	u64 value;
 	int ret;
@@ -1460,8 +1479,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
 
@@ -1522,6 +1548,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf;
 	u8 epp;
 
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
@@ -1532,15 +1559,16 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
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
@@ -1572,23 +1600,21 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
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
 
-	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
+	return amd_pstate_update_perf(cpudata, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
 }
 
 static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
@@ -1609,22 +1635,21 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
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
index 0149933692458..8421c83c07919 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -13,6 +13,34 @@
 /*********************************************************************
  *                        AMD P-state INTERFACE                       *
  *********************************************************************/
+
+/**
+ * union perf_cached - A union to cache performance-related data.
+ * @highest_perf: the maximum performance an individual processor may reach,
+ *		  assuming ideal conditions
+ *		  For platforms that do not support the preferred core feature, the
+ *		  highest_pef may be configured with 166 or 255, to avoid max frequency
+ *		  calculated wrongly. we take the fixed value as the highest_perf.
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
@@ -30,20 +58,9 @@ struct amd_aperf_mperf {
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
@@ -68,13 +85,9 @@ struct amd_cpudata {
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


