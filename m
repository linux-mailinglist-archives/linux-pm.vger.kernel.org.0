Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95ED02D2DA1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 15:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgLHO5C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 09:57:02 -0500
Received: from foss.arm.com ([217.140.110.172]:50138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729837AbgLHO5C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 09:57:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F33561FB;
        Tue,  8 Dec 2020 06:56:15 -0800 (PST)
Received: from [10.57.23.55] (unknown [10.57.23.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91AC33F718;
        Tue,  8 Dec 2020 06:56:14 -0800 (PST)
Subject: Re: [PATCH] thermal/core: Emit a warning if the thermal zone is
 updated without ops
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201207190530.30334-1-daniel.lezcano@linaro.org>
 <2b8ce280-cb91-fb23-d19a-00dcee2a3e5a@arm.com>
 <81e25f27-344e-f6c2-5f08-68068348f7ba@linaro.org>
 <dd5f9f97-ab30-5bb0-1211-66d211035968@arm.com>
Message-ID: <d1d2c723-8f1f-fc68-0cdf-d26d8373b417@arm.com>
Date:   Tue, 8 Dec 2020 14:56:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dd5f9f97-ab30-5bb0-1211-66d211035968@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/8/20 2:37 PM, Lukasz Luba wrote:
> 
> 
> On 12/8/20 1:51 PM, Daniel Lezcano wrote:
>>
>> Hi Lukasz,
>>
>> On 08/12/2020 10:36, Lukasz Luba wrote:
>>> Hi Daniel,
>>
>> [ ... ]
>>
>>>>      static void thermal_zone_device_init(struct thermal_zone_device 
>>>> *tz)
>>>> @@ -553,11 +555,9 @@ void thermal_zone_device_update(struct
>>>> thermal_zone_device *tz,
>>>>        if (atomic_read(&in_suspend))
>>>>            return;
>>>>    -    if (!tz->ops->get_temp)
>>>> +    if (update_temperature(tz))
>>>>            return;
>>>>    -    update_temperature(tz);
>>>> -
>>>
>>> I think the patch does a bit more. Previously we continued running the
>>> code below even when the thermal_zone_get_temp() returned an error (due
>>> to various reasons). Now we stop and probably would not schedule next
>>> polling, not calling:
>>> handle_thermal_trip() and monitor_thermal_zone()
>>
>> I agree there is a change in the behavior.
>>
>>> I would left update_temperature(tz) as it was and not check the return.
>>> The function thermal_zone_get_temp() can protect itself from missing
>>> tz->ops->get_temp(), so we should be safe.
>>>
>>> What do you think?
>>
>> Does it make sense to handle the trip point if we are unable to read the
>> temperature?
>>
>> The lines following the update_temperature() are:
>>
>>   - thermal_zone_set_trips() which needs a correct tz->temperature
>>
>>   - handle_thermal_trip() which needs a correct tz->temperature to
>> compare with
>>
>>   - monitor_thermal_zone() which needs a consistent tz->passive. This one
>> is updated by the governor which is in an inconsistent state because the
>> temperature is not updated.
>>
>> The problem I see here is how the interrupt mode and the polling mode
>> are existing in the same code path.
>>
>> The interrupt mode can call thermal_notify_framework() for critical/hot
>> trip points without being followed by a monitoring. But for the other
>> trip points, the get_temp is needed.
> 
> Yes, I agree that we can bail out when there is no .get_temp() callback
> and even not schedule next polling in such case.
> But I am just not sure if we can bail out and not schedule the next
> polling, when there is .get_temp() populated and the driver returned
> an error only at that moment, e.g. indicating some internal temporary,
> issue like send queue full, so such as -EBUSY, or -EAGAIN, etc.
> The thermal_zone_get_temp() would pass the error to update_temperature()
> but we return, losing the next try. We would not check the temperature
> again.
> 

Some links to point you to such code where sensor has to deal
with protocol and various error reasons [1][2][3]


[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/firmware/arm_scmi/sensors.c#L230
[2] 
https://elixir.bootlin.com/linux/latest/source/drivers/firmware/arm_scmi/driver.c#L425
[3] 
https://elixir.bootlin.com/linux/latest/source/drivers/firmware/arm_scmi/driver.c#L474
