Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9AF6120FA
	for <lists+linux-pm@lfdr.de>; Sat, 29 Oct 2022 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiJ2HYN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Oct 2022 03:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2HYN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Oct 2022 03:24:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5E918D830
        for <linux-pm@vger.kernel.org>; Sat, 29 Oct 2022 00:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47B38CE3047
        for <linux-pm@vger.kernel.org>; Sat, 29 Oct 2022 07:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C4EC433D6;
        Sat, 29 Oct 2022 07:24:03 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 1/2] LoongArch: Add suspend (ACPI S3) support
Date:   Sat, 29 Oct 2022 15:21:48 +0800
Message-Id: <20221029072149.1129926-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add suspend (Suspend To RAM, aka ACPI S3) support for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Simplify suspend_asm.S and fix build warnging.

 arch/loongarch/Kconfig                |  5 ++
 arch/loongarch/Makefile               |  3 +
 arch/loongarch/include/asm/acpi.h     | 10 +++
 arch/loongarch/include/asm/bootinfo.h |  1 +
 arch/loongarch/include/asm/loongson.h |  3 +
 arch/loongarch/include/asm/time.h     |  1 +
 arch/loongarch/kernel/acpi.c          |  6 ++
 arch/loongarch/kernel/smp.c           |  1 +
 arch/loongarch/kernel/time.c          | 11 +++-
 arch/loongarch/power/Makefile         |  3 +
 arch/loongarch/power/platform.c       | 45 ++++++++++++++
 arch/loongarch/power/suspend.c        | 73 ++++++++++++++++++++++
 arch/loongarch/power/suspend_asm.S    | 90 +++++++++++++++++++++++++++
 13 files changed, 249 insertions(+), 3 deletions(-)
 create mode 100644 arch/loongarch/power/Makefile
 create mode 100644 arch/loongarch/power/platform.c
 create mode 100644 arch/loongarch/power/suspend.c
 create mode 100644 arch/loongarch/power/suspend_asm.S

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a8dc58e8162a..0df102401d1d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -57,6 +57,7 @@ config LOONGARCH
 	select ARCH_WANTS_NO_INSTR
 	select BUILDTIME_TABLE_SORT
 	select COMMON_CLK
+	select CPU_PM
 	select EFI
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
@@ -517,6 +518,10 @@ config ARCH_MMAP_RND_BITS_MAX
 
 menu "Power management options"
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+
+source "kernel/power/Kconfig"
 source "drivers/acpi/Kconfig"
 
 endmenu
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index f4cb54d5afd6..a0fc1f9980e3 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -104,6 +104,9 @@ endif
 libs-y += arch/loongarch/lib/
 libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+# suspend and hibernation support
+drivers-$(CONFIG_PM)	+= arch/loongarch/power/
+
 ifeq ($(KBUILD_EXTMOD),)
 prepare: vdso_prepare
 vdso_prepare: prepare0
diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 825c2519b9d1..4198753aa1d0 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -35,4 +35,14 @@ extern struct list_head acpi_wakeup_device_list;
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
 
+extern int loongarch_acpi_suspend(void);
+extern int (*acpi_suspend_lowlevel)(void);
+extern void loongarch_suspend_enter(void);
+
+static inline unsigned long acpi_get_wakeup_address(void)
+{
+	extern void loongarch_wakeup_start(void);
+	return (unsigned long)loongarch_wakeup_start;
+}
+
 #endif /* _ASM_LOONGARCH_ACPI_H */
diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
index ed0910e8b856..0051b526ac6d 100644
--- a/arch/loongarch/include/asm/bootinfo.h
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -32,6 +32,7 @@ struct loongson_system_configuration {
 	int cores_per_node;
 	int cores_per_package;
 	unsigned long cores_io_master;
+	unsigned long suspend_addr;
 	const char *cpuname;
 };
 
diff --git a/arch/loongarch/include/asm/loongson.h b/arch/loongarch/include/asm/loongson.h
index 00db93edae1b..12494cffffd1 100644
--- a/arch/loongarch/include/asm/loongson.h
+++ b/arch/loongarch/include/asm/loongson.h
@@ -136,4 +136,7 @@ typedef enum {
 #define ls7a_writel(val, addr)	*(volatile unsigned int   *)TO_UNCACHE(addr) = (val)
 #define ls7a_writeq(val, addr)	*(volatile unsigned long  *)TO_UNCACHE(addr) = (val)
 
+void enable_gpe_wakeup(void);
+void enable_pci_wakeup(void);
+
 #endif /* __ASM_LOONGSON_H */
diff --git a/arch/loongarch/include/asm/time.h b/arch/loongarch/include/asm/time.h
index 2eae219301d0..037a2d1b8ff4 100644
--- a/arch/loongarch/include/asm/time.h
+++ b/arch/loongarch/include/asm/time.h
@@ -12,6 +12,7 @@
 extern u64 cpu_clock_freq;
 extern u64 const_clock_freq;
 
+extern void save_counter(void);
 extern void sync_counter(void);
 
 static inline unsigned int calc_const_freq(void)
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 335398482038..8312c26177c2 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -156,6 +156,12 @@ static void __init acpi_process_madt(void)
 	loongson_sysconf.nr_cpus = num_processors;
 }
 
+#ifndef CONFIG_ACPI_SLEEP
+int (*acpi_suspend_lowlevel)(void);
+#else
+int (*acpi_suspend_lowlevel)(void) = loongarch_acpi_suspend;
+#endif
+
 int __init acpi_boot_init(void)
 {
 	/*
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 781a4d4bdddc..6e192a25e134 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/export.h>
+#include <linux/syscore_ops.h>
 #include <linux/time.h>
 #include <linux/tracepoint.h>
 #include <linux/sched/hotplug.h>
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 786735dcc8d6..a6576dea590c 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -115,12 +115,17 @@ static unsigned long __init get_loops_per_jiffy(void)
 	return lpj;
 }
 
-static long init_timeval;
+static long init_offset __nosavedata;
+
+void save_counter(void)
+{
+	init_offset = drdtime();
+}
 
 void sync_counter(void)
 {
 	/* Ensure counter begin at 0 */
-	csr_write64(-init_timeval, LOONGARCH_CSR_CNTC);
+	csr_write64(init_offset, LOONGARCH_CSR_CNTC);
 }
 
 static int get_timer_irq(void)
@@ -219,7 +224,7 @@ void __init time_init(void)
 	else
 		const_clock_freq = calc_const_freq();
 
-	init_timeval = drdtime() - csr_read64(LOONGARCH_CSR_CNTC);
+	init_offset = -(drdtime() - csr_read64(LOONGARCH_CSR_CNTC));
 
 	constant_clockevent_init();
 	constant_clocksource_init();
diff --git a/arch/loongarch/power/Makefile b/arch/loongarch/power/Makefile
new file mode 100644
index 000000000000..6740117decaa
--- /dev/null
+++ b/arch/loongarch/power/Makefile
@@ -0,0 +1,3 @@
+obj-y	+= platform.o
+
+obj-$(CONFIG_SUSPEND)		+= suspend.o suspend_asm.o
diff --git a/arch/loongarch/power/platform.c b/arch/loongarch/power/platform.c
new file mode 100644
index 000000000000..06534b80a361
--- /dev/null
+++ b/arch/loongarch/power/platform.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+
+#include <asm/bootinfo.h>
+#include <asm/loongson.h>
+
+void enable_gpe_wakeup(void)
+{
+	acpi_enable_all_wakeup_gpes();
+}
+
+void enable_pci_wakeup(void)
+{
+	acpi_write_bit_register(ACPI_BITREG_PCIEXP_WAKE_STATUS, 1);
+
+	if (acpi_gbl_FADT.flags & ACPI_FADT_PCI_EXPRESS_WAKE)
+		acpi_write_bit_register(ACPI_BITREG_PCIEXP_WAKE_DISABLE, 0);
+}
+
+static int __init loongson3_acpi_suspend_init(void)
+{
+#ifdef CONFIG_ACPI
+	acpi_status status;
+	uint64_t suspend_addr = 0;
+
+	if (acpi_disabled || acpi_gbl_reduced_hardware)
+		return 0;
+
+	acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
+	status = acpi_evaluate_integer(NULL, "\\SADR", NULL, &suspend_addr);
+	if (ACPI_FAILURE(status) || !suspend_addr) {
+		pr_err("ACPI S3 is not support!\n");
+		return -1;
+	}
+	loongson_sysconf.suspend_addr = (u64)phys_to_virt(PHYSADDR(suspend_addr));
+#endif
+	return 0;
+}
+
+device_initcall(loongson3_acpi_suspend_init);
diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspend.c
new file mode 100644
index 000000000000..5e19733e5e05
--- /dev/null
+++ b/arch/loongarch/power/suspend.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * loongson-specific suspend support
+ *
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/acpi.h>
+#include <linux/pm.h>
+#include <linux/suspend.h>
+
+#include <asm/loongarch.h>
+#include <asm/loongson.h>
+#include <asm/setup.h>
+#include <asm/time.h>
+#include <asm/tlbflush.h>
+
+u64 loongarch_suspend_addr;
+
+struct saved_registers {
+	u32 ecfg;
+	u32 euen;
+	u64 pgd;
+	u64 kpgd;
+	u32 pwctl0;
+	u32 pwctl1;
+};
+static struct saved_registers saved_regs;
+
+static void arch_common_suspend(void)
+{
+	save_counter();
+	saved_regs.pgd = csr_read64(LOONGARCH_CSR_PGDL);
+	saved_regs.kpgd = csr_read64(LOONGARCH_CSR_PGDH);
+	saved_regs.pwctl0 = csr_read32(LOONGARCH_CSR_PWCTL0);
+	saved_regs.pwctl1 = csr_read32(LOONGARCH_CSR_PWCTL1);
+	saved_regs.ecfg = csr_read32(LOONGARCH_CSR_ECFG);
+	saved_regs.euen = csr_read32(LOONGARCH_CSR_EUEN);
+
+	loongarch_suspend_addr = loongson_sysconf.suspend_addr;
+}
+
+static void arch_common_resume(void)
+{
+	sync_counter();
+	local_flush_tlb_all();
+	csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
+	csr_write64(eentry, LOONGARCH_CSR_EENTRY);
+	csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
+	csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
+
+	csr_write64(saved_regs.pgd, LOONGARCH_CSR_PGDL);
+	csr_write64(saved_regs.kpgd, LOONGARCH_CSR_PGDH);
+	csr_write32(saved_regs.pwctl0, LOONGARCH_CSR_PWCTL0);
+	csr_write32(saved_regs.pwctl1, LOONGARCH_CSR_PWCTL1);
+	csr_write32(saved_regs.ecfg, LOONGARCH_CSR_ECFG);
+	csr_write32(saved_regs.euen, LOONGARCH_CSR_EUEN);
+}
+
+int loongarch_acpi_suspend(void)
+{
+	enable_gpe_wakeup();
+	enable_pci_wakeup();
+
+	arch_common_suspend();
+
+	/* processor specific suspend */
+	loongarch_suspend_enter();
+
+	arch_common_resume();
+
+	return 0;
+}
diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
new file mode 100644
index 000000000000..4469d89d0227
--- /dev/null
+++ b/arch/loongarch/power/suspend_asm.S
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Sleep helper for Loongson-3 sleep mode.
+ *
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/addrspace.h>
+#include <asm/loongarch.h>
+#include <asm/stackframe.h>
+
+/* preparatory stuff */
+.macro	SETUP_SLEEP
+	addi.d		sp, sp, -PT_SIZE
+	st.d		$r1, sp, PT_R1
+	st.d		$r2, sp, PT_R2
+	st.d		$r3, sp, PT_R3
+	st.d		$r4, sp, PT_R4
+	st.d		$r11, sp, PT_R11
+	st.d		$r21, sp, PT_R21
+	st.d		$r22, sp, PT_R22
+	st.d		$r23, sp, PT_R23
+	st.d		$r24, sp, PT_R24
+	st.d		$r25, sp, PT_R25
+	st.d		$r26, sp, PT_R26
+	st.d		$r27, sp, PT_R27
+	st.d		$r28, sp, PT_R28
+	st.d		$r29, sp, PT_R29
+	st.d		$r30, sp, PT_R30
+	st.d		$r31, sp, PT_R31
+
+	la.pcrel	t0, acpi_saved_sp
+	st.d		sp, t0, 0
+.endm
+
+.macro SETUP_WAKEUP
+	ld.d		$r1, sp, PT_R1
+	ld.d		$r2, sp, PT_R2
+	ld.d		$r3, sp, PT_R3
+	ld.d		$r4, sp, PT_R4
+	ld.d		$r21, sp, PT_R21
+	ld.d		$r22, sp, PT_R22
+	ld.d		$r23, sp, PT_R23
+	ld.d		$r24, sp, PT_R24
+	ld.d		$r25, sp, PT_R25
+	ld.d		$r26, sp, PT_R26
+	ld.d		$r27, sp, PT_R27
+	ld.d		$r28, sp, PT_R28
+	ld.d		$r29, sp, PT_R29
+	ld.d		$r30, sp, PT_R30
+	ld.d		$r31, sp, PT_R31
+.endm
+
+	.text
+	.align 12
+
+/* Sleep/wakeup code for Loongson-3 */
+SYM_FUNC_START(loongarch_suspend_enter)
+	SETUP_SLEEP
+	bl		__flush_cache_all
+
+	/* Pass RA and SP to BIOS */
+	addi.d		a1, sp, 0
+	la.pcrel	a0, loongarch_wakeup_start
+	la.pcrel	t0, loongarch_suspend_addr
+	ld.d		t0, t0, 0
+	jirl		a0, t0, 0 /* Call BIOS's STR sleep routine */
+
+	/*
+	 * This is where we return upon wakeup.
+	 * Reload all of the registers and return.
+	 */
+SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
+	li.d		t0, CSR_DMW0_INIT	# UC, PLV0
+	csrwr		t0, LOONGARCH_CSR_DMWIN0
+	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
+	csrwr		t0, LOONGARCH_CSR_DMWIN1
+
+	la.abs		t0, 0f
+	jr		t0
+0:
+	la.pcrel	t0, acpi_saved_sp
+	ld.d		sp, t0, 0
+	SETUP_WAKEUP
+	addi.d		sp, sp, PT_SIZE
+	jr		ra
+SYM_FUNC_END(loongarch_suspend_enter)
-- 
2.31.1

