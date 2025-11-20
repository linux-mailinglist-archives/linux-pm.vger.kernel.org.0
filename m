Return-Path: <linux-pm+bounces-38319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F8C761C8
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 20:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFE824E140B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 19:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0803A3358CF;
	Thu, 20 Nov 2025 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtfNaTSj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A332F7ABF
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667834; cv=none; b=OAq0JJCDjO/Y7sEzfixKp+zsChv31Cn10Rtj2/dPdKYAKPBeN+fpioyY6KZ5XqtRfGnOUatZnfHG0Y2c9rolxj6J2nB4aMBucWtI6vN+wJZwRLObV1eLwZLKyGW/HkGqWK+YWDSKqLY0Ysh5HnOBh0+7jjL15ufDNAH/1AS8c8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667834; c=relaxed/simple;
	bh=F5HMguFxGXthSp33PiZZaL+9ps5RXkwJXAlFEkKzvnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rN8dGmFD+6dHO3AeQ+Ua+X+xz0pif+46eIGMWEAwtnarlKbU8iIQEKaOn1gQ3J1OaVXTRbYlLbEpibwNn5AKtjvVl4gnOnx65pVxj6fS8ezqfaPk8KMlbz2/hdYhB1k3wFPT2wTQ06zXO+wNZBlwgSETwBNxR1uhJSm+fH2t/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OtfNaTSj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so11214595e9.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763667829; x=1764272629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0wcaY9b/9Hgu2I30mJDJj//TA73VYL8EoY2qW3Rxqw=;
        b=OtfNaTSjhmOUwDfq+zdZF5EOMcQN2sxmXxqW9ONDn19ahfiWScqyEXiZS3X5XoreVV
         cAqisq7xdhVZMJaoQdeS9kIBdz6VYnhc7stc/GXnpMUh2GNPQz3igrOBvFm6++I/4WAL
         2u62LZA6qi9oGnySIn7UobwFaCGUU93RMIeSzRcW5VGs9V7qMCpEVfu0zV0yv613hSV/
         BNdE6z4awnIvD1if5paLH+J0HSQDiA7gQQnWPlJCFHgueNpqatV9UckJpVyNi9+/siBt
         7XWL5iyjCcl7NquygMuiQ8CCaaTkFaiKkwoYOT26elmqUa1f66i8OGJmfwbeD2ofR2yQ
         MVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763667829; x=1764272629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0wcaY9b/9Hgu2I30mJDJj//TA73VYL8EoY2qW3Rxqw=;
        b=Spqql7V4sQIwWTf6ihbEz9EYAfwwnNbIV7RNU0BPpXJljP5ol1ba8PJeu9+gcU9jmJ
         2EiW47fu71RpNWM7/XhD1A3srQ+P5RBPB0H8WesFQYBNKUeJU91oXv6Qtynl++pSSaZK
         YimOya4owlves+7wmC5X6ec++3dAV2HBtn1vpgqecR1UQkLOS4fWrO/uZckv/PxoklBf
         Bw4lF/WgX0Z3v1fEibLhFY1eDqv+L9+J8UUVOlJob1U+xynoLB3GTMJ4WIZQFXsT76Si
         0G0E3zj21KSKm9nQEXX9Xb6MI07jGsRV5DlrKzH85Ebj/OOg35r3iv4ZMgGaCnuKFaR5
         JVjg==
X-Forwarded-Encrypted: i=1; AJvYcCWIxCkM9ghXRUjRUQXiUDyJhQmPAR4uMqFi07PKOeLWGxTfeNLEl0OhEpAEqsXMqXNOVUGf5AgmJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHe6Gh5N6zaKxxlw8PcYLj66uNx1LV819HrZo7CL4ibQgppCoQ
	To3+jYIyIXgz7HO6ILSgLxogKSMTn2n/BJ0kXd0RgAX+CYrFw0sUCJoW5551/+eVL+0=
X-Gm-Gg: ASbGncuZrBCH3vXycM+y/9FHQ/ky+9hRb2lCrRsBcC5xqPpkovmdUZbYkMLa6cGRuKw
	1OArtzTY4uKaw4sG+FcAbSGPg+5hFCbBUxbatMoTlVY7apywxXFaSk9b/7piix6VcyD7OMStMBO
	JrOwBz7MuCjECG6oMhZ1ZzvbJR0KYA3qt0cfwnci6HNDuKX6yBXXQ9QIfVkTJZklYsf8/W3gSq/
	UMhA+m/KErYb12PuBc66UMsXnUdB2HsvyUYIiRooA4DGMNlDu1vjTlq5ID5vn4dbSlU5pj8KVKv
	JM+/gDcAot0FKYzyN1Pj/5fsBptoOtAc3KCAc515LtTdBUBm8vcY/XpT6ROhNS8vowJBmdUDNHt
	SfpcpjPiqsuBNFJTbCHWNDLioMDlpch5HTaCcbUb33qT5scG51oHTNHWHOx8e1DpX142b4zwKj7
	jll2VxT5gEVd9v8sJexqycsaR0gW5DhitP461jJ56HN04D2VrfSc+N97HoreQXQVXyhV32TDnTr
	Ivu
X-Google-Smtp-Source: AGHT+IGqh7E+LkxDhKlzmmjzCWXrpgMklQEVcxHPfpIoIqEeiNxTg7zmRUqSzdRXebKFStcuQIUrVA==
X-Received: by 2002:a05:600c:1c23:b0:477:aed0:f40a with SMTP id 5b1f17b1804b1-477b8a98cefmr53366115e9.19.1763667829301;
        Thu, 20 Nov 2025 11:43:49 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477bf1df334sm6309645e9.3.2025.11.20.11.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 11:43:48 -0800 (PST)
Message-ID: <2180a854-8ba6-4424-add2-eb34637530c1@linaro.org>
Date: Thu, 20 Nov 2025 20:43:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
To: Shin Son <shin.son@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251113064022.2701578-1-shin.son@samsung.com>
 <CGME20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237@epcas2p1.samsung.com>
 <20251113064022.2701578-3-shin.son@samsung.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251113064022.2701578-3-shin.son@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/13/25 07:40, Shin Son wrote:
> The Exynos tmu driver's private data structure has been extended
> to support the exynosautov920 hardware, which requires per-sensor interrupt
> enablement and multiple-zone handling:
> 
> - Add 'slope_comp' : compensation parameter below 25 degrees.
> - Add 'calib_temp' : stores the fused calibaration temperature.
> - Add 'sensor_count' : reflects the maximum sensor numbers.
> - Rename 'tzd' -> 'tzd_array' to register multiple thermal zones.
> 
> Since splitting this patch causes runtime errors during temperature
> emulation or problems where the read temperature feature fails to
> retrieve values, I have submitted it as a single commit. To add support
> for the exynosautov920 to the exisiting TMU interface, the following
> changes are included:
> 
> 1. Simplify "temp_to_code" and "code_to_temp" to one computation path
>     by normalizing calib_temp.
> 2. Loop over 'sensor_count' in critical-point setup.
> 3. Introduce 'update_con_reg' for exynosautov920 control-register updates.
> 4. Add exynosautov920-specific branch in 'exynos_tmu_update_temp' function.
> 5. Skip high & low temperature threshold setup in exynosautov920.
> 6. Enable interrupts via sensor_count in exynosautov920.
> 7. Initialize all new members during 'exynosautov920_tmu_initialize'.
> 8. Clear IRQs by iterating the sensor_count in exynosautov920.
> 9. Register each zone with 'devm_thermal_of_zone_register()'
>     based on 'sensor_count'.
> 
> Reviewed-by: Henrik Grimler <henrik@grimler.se>
> Signed-off-by: Shin Son <shin.son@samsung.com>
> ---
>   drivers/thermal/samsung/exynos_tmu.c | 322 ++++++++++++++++++++++++---
>   1 file changed, 285 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 47a99b3c5395..8fa188928b79 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -121,8 +121,51 @@
>   
>   #define EXYNOS_NOISE_CANCEL_MODE		4
>   
> +/* ExynosAutov920 specific registers */
> +#define EXYNOSAUTOV920_SLOPE_COMP		25
> +#define EXYNOSAUTOV920_SLOPE_COMP_MASK		0xf
> +#define EXYNOSAUTOV920_CALIB_SEL_TEMP		30
> +#define EXYNOSAUTOV920_CALIB_SEL_TEMP_MASK	0x2
> +
> +#define EXYNOSAUTOV920_SENSOR0_TRIM_INFO	0x10
> +#define EXYNOSAUTOV920_TRIM_MASK		0x1ff
> +#define EXYNOSAUTOV920_TRIMINFO_25_SHIFT	0
> +#define EXYNOSAUTOV920_TRIMINFO_85_SHIFT	9
> +
> +#define EXYNOSAUTOV920_TMU_REG_TRIMINFO2	0x04
> +
> +#define EXYNOSAUTOV920_TMU_REG_THRESHOLD(p)	(((p)) * 0x50 + 0x00d0)
> +#define EXYNOSAUTOV920_TMU_REG_INTEN(p)		(((p)) * 0x50 + 0x00f0)
> +#define EXYNOSAUTOV920_TMU_REG_INT_PEND(p)	(((p)) * 0x50 + 0x00f8)
> +
> +#define EXYNOSAUTOV920_CURRENT_TEMP_P1_P0	0x084
> +#define EXYNOSAUTOV920_TMU_REG_EMUL_CON		0x0b0
> +
> +#define EXYNOSAUTOV920_TMU_REG_CONTROL		0x50
> +#define EXYNOSAUTOV920_TMU_REG_CONTROL1		0x54
> +#define EXYNOSAUTOV920_TMU_REG_AVG_CONTROL	0x58
> +#define EXYNOSAUTOV920_TMU_SAMPLING_INTERVAL	0x70
> +#define EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE0	0x74
> +#define EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE1	0x78
> +
> +#define EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_SHIFT		8
> +#define EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_MASK		0x1f
> +#define EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_SHIFT	3
> +#define EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_MASK		0xf
> +#define EXYNOSAUTOV920_TMU_NUM_PROBE_MASK		0xf
> +#define EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT		16
> +#define EXYNOSAUTOV920_TMU_LPI_MODE_MASK		1
> +#define EXYNOSAUTOV920_TMU_LPI_MODE_SHIFT		10
> +
> +#define EXYNOSAUTOV920_TMU_AVG_CON_UPDATE		0x0008011a
> +#define EXYNOSAUTOV920_TMU_COUNTER_VALUE0_UPDATE	0x030003c0
> +#define EXYNOSAUTOV920_TMU_COUNTER_VALUE1_UPDATE	0x03c0004d
> +
>   #define MCELSIUS	1000
>   
> +#define EXYNOS_DEFAULT_SENSOR_COUNT			1
> +#define EXYNOS_MAX_SENSOR_COUNT				15
> +
>   enum soc_type {
>   	SOC_ARCH_EXYNOS3250 = 1,
>   	SOC_ARCH_EXYNOS4210,
> @@ -133,6 +176,7 @@ enum soc_type {
>   	SOC_ARCH_EXYNOS5420_TRIMINFO,
>   	SOC_ARCH_EXYNOS5433,
>   	SOC_ARCH_EXYNOS7,
> +	SOC_ARCH_EXYNOSAUTOV920,
>   };
>   
>   /**
> @@ -150,6 +194,8 @@ enum soc_type {
>    * @efuse_value: SoC defined fuse value
>    * @min_efuse_value: minimum valid trimming data
>    * @max_efuse_value: maximum valid trimming data
> + * @slope_comp: allocated value of the slope compensation.
> + * @calib_temp: calibration temperature of the TMU.
>    * @temp_error1: fused value of the first point trim.
>    * @temp_error2: fused value of the second point trim.
>    * @gain: gain of amplifier in the positive-TC generator block
> @@ -157,7 +203,8 @@ enum soc_type {
>    * @reference_voltage: reference voltage of amplifier
>    *	in the positive-TC generator block
>    *	0 < reference_voltage <= 31
> - * @tzd: pointer to thermal_zone_device structure
> + * @sensor_count: The maximum number of the sensors
> + * @tzd_array: pointer array of thermal_zone_device structure
>    * @enabled: current status of TMU device
>    * @tmu_set_low_temp: SoC specific method to set trip (falling threshold)
>    * @tmu_set_high_temp: SoC specific method to set trip (rising threshold)
> @@ -174,6 +221,7 @@ struct exynos_tmu_data {
>   	void __iomem *base;
>   	void __iomem *base_second;
>   	int irq;
> +	int sensor_count;
>   	enum soc_type soc;
>   	struct mutex lock;
>   	struct clk *clk, *clk_sec, *sclk;
> @@ -181,10 +229,12 @@ struct exynos_tmu_data {
>   	u32 efuse_value;
>   	u32 min_efuse_value;
>   	u32 max_efuse_value;
> +	u16 slope_comp;
> +	u16 calib_temp;
>   	u16 temp_error1, temp_error2;
>   	u8 gain;
>   	u8 reference_voltage;
> -	struct thermal_zone_device *tzd;
> +	struct thermal_zone_device *tzd_array[EXYNOS_MAX_SENSOR_COUNT];
>   	bool enabled;
>   
>   	void (*tmu_set_low_temp)(struct exynos_tmu_data *data, u8 temp);
> @@ -205,13 +255,20 @@ struct exynos_tmu_data {
>    */
>   static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
>   {
> +	s32 temp_diff, code;
> +
>   	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
>   		return temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
>   
> -	return (temp - EXYNOS_FIRST_POINT_TRIM) *
> -		(data->temp_error2 - data->temp_error1) /
> -		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
> -		data->temp_error1;
> +	temp_diff = temp - EXYNOS_FIRST_POINT_TRIM;
> +
> +	code = temp_diff * (data->temp_error2 - data->temp_error1) * MCELSIUS /
> +	       (data->calib_temp - EXYNOS_FIRST_POINT_TRIM);
> +
> +	if (data->soc == SOC_ARCH_EXYNOSAUTOV920 && temp_diff < 0)
> +		code = code * (57 + data->slope_comp) / 65;
> +
> +	return code / MCELSIUS + data->temp_error1;
>   }
>   
>   /*
> @@ -220,13 +277,20 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
>    */
>   static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
>   {
> +	s32 code_diff, temp;
> +
>   	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
>   		return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
>   
> -	return (temp_code - data->temp_error1) *
> -		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
> -		(data->temp_error2 - data->temp_error1) +
> -		EXYNOS_FIRST_POINT_TRIM;
> +	code_diff = temp_code - data->temp_error1;
> +
> +	temp = code_diff * (data->calib_temp - EXYNOS_FIRST_POINT_TRIM) * MCELSIUS /
> +	       (data->temp_error2 - data->temp_error1);
> +
> +	if (data->soc == SOC_ARCH_EXYNOSAUTOV920 && code_diff < 0)
> +		temp = temp * 65 / (57 + data->slope_comp);

No litterals, comments, etc ...

> +
> +	return temp / MCELSIUS + EXYNOS_FIRST_POINT_TRIM;
>   }
>   
>   static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
> @@ -262,6 +326,9 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>   		clk_enable(data->clk_sec);
>   
>   	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
> +	if (data->soc == SOC_ARCH_EXYNOSAUTOV920)
> +		status = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> +
>   	if (!status) {
>   		ret = -EBUSY;
>   	} else {
> @@ -280,27 +347,34 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>   static int exynos_thermal_zone_configure(struct platform_device *pdev)
>   {
>   	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> -	struct thermal_zone_device *tzd = data->tzd;
> -	int ret, temp;
> +	struct thermal_zone_device *tzd;
> +	int ret, temp, idx;
>   
> -	ret = thermal_zone_get_crit_temp(tzd, &temp);
> -	if (ret) {
> -		/* FIXME: Remove this special case */
> -		if (data->soc == SOC_ARCH_EXYNOS5433)
> -			return 0;
> +	for (idx = 0; idx < data->sensor_count; idx++) {
> +		tzd = data->tzd_array[idx];
>   
> -		dev_err(&pdev->dev,
> -			"No CRITICAL trip point defined in device tree!\n");
> -		return ret;
> -	}
> +		if (!tzd)
> +			continue;
>   
> -	mutex_lock(&data->lock);
> -	clk_enable(data->clk);
> +		ret = thermal_zone_get_crit_temp(tzd, &temp);
> +		if (ret) {
> +			/* FIXME: Remove this special case */
> +			if (data->soc == SOC_ARCH_EXYNOS5433)
> +				return 0;
>   
> -	data->tmu_set_crit_temp(data, temp / MCELSIUS);
> +			dev_err(&pdev->dev,
> +				"No CRITICAL trip point defined in device tree!\n");
> +			return ret;
> +		}
>   
> -	clk_disable(data->clk);
> -	mutex_unlock(&data->lock);
> +		mutex_lock(&data->lock);
> +		clk_enable(data->clk);
> +
> +		data->tmu_set_crit_temp(data, temp / MCELSIUS);
> +
> +		clk_disable(data->clk);
> +		mutex_unlock(&data->lock);
> +	}
>   
>   	return 0;
>   }
> @@ -323,6 +397,37 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
>   	return con;
>   }
>   
> +static void update_con_reg(struct exynos_tmu_data *data)
> +{
> +	u32 val, t_buf_vref_sel, t_buf_slope_sel;
> +
> +	val = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> +	t_buf_vref_sel = (val >> EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_SHIFT)
> +				& EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_MASK;
> +	t_buf_slope_sel = (val >> EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_SHIFT)
> +				& EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_MASK;
> +
> +	val = readl(data->base +  EXYNOSAUTOV920_TMU_REG_CONTROL);
> +	val &= ~(EXYNOS_TMU_REF_VOLTAGE_MASK << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
> +	val |= (t_buf_vref_sel << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
> +	val &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
> +	val |= (t_buf_slope_sel << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
> +	writel(val, data->base + EXYNOSAUTOV920_TMU_REG_CONTROL);
> +
> +	val = readl(data->base + EXYNOSAUTOV920_TMU_REG_CONTROL1);
> +	val &= ~(EXYNOSAUTOV920_TMU_NUM_PROBE_MASK << EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT);
> +	val &= ~(EXYNOSAUTOV920_TMU_LPI_MODE_MASK << EXYNOSAUTOV920_TMU_LPI_MODE_SHIFT);
> +	val |= (data->sensor_count << EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT);
> +	writel(val, data->base + EXYNOSAUTOV920_TMU_REG_CONTROL1);
> +
> +	writel(1, data->base + EXYNOSAUTOV920_TMU_SAMPLING_INTERVAL);
> +	writel(EXYNOSAUTOV920_TMU_AVG_CON_UPDATE, data->base + EXYNOSAUTOV920_TMU_REG_AVG_CONTROL);
> +	writel(EXYNOSAUTOV920_TMU_COUNTER_VALUE0_UPDATE,
> +	       data->base + EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE0);
> +	writel(EXYNOSAUTOV920_TMU_COUNTER_VALUE1_UPDATE,
> +	       data->base + EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE1);
> +}
> +

This is unreadable; please make it understandable for those who don’t 
have the documentation (explicit static inline functions, comments, etc 
...).

>   static void exynos_tmu_control(struct platform_device *pdev, bool on)
>   {
>   	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> @@ -354,9 +459,8 @@ static void exynos_tmu_update_temp(struct exynos_tmu_data *data, int reg_off,
>   	u16 tmu_temp_mask;
>   	u32 th;
>   
> -	tmu_temp_mask =
> -		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
> -						: EXYNOS_TMU_TEMP_MASK;
> +	tmu_temp_mask = (data->soc == SOC_ARCH_EXYNOS7 || data->soc == SOC_ARCH_EXYNOSAUTOV920)
> +		? EXYNOS7_TMU_TEMP_MASK	: EXYNOS_TMU_TEMP_MASK;
>   
>   	th = readl(data->base + reg_off);
>   	th &= ~(tmu_temp_mask << bit_off);
> @@ -582,6 +686,68 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
>   	sanitize_temp_error(data, trim_info);
>   }
>   
> +static void exynosautov920_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
> +{
> +	/*
> +	 * Failing thresholds are not supported on Exynosautov920.
> +	 * We use polling instead.
> +	 */
> +}
> +
> +static void exynosautov920_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
> +{
> +	/*
> +	 * Rising thresholds are not supported on Exynosautov920.
> +	 * We use polling instead.
> +	 */
> +}
> +
> +static void exynosautov920_tmu_disable_low(struct exynos_tmu_data *data)
> +{
> +	/* Again, this is handled by polling. */
> +}
> +
> +static void exynosautov920_tmu_disable_high(struct exynos_tmu_data *data)
> +{
> +	/* Again, this is handled by polling. */
> +}

The driver would deserve some cleanups. Instead of having empty 
callbacks, check in exynos_set_trips() if the ops is !NULL. Then remove 
all no-op ops.

> +static void exynosautov920_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
> +{
> +	unsigned int idx;
> +
> +	for (idx = 0; idx < data->sensor_count; idx++) {
> +		if (!data->tzd_array[idx])
> +			continue;
> +
> +		exynos_tmu_update_temp(data, EXYNOSAUTOV920_TMU_REG_THRESHOLD(idx), 16, temp);
> +		exynos_tmu_update_bit(data, EXYNOSAUTOV920_TMU_REG_INTEN(idx), 7, true);
> +	}
> +}

There is something wrong in the driver design.

exynosautov920_tmu_set_crit_temp() is called from 
exynos_thermal_zone_configure() and the routine above sets the 
temperature on all the thermal zone while this one is retrieved from one 
thermal zone.

Which results in:

	for all tz do;
		for all tz do;
			if !tz then continue;
			set_crit_temp(tz)

No, this driver needs to be revisited and cleanup before sending changes 
for multiple sensors support.

What percentage of code sharing is there with the existing driver ?
> +static void exynosautov920_tmu_initialize(struct platform_device *pdev)
> +{
> +	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> +	unsigned int val;
> +
> +	data->tmu_control(pdev, false);
> +
> +	update_con_reg(data);
> +
> +	val = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> +	data->cal_type = TYPE_TWO_POINT_TRIMMING;
> +	data->slope_comp = (val >> EXYNOSAUTOV920_SLOPE_COMP) & EXYNOSAUTOV920_SLOPE_COMP_MASK;
> +
> +	val = readl(data->base + EXYNOSAUTOV920_SENSOR0_TRIM_INFO);
> +	data->temp_error1 = (val >> EXYNOSAUTOV920_TRIMINFO_25_SHIFT) & EXYNOSAUTOV920_TRIM_MASK;
> +	data->temp_error2 = (val >> EXYNOSAUTOV920_TRIMINFO_85_SHIFT) & EXYNOSAUTOV920_TRIM_MASK;
> +
> +	val = readl(data->base + EXYNOSAUTOV920_TMU_REG_TRIMINFO2);
> +	val = (val >> EXYNOSAUTOV920_CALIB_SEL_TEMP) & EXYNOSAUTOV920_CALIB_SEL_TEMP_MASK;
> +
> +	data->calib_temp = (EXYNOS_SECOND_POINT_TRIM + (20 * val));
> +}
> +

This is unreadable; please make it understandable for those who don’t 
have the documentation (explicit static inline functions, comments, etc 
...).

>   static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
>   {
>   	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> @@ -633,6 +799,24 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
>   	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
>   }
>   
> +static void exynosautov920_tmu_control(struct platform_device *pdev, bool on)
> +{
> +	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> +	unsigned int con;
> +
> +	con = readl(data->base + EXYNOSAUTOV920_TMU_REG_CONTROL);
> +
> +	if (on) {
> +		con |= BIT(EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
> +		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
> +	} else {
> +		con &= ~BIT(EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
> +		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
> +	}
> +
> +	writel(con, data->base + EXYNOSAUTOV920_TMU_REG_CONTROL);
> +}

Document a bit the code please.

>   static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
>   {
>   	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
> @@ -671,7 +855,7 @@ static u32 get_emul_con_reg(struct exynos_tmu_data *data, unsigned int val,
>   
>   		val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
>   		val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
> -		if (data->soc == SOC_ARCH_EXYNOS7) {
> +		if (data->soc == SOC_ARCH_EXYNOS7 || data->soc == SOC_ARCH_EXYNOSAUTOV920) {
>   			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
>   				EXYNOS7_EMUL_DATA_SHIFT);
>   			val |= (temp_to_code(data, temp) <<
> @@ -703,6 +887,8 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
>   		emul_con = EXYNOS5433_TMU_EMUL_CON;
>   	else if (data->soc == SOC_ARCH_EXYNOS7)
>   		emul_con = EXYNOS7_TMU_REG_EMUL_CON;
> +	else if (data->soc == SOC_ARCH_EXYNOSAUTOV920)
> +		emul_con = EXYNOSAUTOV920_TMU_REG_EMUL_CON;
>   	else
>   		emul_con = EXYNOS_EMUL_CON;
>   
> @@ -756,11 +942,23 @@ static int exynos7_tmu_read(struct exynos_tmu_data *data)
>   		EXYNOS7_TMU_TEMP_MASK;
>   }
>   
> +static int exynosautov920_tmu_read(struct exynos_tmu_data *data)
> +{
> +	return readw(data->base + EXYNOSAUTOV920_CURRENT_TEMP_P1_P0) &
> +		EXYNOS7_TMU_TEMP_MASK;
> +}
> +
>   static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
>   {
>   	struct exynos_tmu_data *data = id;
> +	int idx;
>   
> -	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
> +	for (idx = 0; idx < data->sensor_count; idx++) {
> +		if (!data->tzd_array[idx])
> +			continue;
> +
> +		thermal_zone_device_update(data->tzd_array[idx], THERMAL_EVENT_UNSPECIFIED);
I understand the main reason is to keep a common isr but you should 
*not* update all the thermal zones. There is an amount of processing 
behind this function adding a significant overhead.

So somehow readl(data->base + EXYNOSAUTOV920_TMU_REG_INT_PEND(idx)); 
should be used here to know if the thermal zone has to be updated or not.

> +	}
>   
>   	mutex_lock(&data->lock);
>   	clk_enable(data->clk);
> @@ -805,6 +1003,19 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
>   	writel(val_irq, data->base + tmu_intclear);
>   }
>   
> +static void exynosautov920_tmu_clear_irqs(struct exynos_tmu_data *data)
> +{
> +	unsigned int idx, val_irq;
> +
> +	for (idx = 0; idx < data->sensor_count; idx++) {
> +		if (!data->tzd_array[idx])
> +			continue;
> +
> +		val_irq = readl(data->base + EXYNOSAUTOV920_TMU_REG_INT_PEND(idx));
> +		writel(val_irq, data->base + EXYNOSAUTOV920_TMU_REG_INT_PEND(idx));
> +	}
> +}
> +
>   static const struct of_device_id exynos_tmu_match[] = {
>   	{
>   		.compatible = "samsung,exynos3250-tmu",
> @@ -833,6 +1044,9 @@ static const struct of_device_id exynos_tmu_match[] = {
>   	}, {
>   		.compatible = "samsung,exynos7-tmu",
>   		.data = (const void *)SOC_ARCH_EXYNOS7,
> +	}, {
> +		.compatible = "samsung,exynosautov920-tmu",
> +		.data = (const void *)SOC_ARCH_EXYNOSAUTOV920,

Time to do cleanups in the driver. Use at your advantage the .data to 
store the relevant info instead of a awful else-if in the different 
functions above.

>   	},
>   	{ },
>   };
> @@ -865,6 +1079,10 @@ static int exynos_map_dt_data(struct platform_device *pdev)
>   
>   	data->soc = (uintptr_t)of_device_get_match_data(&pdev->dev);
>   
> +	data->sensor_count = EXYNOS_DEFAULT_SENSOR_COUNT;
> +
> +	data->calib_temp = EXYNOS_SECOND_POINT_TRIM;
> +
>   	switch (data->soc) {
>   	case SOC_ARCH_EXYNOS4210:
>   		data->tmu_set_low_temp = exynos4210_tmu_set_low_temp;
> @@ -945,6 +1163,19 @@ static int exynos_map_dt_data(struct platform_device *pdev)
>   		data->min_efuse_value = 15;
>   		data->max_efuse_value = 100;
>   		break;
> +	case SOC_ARCH_EXYNOSAUTOV920:
> +		data->tmu_set_low_temp = exynosautov920_tmu_set_low_temp;
> +		data->tmu_set_high_temp = exynosautov920_tmu_set_high_temp;
> +		data->tmu_disable_low = exynosautov920_tmu_disable_low;
> +		data->tmu_disable_high = exynosautov920_tmu_disable_high;
> +		data->tmu_set_crit_temp = exynosautov920_tmu_set_crit_temp;
> +		data->tmu_initialize = exynosautov920_tmu_initialize;
> +		data->tmu_control = exynosautov920_tmu_control;
> +		data->tmu_read = exynosautov920_tmu_read;
> +		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
> +		data->tmu_clear_irqs = exynosautov920_tmu_clear_irqs;
> +		data->sensor_count = EXYNOS_MAX_SENSOR_COUNT;
> +		break;

Same comment as above.

>   	default:
>   		dev_err(&pdev->dev, "Platform not supported\n");
>   		return -EINVAL;
> @@ -952,6 +1183,14 @@ static int exynos_map_dt_data(struct platform_device *pdev)
>   
>   	data->cal_type = TYPE_ONE_POINT_TRIMMING;
>   
> +	if (data->soc == SOC_ARCH_EXYNOSAUTOV920) {
> +		if (of_property_read_u32(pdev->dev.of_node, "samsung,sensors",
> +					 &data->sensor_count)) {
> +			dev_err(&pdev->dev, "failed to get sensor count\n");
> +			return -ENODEV;
> +		}
> +	}
> +
>   	/*
>   	 * Check if the TMU shares some registers and then try to map the
>   	 * memory of common registers.
> @@ -1006,7 +1245,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct exynos_tmu_data *data;
> -	int ret;
> +	struct thermal_zone_device *tzd;
> +	int ret, idx;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
> @@ -1084,11 +1324,19 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>   		goto err_sclk;
>   	}
>   
> -	data->tzd = devm_thermal_of_zone_register(dev, 0, data,
> -						  &exynos_sensor_ops);
> -	if (IS_ERR(data->tzd)) {
> -		ret = dev_err_probe(dev, PTR_ERR(data->tzd), "Failed to register sensor\n");
> -		goto err_sclk;
> +	for (idx = 0; idx < data->sensor_count; idx++) {
> +		tzd = devm_thermal_of_zone_register(dev, idx, data, &exynos_sensor_ops);
> +
> +		if (IS_ERR(tzd)) {
> +			if (PTR_ERR(tzd) == -ENODEV)
> +				continue;
> +
> +			ret = dev_err_probe(dev, PTR_ERR(data->tzd_array[idx]),
> +					    "Failed to register sensor\n");
> +			goto err_sclk;
> +		}
> +
> +		data->tzd_array[idx] = tzd;
>   	}
>   
>   	ret = exynos_thermal_zone_configure(pdev);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

