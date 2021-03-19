Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F3341DD2
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 14:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCSNLu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 09:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCSNLl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 09:11:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5BEC061760
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 06:11:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g24so6603198qts.6
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 06:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kaEkDG82vpeIsypRJLoIoxNiwNxHXA+4emZVBWzINmo=;
        b=IOsbENRNxp9LPp1nP6L+0/LWlab2OJig+oUlOKCsGQOwcuxwIFYqeSF3iSSU8cJer6
         sw7Vd5ch27eTG0ao+h+NleR1oXI5et59y0ZQs/AGnLu84m8sjS05B5o4wa0kmiD/jS53
         0IRvYYfH+QVIb/LoSIkp3nqhMOPOxCJi4KXeF4+jFhUwBkehGg7I0yEdDSaIkVY1iCpy
         SMRQJGqmfm6Lu3AvOmhPc9PaTYBvHcFYmub5uK1FTcGZ11bAQklSx3hsGEgKOeWjpKdp
         J0WiGo1wbkFAuCk4zMgrR5UTEIRyPKrttR0PEVoKd033ld+LcIpxDnbAvnEenSWp8zHQ
         4Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kaEkDG82vpeIsypRJLoIoxNiwNxHXA+4emZVBWzINmo=;
        b=QwHKRJxSfZfYvXsOFIW5By5wZKeDjoZeDo/Sn+X1Bsjv7ReYLwHI4FOGkPAdvNU+lT
         cReX1aYQ6FxfqdtZr8sRjt5LmFZHdEwaDfLL6EE3F7DkGTi6TcbJV4SKwEC5aBe0DIPJ
         ptOJhOis1gZsC8NUevw8qwVQVYWgSzMal83AIUuQ7so3syqoNI8qGM2nOLMdXqPmiMSM
         NYEoMUdv6Mk2knKrp8jD2YOkv4fQEbIRANY206pbL/nI9uXeSbV7rRh+EVM7EREm1E/m
         Tqmce2w4sgtbKfGFqU8lMUhtrLiCTJAxv0c0EdMufHlMKYL7QFuIA9svmD+nO8yk50Kt
         QhGw==
X-Gm-Message-State: AOAM532+aOE5jlo7cD0syR0nYLyX50YIiGT41btFML+/BppqB+kB66g+
        FqoQLnhBlBR+US2LKc1l5eJTug==
X-Google-Smtp-Source: ABdhPJxTsbHZiuW5+IjwxkyBm6OQ8iudTWWOWG5ygNGN46UAEnxQ9eqd21rFR37ttbcQcXsaY9lHaQ==
X-Received: by 2002:ac8:5747:: with SMTP id 7mr8206851qtx.274.1616159499850;
        Fri, 19 Mar 2021 06:11:39 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id 1sm3498564qtw.3.2021.03.19.06.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 06:11:39 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v11 1/9] drivers: thermal: tsens: Add VER_0 tsens version
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
 <20210319005228.1250-2-ansuelsmth@gmail.com>
Message-ID: <7c38ea02-d957-6f63-ccce-1c35dd5d04de@linaro.org>
Date:   Fri, 19 Mar 2021 09:11:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319005228.1250-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/18/21 8:52 PM, Ansuel Smith wrote:
> VER_0 is used to describe device based on tsens version before v0.1.
> These device are devices based on msm8960 for example apq8064 or
> ipq806x.

Hi Ansuel,

There are still checkpatch check warnings in this patch. Please run 
checkpatch.pl --strict and fix them. Once that is done, you can add

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

Warm Regards
Thara

> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   drivers/thermal/qcom/tsens.c | 141 ++++++++++++++++++++++++++++-------
>   drivers/thermal/qcom/tsens.h |   4 +-
>   2 files changed, 116 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index d8ce3a687b80..277d9b17e949 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -12,6 +12,7 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_platform.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm.h>
>   #include <linux/regmap.h>
> @@ -515,6 +516,15 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>   			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
>   				hw_id, __func__, temp);
>   		}
> +
> +		if (tsens_version(priv) < VER_0_1) {
> +			/* Constraint: There is only 1 interrupt control register for all
> +			 * 11 temperature sensor. So monitoring more than 1 sensor based
> +			 * on interrupts will yield inconsistent result. To overcome this
> +			 * issue we will monitor only sensor 0 which is the master sensor.
> +			 */
> +			break;
> +		}
>   	}
>   
>   	return IRQ_HANDLED;
> @@ -530,6 +540,13 @@ static int tsens_set_trips(void *_sensor, int low, int high)
>   	int high_val, low_val, cl_high, cl_low;
>   	u32 hw_id = s->hw_id;
>   
> +	if (tsens_version(priv) < VER_0_1) {
> +		/* Pre v0.1 IP had a single register for each type of interrupt
> +		 * and thresholds
> +		 */
> +		hw_id = 0;
> +	}
> +
>   	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
>   		hw_id, __func__, low, high);
>   
> @@ -584,18 +601,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>   	u32 valid;
>   	int ret;
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
>   		ret = regmap_field_read(priv->rf[valid_idx], &valid);
>   		if (ret)
>   			return ret;
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
>   	}
>   
>   	/* Valid bit is set, OK to read the temperature */
> @@ -608,15 +628,29 @@ int get_temp_common(const struct tsens_sensor *s, int *temp)
>   {
>   	struct tsens_priv *priv = s->priv;
>   	int hw_id = s->hw_id;
> -	int last_temp = 0, ret;
> +	int last_temp = 0, ret, trdy;
> +	unsigned long timeout;
>   
> -	ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
> -	if (ret)
> -		return ret;
> +	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
> +	do {
> +		if (tsens_version(priv) == VER_0) {
> +			ret = regmap_field_read(priv->rf[TRDY], &trdy);
> +			if (ret)
> +				return ret;
> +			if (!trdy)
> +				continue;
> +		}
>   
> -	*temp = code_to_degc(last_temp, s) * 1000;
> +		ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
> +		if (ret)
> +			return ret;
>   
> -	return 0;
> +		*temp = code_to_degc(last_temp, s) * 1000;
> +
> +		return 0;
> +	} while (time_before(jiffies, timeout));
> +
> +	return -ETIMEDOUT;
>   }
>   
>   #ifdef CONFIG_DEBUG_FS
> @@ -738,19 +772,31 @@ int __init init_common(struct tsens_priv *priv)
>   		priv->tm_offset = 0x1000;
>   	}
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
>   	}
>   
> -	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
> -	if (IS_ERR(priv->tm_map)) {
> +	if (IS_ERR_OR_NULL(priv->tm_map)) {
>   		ret = PTR_ERR(priv->tm_map);
>   		goto err_put_device;
>   	}
>   
> +	/* VER_0 have only tm_map */
> +	if (!priv->srot_map)
> +		priv->srot_map = priv->tm_map;
> +
>   	if (tsens_version(priv) > VER_0_1) {
>   		for (i = VER_MAJOR; i <= VER_STEP; i++) {
>   			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
> @@ -769,6 +815,10 @@ int __init init_common(struct tsens_priv *priv)
>   		ret = PTR_ERR(priv->rf[TSENS_EN]);
>   		goto err_put_device;
>   	}
> +	/* in VER_0 TSENS need to be explicitly enabled */
> +	if (tsens_version(priv) == VER_0)
> +		regmap_field_write(priv->rf[TSENS_EN], 1);
> +
>   	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>   	if (ret)
>   		goto err_put_device;
> @@ -791,6 +841,20 @@ int __init init_common(struct tsens_priv *priv)
>   		goto err_put_device;
>   	}
>   
> +	priv->rf[TSENS_SW_RST] = devm_regmap_field_alloc(
> +		dev, priv->srot_map, priv->fields[TSENS_SW_RST]);
> +	if (IS_ERR(priv->rf[TSENS_SW_RST])) {
> +		ret = PTR_ERR(priv->rf[TSENS_SW_RST]);
> +		goto err_put_device;
> +	}
> +
> +	priv->rf[TRDY] =
> +		devm_regmap_field_alloc(dev, priv->tm_map, priv->fields[TRDY]);
> +	if (IS_ERR(priv->rf[TRDY])) {
> +		ret = PTR_ERR(priv->rf[TRDY]);
> +		goto err_put_device;
> +	}
> +
>   	/* This loop might need changes if enum regfield_ids is reordered */
>   	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
>   		for (i = 0; i < priv->feat->max_sensors; i++) {
> @@ -806,7 +870,7 @@ int __init init_common(struct tsens_priv *priv)
>   		}
>   	}
>   
> -	if (priv->feat->crit_int) {
> +	if (priv->feat->crit_int || tsens_version(priv) < VER_0_1) {
>   		/* Loop might need changes if enum regfield_ids is reordered */
>   		for (j = CRITICAL_STATUS_0; j <= CRIT_THRESH_15; j += 16) {
>   			for (i = 0; i < priv->feat->max_sensors; i++) {
> @@ -844,7 +908,11 @@ int __init init_common(struct tsens_priv *priv)
>   	}
>   
>   	spin_lock_init(&priv->ul_lock);
> -	tsens_enable_irq(priv);
> +
> +	/* VER_0 interrupt doesn't need to be enabled */
> +	if (tsens_version(priv) >= VER_0_1)
> +		tsens_enable_irq(priv);
> +
>   	tsens_debug_init(op);
>   
>   err_put_device:
> @@ -943,10 +1011,14 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>   		if (irq == -ENXIO)
>   			ret = 0;
>   	} else {
> -		ret = devm_request_threaded_irq(&pdev->dev, irq,
> -						NULL, thread_fn,
> -						IRQF_ONESHOT,
> -						dev_name(&pdev->dev), priv);
> +		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
> +		ret = devm_request_threaded_irq(
> +			&pdev->dev, irq,
> +			tsens_version(priv) == VER_0 ? thread_fn : NULL,
> +			tsens_version(priv) == VER_0 ? NULL : thread_fn,
> +			tsens_version(priv) == VER_0 ? IRQF_TRIGGER_RISING :
> +							     IRQF_ONESHOT,
> +			dev_name(&pdev->dev), priv);
>   		if (ret)
>   			dev_err(&pdev->dev, "%s: failed to get irq\n",
>   				__func__);
> @@ -975,6 +1047,19 @@ static int tsens_register(struct tsens_priv *priv)
>   			priv->ops->enable(priv, i);
>   	}
>   
> +	/* VER_0 require to set MIN and MAX THRESH
> +	 * These 2 regs are set using the:
> +	 * - CRIT_THRESH_0 for MAX THRESH hardcoded to 120°C
> +	 * - CRIT_THRESH_1 for MIN THRESH hardcoded to   0°C
> +	 */
> +	if (tsens_version(priv) < VER_0_1) {
> +		regmap_field_write(priv->rf[CRIT_THRESH_0],
> +				   tsens_mC_to_hw(priv->sensor, 120000));
> +
> +		regmap_field_write(priv->rf[CRIT_THRESH_1],
> +				   tsens_mC_to_hw(priv->sensor, 0));
> +	}
> +
>   	ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
>   	if (ret < 0)
>   		return ret;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index f40b625f897e..8e6c1fd3ccf5 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -13,6 +13,7 @@
>   #define CAL_DEGC_PT2		120
>   #define SLOPE_FACTOR		1000
>   #define SLOPE_DEFAULT		3200
> +#define TIMEOUT_US		100
>   #define THRESHOLD_MAX_ADC_CODE	0x3ff
>   #define THRESHOLD_MIN_ADC_CODE	0x0
>   
> @@ -25,7 +26,8 @@ struct tsens_priv;
>   
>   /* IP version numbers in ascending order */
>   enum tsens_ver {
> -	VER_0_1 = 0,
> +	VER_0 = 0,
> +	VER_0_1,
>   	VER_1_X,
>   	VER_2_X,
>   };
>
