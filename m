Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437E8610D3F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 11:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJ1JbC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 05:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJ1JbB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 05:31:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A1D21265
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 02:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2D34B828C2
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 09:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EB8C43140
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 09:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666949456;
        bh=fh34Dm+6uKYdtnBL4m6v70DedWLXWQYHUSTkQ9C3n8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SZjGDkpaYFYGihTAQxdVCigJpmCgaMpbtFk/hcNGuLZcmgTNg82/S8ginEfEhTT8r
         o7GVEBus+H7vxmcf2qcrGSzpsd9i8VBn0b7mSmq3JmXkDm3icn12Eo7JxmuxsS1xh0
         ei2Utl336eMmiyXGKINazxyY96jClvU8A7k2/3wIc4GlIeGChjNPw8stO9FDmTDXVX
         19+0Aj6Z8CGcB9GOaqd64rhq6SJ8JE8KmSgIMFflbc6d8hZnFETRmxvhfvcepcMHZk
         2el0ON+x+ifEoU8G+mQvnR8H6FB9bdIRPrXmA/RMg4mGtOKEoTUaV97tQE5m3qNtUe
         HWsl1kLONv+dw==
Received: by mail-ed1-f43.google.com with SMTP id z97so7008624ede.8
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 02:30:56 -0700 (PDT)
X-Gm-Message-State: ACrzQf0wAtcJpmcUGik76+EOwO+VtJ68EU/9mClpX4Mu7zNGouXvNmAI
        tkzObPfrrcP/nQPy2nedEHmujzI1tOS8BR4bzUE=
X-Google-Smtp-Source: AMsMyM6khVIOwiYobGeDhADEJKQ82dhmT4B5UYJZGwaftdghfMgYeyJXGyGuLima2Ol5lUUx9fmIk4L4tbnSjZPbcLw=
X-Received: by 2002:a05:6402:550e:b0:456:f79f:2bed with SMTP id
 fi14-20020a056402550e00b00456f79f2bedmr50690272edb.106.1666949454758; Fri, 28
 Oct 2022 02:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221028023829.4030984-1-chenhuacai@loongson.cn>
 <20221028023829.4030984-2-chenhuacai@loongson.cn> <61fdb0b1-d413-1fa4-5dde-748db84c5994@loongson.cn>
In-Reply-To: <61fdb0b1-d413-1fa4-5dde-748db84c5994@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 28 Oct 2022 17:30:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6we4jY3==73GDxJ19JLctcRxHraPJArHrb=ZFqCM3+hg@mail.gmail.com>
Message-ID: <CAAhV-H6we4jY3==73GDxJ19JLctcRxHraPJArHrb=ZFqCM3+hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Add hibernation (ACPI S4) support
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Jinyang,

On Fri, Oct 28, 2022 at 3:26 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> Hi, Huacai,
>
>
> On 2022/10/28 =E4=B8=8A=E5=8D=8810:38, Huacai Chen wrote:
> > Add hibernation (Suspend to Disk, aka ACPI S4) support for LoongArch.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/Kconfig               |  3 ++
> >   arch/loongarch/kernel/asm-offsets.c  | 12 +++++
> >   arch/loongarch/kernel/reset.c        |  2 +
> >   arch/loongarch/kernel/setup.c        |  5 ++
> >   arch/loongarch/power/Makefile        |  1 +
> >   arch/loongarch/power/hibernate.c     | 58 ++++++++++++++++++++++++
> >   arch/loongarch/power/hibernate_asm.S | 68 +++++++++++++++++++++++++++=
+
> >   7 files changed, 149 insertions(+)
> >   create mode 100644 arch/loongarch/power/hibernate.c
> >   create mode 100644 arch/loongarch/power/hibernate_asm.S
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 0df102401d1d..1943f840e494 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -521,6 +521,9 @@ menu "Power management options"
> >   config ARCH_SUSPEND_POSSIBLE
> >       def_bool y
> >
> > +config ARCH_HIBERNATION_POSSIBLE
> > +     def_bool y
> > +
> >   source "kernel/power/Kconfig"
> >   source "drivers/acpi/Kconfig"
> >
> > diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kerne=
l/asm-offsets.c
> > index bdd88eda9513..4ef494577813 100644
> > --- a/arch/loongarch/kernel/asm-offsets.c
> > +++ b/arch/loongarch/kernel/asm-offsets.c
> > @@ -257,3 +257,15 @@ void output_smpboot_defines(void)
> >       BLANK();
> >   }
> >   #endif
> > +
> > +#ifdef CONFIG_HIBERNATION
> > +void output_pbe_defines(void)
> > +{
> > +     COMMENT(" Linux struct pbe offsets. ");
> > +     OFFSET(PBE_ADDRESS, pbe, address);
> > +     OFFSET(PBE_ORIG_ADDRESS, pbe, orig_address);
> > +     OFFSET(PBE_NEXT, pbe, next);
> > +     DEFINE(PBE_SIZE, sizeof(struct pbe));
> > +     BLANK();
> > +}
> > +#endif
> > diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/rese=
t.c
> > index 8c82021eb2f4..cdf021ff6214 100644
> > --- a/arch/loongarch/kernel/reset.c
> > +++ b/arch/loongarch/kernel/reset.c
> > @@ -15,6 +15,7 @@
> >   #include <acpi/reboot.h>
> >   #include <asm/idle.h>
> >   #include <asm/loongarch.h>
> > +#include <asm/loongson.h>
> >
> >   void (*pm_power_off)(void);
> >   EXPORT_SYMBOL(pm_power_off);
> > @@ -42,6 +43,7 @@ void machine_power_off(void)
> >       preempt_disable();
> >       smp_send_stop();
> >   #endif
> > +     enable_pci_wakeup();
> >       do_kernel_power_off();
> >   #ifdef CONFIG_EFI
> >       efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
> > diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setu=
p.c
> > index 96b6cb5db004..3c8bc250f4e2 100644
> > --- a/arch/loongarch/kernel/setup.c
> > +++ b/arch/loongarch/kernel/setup.c
> > @@ -28,6 +28,7 @@
> >   #include <linux/sizes.h>
> >   #include <linux/device.h>
> >   #include <linux/dma-map-ops.h>
> > +#include <linux/suspend.h>
> >   #include <linux/swiotlb.h>
> >
> >   #include <asm/addrspace.h>
> > @@ -312,6 +313,10 @@ static void __init arch_mem_init(char **cmdline_p)
> >
> >       dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
> >
> > +     /* Reserve for hibernation. */
> > +     register_nosave_region(PFN_DOWN(__pa_symbol(&__nosave_begin)),
> > +                                PFN_UP(__pa_symbol(&__nosave_end)));
> > +
> >       memblock_dump_all();
> >
> >       early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
> > diff --git a/arch/loongarch/power/Makefile b/arch/loongarch/power/Makef=
ile
> > index 6740117decaa..58151d003e40 100644
> > --- a/arch/loongarch/power/Makefile
> > +++ b/arch/loongarch/power/Makefile
> > @@ -1,3 +1,4 @@
> >   obj-y       +=3D platform.o
> >
> >   obj-$(CONFIG_SUSPEND)               +=3D suspend.o suspend_asm.o
> > +obj-$(CONFIG_HIBERNATION)    +=3D hibernate.o hibernate_asm.o
> > diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hi=
bernate.c
> > new file mode 100644
> > index 000000000000..32dae9ef311a
> > --- /dev/null
> > +++ b/arch/loongarch/power/hibernate.c
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <asm/fpu.h>
> > +#include <asm/loongson.h>
> > +#include <asm/sections.h>
> > +#include <asm/tlbflush.h>
> > +
> > +static u64 saved_crmd;
> > +static u64 saved_prmd;
> > +static u64 saved_euen;
> > +static u64 saved_ecfg;
> > +struct pt_regs saved_regs;
> > +
> > +void save_processor_state(void)
> > +{
> > +     saved_crmd =3D csr_read32(LOONGARCH_CSR_CRMD);
> > +     saved_prmd =3D csr_read32(LOONGARCH_CSR_PRMD);
> > +     saved_euen =3D csr_read32(LOONGARCH_CSR_EUEN);
> > +     saved_ecfg =3D csr_read32(LOONGARCH_CSR_ECFG);
> > +
> > +     if (is_fpu_owner())
> > +             save_fp(current);
> > +}
> > +
> > +void restore_processor_state(void)
> > +{
> > +     csr_write32(saved_crmd, LOONGARCH_CSR_CRMD);
> > +     csr_write32(saved_prmd, LOONGARCH_CSR_PRMD);
> > +     csr_write32(saved_euen, LOONGARCH_CSR_EUEN);
> > +     csr_write32(saved_ecfg, LOONGARCH_CSR_ECFG);
> > +
> > +     if (is_fpu_owner())
> > +             restore_fp(current);
> > +}
> > +
> > +int pfn_is_nosave(unsigned long pfn)
> > +{
> I'm surprised that every arch has its own version of pfn_is_nosave().
>
> We can improve it. But it's beyond these patches, just ignore here.
>
>
> > +     unsigned long nosave_begin_pfn =3D PFN_DOWN(__pa(&__nosave_begin)=
);
> > +     unsigned long nosave_end_pfn =3D PFN_UP(__pa(&__nosave_end));
> > +
> > +     return  (pfn >=3D nosave_begin_pfn) && (pfn < nosave_end_pfn);
> > +}
> > +
> > +extern int swsusp_asm_suspend(void);
> > +
> > +int swsusp_arch_suspend(void)
> > +{
> > +     enable_pci_wakeup();
> > +     return swsusp_asm_suspend();
> > +}
> > +
> > +extern int swsusp_asm_resume(void);
> > +
> > +int swsusp_arch_resume(void)
> > +{
> > +     /* Avoid TLB mismatch during and after kernel resume */
> > +     local_flush_tlb_all();
> > +     return swsusp_asm_resume();
> > +}
> > diff --git a/arch/loongarch/power/hibernate_asm.S b/arch/loongarch/powe=
r/hibernate_asm.S
> > new file mode 100644
> > index 000000000000..7894fbd56c85
> > --- /dev/null
> > +++ b/arch/loongarch/power/hibernate_asm.S
> > @@ -0,0 +1,64 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Hibernation support specific for LoongArch
> > + *
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/linkage.h>
> > +#include <asm/asm.h>
> > +#include <asm/asm-offsets.h>
> > +#include <asm/regdef.h>
> > +
> > +.text
> > +SYM_FUNC_START(swsusp_asm_suspend)
> > +     la.pcrel        t0, saved_regs
> > +     PTR_S           ra, t0, PT_R1
> > +     PTR_S           sp, t0, PT_R3
> > +     PTR_S           fp, t0, PT_R22
> > +     PTR_S           tp, t0, PT_R2
> > +     PTR_S           s0, t0, PT_R23
> > +     PTR_S           s1, t0, PT_R24
> > +     PTR_S           s2, t0, PT_R25
> > +     PTR_S           s3, t0, PT_R26
> > +     PTR_S           s4, t0, PT_R27
> > +     PTR_S           s5, t0, PT_R28
> > +     PTR_S           s6, t0, PT_R29
> > +     PTR_S           s7, t0, PT_R30
> > +     PTR_S           s8, t0, PT_R31
> > +     b               swsusp_save
>
> Is needed save and restore PERCPU_BASE_KS, u0 or other KSave registers?
Saving/restoring PERCPU_BASE_KS and u0 seems needed, but I don't know
why it works well without them. :)

Huacai
>
>
> Thanks,
>
> Jinyang
>
>
> > +SYM_FUNC_END(swsusp_asm_suspend)
> > +
> > +SYM_FUNC_START(swsusp_asm_resume)
> > +     la.pcrel        t0, restore_pblist
> > +     PTR_L           t0, t0, 0
> > +0:
> > +     PTR_L           t1, t0, PBE_ADDRESS  /* source */
> > +     PTR_L           t2, t0, PBE_ORIG_ADDRESS /* destination */
> > +     PTR_LI          t3, _PAGE_SIZE
> > +     PTR_ADD         t3, t3, t1
> > +1:
> > +     REG_L           t8, t1, 0
> > +     REG_S           t8, t2, 0
> > +     PTR_ADDI        t1, t1, SZREG
> > +     PTR_ADDI        t2, t2, SZREG
> > +     bne             t1, t3, 1b
> > +     PTR_L           t0, t0, PBE_NEXT
> > +     bnez            t0, 0b
> > +     la.pcrel        t0, saved_regs
> > +     PTR_L           ra, t0, PT_R1
> > +     PTR_L           sp, t0, PT_R3
> > +     PTR_L           fp, t0, PT_R22
> > +     PTR_L           tp, t0, PT_R2
> > +     PTR_L           s0, t0, PT_R23
> > +     PTR_L           s1, t0, PT_R24
> > +     PTR_L           s2, t0, PT_R25
> > +     PTR_L           s3, t0, PT_R26
> > +     PTR_L           s4, t0, PT_R27
> > +     PTR_L           s5, t0, PT_R28
> > +     PTR_L           s6, t0, PT_R29
> > +     PTR_L           s7, t0, PT_R30
> > +     PTR_L           s8, t0, PT_R31
> > +     PTR_LI          a0, 0x0
> > +     jirl            zero, ra, 0
> > +SYM_FUNC_END(swsusp_asm_resume)
>
