Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF44699BF
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfGOR35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 13:29:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44556 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731838AbfGOR35 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 13:29:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so6695577lfm.11;
        Mon, 15 Jul 2019 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rlXTyJMYpzUBstnyetLObobNUoJMGaePqJSvqyF2PiA=;
        b=Xxd5N+R1yuSFK2m29GZXIIIei+oP32X4nswgxWjBtlwJ9BTaBGR1PKUPdRpXlyCfu9
         u7HBgp3QpifHCtoXbY07XCrmbeacfANqjjUvfBr6TCasG445AFa+M+2867HEpD9neRj2
         aLNRpZfw16J1Pv8l2MUQ5sFXEdWkQ1R8Ntpd2ey1IsXjeSsSRul8SjxDmsnr7+s/NRdr
         tX9H0KrScgk+fAB3yqQ4fQJzFvIEKpS5hq/I0Kqepsk+V3Vv93ZvJ5MgU8PCxd21gSr4
         AU6urDxd5zEDvoojDoJfDzk1Y+ieAmCN1Xt1cPMeV3PeBIOwQVo7Dy0bhq9jOXiB1nG+
         WBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlXTyJMYpzUBstnyetLObobNUoJMGaePqJSvqyF2PiA=;
        b=mrj5z0O4Xqwik2K5Hh3g07ZfdbI5mgYtoAA2XM2ok4feZt/8ZydWBYyJjV1d3IFZw1
         ht5erIK1xW7nG38+r+6WMmGHLFyeMcBR7autavIhmu0qU6tvazDkFz9HYHJWDM74EbuN
         lWJI/fyBW35CJWjVrFjCD97mWqe+L6Zs1m6iO0E1V0QPV7WD0RJ250oENPoAUWO/YjNP
         8K7s7fOaIlRooBEm1r/kI3fHbJQ9EmWssYwoYPstRilMrv8KcNms4DMLjcmkn81o7pZq
         W6law1dwz3lSQYHu4apQv3T6D/sqnn9dOIDvmczuYGqIubwBeqd28SHe2LdJjJFUbUDG
         jfGA==
X-Gm-Message-State: APjAAAUHj31AVb7Hhty4lQwQGlF9EN1uAmINEYrhhU3c0qSzu82zZK6a
        qUWwlLzg/f0B1Q4ieKmyGrGmAtMG
X-Google-Smtp-Source: APXvYqzeVvr5rcFgYQUGHViEgd49oF3olYH6OA8job4Itt/VkiqMrXV5Lmnpcz5gbGli7GhoWkVbig==
X-Received: by 2002:ac2:5c1d:: with SMTP id r29mr11100976lfp.72.1563211793736;
        Mon, 15 Jul 2019 10:29:53 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/13] cpuidle: Introduce unified driver for NVIDIA Tegra SoCs
Date:   Mon, 15 Jul 2019 20:26:25 +0300
Message-Id: <20190715172629.4437-10-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new driver is based on the old CPU Idle drivers that are removed now
from arm/arch/mach-tegra/ directory. Those removed drivers were reworked
and squashed into a single unified driver that covers multiple hardware
generations, starting from Tegra20 and ending with Tegra124. The new
driver takes slightly different approach in regards to handling of CC6
state by parking secondary CPUs explicitly into offline state, in contrast
to CPUs suspend/resume racing that old Tegra20 had. The new driver doesn't
ignore any possible errors and provides useful diagnostics information in
a case of failure.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/Kconfig.arm     |   8 +
 drivers/cpuidle/Makefile        |   1 +
 drivers/cpuidle/cpuidle-tegra.c | 349 ++++++++++++++++++++++++++++++++
 include/soc/tegra/cpuidle.h     |   4 +
 4 files changed, 362 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c

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
index 000000000000..2ab293343069
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -0,0 +1,349 @@
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
+#include <linux/firmware/trusted_foundations.h>
+
+#include <soc/tegra/cpuidle.h>
+#include <soc/tegra/flowctrl.h>
+#include <soc/tegra/fuse.h>
+#include <soc/tegra/irq.h>
+#include <soc/tegra/pm.h>
+
+#include <asm/cpuidle.h>
+#include <asm/firmware.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+
+#define TEGRA_C1	0
+#define TEGRA_C7	1
+#define TEGRA_CC6	2
+
+static atomic_t tegra_idle_barrier;
+static atomic_t tegra_abort_flag;
+
+static inline bool tegra_cpuidle_using_firmware(void)
+{
+	return firmware_ops->prepare_idle && firmware_ops->do_idle;
+}
+
+static void tegra_cpuidle_report_cpus_state(void)
+{
+	unsigned int cpu, lcpu;
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
+	ktime_t timeout = ktime_add_ms(ktime_get(), 100);
+
+	/*
+	 * The primary CPU0 core shall wait for the secondaries shutdown
+	 * in order to power-off CPU's cluster safely.  The timeout value
+	 * depends on the current CPU frequency, it takes about 40-150us
+	 * in average and over 1000us in a worst case scenario.
+	 */
+	do {
+		if (tegra_cpu_rail_off_ready())
+			return 0;
+
+	} while (ktime_compare(ktime_get(), timeout) < 0);
+
+	/* postmortem */
+	tegra_cpuidle_report_cpus_state();
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
+	int err;
+
+	if (cpu > 0) {
+		err = cpu_suspend(cpu, tegra_pm_park_secondary_cpu);
+	} else {
+		err = tegra_cpuidle_wait_for_secondary_cpus_parking();
+		if (err)
+			return err;
+
+		err = tegra_pm_enter_lp2();
+
+		tegra_cpuidle_unpark_secondary_cpus();
+	}
+
+	return err;
+}
+
+static int tegra_cpuidle_c7_enter(void)
+{
+	int err;
+
+	if (tegra_cpuidle_using_firmware()) {
+		err = call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
+		if (err)
+			return err;
+
+		return call_firmware_op(do_idle, 0);
+	}
+
+	return cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
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
+	int err;
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
+		err = tegra_cpuidle_coupled_barrier(dev);
+		if (err)
+			return err;
+	}
+
+	local_fiq_disable();
+	tegra_pm_set_cpu_in_lp2();
+	cpu_pm_enter();
+
+	switch (index) {
+	case TEGRA_C7:
+		err = tegra_cpuidle_c7_enter();
+		break;
+	case TEGRA_CC6:
+		err = tegra_cpuidle_cc6_enter(cpu);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	cpu_pm_exit();
+	tegra_pm_clear_cpu_in_lp2();
+	local_fiq_enable();
+
+	return err;
+}
+
+static int tegra_cpuidle_adjust_state_index(struct cpuidle_device *dev,
+					    struct cpuidle_driver *drv,
+					    int index, unsigned int cpu)
+{
+	/*
+	 * On Tegra30 CPU0 can't be power-gated while secondary CPUs
+	 * are active because it gates the whole CPU cluster.
+	 */
+	if (cpu != 0 || index != TEGRA_C7 || tegra_get_chip_id() != TEGRA30)
+		return index;
+
+	if (!IS_ENABLED(CONFIG_PM_SLEEP) || num_online_cpus() > 1)
+		index = TEGRA_C1;
+	else
+		index = TEGRA_CC6;
+
+	if (drv->states[index].disabled || dev->states_usage[index].disable)
+		index = -1;
+
+	return index;
+}
+
+static int tegra_cpuidle_enter(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv,
+			       int index)
+{
+	unsigned int cpu = cpu_logical_map(dev->cpu);
+	int err;
+
+	index = tegra_cpuidle_adjust_state_index(dev, drv, index, cpu);
+	if (index < 0)
+		return index;
+
+	if (index == TEGRA_C1)
+		err = arm_cpuidle_simple_enter(dev, drv, index);
+	else
+		err = tegra_cpuidle_state_enter(dev, index, cpu);
+
+	if (err && (err != -EINTR || index != TEGRA_CC6))
+		pr_err_once("failed to enter state %d err: %d\n", index, err);
+
+	return err ? -1 : index;
+}
+
+static void tegra114_enter_s2idle(struct cpuidle_device *dev,
+				  struct cpuidle_driver *drv,
+				  int index)
+{
+	tegra_cpuidle_enter(dev, drv, index);
+}
+
+static struct cpuidle_driver tegra_idle_driver = {
+	.name = "tegra_idle",
+	.states = {
+		[TEGRA_C1] = ARM_CPUIDLE_WFI_STATE_PWR(600),
+		[TEGRA_C7] = {
+			.enter			= tegra_cpuidle_enter,
+			.exit_latency		= 2000,
+			.target_residency	= 2200,
+			.power_usage		= 100,
+			.flags			= CPUIDLE_FLAG_TIMER_STOP,
+			.name			= "C7",
+			.desc			= "CPU core powered off",
+		},
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
+	.state_count = 3,
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
+	tegra_idle_driver.states[TEGRA_CC6].disabled = true;
+}
+
+static void tegra_cpuidle_setup_tegra114_c7_state(void)
+{
+	struct cpuidle_state *s = &tegra_idle_driver.states[TEGRA_C7];
+
+	s->enter_s2idle = tegra114_enter_s2idle;
+	s->target_residency = 1000;
+	s->exit_latency = 500;
+}
+
+static int tegra_cpuidle_probe(struct platform_device *pdev)
+{
+	/*
+	 * Required suspend-resume functionality, which is provided by the
+	 * Tegra-arch core and PMC driver, is unavailable if PM-sleep option
+	 * is disabled.
+	 */
+	if (!IS_ENABLED(CONFIG_PM_SLEEP)) {
+		if (!tegra_cpuidle_using_firmware())
+			tegra_idle_driver.states[TEGRA_C7].disabled = true;
+
+		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
+	}
+
+	/*
+	 * Generic WFI state (also known as C1 or LP3) and the coupled CPU
+	 * cluster power-off (CC6 or LP2) states are common for all Tegra SoCs.
+	 */
+	switch (tegra_get_chip_id()) {
+	case TEGRA20:
+		/* Tegra20 isn't capable to power-off individual CPU cores */
+		tegra_idle_driver.states[TEGRA_C7].disabled = true;
+		break;
+	case TEGRA30:
+		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
+		break;
+	case TEGRA114:
+	case TEGRA124:
+		tegra_cpuidle_setup_tegra114_c7_state();
+
+		/* coupled CC6 (LP2) state isn't implemented yet */
+		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
+		break;
+	default:
+		return -EINVAL;
+	}
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

