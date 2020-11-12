Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204C72B09F6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 17:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKLQ2W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 11:28:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40790 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgKLQ2W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 11:28:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id m143so7028850oig.7;
        Thu, 12 Nov 2020 08:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVkmZGVvtikkFdNcFf5aJnZ+zKHdkv+RuYhcq803DV0=;
        b=VN7j/WRZiF4jN8FvSW8DnYFnMF6g8ak35ej7awnPzXEkbEVOx/LB8nbqNRduNA/DUE
         eEOHvSdYiFPb+YgGzDQHCPBZYco2duVqgcVnohz5WTPJ0HUVwFxUqznvWJ7yL5XU7tlZ
         +rngY2vo7bOqvJAkU4a53ScDYYnAGZpQiP7dmlTPcK2tgTfsiCH1KjNxP9L6KiglD78v
         5a/jlpSyIikQ24vtg4qtEgV1Kp++2TV60nCiZCWsGhoOSdhqBJitX/RLlDDwx6Wcp2A7
         ro1DgvE8peGrp6Ty2kDGGm3VQJIhv0kY+sGAUgLvJjTqYLanZZ6Y/IRdS3LblJC/RrEa
         TVQQ==
X-Gm-Message-State: AOAM533weuQr5Y/x9imbhuumPykN+MpGfsiKQhjjAx0d4NPcYR1EgRZo
        3/VrkxIanlUo18WktY9iU1jC/YTUWk9mDZkmXCk=
X-Google-Smtp-Source: ABdhPJwquNMw4w3BCjuJtYWxyxNKDiRQhbvewS6EVr2u1s2+mtSUV0JsefldotA13QPL9jO+lJtEefvMnjbDwjGMwLw=
X-Received: by 2002:aca:c4c9:: with SMTP id u192mr306660oif.69.1605198500721;
 Thu, 12 Nov 2020 08:28:20 -0800 (PST)
MIME-Version: 1.0
References: <1601005600-32653-1-git-send-email-liush@allwinnertech.com>
In-Reply-To: <1601005600-32653-1-git-send-email-liush@allwinnertech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Nov 2020 17:28:09 +0100
Message-ID: <CAJZ5v0h-7Hc9MxeaqVSjOREYHfc+m2Bjxcuk9Q04d9b1r4zqVg@mail.gmail.com>
Subject: Re: [v3] cpuidle: add riscv cpuidle driver
To:     liush <liush@allwinnertech.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, anup.patel@wdc.com,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, amanieu@gmail.com,
        guoren@linux.alibaba.com, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 25, 2020 at 5:46 AM liush <liush@allwinnertech.com> wrote:
>
> This patch adds a simple cpuidle driver for RISC-V systems using
> the WFI state. Other states will be supported in the future.
>
> Reported-by: kernel test robot <lkp@intel.com>

This isn't needed in a patch adding a new driver.

> Signed-off-by: liush <liush@allwinnertech.com>
> ---
> Changes in v3:
> - fix the issue reported by kernel test robot
>   "drivers/cpuidle/cpuidle-riscv.c:22:12: warning: no previous prototype
>    for 'riscv_low_level_suspend_enter' [-Wmissing-prototypes]"
> Changes in v2:
> - call "mb()" before run "WFI" in cpu_do_idle
> - modify commit description
> - place "select CPU_IDLE" in alphabetical order
> - replace "__asm__ __volatile__ ("wfi")" with "wait_for_interrupt()"
> - delete "cpuidle.c",move "cpu_do_idle()" to cpuidle.h
> - modify "arch_cpu_idle", "cpu_do_idle" can be called by
>   "arch_cpu_idle"
> - fix space/tab issues
> - modify riscv_low_level_suspend_enter to __weak mode
>
>  arch/riscv/Kconfig               |  7 +++++
>  arch/riscv/include/asm/cpuidle.h | 16 ++++++++++++
>  arch/riscv/kernel/process.c      |  3 ++-
>  drivers/cpuidle/Kconfig          |  5 ++++
>  drivers/cpuidle/Kconfig.riscv    | 11 ++++++++
>  drivers/cpuidle/Makefile         |  4 +++
>  drivers/cpuidle/cpuidle-riscv.c  | 55 ++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/cpuidle.h
>  create mode 100644 drivers/cpuidle/Kconfig.riscv
>  create mode 100644 drivers/cpuidle/cpuidle-riscv.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index df18372..799bf86 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -33,6 +33,7 @@ config RISCV
>         select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>         select CLONE_BACKWARDS
>         select COMMON_CLK
> +       select CPU_IDLE
>         select EDAC_SUPPORT
>         select GENERIC_ARCH_TOPOLOGY if SMP
>         select GENERIC_ATOMIC64 if !64BIT
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
> index 00000000..599b810
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpuidle.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __RISCV_CPUIDLE_H
> +#define __RISCV_CPUIDLE_H
> +
> +static inline void cpu_do_idle(void)
> +{
> +       /*
> +        * Add mb() here to ensure that all
> +        * IO/MEM access are completed prior
> +        * to enter WFI.
> +        */
> +       mb();

Either the comment isn't precise enough, or this may not work as expected.

The memory barrier prevents memory accesses occurring earlier in the
code flow from being reordered (by the processor or by the compiler)
after the function call below, but is this really needed?  That is,
can they be reordered anyway?  If so, then why?

> +       wait_for_interrupt();
> +}
> +
> +#endif
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 2b97c49..5431aaa 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -21,6 +21,7 @@
>  #include <asm/string.h>
>  #include <asm/switch_to.h>
>  #include <asm/thread_info.h>
> +#include <asm/cpuidle.h>
>
>  register unsigned long gp_in_global __asm__("gp");
>
> @@ -35,7 +36,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
>
>  void arch_cpu_idle(void)
>  {
> -       wait_for_interrupt();
> +       cpu_do_idle();
>         local_irq_enable();
>  }
>
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
> index 00000000..7bec059
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.riscv
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# RISCV CPU Idle drivers
> +#
> +config RISCV_CPUIDLE
> +       bool "Generic RISCV CPU idle Driver"
> +       select DT_IDLE_STATES
> +       select CPU_IDLE_MULTIPLE_DRIVERS
> +       help
> +         Select this option to enable generic cpuidle driver for RISCV.
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

I'm not sure why this is needed at all.

Because there is only one idle state, idx in __CPU_PM_CPU_IDLE_ENTER()
will always be 0, so it'll always call cpu_do_idle(), so can't it be
invoked directly from here?

And since the arch_cpu_idle() is also WFI, why is the full-blown
cpuidle driver needed at this point?

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
