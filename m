Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4CC610CD7
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 11:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJ1JNe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 05:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiJ1JNd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 05:13:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526821C5A74
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 02:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 998FA626E1
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 09:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080F7C433D6
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 09:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666948411;
        bh=0IiU0gFpIrPxbGLGSw4EFzCWh4rCKreu4z8w+p38/xo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n16WukkDAIhk3zpTm5kmtyiKJKJNr4ruKmO+IecHu9CpNZX2hZvQ9oHBLzuxn3c7A
         ywaj2ptxOsqAsrWAiz0pXgtoH5zuXYbIuaoDJwue72pTmEXIBzPRovqo+ysDCALgN/
         ++PTz1uhN0EGSKQ3GwR7G/OH66TBU938DfQlNC5bo+jWFI3IH+7KJRDQdCm/+kwobB
         jTAAuhty1OQW+99lWKa+iLX488WBg15Dl4ztNnB89FOEC/ovjKhowR+L+ASlczB03h
         ZLxdmbMFpnebt5YHV2OX4f009nCZE8haypA8a/YDtI71uhQQJ9dBFpSmlA8+Q0LBHX
         vsNinbBY7lPEw==
Received: by mail-ej1-f45.google.com with SMTP id ud5so11543255ejc.4
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 02:13:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf2ceIn3m1ZGaLq589owbJL+DLbN5JQH/Wh8v+IwNV+ne6CN/M5y
        N9C2GyMPI3dgWEiaUvyCHI9MSw7GrZqMj03TDq8=
X-Google-Smtp-Source: AMsMyM4ct6lzs6BYak0w6neGWI+m+ygE9ZQ4N3EzYNe1FGtYLXDA5aMOB4rAFTciH14CJlhNB6yioVYPhigq0T4O4f8=
X-Received: by 2002:a17:906:af97:b0:7ad:a2ef:a522 with SMTP id
 mj23-20020a170906af9700b007ada2efa522mr876446ejb.72.1666948409208; Fri, 28
 Oct 2022 02:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221028023829.4030984-1-chenhuacai@loongson.cn> <a33f0f60-8abc-6b84-f526-d07ae864fcb2@loongson.cn>
In-Reply-To: <a33f0f60-8abc-6b84-f526-d07ae864fcb2@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 28 Oct 2022 17:13:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H54HMMm3pzBEmHyKF_b9u8ZUjeGPcX=Ot9ddkg17AsODg@mail.gmail.com>
Message-ID: <CAAhV-H54HMMm3pzBEmHyKF_b9u8ZUjeGPcX=Ot9ddkg17AsODg@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: Add suspend (ACPI S3) support
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Youling,

On Fri, Oct 28, 2022 at 5:06 PM Youling Tang <tangyouling@loongson.cn> wrote:
>
> Hi, Huacai
>
> On 10/28/2022 10:38 AM, Huacai Chen wrote:
> > Add suspend (Suspend To RAM, aka ACPI S3) support for LoongArch.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/Kconfig                |   5 ++
> >  arch/loongarch/Makefile               |   3 +
> >  arch/loongarch/include/asm/acpi.h     |  10 +++
> >  arch/loongarch/include/asm/bootinfo.h |   1 +
> >  arch/loongarch/include/asm/loongson.h |   3 +
> >  arch/loongarch/include/asm/time.h     |   1 +
> >  arch/loongarch/kernel/acpi.c          |   6 ++
> >  arch/loongarch/kernel/smp.c           |   1 +
> >  arch/loongarch/kernel/time.c          |  11 ++-
> >  arch/loongarch/power/Makefile         |   3 +
> >  arch/loongarch/power/platform.c       |  45 +++++++++++
> >  arch/loongarch/power/suspend.c        |  73 +++++++++++++++++
> >  arch/loongarch/power/suspend_asm.S    | 112 ++++++++++++++++++++++++++
> >  13 files changed, 271 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/loongarch/power/Makefile
> >  create mode 100644 arch/loongarch/power/platform.c
> >  create mode 100644 arch/loongarch/power/suspend.c
> >  create mode 100644 arch/loongarch/power/suspend_asm.S
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index a8dc58e8162a..0df102401d1d 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -57,6 +57,7 @@ config LOONGARCH
> >       select ARCH_WANTS_NO_INSTR
> >       select BUILDTIME_TABLE_SORT
> >       select COMMON_CLK
> > +     select CPU_PM
> >       select EFI
> >       select GENERIC_CLOCKEVENTS
> >       select GENERIC_CMOS_UPDATE
> > @@ -517,6 +518,10 @@ config ARCH_MMAP_RND_BITS_MAX
> >
> >  menu "Power management options"
> >
> > +config ARCH_SUSPEND_POSSIBLE
> > +     def_bool y
> > +
> > +source "kernel/power/Kconfig"
> >  source "drivers/acpi/Kconfig"
> >
> >  endmenu
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index f4cb54d5afd6..a0fc1f9980e3 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -104,6 +104,9 @@ endif
> >  libs-y += arch/loongarch/lib/
> >  libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >
> > +# suspend and hibernation support
> > +drivers-$(CONFIG_PM) += arch/loongarch/power/
> > +
> >  ifeq ($(KBUILD_EXTMOD),)
> >  prepare: vdso_prepare
> >  vdso_prepare: prepare0
> > diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
> > index 825c2519b9d1..9664868b1260 100644
> > --- a/arch/loongarch/include/asm/acpi.h
> > +++ b/arch/loongarch/include/asm/acpi.h
> > @@ -35,4 +35,14 @@ extern struct list_head acpi_wakeup_device_list;
> >
> >  #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
> >
> > +extern int loongarch_acpi_suspend(void);
> > +extern int (*acpi_suspend_lowlevel)(void);
> > +extern void loongarch_suspend_enter(void);
> > +extern void loongarch_wakeup_start(void);
> > +
> > +static inline unsigned long acpi_get_wakeup_address(void)
> > +{
> > +     return (unsigned long)loongarch_wakeup_start;
> > +}
> > +
> >  #endif /* _ASM_LOONGARCH_ACPI_H */
> > diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
> > index ed0910e8b856..0051b526ac6d 100644
> > --- a/arch/loongarch/include/asm/bootinfo.h
> > +++ b/arch/loongarch/include/asm/bootinfo.h
> > @@ -32,6 +32,7 @@ struct loongson_system_configuration {
> >       int cores_per_node;
> >       int cores_per_package;
> >       unsigned long cores_io_master;
> > +     unsigned long suspend_addr;
> >       const char *cpuname;
> >  };
> >
> > diff --git a/arch/loongarch/include/asm/loongson.h b/arch/loongarch/include/asm/loongson.h
> > index 00db93edae1b..12494cffffd1 100644
> > --- a/arch/loongarch/include/asm/loongson.h
> > +++ b/arch/loongarch/include/asm/loongson.h
> > @@ -136,4 +136,7 @@ typedef enum {
> >  #define ls7a_writel(val, addr)       *(volatile unsigned int   *)TO_UNCACHE(addr) = (val)
> >  #define ls7a_writeq(val, addr)       *(volatile unsigned long  *)TO_UNCACHE(addr) = (val)
> >
> > +void enable_gpe_wakeup(void);
> > +void enable_pci_wakeup(void);
> > +
> >  #endif /* __ASM_LOONGSON_H */
> > diff --git a/arch/loongarch/include/asm/time.h b/arch/loongarch/include/asm/time.h
> > index 2eae219301d0..037a2d1b8ff4 100644
> > --- a/arch/loongarch/include/asm/time.h
> > +++ b/arch/loongarch/include/asm/time.h
> > @@ -12,6 +12,7 @@
> >  extern u64 cpu_clock_freq;
> >  extern u64 const_clock_freq;
> >
> > +extern void save_counter(void);
> >  extern void sync_counter(void);
> >
> >  static inline unsigned int calc_const_freq(void)
> > diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> > index 335398482038..982672caf753 100644
> > --- a/arch/loongarch/kernel/acpi.c
> > +++ b/arch/loongarch/kernel/acpi.c
> > @@ -156,6 +156,12 @@ static void __init acpi_process_madt(void)
> >       loongson_sysconf.nr_cpus = num_processors;
> >  }
> >
> > +#ifdef CONFIG_ACPI_SLEEP
> > +int (*acpi_suspend_lowlevel)(void) = loongarch_acpi_suspend;
> > +#else
> > +int (*acpi_suspend_lowlevel)(void);
> > +#endif
> > +
> >  int __init acpi_boot_init(void)
> >  {
> >       /*
> > diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> > index 781a4d4bdddc..6e192a25e134 100644
> > --- a/arch/loongarch/kernel/smp.c
> > +++ b/arch/loongarch/kernel/smp.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/smp.h>
> >  #include <linux/threads.h>
> >  #include <linux/export.h>
> > +#include <linux/syscore_ops.h>
> >  #include <linux/time.h>
> >  #include <linux/tracepoint.h>
> >  #include <linux/sched/hotplug.h>
> > diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
> > index 786735dcc8d6..a6576dea590c 100644
> > --- a/arch/loongarch/kernel/time.c
> > +++ b/arch/loongarch/kernel/time.c
> > @@ -115,12 +115,17 @@ static unsigned long __init get_loops_per_jiffy(void)
> >       return lpj;
> >  }
> >
> > -static long init_timeval;
> > +static long init_offset __nosavedata;
> > +
> > +void save_counter(void)
> > +{
> > +     init_offset = drdtime();
> > +}
> >
> >  void sync_counter(void)
> >  {
> >       /* Ensure counter begin at 0 */
> > -     csr_write64(-init_timeval, LOONGARCH_CSR_CNTC);
> > +     csr_write64(init_offset, LOONGARCH_CSR_CNTC);
> >  }
> >
> >  static int get_timer_irq(void)
> > @@ -219,7 +224,7 @@ void __init time_init(void)
> >       else
> >               const_clock_freq = calc_const_freq();
> >
> > -     init_timeval = drdtime() - csr_read64(LOONGARCH_CSR_CNTC);
> > +     init_offset = -(drdtime() - csr_read64(LOONGARCH_CSR_CNTC));
> >
> >       constant_clockevent_init();
> >       constant_clocksource_init();
> > diff --git a/arch/loongarch/power/Makefile b/arch/loongarch/power/Makefile
> > new file mode 100644
> > index 000000000000..6740117decaa
> > --- /dev/null
> > +++ b/arch/loongarch/power/Makefile
> > @@ -0,0 +1,3 @@
> > +obj-y        += platform.o
> > +
> > +obj-$(CONFIG_SUSPEND)                += suspend.o suspend_asm.o
> > diff --git a/arch/loongarch/power/platform.c b/arch/loongarch/power/platform.c
> > new file mode 100644
> > index 000000000000..675e8792afaf
> > --- /dev/null
> > +++ b/arch/loongarch/power/platform.c
> > @@ -0,0 +1,45 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/acpi.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <asm/bootinfo.h>
> > +#include <asm/setup.h>
> > +
> > +void enable_gpe_wakeup(void)
> > +{
> > +     acpi_enable_all_wakeup_gpes();
> > +}
> > +
> > +void enable_pci_wakeup(void)
> > +{
> > +     acpi_write_bit_register(ACPI_BITREG_PCIEXP_WAKE_STATUS, 1);
> > +
> > +     if (acpi_gbl_FADT.flags & ACPI_FADT_PCI_EXPRESS_WAKE)
> > +             acpi_write_bit_register(ACPI_BITREG_PCIEXP_WAKE_DISABLE, 0);
> > +}
> > +
> > +static int __init loongson3_acpi_suspend_init(void)
> > +{
> > +#ifdef CONFIG_ACPI
> > +     acpi_status status;
> > +     uint64_t suspend_addr = 0;
> > +
> > +     if (acpi_disabled || acpi_gbl_reduced_hardware)
> > +             return 0;
> > +
> > +     acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
> > +     status = acpi_evaluate_integer(NULL, "\\SADR", NULL, &suspend_addr);
> > +     if (ACPI_FAILURE(status) || !suspend_addr) {
> > +             pr_err("ACPI S3 is not support!\n");
> > +             return -1;
> > +     }
> > +     loongson_sysconf.suspend_addr = (u64)phys_to_virt(PHYSADDR(suspend_addr));
> > +#endif
> > +     return 0;
> > +}
> > +
> > +device_initcall(loongson3_acpi_suspend_init);
> > diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspend.c
> > new file mode 100644
> > index 000000000000..b9fa0f9a9277
> > --- /dev/null
> > +++ b/arch/loongarch/power/suspend.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * loongson-specific suspend support
> > + *
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/acpi.h>
> > +#include <linux/pm.h>
> > +#include <linux/suspend.h>
> > +
> > +#include <asm/loongarch.h>
> > +#include <asm/loongson.h>
> > +#include <asm/setup.h>
> > +#include <asm/time.h>
> > +#include <asm/tlbflush.h>
> > +
> > +u64 loongarch_suspend_addr;
> > +
> > +struct saved_registers {
> > +     u32 ecfg;
> > +     u32 euen;
> > +     u64 pgd;
> > +     u64 kpgd;
> > +     u32 pwctl0;
> > +     u32 pwctl1;
> > +};
> > +static struct saved_registers saved_regs;
> > +
> > +static void arch_common_suspend(void)
> > +{
> > +     save_counter();
> > +     saved_regs.pgd = csr_read64(LOONGARCH_CSR_PGDL);
> > +     saved_regs.kpgd = csr_read64(LOONGARCH_CSR_PGDH);
> > +     saved_regs.pwctl0 = csr_read32(LOONGARCH_CSR_PWCTL0);
> > +     saved_regs.pwctl1 = csr_read32(LOONGARCH_CSR_PWCTL1);
> > +     saved_regs.ecfg = csr_read32(LOONGARCH_CSR_ECFG);
> > +     saved_regs.euen = csr_read32(LOONGARCH_CSR_EUEN);
> > +
> > +     loongarch_suspend_addr = loongson_sysconf.suspend_addr;
> > +}
> > +
> > +static void arch_common_resume(void)
> > +{
> > +     sync_counter();
> > +     local_flush_tlb_all();
> > +     csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
> > +     csr_write64(eentry, LOONGARCH_CSR_EENTRY);
> > +     csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
> > +     csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
> > +
> > +     csr_write64(saved_regs.pgd, LOONGARCH_CSR_PGDL);
> > +     csr_write64(saved_regs.kpgd, LOONGARCH_CSR_PGDH);
> > +     csr_write32(saved_regs.pwctl0, LOONGARCH_CSR_PWCTL0);
> > +     csr_write32(saved_regs.pwctl1, LOONGARCH_CSR_PWCTL1);
> > +     csr_write32(saved_regs.ecfg, LOONGARCH_CSR_ECFG);
> > +     csr_write32(saved_regs.euen, LOONGARCH_CSR_EUEN);
> > +}
> > +
> > +int loongarch_acpi_suspend(void)
> > +{
> > +     enable_gpe_wakeup();
> > +     enable_pci_wakeup();
> > +
> > +     arch_common_suspend();
> > +
> > +     /* processor specific suspend */
> > +     loongarch_suspend_enter();
> > +
> > +     arch_common_resume();
> > +
> > +     return 0;
> > +}
> > diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
> > new file mode 100644
> > index 000000000000..ff52c3aa09d9
> > --- /dev/null
> > +++ b/arch/loongarch/power/suspend_asm.S
> > @@ -0,0 +1,108 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Sleep helper for Loongson-3 sleep mode.
> > + *
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <asm/asm.h>
> > +#include <asm/asmmacro.h>
> > +#include <asm/addrspace.h>
> > +#include <asm/loongarch.h>
> > +#include <asm/stackframe.h>
> > +
> > +     .text
> > +     .align  5
> > +
> > +/* preparatory stuff */
> > +.macro       SETUP_SLEEP
> > +     addi.d          sp, sp, -PT_SIZE
> > +     st.d            $r1, sp, PT_R1
> > +     st.d            $r2, sp, PT_R2
> > +     st.d            $r3, sp, PT_R3
> > +     st.d            $r4, sp, PT_R4
> > +     st.d            $r5, sp, PT_R5
> > +     st.d            $r6, sp, PT_R6
> > +     st.d            $r7, sp, PT_R7
> > +     st.d            $r8, sp, PT_R8
> > +     st.d            $r9, sp, PT_R9
> > +     st.d            $r10, sp, PT_R10
> > +     st.d            $r11, sp, PT_R11
> > +     st.d            $r20, sp, PT_R20
> > +     st.d            $r21, sp, PT_R21
> > +     st.d            $r22, sp, PT_R22
> > +     st.d            $r23, sp, PT_R23
> > +     st.d            $r24, sp, PT_R24
> > +     st.d            $r25, sp, PT_R25
> > +     st.d            $r26, sp, PT_R26
> > +     st.d            $r27, sp, PT_R27
> > +     st.d            $r28, sp, PT_R28
> > +     st.d            $r29, sp, PT_R29
> > +     st.d            $r30, sp, PT_R30
> > +     st.d            $r31, sp, PT_R31
> > +
> > +     la.pcrel        t0, acpi_saved_sp
> > +     st.d            sp, t0, 0
> > +.endm
> > +
> > +/* Sleep code for Loongson-3 */
> > +SYM_CODE_START(loongarch_suspend_enter)
> > +     SETUP_SLEEP
> > +     bl              __flush_cache_all
> > +
> > +     /* Pass RA and SP to BIOS */
> > +     addi.d          a1, sp, 0
> > +     la.pcrel        a0, loongarch_wakeup_start
> > +     la.pcrel        t0, loongarch_suspend_addr
> > +     ld.d            t0, t0, 0 /* Call BIOS's STR sleep routine */
> > +     jr              t0
> > +     nop
> > +SYM_CODE_END(loongarch_suspend_enter)
> > +
> > +.macro SETUP_WAKEUP
> > +     ld.d            $r1, sp, PT_R1
> > +     ld.d            $r2, sp, PT_R2
> > +     ld.d            $r3, sp, PT_R3
> > +     ld.d            $r4, sp, PT_R4
> > +     ld.d            $r5, sp, PT_R5
> > +     ld.d            $r6, sp, PT_R6
> > +     ld.d            $r7, sp, PT_R7
> > +     ld.d            $r8, sp, PT_R8
> > +     ld.d            $r9, sp, PT_R9
> > +     ld.d            $r10, sp, PT_R10
> > +     ld.d            $r11, sp, PT_R11
> > +     ld.d            $r20, sp, PT_R20
> > +     ld.d            $r21, sp, PT_R21
> > +     ld.d            $r22, sp, PT_R22
> > +     ld.d            $r23, sp, PT_R23
> > +     ld.d            $r24, sp, PT_R24
> > +     ld.d            $r25, sp, PT_R25
> > +     ld.d            $r26, sp, PT_R26
> > +     ld.d            $r27, sp, PT_R27
> > +     ld.d            $r28, sp, PT_R28
> > +     ld.d            $r29, sp, PT_R29
> > +     ld.d            $r30, sp, PT_R30
> > +     ld.d            $r31, sp, PT_R31
> > +.endm
> > +
> > +     /* This is where we return upon wakeup.
> > +      * Reload all of the registers and return.
> > +      */
> > +     .align 12
> > +
> > +SYM_CODE_START(loongarch_wakeup_start)
> > +     li.d            t0, CSR_DMW0_INIT       # UC, PLV0
> > +     csrwr           t0, LOONGARCH_CSR_DMWIN0
> > +     li.d            t0, CSR_DMW1_INIT       # CA, PLV0
> > +     csrwr           t0, LOONGARCH_CSR_DMWIN1
> > +
> > +     la.abs          t0, 0f
> > +     jr              t0
>
> We should try to avoid using la.abs in order to make it easier to
> implement KASLR feature in the future.
> If the purpose here is just to get the link address of the current
> location, we would like to use the following method (and remove the
> "0:" label):
>
> li.d    t0, CACHE_BASE
> pcaddi  t0, 0
> or      t0, t0, t1
> jirl    zero, t0, 0xc
But this cannot work for the TLB-mapped kernel. :(

Huacai

>
> Thanks,
> Youling
>
> > +0:
> > +     la.pcrel        t0, acpi_saved_sp
> > +     ld.d            sp, t0, 0
> > +     SETUP_WAKEUP
> > +     addi.d          sp, sp, PT_SIZE
> > +     jr              ra
> > +SYM_CODE_END(loongarch_wakeup_start)
> >
>
