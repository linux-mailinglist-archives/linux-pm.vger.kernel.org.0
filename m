Return-Path: <linux-pm+bounces-38656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A43C8735F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 22:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C7346AB3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFFC2FB637;
	Tue, 25 Nov 2025 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="za5VreFB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47F2FAC0A
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105623; cv=none; b=CbGzUecJHVY6BNldidzc2USdkrCY8LhpMQtNp0x4ncGMoxIFzsZaumSRRRpWIA/EaaZBJBx1x/anwurUwSTWd8g6KxoOKmfdDx7wVQ3IZX9js82tBT3O7Gczzq0EL4xHg3rX2Zs9JeYUH855nVzduJb8LTmL4dIYV77uNyHAyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105623; c=relaxed/simple;
	bh=XJW1618AeSh8p0FvIT2L/UOsZV0GPeMhh84mZiz4ecg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KODrG6YzuIueO/epC8DRNJam7NtKhKNTCUwF//8i43ecwrJh7A9TVbGRkiCz/ehTiD7zc70JlL8Vt33RfopjO5VVMDKeH6d/liT2xSy3Sdt3dlqO0r7V4MjwVKl8w1T+PWuAhQTMu2y9SQalp1FNmaYwyVS6jTXNsga7q7UUIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=za5VreFB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso36198965e9.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 13:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764105619; x=1764710419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lgeyODjjwWGv2LqYAD1M4y/a4gMxr9izn+TjHICf2QA=;
        b=za5VreFBx7A+NbX4bmySWiHkFMr/Wt8BGG8fEda+vmHv+mYkBKmxcEVqvh2ruD3TmW
         ZtI7peF2UKpGSXQGwWKI9RGIpQBbwlgxHTP8Ma9zhknnPZiFGcsZKHoCIOTPVfrGQSFZ
         reX9WXpzyOM6avdYBl6JdWvHSimhr3MXrZ74Hs02uGn+xPU/yP2RzjJWi1PqpZ2jTKEQ
         vVlY8wXjWI08MOJNgeByAfSgE5Dw7XMjXBBLA8aO6PvcEjtt5kQhRwG+uR4oWiKfcFT7
         ti397o+KHceuPRmATwrv4cDMQSLmbGUC6wI8vzDhXtLTsTqxJmTpotG0BnXpxHBEkHmV
         g/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764105619; x=1764710419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgeyODjjwWGv2LqYAD1M4y/a4gMxr9izn+TjHICf2QA=;
        b=gizmT+CJEfWbyFjpVTANlfzcSKuXDWjF0E7BfvCmFqOgD+kfgQXuE9dzVyOeL6WA8x
         c/MVLnMiCGSr/VEaRkBcgERGGdUJU5dilOromPoR5SDKRydGESEV7WParx2XFmskX3kI
         LNZQzwmq86U5634xMGCdgLHd4FipVVSvWBGDE9O1Pe0tEdpk6c8LuMZfLhVGoUcENx4+
         T6/evK62CAgdQH0vfTDEnTepWiTgaNuuDLrRKe5DCIxslvpvnZE1Y5ZBsnsIcmr/sbm+
         aEOO7LzTABFxpB+kz0jlYRtwzNF7jexNvwbKefpIBtvW/UwF3q4aZ3swrpOcBBHrcJde
         fL8A==
X-Forwarded-Encrypted: i=1; AJvYcCVVvV9KoThAKaWgyd85odhXr2v6RSi8Lmi7Uq5S0f6VyeUjLdXYKVJHxIwcLSPIHVZFeB5lK09Wfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSQDF1e7CNjU4Hlgo8dwIATkaGuYYRB5fdrjc9kPeeg9xxdDt
	K+c97ivwcQJmv7kTCumtPMRuR9QtrKQGpRNf23qmYxOK3gryqJ2WctD1SYfj2FLekQo=
X-Gm-Gg: ASbGncuY1iTCg63+HMaSug1SEe0J7pmhtyDll8yf5R1ZA9PkxVGHbZJkkrueQlKxKRv
	AxFUB12lVapBUj+9XydkzSLFdyEFx4zKM157mhnC4M+mJt1MyIlPSZ8CeJU4MsRZN+W02Jg6Dry
	snwRGX0JibIViPgFvf667mhKwdQ1bXVeJl3tTACZ6ihyYXT/WN537o59UM4s8Qxo4hUeeYB53sm
	YhXxwCMokzqdvoFgi4mZA3xZg0d+J7BKP7iU5Jh0f8t9LzXDIMLf5fVd7z7FhKV4D0r9TOpE/pr
	GjzAuw1OZS4zVtJFEaGNDYBuR7RWStofmEBA/geQwhLprMwb6e2+Bf/LcvN8hYykXjCMCyUAJL0
	yOWUvgI/ySlq4dWvti5VGY9DWl/cmbkL755uo5fK8M/bpBG13LVfvFd2NhByCM+AMbdZ4p6e7lF
	cV1itqDn3Bf1rUGzH1haHF1ZIm13lotTyRjQAoKEJWVDcC8ikE3OWYCTptsEmkKgGYiw==
X-Google-Smtp-Source: AGHT+IFdWHejJYMhzJuTuSVlm6rwhlp+m0ckCKintINuBoyb0kMJ5cumF+USbjfNXBcVyPOJkM1Z+A==
X-Received: by 2002:a05:600c:1f94:b0:471:1765:839c with SMTP id 5b1f17b1804b1-477c1117949mr131150635e9.20.1764105619440;
        Tue, 25 Nov 2025 13:20:19 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1d9d:2362:4539:c68d? ([2a05:6e02:1041:c10:1d9d:2362:4539:c68d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4790ab8bb21sm9790865e9.0.2025.11.25.13.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 13:20:18 -0800 (PST)
Message-ID: <ad124b26-7c59-4c31-8e45-7eca0001d6a2@linaro.org>
Date: Tue, 25 Nov 2025 22:20:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] thermal/drivers: airoha: Generalize
 get_thermal_ADC and set_mux function
To: Christian Marangi <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251106225929.1778398-1-ansuelsmth@gmail.com>
 <20251106225929.1778398-4-ansuelsmth@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251106225929.1778398-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/25 23:59, Christian Marangi wrote:
> In preparation for support of Airoha AN7583, generalize
> get_thermal_ADC() and set_thermal_mux() with the use of reg_field API.
> 
> This is to account the same logic between the current supported SoC and
> the new one but with different register address.
> 
> While at it also further improve some comments and move sleep inside the
> set_thermal_mux function.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/thermal/airoha_thermal.c | 54 +++++++++++++++++++++++++-------
>   1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
> index 864a01fd8fd8..a062922cb116 100644
> --- a/drivers/thermal/airoha_thermal.c
> +++ b/drivers/thermal/airoha_thermal.c
> @@ -193,9 +193,18 @@
>   
>   #define AIROHA_MAX_SAMPLES			6
>   
> +enum airoha_thermal_chip_scu_field {
> +	AIROHA_THERMAL_DOUT_TADC,
> +	AIROHA_THERMAL_MUX_TADC,
> +
> +	/* keep last */
> +	AIROHA_THERMAL_FIELD_MAX,

nit: if last, no comma :)
nit2: naming is not consistent

> +};
> +
>   struct airoha_thermal_priv {
>   	struct regmap *map;
>   	struct regmap *chip_scu;
> +	struct regmap_field *chip_scu_fields[AIROHA_THERMAL_FIELD_MAX];
>   	struct resource scu_adc_res;
>   
>   	u32 pllrg_protect;
> @@ -219,22 +228,29 @@ static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
>   {
>   	u32 val;
>   
> -	regmap_read(priv->chip_scu, EN7581_DOUT_TADC, &val);
> -	return FIELD_GET(EN7581_DOUT_TADC_MASK, val);
> +	regmap_field_read(priv->chip_scu_fields[AIROHA_THERMAL_DOUT_TADC],
> +			  &val);
> +	return val;
>   }
>   
> -static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
> +static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
> +				   int tdac_idx)
>   {
> -	u32 adc_mux, pllrg;
> +	u32 pllrg;
>   
>   	/* Save PLLRG current value */
>   	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
>   
> -	/* Give access to thermal regs */
> +	/* Give access to Thermal regs */
>   	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
>   		     priv->pllrg_protect);
> -	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
> -	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
> +
> +	/* Configure Thermal ADC mux to tdac_idx */
> +	regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
> +			   tdac_idx);
> +
> +	/* Sleep 10 ms for Thermal ADC to enable */
> +	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);

10ms ? It is a lot no ?
>   	/* Restore PLLRG value on exit */
>   	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
> @@ -343,10 +359,8 @@ static void en7581_thermal_setup_adc_val(struct device *dev,
>   {
>   	u32 efuse_calib_info, cpu_sensor;
>   
> -	/* Setup thermal sensor to ADC mode and setup the mux to DIODE1 */
> -	airoha_init_thermal_ADC_mode(priv);
> -	/* sleep 10 ms for ADC to enable */
> -	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
> +	/* Setup Thermal Sensor to ADC mode and setup the mux to DIODE1 */
> +	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1);
>   
>   	regmap_read(priv->map, EN7581_EFUSE_TEMP_OFFSET_REG, &efuse_calib_info);
>   	if (efuse_calib_info) {
> @@ -429,13 +443,18 @@ static const struct regmap_config en7581_thermal_regmap_config = {
>   	.val_bits		= 32,
>   };
>   
> +static const struct reg_field en7581_chip_scu_fields[AIROHA_THERMAL_FIELD_MAX] = {
> +	[AIROHA_THERMAL_DOUT_TADC] = REG_FIELD(EN7581_DOUT_TADC, 0, 15),
> +	[AIROHA_THERMAL_MUX_TADC] = REG_FIELD(EN7581_PWD_TADC, 1, 3),
> +};
> +
>   static int en7581_thermal_probe(struct platform_device *pdev,
>   				struct airoha_thermal_priv *priv)
>   {
>   	struct device_node *chip_scu_np;
>   	struct device *dev = &pdev->dev;
>   	void __iomem *base;
> -	int irq, ret;
> +	int i, irq, ret;
>   
>   	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
> @@ -454,6 +473,17 @@ static int en7581_thermal_probe(struct platform_device *pdev,
>   	if (IS_ERR(priv->chip_scu))
>   		return PTR_ERR(priv->chip_scu);
>   
> +	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
> +		struct regmap_field *field;
> +
> +		field = devm_regmap_field_alloc(dev, priv->chip_scu,
> +						en7581_chip_scu_fields[i]);
> +		if (IS_ERR(field))
> +			return PTR_ERR(field);
> +
> +		priv->chip_scu_fields[i] = field;
> +	}
> +
>   	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
>   	of_node_put(chip_scu_np);
>   


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

