Return-Path: <linux-pm+bounces-22123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4F4A36A22
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6B53AE57A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F513C682;
	Sat, 15 Feb 2025 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU4LQVH3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D286913B5B6;
	Sat, 15 Feb 2025 00:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580778; cv=none; b=lAtdk3nxZdrFtwh12GAFrKdpUX7qq3hZM4ed/WamucBbLFdDzdDTsrGcV8x25ZvzJbaIqrLDbwTniy9HIoGZWyq0Fn/FCDsadsTwOFFFkHX0HpJI+zF4FZzS6SCY/wOiY1Z/cDB7xmRPsYu6nYGn6hjUVVCCVxNes9yWaGFFZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580778; c=relaxed/simple;
	bh=C2ot3IzhdH9uei6tuTGwLrgMH8f/yP7WKB0QNBvka+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4/Bt4Pnv3W594J4U4h13APzogP610uFIl7dFBoAjr8o7n/Mw+2tzIL+bXb7uPObZVAUTrViW8ppwHkKCMPHcXjNuNjrB9ZGtClxl9kIXlncK+SqveuPX54W5FuOZFLbWUbU/QqIA+sxQhWx57VXBTjbKwY3gAKONUuppM9Vy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU4LQVH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A9FC4CED1;
	Sat, 15 Feb 2025 00:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580778;
	bh=C2ot3IzhdH9uei6tuTGwLrgMH8f/yP7WKB0QNBvka+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RU4LQVH34vCtNkWUsY0f8ONsHtYgc0mBb1dEUZ5cOPt7IKj/WzEWR3RHczjJsBlYR
	 Vmn3L+jA6W92xiurbyr+YpNQNlZh+MtqjYwA4nWA4HmUU+6fMyOVezJHhOeCq/bXUZ
	 9DcLIF+p5NlkpkTXgntvxAwa4T8Ww2EauzWdtd5JtXldq3Gb1KDLgHI0q3mxfooMFK
	 njYIuOio+Tv58vBawCYTpFbat+zr2k3cLGcybHCXUlhAQ5zvroCrXgzfqC5rTXU9Zw
	 o3CpCWVdE2/4Ifeidnb6yxRYhmZxvKiXY147RTK+pcGbfnIbaMXDfAj8Gr5SrK3zGz
	 UH1cX6X7RpLdA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 02/17] cpufreq/amd-pstate: Drop min and max cached frequencies
Date: Fri, 14 Feb 2025 18:52:29 -0600
Message-ID: <20250215005244.1212285-3-superm1@kernel.org>
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

Use the perf_to_freq helpers to calculate this on the fly.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
--
v2:
 * Keep cached limits
---
 drivers/cpufreq/amd-pstate-ut.c | 14 +++----
 drivers/cpufreq/amd-pstate.c    | 69 +++++++++++----------------------
 drivers/cpufreq/amd-pstate.h    |  9 +----
 3 files changed, 31 insertions(+), 61 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 3a0a380c3590c..445278cf40b61 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -214,14 +214,14 @@ static void amd_pstate_ut_check_freq(u32 index)
 			break;
 		cpudata = policy->driver_data;
 
-		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
+		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
 			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
-			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
-			(cpudata->min_freq > 0))) {
+			(cpudata->lowest_nonlinear_freq > policy->cpuinfo.min_freq) &&
+			(policy->cpuinfo.min_freq > 0))) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
-				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
-				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
+				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
+				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
 			goto skip_test;
 		}
 
@@ -233,13 +233,13 @@ static void amd_pstate_ut_check_freq(u32 index)
 		}
 
 		if (cpudata->boost_supported) {
-			if ((policy->max == cpudata->max_freq) ||
+			if ((policy->max == policy->cpuinfo.max_freq) ||
 					(policy->max == cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
 			else {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
-					__func__, cpu, policy->max, cpudata->max_freq,
+					__func__, cpu, policy->max, policy->cpuinfo.max_freq,
 					cpudata->nominal_freq);
 				goto skip_test;
 			}
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 573643654e8d6..bcebdc4167fe0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -717,7 +717,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 	int ret = 0;
 
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	max_freq = READ_ONCE(cpudata->max_freq);
+	max_freq = perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf));
 
 	if (on)
 		policy->cpuinfo.max_freq = max_freq;
@@ -901,35 +901,25 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
 static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
 	int ret;
-	u32 min_freq, max_freq;
-	u32 nominal_freq, lowest_nonlinear_freq;
+	u32 min_freq, nominal_freq, lowest_nonlinear_freq;
 	struct cppc_perf_caps cppc_perf;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
 
-	if (quirks && quirks->lowest_freq)
-		min_freq = quirks->lowest_freq;
-	else
-		min_freq = cppc_perf.lowest_freq;
-
 	if (quirks && quirks->nominal_freq)
 		nominal_freq = quirks->nominal_freq;
 	else
 		nominal_freq = cppc_perf.nominal_freq;
 
-	min_freq *= 1000;
 	nominal_freq *= 1000;
-
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
-	WRITE_ONCE(cpudata->min_freq, min_freq);
-
-	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
-	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
 
-	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
-	WRITE_ONCE(cpudata->max_freq, max_freq);
+	if (quirks && quirks->lowest_freq) {
+		min_freq = quirks->lowest_freq;
+	} else
+		min_freq = cppc_perf.lowest_freq;
 
 	/**
 	 * Below values need to be initialized correctly, otherwise driver will fail to load
@@ -937,12 +927,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
 	 * Check _CPC in ACPI table objects if any values are incorrect
 	 */
-	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
-		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
-			min_freq, max_freq, nominal_freq);
+	if (nominal_freq <= 0) {
+		pr_err("nominal_freq(%d) value is incorrect\n",
+			nominal_freq);
 		return -EINVAL;
 	}
 
+	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
+	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
+
 	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
 		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
 			lowest_nonlinear_freq, min_freq, nominal_freq);
@@ -954,9 +947,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, ret;
-	struct device *dev;
 	struct amd_cpudata *cpudata;
+	struct device *dev;
+	int ret;
 
 	/*
 	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
@@ -987,17 +980,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
-	min_freq = READ_ONCE(cpudata->min_freq);
-	max_freq = READ_ONCE(cpudata->max_freq);
-
 	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
 	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
 
-	policy->min = min_freq;
-	policy->max = max_freq;
-
-	policy->cpuinfo.min_freq = min_freq;
-	policy->cpuinfo.max_freq = max_freq;
+	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
+	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
 
 	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
 
@@ -1021,9 +1008,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata2;
 	}
 
-	cpudata->max_limit_freq = max_freq;
-	cpudata->min_limit_freq = min_freq;
-
 	policy->driver_data = cpudata;
 
 	if (!current_pstate_driver->adjust_perf)
@@ -1081,14 +1065,10 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
 static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
-	int max_freq;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	max_freq = READ_ONCE(cpudata->max_freq);
-	if (max_freq < 0)
-		return max_freq;
 
-	return sysfs_emit(buf, "%u\n", max_freq);
+	return sysfs_emit(buf, "%u\n", perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf)));
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
@@ -1446,10 +1426,10 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, ret;
 	struct amd_cpudata *cpudata;
 	struct device *dev;
 	u64 value;
+	int ret;
 
 	/*
 	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
@@ -1480,19 +1460,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
-	min_freq = READ_ONCE(cpudata->min_freq);
-	max_freq = READ_ONCE(cpudata->max_freq);
-
-	policy->cpuinfo.min_freq = min_freq;
-	policy->cpuinfo.max_freq = max_freq;
+	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
+	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
 	policy->driver_data = cpudata;
 
-	policy->min = policy->cpuinfo.min_freq;
-	policy->max = policy->cpuinfo.max_freq;
-
 	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
 
 	/*
@@ -1550,7 +1524,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u8 epp;
 
-	amd_pstate_update_min_max_limit(policy);
+	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
+		amd_pstate_update_min_max_limit(policy);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		epp = 0;
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 19d405c6d805e..0149933692458 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -46,8 +46,6 @@ struct amd_aperf_mperf {
  * @max_limit_perf: Cached value of the performance corresponding to policy->max
  * @min_limit_freq: Cached value of policy->min (in khz)
  * @max_limit_freq: Cached value of policy->max (in khz)
- * @max_freq: the frequency (in khz) that mapped to highest_perf
- * @min_freq: the frequency (in khz) that mapped to lowest_perf
  * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
  * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
  * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
@@ -77,11 +75,8 @@ struct amd_cpudata {
 	u8	prefcore_ranking;
 	u8	min_limit_perf;
 	u8	max_limit_perf;
-	u32     min_limit_freq;
-	u32     max_limit_freq;
-
-	u32	max_freq;
-	u32	min_freq;
+	u32	min_limit_freq;
+	u32	max_limit_freq;
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
 
-- 
2.43.0


