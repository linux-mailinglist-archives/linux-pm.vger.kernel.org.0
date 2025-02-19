Return-Path: <linux-pm+bounces-22494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B26CA3CACC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257493B3B37
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98C7255E59;
	Wed, 19 Feb 2025 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhkSzakK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EE255E54;
	Wed, 19 Feb 2025 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999000; cv=none; b=SsyC9FZh6Sck1jU2puji2mhKOUYglLIqJuTUcm+lySZTsrm69V+l5R0xWwS263k0HfJ42fJ40ZPPpFZW98K46vKrpt58yMr075Qa7Byvk2h10vj9MHFoUfyB5uCHzaG+y3OE5VjI6UKiyqiFsJhYKymw7UqHMotLA7EEoKoIEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999000; c=relaxed/simple;
	bh=9jGLT2Sajb4T6RTPX4fgKxwA25hEN4bM4Iv+mSd3Uz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrYUUesHMf2LXrkg8tKwuZ8GWsQhYkftAcnx6jOpaFo8iG4EFVpnwVEm3aoa3c7rTMBugYeK4E7dA8BrQvGcbSWLV4TSyRH5gwMq5OD2gxyaXcOYUz8bfPSMWdiYaXcbpHzTgdwmgcES+YYQdJBQq4DxA7UPi9sWVhwP6MLr0ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhkSzakK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5A2C4CEE6;
	Wed, 19 Feb 2025 21:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999000;
	bh=9jGLT2Sajb4T6RTPX4fgKxwA25hEN4bM4Iv+mSd3Uz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhkSzakKfIElmvJkT9Bycb9K2d2ELSpQNuK+ZFPBvLXP/JXjms64x8N+HwR+LZQ9M
	 M/7lsqjGwtvdPierpvF1kWcGwiIMBwWsuJteuC1dNh0yFoQIWleL5hXMTrcyr3fcfB
	 9m1uoE31dB9tyk/48x/n5TzJqVfyi4Zp0rtHO/gHVEmGAbWwxHeyxDtmCrf8PRLyYE
	 94iV3YixEacFlKOCrzP0PIIMzk7tKRJAkxxTDN+TVu3M+VblEwcJ70b0P6MBXGFdOB
	 VHIzOfofmdePrmp+ZEf53YfceI1eTKsACkUm20KdmffOGdBzw8QaTtovP6XsiTS8Qx
	 t0D9qtY2uFoWg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 03/19] cpufreq/amd-pstate: Drop min and max cached frequencies
Date: Wed, 19 Feb 2025 15:02:46 -0600
Message-ID: <20250219210302.442954-4-superm1@kernel.org>
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

Use the perf_to_freq helpers to calculate this on the fly.
As the members are no longer cached add an extra check into
amd_pstate_update_min_max_limit().

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * Avoid some unnecessary changes to amd_pstate_init_freq()
 * Add tag
v3:
 * Fix calc error for min_freq
v2:
 * Keep cached limits
---
 drivers/cpufreq/amd-pstate-ut.c | 14 +++++------
 drivers/cpufreq/amd-pstate.c    | 43 +++++++++------------------------
 drivers/cpufreq/amd-pstate.h    |  9 ++-----
 3 files changed, 20 insertions(+), 46 deletions(-)

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
index 87c605348a3dc..278d909904e3b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -717,7 +717,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 	int ret = 0;
 
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	max_freq = READ_ONCE(cpudata->max_freq);
+	max_freq = perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf));
 
 	if (on)
 		policy->cpuinfo.max_freq = max_freq;
@@ -923,13 +923,10 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	nominal_freq *= 1000;
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
-	WRITE_ONCE(cpudata->min_freq, min_freq);
 
 	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
 	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
-
 	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
-	WRITE_ONCE(cpudata->max_freq, max_freq);
 
 	/**
 	 * Below values need to be initialized correctly, otherwise driver will fail to load
@@ -954,9 +951,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, ret;
-	struct device *dev;
 	struct amd_cpudata *cpudata;
+	struct device *dev;
+	int ret;
 
 	/*
 	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
@@ -987,17 +984,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
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
 
@@ -1021,9 +1012,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata2;
 	}
 
-	cpudata->max_limit_freq = max_freq;
-	cpudata->min_limit_freq = min_freq;
-
 	policy->driver_data = cpudata;
 
 	if (!current_pstate_driver->adjust_perf)
@@ -1081,14 +1069,10 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
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
@@ -1446,10 +1430,10 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, ret;
 	struct amd_cpudata *cpudata;
 	struct device *dev;
 	u64 value;
+	int ret;
 
 	/*
 	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
@@ -1480,19 +1464,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
@@ -1550,7 +1528,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
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


