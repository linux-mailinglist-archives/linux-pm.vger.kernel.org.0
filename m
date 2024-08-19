Return-Path: <linux-pm+bounces-12420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CB2956894
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 12:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0476C1C209C2
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CFB1607AB;
	Mon, 19 Aug 2024 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK5SmFTx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B1115B15D
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063588; cv=none; b=qdDViBPW6dq+IgxuAvkutJ7T0eJqUIVk3vJsqQ7186noSz32rEg4zZvpcbs8gLrc+ba2n5ojpNJDu/WSS3sX5t+ahuqzKopPQg8UPJQWscx1yek+IdKq/NHge9040TiwU+0gspxZapfq5CoPOBlegD8NHdKu0fG8n+oMadIY3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063588; c=relaxed/simple;
	bh=WH0SKGJtO9gQRroBEoluyMAsBfs2VxCFcLR7XJcVrII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDOnf3HpL+n7rRAOO/IED1VCCKgOGmBXZF5sOnc1y2Cqb0ZyAr0cWOyYPf9hCzJzEiXx6CIOAuZLhn4c4Gjzvjspq5MbokxiJhsAYgKC/vVp97ckRY9x95VgXpOMxZp+9bOT0rdB8o+vw5ap4NAGWIU20TMMCyTv9pXP5s+ur2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GK5SmFTx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so31074465e9.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 03:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724063585; x=1724668385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1eZipzj07GzNWdtg8hKnzIybeawRK/Zart5hRuTPhrs=;
        b=GK5SmFTxr7mtjuWYbnT0araa+5L7mQZH6vkkAXjNcZR2q4RqK7WM35mDwKkF9j7GqX
         jVdwoNQ5LoPZ9FQfhBnunW239HJQTDEPSIE07AwDljaX7tAFdYGCBA+YVXeKpyR7o9SK
         3KQBOJytYD1pXKbmy/YQUpHaITnFjLYWbc5TlpC+NICP+bq2UhBZxVCfTeBnSBreFJ5S
         9aXP/ArR4q0/jzhK3eSEnk9R8c0og+3kAUGu+iw6FrVNJLtCrDHetBJFbt/Ago3hAG0E
         q9XWX5mx3BKymvADpxBCfJ9JDIbpUgFwqXlkl1+v4BN0zML0+ka3X22z9ptLuc0mqYPd
         cjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063585; x=1724668385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eZipzj07GzNWdtg8hKnzIybeawRK/Zart5hRuTPhrs=;
        b=dgrRhKLZ1rdFT3MUUHB1dvcB6jyKzH0DxJQec9sjpbg2uhIwj9P5sNS9mKp8CtVzGK
         Kqgt6bJWR3Qd07WIK+0K2Altb53WoTdn6PH+tjVztQWc9BGVnumqF45OX9tmm3Nep9pT
         Uvg+aGC+Pt3JjpNAvzB9ovcaSDN9Qn4AsDLYxz3lkLuprBi4larNdKARnhEtAaG8c3Rp
         l7AVcClKw2b705Nt9do5SFVjsCEXBpW3Qkrvr2ZCgXg7WGq0MrLgKtp4N2yxBINSgP1J
         7bGajl4MNHbTQYCogEbsDJe4wc6cA/n+0YRpb5eR1V4QHy5Ag203O0/1kktHGZt6Ajjq
         nO9A==
X-Gm-Message-State: AOJu0YxvBOxrYOXsoIlrunMuqk7CIMFfn9Ly5to7l344RhWNNIF52kMc
	5r5K0gNkbFqtncLfUIMd36SiedvJJfmusuRBdVwu6leiLsFzSD+mvdnr5JQbbXU=
X-Google-Smtp-Source: AGHT+IExoZjz8aVKSxb4A/yodmwISVWDZie6lXaITvz4XBbczkl3kuP0YehMESEgRBdiWHoMBZTO1Q==
X-Received: by 2002:a05:600c:4ed3:b0:426:6000:565a with SMTP id 5b1f17b1804b1-429ed7bb030mr62815185e9.16.1724063584418;
        Mon, 19 Aug 2024 03:33:04 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ed794739sm103913605e9.43.2024.08.19.03.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 03:33:03 -0700 (PDT)
Message-ID: <66f3361b-00f8-4527-aaa8-d1c302c8ea26@linaro.org>
Date: Mon, 19 Aug 2024 12:33:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] thermal/drivers/mediatek: add another get_temp ops
 for thermal sensors
To: Hsin-Te Yuan <yuanhsinte@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 James Lo <james.lo@mediatek.com>, Michael Kao <michael.kao@mediatek.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Ben Tseng <ben.tseng@mediatek.com>
References: <20240809-auxadc_thermal-v11-1-af36cc74f3a3@chromium.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240809-auxadc_thermal-v11-1-af36cc74f3a3@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/08/2024 10:44, Hsin-Te Yuan wrote:
> From: James Lo <james.lo@mediatek.com>
> 
> Provide thermal zone to read thermal sensor
> in the SoC. We can read all the thermal sensors
> value in the SoC by the node /sys/class/thermal/

Please elaborate a bit more the description to stick to the changes.

What is the difference between MT8183 Kukui devices and older ones, for 
instance ?

> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: James Lo <james.lo@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Resurrecting this patch specifically for MediaTek MT8183 Kukui devices.
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
>   drivers/thermal/mediatek/auxadc_thermal.c | 71 +++++++++++++++++++++++++++----
>   1 file changed, 63 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index 9ee2e7283435..8b50d560bbf9 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -847,7 +847,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   
>   static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>   {
> -	struct mtk_thermal *mt = thermal_zone_device_priv(tz);
> +	struct mtk_thermal_bank *bank = thermal_zone_device_priv(tz);
> +	struct mtk_thermal *mt = bank->mt;

Where is used this variable ?

>   	int i;
>   	int tempmax = INT_MIN;
>   
> @@ -866,10 +867,46 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
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
> +	if (id < 0)
> +		return  -EACCES;

This test should not be done here:

1. EACCES is permission denied

2. The bank id should be checked at init time

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
> +	if (!mtk_thermal_temp_is_valid(temp)) {

unlikely(!mtk_thermal_temp_is_valid(temp)) ?

> +		temp = THERMAL_TEMP_INVALID;

What is the point of assigning this value and return just after ?

> +		return -EAGAIN;
> +	}
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
> @@ -1199,6 +1236,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   	u64 auxadc_phys_base, apmixed_phys_base;
>   	struct thermal_zone_device *tzdev;
>   	void __iomem *apmixed_base, *auxadc_base;
> +	struct mtk_thermal_bank *tz;
>   
>   	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>   	if (!mt)
> @@ -1285,14 +1323,31 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
>   					      auxadc_phys_base, ctrl_id);
>   
> -	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
> -					      &mtk_thermal_ops);
> -	if (IS_ERR(tzdev))
> -		return PTR_ERR(tzdev);
> +	for (i = 0; i < mt->conf->num_sensors + 1; i++) {

Why "num_sensors + 1" ?

> +		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> +		if (!tz)
> +			return -ENOMEM;
> +
> +		tz->mt = mt;
> +		tz->id = i;
> +
> +		tzdev = devm_thermal_of_zone_register(&pdev->dev, i,
> +				tz, (i == 0) ?
> +				&mtk_thermal_ops : &mtk_thermal_sensor_ops);

Don't you want to keep the init routine and depending on the platform 
add the loop with the extra sensors ? That may help to make the code 
cleaner instead of doing tests like (i == 0) ? &mtk_thermal_ops : 
&mtk_thermal_sensor_ops

> +		if (IS_ERR(tzdev)) {
> +			if (PTR_ERR(tzdev) == -ENODEV) {
> +				dev_warn(&pdev->dev, "can't find thermal sensor %d\n", i);
> +				continue;
> +			}
> +			if (PTR_ERR(tzdev) != -EACCES)

The id correctness should be checked in this loop, not rely on a EACCES 
returned by a implicit call to thermal_zone_get_temp()

> +				return PTR_ERR(tzdev);
> +		}
>   
> -	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> -	if (ret)
> -		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> +		ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> +		if (ret)
> +			dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs: %d\n", ret);
> +	}
>   
>   	return 0;
>   }
> 
> ---
> base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
> change-id: 20240809-auxadc_thermal-9be338ec8b1c
> 
> Best regards,


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

