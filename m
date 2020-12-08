Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A7A2D2CFE
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgLHOVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 09:21:22 -0500
Received: from foss.arm.com ([217.140.110.172]:49658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgLHOVV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 09:21:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFA9613D5;
        Tue,  8 Dec 2020 06:20:35 -0800 (PST)
Received: from [10.57.23.55] (unknown [10.57.23.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A96B3F718;
        Tue,  8 Dec 2020 06:20:33 -0800 (PST)
Subject: Re: [PATCH v2 2/5] thermal: devfreq_cooling: get a copy of device
 status
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, ionela.voinescu@arm.com
References: <20201118120358.17150-1-lukasz.luba@arm.com>
 <20201118120358.17150-3-lukasz.luba@arm.com>
 <5d4743b9-5b2f-8494-8d10-6a5fd2c0fdfd@linaro.org>
 <d9906ed8-e3bf-5e42-2e43-09071848ae48@arm.com>
 <224c6b9b-977a-d553-f22b-2056223a84bc@linaro.org>
 <947a3afc-5dd6-892b-6987-ad81a5a96197@arm.com>
Message-ID: <9b19373f-2dd9-368c-6d38-cd885fcde5e1@arm.com>
Date:   Tue, 8 Dec 2020 14:20:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <947a3afc-5dd6-892b-6987-ad81a5a96197@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 12/7/20 12:41 PM, Lukasz Luba wrote:
> 
> 
> On 12/3/20 4:09 PM, Daniel Lezcano wrote:
>> On 03/12/2020 16:38, Lukasz Luba wrote:
>>>
>>>
>>> On 12/3/20 1:09 PM, Daniel Lezcano wrote:
>>>> On 18/11/2020 13:03, Lukasz Luba wrote:
>>>>> Devfreq cooling needs to now the correct status of the device in order
>>>>> to operate. Do not rely on Devfreq last_status which might be a stale
>>>>> data
>>>>> and get more up-to-date values of the load.
>>>>>
>>>>> Devfreq framework can change the device status in the background. To
>>>>> mitigate this situation make a copy of the status structure and use it
>>>>> for internal calculations.
>>>>>
>>>>> In addition this patch adds normalization function, which also makes
>>>>> sure
>>>>> that whatever data comes from the device, it is in a sane range.
>>>>>
>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> ---
>>>>>    drivers/thermal/devfreq_cooling.c | 52 
>>>>> +++++++++++++++++++++++++------
>>>>>    1 file changed, 43 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/thermal/devfreq_cooling.c
>>>>> b/drivers/thermal/devfreq_cooling.c
>>>>> index 659c0143c9f0..925523694462 100644
>>>>> --- a/drivers/thermal/devfreq_cooling.c
>>>>> +++ b/drivers/thermal/devfreq_cooling.c
>>>>> @@ -227,20 +227,46 @@ static inline unsigned long
>>>>> get_total_power(struct devfreq_cooling_device *dfc,
>>>>>                                       voltage);
>>>>>    }
>>>>>    +static void _normalize_load(struct devfreq_dev_status *status)
>>>>> +{
>>>>> +    /* Make some space if needed */
>>>>> +    if (status->busy_time > 0xffff) {
>>>>> +        status->busy_time >>= 10;
>>>>> +        status->total_time >>= 10;
>>>>> +    }
>>>>> +
>>>>> +    if (status->busy_time > status->total_time)
>>>>> +        status->busy_time = status->total_time;
>>>>
>>>> How the condition above is possible?
>>>
>>> They should, be checked by the driver, but I cannot trust
>>> and have to check for all corner cases: (div by 0, overflow
>>> one of them, etc). The busy_time and total_time are unsigned long,
>>> which means 4B on 32bit machines.
>>> If these values are coming from device counters, which count every
>>> busy cycle and total cycles of a clock of a device running at e.g.
>>> 1GHz they would overflow every ~4s.
>>
>> I don't think it is up to this routine to check the driver is correctly
>> implemented, especially at every call to get_requested_power.
>>
>> If the normalization ends up by doing this kind of thing, there is
>> certainly something wrong in the 'status' computation to be fixed before
>> submitting this series.
>>
>>
>>> Normally IPA polling are 1s and 100ms, it's platform specific. But there
>>> are also 'empty' periods when IPA sees temperature very low and does not
>>> even call the .get_requested_power() callbacks for the cooling devices,
>>> just grants max freq to all. This is problematic. I am investigating it
>>> and will propose a solution for IPA soon.
>>>
>>> I would avoid all of this if devfreq core would have default for all
>>> devices a reliable polling timer... Let me check some possibilities also
>>> for this case.
>>
>> Ok, may be create an API to compute the 'idle,busy,total times' to be
>> used by the different the devfreq drivers and then fix the overflow in
>> this common place.
> 
> Yes, I have this plan, but I have to close this patch series. To go
> forward with this, I will drop the normalization function and will keep
> only the code of safe copy of the 'status', so using busy_time and
> total_time will be safe.

I did experiments and actually I cannot drop this function. Drivers can
feed total_time and busy_time which are in nanoseconds, e.g. [1] 50ms =>
50.000.000ns which is then when multiplied by 1024  and exceed the u32.
I want to avoid 64bit variables and divisions, so shifting them earlier
would help. IMHO it does not harm this devfreq cooling to make that
check and handle ns values.

I am going to use the normalization into 0..1024 as you and Ionela
suggested.
I will also drop the direct device status check. That would be a
different patch series. In that patch set I will try to come with a
generic solution and some API.

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/v5.10-rc5/source/drivers/gpu/drm/panfrost/panfrost_devfreq.c#L66
