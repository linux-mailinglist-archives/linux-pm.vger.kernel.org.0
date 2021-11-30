Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A01546318F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Nov 2021 11:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhK3Kzi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Nov 2021 05:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbhK3Kzb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Nov 2021 05:55:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6F6C061746
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 02:52:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 133so17086332wme.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 02:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l/mn5NCaNhYntwm97MfZubwn0q0Gqsso7qEQGS70gDc=;
        b=ZlNQLENAGChJm+RwFQCZ0+jS35IKcerLqGkJg3MPgYsolAuIe7QIelpHQcd6dVPOcM
         2O8nwCwCDuO2O1Q5ZpPa2rbPNTbYFzXHJPY1oq4ZZ5dIRn+kIwgqCc3IVhmu3ofCJ0HK
         JyLv4PrG23b492UC9VOi8WWpOpbBFxQcqwq/p7EqQoc4RlTkiILUpTIKBlkDBAGNBB6S
         3kWcb8r4jIjf0Mq51wjY7pr6oF0Z9KWaQUdV/9ul99RbDXCSfxk/lBjCoWxBmOqeweFr
         HqIPKtUhNSSllLcYPpwNfkLR4KPXacAmL3s81MCKp0p7C7Z28K+TBO/PdHKcfaeVXAip
         Cwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l/mn5NCaNhYntwm97MfZubwn0q0Gqsso7qEQGS70gDc=;
        b=T3KmhhNK2z/uXlwhMvgRKyTWaF6BcLXn+ozI/luVu4km9Lj34GJV0gv8NsqAkwqGNd
         qta/ebacOYNlIoFSKuSvtV9YtYmKrr5n/hY/oykTLDilaq+ckp6I+tRFzw84sZQrryrO
         iAkAdUaejSDuVlU9cFF0H+ENHVnRBAs27dGsYGI9vDLl7ZcHzIkadSDMJrP5/dPQA6zh
         Vz62+nRar3LSvfmyKAmZ2w+Ehrt1QBykH+uL3wAXOUrlj7Eo22xkaPfQMiDbPs8wB4pc
         LJ1FCjYyVReBSTdNAiMsKZ+wtPVpWzwA8Cj9MEhjvc3doykHc3kdH0N17B3586ViiEJ7
         YcMQ==
X-Gm-Message-State: AOAM530+4vSr2Pjr5eO09L+6mh5M0+HX70ABvKjvfk1toxmqxkVvhpHt
        ll4Q/UPDuiTl0kcwE2bn0RfAiw==
X-Google-Smtp-Source: ABdhPJwcvJUZCWkaordSdThMvMjZBYyqClAeWOu/JSFq1ZkFasLm0paPQsBU8aHwy4S1lN/qI4rfqA==
X-Received: by 2002:a1c:183:: with SMTP id 125mr4151330wmb.0.1638269524372;
        Tue, 30 Nov 2021 02:52:04 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7880:daae:2d50:bb5e? ([2a01:e34:ed2f:f020:7880:daae:2d50:bb5e])
        by smtp.googlemail.com with ESMTPSA id t17sm2247779wmq.15.2021.11.30.02.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 02:52:03 -0800 (PST)
Subject: Re: [PATCH v2 2/2] thermal/drivers: Add TSU driver for RZ/G2L
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20211120194711.9073-1-biju.das.jz@bp.renesas.com>
 <20211120194711.9073-3-biju.das.jz@bp.renesas.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <824a8949-d643-6938-6e58-6dfb20d62f70@linaro.org>
Date:   Tue, 30 Nov 2021 11:52:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211120194711.9073-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/11/2021 20:47, Biju Das wrote:
> Add Thermal Sensor Unit(TSU) driver for RZ/G2L SoC.

Please give a technical description of the sensor as it is the first
submission.

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
>  * Removed devm_add_action_or_reset from probe.
> ---
>  drivers/thermal/Kconfig         |   9 ++
>  drivers/thermal/Makefile        |   1 +
>  drivers/thermal/rzg2l_thermal.c | 235 ++++++++++++++++++++++++++++++++
>  3 files changed, 245 insertions(+)
>  create mode 100644 drivers/thermal/rzg2l_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index d7f44deab5b1..e37691e0bf20 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -354,6 +354,15 @@ config RCAR_GEN3_THERMAL
>  	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver into
>  	  the Linux thermal framework.
>  
> +config RZG2L_THERMAL
> +	tristate "Renesas RZ/G2L thermal driver"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	depends on OF
> +	help
> +	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
> +	  thermal framework.
> +
>  config KIRKWOOD_THERMAL
>  	tristate "Temperature sensor on Marvell Kirkwood SoCs"
>  	depends on MACH_KIRKWOOD || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 82fc3e616e54..f0c36a1530d5 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_SUN8I_THERMAL)     += sun8i_thermal.o
>  obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
>  obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
>  obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
> +obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
>  obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
>  obj-y				+= samsung/
>  obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
> diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
> new file mode 100644
> index 000000000000..ea828c15dd1e
> --- /dev/null
> +++ b/drivers/thermal/rzg2l_thermal.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L TSU Thermal Sensor Driver
> + *
> + * Copyright (C) 2021 Renesas Electronics Corporation
> + */
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <linux/thermal.h>
> +
> +#include "thermal_hwmon.h"
> +
> +#define CTEMP_MASK	0xFFF
> +
> +/* default calibration values, if FUSE values are missing */
> +#define SW_CALIB0_VAL	3148
> +#define SW_CALIB1_VAL	503
> +
> +/* Register offsets */
> +#define TSU_SM		0x00
> +#define TSU_ST		0x04
> +#define TSU_SAD		0x0C
> +#define TSU_SS		0x10
> +
> +#define OTPTSUTRIM_REG(n)	(0x18 + ((n) * 0x4))
> +
> +/* Sensor Mode Register(TSU_SM) */
> +#define TSU_SM_EN_TS		BIT(0)
> +#define TSU_SM_ADC_EN_TS	BIT(1)
> +#define TSU_SM_NORMAL_MODE	(TSU_SM_EN_TS | TSU_SM_ADC_EN_TS)
> +
> +/* TSU_ST bits */
> +#define TSU_ST_START		BIT(0)
> +
> +#define TSU_SS_CONV_RUNNING	BIT(0)
> +
> +#define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
> +#define MCELSIUS(temp)		((temp) * 1000)

cf. include/linux/units.h

> +#define TS_CODE_CAP_TIMES	8	/* Capture  times */
> +#define RZG2L_THERMAL_GRAN	500	/* milli Celsius */
> +
> +#define RZG2L_TSU_SS_TIMEOUT_US	1000
> +
> +struct rzg2l_thermal_priv {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct thermal_zone_device *zone;
> +	struct reset_control *rstc;
> +	u32 calib0, calib1;
> +};
> +
> +static inline u32 rzg2l_thermal_read(struct rzg2l_thermal_priv *priv, u32 reg)
> +{
> +	return ioread32(priv->base + reg);
> +}
> +
> +static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 reg,
> +				       u32 data)
> +{
> +	iowrite32(data, priv->base + reg);
> +}
> +
> +static int rzg2l_thermal_round(int temp)
> +{
> +	int result, round_offs;
> +
> +	round_offs = temp >= 0 ? RZG2L_THERMAL_GRAN / 2 : -RZG2L_THERMAL_GRAN / 2;
> +	result = (temp + round_offs) / RZG2L_THERMAL_GRAN;
> +
> +	return result * RZG2L_THERMAL_GRAN;
> +}

roundup() | rounddown() ? (cf math.h)

> +
> +static int rzg2l_thermal_get_temp(void *devdata, int *temp)
> +{
> +	struct rzg2l_thermal_priv *priv = devdata;
> +	u32 result, dsensor, ts_code_ave;
> +	int val, i;
> +
> +	result = 0;

Init in the declaration

What unit is the value returned ?

> +	/*  Read the ADC value 8 times with an interval of 20 microsecs */

Why do you have to do that ? + comment format

/*
 *
 */


> +	for (i = 0; i < TS_CODE_CAP_TIMES ; i++) {
> +		result += rzg2l_thermal_read(priv, TSU_SAD) & CTEMP_MASK;
> +		usleep_range(20, 30);
> +	}
> +
> +	/* Calculate the average value */

With a proper comment in the loop, no need to add this one

> +	ts_code_ave = result / TS_CODE_CAP_TIMES;

> +	/* Curvature correction */

What is it? + comment format

> +	dsensor = TS_CODE_AVE_SCALE(ts_code_ave) /
> +		(TS_CODE_AVE_SCALE(1) + (ts_code_ave * 13));
> +

No litteral, s/13/a_macro/

> +	/* Temperature calculation */
> +	val = ((dsensor - priv->calib1) * (MCELSIUS(165) /
> +		(priv->calib0 - priv->calib1))) - MCELSIUS(40);

Elaborate please + comment format

> +
> +	/* Round value to device granularity setting */

Comment format

> +	*temp = rzg2l_thermal_round(val);
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops = {
> +	.get_temp = rzg2l_thermal_get_temp,
> +};
> +
> +static int rzg2l_thermal_init(struct rzg2l_thermal_priv *priv)
> +{
> +	u32 reg_val;
> +
> +	rzg2l_thermal_write(priv, TSU_SM, TSU_SM_NORMAL_MODE);
> +	rzg2l_thermal_write(priv, TSU_ST, 0);
> +
> +	/* Before setting START bit, Wait for 60 µs */

Why + comment format. The comment should not describe what is doing the
code but *why*. It is obvious usleep(60) waits 60us

> +	usleep_range(60, 80);
> +
> +	reg_val = rzg2l_thermal_read(priv, TSU_ST);
> +	reg_val |= TSU_ST_START;
> +	rzg2l_thermal_write(priv, TSU_ST, reg_val);
> +
> +	return readl_poll_timeout(priv->base + TSU_SS, reg_val,
> +				  reg_val == TSU_SS_CONV_RUNNING, 50,
> +				  RZG2L_TSU_SS_TIMEOUT_US);
> +}
> +
> +static void rzg2l_thermal_reset_assert_pm_disable_put(struct platform_device *pdev)
> +{
> +	struct rzg2l_thermal_priv *priv = dev_get_drvdata(&pdev->dev);
> +
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	reset_control_assert(priv->rstc);
> +}
> +
> +static int rzg2l_thermal_remove(struct platform_device *pdev)
> +{
> +	struct rzg2l_thermal_priv *priv = dev_get_drvdata(&pdev->dev);
> +
> +	thermal_remove_hwmon_sysfs(priv->zone);
> +	rzg2l_thermal_reset_assert_pm_disable_put(pdev);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_thermal_probe(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *zone;
> +	struct rzg2l_thermal_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->dev = dev;
> +	priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(priv->rstc))
> +		return dev_err_probe(dev, PTR_ERR(priv->rstc),
> +				     "failed to get cpg reset");
> +
> +	reset_control_deassert(priv->rstc);
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
> +	priv->calib0 = rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0));
> +	if (!priv->calib0)
> +		priv->calib0 = SW_CALIB0_VAL;
> +
> +	priv->calib1 = rzg2l_thermal_read(priv, OTPTSUTRIM_REG(1));
> +	if (!priv->calib1)
> +		priv->calib1 = SW_CALIB1_VAL;
> +
> +	platform_set_drvdata(pdev, priv);
> +	ret = rzg2l_thermal_init(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to start TSU");
> +		goto err;
> +	}
> +
> +	zone = devm_thermal_zone_of_sensor_register(dev, 0, priv,
> +						    &rzg2l_tz_of_ops);
> +	if (IS_ERR(zone)) {
> +		dev_err(dev, "Can't register thermal zone");
> +		ret = PTR_ERR(zone);

		dev_err(dev, "Can't register thermal zone: %d", ret);

> +		goto err;
> +	}
> +
> +	priv->zone = zone;
> +	priv->zone->tzp->no_hwmon = false;
> +	ret = thermal_add_hwmon_sysfs(priv->zone);
> +	if (ret)
> +		goto err;
> +
> +	dev_info(dev, "TSU probed with %s caliberation values",
> +		 rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0)) ?  "hw" : "sw");

	s/dev_info/dev_debug/

> +	return 0;
> +
> +err:
> +	rzg2l_thermal_reset_assert_pm_disable_put(pdev);
> +	return ret;
> +}
> +
> +static const struct of_device_id rzg2l_thermal_dt_ids[] = {
> +	{ .compatible = "renesas,rzg2l-tsu", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_thermal_dt_ids);
> +
> +static struct platform_driver rzg2l_thermal_driver = {
> +	.driver = {
> +		.name = "rzg2l_thermal",
> +		.of_match_table = rzg2l_thermal_dt_ids,
> +	},
> +	.probe = rzg2l_thermal_probe,
> +	.remove = rzg2l_thermal_remove,
> +};
> +module_platform_driver(rzg2l_thermal_driver);
> +
> +MODULE_DESCRIPTION("Renesas RZ/G2L TSU Thermal Sensor Driver");
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_LICENSE("GPL v2");
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
