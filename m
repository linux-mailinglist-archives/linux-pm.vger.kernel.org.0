Return-Path: <linux-pm+bounces-33021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9BFB3409B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC83484023
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5994E1F4CAF;
	Mon, 25 Aug 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qn0OLPlY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D227144B;
	Mon, 25 Aug 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128206; cv=none; b=pYV//0Ev/JrAmykkU6/yanbIx49UjPdT4L5mZ59AxHFSRK46AHLTGHhft/0vL1ijG+VS3rFDY7ADupqGomkJ6XBic5uptQbT7TK2dgLMu0oyV9cfL66YSWFumKJcDbuAPyi1rP2bk68XgGC6B1ruxgv3otVzWOZKqJzrGwTjy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128206; c=relaxed/simple;
	bh=J8WY/NmmefCqmYpko1TSzTVCtD/9pj+V9HVanIj+p1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgWgu0OVZijBNM0I5hvhZNy55MS47cuyPc1BWQKcqfFa4mv+jbYsjrP5kVP5OM4wsY7cLQBqkhON/Z2+b0yTDNNY9Q2jvyDrfqlrKPNEgh42B/eDhQADDsJ4Vlzv+lGFXmM3bOaw0Z96id2hOUbq6Z7L796eV2mVArQwRMHGmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qn0OLPlY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756128203; x=1787664203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8WY/NmmefCqmYpko1TSzTVCtD/9pj+V9HVanIj+p1E=;
  b=Qn0OLPlYJ5e6e54vpsqVD3H8dVbWAtsMscdaVCFRhv4+FTO+wLfW0o6w
   /0cYWA7Ia7k+hWFkZ6/LCLcjrT1kKA4tQ33Zn/BkUNzex6cMZ18j8GapH
   FkhWbsstIz9cU5GHbsZiP92G7DFehC+Z0YVTVj125pe12TtW0fhznsdnV
   YzmpqqBkmzLnooiANFEXgspVHAAmLtvyc8SgZ+bXCB1V6t8zZx/kUhr09
   wTtbJ76BkuJkZ07E9tD0jPnpx9OTdeMGwlJxoXvewB8BlA5NfMagAz/W5
   +L/90jU8hinsDGfBYSkd9asfIeyA6OePMrZLvavot8TfQuFWjpI1aPNkV
   w==;
X-CSE-ConnectionGUID: iZLCz078SamO71fyXz1dFg==
X-CSE-MsgGUID: 9vRCnepeSVymKbFqYRQ1Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58048397"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="58048397"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:23:21 -0700
X-CSE-ConnectionGUID: cAiuo5AsQzK0jNMId4X7OA==
X-CSE-MsgGUID: xT7psmVGQY6so3amVS79+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="169485277"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa008.jf.intel.com with ESMTP; 25 Aug 2025 06:23:21 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/4] thermal: intel: int340x: Add support for power slider
Date: Mon, 25 Aug 2025 06:23:12 -0700
Message-ID: <20250825132315.75521-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825132315.75521-1-srinivas.pandruvada@linux.intel.com>
References: <20250825132315.75521-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for system wide energy performance preference using a SoC
slider interface defined via processor thermal PCI device MMIO space.

Using Linux platform-profile class API, register a new platform profile.
Provide three platform power profile choices:
"performance", "balanced" and "low-power".

Profile sysfs is located at:
/sys/class/platform-profile/platform-profile-*
where attribute "name" is presented as "SoC Power Slider".

At boot by default the slider is set to balanced mode. This profile is
changed by user space based on user preference via power profile daemon
or directly writing to the "profile" sysfs attribute.

Add a CPU model specific processor thermal device feature
PROC_THERMAL_FEATURE_SOC_POWER_SLIDER. When enabled for a CPU model,
slider interface is registered.

During system suspend callback save slider register and restore during
resume callback.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

v2:
- Squashed 5/5 to this 1/5 (suspend/resume patch merged to this patch)
- Rearranged defines
- Used break instead of return in the default handling in switch/case in
the function convert_profile_to_power_slider()
- Replace dev_err() with dev_info()
- Create static inline for read/write slider offset MMIO

 drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |  20 ++
 .../processor_thermal_device.h                |   6 +
 .../processor_thermal_soc_slider.c            | 194 ++++++++++++++++++
 5 files changed, 222 insertions(+)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 4c699f0896b5..4ced7bdcd62c 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -12,6 +12,7 @@ config INT340X_THERMAL
 	select ACPI_THERMAL_LIB
 	select INTEL_SOC_DTS_IOSF_CORE
 	select INTEL_TCC
+	select ACPI_PLATFORM_PROFILE
 	select PROC_THERMAL_MMIO_RAPL if POWERCAP
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index 184318d1792b..436be34b21a9 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_mbox.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wt_req.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wt_hint.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_power_floor.o
+obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_soc_slider.o
 obj-$(CONFIG_INT3406_THERMAL)	+= int3406_thermal.o
 obj-$(CONFIG_ACPI_THERMAL_REL)	+= acpi_thermal_rel.o
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 29fcece48cad..48e7849d4816 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -338,10 +338,17 @@ static int tcc_offset_save = -1;
 
 int proc_thermal_suspend(struct device *dev)
 {
+	struct proc_thermal_device *proc_dev;
+
 	tcc_offset_save = intel_tcc_get_offset(-1);
 	if (tcc_offset_save < 0)
 		dev_warn(dev, "failed to save offset (%d)\n", tcc_offset_save);
 
+	proc_dev = dev_get_drvdata(dev);
+
+	if (proc_dev->mmio_feature_mask & PROC_THERMAL_FEATURE_SOC_POWER_SLIDER)
+		proc_thermal_soc_power_slider_suspend(proc_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(proc_thermal_suspend);
@@ -357,6 +364,9 @@ int proc_thermal_resume(struct device *dev)
 	if (tcc_offset_save >= 0)
 		intel_tcc_set_offset(-1, tcc_offset_save);
 
+	if (proc_dev->mmio_feature_mask & PROC_THERMAL_FEATURE_SOC_POWER_SLIDER)
+		proc_thermal_soc_power_slider_resume(proc_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(proc_thermal_resume);
@@ -432,8 +442,18 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 		}
 	}
 
+	if (feature_mask & PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) {
+		ret = proc_thermal_soc_power_slider_add(pdev, proc_priv);
+		if (ret) {
+			dev_info(&pdev->dev, "failed to add soc power efficiency slider\n");
+			goto err_rem_wlt;
+		}
+	}
+
 	return 0;
 
+err_rem_wlt:
+	proc_thermal_wt_hint_remove(pdev);
 err_rem_rfim:
 	proc_thermal_rfim_remove(pdev);
 err_rem_ptc:
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 49398794124a..30760475102f 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -69,6 +69,7 @@ struct rapl_mmio_regs {
 #define PROC_THERMAL_FEATURE_POWER_FLOOR	0x40
 #define PROC_THERMAL_FEATURE_MSI_SUPPORT	0x80
 #define PROC_THERMAL_FEATURE_PTC	0x100
+#define PROC_THERMAL_FEATURE_SOC_POWER_SLIDER	0x200
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
@@ -127,4 +128,9 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 void proc_thermal_ptc_remove(struct pci_dev *pdev);
+
+int proc_thermal_soc_power_slider_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+void proc_thermal_soc_power_slider_suspend(struct proc_thermal_device *proc_priv);
+void proc_thermal_soc_power_slider_resume(struct proc_thermal_device *proc_priv);
+
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
new file mode 100644
index 000000000000..3225cb38588c
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Processor Thermal Device Interface for Reading and Writing
+ * SoC Power Slider Values from User Space.
+ *
+ * Operation:
+ * The SOC_EFFICIENCY_SLIDER_0_0_0_MCHBAR register is accessed
+ * using the MMIO (Memory-Mapped I/O) interface with an MMIO offset of 0x5B38.
+ * Although this register is 64 bits wide, only bits 7:0 are used,
+ * and the other bits remain unchanged.
+ *
+ * Bit definitions
+ *
+ * Bits 2:0 (Slider value):
+ * The SoC optimizer slider value indicates the system wide energy performance
+ * hint. The slider has no specific units and ranges from 0 (highest
+ * performance) to 6 (highest energy efficiency). Value of 7 is reserved.
+ * Bits 3 : Reserved
+ * Bits 6:4 (Offset)
+ * Offset allows the SoC to automatically switch slider position in range
+ * [slider value (bits 2:0) + offset] to improve power efficiency based on
+ * internal SoC algorithms.
+ * Bit 7 (Enable):
+ * If this bit is set, the SoC Optimization sliders will be processed by the
+ * SoC firmware.
+ *
+ * Copyright (c) 2025, Intel Corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/platform_profile.h>
+#include "processor_thermal_device.h"
+
+#define SOC_POWER_SLIDER_OFFSET	0x5B38
+
+enum power_slider_preference {
+	SOC_POWER_SLIDER_PERFORMANCE,
+	SOC_POWER_SLIDER_BALANCE,
+	SOC_POWER_SLIDER_POWERSAVE,
+};
+
+#define SOC_SLIDER_VALUE_MINIMUM	0x00
+#define SOC_SLIDER_VALUE_BALANCE	0x03
+#define SOC_SLIDER_VALUE_MAXIMUM	0x06
+
+#define SLIDER_MASK		GENMASK_ULL(2, 0)
+#define SLIDER_ENABLE_BIT	7
+
+static u8 slider_values[] = {
+	[SOC_POWER_SLIDER_PERFORMANCE] = SOC_SLIDER_VALUE_MINIMUM,
+	[SOC_POWER_SLIDER_BALANCE] = SOC_SLIDER_VALUE_BALANCE,
+	[SOC_POWER_SLIDER_POWERSAVE] = SOC_SLIDER_VALUE_MAXIMUM,
+};
+
+/* Convert from platform power profile option to SoC slider value */
+static int convert_profile_to_power_slider(enum platform_profile_option profile)
+{
+	switch (profile) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		return slider_values[SOC_POWER_SLIDER_POWERSAVE];
+	case PLATFORM_PROFILE_BALANCED:
+		return slider_values[SOC_POWER_SLIDER_BALANCE];
+	case PLATFORM_PROFILE_PERFORMANCE:
+		return slider_values[SOC_POWER_SLIDER_PERFORMANCE];
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/* Convert to platform power profile option from SoC slider values */
+static int convert_power_slider_to_profile(u8 slider)
+{
+	if (slider == slider_values[SOC_POWER_SLIDER_PERFORMANCE])
+		return PLATFORM_PROFILE_PERFORMANCE;
+	if (slider == slider_values[SOC_POWER_SLIDER_BALANCE])
+		return PLATFORM_PROFILE_BALANCED;
+	if (slider == slider_values[SOC_POWER_SLIDER_POWERSAVE])
+		return PLATFORM_PROFILE_LOW_POWER;
+
+	return -EOPNOTSUPP;
+}
+
+static inline u64 read_soc_slider(struct proc_thermal_device *proc_priv)
+{
+	return readq(proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
+}
+
+static inline void write_soc_slider(struct proc_thermal_device *proc_priv, u64 val)
+{
+	writeq(val, proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
+}
+
+static void set_soc_power_profile(struct proc_thermal_device *proc_priv, int slider)
+{
+	u64 val;
+
+	val = read_soc_slider(proc_priv);
+	val &= ~SLIDER_MASK;
+	val |= (FIELD_PREP(SLIDER_MASK, slider) | BIT(SLIDER_ENABLE_BIT));
+	write_soc_slider(proc_priv, val);
+}
+
+/* profile get/set callbacks are called with a profile lock, so no need for local locks */
+
+static int power_slider_platform_profile_set(struct device *dev,
+					     enum platform_profile_option profile)
+{
+	struct proc_thermal_device *proc_priv;
+	int slider;
+
+	proc_priv = dev_get_drvdata(dev);
+	if (!proc_priv)
+		return -EOPNOTSUPP;
+
+	slider = convert_profile_to_power_slider(profile);
+	if (slider < 0)
+		return slider;
+
+	set_soc_power_profile(proc_priv, slider);
+
+	return 0;
+}
+
+static int power_slider_platform_profile_get(struct device *dev,
+					     enum platform_profile_option *profile)
+{
+	struct proc_thermal_device *proc_priv;
+	int slider, ret;
+	u64 val;
+
+	proc_priv = dev_get_drvdata(dev);
+	if (!proc_priv)
+		return -EOPNOTSUPP;
+
+	val = read_soc_slider(proc_priv);
+	slider = FIELD_GET(SLIDER_MASK, val);
+
+	ret = convert_power_slider_to_profile(slider);
+	if (ret < 0)
+		return ret;
+
+	*profile = ret;
+
+	return 0;
+}
+
+static int power_slider_platform_profile_probe(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
+static const struct platform_profile_ops power_slider_platform_profile_ops = {
+	.probe = power_slider_platform_profile_probe,
+	.profile_get = power_slider_platform_profile_get,
+	.profile_set = power_slider_platform_profile_set,
+};
+
+int proc_thermal_soc_power_slider_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
+{
+	struct device *ppdev;
+
+	set_soc_power_profile(proc_priv, slider_values[SOC_POWER_SLIDER_BALANCE]);
+
+	ppdev = devm_platform_profile_register(&pdev->dev, "SoC Power Slider", proc_priv,
+					       &power_slider_platform_profile_ops);
+
+	return PTR_ERR_OR_ZERO(ppdev);
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_soc_power_slider_add, "INT340X_THERMAL");
+
+static u64 soc_slider_save;
+
+void proc_thermal_soc_power_slider_suspend(struct proc_thermal_device *proc_priv)
+{
+	soc_slider_save = read_soc_slider(proc_priv);
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_soc_power_slider_suspend, "INT340X_THERMAL");
+
+void proc_thermal_soc_power_slider_resume(struct proc_thermal_device *proc_priv)
+{
+	write_soc_slider(proc_priv, soc_slider_save);
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_soc_power_slider_resume, "INT340X_THERMAL");
+
+MODULE_IMPORT_NS("INT340X_THERMAL");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Processor Thermal Power Slider Interface");
-- 
2.43.0


