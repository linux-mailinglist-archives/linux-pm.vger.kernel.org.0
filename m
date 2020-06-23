Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AAF205A8D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 20:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbgFWS1S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 14:27:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:12868 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733149AbgFWS1J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 14:27:09 -0400
IronPort-SDR: cdxIC0ZwR0tH5KKyuCh1mLVZqECpPnYyEPnLXWdCoFdYswnbKYYoHJYb3enbN1U+KYjzyGwJzz
 QL1xkpLMwhKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="132578330"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="132578330"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 11:27:08 -0700
IronPort-SDR: oO4cTV/P6SdMUJshynRroAFhwkIYV4FzlUfiNEMgMTk0rT/yjiAYxhbRBeWju4mUXRkKKMNUFm
 krl/iQTq+C7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="452329753"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.228.214])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 11:27:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/2] cpufreq: intel_pstate: Allow enable/disable energy efficiency
Date:   Tue, 23 Jun 2020 11:27:04 -0700
Message-Id: <20200623182705.1425539-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200623182705.1425539-1-srinivas.pandruvada@linux.intel.com>
References: <20200623182705.1425539-1-srinivas.pandruvada@linux.intel.com>
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

So, add an additional attribute "energy_efficiency_enable" under
/sys/devices/system/cpu/intel_pstate/ for these CPU models. This allows
to read and write bit 19 ("Disable Energy Efficiency Optimization") in
the MSR IA32_POWER_CTL.

This attribute is present in both HWP and non-HWP mode as this has an
effect in both modes. Refer to Intel Software Developer's manual for
details. The scope of this bit is package wide.

Suggested-by: Len Brown <lenb@kernel.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |  7 +++
 drivers/cpufreq/intel_pstate.c                | 49 ++++++++++++++++++-
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 39d80bc29ccd..939bfdc53f4f 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -431,6 +431,13 @@ argument is passed to the kernel in the command line.
 	supported in the current configuration, writes to this attribute will
 	fail with an appropriate error.
 
+``energy_efficiency_enable``
+	This attribute is only present on platforms, which has CPUs matching
+	Kaby Lake desktop CPU model. By default "energy_efficiency" is disabled
+	on these CPU models in HWP mode by this driver. Enabling energy
+	efficiency may limit maximum operating frequency in both HWP and non
+	HWP mode.
+
 Interpretation of Policy Attributes
 -----------------------------------
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8e23a698ce04..1cf6d06f2314 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1218,6 +1218,44 @@ static ssize_t store_hwp_dynamic_boost(struct kobject *a,
 	return count;
 }
 
+#define MSR_IA32_POWER_CTL_BIT_EE	19
+
+static ssize_t show_energy_efficiency_enable(struct kobject *kobj,
+					     struct kobj_attribute *attr,
+					     char *buf)
+{
+	u64 power_ctl;
+	int enable;
+
+	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
+	enable = (power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE)) >> MSR_IA32_POWER_CTL_BIT_EE;
+	return sprintf(buf, "%d\n", !enable);
+}
+
+static ssize_t store_energy_efficiency_enable(struct kobject *a,
+					      struct kobj_attribute *b,
+					      const char *buf, size_t count)
+{
+	u64 power_ctl;
+	u32 input;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &input);
+	if (ret)
+		return ret;
+
+	mutex_lock(&intel_pstate_driver_lock);
+	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
+	if (input)
+		power_ctl &= ~BIT(MSR_IA32_POWER_CTL_BIT_EE);
+	else
+		power_ctl |= BIT(MSR_IA32_POWER_CTL_BIT_EE);
+	wrmsrl(MSR_IA32_POWER_CTL, power_ctl);
+	mutex_unlock(&intel_pstate_driver_lock);
+
+	return count;
+}
+
 show_one(max_perf_pct, max_perf_pct);
 show_one(min_perf_pct, min_perf_pct);
 
@@ -1228,6 +1266,7 @@ define_one_global_rw(min_perf_pct);
 define_one_global_ro(turbo_pct);
 define_one_global_ro(num_pstates);
 define_one_global_rw(hwp_dynamic_boost);
+define_one_global_rw(energy_efficiency_enable);
 
 static struct attribute *intel_pstate_attributes[] = {
 	&status.attr,
@@ -1241,6 +1280,8 @@ static const struct attribute_group intel_pstate_attr_group = {
 	.attrs = intel_pstate_attributes,
 };
 
+static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[];
+
 static void __init intel_pstate_sysfs_expose_params(void)
 {
 	struct kobject *intel_pstate_kobject;
@@ -1273,6 +1314,12 @@ static void __init intel_pstate_sysfs_expose_params(void)
 				       &hwp_dynamic_boost.attr);
 		WARN_ON(rc);
 	}
+
+	if (x86_match_cpu(intel_pstate_cpu_ee_disable_ids)) {
+		rc = sysfs_create_file(intel_pstate_kobject,
+				       &energy_efficiency_enable.attr);
+		WARN_ON(rc);
+	}
 }
 /************************** sysfs end ************************/
 
@@ -1288,8 +1335,6 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
 }
 
-#define MSR_IA32_POWER_CTL_BIT_EE	19
-
 /* Disable energy efficiency optimization */
 static void intel_pstate_disable_ee(int cpu)
 {
-- 
2.25.4

