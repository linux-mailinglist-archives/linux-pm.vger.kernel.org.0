Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E841FC5B7
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 07:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgFQFjd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 01:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQFjd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 01:39:33 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5742C06174E
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 22:39:32 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 190so649780vsr.9
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 22:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vagjVKSkecC/z5l23mqjlUJhPMrSeSw7xH2X0+6z0lQ=;
        b=kz5EDsy5OwgZsAA8HYLMeWwC0dLYIH2p0Rt2PGqOE/VBizT4ojX7X7YXeCTs263LpB
         DGIv3XKtXblVdKAWygKjF6Jo8N3TpDFXd6pxFTTUOrGxGN6ZRBIgUu6nkKrI3Rc+RVx2
         1pzbmyf6x67qKW6fwH63zuHn0mD8dVxRHp7gOoi/eSxTzpRzQzvAgPVc0Ky4HB+1GjnA
         7wvw4OHr9B7ToBfNwmek//rEEGYubF28sy+OzkWX9XBf5uqIsumwe6XgCKst2FS/5KI7
         Ie7/cjzlRdRopraP84WlLXNGckUh+qrMkONlPI1Wa07AoQ8sVSEA3TuYFJOhhUVrwYbV
         z/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vagjVKSkecC/z5l23mqjlUJhPMrSeSw7xH2X0+6z0lQ=;
        b=kBrnpLbyjWE0hvyeXFsO2/K+ezXmdIsAW0OTmjumPdpl+E/19RVMJKpF2X2xOjWv4T
         FQJY9/GZ2SEaCFc60h6QtqH0K6zbNmDbaamCtHt1LsB//ha5x+/pL/8Tpxz3begKx8XG
         MEDIfri5UwlupX4h3vbVUNgEyo2MntxdCEZ+Sn3x0ScyyFTL1G4A2Miki8RenjfFOnuo
         T3LGec80o8+us3PbsmUSckRJD26/7pGJSdmU/Apih8Ota55cyUWgL2pnzFE0G9DUed5a
         sofnxPMAVrsMMpAvsImP2l9q63nMMl8mQUgklDrVCOVUpv/iToyNwJ9tvNYqq1hm93d8
         pRBA==
X-Gm-Message-State: AOAM531umN2GaWm4liMtohHBkTPWp3GA2qnhck8KQkKTZ9sPfizNH7fC
        +zp5YE9m5/D30TIPY4miLYNewqSOH3lV+g0J7nfkRw==
X-Google-Smtp-Source: ABdhPJzRRUswoGanXtfI1tAmrtuA6BOvFYnBKprvwwQrE+7ToLUGrzsvYUG0Ho+RFm1cMii6QOQ1yLXDbuPQoMW3yVk=
X-Received: by 2002:a67:ea98:: with SMTP id f24mr4220921vso.159.1592372371922;
 Tue, 16 Jun 2020 22:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200608091739.2368-1-narmstrong@baylibre.com> <20200608091739.2368-4-narmstrong@baylibre.com>
In-Reply-To: <20200608091739.2368-4-narmstrong@baylibre.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 17 Jun 2020 11:09:21 +0530
Message-ID: <CAHLCerNJ4F3w2+nJHtq5+c-t7KNDnN-2eRQVSUDk7xB4y=X9YA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] thermal: add support for the MCU controlled FAN on
 Khadas boards
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 8, 2020 at 2:47 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
> on-board microcontroller.
>
> This implements the FAN control as thermal devices and as cell of the Khadas
> MCU MFD driver.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  drivers/thermal/Kconfig          |  11 ++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/khadas_mcu_fan.c | 174 +++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
>  create mode 100644 drivers/thermal/khadas_mcu_fan.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 91af271e9bb0..53efd381f434 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -490,4 +490,15 @@ config SPRD_THERMAL
>         help
>           Support for the Spreadtrum thermal sensor driver in the Linux thermal
>           framework.
> +
> +config KHADAS_MCU_FAN_THERMAL
> +       tristate "Khadas MCU controller FAN cooling support"
> +       depends on OF || COMPILE_TEST
> +       depends on MFD_KHADAS_MCU
> +       select MFD_CORE
> +       select REGMAP
> +       help
> +         If you say yes here you get support for the FAN controlled
> +         by the Microcontroller found on the Khadas VIM boards.
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 8c8ed7b79915..460428c2122c 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_ZX2967_THERMAL)  += zx2967_thermal.o
>  obj-$(CONFIG_UNIPHIER_THERMAL) += uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)     += sprd_thermal.o
> +obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)   += khadas_mcu_fan.o
> diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
> new file mode 100644
> index 000000000000..6995b443cad4
> --- /dev/null
> +++ b/drivers/thermal/khadas_mcu_fan.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Khadas MCU Controlled FAN driver
> + *
> + * Copyright (C) 2020 BayLibre SAS
> + * Author(s): Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/khadas-mcu.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
> +#include <linux/thermal.h>
> +
> +#define MAX_LEVEL 3
> +
> +struct khadas_mcu_fan_ctx {
> +       struct khadas_mcu *mcu;
> +       unsigned int level;
> +       struct thermal_cooling_device *cdev;
> +};
> +
> +static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
> +                                   unsigned int level)
> +{
> +       int ret;
> +
> +       ret = regmap_write(ctx->mcu->regmap, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> +                          level);
> +       if (ret)
> +               return ret;
> +
> +       ctx->level = level;
> +
> +       return 0;
> +}
> +
> +static int khadas_mcu_fan_get_max_state(struct thermal_cooling_device *cdev,
> +                                       unsigned long *state)
> +{
> +       struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +       if (!ctx)
> +               return -EINVAL;
> +
> +       *state = MAX_LEVEL;
> +
> +       return 0;
> +}
> +
> +static int khadas_mcu_fan_get_cur_state(struct thermal_cooling_device *cdev,
> +                                       unsigned long *state)
> +{
> +       struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +       if (!ctx)
> +               return -EINVAL;
> +
> +       *state = ctx->level;
> +
> +       return 0;
> +}
> +
> +static int
> +khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
> +                            unsigned long state)
> +{
> +       struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +       if (!ctx || (state > MAX_LEVEL))
> +               return -EINVAL;
> +
> +       if (state == ctx->level)
> +               return 0;
> +
> +       return khadas_mcu_fan_set_level(ctx, state);
> +}
> +
> +static const struct thermal_cooling_device_ops khadas_mcu_fan_cooling_ops = {
> +       .get_max_state = khadas_mcu_fan_get_max_state,
> +       .get_cur_state = khadas_mcu_fan_get_cur_state,
> +       .set_cur_state = khadas_mcu_fan_set_cur_state,
> +};
> +
> +static int khadas_mcu_fan_probe(struct platform_device *pdev)
> +{
> +       struct khadas_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
> +       struct thermal_cooling_device *cdev;
> +       struct device *dev = &pdev->dev;
> +       struct khadas_mcu_fan_ctx *ctx;
> +       int ret;
> +
> +       ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +       ctx->mcu = mcu;
> +       platform_set_drvdata(pdev, ctx);
> +
> +       cdev = devm_thermal_of_cooling_device_register(dev->parent,
> +                       dev->parent->of_node, "khadas-mcu-fan", ctx,
> +                       &khadas_mcu_fan_cooling_ops);
> +       if (IS_ERR(cdev)) {
> +               ret = PTR_ERR(cdev);
> +               dev_err(dev,
> +                               "Failed to register khadas-mcu-fan as cooling device: %d\n",
> +                               ret);
> +               return ret;
> +       }
> +       ctx->cdev = cdev;
> +       thermal_cdev_update(cdev);
> +
> +       return 0;
> +}
> +
> +static int khadas_mcu_fan_disable(struct device *dev)
> +{
> +       struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +       unsigned int level_save = ctx->level;
> +       int ret;
> +
> +       ret = khadas_mcu_fan_set_level(ctx, 0);
> +       if (ret)
> +               return ret;
> +
> +       ctx->level = level_save;
> +
> +       return 0;
> +}
> +
> +static void khadas_mcu_fan_shutdown(struct platform_device *pdev)
> +{
> +       khadas_mcu_fan_disable(&pdev->dev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int khadas_mcu_fan_suspend(struct device *dev)
> +{
> +       return khadas_mcu_fan_disable(dev);
> +}
> +
> +static int khadas_mcu_fan_resume(struct device *dev)
> +{
> +       struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +
> +       return khadas_mcu_fan_set_level(ctx, ctx->level);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(khadas_mcu_fan_pm, khadas_mcu_fan_suspend,
> +                        khadas_mcu_fan_resume);
> +
> +static const struct platform_device_id khadas_mcu_fan_id_table[] = {
> +       { .name = "khadas-mcu-fan-ctrl", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(platform, khadas_mcu_fan_id_table);
> +
> +static struct platform_driver khadas_mcu_fan_driver = {
> +       .probe          = khadas_mcu_fan_probe,
> +       .shutdown       = khadas_mcu_fan_shutdown,
> +       .driver = {
> +               .name           = "khadas-mcu-fan-ctrl",
> +               .pm             = &khadas_mcu_fan_pm,
> +       },
> +       .id_table       = khadas_mcu_fan_id_table,
> +};
> +
> +module_platform_driver(khadas_mcu_fan_driver);
> +
> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_DESCRIPTION("Khadas MCU FAN driver");
> +MODULE_LICENSE("GPL");
> --
> 2.22.0
>
