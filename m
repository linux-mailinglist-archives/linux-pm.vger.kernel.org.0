Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764713B8002
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 11:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhF3Jdf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 05:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhF3Jde (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 05:33:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE3AC061766
        for <linux-pm@vger.kernel.org>; Wed, 30 Jun 2021 02:31:05 -0700 (PDT)
Date:   Wed, 30 Jun 2021 09:31:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625045463;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwltn0cylmT4HfxdWaW4Ql6HM47Meu+mt61MnjbvdaQ=;
        b=u6hAzpMbQ4OFygrLKzKtVHNYM+1KmAMgcxgwYrNUDt/30zMPnALMJjfJaum42JnR5OwRmC
        rvBLwwCtXph76PtDmam0I9cvLW1givhT/T5nKG6YSu1rhDjtP97EKRN/yxsOSE9xqZvS03
        g8fHJbEKpgV07vPzJryvkmzYC08niQ4Rc3ENwjZNoVlJxG1+QBx0+AoJz2MQgaq5WSxtux
        EgwqqgLEp6gO5jvC6m5rQ8AIefpiNeLAuMbNRFokp5ZZ7AxOS8AozeKF8+HLvQQvUMOSVF
        2x2K1yzyAvzXQzgowBRcTdsN7i7Tb16SdFmyFHYDGAwlCHryjH9ri+76qJwPRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625045463;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwltn0cylmT4HfxdWaW4Ql6HM47Meu+mt61MnjbvdaQ=;
        b=lNW5WFyJqYxb8eXgtab2zkZaGlXDRCG5FO7R3SM1kgLk9UmQQjRjoHUPu2hrhABTEW8C36
        CLaX65kvv5mQynAw==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/int340x/processor_thermal:
 Split enumeration and processing part
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210525204811.3793651-2-srinivas.pandruvada@linux.intel.com>
References: <20210525204811.3793651-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162504546253.395.8302994205063185384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6de7a1d006ea9db235492b288312838d6878385f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6de7a1d006ea9db235492b288312838d6878385f
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Tue, 25 May 2021 13:48:10 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Jun 2021 19:00:01 +02:00

thermal/drivers/int340x/processor_thermal: Split enumeration and processing part

Remove enumeration part from the processor_thermal_device to two
different modules. One for ACPI and one for PCI:
	ACPI enumeration: int3401_thermal
	PCI part: processor_thermal_device_pci_legacy

The current processor_thermal_device now just implements interface
functions to be used by the ACPI and PCI enumeration module. This is
done by:
1. Make functions proc_thermal_add() and proc_thermal_remove() non static
and export them for usage in other processor_thermal_device_pci_legacy.c
and in int3401_thermal.c.

2. Move the sysfs file creation for TCC offset and power limit attribute
group to the proc_thermal_add() from the individual enumeration callbacks
for PCI and ACPI.

3. Create new interface functions proc_thermal_mmio_add() and
proc_thermal_mmio_remove() which will be called from the
processor_thermal_device_pci_legacy module.

4. Export proc_thermal_resume(), so that it can be used by power
management callbacks.

5. Remove special check for double enumeration as it never happens.

While here, fix some cleanup on error conditions in proc_thermal_add().

No functional changes are expected with this change.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210525204811.3793651-2-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/int340x_thermal/Makefile                              |   2 +-
 drivers/thermal/intel/int340x_thermal/int3401_thermal.c                     |  82 ++++++++++++++++++++-
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c            | 289 +++++++---------------------------------------------------------------
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h            |   8 +-
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c | 164 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 286 insertions(+), 259 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/int3401_thermal.c
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c

diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index 38a2731..aaf02d5 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -4,6 +4,8 @@ obj-$(CONFIG_INT340X_THERMAL)	+= int340x_thermal_zone.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3402_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3403_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device.o
+obj-$(CONFIG_INT340X_THERMAL)	+= int3401_thermal.o
+obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device_pci_legacy.o
 obj-$(CONFIG_PROC_THERMAL_MMIO_RAPL) += processor_thermal_rapl.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_rfim.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_mbox.o
diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
new file mode 100644
index 0000000..acebc8b
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * INT3401 processor thermal device
+ * Copyright (c) 2020, Intel Corporation.
+ */
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#include "int340x_thermal_zone.h"
+#include "processor_thermal_device.h"
+
+static const struct acpi_device_id int3401_device_ids[] = {
+	{"INT3401", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, int3401_device_ids);
+
+static int int3401_add(struct platform_device *pdev)
+{
+	struct proc_thermal_device *proc_priv;
+	int ret;
+
+	proc_priv = devm_kzalloc(&pdev->dev, sizeof(*proc_priv), GFP_KERNEL);
+	if (!proc_priv)
+		return -ENOMEM;
+
+	ret = proc_thermal_add(&pdev->dev, proc_priv);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, proc_priv);
+
+	return ret;
+}
+
+static int int3401_remove(struct platform_device *pdev)
+{
+	proc_thermal_remove(platform_get_drvdata(pdev));
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int int3401_thermal_resume(struct device *dev)
+{
+	return proc_thermal_resume(dev);
+}
+#else
+#define int3401_thermal_resume NULL
+#endif
+
+static SIMPLE_DEV_PM_OPS(int3401_proc_thermal_pm, NULL, int3401_thermal_resume);
+
+static struct platform_driver int3401_driver = {
+	.probe = int3401_add,
+	.remove = int3401_remove,
+	.driver = {
+		.name = "int3401 thermal",
+		.acpi_match_table = int3401_device_ids,
+		.pm = &int3401_proc_thermal_pm,
+	},
+};
+
+static int __init proc_thermal_init(void)
+{
+	return platform_driver_register(&int3401_driver);
+}
+
+static void __exit proc_thermal_exit(void)
+{
+	platform_driver_unregister(&int3401_driver);
+}
+
+module_init(proc_thermal_init);
+module_exit(proc_thermal_exit);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
+MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 9e6f2a8..de4fc64 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -3,34 +3,17 @@
  * processor_thermal_device.c
  * Copyright (c) 2014, Intel Corporation.
  */
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/acpi.h>
 #include <linux/thermal.h>
-#include <linux/cpuhotplug.h>
 #include "int340x_thermal_zone.h"
 #include "processor_thermal_device.h"
 #include "../intel_soc_dts_iosf.h"
 
 #define DRV_NAME "proc_thermal"
 
-enum proc_thermal_emum_mode_type {
-	PROC_THERMAL_NONE,
-	PROC_THERMAL_PCI,
-	PROC_THERMAL_PLATFORM_DEV
-};
-
-/*
- * We can have only one type of enumeration, PCI or Platform,
- * not both. So we don't need instance specific data.
- */
-static enum proc_thermal_emum_mode_type proc_thermal_emum_mode =
-							PROC_THERMAL_NONE;
-
 #define POWER_LIMIT_SHOW(index, suffix) \
 static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
 					struct device_attribute *attr, \
@@ -38,11 +21,6 @@ static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
 { \
 	struct proc_thermal_device *proc_dev = dev_get_drvdata(dev); \
 	\
-	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
-		dev_warn(dev, "Attempted to get power limit before device was initialized!\n"); \
-		return 0; \
-	} \
-	\
 	return sprintf(buf, "%lu\n",\
 	(unsigned long)proc_dev->power_limits[index].suffix * 1000); \
 }
@@ -291,11 +269,8 @@ static void proc_thermal_notify(acpi_handle handle, u32 event, void *data)
 	}
 }
 
-
-static int proc_thermal_add(struct device *dev,
-			    struct proc_thermal_device **priv)
+int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 {
-	struct proc_thermal_device *proc_priv;
 	struct acpi_device *adev;
 	acpi_status status;
 	unsigned long long tmp;
@@ -306,13 +281,8 @@ static int proc_thermal_add(struct device *dev,
 	if (!adev)
 		return -ENODEV;
 
-	proc_priv = devm_kzalloc(dev, sizeof(*proc_priv), GFP_KERNEL);
-	if (!proc_priv)
-		return -ENOMEM;
-
 	proc_priv->dev = dev;
 	proc_priv->adev = adev;
-	*priv = proc_priv;
 
 	ret = proc_thermal_read_ppcc(proc_priv);
 	if (ret)
@@ -338,15 +308,29 @@ static int proc_thermal_add(struct device *dev,
 	if (ret)
 		goto remove_zone;
 
+	ret = sysfs_create_file(&dev->kobj, &dev_attr_tcc_offset_degree_celsius.attr);
+	if (ret)
+		goto remove_notify;
+
+	ret = sysfs_create_group(&dev->kobj, &power_limit_attribute_group);
+	if (ret) {
+		sysfs_remove_file(&dev->kobj, &dev_attr_tcc_offset_degree_celsius.attr);
+		goto remove_notify;
+	}
+
 	return 0;
 
+remove_notify:
+	acpi_remove_notify_handler(adev->handle,
+				    ACPI_DEVICE_NOTIFY, proc_thermal_notify);
 remove_zone:
 	int340x_thermal_zone_remove(proc_priv->int340x_zone);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(proc_thermal_add);
 
-static void proc_thermal_remove(struct proc_thermal_device *proc_priv)
+void proc_thermal_remove(struct proc_thermal_device *proc_priv)
 {
 	acpi_remove_notify_handler(proc_priv->adev->handle,
 				   ACPI_DEVICE_NOTIFY, proc_thermal_notify);
@@ -355,60 +339,24 @@ static void proc_thermal_remove(struct proc_thermal_device *proc_priv)
 	sysfs_remove_group(&proc_priv->dev->kobj,
 			   &power_limit_attribute_group);
 }
+EXPORT_SYMBOL_GPL(proc_thermal_remove);
 
-static int int3401_add(struct platform_device *pdev)
+int proc_thermal_resume(struct device *dev)
 {
-	struct proc_thermal_device *proc_priv;
-	int ret;
-
-	if (proc_thermal_emum_mode == PROC_THERMAL_PCI) {
-		dev_err(&pdev->dev, "error: enumerated as PCI dev\n");
-		return -ENODEV;
-	}
-
-	ret = proc_thermal_add(&pdev->dev, &proc_priv);
-	if (ret)
-		return ret;
-
-	platform_set_drvdata(pdev, proc_priv);
-	proc_thermal_emum_mode = PROC_THERMAL_PLATFORM_DEV;
-
-	dev_info(&pdev->dev, "Creating sysfs group for PROC_THERMAL_PLATFORM_DEV\n");
-
-	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_tcc_offset_degree_celsius.attr);
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_group(&pdev->dev.kobj, &power_limit_attribute_group);
-	if (ret)
-		sysfs_remove_file(&pdev->dev.kobj, &dev_attr_tcc_offset_degree_celsius.attr);
+	struct proc_thermal_device *proc_dev;
 
-	return ret;
-}
+	proc_dev = dev_get_drvdata(dev);
+	proc_thermal_read_ppcc(proc_dev);
 
-static int int3401_remove(struct platform_device *pdev)
-{
-	proc_thermal_remove(platform_get_drvdata(pdev));
+	tcc_offset_update(tcc_offset_save);
 
 	return 0;
 }
-
-static irqreturn_t proc_thermal_pci_msi_irq(int irq, void *devid)
-{
-	struct proc_thermal_device *proc_priv;
-	struct pci_dev *pdev = devid;
-
-	proc_priv = pci_get_drvdata(pdev);
-
-	intel_soc_dts_iosf_interrupt_handler(proc_priv->soc_dts);
-
-	return IRQ_HANDLED;
-}
+EXPORT_SYMBOL_GPL(proc_thermal_resume);
 
 #define MCHBAR 0
 
-static int proc_thermal_set_mmio_base(struct pci_dev *pdev,
-				      struct proc_thermal_device *proc_priv)
+static int proc_thermal_set_mmio_base(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
 {
 	int ret;
 
@@ -423,9 +371,9 @@ static int proc_thermal_set_mmio_base(struct pci_dev *pdev,
 	return 0;
 }
 
-static int proc_thermal_mmio_add(struct pci_dev *pdev,
-				 struct proc_thermal_device *proc_priv,
-				 kernel_ulong_t feature_mask)
+int proc_thermal_mmio_add(struct pci_dev *pdev,
+			  struct proc_thermal_device *proc_priv,
+			  kernel_ulong_t feature_mask)
 {
 	int ret;
 
@@ -471,11 +419,10 @@ err_rem_rapl:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(proc_thermal_mmio_add);
 
-static void proc_thermal_mmio_remove(struct pci_dev *pdev)
+void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
 {
-	struct proc_thermal_device *proc_priv = pci_get_drvdata(pdev);
-
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_RAPL)
 		proc_thermal_rapl_remove();
 
@@ -486,181 +433,7 @@ static void proc_thermal_mmio_remove(struct pci_dev *pdev)
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_MBOX)
 		proc_thermal_mbox_remove(pdev);
 }
-
-static int  proc_thermal_pci_probe(struct pci_dev *pdev,
-				   const struct pci_device_id *id)
-{
-	struct proc_thermal_device *proc_priv;
-	int ret;
-
-	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) {
-		dev_err(&pdev->dev, "error: enumerated as platform dev\n");
-		return -ENODEV;
-	}
-
-	ret = pcim_enable_device(pdev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "error: could not enable device\n");
-		return ret;
-	}
-
-	ret = proc_thermal_add(&pdev->dev, &proc_priv);
-	if (ret)
-		return ret;
-
-	pci_set_drvdata(pdev, proc_priv);
-	proc_thermal_emum_mode = PROC_THERMAL_PCI;
-
-	if (pdev->device == PCI_DEVICE_ID_INTEL_BSW_THERMAL) {
-		/*
-		 * Enumerate additional DTS sensors available via IOSF.
-		 * But we are not treating as a failure condition, if
-		 * there are no aux DTSs enabled or fails. This driver
-		 * already exposes sensors, which can be accessed via
-		 * ACPI/MSR. So we don't want to fail for auxiliary DTSs.
-		 */
-		proc_priv->soc_dts = intel_soc_dts_iosf_init(
-					INTEL_SOC_DTS_INTERRUPT_MSI, 2, 0);
-
-		if (!IS_ERR(proc_priv->soc_dts) && pdev->irq) {
-			ret = pci_enable_msi(pdev);
-			if (!ret) {
-				ret = request_threaded_irq(pdev->irq, NULL,
-						proc_thermal_pci_msi_irq,
-						IRQF_ONESHOT, "proc_thermal",
-						pdev);
-				if (ret) {
-					intel_soc_dts_iosf_exit(
-							proc_priv->soc_dts);
-					pci_disable_msi(pdev);
-					proc_priv->soc_dts = NULL;
-				}
-			}
-		} else
-			dev_err(&pdev->dev, "No auxiliary DTSs enabled\n");
-	}
-
-	dev_info(&pdev->dev, "Creating sysfs group for PROC_THERMAL_PCI\n");
-
-	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_tcc_offset_degree_celsius.attr);
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_group(&pdev->dev.kobj, &power_limit_attribute_group);
-	if (ret) {
-		sysfs_remove_file(&pdev->dev.kobj, &dev_attr_tcc_offset_degree_celsius.attr);
-		return ret;
-	}
-
-	ret = proc_thermal_mmio_add(pdev, proc_priv, id->driver_data);
-	if (ret) {
-		proc_thermal_remove(proc_priv);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void  proc_thermal_pci_remove(struct pci_dev *pdev)
-{
-	struct proc_thermal_device *proc_priv = pci_get_drvdata(pdev);
-
-	if (proc_priv->soc_dts) {
-		intel_soc_dts_iosf_exit(proc_priv->soc_dts);
-		if (pdev->irq) {
-			free_irq(pdev->irq, pdev);
-			pci_disable_msi(pdev);
-		}
-	}
-
-	proc_thermal_mmio_remove(pdev);
-	proc_thermal_remove(proc_priv);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int proc_thermal_resume(struct device *dev)
-{
-	struct proc_thermal_device *proc_dev;
-
-	proc_dev = dev_get_drvdata(dev);
-	proc_thermal_read_ppcc(proc_dev);
-
-	tcc_offset_update(tcc_offset_save);
-
-	return 0;
-}
-#else
-#define proc_thermal_resume NULL
-#endif
-
-static SIMPLE_DEV_PM_OPS(proc_thermal_pm, NULL, proc_thermal_resume);
-
-static const struct pci_device_id proc_thermal_pci_ids[] = {
-	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
-	{ PCI_DEVICE_DATA(INTEL, BDW_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, BSW_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, BXT0_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, BXT1_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, BXTX_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, BXTP_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, CNL_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, CFL_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, GLK_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, HSB_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, ICL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
-	{ PCI_DEVICE_DATA(INTEL, JSL_THERMAL, 0) },
-	{ PCI_DEVICE_DATA(INTEL, SKL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
-	{ PCI_DEVICE_DATA(INTEL, TGL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_MBOX) },
-	{ },
-};
-
-MODULE_DEVICE_TABLE(pci, proc_thermal_pci_ids);
-
-static struct pci_driver proc_thermal_pci_driver = {
-	.name		= DRV_NAME,
-	.probe		= proc_thermal_pci_probe,
-	.remove		= proc_thermal_pci_remove,
-	.id_table	= proc_thermal_pci_ids,
-	.driver.pm	= &proc_thermal_pm,
-};
-
-static const struct acpi_device_id int3401_device_ids[] = {
-	{"INT3401", 0},
-	{"", 0},
-};
-MODULE_DEVICE_TABLE(acpi, int3401_device_ids);
-
-static struct platform_driver int3401_driver = {
-	.probe = int3401_add,
-	.remove = int3401_remove,
-	.driver = {
-		.name = "int3401 thermal",
-		.acpi_match_table = int3401_device_ids,
-		.pm = &proc_thermal_pm,
-	},
-};
-
-static int __init proc_thermal_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&int3401_driver);
-	if (ret)
-		return ret;
-
-	ret = pci_register_driver(&proc_thermal_pci_driver);
-
-	return ret;
-}
-
-static void __exit proc_thermal_exit(void)
-{
-	platform_driver_unregister(&int3401_driver);
-	pci_unregister_driver(&proc_thermal_pci_driver);
-}
-
-module_init(proc_thermal_init);
-module_exit(proc_thermal_exit);
+EXPORT_SYMBOL_GPL(proc_thermal_mmio_remove);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 3161607..5e51f11 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -80,5 +80,11 @@ int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 void proc_thermal_mbox_remove(struct pci_dev *pdev);
 
 int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp);
-
+int proc_thermal_add(struct device *dev, struct proc_thermal_device *priv);
+void proc_thermal_remove(struct proc_thermal_device *proc_priv);
+int proc_thermal_resume(struct device *dev);
+int proc_thermal_mmio_add(struct pci_dev *pdev,
+			  struct proc_thermal_device *proc_priv,
+			  kernel_ulong_t feature_mask);
+void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
new file mode 100644
index 0000000..21cf751
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * B0D4 processor thermal device
+ * Copyright (c) 2020, Intel Corporation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/thermal.h>
+
+#include "int340x_thermal_zone.h"
+#include "processor_thermal_device.h"
+#include "../intel_soc_dts_iosf.h"
+
+#define DRV_NAME "proc_thermal"
+
+static irqreturn_t proc_thermal_pci_msi_irq(int irq, void *devid)
+{
+	struct proc_thermal_device *proc_priv;
+	struct pci_dev *pdev = devid;
+
+	proc_priv = pci_get_drvdata(pdev);
+
+	intel_soc_dts_iosf_interrupt_handler(proc_priv->soc_dts);
+
+	return IRQ_HANDLED;
+}
+
+static int proc_thermal_pci_probe(struct pci_dev *pdev,
+				  const struct pci_device_id *id)
+{
+	struct proc_thermal_device *proc_priv;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "error: could not enable device\n");
+		return ret;
+	}
+
+	proc_priv = devm_kzalloc(&pdev->dev, sizeof(*proc_priv), GFP_KERNEL);
+	if (!proc_priv)
+		return -ENOMEM;
+
+	ret = proc_thermal_add(&pdev->dev, proc_priv);
+	if (ret)
+		return ret;
+
+	pci_set_drvdata(pdev, proc_priv);
+
+	if (pdev->device == PCI_DEVICE_ID_INTEL_BSW_THERMAL) {
+		/*
+		 * Enumerate additional DTS sensors available via IOSF.
+		 * But we are not treating as a failure condition, if
+		 * there are no aux DTSs enabled or fails. This driver
+		 * already exposes sensors, which can be accessed via
+		 * ACPI/MSR. So we don't want to fail for auxiliary DTSs.
+		 */
+		proc_priv->soc_dts = intel_soc_dts_iosf_init(
+					INTEL_SOC_DTS_INTERRUPT_MSI, 2, 0);
+
+		if (!IS_ERR(proc_priv->soc_dts) && pdev->irq) {
+			ret = pci_enable_msi(pdev);
+			if (!ret) {
+				ret = request_threaded_irq(pdev->irq, NULL,
+						proc_thermal_pci_msi_irq,
+						IRQF_ONESHOT, "proc_thermal",
+						pdev);
+				if (ret) {
+					intel_soc_dts_iosf_exit(
+							proc_priv->soc_dts);
+					pci_disable_msi(pdev);
+					proc_priv->soc_dts = NULL;
+				}
+			}
+		} else
+			dev_err(&pdev->dev, "No auxiliary DTSs enabled\n");
+	} else {
+
+	}
+
+	ret = proc_thermal_mmio_add(pdev, proc_priv, id->driver_data);
+	if (ret) {
+		proc_thermal_remove(proc_priv);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void proc_thermal_pci_remove(struct pci_dev *pdev)
+{
+	struct proc_thermal_device *proc_priv = pci_get_drvdata(pdev);
+
+	if (proc_priv->soc_dts) {
+		intel_soc_dts_iosf_exit(proc_priv->soc_dts);
+		if (pdev->irq) {
+			free_irq(pdev->irq, pdev);
+			pci_disable_msi(pdev);
+		}
+	}
+
+	proc_thermal_mmio_remove(pdev, proc_priv);
+	proc_thermal_remove(proc_priv);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int proc_thermal_pci_resume(struct device *dev)
+{
+	return proc_thermal_resume(dev);
+}
+#else
+#define proc_thermal_pci_resume NULL
+#endif
+
+static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, NULL, proc_thermal_pci_resume);
+
+static const struct pci_device_id proc_thermal_pci_ids[] = {
+	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
+	{ PCI_DEVICE_DATA(INTEL, BDW_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, BSW_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, BXT0_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, BXT1_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, BXTX_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, BXTP_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, CNL_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, CFL_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, GLK_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, HSB_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, ICL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
+	{ PCI_DEVICE_DATA(INTEL, JSL_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, SKL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
+	{ PCI_DEVICE_DATA(INTEL, TGL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_MBOX) },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(pci, proc_thermal_pci_ids);
+
+static struct pci_driver proc_thermal_pci_driver = {
+	.name		= DRV_NAME,
+	.probe		= proc_thermal_pci_probe,
+	.remove		= proc_thermal_pci_remove,
+	.id_table	= proc_thermal_pci_ids,
+	.driver.pm	= &proc_thermal_pci_pm,
+};
+
+static int __init proc_thermal_init(void)
+{
+	return pci_register_driver(&proc_thermal_pci_driver);
+}
+
+static void __exit proc_thermal_exit(void)
+{
+	pci_unregister_driver(&proc_thermal_pci_driver);
+}
+
+module_init(proc_thermal_init);
+module_exit(proc_thermal_exit);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
+MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
+MODULE_LICENSE("GPL v2");
