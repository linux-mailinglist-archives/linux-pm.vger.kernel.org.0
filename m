Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1161084E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 04:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiJ1ClU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Oct 2022 22:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiJ1ClS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2022 22:41:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6246F97D4F
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2022 19:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3957B82743
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 02:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D703C433D7;
        Fri, 28 Oct 2022 02:41:12 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 2/2] LoongArch: Add hibernation (ACPI S4) support
Date:   Fri, 28 Oct 2022 10:38:29 +0800
Message-Id: <20221028023829.4030984-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221028023829.4030984-1-chenhuacai@loongson.cn>
References: <20221028023829.4030984-1-chenhuacai@loongson.cn>
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

Add hibernation (Suspend to Disk, aka ACPI S4) support for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig               |  3 ++
 arch/loongarch/kernel/asm-offsets.c  | 12 +++++
 arch/loongarch/kernel/reset.c        |  2 +
 arch/loongarch/kernel/setup.c        |  5 ++
 arch/loongarch/power/Makefile        |  1 +
 arch/loongarch/power/hibernate.c     | 58 ++++++++++++++++++++++++
 arch/loongarch/power/hibernate_asm.S | 68 ++++++++++++++++++++++++++++
 7 files changed, 149 insertions(+)
 create mode 100644 arch/loongarch/power/hibernate.c
 create mode 100644 arch/loongarch/power/hibernate_asm.S

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 0df102401d1d..1943f840e494 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -521,6 +521,9 @@ menu "Power management options"
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+
 source "kernel/power/Kconfig"
 source "drivers/acpi/Kconfig"
 
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index bdd88eda9513..4ef494577813 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -257,3 +257,15 @@ void output_smpboot_defines(void)
 	BLANK();
 }
 #endif
+
+#ifdef CONFIG_HIBERNATION
+void output_pbe_defines(void)
+{
+	COMMENT(" Linux struct pbe offsets. ");
+	OFFSET(PBE_ADDRESS, pbe, address);
+	OFFSET(PBE_ORIG_ADDRESS, pbe, orig_address);
+	OFFSET(PBE_NEXT, pbe, next);
+	DEFINE(PBE_SIZE, sizeof(struct pbe));
+	BLANK();
+}
+#endif
diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
index 8c82021eb2f4..cdf021ff6214 100644
--- a/arch/loongarch/kernel/reset.c
+++ b/arch/loongarch/kernel/reset.c
@@ -15,6 +15,7 @@
 #include <acpi/reboot.h>
 #include <asm/idle.h>
 #include <asm/loongarch.h>
+#include <asm/loongson.h>
 
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
@@ -42,6 +43,7 @@ void machine_power_off(void)
 	preempt_disable();
 	smp_send_stop();
 #endif
+	enable_pci_wakeup();
 	do_kernel_power_off();
 #ifdef CONFIG_EFI
 	efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 96b6cb5db004..3c8bc250f4e2 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -28,6 +28,7 @@
 #include <linux/sizes.h>
 #include <linux/device.h>
 #include <linux/dma-map-ops.h>
+#include <linux/suspend.h>
 #include <linux/swiotlb.h>
 
 #include <asm/addrspace.h>
@@ -312,6 +313,10 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
 
+	/* Reserve for hibernation. */
+	register_nosave_region(PFN_DOWN(__pa_symbol(&__nosave_begin)),
+				   PFN_UP(__pa_symbol(&__nosave_end)));
+
 	memblock_dump_all();
 
 	early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
diff --git a/arch/loongarch/power/Makefile b/arch/loongarch/power/Makefile
index 6740117decaa..58151d003e40 100644
--- a/arch/loongarch/power/Makefile
+++ b/arch/loongarch/power/Makefile
@@ -1,3 +1,4 @@
 obj-y	+= platform.o
 
 obj-$(CONFIG_SUSPEND)		+= suspend.o suspend_asm.o
+obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate_asm.o
diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hibernate.c
new file mode 100644
index 000000000000..32dae9ef311a
--- /dev/null
+++ b/arch/loongarch/power/hibernate.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/fpu.h>
+#include <asm/loongson.h>
+#include <asm/sections.h>
+#include <asm/tlbflush.h>
+
+static u64 saved_crmd;
+static u64 saved_prmd;
+static u64 saved_euen;
+static u64 saved_ecfg;
+struct pt_regs saved_regs;
+
+void save_processor_state(void)
+{
+	saved_crmd = csr_read32(LOONGARCH_CSR_CRMD);
+	saved_prmd = csr_read32(LOONGARCH_CSR_PRMD);
+	saved_euen = csr_read32(LOONGARCH_CSR_EUEN);
+	saved_ecfg = csr_read32(LOONGARCH_CSR_ECFG);
+
+	if (is_fpu_owner())
+		save_fp(current);
+}
+
+void restore_processor_state(void)
+{
+	csr_write32(saved_crmd, LOONGARCH_CSR_CRMD);
+	csr_write32(saved_prmd, LOONGARCH_CSR_PRMD);
+	csr_write32(saved_euen, LOONGARCH_CSR_EUEN);
+	csr_write32(saved_ecfg, LOONGARCH_CSR_ECFG);
+
+	if (is_fpu_owner())
+		restore_fp(current);
+}
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = PFN_DOWN(__pa(&__nosave_begin));
+	unsigned long nosave_end_pfn = PFN_UP(__pa(&__nosave_end));
+
+	return	(pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
+
+extern int swsusp_asm_suspend(void);
+
+int swsusp_arch_suspend(void)
+{
+	enable_pci_wakeup();
+	return swsusp_asm_suspend();
+}
+
+extern int swsusp_asm_resume(void);
+
+int swsusp_arch_resume(void)
+{
+	/* Avoid TLB mismatch during and after kernel resume */
+	local_flush_tlb_all();
+	return swsusp_asm_resume();
+}
diff --git a/arch/loongarch/power/hibernate_asm.S b/arch/loongarch/power/hibernate_asm.S
new file mode 100644
index 000000000000..7894fbd56c85
--- /dev/null
+++ b/arch/loongarch/power/hibernate_asm.S
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Hibernation support specific for LoongArch
+ *
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+
+.text
+SYM_FUNC_START(swsusp_asm_suspend)
+	la.pcrel	t0, saved_regs
+	PTR_S		ra, t0, PT_R1
+	PTR_S		sp, t0, PT_R3
+	PTR_S		fp, t0, PT_R22
+	PTR_S		tp, t0, PT_R2
+	PTR_S		s0, t0, PT_R23
+	PTR_S		s1, t0, PT_R24
+	PTR_S		s2, t0, PT_R25
+	PTR_S		s3, t0, PT_R26
+	PTR_S		s4, t0, PT_R27
+	PTR_S		s5, t0, PT_R28
+	PTR_S		s6, t0, PT_R29
+	PTR_S		s7, t0, PT_R30
+	PTR_S		s8, t0, PT_R31
+	b		swsusp_save
+SYM_FUNC_END(swsusp_asm_suspend)
+
+SYM_FUNC_START(swsusp_asm_resume)
+	la.pcrel	t0, restore_pblist
+	PTR_L		t0, t0, 0
+0:
+	PTR_L		t1, t0, PBE_ADDRESS  /* source */
+	PTR_L		t2, t0, PBE_ORIG_ADDRESS /* destination */
+	PTR_LI		t3, _PAGE_SIZE
+	PTR_ADD		t3, t3, t1
+1:
+	REG_L		t8, t1, 0
+	REG_S		t8, t2, 0
+	PTR_ADDI	t1, t1, SZREG
+	PTR_ADDI	t2, t2, SZREG
+	bne		t1, t3, 1b
+	PTR_L		t0, t0, PBE_NEXT
+	bnez		t0, 0b
+	la.pcrel	t0, saved_regs
+	PTR_L		ra, t0, PT_R1
+	PTR_L		sp, t0, PT_R3
+	PTR_L		fp, t0, PT_R22
+	PTR_L		tp, t0, PT_R2
+	PTR_L		s0, t0, PT_R23
+	PTR_L		s1, t0, PT_R24
+	PTR_L		s2, t0, PT_R25
+	PTR_L		s3, t0, PT_R26
+	PTR_L		s4, t0, PT_R27
+	PTR_L		s5, t0, PT_R28
+	PTR_L		s6, t0, PT_R29
+	PTR_L		s7, t0, PT_R30
+	PTR_L		s8, t0, PT_R31
+	PTR_LI		a0, 0x0
+	jirl		zero, ra, 0
+SYM_FUNC_END(swsusp_asm_resume)
-- 
2.31.1

