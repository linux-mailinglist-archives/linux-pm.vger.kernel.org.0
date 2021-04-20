Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49E536608A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 22:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhDTUC1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 16:02:27 -0400
Received: from foss.arm.com ([217.140.110.172]:42066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233751AbhDTUC0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 16:02:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CEDB106F;
        Tue, 20 Apr 2021 13:01:54 -0700 (PDT)
Received: from [10.57.29.84] (unknown [10.57.29.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD1CC3F73B;
        Tue, 20 Apr 2021 13:01:52 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal: power_allocator: update once cooling
 devices when temp is low
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210419084536.25000-1-lukasz.luba@arm.com>
 <20210419084536.25000-3-lukasz.luba@arm.com>
 <c69e2ba0-b382-01a0-292f-019fffd365e0@linaro.org>
 <55943d6f-0f72-215d-1dd4-bf3996092df7@arm.com>
 <91411c9c-d78e-8ba6-1cd3-da6879bc5ceb@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <0fc57590-cc7c-9e04-16bc-13b7b787ad2f@arm.com>
Date:   Tue, 20 Apr 2021 21:01:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <91411c9c-d78e-8ba6-1cd3-da6879bc5ceb@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/20/21 4:24 PM, Daniel Lezcano wrote:
> On 20/04/2021 16:21, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> On 4/20/21 2:30 PM, Daniel Lezcano wrote:
>>> On 19/04/2021 10:45, Lukasz Luba wrote:
>>
>> [snip]
>>
>>>> -        instance->cdev->updated = false;
>>>> +        if (update)
>>>> +            instance->cdev->updated = false;
>>>> +
>>>>            mutex_unlock(&instance->cdev->lock);
>>>> -        (instance->cdev);
>>>> +
>>>> +        if (update)
>>>> +            thermal_cdev_update(instance->cdev);
>>>
>>> This cdev update has something bad IMHO. It is protected by a mutex but
>>> the 'updated' field is left unprotected before calling
>>> thermal_cdev_update().
>>>
>>> It is not the fault of this code but how the cooling device are updated
>>> and how it interacts with the thermal instances.
>>>
>>> IMO, part of the core code needs to revisited.
>>
>> I agree, but please check my comments below.
>>
>>>
>>> This change tight a bit more the knot.
>>>
>>> Would it make sense to you if we create a function eg.
>>> __thermal_cdev_update()
>>
>> I'm not sure if I assume it right that the function would only have the:
>> list_for_each_entry(instance, &cdev->thermal_instances, cdev_node)
>>
>> loop from the thermal_cdev_update(). But if it has only this loop then
>> it's too little.
>>
>>>
>>> And then we have:
>>>
>>> void thermal_cdev_update(struct thermal_cooling_device *cdev)
>>> {
>>>           mutex_lock(&cdev->lock);
>>>           /* cooling device is updated*/
>>>           if (cdev->updated) {
>>>                   mutex_unlock(&cdev->lock);
>>>                   return;
>>>           }
>>>
>>>      __thermal_cdev_update(cdev);
>>>
>>>           thermal_cdev_set_cur_state(cdev, target);
>>
>> Here we are actually setting the 'target' state via:
>> cdev->ops->set_cur_state(cdev, target)
>>
>> then we notify, then updating stats.
>>
>>>
>>>           cdev->updated = true;
>>>           mutex_unlock(&cdev->lock);
>>>           trace_cdev_update(cdev, target);
>>
>> Also this trace is something that I'm using in my tests...
> 
> Yeah, I noticed right after sending the comments. All that should be
> moved in the lockless function.

Agree

> 
> So this function becomes:
> 
> void thermal_cdev_update(struct thermal_cooling_device *cdev)
> {
> 	mutex_lock(&cdev->lock);
> 	if (!cdev->updated) {
> 		__thermal_cdev_update(cdev);
> 		cdev->updated = true;
> 	}
> 	mutex_unlock(&cdev->lock);
> 
> 	dev_dbg(&cdev->device, "set to state %lu\n", target);
> }
> 
> We end up with the trace_cdev_update(cdev, target) inside the mutex
> section but that should be fine.

True, this shouldn't be an issue.

> 
>>>           dev_dbg(&cdev->device, "set to state %lu\n", target);
>>> }
>>>
>>> And in this file we do instead:
>>>
>>> -        instance->cdev->updated = false;
>>> +        if (update)
>>> +            __thermal_cdev_update(instance->cdev);
>>>             mutex_unlock(&instance->cdev->lock);
>>> -        thermal_cdev_update(instance->cdev);
>>
>> Without the line above, we are not un-throttling the devices.
> 
> Is it still true with the amended function thermal_cdev_update() ?
> 
> 

That new approach should work. I can test your patch with this new
functions and re-base my work on top of it.
Or you like me to write such patch and send it?
