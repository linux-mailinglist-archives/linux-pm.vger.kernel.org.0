Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B612D4212
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 13:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbgLIMVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 07:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731426AbgLIMVH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 07:21:07 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647D5C0613CF
        for <linux-pm@vger.kernel.org>; Wed,  9 Dec 2020 04:20:27 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id i9so1520069wrc.4
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2020 04:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aHCC0yRuI2Aim1ZZrGfctlyo8NKoBLz1xesJmBQo8bs=;
        b=PQVtFyoXOjUSWtR0QJvOn8aslWm/UdWawnoWNycULCE2ti+XJj54hslJj7MmdfJQHP
         vvp+yY8grrMtvdvBLPTkvcpMa0TsLh391vZNEI6/ZGEpSpDt6XccPdtGGDSpjrkObqFE
         JkR8gJX2GFfegtnNRCxPwi3k4flMOZ+SIUTYOitNRJ1vp3OunYPaEP9awKKyrhQBgblC
         xgplTBBXa+uUWjUNyJ3MHfuYEKyGPbPL1JpvD6N8CjBJWasqJSlBOb453RU0a1NfsmY3
         H6/kOE7NI86AuJXx0yRKJZ8JocGPyzq59txDZcfLQNQyPGUBcMeH5LtDudLBJ8nNH8pj
         709A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aHCC0yRuI2Aim1ZZrGfctlyo8NKoBLz1xesJmBQo8bs=;
        b=F3uMr0WFahHaHOmpGzfncn4/CJbAae6l9gvL7KO0td6juQMhKwBAo2f6/YWhu3P1Z4
         gmNJA1OQE3NkuMzQIWlml+Y7CIte/pBqJdA4sfJEdmE+H7UCznygpzDN7/H6nESzb7F8
         pAZNyCx9X8Fs6LoOBgwzPmo1NTdQNVjBPmCFNP7Y6a8W3XrJ/Dcu6HWpOEgBBi7JThBn
         WJ5D589CEjsWOvUoIJNsqQj5igFKomb9kTj0aO8F5T34pGtR3HwBvjVFH762ogfpuBnt
         GOAnspYyoRR+QyHHEuwbsFLzA1blcT+QpT6oVt2REcgr4zZQVulXXAzXZx5Aq6kUvCPE
         YRbw==
X-Gm-Message-State: AOAM5322uY0Uwi4azTWAOGCk3H2A7fXYS41XaNnDEm5QVOLU97fojuFb
        7x+hSU6HqdJcGv6DYzSq8RekMQ==
X-Google-Smtp-Source: ABdhPJwCAx9d6RPtrhjLPCHIJkDSQRUPCHEEfrSRPfijPR0WZIwVheBUpkgD+CINnKd5rVQ68vS7iQ==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr79792wrc.411.1607516425978;
        Wed, 09 Dec 2020 04:20:25 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8cf2:3820:1fbd:70ad? ([2a01:e34:ed2f:f020:8cf2:3820:1fbd:70ad])
        by smtp.googlemail.com with ESMTPSA id l11sm2969614wmh.46.2020.12.09.04.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 04:20:25 -0800 (PST)
Subject: Re: [PATCH] thermal/core: Emit a warning if the thermal zone is
 updated without ops
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rui.zhang@intel.com, Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201207190530.30334-1-daniel.lezcano@linaro.org>
 <2b8ce280-cb91-fb23-d19a-00dcee2a3e5a@arm.com>
 <81e25f27-344e-f6c2-5f08-68068348f7ba@linaro.org>
 <dd5f9f97-ab30-5bb0-1211-66d211035968@arm.com>
 <7dff767d-3089-584e-f77d-33018faa38ea@linaro.org>
 <90989e59-f880-93df-7fbf-74c26fa8258f@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <652ae54b-45aa-eef2-bf96-b4eae941ef04@linaro.org>
Date:   Wed, 9 Dec 2020 13:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <90989e59-f880-93df-7fbf-74c26fa8258f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/12/2020 11:41, Lukasz Luba wrote:
> 
> 
> On 12/8/20 3:19 PM, Daniel Lezcano wrote:
>> On 08/12/2020 15:37, Lukasz Luba wrote:
>>>
>>>
>>> On 12/8/20 1:51 PM, Daniel Lezcano wrote:
>>>>
>>>> Hi Lukasz,
>>>>
>>>> On 08/12/2020 10:36, Lukasz Luba wrote:
>>>>> Hi Daniel,
>>>>
>>>> [ ... ]
>>>>
>>>>>>       static void thermal_zone_device_init(struct thermal_zone_device
>>>>>> *tz)
>>>>>> @@ -553,11 +555,9 @@ void thermal_zone_device_update(struct
>>>>>> thermal_zone_device *tz,
>>>>>>         if (atomic_read(&in_suspend))
>>>>>>             return;
>>>>>>     -    if (!tz->ops->get_temp)
>>>>>> +    if (update_temperature(tz))
>>>>>>             return;
>>>>>>     -    update_temperature(tz);
>>>>>> -
>>>>>
>>>>> I think the patch does a bit more. Previously we continued running the
>>>>> code below even when the thermal_zone_get_temp() returned an error
>>>>> (due
>>>>> to various reasons). Now we stop and probably would not schedule next
>>>>> polling, not calling:
>>>>> handle_thermal_trip() and monitor_thermal_zone()
>>>>
>>>> I agree there is a change in the behavior.
>>>>
>>>>> I would left update_temperature(tz) as it was and not check the
>>>>> return.
>>>>> The function thermal_zone_get_temp() can protect itself from missing
>>>>> tz->ops->get_temp(), so we should be safe.
>>>>>
>>>>> What do you think?
>>>>
>>>> Does it make sense to handle the trip point if we are unable to read
>>>> the
>>>> temperature?
>>>>
>>>> The lines following the update_temperature() are:
>>>>
>>>>    - thermal_zone_set_trips() which needs a correct tz->temperature
>>>>
>>>>    - handle_thermal_trip() which needs a correct tz->temperature to
>>>> compare with
>>>>
>>>>    - monitor_thermal_zone() which needs a consistent tz->passive.
>>>> This one
>>>> is updated by the governor which is in an inconsistent state because
>>>> the
>>>> temperature is not updated.
>>>>
>>>> The problem I see here is how the interrupt mode and the polling mode
>>>> are existing in the same code path.
>>>>
>>>> The interrupt mode can call thermal_notify_framework() for critical/hot
>>>> trip points without being followed by a monitoring. But for the other
>>>> trip points, the get_temp is needed.
>>>
>>> Yes, I agree that we can bail out when there is no .get_temp() callback
>>> and even not schedule next polling in such case.
>>> But I am just not sure if we can bail out and not schedule the next
>>> polling, when there is .get_temp() populated and the driver returned
>>> an error only at that moment, e.g. indicating some internal temporary,
>>> issue like send queue full, so such as -EBUSY, or -EAGAIN, etc.
>>> The thermal_zone_get_temp() would pass the error to update_temperature()
>>> but we return, losing the next try. We would not check the temperature
>>> again.
>>
>> Hmm, right. I agree with your point.
>>
>> What about the following changes:
>>
>>   - Add the new APIs:
>>
>>     thermal_zone_device_critical(struct thermal_zone_device *tz);
>>       => emergency poweroff
>>
>>     thermal_zone_device_hot(struct thermal_zone_device *tz);
>>       => userspace notification
>
> They look promising, I have to look into the existing code.
> When they would be called?

They can be called directly by the driver when there is no get_temp
callback instead of calling thermal_zone_device_update, and by the usual
code path via handle_critical_trip function.

Also that can solve the issue [1] when registering a device which is
already too hot [1] by adding the ops in the thermal zone.

[1] https://lkml.org/lkml/2020/11/28/166

>>   - Add a big fat WARN when thermal_zone_device_update is called with
>> .get_temp == NULL because that must not happen.
> 
> Good idea
> 
>>
>> If the .get_temp is NULL it is because we only have a HOT/CRITICAL
>> thermal trip points where we don't care about the temperature and
>> governor decision, right ?
>>
> 
> That is a good question. Let me dig into the code. I would say yes - we
> don't have to hassle with governor in this circumstances.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
