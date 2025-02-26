Return-Path: <linux-pm+bounces-22970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5421FA4572B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01015188DEAD
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25A1E1DE0;
	Wed, 26 Feb 2025 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwISdukQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61DF26E622;
	Wed, 26 Feb 2025 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556205; cv=none; b=tLlwsICzKBbkm0btnp7yCFSHNcDTcuX7qW3i6KHShWFCIS04jZrwMJm44AxPdX7EbcDqqD2yZtTi/UO2PdDMzQTXOkpyMx74FwOeOpOKl7pOJsuuGpZslzHINU/b0L34az2nwbqL5k058lONoknQNnRQ6P6+PHi7JDxcnlLRVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556205; c=relaxed/simple;
	bh=hSoP8YKlBzaIWPk988HCBosOMTnwKrYcedoh3R7B29Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5QfIkCKRqSeb4mR12Lpz5JhbbKBES+w48Q8lo9Aqazc2nYJ1VG6ytNNCBrShCi8GEJDZ+UTXkD+i9O+T2X2vgfIKrzBiv++wdfpQ7WTGSv4nx39cBBmbiw0VcHtiKle/kndHJ3MDCbx+LxlFBmeMaP0NcqMYwfFaxxj/DdD4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwISdukQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD65C4CED6;
	Wed, 26 Feb 2025 07:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556205;
	bh=hSoP8YKlBzaIWPk988HCBosOMTnwKrYcedoh3R7B29Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nwISdukQHivbvzA07w5y9agjyIxXf5opWOjNN3EFspMKeFIqLQ/dC3UbfcTXh4ne8
	 o5uFgA74CKkHhm4mhufOihwS5jzwwJbOuEzXhCaR69eVikugTAU9ZfwQCSLKoZr31O
	 gICeux56GQV2C/TJp0NZWZ9R54COvlGy0SLGxG79hC+HoFAYvt663wcEGRo39POCBi
	 R1QsrPH2Tzz5RO7cdMxO2QShrosoF9B4BVVwnS0XqfL9tPYcIA6mEd2BuA/PYyGTV2
	 4oSTszHlGknRvvM1KjTaXlBw/AO+C2OtUxyzOHdUU1sQ+XAIX7v8O5VbCGRFGtybXB
	 qR9ScWagIzY8g==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 17/19] cpufreq/amd-pstate: Rework CPPC enabling
Date: Wed, 26 Feb 2025 01:49:32 -0600
Message-ID: <20250226074934.1667721-18-superm1@kernel.org>
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

The CPPC enable register is configured as "write once".  That is
any future writes don't actually do anything.

Because of this, all the cleanup paths that currently exist for
CPPC disable are non-effective.

Rework CPPC enable to only enable after all the CAP registers have
been read to avoid enabling CPPC on CPUs with invalid _CPC or
unpopulated MSRs.

As the register is write once, remove all cleanup paths as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Drop unnecessary extra code in shmem_cppc_enable()
 * Remove redundant tracing in store_energy_performance_preference()
 * Add missing call to amd_pstate_cppc_enable() in passive case
 * Leave cpudata->suspended alone in amd_pstate_epp_cpu_online()
 * Drop spurious whitespace
v4:
 * Remove unnecessary amd_pstate_update_perf() call during online
 * Remove unnecessary if (ret) ret.
 * Drop amd_pstate_cpu_resume()
 * Drop unnecessary derefs
v3:
 * Fixup for suspend/resume issue
---
 drivers/cpufreq/amd-pstate.c | 179 +++++++----------------------------
 1 file changed, 35 insertions(+), 144 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f0d9ee62cb30d..89e6d32223c9b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -85,7 +85,6 @@ static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
-static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 
@@ -371,89 +370,21 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 	return ret;
 }
 
-static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
-					    int pref_index)
+static inline int msr_cppc_enable(struct cpufreq_policy *policy)
 {
-	struct amd_cpudata *cpudata = policy->driver_data;
-	u8 epp;
-
-	if (!pref_index)
-		epp = cpudata->epp_default;
-	else
-		epp = epp_values[pref_index];
-
-	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
-		pr_debug("EPP cannot be set under performance policy\n");
-		return -EBUSY;
-	}
-
-	return amd_pstate_set_epp(policy, epp);
-}
-
-static inline int msr_cppc_enable(bool enable)
-{
-	int ret, cpu;
-	unsigned long logical_proc_id_mask = 0;
-
-       /*
-        * MSR_AMD_CPPC_ENABLE is write-once, once set it cannot be cleared.
-        */
-	if (!enable)
-		return 0;
-
-	if (enable == cppc_enabled)
-		return 0;
-
-	for_each_present_cpu(cpu) {
-		unsigned long logical_id = topology_logical_package_id(cpu);
-
-		if (test_bit(logical_id, &logical_proc_id_mask))
-			continue;
-
-		set_bit(logical_id, &logical_proc_id_mask);
-
-		ret = wrmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_ENABLE,
-				enable);
-		if (ret)
-			return ret;
-	}
-
-	cppc_enabled = enable;
-	return 0;
+	return wrmsrl_safe_on_cpu(policy->cpu, MSR_AMD_CPPC_ENABLE, 1);
 }
 
-static int shmem_cppc_enable(bool enable)
+static int shmem_cppc_enable(struct cpufreq_policy *policy)
 {
-	int cpu, ret = 0;
-	struct cppc_perf_ctrls perf_ctrls;
-
-	if (enable == cppc_enabled)
-		return 0;
-
-	for_each_present_cpu(cpu) {
-		ret = cppc_set_enable(cpu, enable);
-		if (ret)
-			return ret;
-
-		/* Enable autonomous mode for EPP */
-		if (cppc_state == AMD_PSTATE_ACTIVE) {
-			/* Set desired perf as zero to allow EPP firmware control */
-			perf_ctrls.desired_perf = 0;
-			ret = cppc_set_perf(cpu, &perf_ctrls);
-			if (ret)
-				return ret;
-		}
-	}
-
-	cppc_enabled = enable;
-	return ret;
+	return cppc_set_enable(policy->cpu, 1);
 }
 
 DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
 
-static inline int amd_pstate_cppc_enable(bool enable)
+static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
 {
-	return static_call(amd_pstate_cppc_enable)(enable);
+	return static_call(amd_pstate_cppc_enable)(policy);
 }
 
 static int msr_init_perf(struct amd_cpudata *cpudata)
@@ -1069,6 +1000,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 							      cpudata->nominal_freq,
 							      perf.highest_perf);
 
+	ret = amd_pstate_cppc_enable(policy);
+	if (ret)
+		goto free_cpudata1;
+
 	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
 
 	/* It will be updated by governor */
@@ -1116,28 +1051,6 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	kfree(cpudata);
 }
 
-static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
-{
-	int ret;
-
-	ret = amd_pstate_cppc_enable(true);
-	if (ret)
-		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
-
-	return ret;
-}
-
-static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
-{
-	int ret;
-
-	ret = amd_pstate_cppc_enable(false);
-	if (ret)
-		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
-
-	return ret;
-}
-
 /* Sysfs attributes */
 
 /*
@@ -1229,8 +1142,10 @@ static ssize_t show_energy_performance_available_preferences(
 static ssize_t store_energy_performance_preference(
 		struct cpufreq_policy *policy, const char *buf, size_t count)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
 	char str_preference[21];
 	ssize_t ret;
+	u8 epp;
 
 	ret = sscanf(buf, "%20s", str_preference);
 	if (ret != 1)
@@ -1240,7 +1155,17 @@ static ssize_t store_energy_performance_preference(
 	if (ret < 0)
 		return -EINVAL;
 
-	ret = amd_pstate_set_energy_pref_index(policy, ret);
+	if (!ret)
+		epp = cpudata->epp_default;
+	else
+		epp = epp_values[ret];
+
+	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		pr_debug("EPP cannot be set under performance policy\n");
+		return -EBUSY;
+	}
+
+	ret = amd_pstate_set_epp(policy, epp);
 
 	return ret ? ret : count;
 }
@@ -1273,7 +1198,6 @@ static ssize_t show_energy_performance_preference(
 
 static void amd_pstate_driver_cleanup(void)
 {
-	amd_pstate_cppc_enable(false);
 	cppc_state = AMD_PSTATE_DISABLE;
 	current_pstate_driver = NULL;
 }
@@ -1307,14 +1231,6 @@ static int amd_pstate_register_driver(int mode)
 
 	cppc_state = mode;
 
-	ret = amd_pstate_cppc_enable(true);
-	if (ret) {
-		pr_err("failed to enable cppc during amd-pstate driver registration, return %d\n",
-		       ret);
-		amd_pstate_driver_cleanup();
-		return ret;
-	}
-
 	/* at least one CPU supports CPB */
 	current_pstate_driver->boost_enabled = cpu_feature_enabled(X86_FEATURE_CPB);
 
@@ -1554,11 +1470,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
 							      cpudata->nominal_freq,
 							      perf.highest_perf);
+	policy->driver_data = cpudata;
+
+	ret = amd_pstate_cppc_enable(policy);
+	if (ret)
+		goto free_cpudata1;
 
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	policy->driver_data = cpudata;
 
 	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
 
@@ -1650,31 +1570,11 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
-{
-	int ret;
-
-	ret = amd_pstate_cppc_enable(true);
-	if (ret)
-		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
-
-
-	return amd_pstate_epp_update_limit(policy);
-}
-
 static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 {
-	struct amd_cpudata *cpudata = policy->driver_data;
-	int ret;
-
-	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
+	pr_debug("AMD CPU Core %d going online\n", policy->cpu);
 
-	ret = amd_pstate_epp_reenable(policy);
-	if (ret)
-		return ret;
-	cpudata->suspended = false;
-
-	return 0;
+	return amd_pstate_cppc_enable(policy);
 }
 
 static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
@@ -1692,11 +1592,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	int ret;
-
-	/* avoid suspending when EPP is not enabled */
-	if (cppc_state != AMD_PSTATE_ACTIVE)
-		return 0;
 
 	/* invalidate to ensure it's rewritten during resume */
 	cpudata->cppc_req_cached = 0;
@@ -1704,11 +1599,6 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 	/* set this flag to avoid setting core offline*/
 	cpudata->suspended = true;
 
-	/* disable CPPC in lowlevel firmware */
-	ret = amd_pstate_cppc_enable(false);
-	if (ret)
-		pr_err("failed to suspend, return %d\n", ret);
-
 	return 0;
 }
 
@@ -1717,8 +1607,12 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->suspended) {
+		int ret;
+
 		/* enable amd pstate from suspend state*/
-		amd_pstate_epp_reenable(policy);
+		ret = amd_pstate_epp_update_limit(policy);
+		if (ret)
+			return ret;
 
 		cpudata->suspended = false;
 	}
@@ -1733,8 +1627,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
-	.suspend	= amd_pstate_cpu_suspend,
-	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
@@ -1901,7 +1793,6 @@ static int __init amd_pstate_init(void)
 
 global_attr_free:
 	cpufreq_unregister_driver(current_pstate_driver);
-	amd_pstate_cppc_enable(false);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.43.0


