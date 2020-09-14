Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA426825F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 03:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgINBwV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 21:52:21 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:37492 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgINBwT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 21:52:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07457206|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00567186-0.0021741-0.992154;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10434;MF=liush@allwinnertech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.IWjNbES_1600048326;
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com fp:SMTPD_---.IWjNbES_1600048326)
          by smtp.aliyun-inc.com(10.147.41.120);
          Mon, 14 Sep 2020 09:52:13 +0800
From:   liush <liush@allwinnertech.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, anup.patel@wdc.com, atish.patra@wdc.com,
        damien.lemoal@wdc.com, wangkefeng.wang@huawei.com, kernel@esmil.dk,
        zong.li@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, liush <liush@allwinnertech.com>
Subject: [PATCH] cpuidle: add riscv cpuidle driver
Date:   Mon, 14 Sep 2020 09:52:03 +0800
Message-Id: <1600048323-2964-1-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a cpuidle driver for systems based RISCV architecture.
This patch supports state WFI. Other states will be supported in the
future.

Signed-off-by: liush <liush@allwinnertech.com>
---
 arch/riscv/Kconfig               |  7 +++++
 arch/riscv/include/asm/cpuidle.h |  7 +++++
 arch/riscv/kernel/Makefile       |  1 +
 arch/riscv/kernel/cpuidle.c      |  8 ++++++
 drivers/cpuidle/Kconfig          |  5 ++++
 drivers/cpuidle/Kconfig.riscv    | 11 ++++++++
 drivers/cpuidle/Makefile         |  4 +++
 drivers/cpuidle/cpuidle-riscv.c  | 55 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 98 insertions(+)
 create mode 100644 arch/riscv/include/asm/cpuidle.h
 create mode 100644 arch/riscv/kernel/cpuidle.c
 create mode 100644 drivers/cpuidle/Kconfig.riscv
 create mode 100644 drivers/cpuidle/cpuidle-riscv.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index df18372..c7ddb9d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -86,6 +86,7 @@ config RISCV
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select CPU_IDLE
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
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
index 00000000..2599d2f
--- /dev/null
+++ b/arch/riscv/include/asm/cpuidle.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __RISCV_CPUIDLE_H
+#define __RISCV_CPUIDLE_H
+
+extern void cpu_do_idle(void);
+
+#endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index dc93710..396ba9c 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -29,6 +29,7 @@ obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
 obj-y	+= patch.o
+obj-y	+= cpuidle.o
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
diff --git a/arch/riscv/kernel/cpuidle.c b/arch/riscv/kernel/cpuidle.c
new file mode 100644
index 00000000..a3289e7
--- /dev/null
+++ b/arch/riscv/kernel/cpuidle.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/cpuidle.h>
+
+void cpu_do_idle(void)
+{
+	__asm__ __volatile__ ("wfi");
+
+}
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
index 00000000..e86d36b
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.riscv
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# RISCV CPU Idle drivers
+#
+config RISCV_CPUIDLE
+        bool "Generic RISCV CPU idle Driver"
+        select DT_IDLE_STATES
+	select CPU_IDLE_MULTIPLE_DRIVERS
+        help
+          Select this option to enable generic cpuidle driver for RISCV.
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

