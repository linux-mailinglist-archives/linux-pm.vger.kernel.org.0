Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A5C15B554
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgBLXw2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42465 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgBLXw1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so2865159lfl.9;
        Wed, 12 Feb 2020 15:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6wOmddS0yeiDwJ68rxlPfjF/ddpMvHSx+0aK/m/YHZQ=;
        b=S7saNQt7i9QeJxnD5CpXDVYfWJJETBXDkqPw+GyYOr6240qio1xI8gGZuv5LGQvf9s
         Uu+3LAnUyNeNRR6HwtpDrhyDHPTuQbDQLKHI4Vw/lYzmlyYMplHHj8BQeBvgadAGeZTf
         /khEqXYssErEVgUM7gwXgAg+KNHXtU6ylfLZCF+gOif2CSBy1KkxKTIaU6uxc6xsCKFa
         F/194vAbT7STqL/nhgw5U0p+pd5Tn3Sa4khwXKGAR/lhxf5/UAD7xMHsjkkEvCvJeiZh
         sVpnqyCV4JnNLSfblvECBuGt8cHPRU2ZVztXwE/xcNYYxHuRpmmZaK262P3SfZzCrSTa
         5iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6wOmddS0yeiDwJ68rxlPfjF/ddpMvHSx+0aK/m/YHZQ=;
        b=TwDbSBGL0R1v/CL9Or07XqLki0V/2/5ZaHo2eAJruI5/XX7mxP+uIR4uqwW2hmpPRT
         NOGhQ2rvBdojIslA7fIGRnQLkl9HudPFqpejPGu9B8uUO1eWut0Hs+WLytziVh4nRMcl
         19rcBC/aK+cDFu4KSr9vghfz+TeE4kyOv8kFiZxaMOkmCR+xKNstqBlbReTbDoenjRSX
         8nckeaN7iWvHahYWbMj6axPniI0eOJsl2kH0TpIeACRGKhSEwspKBLjpGgTBVsXw1rEs
         9Y4oUZD8gAkXtVKzZa3c7eJChUSVgc4MwsVbFDWaIH2VNks0WaJFNLNmBeOEiIMIfGPj
         vN3g==
X-Gm-Message-State: APjAAAVPifQ7W3OCUassTGYXiMzY63ioDkZyrgnRe34N5mPKm2MUw/cB
        ccEcJ1ik4Lqie0Jd7eCxQvg=
X-Google-Smtp-Source: APXvYqxkQEdLcIye+0MYxoEefzZM0KgjCoINyhd96tx4+A+clLdL6IgtPVxGiwH7pl23ADNAZvrF+A==
X-Received: by 2002:a19:c697:: with SMTP id w145mr7844567lff.54.1581551541972;
        Wed, 12 Feb 2020 15:52:21 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:21 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 12/17] cpuidle: Refactor and move out NVIDIA Tegra20 driver into drivers/cpuidle
Date:   Thu, 13 Feb 2020 02:51:29 +0300
Message-Id: <20200212235134.12638-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver's code is refactored in a way that will make it easy to
support Tegra30/114/124 SoCs by this unified driver later on. The
current functionality is equal to the old Tegra20 driver, only the
code's structure changed a tad. This is also a proper platform driver
now.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/Makefile          |   3 -
 arch/arm/mach-tegra/cpuidle-tegra20.c | 216 --------------------
 arch/arm/mach-tegra/cpuidle.c         |  14 +-
 arch/arm/mach-tegra/cpuidle.h         |   4 -
 drivers/cpuidle/Kconfig.arm           |   8 +
 drivers/cpuidle/Makefile              |   1 +
 drivers/cpuidle/cpuidle-tegra.c       | 277 ++++++++++++++++++++++++++
 include/soc/tegra/cpuidle.h           |   2 +-
 8 files changed, 289 insertions(+), 236 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 965862608ff6..8425bb5608d5 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -12,9 +12,6 @@ obj-y					+= sleep-tegra20.o
 obj-y					+= sleep-tegra30.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= cpuidle-tegra20.o
-endif
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
deleted file mode 100644
index f8f14c0b79ff..000000000000
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ /dev/null
@@ -1,216 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * CPU idle driver for Tegra CPUs
- *
- * Copyright (c) 2010-2012, NVIDIA Corporation.
- * Copyright (c) 2011 Google, Inc.
- * Author: Colin Cross <ccross@android.com>
- *         Gary King <gking@nvidia.com>
- *
- * Rework for 3.3 by Peter De Schrijver <pdeschrijver@nvidia.com>
- */
-
-#include <linux/clk/tegra.h>
-#include <linux/tick.h>
-#include <linux/cpuidle.h>
-#include <linux/cpu_pm.h>
-#include <linux/kernel.h>
-#include <linux/ktime.h>
-#include <linux/module.h>
-
-#include <soc/tegra/flowctrl.h>
-#include <soc/tegra/pm.h>
-
-#include <asm/cpuidle.h>
-#include <asm/smp_plat.h>
-#include <asm/suspend.h>
-
-#include "cpuidle.h"
-#include "iomap.h"
-#include "irq.h"
-#include "reset.h"
-#include "sleep.h"
-
-#ifdef CONFIG_PM_SLEEP
-static atomic_t abort_flag;
-static atomic_t abort_barrier;
-static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
-				    struct cpuidle_driver *drv,
-				    int index);
-#define TEGRA20_MAX_STATES 2
-#else
-#define TEGRA20_MAX_STATES 1
-#endif
-
-static struct cpuidle_driver tegra_idle_driver = {
-	.name = "tegra_idle",
-	.owner = THIS_MODULE,
-	.states = {
-		ARM_CPUIDLE_WFI_STATE_PWR(600),
-#ifdef CONFIG_PM_SLEEP
-		{
-			.enter            = tegra20_idle_lp2_coupled,
-			.exit_latency     = 5000,
-			.target_residency = 10000,
-			.power_usage      = 0,
-			.flags            = CPUIDLE_FLAG_COUPLED |
-			                    CPUIDLE_FLAG_TIMER_STOP,
-			.name             = "powered-down",
-			.desc             = "CPU power gated",
-		},
-#endif
-	},
-	.state_count = TEGRA20_MAX_STATES,
-	.safe_state_index = 0,
-};
-
-#ifdef CONFIG_PM_SLEEP
-#ifdef CONFIG_SMP
-static void tegra20_wake_cpu1_from_reset(void)
-{
-	/* enable cpu clock on cpu */
-	tegra_enable_cpu_clock(1);
-
-	/* take the CPU out of reset */
-	tegra_cpu_out_of_reset(1);
-
-	/* unhalt the cpu */
-	flowctrl_write_cpu_halt(1, 0);
-}
-#else
-static inline void tegra20_wake_cpu1_from_reset(void)
-{
-}
-#endif
-
-static void tegra20_report_cpus_state(void)
-{
-	unsigned long cpu, lcpu, csr;
-
-	for_each_cpu(lcpu, cpu_possible_mask) {
-		cpu = cpu_logical_map(lcpu);
-		csr = flowctrl_read_cpu_csr(cpu);
-
-		pr_err("cpu%lu: online=%d flowctrl_csr=0x%08lx\n",
-		       cpu, cpu_online(lcpu), csr);
-	}
-}
-
-static int tegra20_wait_for_secondary_cpu_parking(void)
-{
-	unsigned int retries = 3;
-
-	while (retries--) {
-		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
-
-		/*
-		 * The primary CPU0 core shall wait for the secondaries
-		 * shutdown in order to power-off CPU's cluster safely.
-		 * The timeout value depends on the current CPU frequency,
-		 * it takes about 40-150us  in average and over 1000us in
-		 * a worst case scenario.
-		 */
-		do {
-			if (tegra_cpu_rail_off_ready())
-				return 0;
-
-		} while (ktime_before(ktime_get(), timeout));
-
-		pr_err("secondary CPU taking too long to park\n");
-
-		tegra20_report_cpus_state();
-	}
-
-	pr_err("timed out waiting secondaries to park\n");
-
-	return -ETIMEDOUT;
-}
-
-static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
-					   struct cpuidle_driver *drv,
-					   int index)
-{
-	bool ret;
-
-	if (tegra20_wait_for_secondary_cpu_parking())
-		return false;
-
-	ret = !tegra_pm_enter_lp2();
-
-	if (cpu_online(1))
-		tegra20_wake_cpu1_from_reset();
-
-	return ret;
-}
-
-#ifdef CONFIG_SMP
-static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
-					 struct cpuidle_driver *drv,
-					 int index)
-{
-	cpu_suspend(dev->cpu, tegra_pm_park_secondary_cpu);
-
-	return true;
-}
-#else
-static inline bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
-						struct cpuidle_driver *drv,
-						int index)
-{
-	return true;
-}
-#endif
-
-static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
-				    struct cpuidle_driver *drv,
-				    int index)
-{
-	bool entered_lp2 = false;
-
-	if (tegra_pending_sgi())
-		atomic_set(&abort_flag, 1);
-
-	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
-
-	if (atomic_read(&abort_flag)) {
-		cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
-		/* clean flag for next coming */
-		atomic_set(&abort_flag, 0);
-		return -EINTR;
-	}
-
-	local_fiq_disable();
-
-	tegra_pm_set_cpu_in_lp2();
-	cpu_pm_enter();
-
-	if (dev->cpu == 0)
-		entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv, index);
-	else
-		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
-
-	cpu_pm_exit();
-	tegra_pm_clear_cpu_in_lp2();
-
-	local_fiq_enable();
-
-	return entered_lp2 ? index : 0;
-}
-#endif
-
-/*
- * Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
- * they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
- * this, simply disable LP2 if the PCI driver and DT node are both enabled.
- */
-void tegra20_cpuidle_pcie_irqs_in_use(void)
-{
-	pr_info_once(
-		"Disabling cpuidle LP2 state, since PCIe IRQs are in use\n");
-	cpuidle_driver_state_disabled(&tegra_idle_driver, 1, true);
-}
-
-int __init tegra20_cpuidle_init(void)
-{
-	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
-}
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index d565c44cfc93..eee85d517783 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <soc/tegra/fuse.h>
 
@@ -23,8 +24,7 @@ void __init tegra_cpuidle_init(void)
 {
 	switch (tegra_get_chip_id()) {
 	case TEGRA20:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
-			tegra20_cpuidle_init();
+		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
 		break;
 	case TEGRA30:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
@@ -38,13 +38,3 @@ void __init tegra_cpuidle_init(void)
 		break;
 	}
 }
-
-void tegra_cpuidle_pcie_irqs_in_use(void)
-{
-	switch (tegra_get_chip_id()) {
-	case TEGRA20:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
-			tegra20_cpuidle_pcie_irqs_in_use();
-		break;
-	}
-}
diff --git a/arch/arm/mach-tegra/cpuidle.h b/arch/arm/mach-tegra/cpuidle.h
index 4e1f459f5bd8..eeb37baf18e1 100644
--- a/arch/arm/mach-tegra/cpuidle.h
+++ b/arch/arm/mach-tegra/cpuidle.h
@@ -7,15 +7,11 @@
 #define __MACH_TEGRA_CPUIDLE_H
 
 #ifdef CONFIG_CPU_IDLE
-int tegra20_cpuidle_init(void);
-void tegra20_cpuidle_pcie_irqs_in_use(void);
 int tegra30_cpuidle_init(void);
 int tegra114_cpuidle_init(void);
 void tegra_cpuidle_init(void);
-void tegra_cpuidle_pcie_irqs_in_use(void);
 #else
 static inline void tegra_cpuidle_init(void) {}
-static inline void tegra_cpuidle_pcie_irqs_in_use(void) {}
 #endif
 
 #endif
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 62272ecfa771..99a2d72ac02b 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -86,3 +86,11 @@ config ARM_MVEBU_V7_CPUIDLE
 	depends on (ARCH_MVEBU || COMPILE_TEST) && !ARM64
 	help
 	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
+
+config ARM_TEGRA_CPUIDLE
+	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
+	depends on ARCH_TEGRA && !ARM64
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
+	select ARM_CPU_SUSPEND
+	help
+	  Select this to enable cpuidle for NVIDIA Tegra20/30/114/124 SoCs.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index cc8c769d7fa9..55a464f6a78b 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
 obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle_psci.o
 cpuidle_psci-y				:= cpuidle-psci.o
 cpuidle_psci-$(CONFIG_PM_GENERIC_DOMAINS_OF) += cpuidle-psci-domain.o
+obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
 
 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
new file mode 100644
index 000000000000..a58d2773d45f
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CPU idle driver for Tegra CPUs
+ *
+ * Copyright (c) 2010-2013, NVIDIA Corporation.
+ * Copyright (c) 2011 Google, Inc.
+ * Author: Colin Cross <ccross@android.com>
+ *         Gary King <gking@nvidia.com>
+ *
+ * Rework for 3.3 by Peter De Schrijver <pdeschrijver@nvidia.com>
+ *
+ * Tegra20/124 driver unification by Dmitry Osipenko <digetx@gmail.com>
+ */
+
+#define pr_fmt(fmt)	"tegra-cpuidle: " fmt
+
+#include <linux/atomic.h>
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/errno.h>
+#include <linux/ktime.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include <linux/clk/tegra.h>
+
+#include <soc/tegra/cpuidle.h>
+#include <soc/tegra/flowctrl.h>
+#include <soc/tegra/fuse.h>
+#include <soc/tegra/irq.h>
+#include <soc/tegra/pm.h>
+
+#include <asm/cpuidle.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+
+enum tegra_state {
+	TEGRA_C1,
+	TEGRA_CC6,
+	TEGRA_STATE_COUNT,
+};
+
+static atomic_t tegra_idle_barrier;
+static atomic_t tegra_abort_flag;
+
+static void tegra_cpuidle_report_cpus_state(void)
+{
+	unsigned long cpu, lcpu, csr;
+
+	for_each_cpu(lcpu, cpu_possible_mask) {
+		cpu = cpu_logical_map(lcpu);
+		csr = flowctrl_read_cpu_csr(cpu);
+
+		pr_err("cpu%lu: online=%d flowctrl_csr=0x%08lx\n",
+		       cpu, cpu_online(lcpu), csr);
+	}
+}
+
+static int tegra_cpuidle_wait_for_secondary_cpus_parking(void)
+{
+	unsigned int retries = 3;
+
+	while (retries--) {
+		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
+
+		/*
+		 * The primary CPU0 core shall wait for the secondaries
+		 * shutdown in order to power-off CPU's cluster safely.
+		 * The timeout value depends on the current CPU frequency,
+		 * it takes about 40-150us in average and over 1000us in
+		 * a worst case scenario.
+		 */
+		do {
+			if (tegra_cpu_rail_off_ready())
+				return 0;
+
+		} while (ktime_before(ktime_get(), timeout));
+
+		pr_err("secondary CPU taking too long to park\n");
+
+		tegra_cpuidle_report_cpus_state();
+	}
+
+	pr_err("timed out waiting secondaries to park\n");
+
+	return -ETIMEDOUT;
+}
+
+static void tegra_cpuidle_unpark_secondary_cpus(void)
+{
+	unsigned int cpu, lcpu;
+
+	for_each_cpu(lcpu, cpu_online_mask) {
+		cpu = cpu_logical_map(lcpu);
+
+		if (cpu > 0) {
+			tegra_enable_cpu_clock(cpu);
+			tegra_cpu_out_of_reset(cpu);
+			flowctrl_write_cpu_halt(cpu, 0);
+		}
+	}
+}
+
+static int tegra_cpuidle_cc6_enter(unsigned int cpu)
+{
+	int ret;
+
+	if (cpu > 0) {
+		ret = cpu_suspend(cpu, tegra_pm_park_secondary_cpu);
+	} else {
+		ret = tegra_cpuidle_wait_for_secondary_cpus_parking();
+		if (!ret)
+			ret = tegra_pm_enter_lp2();
+
+		tegra_cpuidle_unpark_secondary_cpus();
+	}
+
+	return ret;
+}
+
+static int tegra_cpuidle_coupled_barrier(struct cpuidle_device *dev)
+{
+	if (tegra_pending_sgi()) {
+		/*
+		 * CPU got local interrupt that will be lost after GIC's
+		 * shutdown because GIC driver doesn't save/restore the
+		 * pending SGI state across CPU cluster PM.  Abort and retry
+		 * next time.
+		 */
+		atomic_set(&tegra_abort_flag, 1);
+	}
+
+	cpuidle_coupled_parallel_barrier(dev, &tegra_idle_barrier);
+
+	if (atomic_read(&tegra_abort_flag)) {
+		cpuidle_coupled_parallel_barrier(dev, &tegra_idle_barrier);
+		atomic_set(&tegra_abort_flag, 0);
+		return -EINTR;
+	}
+
+	return 0;
+}
+
+static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
+				     int index, unsigned int cpu)
+{
+	int ret;
+
+	/*
+	 * CC6 state is the "CPU cluster power-off" state.  In order to
+	 * enter this state, at first the secondary CPU cores need to be
+	 * parked into offline mode, then the last CPU should clean out
+	 * remaining dirty cache lines into DRAM and trigger Flow Controller
+	 * logic that turns off the cluster's power domain (which includes
+	 * CPU cores, GIC and L2 cache).
+	 */
+	if (index == TEGRA_CC6) {
+		ret = tegra_cpuidle_coupled_barrier(dev);
+		if (ret)
+			return ret;
+	}
+
+	local_fiq_disable();
+	tegra_pm_set_cpu_in_lp2();
+	cpu_pm_enter();
+
+	switch (index) {
+	case TEGRA_CC6:
+		ret = tegra_cpuidle_cc6_enter(cpu);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	cpu_pm_exit();
+	tegra_pm_clear_cpu_in_lp2();
+	local_fiq_enable();
+
+	return ret;
+}
+
+static int tegra_cpuidle_enter(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv,
+			       int index)
+{
+	unsigned int cpu = cpu_logical_map(dev->cpu);
+	int err;
+
+	err = tegra_cpuidle_state_enter(dev, index, cpu);
+	if (err && err != -EINTR)
+		pr_err_once("cpu%u failed to enter idle state %d err: %d\n",
+			    cpu, index, err);
+
+	return err ? -1 : index;
+}
+
+/*
+ * The previous versions of Tegra CPUIDLE driver used a different "legacy"
+ * terminology for naming of the idling states, while this driver uses the
+ * new terminology.
+ *
+ * Mapping of the old terms into the new ones:
+ *
+ * Old | New
+ * ---------
+ * LP3 | C1	(CPU core clock gating)
+ * LP2 | C7	(CPU core power gating)
+ * LP2 | CC6	(CPU cluster power gating)
+ *
+ * Note that that the older CPUIDLE driver versions didn't explicitly
+ * differentiate the LP2 states because these states either used the same
+ * code path or because CC6 wasn't supported.
+ */
+static struct cpuidle_driver tegra_idle_driver = {
+	.name = "tegra_idle",
+	.states = {
+		[TEGRA_C1] = ARM_CPUIDLE_WFI_STATE_PWR(600),
+		[TEGRA_CC6] = {
+			.enter			= tegra_cpuidle_enter,
+			.exit_latency		= 5000,
+			.target_residency	= 10000,
+			.power_usage		= 0,
+			.flags			= CPUIDLE_FLAG_TIMER_STOP |
+						  CPUIDLE_FLAG_COUPLED,
+			.name			= "CC6",
+			.desc			= "CPU cluster powered off",
+		},
+	},
+	.state_count = TEGRA_STATE_COUNT,
+	.safe_state_index = TEGRA_C1,
+};
+
+static inline void tegra_cpuidle_disable_state(enum tegra_state state)
+{
+	cpuidle_driver_state_disabled(&tegra_idle_driver, state, true);
+}
+
+/*
+ * Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
+ * they are legacy IRQs or MSI, are lost when CC6 is enabled.  To work around
+ * this, simply disable CC6 if the PCI driver and DT node are both enabled.
+ */
+void tegra_cpuidle_pcie_irqs_in_use(void)
+{
+	struct cpuidle_state *state_cc6 = &tegra_idle_driver.states[TEGRA_CC6];
+
+	if ((state_cc6->flags & CPUIDLE_FLAG_UNUSABLE) ||
+	    tegra_get_chip_id() != TEGRA20)
+		return;
+
+	pr_info("disabling CC6 state, since PCIe IRQs are in use\n");
+	tegra_cpuidle_disable_state(TEGRA_CC6);
+}
+
+static int tegra_cpuidle_probe(struct platform_device *pdev)
+{
+	/*
+	 * Required suspend-resume functionality, which is provided by the
+	 * Tegra-arch core and PMC driver, is unavailable if PM-sleep option
+	 * is disabled.
+	 */
+	if (!IS_ENABLED(CONFIG_PM_SLEEP))
+		tegra_cpuidle_disable_state(TEGRA_CC6);
+
+	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
+}
+
+static struct platform_driver tegra_cpuidle_driver = {
+	.probe = tegra_cpuidle_probe,
+	.driver = {
+		.name = "tegra-cpuidle",
+	},
+};
+builtin_platform_driver(tegra_cpuidle_driver);
diff --git a/include/soc/tegra/cpuidle.h b/include/soc/tegra/cpuidle.h
index 029ba1f4b2cc..5665975015d8 100644
--- a/include/soc/tegra/cpuidle.h
+++ b/include/soc/tegra/cpuidle.h
@@ -6,7 +6,7 @@
 #ifndef __SOC_TEGRA_CPUIDLE_H__
 #define __SOC_TEGRA_CPUIDLE_H__
 
-#if defined(CONFIG_ARM) && defined(CONFIG_ARCH_TEGRA) && defined(CONFIG_CPU_IDLE)
+#ifdef CONFIG_ARM_TEGRA_CPUIDLE
 void tegra_cpuidle_pcie_irqs_in_use(void);
 #else
 static inline void tegra_cpuidle_pcie_irqs_in_use(void)
-- 
2.24.0

