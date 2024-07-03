Return-Path: <linux-pm+bounces-10543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766179260B5
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 14:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B9128A61D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F566176FBD;
	Wed,  3 Jul 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1bEmYZA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594B16F8F5
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010585; cv=none; b=Y+OtB9gTjtugQx7cagftvHrslPISv/+ZroJLaMNjiKUktw2ttq1NOl+ij5BApWHV4EvFqNME2CKoW3mzYzyDBeb9Khl8p0lK3qdCito1zo7cPrXQ5FMf3HwdCt56JkfuY3wNsGQ5wUSG7BEXy7YrrlMehOn6Vf1dfrXGHqws6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010585; c=relaxed/simple;
	bh=scNJ3uUgavXLkE+B8Fc8qL2ylIDhONrLy1yZofAzYGE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MUT90rMl9tw73cZlJ4wZCsMyk49i0y1Ps97xbI2WPw1vrJoLkBQeMx55Qk9kr+FFmY8QbWU5Hzg6n/G2qh++9GjDtb/l/K6ajxkzmIJfk76Tj4+zNhSfrkjbPmcOGWAIy5xSwBx7vS10f03cgIqy1gyRyb15J7mPUi+xFm+ChTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1bEmYZA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso37657585e9.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720010582; x=1720615382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcls5OOoW3A7th1rHpUdejr+WreMigQqwbobdOirfgY=;
        b=K1bEmYZA1o34W2ddnaN2UBN3aeyg5iQKtl6EMH0N31t6gg0YqC/ejKvEQz6TUzcoeh
         a0KchRy5UQEfAvJIKZaOuZ+cu4pqkn/0bUq3umNd9BVYsP0BJephkXluibXKe6WyArqf
         HV094m7KZJtbz4IesGsNNUWFBnbIl74t+mEAGuWOqWQCyRAF1SajizZNTnhTiYE8e5z4
         iI/H3N7DrnrgslD8/4d5CEtXow7wN7ovipHD8GZNimqdlmjXSpz3OsgB2Tx0lQcarkhY
         kJdRoCu1NlFa907X1HqnWuWBA4oguSUg6WOa35IBReGZptZBkpQ6t8YrD2tv0TFV1cEg
         29ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010582; x=1720615382;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mcls5OOoW3A7th1rHpUdejr+WreMigQqwbobdOirfgY=;
        b=qyW8R8OhEW+yPdmuPifWeDYgJVSXIPW8clpIGMVlppKnGJZ6aUTxdZ4Ik8M6OqCyXB
         LUmfFx2eNq4AweaKZsskAe0Vb7YlQOuLryMVgHCSBXjCL0p187T4aPkN8kH+PGHvG0hG
         8PdsTE+5+bAAynNIco50Y8Rx/HOlZLSSioRW4Pa80a6M9u3FWxZ6r36awX0UsgUciwHR
         z7s60UA1mcfJHbh0V6mr2OKE2rS6D4NtHN/cq2DdVy1FcT6jIIoJaqSw1Axazag3+On1
         Hvx718iPkOPRRQSBxlmmU5TxynrL5wc08DGQrD4LBuUab9czEPy/fdeDK+mWCoIZGQqL
         SOyg==
X-Forwarded-Encrypted: i=1; AJvYcCXQK5k0pCkNy+u8mpCwCnXcpVqYolFqTgEqU0pyrgUckNKcJ0s03CfQc3M26fy2xRE9LAfYEoTfqi/qF9syOEZHg9oLOjNpIzk=
X-Gm-Message-State: AOJu0YyZAENrZ+l5Oc7N4q9+wclhPvaqefj+5j6A9Vs4Yf8zIrjsFlbR
	CLKBJkOqpzyCfpzcDLnNmwqX1QQxQFbvGnoWy54Y8AiQYycyDr+hD33aMYvHCRs=
X-Google-Smtp-Source: AGHT+IHzvGwL7xX/n54n3hkiAuZuRwCsQpyInFxT+6vkOaUz1Rzb2YoLzDROcVZYUUviyDaDbEvxpA==
X-Received: by 2002:a05:600c:218a:b0:425:6303:7ef1 with SMTP id 5b1f17b1804b1-4257a06e028mr85165095e9.25.1720010581458;
        Wed, 03 Jul 2024 05:43:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ef03:73b5:7503:ee71? ([2a01:e0a:982:cbb0:ef03:73b5:7503:ee71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42577a0c286sm128225135e9.0.2024.07.03.05.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:43:01 -0700 (PDT)
Message-ID: <12c5c133-9519-4a26-b9a3-2da1d3466e94@linaro.org>
Date: Wed, 3 Jul 2024 14:43:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <2764814.mvXUDI8C0e@rjwysocki.net>
 <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
 <8d91a3c1-018f-495b-83be-979b795b5548@linaro.org>
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
In-Reply-To: <8d91a3c1-018f-495b-83be-979b795b5548@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 03/07/2024 14:25, Daniel Lezcano wrote:
> 
> Hi Neil,
> 
> it seems there is something wrong with the driver actually.
> 
> There can be a moment where the sensor is not yet initialized for different reason, so reading the temperature fails. The routine will just retry until the sensor gets ready.
> 
> Having these errors seem to me that the sensor for this specific thermal zone is never ready which may be the root cause of your issue. The change is spotting this problem IMO.

Probably, but it gets printed every second until system shutdown, but only for a single thermal_zone.

Using v1 of Rafael's patch makes the message disappear completely.

Neil

> 
> 
> On 03/07/2024 12:54, Neil Armstrong wrote:
>> Hi,
>>
>> On 28/06/2024 14:10, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
>>> if zone temperature is invalid") caused __thermal_zone_device_update()
>>> to return early if the current thermal zone temperature was invalid.
>>>
>>> This was done to avoid running handle_thermal_trip() and governor
>>> callbacks in that case which led to confusion.  However, it went too
>>> far because monitor_thermal_zone() still needs to be called even when
>>> the zone temperature is invalid to ensure that it will be updated
>>> eventually in case thermal polling is enabled and the driver has no
>>> other means to notify the core of zone temperature changes (for example,
>>> it does not register an interrupt handler or ACPI notifier).
>>>
>>> Also if the .set_trips() zone callback is expected to set up monitoring
>>> interrupts for a thermal zone, it has to be provided with valid
>>> boundaries and that can only happen if the zone temperature is known.
>>>
>>> Accordingly, to ensure that __thermal_zone_device_update() will
>>> run again after a failing zone temperature check, make it call
>>> monitor_thermal_zone() regardless of whether or not the zone
>>> temperature is valid and make the latter schedule a thermal zone
>>> temperature update if the zone temperature is invalid even if
>>> polling is not enabled for the thermal zone.
>>>
>>> Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() if zone temperature is invalid")
>>> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>   drivers/thermal/thermal_core.c |    5 ++++-
>>>   drivers/thermal/thermal_core.h |    6 ++++++
>>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>> @@ -300,6 +300,8 @@ static void monitor_thermal_zone(struct
>>>           thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
>>>       else if (tz->polling_delay_jiffies)
>>>           thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>>> +    else if (tz->temperature == THERMAL_TEMP_INVALID)
>>> +        thermal_zone_device_set_polling(tz, msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
>>>   }
>>>   static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
>>> @@ -514,7 +516,7 @@ void __thermal_zone_device_update(struct
>>>       update_temperature(tz);
>>>       if (tz->temperature == THERMAL_TEMP_INVALID)
>>> -        return;
>>> +        goto monitor;
>>>       tz->notify_event = event;
>>> @@ -536,6 +538,7 @@ void __thermal_zone_device_update(struct
>>>       thermal_debug_update_trip_stats(tz);
>>> +monitor:
>>>       monitor_thermal_zone(tz);
>>>   }
>>> Index: linux-pm/drivers/thermal/thermal_core.h
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.h
>>> +++ linux-pm/drivers/thermal/thermal_core.h
>>> @@ -133,6 +133,12 @@ struct thermal_zone_device {
>>>       struct thermal_trip_desc trips[] __counted_by(num_trips);
>>>   };
>>> +/*
>>> + * Default delay after a failing thermal zone temperature check before
>>> + * attempting to check it again.
>>> + */
>>> +#define THERMAL_RECHECK_DELAY_MS    100
>>> +
>>>   /* Default Thermal Governor */
>>>   #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
>>>   #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
>>>
>>>
>>>
>>>
>>
>> This patch on next-20240702 makes Qualcomm HDK8350, HDK8450, QRD8550, HDK8560, QRD8650 & HDK8650 output in loop:
>>
>> thermal thermal_zoneXX: failed to read out thermal zone (-19)
>>
>> Boot logs or ARM64 defconfig:
>> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152439#L1393
>> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152440#L2200
>> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152442#L2828
>> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152441#L1862
>> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152443#L1776
>> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152444#L1723
>>
>> Result of git bisect:
>> # bad: [82e4255305c554b0bb18b7ccf2db86041b4c8b6e] Add linux-next specific files for 20240702
>> # good: [22a40d14b572deb80c0648557f4bd502d7e83826] Linux 6.10-rc6
>> git bisect start 'FETCH_HEAD' 'v6.10-rc6'
>> # bad: [f6dfcf0e9567b57b93f2564966d9177f0d8dbe05] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>> git bisect bad f6dfcf0e9567b57b93f2564966d9177f0d8dbe05
>> # good: [7f86ae0c2dc19fea7be1da29b2bf03f085463ae7] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
>> git bisect good 7f86ae0c2dc19fea7be1da29b2bf03f085463ae7
>> # bad: [077d5bbd75dd12af2096c96846ffc78ab5dd65b1] Merge branch 'devfreq-next' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
>> git bisect bad 077d5bbd75dd12af2096c96846ffc78ab5dd65b1
>> # good: [271bcaf753d0afe2bd0386ab1e98132ee65b61ca] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
>> git bisect good 271bcaf753d0afe2bd0386ab1e98132ee65b61ca
>> # good: [9758a2ee5316a6f8736ab4fd39a6f6176aa057ec] Merge branch 'hwmon-next' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
>> git bisect good 9758a2ee5316a6f8736ab4fd39a6f6176aa057ec
>> # good: [e6bd69ea345045520bd63487b85a4b5676aff76b] Merge branch 'master' of git://linuxtv.org/mchehab/media-next.git
>> git bisect good e6bd69ea345045520bd63487b85a4b5676aff76b
>> # good: [46398edfb36e2882be5e86ea563b2db9138ae499] Merge branches 'pm-cpuidle' and 'pm-powercap' into linux-next
>> git bisect good 46398edfb36e2882be5e86ea563b2db9138ae499
>> # good: [d3927cbc52eed166f74ea7e031ed6384cc3d4d5f] Merge branch 'thermal-intel' into linux-next
>> git bisect good d3927cbc52eed166f74ea7e031ed6384cc3d4d5f
>> # good: [ce84b7beeb524e7b20983838687862454ba54df7] cpufreq: sti: add missing MODULE_DEVICE_TABLE entry for stih418
>> git bisect good ce84b7beeb524e7b20983838687862454ba54df7
>> # bad: [fcf61315d38d41f4e55856b179f9e5538e299ef4] Merge branch 'thermal-fixes' into linux-next
>> git bisect bad fcf61315d38d41f4e55856b179f9e5538e299ef4
>> # good: [4262b8d782a74c7cf7b8b94ed9e4fcb94e856d1e] dt-bindings: thermal: mediatek: Fix thermal zone definition for MT8186
>> git bisect good 4262b8d782a74c7cf7b8b94ed9e4fcb94e856d1e
>> # good: [7eeb114a635a04bea2fa7d57cedbf374c714d29e] dt-bindings: thermal: convert hisilicon-thermal.txt to dt-schema
>> git bisect good 7eeb114a635a04bea2fa7d57cedbf374c714d29e
>> # good: [107ac0d49ae6a86b4986146b9a612294f7e34406] Merge branch 'thermal/linux-next' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into linux-next
>> git bisect good 107ac0d49ae6a86b4986146b9a612294f7e34406
>> # bad: [5725f40698b9ba7f84fbfee25b9059ba044c4b86] thermal: core: Call monitor_thermal_zone() if zone temperature is invalid
>> git bisect bad 5725f40698b9ba7f84fbfee25b9059ba044c4b86
>> # first bad commit: [5725f40698b9ba7f84fbfee25b9059ba044c4b86] thermal: core: Call monitor_thermal_zone() if zone temperature is invalid
>>
>> #regzbot introduced: 5725f40698b9ba7f84fbfee25b9059ba044c4b86
>>
>> Thanks,
>> Neil
> 


