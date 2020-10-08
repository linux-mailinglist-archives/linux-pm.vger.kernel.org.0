Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ADF287451
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 14:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgJHMeq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 08:34:46 -0400
Received: from foss.arm.com ([217.140.110.172]:55118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbgJHMeo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 08:34:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 893DF1063;
        Thu,  8 Oct 2020 05:34:43 -0700 (PDT)
Received: from [10.57.48.204] (unknown [10.57.48.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 306A63F71F;
        Thu,  8 Oct 2020 05:34:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] thermal: power allocator: estimate sustainable power
 only once
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com
References: <20201002122416.13659-1-lukasz.luba@arm.com>
 <20201002122416.13659-3-lukasz.luba@arm.com> <20201008101434.GA23491@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d57cc0aa-01e4-e3b2-c591-be7e54f95780@arm.com>
Date:   Thu, 8 Oct 2020 13:34:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201008101434.GA23491@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela,

On 10/8/20 11:14 AM, Ionela Voinescu wrote:
> Hi Lukasz,
> 
> On Friday 02 Oct 2020 at 13:24:16 (+0100), Lukasz Luba wrote:
>> The sustainable power value might come from the Device Tree or can be
>> estimated in run time. There is no need to estimate every time when the
>> governor is called and temperature is high. Instead, store the estimated
>> value and make it available via standard sysfs interface so it can be
>> checked from the user-space.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index f69fafe486a5..dd59085f38f5 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -204,6 +204,8 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>>   		estimate_pid_constants(tz, sustainable_power,
>>   				       params->trip_switch_on, control_temp,
>>   				       true);
>> +		/* Do the estimation only once and make available in sysfs */
>> +		tz->tzp->sustainable_power = sustainable_power;
> 
> After looking over the code, it does seems mostly useless to do the
> estimation every time the controller kicks in.
> 
> But I have two comments in this regard:
> 
>   - The estimation is dependent on the temperature we control for which
>     can be changed from sysfs. While I don't see that as a big worry,
>     (sustainable power is an estimation anyway), it might be worth a
>     more detailed comment on why we don't expect this to be a problem,
>     or what we expect the consequences of computing sustainable power
>     only once could be.

The problem is that we don't expose the estimated value in the sysfs.
This is the case when there was no DT entry with 'sustainable-power'.
If someone is going to write the values via sysfs, we assume he/she
knows the consequences and also what other values to write and where,
to make it working optimally.

> 
>   - In the function comment for estimate_pid_constants() there is a
>     mention of sustainable power:
>     """
>      * Sustainable power is provided in case it was estimated.  The
>      * estimated sustainable_power should not be stored in the
>      * thermal_zone_parameters so it has to be passed explicitly to this
>      * function.
>     """

Good catch, that comment left. I will remove it.

>     If we are going to compute the sustainable power estimation only once,
>     this comment should be removed, the estimated value should be added to
>     the trip point parameters before estimate_pid_constants(), and the
>     sustainable_power argument should be removed.
>     Otherwise we end up with conflicting information in the code.

We can also call estimate_sustainable_power() inside the
estimate_pid_constants() if sust. power was 0, then set the
tz->tzp->sustainable_power = sustainable_power

Thank you for your comments.

Regards,
Lukasz

> 
> Regards,
> Ionela.
> 
