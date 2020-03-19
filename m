Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F7118BF52
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 19:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSSZJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 14:25:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41117 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSSZI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 14:25:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so4361360wrc.8
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TQw1PGKPTMJ0Q+G+rToKEsu033L1SxRIQ9vKoZ/eDhs=;
        b=A+WkHmfuVZsFxCjHcaDc9Y7G1koy/78ePcbzpo8H4EM8G+UO0W8GrGqJS3hAlyRB2Y
         jSCLuzuc+wTQrNfjWriUn3KYMN8thh+BzIsWmkTyYd/mi7r+DXdpTfQZcm6ulczysm0k
         jsiAnwvD5XqBxVbpJ7a/BGIr9pthtyNciZ93RVCvBls3yYEajYgMENBLoEtVEQZq8cLU
         x2r2yy06cmkMEHeAw+mOrwgzIXs4bUU8aOnM4aOZnrOCgAbvZrAXMX9BarGcuH4q0wOy
         7FuGCPi+jQzgXIlxT83SOw3PV5GHNIQ6VWhbr2Xzvyk2WVP3WA0oT4f4qavgAeVZTPMP
         ElTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TQw1PGKPTMJ0Q+G+rToKEsu033L1SxRIQ9vKoZ/eDhs=;
        b=QoYZ6FyIHU0EtVqzE06WZnLakLGItya4pm2na6Xmxf5CNHGLU83SwqL2Bo+V+niNZd
         /8qC3XVqr6xYO1ALYj4aM8L/oYayXK3Fggtv5OR2hDsWZ8RbJotf9XtilHU57mrjnktF
         cEVjIUryhituEyIPAsPHZgNyNUFzrpixVcaIzxB2MYafJdH3PWZahgF/sw1jmFQfgrqV
         +c9w4iGMCJ0YamLTh9B0lhWq/dYdLizPLOMEf/sIZ9ejsf/L0NAAqSA3pBiM3OFJhgLn
         GgCAJS106TNt6cozGKeCMKBlCO+4bqjlnH9EzXKfZAdORpnALk1nolNxDTgu9oGuhOLi
         H96w==
X-Gm-Message-State: ANhLgQ0Guk7I2AwTCfKQNhGfQm6dFM96Lk3Fardf0OO9c3VdRRs+kJFt
        vhGcsW7vWNmadwi2j+f/hPDL/g==
X-Google-Smtp-Source: ADFU+vvuSBHAjDT5LCtY3qcBQjT2otLqXL+Z1gaggmOcIerNmThW/9KDIxTDfWqLw7BM09CnCrk8NQ==
X-Received: by 2002:a5d:630e:: with SMTP id i14mr4962841wru.260.1584642304007;
        Thu, 19 Mar 2020 11:25:04 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6dd6:dc1a:136d:210e? ([2a01:e34:ed2f:f020:6dd6:dc1a:136d:210e])
        by smtp.googlemail.com with ESMTPSA id d15sm4498193wrp.37.2020.03.19.11.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 11:25:03 -0700 (PDT)
Subject: Re: [PATCH 2/3] thermal: imx8mm: Add i.MX8MP support
To:     Anson Huang <Anson.Huang@nxp.com>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1583681240-14782-1-git-send-email-Anson.Huang@nxp.com>
 <1583681240-14782-2-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9ca81c42-6086-eb17-3eda-9bc2dab1101e@linaro.org>
Date:   Thu, 19 Mar 2020 19:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583681240-14782-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2020 16:27, Anson Huang wrote:
> i.MX8MP shares same TMU with i.MX8MM, the only difference is i.MX8MP
> has two thermal sensors while i.MX8MM ONLY has one, add multiple sensors
> support for i.MX8MM TMU driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/imx8mm_thermal.c | 108 +++++++++++++++++++++++++++++++++------
>  1 file changed, 93 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index d597ceb..8a87ed0 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -10,34 +10,75 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/thermal.h>
>  
>  #include "thermal_core.h"
>  
>  #define TER			0x0	/* TMU enable */
> +#define TPS			0x4
>  #define TRITSR			0x20	/* TMU immediate temp */
>  
>  #define TER_EN			BIT(31)
>  #define TRITSR_VAL_MASK		0xff
>  
> -#define TEMP_LOW_LIMIT		10
> +#define PROBE_SEL_ALL		GENMASK(31, 30)
>  
> -struct imx8mm_tmu {
> +#define PROBE0_STATUS_OFFSET	30
> +#define PROBE0_VAL_OFFSET	16
> +#define SIGN_BIT		BIT(7)
> +#define TEMP_VAL_MASK		GENMASK(6, 0)
> +
> +#define VER1_TEMP_LOW_LIMIT	10
> +#define VER2_TEMP_LOW_LIMIT	-40
> +#define VER2_TEMP_HIGH_LIMIT	125
> +
> +#define TMU_VER1		0x1
> +#define TMU_VER2		0x2
> +
> +struct thermal_soc_data {
> +	u32 num_sensors;
> +	u32 version;
> +};
> +
> +struct tmu_sensor {
> +	struct imx8mm_tmu *priv;
> +	u32 hw_id;
>  	struct thermal_zone_device *tzd;
> +};
> +
> +struct imx8mm_tmu {
>  	void __iomem *base;
>  	struct clk *clk;
> +	const struct thermal_soc_data *socdata;
> +	struct tmu_sensor sensors[0];
>  };
>  
>  static int tmu_get_temp(void *data, int *temp)
>  {
> -	struct imx8mm_tmu *tmu = data;
> +	struct tmu_sensor *sensor = data;
> +	struct imx8mm_tmu *tmu = sensor->priv;
> +	bool ready;
>  	u32 val;
>  
> -	val = readl_relaxed(tmu->base + TRITSR) & TRITSR_VAL_MASK;
> -	if (val < TEMP_LOW_LIMIT)
> -		return -EAGAIN;
> +	if (tmu->socdata->version == TMU_VER1) {

Don't do this here, implement a callback to read the temp, store it in
the socdata and call it directly from here.

So you end up with something simple like:

	*temp = tmu->socdata->get_temp(...);

> +		val = readl_relaxed(tmu->base + TRITSR) & TRITSR_VAL_MASK;
> +		if (val < VER1_TEMP_LOW_LIMIT)
> +			return -EAGAIN;> +	} else {
> +		val = readl_relaxed(tmu->base + TRITSR);
> +		ready = val & (1 << (sensor->hw_id + PROBE0_STATUS_OFFSET));

	test_bit()?

> +		val = (val >> (sensor->hw_id * PROBE0_VAL_OFFSET))
> +		      & TRITSR_VAL_MASK;
> +		if (val & SIGN_BIT) /* negative */
> +			val = (~(val & TEMP_VAL_MASK) + 1);

Please have a look at the different bitops available to simplify this
decoding.

> +		*temp = val;
> +		if (!ready || *temp < VER2_TEMP_LOW_LIMIT ||
> +		    *temp > VER2_TEMP_HIGH_LIMIT)
> +			return -EAGAIN;
> +	}
>  
>  	*temp = val * 1000;
>  
> @@ -50,14 +91,21 @@ static struct thermal_zone_of_device_ops tmu_tz_ops = {
>  
>  static int imx8mm_tmu_probe(struct platform_device *pdev)
>  {
> +	const struct thermal_soc_data *data;
>  	struct imx8mm_tmu *tmu;
>  	u32 val;
>  	int ret;
> +	int i;
> +
> +	data = of_device_get_match_data(&pdev->dev);
>  
> -	tmu = devm_kzalloc(&pdev->dev, sizeof(struct imx8mm_tmu), GFP_KERNEL);
> +	tmu = devm_kzalloc(&pdev->dev, struct_size(tmu, sensors,
> +			   data->num_sensors), GFP_KERNEL);
>  	if (!tmu)
>  		return -ENOMEM;
>  
> +	tmu->socdata = data;
> +
>  	tmu->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(tmu->base))
>  		return PTR_ERR(tmu->base);
> @@ -77,16 +125,35 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	tmu->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
> -							tmu, &tmu_tz_ops);
> -	if (IS_ERR(tmu->tzd)) {
> -		dev_err(&pdev->dev,
> -			"failed to register thermal zone sensor: %d\n", ret);
> -		return PTR_ERR(tmu->tzd);
> +	/* disable the monitor during initialization */
> +	val = readl_relaxed(tmu->base + TER);
> +	val &= ~TER_EN;
> +	writel_relaxed(val, tmu->base + TER);

Could you wrap those calls inside a small helper function with a self
described name?

> +
> +	for (i = 0; i < data->num_sensors; i++) {
> +		tmu->sensors[i].priv = tmu;
> +		tmu->sensors[i].tzd =
> +			devm_thermal_zone_of_sensor_register(&pdev->dev, i,
> +							     &tmu->sensors[i],
> +							     &tmu_tz_ops);
> +		if (IS_ERR(tmu->sensors[i].tzd)) {
> +			dev_err(&pdev->dev,
> +				"failed to register thermal zone sensor[%d]: %d\n",
> +				i, ret);
> +			return PTR_ERR(tmu->sensors[i].tzd);
> +		}
> +		tmu->sensors[i].hw_id = i;

May be you can store the offset directly, so it is not computed every
time the temperature is read?

>  	}
>  
>  	platform_set_drvdata(pdev, tmu);
>  
> +	/* enable all the probes for V2 TMU */
> +	if (tmu->socdata->version == TMU_VER2) {
> +		val = readl_relaxed(tmu->base + TPS);
> +		val |= PROBE_SEL_ALL;
> +		writel_relaxed(val, tmu->base + TPS);
> +	}

Same comment as before about putting these in a helper

>  	/* enable the monitor */
>  	val = readl_relaxed(tmu->base + TER);
>  	val |= TER_EN;
> @@ -111,8 +178,19 @@ static int imx8mm_tmu_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static struct thermal_soc_data imx8mm_tmu_data = {
> +	.num_sensors = 1,
> +	.version = TMU_VER1,
> +};
> +
> +static struct thermal_soc_data imx8mp_tmu_data = {
> +	.num_sensors = 2,
> +	.version = TMU_VER2,
> +};
> +
>  static const struct of_device_id imx8mm_tmu_table[] = {
> -	{ .compatible = "fsl,imx8mm-tmu", },
> +	{ .compatible = "fsl,imx8mm-tmu", .data = &imx8mm_tmu_data, },
> +	{ .compatible = "fsl,imx8mp-tmu", .data = &imx8mp_tmu_data, },
>  	{ },
>  };
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

