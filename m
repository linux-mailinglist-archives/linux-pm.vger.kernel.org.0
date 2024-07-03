Return-Path: <linux-pm+bounces-10545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B703F9260BD
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 14:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD5228B235
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD385178360;
	Wed,  3 Jul 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qv67i7uS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935B173339
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010640; cv=none; b=b0YI/b6zpVtqVIGXRfbZ7SK6efIyF6uAKJvLrW8Ak2+xkizepIood9RNILMtB6Kh45lKn+egtp6Rk9LbZ8qnjlbUS0wWC8e6S3PIsiXEq0dOHoMwltkuwjAy2tAVTeHQR8j/kePTkEirEuzMXmRa1p6ZsbJGb58BMHCqiwJi2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010640; c=relaxed/simple;
	bh=VdRfPzAthl7DMawkwBV/SuNa8f44jOlg5OX6ORSz6BI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OXkgdoiHH5rOcG4ArNke/ZjpMDyPCBToDNO2Co/JSc+9LZUP9XmVQt0ypQYPyHRM6Z8mbttM9h5a6wlLeKE+Uv1xo9yoCd3cj705Bg0KHp41cIwONKRSReDl/kmsWhWDphgXmb434WqkAPvN1PlSK2PpIHs4SSI9qxWa2wrANfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qv67i7uS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee88c4443eso3223151fa.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720010637; x=1720615437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3HgH1hvKo0FY8JZsGAA6bC1vvxBJE11DO7UMAUzFq0=;
        b=Qv67i7uSx35gz3ytcVBmquEtpVRgqD+ssSoCvMAc2fK7og0j1H2UcJk8/DMKH6t8Zc
         ADsOEFpk2QuFZofSQaQFTZ3KCDBlepyPSEVJVqEWJ0haOrdSfJCDE84kQ7niMFPHijPM
         n3dMiWnNuasXkNwRo4GyMSuiAh6xUSQtLxeoM6nn57Jv0G3nSSXwPrlvmpHHl9m9+kAv
         gcO2QcwKw3do2JpkhkkDZ8eknqlq5Eg3g0X46BafppBkOBahr5toWfyCDOz2WdrwNQbl
         rU1PNyscuPBovlxPwQDHeHL8JuNskQ1nfqXaUMqN1C/lyTmMLP1EV1K1GDzlvThyx5ey
         Ehlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010637; x=1720615437;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l3HgH1hvKo0FY8JZsGAA6bC1vvxBJE11DO7UMAUzFq0=;
        b=QLntvvcFMbSTcdd6vDDf0Urh+F/LSHO+h1vuITK0tMhz7pApC9p9QSF1HfzANDVHpB
         WfO16DSpVK6qGdtYycI04lHPxZbQuR5+bggjybqMk5ACvrguTGckLd3UwlEpnqqgIsrA
         9YD7Ri3aJoy3I6luUpYhZpL0Ce+QvorLZPXon+cZjTI5lBSOYyXkB60RQkVVC7EJEaI7
         K/JpzKPB/dRgj+oVp8U+KNKaGKMbU1DYWbrfW6LU+NgVeF+UBQ4NIvc6javMP03+J+bD
         GQlzNv+sgIGtgoNEtjVq0N0iT7wfNkALkpw3ag2haPdfsicCKQ7lY342dgjFF83ydV1m
         H+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVhBNU0u+QywCnQ35j5bzumbmTZQRYoGs9V/mLzZS9eC2PeojesIj3QtDXh82bABSIXpcq/DzjcUHl04A5rkwXhpcAFE/OupI=
X-Gm-Message-State: AOJu0YzTiG+p6+8cYxwRTLov/G6pbxJMcuITGvGnbhFsHjEfTG/ONap0
	9jzXxcNPGrBzBkc83VvEPCf2Dk/pgl1+nMKFVORkHZAY1aEL57KYMysznPep92o=
X-Google-Smtp-Source: AGHT+IHap25tUcl2feO5Gid55wz2EuEoXF9uI1mSdT2acRF9XJ3Tb5QEU9rHXqKUwVaFOWBXfgmR9g==
X-Received: by 2002:a2e:87c9:0:b0:2ec:5811:edd4 with SMTP id 38308e7fff4ca-2ee5e3c35dbmr84168551fa.31.1720010636932;
        Wed, 03 Jul 2024 05:43:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ef03:73b5:7503:ee71? ([2a01:e0a:982:cbb0:ef03:73b5:7503:ee71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36796bae9ecsm786492f8f.38.2024.07.03.05.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:43:56 -0700 (PDT)
Message-ID: <fdbdfdc3-d87c-4b95-8fc9-7b2331d1b684@linaro.org>
Date: Wed, 3 Jul 2024 14:43:55 +0200
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
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <2764814.mvXUDI8C0e@rjwysocki.net>
 <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
 <CAJZ5v0ghYd28H5eX8b68PSABMm8vTbeSpMxUsQ5mpVOXRPZ3RA@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0ghYd28H5eX8b68PSABMm8vTbeSpMxUsQ5mpVOXRPZ3RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 03/07/2024 13:29, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wed, Jul 3, 2024 at 1:04 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
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
>>> callbacks in that case which led to confusion.  However, it went too
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
>>>    drivers/thermal/thermal_core.c |    5 ++++-
>>>    drivers/thermal/thermal_core.h |    6 ++++++
>>>    2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>> @@ -300,6 +300,8 @@ static void monitor_thermal_zone(struct
>>>                thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
>>>        else if (tz->polling_delay_jiffies)
>>>                thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>>> +     else if (tz->temperature == THERMAL_TEMP_INVALID)
>>> +             thermal_zone_device_set_polling(tz, msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
>>>    }
>>>
>>>    static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
>>> @@ -514,7 +516,7 @@ void __thermal_zone_device_update(struct
>>>        update_temperature(tz);
>>>
>>>        if (tz->temperature == THERMAL_TEMP_INVALID)
>>> -             return;
>>> +             goto monitor;
>>>
>>>        tz->notify_event = event;
>>>
>>> @@ -536,6 +538,7 @@ void __thermal_zone_device_update(struct
>>>
>>>        thermal_debug_update_trip_stats(tz);
>>>
>>> +monitor:
>>>        monitor_thermal_zone(tz);
>>>    }
>>>
>>> Index: linux-pm/drivers/thermal/thermal_core.h
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.h
>>> +++ linux-pm/drivers/thermal/thermal_core.h
>>> @@ -133,6 +133,12 @@ struct thermal_zone_device {
>>>        struct thermal_trip_desc trips[] __counted_by(num_trips);
>>>    };
>>>
>>> +/*
>>> + * Default delay after a failing thermal zone temperature check before
>>> + * attempting to check it again.
>>> + */
>>> +#define THERMAL_RECHECK_DELAY_MS     100
>>> +
>>>    /* Default Thermal Governor */
>>>    #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
>>>    #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
>>>
>>>
>>>
>>>
>>
>> This patch on next-20240702 makes Qualcomm HDK8350, HDK8450, QRD8550, HDK8560, QRD8650 & HDK8650 output in loop:
>>
>> thermal thermal_zoneXX: failed to read out thermal zone (-19)
> 
> Is the loop endless?  If not, how many times does the message get printed?

It get printed indefinitely

> 
> If I'm not mistaken, it would be printed at least once without the
> commit in question.  Can you please check that?
> 
> Also, can you check the previous version of the patch in question:
> 
> https://lore.kernel.org/linux-pm/2745114.mvXUDI8C0e@rjwysocki.net/
> 
> and see if it has the same problem (just apply it instead of the $subject one).

I reverted this one a applied v1 and the message disappeared completely.

Neil

> 
> Thanks!


