Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6E6120D8
	for <lists+linux-pm@lfdr.de>; Sat, 29 Oct 2022 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ2HIL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Oct 2022 03:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJ2HIK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Oct 2022 03:08:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950FC8949
        for <linux-pm@vger.kernel.org>; Sat, 29 Oct 2022 00:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53111B82EB4
        for <linux-pm@vger.kernel.org>; Sat, 29 Oct 2022 07:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2354C433D6
        for <linux-pm@vger.kernel.org>; Sat, 29 Oct 2022 07:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667027285;
        bh=jnlxe+K3Hah66Yfp2kuDJ4OKa8t68snaUpq/67Vkfpw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t1Y6ZTHBVdjYEoZk57SjZUP94ZxS1acjzV0B3OPSINkkRUDAF46i/aXh4mV9viA7x
         RtnyaZD+1MHuMFUMxhL9MKFv1nXttSrF+aGnPZk0x+/agJKdtVGYYLptrpU5f9XXP5
         9I74UgoZ77pecqoGS8XO5Umvmt5w0ZScSkwLIhpQOq5YWg593s8/jmM4++km7JcTFz
         PDQdkvIJmQmHzHIEcGigqmN1foSVM+EdbZMkRHwtJD3eRanFj5SKMPObmlVP27HxKz
         wMzAHADtinP05miod2DX6n5tEhE259uaFseNZPvzHbUNdlphdWZQM2LkvFmB4E79z8
         8ewnyax+WK9gA==
Received: by mail-ej1-f46.google.com with SMTP id y14so17800682ejd.9
        for <linux-pm@vger.kernel.org>; Sat, 29 Oct 2022 00:08:05 -0700 (PDT)
X-Gm-Message-State: ACrzQf2LVw1Pp1c9f9Y88h7gG+PBZSd3iUtlHpeoUIOVqo2xcVQr+RjY
        o0MLZwKo01NwpgEQqdEpmXN31DygveOlh638mSM=
X-Google-Smtp-Source: AMsMyM4ZLA6TA1EK7vhdvgXL94r+a8vNgWOOyxkOjs9Z22IEgdxkcKtBhHtMhAr8zEym1tHv1mARlV5rQRtA7oOEC4Y=
X-Received: by 2002:a17:907:6d06:b0:7ad:b45c:dcab with SMTP id
 sa6-20020a1709076d0600b007adb45cdcabmr866659ejc.72.1667027283778; Sat, 29 Oct
 2022 00:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221028023829.4030984-1-chenhuacai@loongson.cn>
 <9a866ff3-63a9-09fc-00cc-1a156d258202@loongson.cn> <CAAhV-H7J_2_jDbqor6dRLnV65mNYSrzSrkOA-D_1pUhQSdTaXg@mail.gmail.com>
 <90b19909-8261-7783-bb43-fff00f8a0bb1@loongson.cn> <CAAhV-H4F-tyAWOH4eg=H8a4PD=UQtEAwJ0dpVTHUsqfu_BWwkg@mail.gmail.com>
 <ce478fff-fdd3-cdff-6afb-90d72321415d@loongson.cn>
In-Reply-To: <ce478fff-fdd3-cdff-6afb-90d72321415d@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 29 Oct 2022 15:07:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6fXsQt5+yi9bBsRWM_pCRzLyhMb470hoQu9ccHZq14vg@mail.gmail.com>
Message-ID: <CAAhV-H6fXsQt5+yi9bBsRWM_pCRzLyhMb470hoQu9ccHZq14vg@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: Add suspend (ACPI S3) support
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

On Fri, Oct 28, 2022 at 6:13 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> On 2022/10/28 =E4=B8=8B=E5=8D=885:44, Huacai Chen wrote:
>
> > Hi, Jinyang,
> >
> > On Fri, Oct 28, 2022 at 5:37 PM Jinyang He <hejinyang@loongson.cn> wrot=
e:
> >> Hi, Huacai,
> >>
> >>
> >> On 2022/10/28 =E4=B8=8B=E5=8D=885:00, Huacai Chen wrote:
> >>
> >>>    Hi, Jinyang,
> >>>
> >>> On Fri, Oct 28, 2022 at 3:23 PM Jinyang He <hejinyang@loongson.cn> wr=
ote:
> >>>> On 2022/10/28 =E4=B8=8A=E5=8D=8810:38, Huacai Chen wrote:
> >>>>
> >>>>> Add suspend (Suspend To RAM, aka ACPI S3) support for LoongArch.
> >>>>>
> >>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>>>> ---
> >>>>>     arch/loongarch/Kconfig                |   5 ++
> >>>>>     arch/loongarch/Makefile               |   3 +
> >>>>>     arch/loongarch/include/asm/acpi.h     |  10 +++
> >>>>>     arch/loongarch/include/asm/bootinfo.h |   1 +
> >>>>>     arch/loongarch/include/asm/loongson.h |   3 +
> >>>>>     arch/loongarch/include/asm/time.h     |   1 +
> >>>>>     arch/loongarch/kernel/acpi.c          |   6 ++
> >>>>>     arch/loongarch/kernel/smp.c           |   1 +
> >>>>>     arch/loongarch/kernel/time.c          |  11 ++-
> >>>>>     arch/loongarch/power/Makefile         |   3 +
> >>>>>     arch/loongarch/power/platform.c       |  45 +++++++++++
> >>>>>     arch/loongarch/power/suspend.c        |  73 +++++++++++++++++
> >>>>>     arch/loongarch/power/suspend_asm.S    | 112 +++++++++++++++++++=
+++++++
> >>>>>     13 files changed, 271 insertions(+), 3 deletions(-)
> >>>>>     create mode 100644 arch/loongarch/power/Makefile
> >>>>>     create mode 100644 arch/loongarch/power/platform.c
> >>>>>     create mode 100644 arch/loongarch/power/suspend.c
> >>>>>     create mode 100644 arch/loongarch/power/suspend_asm.S
> >>>>>
> >>>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >>>>> index a8dc58e8162a..0df102401d1d 100644
> >>>>> --- a/arch/loongarch/Kconfig
> >>>>> +++ b/arch/loongarch/Kconfig
> >>>>> @@ -57,6 +57,7 @@ config LOONGARCH
> >>>>>         select ARCH_WANTS_NO_INSTR
> >>>>>         select BUILDTIME_TABLE_SORT
> >>>>>         select COMMON_CLK
> >>>>> +     select CPU_PM
> >>>>>         select EFI
> >>>>>         select GENERIC_CLOCKEVENTS
> >>>>>         select GENERIC_CMOS_UPDATE
> >>>>> @@ -517,6 +518,10 @@ config ARCH_MMAP_RND_BITS_MAX
> >>>>>
> >>>>>     menu "Power management options"
> >>>>>
> >>>>> +config ARCH_SUSPEND_POSSIBLE
> >>>>> +     def_bool y
> >>>>> +
> >>>>> +source "kernel/power/Kconfig"
> >>>>>     source "drivers/acpi/Kconfig"
> >>>>>
> >>>>>     endmenu
> >>>>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> >>>>> index f4cb54d5afd6..a0fc1f9980e3 100644
> >>>>> --- a/arch/loongarch/Makefile
> >>>>> +++ b/arch/loongarch/Makefile
> >>>>> @@ -104,6 +104,9 @@ endif
> >>>>>     libs-y +=3D arch/loongarch/lib/
> >>>>>     libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/li=
bstub/lib.a
> >>>>>
> >>>>> +# suspend and hibernation support
> >>>>> +drivers-$(CONFIG_PM) +=3D arch/loongarch/power/
> >>>>> +
> >>>>>     ifeq ($(KBUILD_EXTMOD),)
> >>>>>     prepare: vdso_prepare
> >>>>>     vdso_prepare: prepare0
> >>>>> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/inc=
lude/asm/acpi.h
> >>>>> index 825c2519b9d1..9664868b1260 100644
> >>>>> --- a/arch/loongarch/include/asm/acpi.h
> >>>>> +++ b/arch/loongarch/include/asm/acpi.h
> >>>>> @@ -35,4 +35,14 @@ extern struct list_head acpi_wakeup_device_list;
> >>>>>
> >>>>>     #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
> >>>>>
> >>>>> +extern int loongarch_acpi_suspend(void);
> >>>>> +extern int (*acpi_suspend_lowlevel)(void);
> >>>>> +extern void loongarch_suspend_enter(void);
> >>>>> +extern void loongarch_wakeup_start(void);
> >>>>> +
> >>>>> +static inline unsigned long acpi_get_wakeup_address(void)
> >>>>> +{
> >>>>> +     return (unsigned long)loongarch_wakeup_start;
> >>>>> +}
> >>>>> +
> >>>>>     #endif /* _ASM_LOONGARCH_ACPI_H */
> >>>>> diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch=
/include/asm/bootinfo.h
> >>>>> index ed0910e8b856..0051b526ac6d 100644
> >>>>> --- a/arch/loongarch/include/asm/bootinfo.h
> >>>>> +++ b/arch/loongarch/include/asm/bootinfo.h
> >>>>> @@ -32,6 +32,7 @@ struct loongson_system_configuration {
> >>>>>         int cores_per_node;
> >>>>>         int cores_per_package;
> >>>>>         unsigned long cores_io_master;
> >>>>> +     unsigned long suspend_addr;
> >>>>>         const char *cpuname;
> >>>>>     };
> >>>>>
> >>>>> diff --git a/arch/loongarch/include/asm/loongson.h b/arch/loongarch=
/include/asm/loongson.h
> >>>>> index 00db93edae1b..12494cffffd1 100644
> >>>>> --- a/arch/loongarch/include/asm/loongson.h
> >>>>> +++ b/arch/loongarch/include/asm/loongson.h
> >>>>> @@ -136,4 +136,7 @@ typedef enum {
> >>>>>     #define ls7a_writel(val, addr)      *(volatile unsigned int   *=
)TO_UNCACHE(addr) =3D (val)
> >>>>>     #define ls7a_writeq(val, addr)      *(volatile unsigned long  *=
)TO_UNCACHE(addr) =3D (val)
> >>>>>
> >>>>> +void enable_gpe_wakeup(void);
> >>>>> +void enable_pci_wakeup(void);
> >>>>> +
> >>>>>     #endif /* __ASM_LOONGSON_H */
> >>>>> diff --git a/arch/loongarch/include/asm/time.h b/arch/loongarch/inc=
lude/asm/time.h
> >>>>> index 2eae219301d0..037a2d1b8ff4 100644
> >>>>> --- a/arch/loongarch/include/asm/time.h
> >>>>> +++ b/arch/loongarch/include/asm/time.h
> >>>>> @@ -12,6 +12,7 @@
> >>>>>     extern u64 cpu_clock_freq;
> >>>>>     extern u64 const_clock_freq;
> >>>>>
> >>>>> +extern void save_counter(void);
> >>>>>     extern void sync_counter(void);
> >>>>>
> >>>>>     static inline unsigned int calc_const_freq(void)
> >>>>> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/a=
cpi.c
> >>>>> index 335398482038..982672caf753 100644
> >>>>> --- a/arch/loongarch/kernel/acpi.c
> >>>>> +++ b/arch/loongarch/kernel/acpi.c
> >>>>> @@ -156,6 +156,12 @@ static void __init acpi_process_madt(void)
> >>>>>         loongson_sysconf.nr_cpus =3D num_processors;
> >>>>>     }
> >>>>>
> >>>>> +#ifdef CONFIG_ACPI_SLEEP
> >>>>> +int (*acpi_suspend_lowlevel)(void) =3D loongarch_acpi_suspend;
> >>>>> +#else
> >>>>> +int (*acpi_suspend_lowlevel)(void);
> >>>>> +#endif
> >>>>> +
> >>>>>     int __init acpi_boot_init(void)
> >>>>>     {
> >>>>>         /*
> >>>>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/sm=
p.c
> >>>>> index 781a4d4bdddc..6e192a25e134 100644
> >>>>> --- a/arch/loongarch/kernel/smp.c
> >>>>> +++ b/arch/loongarch/kernel/smp.c
> >>>>> @@ -16,6 +16,7 @@
> >>>>>     #include <linux/smp.h>
> >>>>>     #include <linux/threads.h>
> >>>>>     #include <linux/export.h>
> >>>>> +#include <linux/syscore_ops.h>
> >>>>>     #include <linux/time.h>
> >>>>>     #include <linux/tracepoint.h>
> >>>>>     #include <linux/sched/hotplug.h>
> >>>>> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/t=
ime.c
> >>>>> index 786735dcc8d6..a6576dea590c 100644
> >>>>> --- a/arch/loongarch/kernel/time.c
> >>>>> +++ b/arch/loongarch/kernel/time.c
> >>>>> @@ -115,12 +115,17 @@ static unsigned long __init get_loops_per_jif=
fy(void)
> >>>>>         return lpj;
> >>>>>     }
> >>>>>
> >>>>> -static long init_timeval;
> >>>>> +static long init_offset __nosavedata;
> >>>>> +
> >>>>> +void save_counter(void)
> >>>>> +{
> >>>>> +     init_offset =3D drdtime();
> >>>>> +}
> >>>>>
> >>>>>     void sync_counter(void)
> >>>>>     {
> >>>>>         /* Ensure counter begin at 0 */
> >>>>> -     csr_write64(-init_timeval, LOONGARCH_CSR_CNTC);
> >>>>> +     csr_write64(init_offset, LOONGARCH_CSR_CNTC);
> >>>>>     }
> >>>>>
> >>>>>     static int get_timer_irq(void)
> >>>>> @@ -219,7 +224,7 @@ void __init time_init(void)
> >>>>>         else
> >>>>>                 const_clock_freq =3D calc_const_freq();
> >>>>>
> >>>>> -     init_timeval =3D drdtime() - csr_read64(LOONGARCH_CSR_CNTC);
> >>>>> +     init_offset =3D -(drdtime() - csr_read64(LOONGARCH_CSR_CNTC))=
;
> >>>>>
> >>>>>         constant_clockevent_init();
> >>>>>         constant_clocksource_init();
> >>>>> diff --git a/arch/loongarch/power/Makefile b/arch/loongarch/power/M=
akefile
> >>>>> new file mode 100644
> >>>>> index 000000000000..6740117decaa
> >>>>> --- /dev/null
> >>>>> +++ b/arch/loongarch/power/Makefile
> >>>>> @@ -0,0 +1,3 @@
> >>>>> +obj-y        +=3D platform.o
> >>>>> +
> >>>>> +obj-$(CONFIG_SUSPEND)                +=3D suspend.o suspend_asm.o
> >>>>> diff --git a/arch/loongarch/power/platform.c b/arch/loongarch/power=
/platform.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..675e8792afaf
> >>>>> --- /dev/null
> >>>>> +++ b/arch/loongarch/power/platform.c
> >>>>> @@ -0,0 +1,45 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>> +/*
> >>>>> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> >>>>> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> >>>>> + */
> >>>>> +#include <linux/acpi.h>
> >>>>> +#include <linux/platform_device.h>
> >>>>> +
> >>>>> +#include <asm/bootinfo.h>
> >>>>> +#include <asm/setup.h>
> >>>>> +
> >>>>> +void enable_gpe_wakeup(void)
> >>>>> +{
> >>>>> +     acpi_enable_all_wakeup_gpes();
> >>>>> +}
> >>>>> +
> >>>>> +void enable_pci_wakeup(void)
> >>>>> +{
> >>>>> +     acpi_write_bit_register(ACPI_BITREG_PCIEXP_WAKE_STATUS, 1);
> >>>>> +
> >>>>> +     if (acpi_gbl_FADT.flags & ACPI_FADT_PCI_EXPRESS_WAKE)
> >>>>> +             acpi_write_bit_register(ACPI_BITREG_PCIEXP_WAKE_DISAB=
LE, 0);
> >>>>> +}
> >>>>> +
> >>>>> +static int __init loongson3_acpi_suspend_init(void)
> >>>>> +{
> >>>>> +#ifdef CONFIG_ACPI
> >>>>> +     acpi_status status;
> >>>>> +     uint64_t suspend_addr =3D 0;
> >>>>> +
> >>>>> +     if (acpi_disabled || acpi_gbl_reduced_hardware)
> >>>>> +             return 0;
> >>>>> +
> >>>>> +     acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
> >>>>> +     status =3D acpi_evaluate_integer(NULL, "\\SADR", NULL, &suspe=
nd_addr);
> >>>>> +     if (ACPI_FAILURE(status) || !suspend_addr) {
> >>>>> +             pr_err("ACPI S3 is not support!\n");
> >>>>> +             return -1;
> >>>>> +     }
> >>>>> +     loongson_sysconf.suspend_addr =3D (u64)phys_to_virt(PHYSADDR(=
suspend_addr));
> >>>>> +#endif
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +device_initcall(loongson3_acpi_suspend_init);
> >>>>> diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/=
suspend.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..b9fa0f9a9277
> >>>>> --- /dev/null
> >>>>> +++ b/arch/loongarch/power/suspend.c
> >>>>> @@ -0,0 +1,73 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>> +/*
> >>>>> + * loongson-specific suspend support
> >>>>> + *
> >>>>> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> >>>>> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> >>>>> + */
> >>>>> +#include <linux/acpi.h>
> >>>>> +#include <linux/pm.h>
> >>>>> +#include <linux/suspend.h>
> >>>>> +
> >>>>> +#include <asm/loongarch.h>
> >>>>> +#include <asm/loongson.h>
> >>>>> +#include <asm/setup.h>
> >>>>> +#include <asm/time.h>
> >>>>> +#include <asm/tlbflush.h>
> >>>>> +
> >>>>> +u64 loongarch_suspend_addr;
> >>>>> +
> >>>>> +struct saved_registers {
> >>>>> +     u32 ecfg;
> >>>>> +     u32 euen;
> >>>>> +     u64 pgd;
> >>>>> +     u64 kpgd;
> >>>>> +     u32 pwctl0;
> >>>>> +     u32 pwctl1;
> >>>>> +};
> >>>>> +static struct saved_registers saved_regs;
> >>>>> +
> >>>>> +static void arch_common_suspend(void)
> >>>>> +{
> >>>>> +     save_counter();
> >>>>> +     saved_regs.pgd =3D csr_read64(LOONGARCH_CSR_PGDL);
> >>>>> +     saved_regs.kpgd =3D csr_read64(LOONGARCH_CSR_PGDH);
> >>>>> +     saved_regs.pwctl0 =3D csr_read32(LOONGARCH_CSR_PWCTL0);
> >>>>> +     saved_regs.pwctl1 =3D csr_read32(LOONGARCH_CSR_PWCTL1);
> >>>>> +     saved_regs.ecfg =3D csr_read32(LOONGARCH_CSR_ECFG);
> >>>>> +     saved_regs.euen =3D csr_read32(LOONGARCH_CSR_EUEN);
> >>>>> +
> >>>>> +     loongarch_suspend_addr =3D loongson_sysconf.suspend_addr;
> >>>>> +}
> >>>>> +
> >>>>> +static void arch_common_resume(void)
> >>>>> +{
> >>>>> +     sync_counter();
> >>>>> +     local_flush_tlb_all();
> >>>>> +     csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
> >>>>> +     csr_write64(eentry, LOONGARCH_CSR_EENTRY);
> >>>>> +     csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
> >>>>> +     csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
> >>>>> +
> >>>>> +     csr_write64(saved_regs.pgd, LOONGARCH_CSR_PGDL);
> >>>>> +     csr_write64(saved_regs.kpgd, LOONGARCH_CSR_PGDH);
> >>>>> +     csr_write32(saved_regs.pwctl0, LOONGARCH_CSR_PWCTL0);
> >>>>> +     csr_write32(saved_regs.pwctl1, LOONGARCH_CSR_PWCTL1);
> >>>>> +     csr_write32(saved_regs.ecfg, LOONGARCH_CSR_ECFG);
> >>>>> +     csr_write32(saved_regs.euen, LOONGARCH_CSR_EUEN);
> >>>>> +}
> >>>>> +
> >>>>> +int loongarch_acpi_suspend(void)
> >>>>> +{
> >>>>> +     enable_gpe_wakeup();
> >>>>> +     enable_pci_wakeup();
> >>>>> +
> >>>>> +     arch_common_suspend();
> >>>>> +
> >>>>> +     /* processor specific suspend */
> >>>>> +     loongarch_suspend_enter();
> >>>>> +
> >>>>> +     arch_common_resume();
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/po=
wer/suspend_asm.S
> >>>>> new file mode 100644
> >>>>> index 000000000000..ff52c3aa09d9
> >>>>> --- /dev/null
> >>>>> +++ b/arch/loongarch/power/suspend_asm.S
> >>>>> @@ -0,0 +1,108 @@
> >>>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>>> +/*
> >>>>> + * Sleep helper for Loongson-3 sleep mode.
> >>>>> + *
> >>>>> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> >>>>> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> >>>>> + */
> >>>>> +
> >>>>> +#include <asm/asm.h>
> >>>>> +#include <asm/asmmacro.h>
> >>>>> +#include <asm/addrspace.h>
> >>>>> +#include <asm/loongarch.h>
> >>>>> +#include <asm/stackframe.h>
> >>>>> +
> >>>>> +     .text
> >>>>> +     .align  5
> >>>>> +
> >>>>> +/* preparatory stuff */
> >>>>> +.macro       SETUP_SLEEP
> >>>>> +     addi.d          sp, sp, -PT_SIZE
> >>>>> +     st.d            $r1, sp, PT_R1
> >>>>> +     st.d            $r2, sp, PT_R2
> >>>>> +     st.d            $r3, sp, PT_R3
> >>>>> +     st.d            $r4, sp, PT_R4
> >>>>> +     st.d            $r5, sp, PT_R5
> >>>>> +     st.d            $r6, sp, PT_R6
> >>>>> +     st.d            $r7, sp, PT_R7
> >>>>> +     st.d            $r8, sp, PT_R8
> >>>>> +     st.d            $r9, sp, PT_R9
> >>>>> +     st.d            $r10, sp, PT_R10
> >>>>> +     st.d            $r11, sp, PT_R11
> >>>>> +     st.d            $r20, sp, PT_R20
> >>>>> +     st.d            $r21, sp, PT_R21
> >>>>> +     st.d            $r22, sp, PT_R22
> >>>>> +     st.d            $r23, sp, PT_R23
> >>>>> +     st.d            $r24, sp, PT_R24
> >>>>> +     st.d            $r25, sp, PT_R25
> >>>>> +     st.d            $r26, sp, PT_R26
> >>>>> +     st.d            $r27, sp, PT_R27
> >>>>> +     st.d            $r28, sp, PT_R28
> >>>>> +     st.d            $r29, sp, PT_R29
> >>>>> +     st.d            $r30, sp, PT_R30
> >>>>> +     st.d            $r31, sp, PT_R31
> >>>>> +
> >>>>> +     la.pcrel        t0, acpi_saved_sp
> >>>>> +     st.d            sp, t0, 0
> >>>>> +.endm
> >>>>> +
> >>>>> +/* Sleep code for Loongson-3 */
> >>>>> +SYM_CODE_START(loongarch_suspend_enter)
> >>>>> +     SETUP_SLEEP
> >>>>> +     bl              __flush_cache_all
> >>>>> +
> >>>>> +     /* Pass RA and SP to BIOS */
> >>>>> +     addi.d          a1, sp, 0
> >>>>> +     la.pcrel        a0, loongarch_wakeup_start
> >>>>> +     la.pcrel        t0, loongarch_suspend_addr
> >>>>> +     ld.d            t0, t0, 0 /* Call BIOS's STR sleep routine */
> >>>>> +     jr              t0
> >>>>> +     nop
> >>>> Hi, Huacai,
> >>>>
> >>>> For loongarch_suspend_enter() and loongarch_wakeup_start(), it is be=
tter to
> >>>> make them be more like C-style, that means it could obey LoongArch-p=
sABI.
> >>>> Just alloc limited stack and store the ra, s* and fp registers.
> >>>> Additionally,
> >>>> the tp and the u0 should be saved, too. Combine
> >>>> loongarch_suspend_enter() and
> >>>> loongarch_suspend_enter() to one function and using 'jirl a0, t0, 0'=
 to link
> >>>> them which indicate the control flow will return. These works make t=
he
> >>>> control
> >>>> flow clarity. Finally use SYM_FUNC_START/END declare the new functio=
n.
> >>> Thank you for your comments, but you may misunderstand something abou=
t S3.
> >>> 1,  S3 sleep means come from kernel to BIOS, and S3 wakeup means come
> >>> from BIOS to kernel (it has a POST progress, all register context
> >>> lost). This is very different from a function call. When exception
> >>> handling we need to save all and restore all, S3 wakeup should do eve=
n
> >>> more.
> >> It's true I'm not familiar with S3 (almost the hardware working). It i=
s
> >> special code control that S3 sleep from kernel to BIOS and wakeup
> >> from BIOS to kernel. But loongarch_acpi_suspend() calls
> >> loongarch_suspend_enter()
> >> and the latter returns by loongarch_wakeup_start().
> >> (If there is other way to restore it, I'm seriously wrong.) The key
> >> point is the position after calling loongarch_suspend_enter() and
> >> before calling arch_common_resume(). We just keep this control flow
> >> is normally at this point. So, due to LoongArch-psABI, after calling
> >> loongarch_suspend_enter(), t* and a* can be changed. Actually, we
> >> just should take care of tp and u0.
> > Obey psABI needs caller and callee to know each other, this is not the
> > case for S3, kernel doesn't assume anything about BIOS.
>
> +int loongarch_acpi_suspend(void)
> +{
> +     enable_gpe_wakeup();
> +     enable_pci_wakeup();
> +
> +     arch_common_suspend();
> +
> +     /* processor specific suspend */
> +     loongarch_suspend_enter();
> +
>
> I'm not sure what register state is broken will cause error here.
> While there may be ipa-ra optimizations, they are not in the same
> compilation unit. It obey Procedure Calling Convention. t* and a*
> is free, and others regs should be restored before here.
>
> +     arch_common_resume();
> +
> +     return 0;
> +}
>
> >>
> >>> 2, a0 (wakeup pc) and a1 (wakeup sp) are information passed to BIOS,
> >>> BIOS may store it in some place similar to NVRAM, it does not
> >>> naturally exist in the register after power up.
> >>> 3, What means combine  loongarch_suspend_enter() and loongarch_suspen=
d_enter()?
> >> Just mistake, combine loongarch_suspend_enter and loongarch_wakeup_sta=
rt,
> > They cannot be combined, you also cannot combine swsusp_asm_suspend
> > and swsusp_asm_resume for S4, right?
>
> S4 is not needed. IMO S4 is like try catch, while S3 is like syscall.
> User use syscall and known a* and t* will be destoryed, and kernel is
> not needed save all regs unless like process copy.
>
> S4 is like try catch, we save state like setjmp, and the control flow
> will still go until do leave(). And then restart kernel like get signal,
> the time when initcall call restore like longjmp.
Yes, you are right, I got it, thanks.

Huacai
>
>
> >> like follows,
> >>
> >> +     /* Pass RA and SP to BIOS */
> >> +     addi.d          a1, sp, 0
> >> +     la.pcrel        a0, loongarch_wakeup_start
> >> +     la.pcrel        t0, loongarch_suspend_addr
> >> +     ld.d            t0, t0, 0 /* Call BIOS's STR sleep routine */
> >> +     jr              t0
> >> +     nop
> >> +SYM_CODE_END(loongarch_suspend_enter)
> >> +
> >> +     .align 12
> >> +
> >> +SYM_CODE_START(loongarch_wakeup_start)
> >> +     li.d            t0, CSR_DMW0_INIT       # UC, PLV0
> >> +     csrwr           t0, LOONGARCH_CSR_DMWIN0
> >> +     li.d            t0, CSR_DMW1_INIT       # CA, PLV0
> >> +     csrwr           t0, LOONGARCH_CSR_DMWIN1
> >>
> >> --------change it to-------------->
> >>
> >> .align 12
> >> SYM_FUNC_START(loongarch_suspend_enter)
> >> ...
> >> +     /* Pass RA and SP to BIOS */
> >> +     addi.d          a1, sp, 0
> >> +     la.pcrel        t0, loongarch_suspend_addr
> >> +     ld.d            t0, t0, 0 /* Call BIOS's STR sleep routine */
> >> *jirl a0, t0, 0*
> >> +     li.d            t0, CSR_DMW0_INIT       # UC, PLV0
> >> +     csrwr           t0, LOONGARCH_CSR_DMWIN0
> >> +     li.d            t0, CSR_DMW1_INIT       # CA, PLV0
> >> +     csrwr           t0, LOONGARCH_CSR_DMWIN1
> >> ...
> >>
> >>> Huacai
> >>>
> >>>> Thanks,
> >>>>
> >>>> Jinyang
> >>>>
> >>>>
> >>>>> +SYM_CODE_END(loongarch_suspend_enter)
> >>>>> +
> >>>>> +.macro SETUP_WAKEUP
> >>>>> +     ld.d            $r1, sp, PT_R1
> >>>>> +     ld.d            $r2, sp, PT_R2
> >>>>> +     ld.d            $r3, sp, PT_R3
> >>>>> +     ld.d            $r4, sp, PT_R4
> >>>>> +     ld.d            $r5, sp, PT_R5
> >>>>> +     ld.d            $r6, sp, PT_R6
> >>>>> +     ld.d            $r7, sp, PT_R7
> >>>>> +     ld.d            $r8, sp, PT_R8
> >>>>> +     ld.d            $r9, sp, PT_R9
> >>>>> +     ld.d            $r10, sp, PT_R10
> >>>>> +     ld.d            $r11, sp, PT_R11
> >>>>> +     ld.d            $r20, sp, PT_R20
> >>>>> +     ld.d            $r21, sp, PT_R21
> >>>>> +     ld.d            $r22, sp, PT_R22
> >>>>> +     ld.d            $r23, sp, PT_R23
> >>>>> +     ld.d            $r24, sp, PT_R24
> >>>>> +     ld.d            $r25, sp, PT_R25
> >>>>> +     ld.d            $r26, sp, PT_R26
> >>>>> +     ld.d            $r27, sp, PT_R27
> >>>>> +     ld.d            $r28, sp, PT_R28
> >>>>> +     ld.d            $r29, sp, PT_R29
> >>>>> +     ld.d            $r30, sp, PT_R30
> >>>>> +     ld.d            $r31, sp, PT_R31
> >>>>> +.endm
> >>>>> +
> >>>>> +     /* This is where we return upon wakeup.
> >>>>> +      * Reload all of the registers and return.
> >>>>> +      */
> >>>>> +     .align 12
> >>>>> +
> >>>>> +SYM_CODE_START(loongarch_wakeup_start)
> >>>>> +     li.d            t0, CSR_DMW0_INIT       # UC, PLV0
> >>>>> +     csrwr           t0, LOONGARCH_CSR_DMWIN0
> >>>>> +     li.d            t0, CSR_DMW1_INIT       # CA, PLV0
> >>>>> +     csrwr           t0, LOONGARCH_CSR_DMWIN1
> >>>>> +
> >>>>> +     la.abs          t0, 0f
> >>>>> +     jr              t0
> >>>>> +0:
> >>>>> +     la.pcrel        t0, acpi_saved_sp
> >>>>> +     ld.d            sp, t0, 0
> >>>>> +     SETUP_WAKEUP
> >>>>> +     addi.d          sp, sp, PT_SIZE
> >>>>> +     jr              ra
> >>>>> +SYM_CODE_END(loongarch_wakeup_start)
> >>
>
>
