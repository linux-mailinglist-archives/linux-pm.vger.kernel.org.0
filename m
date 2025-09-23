Return-Path: <linux-pm+bounces-35235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9294B96996
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15CA32177E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA5726CE35;
	Tue, 23 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PhjyFkfE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFF1A23B9
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641523; cv=none; b=lteoPMY6ahB1rb9JDgsQWtgOnSmxqEvlTU1V65hbyIXhUPkk4cTa/BaBKzMZxXECOZvi5VhH/LoLS2kN8B12LuY4xGNxwkBKot72cSgUDDNDnGnBouRKcSU2IBpaUQx9mai1a+sbAS80oB+T7yD/WSRdYQ5bIqkP6YEfNvDZWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641523; c=relaxed/simple;
	bh=gODZzPD/opn1TM9cf3UdOfrIL0SMTLmEZ7NN+GXHa6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ONNA3dwmXy+ZZ9XWpsO6YcT5KaWjKWY2CF2jUbd5D5a+/aB7Gu2iYcaSYplOaYrLQ4+9vRxNaWs556Djalhyzj56jzkB7fqoi8KFBPvLMsVnytEUzuB073g1p25R28LUMEFYavqr1w+TEY4qHqJgxjNar6m/j9BPCJn19/nHS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PhjyFkfE; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-85322d9c606so72590885a.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758641519; x=1759246319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNQg6Dmvc7QhPeOGSjQkaaU9Q6+ewyJ1+A+N+0yiv7Q=;
        b=PhjyFkfESyNWL+OKGPOGUyoNuCEc+jtJZ1Hc5QX2yk/WKg+Mx9fWpHzyRsS8UwNsoj
         +PQD2mjt/mIepxgl2qwZERaFypJYzgf57q6y7IMGt7LaxVVjDOYA4osTStalc4PRauXq
         LkS1e9ZSmHFdXatNhS3hswcBUqaJk/Ee/CmtTsU8WRI65W6C//bU+PIj5mGDHCCPShR8
         ItxTYHfZp0rN7FBFM7XWA5kmZLDj/cKWGIIC5T2Hw3q5XyeSj7a1uhZfm854u6iG1avl
         7tQlECWjMbHQgPfAUHO4W9jCzAFhXa3e2dbM4jRYu5jm/bz8qDeSGXQzZ8y+TLQ1hFQG
         pmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641519; x=1759246319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNQg6Dmvc7QhPeOGSjQkaaU9Q6+ewyJ1+A+N+0yiv7Q=;
        b=a68OSo5xOykJI5KEjoscaWNYx2VY/syOs0Kx0zggPf/2DiqnF78QSit4Tz2qHC51SV
         TWtY/TYLImj0zyLKTrw50NYTl+mgWd3zs+zt3OysjX5qVKrwYJVBQ73p/gx+cwaHyJoP
         EPg5p3KZMimKnEpU+6hAAvC9m9diTsiHgitadEA47Rp7G8iXVKX9BLv85zBK8Yinf9sK
         lr+wgdzw7DWpATFg11MnMUjK58Lcjqw9jGFcYYlsI6QP7Us6zShmU8wY9wWZgDvibpVP
         iL1qks7hR+ElqWSB5km49iCRuE4Ay0Ydmd2DGXSN5uqtmmhBOnuhuxeZv1QZYQvQi6wW
         rqWA==
X-Forwarded-Encrypted: i=1; AJvYcCW+IDhpptB0zDxqZZVBn/CjNzs5GSmQGQbUtIi2dBfihiXadamie/oJWuh95r46Kf+zqWxUD1mHMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnuz/ZhnRY7WWesoFUaJhJlNQzx/tjz3JcdDSmS5wwlE0+yjoC
	ggPkAnMgReTJK+14bqHKI9qJBO7mnCwG+9d4r+kROVucJOArQdnDGebTbWY69ll1Ew8=
X-Gm-Gg: ASbGncu+JwHwZ3zvEvbSF4H8lSGlaJTbtBqUdEkOaMdG6myos6ePHmI7qTbbhGKXpB3
	qOel4zBeMimS8bD61oDf7pyb/teDnQFgiwJFxPQodb+/XYuxR+Wh9Xjl2SOktoPiZEaSx8tb0VI
	GgVt4Na62EyOCViRCnG6NyuejujwEIyVGAfZxY59gBIRUVk7VKKxBrxLoWa6BLMM6dYEAOIgf/C
	Ibg1DGBhHg3Xd1M85OM1nTGyEbwZl0mA++isu4xWDRL5d6YzahB7OQS6MprpJj0nsvaPM1GYr9O
	0IyqXq4pHKhhZNUtaYjeG1BaIPmSv8dUBLtoHIOtO1cZ51Pg2QZ2AOb+qMvnwuHLqhDvDSWBS4I
	uDw6aBRecMvY+hE7DGgXNDaLwDt9A
X-Google-Smtp-Source: AGHT+IG3zk1Sk0vaD8CMZLIiKqK7VvkHbQL7KBuD4nbMD4OVDlX0qOxl76RR2+NJ7QBWuWzryzvOrw==
X-Received: by 2002:a05:620a:29d2:b0:848:624c:457a with SMTP id af79cd13be357-8516ba5bdf9mr381050785a.33.1758641518908;
        Tue, 23 Sep 2025 08:31:58 -0700 (PDT)
Received: from localhost ([93.115.195.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836305769ecsm1021524285a.42.2025.09.23.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:31:58 -0700 (PDT)
From: Fam Zheng <fam.zheng@bytedance.com>
To: linux-kernel@vger.kernel.org
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	linyongting@bytedance.com,
	songmuchun@bytedance.com,
	satish.kumar@bytedance.com,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	yuanzhu@bytedance.com,
	Ingo Molnar <mingo@redhat.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	fam.zheng@bytedance.com,
	Zhang Rui <rui.zhang@intel.com>,
	fam@euphon.net,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	liangma@bytedance.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	guojinhui.liam@bytedance.com,
	linux-pm@vger.kernel.org,
	Thom Hughes <thom.hughes@bytedance.com>
Subject: [RFC 4/5] x86/parker: Add parker initialisation code
Date: Tue, 23 Sep 2025 15:31:45 +0000
Message-Id: <20250923153146.365015-5-fam.zheng@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923153146.365015-1-fam.zheng@bytedance.com>
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thom Hughes <thom.hughes@bytedance.com>

Signed-off-by: Thom Hughes <thom.hughes@bytedance.com>
Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
---
 arch/x86/kernel/setup.c             |   4 +
 arch/x86/parker/Makefile            |   3 +-
 arch/x86/parker/Makefile-full       |   3 +
 arch/x86/parker/setup.c             | 423 ++++++++++++++++++++++++++++
 arch/x86/parker/trampoline.S        |  55 ++++
 arch/x86/parker/trampoline.h        |  10 +
 drivers/thermal/intel/therm_throt.c |   3 +
 include/linux/parker-bkup.h         |  22 ++
 include/linux/parker.h              |  15 +
 9 files changed, 537 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/parker/Makefile-full
 create mode 100644 arch/x86/parker/setup.c
 create mode 100644 arch/x86/parker/trampoline.S
 create mode 100644 arch/x86/parker/trampoline.h
 create mode 100644 include/linux/parker-bkup.h

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cebee310e200..a3c7909efaf5 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/root_dev.h>
 #include <linux/hugetlb.h>
+#include <linux/parker.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
@@ -917,6 +918,7 @@ void __init setup_arch(char **cmdline_p)
 	 * called before cache_bp_init() for setting up MTRR state.
 	 */
 	init_hypervisor_platform();
+	parker_init();
 
 	tsc_early_init();
 	x86_init.resources.probe_roms();
@@ -1110,6 +1112,8 @@ void __init setup_arch(char **cmdline_p)
 
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+	/* Allocate memory for PARKER kernels */
+	parker_cma_reserve();
 
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
diff --git a/arch/x86/parker/Makefile b/arch/x86/parker/Makefile
index 41c40fc64267..506ad8cbff00 100644
--- a/arch/x86/parker/Makefile
+++ b/arch/x86/parker/Makefile
@@ -1,2 +1,3 @@
-obj-y += kernfs.o
+obj-y += kernfs.o setup.o trampoline.o
 $(obj)/kernfs.o: $(obj)/internal.h
+$(obj)/setup.o: $(obj)/internal.h
diff --git a/arch/x86/parker/Makefile-full b/arch/x86/parker/Makefile-full
new file mode 100644
index 000000000000..506ad8cbff00
--- /dev/null
+++ b/arch/x86/parker/Makefile-full
@@ -0,0 +1,3 @@
+obj-y += kernfs.o setup.o trampoline.o
+$(obj)/kernfs.o: $(obj)/internal.h
+$(obj)/setup.o: $(obj)/internal.h
diff --git a/arch/x86/parker/setup.c b/arch/x86/parker/setup.c
new file mode 100644
index 000000000000..2d36dac05289
--- /dev/null
+++ b/arch/x86/parker/setup.c
@@ -0,0 +1,423 @@
+#define pr_fmt(fmt)	"parker: " fmt
+
+#include <linux/module.h>
+#include <linux/memblock.h>
+#include <linux/parker.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/pgtable.h>
+#include <linux/reboot.h>
+
+#include <asm/apic.h>
+#include <asm/realmode.h>
+#include <asm/reboot.h>
+#include <asm/acpi.h>
+#include <asm/i8259.h>
+#include <asm/mpspec.h>
+#include <asm/x86_init.h>
+#include <asm/pci_x86.h>
+#include <asm/realmode.h>
+
+#include "internal.h"
+#include "trampoline.h"
+
+bool is_parker = false;
+
+static phys_addr_t parker_control_structure_address;
+static volatile struct parker_control_structure *parker_control_structure;
+
+static void (*old_shutdown)(void);
+static void (*old_restart)(char*);
+
+/* Take in parker control page as kernel parameter
+ * this also indicates we are booting as a parker kernel
+ * currently assumes that control structure is 1 page */
+static __init int parker_parse_early_param(char *opt)
+{
+	if (!opt)
+		return -EINVAL;
+	char *oldopt = opt;
+	parker_control_structure_address = memparse(opt, &opt);
+	if (oldopt == opt)
+		return -EINVAL;
+	is_parker = true;
+	return 0;
+}
+early_param("parker", parker_parse_early_param);
+
+inline bool is_parker_instance(void)
+{
+	return is_parker;
+}
+
+static struct resource parker_control_structure_resource = {
+	.name  = "Parker Control Structure",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_RESERVED
+};
+
+static struct real_mode_header parker_dummy_real_mode_header;
+
+static void parker_reserve_control_structure(unsigned long long addr)
+{
+	parker_control_structure_resource.start = addr;
+	parker_control_structure_resource.end = addr + PAGE_SIZE - 1;
+	insert_resource(&iomem_resource, &parker_control_structure_resource);
+}
+
+static void __init parker_x2apic_init(void)
+{
+#ifdef CONFIG_X86_X2APIC
+	if (!x2apic_enabled())
+		return;
+	x2apic_phys = 1;
+	/*
+	 * This will trigger the switch to apic_x2apic_phys.  Empty OEM IDs
+	 * ensure that only this APIC driver picks up the call.
+	 */
+	default_acpi_madt_oem_check("", "");
+#endif
+}
+
+/* Setup trampoline pagetable, stack and initial code pointer */
+static int __init parker_init_trampoline(void)
+{
+	/* Setup trampoline lock or else head_64.S:secondary_startup_64 will crash */
+	trampoline_lock = (u32 *)&parker_trampoline_lock;
+	WRITE_ONCE(*trampoline_lock, 0);
+
+	/* Map kernel page table so we can access kernel memory */
+	for (int i = pgd_index(__PAGE_OFFSET); i < PTRS_PER_PGD; i++)
+		WRITE_ONCE(parker_trampoline_pgt[i], init_top_pgt[i].pgd);
+
+	/* 1:1 map parker_ap_trampoline physical memory so we can jump from host*/
+	u64 paddr_map = virt_to_phys(parker_ap_trampoline);
+	pgd_t *pgd = (pgd_t*)parker_trampoline_pgt;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	pgd += pgd_index(paddr_map);
+	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
+	if (!pgd_present(*pgd)) {
+		p4d = (p4d_t *)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		if (!p4d)
+			return -ENOMEM;
+		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
+	}
+	p4d = p4d_offset(pgd, paddr_map);
+	if (!p4d_present(*p4d)) {
+		pud = (pud_t *)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		if (!pud) {
+			memblock_free(p4d, PAGE_SIZE);
+			return -ENOMEM;
+		}
+		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
+	}
+	pud = pud_offset(p4d, paddr_map);
+	if (!pud_present(*pud)) {
+		pmd = (pmd_t *)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		if (!pmd) {
+			memblock_free(p4d, PAGE_SIZE);
+			memblock_free(pud, PAGE_SIZE);
+			return -ENOMEM;
+		}
+		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+	}
+	pmd = pmd_offset(pud, paddr_map);
+	if (!pmd_present(*pmd)) {
+		pte = (pte_t *)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		if (!pte) {
+			memblock_free(p4d, PAGE_SIZE);
+			memblock_free(pud, PAGE_SIZE);
+			memblock_free(pmd, PAGE_SIZE);
+			return -ENOMEM;
+		}
+		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
+	}
+	pte = pte_offset_kernel(pmd, paddr_map);
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		prot = PAGE_KERNEL_EXEC;
+
+	set_pte(pte, pfn_pte(paddr_map >> PAGE_SHIFT, prot));
+
+	/* Write initial code (within parker) for secondary CPU initialisation */
+	WRITE_ONCE(parker_trampoline_start, secondary_startup_64);
+
+	/* Store virtual address of top of stack at bottom of stack */
+	WRITE_ONCE(parker_trampoline_stack, &parker_trampoline_stack_end);
+
+	/* Synchronise all updates */
+	smp_mb();
+
+	return 0;
+}
+
+static void parker_set_spoof_bsp(bool enabled)
+{
+	u64 msr;
+	rdmsrl(MSR_IA32_APICBASE, msr);
+	msr = enabled ? (msr | MSR_IA32_APICBASE_BSP) :
+			(msr & ~MSR_IA32_APICBASE_BSP);
+	wrmsrl(MSR_IA32_APICBASE, msr);
+}
+
+static void __init parker_parse_smp_cfg(void)
+{
+	int ret;
+	pr_info("smpconfig\n");
+	/* Disable legacy PIC */
+	pic_mode = 0;
+
+	/* Initialize x2apic as ACPI disabled */
+	parker_x2apic_init();
+
+	/* Spoof parker BSP as BSP or kernel thinks it's crash kernel */
+	parker_set_spoof_bsp(true);
+
+	/* Assume that lapic address is unchangd */
+	register_lapic_address(APIC_DEFAULT_PHYS_BASE);
+	ret = parker_init_trampoline();
+	if (ret < 0) {
+		pr_info("Failed to initialise trampoline.\n");
+		smp_found_config = 0;
+		return;
+	}
+
+	/* Register all APIC ID's for parker APs */
+	for (int i = 0; i < parker_control_structure->num_cpus; ++i) {
+		topology_register_apic(READ_ONCE(parker_control_structure->apic_ids[i]),
+				       CPU_ACPIID_INVALID,
+				       true);
+	}
+
+	smp_found_config = 1;
+}
+
+static bool __init parker_x2apic_available(void)
+{
+	return x2apic_enabled();
+}
+
+static void parker_init_host_control(void)
+{
+	parker_reserve_control_structure((unsigned long long)parker_control_structure);
+	phys_addr_t address = parker_control_structure_address;
+	parker_control_structure = early_memremap(address, PAGE_SIZE);
+	/* Announce trampoline physical address to host kernel */
+	phys_addr_t trampoline_phys_addr = virt_to_phys(parker_ap_trampoline);
+	WRITE_ONCE(parker_control_structure->start_address, trampoline_phys_addr);
+	smp_mb();
+}
+
+/* Some APIC callback overrides */
+static int parker_wakeup_secondary_cpu_64(u32 apicid, unsigned long _dummy_start_eip)
+{
+	WRITE_ONCE(parker_trampoline_apicid, apicid);
+	smp_mb();
+
+	/* Wait for APIC id to be reset before continuing,
+	 * ensuring no CPU misses trampoline kick. */
+	while (READ_ONCE(parker_trampoline_apicid) != 0)
+		cpu_relax();
+
+	return 0;
+}
+
+static void parker_send_IPI_allbutself(int vector)
+{
+	if (num_online_cpus() < 2)
+		return;
+
+	__apic_send_IPI_mask_allbutself(cpu_online_mask, vector);
+}
+
+static void parker_send_IPI_all(int vector)
+{
+	__apic_send_IPI_mask(cpu_online_mask, vector);
+}
+
+
+/* Setup real mode header so SMP doesn't dereference null pointer */
+static void __init parker_realmode_init(void)
+{
+	real_mode_header = &parker_dummy_real_mode_header;
+}
+
+static void parker_emergency_restart(void)
+{
+	pr_notice("Restart not supported, spinning\n");
+	for (;;) {
+		continue;
+	}
+}
+
+static void parker_offline(void)
+{
+	/* Remove BSP flag from APIC MSR
+	 * or we crash on second use of BSP in parker kernel */
+	parker_set_spoof_bsp(false);
+	parker_control_structure = memremap(parker_control_structure_address, PAGE_SIZE, MEMREMAP_WB);
+	if (!parker_control_structure) {
+		pr_err("Unable to map control structure, unable to tell host we are offline.\n");
+		return;
+	}
+	WRITE_ONCE(parker_control_structure->online, false);
+	memunmap((void*)parker_control_structure);
+}
+
+static void parker_shutdown(void)
+{
+	pr_info("shutting down.\n");
+	parker_offline();
+	old_shutdown();
+}
+
+/* No restart occurs, will just effectively shutdown */
+static void parker_restart(char *msg)
+{
+	pr_info("rebooting\n");
+	parker_offline();
+	old_restart(msg);
+}
+
+static struct pci_bus __init *parker_pci_init_root_bus(int busno)
+{
+	struct pci_bus *bus;
+	struct pci_sysdata *sd;
+	LIST_HEAD(resources);
+
+	/* If bus exists, continue */
+	/* TODO: Is domain always 0? (probably not) */
+	bus = pci_find_bus(0, busno);
+	if (bus)
+		return bus;
+
+	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
+	if (!sd) {
+		printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busno);
+		return NULL;
+	}
+
+	sd->node = x86_pci_root_bus_node(busno);
+	x86_pci_root_bus_resources(busno, &resources);
+	bus = pci_create_root_bus(NULL, busno, &pci_root_ops, sd, &resources);
+	if (!bus) {
+		pci_free_resource_list(&resources);
+		kfree(sd);
+		return NULL;
+	}
+
+	return bus;
+}
+
+static int __init parker_pci_init(void)
+{
+	/* Set to 0 as we are manually setting up and probing busses ourselves */
+	pcibios_last_bus = 0;
+
+	/* Scan only passed through PCI devices, passing through PCIe port unsuppored */
+	for (int i = 0; i < parker_control_structure->num_pci_devs; ++i) {
+		u32 dev_id = parker_control_structure->pci_dev_ids[i];
+		u32 busno = PCI_BUS_NUM(dev_id);
+		u32 devfn = dev_id & 0xff;
+		struct pci_bus *bus = parker_pci_init_root_bus(busno);
+		if (!bus) {
+			pr_err("Failed to get bus: %d\n", busno);
+			continue;
+		}
+		struct pci_dev *dev = pci_scan_single_device(bus, devfn);
+		if (!dev) {
+			pr_err("Failed to get dev: %d\n", devfn);
+			continue;
+		}
+		pci_bus_add_device(dev);
+	}
+
+	/* We can announce online now to host kernel */
+	WRITE_ONCE(parker_control_structure->online, 1);
+	smp_mb();
+
+	/* PCI initialisation is the last time the early mapped structure is used */
+	early_memunmap((void*)parker_control_structure, PAGE_SIZE);
+
+	/* TODO: Disable rescan! */
+	return 0;
+}
+
+static int parker_pci_enable_irq(struct pci_dev *dev)
+{
+	/* Let's lie to everyone ;) */
+	/* TODO: Find drivers that can use MSI only that fail to load without INT-A
+	 * then we can return -EINVAL; */
+	return 0;
+}
+
+static void parker_pci_disable_irq(struct pci_dev *dev)
+{
+	return;
+}
+
+void __init parker_init()
+{
+	if (!is_parker_instance())
+		return;
+
+	pr_info("parker: Initialising parker..\n");
+	/* TODO: Re-enable! */
+	legacy_pic = &null_legacy_pic;
+	/* Reserve dummy header so existing smpboot.c:do_boot_cpu code
+	 * doesn't dereference NULL pointer */
+	x86_platform.realmode_reserve		= x86_init_noop;
+	x86_platform.realmode_init		= parker_realmode_init;
+
+	/* Disable legacy code */
+	x86_platform.legacy.rtc			= 0;
+	x86_platform.legacy.warm_reset		= 0;
+	x86_platform.legacy.i8042		= X86_LEGACY_I8042_PLATFORM_ABSENT;
+
+	/* Disable emergency restart */
+	machine_ops.emergency_restart		= parker_emergency_restart;
+
+	/* Save old machine ops */
+	old_shutdown				= machine_ops.shutdown;
+	old_restart				= machine_ops.restart;
+
+	/* Ensure shutdown / restart makes host kernel aware parker is offline */
+	machine_ops.shutdown			= parker_shutdown;
+	machine_ops.restart			= parker_restart;
+
+	/* Use control structure for SMP CPU APIC ID enumeration */
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= parker_parse_smp_cfg;
+
+	/* TODO: Investigate x2apic alternative, but requires baremetal */
+	x86_init.hyper.x2apic_available = parker_x2apic_available;
+
+	/* Disable PCI IRQ handling as we don't support INT-A mode */
+	x86_init.pci.init			= parker_pci_init;
+	x86_init.pci.init_irq			= x86_init_noop;
+	x86_init.pci.fixup_irqs			= x86_init_noop;
+	pcibios_enable_irq			= parker_pci_enable_irq;
+	pcibios_disable_irq			= parker_pci_disable_irq;
+
+	/* No ACPI, so no hotplugging (be nice) */
+	disable_acpi();
+
+	/* Setup host kernel control page */
+	parker_init_host_control();
+
+	/* Let smpboot.c:do_boot_cpu use our wakeup routine */
+	apic_update_callback(wakeup_secondary_cpu_64, parker_wakeup_secondary_cpu_64);
+
+	/* Prevent shorthand IPIs */
+	apic_update_callback(send_IPI_all, parker_send_IPI_all);
+	apic_update_callback(send_IPI_allbutself, parker_send_IPI_allbutself);
+}
diff --git a/arch/x86/parker/trampoline.S b/arch/x86/parker/trampoline.S
new file mode 100644
index 000000000000..2107201eb1de
--- /dev/null
+++ b/arch/x86/parker/trampoline.S
@@ -0,0 +1,55 @@
+#include <linux/linkage.h>
+
+#include <asm/page_types.h>
+#include <asm/nospec-branch.h>
+#include <asm/unwind_hints.h>
+
+/* NOTE: No SME, host kernel and secondary kernel must match N-level pgt */
+/* NOTE: Changing this file will require a full recompilation as makefile isn't setup properly */
+.text
+.code64
+SYM_CODE_START(parker_ap_trampoline)
+	UNWIND_HINT_END_OF_STACK
+	ANNOTATE_NOENDBR
+/* Spin for now */
+.Lno_trampoline_start:
+	mov parker_trampoline_start(%rip), %rcx
+	test %rcx, %rcx
+	jz .Lno_trampoline_start
+	leaq parker_trampoline_pgt(%rip), %rax
+.Lno_stack:
+	/* Store vaddr of stack at top of stack */
+	movq parker_trampoline_stack(%rip), %rsp
+	test %rsp, %rsp
+	jz .Lno_stack
+	mov %rax, %cr3
+.Lwrong_apicid:
+	cmp parker_trampoline_apicid, %esi
+	jne .Lwrong_apicid
+.Ltrampoline_locked:
+	lock btsl $0, parker_trampoline_lock
+	jnc .Ltrampoline_unlocked
+	pause
+	jmp .Ltrampoline_locked
+/* Assume APIC ID 0 is never secondary processor */
+.Ltrampoline_unlocked:
+	movl $0, parker_trampoline_apicid
+	ANNOTATE_RETPOLINE_SAFE
+	call *%rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_CODE_END(parker_ap_trampoline)
+
+.data
+.balign PAGE_SIZE
+SYM_DATA(parker_trampoline_pgt, .skip 4096)
+SYM_DATA(parker_trampoline_start, .quad 0)
+SYM_DATA(parker_trampoline_apicid, .long 0)
+SYM_DATA(parker_trampoline_lock, .long 0)
+.balign 4096
+/* TODO: Just allocate a stack why waste 4KB */
+SYM_DATA_START(parker_trampoline_stack)
+	.skip 4096
+SYM_DATA_END_LABEL(parker_trampoline_stack, SYM_L_GLOBAL, parker_trampoline_stack_end)
+SYM_DATA(parker_trampoline_end, .quad 0)
diff --git a/arch/x86/parker/trampoline.h b/arch/x86/parker/trampoline.h
new file mode 100644
index 000000000000..b93ca612db99
--- /dev/null
+++ b/arch/x86/parker/trampoline.h
@@ -0,0 +1,10 @@
+#ifndef _TRAMPOLINE_H
+#define _TRAMPOLINE_H
+void parker_ap_trampoline(void);
+extern u64 parker_trampoline_pgt[];
+extern void *parker_trampoline_start;
+extern u32 parker_trampoline_lock;
+extern void *parker_trampoline_stack;
+extern u32 parker_trampoline_apicid;
+extern u64 parker_trampoline_stack_end;
+#endif
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index e69868e868eb..dabc7e35ff72 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/export.h>
+#include <linux/parker.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/smp.h>
@@ -690,6 +691,8 @@ void intel_thermal_interrupt(void)
 /* Thermal monitoring depends on APIC, ACPI and clock modulation */
 static int intel_thermal_supported(struct cpuinfo_x86 *c)
 {
+	if (is_parker_instance())
+		return 0;
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return 0;
 	if (!cpu_has(c, X86_FEATURE_ACPI) || !cpu_has(c, X86_FEATURE_ACC))
diff --git a/include/linux/parker-bkup.h b/include/linux/parker-bkup.h
new file mode 100644
index 000000000000..b00833b5a24b
--- /dev/null
+++ b/include/linux/parker-bkup.h
@@ -0,0 +1,22 @@
+#ifndef _LINUX_PARKER_H
+#define _LINUX_PARKER_H
+#ifdef CONFIG_PARKER
+extern void __init parker_cma_reserve(void);
+extern void __init parker_init(void);
+extern bool is_parker_instance(void);
+#else
+static inline __init void parker_cma_reserve(void)
+{
+}
+
+static inline __init void parker_init(void)
+{
+}
+
+static inline bool is_parker_instance(void)
+{
+	return false;
+}
+#endif /* CONFIG_PARKER */
+#endif /* _LINUX_PARKER_H */
+
diff --git a/include/linux/parker.h b/include/linux/parker.h
index 4984aefcee0f..b00833b5a24b 100644
--- a/include/linux/parker.h
+++ b/include/linux/parker.h
@@ -1,7 +1,22 @@
 #ifndef _LINUX_PARKER_H
 #define _LINUX_PARKER_H
 #ifdef CONFIG_PARKER
+extern void __init parker_cma_reserve(void);
+extern void __init parker_init(void);
+extern bool is_parker_instance(void);
+#else
+static inline __init void parker_cma_reserve(void)
+{
+}
 
+static inline __init void parker_init(void)
+{
+}
+
+static inline bool is_parker_instance(void)
+{
+	return false;
+}
 #endif /* CONFIG_PARKER */
 #endif /* _LINUX_PARKER_H */
 
-- 
2.39.5


