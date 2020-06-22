Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7430C2040CF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 22:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgFVUCP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgFVUCO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 16:02:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF0AC0617B9
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 12:47:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so689967wme.5
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ODOSMs7hlDlueY6tO0Y70BJvb4BVdVy4itgUewuyPXQ=;
        b=uFaTK3d56s7T4bkZ+sGL815DQdbAIf5cC8yFeAHB7iaBtf7T1St4qfhuFmFMJ7f6/r
         t3xdDkBr2I+T39H09CDtHgv6oo/c7ibkh9AIfNq+39DuGI2KibjJMbijs4S4rv6k95+4
         6HUte0FXf/ZEXY12mInPLRA8OUYmrEzkOssBKxRitUovbFgfMVJH8hUDZts6iIO67xB+
         hRzNmZTbsoYDo6NjbpLWAxZnBVHBs6QniFGG65hb6aBZHA3jbq6CcBN3mIE/o93azWMy
         O/MOwa8kjvX6+gA7jakig8mo/V8Q2EqgdgjEmdhoRH0dQD+FvrNICMjEFKXgNifncJAk
         1dCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ODOSMs7hlDlueY6tO0Y70BJvb4BVdVy4itgUewuyPXQ=;
        b=lAfJa/Cd+D+hHzFUf5VUYF++VC4mvDyqNUbcN4FzCxXaBdxqE8arqDfWAF+E6xauvk
         skLFamNX3gAK8e594R9cvwIWna7UwpFjAoAVty20h0Jlv117Rim5qTMtfwptkeQhvhpp
         iyYz4Ws8FYPeI7v26teIW+osEAcSP3n69gQjdNEVOcIMfBt8L77I2Em511MWdFVQB89o
         PY3zMjjLXyZrOyWsfd7p2tINqv//Nx3y/J2aeYJfIDV93Sc2ohEAqKjR0s3rHviYLdDt
         3OP95F87dVYPp0eAXh3CuZYvsd1r9DSynr2zfBvGN+tBiT4TrBlGfk79EN/jhp1CGJWH
         hSZA==
X-Gm-Message-State: AOAM532ZfkmW6VMpHYMkYz6HCcV7OMIF3mdjtd2sMRPT2RtTg0cFm2MY
        DRFK2tmajPJTKRHsLQycgTg+FqcX84k=
X-Google-Smtp-Source: ABdhPJxEDVn/3oGDYMLsY0vvPxVE+iAjav6gvVGW8hxllefuYnkkGCqLpJrLn9luSaiJbbCUK8wrkw==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr1767496wma.129.1592855218748;
        Mon, 22 Jun 2020 12:46:58 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.googlemail.com with ESMTPSA id i17sm12945242wrc.34.2020.06.22.12.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 12:46:58 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] thermal: add support for the MCU controlled FAN on
 Khadas boards
To:     Neil Armstrong <narmstrong@baylibre.com>, lee.jones@linaro.org
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20200618133818.15857-1-narmstrong@baylibre.com>
 <20200618133818.15857-2-narmstrong@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <53aa62a3-1d8e-bc91-1a2b-88c766276beb@linaro.org>
Date:   Mon, 22 Jun 2020 21:46:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618133818.15857-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/06/2020 15:38, Neil Armstrong wrote:
> The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
> on-board microcontroller.
> 
> This implements the FAN control as thermal devices and as cell of the Khadas
> MCU MFD driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
> Hi Lee,
> 
> Could you apply this patch via the MFD tree since it depends on
> the linux/mfd/khadas-mcu.h header ?
> 
> This patch is unchanged from the v3 serie.
> 
> Thanks,
> Neil
> 
>  drivers/thermal/Kconfig          |  11 ++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/khadas_mcu_fan.c | 174 +++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
>  create mode 100644 drivers/thermal/khadas_mcu_fan.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 3eb2348e5242..0125561488c9 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -500,4 +500,15 @@ config SPRD_THERMAL
>  	help
>  	  Support for the Spreadtrum thermal sensor driver in the Linux thermal
>  	  framework.
> +
> +config KHADAS_MCU_FAN_THERMAL
> +	tristate "Khadas MCU controller FAN cooling support"
> +	depends on OF || COMPILE_TEST
> +	depends on MFD_KHADAS_MCU
> +	select MFD_CORE
> +	select REGMAP
> +	help
> +	  If you say yes here you get support for the FAN controlled
> +	  by the Microcontroller found on the Khadas VIM boards.
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 0c8b84a09b9a..4b6aabaa7e31 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
>  obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
> +obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
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
> +	struct khadas_mcu *mcu;
> +	unsigned int level;
> +	struct thermal_cooling_device *cdev;
> +};
> +
> +static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
> +				    unsigned int level)
> +{
> +	int ret;
> +
> +	ret = regmap_write(ctx->mcu->regmap, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> +			   level);
> +	if (ret)
> +		return ret;
> +
> +	ctx->level = level;
> +
> +	return 0;
> +}
> +
> +static int khadas_mcu_fan_get_max_state(struct thermal_cooling_device *cdev,
> +					unsigned long *state)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +	if (!ctx)
> +		return -EINVAL;

It is pointless to check 'ctx' is NULL, that was done at probe time.

> +	*state = MAX_LEVEL;
> +
> +	return 0;
> +}
> +
> +static int khadas_mcu_fan_get_cur_state(struct thermal_cooling_device *cdev,
> +					unsigned long *state)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +	if (!ctx)
> +		return -EINVAL;

Ditto

> +	*state = ctx->level;
> +
> +	return 0;
> +}
> +
> +static int
> +khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
> +			     unsigned long state)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +	if (!ctx || (state > MAX_LEVEL))
> +		return -EINVAL;

Ditto

> +	if (state == ctx->level)
> +		return 0;
> +
> +	return khadas_mcu_fan_set_level(ctx, state);
> +}
> +
> +static const struct thermal_cooling_device_ops khadas_mcu_fan_cooling_ops = {
> +	.get_max_state = khadas_mcu_fan_get_max_state,
> +	.get_cur_state = khadas_mcu_fan_get_cur_state,
> +	.set_cur_state = khadas_mcu_fan_set_cur_state,
> +};
> +
> +static int khadas_mcu_fan_probe(struct platform_device *pdev)
> +{
> +	struct khadas_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
> +	struct thermal_cooling_device *cdev;
> +	struct device *dev = &pdev->dev;
> +	struct khadas_mcu_fan_ctx *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	ctx->mcu = mcu;
> +	platform_set_drvdata(pdev, ctx);
> +
> +	cdev = devm_thermal_of_cooling_device_register(dev->parent,
> +			dev->parent->of_node, "khadas-mcu-fan", ctx,
> +			&khadas_mcu_fan_cooling_ops);
> +	if (IS_ERR(cdev)) {
> +		ret = PTR_ERR(cdev);
> +		dev_err(dev,
> +				"Failed to register khadas-mcu-fan as cooling device: %d\n",
> +				ret);
> +		return ret;
> +	}
> +	ctx->cdev = cdev;
> +	thermal_cdev_update(cdev);
> +
> +	return 0;
> +}
> +
> +static int khadas_mcu_fan_disable(struct device *dev)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +	unsigned int level_save = ctx->level;
> +	int ret;
> +
> +	ret = khadas_mcu_fan_set_level(ctx, 0);
> +	if (ret)
> +		return ret;
> +
> +	ctx->level = level_save;

Nitpicking : move the save section to suspend.

> +	return 0;
> +}
> +
> +static void khadas_mcu_fan_shutdown(struct platform_device *pdev)
> +{
> +	khadas_mcu_fan_disable(&pdev->dev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int khadas_mcu_fan_suspend(struct device *dev)
> +{
> +	return khadas_mcu_fan_disable(dev);
> +}
> +
> +static int khadas_mcu_fan_resume(struct device *dev)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +
> +	return khadas_mcu_fan_set_level(ctx, ctx->level);

Out of curiosity, did you check the fan is not continuously spinning
after a resume when the suspend happened during a mitigation phase?

> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(khadas_mcu_fan_pm, khadas_mcu_fan_suspend,
> +			 khadas_mcu_fan_resume);
> +
> +static const struct platform_device_id khadas_mcu_fan_id_table[] = {
> +	{ .name = "khadas-mcu-fan-ctrl", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, khadas_mcu_fan_id_table);
> +
> +static struct platform_driver khadas_mcu_fan_driver = {
> +	.probe		= khadas_mcu_fan_probe,
> +	.shutdown	= khadas_mcu_fan_shutdown,
> +	.driver	= {
> +		.name		= "khadas-mcu-fan-ctrl",
> +		.pm		= &khadas_mcu_fan_pm,
> +	},
> +	.id_table	= khadas_mcu_fan_id_table,
> +};
> +
> +module_platform_driver(khadas_mcu_fan_driver);
> +
> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_DESCRIPTION("Khadas MCU FAN driver");
> +MODULE_LICENSE("GPL");
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
