Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527883609EA
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 15:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhDONDB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 09:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhDONC7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 09:02:59 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB66C061574
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 06:02:35 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id b18so6941932vso.7
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcSqexEt5vR6uCgCgMM5NKqwtfT9a0imIzkh/t+OwgI=;
        b=ZGrta9iX5fLbxpqUo3soFkwujYqq8NhhfLo+S41DyG8DgI2eTKCkz+3ijDVw29dOix
         yarVIG6Pzn3m6/C5gHV4R4uJ8IeKgEgu4recFB/9H8QMTg5/rJDQhfRQj6F+Ng1gRwZs
         RFhSj4F56+vIlzWr9s2UhOJK4heS1hYLlcwA+HJA426yNpfOI4DqpUe8PrE3s9VCARNc
         7fC1E+qBwJYoTBj/SnfmLXvB4k4T4ZTfJBjU15u5dNaaHO05OYhwS62y/pGwjxQW4eG7
         SWg+eNIaZjtL997InoXYqbeeqOkQ1VtW0m3A2vDY0P2PvhZQaJObyTo94nT1XxR/wiL4
         g+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcSqexEt5vR6uCgCgMM5NKqwtfT9a0imIzkh/t+OwgI=;
        b=nvwPDGPdbuip3jvepNgw3rr5a4cxDPhGkNClH490U00w/2ftvyW9m08zLfZCV4ntda
         CdVOf+s3eZKs88ZI2aV8ntL+oBQkFwRt2mVkMkn/tkbVNBGBWgxUqy3W+HPBUTZqugXm
         aQ/q6c5Y2U0xxViVDjxzwERvt4iapUm4Viu/c0frJGXsijqGP9g01fmsmOermxLvX+2b
         fD6QTWBC0B0NWlNjzxQL/nHYsNVur6epCCao2KvhKcxZTJpiV6hZa2Uzs60zymObS7EJ
         svck6Bj8Z8W4TnJIC+lvv45HxSvQ/4H5zOafPtuE8N1N7qI1h+nlFWjxoSNDzyDsr4EP
         7bRw==
X-Gm-Message-State: AOAM532w5TCJWnzKsBCmwJiDS4S96XCXotsyuUelFPlraIgSeScqTaoB
        OcoG+BPPS5J2MfSvAJP4XCtgBhBjONtFG5qIqdKJQQ==
X-Google-Smtp-Source: ABdhPJwiEJUdIo6K8bvT0prHs6DtmSryUuXgsWkneUhl5TZ6TwyXIYQxLutZ9tE7BxReUv2/RMfFogXAhbodSTPb/d4=
X-Received: by 2002:a67:fd48:: with SMTP id g8mr1796106vsr.55.1618491752832;
 Thu, 15 Apr 2021 06:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210318130512.1025416-1-anup.patel@wdc.com> <20210318130512.1025416-6-anup.patel@wdc.com>
In-Reply-To: <20210318130512.1025416-6-anup.patel@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 15:01:56 +0200
Message-ID: <CAPDyKFq3JLqFabmay25e6JGX+UD-=yEPRykgYBadFo3y3sGbOw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/8] cpuidle: Factor-out power domain related code
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

Hi Anup,

First, my apologies for the very long delay.

On Thu, 18 Mar 2021 at 14:06, Anup Patel <anup.patel@wdc.com> wrote:
>
> The generic power domain related code in PSCI domain driver is largely
> independent of PSCI and can be shared with RISC-V SBI domain driver
> hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.

I do agree that some parts could be considered as independent of PSCI,
perhaps those are rather "cpuidle-dt" specific.

Although, while I was looking at the changes in $subject patch, it
looks like you are adding another layer on top of
genpd/cpuidle-psci-domain. For example, you add the struct
dt_idle_genpd_ops with a couple of new callbacks. Even if this might
reduce open-coding a bit, I think it also introduces complexity. In my
opinion, those changes aren't really worth it.

Perhaps you can find some smaller pieces of code that are really
independent, which can be shared!?

>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Kind regards
Uffe

> ---
>  drivers/cpuidle/Kconfig                       |   4 +
>  drivers/cpuidle/Kconfig.arm                   |   1 +
>  drivers/cpuidle/Makefile                      |   1 +
>  drivers/cpuidle/cpuidle-psci-domain.c         | 244 +-----------------
>  drivers/cpuidle/cpuidle-psci.h                |  15 +-
>  ...{cpuidle-psci-domain.c => dt_idle_genpd.c} | 165 ++++--------
>  drivers/cpuidle/dt_idle_genpd.h               |  42 +++
>  7 files changed, 121 insertions(+), 351 deletions(-)
>  copy drivers/cpuidle/{cpuidle-psci-domain.c => dt_idle_genpd.c} (52%)
>  create mode 100644 drivers/cpuidle/dt_idle_genpd.h
>
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c0aeedd66f02..f1afe7ab6b54 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -47,6 +47,10 @@ config CPU_IDLE_GOV_HALTPOLL
>  config DT_IDLE_STATES
>         bool
>
> +config DT_IDLE_GENPD
> +       depends on PM_GENERIC_DOMAINS_OF
> +       bool
> +
>  menu "ARM CPU Idle Drivers"
>  depends on ARM || ARM64
>  source "drivers/cpuidle/Kconfig.arm"
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 0844fadc4be8..1007435ae298 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -27,6 +27,7 @@ config ARM_PSCI_CPUIDLE_DOMAIN
>         bool "PSCI CPU idle Domain"
>         depends on ARM_PSCI_CPUIDLE
>         depends on PM_GENERIC_DOMAINS_OF
> +       select DT_IDLE_GENPD
>         default y
>         help
>           Select this to enable the PSCI based CPUidle driver to use PM domains,
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 26bbc5e74123..11a26cef279f 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -6,6 +6,7 @@
>  obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>  obj-$(CONFIG_DT_IDLE_STATES)             += dt_idle_states.o
> +obj-$(CONFIG_DT_IDLE_GENPD)              += dt_idle_genpd.o
>  obj-$(CONFIG_ARCH_HAS_CPU_RELAX)         += poll_state.o
>  obj-$(CONFIG_HALTPOLL_CPUIDLE)           += cpuidle-haltpoll.o
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index ff2c3f8e4668..b0621d890ab7 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -16,17 +16,9 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/psci.h>
> -#include <linux/slab.h>
> -#include <linux/string.h>
>
>  #include "cpuidle-psci.h"
>
> -struct psci_pd_provider {
> -       struct list_head link;
> -       struct device_node *node;
> -};
> -
> -static LIST_HEAD(psci_pd_providers);
>  static bool psci_pd_allow_domain_state;
>
>  static int psci_pd_power_off(struct generic_pm_domain *pd)
> @@ -47,178 +39,6 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
>         return 0;
>  }
>
> -static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
> -                                    int state_count)
> -{
> -       int i, ret;
> -       u32 psci_state, *psci_state_buf;
> -
> -       for (i = 0; i < state_count; i++) {
> -               ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
> -                                       &psci_state);
> -               if (ret)
> -                       goto free_state;
> -
> -               psci_state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
> -               if (!psci_state_buf) {
> -                       ret = -ENOMEM;
> -                       goto free_state;
> -               }
> -               *psci_state_buf = psci_state;
> -               states[i].data = psci_state_buf;
> -       }
> -
> -       return 0;
> -
> -free_state:
> -       i--;
> -       for (; i >= 0; i--)
> -               kfree(states[i].data);
> -       return ret;
> -}
> -
> -static int psci_pd_parse_states(struct device_node *np,
> -                       struct genpd_power_state **states, int *state_count)
> -{
> -       int ret;
> -
> -       /* Parse the domain idle states. */
> -       ret = of_genpd_parse_idle_states(np, states, state_count);
> -       if (ret)
> -               return ret;
> -
> -       /* Fill out the PSCI specifics for each found state. */
> -       ret = psci_pd_parse_state_nodes(*states, *state_count);
> -       if (ret)
> -               kfree(*states);
> -
> -       return ret;
> -}
> -
> -static void psci_pd_free_states(struct genpd_power_state *states,
> -                               unsigned int state_count)
> -{
> -       int i;
> -
> -       for (i = 0; i < state_count; i++)
> -               kfree(states[i].data);
> -       kfree(states);
> -}
> -
> -static int psci_pd_init(struct device_node *np, bool use_osi)
> -{
> -       struct generic_pm_domain *pd;
> -       struct psci_pd_provider *pd_provider;
> -       struct dev_power_governor *pd_gov;
> -       struct genpd_power_state *states = NULL;
> -       int ret = -ENOMEM, state_count = 0;
> -
> -       pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> -       if (!pd)
> -               goto out;
> -
> -       pd_provider = kzalloc(sizeof(*pd_provider), GFP_KERNEL);
> -       if (!pd_provider)
> -               goto free_pd;
> -
> -       pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
> -       if (!pd->name)
> -               goto free_pd_prov;
> -
> -       /*
> -        * Parse the domain idle states and let genpd manage the state selection
> -        * for those being compatible with "domain-idle-state".
> -        */
> -       ret = psci_pd_parse_states(np, &states, &state_count);
> -       if (ret)
> -               goto free_name;
> -
> -       pd->free_states = psci_pd_free_states;
> -       pd->name = kbasename(pd->name);
> -       pd->states = states;
> -       pd->state_count = state_count;
> -       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
> -
> -       /* Allow power off when OSI has been successfully enabled. */
> -       if (use_osi)
> -               pd->power_off = psci_pd_power_off;
> -       else
> -               pd->flags |= GENPD_FLAG_ALWAYS_ON;
> -
> -       /* Use governor for CPU PM domains if it has some states to manage. */
> -       pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
> -
> -       ret = pm_genpd_init(pd, pd_gov, false);
> -       if (ret) {
> -               psci_pd_free_states(states, state_count);
> -               goto free_name;
> -       }
> -
> -       ret = of_genpd_add_provider_simple(np, pd);
> -       if (ret)
> -               goto remove_pd;
> -
> -       pd_provider->node = of_node_get(np);
> -       list_add(&pd_provider->link, &psci_pd_providers);
> -
> -       pr_debug("init PM domain %s\n", pd->name);
> -       return 0;
> -
> -remove_pd:
> -       pm_genpd_remove(pd);
> -free_name:
> -       kfree(pd->name);
> -free_pd_prov:
> -       kfree(pd_provider);
> -free_pd:
> -       kfree(pd);
> -out:
> -       pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
> -       return ret;
> -}
> -
> -static void psci_pd_remove(void)
> -{
> -       struct psci_pd_provider *pd_provider, *it;
> -       struct generic_pm_domain *genpd;
> -
> -       list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
> -               of_genpd_del_provider(pd_provider->node);
> -
> -               genpd = of_genpd_remove_last(pd_provider->node);
> -               if (!IS_ERR(genpd))
> -                       kfree(genpd);
> -
> -               of_node_put(pd_provider->node);
> -               list_del(&pd_provider->link);
> -               kfree(pd_provider);
> -       }
> -}
> -
> -static int psci_pd_init_topology(struct device_node *np)
> -{
> -       struct device_node *node;
> -       struct of_phandle_args child, parent;
> -       int ret;
> -
> -       for_each_child_of_node(np, node) {
> -               if (of_parse_phandle_with_args(node, "power-domains",
> -                                       "#power-domain-cells", 0, &parent))
> -                       continue;
> -
> -               child.np = node;
> -               child.args_count = 0;
> -               ret = of_genpd_add_subdomain(&parent, &child);
> -               of_node_put(parent.np);
> -               if (ret) {
> -                       of_node_put(node);
> -                       return ret;
> -               }
> -       }
> -
> -       return 0;
> -}
> -
>  static bool psci_pd_try_set_osi_mode(void)
>  {
>         int ret;
> @@ -244,6 +64,10 @@ static void psci_cpuidle_domain_sync_state(struct device *dev)
>         psci_pd_allow_domain_state = true;
>  }
>
> +static struct dt_idle_genpd_ops psci_genpd_ops = {
> +       .parse_state_node = psci_dt_parse_state_node,
> +};
> +
>  static const struct of_device_id psci_of_match[] = {
>         { .compatible = "arm,psci-1.0" },
>         {}
> @@ -252,48 +76,25 @@ static const struct of_device_id psci_of_match[] = {
>  static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>  {
>         struct device_node *np = pdev->dev.of_node;
> -       struct device_node *node;
>         bool use_osi;
> -       int ret = 0, pd_count = 0;
> +       int ret = 0;
>
>         if (!np)
>                 return -ENODEV;
>
>         /* If OSI mode is supported, let's try to enable it. */
>         use_osi = psci_pd_try_set_osi_mode();
> +       if (use_osi)
> +               psci_genpd_ops.power_off = psci_pd_power_off;
>
> -       /*
> -        * Parse child nodes for the "#power-domain-cells" property and
> -        * initialize a genpd/genpd-of-provider pair when it's found.
> -        */
> -       for_each_child_of_node(np, node) {
> -               if (!of_find_property(node, "#power-domain-cells", NULL))
> -                       continue;
> -
> -               ret = psci_pd_init(node, use_osi);
> -               if (ret)
> -                       goto put_node;
> -
> -               pd_count++;
> -       }
> -
> -       /* Bail out if not using the hierarchical CPU topology. */
> -       if (!pd_count)
> -               goto no_pd;
> -
> -       /* Link genpd masters/subdomains to model the CPU topology. */
> -       ret = psci_pd_init_topology(np);
> +       /* Generic power domain probing based on DT node. */
> +       ret = dt_idle_genpd_probe(&psci_genpd_ops, np);
>         if (ret)
> -               goto remove_pd;
> +               goto no_pd;
>
>         pr_info("Initialized CPU PM domain topology\n");
>         return 0;
>
> -put_node:
> -       of_node_put(node);
> -remove_pd:
> -       psci_pd_remove();
> -       pr_err("failed to create CPU PM domains ret=%d\n", ret);
>  no_pd:
>         if (use_osi)
>                 psci_set_osi_mode(false);
> @@ -314,28 +115,3 @@ static int __init psci_idle_init_domains(void)
>         return platform_driver_register(&psci_cpuidle_domain_driver);
>  }
>  subsys_initcall(psci_idle_init_domains);
> -
> -struct device *psci_dt_attach_cpu(int cpu)
> -{
> -       struct device *dev;
> -
> -       dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
> -       if (IS_ERR_OR_NULL(dev))
> -               return dev;
> -
> -       pm_runtime_irq_safe(dev);
> -       if (cpu_online(cpu))
> -               pm_runtime_get_sync(dev);
> -
> -       dev_pm_syscore_device(dev, true);
> -
> -       return dev;
> -}
> -
> -void psci_dt_detach_cpu(struct device *dev)
> -{
> -       if (IS_ERR_OR_NULL(dev))
> -               return;
> -
> -       dev_pm_domain_detach(dev, false);
> -}
> diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
> index d8e925e84c27..70de1e3c00af 100644
> --- a/drivers/cpuidle/cpuidle-psci.h
> +++ b/drivers/cpuidle/cpuidle-psci.h
> @@ -10,8 +10,19 @@ void psci_set_domain_state(u32 state);
>  int psci_dt_parse_state_node(struct device_node *np, u32 *state);
>
>  #ifdef CONFIG_ARM_PSCI_CPUIDLE_DOMAIN
> -struct device *psci_dt_attach_cpu(int cpu);
> -void psci_dt_detach_cpu(struct device *dev);
> +
> +#include "dt_idle_genpd.h"
> +
> +static inline struct device *psci_dt_attach_cpu(int cpu)
> +{
> +       return dt_idle_genpd_attach_cpu(cpu, "psci");
> +}
> +
> +static inline void psci_dt_detach_cpu(struct device *dev)
> +{
> +       dt_idle_genpd_detach_cpu(dev);
> +}
> +
>  #else
>  static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
>  static inline void psci_dt_detach_cpu(struct device *dev) { }
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/dt_idle_genpd.c
> similarity index 52%
> copy from drivers/cpuidle/cpuidle-psci-domain.c
> copy to drivers/cpuidle/dt_idle_genpd.c
> index ff2c3f8e4668..805c4c81d60f 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/dt_idle_genpd.c
> @@ -1,71 +1,52 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * PM domains for CPUs via genpd - managed by cpuidle-psci.
> + * PM domains for CPUs via genpd.
>   *
>   * Copyright (C) 2019 Linaro Ltd.
>   * Author: Ulf Hansson <ulf.hansson@linaro.org>
>   *
> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
>   */
>
> -#define pr_fmt(fmt) "CPUidle PSCI: " fmt
> +#define pr_fmt(fmt) "dt-idle-genpd: " fmt
>
>  #include <linux/cpu.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/psci.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>
> -#include "cpuidle-psci.h"
> +#include "dt_idle_genpd.h"
>
> -struct psci_pd_provider {
> +struct dt_pd_provider {
>         struct list_head link;
>         struct device_node *node;
>  };
>
> -static LIST_HEAD(psci_pd_providers);
> -static bool psci_pd_allow_domain_state;
> +static LIST_HEAD(dt_pd_providers);
>
> -static int psci_pd_power_off(struct generic_pm_domain *pd)
> -{
> -       struct genpd_power_state *state = &pd->states[pd->state_idx];
> -       u32 *pd_state;
> -
> -       if (!state->data)
> -               return 0;
> -
> -       if (!psci_pd_allow_domain_state)
> -               return -EBUSY;
> -
> -       /* OSI mode is enabled, set the corresponding domain state. */
> -       pd_state = state->data;
> -       psci_set_domain_state(*pd_state);
> -
> -       return 0;
> -}
> -
> -static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
> -                                    int state_count)
> +static int dt_pd_parse_state_nodes(const struct dt_idle_genpd_ops *ops,
> +                                  struct genpd_power_state *states,
> +                                  int state_count)
>  {
>         int i, ret;
> -       u32 psci_state, *psci_state_buf;
> +       u32 state, *state_buf;
>
>         for (i = 0; i < state_count; i++) {
> -               ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
> -                                       &psci_state);
> +               ret = ops->parse_state_node(to_of_node(states[i].fwnode),
> +                                           &state);
>                 if (ret)
>                         goto free_state;
>
> -               psci_state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
> -               if (!psci_state_buf) {
> +               state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
> +               if (!state_buf) {
>                         ret = -ENOMEM;
>                         goto free_state;
>                 }
> -               *psci_state_buf = psci_state;
> -               states[i].data = psci_state_buf;
> +               *state_buf = state;
> +               states[i].data = state_buf;
>         }
>
>         return 0;
> @@ -77,8 +58,10 @@ static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
>         return ret;
>  }
>
> -static int psci_pd_parse_states(struct device_node *np,
> -                       struct genpd_power_state **states, int *state_count)
> +static int dt_pd_parse_states(const struct dt_idle_genpd_ops *ops,
> +                             struct device_node *np,
> +                             struct genpd_power_state **states,
> +                             int *state_count)
>  {
>         int ret;
>
> @@ -87,15 +70,15 @@ static int psci_pd_parse_states(struct device_node *np,
>         if (ret)
>                 return ret;
>
> -       /* Fill out the PSCI specifics for each found state. */
> -       ret = psci_pd_parse_state_nodes(*states, *state_count);
> +       /* Fill out the dt specifics for each found state. */
> +       ret = dt_pd_parse_state_nodes(ops, *states, *state_count);
>         if (ret)
>                 kfree(*states);
>
>         return ret;
>  }
>
> -static void psci_pd_free_states(struct genpd_power_state *states,
> +static void dt_pd_free_states(struct genpd_power_state *states,
>                                 unsigned int state_count)
>  {
>         int i;
> @@ -105,10 +88,11 @@ static void psci_pd_free_states(struct genpd_power_state *states,
>         kfree(states);
>  }
>
> -static int psci_pd_init(struct device_node *np, bool use_osi)
> +static int dt_pd_init(const struct dt_idle_genpd_ops *ops,
> +                     struct device_node *np)
>  {
>         struct generic_pm_domain *pd;
> -       struct psci_pd_provider *pd_provider;
> +       struct dt_pd_provider *pd_provider;
>         struct dev_power_governor *pd_gov;
>         struct genpd_power_state *states = NULL;
>         int ret = -ENOMEM, state_count = 0;
> @@ -129,19 +113,19 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>          * Parse the domain idle states and let genpd manage the state selection
>          * for those being compatible with "domain-idle-state".
>          */
> -       ret = psci_pd_parse_states(np, &states, &state_count);
> +       ret = dt_pd_parse_states(ops, np, &states, &state_count);
>         if (ret)
>                 goto free_name;
>
> -       pd->free_states = psci_pd_free_states;
> +       pd->free_states = dt_pd_free_states;
>         pd->name = kbasename(pd->name);
>         pd->states = states;
>         pd->state_count = state_count;
>         pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
>
> -       /* Allow power off when OSI has been successfully enabled. */
> -       if (use_osi)
> -               pd->power_off = psci_pd_power_off;
> +       /* Allow power off when available. */
> +       if (ops->power_off)
> +               pd->power_off = ops->power_off;
>         else
>                 pd->flags |= GENPD_FLAG_ALWAYS_ON;
>
> @@ -150,7 +134,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>
>         ret = pm_genpd_init(pd, pd_gov, false);
>         if (ret) {
> -               psci_pd_free_states(states, state_count);
> +               dt_pd_free_states(states, state_count);
>                 goto free_name;
>         }
>
> @@ -159,7 +143,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>                 goto remove_pd;
>
>         pd_provider->node = of_node_get(np);
> -       list_add(&pd_provider->link, &psci_pd_providers);
> +       list_add(&pd_provider->link, &dt_pd_providers);
>
>         pr_debug("init PM domain %s\n", pd->name);
>         return 0;
> @@ -177,12 +161,12 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>         return ret;
>  }
>
> -static void psci_pd_remove(void)
> +static void dt_pd_remove(void)
>  {
> -       struct psci_pd_provider *pd_provider, *it;
> +       struct dt_pd_provider *pd_provider, *it;
>         struct generic_pm_domain *genpd;
>
> -       list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
> +       list_for_each_entry_safe(pd_provider, it, &dt_pd_providers, link) {
>                 of_genpd_del_provider(pd_provider->node);
>
>                 genpd = of_genpd_remove_last(pd_provider->node);
> @@ -195,7 +179,7 @@ static void psci_pd_remove(void)
>         }
>  }
>
> -static int psci_pd_init_topology(struct device_node *np)
> +static int dt_pd_init_topology(struct device_node *np)
>  {
>         struct device_node *node;
>         struct of_phandle_args child, parent;
> @@ -219,49 +203,15 @@ static int psci_pd_init_topology(struct device_node *np)
>         return 0;
>  }
>
> -static bool psci_pd_try_set_osi_mode(void)
> -{
> -       int ret;
> -
> -       if (!psci_has_osi_support())
> -               return false;
> -
> -       ret = psci_set_osi_mode(true);
> -       if (ret) {
> -               pr_warn("failed to enable OSI mode: %d\n", ret);
> -               return false;
> -       }
> -
> -       return true;
> -}
> -
> -static void psci_cpuidle_domain_sync_state(struct device *dev)
> +int dt_idle_genpd_probe(const struct dt_idle_genpd_ops *ops,
> +                       struct device_node *np)
>  {
> -       /*
> -        * All devices have now been attached/probed to the PM domain topology,
> -        * hence it's fine to allow domain states to be picked.
> -        */
> -       psci_pd_allow_domain_state = true;
> -}
> -
> -static const struct of_device_id psci_of_match[] = {
> -       { .compatible = "arm,psci-1.0" },
> -       {}
> -};
> -
> -static int psci_cpuidle_domain_probe(struct platform_device *pdev)
> -{
> -       struct device_node *np = pdev->dev.of_node;
>         struct device_node *node;
> -       bool use_osi;
>         int ret = 0, pd_count = 0;
>
> -       if (!np)
> +       if (!np || !ops || !ops->parse_state_node)
>                 return -ENODEV;
>
> -       /* If OSI mode is supported, let's try to enable it. */
> -       use_osi = psci_pd_try_set_osi_mode();
> -
>         /*
>          * Parse child nodes for the "#power-domain-cells" property and
>          * initialize a genpd/genpd-of-provider pair when it's found.
> @@ -270,7 +220,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>                 if (!of_find_property(node, "#power-domain-cells", NULL))
>                         continue;
>
> -               ret = psci_pd_init(node, use_osi);
> +               ret = dt_pd_init(ops, node);
>                 if (ret)
>                         goto put_node;
>
> @@ -282,44 +232,27 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>                 goto no_pd;
>
>         /* Link genpd masters/subdomains to model the CPU topology. */
> -       ret = psci_pd_init_topology(np);
> +       ret = dt_pd_init_topology(np);
>         if (ret)
>                 goto remove_pd;
>
> -       pr_info("Initialized CPU PM domain topology\n");
>         return 0;
>
>  put_node:
>         of_node_put(node);
>  remove_pd:
> -       psci_pd_remove();
> +       dt_pd_remove();
>         pr_err("failed to create CPU PM domains ret=%d\n", ret);
>  no_pd:
> -       if (use_osi)
> -               psci_set_osi_mode(false);
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(dt_idle_genpd_probe);
>
> -static struct platform_driver psci_cpuidle_domain_driver = {
> -       .probe  = psci_cpuidle_domain_probe,
> -       .driver = {
> -               .name = "psci-cpuidle-domain",
> -               .of_match_table = psci_of_match,
> -               .sync_state = psci_cpuidle_domain_sync_state,
> -       },
> -};
> -
> -static int __init psci_idle_init_domains(void)
> -{
> -       return platform_driver_register(&psci_cpuidle_domain_driver);
> -}
> -subsys_initcall(psci_idle_init_domains);
> -
> -struct device *psci_dt_attach_cpu(int cpu)
> +struct device *dt_idle_genpd_attach_cpu(int cpu, const char *name)
>  {
>         struct device *dev;
>
> -       dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
> +       dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), name);
>         if (IS_ERR_OR_NULL(dev))
>                 return dev;
>
> @@ -331,11 +264,13 @@ struct device *psci_dt_attach_cpu(int cpu)
>
>         return dev;
>  }
> +EXPORT_SYMBOL_GPL(dt_idle_genpd_attach_cpu);
>
> -void psci_dt_detach_cpu(struct device *dev)
> +void dt_idle_genpd_detach_cpu(struct device *dev)
>  {
>         if (IS_ERR_OR_NULL(dev))
>                 return;
>
>         dev_pm_domain_detach(dev, false);
>  }
> +EXPORT_SYMBOL_GPL(dt_idle_genpd_detach_cpu);
> diff --git a/drivers/cpuidle/dt_idle_genpd.h b/drivers/cpuidle/dt_idle_genpd.h
> new file mode 100644
> index 000000000000..a3d3d2e85871
> --- /dev/null
> +++ b/drivers/cpuidle/dt_idle_genpd.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DT_IDLE_GENPD
> +#define __DT_IDLE_GENPD
> +
> +struct device_node;
> +struct generic_pm_domain;
> +
> +struct dt_idle_genpd_ops {
> +       int (*parse_state_node)(struct device_node *np, u32 *state);
> +       int (*power_off)(struct generic_pm_domain *pd);
> +};
> +
> +#ifdef CONFIG_DT_IDLE_GENPD
> +
> +int dt_idle_genpd_probe(const struct dt_idle_genpd_ops *ops,
> +                       struct device_node *np);
> +
> +struct device *dt_idle_genpd_attach_cpu(int cpu, const char *name);
> +
> +void dt_idle_genpd_detach_cpu(struct device *dev);
> +
> +#else
> +
> +int dt_idle_genpd_probe(const struct dt_idle_genpd_ops *ops,
> +                       struct device_node *np)
> +{
> +       return 0;
> +}
> +
> +static inline struct device *dt_idle_genpd_attach_cpu(int cpu,
> +                                                     const char *name)
> +{
> +       return NULL;
> +}
> +
> +static inline void dt_idle_genpd_detach_cpu(struct device *dev)
> +{
> +}
> +
> +#endif
> +
> +#endif
> --
> 2.25.1
>
