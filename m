Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E62620769
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 04:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiKHDb1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 22:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiKHDbY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 22:31:24 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65212F3B1
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 19:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667878282; x=1699414282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vQHiKPUEUo9yZZX7kHYkQ3rjbJK7zqh1vCi42BPQ5Mc=;
  b=RQzhwFLNE5UL2Byw1NoRLLXCxCiN+jXTMYNJJXkf9912nRefV8Z66Ojq
   DsechE67wYj0fDOQPodQUtA500/9QlVXe/hLD+Rmn7tX/7nNoBDZet9t+
   qY2Tf1EaJptsxDuXBuXitxgI27ugkOnHrI2f917RMvc0PWkmC+i4pSLdw
   GndL6odR9wGAqLpBm9LFbYOF+drMlo0H/ORO2ue7ZKrFStzDEuvBfVnIL
   i6Zjt7k8CvdsCfSi4PnqPnrVUnPWQqpw0ULQwAeUPk67zSmJIyR1tQ7c+
   JqTwY55KNpR/4rzU0Yunqcnza4x4IQtgZ0KFPURnKaJbFH3g5xGJ7xUiS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372732526"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="372732526"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:31:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614120234"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="614120234"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 19:31:21 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH 2/6] thermal/int340x/processor_thermal: Use Intel TCC library
Date:   Tue,  8 Nov 2022 11:33:28 +0800
Message-Id: <20221108033332.27760-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221108033332.27760-1-rui.zhang@intel.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Cleanup the code by using Intel TCC library for TCC (Thermal Control
Circuitry) MSR access.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
 .../processor_thermal_device.c                | 123 ++++--------------
 2 files changed, 25 insertions(+), 99 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 5d046de96a5d..0f511917e0e1 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -10,6 +10,7 @@ config INT340X_THERMAL
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
 	select INTEL_SOC_DTS_IOSF_CORE
+	select INTEL_TCC
 	select PROC_THERMAL_MMIO_RAPL if POWERCAP
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index a8d98f1bd6c6..a9e08dddb773 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 #include <linux/acpi.h>
+#include <linux/intel_tcc.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -68,54 +69,17 @@ static const struct attribute_group power_limit_attribute_group = {
 	.name = "power_limits"
 };
 
-static int tcc_get_offset(void)
-{
-	u64 val;
-	int err;
-
-	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
-	if (err)
-		return err;
-
-	return (val >> 24) & 0x3f;
-}
-
 static ssize_t tcc_offset_degree_celsius_show(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
-	int tcc;
-
-	tcc = tcc_get_offset();
-	if (tcc < 0)
-		return tcc;
-
-	return sprintf(buf, "%d\n", tcc);
-}
-
-static int tcc_offset_update(unsigned int tcc)
-{
-	u64 val;
-	int err;
+	int offset, ret;
 
-	if (tcc > 63)
-		return -EINVAL;
-
-	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
-	if (err)
-		return err;
-
-	if (val & BIT(31))
-		return -EPERM;
-
-	val &= ~GENMASK_ULL(29, 24);
-	val |= (tcc & 0x3f) << 24;
-
-	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
-	if (err)
-		return err;
+	ret = intel_tcc_get_offset(cpumask_any(cpu_online_mask), &offset);
+	if (ret < 0)
+		return ret;
 
-	return 0;
+	return sprintf(buf, "%d\n", offset);
 }
 
 static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
@@ -136,7 +100,7 @@ static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
 	if (kstrtouint(buf, 0, &tcc))
 		return -EINVAL;
 
-	err = tcc_offset_update(tcc);
+	err = intel_tcc_set_offset(cpumask_any(cpu_online_mask), tcc);
 	if (err)
 		return err;
 
@@ -145,66 +109,26 @@ static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
 
 static DEVICE_ATTR_RW(tcc_offset_degree_celsius);
 
-static int stored_tjmax; /* since it is fixed, we can have local storage */
-
-static int get_tjmax(void)
-{
-	u32 eax, edx;
-	u32 val;
-	int err;
-
-	err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
-	if (err)
-		return err;
-
-	val = (eax >> 16) & 0xff;
-	if (val)
-		return val;
-
-	return -EINVAL;
-}
-
-static int read_temp_msr(int *temp)
+static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
+					 int *temp)
 {
 	int cpu;
-	u32 eax, edx;
 	int err;
-	unsigned long curr_temp_off = 0;
+	int curr_temp_off;
 
 	*temp = 0;
 
 	for_each_online_cpu(cpu) {
-		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_THERM_STATUS, &eax,
-					&edx);
+		err = intel_tcc_get_temp(cpu, false, &curr_temp_off);
 		if (err)
-			goto err_ret;
-		else {
-			if (eax & 0x80000000) {
-				curr_temp_off = (eax >> 16) & 0x7f;
-				if (!*temp || curr_temp_off < *temp)
-					*temp = curr_temp_off;
-			} else {
-				err = -EINVAL;
-				goto err_ret;
-			}
-		}
+			return err;
+		if (!*temp || curr_temp_off > *temp)
+			*temp = curr_temp_off;
 	}
 
-	return 0;
-err_ret:
-	return err;
-}
+	*temp *= 1000;
 
-static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
-					 int *temp)
-{
-	int ret;
-
-	ret = read_temp_msr(temp);
-	if (!ret)
-		*temp = (stored_tjmax - *temp) * 1000;
-
-	return ret;
+	return 0;
 }
 
 static struct thermal_zone_device_ops proc_thermal_local_ops = {
@@ -286,7 +210,7 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 	acpi_status status;
 	unsigned long long tmp;
 	struct thermal_zone_device_ops *ops = NULL;
-	int ret;
+	int tjmax, ret;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
@@ -302,8 +226,7 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 	status = acpi_evaluate_integer(adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
 		/* there is no _TMP method, add local method */
-		stored_tjmax = get_tjmax();
-		if (stored_tjmax > 0)
+		if (!intel_tcc_get_tjmax(cpumask_any(cpu_online_mask), &tjmax))
 			ops = &proc_thermal_local_ops;
 	}
 
@@ -356,9 +279,10 @@ static int tcc_offset_save = -1;
 
 int proc_thermal_suspend(struct device *dev)
 {
-	tcc_offset_save = tcc_get_offset();
-	if (tcc_offset_save < 0)
-		dev_warn(dev, "failed to save offset (%d)\n", tcc_offset_save);
+	if (intel_tcc_get_offset(cpumask_any(cpu_online_mask), &tcc_offset_save)) {
+		dev_warn(dev, "failed to save offset\n");
+		tcc_offset_save = -1;
+	}
 
 	return 0;
 }
@@ -373,7 +297,7 @@ int proc_thermal_resume(struct device *dev)
 
 	/* Do not update if saving failed */
 	if (tcc_offset_save >= 0)
-		tcc_offset_update(tcc_offset_save);
+		intel_tcc_set_offset(cpumask_any(cpu_online_mask), tcc_offset_save);
 
 	return 0;
 }
@@ -460,6 +384,7 @@ void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *
 }
 EXPORT_SYMBOL_GPL(proc_thermal_mmio_remove);
 
+MODULE_IMPORT_NS(INTEL_TCC);
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

