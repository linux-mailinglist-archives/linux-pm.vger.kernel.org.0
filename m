Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67D2D7643
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436680AbgLKNKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436586AbgLKNJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:09:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D70C0613D3
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 05:09:04 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:09:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607692142;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4VQBCKJ4+HnRJCU3zNhOagznNZT44pUCdt5f+Z9lI0=;
        b=OZx/91+lN+jEfLPrv0RRhqzLS/6gpF7mtCEfnkepW0ZWPxcj4t5sgQ9FbstQPFCUGN2rx1
        4cDMyp5Xo4TK2qxaf3Q4Cj2/4dFjTErYAR1GLRg6tRln6WLR8faW8m6yfdJ8kkquMwfbug
        FAFsnd+rkO0hHy1bu/9Y7MELh0LH903F+RSWFzZ5etST5gMdLzoJc9p4nQfhhCwe8iVcN7
        yCk1IjTzwgdHfRVxBFtOsdD7aSzV/y/XdvGpKRV49b05KYC79g6aUJciQowL3qwTx7tpi7
        vFGQ4xVpegD5Yfi7gG9HlwojhMefYGJM+ShBqlLyPjVJOKeVBqbomOIPyQmCHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607692142;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4VQBCKJ4+HnRJCU3zNhOagznNZT44pUCdt5f+Z9lI0=;
        b=9r+tB63moAGGtYun1/eMj7WAP2e1L45IVFDhyKWrto10d1o8x8IkhawtDNvTAfALcmnFxv
        QMa8OLA4rHCBZlDQ==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: int340x: processor_thermal: Add
 mailbox driver
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201126171829.945969-4-srinivas.pandruvada@linux.intel.com>
References: <20201126171829.945969-4-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160769214183.3364.15780921804777717990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     729a866af3b3f63ccdb91b3af61f3e07b668b757
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//729a866af3b3f63ccdb91b3af61f3e07b668b757
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Thu, 26 Nov 2020 09:18:29 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Dec 2020 12:29:50 +01:00

thermal: int340x: processor_thermal: Add mailbox driver

Added processor thermal device mail box interface for workload hints
setting. These hints will give indication to hardware to better manage
power and thermals. The supported hints are:
idle
semi_active
burusty
sustained
battery_life

For example when the system is on battery, the hardware can be less
aggressive in power ramp up.

This will create an attribute group at
/sys/bus/pci/devices/0000:00:04.0/workload_request

This folder contains two attributes:
workload_available_types : (RO):  This shows available workload types
workload_type: (RW) : Allows to set and get current workload type
setting

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201126171829.945969-4-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/int340x_thermal/Makefile                   |   1 +-
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c |  17 +++++-
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h |   4 +-
 drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c   | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 232 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c

diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index f4e2eb7..38a2731 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -6,5 +6,6 @@ obj-$(CONFIG_INT340X_THERMAL)	+= int3403_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device.o
 obj-$(CONFIG_PROC_THERMAL_MMIO_RAPL) += processor_thermal_rapl.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_rfim.o
+obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_mbox.o
 obj-$(CONFIG_INT3406_THERMAL)	+= int3406_thermal.o
 obj-$(CONFIG_ACPI_THERMAL_REL)	+= acpi_thermal_rel.o
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index b6a7358..9e6f2a8 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -454,8 +454,18 @@ static int proc_thermal_mmio_add(struct pci_dev *pdev,
 		}
 	}
 
+	if (feature_mask & PROC_THERMAL_FEATURE_MBOX) {
+		ret = proc_thermal_mbox_add(pdev, proc_priv);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to add MBOX interface\n");
+			goto err_rem_rfim;
+		}
+	}
+
 	return 0;
 
+err_rem_rfim:
+	proc_thermal_rfim_remove(pdev);
 err_rem_rapl:
 	proc_thermal_rapl_remove();
 
@@ -472,6 +482,9 @@ static void proc_thermal_mmio_remove(struct pci_dev *pdev)
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR ||
 	    proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS)
 		proc_thermal_rfim_remove(pdev);
+
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_MBOX)
+		proc_thermal_mbox_remove(pdev);
 }
 
 static int  proc_thermal_pci_probe(struct pci_dev *pdev,
@@ -583,7 +596,7 @@ static int proc_thermal_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(proc_thermal_pm, NULL, proc_thermal_resume);
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
-	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS) },
+	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
 	{ PCI_DEVICE_DATA(INTEL, BDW_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, BSW_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, BXT0_THERMAL, 0) },
@@ -597,7 +610,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ICL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
 	{ PCI_DEVICE_DATA(INTEL, JSL_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, SKL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
-	{ PCI_DEVICE_DATA(INTEL, TGL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR) },
+	{ PCI_DEVICE_DATA(INTEL, TGL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_MBOX) },
 	{ },
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 4bbb88f..b9ed645 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -56,6 +56,7 @@ struct rapl_mmio_regs {
 #define PROC_THERMAL_FEATURE_RAPL	0x01
 #define PROC_THERMAL_FEATURE_FIVR	0x02
 #define PROC_THERMAL_FEATURE_DVFS	0x04
+#define PROC_THERMAL_FEATURE_MBOX	0x08
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
@@ -75,4 +76,7 @@ static void __maybe_unused proc_thermal_rapl_remove(void)
 int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 void proc_thermal_rfim_remove(struct pci_dev *pdev);
 
+int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+void proc_thermal_mbox_remove(struct pci_dev *pdev);
+
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
new file mode 100644
index 0000000..2c105fe
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * processor thermal device mailbox driver for Workload type hints
+ * Copyright (c) 2020, Intel Corporation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "processor_thermal_device.h"
+
+#define MBOX_CMD_WORKLOAD_TYPE_READ	0x0E
+#define MBOX_CMD_WORKLOAD_TYPE_WRITE	0x0F
+
+#define MBOX_OFFSET_DATA		0x5810
+#define MBOX_OFFSET_INTERFACE		0x5818
+
+#define MBOX_BUSY_BIT			31
+#define MBOX_RETRY_COUNT		100
+
+#define MBOX_DATA_BIT_VALID		31
+#define MBOX_DATA_BIT_AC_DC		30
+
+static DEFINE_MUTEX(mbox_lock);
+
+static int send_mbox_cmd(struct pci_dev *pdev, u8 cmd_id, u32 cmd_data, u8 *cmd_resp)
+{
+	struct proc_thermal_device *proc_priv;
+	u32 retries, data;
+	int ret;
+
+	mutex_lock(&mbox_lock);
+	proc_priv = pci_get_drvdata(pdev);
+
+	/* Poll for rb bit == 0 */
+	retries = MBOX_RETRY_COUNT;
+	do {
+		data = readl((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_INTERFACE));
+		if (data & BIT_ULL(MBOX_BUSY_BIT)) {
+			ret = -EBUSY;
+			continue;
+		}
+		ret = 0;
+		break;
+	} while (--retries);
+
+	if (ret)
+		goto unlock_mbox;
+
+	if (cmd_id == MBOX_CMD_WORKLOAD_TYPE_WRITE)
+		writel(cmd_data, (void __iomem *) ((proc_priv->mmio_base + MBOX_OFFSET_DATA)));
+
+	/* Write command register */
+	data = BIT_ULL(MBOX_BUSY_BIT) | cmd_id;
+	writel(data, (void __iomem *) ((proc_priv->mmio_base + MBOX_OFFSET_INTERFACE)));
+
+	/* Poll for rb bit == 0 */
+	retries = MBOX_RETRY_COUNT;
+	do {
+		data = readl((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_INTERFACE));
+		if (data & BIT_ULL(MBOX_BUSY_BIT)) {
+			ret = -EBUSY;
+			continue;
+		}
+
+		if (data) {
+			ret = -ENXIO;
+			goto unlock_mbox;
+		}
+
+		if (cmd_id == MBOX_CMD_WORKLOAD_TYPE_READ) {
+			data = readl((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
+			*cmd_resp = data & 0xff;
+		}
+
+		ret = 0;
+		break;
+	} while (--retries);
+
+unlock_mbox:
+	mutex_unlock(&mbox_lock);
+	return ret;
+}
+
+/* List of workload types */
+static const char * const workload_types[] = {
+	"none",
+	"idle",
+	"semi_active",
+	"burusty",
+	"sustained",
+	"battery_life",
+	NULL
+};
+
+
+static ssize_t workload_available_types_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	int i = 0;
+	int ret = 0;
+
+	while (workload_types[i] != NULL)
+		ret += sprintf(&buf[ret], "%s ", workload_types[i++]);
+
+	ret += sprintf(&buf[ret], "\n");
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(workload_available_types);
+
+static ssize_t workload_type_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	char str_preference[15];
+	u32 data = 0;
+	ssize_t ret;
+
+	ret = sscanf(buf, "%14s", str_preference);
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = match_string(workload_types, -1, str_preference);
+	if (ret < 0)
+		return ret;
+
+	ret &= 0xff;
+
+	if (ret)
+		data = BIT(MBOX_DATA_BIT_VALID) | BIT(MBOX_DATA_BIT_AC_DC);
+
+	data |= ret;
+
+	ret = send_mbox_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_WRITE, data, NULL);
+	if (ret)
+		return false;
+
+	return count;
+}
+
+static ssize_t workload_type_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 cmd_resp;
+	int ret;
+
+	ret = send_mbox_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_READ, 0, &cmd_resp);
+	if (ret)
+		return false;
+
+	cmd_resp &= 0xff;
+
+	if (cmd_resp > ARRAY_SIZE(workload_types) - 1)
+		return -EINVAL;
+
+	return sprintf(buf, "%s\n", workload_types[cmd_resp]);
+}
+
+static DEVICE_ATTR_RW(workload_type);
+
+static struct attribute *workload_req_attrs[] = {
+	&dev_attr_workload_available_types.attr,
+	&dev_attr_workload_type.attr,
+	NULL
+};
+
+static const struct attribute_group workload_req_attribute_group = {
+	.attrs = workload_req_attrs,
+	.name = "workload_request"
+};
+
+
+
+static bool workload_req_created;
+
+int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
+{
+	u8 cmd_resp;
+	int ret;
+
+	/* Check if there is a mailbox support, if fails return success */
+	ret = send_mbox_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_READ, 0, &cmd_resp);
+	if (ret)
+		return 0;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &workload_req_attribute_group);
+	if (ret)
+		return ret;
+
+	workload_req_created = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(proc_thermal_mbox_add);
+
+void proc_thermal_mbox_remove(struct pci_dev *pdev)
+{
+	if (workload_req_created)
+		sysfs_remove_group(&pdev->dev.kobj, &workload_req_attribute_group);
+
+	workload_req_created = false;
+
+}
+EXPORT_SYMBOL_GPL(proc_thermal_mbox_remove);
+
+MODULE_LICENSE("GPL v2");
