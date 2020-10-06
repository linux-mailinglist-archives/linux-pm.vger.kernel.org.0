Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60AC284E3D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 16:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgJFOqv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 10:46:51 -0400
Received: from foss.arm.com ([217.140.110.172]:49124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgJFOqv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Oct 2020 10:46:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 408791476;
        Tue,  6 Oct 2020 07:46:50 -0700 (PDT)
Received: from [10.57.54.147] (unknown [10.57.54.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B2433F71F;
        Tue,  6 Oct 2020 07:46:46 -0700 (PDT)
Subject: Re: [PATCH] thermal: power_allocate: add upper and lower limits
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200424071601.2636-1-michael.kao@mediatek.com>
 <accb83e0-ffbe-b6e3-6bf9-e7cc8b9fe19c@arm.com>
 <1588156776.3573.1.camel@mtksdccf07>
 <03286571-c110-7f5e-a911-24f8c3e4fd42@arm.com>
 <1598347775.16267.0.camel@mtksdccf07>
 <25cb2d5b-0d87-8a22-a881-a5b6e46307ec@arm.com>
Message-ID: <77bd14bb-0318-332a-4ea1-f60a314ce3be@arm.com>
Date:   Tue, 6 Oct 2020 15:46:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <25cb2d5b-0d87-8a22-a881-a5b6e46307ec@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/6/20 3:39 PM, Lukasz Luba wrote:
> Hi Michael,
> 
> On 8/25/20 10:29 AM, Michael Kao wrote:
>> On Wed, 2020-04-29 at 21:24 +0100, Lukasz Luba wrote:
>>>
>>> On 4/29/20 11:39 AM, Michael Kao wrote:
>>>> On Fri, 2020-04-24 at 10:22 +0100, Lukasz Luba wrote:
>>>>> Hi Michael,
>>>>>
>>>>> On 4/24/20 8:16 AM, Michael Kao wrote:
>>>>>> The upper and lower limits of thermal throttle state in the
>>>>>> device tree do not apply to the power_allocate governor.
>>>>>> Add the upper and lower limits to the power_allocate governor.
>>>>>>
>>>>>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
>>>>>> ---
>>>>>>     drivers/thermal/thermal_core.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/thermal/thermal_core.c 
>>>>>> b/drivers/thermal/thermal_core.c
>>>>>> index 9a321dc548c8..f6feed2265bd 100644
>>>>>> --- a/drivers/thermal/thermal_core.c
>>>>>> +++ b/drivers/thermal/thermal_core.c
>>>>>> @@ -598,7 +598,7 @@ int power_actor_set_power(struct 
>>>>>> thermal_cooling_device *cdev,
>>>>>>         if (ret)
>>>>>>             return ret;
>>>>>> -    instance->target = state;
>>>>>> +    instance->target = clamp_val(state, instance->lower, 
>>>>>> instance->upper);
>>>>>>         mutex_lock(&cdev->lock);
>>>>>>         cdev->updated = false;
>>>>>>         mutex_unlock(&cdev->lock);
>>>>>>
>>>>>
>>>>> Thank you for the patch and having to look at it. I have some concerns
>>>>> with this approach. Let's analyze it further.
>>>>>
>>>>> In default the cooling devices in the thermal zone which is used by 
>>>>> IPA
>>>>> do not have this 'lower' and 'upper' limits. They are set to
>>>>> THERMAL_NO_LIMIT in DT to give full control to IPA over the states.
>>>>>
>>>>> This the function 'power_actor_set_power' actually translates granted
>>>>> power to the state that device will run for the next period.
>>>>> The IPA algorithm has already split the power budget.
>>>>> Now what happen when the 'lower' value will change the state to a 
>>>>> state
>>>>> which consumes more power than was calculated in the IPA alg... It 
>>>>> will
>>>>> became unstable.
>>>>>
>>>>> I would rather see a change which uses these 'lower' and 'upper' 
>>>>> limits
>>>>> before the IPA do the calculation of the power budget. But this wasn't
>>>>> a requirement and we assumed that IPA has full control over the 
>>>>> cooling
>>>>> device (which I described above with this DT THERMAL_NO_LIMIT).
>>>>>
>>>>> Is there a problem with your platform that it has to provide some
>>>>> minimal performance, so you tried to introduce this clamping?
>>>>>
>>>>> Regards,
>>>>> Lukasz
>>>>
>>>>
>>>> Hi Lukasz,
>>>>
>>>> I refer to the documentation settings of the thermal device tree
>>>> (Documentation / devicetree / bindings / thermal / thermal.txt).
>>>>
>>>> It shows that cooling-device is a mandatory property, so max/min 
>>>> cooling
>>>> state should be able to support in framework point of view.
>>>> Otherwise, the limitation should be added in binding document.
>>>>
>>>> Different hardware mechanisms have different heat dissipation
>>>> capabilities.
>>>> Limiting the input heat source can slow down the heat accumulation and
>>>> temperature burst.
>>>> We want to reduce the accumulation of heat at high temperature by
>>>> limiting the minimum gear of thermal throttle.
>>>
>>> I agree that these 'lower' and 'upper' limits shouldn't be just
>>> ignored as is currently. This patch clamps the value at late stage,
>>> though.
>>>
>>> Let me have a look how it could be taken into account in the early
>>> stage, before the power calculation and split are done. Maybe there
>>> is a clean way to inject this.
>>>
>>> Regards,
>>> Lukasz
>> Hi Lukasz,
>>
>> After the research, do you have any ideas or suggestions?
>>
>> Best Regards,
>> Michael
>>
> 
> My apologies for the delay. I have done some experiments.
> Could you resend the patch, please make sure it is not encoded in base64
> like this one.
> 
> I am going to take your patch together with some other changes.
> 
> Regards,
> Lukasz

Please change also the commit message to something like:

thermal: core: add upper and lower limits to power_actor_set_power

The upper and lower limits of thermal throttle state in the
DT do not apply to the Intelligent Power Allocation (IPA) governor.
Add the clamping for cooling device upper and lower limits in the
power_actor_set_power() used by IPA.

Regards,
Lukasz



