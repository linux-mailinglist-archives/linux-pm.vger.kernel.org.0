Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B0A2BBC42
	for <lists+linux-pm@lfdr.de>; Sat, 21 Nov 2020 03:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgKUCeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Nov 2020 21:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgKUCeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Nov 2020 21:34:44 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865E9C0613CF
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2020 18:34:42 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 131so9666328pfb.9
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2020 18:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=37P7Jp8XSIot7E8fEFKnYF/0x/havgOQAmhG1+AF0yA=;
        b=bLFTrW9873Ae9vJUsAjQxjkt1Pjx0SDYg+l7N6bdkOz1ymhAcnBcLE2TvvHJW+P65Q
         WXl2ZMuBiyf6wmIAiqZks+kRpeKLwwSToOZlJMHIEi1qdT0tJpxG8/vVt+hCqBRLLXyk
         tLh+v4i8wnb+FqbE4K75EZct9hswU+mSMTAvjOaKP+ig7v2hZ12AUqqtLK/vvTm9ENFA
         UPZXb7jClQET+PSUu0s9d9L2uZ17bTbhmgNkexJapEyi/zwD7xbmBKZqt5zg76szT1KF
         MecH8ZfNz12TYNluG3T6BpZN+bihvvXFR/oe+3T8+SqxIe3yBwifIcMIZtYc50wLj+ui
         KvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=37P7Jp8XSIot7E8fEFKnYF/0x/havgOQAmhG1+AF0yA=;
        b=GjPEik27slKlGUoXgzaj1nHkEdMZK1ySKVOP2LVXtHVCmmbkF291wKedgWke0EDvYo
         Hk4/ahqNA1/W1mnzbCq0/c9DacheoyiJvmf5PBzfqmm6whvb0Bp2OXsu4bUjL5cUhV8h
         c7z3TMzqgrwQabWY0MlSSITpZWFmgkV2znBpwwtO1fHIy5ZLs0fjsYtk4EQsMk6cWfQR
         bcc7kKo8/AahotngorotqQ7d3UtWSADH1CQ6K4UqP6lgl6hmQucCEguirABjtLJxOeRa
         5FeMa/9ZxlkLgkAWRpMi76/eB7DDzAzZIFapmEnjNlbCBckSeYIvU/YJHlV17C5mSB28
         1TbA==
X-Gm-Message-State: AOAM533aYtUZE703lKd50MAFWexshqNKvF4TnHn3ZcrYoUwmgfRgbLjU
        XMeO6AskrDDhd5O/YFeqrKJZ8Q==
X-Google-Smtp-Source: ABdhPJxUtfqQocBNJXNZyJmlVXOuOTyrvZBFsXf/39nF4EUtYC0A4QA5HkZ857JVjeQc1ATtuP+42Q==
X-Received: by 2002:a17:90a:154a:: with SMTP id y10mr13440501pja.6.1605926081647;
        Fri, 20 Nov 2020 18:34:41 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k9sm5028411pfp.68.2020.11.20.18.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 18:34:40 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:34:40 -0800 (PST)
X-Google-Original-Date: Fri, 20 Nov 2020 18:34:38 PST (-0800)
Subject:     Re: [v3] cpuidle: add riscv cpuidle driver
In-Reply-To: <CAJZ5v0h-7Hc9MxeaqVSjOREYHfc+m2Bjxcuk9Q04d9b1r4zqVg@mail.gmail.com>
CC:     liush@allwinnertech.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, Anup Patel <Anup.Patel@wdc.com>,
        keescook@chromium.org, christian.brauner@ubuntu.com,
        geert@linux-m68k.org, amanieu@gmail.com, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rafael@kernel.org
Message-ID: <mhng-28f02efa-2790-4a6d-bff7-a91bf3a0d227@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 12 Nov 2020 08:28:09 PST (-0800), rafael@kernel.org wrote:
> On Fri, Sep 25, 2020 at 5:46 AM liush <liush@allwinnertech.com> wrote:
>>
>> This patch adds a simple cpuidle driver for RISC-V systems using
>> the WFI state. Other states will be supported in the future.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>
> This isn't needed in a patch adding a new driver.
>
>> Signed-off-by: liush <liush@allwinnertech.com>
>> ---
>> Changes in v3:
>> - fix the issue reported by kernel test robot
>>   "drivers/cpuidle/cpuidle-riscv.c:22:12: warning: no previous prototype
>>    for 'riscv_low_level_suspend_enter' [-Wmissing-prototypes]"
>> Changes in v2:
>> - call "mb()" before run "WFI" in cpu_do_idle
>> - modify commit description
>> - place "select CPU_IDLE" in alphabetical order
>> - replace "__asm__ __volatile__ ("wfi")" with "wait_for_interrupt()"
>> - delete "cpuidle.c",move "cpu_do_idle()" to cpuidle.h
>> - modify "arch_cpu_idle", "cpu_do_idle" can be called by
>>   "arch_cpu_idle"
>> - fix space/tab issues
>> - modify riscv_low_level_suspend_enter to __weak mode
>>
>>  arch/riscv/Kconfig               |  7 +++++
>>  arch/riscv/include/asm/cpuidle.h | 16 ++++++++++++
>>  arch/riscv/kernel/process.c      |  3 ++-
>>  drivers/cpuidle/Kconfig          |  5 ++++
>>  drivers/cpuidle/Kconfig.riscv    | 11 ++++++++
>>  drivers/cpuidle/Makefile         |  4 +++
>>  drivers/cpuidle/cpuidle-riscv.c  | 55 ++++++++++++++++++++++++++++++++++++++++
>>  7 files changed, 100 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/riscv/include/asm/cpuidle.h
>>  create mode 100644 drivers/cpuidle/Kconfig.riscv
>>  create mode 100644 drivers/cpuidle/cpuidle-riscv.c
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index df18372..799bf86 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -33,6 +33,7 @@ config RISCV
>>         select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>>         select CLONE_BACKWARDS
>>         select COMMON_CLK
>> +       select CPU_IDLE
>>         select EDAC_SUPPORT
>>         select GENERIC_ARCH_TOPOLOGY if SMP
>>         select GENERIC_ATOMIC64 if !64BIT
>> @@ -407,6 +408,12 @@ config BUILTIN_DTB
>>         depends on RISCV_M_MODE
>>         depends on OF
>>
>> +menu "CPU Power Management"
>> +
>> +source "drivers/cpuidle/Kconfig"
>> +
>> +endmenu
>> +
>>  menu "Power management options"
>>
>>  source "kernel/power/Kconfig"
>> diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
>> new file mode 100644
>> index 00000000..599b810
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/cpuidle.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __RISCV_CPUIDLE_H
>> +#define __RISCV_CPUIDLE_H
>> +
>> +static inline void cpu_do_idle(void)
>> +{
>> +       /*
>> +        * Add mb() here to ensure that all
>> +        * IO/MEM access are completed prior
>> +        * to enter WFI.
>> +        */
>> +       mb();
>
> Either the comment isn't precise enough, or this may not work as expected.
>
> The memory barrier prevents memory accesses occurring earlier in the
> code flow from being reordered (by the processor or by the compiler)
> after the function call below, but is this really needed?  That is,
> can they be reordered anyway?  If so, then why?
>
>> +       wait_for_interrupt();
>> +}
>> +
>> +#endif
>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>> index 2b97c49..5431aaa 100644
>> --- a/arch/riscv/kernel/process.c
>> +++ b/arch/riscv/kernel/process.c
>> @@ -21,6 +21,7 @@
>>  #include <asm/string.h>
>>  #include <asm/switch_to.h>
>>  #include <asm/thread_info.h>
>> +#include <asm/cpuidle.h>
>>
>>  register unsigned long gp_in_global __asm__("gp");
>>
>> @@ -35,7 +36,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
>>
>>  void arch_cpu_idle(void)
>>  {
>> -       wait_for_interrupt();
>> +       cpu_do_idle();
>>         local_irq_enable();
>>  }
>>
>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>> index c0aeedd..f6be0fd 100644
>> --- a/drivers/cpuidle/Kconfig
>> +++ b/drivers/cpuidle/Kconfig
>> @@ -62,6 +62,11 @@ depends on PPC
>>  source "drivers/cpuidle/Kconfig.powerpc"
>>  endmenu
>>
>> +menu "RISCV CPU Idle Drivers"
>> +depends on RISCV
>> +source "drivers/cpuidle/Kconfig.riscv"
>> +endmenu
>> +
>>  config HALTPOLL_CPUIDLE
>>         tristate "Halt poll cpuidle driver"
>>         depends on X86 && KVM_GUEST
>> diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
>> new file mode 100644
>> index 00000000..7bec059
>> --- /dev/null
>> +++ b/drivers/cpuidle/Kconfig.riscv
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# RISCV CPU Idle drivers
>> +#
>> +config RISCV_CPUIDLE
>> +       bool "Generic RISCV CPU idle Driver"
>> +       select DT_IDLE_STATES
>> +       select CPU_IDLE_MULTIPLE_DRIVERS
>> +       help
>> +         Select this option to enable generic cpuidle driver for RISCV.
>> +         Now only support C0 State.
>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>> index 26bbc5e..4c83c4e 100644
>> --- a/drivers/cpuidle/Makefile
>> +++ b/drivers/cpuidle/Makefile
>> @@ -34,3 +34,7 @@ obj-$(CONFIG_MIPS_CPS_CPUIDLE)                += cpuidle-cps.o
>>  # POWERPC drivers
>>  obj-$(CONFIG_PSERIES_CPUIDLE)          += cpuidle-pseries.o
>>  obj-$(CONFIG_POWERNV_CPUIDLE)          += cpuidle-powernv.o
>> +
>> +###############################################################################
>> +# RISCV drivers
>> +obj-$(CONFIG_RISCV_CPUIDLE)            += cpuidle-riscv.o
>> diff --git a/drivers/cpuidle/cpuidle-riscv.c b/drivers/cpuidle/cpuidle-riscv.c
>> new file mode 100644
>> index 00000000..5dddcfa
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-riscv.c
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * RISC-V CPU idle driver.
>> + *
>> + * Copyright (C) 2020-2022 Allwinner Ltd
>> + *
>> + * Based on code - driver/cpuidle/cpuidle-at91.c
>> + *
>> + */
>> +#include <linux/cpuidle.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/cpu_pm.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <asm/cpuidle.h>
>> +
>> +#define MAX_IDLE_STATES        1
>> +
>> +/* TODO: Implement deeper idle states */
>> +static int riscv_low_level_suspend_enter(int state)
>> +{
>> +       return 0;
>> +}
>> +
>> +/* Actual code that puts the SoC in different idle states */
>> +static int riscv_enter_idle(struct cpuidle_device *dev,
>> +                       struct cpuidle_driver *drv,
>> +                              int index)
>> +{
>> +       return CPU_PM_CPU_IDLE_ENTER_PARAM(riscv_low_level_suspend_enter,
>> +                                          index, 0);
>
> I'm not sure why this is needed at all.
>
> Because there is only one idle state, idx in __CPU_PM_CPU_IDLE_ENTER()
> will always be 0, so it'll always call cpu_do_idle(), so can't it be
> invoked directly from here?
>
> And since the arch_cpu_idle() is also WFI, why is the full-blown
> cpuidle driver needed at this point?

IIRC that was essentially the same feedback as I had on some earlier version of
this.  The ISA defines WFI and a handful of pause mechanisms, and while I'd be
happy to take a driver that selects between those I don't really see a reason
to unless there's some hardware that benefits from it.  I would definitely buy
the argument that those existing standard mechanisms are insufficient to build
a realistic chip, but without any concrete users it's very hard to reason about
any code -- that's true for standard extensions, but doubly so for anything
else.  In this case requiring an in-tree user may be a bit pedantic, as there's
really only one way to go about this sort of thing, but it's the generally
accepted approach in Linux and without an in-tree user it's very hard to
maintain the code.

I know it can be a headache to keep stuff like this out of tree, and while
we've accepted some stuff with only out of tree users I don't want to make that
a general policy.  Specifically I'm thinking of some helper functions for the
hypervisor extension that aren't properly used, but I consider that a bit of a
special case -- that's a standard RISC-V extension, and the ratification
process is just so glacially paced that it seems silly to make a bunch more
work for everyone when it comes to some simple refactoring.

In this case I don't really see such a concrete use case.  I suppose a driver
could be constructed for the WFM/pause type stuff, but I don't really see those
(at least as currently defined) being interesting for the Linux use case.
While obviously it'd be best to have any other idle scheme as a standard RISC-V
extension, I understand that is a long process and my guess would be that
(assuming the RISC-V stuff ever get taken seriously) we have a bunch of
non-standard schemes that arrive before an official standard shows up.  While I
don't really see any reason to do anything differently for an arbitrary idle
driver, it's impossible to reason about that sort of thing without some user of
the code.

So essentially: I'd be happy to take this if something used it, but without a
user I don't really see how I can.

Sorry!

>
>> +}
>> +
>> +static struct cpuidle_driver riscv_idle_driver = {
>> +       .name                   = "riscv_idle",
>> +       .owner                  = THIS_MODULE,
>> +       .states[0]              = {
>> +               .enter                  = riscv_enter_idle,
>> +               .exit_latency           = 1,
>> +               .target_residency       = 1,
>> +               .name                   = "WFI",
>> +               .desc                   = "RISCV WFI",
>> +       },
>> +       .state_count = MAX_IDLE_STATES,
>> +};
>> +
>> +static int __init riscv_cpuidle_init(void)
>> +{
>> +       return cpuidle_register(&riscv_idle_driver, NULL);
>> +}
>> +
>> +device_initcall(riscv_cpuidle_init);
>> --
