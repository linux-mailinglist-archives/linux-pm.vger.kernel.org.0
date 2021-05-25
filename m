Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701D438F9FF
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 07:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhEYFlC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 01:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhEYFlB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 01:41:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49442C061756
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 22:39:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z17so30737145wrq.7
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 22:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQiX/rQDAoKlbFuUGF3PSR+oQN5hRwJFo9Bkf8URLIk=;
        b=swljZTkozfJKaBoih9exTUXxqih582ijHRewXuKt1qmE88o78KJZkY/zGuFg1US/Nh
         2MDTrSf79z5K9N2imkJbnhVC9R8ecG6t/8fh6rMeLKQPBjL9xtgE/BDfsywU2AIvfOn2
         Gmk1ifact4m3P0F1HVhGvqwDgAPBgFNC1W5moBzZEDfd3encZX5qXuyYQtRjvcZaVCV+
         CnHxE4banq8ZoelswFk9YQDt6IcEJrYqO51A8x6iY///aJ4+9MGEGpBZWRRsrHz+koGX
         fS7OzkNLHe3hvMgUn68DQ+dfdPTzfSZQe/eJ2pLVJqvI7aGuR46dXp0njZkZ+pAC/S91
         cDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQiX/rQDAoKlbFuUGF3PSR+oQN5hRwJFo9Bkf8URLIk=;
        b=DGKjHpliydO05E+2nRxNSKZVvYgKtRNszzcTI9GT/BJKLDGVjS9xtmz56PYnZwuJA3
         ko86QN2exj36ZUmoVAJCGts+qHuBEUhH53lcz7AIAxAdGHmwR3jMdIG3GliKMDQeAHU4
         f/w6ZswuVQE+cGafA651cZP1J5SQldnw4jqqIxZjY/wY9TjtWSdymIxHb4JmuIgylI/S
         CTbx+IbmnEVaOUE8hosdiBTevaxkpL2oxQf/KIoxfpUUMbUWPo6tcK9OKOXMcXhVplcX
         l3FCHCG1cQBbm+4ay8AZ7uGFmV3VpcPi9n7MpYeadw5zqsbFVq3z1tFKwkq/2nes/2y2
         cKig==
X-Gm-Message-State: AOAM5325bG40oTXX9GnQveXKuBuo02hktmmEyKYKje/JzCQzpZSTkCFe
        22OMRPYKOulEISPgsjD+U7BJXb8i5WQ+ojrDYHQMFA==
X-Google-Smtp-Source: ABdhPJyBgMoZRcFrFb6b8bdZS6V3TxmteE0u5AEexQOZc501tkOujoVNGZfR3Vqd+MuBm9VOvVL5cVaBBDZE1wmDGLw=
X-Received: by 2002:adf:e38c:: with SMTP id e12mr24819885wrm.128.1621921168743;
 Mon, 24 May 2021 22:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210517130823.796963-1-anup.patel@wdc.com> <20210517130823.796963-6-anup.patel@wdc.com>
 <CAPDyKFpxx-jBbL4o_iJCcivFL2ei5a7PcWVfUaBmLu-q89Mkjg@mail.gmail.com>
In-Reply-To: <CAPDyKFpxx-jBbL4o_iJCcivFL2ei5a7PcWVfUaBmLu-q89Mkjg@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 25 May 2021 11:09:17 +0530
Message-ID: <CAAhSdy1quHePY_HM875LHQgXGKrjm24SzeD5yFJUnqunpcHd8g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/8] cpuidle: Factor-out power domain related code
 from PSCI domain driver
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 24, 2021 at 11:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 17 May 2021 at 15:10, Anup Patel <anup.patel@wdc.com> wrote:
> >
> > The generic power domain related code in PSCI domain driver is largely
> > independent of PSCI and can be shared with RISC-V SBI domain driver
> > hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>
> This is clearly a big step in the right direction. Just a couple minor
> things, see more below.
>
> Note that, I have a couple of patches in the pipe for the
> cpuidle-psci-domain driver (not ready to be posted). I need a couple
> of more days to confirm this restructuring still makes sense beyond
> these potential new changes. I will let you know as soon as I can with
> the outcome.

Sure, I will wait for more comments from you. I was thinking of sending
next revision of patches sometime next week with the renaming of
function names which you suggested.

>
> [...]
>
> > diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
>
> I think it would be a good idea to add a new section for this to the
> MAINTAINERS file. Perhaps a "DT IDLE DOMAIN" section? Or perhaps you
> have another idea?
>
> In any case, I am happy to continue with maintenance of this code,
> even in the new restructured form.

Yes, a separate "DT IDLE DOMAIN" section in MAINTAINERS file
sounds good to me.

Anyway the dt_idle_genpd is factored-out code from cpuidle-psci-domain.c
so I suggest you to maintain dt_idle_genpd as well.

Do you want me to add a "DT IDLE DOMAIN" section in the
MAINTAINERS file as part of this patch ??

>
> > new file mode 100644
> > index 000000000000..5a901773db60
> > --- /dev/null
> > +++ b/drivers/cpuidle/dt_idle_genpd.c
> > @@ -0,0 +1,182 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PM domains for CPUs via genpd.
> > + *
> > + * Copyright (C) 2019 Linaro Ltd.
> > + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> > + *
> > + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#define pr_fmt(fmt) "dt-idle-genpd: " fmt
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +
> > +#include "dt_idle_genpd.h"
> > +
> > +static int dt_pd_parse_state_nodes(
> > +                       int (*parse_state)(struct device_node *, u32 *),
> > +                       struct genpd_power_state *states, int state_count)
> > +{
> > +       int i, ret;
> > +       u32 state, *state_buf;
> > +
> > +       for (i = 0; i < state_count; i++) {
> > +               ret = parse_state(to_of_node(states[i].fwnode), &state);
> > +               if (ret)
> > +                       goto free_state;
> > +
> > +               state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
> > +               if (!state_buf) {
> > +                       ret = -ENOMEM;
> > +                       goto free_state;
> > +               }
> > +               *state_buf = state;
> > +               states[i].data = state_buf;
> > +       }
> > +
> > +       return 0;
> > +
> > +free_state:
> > +       i--;
> > +       for (; i >= 0; i--)
> > +               kfree(states[i].data);
> > +       return ret;
> > +}
> > +
> > +static int dt_pd_parse_states(struct device_node *np,
> > +                       int (*parse_state)(struct device_node *, u32 *),
> > +                       struct genpd_power_state **states,
> > +                       int *state_count)
> > +{
> > +       int ret;
> > +
> > +       /* Parse the domain idle states. */
> > +       ret = of_genpd_parse_idle_states(np, states, state_count);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Fill out the dt specifics for each found state. */
> > +       ret = dt_pd_parse_state_nodes(parse_state, *states, *state_count);
> > +       if (ret)
> > +               kfree(*states);
> > +
> > +       return ret;
> > +}
> > +
> > +static void dt_pd_free_states(struct genpd_power_state *states,
> > +                             unsigned int state_count)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < state_count; i++)
> > +               kfree(states[i].data);
> > +       kfree(states);
> > +}
> > +
> > +void dt_pd_free(struct generic_pm_domain *pd)
> > +{
> > +       dt_pd_free_states(pd->states, pd->state_count);
> > +       kfree(pd->name);
> > +       kfree(pd);
> > +}
> > +EXPORT_SYMBOL_GPL(dt_pd_free);
> > +
> > +struct generic_pm_domain *dt_pd_alloc(struct device_node *np,
> > +                       int (*parse_state)(struct device_node *, u32 *))
> > +{
> > +       struct generic_pm_domain *pd;
> > +       struct genpd_power_state *states = NULL;
> > +       int ret, state_count = 0;
> > +
> > +       pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> > +       if (!pd)
> > +               goto out;
> > +
> > +       pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
> > +       if (!pd->name)
> > +               goto free_pd;
> > +
> > +       /*
> > +        * Parse the domain idle states and let genpd manage the state selection
> > +        * for those being compatible with "domain-idle-state".
> > +        */
> > +       ret = dt_pd_parse_states(np, parse_state, &states, &state_count);
> > +       if (ret)
> > +               goto free_name;
> > +
> > +       pd->free_states = dt_pd_free_states;
> > +       pd->name = kbasename(pd->name);
> > +       pd->states = states;
> > +       pd->state_count = state_count;
> > +
> > +       pr_debug("alloc PM domain %s\n", pd->name);
> > +       return pd;
> > +
> > +free_name:
> > +       kfree(pd->name);
> > +free_pd:
> > +       kfree(pd);
> > +out:
> > +       pr_err("failed to alloc PM domain %pOF\n", np);
> > +       return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(dt_pd_alloc);
> > +
> > +int dt_pd_init_topology(struct device_node *np)
> > +{
> > +       struct device_node *node;
> > +       struct of_phandle_args child, parent;
> > +       int ret;
> > +
> > +       for_each_child_of_node(np, node) {
> > +               if (of_parse_phandle_with_args(node, "power-domains",
> > +                                       "#power-domain-cells", 0, &parent))
> > +                       continue;
> > +
> > +               child.np = node;
> > +               child.args_count = 0;
> > +               ret = of_genpd_add_subdomain(&parent, &child);
> > +               of_node_put(parent.np);
> > +               if (ret) {
> > +                       of_node_put(node);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dt_pd_init_topology);
>
> May I suggest that we stick to dt_idle_* as the prefix for all of the
> exported functions in this file. Static functions can just skip the
> prefix altogether.

Sure, I will update the function names like you suggested in next
patch revision.

>
> > +
> > +struct device *dt_idle_genpd_attach_cpu(int cpu, const char *name)
> > +{
> > +       struct device *dev;
> > +
> > +       dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), name);
> > +       if (IS_ERR_OR_NULL(dev))
> > +               return dev;
> > +
> > +       pm_runtime_irq_safe(dev);
> > +       if (cpu_online(cpu))
> > +               pm_runtime_get_sync(dev);
> > +
> > +       dev_pm_syscore_device(dev, true);
> > +
> > +       return dev;
> > +}
> > +EXPORT_SYMBOL_GPL(dt_idle_genpd_attach_cpu);
> > +
> > +void dt_idle_genpd_detach_cpu(struct device *dev)
> > +{
> > +       if (IS_ERR_OR_NULL(dev))
> > +               return;
> > +
> > +       dev_pm_domain_detach(dev, false);
> > +}
> > +EXPORT_SYMBOL_GPL(dt_idle_genpd_detach_cpu);
>
> Again, a minor comment on the naming of the functions. How about
> skipping "genpd" in the prefix, thus just dt_idle_attach|detach_cpu()?

Sure, I will update.

>
> [...]
>
> Kind regards
> Uffe

Regards,
Anup
