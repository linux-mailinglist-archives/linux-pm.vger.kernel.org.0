Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DBB610B40
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 09:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJ1H0D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 03:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ1H0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 03:26:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0ECBCABF3
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 00:26:00 -0700 (PDT)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8DxfbcHhFtjJAsDAA--.6603S3;
        Fri, 28 Oct 2022 15:25:59 +0800 (CST)
Received: from [10.136.12.12] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxr+AFhFtjJD0GAA--.22104S3;
        Fri, 28 Oct 2022 15:25:58 +0800 (CST)
Subject: Re: [PATCH 2/2] LoongArch: Add hibernation (ACPI S4) support
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20221028023829.4030984-1-chenhuacai@loongson.cn>
 <20221028023829.4030984-2-chenhuacai@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <61fdb0b1-d413-1fa4-5dde-748db84c5994@loongson.cn>
Date:   Fri, 28 Oct 2022 15:25:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221028023829.4030984-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dxr+AFhFtjJD0GAA--.22104S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3GFy3CrW8Wr47Kw18Gw48Zwb_yoW3Xr17pr
        yDAF4kJ3yv9Fn7Jr93t34UZrn8Jw4kKw43Wa43CryxJF17Xrn8Aw18Kr98XF1rtw48Cr10
        vr1fK3ya9F47KaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Huacai,


On 2022/10/28 上午10:38, Huacai Chen wrote:
> Add hibernation (Suspend to Disk, aka ACPI S4) support for LoongArch.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/Kconfig               |  3 ++
>   arch/loongarch/kernel/asm-offsets.c  | 12 +++++
>   arch/loongarch/kernel/reset.c        |  2 +
>   arch/loongarch/kernel/setup.c        |  5 ++
>   arch/loongarch/power/Makefile        |  1 +
>   arch/loongarch/power/hibernate.c     | 58 ++++++++++++++++++++++++
>   arch/loongarch/power/hibernate_asm.S | 68 ++++++++++++++++++++++++++++
>   7 files changed, 149 insertions(+)
>   create mode 100644 arch/loongarch/power/hibernate.c
>   create mode 100644 arch/loongarch/power/hibernate_asm.S
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 0df102401d1d..1943f840e494 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -521,6 +521,9 @@ menu "Power management options"
>   config ARCH_SUSPEND_POSSIBLE
>   	def_bool y
>   
> +config ARCH_HIBERNATION_POSSIBLE
> +	def_bool y
> +
>   source "kernel/power/Kconfig"
>   source "drivers/acpi/Kconfig"
>   
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
> index bdd88eda9513..4ef494577813 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -257,3 +257,15 @@ void output_smpboot_defines(void)
>   	BLANK();
>   }
>   #endif
> +
> +#ifdef CONFIG_HIBERNATION
> +void output_pbe_defines(void)
> +{
> +	COMMENT(" Linux struct pbe offsets. ");
> +	OFFSET(PBE_ADDRESS, pbe, address);
> +	OFFSET(PBE_ORIG_ADDRESS, pbe, orig_address);
> +	OFFSET(PBE_NEXT, pbe, next);
> +	DEFINE(PBE_SIZE, sizeof(struct pbe));
> +	BLANK();
> +}
> +#endif
> diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
> index 8c82021eb2f4..cdf021ff6214 100644
> --- a/arch/loongarch/kernel/reset.c
> +++ b/arch/loongarch/kernel/reset.c
> @@ -15,6 +15,7 @@
>   #include <acpi/reboot.h>
>   #include <asm/idle.h>
>   #include <asm/loongarch.h>
> +#include <asm/loongson.h>
>   
>   void (*pm_power_off)(void);
>   EXPORT_SYMBOL(pm_power_off);
> @@ -42,6 +43,7 @@ void machine_power_off(void)
>   	preempt_disable();
>   	smp_send_stop();
>   #endif
> +	enable_pci_wakeup();
>   	do_kernel_power_off();
>   #ifdef CONFIG_EFI
>   	efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 96b6cb5db004..3c8bc250f4e2 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -28,6 +28,7 @@
>   #include <linux/sizes.h>
>   #include <linux/device.h>
>   #include <linux/dma-map-ops.h>
> +#include <linux/suspend.h>
>   #include <linux/swiotlb.h>
>   
>   #include <asm/addrspace.h>
> @@ -312,6 +313,10 @@ static void __init arch_mem_init(char **cmdline_p)
>   
>   	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
>   
> +	/* Reserve for hibernation. */
> +	register_nosave_region(PFN_DOWN(__pa_symbol(&__nosave_begin)),
> +				   PFN_UP(__pa_symbol(&__nosave_end)));
> +
>   	memblock_dump_all();
>   
>   	early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
> diff --git a/arch/loongarch/power/Makefile b/arch/loongarch/power/Makefile
> index 6740117decaa..58151d003e40 100644
> --- a/arch/loongarch/power/Makefile
> +++ b/arch/loongarch/power/Makefile
> @@ -1,3 +1,4 @@
>   obj-y	+= platform.o
>   
>   obj-$(CONFIG_SUSPEND)		+= suspend.o suspend_asm.o
> +obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate_asm.o
> diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hibernate.c
> new file mode 100644
> index 000000000000..32dae9ef311a
> --- /dev/null
> +++ b/arch/loongarch/power/hibernate.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <asm/fpu.h>
> +#include <asm/loongson.h>
> +#include <asm/sections.h>
> +#include <asm/tlbflush.h>
> +
> +static u64 saved_crmd;
> +static u64 saved_prmd;
> +static u64 saved_euen;
> +static u64 saved_ecfg;
> +struct pt_regs saved_regs;
> +
> +void save_processor_state(void)
> +{
> +	saved_crmd = csr_read32(LOONGARCH_CSR_CRMD);
> +	saved_prmd = csr_read32(LOONGARCH_CSR_PRMD);
> +	saved_euen = csr_read32(LOONGARCH_CSR_EUEN);
> +	saved_ecfg = csr_read32(LOONGARCH_CSR_ECFG);
> +
> +	if (is_fpu_owner())
> +		save_fp(current);
> +}
> +
> +void restore_processor_state(void)
> +{
> +	csr_write32(saved_crmd, LOONGARCH_CSR_CRMD);
> +	csr_write32(saved_prmd, LOONGARCH_CSR_PRMD);
> +	csr_write32(saved_euen, LOONGARCH_CSR_EUEN);
> +	csr_write32(saved_ecfg, LOONGARCH_CSR_ECFG);
> +
> +	if (is_fpu_owner())
> +		restore_fp(current);
> +}
> +
> +int pfn_is_nosave(unsigned long pfn)
> +{
I'm surprised that every arch has its own version of pfn_is_nosave().

We can improve it. But it's beyond these patches, just ignore here.


> +	unsigned long nosave_begin_pfn = PFN_DOWN(__pa(&__nosave_begin));
> +	unsigned long nosave_end_pfn = PFN_UP(__pa(&__nosave_end));
> +
> +	return	(pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
> +}
> +
> +extern int swsusp_asm_suspend(void);
> +
> +int swsusp_arch_suspend(void)
> +{
> +	enable_pci_wakeup();
> +	return swsusp_asm_suspend();
> +}
> +
> +extern int swsusp_asm_resume(void);
> +
> +int swsusp_arch_resume(void)
> +{
> +	/* Avoid TLB mismatch during and after kernel resume */
> +	local_flush_tlb_all();
> +	return swsusp_asm_resume();
> +}
> diff --git a/arch/loongarch/power/hibernate_asm.S b/arch/loongarch/power/hibernate_asm.S
> new file mode 100644
> index 000000000000..7894fbd56c85
> --- /dev/null
> +++ b/arch/loongarch/power/hibernate_asm.S
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Hibernation support specific for LoongArch
> + *
> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/regdef.h>
> +
> +.text
> +SYM_FUNC_START(swsusp_asm_suspend)
> +	la.pcrel	t0, saved_regs
> +	PTR_S		ra, t0, PT_R1
> +	PTR_S		sp, t0, PT_R3
> +	PTR_S		fp, t0, PT_R22
> +	PTR_S		tp, t0, PT_R2
> +	PTR_S		s0, t0, PT_R23
> +	PTR_S		s1, t0, PT_R24
> +	PTR_S		s2, t0, PT_R25
> +	PTR_S		s3, t0, PT_R26
> +	PTR_S		s4, t0, PT_R27
> +	PTR_S		s5, t0, PT_R28
> +	PTR_S		s6, t0, PT_R29
> +	PTR_S		s7, t0, PT_R30
> +	PTR_S		s8, t0, PT_R31
> +	b		swsusp_save

Is needed save and restore PERCPU_BASE_KS, u0 or other KSave registers?


Thanks,

Jinyang


> +SYM_FUNC_END(swsusp_asm_suspend)
> +
> +SYM_FUNC_START(swsusp_asm_resume)
> +	la.pcrel	t0, restore_pblist
> +	PTR_L		t0, t0, 0
> +0:
> +	PTR_L		t1, t0, PBE_ADDRESS  /* source */
> +	PTR_L		t2, t0, PBE_ORIG_ADDRESS /* destination */
> +	PTR_LI		t3, _PAGE_SIZE
> +	PTR_ADD		t3, t3, t1
> +1:
> +	REG_L		t8, t1, 0
> +	REG_S		t8, t2, 0
> +	PTR_ADDI	t1, t1, SZREG
> +	PTR_ADDI	t2, t2, SZREG
> +	bne		t1, t3, 1b
> +	PTR_L		t0, t0, PBE_NEXT
> +	bnez		t0, 0b
> +	la.pcrel	t0, saved_regs
> +	PTR_L		ra, t0, PT_R1
> +	PTR_L		sp, t0, PT_R3
> +	PTR_L		fp, t0, PT_R22
> +	PTR_L		tp, t0, PT_R2
> +	PTR_L		s0, t0, PT_R23
> +	PTR_L		s1, t0, PT_R24
> +	PTR_L		s2, t0, PT_R25
> +	PTR_L		s3, t0, PT_R26
> +	PTR_L		s4, t0, PT_R27
> +	PTR_L		s5, t0, PT_R28
> +	PTR_L		s6, t0, PT_R29
> +	PTR_L		s7, t0, PT_R30
> +	PTR_L		s8, t0, PT_R31
> +	PTR_LI		a0, 0x0
> +	jirl		zero, ra, 0
> +SYM_FUNC_END(swsusp_asm_resume)

