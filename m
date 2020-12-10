Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27D12D5C0E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 14:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbgLJNiV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 08:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389575AbgLJNiK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 08:38:10 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22038C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 05:37:30 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m5so5501938wrx.9
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 05:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oRtoQvl6MRwwbBwu+OqoR6Ch7qCnEu5Xnq7MBfAyxbo=;
        b=cfiQdQ57fyFjf+aeE5qdCw7XNDFrO5g6gYq+9m4593bVy09IxHbnfPqbmaboucXXF5
         gVWFQ0psB4TU8rwIgphClPaUu1c1W2G2eHgmsfeeYjJKiJe6BWaZ/9NhIc43QCEdNJAk
         NU4NX/qrUnwWtnJTTasf3wpxSQfg51ZTuvH/ys+sKpxrHTh0p3/AcZk+dQDrUkv9nGEf
         eA9hi5BfIYeWW2cfrpLzVcVoFyHJUmdLyuN+3P7hNRE9YzI36hp3B69gtWr09OZaJcR1
         nS+7wPbdlm05JL8d8ehe13RcTCobIxyCLMfdP05bq9AGdRYvD+s5/ACANmLjW9YwAjDv
         /UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oRtoQvl6MRwwbBwu+OqoR6Ch7qCnEu5Xnq7MBfAyxbo=;
        b=L7ISR5/dc5aAA5tSpmY/leCdkNCarHmwxTF1htu+tF2W0p7nu0vHW6YRWdadwAASq7
         ryYWQ5Q1YhHSRWDduPfZHs0g32sxkkaaPa03xEtnbjhaiP4RjOXXa5Ld0cs8LKtEGDWP
         PX94K8c/Z8JlNTkroxItX15kw1id6MdrRXfb3DOjmSR9YYm42gcCTtMKljc75XTbe7Rf
         zI9LlY0HlyecMLojvjlKbbRiTRKGy5+FIvU6KSZs1vRtXtmH6DfUIt0jq9Y7bxKswu5w
         68aB7KZPusplq4032IlMFKqYR3zDyoQDxVXCF6pQo+S803gmobpAQHmsojza3FHG9+56
         fh2Q==
X-Gm-Message-State: AOAM5320k85OgyUjGcubPTYJYZ0noeLCkiP1BKw7YljttUYYEt62ulrU
        xAJFmSOrFIHwi+/yp61/mijIMA==
X-Google-Smtp-Source: ABdhPJwCCzpOMSIxWJQznXzFX6b1+JYQPsqyyFO/88xv27PsxliFuoQMvIjIx6fpO6qMgtHZVN9t0A==
X-Received: by 2002:a5d:5604:: with SMTP id l4mr8256266wrv.127.1607607448711;
        Thu, 10 Dec 2020 05:37:28 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4ea:d408:1aec:e109? ([2a01:e34:ed2f:f020:4ea:d408:1aec:e109])
        by smtp.googlemail.com with ESMTPSA id n123sm9591223wmn.7.2020.12.10.05.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 05:37:28 -0800 (PST)
Subject: Re: [PATCH 2/5] thermal/core: Add critical and hot ops
To:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
 <20201210121514.25760-2-daniel.lezcano@linaro.org>
 <fd9b262a-cb9a-bd88-5790-0ca5f9a7bdad@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <565c354e-0850-47f3-ad58-ee28fdedcfb2@linaro.org>
Date:   Thu, 10 Dec 2020 14:37:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fd9b262a-cb9a-bd88-5790-0ca5f9a7bdad@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/12/2020 13:44, Lukasz Luba wrote:
> 
> 
> On 12/10/20 12:15 PM, Daniel Lezcano wrote:
>> Currently there is no way to the sensors to directly call an ops in
>> interrupt mode without calling thermal_zone_device_update assuming all
>> the trip points are defined.
>>
>> A sensor may want to do something special if a trip point is hot or
>> critical.
>>
>> This patch adds the critical and hot ops to the thermal zone device,
>> so a sensor can directly invoke them or let the thermal framework to
>> call the sensor specific ones.
>>
>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/thermal_core.c | 43 +++++++++++++++++++++-------------
>>   include/linux/thermal.h        |  3 +++
>>   2 files changed, 30 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c
>> index e6771e5aeedb..cee0b31b5cd7 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -375,6 +375,25 @@ static void thermal_emergency_poweroff(void)
>>                     msecs_to_jiffies(poweroff_delay_ms));
>>   }
>>   +void thermal_zone_device_critical(struct thermal_zone_device *tz)
>> +{
>> +    dev_emerg(&tz->device, "%s: critical temperature reached, "
>> +          "shutting down\n", tz->type);
>> +
>> +    mutex_lock(&poweroff_lock);
>> +    if (!power_off_triggered) {
>> +        /*
>> +         * Queue a backup emergency shutdown in the event of
>> +         * orderly_poweroff failure
>> +         */
>> +        thermal_emergency_poweroff();
>> +        orderly_poweroff(true);
>> +        power_off_triggered = true;
>> +    }
>> +    mutex_unlock(&poweroff_lock);
>> +}
>> +EXPORT_SYMBOL(thermal_zone_device_critical);
>> +
>>   static void handle_critical_trips(struct thermal_zone_device *tz,
>>                     int trip, enum thermal_trip_type trip_type)
>>   {
>> @@ -391,22 +410,10 @@ static void handle_critical_trips(struct
>> thermal_zone_device *tz,
>>       if (tz->ops->notify)
>>           tz->ops->notify(tz, trip, trip_type);
>>   -    if (trip_type == THERMAL_TRIP_CRITICAL) {
>> -        dev_emerg(&tz->device,
>> -              "critical temperature reached (%d C), shutting down\n",
>> -              tz->temperature / 1000);
>> -        mutex_lock(&poweroff_lock);
>> -        if (!power_off_triggered) {
>> -            /*
>> -             * Queue a backup emergency shutdown in the event of
>> -             * orderly_poweroff failure
>> -             */
>> -            thermal_emergency_poweroff();
>> -            orderly_poweroff(true);
>> -            power_off_triggered = true;
>> -        }
>> -        mutex_unlock(&poweroff_lock);
>> -    }
>> +    if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
>> +        tz->ops->hot(tz);
>> +    else if (trip_type == THERMAL_TRIP_CRITICAL)
>> +        tz->ops->critical(tz);
> 
> I can see that in the patch 3/5 there driver .critical() callback
> calls framework thermal_zone_device_critical() at the end.
> I wonder if we could always call this framework function.

It is actually done on purpose, we want to let the driver to handle the
critical routine which may not end up with an emergency shutdown.

[ ... ]

>>   #else
>>   static inline struct thermal_zone_device *thermal_zone_device_register(
>>       const char *type, int trips, int mask, void *devdata,
>>
> 
> I am just concerned about drivers which provide own .critical() callback
> but forgot to call thermal_zone_device_critical() at the end and
> framework could skip it.
> 
> Or we can make sure during the review that it's not an issue (and ignore
> out of tree drivers)?

Yes, the framework guarantees if the critical trip point is crossed we
call the emergency shutdown by default. If the driver choose to override
it, it takes responsibility of the change.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
