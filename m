Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A675816B45B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgBXWnQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:43:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46817 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgBXWmv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:51 -0500
Received: by mail-lf1-f67.google.com with SMTP id u2so5355790lfk.13;
        Mon, 24 Feb 2020 14:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUqQ80Gm1VC83eTLc9O8bMgxItSexq/gS3iB7oB+5hA=;
        b=as5fr+uYlLG4Cf0/qw6VUt/j7Xwk9b47Fcxgpw4PR/+9mkElUObby1FvplySz4Eb0+
         Eef8FW5XE0SMfwVbRrqyTfc/tLUI7rQV9IcrMOW9iTEqsCkuNmj8P/nANqBFzzUcQEBu
         xOkDztYyAOcXfAmeV2YBxlZxsQ8n+GWHhSmRjCYaZX7uMsBsh2810r1g9hWtR0i1ICTc
         HFvSgr9zALXGrQEAYdqM8N31GYtDWuw3vvdcCFwf+nDQiJAUVKgLAYYS2Y9opKvqJfqz
         Hr36eZrzGR0r1vJb74k5d79ohFc3AcOosslkHxCkKEL6q74Bc1gEde0QCx46EfuOiyvP
         3EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUqQ80Gm1VC83eTLc9O8bMgxItSexq/gS3iB7oB+5hA=;
        b=hWwwZ9Fp4aUYSPe5eQFFWO1FrtXPrRtIOW5F5pmASdI96hep75tZQRhkwbcLW7S0Cy
         cI1dt+uwkrmW0QBQlbze1erGZ4SVbooEeasHttq+k0vRzh96CwaJ8J5NtmCDC9le1GgU
         h5FT+TcgAWN+Z3pEzGEl3TeZyyy5i5SPmcSvLuwkXZI+zMwzo6EKKEKa9tYteY3IGAtt
         +yxWtgxkzr7V9zMtlXzEnfSOqUC1KH+rPGsK4Y/JO5mdRLr8w+MeSI308Yt3CD/gTrPH
         /q7J/TgVhpj3gK9n2H2d3GHuxxicr9t57f0tBvBKMFfi3QbgaIcCxty0Dgsrc/22huJ6
         jQcQ==
X-Gm-Message-State: APjAAAVz5maR9mGfK0HrSV2j4W1IGb3CbOyd8flR3Wvooi4xuqprOBdP
        UhS7dk1gu+JYm1NSZFJ7T+Y=
X-Google-Smtp-Source: APXvYqxJSrcrowD2vhM1fV4h9KnHS0Cg4UztDaLiu4wtO1R6VPuJdfOkYuyVg+1dPac+dHwiNMpnjQ==
X-Received: by 2002:a19:6903:: with SMTP id e3mr3667522lfc.25.1582584169060;
        Mon, 24 Feb 2020 14:42:49 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:48 -0800 (PST)
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
Subject: [PATCH v11 14/17] cpuidle: tegra: Squash Tegra114 driver into the common driver
Date:   Tue, 25 Feb 2020 01:40:54 +0300
Message-Id: <20200224224057.21877-15-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra20/30/114/124 SoCs have common idling states, thus there is no much
point in having separate drivers for a similar hardware. This patch moves
Tegra114/124 arch/ drivers into the common driver without any functional
changes. The CC6 state is kept disabled on Tegra114/124 because the core
Tegra PM code needs some more work in order to support that state.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/Makefile           |  7 --
 arch/arm/mach-tegra/cpuidle-tegra114.c | 90 --------------------------
 arch/arm/mach-tegra/cpuidle.c          | 37 -----------
 arch/arm/mach-tegra/cpuidle.h          | 16 -----
 arch/arm/mach-tegra/tegra.c            |  6 +-
 drivers/cpuidle/cpuidle-tegra.c        | 45 ++++++++++++-
 6 files changed, 48 insertions(+), 153 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 99c5f4274e5c..07572b5373b8 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -10,19 +10,12 @@ obj-y					+= sleep.o
 obj-y					+= tegra.o
 obj-y					+= sleep-tegra20.o
 obj-y					+= sleep-tegra30.o
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
-endif
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= pm-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= cpuidle-tegra114.o
-endif
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
deleted file mode 100644
index 858c30cc5dc7..000000000000
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ /dev/null
@@ -1,90 +0,0 @@
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
-#include <soc/tegra/pm.h>
-
-#include <asm/cpuidle.h>
-#include <asm/smp_plat.h>
-#include <asm/suspend.h>
-#include <asm/psci.h>
-
-#include "cpuidle.h"
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
-	tegra_pm_set_cpu_in_lp2();
-	cpu_pm_enter();
-
-	call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
-
-	/* Do suspend by ourselves if the firmware does not implement it */
-	if (call_firmware_op(do_idle, 0) == -ENOSYS)
-		cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
-
-	cpu_pm_exit();
-	tegra_pm_clear_cpu_in_lp2();
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
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
deleted file mode 100644
index fa0dcf3c2c45..000000000000
--- a/arch/arm/mach-tegra/cpuidle.c
+++ /dev/null
@@ -1,37 +0,0 @@
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
-#include <linux/platform_device.h>
-
-#include <soc/tegra/fuse.h>
-
-#include "cpuidle.h"
-
-void __init tegra_cpuidle_init(void)
-{
-	switch (tegra_get_chip_id()) {
-	case TEGRA20:
-	case TEGRA30:
-		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
-		break;
-	case TEGRA114:
-	case TEGRA124:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) ||
-		    IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC))
-			tegra114_cpuidle_init();
-		break;
-	}
-}
diff --git a/arch/arm/mach-tegra/cpuidle.h b/arch/arm/mach-tegra/cpuidle.h
deleted file mode 100644
index 5423a05a69f6..000000000000
--- a/arch/arm/mach-tegra/cpuidle.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2012, NVIDIA Corporation. All rights reserved.
- */
-
-#ifndef __MACH_TEGRA_CPUIDLE_H
-#define __MACH_TEGRA_CPUIDLE_H
-
-#ifdef CONFIG_CPU_IDLE
-int tegra114_cpuidle_init(void);
-void tegra_cpuidle_init(void);
-#else
-static inline void tegra_cpuidle_init(void) {}
-#endif
-
-#endif
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 79184a077c84..eeacff626546 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -36,11 +36,11 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach-types.h>
+#include <asm/psci.h>
 #include <asm/setup.h>
 
 #include "board.h"
 #include "common.h"
-#include "cpuidle.h"
 #include "iomap.h"
 #include "pm.h"
 #include "reset.h"
@@ -85,7 +85,6 @@ static void __init tegra_dt_init(void)
 static void __init tegra_dt_init_late(void)
 {
 	tegra_init_suspend();
-	tegra_cpuidle_init();
 
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("compal,paz00"))
@@ -98,6 +97,9 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
 	    of_machine_is_compatible("nvidia,tegra30"))
 		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARM_TEGRA_CPUIDLE) && !psci_smp_available())
+		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index cd969ec18651..2ddbd289e17d 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 
 #include <linux/clk/tegra.h>
+#include <linux/firmware/trusted_foundations.h>
 
 #include <soc/tegra/cpuidle.h>
 #include <soc/tegra/flowctrl.h>
@@ -32,6 +33,7 @@
 #include <soc/tegra/pm.h>
 
 #include <asm/cpuidle.h>
+#include <asm/firmware.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
@@ -45,6 +47,11 @@ enum tegra_state {
 static atomic_t tegra_idle_barrier;
 static atomic_t tegra_abort_flag;
 
+static inline bool tegra_cpuidle_using_firmware(void)
+{
+	return firmware_ops->prepare_idle && firmware_ops->do_idle;
+}
+
 static void tegra_cpuidle_report_cpus_state(void)
 {
 	unsigned long cpu, lcpu, csr;
@@ -125,6 +132,16 @@ static int tegra_cpuidle_cc6_enter(unsigned int cpu)
 
 static int tegra_cpuidle_c7_enter(void)
 {
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
 	return cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
 }
 
@@ -235,6 +252,13 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
 	return err ? -1 : index;
 }
 
+static void tegra114_enter_s2idle(struct cpuidle_device *dev,
+				  struct cpuidle_driver *drv,
+				  int index)
+{
+	tegra_cpuidle_enter(dev, drv, index);
+}
+
 /*
  * The previous versions of Tegra CPUIDLE driver used a different "legacy"
  * terminology for naming of the idling states, while this driver uses the
@@ -302,6 +326,15 @@ void tegra_cpuidle_pcie_irqs_in_use(void)
 	tegra_cpuidle_disable_state(TEGRA_CC6);
 }
 
+static void tegra_cpuidle_setup_tegra114_c7_state(void)
+{
+	struct cpuidle_state *s = &tegra_idle_driver.states[TEGRA_C7];
+
+	s->enter_s2idle = tegra114_enter_s2idle;
+	s->target_residency = 1000;
+	s->exit_latency = 500;
+}
+
 static int tegra_cpuidle_probe(struct platform_device *pdev)
 {
 	/*
@@ -310,7 +343,9 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 	 * is disabled.
 	 */
 	if (!IS_ENABLED(CONFIG_PM_SLEEP)) {
-		tegra_cpuidle_disable_state(TEGRA_C7);
+		if (!tegra_cpuidle_using_firmware())
+			tegra_cpuidle_disable_state(TEGRA_C7);
+
 		tegra_cpuidle_disable_state(TEGRA_CC6);
 	}
 
@@ -328,6 +363,14 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 		tegra_cpuidle_disable_state(TEGRA_CC6);
 		break;
 
+	case TEGRA114:
+	case TEGRA124:
+		tegra_cpuidle_setup_tegra114_c7_state();
+
+		/* coupled CC6 (LP2) state isn't implemented yet */
+		tegra_cpuidle_disable_state(TEGRA_CC6);
+		break;
+
 	default:
 		return -EINVAL;
 	}
-- 
2.24.0

