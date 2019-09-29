Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970B3C18D2
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfI2SA5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35599 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfI2SAO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so7116410lji.2;
        Sun, 29 Sep 2019 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9J6MCliv+ng9er+HYIptAC1zq0kRvQPa3den7Juc6c=;
        b=nTobptm8hZ64D8S3su51EKhrMm+XC0MVs49OBBzux84QuUJJ9SJDO5Vw1gR4g8jyLJ
         LFMZ/KtpctNO8zsEVSSMgrEkzYj0T3O2yH0ZtzLHZY/Hg2zk2Bu4sJj2eLbGuAXbcT18
         HrEqEpdiPuBWWGfC3pG0L+fGs4JUXtCy4aClDtqZSXdBX4YfaFagNGLPKA2Ygi2ZtxUi
         8L3koE9eizasUvnaUg51aM8gVXKOOqeiP50A8TOfAb1QqJRpVGOxxwaiDSl+MaQWhHHk
         57MBCti+y/Nr0GGTCAdoIcXUsJKS8tdVGudysg/W6denNL0TYdsritmm0JIkmeij4bKs
         ++xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9J6MCliv+ng9er+HYIptAC1zq0kRvQPa3den7Juc6c=;
        b=Bzcl+DMqcVLqQrtixG9z2h3KRRA8VfW7oKPU2KqCrw8tHEctZwpTnXBLmGXwA32VVi
         IgV5O8Up6QQm21vuXv+acfj7yKsS3ZAZfwIWbFLxOi8CSbVDK04lMVDCeknIYMpaGWn3
         3VCqZaRFA4uB+2PvKkwOKbsIw6sCKDVzILGTFmvSB/nZdruzvISmyurcMYqhxaRZ+YWx
         TyeFfHK7YhAq3X6n2AU9nC0S+6qzoCvb2935biu9/SVSbi4xAAkiAhPr6Qc+ydFuLoxN
         Ojd9I++ualUqaSI2fP/yYU2v7lRnsjZpq44RhCHIc9/qtjGzBK/KJ1Qp7tO16LkktFNU
         b1sQ==
X-Gm-Message-State: APjAAAV751b+kCXMhdykcQYjdoWs5Ab/Wg94ONt9aVwflc7XgKg4P61y
        ch2q1O4luuYyPywLsWs6trY=
X-Google-Smtp-Source: APXvYqxGkaYXZcSvQTFn0nF9PstpbZNXsLCO5N73ucoI8NJetHnPqFJ89moTiVHTO3Wsy1p9fF3SMQ==
X-Received: by 2002:a2e:844b:: with SMTP id u11mr9525896ljh.201.1569780009308;
        Sun, 29 Sep 2019 11:00:09 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/14] ARM: tegra: Remove cpuidle drivers to replace them with a new driver
Date:   Sun, 29 Sep 2019 20:59:39 +0300
Message-Id: <20190929175952.22690-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove the old drivers to replace them cleanly with a new one later on.
Please note that old Tegra20 CPUIDLE driver used pen-locking in order to
block secondary CPU waking-up if IRQ happened to raise during of the
entering into CC6 and primary CPU already crossed point of no return, but
that is unnecessary in practice because CPUIDLE simply won't enter the
coupled CC6 state if there is some CPU activity going on. The new driver
will ensure that all secondary CPUs parked successfully at first and thus
primary CPU won't be racing with the secondaries, hence the pen-locking
functionality isn't needed anymore at all. This is the most notable thing
of this patch.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/Makefile           |  13 --
 arch/arm/mach-tegra/cpuidle-tegra114.c |  89 -----------
 arch/arm/mach-tegra/cpuidle-tegra20.c  | 212 -------------------------
 arch/arm/mach-tegra/cpuidle-tegra30.c  | 132 ---------------
 arch/arm/mach-tegra/cpuidle.c          |  50 ------
 arch/arm/mach-tegra/cpuidle.h          |  21 ---
 arch/arm/mach-tegra/irq.c              |   1 -
 arch/arm/mach-tegra/irq.h              |  11 --
 arch/arm/mach-tegra/pm.c               |   7 -
 arch/arm/mach-tegra/pm.h               |   1 -
 arch/arm/mach-tegra/reset-handler.S    |  11 --
 arch/arm/mach-tegra/reset.h            |   9 +-
 arch/arm/mach-tegra/sleep-tegra20.S    | 170 --------------------
 arch/arm/mach-tegra/sleep.h            |  12 --
 arch/arm/mach-tegra/tegra.c            |   3 -
 drivers/soc/tegra/Kconfig              |   1 -
 include/soc/tegra/cpuidle.h            |   4 -
 17 files changed, 2 insertions(+), 745 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.h
 delete mode 100644 arch/arm/mach-tegra/irq.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 6c1dff2eccc2..5d93a0b36866 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -8,29 +8,16 @@ obj-y					+= reset.o
 obj-y					+= reset-handler.o
 obj-y					+= sleep.o
 obj-y					+= tegra.o
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= cpuidle-tegra20.o
-endif
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
-endif
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
-endif
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= pm-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= cpuidle-tegra114.o
-endif
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
deleted file mode 100644
index 5118f777fd66..000000000000
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ /dev/null
@@ -1,89 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2013, NVIDIA Corporation. All rights reserved.
- */
-
-#include <asm/firmware.h>
-#include <linux/tick.h>
-#include <linux/cpuidle.h>
-#include <linux/cpu_pm.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-#include <linux/firmware/trusted_foundations.h>
-
-#include <asm/cpuidle.h>
-#include <asm/smp_plat.h>
-#include <asm/suspend.h>
-#include <asm/psci.h>
-
-#include "cpuidle.h"
-#include "pm.h"
-#include "sleep.h"
-
-#ifdef CONFIG_PM_SLEEP
-#define TEGRA114_MAX_STATES 2
-#else
-#define TEGRA114_MAX_STATES 1
-#endif
-
-#ifdef CONFIG_PM_SLEEP
-static int tegra114_idle_power_down(struct cpuidle_device *dev,
-				    struct cpuidle_driver *drv,
-				    int index)
-{
-	local_fiq_disable();
-
-	tegra_set_cpu_in_lp2();
-	cpu_pm_enter();
-
-	call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
-
-	/* Do suspend by ourselves if the firmware does not implement it */
-	if (call_firmware_op(do_idle, 0) == -ENOSYS)
-		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
-
-	cpu_pm_exit();
-	tegra_clear_cpu_in_lp2();
-
-	local_fiq_enable();
-
-	return index;
-}
-
-static void tegra114_idle_enter_s2idle(struct cpuidle_device *dev,
-				       struct cpuidle_driver *drv,
-				       int index)
-{
-       tegra114_idle_power_down(dev, drv, index);
-}
-#endif
-
-static struct cpuidle_driver tegra_idle_driver = {
-	.name = "tegra_idle",
-	.owner = THIS_MODULE,
-	.state_count = TEGRA114_MAX_STATES,
-	.states = {
-		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
-#ifdef CONFIG_PM_SLEEP
-		[1] = {
-			.enter			= tegra114_idle_power_down,
-			.enter_s2idle		= tegra114_idle_enter_s2idle,
-			.exit_latency		= 500,
-			.target_residency	= 1000,
-			.flags			= CPUIDLE_FLAG_TIMER_STOP,
-			.power_usage		= 0,
-			.name			= "powered-down",
-			.desc			= "CPU power gated",
-		},
-#endif
-	},
-};
-
-int __init tegra114_cpuidle_init(void)
-{
-	if (!psci_smp_available())
-		return cpuidle_register(&tegra_idle_driver, NULL);
-
-	return 0;
-}
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
deleted file mode 100644
index 2447427cb4a8..000000000000
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ /dev/null
@@ -1,212 +0,0 @@
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
-#include <linux/module.h>
-
-#include <soc/tegra/flowctrl.h>
-
-#include <asm/cpuidle.h>
-#include <asm/smp_plat.h>
-#include <asm/suspend.h>
-
-#include "cpuidle.h"
-#include "iomap.h"
-#include "irq.h"
-#include "pm.h"
-#include "reset.h"
-#include "sleep.h"
-
-#ifdef CONFIG_PM_SLEEP
-static bool abort_flag;
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
-static int tegra20_reset_sleeping_cpu_1(void)
-{
-	int ret = 0;
-
-	tegra_pen_lock();
-
-	if (readb(tegra20_cpu1_resettable_status) == CPU_RESETTABLE)
-		tegra20_cpu_shutdown(1);
-	else
-		ret = -EINVAL;
-
-	tegra_pen_unlock();
-
-	return ret;
-}
-
-static void tegra20_wake_cpu1_from_reset(void)
-{
-	tegra_pen_lock();
-
-	tegra20_cpu_clear_resettable();
-
-	/* enable cpu clock on cpu */
-	tegra_enable_cpu_clock(1);
-
-	/* take the CPU out of reset */
-	tegra_cpu_out_of_reset(1);
-
-	/* unhalt the cpu */
-	flowctrl_write_cpu_halt(1, 0);
-
-	tegra_pen_unlock();
-}
-
-static int tegra20_reset_cpu_1(void)
-{
-	if (!cpu_online(1) || !tegra20_reset_sleeping_cpu_1())
-		return 0;
-
-	tegra20_wake_cpu1_from_reset();
-	return -EBUSY;
-}
-#else
-static inline void tegra20_wake_cpu1_from_reset(void)
-{
-}
-
-static inline int tegra20_reset_cpu_1(void)
-{
-	return 0;
-}
-#endif
-
-static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
-					   struct cpuidle_driver *drv,
-					   int index)
-{
-	while (tegra20_cpu_is_resettable_soon())
-		cpu_relax();
-
-	if (tegra20_reset_cpu_1() || !tegra_cpu_rail_off_ready())
-		return false;
-
-	tegra_idle_lp2_last();
-
-	if (cpu_online(1))
-		tegra20_wake_cpu1_from_reset();
-
-	return true;
-}
-
-#ifdef CONFIG_SMP
-static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
-					 struct cpuidle_driver *drv,
-					 int index)
-{
-	cpu_suspend(0, tegra20_sleep_cpu_secondary_finish);
-
-	tegra20_cpu_clear_resettable();
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
-		WRITE_ONCE(abort_flag, true);
-
-	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
-
-	if (abort_flag) {
-		cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
-		abort_flag = false;	/* clean flag for next coming */
-		return -EINTR;
-	}
-
-	local_fiq_disable();
-
-	tegra_set_cpu_in_lp2();
-	cpu_pm_enter();
-
-	if (dev->cpu == 0)
-		entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv, index);
-	else
-		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
-
-	cpu_pm_exit();
-	tegra_clear_cpu_in_lp2();
-
-	local_fiq_enable();
-
-	smp_rmb();
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
-	tegra_idle_driver.states[1].disabled = true;
-}
-
-int __init tegra20_cpuidle_init(void)
-{
-	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
-}
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
deleted file mode 100644
index c6128526877d..000000000000
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ /dev/null
@@ -1,132 +0,0 @@
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
-#include <linux/module.h>
-
-#include <asm/cpuidle.h>
-#include <asm/smp_plat.h>
-#include <asm/suspend.h>
-
-#include "cpuidle.h"
-#include "pm.h"
-#include "sleep.h"
-
-#ifdef CONFIG_PM_SLEEP
-static int tegra30_idle_lp2(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv,
-			    int index);
-#endif
-
-static struct cpuidle_driver tegra_idle_driver = {
-	.name = "tegra_idle",
-	.owner = THIS_MODULE,
-#ifdef CONFIG_PM_SLEEP
-	.state_count = 2,
-#else
-	.state_count = 1,
-#endif
-	.states = {
-		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
-#ifdef CONFIG_PM_SLEEP
-		[1] = {
-			.enter			= tegra30_idle_lp2,
-			.exit_latency		= 2000,
-			.target_residency	= 2200,
-			.power_usage		= 0,
-			.flags			= CPUIDLE_FLAG_TIMER_STOP,
-			.name			= "powered-down",
-			.desc			= "CPU power gated",
-		},
-#endif
-	},
-};
-
-#ifdef CONFIG_PM_SLEEP
-static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
-					   struct cpuidle_driver *drv,
-					   int index)
-{
-	/* All CPUs entering LP2 is not working.
-	 * Don't let CPU0 enter LP2 when any secondary CPU is online.
-	 */
-	if (num_online_cpus() > 1 || !tegra_cpu_rail_off_ready()) {
-		cpu_do_idle();
-		return false;
-	}
-
-	tegra_idle_lp2_last();
-
-	return true;
-}
-
-#ifdef CONFIG_SMP
-static bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv,
-					int index)
-{
-	smp_wmb();
-
-	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
-
-	return true;
-}
-#else
-static inline bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
-					       struct cpuidle_driver *drv,
-					       int index)
-{
-	return true;
-}
-#endif
-
-static int tegra30_idle_lp2(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv,
-			    int index)
-{
-	bool entered_lp2 = false;
-	bool last_cpu;
-
-	local_fiq_disable();
-
-	last_cpu = tegra_set_cpu_in_lp2();
-	cpu_pm_enter();
-
-	if (dev->cpu == 0) {
-		if (last_cpu)
-			entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv,
-								     index);
-		else
-			cpu_do_idle();
-	} else {
-		entered_lp2 = tegra30_cpu_core_power_down(dev, drv, index);
-	}
-
-	cpu_pm_exit();
-	tegra_clear_cpu_in_lp2();
-
-	local_fiq_enable();
-
-	smp_rmb();
-
-	return (entered_lp2) ? index : 0;
-}
-#endif
-
-int __init tegra30_cpuidle_init(void)
-{
-	return cpuidle_register(&tegra_idle_driver, NULL);
-}
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
deleted file mode 100644
index d565c44cfc93..000000000000
--- a/arch/arm/mach-tegra/cpuidle.c
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/mach-tegra/cpuidle.c
- *
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
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-#include <soc/tegra/fuse.h>
-
-#include "cpuidle.h"
-
-void __init tegra_cpuidle_init(void)
-{
-	switch (tegra_get_chip_id()) {
-	case TEGRA20:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
-			tegra20_cpuidle_init();
-		break;
-	case TEGRA30:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
-			tegra30_cpuidle_init();
-		break;
-	case TEGRA114:
-	case TEGRA124:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) ||
-		    IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC))
-			tegra114_cpuidle_init();
-		break;
-	}
-}
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
deleted file mode 100644
index 4e1f459f5bd8..000000000000
--- a/arch/arm/mach-tegra/cpuidle.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2012, NVIDIA Corporation. All rights reserved.
- */
-
-#ifndef __MACH_TEGRA_CPUIDLE_H
-#define __MACH_TEGRA_CPUIDLE_H
-
-#ifdef CONFIG_CPU_IDLE
-int tegra20_cpuidle_init(void);
-void tegra20_cpuidle_pcie_irqs_in_use(void);
-int tegra30_cpuidle_init(void);
-int tegra114_cpuidle_init(void);
-void tegra_cpuidle_init(void);
-void tegra_cpuidle_pcie_irqs_in_use(void);
-#else
-static inline void tegra_cpuidle_init(void) {}
-static inline void tegra_cpuidle_pcie_irqs_in_use(void) {}
-#endif
-
-#endif
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index ace7a390b5fe..4c065b54cbe7 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -20,7 +20,6 @@
 
 #include "board.h"
 #include "iomap.h"
-#include "irq.h"
 
 #define SGI_MASK 0xFFFF
 
diff --git a/arch/arm/mach-tegra/irq.h b/arch/arm/mach-tegra/irq.h
deleted file mode 100644
index 7a94cf121448..000000000000
--- a/arch/arm/mach-tegra/irq.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2012, NVIDIA Corporation. All rights reserved.
- */
-
-#ifndef __TEGRA_IRQ_H
-#define __TEGRA_IRQ_H
-
-bool tegra_pending_sgi(void);
-
-#endif
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 3cab81b82866..6aaacb5757e1 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -137,18 +137,11 @@ bool tegra_set_cpu_in_lp2(void)
 
 	if ((phy_cpu_id == 0) && cpumask_equal(cpu_lp2_mask, cpu_online_mask))
 		last_cpu = true;
-	else if (tegra_get_chip_id() == TEGRA20 && phy_cpu_id == 1)
-		tegra20_cpu_set_resettable_soon();
 
 	spin_unlock(&tegra_lp2_lock);
 	return last_cpu;
 }
 
-int tegra_cpu_do_idle(void)
-{
-	return cpu_do_idle();
-}
-
 static int tegra_sleep_cpu(unsigned long v2p)
 {
 	/*
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 569151b3edc0..1e51a9b636eb 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -25,7 +25,6 @@ void tegra30_sleep_core_init(void);
 
 void tegra_clear_cpu_in_lp2(void);
 bool tegra_set_cpu_in_lp2(void);
-int tegra_cpu_do_idle(void);
 void tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 67b763fea005..df44828a34d3 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -183,17 +183,6 @@ after_errata:
 	bleq	__die				@ CPU not present (to OS)
 #endif
 
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
-	/* Are we on Tegra20? */
-	cmp	r6, #TEGRA20
-	bne	1f
-	/* If not CPU0, don't let CPU0 reset CPU1 now that CPU1 is coming up. */
-	mov	r0, #CPU_NOT_RESETTABLE
-	cmp	r10, #0
-	strbne	r0, [r12, #RESET_DATA(RESETTABLE_STATUS)]
-1:
-#endif
-
 	/* Waking up from LP1? */
 	ldr	r8, [r12, #RESET_DATA(MASK_LP1)]
 	tst	r8, r11				@ if in_lp1
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index a4cfc08159f6..51265592cb1a 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -16,9 +16,8 @@
 #define TEGRA_RESET_STARTUP_SECONDARY	3
 #define TEGRA_RESET_STARTUP_LP2		4
 #define TEGRA_RESET_STARTUP_LP1		5
-#define TEGRA_RESET_RESETTABLE_STATUS	6
-#define TEGRA_RESET_TF_PRESENT		7
-#define TEGRA_RESET_DATA_SIZE		8
+#define TEGRA_RESET_TF_PRESENT		6
+#define TEGRA_RESET_DATA_SIZE		7
 
 #define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
 
@@ -42,10 +41,6 @@ void __tegra_cpu_reset_handler_end(void);
 	(IO_ADDRESS(TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET + \
 	((u32)&__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_LP2] - \
 	 (u32)__tegra_cpu_reset_handler_start)))
-#define tegra20_cpu1_resettable_status \
-	(IO_ADDRESS(TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET + \
-	((u32)&__tegra_cpu_reset_handler_data[TEGRA_RESET_RESETTABLE_STATUS] - \
-	 (u32)__tegra_cpu_reset_handler_start)))
 #endif
 
 #define tegra_cpu_reset_handler_offset \
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index 9a89f30d53ca..0e00ba8cf646 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -43,9 +43,6 @@
 #define APB_MISC_XM2CFGCPADCTRL2	0x8e4
 #define APB_MISC_XM2CFGDPADCTRL2	0x8e8
 
-#define __tegra20_cpu1_resettable_status_offset \
-	(__tegra_cpu_reset_handler_data_offset + RESET_DATA(RESETTABLE_STATUS))
-
 .macro pll_enable, rd, r_car_base, pll_base
 	ldr	\rd, [\r_car_base, #\pll_base]
 	tst	\rd, #(1 << 30)
@@ -90,10 +87,6 @@ ENDPROC(tegra20_hotplug_shutdown)
 ENTRY(tegra20_cpu_shutdown)
 	cmp	r0, #0
 	reteq	lr			@ must not be called for CPU 0
-	mov32	r1, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r2, =__tegra20_cpu1_resettable_status_offset
-	mov	r12, #CPU_RESETTABLE
-	strb	r12, [r1, r2]
 
 	cpu_to_halt_reg r1, r0
 	ldr	r3, =TEGRA_FLOW_CTRL_VIRT
@@ -116,107 +109,6 @@ ENDPROC(tegra20_cpu_shutdown)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-/*
- * tegra_pen_lock
- *
- * spinlock implementation with no atomic test-and-set and no coherence
- * using Peterson's algorithm on strongly-ordered registers
- * used to synchronize a cpu waking up from wfi with entering lp2 on idle
- *
- * The reference link of Peterson's algorithm:
- * http://en.wikipedia.org/wiki/Peterson's_algorithm
- *
- * SCRATCH37 = r1 = !turn (inverted from Peterson's algorithm)
- * on cpu 0:
- * r2 = flag[0] (in SCRATCH38)
- * r3 = flag[1] (in SCRATCH39)
- * on cpu1:
- * r2 = flag[1] (in SCRATCH39)
- * r3 = flag[0] (in SCRATCH38)
- *
- * must be called with MMU on
- * corrupts r0-r3, r12
- */
-ENTRY(tegra_pen_lock)
-	mov32	r3, TEGRA_PMC_VIRT
-	cpu_id	r0
-	add	r1, r3, #PMC_SCRATCH37
-	cmp	r0, #0
-	addeq	r2, r3, #PMC_SCRATCH38
-	addeq	r3, r3, #PMC_SCRATCH39
-	addne	r2, r3, #PMC_SCRATCH39
-	addne	r3, r3, #PMC_SCRATCH38
-
-	mov	r12, #1
-	str	r12, [r2]		@ flag[cpu] = 1
-	dsb
-	str	r12, [r1]		@ !turn = cpu
-1:	dsb
-	ldr	r12, [r3]
-	cmp	r12, #1			@ flag[!cpu] == 1?
-	ldreq	r12, [r1]
-	cmpeq	r12, r0			@ !turn == cpu?
-	beq	1b			@ while !turn == cpu && flag[!cpu] == 1
-
-	ret	lr			@ locked
-ENDPROC(tegra_pen_lock)
-
-ENTRY(tegra_pen_unlock)
-	dsb
-	mov32	r3, TEGRA_PMC_VIRT
-	cpu_id	r0
-	cmp	r0, #0
-	addeq	r2, r3, #PMC_SCRATCH38
-	addne	r2, r3, #PMC_SCRATCH39
-	mov	r12, #0
-	str	r12, [r2]
-	ret     lr
-ENDPROC(tegra_pen_unlock)
-
-/*
- * tegra20_cpu_clear_resettable(void)
- *
- * Called to clear the "resettable soon" flag in IRAM variable when
- * it is expected that the secondary CPU will be idle soon.
- */
-ENTRY(tegra20_cpu_clear_resettable)
-	mov32	r1, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r2, =__tegra20_cpu1_resettable_status_offset
-	mov	r12, #CPU_NOT_RESETTABLE
-	strb	r12, [r1, r2]
-	ret	lr
-ENDPROC(tegra20_cpu_clear_resettable)
-
-/*
- * tegra20_cpu_set_resettable_soon(void)
- *
- * Called to set the "resettable soon" flag in IRAM variable when
- * it is expected that the secondary CPU will be idle soon.
- */
-ENTRY(tegra20_cpu_set_resettable_soon)
-	mov32	r1, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r2, =__tegra20_cpu1_resettable_status_offset
-	mov	r12, #CPU_RESETTABLE_SOON
-	strb	r12, [r1, r2]
-	ret	lr
-ENDPROC(tegra20_cpu_set_resettable_soon)
-
-/*
- * tegra20_cpu_is_resettable_soon(void)
- *
- * Returns true if the "resettable soon" flag in IRAM variable has been
- * set because it is expected that the secondary CPU will be idle soon.
- */
-ENTRY(tegra20_cpu_is_resettable_soon)
-	mov32	r1, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r2, =__tegra20_cpu1_resettable_status_offset
-	ldrb	r12, [r1, r2]
-	cmp	r12, #CPU_RESETTABLE_SOON
-	moveq	r0, #1
-	movne	r0, #0
-	ret	lr
-ENDPROC(tegra20_cpu_is_resettable_soon)
-
 /*
  * tegra20_sleep_core_finish(unsigned long v2p)
  *
@@ -242,68 +134,6 @@ ENTRY(tegra20_sleep_core_finish)
 	ret	r3
 ENDPROC(tegra20_sleep_core_finish)
 
-/*
- * tegra20_sleep_cpu_secondary_finish(unsigned long v2p)
- *
- * Enters WFI on secondary CPU by exiting coherency.
- */
-ENTRY(tegra20_sleep_cpu_secondary_finish)
-	stmfd	sp!, {r4-r11, lr}
-
-	mrc	p15, 0, r11, c1, c0, 1  @ save actlr before exiting coherency
-
-	/* Flush and disable the L1 data cache */
-	mov	r0, #TEGRA_FLUSH_CACHE_LOUIS
-	bl	tegra_disable_clean_inv_dcache
-
-	mov32	r0, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r4, =__tegra20_cpu1_resettable_status_offset
-	mov	r3, #CPU_RESETTABLE
-	strb	r3, [r0, r4]
-
-	bl	tegra_cpu_do_idle
-
-	/*
-	 * cpu may be reset while in wfi, which will return through
-	 * tegra_resume to cpu_resume
-	 * or interrupt may wake wfi, which will return here
-	 * cpu state is unchanged - MMU is on, cache is on, coherency
-	 * is off, and the data cache is off
-	 *
-	 * r11 contains the original actlr
-	 */
-
-	bl	tegra_pen_lock
-
-	mov32	r0, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r4, =__tegra20_cpu1_resettable_status_offset
-	mov	r3, #CPU_NOT_RESETTABLE
-	strb	r3, [r0, r4]
-
-	bl	tegra_pen_unlock
-
-	/* Re-enable the data cache */
-	mrc	p15, 0, r10, c1, c0, 0
-	orr	r10, r10, #CR_C
-	mcr	p15, 0, r10, c1, c0, 0
-	isb
-
-	mcr	p15, 0, r11, c1, c0, 1	@ reenable coherency
-
-	/* Invalidate the TLBs & BTAC */
-	mov	r1, #0
-	mcr	p15, 0, r1, c8, c3, 0	@ invalidate shared TLBs
-	mcr	p15, 0, r1, c7, c1, 6	@ invalidate shared BTAC
-	dsb
-	isb
-
-	/* the cpu was running with coherency disabled,
-	 * caches may be out of date */
-	bl	v7_flush_kern_cache_louis
-
-	ldmfd	sp!, {r4 - r11, pc}
-ENDPROC(tegra20_sleep_cpu_secondary_finish)
-
 /*
  * tegra20_tear_down_cpu
  *
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 78ef32a907c8..d219872b7546 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -114,8 +114,6 @@
 .endm
 
 #else
-void tegra_pen_lock(void);
-void tegra_pen_unlock(void);
 void tegra_resume(void);
 int tegra_sleep_cpu_finish(unsigned long);
 void tegra_disable_clean_inv_dcache(u32 flag);
@@ -125,16 +123,6 @@ void tegra20_hotplug_shutdown(void);
 void tegra30_hotplug_shutdown(void);
 #endif
 
-void tegra20_cpu_shutdown(int cpu);
-int tegra20_cpu_is_resettable_soon(void);
-void tegra20_cpu_clear_resettable(void);
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
-void tegra20_cpu_set_resettable_soon(void);
-#else
-static inline void tegra20_cpu_set_resettable_soon(void) {}
-#endif
-
-int tegra20_sleep_cpu_secondary_finish(unsigned long);
 void tegra20_tear_down_cpu(void);
 int tegra30_sleep_cpu_secondary_finish(unsigned long);
 void tegra30_tear_down_cpu(void);
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index e512e606eabd..d9237769a37c 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -40,9 +40,7 @@
 
 #include "board.h"
 #include "common.h"
-#include "cpuidle.h"
 #include "iomap.h"
-#include "irq.h"
 #include "pm.h"
 #include "reset.h"
 #include "sleep.h"
@@ -86,7 +84,6 @@ static void __init tegra_dt_init(void)
 static void __init tegra_dt_init_late(void)
 {
 	tegra_init_suspend();
-	tegra_cpuidle_init();
 
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("compal,paz00"))
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index c8ef05d6b8c7..d98c69efb7e0 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -6,7 +6,6 @@ if ARM
 
 config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
-	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_754327 if SMP
 	select ARM_ERRATA_764369 if SMP
diff --git a/include/soc/tegra/cpuidle.h b/include/soc/tegra/cpuidle.h
index 029ba1f4b2cc..f758808342b6 100644
--- a/include/soc/tegra/cpuidle.h
+++ b/include/soc/tegra/cpuidle.h
@@ -6,12 +6,8 @@
 #ifndef __SOC_TEGRA_CPUIDLE_H__
 #define __SOC_TEGRA_CPUIDLE_H__
 
-#if defined(CONFIG_ARM) && defined(CONFIG_ARCH_TEGRA) && defined(CONFIG_CPU_IDLE)
-void tegra_cpuidle_pcie_irqs_in_use(void);
-#else
 static inline void tegra_cpuidle_pcie_irqs_in_use(void)
 {
 }
-#endif
 
 #endif /* __SOC_TEGRA_CPUIDLE_H__ */
-- 
2.23.0

