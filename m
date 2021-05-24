Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20AE38F2B1
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 20:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhEXSDW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 14:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhEXSDW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 14:03:22 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1771C061756
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 11:01:53 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id f20so5611569uax.6
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Yts7qQiY5cVw+gZuSHeCN8lE/arX6Qto1/OwLEXAhQ=;
        b=H8BM+oDJsRf44M+gFJkkX2QGVohKPWVfWWJU1mhWKhdIAEex/y5Apwy3ws0LA6RZyi
         6WnwtyNXX+DOUwTZSzorRoijv7lG0bmMnBRaGIkcCaoKmNIIngJHaeJm+gWvkADlTnX6
         SMrzNlrJWO25a0iSaOrEJWWo0PzSp6eAMvxpc7k7v4OrARj2Fg/NJkS9tYYMhFlE7frh
         pBipM/2BBB75n9EseQ9DXqjJrBVWZ9eTAUPph4y3yvHa4C6eDqQyrVxDSBnh3sLXG2JK
         BlL8LVo2mGZLNKqM8rm1n8F4ahX4fi67nCHB5iam3AIvB7K97PmRBIlxzXzwAX/EqoGm
         qLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Yts7qQiY5cVw+gZuSHeCN8lE/arX6Qto1/OwLEXAhQ=;
        b=OC7ww+jtGWfNeKZ9xITECY9ZpnThsLrTBipP6Jh6xPehchslMLBNzvFwX3Aqj7fzLi
         8kAW8FY5B/oqOunYTaS3xPH7/8HPHom+pQbBwp6qW64PTX9wzJnwcVknS+GUQdtQHPkR
         fDeWOxJSUP7XcjEbSNC7tbs56ESl52XGjl6FKAq1K9XXorquEMgAIcnE/2R6sPh5dB7S
         EbE7GsQ4Jp6rwoKLOAMQLt3fgqNHjN4pPXkabRCR8XVdyF6J3vqIPb9jUWxEjSJQfhKE
         4eHyc0zkz/rC3nclYnGsCASQMkgPRiBRrkrGhnesbeQ5gmVDH4riaoVRYZtc/M3sndnk
         4YrA==
X-Gm-Message-State: AOAM533DqnJbg2UoLVGpWRDPWYL4nb5lEfCDF0IJrzNegf4/+wZitd74
        4NKR+smHfTUroYOVLF18GI5tSanZC3vGwxuTOD8TuA==
X-Google-Smtp-Source: ABdhPJzldT2KtNW5LanITjVVU8o7Tu39YI61SMrwMRReheJzUy03Rj2D1eZAzB04TnuGNIFPO+/hkePdl+GMFf+OCc0=
X-Received: by 2002:a9f:24b4:: with SMTP id 49mr14197782uar.100.1621879313042;
 Mon, 24 May 2021 11:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210517130823.796963-1-anup.patel@wdc.com> <20210517130823.796963-6-anup.patel@wdc.com>
In-Reply-To: <20210517130823.796963-6-anup.patel@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 20:01:16 +0200
Message-ID: <CAPDyKFpxx-jBbL4o_iJCcivFL2ei5a7PcWVfUaBmLu-q89Mkjg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/8] cpuidle: Factor-out power domain related code
 from PSCI domain driver
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 17 May 2021 at 15:10, Anup Patel <anup.patel@wdc.com> wrote:
>
> The generic power domain related code in PSCI domain driver is largely
> independent of PSCI and can be shared with RISC-V SBI domain driver
> hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

This is clearly a big step in the right direction. Just a couple minor
things, see more below.

Note that, I have a couple of patches in the pipe for the
cpuidle-psci-domain driver (not ready to be posted). I need a couple
of more days to confirm this restructuring still makes sense beyond
these potential new changes. I will let you know as soon as I can with
the outcome.

[...]

> diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c

I think it would be a good idea to add a new section for this to the
MAINTAINERS file. Perhaps a "DT IDLE DOMAIN" section? Or perhaps you
have another idea?

In any case, I am happy to continue with maintenance of this code,
even in the new restructured form.

> new file mode 100644
> index 000000000000..5a901773db60
> --- /dev/null
> +++ b/drivers/cpuidle/dt_idle_genpd.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PM domains for CPUs via genpd.
> + *
> + * Copyright (C) 2019 Linaro Ltd.
> + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> + *
> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> + */
> +
> +#define pr_fmt(fmt) "dt-idle-genpd: " fmt
> +
> +#include <linux/cpu.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include "dt_idle_genpd.h"
> +
> +static int dt_pd_parse_state_nodes(
> +                       int (*parse_state)(struct device_node *, u32 *),
> +                       struct genpd_power_state *states, int state_count)
> +{
> +       int i, ret;
> +       u32 state, *state_buf;
> +
> +       for (i = 0; i < state_count; i++) {
> +               ret = parse_state(to_of_node(states[i].fwnode), &state);
> +               if (ret)
> +                       goto free_state;
> +
> +               state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
> +               if (!state_buf) {
> +                       ret = -ENOMEM;
> +                       goto free_state;
> +               }
> +               *state_buf = state;
> +               states[i].data = state_buf;
> +       }
> +
> +       return 0;
> +
> +free_state:
> +       i--;
> +       for (; i >= 0; i--)
> +               kfree(states[i].data);
> +       return ret;
> +}
> +
> +static int dt_pd_parse_states(struct device_node *np,
> +                       int (*parse_state)(struct device_node *, u32 *),
> +                       struct genpd_power_state **states,
> +                       int *state_count)
> +{
> +       int ret;
> +
> +       /* Parse the domain idle states. */
> +       ret = of_genpd_parse_idle_states(np, states, state_count);
> +       if (ret)
> +               return ret;
> +
> +       /* Fill out the dt specifics for each found state. */
> +       ret = dt_pd_parse_state_nodes(parse_state, *states, *state_count);
> +       if (ret)
> +               kfree(*states);
> +
> +       return ret;
> +}
> +
> +static void dt_pd_free_states(struct genpd_power_state *states,
> +                             unsigned int state_count)
> +{
> +       int i;
> +
> +       for (i = 0; i < state_count; i++)
> +               kfree(states[i].data);
> +       kfree(states);
> +}
> +
> +void dt_pd_free(struct generic_pm_domain *pd)
> +{
> +       dt_pd_free_states(pd->states, pd->state_count);
> +       kfree(pd->name);
> +       kfree(pd);
> +}
> +EXPORT_SYMBOL_GPL(dt_pd_free);
> +
> +struct generic_pm_domain *dt_pd_alloc(struct device_node *np,
> +                       int (*parse_state)(struct device_node *, u32 *))
> +{
> +       struct generic_pm_domain *pd;
> +       struct genpd_power_state *states = NULL;
> +       int ret, state_count = 0;
> +
> +       pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               goto out;
> +
> +       pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
> +       if (!pd->name)
> +               goto free_pd;
> +
> +       /*
> +        * Parse the domain idle states and let genpd manage the state selection
> +        * for those being compatible with "domain-idle-state".
> +        */
> +       ret = dt_pd_parse_states(np, parse_state, &states, &state_count);
> +       if (ret)
> +               goto free_name;
> +
> +       pd->free_states = dt_pd_free_states;
> +       pd->name = kbasename(pd->name);
> +       pd->states = states;
> +       pd->state_count = state_count;
> +
> +       pr_debug("alloc PM domain %s\n", pd->name);
> +       return pd;
> +
> +free_name:
> +       kfree(pd->name);
> +free_pd:
> +       kfree(pd);
> +out:
> +       pr_err("failed to alloc PM domain %pOF\n", np);
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(dt_pd_alloc);
> +
> +int dt_pd_init_topology(struct device_node *np)
> +{
> +       struct device_node *node;
> +       struct of_phandle_args child, parent;
> +       int ret;
> +
> +       for_each_child_of_node(np, node) {
> +               if (of_parse_phandle_with_args(node, "power-domains",
> +                                       "#power-domain-cells", 0, &parent))
> +                       continue;
> +
> +               child.np = node;
> +               child.args_count = 0;
> +               ret = of_genpd_add_subdomain(&parent, &child);
> +               of_node_put(parent.np);
> +               if (ret) {
> +                       of_node_put(node);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dt_pd_init_topology);

May I suggest that we stick to dt_idle_* as the prefix for all of the
exported functions in this file. Static functions can just skip the
prefix altogether.

> +
> +struct device *dt_idle_genpd_attach_cpu(int cpu, const char *name)
> +{
> +       struct device *dev;
> +
> +       dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), name);
> +       if (IS_ERR_OR_NULL(dev))
> +               return dev;
> +
> +       pm_runtime_irq_safe(dev);
> +       if (cpu_online(cpu))
> +               pm_runtime_get_sync(dev);
> +
> +       dev_pm_syscore_device(dev, true);
> +
> +       return dev;
> +}
> +EXPORT_SYMBOL_GPL(dt_idle_genpd_attach_cpu);
> +
> +void dt_idle_genpd_detach_cpu(struct device *dev)
> +{
> +       if (IS_ERR_OR_NULL(dev))
> +               return;
> +
> +       dev_pm_domain_detach(dev, false);
> +}
> +EXPORT_SYMBOL_GPL(dt_idle_genpd_detach_cpu);

Again, a minor comment on the naming of the functions. How about
skipping "genpd" in the prefix, thus just dt_idle_attach|detach_cpu()?

[...]

Kind regards
Uffe
