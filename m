Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC143B8000
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 11:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhF3Jdf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 05:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbhF3Jdd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 05:33:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E83C06175F
        for <linux-pm@vger.kernel.org>; Wed, 30 Jun 2021 02:31:05 -0700 (PDT)
Date:   Wed, 30 Jun 2021 09:31:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625045462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZ04CVAmUtI7jkApZgd81FzRnhjDg/Xx6alHZjVyCeY=;
        b=F3yt4X5avZ6KFbbnBZfTV/Pah9nSrIn8v0SVBjwlzQm2L7jneq9PSRbvsj7Lc15UZee0ga
        4MFChXNrKBa3yAAmrzBMSQnhXwTRkpvSvVad5lv63hPRhEmxEVctR//v+mhYk09C2nd6E2
        JaJ8K7KdInDfNHv99IGFmnwJcRSxcGpplCsiXJsbkMyn4jNRla1GbcrCdxMp/RtB+IHfmV
        F0x+ADjWv/yqaippyf10AONfdY/6sBAXNVFsDx3X/+Eud21uJ0IDODoehwrVX+ninHKVab
        mBRp0hqDudYFBMRUfbCh+hRB3YCS67xlfBWaPybr5TrhPE9wAeZTIdyXj3IH5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625045462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZ04CVAmUtI7jkApZgd81FzRnhjDg/Xx6alHZjVyCeY=;
        b=pRGFYIGW1DuEb6gQcYH0pSH84y8uUfaBb1MgzZ1ZCED/wK45kxVOOIenPnjLxeOvcwwxL0
        dGyg9sL2/XRVH7CA==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/int340x/processor_thermal:
 Add PCI MMIO based thermal driver
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210525204811.3793651-3-srinivas.pandruvada@linux.intel.com>
References: <20210525204811.3793651-3-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162504546198.395.17147981517396216079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     b117ca30c44e45e4ab716ad0c22091e9cd3569f2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b117ca30c44e45e4ab716ad0c22091e9cd3569f2
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Tue, 25 May 2021 13:48:11 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 28 Jun 2021 20:57:32 +02:00

thermal/drivers/int340x/processor_thermal: Add PCI MMIO based thermal driver

Add a new PCI driver which register a thermal zone and allows to get
notification for threshold violation by a RW trip point. These
notifications are delivered from the device using MSI based
interrupt.

The main difference between this new PCI driver and the existing
one is that the temperature and trip points directly use PCI
MMIO instead of using ACPI methods.

This driver registers a thermal zone "TCPU_PCI" in addition to the
legacy processor thermal device, which uses ACPI companion device
to set name, temperature and trips.

This driver is enabled for AlderLake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210525204811.3793651-3-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/int340x_thermal/Makefile                              |   1 +-
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h            |   1 +-
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c        | 371 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c |   1 +-
 4 files changed, 373 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c

diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index aaf02d5..4e852ce 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_INT340X_THERMAL)	+= int3403_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3401_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device_pci_legacy.o
+obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device_pci.o
 obj-$(CONFIG_PROC_THERMAL_MMIO_RAPL) += processor_thermal_rapl.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_rfim.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_mbox.o
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 5e51f11..5a1cfe4 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -44,6 +44,7 @@ struct proc_thermal_device {
 	struct intel_soc_dts_sensors *soc_dts;
 	u32 mmio_feature_mask;
 	void __iomem *mmio_base;
+	void *priv_data;
 };
 
 struct rapl_mmio_regs {
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
new file mode 100644
index 0000000..ad7e2e3
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Processor thermal device for newer processors
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
+
+#define DRV_NAME "proc_thermal_pci"
+
+struct proc_thermal_pci {
+	struct pci_dev *pdev;
+	struct proc_thermal_device *proc_priv;
+	struct thermal_zone_device *tzone;
+	struct delayed_work work;
+	int stored_thres;
+	int no_legacy;
+};
+
+enum proc_thermal_mmio_type {
+	PROC_THERMAL_MMIO_TJMAX,
+	PROC_THERMAL_MMIO_PP0_TEMP,
+	PROC_THERMAL_MMIO_PP1_TEMP,
+	PROC_THERMAL_MMIO_PKG_TEMP,
+	PROC_THERMAL_MMIO_THRES_0,
+	PROC_THERMAL_MMIO_THRES_1,
+	PROC_THERMAL_MMIO_INT_ENABLE_0,
+	PROC_THERMAL_MMIO_INT_ENABLE_1,
+	PROC_THERMAL_MMIO_INT_STATUS_0,
+	PROC_THERMAL_MMIO_INT_STATUS_1,
+	PROC_THERMAL_MMIO_MAX
+};
+
+struct proc_thermal_mmio_info {
+	enum proc_thermal_mmio_type mmio_type;
+	u64	mmio_addr;
+	u64	shift;
+	u64	mask;
+};
+
+static struct proc_thermal_mmio_info proc_thermal_mmio_info[] = {
+	{ PROC_THERMAL_MMIO_TJMAX, 0x599c, 16, 0xff },
+	{ PROC_THERMAL_MMIO_PP0_TEMP, 0x597c, 0, 0xff },
+	{ PROC_THERMAL_MMIO_PP1_TEMP, 0x5980, 0, 0xff },
+	{ PROC_THERMAL_MMIO_PKG_TEMP, 0x5978, 0, 0xff },
+	{ PROC_THERMAL_MMIO_THRES_0, 0x5820, 8, 0x7F },
+	{ PROC_THERMAL_MMIO_THRES_1, 0x5820, 16, 0x7F },
+	{ PROC_THERMAL_MMIO_INT_ENABLE_0, 0x5820, 15, 0x01 },
+	{ PROC_THERMAL_MMIO_INT_ENABLE_1, 0x5820, 23, 0x01 },
+	{ PROC_THERMAL_MMIO_INT_STATUS_0, 0x7200, 6, 0x01 },
+	{ PROC_THERMAL_MMIO_INT_STATUS_1, 0x7200, 8, 0x01 },
+};
+
+#define B0D4_THERMAL_NOTIFY_DELAY	1000
+static int notify_delay_ms = B0D4_THERMAL_NOTIFY_DELAY;
+
+static void proc_thermal_mmio_read(struct proc_thermal_pci *pci_info,
+				    enum proc_thermal_mmio_type type,
+				    u32 *value)
+{
+	*value = ioread32(((u8 __iomem *)pci_info->proc_priv->mmio_base +
+				proc_thermal_mmio_info[type].mmio_addr));
+	*value >>= proc_thermal_mmio_info[type].shift;
+	*value &= proc_thermal_mmio_info[type].mask;
+}
+
+static void proc_thermal_mmio_write(struct proc_thermal_pci *pci_info,
+				     enum proc_thermal_mmio_type type,
+				     u32 value)
+{
+	u32 current_val;
+	u32 mask;
+
+	current_val = ioread32(((u8 __iomem *)pci_info->proc_priv->mmio_base +
+				proc_thermal_mmio_info[type].mmio_addr));
+	mask = proc_thermal_mmio_info[type].mask << proc_thermal_mmio_info[type].shift;
+	current_val &= ~mask;
+
+	value &= proc_thermal_mmio_info[type].mask;
+	value <<= proc_thermal_mmio_info[type].shift;
+
+	current_val |= value;
+	iowrite32(current_val, ((u8 __iomem *)pci_info->proc_priv->mmio_base +
+				proc_thermal_mmio_info[type].mmio_addr));
+}
+
+/*
+ * To avoid sending two many messages to user space, we have 1 second delay.
+ * On interrupt we are disabling interrupt and enabling after 1 second.
+ * This workload function is delayed by 1 second.
+ */
+static void proc_thermal_threshold_work_fn(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct proc_thermal_pci *pci_info = container_of(delayed_work,
+						struct proc_thermal_pci, work);
+	struct thermal_zone_device *tzone = pci_info->tzone;
+
+	if (tzone)
+		thermal_zone_device_update(tzone, THERMAL_TRIP_VIOLATED);
+
+	/* Enable interrupt flag */
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 1);
+}
+
+static void pkg_thermal_schedule_work(struct delayed_work *work)
+{
+	unsigned long ms = msecs_to_jiffies(notify_delay_ms);
+
+	schedule_delayed_work(work, ms);
+}
+
+static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
+{
+	struct proc_thermal_pci *pci_info = devid;
+	u32 status;
+
+	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_INT_STATUS_0, &status);
+
+	/* Disable enable interrupt flag */
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+	pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
+
+	pkg_thermal_schedule_work(&pci_info->work);
+
+	return IRQ_HANDLED;
+}
+
+static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
+{
+	struct proc_thermal_pci *pci_info = tzd->devdata;
+	u32 _temp;
+
+	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_PKG_TEMP, &_temp);
+	*temp = (unsigned long)_temp * 1000;
+
+	return 0;
+}
+
+static int sys_get_trip_temp(struct thermal_zone_device *tzd,
+			     int trip, int *temp)
+{
+	struct proc_thermal_pci *pci_info = tzd->devdata;
+	u32 _temp;
+
+	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_THRES_0, &_temp);
+	if (!_temp) {
+		*temp = THERMAL_TEMP_INVALID;
+	} else {
+		int tjmax;
+
+		proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_TJMAX, &tjmax);
+		_temp = tjmax - _temp;
+		*temp = (unsigned long)_temp * 1000;
+	}
+
+	return 0;
+}
+
+static int sys_get_trip_type(struct thermal_zone_device *tzd, int trip,
+			      enum thermal_trip_type *type)
+{
+	*type = THERMAL_TRIP_PASSIVE;
+
+	return 0;
+}
+
+static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
+{
+	struct proc_thermal_pci *pci_info = tzd->devdata;
+	int tjmax, _temp;
+
+	if (temp <= 0) {
+		cancel_delayed_work_sync(&pci_info->work);
+		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
+		thermal_zone_device_disable(tzd);
+		pci_info->stored_thres = 0;
+		return 0;
+	}
+
+	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_TJMAX, &tjmax);
+	_temp = tjmax - (temp / 1000);
+	if (_temp < 0)
+		return -EINVAL;
+
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, _temp);
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 1);
+
+	thermal_zone_device_enable(tzd);
+	pci_info->stored_thres = temp;
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops tzone_ops = {
+	.get_temp = sys_get_curr_temp,
+	.get_trip_temp = sys_get_trip_temp,
+	.get_trip_type = sys_get_trip_type,
+	.set_trip_temp	= sys_set_trip_temp,
+};
+
+static struct thermal_zone_params tzone_params = {
+	.governor_name = "user_space",
+	.no_hwmon = true,
+};
+
+static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct proc_thermal_device *proc_priv;
+	struct proc_thermal_pci *pci_info;
+	int irq_flag = 0, irq, ret;
+
+	proc_priv = devm_kzalloc(&pdev->dev, sizeof(*proc_priv), GFP_KERNEL);
+	if (!proc_priv)
+		return -ENOMEM;
+
+	pci_info = devm_kzalloc(&pdev->dev, sizeof(*pci_info), GFP_KERNEL);
+	if (!pci_info)
+		return -ENOMEM;
+
+	pci_info->pdev = pdev;
+	ret = pcim_enable_device(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "error: could not enable device\n");
+		return ret;
+	}
+
+	pci_set_master(pdev);
+
+	INIT_DELAYED_WORK(&pci_info->work, proc_thermal_threshold_work_fn);
+
+	ret = proc_thermal_add(&pdev->dev, proc_priv);
+	if (ret) {
+		dev_err(&pdev->dev, "error: proc_thermal_add, will continue\n");
+		pci_info->no_legacy = 1;
+	}
+
+	proc_priv->priv_data = pci_info;
+	pci_info->proc_priv = proc_priv;
+	pci_set_drvdata(pdev, proc_priv);
+
+	ret = proc_thermal_mmio_add(pdev, proc_priv, id->driver_data);
+	if (ret)
+		goto err_ret_thermal;
+
+	pci_info->tzone = thermal_zone_device_register("TCPU_PCI", 1, 1, pci_info,
+							&tzone_ops,
+							&tzone_params, 0, 0);
+	if (IS_ERR(pci_info->tzone))
+		goto err_ret_mmio;
+
+	/* request and enable interrupt */
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to allocate vectors!\n");
+		goto err_ret_tzone;
+	}
+	if (!pdev->msi_enabled && !pdev->msix_enabled)
+		irq_flag = IRQF_SHARED;
+
+	irq =  pci_irq_vector(pdev, 0);
+	ret = devm_request_threaded_irq(&pdev->dev, irq,
+					proc_thermal_irq_handler, NULL,
+					irq_flag, KBUILD_MODNAME, pci_info);
+	if (ret) {
+		dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
+		goto err_free_vectors;
+	}
+
+	return 0;
+
+err_free_vectors:
+	pci_free_irq_vectors(pdev);
+err_ret_tzone:
+	thermal_zone_device_unregister(pci_info->tzone);
+err_ret_mmio:
+	proc_thermal_mmio_remove(pdev, proc_priv);
+err_ret_thermal:
+	if (!pci_info->no_legacy)
+		proc_thermal_remove(proc_priv);
+	pci_disable_device(pdev);
+
+	return ret;
+}
+
+static void proc_thermal_pci_remove(struct pci_dev *pdev)
+{
+	struct proc_thermal_device *proc_priv = pci_get_drvdata(pdev);
+	struct proc_thermal_pci *pci_info = proc_priv->priv_data;
+
+	cancel_delayed_work_sync(&pci_info->work);
+
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+
+	devm_free_irq(&pdev->dev, pdev->irq, pci_info);
+	pci_free_irq_vectors(pdev);
+
+	thermal_zone_device_unregister(pci_info->tzone);
+	proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
+	if (!pci_info->no_legacy)
+		proc_thermal_remove(proc_priv);
+	pci_disable_device(pdev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int proc_thermal_pci_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct proc_thermal_device *proc_priv;
+	struct proc_thermal_pci *pci_info;
+
+	proc_priv = pci_get_drvdata(pdev);
+	pci_info = proc_priv->priv_data;
+
+	if (pci_info->stored_thres) {
+		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0,
+					 pci_info->stored_thres / 1000);
+		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 1);
+	}
+
+	if (!pci_info->no_legacy)
+		return proc_thermal_resume(dev);
+
+	return 0;
+}
+#else
+#define proc_thermal_pci_resume NULL
+#endif
+
+static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, NULL, proc_thermal_pci_resume);
+
+static const struct pci_device_id proc_thermal_pci_ids[] = {
+	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(pci, proc_thermal_pci_ids);
+
+static struct pci_driver proc_thermal_pci_driver = {
+	.name		= DRV_NAME,
+	.probe		= proc_thermal_pci_probe,
+	.remove	= proc_thermal_pci_remove,
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
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
index 21cf751..f5fc179 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
@@ -118,7 +118,6 @@ static int proc_thermal_pci_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, NULL, proc_thermal_pci_resume);
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
-	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
 	{ PCI_DEVICE_DATA(INTEL, BDW_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, BSW_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, BXT0_THERMAL, 0) },
