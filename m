Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4C1268755
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 10:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgINIkV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 04:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgINIkP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 04:40:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438A0C061788
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 01:40:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so17753119wrv.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIHvV2acufNTdV2ZD5UVUE8IHhdO6zOGauywATo6f5M=;
        b=YWpaC93PYgw87CMssVEGXLRFjRk4KgGY/F1FvrcEiBp4LR38i+yXTh1JADV48qqjAZ
         lu08OG3aCJptxCi00sK+VAmSKO59eWfiFONCeYEc1ssxf6q6TY96Y5OfRs6dDnP1koO8
         L08c9pT50Zy4fXmQunPZE0eaZxMesoN4CIw3Do/LrEp4BTR71QGpSTpezDFlpLwC3NVX
         Yugw/Q0BhJegiIEUDch6sD1ER5cg/j2pX2eMoSyj8rb8v2M/0N4el4IQmJegFalV6CEz
         0LFp9MiCLGoqRjdHyYoGT1vmMT4E1bHee0nTLv84HNKJTL2FZ7iWAE/OkRoNuFiVzGZh
         M5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIHvV2acufNTdV2ZD5UVUE8IHhdO6zOGauywATo6f5M=;
        b=XZija+EcUyPjDT02btAKGwTWGwqozJFfOBVhXNdN6G4pQ2/UJWdwUgszskIILBcKwR
         TKScC4YVoAzi9joO1+sbjsLaXo7hYY0oJO2isupGkaX5mYpNJC8zNerM0TNn6QZhKMX6
         zvMvl9VygY0OaH0qDHHQlInyPDj5yMh41nsExM+RjTcSsSeHJ3XG7W3qYYW9EPhR5OA/
         q2LZmxl7as9RmDAqR9emTLJifgnwF1tsm5yAlIbuRuYJFiikOTHdP7ViI4b6gGOdwm3H
         +vrWzTL+LVEzCBF25tcFc3Ki0H624/OOxYKhCa0P5BDbY2hsnfbSgseESXORskDilUcp
         QP8Q==
X-Gm-Message-State: AOAM531YyGCXMdhBfSjFPU3vN+VrANkDCL81okG30o1GjJkgqQ0guwH2
        kWalxWRw3nnlYMSHoYzw9m/eUCQ3s68M6/t/hdVZrg==
X-Google-Smtp-Source: ABdhPJzZZtlrbBcwMKRCG6Rgim7y5nru9TDNf+5xUibO9sM7r++qDdLRG82ILvPk48o6iDJme+lAd1hw7y6kFZ9Gws4=
X-Received: by 2002:adf:eecb:: with SMTP id a11mr14874541wrp.356.1600072813698;
 Mon, 14 Sep 2020 01:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <1600048323-2964-1-git-send-email-liush@allwinnertech.com>
In-Reply-To: <1600048323-2964-1-git-send-email-liush@allwinnertech.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 14 Sep 2020 14:10:02 +0530
Message-ID: <CAAhSdy1p3A-zQ+Q8WpvNHBEmUJs223gbd11HFiTz+uD-pJFW5g@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: add riscv cpuidle driver
To:     liush <liush@allwinnertech.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, rjw@rjwysocki.net,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Emil Renner Berhing <kernel@esmil.dk>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 14, 2020 at 7:22 AM liush <liush@allwinnertech.com> wrote:
>
> This patch adds a cpuidle driver for systems based RISCV architecture.
> This patch supports state WFI. Other states will be supported in the
> future.

First of all thanks for taking up the CPUIDLE efforts for RISC-V.

The commit description can be bit simplified as follows:
"This patch adds a simple cpuidle driver for RISC-V systems using
the WFI state. Other states will be supported in the future."

>
> Signed-off-by: liush <liush@allwinnertech.com>
> ---
>  arch/riscv/Kconfig               |  7 +++++
>  arch/riscv/include/asm/cpuidle.h |  7 +++++
>  arch/riscv/kernel/Makefile       |  1 +
>  arch/riscv/kernel/cpuidle.c      |  8 ++++++
>  drivers/cpuidle/Kconfig          |  5 ++++
>  drivers/cpuidle/Kconfig.riscv    | 11 ++++++++
>  drivers/cpuidle/Makefile         |  4 +++
>  drivers/cpuidle/cpuidle-riscv.c  | 55 ++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 98 insertions(+)
>  create mode 100644 arch/riscv/include/asm/cpuidle.h
>  create mode 100644 arch/riscv/kernel/cpuidle.c
>  create mode 100644 drivers/cpuidle/Kconfig.riscv
>  create mode 100644 drivers/cpuidle/cpuidle-riscv.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index df18372..c7ddb9d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -86,6 +86,7 @@ config RISCV
>         select SPARSE_IRQ
>         select SYSCTL_EXCEPTION_TRACE
>         select THREAD_INFO_IN_TASK
> +       select CPU_IDLE

Place "select CPU_IDLE" in alphabetical order under
"config RISCV".

>
>  config ARCH_MMAP_RND_BITS_MIN
>         default 18 if 64BIT
> @@ -407,6 +408,12 @@ config BUILTIN_DTB
>         depends on RISCV_M_MODE
>         depends on OF
>
> +menu "CPU Power Management"
> +
> +source "drivers/cpuidle/Kconfig"
> +
> +endmenu
> +
>  menu "Power management options"
>
>  source "kernel/power/Kconfig"
> diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
> new file mode 100644
> index 00000000..2599d2f
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpuidle.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __RISCV_CPUIDLE_H
> +#define __RISCV_CPUIDLE_H
> +
> +extern void cpu_do_idle(void);
> +
> +#endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index dc93710..396ba9c 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -29,6 +29,7 @@ obj-y += riscv_ksyms.o
>  obj-y  += stacktrace.o
>  obj-y  += cacheinfo.o
>  obj-y  += patch.o
> +obj-y  += cpuidle.o
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>
>  obj-$(CONFIG_RISCV_M_MODE)     += traps_misaligned.o
> diff --git a/arch/riscv/kernel/cpuidle.c b/arch/riscv/kernel/cpuidle.c
> new file mode 100644
> index 00000000..a3289e7
> --- /dev/null
> +++ b/arch/riscv/kernel/cpuidle.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <asm/cpuidle.h>
> +
> +void cpu_do_idle(void)
> +{
> +       __asm__ __volatile__ ("wfi");
> +

You should directly use the wait_for_interrupt() macro defined
in asm/processor.h.

I think we don't need a separate kernel/cpuidle.c source file as
of now. Maybe in-future we can add if required.

I suggest making cpu_do_idle() as "static inline" in asm/cpuidle.h

This way you will only need asm/cpuidle.h for the current changes.

> +}
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c0aeedd..f6be0fd 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -62,6 +62,11 @@ depends on PPC
>  source "drivers/cpuidle/Kconfig.powerpc"
>  endmenu
>
> +menu "RISCV CPU Idle Drivers"
> +depends on RISCV
> +source "drivers/cpuidle/Kconfig.riscv"
> +endmenu
> +
>  config HALTPOLL_CPUIDLE
>         tristate "Halt poll cpuidle driver"
>         depends on X86 && KVM_GUEST
> diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
> new file mode 100644
> index 00000000..e86d36b
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.riscv
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# RISCV CPU Idle drivers
> +#
> +config RISCV_CPUIDLE
> +        bool "Generic RISCV CPU idle Driver"
> +        select DT_IDLE_STATES
> +       select CPU_IDLE_MULTIPLE_DRIVERS
> +        help
> +          Select this option to enable generic cpuidle driver for RISCV.
> +         Now only support C0 State.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 26bbc5e..4c83c4e 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -34,3 +34,7 @@ obj-$(CONFIG_MIPS_CPS_CPUIDLE)                += cpuidle-cps.o
>  # POWERPC drivers
>  obj-$(CONFIG_PSERIES_CPUIDLE)          += cpuidle-pseries.o
>  obj-$(CONFIG_POWERNV_CPUIDLE)          += cpuidle-powernv.o
> +
> +###############################################################################
> +# RISCV drivers
> +obj-$(CONFIG_RISCV_CPUIDLE)            += cpuidle-riscv.o
> diff --git a/drivers/cpuidle/cpuidle-riscv.c b/drivers/cpuidle/cpuidle-riscv.c
> new file mode 100644
> index 00000000..5dddcfa
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-riscv.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RISC-V CPU idle driver.
> + *
> + * Copyright (C) 2020-2022 Allwinner Ltd
> + *
> + * Based on code - driver/cpuidle/cpuidle-at91.c
> + *
> + */
> +#include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <asm/cpuidle.h>
> +
> +#define MAX_IDLE_STATES        1
> +
> +/* TODO: Implement deeper idle states */
> +static int riscv_low_level_suspend_enter(int state)
> +{

Shouldn't we call cpu_do_idle() here ???

> +       return 0;
> +}
> +
> +/* Actual code that puts the SoC in different idle states */
> +static int riscv_enter_idle(struct cpuidle_device *dev,
> +                       struct cpuidle_driver *drv,
> +                              int index)
> +{
> +       return CPU_PM_CPU_IDLE_ENTER_PARAM(riscv_low_level_suspend_enter,
> +                                          index, 0);
> +}
> +
> +static struct cpuidle_driver riscv_idle_driver = {
> +       .name                   = "riscv_idle",
> +       .owner                  = THIS_MODULE,
> +       .states[0]              = {
> +               .enter                  = riscv_enter_idle,
> +               .exit_latency           = 1,
> +               .target_residency       = 1,
> +               .name                   = "WFI",
> +               .desc                   = "RISCV WFI",
> +       },
> +       .state_count = MAX_IDLE_STATES,
> +};
> +
> +static int __init riscv_cpuidle_init(void)
> +{
> +       return cpuidle_register(&riscv_idle_driver, NULL);
> +}
> +
> +device_initcall(riscv_cpuidle_init);
> --
> 2.7.4
>

As a separate topic, I suggest you propose the
SBI_EXT_HSM_HART_SUSPEND call for SBI spec.

The generic RISC-V cpuidle driver can detect
SBI_EXT_HSM_HART_SUSPEND availability in
riscv_cpuidle_init(). The riscv_low_level_suspend_enter()
will do SBI_EXT_HSM_HART_SUSPEND call whenever
available otherwise it can simply call cpu_do_idle().

Regards,
Anup
