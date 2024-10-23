Return-Path: <linux-pm+bounces-16287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5009AC793
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD941C2060E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3CA19F40A;
	Wed, 23 Oct 2024 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnSUdrtL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E51509A0
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678630; cv=none; b=JmRP2EutEvwkMKfnJ4ofT3sLk+m5cPeRyx1OLO9OXGWn2APZPrPDa7X8fo19eti/O4OSRdeI/TMUQXOYmSC8PQVi4ch4e66F5u8X4R2rZ3AmCr64CVARjmVuTZ7IVgjXJKyhylcB/MJZFE5behN/+9xlxwhW52Ff6e+54o6kb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678630; c=relaxed/simple;
	bh=5oe9upnnkInMdpt6My12O0Da9yrxhuZVT3jnBKYh6qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcpFrWt69X+AS4zdcOlNxUwNHjrANCFARNEwokrYarc6mTI2M0mbuTFwHOrdXhwseq+66noSRJBoRUay9UUrSFd5vc4kbqOtrvS+5gFZa+84IPiVxTAB+xL6PwM8mYu81u1/yMePSX37wjeQUC5BBq14HoWGuPcXXpndD1HvYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EnSUdrtL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315abed18aso62993955e9.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729678627; x=1730283427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXznnsz8M4a2v04xFS5JzaaMqP+O3PCxrBSTBDqFsS8=;
        b=EnSUdrtL71QqRYTfdYZdgKPtyfV6NKnjr4UO2RbjAX13P4MwvSQ17387ZynRWJ1LiR
         C7WgYr1144Vd6bFNsTikZTNbYx91wFWTaZ9m2LVZ4kUT7kmkREwT8cJaqMudNcD+oLW0
         Xn0vwgauTo04vdnBDHoSAfJD1tOr1ZcvyNuUES2Rhzkc2lNLo8L0MgzxHqvezZqygyJu
         A2CzPQxtnLR57Hh6tjax0njwf8G6b/p5Q+hT+GhyjMACtbukCndRTpKBneQIzEMdR82y
         FUfUUp07Q+lCk+m70Bv/iAFkTLBusOIrfNrwCY2dZm85ZHL6Ey0YCz/+YLMflHjx2QzK
         LTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678627; x=1730283427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXznnsz8M4a2v04xFS5JzaaMqP+O3PCxrBSTBDqFsS8=;
        b=EL5ATpQqYOqjZyzLAmg9VNNHZsGPgI8EN/X9dSa0rn6P/qnj2vuNsUD7UR9Cv0/tAA
         L0cpGXG6ehr0ai+uxx7H48flIdr5bxfRO+YcUrtjt57YDWWkRbQ8h6i1sXUgqqiRbOWK
         hiUXA1Qf1TT+ITj7DKA0GEcQBmFRi1DYk3BZt+TZQsXKQL6lSboSkuMkQDHU3XA+6Dbg
         m15yGGfTfwk2McrWV61ruKmBrd38iGgf8DJRWel69X7t/Cs+28+sBEzg/DJKLuqNgHJa
         R6yYltvH2szVZpM/cRovopDwo4MO/lxLlYS1xf2iUl8xLQbfXcHTx7/a8qT2KdBlpXYg
         x+/w==
X-Gm-Message-State: AOJu0Yweq0Zvkdpsa6s00IzOIWOT6ZnchMj1jecTLBl96NskyG9bu089
	sdYUtGr7T67kIqC7bwPQ1ovrpLtd9PLPaZlTxlZQVUzeDNgGTTIPzV+9hUTZhaQ=
X-Google-Smtp-Source: AGHT+IHs3UuSz6gO2bZx07T1eJ1XUbFuVhDrfoFPdLPcngxMZgHez+68L5ktG9k77Tw/nPEZT/QtcA==
X-Received: by 2002:a05:600c:1c0f:b0:431:3b53:105e with SMTP id 5b1f17b1804b1-431841fda82mr17270265e9.9.1729678626857;
        Wed, 23 Oct 2024 03:17:06 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186bd68c7sm12118055e9.7.2024.10.23.03.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 03:17:06 -0700 (PDT)
Message-ID: <5bf7ebec-e1f5-43eb-9a99-4d4700e12a33@linaro.org>
Date: Wed, 23 Oct 2024 12:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] thermal: core: Connect the threshold with the core
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241022155147.463475-1-daniel.lezcano@linaro.org>
 <20241022155147.463475-2-daniel.lezcano@linaro.org>
 <cbadcbb6-72b0-4ac1-a3ed-15c935a3772e@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <cbadcbb6-72b0-4ac1-a3ed-15c935a3772e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/10/2024 22:25, Lukasz Luba wrote:
> 
> 
> On 10/22/24 16:51, Daniel Lezcano wrote:
>> Initialize, de-initialize and handle the threshold in the same place
>> than the trip points.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Link: https://patch.msgid.link/20240923100005.2532430-3- 
>> daniel.lezcano@linaro.org
>> [ rjw: Subject edit ]
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/thermal/thermal_core.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/ 
>> thermal_core.c
>> index 8f03985f971c..1e87256e86be 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -585,6 +585,8 @@ void __thermal_zone_device_update(struct 
>> thermal_zone_device *tz,
>>               high = td->threshold;
>>       }
>> +    thermal_thresholds_handle(tz, &low, &high);
>> +
>>       thermal_zone_set_trips(tz, low, high);
>>       list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
>> @@ -1491,6 +1493,10 @@ thermal_zone_device_register_with_trips(const 
>> char *type,
>>               goto unregister;
>>       }
>> +    result = thermal_thresholds_init(tz);
>> +    if (result)
>> +        goto remove_hwmon;
>> +
> 
> AFAICS the function thermal_thresholds_init() cannot fail.
> It always returns 0. So compiler+linker will remove that check anyway. 
> Therefore, I would remove the check in this code.
> Or maybe you have some other plans in near future to that init
> function...

Yes, right. However, it is how I wrote the code. If the call site 
returns an error then the called functions must return an error.

That way the code handling the error is already there and when the 
underlying functions change their logic with a possible error then the 
call site is not impacted.

That makes the code more maintainable for external contributions and as 
you mentioned the compiler is smart enough to optimize the path so there 
is no performance penalty.

>>       mutex_lock(&thermal_list_lock);
>>       mutex_lock(&tz->lock);
>> @@ -1514,6 +1520,8 @@ thermal_zone_device_register_with_trips(const 
>> char *type,
>>       return tz;
>> +remove_hwmon:
>> +    thermal_remove_hwmon_sysfs(tz);
> 
> So remove this line as well, since it cannot happen.
> Although, it's a minor so up to you.
> 
>>   unregister:
>>       device_del(&tz->device);
>>   release_device:
>> @@ -1601,6 +1609,7 @@ void thermal_zone_device_unregister(struct 
>> thermal_zone_device *tz)
>>       thermal_set_governor(tz, NULL);
>> +    thermal_thresholds_exit(tz);
>>       thermal_remove_hwmon_sysfs(tz);
>>       ida_free(&thermal_tz_ida, tz->id);
>>       ida_destroy(&tz->ida);
> 
> Other than that, since no functional issues
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

