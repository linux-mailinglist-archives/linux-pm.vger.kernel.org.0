Return-Path: <linux-pm+bounces-22508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B8A3CAE5
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B304118949FF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57425B69E;
	Wed, 19 Feb 2025 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE/OBO9G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954E253F19;
	Wed, 19 Feb 2025 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999013; cv=none; b=iUsgwCybdaG4XzDs3aKiOUCpORa2hFl3uhWSfETIZIsx84hj3IVZEtHMBYoD2nf5s5Pk4RcI/6nNC9GTdMRJklOujV19eE9aZk/Z+XGc5zc5NePbLXpmLZB2GKLRMgDOX9rgruxV3wHmESWyJKnl47zolGTovlMZ8FipEotntQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999013; c=relaxed/simple;
	bh=is3NlPOjc2m4OPHZsZJTOe/HxBdKxgy5h40TK5+1hhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6GrSxRIGdiXPmZ0f25eFye7EYmWir6gvLzh0pJFBfa5sdCCuYH1xaoZeAWDliayvv67Ztz5AYFhMERPLY6Pc3P+0V3lgm1VL9kAyj3BYmoUetoMZgvS214MoAEpXs+R4VHHgz7cpSX4xO4qs8ntrI7jO2ghbwE12ORrG9+r100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE/OBO9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D790C4CEDD;
	Wed, 19 Feb 2025 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999012;
	bh=is3NlPOjc2m4OPHZsZJTOe/HxBdKxgy5h40TK5+1hhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QE/OBO9GMLTwc7bz7IE0K1+mN7Z0UIiN42upmwV6yckf76z1HyMqJkYbXC/Z6Mupd
	 MWPk5bIfWPWhjTV22Oi3ApRvqjA2rp/sw7w1iw6bJ3FyHd0kXsHaC6zZSztwS/za1N
	 DnvZ5uvmWV2L7e1GnaBirJDr/q5AM4XdHjm4lY2DRvhrw8z8NplYksm9+MPvS8gUXC
	 2k/LqsDmb5aib3jEiwBPA2el/k6O3RlJnRLKRepG3jp3QfzIC4EvU6jvwxqxFuQ4h7
	 odQQPXy0PsU168Q8UgEFsR1Hb7Jpzv7yL2nl8FNCP4T34Gjfz2CGZw4/tfsYLltFK4
	 mrNxpvfS7xbOQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 17/19] cpufreq/amd-pstate: Rework CPPC enabling
Date: Wed, 19 Feb 2025 15:03:00 -0600
Message-ID: <20250219210302.442954-18-superm1@kernel.org>
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
v4:
 * Remove unnecessary amd_pstate_update_perf() call during online
 * Remove unnecessary if (ret) ret.
 * Drop amd_pstate_cpu_resume()
 * Drop unnecessary derefs
v3:
 * Fixup for suspend/resume issue
---
 drivers/cpufreq/amd-pstate.c | 187 +++++++++++------------------------
 1 file changed, 55 insertions(+), 132 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fa9c581c68a39..f152636cecbeb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -85,7 +85,6 @@ static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
-static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 
@@ -371,89 +370,35 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
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
+	return wrmsrl_safe_on_cpu(policy->cpu, MSR_AMD_CPPC_ENABLE, 1);
 }
 
-static inline int msr_cppc_enable(bool enable)
+static int shmem_cppc_enable(struct cpufreq_policy *policy)
 {
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
-}
-
-static int shmem_cppc_enable(bool enable)
-{
-	int cpu, ret = 0;
 	struct cppc_perf_ctrls perf_ctrls;
+	int ret;
 
-	if (enable == cppc_enabled)
-		return 0;
-
-	for_each_present_cpu(cpu) {
-		ret = cppc_set_enable(cpu, enable);
-		if (ret)
-			return ret;
+	ret = cppc_set_enable(policy->cpu, 1);
+	if (ret)
+		return ret;
 
-		/* Enable autonomous mode for EPP */
-		if (cppc_state == AMD_PSTATE_ACTIVE) {
-			/* Set desired perf as zero to allow EPP firmware control */
-			perf_ctrls.desired_perf = 0;
-			ret = cppc_set_perf(cpu, &perf_ctrls);
-			if (ret)
-				return ret;
-		}
+	/* Enable autonomous mode for EPP */
+	if (cppc_state == AMD_PSTATE_ACTIVE) {
+		/* Set desired perf as zero to allow EPP firmware control */
+		perf_ctrls.desired_perf = 0;
+		ret = cppc_set_perf(policy->cpu, &perf_ctrls);
 	}
 
-	cppc_enabled = enable;
 	return ret;
 }
 
 DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
 
-static inline int amd_pstate_cppc_enable(bool enable)
+static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
 {
-	return static_call(amd_pstate_cppc_enable)(enable);
+	return static_call(amd_pstate_cppc_enable)(policy);
 }
 
 static int msr_init_perf(struct amd_cpudata *cpudata)
@@ -1115,28 +1060,6 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
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
@@ -1228,8 +1151,10 @@ static ssize_t show_energy_performance_available_preferences(
 static ssize_t store_energy_performance_preference(
 		struct cpufreq_policy *policy, const char *buf, size_t count)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
 	char str_preference[21];
 	ssize_t ret;
+	u8 epp;
 
 	ret = sscanf(buf, "%20s", str_preference);
 	if (ret != 1)
@@ -1239,7 +1164,29 @@ static ssize_t store_energy_performance_preference(
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
+	if (trace_amd_pstate_epp_perf_enabled()) {
+		union perf_cached perf = cpudata->perf;
+
+		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
+					  epp,
+					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
+					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
+					  policy->boost_enabled,
+					  FIELD_GET(AMD_CPPC_EPP_PERF_MASK,
+						    cpudata->cppc_req_cached) != epp);
+	}
+
+	ret = amd_pstate_set_epp(policy, epp);
 
 	return ret ? ret : count;
 }
@@ -1272,7 +1219,6 @@ static ssize_t show_energy_performance_preference(
 
 static void amd_pstate_driver_cleanup(void)
 {
-	amd_pstate_cppc_enable(false);
 	cppc_state = AMD_PSTATE_DISABLE;
 	current_pstate_driver = NULL;
 }
@@ -1306,14 +1252,6 @@ static int amd_pstate_register_driver(int mode)
 
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
 
@@ -1553,11 +1491,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
 
@@ -1649,31 +1591,21 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
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
 	struct amd_cpudata *cpudata = policy->driver_data;
 	int ret;
 
-	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
+	pr_debug("AMD CPU Core %d going online\n", policy->cpu);
 
-	ret = amd_pstate_epp_reenable(policy);
+	ret = amd_pstate_cppc_enable(policy);
 	if (ret)
 		return ret;
+
 	cpudata->suspended = false;
 
 	return 0;
+
 }
 
 static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
@@ -1691,11 +1623,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
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
@@ -1703,11 +1630,6 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 	/* set this flag to avoid setting core offline*/
 	cpudata->suspended = true;
 
-	/* disable CPPC in lowlevel firmware */
-	ret = amd_pstate_cppc_enable(false);
-	if (ret)
-		pr_err("failed to suspend, return %d\n", ret);
-
 	return 0;
 }
 
@@ -1716,8 +1638,12 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
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
@@ -1732,8 +1658,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
-	.suspend	= amd_pstate_cpu_suspend,
-	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
@@ -1748,8 +1672,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.exit		= amd_pstate_epp_cpu_exit,
 	.offline	= amd_pstate_epp_cpu_offline,
 	.online		= amd_pstate_epp_cpu_online,
-	.suspend	= amd_pstate_epp_suspend,
-	.resume		= amd_pstate_epp_resume,
+	.suspend        = amd_pstate_epp_suspend,
+	.resume         = amd_pstate_epp_resume,
 	.update_limits	= amd_pstate_update_limits,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate-epp",
@@ -1900,7 +1824,6 @@ static int __init amd_pstate_init(void)
 
 global_attr_free:
 	cpufreq_unregister_driver(current_pstate_driver);
-	amd_pstate_cppc_enable(false);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.43.0


