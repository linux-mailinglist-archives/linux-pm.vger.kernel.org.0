Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3E2D10BA
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 13:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgLGMlz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 07:41:55 -0500
Received: from foss.arm.com ([217.140.110.172]:49554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgLGMlz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Dec 2020 07:41:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 420C31042;
        Mon,  7 Dec 2020 04:41:09 -0800 (PST)
Received: from [10.57.29.223] (unknown [10.57.29.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 842E63F718;
        Mon,  7 Dec 2020 04:41:06 -0800 (PST)
Subject: Re: [PATCH v2 2/5] thermal: devfreq_cooling: get a copy of device
 status
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <947a3afc-5dd6-892b-6987-ad81a5a96197@arm.com>
Date:   Mon, 7 Dec 2020 12:41:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <224c6b9b-977a-d553-f22b-2056223a84bc@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/3/20 4:09 PM, Daniel Lezcano wrote:
> On 03/12/2020 16:38, Lukasz Luba wrote:
>>
>>
>> On 12/3/20 1:09 PM, Daniel Lezcano wrote:
>>> On 18/11/2020 13:03, Lukasz Luba wrote:
>>>> Devfreq cooling needs to now the correct status of the device in order
>>>> to operate. Do not rely on Devfreq last_status which might be a stale
>>>> data
>>>> and get more up-to-date values of the load.
>>>>
>>>> Devfreq framework can change the device status in the background. To
>>>> mitigate this situation make a copy of the status structure and use it
>>>> for internal calculations.
>>>>
>>>> In addition this patch adds normalization function, which also makes
>>>> sure
>>>> that whatever data comes from the device, it is in a sane range.
>>>>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> ---
>>>>    drivers/thermal/devfreq_cooling.c | 52 +++++++++++++++++++++++++------
>>>>    1 file changed, 43 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/devfreq_cooling.c
>>>> b/drivers/thermal/devfreq_cooling.c
>>>> index 659c0143c9f0..925523694462 100644
>>>> --- a/drivers/thermal/devfreq_cooling.c
>>>> +++ b/drivers/thermal/devfreq_cooling.c
>>>> @@ -227,20 +227,46 @@ static inline unsigned long
>>>> get_total_power(struct devfreq_cooling_device *dfc,
>>>>                                       voltage);
>>>>    }
>>>>    +static void _normalize_load(struct devfreq_dev_status *status)
>>>> +{
>>>> +    /* Make some space if needed */
>>>> +    if (status->busy_time > 0xffff) {
>>>> +        status->busy_time >>= 10;
>>>> +        status->total_time >>= 10;
>>>> +    }
>>>> +
>>>> +    if (status->busy_time > status->total_time)
>>>> +        status->busy_time = status->total_time;
>>>
>>> How the condition above is possible?
>>
>> They should, be checked by the driver, but I cannot trust
>> and have to check for all corner cases: (div by 0, overflow
>> one of them, etc). The busy_time and total_time are unsigned long,
>> which means 4B on 32bit machines.
>> If these values are coming from device counters, which count every
>> busy cycle and total cycles of a clock of a device running at e.g.
>> 1GHz they would overflow every ~4s.
> 
> I don't think it is up to this routine to check the driver is correctly
> implemented, especially at every call to get_requested_power.
> 
> If the normalization ends up by doing this kind of thing, there is
> certainly something wrong in the 'status' computation to be fixed before
> submitting this series.
> 
> 
>> Normally IPA polling are 1s and 100ms, it's platform specific. But there
>> are also 'empty' periods when IPA sees temperature very low and does not
>> even call the .get_requested_power() callbacks for the cooling devices,
>> just grants max freq to all. This is problematic. I am investigating it
>> and will propose a solution for IPA soon.
>>
>> I would avoid all of this if devfreq core would have default for all
>> devices a reliable polling timer... Let me check some possibilities also
>> for this case.
> 
> Ok, may be create an API to compute the 'idle,busy,total times' to be
> used by the different the devfreq drivers and then fix the overflow in
> this common place.

Yes, I have this plan, but I have to close this patch series. To go
forward with this, I will drop the normalization function and will keep
only the code of safe copy of the 'status', so using busy_time and
total_time will be safe.

I will address this computation and normalization in different patch
series. There might be a need of a new API as you pointed out, which
is out-of-scope of this patch set.

> 
>>>> +    status->busy_time *= 100;
>>>> +    status->busy_time /= status->total_time ? : 1;
>>>> +
>>>> +    /* Avoid division by 0 */
>>>> +    status->busy_time = status->busy_time ? : 1;
>>>> +    status->total_time = 100;
>>>
>>> Why not base the normalization on 1024? and use an intermediate u64.
>>
>> You are the 2nd reviewer who is asking this. I tried to keep 'load' as
>> in range [0, 100] since we also have 'load' in cpufreq cooling in this
>> range. Maybe I should switch to 1024 (Ionela was also asking for this).
> 
> Well it is common practice to compute normalization with 1024 because
> the division is a bit shift and the compiler optimize the code very well
> with that value.
> 

I will keep this 1024 in mind for the next topic series.

Regards,
Lukasz
