Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48628E3F5
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 18:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgJNQGA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 12:06:00 -0400
Received: from foss.arm.com ([217.140.110.172]:52532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbgJNQGA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Oct 2020 12:06:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D254D6E;
        Wed, 14 Oct 2020 09:06:00 -0700 (PDT)
Received: from [10.57.50.223] (unknown [10.57.50.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1544B3F71F;
        Wed, 14 Oct 2020 09:05:57 -0700 (PDT)
Subject: Re: [PATCH 1/3] thermal: power_allocator: respect upper and lower
 bounds for cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, Dietmar.Eggemann@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
References: <20201007122256.28080-1-lukasz.luba@arm.com>
 <20201007122256.28080-2-lukasz.luba@arm.com>
 <64ac12ca-9d7a-11f1-f935-0eb96dc6355b@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b280a851-a4ea-490e-8cee-327bc34ee8b9@arm.com>
Date:   Wed, 14 Oct 2020 17:05:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <64ac12ca-9d7a-11f1-f935-0eb96dc6355b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/14/20 1:31 PM, Daniel Lezcano wrote:
> On 07/10/2020 14:22, Lukasz Luba wrote:
>> The thermal cooling device specified in DT might be instantiated for
>> a thermal zone trip point with a limited set of OPPs to operate on. This
>> configuration should be supported by Intelligent Power Allocation (IPA),
>> since it is a standard for other governors. Change the code and allow IPA
>> to get power value of lower and upper bound set for a given cooling
>> device.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index dd59085f38f5..f9ee7787b325 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -96,7 +96,8 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
>>   		if (instance->trip != params->trip_max_desired_temperature)
>>   			continue;
>>   
>> -		if (power_actor_get_min_power(cdev, tz, &min_power))
>> +		if (cdev->ops->state2power(cdev, tz, instance->upper,
>> +					   &min_power))
> 
> 	if (cdev->ops->state2power && cdev->ops->state2power(cdev, tz,
> 							instance->upper,
> 							&min_power))
> 
> ?


Yes, worth to check. I had this in [1] and missed it here while playing
with re-base of these patch series and other test branches.

I will send v2 with the needed cdev_is_power_actor() check.

> 
>>   			continue;
>>   
>>   		sustainable_power += min_power;
>> @@ -404,7 +405,8 @@ static int allocate_power(struct thermal_zone_device *tz,
>>   
>>   		weighted_req_power[i] = frac_to_int(weight * req_power[i]);
>>   
>> -		if (power_actor_get_max_power(cdev, tz, &max_power[i]))
>> +		if (cdev->ops->state2power(cdev, tz, instance->lower,
>> +					   &max_power[i]))
>>   			continue;
> 
> Same here ?

Inside that loop we check (just a few lines above):

		if (!cdev_is_power_actor(cdev))
			continue;

then we call this:

		if (cdev->ops->state2power(cdev, tz, instance->lower,
					&max_power[i]))

So it should be safe.

> 
>>   		total_req_power += req_power[i];
>>
> 
> 

Thank you Daniel for reviewing this.

Regards,
Lukasz

[1] 
https://lore.kernel.org/linux-pm/20201008170426.465-3-lukasz.luba@arm.com/
