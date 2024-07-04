Return-Path: <linux-pm+bounces-10607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3AF927670
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 14:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519191F212D0
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BD1AE843;
	Thu,  4 Jul 2024 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADWXGZ3F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07DD26289
	for <linux-pm@vger.kernel.org>; Thu,  4 Jul 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097576; cv=none; b=MAFBXt6qbzdVkBDZyMmTKuvM7A3coHGEypa768UUXFykOlO6HGVLktXw1YbWUlQmo4KZMN+Fs6bX5Ew6ic5RGGgZxP6rVvjWPYP39GQUdyhmSSEs+DhQkR+1STe/fv5PE4CEVYxJRcMIwDKiDHjhTQR5BUx1jfH9URyo8G9OIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097576; c=relaxed/simple;
	bh=s1aeqAr7pZZSjhKno9CeXyDqgFwb+Pm7TOlyclNbJFw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PixO86IZYwiy1cKG0aXV8M6fLomX+5aCntUxov2+nIuLU4HMz9DQ/sY9Wagbf6EMN9DwKfJpo1L89iklwQ/TByjwEDMWUxZCjHydn3fQFxwlF5CmZOvAqcIOYX8ZUbG7HOU15Yr2NEZQ3eX1FDCogNO5Pf/QKr6rhKUIDZP0khQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ADWXGZ3F; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367a3d1a378so62151f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2024 05:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720097572; x=1720702372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojBdomht8992CLL3MWJCzSVU4eAEXfQWlgF80GsezlQ=;
        b=ADWXGZ3FnNLy4OA0oVi9C/zIq64htHa8JNeVlUDmtJ+dP/0k2GtMHBa6iWg3t3++w2
         kWS891U/ofa6r1nEG6N5yZVzfGeGTU1FqcdvMPgxp2t6n8QDqAXG8szYdMcPwLy6T1b3
         B3mC1S54UnLWmhJQhzJxRoJ/5qpcByAdHu+E4zT/KlVqKbj2wUp6z/raR0jhTrS7oK0r
         gZva088XGwnSmUCZLmuLeir2bZPQkhFDOWrL5VqqP8+RONvytPRjotKyLcZpbYoSF7ie
         EwWG5b9WjGVXzIM0r+0dGHpM/tZX2dCJ/cO8ekYX7L+om9lgGzGl03/TWdvNOLmk4UZt
         jTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097572; x=1720702372;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ojBdomht8992CLL3MWJCzSVU4eAEXfQWlgF80GsezlQ=;
        b=oMIcsmlCaGL/fpBRiiwqcM3qbGkL/lR2hVSjO2RdKPFM/afsWZxHxcGPkhZfqND3Sa
         R2I7cbSBKlQqbNimcefP2lJ9h7/pDdSivz3EAfhiD0L86AXBN5j3mOd7N+8zpXFwykia
         alBIR1V4bw2mv+f7sac/muEGPRkwSHOPOJVdiLTFG2gPwi9fOjvexgLFuqHJ18bSn6pl
         Xxw3cCJJAV5YEOVMuRifvAi3oHH6iC9quaLVFO9EwXcphOFeNp8wNjRZ298+N//VdgNw
         gLVJofSbksYX8k4gTbNVWxMIwReVJYoeaGy10QZwLNsEs5FIj83jK4mrHb95SXkx+lzg
         WBDg==
X-Forwarded-Encrypted: i=1; AJvYcCW2z94HcqijGPf8cXSGO+cxscSHbkAKoXiw2vwOIoTK30OMhbb3E3iQmMSoSqcJAO0M65b1DrB1rHyZbD9Hg+KWcx1xDBTyqg4=
X-Gm-Message-State: AOJu0Yw+xnSIkotKYnYW82iuVhVW0qJEzqlIRph+jXlwHE2CmSWjeLs/
	tNDflsBux+iAw+fgIlbY4mTs2cQELCZwESm49PLt/HJTbwjmrrRejqIAN9xj0eA=
X-Google-Smtp-Source: AGHT+IFUvtoFlxxScN4PRB8HgZPhGILpqFT7zG6E5zsLT1Y/5gE6gi1n/oR0JdAdedgIbxn0EwVm6Q==
X-Received: by 2002:a5d:4207:0:b0:367:9cd5:c608 with SMTP id ffacd0b85a97d-3679dd31836mr1392396f8f.36.1720097572007;
        Thu, 04 Jul 2024 05:52:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf0c:e5a4:4535:f45c? ([2a01:e0a:982:cbb0:bf0c:e5a4:4535:f45c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a043a16sm18687489f8f.0.2024.07.04.05.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 05:52:51 -0700 (PDT)
Message-ID: <d30068aa-b0df-4ec7-9a6b-9d5c6b49b74e@linaro.org>
Date: Thu, 4 Jul 2024 14:52:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
 <218d45a8-4c3d-453b-aded-d232c366da2c@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <218d45a8-4c3d-453b-aded-d232c366da2c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 04/07/2024 14:49, Daniel Lezcano wrote:
> On 04/07/2024 13:46, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
>> if zone temperature is invalid") caused __thermal_zone_device_update()
>> to return early if the current thermal zone temperature was invalid.
>>
>> This was done to avoid running handle_thermal_trip() and governor
>> callbacks in that case which led to confusion.  However, it went too
>> far because monitor_thermal_zone() still needs to be called even when
>> the zone temperature is invalid to ensure that it will be updated
>> eventually in case thermal polling is enabled and the driver has no
>> other means to notify the core of zone temperature changes (for example,
>> it does not register an interrupt handler or ACPI notifier).
>>
>> Also if the .set_trips() zone callback is expected to set up monitoring
>> interrupts for a thermal zone, it needs to be provided with valid
>> boundaries and that can only be done if the zone temperature is known.
>>
>> Accordingly, to ensure that __thermal_zone_device_update() will
>> run again after a failing zone temperature check, make it call
>> monitor_thermal_zone() regardless of whether or not the zone
>> temperature is valid and make the latter schedule a thermal zone
>> temperature update if the zone temperature is invalid even if
>> polling is not enabled for the thermal zone (however, if this
>> continues to fail, give up after some time).
> 
> Rafael,
> 
> do we agree that we should fix somehow the current issue in this way because we are close to the merge window, but the proper fix is not doing that ?

I've tested this patch, but I have no opinion about it.

I sent https://lore.kernel.org/all/20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org/ which
fixes the warning print, leaving the option for thermal core to update the tz once it becomes available,
which is the initial goal of this patchset.

Neil

> 
> 
>> Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() if zone temperature is invalid")
>> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org
>> Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/thermal/thermal_core.c |   13 ++++++++++++-
>>   drivers/thermal/thermal_core.h |    9 +++++++++
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> Index: linux-pm/drivers/thermal/thermal_core.c
>> ===================================================================
>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>> +++ linux-pm/drivers/thermal/thermal_core.c
>> @@ -300,6 +300,14 @@ static void monitor_thermal_zone(struct
>>           thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
>>       else if (tz->polling_delay_jiffies)
>>           thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>> +    else if (tz->temperature == THERMAL_TEMP_INVALID &&
>> +         tz->recheck_delay_jiffies <= THERMAL_MAX_RECHECK_DELAY) {
>> +        thermal_zone_device_set_polling(tz, tz->recheck_delay_jiffies);
>> +        /* Double the recheck delay for the next attempt. */
>> +        tz->recheck_delay_jiffies += tz->recheck_delay_jiffies;
>> +        if (tz->recheck_delay_jiffies > THERMAL_MAX_RECHECK_DELAY)
>> +            dev_info(&tz->device, "Temperature unknown, giving up\n");
>> +    }
>>   }
>>   static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
>> @@ -430,6 +438,7 @@ static void update_temperature(struct th
>>       tz->last_temperature = tz->temperature;
>>       tz->temperature = temp;
>> +    tz->recheck_delay_jiffies = 1;
>>       trace_thermal_temperature(tz);
>> @@ -514,7 +523,7 @@ void __thermal_zone_device_update(struct
>>       update_temperature(tz);
>>       if (tz->temperature == THERMAL_TEMP_INVALID)
>> -        return;
>> +        goto monitor;
>>       tz->notify_event = event;
>> @@ -536,6 +545,7 @@ void __thermal_zone_device_update(struct
>>       thermal_debug_update_trip_stats(tz);
>> +monitor:
>>       monitor_thermal_zone(tz);
>>   }
>> @@ -1438,6 +1448,7 @@ thermal_zone_device_register_with_trips(
>>       thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>>       thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
>> +    tz->recheck_delay_jiffies = 1;
>>       /* sys I/F */
>>       /* Add nodes that are always present via .groups */
>> Index: linux-pm/drivers/thermal/thermal_core.h
>> ===================================================================
>> --- linux-pm.orig/drivers/thermal/thermal_core.h
>> +++ linux-pm/drivers/thermal/thermal_core.h
>> @@ -67,6 +67,8 @@ struct thermal_governor {
>>    * @polling_delay_jiffies: number of jiffies to wait between polls when
>>    *            checking whether trip points have been crossed (0 for
>>    *            interrupt driven systems)
>> + * @recheck_delay_jiffies: delay after a failed thermal zone temperature check
>> + *             before attempting to check it again
>>    * @temperature:    current temperature.  This is only for core code,
>>    *            drivers should use thermal_zone_get_temp() to get the
>>    *            current temperature
>> @@ -108,6 +110,7 @@ struct thermal_zone_device {
>>       int num_trips;
>>       unsigned long passive_delay_jiffies;
>>       unsigned long polling_delay_jiffies;
>> +    unsigned long recheck_delay_jiffies;
>>       int temperature;
>>       int last_temperature;
>>       int emul_temperature;
>> @@ -133,6 +136,12 @@ struct thermal_zone_device {
>>       struct thermal_trip_desc trips[] __counted_by(num_trips);
>>   };
>> +/*
>> + * Maximum delay after a failing thermal zone temperature check before
>> + * attempting to check it again (in jiffies).
>> + */
>> +#define THERMAL_MAX_RECHECK_DELAY    (30 * HZ)
>> +
>>   /* Default Thermal Governor */
>>   #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
>>   #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
>>
>>
>>
> 


