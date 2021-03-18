Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5608D340F9B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 22:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhCRVPi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 17:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhCRVPK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 17:15:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F3C06175F
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 14:15:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s2so5225005qtx.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=thtI6D5yvLQ8I+ZEZPewpU2UeG4JeNUahdvcK2n34kc=;
        b=Vctd/VJFOvSx90u1XC5z0hzSnDhF2EgyP2vMD0Kx/ybecq7kOpW39NaHT/O3QSILvq
         04fYCFIQX+gM+pP+UvwFYjsp/JsYC/PSrHVM3P9v/hmQsYlhad78+lAw+EdcBxU2dGcT
         JafEuw73AwskpvYEhNfUoRIqHlRvAGkUsHnSsz53p1p+KXTGiK4kdPe/oeeb1zu/IZ60
         61PkfFwXZTk8dkeR3rvhdae1+qKGZ3ysCiG/UhZTq54bVhSgpgaX8UDXOpsOHlWkE3n3
         plC89LVAm2RshOiIKuD8ualGH5nlyolrSiFNjmpuaTsFUDNB2xGT0+YYgwUR0TbNabeV
         1PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=thtI6D5yvLQ8I+ZEZPewpU2UeG4JeNUahdvcK2n34kc=;
        b=OoY5BnZEznrroYLDCUISJL30C93o8WyYiHiqiH7lQ7J1Mayq30Rpppk2mQnZjR3WAF
         I6ucrM13K8pDx37DkFSW0diVxTqvSWBxZt79hYgN4pOFqpmhPiWmpzCfuv+nzazP1pPa
         ZehejQuZ8AvWK0lIge0CIwYT7G47TD5Z5q8MIPzvg1RK0MxY5SM28vI0wedMhCHy9yjR
         OSIc5OeugaPKeeWZ67cNuZRKxZZY1215xCAMi6UGBEmryIoCqEJtF7vJ+hm8I7EoroL1
         qMOg3yuSaUfzbOd5+Ckp8Kj6bc5fwYo5S9FtPOWpvhrDRzgOCsgyTAgTR2NyKyaTTSTR
         qQdA==
X-Gm-Message-State: AOAM533rpwHIRfgUGmpSHdCKPiPBz5tusBZYsXxrM1O5d6qVnKYlWTna
        GcaH/5sh6smhJb3pr7P9owHICw==
X-Google-Smtp-Source: ABdhPJwfXGKIo+tl8E9EXsaHg7MmFGuE3MtjbAdHaDLdrDL7h3KJsFUbaud2jfCqV77838elS8U12Q==
X-Received: by 2002:ac8:590e:: with SMTP id 14mr5711740qty.51.1616102109102;
        Thu, 18 Mar 2021 14:15:09 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id v2sm2732410qkp.119.2021.03.18.14.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 14:15:08 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v10 1/8] drivers: thermal: tsens: Add VER_0 tsens version
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
 <20210217194011.22649-2-ansuelsmth@gmail.com>
Message-ID: <642632a5-7124-e728-c2e5-691185816420@linaro.org>
Date:   Thu, 18 Mar 2021 17:15:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217194011.22649-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ansuel!

Apologies for delay in the review..

This particular patch throws checkpatch check warnings. Please
run checkpatch.pl --strict and fix them. Rest of the comments below

On 2/17/21 2:40 PM, Ansuel Smith wrote:
> VER_0 is used to describe device based on tsens version before v0.1.
> These device are devices based on msm8960 for example apq8064 or
> ipq806x.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   drivers/thermal/qcom/tsens.c | 175 +++++++++++++++++++++++++++++------
>   drivers/thermal/qcom/tsens.h |   4 +-
>   2 files changed, 151 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index d8ce3a687b80..f9126909892b 100644
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
> +		if (priv->rf[TRDY]) {
> +			ret = regmap_field_read(priv->rf[TRDY], &trdy);
> +			if (ret)
> +				return ret;
> +			if (!trdy)
> +				continue;
> +		}

Did you test this on v0.1 sensor and ensure that the trdy handshake 
works there as well? I don't have a platform to test this. But the safer 
option here will be to do the hand shake only for v0.

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
> @@ -791,6 +841,57 @@ int __init init_common(struct tsens_priv *priv)
>   		goto err_put_device;
>   	}
>   
> +	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
> +						     priv->fields[TSENS_EN]);

Why are you reallocating TSENS_EN here? It is already done above. Also 
the base map is wrong. It should be priv->srot_map

> +	if (IS_ERR(priv->rf[TSENS_EN])) {
> +		ret = PTR_ERR(priv->rf[TSENS_EN]);
> +		goto err_put_device;
> +	}
> +
> +	priv->rf[TSENS_SW_RST] = devm_regmap_field_alloc(
> +		dev, priv->tm_map, priv->fields[TSENS_EN]);

/s/priv->tm_map/priv->srot_map.


> +	if (IS_ERR(priv->rf[TSENS_EN])) {

check for TSENS_SW_RST and not TSENS_EN..

> +		ret = PTR_ERR(priv->rf[TSENS_EN]);

check for TSENS_SW_RST and not TSENS_EN

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

Does not the code in for loop for (j = LAST_TEMP_0; j <= UP_THRESH_15; j 
+= 16) { do this for you ? If not, you should move it inside the if 
condition below. And in that case you need not loop enter the for (j = 
LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {.

> +
> +	if (tsens_version(priv) < VER_0_1) {
> +		priv->rf[CRIT_THRESH_0] = devm_regmap_field_alloc(
> +			dev, priv->tm_map, priv->fields[CRIT_THRESH_0]);
> +		if (IS_ERR(priv->rf[CRIT_THRESH_0])) {
> +			ret = PTR_ERR(priv->rf[CRIT_THRESH_0]);
> +			goto err_put_device;
> +		}
> +
> +		priv->rf[CRIT_THRESH_1] = devm_regmap_field_alloc(
> +			dev, priv->tm_map, priv->fields[CRIT_THRESH_1]);
> +		if (IS_ERR(priv->rf[CRIT_THRESH_1])) {
> +			ret = PTR_ERR(priv->rf[CRIT_THRESH_1]);
> +			goto err_put_device;
> +		}
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
> @@ -844,7 +945,11 @@ int __init init_common(struct tsens_priv *priv)
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
> @@ -930,7 +1035,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>   			      irq_handler_t thread_fn)
>   {
>   	struct platform_device *pdev;
> -	int ret, irq;
> +	int ret, irq, irq_type = IRQF_ONESHOT;
>   
>   	pdev = of_find_device_by_node(priv->dev->of_node);
>   	if (!pdev)
> @@ -943,9 +1048,12 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>   		if (irq == -ENXIO)
>   			ret = 0;
>   	} else {
> -		ret = devm_request_threaded_irq(&pdev->dev, irq,
> -						NULL, thread_fn,
> -						IRQF_ONESHOT,
> +		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
> +		if (tsens_version(priv) == VER_0)
> +			irq_type = IRQF_TRIGGER_RISING;
> +
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, thread_fn,
> +						NULL, irq_type,
>   						dev_name(&pdev->dev), priv);

You have changed the interrupt handling from  threaded context to 
interrupt context. I cannot see any reason to do this.

>   		if (ret)
>   			dev_err(&pdev->dev, "%s: failed to get irq\n",
> @@ -975,6 +1083,19 @@ static int tsens_register(struct tsens_priv *priv)
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

-- 
Warm Regards
Thara
