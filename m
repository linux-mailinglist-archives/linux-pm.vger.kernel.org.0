Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB8E447B70
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 08:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhKHH6O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 02:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbhKHH6G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 02:58:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF643C061764;
        Sun,  7 Nov 2021 23:55:21 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so8159695pjb.4;
        Sun, 07 Nov 2021 23:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=e49D5wvHS1g3lmmCG0MF20nmuejShsd1i9ZTCZnfYBk=;
        b=KW8EGSPyYGndjmnn2hiI71grvTBv8Lg3MlH7EK6Ev+RvF3/JATUPgPLCNAazFiyHOw
         cBxeA1ZrXK5PlSh6u56MRhxEhyIeId9YhoA+h4Te9xb94aJKoZvZKyjuQ8h/NUlsqrQ6
         NlfKqAzKCQh/vElKVCXa9bwFKeavJG4Qhp/SJ0MpOD9QCpCEnzQ1pwxAfek/7iwbLebe
         TzU7WS8gRHBImTBw828XaB7SfbmCMniCM3QiNOgcj1lKAUrywGqiXOR0aKnZxSLGopLA
         QUxwmnrPn1TycPq4XJua+dPQ9igfLNfgU/mYKmLqbfwfjANQcHvetCtFb3eHN6JY17Rb
         uGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=e49D5wvHS1g3lmmCG0MF20nmuejShsd1i9ZTCZnfYBk=;
        b=S2D+GMfC91OPr5sfTZndQ8iegQrKeSAKScD4wRBEV1uVoyj0j5wHdJTaPhLeo9oz3h
         LxCkdde9/i3+CK+tbKJKIM8exS1CLBmx/7lh8+qnRuslQsxqh1f6qNRH7oJASN9vh1CT
         +jWKGBbvPOLVZfuzr/RAjwouQkVR83v3QW+Gmlsqs8W6SjluGXn8Om3Rwoc0s+RIsA8p
         Ermv5M4JrGFIzlclFf8yuxTHeQpGwOTHy3069aK4R+JVa3mF9J0Y5hw49Tix+1hRUlXT
         vw6Fr1nXX9y8SR2FEVp1wFxqlGPnz2/BmGke3XwXVkZT2Uwhecl/WkSqmKc00azPkB55
         6YIQ==
X-Gm-Message-State: AOAM532ZJ93xkvMIY9ch/rXM8IVlezx/e1hlA5Qu+ZRQrTaE45LpGVbU
        xkDr15jVcELLhY2mSTVZqdKKBTXc8oLJWw==
X-Google-Smtp-Source: ABdhPJxYrVEmXnc27wqrwe4T7bj79/ODehxQiR+0t1lX3H2ulUaXVIa5Pdkbs88HgZ6CDHkLuslP6Q==
X-Received: by 2002:a17:903:2445:b0:142:830:ea8e with SMTP id l5-20020a170903244500b001420830ea8emr41909663pls.54.1636358121426;
        Sun, 07 Nov 2021 23:55:21 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id ep15sm1631150pjb.3.2021.11.07.23.55.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Nov 2021 23:55:21 -0800 (PST)
From:   Edwin chiu <edwinchiu0505tw@gmail.com>
X-Google-Original-From: Edwin chiu <edwin.chiu@sunplus.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc:     Edwin chiu <edwin.chiu@sunplus.com>
Subject: [PATCH 2/2] cpuidle:sunplus:create cpuidle driver for sunplus sp7021
Date:   Mon,  8 Nov 2021 15:55:10 +0800
Message-Id: <5b22c45fb15e59e0060d07d43b242ed8db031788.1636356928.git.edwin.chiu@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1636356928.git.edwin.chiu@sunplus.com>
References: <cover.1636356928.git.edwin.chiu@sunplus.com>
In-Reply-To: <cover.1636356928.git.edwin.chiu@sunplus.com>
References: <cover.1636356928.git.edwin.chiu@sunplus.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Create cpuidle driver for sunplus sp7021 chip

Signed-off-by: Edwin chiu <edwin.chiu@sunplus.com>
---
 MAINTAINERS                                   |   5 +-
 drivers/cpuidle/Kconfig.arm                   |   7 +
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-sunplus.c             | 185 ++++++++++++++++++++++++++
 include/linux/platform_data/cpuidle-sunplus.h |  14 ++
 5 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpuidle/cpuidle-sunplus.c
 create mode 100644 include/linux/platform_data/cpuidle-sunplus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 52f17ec..050fe3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,7 +17949,10 @@ SUNPLUS CPUIDLE DRIVER
 M:	Edwin Chiu <edwin.chiu@sunplus.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
-
+F:	drivers/cpuidle/Kconfig.arm
+F:	drivers/cpuidle/Makefile
+F:	drivers/cpuidle/cpuidle-sunplus.c
+F:	include/linux/platform_data/cpuidle-sunplus.h
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 334f83e..ad9956c 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -117,3 +117,10 @@ config ARM_QCOM_SPM_CPUIDLE
 	  The Subsystem Power Manager (SPM) controls low power modes for the
 	  CPU and L2 cores. It interface with various system drivers to put
 	  the cores in low power modes.
+
+config ARM_SUNPLUS_CPUIDLE
+	bool "CPU Idle Driver For SUNPLUS SoCs"
+	depends on !ARM64
+	select DT_IDLE_STATES
+	help
+	  Select this to enable cpuidle on SP7021 processors.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 26bbc5e..0a020d1 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
 obj-$(CONFIG_ARM_PSCI_CPUIDLE_DOMAIN)	+= cpuidle-psci-domain.o
 obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
 obj-$(CONFIG_ARM_QCOM_SPM_CPUIDLE)	+= cpuidle-qcom-spm.o
+obj-$(CONFIG_ARM_SUNPLUS_CPUIDLE)		+= cpuidle-sunplus.o
 
 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-sunplus.c b/drivers/cpuidle/cpuidle-sunplus.c
new file mode 100644
index 0000000..4a7a0c0
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-sunplus.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ARM/ARM64 generic CPU idle driver.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ */
+#define pr_fmt(fmt) "CPUidle arm: " fmt
+
+#include <linux/cpu_cooling.h>
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/platform_data/cpuidle-sunplus.h>
+
+#include <asm/cpuidle.h>
+#include <asm/suspend.h>
+
+#include "dt_idle_states.h"
+
+static int sp7021_wfi_finisher(unsigned long flags)
+{
+	cpu_v7_do_idle();   // idle to WFI
+
+	return -1;
+}
+
+static int sp7021_enter_idle_state(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int idx)
+{
+	int ret;
+
+  // if idx=0, call cpu_do_idle()
+	if (!idx) {
+		cpu_v7_do_idle();
+		return idx;
+	}
+
+	// if idx>0, call cpu_suspend()
+	ret = cpu_pm_enter();
+	if (!ret) {
+	/*
+	 * Pass idle state index to cpuidle_suspend which in turn
+	 * will call the CPU ops suspend protocol with idle index as a
+	 * parameter.
+	 */
+		ret = cpu_suspend(idx, sp7021_wfi_finisher);
+	  //cpu_pm_exit();
+	}
+	cpu_pm_exit();
+
+	return ret ? -1:idx;
+}
+
+static struct cpuidle_driver sp7021_idle_driver __initdata = {
+	.name = "sp7021_idle",
+	.owner = THIS_MODULE,
+	/*
+	 * State at index 0 is standby wfi and considered standard
+	 * on all ARM platforms. If in some platforms simple wfi
+	 * can't be used as "state 0", DT bindings must be implemented
+	 * to work around this issue and allow installing a special
+	 * handler for idle state index 0.
+	 */
+	.states[0] = {
+		.enter                  = sp7021_enter_idle_state,
+		.exit_latency           = 1,
+		.target_residency       = 1,
+		.power_usage		= UINT_MAX,
+		.name                   = "WFI",
+		.desc                   = "ARM WFI",
+	}
+};
+
+static const struct of_device_id sp7021_idle_state_match[] __initconst = {
+	{ .compatible = "arm,idle-state",
+		.data = sp7021_enter_idle_state },
+	{ },
+};
+
+/*
+ * arm_idle_init - Initializes arm cpuidle driver
+ *
+ * Initializes arm cpuidle driver for all CPUs, if any CPU fails
+ * to register cpuidle driver then rollback to cancel all CPUs
+ * registration.
+ */
+static int __init sp7021_idle_init(void)
+{
+	int cpu, ret;
+	struct cpuidle_driver *drv;
+	struct cpuidle_device *dev;
+
+	drv = kmemdup(&sp7021_idle_driver, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
+	/*
+	 * Initialize idle states data, starting at index 1.  This
+	 * driver is DT only, if no DT idle states are detected (ret
+	 * == 0) let the driver initialization fail accordingly since
+	 * there is no reason to initialize the idle driver if only
+	 * wfi is supported.
+	 */
+	ret = dt_init_idle_driver(drv, sp7021_idle_state_match, 1);
+	if (ret <= 0)
+		return ret ? : -ENODEV;
+
+	ret = cpuidle_register_driver(drv);
+	if (ret) {
+		pr_err("Failed to register cpuidle driver\n");
+		return ret;
+	}
+
+	/*
+	 * Call arch CPU operations in order to initialize
+	 * idle states suspend back-end specific data
+	 */
+	for_each_possible_cpu(cpu) {
+		/*
+		 * Skip the cpuidle device initialization if the reported
+		 * failure is a HW misconfiguration/breakage (-ENXIO)
+		 */
+		if (ret == -ENXIO)
+			continue;
+
+		if (ret) {
+			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
+			goto out_fail;
+		}
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev) {
+			ret = -ENOMEM;
+			goto out_fail;
+		}
+		dev->cpu = cpu;
+
+		ret = cpuidle_register_device(dev);
+		if (ret) {
+			pr_err("Failed to register cpuidle device for CPU %d\n", cpu);
+			kfree(dev);
+			goto out_fail;
+		}
+	}
+
+	return 0;
+
+out_fail:
+	while (--cpu >= 0) {
+		dev = per_cpu(cpuidle_devices, cpu);
+		cpuidle_unregister_device(dev);
+		kfree(dev);
+	}
+	cpuidle_unregister_driver(drv);
+
+	return ret;
+}
+static int __init idle_init(void)
+{
+	int ret;
+
+	if (of_machine_is_compatible("sunplus,sp7021-achip")) {
+		sp7021_idle_init();
+		ret = 0;
+	}	else
+		ret = -1;
+
+	if (ret) {
+		pr_err("failed to cpuidle init\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+device_initcall(idle_init);
+
+MODULE_AUTHOR("Edwin Chiu <edwin.chiu@sunplus.com>");
+MODULE_DESCRIPTION("Sunplus sp7021 cpuidle driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/cpuidle-sunplus.h b/include/linux/platform_data/cpuidle-sunplus.h
new file mode 100644
index 0000000..43e6001
--- /dev/null
+++ b/include/linux/platform_data/cpuidle-sunplus.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CPUIDLE_SP7021_H
+#define __CPUIDLE_SP7021_H
+
+
+extern int cpu_v7_do_idle(void);
+
+#endif
-- 
2.7.4

