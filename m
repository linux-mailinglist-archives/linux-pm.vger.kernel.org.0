Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9752C5A62
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404255AbgKZRSi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:18:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:50836 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404254AbgKZRSh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 12:18:37 -0500
IronPort-SDR: oY99ejYTJRTeTw6LFHTnA32iNY0xmGqRQKqTMBDLxSJZlU2ECzo0tHSvPEyyvZ1GyMBfKPQirO
 BMZhHL00WnVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="190462922"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="190462922"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 09:18:37 -0800
IronPort-SDR: +a5Jo6CwnTAhxNbZhmXnxphLIQqWIDO+aOMUWqST1v6BOffH+DYG++UGXvCloskwDSl2aiNuWL
 6SjCFee22iuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="313450935"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2020 09:18:36 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/4] thermal: int340x: processor_thermal: Add mailbox driver
Date:   Thu, 26 Nov 2020 09:18:29 -0800
Message-Id: <20201126171829.945969-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201126171829.945969-1-srinivas.pandruvada@linux.intel.com>
References: <20201126171829.945969-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
---
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |  17 +-
 .../processor_thermal_device.h                |   4 +
 .../int340x_thermal/processor_thermal_mbox.c  | 212 ++++++++++++++++++
 4 files changed, 232 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c

diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index f4e2eb7d9606..38a2731e503c 100644
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
index b6a7358b989d..9e6f2a895a23 100644
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
index 4bbb88f6b4a7..b9ed64561aaf 100644
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
index 000000000000..2c105fed2d7b
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
-- 
2.25.4

