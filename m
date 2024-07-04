Return-Path: <linux-pm+bounces-10627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D1927B79
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D42B20923
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01A81B29DA;
	Thu,  4 Jul 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wm/kTnma"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AF3182D8
	for <linux-pm@vger.kernel.org>; Thu,  4 Jul 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111990; cv=none; b=raZarBl/9IBa/IBTunmE8gmhY4775PjDkcLwSFgrolU6wBdZKAVGzxuPBjcuHi6DYCg2p46CccIQEy7guBVXxkHPxZ4oa39BMnW7C0pn3vXMiXBsy6SRC79LAlyTYxw6grRHxP2PtC1ZlUOXBc/3VPmmHKkiRrlG/t4/X+TIodY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111990; c=relaxed/simple;
	bh=vNml4V8TqWsITsu2939Ir5Wz/Im777PXky6vZIiWlM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMcuOitloeAtsnPa8SpOtVk8egQLexTkorYjzVyLrzd/1eENrOGnGlpHmqIiU1UeUiPG9qB+WPKx3VswbEddfCsURTPC0rbt4Tzu5f4A7Qjbt3Znn0iMGzvisLKtqoGZAPqVuuVI5vdCoQFysIvsjIyGIZOz0ppsKJyLTqmapKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wm/kTnma; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4255fa23f7bso5498615e9.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2024 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720111987; x=1720716787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DkTSiyMRMYh6Bw6K4VHRPTD1+iOzdzxDtGfcT/N811U=;
        b=wm/kTnmas09qKDBlHLxUYStjS+QpmASiXdI+r5tp8QIP/+F11i53nQt28/06EhMQEC
         k3KSfR+aVZinR1RH4vSjUuVJqBA+e6Q8qrcmjZOZZtnQ0OckI4aef9f4Y/tSplyHdFHB
         VTDKdKo7UktY8Ak/5x8QYCN6yIKVJn2YRcHryNk/lGbtzGQ7rRaGvCsQg/ori0S5GX9y
         tcf1GlCSJJ9PMtFM+pusjKk0R1GtNESX3Dk+o4pPjTYLTShuCMsPM49AZMBluEbjTylb
         bJf2yyvdFtU9tiND6Q0rAJy+IEsexCGKUkLIkJy0hElmUD6mtzQyeSVb/n7oWaLccgwv
         UiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720111987; x=1720716787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkTSiyMRMYh6Bw6K4VHRPTD1+iOzdzxDtGfcT/N811U=;
        b=d/0hC89afrwCMcI2i2gT8QQDbF0asod26iJm3CqBaLPXS2/z3eoflYf0pec5Gco1ZC
         3LH/5BdlaJ1t8ZiQESCGnTQWtKHuY+FP/PGy8Zs8ADO0WT2/d6sm1BU5lzI5VPdsPkEi
         JUktiUKXjyG2qh6mTYJEBk+w/asaDpY0XtFGogZfsh//8D0tdWUZeRCdQLXBdf1J/bJB
         6Tlu+Wakd8yd3cSAdUZMSfVvQwoRxVaw3zoGEgNB7ASNgya04nAerc4u7JWU0v9mV+W5
         suhWCVT5BWc+bTewRZ48IFPZtXlp6uIe6jR2Nsa2fm2XEcyFfeIseFofOUD1a4v+1KO8
         jruQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIRCDLRvF5EB1naMqDUwhrwpqOPAVadSNgJvI1rn48+Kmll2pAxZrSrLDwZj1xdGLTdN3poRwoY6XvX1i58jRbUZdEXnZLOFo=
X-Gm-Message-State: AOJu0YyvI8eYlcgATOBKiFiVDUJZn+K8kYvo+qBjE2yQBKVM2Ak6bk78
	R3A0G0vluEkDMGWPhgdRgEHHip1D0WQ26LUGmicff3wdfogcW0F4lhNxPn71usk=
X-Google-Smtp-Source: AGHT+IEGxXUW+N8GPopc/bN3lz6X+A1LZm+R2JSgWqEMWXCPDVOLWpIAE8hiTSFY5aIWFGMQf1XCoA==
X-Received: by 2002:a05:600c:4a17:b0:425:6f96:8bcd with SMTP id 5b1f17b1804b1-4264a34fe75mr17909055e9.0.1720111986968;
        Thu, 04 Jul 2024 09:53:06 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-367a2ee695csm936999f8f.98.2024.07.04.09.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 09:53:06 -0700 (PDT)
Message-ID: <db358fd0-4163-48c2-b6f2-66c0357fc064@linaro.org>
Date: Thu, 4 Jul 2024 18:53:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
 <218d45a8-4c3d-453b-aded-d232c366da2c@linaro.org>
 <CAJZ5v0gRoy0+LD0EgwbS0NL8kHhas4T6itgawGjE8iNf57MOcg@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gRoy0+LD0EgwbS0NL8kHhas4T6itgawGjE8iNf57MOcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/07/2024 16:21, Rafael J. Wysocki wrote:
> On Thu, Jul 4, 2024 at 2:49 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 04/07/2024 13:46, Rafael J. Wysocki wrote:
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
>>> interrupts for a thermal zone, it needs to be provided with valid
>>> boundaries and that can only be done if the zone temperature is known.
>>>
>>> Accordingly, to ensure that __thermal_zone_device_update() will
>>> run again after a failing zone temperature check, make it call
>>> monitor_thermal_zone() regardless of whether or not the zone
>>> temperature is valid and make the latter schedule a thermal zone
>>> temperature update if the zone temperature is invalid even if
>>> polling is not enabled for the thermal zone (however, if this
>>> continues to fail, give up after some time).
>>
>> Rafael,
>>
>> do we agree that we should fix somehow the current issue in this way
>> because we are close to the merge window,
> 
> Yes.
> 
>> but the proper fix is not doing that ?
> 
> We need to decide what to do in general when __thermal_zone_get_temp()
> returns an error.  A proper fix would result from that, but it would
> require more time than is available IMV.  We can properly fix this in
> 6.11.

Right, in general we should take care of returning values from the 
different functions, update_temperature(), etc... in order to have the 
thermal_zone_device_update() returning a value.

So from there we can catch the result in the initialization function and 
do the proper actions.

 From a higher perspective, IMO the code contains too many returning 
void functions. We should convert that into returning values and handle 
the error cases.

> For 6.10 I see two options:
> 
> 1. Apply the v2 of this patch:
> 
> https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net/
> 
> I slightly prefer it because it is simpler and doesn't change the size
> of struct thermal_zone_device.

I agree

>  However, the clear disadvantage of it
> is that it will poke at dead thermal zones indefinitely.

Yes, but the advantage of this disadvantage is it is so visible that 
buggy routine will be brought to the light, so they can be fixed. I 
don't think we should have so many, perhaps none.

> The THERMAL_RECHECK_DELAY_MS value in it can be adjusted.  Maybe 250
> ms would be a better choice?

Yes

> 2. Apply this patch (ie. v3)
> 
> It is nicer to thermal zones that never become operational, but it may
> miss thermal zones that become operational very late.

I would keep this v3 as a backup in case there are too many complaints, 
but I doubt

>>> Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() if zone temperature is invalid")
>>> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org
>>> Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>    drivers/thermal/thermal_core.c |   13 ++++++++++++-
>>>    drivers/thermal/thermal_core.h |    9 +++++++++
>>>    2 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>> @@ -300,6 +300,14 @@ static void monitor_thermal_zone(struct
>>>                thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
>>>        else if (tz->polling_delay_jiffies)
>>>                thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>>> +     else if (tz->temperature == THERMAL_TEMP_INVALID &&
>>> +              tz->recheck_delay_jiffies <= THERMAL_MAX_RECHECK_DELAY) {
>>> +             thermal_zone_device_set_polling(tz, tz->recheck_delay_jiffies);
>>> +             /* Double the recheck delay for the next attempt. */
>>> +             tz->recheck_delay_jiffies += tz->recheck_delay_jiffies;
>>> +             if (tz->recheck_delay_jiffies > THERMAL_MAX_RECHECK_DELAY)
>>> +                     dev_info(&tz->device, "Temperature unknown, giving up\n");
>>> +     }
>>>    }
>>>
>>>    static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
>>> @@ -430,6 +438,7 @@ static void update_temperature(struct th
>>>
>>>        tz->last_temperature = tz->temperature;
>>>        tz->temperature = temp;
>>> +     tz->recheck_delay_jiffies = 1;
>>>
>>>        trace_thermal_temperature(tz);
>>>
>>> @@ -514,7 +523,7 @@ void __thermal_zone_device_update(struct
>>>        update_temperature(tz);
>>>
>>>        if (tz->temperature == THERMAL_TEMP_INVALID)
>>> -             return;
>>> +             goto monitor;
>>>
>>>        tz->notify_event = event;
>>>
>>> @@ -536,6 +545,7 @@ void __thermal_zone_device_update(struct
>>>
>>>        thermal_debug_update_trip_stats(tz);
>>>
>>> +monitor:
>>>        monitor_thermal_zone(tz);
>>>    }
>>>
>>> @@ -1438,6 +1448,7 @@ thermal_zone_device_register_with_trips(
>>>
>>>        thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>>>        thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
>>> +     tz->recheck_delay_jiffies = 1;
>>>
>>>        /* sys I/F */
>>>        /* Add nodes that are always present via .groups */
>>> Index: linux-pm/drivers/thermal/thermal_core.h
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.h
>>> +++ linux-pm/drivers/thermal/thermal_core.h
>>> @@ -67,6 +67,8 @@ struct thermal_governor {
>>>     * @polling_delay_jiffies: number of jiffies to wait between polls when
>>>     *                  checking whether trip points have been crossed (0 for
>>>     *                  interrupt driven systems)
>>> + * @recheck_delay_jiffies: delay after a failed thermal zone temperature check
>>> + *                   before attempting to check it again
>>>     * @temperature:    current temperature.  This is only for core code,
>>>     *                  drivers should use thermal_zone_get_temp() to get the
>>>     *                  current temperature
>>> @@ -108,6 +110,7 @@ struct thermal_zone_device {
>>>        int num_trips;
>>>        unsigned long passive_delay_jiffies;
>>>        unsigned long polling_delay_jiffies;
>>> +     unsigned long recheck_delay_jiffies;
>>>        int temperature;
>>>        int last_temperature;
>>>        int emul_temperature;
>>> @@ -133,6 +136,12 @@ struct thermal_zone_device {
>>>        struct thermal_trip_desc trips[] __counted_by(num_trips);
>>>    };
>>>
>>> +/*
>>> + * Maximum delay after a failing thermal zone temperature check before
>>> + * attempting to check it again (in jiffies).
>>> + */
>>> +#define THERMAL_MAX_RECHECK_DELAY    (30 * HZ)
>>> +
>>>    /* Default Thermal Governor */
>>>    #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
>>>    #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
>>>
>>>
>>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


