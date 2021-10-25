Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFE43987C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJYO2d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 10:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJYO2d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 10:28:33 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB5C061745;
        Mon, 25 Oct 2021 07:26:11 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id y15-20020a9d460f000000b0055337e17a55so15166506ote.10;
        Mon, 25 Oct 2021 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+z5Y1Y0ONJ0cZmt38ZRly+OZvAAv3eLwdLp3HwT4KHs=;
        b=gxaw7UeD7mDauJ8UoIYBp9i5T8QidqHdac2965HLHdWWmgI5EfiqTFEH1wUKYc95CO
         QEwIt2ftZErz96kwa0SVM84R7cV9iuzfIZgbcG0bu/r74pI77HALXtIAfIHazsBOXCAW
         TtKbmMsaSrwV9u6DQBmrqxi/EiBMD+L+dEwJkBH9zDayv+JDbTA5nTZ6wknZn4/aMpoE
         478N9GpRRexJpqv+0DlzW2+kwct/daJoU6ACashNCCyq3wukhftooOG/UG0SbNy0BLjv
         Vkc7JElvEMyxCUnKpatllZrvUKa8ZFWhvm32bSA3eLT+yUY6exGDPAwML/Gu8CmBI0lR
         gQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+z5Y1Y0ONJ0cZmt38ZRly+OZvAAv3eLwdLp3HwT4KHs=;
        b=H3TtzUsHWouDR+W/jA8uCs2J6PyHueChTIzqgjDw+vh2wvALDcW7NDsAn6+Rk+ffax
         aCf7o29Jt0raiFoUWBCXZpMq3kroa4bJesEP5qBgg29Xd2hPoXmJpTxtP29FoiEjHEhc
         1N2ROsJ9DBHVM9WCBzkkSl44iPpTXOvXhkI33y0xMMOpqIKfJg6n8L8qA4Q+WSCzaC/Q
         RK5xXZu6esmh9AOIzGwmtw1cvjeJWnYn4Wv6m2j6oCUDSSxVvPSprvNOcQeVmjfWDxax
         +RUOl4L2C+9r8Km8pFgfjo8/r02xGscJ2b/2ATl9mVOCwAGJkYOEGmyIPANiOejnu090
         +2lA==
X-Gm-Message-State: AOAM5320gZe5jCPHq/oyK23T/mfh5iAx+T3VD4t36taQo8QpaieS7DfT
        NsQJtcxv6FQ7lItJi0gts1aCxUcmpnQ=
X-Google-Smtp-Source: ABdhPJyQ5k+clLsk+G7sG8aicM9QcLq1sVEwn6z+Oz6NJmVQ7dACDhrzdNm8Sakb5b4uUSd5dbafCQ==
X-Received: by 2002:a05:6830:19ec:: with SMTP id t12mr14835192ott.334.1635171970286;
        Mon, 25 Oct 2021 07:26:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3sm154619oih.23.2021.10.25.07.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 07:26:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Alistair Francis <alistair@alistair23.me>, robh+dt@kernel.org,
        kernel@pengutronix.de, lgirdwood@gmail.com, lee.jones@linaro.org,
        broonie@kernel.org
Cc:     s.hauer@pengutronix.de, rui.zhang@intel.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        amitk@kernel.org, shawnguo@kernel.org, alistair23@gmail.com,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        andreas@kemnade.info, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211025105309.37942-1-alistair@alistair23.me>
 <20211025105309.37942-6-alistair@alistair23.me>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v14 5/8] hwmon: sy7636a: Add temperature driver for
 sy7636a
Message-ID: <213a8532-8062-ddad-480b-405b6157e499@roeck-us.net>
Date:   Mon, 25 Oct 2021 07:26:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025105309.37942-6-alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/25/21 3:53 AM, Alistair Francis wrote:
> This is a multi-function device to interface with the sy7636a
> EPD PMIC chip from Silergy.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>   Documentation/hwmon/sy7636a-hwmon.rst |  24 ++++++

Needs to be added to Documentation/hwmon/index.rst

>   drivers/hwmon/Kconfig                 |   9 ++
>   drivers/hwmon/Makefile                |   1 +
>   drivers/hwmon/sy7636a-hwmon.c         | 114 ++++++++++++++++++++++++++
>   4 files changed, 148 insertions(+)
>   create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst
>   create mode 100644 drivers/hwmon/sy7636a-hwmon.c
> 
> diff --git a/Documentation/hwmon/sy7636a-hwmon.rst b/Documentation/hwmon/sy7636a-hwmon.rst
> new file mode 100644
> index 000000000000..6b3e36d028dd
> --- /dev/null
> +++ b/Documentation/hwmon/sy7636a-hwmon.rst
> @@ -0,0 +1,24 @@
> +Kernel driver sy7636a-hwmon
> +=========================
> +
> +Supported chips:
> +
> + * Silergy SY7636A PMIC
> +
> +
> +Description
> +-----------
> +
> +This driver adds hardware temperature reading support for
> +the Silergy SY7636A PMIC.
> +
> +The following sensors are supported
> +
> +  * Temperature
> +      - SoC on-die temperature in milli-degree C
> +
> +sysfs-Interface
> +---------------
> +
> +temp0_input
> +	- SoC on-die temperature (milli-degree C)
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index c4578e8f34bb..d768b833b721 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1651,6 +1651,15 @@ config SENSORS_SIS5595
>   	  This driver can also be built as a module. If so, the module
>   	  will be called sis5595.
>   
> +config SENSORS_SY7636A
> +	tristate "Silergy SY7636A"
> +	help
> +	  If you say yes here you get support for the thermistor readout of
> +	  the Silergy SY7636A PMIC.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sy7636a-hwmon.
> +
>   config SENSORS_DME1737
>   	tristate "SMSC DME1737, SCH311x and compatibles"
>   	depends on I2C && !PPC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 162940270661..1355ffdb1481 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -181,6 +181,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>   obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
>   obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>   obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
> +obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
>   obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
>   obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
>   obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
> diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
> new file mode 100644
> index 000000000000..1727a5f2a2ea
> --- /dev/null
> +++ b/drivers/hwmon/sy7636a-hwmon.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Functions to access SY3686A power management chip temperature
> + *
> + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> + *
> + * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> + *          Alistair Francis <alistair@alistair23.me>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/machine.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
> +struct sy7636a_data {
> +	struct regmap *regmap;
> +	struct regulator *regulator;
> +};
> +
> +static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long *temp)
> +{
> +	struct sy7636a_data *data = dev_get_drvdata(dev);
> +	int ret, reg_val;
> +
> +	ret = regulator_enable(data->regulator);
> +	if (ret)
> +		return ret;
> +

This doesn't look correct. There is no matching call to regulator_disable,
meaning the use count will go up with each read. Also, it seems to be too
late to enable the regulator just before reading the temperature value.
If the regulator is indeed useful, it would enable power to the circuitry
performing the temperature read operation just before actually reading
the temperature, leaving the circuitry no time to actually measure the
temperature.

> +	ret = regmap_read(data->regmap,
> +			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*temp = reg_val * 1000;
> +
> +	return 0;
> +}
> +
> +static umode_t sy7636a_is_visible(const void *data,
> +				   enum hwmon_sensor_types type,
> +				   u32 attr, int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;
> +
> +	if (attr != hwmon_temp_input)
> +		return 0;
> +
> +	return 0444;
> +}
> +
> +static const struct hwmon_ops sy7636a_hwmon_ops = {
> +	.is_visible = sy7636a_is_visible,
> +	.read = sy7636a_read,
> +};
> +
> +static const struct hwmon_channel_info *sy7636a_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info sy7636a_chip_info = {
> +	.ops = &sy7636a_hwmon_ops,
> +	.info = sy7636a_info,
> +};
> +
> +static int sy7636a_sensor_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	struct sy7636a_data *data;
> +	struct device *hwmon_dev;
> +	int err;
> +
> +	if (!regmap)
> +		return -EPROBE_DEFER;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GFP_KERNEL);
> +	if (!data) {
> +		return -ENOMEM;
> +	}
> +
> +	data->regmap = regmap;
> +	data->regulator = devm_regulator_get(&pdev->dev, "vcom");
> +

This needs an error check.

> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +			"sy7636a_temperature", regmap, &sy7636a_chip_info, NULL);
> +
> +	if (IS_ERR(hwmon_dev)) {
> +		err = PTR_ERR(hwmon_dev);
> +		dev_err(&pdev->dev, "Unable to register hwmon device, returned %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sy7636a_sensor_driver = {
> +	.probe = sy7636a_sensor_probe,
> +	.driver = {
> +		.name = "sy7636a-temperature",
> +	},
> +};
> +module_platform_driver(sy7636a_sensor_driver);
> +
> +MODULE_DESCRIPTION("SY7636A sensor driver");
> +MODULE_LICENSE("GPL");
> 

