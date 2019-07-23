Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26B171A09
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfGWOPc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 10:15:32 -0400
Received: from foss.arm.com ([217.140.110.172]:55520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfGWOPc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 10:15:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B61828;
        Tue, 23 Jul 2019 07:15:31 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA2173F71F;
        Tue, 23 Jul 2019 07:15:29 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:15:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/6] ARM: psci: cpuidle: Introduce PSCI CPUidle driver
Message-ID: <20190723141524.GA22025@e121166-lin.cambridge.arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
 <20190722153745.32446-5-lorenzo.pieralisi@arm.com>
 <CAPDyKFppc32r=3w3g5nmHWDR5qR1vxsYjQ1b_GQoc_Gk=ni24A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFppc32r=3w3g5nmHWDR5qR1vxsYjQ1b_GQoc_Gk=ni24A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 01:46:56PM +0200, Ulf Hansson wrote:
> [...]
> 
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -0,0 +1,150 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PSCI CPU idle driver.
> > + *
> > + * Copyright (C) 2019 ARM Ltd.
> > + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > + */
> > +
> > +#define pr_fmt(fmt) "CPUidle PSCI: " fmt
> > +
> > +#include <linux/cpuidle.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/cpu_pm.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/psci.h>
> > +#include <linux/slab.h>
> > +
> > +#include <asm/cpuidle.h>
> 
> This should go away, right?

We need to pull in cpu_do_idle() so it will have to stay there.

> > +#include "dt_idle_states.h"
> > +
> > +static int psci_enter_idle_state(struct cpuidle_device *dev,
> > +                               struct cpuidle_driver *drv, int idx)
> > +{
> > +       return CPU_PM_CPU_IDLE_ENTER(psci_cpu_suspend_enter, idx);
> > +}
> > +
> > +static struct cpuidle_driver psci_idle_driver __initdata = {
> > +       .name = "psci_idle",
> > +       .owner = THIS_MODULE,
> > +       /*
> > +        * PSCI idle states relies on architectural WFI to
> > +        * be represented as state index 0.
> > +        */
> > +       .states[0] = {
> > +               .enter                  = psci_enter_idle_state,
> > +               .exit_latency           = 1,
> > +               .target_residency       = 1,
> > +               .power_usage            = UINT_MAX,
> > +               .name                   = "WFI",
> > +               .desc                   = "ARM WFI",
> > +       }
> > +};
> > +
> > +static const struct of_device_id psci_idle_state_match[] __initconst = {
> > +       { .compatible = "arm,idle-state",
> > +         .data = psci_enter_idle_state },
> > +       { },
> > +};
> > +
> > +static int __init psci_idle_init_cpu(int cpu)
> > +{
> > +       struct cpuidle_driver *drv;
> > +       struct device_node *cpu_node;
> > +       const char *enable_method;
> > +       int ret = 0;
> > +
> > +       drv = kmemdup(&psci_idle_driver, sizeof(*drv), GFP_KERNEL);
> > +       if (!drv)
> > +               return -ENOMEM;
> > +
> > +       drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> > +
> > +       cpu_node = of_get_cpu_node(cpu, NULL);
> > +       if (!cpu_node)
> > +               return -ENODEV;
> 
> You should free drv in case of error here (goto out_kfree_drv; etc).
> 
> > +
> > +       /*
> > +        * Check whether the enable-method for the cpu is PSCI, fail
> > +        * if it is not.
> > +        */
> > +       enable_method = of_get_property(cpu_node, "enable-method", NULL);
> > +       if (!enable_method || (strcmp(enable_method, "psci")))
> > +               ret = -ENODEV;
> > +
> > +       of_node_put(cpu_node);
> > +       if (ret)
> > +               return ret;
> 
> You should free drv in case of error here (goto out_kfree_drv;).

True on both cases, I missed that, thanks.

Lorenzo

> > +
> > +       /*
> > +        * Initialize idle states data, starting at index 1, since
> > +        * by default idle state 0 is the quiescent state reached
> > +        * by the cpu by executing the wfi instruction.
> > +        *
> > +        * If no DT idle states are detected (ret == 0) let the driver
> > +        * initialization fail accordingly since there is no reason to
> > +        * initialize the idle driver if only wfi is supported, the
> > +        * default archictectural back-end already executes wfi
> > +        * on idle entry.
> > +        */
> > +       ret = dt_init_idle_driver(drv, psci_idle_state_match, 1);
> > +       if (ret <= 0) {
> > +               ret = ret ? : -ENODEV;
> > +               goto out_kfree_drv;
> > +       }
> > +
> > +       /*
> > +        * Initialize PSCI idle states.
> > +        */
> > +       ret = psci_cpu_init_idle(cpu);
> > +       if (ret) {
> > +               pr_err("CPU %d failed to PSCI idle\n", cpu);
> > +               goto out_kfree_drv;
> > +       }
> > +
> > +       ret = cpuidle_register(drv, NULL);
> > +       if (ret)
> > +               goto out_kfree_drv;
> > +
> > +       return 0;
> > +
> > +out_kfree_drv:
> > +       kfree(drv);
> > +       return ret;
> > +}
> > +
> 
> [...]
> 
> Kind regards
> Uffe
