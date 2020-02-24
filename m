Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6197416B447
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBXWmv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:42:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37800 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgBXWmu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so8066726lfc.4;
        Mon, 24 Feb 2020 14:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPXlw+TPEAIGqeYKizkXpN+v1vevpC6XwF4/g9bqzh4=;
        b=N7s6Rec4Dlk+3u1aZ0JgPxVACBZdanHduCrk6EdS+634vb5bDdpXDUr+0ijvd7Fkma
         7b6cwYGLywMhDzw+rihAPMt88oi3rnHrHdA1Fa9BNoOJqgYVN77EoPv91LRTtwD7b/Fd
         02h3PtFjp6C3Xb6mxhUe0q+b321RYk29yfIiHN6bG30obgR+2ZVEf3CHzgb2pm3mou8X
         QO1ns0zisKzByFuzWijSfVsFS3xQ/6Q07jlO7xlnE5VVAUf+EeylG8RuIyXBQ8iWYtVE
         yXBjssIjR3lFimWTN6NrDgUaw7S9do46kfq7opEoDPU5pMG+Yh3lp82Vx92NB6h4AKpL
         jUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPXlw+TPEAIGqeYKizkXpN+v1vevpC6XwF4/g9bqzh4=;
        b=bJsZ4/JqaVLkrIrNc65KdW/87s0YIE3J2sb9FEc+1HiYXycNkY7vEeJFl8+egUmdgs
         ti2Snq4tU9v9mH9+kz63GAnvWwnTjhJ4ljH0xQ0mJTm9wrJ51+DS9pKFEmymqmBxihKC
         u34ihIf/+GNSf0EO8cWwxtO6zRCMRXQdIvwhyuv/PZ6+9CLnNnrD1UrczZKMxZnoSGNS
         mt2AXjN/sou/H0wQ78IGLz/5f8qrPd5uhkZB829U7Esa42oYg8UbhHlgjqfaPDutHVKc
         BaZ2sh4Uw8cBpOx24MV7kO+giVcLur9b0D42h2ehcMEorXVR1s13jJihedidDYMoyg5J
         aqZw==
X-Gm-Message-State: APjAAAUZU3nEQBGoAAHkemdF94OK62L3KoNfy2PH/90si/rocM2p16jz
        MxMzH7xQmexPvGmvOynzBWU=
X-Google-Smtp-Source: APXvYqyXId6rkgoMadrB+7P+FemRWQQvkOOuaYCoPyzgwDzFmiUEPUZe9PgKE6o8C8NyI2ND6NlR6g==
X-Received: by 2002:ac2:44a7:: with SMTP id c7mr17394260lfm.32.1582584167980;
        Mon, 24 Feb 2020 14:42:47 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:47 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 13/17] cpuidle: tegra: Squash Tegra30 driver into the common driver
Date:   Tue, 25 Feb 2020 01:40:53 +0300
Message-Id: <20200224224057.21877-14-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra20 and Terga30 SoCs have common C1 and CC6 idling states and thus
share the same code paths, there is no point in having separate drivers
for a similar hardware. This patch merely moves functionality of the old
driver into the new, although the CC6 state is kept disabled for now since
old driver had a rudimentary support for this state (allowing to enter
into CC6 only when secondary CPUs are put offline), while new driver can
provide a full-featured support. The new feature will be enabled by
another patch.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/Makefile          |   3 -
 arch/arm/mach-tegra/cpuidle-tegra30.c | 123 --------------------------
 arch/arm/mach-tegra/cpuidle.c         |   5 +-
 arch/arm/mach-tegra/cpuidle.h         |   1 -
 drivers/cpuidle/cpuidle-tegra.c       |  74 ++++++++++++++--
 5 files changed, 70 insertions(+), 136 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 8425bb5608d5..99c5f4274e5c 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -13,9 +13,6 @@ obj-y					+= sleep-tegra30.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
-endif
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
deleted file mode 100644
index 80ae64bcdf50..000000000000
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ /dev/null
@@ -1,123 +0,0 @@
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
-#include <soc/tegra/pm.h>
-
-#include <asm/cpuidle.h>
-#include <asm/smp_plat.h>
-#include <asm/suspend.h>
-
-#include "cpuidle.h"
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
-	return !tegra_pm_enter_lp2();
-}
-
-#ifdef CONFIG_SMP
-static bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv,
-					int index)
-{
-	smp_wmb();
-
-	cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
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
-
-	local_fiq_disable();
-
-	tegra_pm_set_cpu_in_lp2();
-	cpu_pm_enter();
-
-	if (dev->cpu == 0)
-		entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv, index);
-	else
-		entered_lp2 = tegra30_cpu_core_power_down(dev, drv, index);
-
-	cpu_pm_exit();
-	tegra_pm_clear_cpu_in_lp2();
-
-	local_fiq_enable();
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
index eee85d517783..fa0dcf3c2c45 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -24,11 +24,8 @@ void __init tegra_cpuidle_init(void)
 {
 	switch (tegra_get_chip_id()) {
 	case TEGRA20:
-		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
-		break;
 	case TEGRA30:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
-			tegra30_cpuidle_init();
+		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
 		break;
 	case TEGRA114:
 	case TEGRA124:
diff --git a/arch/arm/mach-tegra/cpuidle.h b/arch/arm/mach-tegra/cpuidle.h
index eeb37baf18e1..5423a05a69f6 100644
--- a/arch/arm/mach-tegra/cpuidle.h
+++ b/arch/arm/mach-tegra/cpuidle.h
@@ -7,7 +7,6 @@
 #define __MACH_TEGRA_CPUIDLE_H
 
 #ifdef CONFIG_CPU_IDLE
-int tegra30_cpuidle_init(void);
 int tegra114_cpuidle_init(void);
 void tegra_cpuidle_init(void);
 #else
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 5691bdcf11cb..cd969ec18651 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -37,6 +37,7 @@
 
 enum tegra_state {
 	TEGRA_C1,
+	TEGRA_C7,
 	TEGRA_CC6,
 	TEGRA_STATE_COUNT,
 };
@@ -122,6 +123,11 @@ static int tegra_cpuidle_cc6_enter(unsigned int cpu)
 	return ret;
 }
 
+static int tegra_cpuidle_c7_enter(void)
+{
+	return cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
+}
+
 static int tegra_cpuidle_coupled_barrier(struct cpuidle_device *dev)
 {
 	if (tegra_pending_sgi()) {
@@ -169,6 +175,10 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 	cpu_pm_enter();
 
 	switch (index) {
+	case TEGRA_C7:
+		ret = tegra_cpuidle_c7_enter();
+		break;
+
 	case TEGRA_CC6:
 		ret = tegra_cpuidle_cc6_enter(cpu);
 		break;
@@ -185,6 +195,24 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 	return ret;
 }
 
+static int tegra_cpuidle_adjust_state_index(int index, unsigned int cpu)
+{
+	/*
+	 * On Tegra30 CPU0 can't be power-gated separately from secondary
+	 * cores because it gates the whole CPU cluster.
+	 */
+	if (cpu > 0 || index != TEGRA_C7 || tegra_get_chip_id() != TEGRA30)
+		return index;
+
+	/* put CPU0 into C1 if C7 is requested and secondaries are online */
+	if (!IS_ENABLED(CONFIG_PM_SLEEP) || num_online_cpus() > 1)
+		index = TEGRA_C1;
+	else
+		index = TEGRA_CC6;
+
+	return index;
+}
+
 static int tegra_cpuidle_enter(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv,
 			       int index)
@@ -192,10 +220,17 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
 	unsigned int cpu = cpu_logical_map(dev->cpu);
 	int err;
 
-	err = tegra_cpuidle_state_enter(dev, index, cpu);
-	if (err && err != -EINTR)
-		pr_err_once("cpu%u failed to enter idle state %d err: %d\n",
-			    cpu, index, err);
+	index = tegra_cpuidle_adjust_state_index(index, cpu);
+	if (dev->states_usage[index].disable)
+		return -1;
+
+	if (index == TEGRA_C1)
+		err = arm_cpuidle_simple_enter(dev, drv, index);
+	else
+		err = tegra_cpuidle_state_enter(dev, index, cpu);
+
+	if (err && (err != -EINTR || index != TEGRA_CC6))
+		pr_err_once("failed to enter state %d err: %d\n", index, err);
 
 	return err ? -1 : index;
 }
@@ -221,6 +256,15 @@ static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.states = {
 		[TEGRA_C1] = ARM_CPUIDLE_WFI_STATE_PWR(600),
+		[TEGRA_C7] = {
+			.enter			= tegra_cpuidle_enter,
+			.exit_latency		= 2000,
+			.target_residency	= 2200,
+			.power_usage		= 100,
+			.flags			= CPUIDLE_FLAG_TIMER_STOP,
+			.name			= "C7",
+			.desc			= "CPU core powered off",
+		},
 		[TEGRA_CC6] = {
 			.enter			= tegra_cpuidle_enter,
 			.exit_latency		= 5000,
@@ -265,8 +309,28 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 	 * Tegra-arch core and PMC driver, is unavailable if PM-sleep option
 	 * is disabled.
 	 */
-	if (!IS_ENABLED(CONFIG_PM_SLEEP))
+	if (!IS_ENABLED(CONFIG_PM_SLEEP)) {
+		tegra_cpuidle_disable_state(TEGRA_C7);
 		tegra_cpuidle_disable_state(TEGRA_CC6);
+	}
+
+	/*
+	 * Generic WFI state (also known as C1 or LP3) and the coupled CPU
+	 * cluster power-off (CC6 or LP2) states are common for all Tegra SoCs.
+	 */
+	switch (tegra_get_chip_id()) {
+	case TEGRA20:
+		/* Tegra20 isn't capable to power-off individual CPU cores */
+		tegra_cpuidle_disable_state(TEGRA_C7);
+		break;
+
+	case TEGRA30:
+		tegra_cpuidle_disable_state(TEGRA_CC6);
+		break;
+
+	default:
+		return -EINVAL;
+	}
 
 	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
 }
-- 
2.24.0

