Return-Path: <linux-pm+bounces-6817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A68AD127
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7351C221F6
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D515351B;
	Mon, 22 Apr 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6c3ebGq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12257150984
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800767; cv=none; b=mJZrDzgZ4xxKKuP3ZKQPOWm6nA6lAWfhQhbV0AAyIwYGzjBZ/OSQzH+aebPwEGbWsABUfaIAicUe4VqkxvDlfubhHOW3viJpagkKaz4HNeZA0cC0u5kuIGPenLKYlq75kHwzj21H9xF2ThQP8XhmJShR21m8VRlprE8J85fg5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800767; c=relaxed/simple;
	bh=Oqe94VpkGzk9aI9bTFO9lAx9HZdL+gdczyCkhmSweuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+JzJ8AkBKQCsGeb3HGzkaT1JZigiwa8LS4gQXLypgvIPD5/dshlpC+RniTI4TZ3k4IBKfFF2ufiQNIH8+rDzVMbjTkW5/R0RAOve+clOcZAJ4TMBiT+TpU1p5hmh+WwWPBWiVu3vStIDQnCXk8YvWKZy/5VY5jDjY8hmqiiG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u6c3ebGq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41aa2f6ff2dso724165e9.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713800763; x=1714405563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRhycPgQpwIvlf2hP1EnQY6sOD615yvq6bGxEhUzAgA=;
        b=u6c3ebGqOgtsxK6rj28g9DreA/No7m0C+hUwWaL2Y9cGlHyrOxqeCEy37CfpESNIcr
         MG0Kg3XzLds+oHnF6rtmDabs7Jfa8X6TqO276QFoX2WsYAd/Yl1rvNtPL+fs/0DJBRlM
         cnv7u8aUM8I1pVZ+g46Ho4Ktsc5NAVWAadnUodjUgcqF46JcysMdHV0DG1ctbfqvEdnZ
         R5LQFbO2P6tPSa467NtR3gFI+EJ7NlEQDC82P+CM2KmWyZP4rH89p8iku+Ba5QhaY7rf
         gahQRZsS18l/gc9iM/kntdrZ+5ngI7kb46Wk11IZwS3jIMXQ8eKu6Uhv9idQl8heNylc
         ZMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800763; x=1714405563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRhycPgQpwIvlf2hP1EnQY6sOD615yvq6bGxEhUzAgA=;
        b=LYRD2t2Ge9vgFxqk/hMD6oFvSA0DjismtCuR7bZCEsK4qsHeXaqEIrmwEYxaqINDzZ
         zG/0GwXKYPVn6fOQw8Q+KDTZvBrZtvWFJTRX0jkD1LQVglZwm0oVfxiXQp6kJwzW1t7p
         GLeCyLgwN+8jkS1Aq5d+pit+v963nO8H8078YtsN/P6f1OJ+o7fpSwAPz5k1nrq8/HQW
         j12MQqZHRd422ohzbILcMvjTRHIIV0wHK22gV4ANSgbNlJ51nriuS6mHEUPuO7cJoAoP
         f5y6LloNRr7PLDfIQGkRqhVCbUzqryzSJPy9Q1fg7OkI3TyHnkRqIun5sQ6gTJiJ/IOm
         Oxdg==
X-Forwarded-Encrypted: i=1; AJvYcCXsfjtejhSJHbXdEaj+Uc1ia+hx+yixq+b2lpihzBc4VbL0tW+4xZihBW7daUmECTHJ7+HM9Pj2V5tlccXaBYmnxhtmOwUalwo=
X-Gm-Message-State: AOJu0Yxqfdx+OYCJXSdKGXOLDs+X2LGiwtHRGWctJKdkSg7qjV9GTgw6
	jtFavrJvNaSJ9YMqyEncO82cy4MqeOGfWllnl/k7wM9h/nWXlDR5CLsgcETp/nqV3ZTSDnZiKPv
	w
X-Google-Smtp-Source: AGHT+IHCeMPLS9nliM1CTYfOFO1ec5EePI1GqVcgmrHjQqsOMOPBPCULd64+GUugUnsLHY5e6ecbqg==
X-Received: by 2002:a05:600c:a004:b0:417:c329:b52b with SMTP id jg4-20020a05600ca00400b00417c329b52bmr6971360wmb.39.1713800763311;
        Mon, 22 Apr 2024 08:46:03 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n8-20020a05600c500800b0041a97870d6fsm910461wmr.2.2024.04.22.08.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 08:46:02 -0700 (PDT)
Message-ID: <d8c1d7a4-60d0-4940-b604-ee62591fa3e8@linaro.org>
Date: Mon, 22 Apr 2024 17:46:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
Content-Language: en-US
To: Thomas Richard <thomas.richard@bootlin.com>, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com, u-kumar1@ti.com,
 Keerthy <j-keerthy@ti.com>
References: <20240417120338.910769-1-thomas.richard@bootlin.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240417120338.910769-1-thomas.richard@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/04/2024 14:03, Thomas Richard wrote:
> From: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> This add suspend-to-ram support.
> 
> The derived_table is kept-as is, so the resume is only about
> pm_runtime_* calls and restoring the same registers as the probe.
> 
> Extract the hardware initialization procedure to a function called at
> both probe-time & resume-time.
> 
> The probe-time loop is split in two to ensure doing the hardware
> initialization before registering thermal zones. That ensures our
> callbacks cannot be called while in bad state.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Acked-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> 
> v3:
>   - Remove __maybe_unused attributes and use the magic of PTR_IF()

Where are these changes ?

> v2:
>   - Fix warnings/errors reported by kernel test robot
> 
>   drivers/thermal/k3_j72xx_bandgap.c | 112 ++++++++++++++++++++---------
>   1 file changed, 79 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> index c74094a86982..a7244e05ed5c 100644
> --- a/drivers/thermal/k3_j72xx_bandgap.c
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -178,6 +178,7 @@ struct k3_j72xx_bandgap {
>   	void __iomem *base;
>   	void __iomem *cfg2_base;
>   	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
> +	int cnt;
>   };
>   
>   /* common data structures */
> @@ -338,24 +339,53 @@ static void print_look_up_table(struct device *dev, int *ref_table)
>   		dev_dbg(dev, "%d       %d %d\n", i, derived_table[i], ref_table[i]);
>   }
>   
> +static void k3_j72xx_bandgap_init_hw(struct k3_j72xx_bandgap *bgp)
> +{
> +	struct k3_thermal_data *data;
> +	int id, high_max, low_temp;
> +	u32 val;
> +
> +	for (id = 0; id < bgp->cnt; id++) {
> +		data = bgp->ts_data[id];
> +		val = readl(bgp->cfg2_base + data->ctrl_offset);
> +		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
> +			K3_VTM_TMPSENS_CTRL_SOC |
> +			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
> +		writel(val, bgp->cfg2_base + data->ctrl_offset);
> +	}
> +
> +	/*
> +	 * Program TSHUT thresholds
> +	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
> +	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
> +	 *         This is already taken care as per of init
> +	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
> +	 */
> +	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
> +	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
> +
> +	writel((low_temp << 16) | high_max, bgp->cfg2_base + K3_VTM_MISC_CTRL2_OFFSET);
> +	mdelay(100);

	100ms ?

Ok, I know you did not introduce this delay. But as it is a suspend / 
resume, this delay will be called at each resume which is not acceptable 
given its duration.

Please, investigate a way to get rid of this delay


> +	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, bgp->cfg2_base + K3_VTM_MISC_CTRL_OFFSET);
> +}
> +
>   struct k3_j72xx_bandgap_data {
>   	const bool has_errata_i2128;
>   };
>   
>   static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   {
> -	int ret = 0, cnt, val, id;
> -	int high_max, low_temp;
> -	struct resource *res;
> +	const struct k3_j72xx_bandgap_data *driver_data;
> +	struct thermal_zone_device *ti_thermal;
>   	struct device *dev = &pdev->dev;
> +	bool workaround_needed = false;
>   	struct k3_j72xx_bandgap *bgp;
>   	struct k3_thermal_data *data;
> -	bool workaround_needed = false;
> -	const struct k3_j72xx_bandgap_data *driver_data;
> -	struct thermal_zone_device *ti_thermal;
> -	int *ref_table;
>   	struct err_values err_vals;
>   	void __iomem *fuse_base;
> +	int ret = 0, val, id;
> +	struct resource *res;
> +	int *ref_table;

No related to the changes but the patch is showing signs the driver 
needs a code cleanup AFAICT

>   	const s64 golden_factors[] = {
>   		-490019999999999936,
> @@ -422,10 +452,10 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   
>   	/* Get the sensor count in the VTM */
>   	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
> -	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
> -	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
> +	bgp->cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
> +	bgp->cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
>   
> -	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
> +	data = devm_kcalloc(bgp->dev, bgp->cnt, sizeof(*data), GFP_KERNEL);
>   	if (!data) {
>   		ret = -ENOMEM;
>   		goto err_alloc;
> @@ -449,8 +479,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   	else
>   		init_table(3, ref_table, pvt_wa_factors);
>   
> -	/* Register the thermal sensors */
> -	for (id = 0; id < cnt; id++) {
> +	/* Precompute the derived table & fill each thermal sensor struct */
> +	for (id = 0; id < bgp->cnt; id++) {
>   		data[id].bgp = bgp;
>   		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
>   		data[id].stat_offset = data[id].ctrl_offset +
> @@ -470,13 +500,13 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   		else if (id == 0 && !workaround_needed)
>   			memcpy(derived_table, ref_table, TABLE_SIZE * 4);
>   
> -		val = readl(data[id].bgp->cfg2_base + data[id].ctrl_offset);
> -		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
> -			K3_VTM_TMPSENS_CTRL_SOC |
> -			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
> -		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
> -
>   		bgp->ts_data[id] = &data[id];
> +	}
> +
> +	k3_j72xx_bandgap_init_hw(bgp);
> +
> +	/* Register the thermal sensors */
> +	for (id = 0; id < bgp->cnt; id++) {
>   		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
>   							   &k3_of_thermal_ops);
>   		if (IS_ERR(ti_thermal)) {
> @@ -486,21 +516,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	/*
> -	 * Program TSHUT thresholds
> -	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
> -	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
> -	 *         This is already taken care as per of init
> -	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
> -	 */
> -	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
> -	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
> -
> -	writel((low_temp << 16) | high_max, data[0].bgp->cfg2_base +
> -	       K3_VTM_MISC_CTRL2_OFFSET);
> -	mdelay(100);
> -	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
> -	       K3_VTM_MISC_CTRL_OFFSET);
> +	platform_set_drvdata(pdev, bgp);
>   
>   	print_look_up_table(dev, ref_table);
>   	/*
> @@ -527,6 +543,35 @@ static void k3_j72xx_bandgap_remove(struct platform_device *pdev)
>   	pm_runtime_disable(&pdev->dev);
>   }
>   
> +static int k3_j72xx_bandgap_suspend(struct device *dev)
> +{
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	return 0;
> +}
> +
> +static int k3_j72xx_bandgap_resume(struct device *dev)
> +{
> +	struct k3_j72xx_bandgap *bgp = dev_get_drvdata(dev);
> +	int ret;
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		pm_runtime_disable(dev);
> +		return ret;
> +	}
> +
> +	k3_j72xx_bandgap_init_hw(bgp);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(k3_j72xx_bandgap_pm_ops,
> +				k3_j72xx_bandgap_suspend,
> +				k3_j72xx_bandgap_resume);
> +
>   static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
>   	.has_errata_i2128 = true,
>   };
> @@ -554,6 +599,7 @@ static struct platform_driver k3_j72xx_bandgap_sensor_driver = {
>   	.driver = {
>   		.name = "k3-j72xx-soc-thermal",
>   		.of_match_table	= of_k3_j72xx_bandgap_match,
> +		.pm = pm_sleep_ptr(&k3_j72xx_bandgap_pm_ops),
>   	},
>   };
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


