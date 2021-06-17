Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E753AAE8D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhFQISJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 04:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFQISI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 04:18:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E641AC061760
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 01:16:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r9so5667979wrz.10
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 01:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfskPmAIRnS3iX9fqtL2aWQXR29mfIxsosBxoKQPIp8=;
        b=T7NV0LBGmKv2Ah8Z5Wp4lIIPHzw0HsoGek4qLp8QyvOeyjT7/l2ErTdUvcnflx1VTm
         yYDVO6P+fwrzCrXLiA+DkV6kuTHOwFdg3y7lJymueoBmO6ooP0YxCEmYo48YOoYyRpj9
         n9C8Bej3Z77tvUIFJh3V+LVY01wNUnHzEAWgMxRdcEU32ZyLqoNKgR0AIJgssblYIV0I
         uXpcClk3Olx9oj7sNNq29OPao+JTCRM1UNFT0dl+mH5tJXGGFgg1xiFTm73GDw00BO1l
         kxu1y+8igBUNkfFbv/4y/P3a6iub98lKDt8a4wBOUKIl4+fBRQQqeqmlFg1CkN0c0lik
         w2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfskPmAIRnS3iX9fqtL2aWQXR29mfIxsosBxoKQPIp8=;
        b=Y4yyWK11XUk4dNEv4GQl5Z2t98zfWSxn41lT9ex69B3FNz0NUq2NXcgxxIbCb6ZTrq
         1BMtqAsBypC1ut6ddhawgEBHORZOcrIKNFNb84GMBCs0LmZR3jgJyq8bXP3s82FIkW6V
         EOM6BA0PztjNmxHft0APVOKORDfrxNTl2iAjQ3g0AXFq8mriB7WtpX3c58aEo1vV+gUJ
         4PnRtV/Us7nyxxS+cbNxTDdPVyUdBFZ85huQwLiwlwMbLOYpX0UHlpttE2/UlIi7FGNF
         fNTM8ClOuMJZP4XQMV9Hd2Z9SisMLDf78oqS9MLhr5J0OfEfwbogyTKWiyq6uP+Uq1ZS
         EmAQ==
X-Gm-Message-State: AOAM5324Yv8MohP+v2e7/OnO/Eyv69dAbSRvY0np8yGx7LSL8LqrIBhB
        I2CNObOBRm0euCZBH1P9FV2HtfwoARDn7BjCpZKg9w==
X-Google-Smtp-Source: ABdhPJw6HXgh51X6WWS1RJXrglFng/2amIVGXJa8HJ/yfNUjyv7LddB8/72Gl5MuejIlIq0hzcSpTnV2hLVMv1Kn9D8=
X-Received: by 2002:adf:efc3:: with SMTP id i3mr4163094wrp.356.1623917759082;
 Thu, 17 Jun 2021 01:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210610052221.39958-1-anup.patel@wdc.com> <20210610052221.39958-7-anup.patel@wdc.com>
 <CAJZ5v0hjOVqAcMrxA5tAu_VD9g7rRJXgr_h+0SQrJQM52XUrSg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hjOVqAcMrxA5tAu_VD9g7rRJXgr_h+0SQrJQM52XUrSg@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 17 Jun 2021 13:45:47 +0530
Message-ID: <CAAhSdy0EK6LT78PegYq6M1cJ+qCznHF_WpQtjE-dzB_T28phHw@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] cpuidle: Add RISC-V SBI CPU idle driver
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 16, 2021 at 11:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 10, 2021 at 7:23 AM Anup Patel <anup.patel@wdc.com> wrote:
> >
> > The RISC-V SBI HSM extension provides HSM suspend call which can
> > be used by Linux RISC-V to enter platform specific low-power state.
> >
> > This patch adds a CPU idle driver based on RISC-V SBI calls which
> > will populate idle states from device tree and use SBI calls to
> > entry these idle states.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  MAINTAINERS                   |   7 +
> >  drivers/cpuidle/Kconfig       |   5 +
> >  drivers/cpuidle/Kconfig.riscv |  15 +
> >  drivers/cpuidle/Makefile      |   4 +
> >  drivers/cpuidle/cpuidle-sbi.c | 626 ++++++++++++++++++++++++++++++++++
>
> Maybe call this cpuidle-riscv-sbi.c to avoid possible confusion.

Just like PSCI in the ARM world we have SBI in the RISC-V world.

I feel cpuilde-sbi.c is more appropriate and consistent with naming
followed by cpuidle-psci.c

>
> >  5 files changed, 657 insertions(+)
> >  create mode 100644 drivers/cpuidle/Kconfig.riscv
> >  create mode 100644 drivers/cpuidle/cpuidle-sbi.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5108b5058502..a16b14c687b5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4796,6 +4796,13 @@ S:       Supported
> >  F:     drivers/cpuidle/dt_idle_genpd.c
> >  F:     drivers/cpuidle/dt_idle_genpd.h
> >
> > +CPUIDLE DRIVER - RISC-V SBI
> > +M:     Anup Patel <anup.patel@wdc.com>
> > +L:     linux-pm@vger.kernel.org
> > +L:     linux-riscv@lists.infradead.org
> > +S:     Supported
> > +F:     drivers/cpuidle/cpuidle-sbi.c
> > +
> >  CRAMFS FILESYSTEM
> >  M:     Nicolas Pitre <nico@fluxnic.net>
> >  S:     Maintained
> > diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> > index f1afe7ab6b54..ff71dd662880 100644
> > --- a/drivers/cpuidle/Kconfig
> > +++ b/drivers/cpuidle/Kconfig
> > @@ -66,6 +66,11 @@ depends on PPC
> >  source "drivers/cpuidle/Kconfig.powerpc"
> >  endmenu
> >
> > +menu "RISC-V CPU Idle Drivers"
> > +depends on RISCV
> > +source "drivers/cpuidle/Kconfig.riscv"
> > +endmenu
> > +
> >  config HALTPOLL_CPUIDLE
> >         tristate "Halt poll cpuidle driver"
> >         depends on X86 && KVM_GUEST
> > diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
> > new file mode 100644
> > index 000000000000..78518c26af74
> > --- /dev/null
> > +++ b/drivers/cpuidle/Kconfig.riscv
> > @@ -0,0 +1,15 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# RISC-V CPU Idle drivers
> > +#
> > +
> > +config RISCV_SBI_CPUIDLE
> > +       bool "RISC-V SBI CPU idle Driver"
> > +       depends on RISCV_SBI
> > +       select DT_IDLE_STATES
> > +       select CPU_IDLE_MULTIPLE_DRIVERS
> > +       select DT_IDLE_GENPD if PM_GENERIC_DOMAINS_OF
> > +       help
> > +         Select this option to enable RISC-V SBI firmware based CPU idle
> > +         driver for RISC-V systems. This drivers also supports hierarchical
> > +         DT based layout of the idle state.
> > diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> > index 11a26cef279f..a36922c18510 100644
> > --- a/drivers/cpuidle/Makefile
> > +++ b/drivers/cpuidle/Makefile
> > @@ -35,3 +35,7 @@ obj-$(CONFIG_MIPS_CPS_CPUIDLE)                += cpuidle-cps.o
> >  # POWERPC drivers
> >  obj-$(CONFIG_PSERIES_CPUIDLE)          += cpuidle-pseries.o
> >  obj-$(CONFIG_POWERNV_CPUIDLE)          += cpuidle-powernv.o
> > +
> > +###############################################################################
> > +# RISC-V drivers
> > +obj-$(CONFIG_RISCV_SBI_CPUIDLE)                += cpuidle-sbi.o
> > diff --git a/drivers/cpuidle/cpuidle-sbi.c b/drivers/cpuidle/cpuidle-sbi.c
> > new file mode 100644
> > index 000000000000..286172b0368d
> > --- /dev/null
> > +++ b/drivers/cpuidle/cpuidle-sbi.c
> > @@ -0,0 +1,626 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * RISC-V SBI CPU idle driver.
> > + *
> > + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#define pr_fmt(fmt) "cpuidle-sbi: " fmt
> > +
> > +#include <linux/cpuidle.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/cpu_pm.h>
> > +#include <linux/cpu_cooling.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/pm_runtime.h>
> > +#include <asm/cpuidle.h>
> > +#include <asm/sbi.h>
> > +#include <asm/suspend.h>
> > +
> > +#include "dt_idle_states.h"
> > +#include "dt_idle_genpd.h"
> > +
> > +struct sbi_cpuidle_data {
> > +       u32 *states;
> > +       struct device *dev;
> > +};
> > +
> > +struct sbi_domain_state {
> > +       bool available;
> > +       u32 state;
> > +};
> > +
> > +static DEFINE_PER_CPU_READ_MOSTLY(struct sbi_cpuidle_data, sbi_cpuidle_data);
> > +static DEFINE_PER_CPU(struct sbi_domain_state, domain_state);
> > +static bool sbi_cpuidle_use_osi;
> > +static bool sbi_cpuidle_use_cpuhp;
> > +static bool sbi_cpuidle_pd_allow_domain_state;
> > +
> > +static inline void sbi_set_domain_state(u32 state)
> > +{
> > +       struct sbi_domain_state *data = this_cpu_ptr(&domain_state);
> > +
> > +       data->available = true;
> > +       data->state = state;
> > +}
> > +
> > +static inline u32 sbi_get_domain_state(void)
> > +{
> > +       struct sbi_domain_state *data = this_cpu_ptr(&domain_state);
> > +
> > +       return data->state;
> > +}
> > +
> > +static inline void sbi_clear_domain_state(void)
> > +{
> > +       struct sbi_domain_state *data = this_cpu_ptr(&domain_state);
> > +
> > +       data->available = false;
> > +}
> > +
> > +static inline bool sbi_is_domain_state_available(void)
> > +{
> > +       struct sbi_domain_state *data = this_cpu_ptr(&domain_state);
> > +
> > +       return data->available;
> > +}
> > +
> > +static int sbi_suspend_finisher(unsigned long suspend_type,
> > +                               unsigned long resume_addr,
> > +                               unsigned long opaque)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
> > +                       suspend_type, resume_addr, opaque, 0, 0, 0);
> > +
> > +       return (ret.error) ? sbi_err_map_linux_errno(ret.error) : 0;
> > +}
> > +
> > +static int sbi_suspend(u32 state)
> > +{
> > +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
> > +               return cpu_suspend(state, sbi_suspend_finisher);
> > +       else
> > +               return sbi_suspend_finisher(state, 0, 0);
> > +}
> > +
> > +static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
> > +                                  struct cpuidle_driver *drv, int idx)
> > +{
> > +       u32 *states = __this_cpu_read(sbi_cpuidle_data.states);
> > +
> > +       return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, states[idx]);
> > +}
> > +
> > +static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
> > +                                         struct cpuidle_driver *drv, int idx,
> > +                                         bool s2idle)
> > +{
> > +       struct sbi_cpuidle_data *data = this_cpu_ptr(&sbi_cpuidle_data);
> > +       u32 *states = data->states;
> > +       struct device *pd_dev = data->dev;
> > +       u32 state;
> > +       int ret;
> > +
> > +       ret = cpu_pm_enter();
> > +       if (ret)
> > +               return -1;
> > +
> > +       /* Do runtime PM to manage a hierarchical CPU toplogy. */
> > +       rcu_irq_enter_irqson();
> > +       if (s2idle)
> > +               dev_pm_genpd_suspend(pd_dev);
> > +       else
> > +               pm_runtime_put_sync_suspend(pd_dev);
> > +       rcu_irq_exit_irqson();
> > +
> > +       if (sbi_is_domain_state_available())
> > +               state = sbi_get_domain_state();
> > +       else
> > +               state = states[idx];
> > +
> > +       ret = sbi_suspend(state) ? -1 : idx;
> > +
> > +       rcu_irq_enter_irqson();
> > +       if (s2idle)
> > +               dev_pm_genpd_resume(pd_dev);
> > +       else
> > +               pm_runtime_get_sync(pd_dev);
> > +       rcu_irq_exit_irqson();
> > +
> > +       cpu_pm_exit();
> > +
> > +       /* Clear the domain state to start fresh when back from idle. */
> > +       sbi_clear_domain_state();
> > +       return ret;
> > +}
> > +
> > +static int sbi_enter_domain_idle_state(struct cpuidle_device *dev,
> > +                                      struct cpuidle_driver *drv, int idx)
> > +{
> > +       return __sbi_enter_domain_idle_state(dev, drv, idx, false);
> > +}
> > +
> > +static int sbi_enter_s2idle_domain_idle_state(struct cpuidle_device *dev,
> > +                                             struct cpuidle_driver *drv,
> > +                                             int idx)
> > +{
> > +       return __sbi_enter_domain_idle_state(dev, drv, idx, true);
> > +}
> > +
> > +static int sbi_cpuidle_cpuhp_up(unsigned int cpu)
> > +{
> > +       struct device *pd_dev = __this_cpu_read(sbi_cpuidle_data.dev);
> > +
> > +       if (pd_dev)
> > +               pm_runtime_get_sync(pd_dev);
> > +
> > +       return 0;
> > +}
> > +
> > +static int sbi_cpuidle_cpuhp_down(unsigned int cpu)
> > +{
> > +       struct device *pd_dev = __this_cpu_read(sbi_cpuidle_data.dev);
> > +
> > +       if (pd_dev) {
> > +               pm_runtime_put_sync(pd_dev);
> > +               /* Clear domain state to start fresh at next online. */
> > +               sbi_clear_domain_state();
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void sbi_idle_init_cpuhp(void)
> > +{
> > +       int err;
> > +
> > +       if (!sbi_cpuidle_use_cpuhp)
> > +               return;
> > +
> > +       err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
> > +                                       "cpuidle/sbi:online",
> > +                                       sbi_cpuidle_cpuhp_up,
> > +                                       sbi_cpuidle_cpuhp_down);
> > +       if (err)
> > +               pr_warn("Failed %d while setup cpuhp state\n", err);
> > +}
> > +
> > +static const struct of_device_id sbi_cpuidle_state_match[] = {
> > +       { .compatible = "riscv,idle-state",
> > +         .data = sbi_cpuidle_enter_state },
> > +       { },
> > +};
> > +
> > +static bool sbi_suspend_state_is_valid(u32 state)
> > +{
> > +       if (state > SBI_HSM_SUSPEND_RET_DEFAULT &&
> > +           state < SBI_HSM_SUSPEND_RET_PLATFORM)
> > +               return false;
> > +       if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
> > +           state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
> > +               return false;
> > +       return true;
> > +}
> > +
> > +static int sbi_dt_parse_state_node(struct device_node *np, u32 *state)
> > +{
> > +       int err = of_property_read_u32(np, "riscv,sbi-suspend-param", state);
> > +
> > +       if (err) {
> > +               pr_warn("%pOF missing riscv,sbi-suspend-param property\n", np);
> > +               return err;
> > +       }
> > +
> > +       if (!sbi_suspend_state_is_valid(*state)) {
> > +               pr_warn("Invalid SBI suspend state %#x\n", *state);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int sbi_dt_cpu_init_topology(struct cpuidle_driver *drv,
> > +                                    struct sbi_cpuidle_data *data,
> > +                                    unsigned int state_count, int cpu)
> > +{
> > +       /* Currently limit the hierarchical topology to be used in OSI mode. */
> > +       if (!sbi_cpuidle_use_osi)
> > +               return 0;
> > +
> > +       data->dev = dt_idle_attach_cpu(cpu, "sbi");
> > +       if (IS_ERR_OR_NULL(data->dev))
> > +               return PTR_ERR_OR_ZERO(data->dev);
> > +
> > +       /*
> > +        * Using the deepest state for the CPU to trigger a potential selection
> > +        * of a shared state for the domain, assumes the domain states are all
> > +        * deeper states.
> > +        */
> > +       drv->states[state_count - 1].enter = sbi_enter_domain_idle_state;
> > +       drv->states[state_count - 1].enter_s2idle =
> > +                                       sbi_enter_s2idle_domain_idle_state;
> > +       sbi_cpuidle_use_cpuhp = true;
> > +
> > +       return 0;
> > +}
> > +
> > +static int sbi_cpuidle_dt_init_states(struct device *dev,
> > +                                       struct cpuidle_driver *drv,
> > +                                       unsigned int cpu,
> > +                                       unsigned int state_count)
> > +{
> > +       struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
> > +       struct device_node *state_node;
> > +       struct device_node *cpu_node;
> > +       u32 *states;
> > +       int i, ret;
> > +
> > +       cpu_node = of_cpu_device_node_get(cpu);
> > +       if (!cpu_node)
> > +               return -ENODEV;
> > +
> > +       states = devm_kcalloc(dev, state_count, sizeof(*states), GFP_KERNEL);
> > +       if (!states) {
> > +               ret = -ENOMEM;
> > +               goto fail;
> > +       }
> > +
> > +       /* Parse SBI specific details from state DT nodes */
> > +       for (i = 1; i < state_count; i++) {
> > +               state_node = of_get_cpu_state_node(cpu_node, i - 1);
> > +               if (!state_node)
> > +                       break;
> > +
> > +               ret = sbi_dt_parse_state_node(state_node, &states[i]);
> > +               of_node_put(state_node);
> > +
> > +               if (ret)
> > +                       return ret;
> > +
> > +               pr_debug("sbi-state %#x index %d\n", states[i], i);
> > +       }
> > +       if (i != state_count) {
> > +               ret = -ENODEV;
> > +               goto fail;
> > +       }
> > +
> > +       /* Initialize optional data, used for the hierarchical topology. */
> > +       ret = sbi_dt_cpu_init_topology(drv, data, state_count, cpu);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       /* Store states in the per-cpu struct. */
> > +       data->states = states;
> > +
> > +fail:
> > +       of_node_put(cpu_node);
> > +
> > +       return ret;
> > +}
> > +
> > +static void sbi_cpuidle_deinit_cpu(int cpu)
> > +{
> > +       struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
> > +
> > +       dt_idle_detach_cpu(data->dev);
> > +       sbi_cpuidle_use_cpuhp = false;
> > +}
> > +
> > +static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
> > +{
> > +       struct cpuidle_driver *drv;
> > +       unsigned int state_count = 0;
> > +       int ret = 0;
> > +
> > +       drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> > +       if (!drv)
> > +               return -ENOMEM;
> > +
> > +       drv->name = "sbi_cpuidle";
> > +       drv->owner = THIS_MODULE;
> > +       drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> > +
> > +       /* RISC-V architectural WFI to be represented as state index 0. */
> > +       drv->states[0].enter = sbi_cpuidle_enter_state;
> > +       drv->states[0].exit_latency = 1;
> > +       drv->states[0].target_residency = 1;
> > +       drv->states[0].power_usage = UINT_MAX;
> > +       strcpy(drv->states[0].name, "WFI");
> > +       strcpy(drv->states[0].desc, "RISC-V WFI");
> > +
> > +       /*
> > +        * If no DT idle states are detected (ret == 0) let the driver
> > +        * initialization fail accordingly since there is no reason to
> > +        * initialize the idle driver if only wfi is supported, the
> > +        * default archictectural back-end already executes wfi
> > +        * on idle entry.
> > +        */
> > +       ret = dt_init_idle_driver(drv, sbi_cpuidle_state_match, 1);
> > +       if (ret <= 0) {
> > +               pr_debug("HART%ld: failed to parse DT idle states\n",
> > +                        cpuid_to_hartid_map(cpu));
> > +               return ret ? : -ENODEV;
> > +       }
> > +       state_count = ret + 1; /* Include WFI state as well */
> > +
> > +       /* Initialize idle states from DT. */
> > +       ret = sbi_cpuidle_dt_init_states(dev, drv, cpu, state_count);
> > +       if (ret) {
> > +               pr_err("HART%ld: failed to init idle states\n",
> > +                      cpuid_to_hartid_map(cpu));
> > +               return ret;
> > +       }
> > +
> > +       ret = cpuidle_register(drv, NULL);
> > +       if (ret)
> > +               goto deinit;
> > +
> > +       cpuidle_cooling_register(drv);
> > +
> > +       return 0;
> > +deinit:
> > +       sbi_cpuidle_deinit_cpu(cpu);
> > +       return ret;
> > +}
> > +
> > +static void sbi_cpuidle_domain_sync_state(struct device *dev)
> > +{
> > +       /*
> > +        * All devices have now been attached/probed to the PM domain
> > +        * topology, hence it's fine to allow domain states to be picked.
> > +        */
> > +       sbi_cpuidle_pd_allow_domain_state = true;
> > +}
> > +
> > +#ifdef CONFIG_DT_IDLE_GENPD
> > +
> > +static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
> > +{
> > +       struct genpd_power_state *state = &pd->states[pd->state_idx];
> > +       u32 *pd_state;
> > +
> > +       if (!state->data)
> > +               return 0;
> > +
> > +       if (!sbi_cpuidle_pd_allow_domain_state)
> > +               return -EBUSY;
> > +
> > +       /* OSI mode is enabled, set the corresponding domain state. */
> > +       pd_state = state->data;
> > +       sbi_set_domain_state(*pd_state);
> > +
> > +       return 0;
> > +}
> > +
> > +struct sbi_pd_provider {
> > +       struct list_head link;
> > +       struct device_node *node;
> > +};
> > +
> > +static LIST_HEAD(sbi_pd_providers);
> > +
> > +static int sbi_pd_init(struct device_node *np)
> > +{
> > +       struct generic_pm_domain *pd;
> > +       struct sbi_pd_provider *pd_provider;
> > +       struct dev_power_governor *pd_gov;
> > +       int ret = -ENOMEM, state_count = 0;
> > +
> > +       pd = dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
> > +       if (!pd)
> > +               goto out;
> > +
> > +       pd_provider = kzalloc(sizeof(*pd_provider), GFP_KERNEL);
> > +       if (!pd_provider)
> > +               goto free_pd;
> > +
> > +       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
> > +
> > +       /* Allow power off when OSI is available. */
> > +       if (sbi_cpuidle_use_osi)
> > +               pd->power_off = sbi_cpuidle_pd_power_off;
> > +       else
> > +               pd->flags |= GENPD_FLAG_ALWAYS_ON;
> > +
> > +       /* Use governor for CPU PM domains if it has some states to manage. */
> > +       pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
> > +
> > +       ret = pm_genpd_init(pd, pd_gov, false);
> > +       if (ret)
> > +               goto free_pd_prov;
> > +
> > +       ret = of_genpd_add_provider_simple(np, pd);
> > +       if (ret)
> > +               goto remove_pd;
> > +
> > +       pd_provider->node = of_node_get(np);
> > +       list_add(&pd_provider->link, &sbi_pd_providers);
> > +
> > +       pr_debug("init PM domain %s\n", pd->name);
> > +       return 0;
> > +
> > +remove_pd:
> > +       pm_genpd_remove(pd);
> > +free_pd_prov:
> > +       kfree(pd_provider);
> > +free_pd:
> > +       dt_idle_pd_free(pd);
> > +out:
> > +       pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
> > +       return ret;
> > +}
> > +
> > +static void sbi_pd_remove(void)
> > +{
> > +       struct sbi_pd_provider *pd_provider, *it;
> > +       struct generic_pm_domain *genpd;
> > +
> > +       list_for_each_entry_safe(pd_provider, it, &sbi_pd_providers, link) {
> > +               of_genpd_del_provider(pd_provider->node);
> > +
> > +               genpd = of_genpd_remove_last(pd_provider->node);
> > +               if (!IS_ERR(genpd))
> > +                       kfree(genpd);
> > +
> > +               of_node_put(pd_provider->node);
> > +               list_del(&pd_provider->link);
> > +               kfree(pd_provider);
> > +       }
> > +}
> > +
> > +static int sbi_genpd_probe(struct device_node *np)
> > +{
> > +       struct device_node *node;
> > +       int ret = 0, pd_count = 0;
> > +
> > +       if (!np)
> > +               return -ENODEV;
> > +
> > +       /*
> > +        * Parse child nodes for the "#power-domain-cells" property and
> > +        * initialize a genpd/genpd-of-provider pair when it's found.
> > +        */
> > +       for_each_child_of_node(np, node) {
> > +               if (!of_find_property(node, "#power-domain-cells", NULL))
> > +                       continue;
> > +
> > +               ret = sbi_pd_init(node);
> > +               if (ret)
> > +                       goto put_node;
> > +
> > +               pd_count++;
> > +       }
> > +
> > +       /* Bail out if not using the hierarchical CPU topology. */
> > +       if (!pd_count)
> > +               goto no_pd;
> > +
> > +       /* Link genpd masters/subdomains to model the CPU topology. */
> > +       ret = dt_idle_pd_init_topology(np);
> > +       if (ret)
> > +               goto remove_pd;
> > +
> > +       return 0;
> > +
> > +put_node:
> > +       of_node_put(node);
> > +remove_pd:
> > +       sbi_pd_remove();
> > +       pr_err("failed to create CPU PM domains ret=%d\n", ret);
> > +no_pd:
> > +       return ret;
> > +}
> > +
> > +#else
> > +
> > +static inline int sbi_genpd_probe(struct device_node *np)
> > +{
> > +       return 0;
> > +}
> > +
> > +#endif
> > +
> > +static int sbi_cpuidle_probe(struct platform_device *pdev)
> > +{
> > +       int cpu, ret;
> > +       struct cpuidle_driver *drv;
> > +       struct cpuidle_device *dev;
> > +       struct device_node *np, *pds_node;
> > +
> > +       /* Detect OSI support based on CPU DT nodes */
> > +       sbi_cpuidle_use_osi = true;
> > +       for_each_possible_cpu(cpu) {
> > +               np = of_cpu_device_node_get(cpu);
> > +               if (np &&
> > +                   of_find_property(np, "power-domains", NULL) &&
> > +                   of_find_property(np, "power-domain-names", NULL)) {
> > +                       continue;
> > +               } else {
> > +                       sbi_cpuidle_use_osi = false;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       /* Populate generic power domains from DT nodes */
> > +       pds_node = of_find_node_by_path("/cpus/power-domains");
> > +       if (pds_node) {
> > +               ret = sbi_genpd_probe(pds_node);
> > +               of_node_put(pds_node);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       /* Initialize CPU idle driver for each CPU */
>
> Why do you need a separate cpuidle driver for every CPU?

The SBI SUSPEND call is to be called separately for each CPU from the
CPU itself. This is similar to the PCSI CPU_SUSPEND call in the ARM world.

Regards,
Anup

>
> > +       for_each_possible_cpu(cpu) {
> > +               ret = sbi_cpuidle_init_cpu(&pdev->dev, cpu);
> > +               if (ret) {
> > +                       pr_debug("HART%ld: idle driver init failed\n",
> > +                                cpuid_to_hartid_map(cpu));
> > +                       goto out_fail;
> > +               }
> > +       }
> > +
> > +       /* Setup CPU hotplut notifiers */
> > +       sbi_idle_init_cpuhp();
> > +
> > +       pr_info("idle driver registered for all CPUs\n");
> > +
> > +       return 0;
> > +
> > +out_fail:
> > +       while (--cpu >= 0) {
> > +               dev = per_cpu(cpuidle_devices, cpu);
> > +               drv = cpuidle_get_cpu_driver(dev);
> > +               cpuidle_unregister(drv);
> > +               sbi_cpuidle_deinit_cpu(cpu);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static struct platform_driver sbi_cpuidle_driver = {
> > +       .probe = sbi_cpuidle_probe,
> > +       .driver = {
> > +               .name = "sbi-cpuidle",
> > +               .sync_state = sbi_cpuidle_domain_sync_state,
> > +       },
> > +};
> > +
> > +static int __init sbi_cpuidle_init(void)
> > +{
> > +       int ret;
> > +       struct platform_device *pdev;
> > +
> > +       /*
> > +        * The SBI HSM suspend function is only available when:
> > +        * 1) SBI version is 0.3 or higher
> > +        * 2) SBI HSM extension is available
> > +        */
> > +       if ((sbi_spec_version < sbi_mk_version(0, 3)) ||
> > +           sbi_probe_extension(SBI_EXT_HSM) <= 0) {
> > +               pr_info("HSM suspend not available\n");
> > +               return 0;
> > +       }
> > +
> > +       ret = platform_driver_register(&sbi_cpuidle_driver);
> > +       if (ret)
> > +               return ret;
> > +
> > +       pdev = platform_device_register_simple("sbi-cpuidle",
> > +                                               -1, NULL, 0);
> > +       if (IS_ERR(pdev)) {
> > +               platform_driver_unregister(&sbi_cpuidle_driver);
> > +               return PTR_ERR(pdev);
> > +       }
> > +
> > +       return 0;
> > +}
> > +device_initcall(sbi_cpuidle_init);
> > --
> > 2.25.1
> >
