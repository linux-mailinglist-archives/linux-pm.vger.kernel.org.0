Return-Path: <linux-pm+bounces-40259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF36CF6C15
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 06:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0693D30559F0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 05:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D02F8BF0;
	Tue,  6 Jan 2026 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLJ15ots"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA72F83AC;
	Tue,  6 Jan 2026 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676514; cv=none; b=S2/kSvxqHmsUhzK1Eb0+vXEZdau0FgIQbIqWH1aN2aeBzSM5LnDlR0MMpiyRXrhgNdBZArcWDYjo0exiUnnInUaLUSM8jzdiOJIAbLfPJVVMHw6Q8Bx4A7rBmZfqriY2RAj133fMQEGrKVG/pCBuZPvuk/pTgc+5M19w1aIhcKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676514; c=relaxed/simple;
	bh=wYvf03Hp1Oqo764YMmwK5bV1IehfJ495o8fiosCb5jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZrdNKI8F2tHReN02zK69FUliErt/OPNH7owJ/6Qdz4k65NOd5sAqV9k5hz6Lvg0Bd8sm5aagT6F30curDEXIUbHgn6hbOfwC7JBC3DAX2TlcbyTDULb0LdzvC3fZX0tQA6ZPa51DK4XoZ4iOnUS2ZgOtIZ4pvxPAOabDlp64dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLJ15ots; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D933AC19425;
	Tue,  6 Jan 2026 05:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767676514;
	bh=wYvf03Hp1Oqo764YMmwK5bV1IehfJ495o8fiosCb5jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLJ15otswxZAF9P/H5IbCpcOLYjxhsJUQLaVASJ7VsrcZeUIEsHTnWEW+tDOWxGjU
	 YcKS/D5wZnkvv+PWZgPXFlXHcS7rtCaGdOG0a+vKF+DUlkLexCpFLP2k2wDH0fSzt2
	 qd+3f2yOyysQsEP5FZ+YqFD/KrcENYL9JlRN8NFivPbzB9lERooTkF3g9Q1UONN1FC
	 GgU5tkr5+5taFceLDZpRKJBWZAQyzeozhAJhx23Tx38GmkI/Xstft+wLhkOiANPKY5
	 2Io4yPqS9kSzuvSW88yOJQyotGtDBjCWzSAC3z8jL1kOh3Dee5WjhUiTGqp+xfZcXy
	 lHgJOCbPe//GQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 3/5] cpufreq/amd-pstate: Add support for platform profile class
Date: Mon,  5 Jan 2026 23:14:39 -0600
Message-ID: <20260106051441.60093-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106051441.60093-1-superm1@kernel.org>
References: <20260106051441.60093-1-superm1@kernel.org>
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
 drivers/cpufreq/amd-pstate.c                | 144 +++++++++++++++++---
 drivers/cpufreq/amd-pstate.h                |  10 ++
 4 files changed, 141 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index df4607b6a5f62..a6745f2358e61 100644
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
index cdaa8d858045a..a0dbb9808ae99 100644
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
index 7dd50b5825d78..e1ccbbdd56d42 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -109,6 +109,7 @@ static struct quirk_entry *quirks;
  *	2		balance_performance
  *	3		balance_power
  *	4		power
+ *	5		custom (for raw EPP values)
  */
 enum energy_perf_value_index {
 	EPP_INDEX_DEFAULT = 0,
@@ -116,6 +117,7 @@ enum energy_perf_value_index {
 	EPP_INDEX_BALANCE_PERFORMANCE,
 	EPP_INDEX_BALANCE_POWERSAVE,
 	EPP_INDEX_POWERSAVE,
+	EPP_INDEX_CUSTOM,
 	EPP_INDEX_MAX,
 };
 
@@ -125,6 +127,7 @@ static const char * const energy_perf_strings[] = {
 	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
 	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
 	[EPP_INDEX_POWERSAVE] = "power",
+	[EPP_INDEX_CUSTOM] = "custom",
 };
 static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
 
@@ -135,7 +138,7 @@ static unsigned int epp_values[] = {
 	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
 	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
 };
-static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX);
+static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 1);
 
 typedef int (*cppc_mode_transition_fn)(int);
 
@@ -1094,6 +1097,10 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 	if (event != PSY_EVENT_PROP_CHANGED)
 		return NOTIFY_OK;
 
+	/* dynamic actions are only applied while platform profile is in balanced */
+	if (cpudata->current_profile != PLATFORM_PROFILE_BALANCED)
+		return 0;
+
 	epp = amd_pstate_get_balanced_epp(policy);
 
 	ret = amd_pstate_set_epp(policy, epp);
@@ -1102,14 +1109,84 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 
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
@@ -1117,11 +1194,35 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
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
@@ -1227,8 +1328,8 @@ static ssize_t show_energy_performance_available_preferences(
 	return offset;
 }
 
-static ssize_t store_energy_performance_preference(
-		struct cpufreq_policy *policy, const char *buf, size_t count)
+ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
+					    const char *buf, size_t count)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	ssize_t ret;
@@ -1239,16 +1340,22 @@ static ssize_t store_energy_performance_preference(
 		return -EBUSY;
 	}
 
-	ret = sysfs_match_string(energy_perf_strings, buf);
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
+	ret = kstrtou8(buf, 0, &epp);
+	if (ret) {
+		ret = sysfs_match_string(energy_perf_strings, buf);
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
@@ -1259,9 +1366,9 @@ static ssize_t store_energy_performance_preference(
 
 	return ret ? ret : count;
 }
+EXPORT_SYMBOL_GPL(store_energy_performance_preference);
 
-static ssize_t show_energy_performance_preference(
-				struct cpufreq_policy *policy, char *buf)
+ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u8 preference, epp;
@@ -1282,11 +1389,12 @@ static ssize_t show_energy_performance_preference(
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
@@ -1621,10 +1729,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
 
 	if (dynamic_epp) {
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 7bfe5f8115623..9839c7c6558f4 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -9,6 +9,7 @@
 #define _LINUX_AMD_PSTATE_H
 
 #include <linux/pm_qos.h>
+#include <linux/platform_profile.h>
 
 /*********************************************************************
  *                        AMD P-state INTERFACE                       *
@@ -110,6 +111,11 @@ struct amd_cpudata {
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
@@ -126,5 +132,9 @@ enum amd_pstate_mode {
 const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
 int amd_pstate_get_status(void);
 int amd_pstate_update_status(const char *buf, size_t size);
+ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
+					    const char *buf, size_t count);
+ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf);
+void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy);
 
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.43.0


