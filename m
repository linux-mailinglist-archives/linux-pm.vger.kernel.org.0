Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7913235B5A0
	for <lists+linux-pm@lfdr.de>; Sun, 11 Apr 2021 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhDKOP0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Apr 2021 10:15:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:51666 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235616AbhDKOP0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 11 Apr 2021 10:15:26 -0400
IronPort-SDR: Ul0BMtDGjnDXrt1YZBQnghIRFY7RzYB/gdEd+TKIHKvszTLHL1Ambkw1X79rnXLeWWXLO/jF/2
 sEbgwplPp35A==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="279328730"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="279328730"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 07:15:09 -0700
IronPort-SDR: mfRIHIjR5bMmGGYkxe1BCpYhQUMs+QuyNqdKhH3bs4dcNqfEdwM9/hZZity3pnEGRM/mX5fxOu
 TB1xxCa+9gvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="423441349"
Received: from power-sh.sh.intel.com ([10.239.48.130])
  by orsmga008.jf.intel.com with ESMTP; 11 Apr 2021 07:15:08 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, dsmythies@telus.net,
        srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com
Subject: [PATCH V2] thermal: intel: introduce tcc cooling driver
Date:   Sun, 11 Apr 2021 22:26:13 +0800
Message-Id: <20210411142613.9584-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Intel processors, the core frequency can be reduced below OS request,
when the current temperature reaches the TCC (Thermal Control Circuit)
activation temperature.

The default TCC activation temperature is specified by
MSR_IA32_TEMPERATURE_TARGET. However, it can be adjusted by specifying an
offset in degrees C, using the TCC Offset bits in the same MSR register.

This patch introduces a cooling devices driver that utilizes the TCC
Offset feature. The bigger the current cooling state is, the lower the
effective TCC activation temperature is, so that the processors can be
throttled earlier before system critical overheats.

Note that, on different platforms, the behavior might be different on
how fast the setting takes effect, and how much the CPU frequency is
reduced.

This patch has been tested on a KBL mobile platform.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
V2:
  Add a note in both Kconfig description and changelog, to clarify that
  the behavior might not be consistent cross platforms.
---
 drivers/thermal/intel/Kconfig             |  11 ++
 drivers/thermal/intel/Makefile            |   1 +
 drivers/thermal/intel/intel_tcc_cooling.c | 128 ++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 drivers/thermal/intel/intel_tcc_cooling.c

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index ce4f59213c7a..e4299ca3423c 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -79,3 +79,14 @@ config INTEL_PCH_THERMAL
 	  Enable this to support thermal reporting on certain intel PCHs.
 	  Thermal reporting device will provide temperature reading,
 	  programmable trip points and other information.
+
+config INTEL_TCC_COOLING
+	tristate "Intel TCC offset cooling Driver"
+	depends on X86
+	help
+	  Enable this to support system cooling by adjusting the effective TCC
+	  activation temperature via the TCC Offset register, which is widely
+	  supported on modern Intel platforms.
+	  Note that, on different platforms, the behavior might be different
+	  on how fast the setting takes effect, and how much the CPU frequency
+	  is reduced.
diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
index ff2ad30ef397..5ff2afa388f7 100644
--- a/drivers/thermal/intel/Makefile
+++ b/drivers/thermal/intel/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL)	+= intel_quark_dts_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
 obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
 obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
+obj-$(CONFIG_INTEL_TCC_COOLING)	+= intel_tcc_cooling.o
 obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
new file mode 100644
index 000000000000..aa6bbb9ba898
--- /dev/null
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cooling device driver that activates the processor throttling by
+ * programming the TCC Offset register.
+ * Copyright (c) 2021, Intel Corporation.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/thermal.h>
+#include <asm/cpu_device_id.h>
+
+#define TCC_SHIFT 24
+#define TCC_MASK	(0x3fULL<<24)
+#define TCC_PROGRAMMABLE	BIT(30)
+
+static struct thermal_cooling_device *tcc_cdev;
+
+static int tcc_get_max_state(struct thermal_cooling_device *cdev, unsigned long
+			     *state)
+{
+	*state = TCC_MASK >> TCC_SHIFT;
+	return 0;
+}
+
+static int tcc_offset_update(int tcc)
+{
+	u64 val;
+	int err;
+
+	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
+	if (err)
+		return err;
+
+	val &= ~TCC_MASK;
+	val |= tcc << TCC_SHIFT;
+
+	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int tcc_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
+			     *state)
+{
+	u64 val;
+	int err;
+
+	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
+	if (err)
+		return err;
+
+	*state = (val & TCC_MASK) >> TCC_SHIFT;
+	return 0;
+}
+
+static int tcc_set_cur_state(struct thermal_cooling_device *cdev, unsigned long
+			     state)
+{
+	return tcc_offset_update(state);
+}
+
+static const struct thermal_cooling_device_ops tcc_cooling_ops = {
+	.get_max_state = tcc_get_max_state,
+	.get_cur_state = tcc_get_cur_state,
+	.set_cur_state = tcc_set_cur_state,
+};
+
+static const struct x86_cpu_id tcc_ids[] __initconst = {
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
+	{}
+};
+
+MODULE_DEVICE_TABLE(x86cpu, tcc_ids);
+
+static int __init tcc_cooling_init(void)
+{
+	int ret;
+	u64 val;
+	const struct x86_cpu_id *id;
+
+	int err;
+
+	id = x86_match_cpu(tcc_ids);
+	if (!id)
+		return -ENODEV;
+
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, &val);
+	if (err)
+		return err;
+
+	if (!(val & TCC_PROGRAMMABLE))
+		return -ENODEV;
+
+	pr_info("Programmable TCC Offset detected\n");
+
+	tcc_cdev =
+	    thermal_cooling_device_register("TCC Offset", NULL,
+					    &tcc_cooling_ops);
+	if (IS_ERR(tcc_cdev)) {
+		ret = PTR_ERR(tcc_cdev);
+		return ret;
+	}
+	return 0;
+}
+
+module_init(tcc_cooling_init)
+
+static void __exit tcc_cooling_exit(void)
+{
+	thermal_cooling_device_unregister(tcc_cdev);
+}
+
+module_exit(tcc_cooling_exit)
+
+MODULE_DESCRIPTION("TCC offset cooling device Driver");
+MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

