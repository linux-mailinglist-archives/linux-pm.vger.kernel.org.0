Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D577BEA48
	for <lists+linux-pm@lfdr.de>; Mon,  9 Oct 2023 21:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378302AbjJITGG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Oct 2023 15:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346681AbjJITGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2023 15:06:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3800A6;
        Mon,  9 Oct 2023 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696878362; x=1728414362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nxuqVnBISTEgSYow6LDkzpJNOyeqOj1zIQph/kNtREE=;
  b=BT+u34m3C1xKMGPgBVj0WF1fN205I4VoYKe3SjLZOn5M54rhCVC8hgce
   LtS5gXMYrp5erhnxJLeQS3dawYC8QUIIiMZr0zY/z3fPiDeT+Hwjc/P9D
   1VgSm83RRFyUYSQ7bpr1QIsuXHEDN0PJSzCKiCwrjs7PO7dLqYJACNrhl
   SQbe9ccHHZVERNGuUktYzCtaaiHdFh7YtY1AV+j5MYg0tCV7uladcrmRP
   /5EqNBvhJ8TWFDiDG26VTCAidN9S6iRtXj1ZcCr7eBIZZV8bmBNhrSErr
   /IN1gn+mB6F/oyncD8i6ehqSR7wwkNl88LpE7zIzsUly+sOJ7W8nPWnWP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415213777"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="415213777"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823445848"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823445848"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 12:06:00 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 4/7] thermal: int340x: processor_thermal: Support power floor notifications
Date:   Mon,  9 Oct 2023 12:05:35 -0700
Message-Id: <20231009190538.2488792-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
References: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the hardware reduces the power to the minimum possible, the power
floor is notified via an interrupt. This can happen when user space
requests a power limit via powercap RAPL interface, which forces the
system to enter to the lowest power. This power floor indication can
be used as a hint to resort to other methods of reducing power than
via RAPL power limit.

Before power floor status can be read or get notifications from the
firmware, it needs to be configured via a mailbox command. Actual power
floor status is read via bit 39 of MMIO offset 0x5B18 of the processor
thermal PCI device.

To show the current power floor status and get notification
on a sysfs attribute, add additional attributes to
/sys/bus/pci/devices/0000\:00\:04.0/power_limits/

power_floor_enable : This attribute is present when a SoC supports
power floor notification. This attribute allows to enable/disable
power floor notifications.

power_floor_status : This attribute is present when a SoC supports
power floor notification. When enabled this shows the current
status of power floor.

The power floor implementation provides interfaces, which are called
from the sysfs callbacks to enable/disable and read power floor
status. Also provides two additional interface to check if the current
processor thermal device interrupt is for power floor status and
send notification to user space.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Use kernel doc as suggested by Rafael
- Code changes as suggested by Rafael
- Use common offset from header file
- Removed clearing of interrupt

 .../driver-api/thermal/intel_dptf.rst         |   8 ++
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |  68 +++++++++-
 .../processor_thermal_device.h                |   8 ++
 .../processor_thermal_power_floor.c           | 126 ++++++++++++++++++
 5 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 2d11e74ac665..55d90eafd94b 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -164,6 +164,14 @@ ABI.
 ``power_limit_1_tmax_us`` (RO)
 	Maximum powercap sysfs constraint_1_time_window_us for Intel RAPL
 
+``power_floor_status`` (RO)
+	When set to 1, hardware is not able to satisfy the requested power limit
+	via Intel RAPL.
+
+``power_floor_enable`` (RW)
+	When set to 1, enable reading and notification of power floor status.
+	Notifications are issued for changes in the power_floor_status attribute.
+
 :file:`/sys/bus/pci/devices/0000\:00\:04.0/`
 
 ``tcc_offset_degree_celsius`` (RW)
diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index f33a3ad3bef3..fe3f43924525 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -12,5 +12,6 @@ obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_rfim.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_mbox.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wt_req.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wt_hint.o
+obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_power_floor.o
 obj-$(CONFIG_INT3406_THERMAL)	+= int3406_thermal.o
 obj-$(CONFIG_ACPI_THERMAL_REL)	+= acpi_thermal_rel.o
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 29ed7d0f7022..649f67fdf345 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -26,6 +26,48 @@ static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
 	(unsigned long)proc_dev->power_limits[index].suffix * 1000); \
 }
 
+static ssize_t power_floor_status_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct proc_thermal_device *proc_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = proc_thermal_read_power_floor_status(proc_dev);
+
+	return sysfs_emit(buf, "%d\n", ret);
+}
+
+static ssize_t power_floor_enable_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct proc_thermal_device *proc_dev = dev_get_drvdata(dev);
+	bool ret;
+
+	ret = proc_thermal_power_floor_get_state(proc_dev);
+
+	return sysfs_emit(buf, "%d\n", ret);
+}
+
+static ssize_t power_floor_enable_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct proc_thermal_device *proc_dev = dev_get_drvdata(dev);
+	u8 state;
+	int ret;
+
+	if (kstrtou8(buf, 0, &state))
+		return -EINVAL;
+
+	ret = proc_thermal_power_floor_set_state(proc_dev, !!state);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 POWER_LIMIT_SHOW(0, min_uw)
 POWER_LIMIT_SHOW(0, max_uw)
 POWER_LIMIT_SHOW(0, step_uw)
@@ -50,6 +92,9 @@ static DEVICE_ATTR_RO(power_limit_1_step_uw);
 static DEVICE_ATTR_RO(power_limit_1_tmin_us);
 static DEVICE_ATTR_RO(power_limit_1_tmax_us);
 
+static DEVICE_ATTR_RO(power_floor_status);
+static DEVICE_ATTR_RW(power_floor_enable);
+
 static struct attribute *power_limit_attrs[] = {
 	&dev_attr_power_limit_0_min_uw.attr,
 	&dev_attr_power_limit_1_min_uw.attr,
@@ -61,12 +106,30 @@ static struct attribute *power_limit_attrs[] = {
 	&dev_attr_power_limit_1_tmin_us.attr,
 	&dev_attr_power_limit_0_tmax_us.attr,
 	&dev_attr_power_limit_1_tmax_us.attr,
+	&dev_attr_power_floor_status.attr,
+	&dev_attr_power_floor_enable.attr,
 	NULL
 };
 
+static umode_t power_limit_attr_visible(struct kobject *kobj, struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct proc_thermal_device *proc_dev;
+
+	if (attr != &dev_attr_power_floor_status.attr && attr != &dev_attr_power_floor_enable.attr)
+		return attr->mode;
+
+	proc_dev = dev_get_drvdata(dev);
+	if (!proc_dev || !(proc_dev->mmio_feature_mask & PROC_THERMAL_FEATURE_POWER_FLOOR))
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group power_limit_attribute_group = {
 	.attrs = power_limit_attrs,
-	.name = "power_limits"
+	.name = "power_limits",
+	.is_visible = power_limit_attr_visible,
 };
 
 static ssize_t tcc_offset_degree_celsius_show(struct device *dev,
@@ -380,6 +443,9 @@ void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *
 	    proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS)
 		proc_thermal_rfim_remove(pdev);
 
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_POWER_FLOOR)
+		proc_thermal_power_floor_set_state(proc_priv, false);
+
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_REQ)
 		proc_thermal_wt_req_remove(pdev);
 	else if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_HINT)
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index f9a381b3e55c..95c6013a33fb 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -63,6 +63,7 @@ struct rapl_mmio_regs {
 #define PROC_THERMAL_FEATURE_WT_REQ	0x08
 #define PROC_THERMAL_FEATURE_DLVR	0x10
 #define PROC_THERMAL_FEATURE_WT_HINT	0x20
+#define PROC_THERMAL_FEATURE_POWER_FLOOR	0x40
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
@@ -94,6 +95,13 @@ void proc_thermal_wt_req_remove(struct pci_dev *pdev);
 #define SOC_WT_RES_INT_STATUS_OFFSET	0x5B18
 #define SOC_WT_RES_INT_STATUS_MASK	GENMASK_ULL(3, 2)
 
+int proc_thermal_read_power_floor_status(struct proc_thermal_device *proc_priv);
+int proc_thermal_power_floor_set_state(struct proc_thermal_device *proc_priv, bool enable);
+bool proc_thermal_power_floor_get_state(struct proc_thermal_device *proc_priv);
+void proc_thermal_power_floor_intr_callback(struct pci_dev *pdev,
+					    struct proc_thermal_device *proc_priv);
+bool proc_thermal_check_power_floor_intr(struct proc_thermal_device *proc_priv);
+
 int processor_thermal_send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64 *resp);
 int processor_thermal_send_mbox_write_cmd(struct pci_dev *pdev, u16 id, u32 data);
 int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev, bool enable, int enable_bit,
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
new file mode 100644
index 000000000000..a1a108407f0f
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Processor thermal device module for registering and processing
+ * power floor. When the hardware reduces the power to the minimum
+ * possible, the power floor is notified via an interrupt.
+ *
+ * Operation:
+ * When user space enables power floor reporting:
+ * - Use mailbox to:
+ *	Enable processor thermal device interrupt
+ *
+ * - Current status of power floor is read from offset 0x5B18
+ *   bit 39.
+ *
+ * Two interface functions are provided to call when there is a
+ * thermal device interrupt:
+ * - proc_thermal_power_floor_intr():
+ *	Check if the interrupt is for change in power floor.
+ *	Called from interrupt context.
+ *
+ * - proc_thermal_power_floor_intr_callback():
+ *	Callback for interrupt processing in thread context. This involves
+ *	sending notification to user space that there is a change in the
+ *	power floor status.
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ */
+
+#include <linux/pci.h>
+#include "processor_thermal_device.h"
+
+#define SOC_POWER_FLOOR_STATUS		BIT(39)
+#define SOC_POWER_FLOOR_SHIFT		39
+
+#define SOC_POWER_FLOOR_INT_ENABLE_BIT	31
+#define SOC_POWER_FLOOR_INT_ACTIVE	BIT(3)
+
+int proc_thermal_read_power_floor_status(struct proc_thermal_device *proc_priv)
+{
+	u64 status = 0;
+
+	status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
+	return (status & SOC_POWER_FLOOR_STATUS) >> SOC_POWER_FLOOR_SHIFT;
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_read_power_floor_status, INT340X_THERMAL);
+
+static bool enable_state;
+static DEFINE_MUTEX(pf_lock);
+
+int proc_thermal_power_floor_set_state(struct proc_thermal_device *proc_priv, bool enable)
+{
+	int ret = 0;
+
+	mutex_lock(&pf_lock);
+	if (enable_state == enable)
+		goto pf_unlock;
+
+	/*
+	 * Time window parameter is not applicable to power floor interrupt configuration.
+	 * Hence use -1 for time window.
+	 */
+	ret = processor_thermal_mbox_interrupt_config(to_pci_dev(proc_priv->dev), enable,
+						      SOC_POWER_FLOOR_INT_ENABLE_BIT, -1);
+	if (!ret)
+		enable_state = enable;
+
+pf_unlock:
+	mutex_unlock(&pf_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_power_floor_set_state, INT340X_THERMAL);
+
+bool proc_thermal_power_floor_get_state(struct proc_thermal_device *proc_priv)
+{
+	return enable_state;
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_power_floor_get_state, INT340X_THERMAL);
+
+/**
+ * proc_thermal_check_power_floor_intr() - Check power floor interrupt.
+ * @proc_priv: Processor thermal device instance.
+ *
+ * Callback to check if the interrupt for power floor is active.
+ *
+ * Context: Called from interrupt context.
+ *
+ * Return: true if power floor is active, false when not active.
+ */
+bool proc_thermal_check_power_floor_intr(struct proc_thermal_device *proc_priv)
+{
+	u64 int_status;
+
+	int_status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
+	return !!(int_status & SOC_POWER_FLOOR_INT_ACTIVE);
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_check_power_floor_intr, INT340X_THERMAL);
+
+/**
+ * proc_thermal_power_floor_intr_callback() - Process power floor notification
+ * @pdev:	PCI device instance
+ * @proc_priv: Processor thermal device instance.
+ *
+ * Check if the power floor interrupt is active, if active send notification to
+ * user space for the attribute "power_limits", so that user can read the attribute
+ * and take action.
+ *
+ * Context: Called from interrupt thread context.
+ *
+ * Return: None.
+ */
+void proc_thermal_power_floor_intr_callback(struct pci_dev *pdev,
+					    struct proc_thermal_device *proc_priv)
+{
+	u64 status;
+
+	status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
+	if (!(status & SOC_POWER_FLOOR_INT_ACTIVE))
+		return;
+
+	sysfs_notify(&pdev->dev.kobj, "power_limits", "power_floor_status");
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_power_floor_intr_callback, INT340X_THERMAL);
+
+MODULE_IMPORT_NS(INT340X_THERMAL);
+MODULE_LICENSE("GPL");
-- 
2.40.1

