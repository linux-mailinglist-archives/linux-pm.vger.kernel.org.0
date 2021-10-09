Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDCE427E19
	for <lists+linux-pm@lfdr.de>; Sun, 10 Oct 2021 01:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhJIXvN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 19:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJIXvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 19:51:13 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F7BC061570;
        Sat,  9 Oct 2021 16:49:15 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l7-20020a0568302b0700b0054e40740571so10752165otv.0;
        Sat, 09 Oct 2021 16:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=je1XZIxljgdSR278fp4p1LdoO9f59hu34O6qug1reV4=;
        b=qM09xTUaQU5TmqVOUFyfH71NBCO+EsREBkLHEny26Z67CdFRvMMhd4LrpcmsN9VtBc
         mHndOfODqBDmmWHy8ppw8rBJPhbQelbqyhH4pvsJLz6PSTOxAkikQWMZmGNHioq6JiA1
         E820I2jcws5Ik6gYp9xraqcpdUD+nWK9kp9tyx7E93gB2xQGt+Ai5AIL9lOSREttbY9T
         Ns13lyFcoTqCH5eSeel1WT9tBn9qgHdrFYIIDG89hSEyfCDwnoCj1swHi+0BS1iVPZef
         XohXq08mX/UciM18H8t3h8cYmy74RT0KRMSHllzAy5YiEzGgpyE2Zb+bOqo/04lRQeoU
         g5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=je1XZIxljgdSR278fp4p1LdoO9f59hu34O6qug1reV4=;
        b=TxT7Rl7DPhqVHyjiF5XJ+Qs1j92wodvNq/TlHKlk2xAT57SyuRgHMoo9TBu5I4BgVG
         S8jqsJk+FiPNXJZOQRuzILoAaEvORxNbw+8+Qvl24U8n3i/JS3Zuc2jvNW/+7+4XJd8R
         99VvScKcJ2+a+2oitAwe6ax+35eORKZQFFLPA1FKmnYUsqcET1+8JPXyauS3liWvo0bO
         VixdaELdlhoX1SgMqOwOD612fKMOp5ABwpR9nNIfCD1k0JHj+TXMLqTwYmt4NX63jHYZ
         wn5hZ7Vr/ZTo+KYRFam5kTZ4l9vkf2yPFMqOnFwqB0m921uOvrYCLygAsUDIL74+YRtO
         /ZnQ==
X-Gm-Message-State: AOAM531A/g+/3FsS+2bIUGDMr6M7yLTaJ1/8M5rp2zIqKSB1pV59FaVB
        mHifZ+ETG6X4NrvMjAa1spQ=
X-Google-Smtp-Source: ABdhPJxzP2b+kx2aWPE8XYDoJOmsRkxxYSAqAsXQJgb9xBBnyTGDFsYtgPTbMzowveRS0rvALOwVrA==
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr14457570otp.44.1633823354966;
        Sat, 09 Oct 2021 16:49:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k21sm796717oig.26.2021.10.09.16.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 16:49:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 9 Oct 2021 16:49:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com, amitk@kernel.org,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v12 05/10] thermal: sy7636a: Add thermal driver for
 sy7636a
Message-ID: <20211009234913.GA2234993@roeck-us.net>
References: <20211009115031.18392-1-alistair@alistair23.me>
 <20211009115031.18392-9-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009115031.18392-9-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 09, 2021 at 09:50:27PM +1000, Alistair Francis wrote:
> Add thermal driver to enable kernel based polling
> and shutdown of device for temperatures out of spec
> 

It _should_ be possible to implement this as part of the hwmon driver
(by using the _with_info hwmon API).

Guenter

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/thermal/Kconfig           |  6 ++
>  drivers/thermal/Makefile          |  1 +
>  drivers/thermal/sy7636a_thermal.c | 94 +++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+)
>  create mode 100644 drivers/thermal/sy7636a_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index d7f44deab5b1..6ee0e7de1b37 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -450,6 +450,12 @@ depends on (ARCH_STI || ARCH_STM32) && OF
>  source "drivers/thermal/st/Kconfig"
>  endmenu
>  
> +config SY7636A_THERMAL
> +	tristate "SY7636A thermal management"
> +	help
> +	  Enable the sy7636a thermal driver, which supports the
> +	  temperature sensor embedded in Silabs SY7636A IC.
> +
>  source "drivers/thermal/tegra/Kconfig"
>  
>  config GENERIC_ADC_THERMAL
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 82fc3e616e54..2e1aca8a0a09 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
>  obj-y				+= intel/
>  obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
>  obj-y				+= st/
> +obj-$(CONFIG_SY7636A_THERMAL)	+= sy7636a_thermal.o
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>  obj-y				+= tegra/
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> diff --git a/drivers/thermal/sy7636a_thermal.c b/drivers/thermal/sy7636a_thermal.c
> new file mode 100644
> index 000000000000..9e58305ca3ce
> --- /dev/null
> +++ b/drivers/thermal/sy7636a_thermal.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Functions to access SY3686A power management chip temperature
> + *
> + * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> + *
> + * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> + *          Alistair Francis <alistair@alistair23.me>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
> +static int sy7636a_get_temp(void *arg, int *res)
> +{
> +	unsigned int mode_ctr;
> +	int ret, reg_val;
> +	struct regmap *regmap = arg;
> +	bool isVoltageActive;
> +
> +	ret = regmap_read(regmap,
> +			SY7636A_REG_OPERATION_MODE_CRL, &mode_ctr);
> +	if (ret)
> +		return ret;
> +
> +	isVoltageActive = mode_ctr & SY7636A_OPERATION_MODE_CRL_ONOFF;
> +
> +	/* If operation mode isn't set to control, then let's set it. */
> +	if (!isVoltageActive) {
> +		ret = regmap_write(regmap,
> +				SY7636A_REG_OPERATION_MODE_CRL,
> +				mode_ctr | SY7636A_OPERATION_MODE_CRL_ONOFF);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_read(regmap,
> +			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Restore the operation mode if it wasn't set */
> +	if (!isVoltageActive) {
> +		ret = regmap_write(regmap,
> +				SY7636A_REG_OPERATION_MODE_CRL,
> +				mode_ctr);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*res = reg_val * 1000;
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_of_device_ops ops = {
> +	.get_temp	= sy7636a_get_temp,
> +};
> +
> +static int sy7636a_thermal_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	struct thermal_zone_device *thermal_zone_dev;
> +
> +	thermal_zone_dev = devm_thermal_zone_of_sensor_register(
> +			pdev->dev.parent,
> +			0,
> +			regmap,
> +			&ops);
> +
> +	return PTR_ERR_OR_ZERO(thermal_zone_dev);
> +}
> +
> +static const struct platform_device_id sy7636a_thermal_id_table[] = {
> +	{ "sy7636a-thermal", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, sy7636a_thermal_id_table);
> +
> +static struct platform_driver sy7636a_thermal_driver = {
> +	.driver = {
> +		.name = "sy7636a-thermal",
> +	},
> +	.probe = sy7636a_thermal_probe,
> +	.id_table = sy7636a_thermal_id_table,
> +};
> +module_platform_driver(sy7636a_thermal_driver);
> +
> +MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>");
> +MODULE_DESCRIPTION("SY7636A thermal driver");
> +MODULE_LICENSE("GPL v2");
