Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30743020B
	for <lists+linux-pm@lfdr.de>; Sat, 16 Oct 2021 12:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbhJPKfK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Oct 2021 06:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244095AbhJPKfK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Oct 2021 06:35:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E815C061765
        for <linux-pm@vger.kernel.org>; Sat, 16 Oct 2021 03:33:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g2so4339208wme.4
        for <linux-pm@vger.kernel.org>; Sat, 16 Oct 2021 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vNUTePMGtYNkuPQndPj+HEpkmZyC7cECLvtS0DJp+As=;
        b=omsYXlnyaM9pWzRISy0ZZp7uu6+skSJIpUrgnr8FSX8WFfo7mTCOnl/Cj+heUEe17p
         lDbXTZ1pm7TxOQqBZFsdrXRTw6F+lefg9tKLbRuTGkUM+KJN57UtdwA61kQwEl+lcxTj
         ZxeTEHSog8Z+MHfIg+axE9FoTy7JOATAZ3R01aL4Ewdz0WQugogR38fFtfR8oWy2GurS
         SeRHWHp4zm524d50ATo8NE8xiQwYnq/csiBk/+oe+bDA2EKAuHCXxvAiJF21+E5NBurK
         H2Qe50YXaHhlhN4NqaF27Pnt83G5VQb+1t1cqV14EQ4KdcKMSrIVsOddOC7LSqo09wJc
         /Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vNUTePMGtYNkuPQndPj+HEpkmZyC7cECLvtS0DJp+As=;
        b=So79DCRhGXpa5uS2whCvHHeSRublimuXBop33qEhtKglwNsQJ0L1+OefJYWopZVs4v
         zddu6IWMNBndn0NYwIW8N40b+wyI1k9cAMmYI8cP+WkHLYrirDQHun8xnTrPG2xKwJ8I
         AALQb+E/lY7/8ILmutE6+oBrCvmY11o4L85umCSBKZAXTBVpSufdt4Tifq3eQ5RaZno0
         NhhR7fedTo3CaqFifNhpOS0G+cl3SrRY0aGoash6FPbRTztCXq82NaNj27k8RvPtViA4
         0i52XqGEISa64hLNdnk3V0O+9s40PA4G/otzgaj9LvVHgDPpksCZmmXjbCtAAULHCQFS
         XFYg==
X-Gm-Message-State: AOAM531ziX+D8DVyazyQghy343B3/2QgJ4AOMa7KrHEcIroKWrFgH6YL
        EQ4CjYJLKMOu6fa5CmogRYekiQ==
X-Google-Smtp-Source: ABdhPJwC9EiRTX+oL3Aqz2Y5p8CIsCKXqu3mglaRf0lqeBtjrbAzk4vuKXWs8sNuS5ca57rlkf5dbQ==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr32055637wmh.23.1634380380684;
        Sat, 16 Oct 2021 03:33:00 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2f2c:1294:472:2bfa? ([2a01:e34:ed2f:f020:2f2c:1294:472:2bfa])
        by smtp.googlemail.com with ESMTPSA id z2sm7170906wrn.89.2021.10.16.03.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 03:33:00 -0700 (PDT)
Subject: Re: [PATCH v13 5/9] thermal: sy7636a: Add thermal driver for sy7636a
To:     Alistair Francis <alistair@alistair23.me>, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, lars.ivar.miljeteig@remarkable.com
References: <20211015122551.38951-1-alistair@alistair23.me>
 <20211015122551.38951-6-alistair@alistair23.me>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cbd12880-253a-032e-9a80-4b414c8eb33a@linaro.org>
Date:   Sat, 16 Oct 2021 12:32:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015122551.38951-6-alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/10/2021 14:25, Alistair Francis wrote:
> Add thermal driver to enable kernel based polling
> and shutdown of device for temperatures out of spec

As it is an initial submission, could you give a brief description of
the sensor even if it is very simple ?

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

no deps ?

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

2021

> + *
> + * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> + *          Alistair Francis <alistair@alistair23.me>
> + */

From Documentation/process/submitting-drivers.rst

"""
Copyright:
                The copyright owner must agree to use of GPL.
                It's best if the submitter and copyright owner
                are the same person/entity. If not, the name of
                the person/entity authorizing use of GPL should be
                listed in case it's necessary to verify the will of
                the copyright owner.
"""

[Cc'ed Lars Ivar Miljeteig]

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
> +static int sy7636a_get_temp(void *arg, int *res)

...(struct thermal_zone_device *tz, int *temp)


> +{
> +	unsigned int mode_ctr;
> +	int ret, reg_val;
> +	struct regmap *regmap = arg;
> +	bool isVoltageActive;

Looks like c++ code

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

Who is turnning off the 'control' outside of this driver?

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

IIUC, this is a mfd, so if a component outside of this driver is
touching this SY7636A_REG_OPERATION_MODE_CRL, there is no guarantee
these operations will stay consistent.

Is that correct ?

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

regmap return value check, please

> +	thermal_zone_dev = devm_thermal_zone_of_sensor_register(
> +			pdev->dev.parent,
> +			0,
> +			regmap,
> +			&ops);

Fix indent please

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
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
