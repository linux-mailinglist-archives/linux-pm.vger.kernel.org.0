Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD0C650EC0
	for <lists+linux-pm@lfdr.de>; Mon, 19 Dec 2022 16:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLSPjP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 10:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiLSPjO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 10:39:14 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33691180D
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 07:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671464353; x=1703000353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WjLjJqVpr9ryArdMJb+Zb1klQB3M0pfezXp+V752k6c=;
  b=C8XbRsRtt8NCEzpkA4zSSKTrWghYkO9UqlzupPpNzFxmrdzNPMCCF1tr
   jNb9yEHKx2nDSW2wOYptmtF6bkYM/i4cDd4ayDowGlLGKZ/eC67dq51Nk
   XTndZsBkhGDMpTqjEP9WT8T2NcEyFhh2i297N4fsgrNEepT5y68TxbX7U
   yCOZKzig80iZ867oo4sm7LJTrz/Ay1MRzc419pYulUEkNQJSnEIatcTWS
   cc8As6pvzEqrcVNt870XZcp9M9jpKpyz6WRqddloLEgIlbHAjKj2uPVNI
   9Yv9CDMKBQ+VPxmjhASWPnWgsc/MRS9iAimBuvdIzQcgLDa2fgOE09o8g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="307051223"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="307051223"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 07:39:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="774960325"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="774960325"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2022 07:39:11 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 2/6] thermal/int340x/processor_thermal: Use Intel TCC library
Date:   Mon, 19 Dec 2022 23:46:16 +0800
Message-Id: <20221219154620.3630-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219154620.3630-1-rui.zhang@intel.com>
References: <20221219154620.3630-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../processor_thermal_device.c                | 119 ++++--------------
 2 files changed, 22 insertions(+), 98 deletions(-)

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
index a8d98f1bd6c6..a2ea22f2bffd 100644
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
+	int offset;
 
-	return sprintf(buf, "%d\n", tcc);
-}
-
-static int tcc_offset_update(unsigned int tcc)
-{
-	u64 val;
-	int err;
-
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
+	offset = intel_tcc_get_offset(-1);
+	if (offset < 0)
+		return offset;
 
-	return 0;
+	return sprintf(buf, "%d\n", offset);
 }
 
 static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
@@ -136,7 +100,7 @@ static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
 	if (kstrtouint(buf, 0, &tcc))
 		return -EINVAL;
 
-	err = tcc_offset_update(tcc);
+	err = intel_tcc_set_offset(-1, tcc);
 	if (err)
 		return err;
 
@@ -145,66 +109,25 @@ static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
 
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
-	int err;
-	unsigned long curr_temp_off = 0;
+	int curr_temp;
 
 	*temp = 0;
 
 	for_each_online_cpu(cpu) {
-		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_THERM_STATUS, &eax,
-					&edx);
-		if (err)
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
+		curr_temp = intel_tcc_get_temp(cpu, false);
+		if (curr_temp < 0)
+			return curr_temp;
+		if (!*temp || curr_temp > *temp)
+			*temp = curr_temp;
 	}
 
-	return 0;
-err_ret:
-	return err;
-}
-
-static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
-					 int *temp)
-{
-	int ret;
-
-	ret = read_temp_msr(temp);
-	if (!ret)
-		*temp = (stored_tjmax - *temp) * 1000;
+	*temp *= 1000;
 
-	return ret;
+	return 0;
 }
 
 static struct thermal_zone_device_ops proc_thermal_local_ops = {
@@ -302,8 +225,7 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 	status = acpi_evaluate_integer(adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
 		/* there is no _TMP method, add local method */
-		stored_tjmax = get_tjmax();
-		if (stored_tjmax > 0)
+		if (intel_tcc_get_tjmax(-1) > 0)
 			ops = &proc_thermal_local_ops;
 	}
 
@@ -356,7 +278,7 @@ static int tcc_offset_save = -1;
 
 int proc_thermal_suspend(struct device *dev)
 {
-	tcc_offset_save = tcc_get_offset();
+	tcc_offset_save = intel_tcc_get_offset(-1);
 	if (tcc_offset_save < 0)
 		dev_warn(dev, "failed to save offset (%d)\n", tcc_offset_save);
 
@@ -373,7 +295,7 @@ int proc_thermal_resume(struct device *dev)
 
 	/* Do not update if saving failed */
 	if (tcc_offset_save >= 0)
-		tcc_offset_update(tcc_offset_save);
+		intel_tcc_set_offset(-1, tcc_offset_save);
 
 	return 0;
 }
@@ -460,6 +382,7 @@ void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *
 }
 EXPORT_SYMBOL_GPL(proc_thermal_mmio_remove);
 
+MODULE_IMPORT_NS(INTEL_TCC);
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

