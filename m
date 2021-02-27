Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC81326B82
	for <lists+linux-pm@lfdr.de>; Sat, 27 Feb 2021 05:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhB0EAV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 23:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhB0EAS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 23:00:18 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534B4C06174A
        for <linux-pm@vger.kernel.org>; Fri, 26 Feb 2021 19:59:38 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u4so12944928ljh.6
        for <linux-pm@vger.kernel.org>; Fri, 26 Feb 2021 19:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IozGx7C0T19f0wHA2sRVJGAa+F8rFFKpX1D9A8YR8PU=;
        b=HCQVZ5EjAhlPbe6PMaX7ZUJILWMltz2qOzxlQTW/cLhl4wTjGnAAFQ9DhlsKHlbPoh
         uhreFWU/8syefOSG9GjCSk0NkbeHR5owmvGV6uHWbk4ij2eRQnsGu0Gp0OzBTtGBkRyN
         22tqA9FjtcndeULj4onrEi3jcyHapzSrHghIwcup5y45alrBxDPasblkR4ddZytTmJzf
         P9W2H1RygxjlfJ4KLdg+914UOoZnQeeeSEUbcd2ddMXmOZCXXhAUB/1R4TzwOta3TjRr
         T/+00ElxyBnmBLV6Cx1a23XWFILvofLUstmlM/qyR0YPBisY03vE2xjKFIH8sq5Xb8z+
         F3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IozGx7C0T19f0wHA2sRVJGAa+F8rFFKpX1D9A8YR8PU=;
        b=EECkUrubtHfpgqsx4+tfynJqYcZmEBssOJvxw9yDJm0QJmkG6uWJjjiFai+4tlFkxz
         4LWfU9hlfaPE4z0UljsUXhTlE21XWzwgpY0gCCkQkoAXDNIYtR6sK8ZpzHqQEMNHvRY5
         DiDsN7TsxGPhE81SrSTbiPLKJBpze+mJATVhPqn55W/dmBPv3VEjKqMc1IMTp2+25k7q
         oFiwm7gIlP5aL/5r1mHD0C3V1ThHFqJ2g7xtwvgpJeHILx5wNE/rMBqFL6TIEOjJwWQI
         tJU7vIXyogAwqQic3F3GiY0Tk0G+esUca5WXVc+nIDDuoXAOXaAYv4Pgh05fM6nx/zxx
         sJ6A==
X-Gm-Message-State: AOAM533mK2BxHsCDQXnXWhlcneDhQ6QOtXTZgzMKsOws8EWi5xCytAr7
        RL8DTaLqCnJ5PfIQBNkyJaWcA/GmlHSF+B89ZIDtdw==
X-Google-Smtp-Source: ABdhPJyK8PaCQQvdm5VywGcJLUez1h6cE0BTHcn810vx1vEgoHXDoa8wi/rAtvi3X+Xex5Uedewqw0yV+4b4iaTOj1Y=
X-Received: by 2002:a05:651c:15:: with SMTP id n21mr3539853lja.284.1614398376751;
 Fri, 26 Feb 2021 19:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20210221093758.210981-1-anup.patel@wdc.com> <20210221093758.210981-2-anup.patel@wdc.com>
 <3a6e2af7-934d-078f-4e19-d4241809e7fb@ghiti.fr>
In-Reply-To: <3a6e2af7-934d-078f-4e19-d4241809e7fb@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 27 Feb 2021 09:29:24 +0530
Message-ID: <CAAhSdy2VPQURW+rCkY7_dWbgqgOU9_MNN5gRurE_bVcjz1k9aQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] RISC-V: Enable CPU_IDLE drivers
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Alex,

On Fri, Feb 26, 2021 at 6:46 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Anup,
>
> Le 2/21/21 =C3=A0 4:37 AM, Anup Patel a =C3=A9crit :
> > We force select CPU_PM and provide asm/cpuidle.h so that we can
> > use CPU IDLE drivers for Linux RISC-V kernel.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >   arch/riscv/Kconfig                |  7 +++++++
> >   arch/riscv/configs/defconfig      |  7 +++----
> >   arch/riscv/configs/rv32_defconfig |  4 ++--
> >   arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
> >   arch/riscv/kernel/process.c       |  3 ++-
> >   5 files changed, 38 insertions(+), 7 deletions(-)
> >   create mode 100644 arch/riscv/include/asm/cpuidle.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index fe6862b06ead..4901200b6b6c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -37,6 +37,7 @@ config RISCV
> >       select CLONE_BACKWARDS
> >       select CLINT_TIMER if !MMU
> >       select COMMON_CLK
> > +     select CPU_PM if CPU_IDLE
> >       select EDAC_SUPPORT
> >       select GENERIC_ARCH_TOPOLOGY if SMP
> >       select GENERIC_ATOMIC64 if !64BIT
> > @@ -430,4 +431,10 @@ source "kernel/power/Kconfig"
> >
> >   endmenu
> >
> > +menu "CPU Power Management"
> > +
> > +source "drivers/cpuidle/Kconfig"
> > +
> > +endmenu
> > +
> >   source "drivers/firmware/Kconfig"
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfi=
g
> > index 6c0625aa96c7..dc4927c0e44b 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -13,11 +13,13 @@ CONFIG_USER_NS=3Dy
> >   CONFIG_CHECKPOINT_RESTORE=3Dy
> >   CONFIG_BLK_DEV_INITRD=3Dy
> >   CONFIG_EXPERT=3Dy
> > +# CONFIG_SYSFS_SYSCALL is not set
> >   CONFIG_BPF_SYSCALL=3Dy
> >   CONFIG_SOC_SIFIVE=3Dy
> >   CONFIG_SOC_VIRT=3Dy
> >   CONFIG_SMP=3Dy
> >   CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_CPU_IDLE=3Dy
> >   CONFIG_JUMP_LABEL=3Dy
> >   CONFIG_MODULES=3Dy
> >   CONFIG_MODULE_UNLOAD=3Dy
> > @@ -65,10 +67,9 @@ CONFIG_HW_RANDOM=3Dy
> >   CONFIG_HW_RANDOM_VIRTIO=3Dy
> >   CONFIG_SPI=3Dy
> >   CONFIG_SPI_SIFIVE=3Dy
> > +# CONFIG_PTP_1588_CLOCK is not set
> >   CONFIG_GPIOLIB=3Dy
> >   CONFIG_GPIO_SIFIVE=3Dy
> > -# CONFIG_PTP_1588_CLOCK is not set
> > -CONFIG_POWER_RESET=3Dy
>
> Why do you remove this config ?

Argh, I don't know how this got here. I will remove
this change in the next revision. Thanks for catching.

>
> >   CONFIG_DRM=3Dy
> >   CONFIG_DRM_RADEON=3Dy
> >   CONFIG_DRM_VIRTIO_GPU=3Dy
> > @@ -132,5 +133,3 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=3Dy
> >   # CONFIG_FTRACE is not set
> >   # CONFIG_RUNTIME_TESTING_MENU is not set
> >   CONFIG_MEMTEST=3Dy
> > -# CONFIG_SYSFS_SYSCALL is not set
> > -CONFIG_EFI=3Dy
>
> And this is one too ? If those removals are intentional, maybe you can
> add something about that in the commit description ?

I will remove this change as well.

>
> > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv3=
2_defconfig
> > index 8dd02b842fef..332e43a4a2c3 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
> > @@ -13,12 +13,14 @@ CONFIG_USER_NS=3Dy
> >   CONFIG_CHECKPOINT_RESTORE=3Dy
> >   CONFIG_BLK_DEV_INITRD=3Dy
> >   CONFIG_EXPERT=3Dy
> > +# CONFIG_SYSFS_SYSCALL is not set
> >   CONFIG_BPF_SYSCALL=3Dy
> >   CONFIG_SOC_SIFIVE=3Dy
> >   CONFIG_SOC_VIRT=3Dy
> >   CONFIG_ARCH_RV32I=3Dy
> >   CONFIG_SMP=3Dy
> >   CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_CPU_IDLE=3Dy
> >   CONFIG_JUMP_LABEL=3Dy
> >   CONFIG_MODULES=3Dy
> >   CONFIG_MODULE_UNLOAD=3Dy
> > @@ -67,7 +69,6 @@ CONFIG_HW_RANDOM_VIRTIO=3Dy
> >   CONFIG_SPI=3Dy
> >   CONFIG_SPI_SIFIVE=3Dy
> >   # CONFIG_PTP_1588_CLOCK is not set
> > -CONFIG_POWER_RESET=3Dy
> >   CONFIG_DRM=3Dy
> >   CONFIG_DRM_RADEON=3Dy
> >   CONFIG_DRM_VIRTIO_GPU=3Dy
> > @@ -131,4 +132,3 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=3Dy
> >   # CONFIG_FTRACE is not set
> >   # CONFIG_RUNTIME_TESTING_MENU is not set
> >   CONFIG_MEMTEST=3Dy
> > -# CONFIG_SYSFS_SYSCALL is not set
> > diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/=
cpuidle.h
> > new file mode 100644
> > index 000000000000..1042d790e446
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/cpuidle.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2021 Allwinner Ltd
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#ifndef _ASM_RISCV_CPUIDLE_H
> > +#define _ASM_RISCV_CPUIDLE_H
> > +
> > +#include <asm/barrier.h>
> > +#include <asm/processor.h>
> > +
> > +static inline void cpu_do_idle(void)
> > +{
> > +     /*
> > +      * Add mb() here to ensure that all
> > +      * IO/MEM access are completed prior
>
> accessES ?

Okay will update.

>
> > +      * to enter WFI.
> > +      */
> > +     mb();
> > +     wait_for_interrupt();
> > +}
> > +
> > +#endif
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index dd5f985b1f40..b5b51fd26624 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -21,6 +21,7 @@
> >   #include <asm/string.h>
> >   #include <asm/switch_to.h>
> >   #include <asm/thread_info.h>
> > +#include <asm/cpuidle.h>
> >
> >   register unsigned long gp_in_global __asm__("gp");
> >
> > @@ -35,7 +36,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
> >
> >   void arch_cpu_idle(void)
> >   {
> > -     wait_for_interrupt();
> > +     cpu_do_idle();
> >       raw_local_irq_enable();
> >   }
> >
> >

Regards,
Anup
