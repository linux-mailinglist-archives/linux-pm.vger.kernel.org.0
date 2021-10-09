Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C04427AB1
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 15:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhJINvv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 09:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhJINvv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 09:51:51 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5148FC061570;
        Sat,  9 Oct 2021 06:49:54 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s24so17573475oij.8;
        Sat, 09 Oct 2021 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v4f1Dq1UZFrwC53WbB/LwX1tkRuqMOrAVxvYfHHHznU=;
        b=NcumLnaPS0HfVdLULaJg4kg3S25H3iNqrFgwh1EbzEq+eiq1Ibwce1jBZVdIffQGos
         NpUCyWt3h03m033XfipC7Y/UNa6ridVVXlrV/TwkWw7pncbcBnnN/yDGW29fPjEhGaTp
         ttseTc02rzQXoS38BZgsLR8DB6CyUjm+b1r0tt6rIP5F+7F19jZGVyjG+C+aoqROwWkm
         S5iNN/JMhwzcpkwNFx2l3dKEW0CiZSKpApVU0WYIWmy0tsI+mKFRvShHwvZQOcwjW1W9
         EK2hEzL2YgxA0I/kSEndUPuJ43xbYZi/rb2vfeM+bnVRGvDlNboa/YaIOdTCn/Y6bIYM
         NqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v4f1Dq1UZFrwC53WbB/LwX1tkRuqMOrAVxvYfHHHznU=;
        b=k+VnxMOdmuCIWhDut+8g2+A/dNBhUrySY85SeVQZejLYcvOyXF3kzJGGaVsNUo0ZXT
         tAj5NUANhyJrXpfJuHduPxYmTvZf/+/h/UiIRHPGv5XLSDhzWPb6ihrH5s6wnSgyeAaS
         5L9xHJ0IRIYQr9NVgBrdeJpAZuHsat4fyiCDLAj1ldJVtoFEaJ6y4ec5O7dsV0csPMqo
         qyO3g+phwsJCGk2dBRq/2/RvgGt0Ln8MfalZwMtFDnl4aBrhz086J9ZXsUY72J1VEaZr
         grsyCGMlA9Ns5C8OMd9yBwtkzCHv45hPSZslNG2lxIic1WPPKHy2scytkZXh8+5t/uUl
         inzw==
X-Gm-Message-State: AOAM5318FYyOUB7KmrQ4h+7IZmVQL6Dee+gZcF0zAeuJQYeU6AXJ2ck/
        gvE0MeLaSEKX0r7FLUiYk0AYp0HwO+E=
X-Google-Smtp-Source: ABdhPJyLEaIhw9EBKK0KncqOw2ryqg+OcWM2QM1LMqppbweKSoQ+ZNhq9hFQvvE+/OtBpGmgcpzHqw==
X-Received: by 2002:aca:a858:: with SMTP id r85mr10280570oie.9.1633787393283;
        Sat, 09 Oct 2021 06:49:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e10sm529150oig.11.2021.10.09.06.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 06:49:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Alistair Francis <alistair@alistair23.me>, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20211009115031.18392-1-alistair@alistair23.me>
 <20211009115031.18392-10-alistair@alistair23.me>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v12 06/10] hwmon: sy7636a: Add temperature driver for
 sy7636a
Message-ID: <0ac0f13e-12eb-2272-3d4b-480dc6b54ee1@roeck-us.net>
Date:   Sat, 9 Oct 2021 06:49:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211009115031.18392-10-alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/9/21 4:50 AM, Alistair Francis wrote:
> This is a multi-function device to interface with the sy7636a
> EPD PMIC chip from Silergy.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>   arch/arm/configs/imx_v6_v7_defconfig |  1 +

That should be a separate patch.

>   drivers/hwmon/Kconfig                | 10 ++++
>   drivers/hwmon/Makefile               |  1 +
>   drivers/hwmon/sy7636a-hwmon.c        | 77 ++++++++++++++++++++++++++++

Documentation/hwmon/sy7636a-hwmon is missing.

>   4 files changed, 89 insertions(+)
>   create mode 100644 drivers/hwmon/sy7636a-hwmon.c
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 8a54a4d0181a..b87adf823e44 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -228,6 +228,7 @@ CONFIG_RN5T618_POWER=m
>   CONFIG_SENSORS_MC13783_ADC=y
>   CONFIG_SENSORS_GPIO_FAN=y
>   CONFIG_SENSORS_IIO_HWMON=y
> +CONFIG_SENSORS_SY7636A=y
>   CONFIG_THERMAL_STATISTICS=y
>   CONFIG_THERMAL_WRITABLE_TRIPS=y
>   CONFIG_CPU_THERMAL=y
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index c4578e8f34bb..59f358293202 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1651,6 +1651,16 @@ config SENSORS_SIS5595
>   	  This driver can also be built as a module. If so, the module
>   	  will be called sis5595.
>   
> +config SENSORS_SY7636A
> +	tristate "Silergy SY7636A"
> +	depends on I2C

That is an arbitrary dependency. The driver doesn't use I2C.

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
> index 000000000000..e0204278339b
> --- /dev/null
> +++ b/drivers/hwmon/sy7636a-hwmon.c
> @@ -0,0 +1,77 @@
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
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/sysfs.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
Alphabetic include file order please, and drop the includes which
are not needed (I don't see a need for slab.h or jiffies.h).

On the other side, the include of regmap.h is missing.

> +static ssize_t show_temp(struct device *dev,
> +	struct device_attribute *attr, char *buf)

If you use continuation lines, please align with "(".

> +{
> +	unsigned int reg_val;
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_read(regmap,
> +			SY7636A_REG_TERMISTOR_READOUT, &reg_val);

Line length limit is now 100, so this continuation line should not be needed.

> +	if (ret)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", reg_val);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp0, 0444, show_temp, NULL, 0);
> +
> +static struct attribute *sy7636a_attrs[] = {
> +	&sensor_dev_attr_temp0.dev_attr.attr,

FWIW, there is no "temp0" in the hwmon ABI. Temperature sensor
numbering starts with 1. Not that it matters,
devm_hwmon_device_register_with_info() creates attributes internally.

> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(sy7636a);
> +
> +static int sy7636a_sensor_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	struct device *hwmon_dev;
> +	int err;
> +
> +	if (!regmap)
> +		return -EPROBE_DEFER;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
> +			"sy7636a_temperature", regmap, sy7636a_groups);
> +

Please use devm_hwmon_device_register_with_info().

> +	if (IS_ERR(hwmon_dev)) {
> +		err = PTR_ERR(hwmon_dev);
> +		dev_err(&pdev->dev, "Unable to register hwmon device, returned %d", err);

I dislike driver noise, but if it is retained please add "\n".

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

