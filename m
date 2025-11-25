Return-Path: <linux-pm+bounces-38640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C40C86435
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AC63A4745
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDFC32A3F2;
	Tue, 25 Nov 2025 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONCD3qlt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263162153E7
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092497; cv=none; b=QwLLIPviF0OhMh+nGcUFsYW3WzdFQ56dP1nV1g8SIGIMNHwL07SlIrIKHIrIEDSzO1Zc29A19cOD9zJvkSf9xfRf7TCxwOC1fTNfUXoCpnPJ/JKP9XWW9lAfayDe2hCGcU2HnV0roWWvvCItbkeww/FeZ8Znrs2yQ3wKAt93eHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092497; c=relaxed/simple;
	bh=pzgH07XMJ8BB9AS0x7BkF5nizHapBVVD/inP/i1r6i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Aaau+blZvidf3IHmAt5gS/kXz8EQHbx8mlxiI1POtMZYNyKQDx3r62wMJfcDACaTfkKDshgInV8XZs2ycQIX8dAaO8S474wrIz83cxSCSSwFPRBwmKh7fkGjoApw66irw6qXpIHXng5zcoHFAyGtwtIoShdOSwhDtEjsAgc5b+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ONCD3qlt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so3286685f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764092493; x=1764697293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lMQ1rizcjeahBOoSsE4k6lkryIgK2OIH0N/lzinDSjg=;
        b=ONCD3qltYu1cvBBxkM8cPlbYcdYCK/tW4X22qZuW+inthVLrVEjcvWE0m9SK+MnMg8
         NNsPeicMtOumOTYeiMLvZ79LdP6gCcUAcT71gZKhJYjhEuKpBtsjskZ3NcmVfwBWmQ5/
         etTP5uYkzRpwYjoLFbud2eXgOmsqOwDKeoIb6UnxcJVh/ZdfGAht5w0aNaUbGiH1BpiI
         vSM1ggkBxw+YlMV8cF4dMlCZYRj3CvcCuI378l/m2eVciAt+PLKvvCFwf6yDgxH46JBE
         Y+11MuiAMdiDGXG+H2TAlLjbxccHsLck9Xwvi9I1C8/jLdKN8LI2HH5tTT0zYak4w9O9
         tYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092493; x=1764697293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMQ1rizcjeahBOoSsE4k6lkryIgK2OIH0N/lzinDSjg=;
        b=qldK9Umod3gcJIY/BExcK5V3QcTuLKWmmDIbT2Y9Wix3k/B/E2lXt3n3ddRuBTN2ed
         KqqX1LQw2bCE2i3Z4rWBwWWXnekeIe/wDKGXHX1SZKrAa1NaKgm2lqtS0Z+pWX1NHthD
         YI6QQTHhymftd75R0GYN7V7CaZFGQDnMTzUPhwIWPMBcvm0joWTrROfUWsT9b7A+1f00
         t1EXY3QX3NbzYlXD4KiJMD2u3o66BAFraJqUNCJlz6FfoUuUhRFVyCg2TuEfgBGP4gyf
         VVzdMZItOCeXEhgyX9z/RHlYBrs6iXhY/388Qwhvx0+3b7ZspJGxaNoJm4SOKiBDnB5L
         I1hA==
X-Forwarded-Encrypted: i=1; AJvYcCXrA6CbB0vk3L2TLnf18hE/tqoWOM8V6LWzOK7w3i/NORKZMOwnK+cSu0C1q+b3ZOAdaWm1YatmEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDZTTQEpQudbA1d+vRDra6rFkW3anJ6H9KZFOl5wcpcLdMQs7
	B8VM1ApXp3BlBMTpRyS0TLST5ZMlbk123gekL7TOfgLGM+7gquywnhZFyM+PfzP3fsE=
X-Gm-Gg: ASbGncs/ScF0uCDsw43Rshj8l7oatjbQQtxpRfdeivkhsBOIXuwhPTKnsd+dhAUVGcC
	FUa0jdmNR8twkAX/hxv2GFMIgmSHIJ7KotlzmNi1ZO14+ABiH6VXYtpw0ZlufzKS/4zbHkdkPU/
	QbF51KDf9uRnufe1cHYbI1gyAd5dA8SkTEf6RLki6TrqIM/r9dCxVfEw0rhXuP5h00OtDONgozf
	zmCPF1MYTy/LpBcYcWORnXIENephxHsGaerWZEhibpQi4/hK6L6JIb4k1WXjTkMdDiQKIIUhUo0
	AE8XSiJ5zFd4zpfDUO8FEQ7dCQ0gXlwOVsLp0HV5z78TK5oWhq3hOE70P2zbLl3ngcqV8akmKRE
	BKlr73nZuak27G2hdS5dzhykBeb/dAYIUBx7VMTlHRHc5A0BYCM0QPe0JDl3SvUCPgDSCLwPrZZ
	ajua553iuzH7FfbOcMzA7VFbIcU8hrb1loFX7s4DPjsgM21McM6aU=
X-Google-Smtp-Source: AGHT+IEEqaPbgKy+ka1s0MF3DwNSw93jKIEgfWM9dePuwGKM32cX2S0zdeAtoK13jXOcd64riwetgw==
X-Received: by 2002:a05:6000:2f83:b0:429:c711:22d8 with SMTP id ffacd0b85a97d-42cc1cee555mr17252309f8f.15.1764092493462;
        Tue, 25 Nov 2025 09:41:33 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1d9d:2362:4539:c68d? ([2a05:6e02:1041:c10:1d9d:2362:4539:c68d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ffesm36235988f8f.10.2025.11.25.09.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 09:41:32 -0800 (PST)
Message-ID: <84128d4b-76a9-4054-969a-64cc44afd46d@linaro.org>
Date: Tue, 25 Nov 2025 18:41:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] thermal/drivers: airoha: Generalize probe function
To: Christian Marangi <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251106225929.1778398-1-ansuelsmth@gmail.com>
 <20251106225929.1778398-3-ansuelsmth@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251106225929.1778398-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/25 23:59, Christian Marangi wrote:
> In preparation for support of Airoha AN7583, generalize the probe
> function to address for the 2 SoC differece.
> 
> Implement a match_data struct where it's possible to define a more
> specific probe and post_probe function and specific thermal ops and
> pllrg protect value.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/thermal/airoha_thermal.c | 102 +++++++++++++++++++++++--------
>   1 file changed, 75 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
> index 01ed49a4887e..864a01fd8fd8 100644
> --- a/drivers/thermal/airoha_thermal.c
> +++ b/drivers/thermal/airoha_thermal.c
> @@ -198,12 +198,23 @@ struct airoha_thermal_priv {
>   	struct regmap *chip_scu;
>   	struct resource scu_adc_res;
>   
> +	u32 pllrg_protect;
> +
>   	struct thermal_zone_device *tz;
>   	int init_temp;
>   	int default_slope;
>   	int default_offset;
>   };
>   
> +struct airoha_thermal_soc_data {
> +	u32 pllrg_protect;
> +
> +	const struct thermal_zone_device_ops *thdev_ops;
> +	int (*probe)(struct platform_device *pdev,
> +		     struct airoha_thermal_priv *priv);
> +	int (*post_probe)(struct platform_device *pdev);
> +};
> +
>   static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
>   {
>   	u32 val;
> @@ -220,7 +231,8 @@ static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
>   	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
>   
>   	/* Give access to thermal regs */
> -	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, EN7581_SCU_THERMAL_PROTECT_KEY);
> +	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
> +		     priv->pllrg_protect);
>   	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
>   	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
>   
> @@ -228,7 +240,7 @@ static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
>   	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
>   }
>   
> -static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> +static int en7581_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>   {
>   	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
>   	int min_value, max_value, avg_value, value;
> @@ -253,7 +265,7 @@ static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>   	return 0;
>   }
>   
> -static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
> +static int en7581_thermal_set_trips(struct thermal_zone_device *tz, int low,
>   				    int high)
>   {
>   	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
> @@ -290,12 +302,12 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
>   	return 0;
>   }
>   
> -static const struct thermal_zone_device_ops thdev_ops = {
> -	.get_temp = airoha_thermal_get_temp,
> -	.set_trips = airoha_thermal_set_trips,
> +static const struct thermal_zone_device_ops en7581_thdev_ops = {
> +	.get_temp = en7581_thermal_get_temp,
> +	.set_trips = en7581_thermal_set_trips,
>   };
>   
> -static irqreturn_t airoha_thermal_irq(int irq, void *data)
> +static irqreturn_t en7581_thermal_irq(int irq, void *data)
>   {
>   	struct airoha_thermal_priv *priv = data;
>   	enum thermal_notify_event event;
> @@ -326,7 +338,7 @@ static irqreturn_t airoha_thermal_irq(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> -static void airoha_thermal_setup_adc_val(struct device *dev,
> +static void en7581_thermal_setup_adc_val(struct device *dev,
>   					 struct airoha_thermal_priv *priv)
>   {
>   	u32 efuse_calib_info, cpu_sensor;
> @@ -356,7 +368,7 @@ static void airoha_thermal_setup_adc_val(struct device *dev,
>   	}
>   }
>   
> -static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
> +static void en7581_thermal_setup_monitor(struct airoha_thermal_priv *priv)
>   {
>   	/* Set measure mode */
>   	regmap_write(priv->map, EN7581_TEMPMSRCTL0,
> @@ -411,30 +423,26 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
>   		     FIELD_PREP(EN7581_ADC_POLL_INTVL, 146));
>   }
>   
> -static const struct regmap_config airoha_thermal_regmap_config = {
> +static const struct regmap_config en7581_thermal_regmap_config = {
>   	.reg_bits		= 32,
>   	.reg_stride		= 4,
>   	.val_bits		= 32,
>   };
>   
> -static int airoha_thermal_probe(struct platform_device *pdev)
> +static int en7581_thermal_probe(struct platform_device *pdev,
> +				struct airoha_thermal_priv *priv)
>   {
> -	struct airoha_thermal_priv *priv;
>   	struct device_node *chip_scu_np;
>   	struct device *dev = &pdev->dev;
>   	void __iomem *base;
>   	int irq, ret;
>   
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> -
>   	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
>   	priv->map = devm_regmap_init_mmio(dev, base,
> -					  &airoha_thermal_regmap_config);
> +					  &en7581_thermal_regmap_config);
>   	if (IS_ERR(priv->map))
>   		return PTR_ERR(priv->map);
>   
> @@ -454,18 +462,55 @@ static int airoha_thermal_probe(struct platform_device *pdev)
>   		return irq;
>   
>   	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -					airoha_thermal_irq, IRQF_ONESHOT,
> +					en7581_thermal_irq, IRQF_ONESHOT,
>   					pdev->name, priv);
>   	if (ret) {
>   		dev_err(dev, "Can't get interrupt working.\n");
>   		return ret;
>   	}
>   
> -	airoha_thermal_setup_monitor(priv);
> -	airoha_thermal_setup_adc_val(dev, priv);
> +	en7581_thermal_setup_monitor(priv);
> +	en7581_thermal_setup_adc_val(dev, priv);
> +
> +	return 0;
> +}
> +
> +static int en7581_thermal_post_probe(struct platform_device *pdev)
> +{
> +	struct airoha_thermal_priv *priv = platform_get_drvdata(pdev);
> +
> +	/* Enable LOW and HIGH interrupt (if supported) */
> +	regmap_write(priv->map, EN7581_TEMPMONINT,
> +		     EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0);
> +
> +	return 0;
> +}
> +
> +static int airoha_thermal_probe(struct platform_device *pdev)
> +{
> +	const struct airoha_thermal_soc_data *soc_data;
> +	struct airoha_thermal_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	soc_data = device_get_match_data(dev);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pllrg_protect = soc_data->pllrg_protect;
> +
> +	if (!soc_data->probe)
> +		return -EINVAL;
> +
> +	ret = soc_data->probe(pdev, priv);
> +	if (ret)
> +		return ret;
>   
>   	/* register of thermal sensor and get info from DT */
> -	priv->tz = devm_thermal_of_zone_register(dev, 0, priv, &thdev_ops);
> +	priv->tz = devm_thermal_of_zone_register(dev, 0, priv,
> +						 soc_data->thdev_ops);

I suggest to move devm_thermal_of_zone_register() in the platform 
specific probe function, directly pass the corresponding ops.

That will allow to get rid of the post_probe() and the thdev_ops field 
in the airoha_thermal_soc_data structure.

	devm_thermal_of_zone_register(dev, 0, priv, &en7581_thdev_ops);


>   	if (IS_ERR(priv->tz)) {
>   		dev_err(dev, "register thermal zone sensor failed\n");
>   		return PTR_ERR(priv->tz);
> @@ -473,15 +518,18 @@ static int airoha_thermal_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, priv);
>   
> -	/* Enable LOW and HIGH interrupt */
> -	regmap_write(priv->map, EN7581_TEMPMONINT,
> -		     EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0);
> -
> -	return 0;
> +	return soc_data->post_probe ? soc_data->post_probe(pdev) : 0;
>   }
>   
> +static const struct airoha_thermal_soc_data en7581_data = {
> +	.pllrg_protect = EN7581_SCU_THERMAL_PROTECT_KEY,
> +	.thdev_ops = &en7581_thdev_ops,
> +	.probe = &en7581_thermal_probe,
> +	.post_probe = &en7581_thermal_post_probe,
> +};
> +
>   static const struct of_device_id airoha_thermal_match[] = {
> -	{ .compatible = "airoha,en7581-thermal" },
> +	{ .compatible = "airoha,en7581-thermal", .data = &en7581_data },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, airoha_thermal_match);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

