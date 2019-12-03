Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B94210F406
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfLCAmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:42:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38540 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfLCAmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so1411056lfm.5;
        Mon, 02 Dec 2019 16:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESuiJE2hQr/ZSTBmtHjvYQ4sX6f/2dQYnnMtbMKp7Vo=;
        b=r/D7SPSnC8mN1xmtbZerwOrsygXzgOC1ahZ2fKWTH73GxifqttiOMcw3Wmw8tZgEBs
         Cc04uPm9i6QIZ6R7KWspRTdVPigwVP+56newWYqCd1mXeLskvW6VvfHCk9bJah6ZgEw1
         oCkpoW8ppy+WpwgNmsGsjYurrri1L5jq1Wrswpv2l4DZKcB5TZonS6ZDo+JEs55CT6NF
         Rcv0LOtyWXtiCgoyRhTqIvhUUCPrpnfzYx+EDRcVMDIhEwBkAsz/GCtS17qieGZ9OvS4
         R0oJV0aV0rQD5iB6qOwvVtH7cA/YczH1xzVYbiVLXoEUXCk2dBFjT5InG6RDXEp0hz1P
         XgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESuiJE2hQr/ZSTBmtHjvYQ4sX6f/2dQYnnMtbMKp7Vo=;
        b=k49pv6rNDPXHDX3cJ2R9n96fBB9xx9Tvn6PI2cbSXQGRZi00KcTPPPcK8NGJO63pfS
         6nWNaeM04oF9kGdAcnmtlfN87IKjmZxWL6bNtfu0VGdBVeBdaUwVmJnsAQDAwhs7ZMSU
         bV2mBbepolu75UsunPIkdIGVCGrT5iDWqtGTdM5fApD4VLv2BWlUBWxbvYGoBjFI1Ks8
         4dAZgLhC2f5kXkqLiEfqk6JSaJwZazRQGRFj7jGlM3Jjm+p04f2o0D5Kn96DYdUbf+7x
         EahVoGo5FflvTHkwbU3A5poAc0brNWVUdr1xVVYURhNeXuCw8gWorR4QD+W2fEV9E7hn
         F9tA==
X-Gm-Message-State: APjAAAXNXzouARG/htxChbGc9wxGxv8dVpPwhetEEvCKlVoWTHBYojXF
        xAutCzFXZ1XtmvH2UfuqmcU=
X-Google-Smtp-Source: APXvYqwrcCzJtLLkz6mrp1f5H/r4/QsKWcj0Zws/vQTDK3nA7bahQ1v/GRG2fgg+5T1zJU13l2xjQA==
X-Received: by 2002:ac2:5504:: with SMTP id j4mr1081268lfk.144.1575333734472;
        Mon, 02 Dec 2019 16:42:14 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:14 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 13/19] cpuidle: Refactor and move out NVIDIA Tegra20 driver into drivers/cpuidle
Date:   Tue,  3 Dec 2019 03:41:10 +0300
Message-Id: <20191203004116.11771-14-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/Makefile          |   3 -
 arch/arm/mach-tegra/cpuidle-tegra20.c | 215 --------------------
 arch/arm/mach-tegra/cpuidle.c         |  14 +-
 arch/arm/mach-tegra/cpuidle.h         |   4 -
 drivers/cpuidle/Kconfig.arm           |   8 +
 drivers/cpuidle/Makefile              |   1 +
 drivers/cpuidle/cpuidle-tegra.c       | 269 ++++++++++++++++++++++++++
 include/soc/tegra/cpuidle.h           |   2 +-
 8 files changed, 281 insertions(+), 235 deletions(-)
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
index 78cc424fac35..000000000000
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ /dev/null
@@ -1,215 +0,0 @@
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
-	unsigned int cpu, lcpu;
-
-	pr_err("secondary CPU taking too long to park\n");
-
-	for_each_cpu(lcpu, cpu_possible_mask) {
-		cpu = cpu_logical_map(lcpu);
-
-		pr_err("cpu%u: online=%d flowctrl_csr=0x%08x\n",
-		       cpu, cpu_online(lcpu), flowctrl_read_cpu_csr(cpu));
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
index d8530475493c..6952bf7bb260 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -86,3 +86,11 @@ config ARM_MVEBU_V7_CPUIDLE
 	depends on ARCH_MVEBU && !ARM64
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
index ee70d5cc5b99..a15e4808d295 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
 obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
 obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
+obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
 
 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
new file mode 100644
index 000000000000..6f7955b9d4bd
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -0,0 +1,269 @@
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
+enum {
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
+	unsigned int cpu, lcpu;
+
+	pr_err("secondary CPU taking too long to park\n");
+
+	for_each_cpu(lcpu, cpu_possible_mask) {
+		cpu = cpu_logical_map(lcpu);
+
+		pr_err("cpu%u: online=%d flowctrl_csr=0x%08x\n",
+		       cpu, cpu_online(lcpu), flowctrl_read_cpu_csr(cpu));
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
+/*
+ * Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
+ * they are legacy IRQs or MSI, are lost when CC6 is enabled.  To work around
+ * this, simply disable CC6 if the PCI driver and DT node are both enabled.
+ */
+void tegra_cpuidle_pcie_irqs_in_use(void)
+{
+	if (tegra_idle_driver.states[TEGRA_CC6].disabled ||
+	    tegra_get_chip_id() != TEGRA20)
+		return;
+
+	pr_info("disabling CC6 state, since PCIe IRQs are in use\n");
+	cpuidle_driver_state_disabled(&tegra_idle_driver, TEGRA_CC6, true);
+	tegra_idle_driver.states[TEGRA_CC6].disabled = true;
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
+		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
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

