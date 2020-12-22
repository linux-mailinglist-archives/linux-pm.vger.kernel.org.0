Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A42E0E68
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 19:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgLVSs4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 13:48:56 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:48649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgLVSsz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 13:48:55 -0500
Received: from orion.localdomain ([95.118.68.26]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3D3N-1kvLYf3Bb3-003gAL; Tue, 22 Dec 2020 19:45:17 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, msalter@redhat.com,
        jacquiot.aurelien@gmail.com, ysato@users.sourceforge.jp,
        geert@linux-m68k.org, tsbogend@alpha.franken.de,
        ley.foon.tan@intel.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, dalias@libc.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sstabellini@kernel.org, chris@zankel.net,
        jcmvbkbc@gmail.com, christian@brauner.io,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-pm@vger.kernel.org
Subject: [PATCH] arch: consolidate pm_power_off callback
Date:   Tue, 22 Dec 2020 19:45:10 +0100
Message-Id: <20201222184510.19415-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:n4hqwhh7LIjEQSp9rLWYAb9MND0ZkRP95+g1E+jzaHcC8BjMZKX
 bRX7HDy98scHqJv/TvEudskGuZFxlSq4AtOv/qPJ5NAPv6cGBsTGa6ax8noKD/hgjjLO09l
 f5Needsa/iXKi3HojJrBH233VwZxpoVLzcPV6Nl/UGu4HwbcHoixH76JoYvRIU8c0xxI+B+
 Wed4rfrftuXiD3ZhBWV/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZYY3bhRqRrE=:9Z7+Ttntpc/yZ0ONUaW5+X
 y6uHceCsl3e2HplEDGgS4EFL2eghEQvTFn4w7NTu9QXh3AH/FIvI+UZmyV0s8t/6vx0aml4RL
 Zut2vYA2aVk8OWgJiDj5Agz0Gjh/B6BgIsYIAfckjDIiepL3IfcRF4Sh491jL5phu1uisMhTW
 +e0BCNzTZbKom2EeX6gSHewwhdeI1a0pk/FcRHiTvdpTtCzMPQ2MqY091fdBXnoXMxOaIWiwa
 nfGBsEpd21MGuxqgE0x7F5khOKrOvkY3ydOk77hP7VIRipf69SRZlprj8ecbFvkYGF97o/x26
 wPD01yvWzKtEucv8YUz7YjauAKprIUvFXkMEcBi9bse7DyYb2+fjtV9xCe9eRFTYuT3JL/A7h
 SlU9NhNG5n0ZLlQGjml/4UrjChq0cs1aMzc5MTMPVEAootea1kqsuVV94Go6V
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the pm_power_off callback into one global place and also add an
function for conditionally calling it (when not NULL), in order to remove
code duplication in all individual archs.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/alpha/kernel/process.c        |  6 ------
 arch/arc/kernel/reset.c            |  3 ---
 arch/arm/kernel/reboot.c           |  6 ++----
 arch/arm64/kernel/process.c        |  6 +-----
 arch/c6x/kernel/process.c          | 10 ++--------
 arch/csky/kernel/power.c           | 10 +++-------
 arch/h8300/kernel/process.c        |  3 ---
 arch/hexagon/kernel/reset.c        |  3 ---
 arch/ia64/kernel/process.c         |  5 +----
 arch/m68k/kernel/process.c         |  3 ---
 arch/microblaze/kernel/process.c   |  3 ---
 arch/mips/kernel/reset.c           |  6 +-----
 arch/nds32/kernel/process.c        |  7 ++-----
 arch/nios2/kernel/process.c        |  3 ---
 arch/openrisc/kernel/process.c     |  3 ---
 arch/parisc/kernel/process.c       |  9 +++------
 arch/powerpc/kernel/setup-common.c |  5 ++---
 arch/powerpc/xmon/xmon.c           |  4 ++--
 arch/riscv/kernel/reset.c          |  9 ++++-----
 arch/s390/kernel/setup.c           |  3 ---
 arch/sh/kernel/reboot.c            |  6 +-----
 arch/x86/kernel/reboot.c           | 15 ++++-----------
 arch/x86/xen/enlighten_pv.c        |  4 ++--
 arch/xtensa/kernel/process.c       |  4 ----
 include/linux/pm.h                 |  2 ++
 kernel/reboot.c                    | 10 ++++++++++
 26 files changed, 42 insertions(+), 106 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 6c71554206cc..df0df869751d 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -43,12 +43,6 @@
 #include "proto.h"
 #include "pci_impl.h"
 
-/*
- * Power off function, if any
- */
-void (*pm_power_off)(void) = machine_power_off;
-EXPORT_SYMBOL(pm_power_off);
-
 #ifdef CONFIG_ALPHA_WTINT
 /*
  * Sleep the CPU.
diff --git a/arch/arc/kernel/reset.c b/arch/arc/kernel/reset.c
index fd6c3eb930ba..3a27b6a202d4 100644
--- a/arch/arc/kernel/reset.c
+++ b/arch/arc/kernel/reset.c
@@ -26,6 +26,3 @@ void machine_power_off(void)
 	/* FIXME ::  power off ??? */
 	machine_halt();
 }
-
-void (*pm_power_off) (void) = NULL;
-EXPORT_SYMBOL(pm_power_off);
diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 0ce388f15422..9e1bf0e9b3e0 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -6,6 +6,7 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
+#include <linux/pm.h>
 
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
@@ -19,8 +20,6 @@ typedef void (*phys_reset_t)(unsigned long, bool);
  * Function pointers to optional machine specific functions
  */
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
 
 /*
  * A temporary stack to use for CPU reset. This is static so that we
@@ -118,8 +117,7 @@ void machine_power_off(void)
 	local_irq_disable();
 	smp_send_stop();
 
-	if (pm_power_off)
-		pm_power_off();
+	do_power_off();
 }
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6616486a58fe..a5d4c1e80abd 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -67,9 +67,6 @@ EXPORT_SYMBOL(__stack_chk_guard);
 /*
  * Function pointers to optional machine specific functions
  */
-void (*pm_power_off)(void);
-EXPORT_SYMBOL_GPL(pm_power_off);
-
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
 static void noinstr __cpu_do_idle(void)
@@ -172,8 +169,7 @@ void machine_power_off(void)
 {
 	local_irq_disable();
 	smp_send_stop();
-	if (pm_power_off)
-		pm_power_off();
+	do_power_off();
 }
 
 /*
diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
index 9f4fd6a40a10..8b4b24476162 100644
--- a/arch/c6x/kernel/process.c
+++ b/arch/c6x/kernel/process.c
@@ -15,6 +15,7 @@
 #include <linux/reboot.h>
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
+#include <linux/pm.h>
 
 #include <asm/syscalls.h>
 
@@ -25,12 +26,6 @@ void	(*c6x_halt)(void);
 extern asmlinkage void ret_from_fork(void);
 extern asmlinkage void ret_from_kernel_thread(void);
 
-/*
- * power off function, if any
- */
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
 void arch_cpu_idle(void)
 {
 	unsigned long tmp;
@@ -71,8 +66,7 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_power_off();
 	halt_loop();
 }
 
diff --git a/arch/csky/kernel/power.c b/arch/csky/kernel/power.c
index 923ee4e381b8..c702e66ce03a 100644
--- a/arch/csky/kernel/power.c
+++ b/arch/csky/kernel/power.c
@@ -2,23 +2,19 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #include <linux/reboot.h>
-
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
+#include <linux/pm.h>
 
 void machine_power_off(void)
 {
 	local_irq_disable();
-	if (pm_power_off)
-		pm_power_off();
+	do_power_off();
 	asm volatile ("bkpt");
 }
 
 void machine_halt(void)
 {
 	local_irq_disable();
-	if (pm_power_off)
-		pm_power_off();
+	do_power_off();
 	asm volatile ("bkpt");
 }
 
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index bc1364db58fe..020bf78a779c 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -46,9 +46,6 @@
 #include <asm/traps.h>
 #include <asm/setup.h>
 
-void (*pm_power_off)(void) = NULL;
-EXPORT_SYMBOL(pm_power_off);
-
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
diff --git a/arch/hexagon/kernel/reset.c b/arch/hexagon/kernel/reset.c
index da36114d928f..8370ddbcdfd9 100644
--- a/arch/hexagon/kernel/reset.c
+++ b/arch/hexagon/kernel/reset.c
@@ -19,6 +19,3 @@ void machine_halt(void)
 void machine_restart(char *cmd)
 {
 }
-
-void (*pm_power_off)(void) = NULL;
-EXPORT_SYMBOL(pm_power_off);
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 4ebbfa076a26..72104b967668 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -57,8 +57,6 @@ void (*ia64_mark_idle)(int);
 
 unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
-void (*pm_power_off) (void);
-EXPORT_SYMBOL(pm_power_off);
 
 static void
 ia64_do_show_stack (struct unw_frame_info *info, void *arg)
@@ -602,8 +600,7 @@ machine_halt (void)
 void
 machine_power_off (void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_power_off()
 	machine_halt();
 }
 
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 08359a6e058f..b8dc10a630e1 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -72,9 +72,6 @@ void machine_power_off(void)
 	for (;;);
 }
 
-void (*pm_power_off)(void) = machine_power_off;
-EXPORT_SYMBOL(pm_power_off);
-
 void show_regs(struct pt_regs * regs)
 {
 	pr_info("Format %02x  Vector: %04x  PC: %08lx  Status: %04x    %s\n",
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 657c2beb665e..f1dd66a14ab6 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -46,9 +46,6 @@ void show_regs(struct pt_regs *regs)
 				regs->msr, regs->ear, regs->esr, regs->fsr);
 }
 
-void (*pm_power_off)(void) = NULL;
-EXPORT_SYMBOL(pm_power_off);
-
 void flush_thread(void)
 {
 }
diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 6288780b779e..73e32eba422f 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -25,9 +25,6 @@
  */
 void (*_machine_restart)(char *command);
 void (*_machine_halt)(void);
-void (*pm_power_off)(void);
-
-EXPORT_SYMBOL(pm_power_off);
 
 static void machine_hang(void)
 {
@@ -114,8 +111,7 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_power_off();
 
 #ifdef CONFIG_SMP
 	preempt_disable();
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index e01ad5d17224..624e2a563082 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -12,6 +12,7 @@
 #include <asm/fpu.h>
 #include <linux/ptrace.h>
 #include <linux/reboot.h>
+#include <linux/pm.h>
 
 #if IS_ENABLED(CONFIG_LAZY_FPU)
 struct task_struct *last_task_used_math;
@@ -27,9 +28,6 @@ extern inline void arch_reset(char mode)
 	}
 }
 
-void (*pm_power_off) (void);
-EXPORT_SYMBOL(pm_power_off);
-
 static char reboot_mode_nds32 = 'h';
 
 int __init reboot_setup(char *str)
@@ -54,8 +52,7 @@ EXPORT_SYMBOL(machine_halt);
 
 void machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_power_off();
 }
 
 EXPORT_SYMBOL(machine_power_off);
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 50b4eb19a6cc..a6195cc02ea4 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -28,9 +28,6 @@
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
-void (*pm_power_off)(void) = NULL;
-EXPORT_SYMBOL(pm_power_off);
-
 void arch_cpu_idle(void)
 {
 	raw_local_irq_enable();
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c98728cce24..c02343bacf59 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -84,9 +84,6 @@ void arch_cpu_idle(void)
 		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
 }
 
-void (*pm_power_off) (void) = machine_power_off;
-EXPORT_SYMBOL(pm_power_off);
-
 /*
  * When a process does an "exec", machine state like FPU and debug
  * registers need to be reset.  This is a hook function for that.
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index a92a23d6acd9..8b94599c9480 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -41,6 +41,7 @@
 #include <linux/rcupdate.h>
 #include <linux/random.h>
 #include <linux/nmi.h>
+#include <linux/pm.h>
 
 #include <asm/io.h>
 #include <asm/asm-offsets.h>
@@ -117,9 +118,8 @@ void machine_power_off(void)
 	pdc_chassis_send_status(PDC_CHASSIS_DIRECT_SHUTDOWN);
 
 	/* ipmi_poweroff may have been installed. */
-	if (pm_power_off)
-		pm_power_off();
-		
+	do_power_off();
+
 	/* It seems we have no way to power the system off via
 	 * software. The user has to press the button himself. */
 
@@ -132,9 +132,6 @@ void machine_power_off(void)
 	for (;;);
 }
 
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
 void machine_halt(void)
 {
 	machine_power_off();
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 71f38e9248be..b36346326176 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -32,6 +32,7 @@
 #include <linux/of_platform.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/pm.h>
 #include <asm/debugfs.h>
 #include <asm/io.h>
 #include <asm/paca.h>
@@ -163,9 +164,7 @@ void machine_restart(char *cmd)
 void machine_power_off(void)
 {
 	machine_shutdown();
-	if (pm_power_off)
-		pm_power_off();
-
+	do_power_off();
 	smp_send_stop();
 	machine_hang();
 }
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index dcd817ca2edf..38d76c283412 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -26,6 +26,7 @@
 #include <linux/ctype.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
+#include <linux/pm.h>
 
 #include <asm/debugfs.h>
 #include <asm/ptrace.h>
@@ -1237,8 +1238,7 @@ static void bootcmds(void)
 	} else if (cmd == 'h') {
 		ppc_md.halt();
 	} else if (cmd == 'p') {
-		if (pm_power_off)
-			pm_power_off();
+		do_power_off();
 	}
 }
 
diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index ee5878d968cc..f8bcf4d8b19b 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -12,9 +12,6 @@ static void default_power_off(void)
 		wait_for_interrupt();
 }
 
-void (*pm_power_off)(void) = default_power_off;
-EXPORT_SYMBOL(pm_power_off);
-
 void machine_restart(char *cmd)
 {
 	do_kernel_restart(cmd);
@@ -23,10 +20,12 @@ void machine_restart(char *cmd)
 
 void machine_halt(void)
 {
-	pm_power_off();
+	do_power_off();
+	default_power_off();
 }
 
 void machine_power_off(void)
 {
-	pm_power_off();
+	do_power_off();
+	default_power_off();
 }
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 1fbed91c73bc..4e348d3b711f 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -302,9 +302,6 @@ void machine_power_off(void)
 /*
  * Dummy power off function.
  */
-void (*pm_power_off)(void) = machine_power_off;
-EXPORT_SYMBOL_GPL(pm_power_off);
-
 void *restart_stack;
 
 unsigned long stack_alloc(void)
diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index 5c33f036418b..8c9b63e1dbba 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -10,9 +10,6 @@
 #include <asm/tlbflush.h>
 #include <asm/traps.h>
 
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
 static void watchdog_trigger_immediate(void)
 {
 	sh_wdt_write_cnt(0xFF);
@@ -46,8 +43,7 @@ static void native_machine_shutdown(void)
 
 static void native_machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_power_off();
 }
 
 static void native_machine_halt(void)
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index db115943e8bd..cddf9ca4e6f6 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -34,12 +34,6 @@
 #include <asm/efi.h>
 
 /*
- * Power off function, if any
- */
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
-/*
  * This is set if we need to go through the 'emergency' path.
  * When machine_emergency_restart() is called, we may be on
  * an inconsistent state and won't be able to do a clean cleanup
@@ -747,11 +741,10 @@ static void native_machine_halt(void)
 
 static void native_machine_power_off(void)
 {
-	if (pm_power_off) {
-		if (!reboot_force)
-			machine_shutdown();
-		pm_power_off();
-	}
+	if (!reboot_force)
+		machine_shutdown();
+	do_power_off();
+
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 }
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 4409306364dc..7e5416c316d3 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -33,6 +33,7 @@
 #include <linux/gfp.h>
 #include <linux/edd.h>
 #include <linux/objtool.h>
+#include <linux/pm.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
@@ -1084,8 +1085,7 @@ static void xen_machine_halt(void)
 
 static void xen_machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_power_off();
 	xen_reboot(SHUTDOWN_poweroff);
 }
 
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 397a7de56377..fb8d5e9829ba 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -51,10 +51,6 @@
 extern void ret_from_fork(void);
 extern void ret_from_kernel_thread(void);
 
-void (*pm_power_off)(void) = NULL;
-EXPORT_SYMBOL(pm_power_off);
-
-
 #ifdef CONFIG_STACKPROTECTOR
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 47aca6bac1d6..78627c970be0 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -22,6 +22,8 @@
 extern void (*pm_power_off)(void);
 extern void (*pm_power_off_prepare)(void);
 
+extern void do_power_off(void);
+
 struct device; /* we have a circular dep with device.h */
 #ifdef CONFIG_VT_CONSOLE_SLEEP
 extern void pm_vt_switch_required(struct device *dev, bool required);
diff --git a/kernel/reboot.c b/kernel/reboot.c
index eb1b15850761..ec4cd66dd1ae 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -53,6 +53,16 @@ int reboot_force;
 void (*pm_power_off_prepare)(void);
 EXPORT_SYMBOL_GPL(pm_power_off_prepare);
 
+void (*pm_power_off)(void);
+EXPORT_SYMBOL_GPL(pm_power_off);
+
+void do_power_off(void)
+{
+	if (pm_power_off)
+		pm_power_off();
+}
+EXPORT_SYMBOL_GPL(do_power_off);
+
 /**
  *	emergency_restart - reboot the system
  *
-- 
2.11.0

