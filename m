Return-Path: <linux-pm+bounces-32351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A690BB25366
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 20:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36129A2122
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18EC305E27;
	Wed, 13 Aug 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHBUhWCo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70822FFDF6;
	Wed, 13 Aug 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111338; cv=none; b=GsuntJdOPd1ETQEB21twtX8fo9W3aC+mNFU9NZXQhb0Tta67tLTemyLdgLfJKJc36N5MA9KdB2IVsT6GYcVxroWAz9Es90/4m9sdCwVizOKQ12WE8IN3XayzmVf2vZgArXSuMqLs5+5dsD+23cUPNWiuMl/PSiktRItOZGf2WvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111338; c=relaxed/simple;
	bh=Ie0dJTj2bMPEL7BIu8nXzt1eyswuKdvb2tJzm4LPZFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRewvvmCUVlx+Zf56HYlQEJW4vT1occOgZteLk0S67tP85XeKEIIpWNXZcyLosG9FdYDaI7l8E/GurydeQLfxtMH0jud0dNUIHm2hqgwAlcpcRYbvmOw6k7KVBgq0jiz42DVE8uBBSx3fibKsFvzt3zUYQoDDNGZGeQTS2qujzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHBUhWCo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755111337; x=1786647337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ie0dJTj2bMPEL7BIu8nXzt1eyswuKdvb2tJzm4LPZFg=;
  b=LHBUhWCom8ASj1ipHWLtj8vb3mHUQ7D9GO1V/qKd2E8gA3vAb9H671ZF
   HdinYDcrLwHo8Q/hzbFBBTsvB4R3CWKHHsUbQd0+wCkSgOsTgNmBV5AHo
   7zlEF/mMnP3B4AFPcf8QOAL7zDbHtIriq7U9hYv0MuNNpbc5YJ+d3dt0C
   fi6U98tGLOEhw+UwvdJBGoArutoFLgCaafD6dcrORqUJoR6/Hk6VN3Mb6
   bblMEj44O3IzuaHcqo4OpbnWH7UrLyBUJ3g24iE0XMS1/oONAUGm+a/rV
   3rIzc6UBm3jUyvnRRPOxf7b9Lt1GqX9V2iWhdAg3lM5rS/+A7ucH3wdNj
   Q==;
X-CSE-ConnectionGUID: eRO1q9x0RiKfXYQlmVW6lw==
X-CSE-MsgGUID: 8RRThAKrSgG0yx6HZqMkRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56631232"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="56631232"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:55:34 -0700
X-CSE-ConnectionGUID: 1mDm1L3VSjqpHghadvmW5g==
X-CSE-MsgGUID: w99HVsxyR02p3+7YKoXiRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170755036"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2025 11:55:34 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/5] thermal: intel: int340x: Add support for power slider
Date: Wed, 13 Aug 2025 11:55:26 -0700
Message-ID: <20250813185530.635096-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
References: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
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

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |  10 +
 .../processor_thermal_device.h                |   4 +
 .../processor_thermal_soc_slider.c            | 171 ++++++++++++++++++
 5 files changed, 187 insertions(+)
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
index 29fcece48cad..4aea5c9baae9 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -432,8 +432,18 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 		}
 	}
 
+	if (feature_mask & PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) {
+		ret = proc_thermal_soc_power_slider_add(pdev, proc_priv);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to add soc power efficiency slider\n");
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
index 49398794124a..ba3f64742f2f 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -69,6 +69,7 @@ struct rapl_mmio_regs {
 #define PROC_THERMAL_FEATURE_POWER_FLOOR	0x40
 #define PROC_THERMAL_FEATURE_MSI_SUPPORT	0x80
 #define PROC_THERMAL_FEATURE_PTC	0x100
+#define PROC_THERMAL_FEATURE_SOC_POWER_SLIDER	0x200
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
@@ -127,4 +128,7 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 void proc_thermal_ptc_remove(struct pci_dev *pdev);
+
+int proc_thermal_soc_power_slider_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
new file mode 100644
index 000000000000..c492ee937dc7
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -0,0 +1,171 @@
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
+#define SOC_SLIDER_VALUE_MAXIMUM	0x06
+#define SOC_SLIDER_VALUE_BALANCE	0x03
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
+		return -EOPNOTSUPP;
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
+#define SLIDER_MASK		GENMASK_ULL(2, 0)
+#define SLIDER_ENABLE_BIT	7
+
+static void set_soc_power_profile(struct proc_thermal_device *proc_priv, int slider)
+{
+	u64 val;
+
+	val = readq(proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
+	val &= ~SLIDER_MASK;
+	val |= FIELD_PREP(SLIDER_MASK, slider);
+	val |= BIT(SLIDER_ENABLE_BIT);
+	writeq(val, proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
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
+	val = readq(proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
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
+MODULE_IMPORT_NS("INT340X_THERMAL");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Processor Thermal Power Slider Interface");
-- 
2.43.0


