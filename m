Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29423277EAE
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 05:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgIYDqx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 23:46:53 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:34042 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgIYDqw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 23:46:52 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07447582|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0059429-0.00236251-0.991695;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=liush@allwinnertech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.IbxjZj1_1601005602;
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com fp:SMTPD_---.IbxjZj1_1601005602)
          by smtp.aliyun-inc.com(10.147.41.143);
          Fri, 25 Sep 2020 11:46:46 +0800
From:   liush <liush@allwinnertech.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, anup.patel@wdc.com,
        keescook@chromium.org, christian.brauner@ubuntu.com,
        geert@linux-m68k.org, amanieu@gmail.com, guoren@linux.alibaba.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, liush <liush@allwinnertech.com>
Subject: [v3] cpuidle: add riscv cpuidle driver
Date:   Fri, 25 Sep 2020 11:46:40 +0800
Message-Id: <1601005600-32653-1-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a simple cpuidle driver for RISC-V systems using
the WFI state. Other states will be supported in the future.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: liush <liush@allwinnertech.com>
---
Changes in v3:
- fix the issue reported by kernel test robot
  "drivers/cpuidle/cpuidle-riscv.c:22:12: warning: no previous prototype 
   for 'riscv_low_level_suspend_enter' [-Wmissing-prototypes]"
Changes in v2:
- call "mb()" before run "WFI" in cpu_do_idle 
- modify commit description 
- place "select CPU_IDLE" in alphabetical order  
- replace "__asm__ __volatile__ ("wfi")" with "wait_for_interrupt()" 
- delete "cpuidle.c",move "cpu_do_idle()" to cpuidle.h 
- modify "arch_cpu_idle", "cpu_do_idle" can be called by 
  "arch_cpu_idle"
- fix space/tab issues
- modify riscv_low_level_suspend_enter to __weak mode

 arch/riscv/Kconfig               |  7 +++++
 arch/riscv/include/asm/cpuidle.h | 16 ++++++++++++
 arch/riscv/kernel/process.c      |  3 ++-
 drivers/cpuidle/Kconfig          |  5 ++++
 drivers/cpuidle/Kconfig.riscv    | 11 ++++++++
 drivers/cpuidle/Makefile         |  4 +++
 drivers/cpuidle/cpuidle-riscv.c  | 55 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/cpuidle.h
 create mode 100644 drivers/cpuidle/Kconfig.riscv
 create mode 100644 drivers/cpuidle/cpuidle-riscv.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index df18372..799bf86 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -33,6 +33,7 @@ config RISCV
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select CPU_IDLE
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
@@ -407,6 +408,12 @@ config BUILTIN_DTB
 	depends on RISCV_M_MODE
 	depends on OF
 
+menu "CPU Power Management"
+
+source "drivers/cpuidle/Kconfig"
+
+endmenu
+
 menu "Power management options"
 
 source "kernel/power/Kconfig"
diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
new file mode 100644
index 00000000..599b810
--- /dev/null
+++ b/arch/riscv/include/asm/cpuidle.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __RISCV_CPUIDLE_H
+#define __RISCV_CPUIDLE_H
+
+static inline void cpu_do_idle(void)
+{
+	/*
+	 * Add mb() here to ensure that all
+	 * IO/MEM access are completed prior
+	 * to enter WFI.
+	 */
+	mb();
+	wait_for_interrupt();
+}
+
+#endif
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 2b97c49..5431aaa 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -21,6 +21,7 @@
 #include <asm/string.h>
 #include <asm/switch_to.h>
 #include <asm/thread_info.h>
+#include <asm/cpuidle.h>
 
 register unsigned long gp_in_global __asm__("gp");
 
@@ -35,7 +36,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
 
 void arch_cpu_idle(void)
 {
-	wait_for_interrupt();
+	cpu_do_idle();
 	local_irq_enable();
 }
 
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c0aeedd..f6be0fd 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -62,6 +62,11 @@ depends on PPC
 source "drivers/cpuidle/Kconfig.powerpc"
 endmenu
 
+menu "RISCV CPU Idle Drivers"
+depends on RISCV
+source "drivers/cpuidle/Kconfig.riscv"
+endmenu
+
 config HALTPOLL_CPUIDLE
 	tristate "Halt poll cpuidle driver"
 	depends on X86 && KVM_GUEST
diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
new file mode 100644
index 00000000..7bec059
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.riscv
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# RISCV CPU Idle drivers
+#
+config RISCV_CPUIDLE
+	bool "Generic RISCV CPU idle Driver"
+	select DT_IDLE_STATES
+	select CPU_IDLE_MULTIPLE_DRIVERS
+	help
+	  Select this option to enable generic cpuidle driver for RISCV.
+	  Now only support C0 State.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 26bbc5e..4c83c4e 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -34,3 +34,7 @@ obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+= cpuidle-cps.o
 # POWERPC drivers
 obj-$(CONFIG_PSERIES_CPUIDLE)		+= cpuidle-pseries.o
 obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
+
+###############################################################################
+# RISCV drivers
+obj-$(CONFIG_RISCV_CPUIDLE)		+= cpuidle-riscv.o
diff --git a/drivers/cpuidle/cpuidle-riscv.c b/drivers/cpuidle/cpuidle-riscv.c
new file mode 100644
index 00000000..5dddcfa
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-riscv.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V CPU idle driver.
+ *
+ * Copyright (C) 2020-2022 Allwinner Ltd
+ *
+ * Based on code - driver/cpuidle/cpuidle-at91.c
+ *
+ */
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <asm/cpuidle.h>
+
+#define MAX_IDLE_STATES	1
+
+/* TODO: Implement deeper idle states */
+static int riscv_low_level_suspend_enter(int state)
+{
+	return 0;
+}
+
+/* Actual code that puts the SoC in different idle states */
+static int riscv_enter_idle(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			       int index)
+{
+	return CPU_PM_CPU_IDLE_ENTER_PARAM(riscv_low_level_suspend_enter,
+					   index, 0);
+}
+
+static struct cpuidle_driver riscv_idle_driver = {
+	.name			= "riscv_idle",
+	.owner			= THIS_MODULE,
+	.states[0]		= {
+		.enter			= riscv_enter_idle,
+		.exit_latency		= 1,
+		.target_residency	= 1,
+		.name			= "WFI",
+		.desc			= "RISCV WFI",
+	},
+	.state_count = MAX_IDLE_STATES,
+};
+
+static int __init riscv_cpuidle_init(void)
+{
+	return cpuidle_register(&riscv_idle_driver, NULL);
+}
+
+device_initcall(riscv_cpuidle_init);
-- 
2.7.4

