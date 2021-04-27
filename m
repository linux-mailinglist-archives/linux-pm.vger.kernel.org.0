Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559AB36CBF1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbhD0TpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbhD0TpS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:18 -0400
Date:   Tue, 27 Apr 2021 19:44:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDp/je16/kcgWqLpvsDABgK4t/TfFYUDVI65OY5+has=;
        b=V0npuegumGb1/bDAU5rHRu0iclwXEstmnyR2/F4w4vyo7g6a9p/RiK5TC8TPjmb2osF9Z+
        0MV4Uap5Sexg+2JoHT4Mh/UMbTPfOBUaF9E9hWPDcvcLyJty4ow13EFa+AWPTw8iwOReKQ
        XwQppJoFIyIeQzz0zJbXPvnVhkpKcmSsdrfYI2gBd4Yio3EjPdOyMQ70QSI/derKFRL3+p
        4zQ6o6SJynEEuFShSTg0Qa/64/NOo9b9g26odF6mAE3U1ZvBYFeZK/Lk8jllIqaGYzZDiu
        dBRPZd3mOm/294phX8IYdeij+jB6nggaiT2jqyOoQmfsgpjIIMwE25/5Z4ROqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDp/je16/kcgWqLpvsDABgK4t/TfFYUDVI65OY5+has=;
        b=A63gbGi/+KqkU5bCyu5DEIK64dCbAUfa0gnais9K6MTYA7AYQhC5xtmOTMWb+O7kdocWcS
        Y1HnRkPcjbV5smDA==
From:   "thermal-bot for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/intel: Introduce tcc cooling driver
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org
In-Reply-To: <20210412125901.12549-1-rui.zhang@intel.com>
References: <20210412125901.12549-1-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <161955267371.29796.10434442972680030591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     2eb87d75f980bcc7c2bd370661f8fcc4ec273ea5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2eb87d75f980bcc7c2bd370661f8fcc4ec273ea5
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Mon, 12 Apr 2021 20:59:01 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Apr 2021 09:18:57 +02:00

thermal/drivers/intel: Introduce tcc cooling driver

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

This patch has been tested on a KabyLake mobile platform from me, and also
on a CometLake platform from Doug.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210412125901.12549-1-rui.zhang@intel.com
---
 drivers/thermal/intel/Kconfig             |  11 ++-
 drivers/thermal/intel/Makefile            |   1 +-
 drivers/thermal/intel/intel_tcc_cooling.c | 129 +++++++++++++++++++++-
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/thermal/intel/intel_tcc_cooling.c

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index ce4f592..e4299ca 100644
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
index ff2ad30..5ff2afa 100644
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
index 0000000..8ec10d5
--- /dev/null
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -0,0 +1,129 @@
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
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
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
