Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D8A1D460A
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgEOGmO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 02:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbgEOGmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 02:42:14 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813CBC05BD09
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 23:42:12 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id 134so312723vky.2
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 23:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BA59quelcDIdRO9l949jW9ARAKnurXI4XEzSqUYELU8=;
        b=0aGc2/3Oe8lE6W0GmBwKdtVn9A80fXiRgafCdAIrbNICAcWPA7bdshiQbSgWb+GY+c
         QXHSadz9Alk0IWk1K5O52dnHgeLOcDNrTOCRfeUCPq7f/aNQONzwN9xx0mqmxKns2dpa
         YQTBOSFnMib+b4loR0XIYQFU8dw7mptMNHNj72JKS3RrCDYBLSU/2W9tHNkj9JAhjUEf
         hqXKJ9oNvxsGbenMKAFNlQXvtnkCmXedDaB4jSSeZG2bn4sS1KLAWf4FaFOhkUKbz5h6
         lYNwGan+ItmduuXW+cesj+198/pDHKJgXy1irGQBotwHxwio5GymDrz50Jh17K11X6oL
         e0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BA59quelcDIdRO9l949jW9ARAKnurXI4XEzSqUYELU8=;
        b=V3tlwOd+EWMNACUuquTREKdJ/6KSgXmgd8jmpiBQTqKjtqJ0VlRMygqd2rNrGTNsR5
         /Paog6Sz1iDG1NmnjvCxvTNH3V5F9FFYhfWhcSEtzbL+YFSEzy3jGLYKfRKNi4gEcalg
         LY+q538NbSbG/OHd4pBEfoynGTaH7TCUeRwvKZPMQ1BJDrhu/LeNCINZGh/36fY15YRG
         1r+X+s3rVor5iUop7cqR3pPXrStwnxaAGiHvs9yFQqU/F8bHCbG9ldf///q5aI5D9VME
         Qv+7dCRpJF10SRf2t4Ju6AUz0SwxjsHjmHb8lfnxzQLaUcqwsnQnpI0KWg7Ir770z4Xp
         qjZQ==
X-Gm-Message-State: AOAM532uLgxky8hujsaUcpfDGVKwaQoYbStAfgPzslxua7cOvrvppqtM
        S720n1B1hNFIfShgl7StGwxZ7oFDabtPDwd/mO4D3g==
X-Google-Smtp-Source: ABdhPJy97WG9tZErtAsULFfSPQ2I8f+58cBdq2w509U3NXrskksxpY2YjHa+yvY7hNCX5KBgDaNNsncGxmdr5WGEM/I=
X-Received: by 2002:a1f:1386:: with SMTP id 128mr799240vkt.46.1589524930544;
 Thu, 14 May 2020 23:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200512132613.31507-1-narmstrong@baylibre.com> <20200512132613.31507-4-narmstrong@baylibre.com>
In-Reply-To: <20200512132613.31507-4-narmstrong@baylibre.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 15 May 2020 12:11:29 +0530
Message-ID: <CAHLCerPiC3QS5u5CGX20q_5aUk4sN5knF4043_=WjtbhDDGuUg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] thermal: add support for the MCU controlled FAN on
 Khadas boards
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
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

On Tue, May 12, 2020 at 6:56 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
> on-board microcontroller.
>
> This implements the FAN control as thermal devices and as cell of the Khadas
> MCU MFD driver.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/thermal/Kconfig          |  10 ++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/khadas_mcu_fan.c | 174 +++++++++++++++++++++++++++++++
>  3 files changed, 185 insertions(+)
>  create mode 100644 drivers/thermal/khadas_mcu_fan.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 91af271e9bb0..72b3960cc5ac 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -490,4 +490,14 @@ config SPRD_THERMAL
>         help
>           Support for the Spreadtrum thermal sensor driver in the Linux thermal
>           framework.
> +
> +config KHADAS_MCU_FAN_THERMAL
> +       tristate "Khadas MCU controller FAN cooling support"
> +       depends on OF || COMPILE_TEST

Could you add a depends on the some board/SoC Kconfig option here so
this doesn't show up for non-Amlogic/non-Khadas boards?

Looks OK otherwise.

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
> index 000000000000..044d4aba8be2
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
> +       ret = regmap_write(ctx->mcu->map, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
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
