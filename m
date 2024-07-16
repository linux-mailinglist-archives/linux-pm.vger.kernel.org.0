Return-Path: <linux-pm+bounces-11172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CD8932E84
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3DBCB2250D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877112E3E8;
	Tue, 16 Jul 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1przt+l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47771DFD1;
	Tue, 16 Jul 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148331; cv=none; b=Lm3SlkQGfA2HrwBeqdYBpo89QYnMNi+eighYtsZig/WHxHSym4Ell6eujp0iktSiw9Eu/XB6C920xt4ivIe008m/GoWpiS4fyMDg0JV7oAN/r5nL8cDqhyBKr5bA1Kc9ddVxstT+SsTYyVY/7dneSmmge+Yn0TCer+zz2tZ78ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148331; c=relaxed/simple;
	bh=iHGif9KoNVl1Xcs8o5LKsXw8G/zYXCSN/ConyahnGpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ0rk8nEELjoDsAbzG3VwPL3PvH2A2Kw6zHbRR3SK8AgTmthg3Lnyhf+fRJJ/rlVp/u+TNQG/Zu3r9PwUOqgheH1tFI6dcu/vir6/YwqbNEjQrynlMfmD2EvTN3VB67c7tNQIW6v8tNL1NIeD966E6VBMa6mkzv3F0ST5bHAcI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1przt+l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4272738eb9eso42695135e9.3;
        Tue, 16 Jul 2024 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721148328; x=1721753128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50Q7bLhb5pI/OfvvmK74KWMk9NSGzK3vz/37rCx6kjc=;
        b=c1przt+lDbeJO9QuPPeusWCbjDBXcbLqmzmkFEm/gj5LkPYNErcLohd2udgtySj1Rd
         etQ8i6BS1QH509B8dLjhGwFr2NRZvBbOX4myOGwgOPXHCC+p0m1/AFpv347N7IUiD8/k
         Wknzi9ebXKv6PxsJL8c/6m+d6xaKoCpEb8bkwhBPTNgjVBKsZgBBAaR2vpkYCQkkfCmu
         95SrxVxAcN/qw5ybBBPxpuoy5AxyoLkZRcrHiWQ98muY99a+J9Sbo73IgiMC5zz/pn+C
         WCyL5qAmhm9Leh/JFWOEDcsWNKowd3d24jZO6M4naYTLKYp0bDqtB/6AO8rm/sohBgv2
         /jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721148328; x=1721753128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50Q7bLhb5pI/OfvvmK74KWMk9NSGzK3vz/37rCx6kjc=;
        b=AO4QwfnPKA9Y8S7D3aq9LUol/cXcw6keeASaKbf5zXtbmDrEqTpduYe5vo1DoHG/Gc
         fDlKJ3+5uygM2Llv7a0DHWGNeKSp+ur4VMkOuK2+BLMUhCkOBn4wzM8kyZrCS+zfG+1/
         wIKtT9N6K3YBm7UYizScqCOfvq0exzVt/WEN9Dzg+GrL6568sSVyAvdEMioOPHHv9KlG
         fuiO0Ag6oQGhH9b71FUbRbVRPkGVXOMjSJLHPaalScBni+3F16ho7W3uXALH2zB14OyG
         LYxoxyE6BXDPEA+0dxka+bLQZSLz0Q07Xer+WLOrwPIJBanHj01TiMWrPqtqrgNLPX1/
         mnBg==
X-Forwarded-Encrypted: i=1; AJvYcCVddNLHpKMOE7mrzVCqEBq649qegE7vVdFCUlf3VHTGr/8f/kv9KN8UgjAFgXQhO74PGwqzSavgPbh5CR7rB1A7HnxN+Ik4NwFVUMXRDMza2hrd1e5aaB/RW2s5zS/5oH1iEcp9WEQZ9A==
X-Gm-Message-State: AOJu0Yz7NflscWXDL0/dsEAX5udTUh9B5agF2rOFBbv7dqx5W4cKhjLT
	vyGp9KRYNFq+pER84IKre1rrX6U6O841RBgN94OMONnSPOFzAjtS
X-Google-Smtp-Source: AGHT+IF+rJaQWuy8Q5qFgVkGLfaxPqUmmetwr9fjqPSEQWcUmokIAeXlBVz3FtS+xqGT1oQHZnITaw==
X-Received: by 2002:a05:600c:2218:b0:427:985b:178b with SMTP id 5b1f17b1804b1-427ba690fc1mr18681335e9.16.1721148327400;
        Tue, 16 Jul 2024 09:45:27 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e983dbsm133978275e9.24.2024.07.16.09.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 09:45:27 -0700 (PDT)
Message-ID: <9b3a619f-cfe3-4fbc-a7c2-a2457a3923a6@gmail.com>
Date: Tue, 16 Jul 2024 18:45:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] thermal: sti: depend on THERMAL_OF subsystem
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20240714-thermal-v3-0-88f2489ef7d5@gmail.com>
 <20240714-thermal-v3-2-88f2489ef7d5@gmail.com>
 <046303cd-54d0-42f0-990d-2d18a9de1f3e@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <046303cd-54d0-42f0-990d-2d18a9de1f3e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/07/2024 à 15:07, Daniel Lezcano a écrit :
> On 14/07/2024 13:42, Raphael Gallais-Pou wrote:
>> Switch to thermal_of_zone to handle thermal-zones. Replace
>> thermal_zone_device_register() by devm_thermal_of_zone_register() and
>> remove ops st_thermal_get_trip_type, st_thermal_get_trip_temp.
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>> Changes in v3:
>> - Fix unmet dependency when building with ARM64 compiler
>>    https://lore.kernel.org/lkml/202406270605.qodaWd4n-lkp@intel.com/
>> - Remove no more used polling_delay variable detected by kernel robot
>>    https://lore.kernel.org/lkml/202406270530.kN5wIswi-lkp@intel.com/
>> Changes in v2:
>> - Remove unused struct thermal_trip trip
>> ---
>>   drivers/thermal/st/Kconfig      |  2 ++
>>   drivers/thermal/st/st_thermal.c | 28 ++++++++++------------------
>>   2 files changed, 12 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/thermal/st/Kconfig b/drivers/thermal/st/Kconfig
>> index ecbdf4ef00f4..95a634709a99 100644
>> --- a/drivers/thermal/st/Kconfig
>> +++ b/drivers/thermal/st/Kconfig
>> @@ -5,12 +5,14 @@
>>   config ST_THERMAL
>>       tristate "Thermal sensors on STMicroelectronics STi series of SoCs"
>> +    depends on THERMAL_OF
>>       help
>>         Support for thermal sensors on STMicroelectronics STi series 
>> of SoCs.
>>   config ST_THERMAL_MEMMAP
>>       select ST_THERMAL
>>       tristate "STi series memory mapped access based thermal sensors"
>> +    depends on THERMAL_OF
> 
> Given the changes below it is possible to move this dependency in the 
> upper Kconfig AFAICS:
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index ed16897584b4..b6b916e7e294 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -429,7 +429,7 @@ source "drivers/thermal/samsung/Kconfig"
>   endmenu
> 
>   menu "STMicroelectronics thermal drivers"
> -depends on (ARCH_STI || ARCH_STM32) && OF
> +depends on (ARCH_STI || ARCH_STM32) && THERMAL_OF
>   source "drivers/thermal/st/Kconfig"
>   endmenu
> 
> THERMAL_OF depends on OF

Hi Daniel,

Thanks for your review.

Indeed, it makes more sense. I'll change this and remove the "depends on 
THERMAL_OF" on st/ level.
> 
>>   config STM32_THERMAL
>>       tristate "Thermal framework support on STMicroelectronics STM32 
>> series of SoCs"
>> diff --git a/drivers/thermal/st/st_thermal.c 
>> b/drivers/thermal/st/st_thermal.c
>> index 5f33543a3a54..23597819ce84 100644
>> --- a/drivers/thermal/st/st_thermal.c
>> +++ b/drivers/thermal/st/st_thermal.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/of_device.h>
>>   #include "st_thermal.h"
>> +#include "../thermal_hwmon.h"
>>   /* The Thermal Framework expects millidegrees */
>>   #define mcelsius(temp)            ((temp) * 1000)
>> @@ -135,8 +136,6 @@ static struct thermal_zone_device_ops st_tz_ops = {
>>       .get_temp    = st_thermal_get_temp,
>>   };
>> -static struct thermal_trip trip;
>> -
>>   int st_thermal_register(struct platform_device *pdev,
>>               const struct of_device_id *st_thermal_of_match)
>>   {
>> @@ -145,7 +144,6 @@ int st_thermal_register(struct platform_device *pdev,
>>       struct device_node *np = dev->of_node;
>>       const struct of_device_id *match;
>> -    int polling_delay;
>>       int ret;
>>       if (!np) {
>> @@ -197,29 +195,22 @@ int st_thermal_register(struct platform_device 
>> *pdev,
>>       if (ret)
>>           goto sensor_off;
>> -    polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
>> -
>> -    trip.temperature = sensor->cdata->crit_temp;
>> -    trip.type = THERMAL_TRIP_CRITICAL;
>> -
>>       sensor->thermal_dev =
>> -        thermal_zone_device_register_with_trips(dev_name(dev), &trip, 
>> 1, sensor,
>> -                            &st_tz_ops, NULL, 0, polling_delay);
>> +        devm_thermal_of_zone_register(dev, 0, sensor, &st_tz_ops);
>>       if (IS_ERR(sensor->thermal_dev)) {
>> -        dev_err(dev, "failed to register thermal zone device\n");
>> +        dev_err(dev, "failed to register thermal of zone\n");
>>           ret = PTR_ERR(sensor->thermal_dev);
>>           goto sensor_off;
>>       }
>> -    ret = thermal_zone_device_enable(sensor->thermal_dev);
>> -    if (ret)
>> -        goto tzd_unregister;
>>       platform_set_drvdata(pdev, sensor);
>> -    return 0;
>> +    /*
>> +     * devm_thermal_of_zone_register() doesn't enable hwmon by default
>> +     * Enable it here
>> +     */
>> +    return devm_thermal_add_hwmon_sysfs(dev, sensor->thermal_dev);
> 
> Other drivers ignore the return code or just print a message in case it 
> is not zero. Otherwise, that makes the thermal driver to fail because of 
> hwmon.

Indeed. I figured that since an error code is yielded only by hwmon when 
it fails, it seems logical to make the thermal driver fail as well since 
it depends on hwmon. Maybe I understood something wrong.

Does tying thermal to hwmon is a bad practice ?

Regards,
Raphaël
> 
>> -tzd_unregister:
>> -    thermal_zone_device_unregister(sensor->thermal_dev);
>>   sensor_off:
>>       st_thermal_sensor_off(sensor);
>> @@ -232,7 +223,8 @@ void st_thermal_unregister(struct platform_device 
>> *pdev)
>>       struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
>>       st_thermal_sensor_off(sensor);
>> -    thermal_zone_device_unregister(sensor->thermal_dev);
>> +    thermal_remove_hwmon_sysfs(sensor->thermal_dev);
>> +    devm_thermal_of_zone_unregister(sensor->dev, sensor->thermal_dev);
>>   }
>>   EXPORT_SYMBOL_GPL(st_thermal_unregister);
>>
> 

