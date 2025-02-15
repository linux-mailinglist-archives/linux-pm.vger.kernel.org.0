Return-Path: <linux-pm+bounces-22143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F03A36A5D
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C40170576
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CFA18C03D;
	Sat, 15 Feb 2025 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYWvBYNH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8918C004;
	Sat, 15 Feb 2025 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580901; cv=none; b=bVoaFL+xhbxM7N9X0l/2F9PuuFDzFg/tWw8SAIkL6TGIjvEYTSDWLL3nFuBJyFTp2bOWvfD2VtgO0qkco7gwW14ZtZvUBpPjllLQGByPhaFDRlisxxuYCX8KsKrgwy+zZ5u0RM+Spc+6M8UG2BVsOTQrnVW8+ipdZ38SaFf6QnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580901; c=relaxed/simple;
	bh=DhZ3YXZcPMLtIFRNwbPKyIRSQL0TNWs0xy4ILudBErs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbknMy0NfqMrdiisa95QFo1sEMXUZIgZ4qHnbBPwLOHVCdmzFth4nqgwUa+mJH4b28MtyFinxfJdXZCymyIPMO5djrWWLoAMCjk6ZIyMqwa9pXafaLRw/lGapEZ86frtJ1N01yizwnusXUDBA2yEu/w634lNCe37+gugebbGy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYWvBYNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA40C4CEE2;
	Sat, 15 Feb 2025 00:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580901;
	bh=DhZ3YXZcPMLtIFRNwbPKyIRSQL0TNWs0xy4ILudBErs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYWvBYNHXY+CCocH5n9O5kBaKN1KW8bnjdMzjZU6K4+u3mHABpupLN/3SHhmW1E2g
	 6kxbUEk1glssvGXV4A1MzRpSrKbe93MwaaZJlHsnvzirk6yZXjqhOGzZKQQRyJoB/1
	 wjPS37Jsm9WREBjbbYCEkKYemxJCu69JSfMlRmsqqhNjOQP0N6t+eEUOkz40rZi7oJ
	 E80LSzm2IIQGS6qdEF0tx2LDlmXmrZWNeqGSf93O9l7BUo1UVZwixRnEkSrQzPtKMq
	 pK0XC6fUI/PWJOaxNvdepRk0zWKdRYPOE7oxrRmKlGCn0soDrgCmWIiSnLj3falztn
	 Rqr/vIW3N9LmA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/5] cpufreq/amd-pstate: Add support for platform profile class
Date: Fri, 14 Feb 2025 18:54:46 -0600
Message-ID: <20250215005448.1216646-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005448.1216646-1-superm1@kernel.org>
References: <20250215005448.1216646-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The platform profile core allows multiple drivers and devices to
register platform profile support.

When the legacy platform profile interface is used all drivers will
adjust the platform profile as well.

Add support for registering every CPU with the platform profile handler
when dynamic EPP is enabled.

The end result will be that changing the platform profile will modify
EPP accordingly.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
 drivers/cpufreq/Kconfig.x86                 |   1 +
 drivers/cpufreq/amd-pstate.c                | 154 ++++++++++++++++----
 drivers/cpufreq/amd-pstate.h                |  10 ++
 4 files changed, 140 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 8424e7119dd7e..36950fb6568c0 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -321,7 +321,9 @@ Whether this behavior is enabled by default with the kernel config option
 at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
 
 When set to enabled, the driver will select a different energy performance
-profile when the machine is running on battery or AC power.
+profile when the machine is running on battery or AC power. The driver will
+also register with the platform profile handler to receive notifications of
+user desired power state and react to those.
 When set to disabled, the driver will not change the energy performance profile
 based on the power source and will not react to user desired power state.
 
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index bfe957b653b05..f9906b4943e40 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -40,6 +40,7 @@ config X86_AMD_PSTATE
 	select ACPI_PROCESSOR
 	select ACPI_CPPC_LIB if X86_64
 	select CPU_FREQ_GOV_SCHEDUTIL if SMP
+	select ACPI_PLATFORM_PROFILE
 	help
 	  This driver adds a CPUFreq driver which utilizes a fine grain
 	  processor performance frequency control range instead of legacy
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f72f385f9f92e..5d5f602ef1407 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -105,6 +105,7 @@ static struct quirk_entry *quirks;
  *	2		balance_performance
  *	3		balance_power
  *	4		power
+ *	5		custom (for raw EPP values)
  */
 enum energy_perf_value_index {
 	EPP_INDEX_DEFAULT = 0,
@@ -112,6 +113,7 @@ enum energy_perf_value_index {
 	EPP_INDEX_BALANCE_PERFORMANCE,
 	EPP_INDEX_BALANCE_POWERSAVE,
 	EPP_INDEX_POWERSAVE,
+	EPP_INDEX_CUSTOM,
 };
 
 static const char * const energy_perf_strings[] = {
@@ -120,6 +122,7 @@ static const char * const energy_perf_strings[] = {
 	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
 	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
 	[EPP_INDEX_POWERSAVE] = "power",
+	[EPP_INDEX_CUSTOM] = "custom",
 	NULL
 };
 
@@ -1089,6 +1092,10 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 	if (event != PSY_EVENT_PROP_CHANGED)
 		return NOTIFY_OK;
 
+	/* dynamic actions are only applied while platform profile is in balanced */
+	if (cpudata->current_profile != PLATFORM_PROFILE_BALANCED)
+		return 0;
+
 	epp = amd_pstate_get_balanced_epp(policy);
 
 	ret = amd_pstate_set_epp(policy, epp);
@@ -1097,14 +1104,84 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 
 	return NOTIFY_OK;
 }
-static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
+
+static int amd_pstate_profile_probe(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
+static int amd_pstate_profile_get(struct device *dev,
+				  enum platform_profile_option *profile)
+{
+	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
+
+	*profile = cpudata->current_profile;
+
+	return 0;
+}
+
+static int amd_pstate_profile_set(struct device *dev,
+				  enum platform_profile_option profile)
+{
+	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
+	int ret;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
+			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
+		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_POWERSAVE);
+		if (ret)
+			return ret;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
+			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
+		ret = amd_pstate_set_epp(policy,
+					 amd_pstate_get_balanced_epp(policy));
+		if (ret)
+			return ret;
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_PERFORMANCE);
+		if (ret)
+			return ret;
+		break;
+	default:
+		pr_err("Unknown Platform Profile %d\n", profile);
+		return -EOPNOTSUPP;
+	}
+
+	cpudata->current_profile = profile;
+
+	return 0;
+}
+
+static const struct platform_profile_ops amd_pstate_profile_ops = {
+	.probe = amd_pstate_profile_probe,
+	.profile_set = amd_pstate_profile_set,
+	.profile_get = amd_pstate_profile_get,
+};
+
+void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->power_nb.notifier_call)
 		power_supply_unreg_notifier(&cpudata->power_nb);
+	if (cpudata->ppdev) {
+		platform_profile_remove(cpudata->ppdev);
+		cpudata->ppdev = NULL;
+	}
+	kfree(cpudata->profile_name);
 	cpudata->dynamic_epp = false;
 }
+EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
 
 static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 {
@@ -1112,11 +1189,35 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 	int ret;
 	u8 epp;
 
-	epp = amd_pstate_get_balanced_epp(policy);
+	switch (cpudata->current_profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		epp = AMD_CPPC_EPP_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_LOW_POWER:
+		epp = AMD_CPPC_EPP_POWERSAVE;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		epp = amd_pstate_get_balanced_epp(policy);
+		break;
+	default:
+		pr_err("Unknown Platform Profile %d\n", cpudata->current_profile);
+		return -EOPNOTSUPP;
+	}
 	ret = amd_pstate_set_epp(policy, epp);
 	if (ret)
 		return ret;
 
+	cpudata->profile_name = kasprintf(GFP_KERNEL, "amd-pstate-epp-cpu%d", cpudata->cpu);
+
+	cpudata->ppdev = platform_profile_register(get_cpu_device(policy->cpu),
+						   cpudata->profile_name,
+						   policy->driver_data,
+						   &amd_pstate_profile_ops);
+	if (IS_ERR(cpudata->ppdev)) {
+		ret = PTR_ERR(cpudata->ppdev);
+		goto cleanup;
+	}
+
 	/* only enable notifier if things will actually change */
 	if (cpudata->epp_default_ac != cpudata->epp_default_dc) {
 		ret = power_supply_reg_notifier(&cpudata->power_nb);
@@ -1223,8 +1324,8 @@ static ssize_t show_energy_performance_available_preferences(
 	return offset;
 }
 
-static ssize_t store_energy_performance_preference(
-		struct cpufreq_policy *policy, const char *buf, size_t count)
+ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
+					    const char *buf, size_t count)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	char str_preference[21];
@@ -1240,41 +1341,35 @@ static ssize_t store_energy_performance_preference(
 	if (ret != 1)
 		return -EINVAL;
 
-	ret = match_string(energy_perf_strings, -1, str_preference);
-	if (ret < 0)
-		return -EINVAL;
-
-	if (ret)
-		epp = epp_values[ret];
-	else
-		epp = amd_pstate_get_balanced_epp(policy);
+	/*
+	 * if the value matches a number, use that, otherwise see if
+	 * matches an index in the energy_perf_strings array
+	 */
+	ret = kstrtou8(str_preference, 0, &epp);
+	if (ret) {
+		ret = match_string(energy_perf_strings, -1, str_preference);
+		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
+			return -EINVAL;
+		if (ret)
+			epp = epp_values[ret];
+		else
+			epp = amd_pstate_get_balanced_epp(policy);
+	}
 
-	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
+	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		pr_debug("EPP cannot be set under performance policy\n");
 		return -EBUSY;
 	}
 
-	if (trace_amd_pstate_epp_perf_enabled()) {
-		union perf_cached perf = cpudata->perf;
-
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
-					  epp,
-					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
-					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
-					  policy->boost_enabled,
-					  FIELD_GET(AMD_CPPC_EPP_PERF_MASK,
-						    cpudata->cppc_req_cached) != epp);
-	}
-
 	ret = amd_pstate_set_epp(policy, epp);
 	if (ret)
 		return ret;
 
 	return ret ? ret : count;
 }
+EXPORT_SYMBOL_GPL(store_energy_performance_preference);
 
-static ssize_t show_energy_performance_preference(
-				struct cpufreq_policy *policy, char *buf)
+ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u8 preference, epp;
@@ -1295,11 +1390,12 @@ static ssize_t show_energy_performance_preference(
 		preference = EPP_INDEX_POWERSAVE;
 		break;
 	default:
-		return -EINVAL;
+		return sysfs_emit(buf, "%u\n", epp);
 	}
 
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
+EXPORT_SYMBOL_GPL(show_energy_performance_preference);
 
 static void amd_pstate_driver_cleanup(void)
 {
@@ -1623,10 +1719,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	    amd_pstate_acpi_pm_profile_undefined()) {
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
+		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
 	} else {
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 		cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
 		cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
+		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index a3b70c635a7d7..f1bbac4faf83d 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -9,6 +9,7 @@
 #define _LINUX_AMD_PSTATE_H
 
 #include <linux/pm_qos.h>
+#include <linux/platform_profile.h>
 
 /*********************************************************************
  *                        AMD P-state INTERFACE                       *
@@ -106,6 +107,11 @@ struct amd_cpudata {
 	u8	epp_default_dc;
 	bool	dynamic_epp;
 	struct notifier_block power_nb;
+
+	/* platform profile */
+	enum platform_profile_option current_profile;
+	struct device *ppdev;
+	char *profile_name;
 };
 
 /*
@@ -121,5 +127,9 @@ enum amd_pstate_mode {
 };
 const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
 int amd_pstate_update_status(const char *buf, size_t size);
+ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
+					    const char *buf, size_t count);
+ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf);
+void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy);
 
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.43.0


