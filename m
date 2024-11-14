Return-Path: <linux-pm+bounces-17567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB39C9016
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C0228111A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6D183CBB;
	Thu, 14 Nov 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbB7khVa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B032BD1D
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602898; cv=none; b=PM4qFqB0cfjq7gYDxKBT89tbuYLuADW1FHpltm4lqMkFBz3oH4sYYcGVMeBEeFj9GsvC01tYXER5DW7uZIKjrq33IA0lI7gDauCZm991Gex/XBgtUF3rBy6vMo+flD6A0Cz5fAXokM21XhJx9pToVOPCEQ3uiF8l//FqalUbOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602898; c=relaxed/simple;
	bh=UVzoHI+wabD4U8U9PM+ChMCkwvnkr3CGkvqkrbqMG8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAs2ewC85fwkb8Vo9ZdZwaJFOlUHYaReNr0z/mxX+b19QcsmpTZBUu9NjoCxgxJTIaxM4ktH/4GntPbmUqnt6iWzoq+4tQT5w6bAgGoSCeCHRrU3zQIHNDVn0EWctKaYmCk8kAlKqlSymQfdDF6R7WC/dncqD9EB2K3t9RfDYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tbB7khVa; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d518f9abcso600660f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731602895; x=1732207695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ealwXs685A+zK5u5kLK86p59/a8hIners/cLaM399gU=;
        b=tbB7khVaCNQXf34Aa8ZNI+wvonmdyuFr2562+H3E+IW8Ahqwh89L7FBz8n730tbG8l
         I95syRFtyhua5a78WGGcsDarogD8Fsd8UkiUd6w5I+W1P8z2XRGpYT+IohzZTI4B/DDC
         QOjqWnzKuwnCABUUza3ouzHO6tsvRL9paLH+7l2sQsm3zruowZ6N1EaZSLES2jfxyW4U
         5/CH27w6/qw4NMBb6qgZbxo9817VmAWfFoOdh67PVbxGQpq0gqlkNuzBjGYXeYRVTpwc
         RZBlMWvxH5Mw4MJYNUokCFJ5l4nQf5UfHdsDzR/jZNfA+A8Cxou92lJiKqVY3K9XTJ9S
         CaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602895; x=1732207695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ealwXs685A+zK5u5kLK86p59/a8hIners/cLaM399gU=;
        b=YQpklWdxQIIcasGfT+GK6+VEZtAERuTKRipFg1E48WAGjG0Ab1rxetUk0ntr4X5GYE
         DpActwPoq0U65YWv1M8jOW1W3q/FmBkWGLIivW/nUZAAKhDbXpIdSZUXR/DIyVKaLoaz
         Tb3QGLYJiP/7aNBTx9dec/SuFjoXvyrPCdm151IQoLlVaWNF8HD8189KvGjaEagCQZe9
         0BBCBHR+Bpsu3PkaJfad13KvYSSZDWXZ7RWOmjM9lN7SYi8DcvA7Lnm63ivXyKw9HO6g
         f6EEtJuKMAR1j4kwMsKU8GYRjfZzMrklfelJRLicmtlMtuKil2nhccH1debnedUF3YrH
         U8qQ==
X-Gm-Message-State: AOJu0YwsZ+DO+CEdYFq1H+O2HxnHl0PnbJvihocadpz0qbEnNHdsewKQ
	8gJg3pJtEPPY74Vpw/o+6Tkwye/Nkv7EjwEjKbBvIsqfurlP3YqQHRSHY4GXJiQ=
X-Google-Smtp-Source: AGHT+IFY8H5SgkG88VtbSy4kDvEfqE/tRQqcxDt4UhQNvLRP81KqjYrY5H5jsgGdVrIr0/hEpuWb/Q==
X-Received: by 2002:a05:6000:2c2:b0:37d:633a:b361 with SMTP id ffacd0b85a97d-381f188c996mr20281965f8f.51.1731602894641;
        Thu, 14 Nov 2024 08:48:14 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-382221845c7sm734913f8f.107.2024.11.14.08.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 08:48:14 -0800 (PST)
Message-ID: <5dd2d2a3-6eff-45fb-8af8-593945235dd3@linaro.org>
Date: Thu, 14 Nov 2024 17:48:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] thermal/drivers/mediatek/auxadc_thermal: expose all
 thermal sensors
To: Hsin-Te Yuan <yuanhsinte@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 James Lo <james.lo@mediatek.com>, Michael Kao <michael.kao@mediatek.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Ben Tseng <ben.tseng@mediatek.com>
References: <20241025-auxadc_thermal-v14-1-96ab5b60c02e@chromium.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241025-auxadc_thermal-v14-1-96ab5b60c02e@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

On 25/10/2024 14:05, Hsin-Te Yuan wrote:
> From: James Lo <james.lo@mediatek.com>
> 
> Previously, the driver only supported reading the temperature from all
> sensors and returning the maximum value. This update adds another
> get_temp ops to support reading the temperature from each sensor
> separately.
> 
> Especially, some thermal zones registered by this patch are needed by
> MT8183 since those thermal zones are necessary for mtk-svs driver.

The DT for the mt8183 describes the sensor id = 0 as the CPU. On this, 
there is a cooling device with trip points.

The driver registers the id=0 as an aggregator for the sensors which 
overloads the CPU thermal zone above.

Why do you need to aggregate all the sensors to retrieve the max value ?

They are all contributing differently to the heat and they should be 
tied with their proper cooling device.

I don't think the thermal configuration is correct and I suggest to fix 
this aggregator by removing it.



> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: James Lo <james.lo@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v14:
> - Remove redundant error message.
> - Link to v13: https://lore.kernel.org/r/20241025-auxadc_thermal-v13-1-a5231c52dccb@chromium.org
> 
> Changes in v13:
> - Make subject and commit message more clear.
> - Make error message more clear.
> - Link to v12: https://lore.kernel.org/r/20241016-auxadc_thermal-v12-1-c0433e9f61af@chromium.org
> 
> Changes in v12:
> - Remove unnecessary check and unused variable assignment in mtk_read_sensor_temp.
> - Add more about what this patch achieves in the commit message.
> - Link to v11: https://lore.kernel.org/r/20240809-auxadc_thermal-v11-1-af36cc74f3a3@chromium.org
> 
> Changes in V11:
>      - Rebase on kernel v6.11-rc2
>      - Use mtk_thermal_temp_is_valid in mtk_read_sensor_temp just like
>        mtk_thermal_bank_temperature
>      - Change the error handling of devm_thermal_of_zone_register return
>        value
>      - link to V10: https://lore.kernel.org/lkml/20220519101044.16765-1-james.lo@mediatek.com/
> 
> Changes in V10:
>      - Rebase to kernel-v5.18-rc7
>      - Resend
> 
> Changes in V9:
>      - Rebase to kernel-v5.14-rc1
>      - Bind raw_to_mcelsius_v1 or raw_to_mcelsius_v2 to compatible
>        data of struct mtk_thermal_data
>      - Remove duplicate struct 'mtk_thermal_bank'
>      - Remove unnecessary if condition check
>      - Return error if any thermal zone fail to register
> 
> Changes in V8:
>      - Rebase to kernel-v5.13-rc1
>      - Resend
> 
> Changes in v7:
>      - Fix build error in v6.
> 
> Changes in v6:
>      - Rebase to kernel-5.11-rc1.
>      - [1/3]
>          - add interrupts property.
>      - [2/3]
>          - add the Tested-by in the commit message.
>      - [3/3]
>          - use the mt->conf->msr[id] instead of conf->msr[id] in the
>            _get_sensor_temp and mtk_thermal_bank_temperature.
>          - remove the redundant space in _get_sensor_temp and
>            mtk_read_sensor_temp.
>          - change kmalloc to dev_kmalloc in mtk_thermal_probe.
> 
> Changes in v5:
>      - Rebase to kernel-5.9-rc1.
>      - Revise the title of cover letter.
>      - Drop "[v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESEL"
>      - [2/2]
>          -  Add the judgement to the version of raw_to_mcelsius.
> 
> Changes in v4:
>      - Rebase to kernel-5.6-rc1.
>      - [1/7]
>          - Squash thermal zone settings in the dtsi from [v3,5/8]
>            arm64: dts: mt8183: Increase polling frequency for CPU thermal zone.
>          - Remove the property of interrupts and mediatek,hw-reset-temp.
>      - [2/7]
>          - Correct commit message.
>      - [4/7]
>          - Change the target temperature to the 80C and change the commit message.
>      - [6/7]
>          - Adjust newline alignment.
>          - Fix the judgement on the return value of registering thermal zone.
> 
> Changes in v3:
>      - Rebase to kernel-5.5-rc1.
>      - [1/8]
>          - Update sustainable power of cpu, tzts1~5 and tztsABB.
>      - [7/8]
>          - Bypass the failure that non cpu_thermal sensor is not find in thermal-zones
>            in dts, which is normal for mt8173, so prompt a warning here instead of
>            failing.
> 
>      Return -EAGAIN instead of -EACCESS on the first read of sensor that
>          often are bogus values. This can avoid following warning on boot:
> 
>            thermal thermal_zone6: failed to read out thermal zone (-13)
> 
> Changes in v2:
>      - [1/8]
>          - Add the sustainable-power,trips,cooling-maps to the tzts1~tztsABB.
>      - [4/8]
>          - Add the min opp of cpu throttle.
> ---
> 
> ---
>   drivers/thermal/mediatek/auxadc_thermal.c | 70 +++++++++++++++++++++++++++----
>   1 file changed, 62 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index 9ee2e7283435acfcbb1a956303b6122a08affecc..9a9079d559a3abe9e3823f744d4c9a159a8666bd 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -847,7 +847,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   
>   static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>   {
> -	struct mtk_thermal *mt = thermal_zone_device_priv(tz);
> +	struct mtk_thermal_bank *bank = thermal_zone_device_priv(tz);
> +	struct mtk_thermal *mt = bank->mt;
>   	int i;
>   	int tempmax = INT_MIN;
>   
> @@ -866,10 +867,41 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>   	return 0;
>   }
>   
> +static int mtk_read_sensor_temp(struct thermal_zone_device *tz, int *temperature)
> +{
> +	struct mtk_thermal_bank *bank = thermal_zone_device_priv(tz);
> +	struct mtk_thermal *mt = bank->mt;
> +	const struct mtk_thermal_data *conf = mt->conf;
> +	int id = bank->id - 1;
> +	int temp = INT_MIN;
> +	u32 raw;
> +
> +	raw = readl(mt->thermal_base + conf->msr[id]);
> +
> +	temp = mt->raw_to_mcelsius(mt, id, raw);
> +
> +	/*
> +	 * The first read of a sensor often contains very high bogus
> +	 * temperature value. Filter these out so that the system does
> +	 * not immediately shut down.
> +	 */
> +
> +	if (unlikely(!mtk_thermal_temp_is_valid(temp)))
> +		return -EAGAIN;
> +
> +	*temperature = temp;
> +
> +	return 0;
> +}
> +
>   static const struct thermal_zone_device_ops mtk_thermal_ops = {
>   	.get_temp = mtk_read_temp,
>   };
>   
> +static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
> +	.get_temp = mtk_read_sensor_temp,
> +};
> +
>   static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>   				  u32 apmixed_phys_base, u32 auxadc_phys_base,
>   				  int ctrl_id)
> @@ -1199,6 +1231,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   	u64 auxadc_phys_base, apmixed_phys_base;
>   	struct thermal_zone_device *tzdev;
>   	void __iomem *apmixed_base, *auxadc_base;
> +	struct mtk_thermal_bank *tz;
>   
>   	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>   	if (!mt)
> @@ -1285,14 +1318,35 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
>   					      auxadc_phys_base, ctrl_id);
>   
> -	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
> -					      &mtk_thermal_ops);
> -	if (IS_ERR(tzdev))
> -		return PTR_ERR(tzdev);
> +	for (i = 0; i <= mt->conf->num_sensors; i++) {
> +		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> +		if (!tz)
> +			return -ENOMEM;
> +
> +		tz->mt = mt;
> +		tz->id = i;
> +
> +		tzdev = devm_thermal_of_zone_register(&pdev->dev, i,
> +						      tz, (i == 0) ?
> +						      &mtk_thermal_ops
> +						      : &mtk_thermal_sensor_ops);
> +
> +		if (IS_ERR(tzdev)) {
> +			ret = PTR_ERR(tzdev);
> +			if (ret == -ENODEV) {
> +				dev_warn(&pdev->dev,
> +					 "Can't find thermal zone for sensor %d; sensor skipped.\n", i);
> +				continue;
> +			}
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to register thermal zone %d.\n", i);
> +		}
>   
> -	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> -	if (ret)
> -		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> +		ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> +		if (ret)
> +			dev_warn(&pdev->dev,
> +				 "Sensor %d: Error in thermal_add_hwmon_sysfs: %d\n", i, ret);
> +	}
>   
>   	return 0;
>   }
> 
> ---
> base-commit: b589839414be04b2b37e4bf6f84af576c99faf64
> change-id: 20240809-auxadc_thermal-9be338ec8b1c
> 
> Best regards,


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

