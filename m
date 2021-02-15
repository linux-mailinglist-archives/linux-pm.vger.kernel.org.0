Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CF131C2F3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 21:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBOU0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 15:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhBOU0D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2021 15:26:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB2FC061788
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 12:25:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h67so5662412wmh.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 12:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jDZtnEWOf82ehEYa4p3dFHkPyYl0MUvWn4LAUrQcIyQ=;
        b=TXBbY9fwjA05K6LxSreuUsHBAGr3qqHUmmhq/w6txO+FUV3t9a+6jsR+SPvyczGU1w
         Rwxn+usXimzVEtlOdoCIy5RU9N0bwmGHp9sfdx4T97SRNK63xPPZbRE8wK4J88yBmE0d
         yT0BNVxRnE0O9F/QjLZsIwwZFzJflO9TVUSdJLLWMAVX3ICGcsOl6WohQKR/fCZMDqfk
         kWUdwHqqbSehSwPONMSpoOvCcknZ7Yjbrq9s8CUNpqaxFtYNVWBNrjq6vTrR2+MJslBu
         06rKPlX2BQgeRXfRTTw0bMEywXh1thd/KegRo5Kz8pIYOI6GRjgfXuxHd7bBSDvMXcBs
         4uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jDZtnEWOf82ehEYa4p3dFHkPyYl0MUvWn4LAUrQcIyQ=;
        b=ewat+9jP+UkN5cxI6ITKxI5HcHCkiJ1m2jKqbHxdPU3FEfR0lTx4GqXt+glwrufwgy
         5/LHfmr56JCni9GpQy6N8OFPDDvPIaEEXXqJyPb4goKZ09/x2GGQwnlLyWwxMnlgm/KV
         gpgNLIOtO2Hkx3Wi4GE5pgNALKCCaGt/PdRxBw+IOdH+dSImNuB5u10wBrvy1cPo1BCX
         gsf9voU6YsFVUUdY0Gsj2/QiNdD05xyVZI/098oOI6fj2sFjm12dUpoaCpsPKNjx/5z5
         H+2Rmp0QicgNUosHByfmZD4YHJC4pGnneiQedWv1Moo3kfchKkBsES0zKj2A5kLkalcL
         1cvg==
X-Gm-Message-State: AOAM5309nzaGtJvkvU73rWJYmmZnpLCr/BR7U8bXsLBju8lyoPkC+f+B
        nyf5IJ4hOb0LoaslTx72rDf7Hw==
X-Google-Smtp-Source: ABdhPJz9/WbE1uEWKoaEcjNs+ultQA6IqlcWbxOwm/+rUXxB4dupMetnCFtRYey8q2YLHMaaybyTaw==
X-Received: by 2002:a1c:6a02:: with SMTP id f2mr518688wmc.36.1613420720969;
        Mon, 15 Feb 2021 12:25:20 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1c0d:1b29:8630:3df5? ([2a01:e34:ed2f:f020:1c0d:1b29:8630:3df5])
        by smtp.googlemail.com with ESMTPSA id h15sm8800051wrh.13.2021.02.15.12.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 12:25:20 -0800 (PST)
Subject: Re: [PATCH v9 1/8] drivers: thermal: tsens: Add VER_0 tsens version
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210122145558.4982-1-ansuelsmth@gmail.com>
 <20210122145558.4982-2-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <84a44ce8-163a-5c31-ddd3-c4cf0247bc46@linaro.org>
Date:   Mon, 15 Feb 2021 21:25:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122145558.4982-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/01/2021 15:55, Ansuel Smith wrote:
> VER_0 is used to describe device based on tsens version before v0.1.
> These device are devices based on msm8960 for example apq8064 or
> ipq806x.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

At the first glance, this series sounds ok but there is no ack from the
maintainers of this driver so I'm uncomfortable picking these changes.

Bjorn ? Amit ?

> ---
>  drivers/thermal/qcom/tsens.c | 171 +++++++++++++++++++++++++++++------
>  drivers/thermal/qcom/tsens.h |   4 +-
>  2 files changed, 147 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index d8ce3a687b80..eaeaa1d69d92 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -12,6 +12,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
> @@ -515,6 +516,15 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>  			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
>  				hw_id, __func__, temp);
>  		}
> +
> +		if (tsens_version(priv) < VER_0_1) {
> +			/* Constraint: There is only 1 interrupt control register for all
> +			 * 11 temperature sensor. So monitoring more than 1 sensor based
> +			 * on interrupts will yield inconsistent result. To overcome this
> +			 * issue we will monitor only sensor 0 which is the master sensor.
> +			 */
> +			break;
> +		}
>  	}
>  
>  	return IRQ_HANDLED;
> @@ -530,6 +540,13 @@ static int tsens_set_trips(void *_sensor, int low, int high)
>  	int high_val, low_val, cl_high, cl_low;
>  	u32 hw_id = s->hw_id;
>  
> +	if (tsens_version(priv) < VER_0_1) {
> +		/* Pre v0.1 IP had a single register for each type of interrupt
> +		 * and thresholds
> +		 */
> +		hw_id = 0;
> +	}
> +
>  	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
>  		hw_id, __func__, low, high);
>  
> @@ -584,18 +601,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  	u32 valid;
>  	int ret;
>  
> -	ret = regmap_field_read(priv->rf[valid_idx], &valid);
> -	if (ret)
> -		return ret;
> -	while (!valid) {
> -		/* Valid bit is 0 for 6 AHB clock cycles.
> -		 * At 19.2MHz, 1 AHB clock is ~60ns.
> -		 * We should enter this loop very, very rarely.
> -		 */
> -		ndelay(400);
> +	/* VER_0 doesn't have VALID bit */
> +	if (tsens_version(priv) >= VER_0_1) {
>  		ret = regmap_field_read(priv->rf[valid_idx], &valid);
>  		if (ret)
>  			return ret;
> +		while (!valid) {
> +			/* Valid bit is 0 for 6 AHB clock cycles.
> +			 * At 19.2MHz, 1 AHB clock is ~60ns.
> +			 * We should enter this loop very, very rarely.
> +			 */
> +			ndelay(400);
> +			ret = regmap_field_read(priv->rf[valid_idx], &valid);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	/* Valid bit is set, OK to read the temperature */
> @@ -608,15 +628,29 @@ int get_temp_common(const struct tsens_sensor *s, int *temp)
>  {
>  	struct tsens_priv *priv = s->priv;
>  	int hw_id = s->hw_id;
> -	int last_temp = 0, ret;
> +	int last_temp = 0, ret, trdy;
> +	unsigned long timeout;
>  
> -	ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
> -	if (ret)
> -		return ret;
> +	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
> +	do {
> +		if (priv->rf[TRDY]) {
> +			ret = regmap_field_read(priv->rf[TRDY], &trdy);
> +			if (ret)
> +				return ret;
> +			if (!trdy)
> +				continue;
> +		}
> +
> +		ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
> +		if (ret)
> +			return ret;
>  
> -	*temp = code_to_degc(last_temp, s) * 1000;
> +		*temp = code_to_degc(last_temp, s) * 1000;
>  
> -	return 0;
> +		return 0;
> +	} while (time_before(jiffies, timeout));
> +
> +	return -ETIMEDOUT;
>  }
>  
>  #ifdef CONFIG_DEBUG_FS
> @@ -738,19 +772,31 @@ int __init init_common(struct tsens_priv *priv)
>  		priv->tm_offset = 0x1000;
>  	}
>  
> -	res = platform_get_resource(op, IORESOURCE_MEM, 0);
> -	tm_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(tm_base)) {
> -		ret = PTR_ERR(tm_base);
> -		goto err_put_device;
> +	if (tsens_version(priv) >= VER_0_1) {
> +		res = platform_get_resource(op, IORESOURCE_MEM, 0);
> +		tm_base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(tm_base)) {
> +			ret = PTR_ERR(tm_base);
> +			goto err_put_device;
> +		}
> +
> +		priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
> +	} else { /* VER_0 share the same gcc regs using a syscon */
> +		struct device *parent = priv->dev->parent;
> +
> +		if (parent)
> +			priv->tm_map = syscon_node_to_regmap(parent->of_node);
>  	}
>  
> -	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
> -	if (IS_ERR(priv->tm_map)) {
> +	if (IS_ERR_OR_NULL(priv->tm_map)) {
>  		ret = PTR_ERR(priv->tm_map);
>  		goto err_put_device;
>  	}
>  
> +	/* VER_0 have only tm_map */
> +	if (!priv->srot_map)
> +		priv->srot_map = priv->tm_map;
> +
>  	if (tsens_version(priv) > VER_0_1) {
>  		for (i = VER_MAJOR; i <= VER_STEP; i++) {
>  			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
> @@ -769,6 +815,10 @@ int __init init_common(struct tsens_priv *priv)
>  		ret = PTR_ERR(priv->rf[TSENS_EN]);
>  		goto err_put_device;
>  	}
> +	/* in VER_0 TSENS need to be explicitly enabled */
> +	if (tsens_version(priv) == VER_0)
> +		regmap_field_write(priv->rf[TSENS_EN], 1);
> +
>  	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>  	if (ret)
>  		goto err_put_device;
> @@ -791,6 +841,66 @@ int __init init_common(struct tsens_priv *priv)
>  		goto err_put_device;
>  	}
>  
> +	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
> +						     priv->fields[TSENS_EN]);
> +	if (IS_ERR(priv->rf[TSENS_EN])) {
> +		ret = PTR_ERR(priv->rf[TSENS_EN]);
> +		goto err_put_device;
> +	}
> +
> +	priv->rf[TSENS_SW_RST] = devm_regmap_field_alloc(
> +		dev, priv->tm_map, priv->fields[TSENS_EN]);
> +	if (IS_ERR(priv->rf[TSENS_EN])) {
> +		ret = PTR_ERR(priv->rf[TSENS_EN]);
> +		goto err_put_device;
> +	}
> +
> +	priv->rf[LOW_INT_CLEAR_0] = devm_regmap_field_alloc(
> +		dev, priv->tm_map, priv->fields[LOW_INT_CLEAR_0]);
> +	if (IS_ERR(priv->rf[LOW_INT_CLEAR_0])) {
> +		ret = PTR_ERR(priv->rf[LOW_INT_CLEAR_0]);
> +		goto err_put_device;
> +	}
> +
> +	priv->rf[UP_INT_CLEAR_0] = devm_regmap_field_alloc(
> +		dev, priv->tm_map, priv->fields[UP_INT_CLEAR_0]);
> +	if (IS_ERR(priv->rf[UP_INT_CLEAR_0])) {
> +		ret = PTR_ERR(priv->rf[UP_INT_CLEAR_0]);
> +		goto err_put_device;
> +	}
> +
> +	/* VER_0 require to set MIN and MAX THRESH
> +	 * These 2 regs are set using the:
> +	 * - CRIT_THRESH_0 for MAX THRESH hardcoded to 120°C
> +	 * - CRIT_THRESH_1 for MIN THRESH hardcoded to   0°C
> +	 */
> +	if (tsens_version(priv) < VER_0_1) {
> +		priv->rf[CRIT_THRESH_0] = devm_regmap_field_alloc(
> +			dev, priv->tm_map, priv->fields[CRIT_THRESH_0]);
> +		if (IS_ERR(priv->rf[CRIT_THRESH_0])) {
> +			ret = PTR_ERR(priv->rf[CRIT_THRESH_0]);
> +			goto err_put_device;
> +		}
> +		regmap_field_write(priv->rf[CRIT_THRESH_0],
> +				   tsens_mC_to_hw(priv->sensor, 120000));
> +
> +		priv->rf[CRIT_THRESH_1] = devm_regmap_field_alloc(
> +			dev, priv->tm_map, priv->fields[CRIT_THRESH_1]);
> +		if (IS_ERR(priv->rf[CRIT_THRESH_1])) {
> +			ret = PTR_ERR(priv->rf[CRIT_THRESH_1]);
> +			goto err_put_device;
> +		}
> +		regmap_field_write(priv->rf[CRIT_THRESH_1],
> +				   tsens_mC_to_hw(priv->sensor, 0));
> +	}
> +
> +	priv->rf[TRDY] =
> +		devm_regmap_field_alloc(dev, priv->tm_map, priv->fields[TRDY]);
> +	if (IS_ERR(priv->rf[TRDY])) {
> +		ret = PTR_ERR(priv->rf[TRDY]);
> +		goto err_put_device;
> +	}
> +
>  	/* This loop might need changes if enum regfield_ids is reordered */
>  	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
>  		for (i = 0; i < priv->feat->max_sensors; i++) {
> @@ -844,7 +954,11 @@ int __init init_common(struct tsens_priv *priv)
>  	}
>  
>  	spin_lock_init(&priv->ul_lock);
> -	tsens_enable_irq(priv);
> +
> +	/* VER_0 interrupt doesn't need to be enabled */
> +	if (tsens_version(priv) >= VER_0_1)
> +		tsens_enable_irq(priv);
> +
>  	tsens_debug_init(op);
>  
>  err_put_device:
> @@ -930,7 +1044,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>  			      irq_handler_t thread_fn)
>  {
>  	struct platform_device *pdev;
> -	int ret, irq;
> +	int ret, irq, irq_type = IRQF_ONESHOT;
>  
>  	pdev = of_find_device_by_node(priv->dev->of_node);
>  	if (!pdev)
> @@ -943,9 +1057,12 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>  		if (irq == -ENXIO)
>  			ret = 0;
>  	} else {
> -		ret = devm_request_threaded_irq(&pdev->dev, irq,
> -						NULL, thread_fn,
> -						IRQF_ONESHOT,
> +		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
> +		if (tsens_version(priv) == VER_0)
> +			irq_type = IRQF_TRIGGER_RISING;
> +
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, thread_fn,
> +						NULL, irq_type,
>  						dev_name(&pdev->dev), priv);
>  		if (ret)
>  			dev_err(&pdev->dev, "%s: failed to get irq\n",
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index f40b625f897e..8e6c1fd3ccf5 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -13,6 +13,7 @@
>  #define CAL_DEGC_PT2		120
>  #define SLOPE_FACTOR		1000
>  #define SLOPE_DEFAULT		3200
> +#define TIMEOUT_US		100
>  #define THRESHOLD_MAX_ADC_CODE	0x3ff
>  #define THRESHOLD_MIN_ADC_CODE	0x0
>  
> @@ -25,7 +26,8 @@ struct tsens_priv;
>  
>  /* IP version numbers in ascending order */
>  enum tsens_ver {
> -	VER_0_1 = 0,
> +	VER_0 = 0,
> +	VER_0_1,
>  	VER_1_X,
>  	VER_2_X,
>  };
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
