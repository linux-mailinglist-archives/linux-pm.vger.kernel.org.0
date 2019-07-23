Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB9870E67
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 03:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbfGWBDP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 21:03:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:7612 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733149AbfGWBDP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jul 2019 21:03:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 18:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,297,1559545200"; 
   d="scan'208";a="192902952"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jul 2019 18:03:14 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] drivers: thermal: processor_thermal_device: Export sysfs inteface for TCC offset
Date:   Mon, 22 Jul 2019 18:03:02 -0700
Message-Id: <20190723010302.18048-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This change exports an interface to read tcc offset and allow writing if
the platform is not locked.

Refer to Intel SDM for details on the MSR: MSR_TEMPERATURE_TARGET.
Here TCC Activation Offset (R/W) bits allow temperature offset in degrees
in relation to TjMAX.

This change will be useful for improving performance from user space for
some platforms, if the current offset is not optimal.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../processor_thermal_device.c                | 91 ++++++++++++++++++-
 1 file changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 213ab3cc6b80..a35635129fed 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -137,6 +137,72 @@ static const struct attribute_group power_limit_attribute_group = {
 	.name = "power_limits"
 };
 
+static ssize_t tcc_offset_degree_celsius_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	u64 val;
+	int err;
+
+	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
+	if (err)
+		return err;
+
+	val = (val >> 24) & 0xff;
+	return sprintf(buf, "%d\n", (int)val);
+}
+
+static int tcc_offset_update(int tcc)
+{
+	u64 val;
+	int err;
+
+	if (!tcc)
+		return -EINVAL;
+
+	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
+	if (err)
+		return err;
+
+	val = ~GENMASK_ULL(31, 24);
+	val = (tcc & 0xff) << 24;
+
+	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int tcc_offset_save;
+
+static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	u64 val;
+	int tcc, err;
+
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, &val);
+	if (err)
+		return err;
+
+	if (!(val & BIT(30)))
+		return -EACCES;
+
+	if (kstrtoint(buf, 0, &tcc))
+		return -EINVAL;
+
+	err = tcc_offset_update(tcc);
+	if (err)
+		return err;
+
+	tcc_offset_save = tcc;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(tcc_offset_degree_celsius);
+
 static int stored_tjmax; /* since it is fixed, we can have local storage */
 
 static int get_tjmax(void)
@@ -332,6 +398,7 @@ static void proc_thermal_remove(struct proc_thermal_device *proc_priv)
 	acpi_remove_notify_handler(proc_priv->adev->handle,
 				   ACPI_DEVICE_NOTIFY, proc_thermal_notify);
 	int340x_thermal_zone_remove(proc_priv->int340x_zone);
+	sysfs_remove_file(&proc_priv->dev->kobj, &dev_attr_tcc_offset_degree_celsius.attr);
 	sysfs_remove_group(&proc_priv->dev->kobj,
 			   &power_limit_attribute_group);
 }
@@ -355,8 +422,15 @@ static int int3401_add(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "Creating sysfs group for PROC_THERMAL_PLATFORM_DEV\n");
 
-	return sysfs_create_group(&pdev->dev.kobj,
-					 &power_limit_attribute_group);
+	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_tcc_offset_degree_celsius.attr);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &power_limit_attribute_group);
+	if (ret)
+		sysfs_remove_file(&pdev->dev.kobj, &dev_attr_tcc_offset_degree_celsius.attr);
+
+	return ret;
 }
 
 static int int3401_remove(struct platform_device *pdev)
@@ -584,8 +658,15 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 
 	dev_info(&pdev->dev, "Creating sysfs group for PROC_THERMAL_PCI\n");
 
-	return sysfs_create_group(&pdev->dev.kobj,
-					 &power_limit_attribute_group);
+	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_tcc_offset_degree_celsius.attr);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &power_limit_attribute_group);
+	if (ret)
+		sysfs_remove_file(&pdev->dev.kobj, &dev_attr_tcc_offset_degree_celsius.attr);
+
+	return ret;
 }
 
 static void  proc_thermal_pci_remove(struct pci_dev *pdev)
@@ -611,6 +692,8 @@ static int proc_thermal_resume(struct device *dev)
 	proc_dev = dev_get_drvdata(dev);
 	proc_thermal_read_ppcc(proc_dev);
 
+	tcc_offset_update(tcc_offset_save);
+
 	return 0;
 }
 #else
-- 
2.17.2

