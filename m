Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48CD08781C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 13:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406490AbfHILDa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 07:03:30 -0400
Received: from foss.arm.com ([217.140.110.172]:45578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406474AbfHILD2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Aug 2019 07:03:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6FBA15AB;
        Fri,  9 Aug 2019 04:03:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56D323F575;
        Fri,  9 Aug 2019 04:03:26 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 4/8] ARM: psci: cpuidle: Introduce PSCI CPUidle driver
Date:   Fri,  9 Aug 2019 12:03:10 +0100
Message-Id: <5d81594495c3ee6a68a9606640af16bff6f64d86.1565348376.git.lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1565348376.git.lorenzo.pieralisi@arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com> <cover.1565348376.git.lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PSCI firmware is the standard power management control for
all ARM64 based platforms and it is also deployed on some
ARM 32 bit platforms to date.

Idle state entry in PSCI is currently achieved by calling
arm_cpuidle_init() and arm_cpuidle_suspend() in a generic
idle driver, which in turn relies on ARM/ARM64 CPUidle back-end
to relay the call into PSCI firmware if PSCI is the boot method.

Given that PSCI is the standard idle entry method on ARM64 systems
(which means that no other CPUidle driver are expected on ARM64
platforms - so PSCI is already a generic idle driver), in order to
simplify idle entry and code maintenance, it makes sense to have a PSCI
specific idle driver so that idle code that it is currently living in
drivers/firmware directory can be hoisted out of it and moved
where it belongs, into a full-fledged PSCI driver, leaving PSCI code
in drivers/firmware as a pure firmware interface, as it should be.

Implement a PSCI CPUidle driver. By default it is a silent Kconfig entry
which is left unselected, since it selection would clash with the
generic ARM CPUidle driver that provides a PSCI based idle driver
through the arm/arm64 arches back-ends CPU operations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 MAINTAINERS                    |   8 ++
 drivers/cpuidle/Kconfig.arm    |  10 +++
 drivers/cpuidle/Makefile       |   1 +
 drivers/cpuidle/cpuidle-psci.c | 151 +++++++++++++++++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-psci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..c2bf8ce65e83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4286,6 +4286,14 @@ S:	Supported
 F:	drivers/cpuidle/cpuidle-exynos.c
 F:	arch/arm/mach-exynos/pm.c
 
+CPUIDLE DRIVER - ARM PSCI
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Supported
+F:	drivers/cpuidle/cpuidle-psci.c
+
 CPU IDLE TIME MANAGEMENT FRAMEWORK
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 48cb3d4bb7d1..eb014aa5ce6b 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -13,6 +13,16 @@ config ARM_CPUIDLE
           initialized by calling the CPU operations init idle hook
           provided by architecture code.
 
+config ARM_PSCI_CPUIDLE
+	bool
+	depends on ARM_PSCI_FW
+	select DT_IDLE_STATES
+	select CPU_IDLE_MULTIPLE_DRIVERS
+	help
+	  Select this to enable PSCI firmware based CPUidle driver for ARM.
+	  It provides an idle driver that is capable of detecting and
+	  managing idle states through the PSCI firmware interface.
+
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
 	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 9d7176cee3d3..40d016339b29 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
 obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
+obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
 
 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
new file mode 100644
index 000000000000..ab1dea918ea3
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PSCI CPU idle driver.
+ *
+ * Copyright (C) 2019 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ */
+
+#define pr_fmt(fmt) "CPUidle PSCI: " fmt
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/psci.h>
+#include <linux/slab.h>
+
+#include <asm/cpuidle.h>
+
+#include "dt_idle_states.h"
+
+static int psci_enter_idle_state(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int idx)
+{
+	return CPU_PM_CPU_IDLE_ENTER(psci_cpu_suspend_enter, idx);
+}
+
+static struct cpuidle_driver psci_idle_driver __initdata = {
+	.name = "psci_idle",
+	.owner = THIS_MODULE,
+	/*
+	 * PSCI idle states relies on architectural WFI to
+	 * be represented as state index 0.
+	 */
+	.states[0] = {
+		.enter                  = psci_enter_idle_state,
+		.exit_latency           = 1,
+		.target_residency       = 1,
+		.power_usage		= UINT_MAX,
+		.name                   = "WFI",
+		.desc                   = "ARM WFI",
+	}
+};
+
+static const struct of_device_id psci_idle_state_match[] __initconst = {
+	{ .compatible = "arm,idle-state",
+	  .data = psci_enter_idle_state },
+	{ },
+};
+
+static int __init psci_idle_init_cpu(int cpu)
+{
+	struct cpuidle_driver *drv;
+	struct device_node *cpu_node;
+	const char *enable_method;
+	int ret = 0;
+
+	cpu_node = of_cpu_device_node_get(cpu);
+	if (!cpu_node)
+		return -ENODEV;
+
+	/*
+	 * Check whether the enable-method for the cpu is PSCI, fail
+	 * if it is not.
+	 */
+	enable_method = of_get_property(cpu_node, "enable-method", NULL);
+	if (!enable_method || (strcmp(enable_method, "psci")))
+		ret = -ENODEV;
+
+	of_node_put(cpu_node);
+	if (ret)
+		return ret;
+
+	drv = kmemdup(&psci_idle_driver, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
+
+	/*
+	 * Initialize idle states data, starting at index 1, since
+	 * by default idle state 0 is the quiescent state reached
+	 * by the cpu by executing the wfi instruction.
+	 *
+	 * If no DT idle states are detected (ret == 0) let the driver
+	 * initialization fail accordingly since there is no reason to
+	 * initialize the idle driver if only wfi is supported, the
+	 * default archictectural back-end already executes wfi
+	 * on idle entry.
+	 */
+	ret = dt_init_idle_driver(drv, psci_idle_state_match, 1);
+	if (ret <= 0) {
+		ret = ret ? : -ENODEV;
+		goto out_kfree_drv;
+	}
+
+	/*
+	 * Initialize PSCI idle states.
+	 */
+	ret = psci_cpu_init_idle(cpu);
+	if (ret) {
+		pr_err("CPU %d failed to PSCI idle\n", cpu);
+		goto out_kfree_drv;
+	}
+
+	ret = cpuidle_register(drv, NULL);
+	if (ret)
+		goto out_kfree_drv;
+
+	return 0;
+
+out_kfree_drv:
+	kfree(drv);
+	return ret;
+}
+
+/*
+ * psci_idle_init - Initializes PSCI cpuidle driver
+ *
+ * Initializes PSCI cpuidle driver for all CPUs, if any CPU fails
+ * to register cpuidle driver then rollback to cancel all CPUs
+ * registration.
+ */
+static int __init psci_idle_init(void)
+{
+	int cpu, ret;
+	struct cpuidle_driver *drv;
+	struct cpuidle_device *dev;
+
+	for_each_possible_cpu(cpu) {
+		ret = psci_idle_init_cpu(cpu);
+		if (ret)
+			goto out_fail;
+	}
+
+	return 0;
+
+out_fail:
+	while (--cpu >= 0) {
+		dev = per_cpu(cpuidle_devices, cpu);
+		drv = cpuidle_get_cpu_driver(dev);
+		cpuidle_unregister(drv);
+		kfree(drv);
+	}
+
+	return ret;
+}
+device_initcall(psci_idle_init);
-- 
2.21.0

