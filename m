Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76A820A867
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 00:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406090AbgFYWuB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 18:50:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:29562 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405903AbgFYWuB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jun 2020 18:50:01 -0400
IronPort-SDR: /7Kw5i2Ia3ukJ9Napp97tQhGzrYG1OS1tDW5UE5/Xpq/S7FsZhqzsVmfdyKEtK//dbEJygULjy
 7dlWW41xv/DQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="145163597"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="145163597"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 15:50:00 -0700
IronPort-SDR: PGR+aiRMrJiEpVfeTkD/7FOwZYABvO/nzjR/4etEPEGm4t+mbQEfMpW3+nbCAK9y28zmMlrnfS
 gsBZ7MqJhg+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="479638543"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.228.165])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2020 15:49:59 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, peterz@infradead.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [UPDATE][PATCH v3 1/2] cpufreq: intel_pstate: Allow enable/disable energy efficiency
Date:   Thu, 25 Jun 2020 15:49:31 -0700
Message-Id: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
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
details. The scope of this bit is package wide. Also these systems
support only one package. So read/write MSR on the current CPU is
enough.

Suggested-by: Len Brown <lenb@kernel.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3 update
Moved the MSR bit definition to msr-index.h from intel_pstate.c as Doug
wanted. Offline checking with Borislav, for MSR defintion it is
fine to move to  msr-index.h even for single user of the definition. But
here the MSR definition is already in msr-index.h, but adding the MSR bit
definition also.

 Documentation/admin-guide/pm/intel_pstate.rst |  9 ++++
 arch/x86/include/asm/msr-index.h              |  1 +
 drivers/cpufreq/intel_pstate.c                | 47 ++++++++++++++++++-
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 39d80bc29ccd..1ca2684a94d7 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -431,6 +431,15 @@ argument is passed to the kernel in the command line.
 	supported in the current configuration, writes to this attribute will
 	fail with an appropriate error.
 
+``energy_efficiency_enable``
+	This attribute is only present on platforms, which has CPUs matching
+	Kaby Lake or Coffee Lake desktop CPU model. By default
+	"energy_efficiency" is disabled on these CPU models in HWP mode by this
+	driver. Enabling energy efficiency may limit maximum operating
+	frequency in both HWP and non HWP mode. In non HWP mode, this attribute
+	has an effect in turbo range only. But in HWP mode, this attribute also
+	has an effect in non turbo range.
+
 Interpretation of Policy Attributes
 -----------------------------------
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e8370e64a155..fec86ad14f8d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -254,6 +254,7 @@
 #define MSR_PEBS_FRONTEND		0x000003f7
 
 #define MSR_IA32_POWER_CTL		0x000001fc
+#define MSR_IA32_POWER_CTL_BIT_EE	19
 
 #define MSR_IA32_MC0_CTL		0x00000400
 #define MSR_IA32_MC0_STATUS		0x00000401
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8e23a698ce04..daa1d9c12098 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1218,6 +1218,42 @@ static ssize_t store_hwp_dynamic_boost(struct kobject *a,
 	return count;
 }
 
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
 
@@ -1228,6 +1264,7 @@ define_one_global_rw(min_perf_pct);
 define_one_global_ro(turbo_pct);
 define_one_global_ro(num_pstates);
 define_one_global_rw(hwp_dynamic_boost);
+define_one_global_rw(energy_efficiency_enable);
 
 static struct attribute *intel_pstate_attributes[] = {
 	&status.attr,
@@ -1241,6 +1278,8 @@ static const struct attribute_group intel_pstate_attr_group = {
 	.attrs = intel_pstate_attributes,
 };
 
+static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[];
+
 static void __init intel_pstate_sysfs_expose_params(void)
 {
 	struct kobject *intel_pstate_kobject;
@@ -1273,6 +1312,12 @@ static void __init intel_pstate_sysfs_expose_params(void)
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
 
@@ -1288,8 +1333,6 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
 }
 
-#define MSR_IA32_POWER_CTL_BIT_EE	19
-
 /* Disable energy efficiency optimization */
 static void intel_pstate_disable_ee(int cpu)
 {
-- 
2.25.4

