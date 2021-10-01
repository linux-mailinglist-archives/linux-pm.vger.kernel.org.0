Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605AF41EF6B
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354491AbhJAO0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354482AbhJAO0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 10:26:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB732C0613E4
        for <linux-pm@vger.kernel.org>; Fri,  1 Oct 2021 07:25:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so39569238lfu.5
        for <linux-pm@vger.kernel.org>; Fri, 01 Oct 2021 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uoTsMILdh2iae8vlYA/uD6rXVrqQcXGr4rKOWNIrfP4=;
        b=ZX/zp88Hzbtc6VumtwtOf/Oh+OaJ0chzGkXC5wf4sPS8EnMadE1LYVMn+oQGU+kHb8
         R+gyJ0Wgd6EZVoHYlNsYzRsUaZ5Rp/cdsIRgMegZH1fxe5M9LdMHvWaVupGppgdYzZDW
         TD5Kr9uQc875LMcukvjCblVlHVTBOl7gxHxMLD9oTeyGDqmxuy531Ve1dY7h60MRyk+C
         V8sDsQ9/XhH26KEHzkzm/kuAtjxeW7JVdmQ74ybXucxQOcK8nSOutATp4BamK5izx3m/
         P4rAUs6vctnmnFw0UhIdyFrrMh5OhPkSyPf5wfcKi9tqeuxiNdqmo/N2ZPtT7kOoHYhb
         jrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoTsMILdh2iae8vlYA/uD6rXVrqQcXGr4rKOWNIrfP4=;
        b=gfcPQDIxErD8X4MPAqqKDLePlXSUeR/x0wgjlPMFKpqv0MkEg5G8GJDpnVaaVbx3C8
         mG+QvXsKKJiC4sKF5LRX+L7E6al68TJ8MUp/GDd+8GEO8l/cHBFt5191Htum1wb25wmo
         1RdpYPBoDvAIj4vEVkWB0zL6gVTepu+dLQXZy0ZUG/o76iP4xd1ww9ISPXwiCZAi2s9h
         hQJxrg3d5nspo+QfHaD4FkaipCgZ7cZioS8SFeDAfSrLudiYy8FYYeu9dz8Wq5BpSjC5
         1WGu02zLXf6od76b8mGqcnZXZNl3RCNsx+k6REYwiJ5WqI4DAEyuVUEG+gscMdhB9kho
         wmkg==
X-Gm-Message-State: AOAM532vfxdt1xr88gBPyYhnhfAgokZBUDqIviBq8UMjJRBmD+ZEtVDi
        BJQ8h3I8uz7pDVGHzpAqYJKlh8H4APUA1qbWzBBpJg==
X-Google-Smtp-Source: ABdhPJwSMtJvxBnj9uWeRpU/b3LkJtcHpGm07/8fvonUj3xZI1CXy/1e+tkG9PmEu6jyQxbbL99Gq2H6ljI3UAmND1M=
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr5584384lfv.358.1633098308316;
 Fri, 01 Oct 2021 07:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210926224058.1252-1-digetx@gmail.com> <20210926224058.1252-21-digetx@gmail.com>
In-Reply-To: <20210926224058.1252-21-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Oct 2021 16:24:32 +0200
Message-ID: <CAPDyKFoF2QxZss_h9B1NFqOqgeF=TQ6LajCedGiJ9_P8X5M0NA@mail.gmail.com>
Subject: Re: [PATCH v13 20/35] mtd: rawnand: tegra: Add runtime PM and OPP support
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 Sept 2021 at 00:42, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> The NAND on Tegra belongs to the core power domain and we're going to
> enable GENPD support for the core domain. Now NAND must be resumed using
> runtime PM API in order to initialize the NAND power state. Add runtime PM
> and OPP support to the NAND driver.
>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mtd/nand/raw/tegra_nand.c | 55 ++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
> index 32431bbe69b8..098fcc9cb9df 100644
> --- a/drivers/mtd/nand/raw/tegra_nand.c
> +++ b/drivers/mtd/nand/raw/tegra_nand.c
> @@ -17,8 +17,11 @@
>  #include <linux/mtd/rawnand.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>
> +#include <soc/tegra/common.h>
> +
>  #define COMMAND                                        0x00
>  #define   COMMAND_GO                           BIT(31)
>  #define   COMMAND_CLE                          BIT(30)
> @@ -1151,6 +1154,7 @@ static int tegra_nand_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         ctrl->dev = &pdev->dev;
> +       platform_set_drvdata(pdev, ctrl);
>         nand_controller_init(&ctrl->controller);
>         ctrl->controller.ops = &tegra_nand_controller_ops;
>
> @@ -1166,14 +1170,22 @@ static int tegra_nand_probe(struct platform_device *pdev)
>         if (IS_ERR(ctrl->clk))
>                 return PTR_ERR(ctrl->clk);
>
> -       err = clk_prepare_enable(ctrl->clk);
> +       err = devm_pm_runtime_enable(&pdev->dev);
> +       if (err)
> +               return err;
> +
> +       err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> +       if (err)
> +               return err;
> +
> +       err = pm_runtime_resume_and_get(&pdev->dev);
>         if (err)
>                 return err;
>
>         err = reset_control_reset(rst);
>         if (err) {
>                 dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
> -               goto err_disable_clk;
> +               goto err_put_pm;
>         }
>
>         writel_relaxed(HWSTATUS_CMD_DEFAULT, ctrl->regs + HWSTATUS_CMD);
> @@ -1188,21 +1200,19 @@ static int tegra_nand_probe(struct platform_device *pdev)
>                                dev_name(&pdev->dev), ctrl);
>         if (err) {
>                 dev_err(ctrl->dev, "Failed to get IRQ: %d\n", err);
> -               goto err_disable_clk;
> +               goto err_put_pm;
>         }
>
>         writel_relaxed(DMA_MST_CTRL_IS_DONE, ctrl->regs + DMA_MST_CTRL);
>
>         err = tegra_nand_chips_init(ctrl->dev, ctrl);
>         if (err)
> -               goto err_disable_clk;
> -
> -       platform_set_drvdata(pdev, ctrl);
> +               goto err_put_pm;
>

There is no corresponding call pm_runtime_put() here. Is it
intentional to always leave the device runtime resumed after ->probe()
has succeeded?

I noticed you included some comments about this for some other
drivers, as those needed more tweaks. Is that also the case for this
driver?

>         return 0;
>
> -err_disable_clk:
> -       clk_disable_unprepare(ctrl->clk);
> +err_put_pm:
> +       pm_runtime_put(ctrl->dev);
>         return err;
>  }
>

[...]

Kind regards
Uffe
