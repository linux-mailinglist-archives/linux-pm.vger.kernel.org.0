Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80F5429A9F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 02:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhJLA41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 20:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbhJLA40 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 20:56:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1954EC061749
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 17:54:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r10so61505998wra.12
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ncnaD26X/UBXH1jDnofX2X5t1TXsmS8IeZbZwTuTT0=;
        b=2tyXQPIuTCJVQeHdTmecUXm097J2f8VrYJdpSh2jjUOoeFCIG4dVdhYeV0I0luOHyG
         f7MusH1iiwM9Pub3gBSo5IeaZlKbkEayBEdLRr7pi7LlT4FFstCgBKkRIhepXi0DEOp1
         Xrg1d0+WYXvN5tEIpz4XfnkrMZaDXoDYDcDsEfXqp4ptrbPDCm7Xp84ZczmtpcR7GOGZ
         OQ3DHXJGybknJ7OvHXXFOcpMwftSN47sMGKB01NPi+lgP4sHjK05RC4PmjMo2cwB5u2U
         wSskp3sWXd7SJ0i37XPRFBOEZIAfDPT12jooOoZOMoKHnMNQsE6eYspAx6x7cetZybao
         I3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ncnaD26X/UBXH1jDnofX2X5t1TXsmS8IeZbZwTuTT0=;
        b=J0kwiJpwQMQHGoeZhS05YnyWsXtvkjisNfD6gaBAFAVyqQDOOcWSE2v31psW4fpecw
         IdBKElfEpUSgbfbeWesKql2V4JpzylDendglURdc0PEeLfPFphBGwT7r2ZVj2/o1M2T7
         FuLkZG5yfLFqXJDahBIqIHz2uyzWcJWvc9gyic9ELlTAR4I+9RTmzreXQZ5KlmP2U13T
         l5S0Eb962iRkpXSBr1gW2N7KFu/IACaK+8YCpt8K2DJYIuQE/bYrbrcHE2TFICoG/6tQ
         JPc0tco4CsY8FG+5/l036hAPwEwdMzWwusSMf5bqbpZ1g9TjCdqHLYjRijIyer54bcrP
         Tcxw==
X-Gm-Message-State: AOAM5303ymxz69weHp7+NaDGs2jVKykC1qQd4XdnZ3OQPFKaRAUkMYoz
        oHq/FsSfGYomDvkn9ql15AmbRIA9V07du1DKLayqjw==
X-Google-Smtp-Source: ABdhPJyvzMX6zyEq4jQHSpgK+w9LNXwraC3Ngj4XFOnaT0BiC/mAGAEM3+8LeP3Ow+tFlGuxcsowI0rLPQkF8oSdK2E=
X-Received: by 2002:adf:f949:: with SMTP id q9mr28343183wrr.331.1634000059274;
 Mon, 11 Oct 2021 17:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211011081820.1135261-1-anup.patel@wdc.com> <20211011081820.1135261-2-anup.patel@wdc.com>
 <30695639.mNO2d7px6N@diego>
In-Reply-To: <30695639.mNO2d7px6N@diego>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 12 Oct 2021 06:24:07 +0530
Message-ID: <CAAhSdy0C6rcavMiPgzxejrxevjvorM=BWbtO8gLMTATSg9DUHg@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] RISC-V: Enable CPU_IDLE drivers
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 12, 2021 at 3:34 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Anup,
>
> Am Montag, 11. Oktober 2021, 10:18:13 CEST schrieb Anup Patel:
> > We force select CPU_PM and provide asm/cpuidle.h so that we can
> > use CPU IDLE drivers for Linux RISC-V kernel.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/Kconfig                |  7 +++++++
> >  arch/riscv/configs/defconfig      |  1 +
> >  arch/riscv/configs/rv32_defconfig |  1 +
> >  arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
> >  arch/riscv/kernel/process.c       |  3 ++-
> >  5 files changed, 35 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/riscv/include/asm/cpuidle.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 8de2afb460f7..d02f1f5a2431 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -46,6 +46,7 @@ config RISCV
> >       select CLONE_BACKWARDS
> >       select CLINT_TIMER if !MMU
> >       select COMMON_CLK
> > +     select CPU_PM if CPU_IDLE
> >       select EDAC_SUPPORT
> >       select GENERIC_ARCH_TOPOLOGY if SMP
> >       select GENERIC_ATOMIC64 if !64BIT
> > @@ -564,5 +565,11 @@ source "kernel/power/Kconfig"
> >
> >  endmenu
> >
> > +menu "CPU Power Management"
> > +
> > +source "drivers/cpuidle/Kconfig"
> > +
> > +endmenu
> > +
> >  source "arch/riscv/kvm/Kconfig"
> >  source "drivers/firmware/Kconfig"
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfi=
g
> > index be21f54e9b91..39b4c32e7997 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=3Dy
> >  CONFIG_SOC_VIRT=3Dy
> >  CONFIG_SMP=3Dy
> >  CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_CPU_IDLE=3Dy
> >  CONFIG_VIRTUALIZATION=3Dy
> >  CONFIG_KVM=3Dy
> >  CONFIG_JUMP_LABEL=3Dy
>
> This doesn't apply.
>
> In the history of your tree that you referenced in the cover-letter
> I found "RISC-V: Enable KVM for RV64 and RV32"
> with that nice "DO NOT UPSTREAM !!!!!" message in caps in it ;-)
>
> This of course makes this not apply on the main riscv tree.
>
> So you might want to base your series on top of a clean "for-next"
> branch of Palmer's tree instead of collecting other stuff below it.

I usually base everything on the most recent Linus release tag.

This time I accidentally rebased on my KVM RISC-V branch which
was merged recently.

I will anyway send v9.

Regards,
Anup

>
> Same for rv32_defconfig below.
>
>
> Heiko
>
>
> > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv3=
2_defconfig
> > index ad01f50c98f1..fed827c82a9e 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
> > @@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=3Dy
> >  CONFIG_ARCH_RV32I=3Dy
> >  CONFIG_SMP=3Dy
> >  CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_CPU_IDLE=3Dy
> >  CONFIG_VIRTUALIZATION=3Dy
> >  CONFIG_KVM=3Dy
> >  CONFIG_JUMP_LABEL=3Dy
> > diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/=
cpuidle.h
> > new file mode 100644
> > index 000000000000..71fdc607d4bc
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
> > +      * IO/MEM accesses are completed prior
> > +      * to entering WFI.
> > +      */
> > +     mb();
> > +     wait_for_interrupt();
> > +}
> > +
> > +#endif
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index 03ac3aa611f5..504b496787aa 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -23,6 +23,7 @@
> >  #include <asm/string.h>
> >  #include <asm/switch_to.h>
> >  #include <asm/thread_info.h>
> > +#include <asm/cpuidle.h>
> >
> >  register unsigned long gp_in_global __asm__("gp");
> >
> > @@ -37,7 +38,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
> >
> >  void arch_cpu_idle(void)
> >  {
> > -     wait_for_interrupt();
> > +     cpu_do_idle();
> >       raw_local_irq_enable();
> >  }
> >
> >
>
>
>
>
