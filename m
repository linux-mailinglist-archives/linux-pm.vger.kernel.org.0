Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C061C571
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 10:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfENI4F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 04:56:05 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38584 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENI4F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 04:56:05 -0400
Received: by mail-vs1-f66.google.com with SMTP id v9so9832721vse.5
        for <linux-pm@vger.kernel.org>; Tue, 14 May 2019 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVt8RYr5RdB+WurCG7zdyCjwz+OuS1MURA7BPyKce6o=;
        b=rSq0q56gaNVxf6qXwNn5F+wWqxGeQ6MRboOnrrL/HUIljKZ2vPgYVY0RAMq+seQI04
         NvkXs2+o7AOtuBRVEe6vT+hyRsT2X/4K8R/uM3Sl9O/7qcQ5LU5JLtYkhKchnJPqKmfX
         QzC7eaFwbPxpqaHuS6Zda8xMcOzLmzr0lCtoQiTiZWJjcMvRf/Nx3inrbiRza2weMCpf
         JCX8xUOlGenGlfmXz1T4hDTrKOHafwH5fPayqQuc8Ro90LGDAtiQj+xLlg7/d6wk4brO
         ny/ULghHwng7NR7bFFDVlDWTxpS/Ba9llUy4DqYenMUGCIGsA37vvhFTjvggYoXmr9xl
         8PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVt8RYr5RdB+WurCG7zdyCjwz+OuS1MURA7BPyKce6o=;
        b=XHVkbuVsYOL3NmHC22ciGkDm45i65e1cwD9Tvi3aBYHilaAAmFPj6uqa3f+y0JQ/mI
         IQ3O6SNPmh/rG40HRI07JsRjCR+ynEFvjwmxWSVD2fV/wou+gABWsIRniR3yMwM71vC9
         mWVMksdCyhNvJyarN3hk3nQSWn4ZYMuoOPIJH268kaKkp1RbpD0BmLq8Y/wQyqND5vSt
         vz9Pf6WzmHyq8x6se4HKFg/SWV3JVPvZsgSsbXRv6mHM9wKScyhVbkhkV63IVzYtFDyW
         ioQ9bqD30aSAKpCr2OSpq9YBkMjECAWV+6tQI8sE6Qnfh0ahxp/u/MeJNvJyOxabRdLS
         kJaw==
X-Gm-Message-State: APjAAAWdcfuAMAFTD/AkiHWFbUp7eqqMhd13WJkFLXcjC1jW21R6otdd
        3FJKlPtSq5qVVRtugSB+5h8GwQ9fMqg62bfHk3FtyA==
X-Google-Smtp-Source: APXvYqwSVaXrwCauRCJL/4hOQ3MyyDQduK/fUJOjRMMJ27PpxVCkYn43uXkSyOQ9pM0+n46FJJoIttk8io8DGgEg6Iw=
X-Received: by 2002:a67:f99a:: with SMTP id b26mr9915748vsq.200.1557824163696;
 Tue, 14 May 2019 01:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190509211911.17998-1-lkundrak@v3.sk> <20190509211911.17998-6-lkundrak@v3.sk>
In-Reply-To: <20190509211911.17998-6-lkundrak@v3.sk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 May 2019 10:55:27 +0200
Message-ID: <CAPDyKFpAAKpR+Y4uHNjkwLsf3adJVVW9WSRApPtAB2s_FyomEQ@mail.gmail.com>
Subject: Re: [PATCH RFC 5/7] clk: mmp2: create a power domain for the GPU core
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        James Cameron <quozl@laptop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 9 May 2019 at 23:19, Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The power management unit on MMP2 is able to gate clock for the GC860 GPU.
>
> There's some special dance required to initialize the unit after the power
> has been enabled. If not followed, either the GPU's memory interface or the
> GPU core doesn't work or the SoC just hangs.
>
> Once the power has been applied to the GPU block, it doesn't seem
> possible to turn it off entirely and initialize again.

I didn't quite see this constraint being managed in the code below.
Can you please elaborate on how you intend to deal with this?

We have a GENPD_FLAG_ALWAYS_ON, that might be useful here.

We also have new flag/behavior, likely to be merged soon [1], which
uses a flag called GENPD_FLAG_RPM_ALWAYS_ON....

>
> As the data sheet is missing, neither the details about initialization, nor
> the reason why it can't be reinitialized are understood. The meaning of
> most bits in the APMU_GPU register are partially described in [1].
>
> [1] http://lists.laptop.org/pipermail/devel/2019-April/039053.html
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  arch/arm/mach-mmp/Kconfig     |  2 +
>  drivers/clk/mmp/clk-of-mmp2.c | 91 +++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>
> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index 94500bed56ab..a0efaefbfc74 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -124,6 +124,8 @@ config MACH_MMP2_DT
>         select PINCTRL_SINGLE
>         select ARCH_HAS_RESET_CONTROLLER
>         select CPU_PJ4
> +       select PM_GENERIC_DOMAINS if PM
> +       select PM_GENERIC_DOMAINS_OF if PM && OF

selecting PM_GENERIC_DOMAINS_OF isn't needed as it defaults to y, in
case PM_GENERIC_DOMAINS and OF.

See /kernel/power/Kconfig

>         help
>           Include support for Marvell MMP2 based platforms using
>           the device tree.
> diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
> index 45f94c89cdc1..7bbf70b2ccd2 100644
> --- a/drivers/clk/mmp/clk-of-mmp2.c
> +++ b/drivers/clk/mmp/clk-of-mmp2.c
> @@ -16,8 +16,11 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/of_address.h>
> +#include <linux/pm_domain.h>
> +#include <linux/clk.h>
>
>  #include <dt-bindings/clock/marvell,mmp2.h>
> +#include <dt-bindings/power/marvell,mmp2.h>
>
>  #include "clk.h"
>  #include "reset.h"
> @@ -58,6 +61,8 @@
>
>  struct mmp2_clk_unit {
>         struct mmp_clk_unit unit;
> +       struct genpd_onecell_data pd_data;
> +       struct generic_pm_domain gpu_pm_domain;
>         void __iomem *mpmu_base;
>         void __iomem *apmu_base;
>         void __iomem *apbc_base;
> @@ -325,6 +330,90 @@ static void mmp2_clk_reset_init(struct device_node *np,
>         mmp_clk_reset_register(np, cells, nr_resets);
>  }
>
> +static int mmp2_gpu_pm_domain_power_on(struct generic_pm_domain *genpd)
> +{
> +       struct mmp2_clk_unit *pxa_unit = container_of(genpd,
> +                       struct mmp2_clk_unit, gpu_pm_domain);
> +       struct mmp_clk_unit *unit = &pxa_unit->unit;
> +       void __iomem *reg = pxa_unit->apmu_base + APMU_GPU;
> +       unsigned long flags = 0;
> +       u32 tmp;
> +       int ret;
> +
> +       spin_lock_irqsave(&gpu_lock, flags);
> +
> +       /* Power up the module. */
> +       tmp = readl(reg);
> +       tmp &= ~0x8700;
> +       tmp |= 0x8600;
> +       writel(tmp, reg);
> +
> +       ret = clk_prepare_enable(unit->clk_table[MMP2_CLK_GPU_GC]);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(unit->clk_table[MMP2_CLK_GPU_BUS]);
> +       if (ret) {
> +               clk_disable_unprepare(unit->clk_table[MMP2_CLK_GPU_GC]);
> +               return ret;
> +       }
> +
> +       /* Disable isolation now that clocks are running. */
> +       tmp = readl(reg);
> +       tmp |= 0x100;
> +       writel(tmp, reg);
> +       udelay(1);
> +
> +       spin_unlock_irqrestore(&gpu_lock, flags);
> +
> +       return 0;
> +}
> +
> +static int mmp2_gpu_pm_domain_power_off(struct generic_pm_domain *genpd)
> +{
> +       struct mmp2_clk_unit *pxa_unit = container_of(genpd,
> +                       struct mmp2_clk_unit, gpu_pm_domain);
> +       struct mmp_clk_unit *unit = &pxa_unit->unit;
> +       void __iomem *reg = pxa_unit->apmu_base + APMU_GPU;
> +       unsigned long flags = 0;
> +       u32 tmp;
> +
> +       spin_lock_irqsave(&gpu_lock, flags);

Why is this lock needed?

> +
> +       /*
> +        * Re-enable isolation. We must not touch the other bits,
> +        * otherwise the * GPU hangs without a known way to recover.
> +        */
> +       tmp = readl(reg);
> +       tmp &= ~0x100;
> +       writel(tmp, reg);
> +       udelay(1);
> +
> +       clk_disable_unprepare(unit->clk_table[MMP2_CLK_GPU_BUS]);
> +       clk_disable_unprepare(unit->clk_table[MMP2_CLK_GPU_GC]);
> +
> +       spin_unlock_irqrestore(&gpu_lock, flags);
> +
> +       return 0;
> +}
> +
> +static struct generic_pm_domain *mmp2_pm_onecell_domains[MMP2_NR_POWER_DOMAINS];
> +
> +static void mmp2_pm_domain_init(struct device_node *np,
> +                       struct mmp2_clk_unit *pxa_unit)
> +{
> +       pm_genpd_init(&pxa_unit->gpu_pm_domain, NULL, true);

pm_genpd_init(), should be called after the below initialization has
been done. Please re-order this.

> +       pxa_unit->gpu_pm_domain.name = "GPU";
> +       pxa_unit->gpu_pm_domain.power_on = mmp2_gpu_pm_domain_power_on;
> +       pxa_unit->gpu_pm_domain.power_off = mmp2_gpu_pm_domain_power_off;
> +       mmp2_pm_onecell_domains[MMP2_POWER_DOMAIN_GPU]
> +                               = &pxa_unit->gpu_pm_domain;
> +
> +       pxa_unit->pd_data.domains = mmp2_pm_onecell_domains;
> +       pxa_unit->pd_data.num_domains = ARRAY_SIZE(mmp2_pm_onecell_domains);
> +       of_genpd_add_provider_onecell(np, &pxa_unit->pd_data);
> +}
> +
>  static void __init mmp2_clk_init(struct device_node *np)
>  {
>         struct mmp2_clk_unit *pxa_unit;
> @@ -351,6 +440,8 @@ static void __init mmp2_clk_init(struct device_node *np)
>                 goto unmap_apmu_region;
>         }
>
> +       mmp2_pm_domain_init(np, pxa_unit);
> +
>         mmp_clk_init(np, &pxa_unit->unit, MMP2_NR_CLKS);
>
>         mmp2_pll_init(pxa_unit);
> --
> 2.21.0
>

Kind regards
Uffe

[1]
https://www.spinics.net/lists/arm-kernel/msg724822.html
