Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2531BA35F
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgD0MNg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0MNf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 08:13:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167B9C0610D5
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 05:13:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so20250709wrv.10
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 05:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bhYbBkGut7kyXltBMMZN/3mZQuIRQJU8EXP5s/lhqg0=;
        b=fDuJQ+Hwk5cstDoeLp7YZuST25aGVXFIVrRz6LE9RotFy5ElFphUFxGDeOsdJ51BdK
         Xra6HTXeK0C7awoxhG088osPKwDMa5+cIY5/pnWP8IYcvAP1v2a/zLSmHFM+DoVaDg85
         82NOW6k/AKu+KaR7wXZ9fZ7iYnTRp1IGUxIHXDfiALETCYES+yz10IaqDk/4hQN4Se2O
         luxU6UthjhJ6Hs/J/XEVDBwm53WbZlAGQ91neqEYlLV/z2A/ranuxheNx8k39PRnHtr+
         tIK3ryno/oRJbzCxGktHvIZ1QGUhG4e6BX19p4JflOMNjqqHPdS+7layKPF4MJb5PZhm
         TmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bhYbBkGut7kyXltBMMZN/3mZQuIRQJU8EXP5s/lhqg0=;
        b=UIvmd/0YVGR8PG7m/XfGTV/X6yqFh2dv1PjZji+el3lJxC8FKG2Z9Hz0Ukg1zrWvGR
         cG9mAqKsg6/1w2eksYNNbBR7N0Mxkh1ITwd0Bh3e5KEYiAxL6vn/LbUoZTVXt1rUNs1X
         gxGkFdswDfWc9zYLOLYP5DCPTzom+vIaoQAFnz5cunr7ucjBcOfAzOfXk9LtQKvundX2
         Y2iXa1XampgMnrR1uXVUz6dafOEwjAzJtIIWN28HyB7YNn6OV4Fc/jVgDH7dTTKaq/J/
         wU/xA+Z6GuThbvrUnKW0ThjODtd3XLl+pWDmPdaDIy4oEtVY6hSTw2yB80bGfjWych1C
         Mt2w==
X-Gm-Message-State: AGi0Puaej7NXSU/9RJuzNwyC/KMI8FQ1coA4pVyd8hmhSAMw6dhUHLXq
        TuZ8L8fsvuRHWQ9SP88sAw1gfg==
X-Google-Smtp-Source: APiQypLYYp1MByjnqv//p80ClA/THkj7IoAlJQR0JpW1sA4qj03glQ9fahVzQGZOAz/97YClPILbvw==
X-Received: by 2002:a5d:640a:: with SMTP id z10mr28451310wru.280.1587989612432;
        Mon, 27 Apr 2020 05:13:32 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id r20sm14690273wmh.26.2020.04.27.05.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 05:13:31 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] thermal: Add HiSilicon Kunpeng thermal driver
To:     Yang Shen <shenyang39@huawei.com>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com
Cc:     linux-pm@vger.kernel.org, linuxarm@huawei.com,
        wangzhou1@hisilicon.com
References: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
 <1587455093-33876-3-git-send-email-shenyang39@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <53ca3883-9155-c023-7916-10ec8cccf977@linaro.org>
Date:   Mon, 27 Apr 2020 14:13:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587455093-33876-3-git-send-email-shenyang39@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/04/2020 09:44, Yang Shen wrote:
> Support HiSilicon Kunpeng tsensor. the driver will report the max
> temperature for each core.

As this is a new driver, can you give a bit more details of the hardware
in this description.

A subsidiary question, why do you want to aggregate the temperatures in
this driver ?

> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Kunshan Tang <tangkunshan@huawei.com>
> ---
>  drivers/thermal/Kconfig           |   8 ++
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/kunpeng_thermal.c | 216 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 225 insertions(+)
>  create mode 100644 drivers/thermal/kunpeng_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5a05db5..7611b5d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -239,6 +239,14 @@ config HISI_THERMAL
>  	  thermal framework. cpufreq is used as the cooling device to throttle
>  	  CPUs when the passive trip is crossed.
> 
> +config KUNPENG_THERMAL
> +	tristate "HiSilicon kunpeng thermal driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  Enable this to plug HiSilicon kunpeng's thermal sensors driver into
> +	  the Linux thermal framework, which supports to get the highest
> +	  temperature of one Kunpeng SoC.
> +
>  config IMX_THERMAL
>  	tristate "Temperature sensor driver for Freescale i.MX SoCs"
>  	depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 9fb88e2..88ffca5 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>  obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
>  obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> +obj-$(CONFIG_KUNPENG_THERMAL)     += kunpeng_thermal.o
> diff --git a/drivers/thermal/kunpeng_thermal.c b/drivers/thermal/kunpeng_thermal.c
> new file mode 100644
> index 0000000..d22e875
> --- /dev/null
> +++ b/drivers/thermal/kunpeng_thermal.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020 HiSilicon Limited. */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#define KUNPENG_TSENSOR_CONTROL			0x20D0
> +#define KUNPENG_TSENSOR_ST			0x60D0
> +#define KUNPENG_TSENSOR_SAMPLE			0x60D4
> +#define KUNPENG_TSENSOR_CONTROL_EN		BIT(0)
> +
> +#define KUNPENG_TSENSOR_IS_READY(reg)		(((reg) >> 12) & 0x1)
> +#define KUNPENG_TSENSOR_IS_VALID(reg)		(((reg) >> 31) & 0x1)
> +#define KUNPENG_TSENSOR_TRIM_HIGH(reg)		(((reg) >> 15) & 0x7FF)
> +#define KUNPENG_TSENSOR_TRIM_LOW(reg)		((reg) & 0x7FF)
> +#define KUNPENG_TSENSOR_TEMP_VAL(reg)		((reg) & 0x3FF)
> +#define KUNPENG_TSENSOR_BASE_NUM(num)		(2 * (num))
> +#define KUNPENG_TSENSOR_TRIM_NUM(num)		(2 * (num) + 1)
> +
> +#define KUNPENG_TSENSOR_RD_INTVRL_US		5
> +#define KUNPENG_TSENSOR_RD_TMOUT_US		5000
> +#define KUNPENG_TSENSOR_BASIC_TMP		25000
> +#define KUNPENG_TSENSOR_BASIC_TRIM_RANGE	80000
> +
> +struct kunpeng_tsensor {
> +	void __iomem *base;
> +	void __iomem *trim_register;
> +};
> +
> +struct kunpeng_thermal_dev {
> +	u32 num_tsensors;
> +	struct kunpeng_tsensor tsensor[];
> +};
> +
> +static int kunpeng_thermal_temp_correct(u32 tmp, u32 trim)
> +{
> +	int trim_high = KUNPENG_TSENSOR_TRIM_HIGH(trim);
> +	int trim_low = KUNPENG_TSENSOR_TRIM_LOW(trim);
> +	int val = KUNPENG_TSENSOR_TEMP_VAL(tmp);
> +
> +	if (trim_high == trim_low)
> +		return INT_MIN;
> +
> +	/* temperature of tsensor needs to be calibrated */
> +	return KUNPENG_TSENSOR_BASIC_TRIM_RANGE * (val - trim_low) /
> +	       (trim_high - trim_low) + KUNPENG_TSENSOR_BASIC_TMP;

Is it possible to give some details about why this is done?

> +}
> +
> +static int kunpeng_thermal_get_temp(struct thermal_zone_device *thermal,
> +				    int *temp)
> +{
> +	struct kunpeng_thermal_dev *tdev = thermal->devdata;
> +	int tempmax = INT_MIN;
> +	u32 i, reg, tmp, trim;
> +	int ret;
> +
> +	for (i = 0; i < tdev->num_tsensors; i++) {
> +		/* Waiting for tsensor ready */
> +		ret = readl_relaxed_poll_timeout(tdev->tsensor[i].base +
> +						 KUNPENG_TSENSOR_ST, reg,
> +						 KUNPENG_TSENSOR_IS_READY(reg),
> +						 KUNPENG_TSENSOR_RD_INTVRL_US,
> +						 KUNPENG_TSENSOR_RD_TMOUT_US);
> +		if (ret) {
> +			dev_err(&thermal->device,
> +				"Tsensor%u isn't ready!\n", i);
> +			continue;
> +		}
> +
> +		/* checking if temperatures are valid */
> +		tmp = readl_relaxed(tdev->tsensor[i].base +
> +				    KUNPENG_TSENSOR_SAMPLE);
> +		if (!KUNPENG_TSENSOR_IS_VALID(tmp)) {
> +			dev_err(&thermal->device,
> +				"Tsensor%u temperature is invalid!\n", i);
> +			continue;
> +		}
> +
> +		trim = readl_relaxed(tdev->tsensor[i].trim_register);
> +
> +		ret = kunpeng_thermal_temp_correct(tmp, trim);
> +		if (ret == INT_MIN) {
> +			dev_err(&thermal->device,
> +				"Tsensor%u trim value is invalid!\n", i);
> +			continue;
> +		}
> +
> +		tempmax = max(ret, tempmax);
> +	}
> +
> +	if (tempmax == INT_MIN)
> +		return -EINVAL;
> +
> +	*temp = tempmax;
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_device_ops ops = {
> +	.get_temp	= kunpeng_thermal_get_temp,
> +};
> +
> +static int kunpeng_thermal_get_iobase(struct platform_device *pdev,
> +				      struct kunpeng_tsensor *tsensor,
> +				      u32 resource_num)
> +{
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, resource_num);
> +	if (!res)
> +		return -EINVAL;
> +
> +	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(base))
> +		return -EINVAL;
> +
> +	if (resource_num & 1)
> +		tsensor->trim_register = base;
> +	else
> +		tsensor->base = base;
> +
> +	return 0;
> +}
> +
> +static int kunpeng_thermal_probe(struct platform_device *pdev)
> +{
> +	u32 num_tsensors = pdev->num_resources >> 1;
> +	struct thermal_zone_device *thermal_zone;
> +	struct kunpeng_thermal_dev *tdev;
> +	u32 i, reg;
> +	int ret;
> +
> +	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev) + sizeof(*tdev->tsensor) *
> +			    num_tsensors, GFP_KERNEL);
> +	if (!tdev)
> +		return -ENOMEM;
> +
> +	tdev->num_tsensors = num_tsensors;
> +
> +	for (i = 0; i < num_tsensors; i++) {
> +		ret = kunpeng_thermal_get_iobase(pdev, &tdev->tsensor[i],
> +						 KUNPENG_TSENSOR_BASE_NUM(i));
> +		if (ret) {
> +			dev_err(&pdev->dev, "Fail to ioremap base!\n");
> +			return ret;
> +		}
> +
> +		ret = kunpeng_thermal_get_iobase(pdev, &tdev->tsensor[i],
> +						 KUNPENG_TSENSOR_TRIM_NUM(i));
> +		if (ret) {
> +			dev_err(&pdev->dev, "Fail to ioremap trim register!\n");
> +			return ret;
> +		}

I initially thought there was a bug because the function is called with
the &tsensor[i] twice, then noticed the spin in the underlying function.

It is probably better to make the code a bit more self-explicit. May be
increment 'i' by a step of 2?


> +		reg = readl_relaxed(tdev->tsensor[i].base +
> +				    KUNPENG_TSENSOR_CONTROL);
> +		writel_relaxed(reg | KUNPENG_TSENSOR_CONTROL_EN,
> +			       tdev->tsensor[i].base +
> +			       KUNPENG_TSENSOR_CONTROL);

Please add helpers with explicit function name for understanding.

> +	}
> +
> +	thermal_zone = thermal_zone_device_register("kunpeng_thermal", 0, 0,
> +						    tdev, &ops, NULL, 0, 0);
> +	if (IS_ERR(thermal_zone)) {
> +		dev_err(&pdev->dev, "Fail to register to thermal subsystem\n");
> +		return PTR_ERR(thermal_zone);
> +	}
> +
> +	platform_set_drvdata(pdev, thermal_zone);
> +
> +	return 0;
> +}
> +
> +/**
> + * kunpeng_thermal_remove() - Unregister device from thermal.
> + *
> + * This driver and IMU share tsensor devices. This function only unregister
> + * devices from thermal but never disable tsensors.

What is the IMU ?

I don't see in this driver anything related to the sensors being shared
with something else.

> + */
> +static int kunpeng_thermal_remove(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *thermal_zone = platform_get_drvdata(pdev);
> +
> +	thermal_zone_device_unregister(thermal_zone);
Why not add a devm_thermal_zone_device_register() ? and get rid of this
function ?

> +	return 0;
> +}
> +
> +static const struct acpi_device_id kunpeng_thermal_acpi_match[] = {
> +	{ "HISI0371", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, kunpeng_thermal_acpi_match);
> +
> +static struct platform_driver kunpeng_thermal_driver = {
> +	.probe		= kunpeng_thermal_probe,
> +	.remove		= kunpeng_thermal_remove,
> +	.driver		= {
> +		.name	= "kunpeng_thermal",
> +		.acpi_match_table = ACPI_PTR(kunpeng_thermal_acpi_match),
> +	},
> +};
> +
> +module_platform_driver(kunpeng_thermal_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Yang Shen <shenyang39@huawei.com>");
> +MODULE_DESCRIPTION("HiSilicon Kunpeng thermal driver");
> --
> 2.7.4
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
