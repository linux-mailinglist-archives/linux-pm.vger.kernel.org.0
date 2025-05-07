Return-Path: <linux-pm+bounces-26775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C15AAD811
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 09:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419DC1C216C2
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DEF21FF2B;
	Wed,  7 May 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqcX8HWj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C812135CB
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602971; cv=none; b=b7PuNrHG9OXdMOgwfSr4xlc1j2JjasSrW2uOYLWDwBRripUdpp5PHWB13jczcqWulD7WHj4tp+Gyo7yZSE2kPrFwV/lEosyNAdKgrUlFs0Iz5B80a3p+flx9wpl6DL4uMFSzz7SgbjINpJRu2BO8GjBApxlIw7FlPYhBHkSdfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602971; c=relaxed/simple;
	bh=3ofFTovtnJvX5M/xuhvl18Z0GfLNgQGP2MJvinEcTik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpeODfDuzNZ3dFOp5X7QPqpq2lI0rsNpX7mh+7Dbuv9E+Oan+gEtOHPZmnAjJjXmF3w23aOTHHG7jHJxucSa0H3alhKls8AQmPJ02g0BxpMsGtgXUAMKsVcQ42iSL4NWAFZqawl62D5TT9mOcOOCHogAmQK25rXPMSX6o46E3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqcX8HWj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1efc4577so3366319f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746602968; x=1747207768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exh3b5R7L77rlGB9XDLUTNFBk7LtXN6j6kHQ/wrFppg=;
        b=lqcX8HWjoX36WHrfdPUWIjNj0BPu4jxR/vDN0sjAWhBJQ7QMdXwwwRn20Na67XyaNs
         zHRWU9RdQEm52VDinC1WP3zhufhSSap2ix1APn4UVW706vlBGsTTSr7E1kOYi/Z0yrHb
         TTYmpP3N0NXBHnieEZKmqSuC9UsAvDTniQz82qqKpTkd+wKP8fiHBBQR3gWkSjKtXjaE
         u1K0iGAv7JdeeqgIYPqdeTRQ2q6VfzsWxDU1vLI/y+pkJZ5YicQstZdEmoPGpih70KZ5
         IpzulRQDCE2YGYLBW6+NN+uJmfQmESsHDdaVmVMcnOWUgDLz7gFX//YoL6mv3zx4Q++8
         9xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746602968; x=1747207768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exh3b5R7L77rlGB9XDLUTNFBk7LtXN6j6kHQ/wrFppg=;
        b=bkQKkvyrKYD1BNjKr0HvrNpHFxqg2xGQK0proWrei44q6SPcNPWrORzH2HOBhvc0U1
         EUxFiBNGTrbe3m/vPmJOq2gu52Z1peMIN8tu7UJsEb61Mn+pmYotBNInEQOIpysScMot
         kaCxv3NCesdz/N5vqwxDnhBrH4jQckRhY5hIgt8A9s3W5XnEZgBPvGWlOFgCshVZk6kG
         mAbj9jnTcJa0x4uUdoPMJybHpz+SyEbex28Vz7itnorL3hzoMyfSSnbpaOs2P1bwDb6/
         g9gubWNPqwfjoTVfgqvzljsZbQyfr5YTxceW/L3dMjoe2FqNEY+fOtFVOh5opwWcHrQO
         IT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQIAVYFPNX6TlRXuoGCl0IpFv8t3RN14uVaU00OWCw7M009NMLKTP1XiH3o1JCmn2tfQy9R2FuAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywosz2NaBiMZSQHaF1ctmu+GDb/UtJ0T2YWIfX4KLcdElJpJg22
	WE3sqAz4QpT1CMkZPsjBwXACySkFqSn1Jr4HoVw+G6Yvbmcv9GyqOHKpBEiinBA=
X-Gm-Gg: ASbGncvRN+ARZ3K4rviwssDwcjMID5jEKtc2cBfu2MXap1EnYY5csGWBz91xLq6FFVX
	Q9+BFwiwQpVjlHBpHoltunzQtDrAEiEeSRiE3OGkFjSr1ID9twS64hKT8Nq3q50b4s01Dlg5hRk
	dY7VFognnMLOrI6A2ACTMRfH7L+x4OrRn4SzH/mU4wQsuK6OCfFTwX5u5mGBn4A1NMBgdHLI9Zm
	78fl/pYejlAccwKxXRE1/RrC9S51XxtcFG4dgiQzE3DfwFgtWKOzTo0k9IpkEB2kJyoUP3Kf53n
	J1bU2l8OfeINYQYd1I80bVdINQsYfhkDqb489sUCJ0/vW636NUJRcJ/tmWtqKEQof1Tavd5AF1J
	xVtRa
X-Google-Smtp-Source: AGHT+IEH+UhigDV51ycf06z5unZsxUS1KzhCHNWdikOd5Jo+ShmTKo/P+eDgWolx1p8pfsovDvmOIg==
X-Received: by 2002:a5d:64e7:0:b0:38d:b325:471f with SMTP id ffacd0b85a97d-3a0b4a16497mr2004847f8f.15.1746602967790;
        Wed, 07 May 2025 00:29:27 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a0b350f604sm2547973f8f.21.2025.05.07.00.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 00:29:27 -0700 (PDT)
Message-ID: <c0e9a395-41d1-4edc-a759-f958ea10387a@linaro.org>
Date: Wed, 7 May 2025 09:29:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250226003608.8973-1-ansuelsmth@gmail.com>
 <20250226003608.8973-2-ansuelsmth@gmail.com>
 <a9f58437-5992-4042-85cd-b9150c4855ff@linaro.org>
 <6814de0d.7b0a0220.2add1a.0689@mx.google.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6814de0d.7b0a0220.2add1a.0689@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/05/2025 17:00, Christian Marangi wrote:
> On Fri, May 02, 2025 at 03:30:56PM +0200, Daniel Lezcano wrote:

[ ... ]

>>> +static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>>> +{
>>> +	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
>>> +	int min, max, avg_temp, temp_adc;
>>> +	int i;
>>> +
>>> +	/* Get the starting temp */
>>> +	temp_adc = airoha_get_thermal_ADC(priv);
>>> +	min = temp_adc;
>>> +	max = temp_adc;
>>> +	avg_temp = temp_adc;
>>> +
>>> +	/* Make 5 more measurement and average the temp ADC difference */
>>> +	for (i = 0; i < 5; i++) {
>>> +		temp_adc = airoha_get_thermal_ADC(priv);
>>> +		avg_temp += temp_adc;
>>> +		if (temp_adc > max)
>>> +			max = temp_adc;
>>> +		if (temp_adc < min)
>>> +			min = temp_adc;
>>> +	}
>>> +	avg_temp = avg_temp - max - min;
>>> +	avg_temp /= 4;

Why 4 ? There is 5 samples no ? one before the loop and 4 with the loop

>>> +	*temp = RAW_TO_TEMP(priv, avg_temp);

Does RAW_TO_TEMP() on a average raw adc value report the same value as 
an average of the temperature after their conversion ?

>>> +	return 0;
>>> +}

The routine is a bit confusing because of the initial adc read.

avg_value = 0;
min_value = INT_MAX;
max_value = INT_MIN;

for (i = 0; i < AIROHA_MAX_SAMPLES; i++) {
	value = airoha_get_thermal_ADC(priv);
	min_value = min(value, min_value);
	max_value = max(value, max_value);
	avg_value += value;
}

avg_value -= (min_value + max_value);
avg_value /= AIROHA_MAX_SAMPLES;

>> Does this chip support the averaging with the filtered mode which prevent to
>> do this expensive calls when getting the temperature ?
>>
> 
> If you notice in this function we read directly from the ADC sensor to
> have a more precise and realtime temperature.
> 
> Yes the thermal module support averaging (and this is what is set for
> the critical temperature monitor) but since we base everything on
> interrupt the expensive call is called only when the user poll the
> temperature with sysfs.

When the temperature reaches the threshold, the interrupt is fired which 
in turn calls thermal_zone_device_update(). This lead to a polling from 
the kernel at a higher rate with the governor taking cooling decision.

> Do you prefer to use the thermal module entirely?

It is up to you. I would say if the sensor has a hardware assistance to 
compute the averaging while the CPU does something else it is better. 
But if the filtered mode has the same issues than the LVTS, then it is 
probably not worth it.


[ ... ]



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

