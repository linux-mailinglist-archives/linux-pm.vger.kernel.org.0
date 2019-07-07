Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906A161880
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 01:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfGGXjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 19:39:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42664 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfGGXjD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 19:39:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so14003790lje.9;
        Sun, 07 Jul 2019 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibMff81hxQNYHOlIYzTner4926/mnrENiZgyVxIq8Wc=;
        b=D2uuoNwPtDOE83IwK1iMitG6dZiINIKRK6DQ9bwx5jSLKaiMr4jGUmfv4xYankgqzK
         4t3NcLuVjM5lmw1TTJ5ekPBTlarznKYk3OComiVtu0gG8jfKCw3iEXugjIg6n/V1bSje
         xXfc65KD/fBD5kxvYlJZUnJb+iwWKC5eeOUpeYwEmEArNPF2vgxKkybfn/MwiTnyEDqb
         IwRyAJJwlNGAicl8bUD3zSEIv2g/bM/382wb6vaqS3mXR62J4ZuMyuB+vPxHZ+WEfyQp
         5t1gulxojc/hYY9gpP1i4RgzEFI5CMvL4uo7bIxwaqVdAMnp39UbPsF76iTumD4ImRAa
         0zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibMff81hxQNYHOlIYzTner4926/mnrENiZgyVxIq8Wc=;
        b=cAoeEgSXuJiTTJ6WK7ByjiacSRO0J9mzbrY4dpHnhLyHRzeUe0rVsl+vTrEXkFWKXT
         Db/4lvUqQpN4+BLm19ZxH14LZIg/NX18w5Mpz/w9aKF7vQ+Q9brBctcoR4GzG/9asl5l
         ELmcz0X46wZr3GK4nkDUY9ocYs+m7kR6QRjJadZJl9VZd6tyL+3jH1TnC1tpGtUXPnFp
         DLhj+2vmAptPz9UEiqA4SsrnfNQ6ODhxGCc3VJDqmpgmmp7PFkINBMC68v+MV8kKaYPv
         stmtBKNKLl127W/ulzDixAt1wruMSVdk2Ty4b+4tGV59cD6Bi4uR2SWFtBcx8K59EK8x
         LUqw==
X-Gm-Message-State: APjAAAUDnwJlI86M/UptwCD7lZkHk1qsLsczKPEE3NnFQmJSClba7FXU
        +4lXDP6Yv4a+LJQJhWhz0N5wNVRt
X-Google-Smtp-Source: APXvYqyhfqWzYEHMoNZyUQxJ5N7Z8hiPFDVZpH/UbuyglkQEvOKv0wD4Iut/4dvO6UtxgibU2m8tcA==
X-Received: by 2002:a2e:8ecb:: with SMTP id e11mr8413509ljl.218.1562542740303;
        Sun, 07 Jul 2019 16:39:00 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id y5sm3246520ljj.5.2019.07.07.16.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 16:38:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] cpuidle: Add unified driver for NVIDIA Tegra SoCs
Date:   Mon,  8 Jul 2019 02:38:06 +0300
Message-Id: <20190707233809.14400-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707233809.14400-1-digetx@gmail.com>
References: <20190707233809.14400-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new driver is based on the old CPU Idle drivers that are removed now
from arm/arch/mach-tegra/ directory. Those removed drivers were reworked
and squashed into a single unified driver that covers multiple hardware
generations, starting from Tegra20 and ending with Tegra124.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c     |   4 +
 drivers/cpuidle/Kconfig.arm     |   8 ++
 drivers/cpuidle/Makefile        |   1 +
 drivers/cpuidle/cpuidle-tegra.c | 237 ++++++++++++++++++++++++++++++++
 include/soc/tegra/cpuidle.h     |   4 +
 5 files changed, 254 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index d9237769a37c..f1ce2857a251 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -36,6 +36,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach-types.h>
+#include <asm/psci.h>
 #include <asm/setup.h>
 
 #include "board.h"
@@ -92,6 +93,9 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("nvidia,tegra20"))
 		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARM_TEGRA_CPUIDLE) && !psci_smp_available())
+		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 48cb3d4bb7d1..d90861361f1d 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -76,3 +76,11 @@ config ARM_MVEBU_V7_CPUIDLE
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
index 9d7176cee3d3..470d17fa8746 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
 obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
+obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
 
 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
new file mode 100644
index 000000000000..3fad4a0cbc78
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -0,0 +1,237 @@
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
+ * Tegra20-124 driver unification by Dmitry Osipenko <digetx@gmail.com>
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+
+#include <linux/clk/tegra.h>
+#include <linux/firmware/trusted_foundations.h>
+
+#include <soc/tegra/cpuidle.h>
+#include <soc/tegra/flowctrl.h>
+#include <soc/tegra/fuse.h>
+#include <soc/tegra/pm.h>
+
+#include <asm/cpuidle.h>
+#include <asm/firmware.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+
+static atomic_t tegra_idle_barrier;
+
+static int tegra_shutdown_secondary_cpu(unsigned long cpu)
+{
+	tegra_cpu_die(cpu);
+
+	return -EINVAL;
+}
+
+static void tegra_await_secondary_cpus(void)
+{
+	/*
+	 * The boot CPU shall await for the secondaries shutdown in order
+	 * to power-off CPU's cluster safely.
+	 */
+	while (!tegra_cpu_rail_off_ready())
+		cpu_relax();
+}
+
+static void tegra_wake_up_secondary_cpus(void)
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
+static int tegra_cpu_idle(struct cpuidle_device *dev,
+			  struct cpuidle_driver *drv,
+			  int index)
+{
+	unsigned int cpu = cpu_logical_map(dev->cpu);
+	int err;
+
+	/*
+	 * On Tegra30 CPU0 can't be power-gated while secondary CPUs
+	 * are active because it gates the whole CPU cluster.
+	 */
+	if (index == 1 && cpu == 0)
+		return arm_cpuidle_simple_enter(dev, drv, 0);
+
+	local_fiq_disable();
+	tegra_set_cpu_in_lp2();
+	cpu_pm_enter();
+
+	switch (index) {
+	case 1:
+		err = cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
+		break;
+	case 2:
+		cpuidle_coupled_parallel_barrier(dev, &tegra_idle_barrier);
+
+		if (cpu == 0) {
+			tegra_await_secondary_cpus();
+			err = tegra_idle_lp2_last();
+			tegra_wake_up_secondary_cpus();
+		} else {
+			err = cpu_suspend(cpu, tegra_shutdown_secondary_cpu);
+		}
+		break;
+	case 3:
+		err = call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
+		if (err && err != -ENOSYS)
+			break;
+
+		err = call_firmware_op(do_idle, 0);
+		if (err && err != -ENOSYS)
+			break;
+
+		/*
+		 * Do suspend by ourselves if the firmware does not
+		 * implement it.
+		 */
+		err = cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	cpu_pm_exit();
+	tegra_clear_cpu_in_lp2();
+	local_fiq_enable();
+
+	smp_rmb();
+
+	return WARN_ON_ONCE(err) ? -1 : index;
+}
+
+static void tegra114_idle_enter_s2idle(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv,
+				       int index)
+{
+	tegra_cpu_idle(dev, drv, index);
+}
+
+static struct cpuidle_driver tegra_idle_driver = {
+	.name = "tegra_idle",
+	.states = {
+		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
+		[1] = {
+			.enter			= tegra_cpu_idle,
+			.exit_latency		= 2000,
+			.target_residency	= 2200,
+			.power_usage		= 0,
+			.flags			= CPUIDLE_FLAG_TIMER_STOP,
+			.name			= "powered-down",
+			.desc			= "CPU core powered-off",
+		},
+		[2] = {
+			.enter			= tegra_cpu_idle,
+			.exit_latency		= 5000,
+			.target_residency	= 10000,
+			.power_usage		= 0,
+			.flags			= CPUIDLE_FLAG_COUPLED |
+						  CPUIDLE_FLAG_TIMER_STOP,
+			.name			= "powered-down",
+			.desc			= "CPU cluster powered-off",
+		},
+		[3] = {
+			.enter			= tegra_cpu_idle,
+			.enter_s2idle		= tegra114_idle_enter_s2idle,
+			.exit_latency		= 500,
+			.target_residency	= 1000,
+			.power_usage		= 0,
+			.flags			= CPUIDLE_FLAG_TIMER_STOP,
+			.name			= "powered-down",
+			.desc			= "CPU core power-gated",
+		},
+	},
+	.state_count = 4,
+	.safe_state_index = 0,
+};
+
+/*
+ * Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
+ * they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
+ * this, simply disable LP2 if the PCI driver and DT node are both enabled.
+ */
+void tegra_cpuidle_pcie_irqs_in_use(void)
+{
+	if (tegra_get_chip_id() != TEGRA20 ||
+	    tegra_idle_driver.states[2].disabled)
+		return;
+
+	pr_info("Disabling cpuidle LP2 state, since PCIe IRQs are in use\n");
+	tegra_idle_driver.states[2].disabled = true;
+}
+
+static int tegra_cpuidle_probe(struct platform_device *pdev)
+{
+	const struct cpumask *coupled_cpus = cpu_possible_mask;
+
+	/*
+	 * Generic WFI state is common for all NVIDIA Tegra SoCs.
+	 *
+	 * Secondary CPU core can't be power-gated separately from CPU0
+	 * on Tegra20.
+	 *
+	 * On Tegra114/124 all CPU cores could be power-gated separately.
+	 */
+	switch (tegra_get_chip_id()) {
+	case TEGRA20:
+		tegra_idle_driver.states[1].disabled = true;
+		tegra_idle_driver.states[3].disabled = true;
+		break;
+	case TEGRA30:
+		tegra_idle_driver.states[2].disabled = true;
+		tegra_idle_driver.states[3].disabled = true;
+		break;
+	case TEGRA114:
+	case TEGRA124:
+		tegra_idle_driver.states[1].disabled = true;
+		tegra_idle_driver.states[2].disabled = true;
+
+		coupled_cpus = NULL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!IS_ENABLED(CONFIG_PM_SLEEP)) {
+		tegra_idle_driver.states[1].disabled = true;
+		tegra_idle_driver.states[2].disabled = true;
+	}
+
+	return cpuidle_register(&tegra_idle_driver, coupled_cpus);
+}
+
+static struct platform_driver tegra_cpuidle_driver = {
+	.probe = tegra_cpuidle_probe,
+	.driver = {
+		.name = "tegra-cpuidle",
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(tegra_cpuidle_driver);
diff --git a/include/soc/tegra/cpuidle.h b/include/soc/tegra/cpuidle.h
index f758808342b6..5665975015d8 100644
--- a/include/soc/tegra/cpuidle.h
+++ b/include/soc/tegra/cpuidle.h
@@ -6,8 +6,12 @@
 #ifndef __SOC_TEGRA_CPUIDLE_H__
 #define __SOC_TEGRA_CPUIDLE_H__
 
+#ifdef CONFIG_ARM_TEGRA_CPUIDLE
+void tegra_cpuidle_pcie_irqs_in_use(void);
+#else
 static inline void tegra_cpuidle_pcie_irqs_in_use(void)
 {
 }
+#endif
 
 #endif /* __SOC_TEGRA_CPUIDLE_H__ */
-- 
2.22.0

