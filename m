Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7969DAC62
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 14:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502416AbfJQMfm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 08:35:42 -0400
Received: from [217.140.110.172] ([217.140.110.172]:41484 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2502412AbfJQMfl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Oct 2019 08:35:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA9AF1C00;
        Thu, 17 Oct 2019 05:35:16 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F3AA83F718;
        Thu, 17 Oct 2019 05:35:15 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: [PATCH v2 2/5] cpufreq: merge arm_big_little and vexpress-spc
Date:   Thu, 17 Oct 2019 13:35:05 +0100
Message-Id: <20191017123508.26130-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017123508.26130-1-sudeep.holla@arm.com>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

arm_big_little cpufreq driver was designed as a generic big little
driver that could be used by any platform and make use of bL switcher.
Over years alternate solutions have be designed and merged to deal with
bL/HMP systems like EAS.

Also since no other driver made use of generic arm_big_little cpufreq
driver except Vexpress SPC, we can merge them together as vexpress-spc
driver used only on Vexpress TC2(CA15_CA7) platform.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 MAINTAINERS                                   |  5 +-
 drivers/cpufreq/Kconfig.arm                   | 12 +--
 drivers/cpufreq/Makefile                      |  2 -
 drivers/cpufreq/arm_big_little.h              | 43 ----------
 ...rm_big_little.c => vexpress-spc-cpufreq.c} | 79 +++++++++++++++----
 5 files changed, 67 insertions(+), 74 deletions(-)
 delete mode 100644 drivers/cpufreq/arm_big_little.h
 rename drivers/cpufreq/{arm_big_little.c => vexpress-spc-cpufreq.c} (90%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..78a4adff7892 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4269,14 +4269,13 @@ F:	include/linux/cpufreq.h
 F:	include/linux/sched/cpufreq.h
 F:	tools/testing/selftests/cpufreq/
 
-CPU FREQUENCY DRIVERS - ARM BIG LITTLE
+CPU FREQUENCY DRIVERS - VEXPRESS SPC ARM BIG LITTLE
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-pm@vger.kernel.org
 W:	http://www.arm.com/products/processors/technologies/biglittleprocessing.php
 S:	Maintained
-F:	drivers/cpufreq/arm_big_little.h
-F:	drivers/cpufreq/arm_big_little.c
+F:	drivers/cpufreq/vexpress-spc-cpufreq.c
 
 CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a905796f7f85..3858d86cf409 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -49,14 +49,6 @@ config ARM_ARMADA_8K_CPUFREQ
 
 	  If in doubt, say N.
 
-# big LITTLE core layer and glue drivers
-config ARM_BIG_LITTLE_CPUFREQ
-	tristate "Generic ARM big LITTLE CPUfreq driver"
-	depends on ARM_CPU_TOPOLOGY && HAVE_CLK
-	select PM_OPP
-	help
-	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
-
 config ARM_SCPI_CPUFREQ
 	tristate "SCPI based CPUfreq driver"
 	depends on ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
@@ -69,7 +61,9 @@ config ARM_SCPI_CPUFREQ
 
 config ARM_VEXPRESS_SPC_CPUFREQ
 	tristate "Versatile Express SPC based CPUfreq driver"
-	depends on ARM_BIG_LITTLE_CPUFREQ && ARCH_VEXPRESS_SPC
+	depends on ARM_CPU_TOPOLOGY && HAVE_CLK
+	depends on ARCH_VEXPRESS_SPC
+	select PM_OPP
 	help
 	  This add the CPUfreq driver support for Versatile Express
 	  big.LITTLE platforms using SPC for power management.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9a9f5ccd13d9..f6670c4abbb0 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -47,8 +47,6 @@ obj-$(CONFIG_X86_SFI_CPUFREQ)		+= sfi-cpufreq.o
 
 ##################################################################################
 # ARM SoC drivers
-obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
-
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
diff --git a/drivers/cpufreq/arm_big_little.h b/drivers/cpufreq/arm_big_little.h
deleted file mode 100644
index 88a176e466c8..000000000000
--- a/drivers/cpufreq/arm_big_little.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * ARM big.LITTLE platform's CPUFreq header file
- *
- * Copyright (C) 2013 ARM Ltd.
- * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
- *
- * Copyright (C) 2013 Linaro.
- * Viresh Kumar <viresh.kumar@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-#ifndef CPUFREQ_ARM_BIG_LITTLE_H
-#define CPUFREQ_ARM_BIG_LITTLE_H
-
-#include <linux/cpufreq.h>
-#include <linux/device.h>
-#include <linux/types.h>
-
-struct cpufreq_arm_bL_ops {
-	char name[CPUFREQ_NAME_LEN];
-
-	/*
-	 * This must set opp table for cpu_dev in a similar way as done by
-	 * dev_pm_opp_of_add_table().
-	 */
-	int (*init_opp_table)(const struct cpumask *cpumask);
-
-	/* Optional */
-	int (*get_transition_latency)(struct device *cpu_dev);
-	void (*free_opp_table)(const struct cpumask *cpumask);
-};
-
-int bL_cpufreq_register(const struct cpufreq_arm_bL_ops *ops);
-void bL_cpufreq_unregister(const struct cpufreq_arm_bL_ops *ops);
-
-#endif /* CPUFREQ_ARM_BIG_LITTLE_H */
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
similarity index 90%
rename from drivers/cpufreq/arm_big_little.c
rename to drivers/cpufreq/vexpress-spc-cpufreq.c
index 7fe52fcddcf1..b7e1aa000c80 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -1,20 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * ARM big.LITTLE Platforms CPUFreq support
+ * Versatile Express SPC CPUFreq Interface driver
  *
- * Copyright (C) 2013 ARM Ltd.
- * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
+ * Copyright (C) 2019 ARM Ltd.
+ * Sudeep Holla <sudeep.holla@arm.com>
  *
  * Copyright (C) 2013 Linaro.
  * Viresh Kumar <viresh.kumar@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -24,16 +16,29 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_cooling.h>
-#include <linux/export.h>
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/topology.h>
 #include <linux/types.h>
 
-#include "arm_big_little.h"
+struct cpufreq_arm_bL_ops {
+	char name[CPUFREQ_NAME_LEN];
+
+	/*
+	 * This must set opp table for cpu_dev in a similar way as done by
+	 * dev_pm_opp_of_add_table().
+	 */
+	int (*init_opp_table)(const struct cpumask *cpumask);
+
+	/* Optional */
+	int (*get_transition_latency)(struct device *cpu_dev);
+	void (*free_opp_table)(const struct cpumask *cpumask);
+};
 
 /* Currently we support only two clusters */
 #define A15_CLUSTER	0
@@ -633,7 +638,6 @@ int bL_cpufreq_register(const struct cpufreq_arm_bL_ops *ops)
 	bL_switcher_put_enabled();
 	return ret;
 }
-EXPORT_SYMBOL_GPL(bL_cpufreq_register);
 
 void bL_cpufreq_unregister(const struct cpufreq_arm_bL_ops *ops)
 {
@@ -651,8 +655,49 @@ void bL_cpufreq_unregister(const struct cpufreq_arm_bL_ops *ops)
 			arm_bL_ops->name);
 	arm_bL_ops = NULL;
 }
-EXPORT_SYMBOL_GPL(bL_cpufreq_unregister);
+
+static int ve_spc_init_opp_table(const struct cpumask *cpumask)
+{
+	struct device *cpu_dev = get_cpu_device(cpumask_first(cpumask));
+	/*
+	 * platform specific SPC code must initialise the opp table
+	 * so just check if the OPP count is non-zero
+	 */
+	return dev_pm_opp_get_opp_count(cpu_dev) <= 0;
+}
+
+static int ve_spc_get_transition_latency(struct device *cpu_dev)
+{
+	return 1000000; /* 1 ms */
+}
+
+static const struct cpufreq_arm_bL_ops ve_spc_cpufreq_ops = {
+	.name	= "vexpress-spc",
+	.get_transition_latency = ve_spc_get_transition_latency,
+	.init_opp_table = ve_spc_init_opp_table,
+};
+
+static int ve_spc_cpufreq_probe(struct platform_device *pdev)
+{
+	return bL_cpufreq_register(&ve_spc_cpufreq_ops);
+}
+
+static int ve_spc_cpufreq_remove(struct platform_device *pdev)
+{
+	bL_cpufreq_unregister(&ve_spc_cpufreq_ops);
+	return 0;
+}
+
+static struct platform_driver ve_spc_cpufreq_platdrv = {
+	.driver = {
+		.name	= "vexpress-spc-cpufreq",
+	},
+	.probe		= ve_spc_cpufreq_probe,
+	.remove		= ve_spc_cpufreq_remove,
+};
+module_platform_driver(ve_spc_cpufreq_platdrv);
 
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
-MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("Vexpress SPC ARM big LITTLE cpufreq driver");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

