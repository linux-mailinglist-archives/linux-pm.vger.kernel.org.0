Return-Path: <linux-pm+bounces-23404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE97A4E3E6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B4017CD32
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C57281372;
	Tue,  4 Mar 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iim9ACWF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A028136E;
	Tue,  4 Mar 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101815; cv=none; b=qv261YZYtok4wBLLL/59cSB0ZhMQev5aLtfD5hpbB0ZROZJBbcipTmlPZPcNn8nFnSQOAOkLPDaSXotnijBWoxiDQVxURER376cVi7CVKDISkOAmQeFNRrBYkDGf8VmQCMRPUWDpp1BeGKtY7hc4WwHpkjw/fsVldN/NXQ3U/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101815; c=relaxed/simple;
	bh=cBnD3T0W3/BA/HYOjLIQM4x1KeXQ6j9o9g6Kgg0ICUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anIIyypkGGhkW9itK/0YxlMjWjRSVzf0Mn190S7+mbuoU642T3tXoCSoJ7/H/mJLQgKGB1wkQOetmol3x7MI8ZuS9CZijE/ZOU+MPFb4yoEOcXRh1bJO4Wv2e7iiyx5aOhPbX5g8NQ/CWJ1869cwKHeH8IDphRt3kZAZVUCLSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iim9ACWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E55C4CEE9;
	Tue,  4 Mar 2025 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741101815;
	bh=cBnD3T0W3/BA/HYOjLIQM4x1KeXQ6j9o9g6Kgg0ICUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iim9ACWFc9bp0Xr6Wqr4B3MSoziGWyu2lqLsmjCl0p31t3meUpl3S/YSUfCMXFcHq
	 qz9lxL15mb8UlLowSqezWy6/y+JuQDBY0akX1Lpqtn7vQ91ps+UNWVHBUgaomQC7lw
	 H/5I1aIsH7bvwCWWHR7c86F/ZlGVUmcyTOXhxlImw9nDdjuauTrozFgXcEd7r9DTOF
	 amBEcAgkgDGaOVbQVCKgINS5LxvwENotflzmcBkZ9VN18xrP6A36nNYZPcadflpoMm
	 VzEPqroUI9NiIlVE2c4zsRh8pvWregLm+4j7uW8zYC74HegqK9/PpDhTkckkkMYxTm
	 GBSx4xiwAHT2Q==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/5] cpufreq/amd-pstate: Add dynamic energy performance preference
Date: Tue,  4 Mar 2025 09:23:23 -0600
Message-ID: <20250304152327.1561017-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152327.1561017-1-superm1@kernel.org>
References: <20250304152327.1561017-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Dynamic energy performance preference will change the EPP profile
based on whether the machine is running on AC or DC power.

A notification chain from the power supply core is used to adjust
EPP values on plug in or plug out events.

For non-server systems:
    * the default EPP for AC mode is `performance`.
    * the default EPP for DC mode is `balance_performance`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Change defaults to performance (AC) and balance_performance (DC)
 * Default Kconfig to disabled for now
 * Rebase on latest branch
---
 Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
 drivers/cpufreq/Kconfig.x86                 |  12 ++
 drivers/cpufreq/amd-pstate.c                | 129 ++++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                |   5 +-
 4 files changed, 155 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 412423c54f258..2e076650dc77c 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -289,7 +289,7 @@ and user can change current preference according to energy or performance needs
 Please get all support profiles list from
 ``energy_performance_available_preferences`` attribute, all the profiles are
 integer values defined between 0 to 255 when EPP feature is enabled by platform
-firmware, if EPP feature is disabled, driver will ignore the written value
+firmware, but if the dynamic EPP feature is enabled, driver will block writes.
 This attribute is read-write.
 
 ``boost``
@@ -311,6 +311,22 @@ boost or `1` to enable it, for the respective CPU using the sysfs path
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
+Dynamic energy performance profile
+==================================
+The amd-pstate driver supports dynamically selecting the energy performance
+profile based on whether the machine is running on AC or DC power.
+
+Whether this behavior is enabled by default with the kernel config option
+`CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be overridden
+at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
+
+When set to enabled, the driver will select a different energy performance
+profile when the machine is running on battery or AC power.
+When set to disabled, the driver will not change the energy performance profile
+based on the power source and will not react to user desired power state.
+
+Attempting to manually write to the ``energy_performance_preference`` sysfs
+file will fail when ``dynamic_epp`` is enabled.
 
 ``amd-pstate`` vs ``acpi-cpufreq``
 ======================================
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 97c2d4f15d76e..c5ef92634ddf4 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -68,6 +68,18 @@ config X86_AMD_PSTATE_DEFAULT_MODE
 	  For details, take a look at:
 	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
 
+config X86_AMD_PSTATE_DYNAMIC_EPP
+	bool "AMD Processor P-State dynamic EPP support"
+	depends on X86_AMD_PSTATE
+	default n
+	help
+	  Allow the kenrel to dynamically change the energy performance
+	  value from events like ACPI platform profile and AC adapter plug
+	  events.
+
+	  This feature can also be changed at runtime, this configuration
+	  option only sets the kernel default value behavior.
+
 config X86_AMD_PSTATE_UT
 	tristate "selftest for AMD Processor P-State driver"
 	depends on X86 && ACPI_PROCESSOR
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e98ef41083ba1..f00fb4ba9f26e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -36,6 +36,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/uaccess.h>
+#include <linux/power_supply.h>
 #include <linux/static_call.h>
 #include <linux/topology.h>
 
@@ -86,6 +87,7 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
+static bool dynamic_epp = CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP;
 static struct quirk_entry *quirks;
 
 /*
@@ -1050,6 +1052,73 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	kfree(cpudata);
 }
 
+static int amd_pstate_get_balanced_epp(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (power_supply_is_system_supplied())
+		return cpudata->epp_default_ac;
+	else
+		return cpudata->epp_default_dc;
+}
+
+static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
+					    unsigned long event, void *data)
+{
+	struct amd_cpudata *cpudata = container_of(nb, struct amd_cpudata, power_nb);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
+	u8 epp;
+	int ret;
+
+	if (event != PSY_EVENT_PROP_CHANGED)
+		return NOTIFY_OK;
+
+	epp = amd_pstate_get_balanced_epp(policy);
+
+	ret = amd_pstate_set_epp(policy, epp);
+	if (ret)
+		pr_warn("Failed to set CPU %d EPP %u: %d\n", cpudata->cpu, epp, ret);
+
+	return NOTIFY_OK;
+}
+static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (cpudata->power_nb.notifier_call)
+		power_supply_unreg_notifier(&cpudata->power_nb);
+	cpudata->dynamic_epp = false;
+}
+
+static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
+	u8 epp;
+
+	epp = amd_pstate_get_balanced_epp(policy);
+	ret = amd_pstate_set_epp(policy, epp);
+	if (ret)
+		return ret;
+
+	/* only enable notifier if things will actually change */
+	if (cpudata->epp_default_ac != cpudata->epp_default_dc) {
+		ret = power_supply_reg_notifier(&cpudata->power_nb);
+		if (ret)
+			goto cleanup;
+		cpudata->power_nb.notifier_call = amd_pstate_power_supply_notifier;
+	}
+
+	cpudata->dynamic_epp = true;
+
+	return 0;
+
+cleanup:
+	amd_pstate_clear_dynamic_epp(policy);
+
+	return ret;
+}
+
 /* Sysfs attributes */
 
 /*
@@ -1146,6 +1215,11 @@ static ssize_t store_energy_performance_preference(
 	ssize_t ret;
 	u8 epp;
 
+	if (cpudata->dynamic_epp) {
+		pr_debug("EPP cannot be set when dynamic EPP is enabled\n");
+		return -EBUSY;
+	}
+
 	ret = sscanf(buf, "%20s", str_preference);
 	if (ret != 1)
 		return -EINVAL;
@@ -1154,10 +1228,10 @@ static ssize_t store_energy_performance_preference(
 	if (ret < 0)
 		return -EINVAL;
 
-	if (!ret)
-		epp = cpudata->epp_default;
-	else
+	if (ret)
 		epp = epp_values[ret];
+	else
+		epp = amd_pstate_get_balanced_epp(policy);
 
 	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		pr_debug("EPP cannot be set under performance policy\n");
@@ -1165,6 +1239,8 @@ static ssize_t store_energy_performance_preference(
 	}
 
 	ret = amd_pstate_set_epp(policy, epp);
+	if (ret)
+		return ret;
 
 	return ret ? ret : count;
 }
@@ -1364,6 +1440,32 @@ static ssize_t prefcore_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
+static ssize_t dynamic_epp_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(dynamic_epp));
+}
+
+static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
+				 const char *buf, size_t count)
+{
+	bool enabled;
+	int ret;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	if (dynamic_epp == enabled)
+		return -EINVAL;
+
+	/* reinitialize with desired dynamic EPP value */
+	dynamic_epp = enabled;
+	ret = amd_pstate_change_driver_mode(cppc_state);
+
+	return ret ? ret : count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1374,6 +1476,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(dynamic_epp);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1398,6 +1501,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_dynamic_epp.attr,
 	NULL
 };
 
@@ -1490,10 +1594,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (amd_pstate_acpi_pm_profile_server() ||
 	    amd_pstate_acpi_pm_profile_undefined()) {
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-		cpudata->epp_default = amd_pstate_get_epp(cpudata);
+		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
 	} else {
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
-		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
+		cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
+		cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
@@ -1502,9 +1607,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_req_cached, value);
 	}
-	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
+
+	if (dynamic_epp)
+		ret = amd_pstate_set_dynamic_epp(policy);
+	else
+		ret = amd_pstate_set_epp(policy, amd_pstate_get_balanced_epp(policy));
 	if (ret)
-		return ret;
+		goto free_cpudata1;
 
 	current_pstate_driver->adjust_perf = NULL;
 
@@ -1521,6 +1630,8 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata) {
+		if (cpudata->dynamic_epp)
+			amd_pstate_clear_dynamic_epp(policy);
 		kfree(cpudata);
 		policy->driver_data = NULL;
 	}
@@ -1556,6 +1667,10 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
+	/* policy can't be changed to performance policy while dynamic epp is enabled */
+	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE && cpudata->dynamic_epp)
+		return -EBUSY;
+
 	cpudata->policy = policy->policy;
 
 	ret = amd_pstate_epp_update_limit(policy);
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index fbe1c08d3f061..6882876f895de 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -104,7 +104,10 @@ struct amd_cpudata {
 	/* EPP feature related attributes*/
 	u32	policy;
 	bool	suspended;
-	u8	epp_default;
+	u8	epp_default_ac;
+	u8	epp_default_dc;
+	bool	dynamic_epp;
+	struct notifier_block power_nb;
 };
 
 /*
-- 
2.43.0


