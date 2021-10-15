Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2342F4EF
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 16:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhJOOOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 10:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbhJOOO1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 10:14:27 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43263C06176F;
        Fri, 15 Oct 2021 07:12:14 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n63so13269075oif.7;
        Fri, 15 Oct 2021 07:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E1fykEaEp8TohMY+IiHVmw9TscjKXemOxBpXDundzLQ=;
        b=SL/ewftzAqVc7u48caQAwLWiVkleZ07bgL1jRQwWvyyyVlL6ZCJ6BKAaA+GClbCJmd
         Fsj6oABT/OSjZRmsQyfrqh1pMCCugBrGzRjfHGxqJGWZVe55UAstK7y6M0hic4cGCg6j
         ofbj79o957HGo/TyoEPwUElYIhdmC3hdJBLA9A1LZqf1KvT0GnHY93cABCRpCQl/LJj1
         9Bbc729m2QrmKUbRUNLhFHjndQf1Jcvsl4PQS3ZSXOAXDgoz9ZHM0sELL62dF4wc0ugo
         CBOWl3SMygdoF6DhGljeTd3Yd/gIzrFNefPw84wqtBag9CPUOOvMZm0y1Mhv9C6SsGsd
         ijzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E1fykEaEp8TohMY+IiHVmw9TscjKXemOxBpXDundzLQ=;
        b=KdE6p2LveCUKOuDYUsGKVvLsWPYl83etSRYz7o5MC33nRnbQD7BA7LQA6lF13iZWbt
         hWbmwyR1qfjGM5VG2tnMuN9pUfXs0XjyOhg3//nX6o0aeKcrNevHsw03YCojaO+29Hnd
         zz+xhO0tPaH0s69aZCi/pOvwAWA10d8xqrsTHjkEpJ6nFO5PW55Rpozday3nX4j3wQSG
         PrYbH/XtVOaSsXVd4VZE7kPbsMAWg2zBW4NARcG5CkvjGhqYYYduuHEZsM2JwtrD01eG
         cq67nVfYAvnOIDvjVUs3WBfUYmaHygtTgWuSPnkauCBWnO3VFOzmlQz64IJ7OSnE0qhI
         os/A==
X-Gm-Message-State: AOAM530wzdFV/83Yqq2b8GNkHFbCgcRohEs5nS5tI4Qk02W89CQukrJx
        1k5q/H+4jQBKOch7m6Y6JKS8n+8AfyU=
X-Google-Smtp-Source: ABdhPJzJCmCho+YkOarrtHmJ2r8dMQMrpGl7fFTl/9bdF/txv43Gz0mliDwMq+3b/jQgNXijMFgQGQ==
X-Received: by 2002:aca:eb82:: with SMTP id j124mr17608877oih.46.1634307133220;
        Fri, 15 Oct 2021 07:12:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2sm1261042otg.51.2021.10.15.07.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 07:12:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Alistair Francis <alistair@alistair23.me>, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20211015122551.38951-1-alistair@alistair23.me>
 <20211015122551.38951-7-alistair@alistair23.me>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v13 6/9] hwmon: sy7636a: Add temperature driver for
 sy7636a
Message-ID: <45191f55-e7a8-7d12-2f27-a03ab50626b1@roeck-us.net>
Date:   Fri, 15 Oct 2021 07:12:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015122551.38951-7-alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/15/21 5:25 AM, Alistair Francis wrote:
> This is a multi-function device to interface with the sy7636a
> EPD PMIC chip from Silergy.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>   Documentation/hwmon/sy7636a-hwmon.rst | 24 +++++++++
>   drivers/hwmon/Kconfig                 |  9 ++++
>   drivers/hwmon/Makefile                |  1 +
>   drivers/hwmon/sy7636a-hwmon.c         | 75 +++++++++++++++++++++++++++
>   4 files changed, 109 insertions(+)
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
> index 000000000000..a59628f87ff3
> --- /dev/null
> +++ b/drivers/hwmon/sy7636a-hwmon.c
> @@ -0,0 +1,75 @@
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
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
> +static ssize_t show_temp(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	unsigned int reg_val;
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_read(regmap, SY7636A_REG_TERMISTOR_READOUT, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", reg_val);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp0, 0444, show_temp, NULL, 0);
> +

This must be temp1_input. "temp0" is not a standard attribute,
and without standard attributes the driver is pointless.

> +static struct attribute *sy7636a_attrs[] = {
> +	&sensor_dev_attr_temp0.dev_attr.attr,
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
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +			"sy7636a_temperature", regmap, NULL, sy7636a_groups);


I am not going to accept this. The groups pointer is only supposed
to be used for non-standard attributes.

Anyway, it is pointless to have both a thermal driver and a hwmon
driver. The hwmon driver can register the thermal node if the _info
interface is used properly, and the thermal driver can register
a hwmon interface using [devm_]thermal_add_hwmon_sysfs(). If you don't
want to use the _info API in the hwmon driver, please drop this
driver and register the hwmon interface from the thermal driver.

Thanks,
Guenter

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

