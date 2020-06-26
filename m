Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB920B85C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgFZSeX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 14:34:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:1976 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgFZSeW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jun 2020 14:34:22 -0400
IronPort-SDR: Qq2hsTGa3X1hR7VZfMJo82GW0d0UrbmuGWlJ9MeBpugCwdsD71UX20BRRqSHpKwbyzJAa+YQnB
 A0lRv44ia29g==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="143666459"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="143666459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:34:13 -0700
IronPort-SDR: nSgnm8qsr/ilwuBci+mcSpjh6tiqhyHppE3o/mEVqRmrYzldQ3AGmL0mro01qyo56D1EXd8fWH
 UG9/+SuZwrWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="453447588"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.109.205])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2020 11:34:13 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, peterz@infradead.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 1/2] cpufreq: intel_pstate: Allow enable/disable energy efficiency
Date:   Fri, 26 Jun 2020 11:34:00 -0700
Message-Id: <20200626183401.1495090-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200626183401.1495090-1-srinivas.pandruvada@linux.intel.com>
References: <20200626183401.1495090-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

By default intel_pstate driver disables energy efficiency by setting
MSR_IA32_POWER_CTL bit 19 for Kaby Lake desktop CPU model in HWP mode.
This CPU model is also shared by Coffee Lake desktop CPUs. This allows
these systems to reach maximum possible frequency. But this adds power
penalty, which some customers don't want. They want some way to enable/
disable dynamically.

So, add an additional attribute "energy_efficiency" under
/sys/devices/system/cpu/intel_pstate/ for these CPU models. This allows
to read and write bit 19 ("Disable Energy Efficiency Optimization") in
the MSR IA32_POWER_CTL.

This attribute is present in both HWP and non-HWP mode as this has an
effect in both modes. Refer to Intel Software Developer's manual for
details.

The scope of this bit is package wide. Also these systems are single
package systems. So read/write MSR on the current CPU is enough.

The energy efficiency (EE) bit setting needs to be preserved during
suspend/resume and CPU offline/online operation. To do this:
- Restoring the EE setting from the cpufreq resume() callback, if there
is change from the system default.
- By default, don't disable EE from cpufreq init() callback for matching
CPU models. Since the scope is package wide and is a single package
system, move the disable EE calls from init() callback to
intel_pstate_init() function, which is called only once.

Suggested-by: Len Brown <lenb@kernel.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst | 11 +++
 arch/x86/include/asm/msr-index.h              |  6 +-
 drivers/cpufreq/intel_pstate.c                | 97 ++++++++++++++-----
 3 files changed, 88 insertions(+), 26 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 39d80bc29ccd..25e1097fc332 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -431,6 +431,17 @@ argument is passed to the kernel in the command line.
 	supported in the current configuration, writes to this attribute will
 	fail with an appropriate error.
 
+``energy_efficiency``
+	This attribute is only present on platforms, which have CPUs matching
+	Kaby Lake or Coffee Lake desktop CPU model. By default
+	energy efficiency optimizations are disabled on these CPU models in HWP
+	mode by this driver. Enabling energy efficiency may limit maximum
+	operating frequency in both HWP and non HWP mode. In non HWP mode,
+	optimizations are done only in the turbo frequency range. In HWP mode,
+	optimizations are done in the entire frequency range. Setting this
+	attribute to "1" enables energy efficiency optimizations and setting
+	to "0" disables energy efficiency optimizations.
+
 Interpretation of Policy Attributes
 -----------------------------------
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e8370e64a155..21b409195b46 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -149,6 +149,10 @@
 
 #define MSR_LBR_SELECT			0x000001c8
 #define MSR_LBR_TOS			0x000001c9
+
+#define MSR_IA32_POWER_CTL		0x000001fc
+#define MSR_IA32_POWER_CTL_BIT_EE	19
+
 #define MSR_LBR_NHM_FROM		0x00000680
 #define MSR_LBR_NHM_TO			0x000006c0
 #define MSR_LBR_CORE_FROM		0x00000040
@@ -253,8 +257,6 @@
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
-#define MSR_IA32_POWER_CTL		0x000001fc
-
 #define MSR_IA32_MC0_CTL		0x00000400
 #define MSR_IA32_MC0_STATUS		0x00000401
 #define MSR_IA32_MC0_ADDR		0x00000402
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8e23a698ce04..7dfd9da385d1 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -866,10 +866,39 @@ static int intel_pstate_hwp_save_state(struct cpufreq_policy *policy)
 	return 0;
 }
 
+#define POWER_CTL_EE_ENABLE	1
+#define POWER_CTL_EE_DISABLE	2
+
+static int power_ctl_ee_state;
+
+static void set_power_ctl_ee_state(bool input)
+{
+	u64 power_ctl;
+
+	mutex_lock(&intel_pstate_driver_lock);
+	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
+	if (input) {
+		power_ctl &= ~BIT(MSR_IA32_POWER_CTL_BIT_EE);
+		power_ctl_ee_state = POWER_CTL_EE_ENABLE;
+	} else {
+		power_ctl |= BIT(MSR_IA32_POWER_CTL_BIT_EE);
+		power_ctl_ee_state = POWER_CTL_EE_DISABLE;
+	}
+	wrmsrl(MSR_IA32_POWER_CTL, power_ctl);
+	mutex_unlock(&intel_pstate_driver_lock);
+}
+
 static void intel_pstate_hwp_enable(struct cpudata *cpudata);
 
 static int intel_pstate_resume(struct cpufreq_policy *policy)
 {
+
+	/* Only restore if the system default is changed */
+	if (power_ctl_ee_state == POWER_CTL_EE_ENABLE)
+		set_power_ctl_ee_state(true);
+	else if (power_ctl_ee_state == POWER_CTL_EE_DISABLE)
+		set_power_ctl_ee_state(false);
+
 	if (!hwp_active)
 		return 0;
 
@@ -1218,6 +1247,32 @@ static ssize_t store_hwp_dynamic_boost(struct kobject *a,
 	return count;
 }
 
+static ssize_t show_energy_efficiency(struct kobject *kobj, struct kobj_attribute *attr,
+				      char *buf)
+{
+	u64 power_ctl;
+	int enable;
+
+	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
+	enable = !!(power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE));
+	return sprintf(buf, "%d\n", !enable);
+}
+
+static ssize_t store_energy_efficiency(struct kobject *a, struct kobj_attribute *b,
+				       const char *buf, size_t count)
+{
+	bool input;
+	int ret;
+
+	ret = kstrtobool(buf, &input);
+	if (ret)
+		return ret;
+
+	set_power_ctl_ee_state(input);
+
+	return count;
+}
+
 show_one(max_perf_pct, max_perf_pct);
 show_one(min_perf_pct, min_perf_pct);
 
@@ -1228,6 +1283,7 @@ define_one_global_rw(min_perf_pct);
 define_one_global_ro(turbo_pct);
 define_one_global_ro(num_pstates);
 define_one_global_rw(hwp_dynamic_boost);
+define_one_global_rw(energy_efficiency);
 
 static struct attribute *intel_pstate_attributes[] = {
 	&status.attr,
@@ -1241,6 +1297,8 @@ static const struct attribute_group intel_pstate_attr_group = {
 	.attrs = intel_pstate_attributes,
 };
 
+static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[];
+
 static void __init intel_pstate_sysfs_expose_params(void)
 {
 	struct kobject *intel_pstate_kobject;
@@ -1273,6 +1331,11 @@ static void __init intel_pstate_sysfs_expose_params(void)
 				       &hwp_dynamic_boost.attr);
 		WARN_ON(rc);
 	}
+
+	if (x86_match_cpu(intel_pstate_cpu_ee_disable_ids)) {
+		rc = sysfs_create_file(intel_pstate_kobject, &energy_efficiency.attr);
+		WARN_ON(rc);
+	}
 }
 /************************** sysfs end ************************/
 
@@ -1288,25 +1351,6 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
 }
 
-#define MSR_IA32_POWER_CTL_BIT_EE	19
-
-/* Disable energy efficiency optimization */
-static void intel_pstate_disable_ee(int cpu)
-{
-	u64 power_ctl;
-	int ret;
-
-	ret = rdmsrl_on_cpu(cpu, MSR_IA32_POWER_CTL, &power_ctl);
-	if (ret)
-		return;
-
-	if (!(power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE))) {
-		pr_info("Disabling energy efficiency optimization\n");
-		power_ctl |= BIT(MSR_IA32_POWER_CTL_BIT_EE);
-		wrmsrl_on_cpu(cpu, MSR_IA32_POWER_CTL, power_ctl);
-	}
-}
-
 static int atom_get_min_pstate(void)
 {
 	u64 value;
@@ -1982,10 +2026,6 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 	if (hwp_active) {
 		const struct x86_cpu_id *id;
 
-		id = x86_match_cpu(intel_pstate_cpu_ee_disable_ids);
-		if (id)
-			intel_pstate_disable_ee(cpunum);
-
 		intel_pstate_hwp_enable(cpu);
 
 		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
@@ -2803,8 +2843,17 @@ static int __init intel_pstate_init(void)
 	if (rc)
 		return rc;
 
-	if (hwp_active)
+	if (hwp_active) {
+		const struct x86_cpu_id *id;
+
+		id = x86_match_cpu(intel_pstate_cpu_ee_disable_ids);
+		if (id) {
+			set_power_ctl_ee_state(false);
+			pr_info("Disabling energy efficiency optimization\n");
+		}
+
 		pr_info("HWP enabled\n");
+	}
 
 	return 0;
 }
-- 
2.25.4

