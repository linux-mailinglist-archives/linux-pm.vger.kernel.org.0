Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5FD32A2AD
	for <lists+linux-pm@lfdr.de>; Tue,  2 Mar 2021 15:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376892AbhCBIRN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 03:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344746AbhCBGnZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 01:43:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D25C06178B
        for <linux-pm@vger.kernel.org>; Mon,  1 Mar 2021 22:42:38 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d15so3396031wrv.5
        for <linux-pm@vger.kernel.org>; Mon, 01 Mar 2021 22:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tfd97WX1co/bA1GShyJOLBPAN41kKS3JMrc0KxlzgGU=;
        b=X3HySQSox1FrvVZIqGKp3GG6HIrkQQVlWJxpD5Cco4Ge2nF0iwz+VlZzafhh+7M7kK
         Ec3QuQX8AccyoXeXbACGA6WDmbvBYjKDKKH+UpLB01eR6ha3wPafBmLjBhmpY6qJiOqw
         bK2kyAE5fEuIRwu+B6ITr7rrY30tatyMOpGz+8exxEsQP2enrIsMEIN27dRfsMvLplZx
         nlH+uXvkTP0FbPoFiBFwLFeJVzY0lU+WxTi+Y3lnpg+eG+caUSBga2HP1cv0ixswGjec
         VRhGC6ZRxaBRCEeJrksMHekp+Xah/I+GfxaeShSi7hK5InuZn7lg7zDRWsnbVXyGYh6R
         IsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tfd97WX1co/bA1GShyJOLBPAN41kKS3JMrc0KxlzgGU=;
        b=RbSzz1YJUgVY9IJzXFAuVzPnlZIhPSKwsh/brS5tuEquvTvYJ9hb7JLH//lSKxCI0i
         zCRw72PNA1W/amCG+pN6a+uD307bnRYXmOuMd/VLOuoMtsvaIrAeOjayOLf1L2C1rjvP
         PZH0mD0EpIZTb6IizTAp5qw3DEAbKC2UAArzpirZIP7VGQDpgSYeLNfwlYoupUPsypDY
         +ZTmekWawid2yP1tpp8Q8qeiieuv17SnrRyNlfo6GjFPK4y79RxlBaS/foQMULcxD2z4
         0EHK0RoM/Zr3uAS6M1eykclDENSWUuZZEmxKPjYR9wZ/WneHpZDHSAxeQTDIXnqpqgEK
         7Xcw==
X-Gm-Message-State: AOAM532KHwaPc5Yk/UbGjkkuvtcES4jheU70WsRFGXOvoPP64adc7W65
        +VbLzpW67NJMk/aRFVitYgnh+wB6DuwGR8NeCzhUEg==
X-Google-Smtp-Source: ABdhPJz1mZd5y4d1mGFzB+y5OipFPnyMJbdA+7nb01Qbnev+st2N3Fi1s+PseO+OVJpZp0oP8W2X+LgHDA+7KkohnTo=
X-Received: by 2002:a5d:464f:: with SMTP id j15mr21059836wrs.390.1614667357370;
 Mon, 01 Mar 2021 22:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20210221093758.210981-1-anup.patel@wdc.com> <20210221093758.210981-2-anup.patel@wdc.com>
 <3a6e2af7-934d-078f-4e19-d4241809e7fb@ghiti.fr>
In-Reply-To: <3a6e2af7-934d-078f-4e19-d4241809e7fb@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 2 Mar 2021 12:12:26 +0530
Message-ID: <CAAhSdy2cOoNK5f75e_mo5c-0-qo4zNWH+Lxoyg31br-+ZZ4n9w@mail.gmail.com>
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

This option is selected by CONFIG_SOC_VIRT so it is being
removed from defconfig by savedefconfig.

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

This is enabled by default so savedefconfig removes it.

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
