Return-Path: <linux-pm+bounces-22137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE438A36A49
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E5E169FB0
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F31A7253;
	Sat, 15 Feb 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOKYU/5i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0A1A5BB8;
	Sat, 15 Feb 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580792; cv=none; b=Wayqph+3zYbIqtjm7uzIrqGTivUFdZ8hnlPEC1KCNSfXZlKFmvVY00EqR/YnysNYMgQ+FkX4K6By3X+NoQd5nHumLc+mV2cl8bz+xUlegmM5d9l+VV3W7HNVre3Yc4e2ARLNoViNI8Rs1Dm3CZ4swgwfBBpQtTtXFxYpV9lunWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580792; c=relaxed/simple;
	bh=VzDiC7mR436uD/j9dxHYmUC5SMnYImhMS3XjQIcfNXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hscFFlb5xpCGBwozaUuDeP/JdWkZ7BB+tvvyS6X0UqNkoczWFiqnnju9NP3TRY7bIQw+H3JLeuKSTljiEO/qysFhqUtUTRWc9TbSZElbwIt1DLsBsLaUdYjNTYFAC5J7+4OKY8vyQ0Ql39PWJfrxyNaF+PmNuygzRKoa5vPIMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOKYU/5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF4CC4CED1;
	Sat, 15 Feb 2025 00:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580792;
	bh=VzDiC7mR436uD/j9dxHYmUC5SMnYImhMS3XjQIcfNXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOKYU/5inIZOc9jGwdWJz2Urd3bpDa0HkYxLgqhDbPMPNJ65yGOFdV2TFKRL+6bAk
	 LE5lDFxzzKFRKE3r/JVJEL5F+mtEkYS9hP5HqgXEHDZkm9W5ZmXra2P2+v/nxSKZCW
	 EvpMIcyA8cLK5CQ07xF4VnGhFCb8YJ3B9q9VUkaBGg57q7IcmT6tbj3RZ41MPcaH+2
	 Mue9kDR/xK8dm6smDL9z8qwL1a4jxLPaOjjwYu0gn66+zZYam208t5dUhc97Lbrh0w
	 BzJ0AriwXWZZCPiR5apTX9zKbcNDqA49GRRXFbGFaUjYmmZKix6vafniweKZD66eQq
	 3dU9HQlS5A57w==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 16/17] cpufreq/amd-pstate: Rework CPPC enabling
Date: Fri, 14 Feb 2025 18:52:43 -0600
Message-ID: <20250215005244.1212285-17-superm1@kernel.org>
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
 drivers/cpufreq/amd-pstate.c | 183 +++++++++++------------------------
 1 file changed, 57 insertions(+), 126 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b39bed12b360f..1117dd4a6addd 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -85,7 +85,6 @@ static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
-static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 
@@ -371,89 +370,40 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 	return ret;
 }
 
-static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
-					    int pref_index)
+static inline int msr_cppc_enable(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
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
 
-	cppc_enabled = enable;
-	return 0;
+	return wrmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_ENABLE, 1);
 }
 
-static int shmem_cppc_enable(bool enable)
+static int shmem_cppc_enable(struct cpufreq_policy *policy)
 {
-	int cpu, ret = 0;
+	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
+	int ret;
 
-	if (enable == cppc_enabled)
-		return 0;
+	ret = cppc_set_enable(cpudata->cpu, 1);
+	if (ret)
+		return ret;
 
-	for_each_present_cpu(cpu) {
-		ret = cppc_set_enable(cpu, enable);
+	/* Enable autonomous mode for EPP */
+	if (cppc_state == AMD_PSTATE_ACTIVE) {
+		/* Set desired perf as zero to allow EPP firmware control */
+		perf_ctrls.desired_perf = 0;
+		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
 		if (ret)
 			return ret;
-
-		/* Enable autonomous mode for EPP */
-		if (cppc_state == AMD_PSTATE_ACTIVE) {
-			/* Set desired perf as zero to allow EPP firmware control */
-			perf_ctrls.desired_perf = 0;
-			ret = cppc_set_perf(cpu, &perf_ctrls);
-			if (ret)
-				return ret;
-		}
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
@@ -1114,24 +1064,7 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 
 static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
 {
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
+	return amd_pstate_cppc_enable(policy);
 }
 
 /* Sysfs attributes */
@@ -1225,8 +1158,10 @@ static ssize_t show_energy_performance_available_preferences(
 static ssize_t store_energy_performance_preference(
 		struct cpufreq_policy *policy, const char *buf, size_t count)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
 	char str_preference[21];
 	ssize_t ret;
+	u8 epp;
 
 	ret = sscanf(buf, "%20s", str_preference);
 	if (ret != 1)
@@ -1236,7 +1171,29 @@ static ssize_t store_energy_performance_preference(
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
@@ -1269,7 +1226,6 @@ static ssize_t show_energy_performance_preference(
 
 static void amd_pstate_driver_cleanup(void)
 {
-	amd_pstate_cppc_enable(false);
 	cppc_state = AMD_PSTATE_DISABLE;
 	current_pstate_driver = NULL;
 }
@@ -1303,14 +1259,6 @@ static int amd_pstate_register_driver(int mode)
 
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
 
@@ -1550,11 +1498,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
 
@@ -1646,32 +1598,27 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
+static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	int ret;
 
-	ret = amd_pstate_cppc_enable(true);
-	if (ret)
-		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
-
-	return amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
-}
+	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
-static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
-{
-	struct amd_cpudata *cpudata = policy->driver_data;
-	int ret;
+	ret = amd_pstate_cppc_enable(policy);
+	if (ret)
+		return ret;
 
-	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
-	ret = amd_pstate_epp_reenable(policy);
+	ret = amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
 	if (ret)
 		return ret;
+
 	cpudata->suspended = false;
 
 	return 0;
+
 }
 
 static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
@@ -1689,20 +1636,10 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	int ret;
-
-	/* avoid suspending when EPP is not enabled */
-	if (cppc_state != AMD_PSTATE_ACTIVE)
-		return 0;
 
 	/* set this flag to avoid setting core offline*/
 	cpudata->suspended = true;
 
-	/* disable CPPC in lowlevel firmware */
-	ret = amd_pstate_cppc_enable(false);
-	if (ret)
-		pr_err("failed to suspend, return %d\n", ret);
-
 	return 0;
 }
 
@@ -1710,12 +1647,8 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	if (cpudata->suspended) {
-		/* enable amd pstate from suspend state*/
-		amd_pstate_epp_reenable(policy);
 
-		cpudata->suspended = false;
-	}
+	cpudata->suspended = false;
 
 	return 0;
 }
@@ -1727,7 +1660,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
-	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
@@ -1743,8 +1675,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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
@@ -1895,7 +1827,6 @@ static int __init amd_pstate_init(void)
 
 global_attr_free:
 	cpufreq_unregister_driver(current_pstate_driver);
-	amd_pstate_cppc_enable(false);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.43.0


