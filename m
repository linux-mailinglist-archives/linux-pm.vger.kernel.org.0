Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B7213906F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 12:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgAMLwp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 06:52:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42708 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgAMLwp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 06:52:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so8207746wro.9
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2020 03:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/85bRh7DZx/BqYPph+OQ0tMRg11cLCfIvkNDwt3UDaY=;
        b=PodXF9h5M+GQnNOoDYRyu2xI9UgBnt7R7b2MeYdJLfbMf7k91vUVzsmlC8iznOX3Zq
         pWBwt/Kd6slRFtQmtM7FMKrUd8751sITb7pk/TTHWMGrIDOB1u3fwpNWDSxiHD5o6D3f
         DtxoVSN5nuPOa6B4fxvmTGULiwYrWjYvEPupX31iAQmgRq/mEFFrngiQC8ZgYMpRbcXJ
         DjsA4sinyeY3JG/KAlVwgGdZrR9vCEeVxSzfp2Bsrx5s1kzfROeLrHCoqN13pmeHKs72
         FnfTge+bW2YiQ0cmkxhhUMvWXqkKJqN1hUmlgUC5LDC/GTAPbF2PlIWc8VDI85iOfCL/
         DI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/85bRh7DZx/BqYPph+OQ0tMRg11cLCfIvkNDwt3UDaY=;
        b=F2YiBALRGiqA9E69a1nuE+eWCL/rf6g2R3Om7UPwqIXFUUGDJ8nQalMB/YbSNmuYgs
         IcilD6slL3R66rK5ZD8BK/AoX8pYQg5gcVbj/Spb7q85e9CeofeYljx/HTpPH6JatOIS
         hW1QmoBmnrsaGcA+SD0p6JWjk2e7Vq5dyUQVmIE1s3szSqxOnHkLRJC81O+eeEEw4oiF
         3jEL5ciIcK6roEByQXBL97c04hwbJK3DIpe+sp17SCPvhrcLVL9BE4VvZyK4N1Wz4y/6
         Q0dPfMZXH8TTs4yXp56+qNkknxGVdWXq1Uoh1Of9d58rEG1UI0NWwzdkqubYtP+xrV9S
         pVHQ==
X-Gm-Message-State: APjAAAVObBTYFxduCvNqj8vUitFfzSHNSc5E9pZIvMDPrW/VhLA7/B+o
        ddzi8xKZeTmAig63QZGpyj3GEg==
X-Google-Smtp-Source: APXvYqxL7vwl2ympNdggit+5Vx+qZ4N7gmasa6xVw3HVQknojAyvSyCgEZqWuFZ+zgWHJUmtK0XsDg==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr18287388wrc.175.1578916362078;
        Mon, 13 Jan 2020 03:52:42 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:257b:a7b6:7749:8057? ([2a01:e34:ed2f:f020:257b:a7b6:7749:8057])
        by smtp.googlemail.com with ESMTPSA id 16sm13768886wmi.0.2020.01.13.03.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 03:52:41 -0800 (PST)
Subject: Re: [PATCH V4 2/4] thermal: Add BCM2711 thermal driver
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
References: <1578759342-4550-1-git-send-email-stefan.wahren@i2se.com>
 <1578759342-4550-3-git-send-email-stefan.wahren@i2se.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a4f3bb11-c2ba-a679-bebf-33c762de5f8d@linaro.org>
Date:   Mon, 13 Jan 2020 12:52:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578759342-4550-3-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/01/2020 17:15, Stefan Wahren wrote:
> This adds the thermal sensor driver for the Broadcom BCM2711 SoC,
> which is placed on the Raspberry Pi 4. The driver only provides
> SoC temperature reading so far.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/thermal/broadcom/Kconfig           |   7 ++
>  drivers/thermal/broadcom/Makefile          |   1 +
>  drivers/thermal/broadcom/bcm2711_thermal.c | 129 +++++++++++++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 drivers/thermal/broadcom/bcm2711_thermal.c
> 
> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
> index cf43e15..061f1db 100644
> --- a/drivers/thermal/broadcom/Kconfig
> +++ b/drivers/thermal/broadcom/Kconfig
> @@ -1,4 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config BCM2711_THERMAL
> +	tristate "Broadcom AVS RO thermal sensor driver"
> +	depends on ARCH_BCM2835 || COMPILE_TEST
> +	depends on THERMAL_OF && MFD_SYSCON
> +	help
> +	  Support for thermal sensors on Broadcom BCM2711 SoCs.
> +
>  config BCM2835_THERMAL
>  	tristate "Thermal sensors on bcm2835 SoC"
>  	depends on ARCH_BCM2835 || COMPILE_TEST
> diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
> index 490ab1f..c917b24 100644
> --- a/drivers/thermal/broadcom/Makefile
> +++ b/drivers/thermal/broadcom/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_BCM2711_THERMAL)		+= bcm2711_thermal.o
>  obj-$(CONFIG_BCM2835_THERMAL)		+= bcm2835_thermal.o
>  obj-$(CONFIG_BRCMSTB_THERMAL)		+= brcmstb_thermal.o
>  obj-$(CONFIG_BCM_NS_THERMAL)		+= ns-thermal.o
> diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
> new file mode 100644
> index 0000000..b1d3c4d
> --- /dev/null
> +++ b/drivers/thermal/broadcom/bcm2711_thermal.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Broadcom AVS RO thermal sensor driver
> + *
> + * based on brcmstb_thermal
> + *
> + * Copyright (C) 2020 Stefan Wahren
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +
> +#include "../thermal_hwmon.h"
> +
> +#define AVS_RO_TEMP_STATUS		0x200
> + #define AVS_RO_TEMP_STATUS_valid_msk	(BIT(16) | BIT(10))
> + #define AVS_RO_TEMP_STATUS_data_msk	GENMASK(9, 0)

extra spaces above and please keep uppercase for the macro.

> +struct bcm2711_thermal_priv {
> +	struct regmap *regmap;
> +	struct device *dev;

There is no gain of adding this pointer for the sake of adding a simple
trace in get_temp. Moreover, if the reading fails, the log will be
flooded with the error. Returning an error is enough, up to the caller
to handle the error and print something or not in this case.

> +	struct thermal_zone_device *thermal;
> +};
> +
> +static int bcm2711_get_temp(void *data, int *temp)
> +{
> +	struct bcm2711_thermal_priv *priv = data;
> +	int slope = thermal_zone_get_slope(priv->thermal);
> +	int offset = thermal_zone_get_offset(priv->thermal);
> +	u32 val;
> +	int ret;
> +	long t;
> +
> +	ret = regmap_read(priv->regmap, AVS_RO_TEMP_STATUS, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (!(val & AVS_RO_TEMP_STATUS_valid_msk)) {
> +		dev_err(priv->dev, "reading not valid\n");
> +		return -EIO;
> +	}
> +
> +	val &= AVS_RO_TEMP_STATUS_data_msk;
> +
> +	/* Convert a HW code to a temperature reading (millidegree celsius) */
> +	t = slope * val + offset;
> +	if (t < 0)
> +		*temp = 0;
> +	else
> +		*temp = t;

	*temp = t < 0 ? 0 : t;

> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops bcm2711_thermal_of_ops = {
> +	.get_temp	= bcm2711_get_temp,
> +};
> +
> +static const struct of_device_id bcm2711_thermal_id_table[] = {
> +	{ .compatible = "brcm,bcm2711-thermal" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bcm2711_thermal_id_table);
> +
> +static int bcm2711_thermal_probe(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *thermal;
> +	struct bcm2711_thermal_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *parent;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	/* get regmap from syscon node */
> +	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
> +	regmap = syscon_node_to_regmap(parent);
> +	of_node_put(parent);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(dev, "failed to get regmap: %d\n", ret);
> +		return ret;
> +	}
> +	priv->regmap = regmap;
> +	priv->dev = dev;
> +
> +	thermal = devm_thermal_zone_of_sensor_register(dev, 0, priv,
> +						       &bcm2711_thermal_of_ops);
> +	if (IS_ERR(thermal)) {
> +		ret = PTR_ERR(thermal);
> +		dev_err(dev, "could not register sensor: %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->thermal = thermal;
> +
> +	thermal->tzp->no_hwmon = false;
> +	ret = thermal_add_hwmon_sysfs(thermal);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver bcm2711_thermal_driver = {
> +	.probe = bcm2711_thermal_probe,
> +	.driver = {
> +		.name = "bcm2711_thermal",
> +		.of_match_table = bcm2711_thermal_id_table,
> +	},
> +};
> +module_platform_driver(bcm2711_thermal_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Stefan Wahren");
> +MODULE_DESCRIPTION("Broadcom AVS RO thermal sensor driver");
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

