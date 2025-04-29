Return-Path: <linux-pm+bounces-26340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A6A9FE05
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 02:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6677AE023
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 00:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED64127E18;
	Tue, 29 Apr 2025 00:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZmYIJWg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70EBE5E;
	Tue, 29 Apr 2025 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745884883; cv=none; b=YZFmhvE6TAtENrSX5PxoYPL/QJ92PQDoKS/T6cTGFv6n1IyyGZrQ4WQqQmLHJNmL8Dq5USzTij3/U1CuKIhM60l53I2qTIpOnAU3pPy2S5qFhxd+JWSdrkK/hjCs6xqO+19tYpKpcCfdvIQjDvmGvQHzYSUOKhlwW9OnG4YeeWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745884883; c=relaxed/simple;
	bh=DMTHozRTXBi8rolvAqKlbTFwQB1pDhXS3qJ+JSQ+Gg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/42IAwatVjS+buWMOG2Sw7DCTlGlqvP1AFMdabSXv8/TUwtMLRkeha230t9fuO8wbwuCWpuqLpUh2PzP9pTfg8uKrTkGE755iLSsvMPww2EM/5w2VWwyWMJnOVlfyxMTh0yfSeizJozxjePJyZXoIhbOXv1QHR7TKcD+rTt/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZmYIJWg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745884882; x=1777420882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DMTHozRTXBi8rolvAqKlbTFwQB1pDhXS3qJ+JSQ+Gg0=;
  b=fZmYIJWgnSV8DrYbuusVjuGRQRZuM77tK8kY0J3csJKXbQ3aAY4t/uRp
   XZRkVdot2cKVF2tAqlow51QCw4nwdNwO3sn2xb4f1whs1xfIsSpcxjJR9
   QoFE5jE6Dus3I7hMvgTPe+jC9+zS4OAaUYJKl9i5L6mfdVrPf+VI04Lmw
   UkctdGfy0f0/gc7Jcev5+g+ZY4HHIcGHesDanegipjA3NzS4tsmUhcBE3
   nFcsKALlJAEzLxOZG/MjGv1Sm+xwLykzn7XmyjU7ah3jrg1h3B/h2JzB0
   ckQchJPgirhymDmO5winB84JK7lzjE7i7eTt5gH2IIYhQ7ZNDH6qwLvO+
   A==;
X-CSE-ConnectionGUID: 5yPrpsDFSo65Eq7wbBl7Aw==
X-CSE-MsgGUID: P7d8Qk5ZR+GUJNRulBPxog==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58864052"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58864052"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:01:19 -0700
X-CSE-ConnectionGUID: cLFWztyKSwe5JAWMlRlatg==
X-CSE-MsgGUID: jqtbEO/5Qo6MmaP0nWb60w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133386489"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa009.jf.intel.com with ESMTP; 28 Apr 2025 17:01:19 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/3] thermal: intel: int340x: Add platform temperature control interface
Date: Mon, 28 Apr 2025 17:01:08 -0700
Message-ID: <20250429000110.236243-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429000110.236243-1-srinivas.pandruvada@linux.intel.com>
References: <20250429000110.236243-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Platform Temperature Control is a dynamic control loop implemented in
hardware to manage the skin or any board temperature of a device. The
reported skin or board temperature is controlled by comparing to a
configured target temperature and adjusting the SoC (System on Chip)
performance accordingly. The feature supports up to three platform
sensors.

OEMs (Original Equipment Manufacturers) can configure this feature
through the BIOS and provide temperature input directly to the hardware
via the Platform Environment Control Interface (PECI). As a result,
this feature can operate independently of any OS-level control.

The OS interface can be used to further fine-tune the default OEM
configuration. Here are some scenarios where the OS interface is
beneficial:
Verification of Firmware Control: Check if firmware-based control is
enabled. If it is, thermal controls from the OS/user space can be
backed out.
Adjusting Target Limits: While OEMs can set an aggressive target limit,
the OS can adjust this to a less aggressive limit based on operating
modes or conditions.

Given that this is platform temperature control, it is expected that a
single user-level manager owns and manages the controls. If multiple
user-level software applications attempt to write different targets, it
can lead to unexpected behavior. For instance, on a Linux desktop, the
Linux thermal daemon can manage these temperature controls, as it has
access to all other temperature control settings.

The hardware control interface is via MMIO offsets in the processor
thermal device MMIO space. There are three instances of MMIO registers.
Refer to the platform_temperature_control.c for MMIO details.

Expose "enable" and "temperature_target" via sysfs.

There are three instances of this controls. So up to three different
sensors can be controlled independently.

Sysfs interface:

tree /sys/bus/pci/devices/0000\:00\:04.0/ptc_?_control/
/sys/bus/pci/devices/0000:00:04.0/ptc_0_control/
├── enable
└── temperature_target
/sys/bus/pci/devices/0000:00:04.0/ptc_1_control/
├── enable
└── temperature_target
/sys/bus/pci/devices/0000:00:04.0/ptc_2_control/
├── enable
└── temperature_target

Description of attributes:

Enable: 1 for enable, 0 for disable. This attribute can be used to
read the current status. User space can write 0 or 1 to disable or
enable this feature respectively.
temperature_target: Target temperature limit to which hardware
will try to limit in milli degree C.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
Rui's comments:
- Change ptc_offsets[] to ptc_offsets[PTC_MAX_INSTANCES]

Rafael's comments:
- Update commit log to remove register definition
- Moved the register definition to .c file
- Add mutex lock for concurrency
- Moved the majority of the code from macro to a function
- Use GENMASK_ULL
- Change platform_temperature_*_control to ptc_*_control
for syfs folder name

 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../platform_temperature_control.c            | 243 ++++++++++++++++++
 .../processor_thermal_device.c                |  15 +-
 .../processor_thermal_device.h                |   3 +
 4 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/platform_temperature_control.c

diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index fe3f43924525..184318d1792b 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device_pci_legacy.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device_pci.o
 obj-$(CONFIG_PROC_THERMAL_MMIO_RAPL) += processor_thermal_rapl.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_rfim.o
+obj-$(CONFIG_INT340X_THERMAL)	+= platform_temperature_control.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_mbox.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wt_req.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wt_hint.o
diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
new file mode 100644
index 000000000000..526f0d3ea055
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * processor thermal device platform temperature controls
+ * Copyright (c) 2025, Intel Corporation.
+ */
+
+/*
+ * Platform temperature controls hardware interface
+ *
+ * The hardware control interface is via MMIO offsets in the processor
+ * thermal device MMIO space. There are three instances of MMIO registers.
+ * All registers are 64 bit wide with RW access.
+ *
+ * Name: PLATFORM_TEMPERATURE_CONTROL
+ * Offsets: 0x5B20, 0x5B28, 0x5B30
+ *
+ *   Bits    Description
+ *   7:0     TARGET_TEMP : Target temperature limit to which the control
+ *           mechanism is regulating. Units: 0.5C.
+ *   8:8     ENABLE: Read current enable status of the feature or enable
+ *           feature.
+ *   11:9    GAIN: Sets the aggressiveness of control loop from 0 to 7
+ *           7 graceful, favors performance at the expense of temperature
+ *           overshoots
+ *           0 aggressive, favors tight regulation over performance
+ *   12:12   TEMPERATURE_OVERRIDE_EN
+ *           When set, hardware will use TEMPERATURE_OVERRIDE values instead
+ *           of reading from corresponding sensor.
+ *   15:13   RESERVED
+ *   23:16   MIN_PERFORMANCE_LEVEL: Minimum Performance level below which the
+ *           there will be no throttling. 0 - all levels of throttling allowed
+ *           including survivability actions. 255 - no throttling allowed.
+ *   31:24   TEMPERATURE_OVERRIDE: Allows SW to override the input temperature.
+ *           hardware will use this value instead of the sensor temperature.
+ *           Units: 0.5C.
+ *   63:32   RESERVED
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "processor_thermal_device.h"
+
+struct mmio_reg {
+	int bits;
+	u16 mask;
+	u16 shift;
+	u16 units;
+};
+
+#define MAX_ATTR_GROUP_NAME_LEN	32
+#define PTC_MAX_ATTRS		3
+
+struct ptc_data {
+	u32 offset;
+	struct attribute_group ptc_attr_group;
+	struct attribute *ptc_attrs[PTC_MAX_ATTRS];
+	struct device_attribute temperature_target_attr;
+	struct device_attribute enable_attr;
+	char group_name[MAX_ATTR_GROUP_NAME_LEN];
+};
+
+static const struct mmio_reg ptc_mmio_regs[] = {
+	{ 8, 0xFF, 0, 500}, /* temperature_target, units 0.5C*/
+	{ 1, 0x01, 8, 0}, /* enable */
+	{ 3, 0x7, 9, 0}, /* gain */
+	{ 8, 0xFF, 16, 0}, /* min_performance_level */
+	{ 1, 0x1, 12, 0}, /* temperature_override_enable */
+	{ 8, 0xFF, 24, 500}, /* temperature_override, units 0.5C */
+};
+
+#define PTC_MAX_INSTANCES	3
+
+/* Unique offset for each PTC instance */
+static u32 ptc_offsets[PTC_MAX_INSTANCES] = {0x5B20, 0x5B28, 0x5B30};
+
+/* These will represent sysfs attribute names */
+static const char * const ptc_strings[] = {
+	"temperature_target",
+	"enable",
+	NULL
+};
+
+/* Lock to protect concurrent read/write and read-modify-write */
+static DEFINE_MUTEX(ptc_lock);
+
+static ssize_t ptc_mmio_show(struct ptc_data *data, struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct proc_thermal_device *proc_priv;
+	const struct mmio_reg *mmio_regs;
+	int ret, units;
+	u64 reg_val;
+
+	proc_priv = pci_get_drvdata(pdev);
+	mmio_regs = ptc_mmio_regs;
+	ret = match_string(ptc_strings, -1, attr->attr.name);
+	if (ret < 0)
+		return ret;
+
+	units = mmio_regs[ret].units;
+
+	guard(mutex)(&ptc_lock);
+
+	reg_val = readq((void __iomem *) (proc_priv->mmio_base + data->offset));
+	ret = (reg_val >> mmio_regs[ret].shift) & mmio_regs[ret].mask;
+	if (units)
+		ret *= units;
+
+	return sysfs_emit(buf, "%d\n", ret);
+}
+
+#define PTC_SHOW(suffix)\
+static ssize_t suffix##_show(struct device *dev,\
+			     struct device_attribute *attr,\
+			     char *buf)\
+{\
+	struct ptc_data *data = container_of(attr, struct ptc_data, suffix##_attr);\
+	return ptc_mmio_show(data, dev, attr, buf);\
+}
+
+static void ptc_mmio_write(struct pci_dev *pdev, u32 offset, int index, u32 value)
+{
+	struct proc_thermal_device *proc_priv;
+	u64 mask, reg_val;
+
+	proc_priv = pci_get_drvdata(pdev);
+
+	mask = GENMASK_ULL(ptc_mmio_regs[index].shift + ptc_mmio_regs[index].bits - 1,
+			   ptc_mmio_regs[index].shift);
+
+	guard(mutex)(&ptc_lock);
+
+	reg_val = readq((void __iomem *) (proc_priv->mmio_base + offset));
+	reg_val &= ~mask;
+	reg_val |= (value << ptc_mmio_regs[index].shift);
+	writeq(reg_val, (void __iomem *) (proc_priv->mmio_base + offset));
+}
+
+static int ptc_store(struct ptc_data *data, struct device *dev, struct device_attribute *attr,
+		     const char *buf,  size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	unsigned int input;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &input);
+	if (ret)
+		return ret;
+
+	ret = match_string(ptc_strings, -1, attr->attr.name);
+	if (ret < 0)
+		return ret;
+
+	if (ptc_mmio_regs[ret].units)
+		input /= ptc_mmio_regs[ret].units;
+
+	if (input > ptc_mmio_regs[ret].mask)
+		return -EINVAL;
+
+	ptc_mmio_write(pdev, data->offset, ret, input);
+
+	return count;
+}
+
+#define PTC_STORE(suffix)\
+static ssize_t suffix##_store(struct device *dev,\
+			      struct device_attribute *attr,\
+			      const char *buf, size_t count)\
+{\
+	struct ptc_data *data = container_of(attr, struct ptc_data, suffix##_attr);\
+	return ptc_store(data, dev, attr, buf, count);\
+}
+
+PTC_SHOW(temperature_target);
+PTC_STORE(temperature_target);
+PTC_SHOW(enable);
+PTC_STORE(enable);
+
+#define ptc_init_attribute(_name)\
+	do {\
+		sysfs_attr_init(&data->_name##_attr.attr);\
+		data->_name##_attr.show = _name##_show;\
+		data->_name##_attr.store = _name##_store;\
+		data->_name##_attr.attr.name = #_name;\
+		data->_name##_attr.attr.mode = 0644;\
+	} while (0)
+
+static int ptc_create_groups(struct pci_dev *pdev, int instance, struct ptc_data *data)
+{
+	int ret, index = 0;
+
+	ptc_init_attribute(temperature_target);
+	ptc_init_attribute(enable);
+
+	data->ptc_attrs[index++] = &data->temperature_target_attr.attr;
+	data->ptc_attrs[index++] = &data->enable_attr.attr;
+	data->ptc_attrs[index] = NULL;
+
+	snprintf(data->group_name, MAX_ATTR_GROUP_NAME_LEN,
+		"ptc_%d_control", instance);
+	data->ptc_attr_group.name = data->group_name;
+	data->ptc_attr_group.attrs = data->ptc_attrs;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &data->ptc_attr_group);
+
+	return ret;
+}
+
+static struct ptc_data ptc_instance[PTC_MAX_INSTANCES];
+
+int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
+{
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_PTC) {
+		int i;
+
+		for (i = 0; i < PTC_MAX_INSTANCES; i++) {
+			ptc_instance[i].offset = ptc_offsets[i];
+			ptc_create_groups(pdev, i, &ptc_instance[i]);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(proc_thermal_ptc_add);
+
+void proc_thermal_ptc_remove(struct pci_dev *pdev)
+{
+	struct proc_thermal_device *proc_priv = pci_get_drvdata(pdev);
+
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_PTC) {
+		int i;
+
+		for (i = 0; i < PTC_MAX_INSTANCES; i++)
+			sysfs_remove_group(&pdev->dev.kobj, &ptc_instance[i].ptc_attr_group);
+	}
+}
+EXPORT_SYMBOL_GPL(proc_thermal_ptc_remove);
+
+MODULE_IMPORT_NS("INT340X_THERMAL");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Processor Thermal PTC Interface");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index c868d8b7bd1c..10841a37431c 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -399,13 +399,21 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 		}
 	}
 
+	if (feature_mask & PROC_THERMAL_FEATURE_PTC) {
+		ret = proc_thermal_ptc_add(pdev, proc_priv);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to add PTC MMIO interface\n");
+			goto err_rem_rapl;
+		}
+	}
+
 	if (feature_mask & PROC_THERMAL_FEATURE_FIVR ||
 	    feature_mask & PROC_THERMAL_FEATURE_DVFS ||
 	    feature_mask & PROC_THERMAL_FEATURE_DLVR) {
 		ret = proc_thermal_rfim_add(pdev, proc_priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to add RFIM interface\n");
-			goto err_rem_rapl;
+			goto err_rem_ptc;
 		}
 	}
 
@@ -427,6 +435,8 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 
 err_rem_rfim:
 	proc_thermal_rfim_remove(pdev);
+err_rem_ptc:
+	proc_thermal_ptc_remove(pdev);
 err_rem_rapl:
 	proc_thermal_rapl_remove();
 
@@ -439,6 +449,9 @@ void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_RAPL)
 		proc_thermal_rapl_remove();
 
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_PTC)
+		proc_thermal_ptc_remove(pdev);
+
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR ||
 	    proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS ||
 	    proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR)
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index ba2d89d3024c..9a6ca43b6fa2 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -67,6 +67,7 @@ struct rapl_mmio_regs {
 #define PROC_THERMAL_FEATURE_WT_HINT	0x20
 #define PROC_THERMAL_FEATURE_POWER_FLOOR	0x40
 #define PROC_THERMAL_FEATURE_MSI_SUPPORT	0x80
+#define PROC_THERMAL_FEATURE_PTC	0x100
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
@@ -123,4 +124,6 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 			  struct proc_thermal_device *proc_priv,
 			  kernel_ulong_t feature_mask);
 void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+void proc_thermal_ptc_remove(struct pci_dev *pdev);
 #endif
-- 
2.49.0


