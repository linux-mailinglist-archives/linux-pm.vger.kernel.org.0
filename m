Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81742889D9
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 15:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbgJINbL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 09:31:11 -0400
Received: from foss.arm.com ([217.140.110.172]:51300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733281AbgJINbL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 09:31:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 712471063;
        Fri,  9 Oct 2020 06:31:10 -0700 (PDT)
Received: from [10.57.51.133] (unknown [10.57.51.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000493F70D;
        Fri,  9 Oct 2020 06:31:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] thermal: power allocator: change the 'k_i'
 coefficient estimation
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com
References: <20201008170426.465-1-lukasz.luba@arm.com>
 <20201008170426.465-2-lukasz.luba@arm.com> <20201009130539.GB5207@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e72f7bf9-92ff-7b0d-4bf4-2f4030117e73@arm.com>
Date:   Fri, 9 Oct 2020 14:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201009130539.GB5207@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/9/20 2:05 PM, Ionela Voinescu wrote:
> On Thursday 08 Oct 2020 at 18:04:25 (+0100), Lukasz Luba wrote:
>> Intelligent Power Allocation (IPA) is built around the PID controller
>> concept. The initialization code tries to setup the environment based on
>> the information available in DT or estimate the value based on minimum
>> power reported by each of the cooling device. The estimation will have an
>> impact on the PID controller behaviour via the related 'k_po', 'k_pu',
>> 'k_i' coefficients and also on the power budget calculation.
>>
>> This change prevents the situation when 'k_i' is relatively big compared
>> to 'k_po' and 'k_pu' values. This might happen when the estimation for
>> 'sustainable_power' returned small value, thus 'k_po' and 'k_pu' are
>> small.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index e566806f1550..aa35aa6c561c 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -132,6 +132,7 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>>   	int ret;
>>   	int switch_on_temp;
>>   	u32 temperature_threshold;
>> +	s32 k_i;
>>   
>>   	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
>>   	if (ret)
>> @@ -157,8 +158,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>>   		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
>>   			temperature_threshold;
>>   
>> -	if (!tz->tzp->k_i || force)
>> -		tz->tzp->k_i = int_to_frac(10) / 1000;
>> +	if (!tz->tzp->k_i || force) {
>> +		k_i = tz->tzp->k_pu / 10;
>> +		tz->tzp->k_i = k_i > 0 ? k_i : 1;
>> +	}
> 
> I spent some time to understand how smaller or bigger values here impact
> the stability of the output and its closeness to the control temperature
> so I could give you and informed review :).
> 
> I did observed that if the k_i value has the same order of magnitude as
> k_p, the output oscillates more, so I do believe this is a good change
> to have.
> 
> What I also observed is that a small k_d value could be very beneficial
> in quicker stabilising the oscillation and saw that it's recommended to
> have for temperature, or in general for systems with measurement lag.
> 
> It's probably worth experimenting with some real systems first, but I
> wonder if setting k_d to 1 as well is a good default. The risk is that
> we will end up too conservative and not take advantage of some power
> budget that's actually still left on the table. In any case, this is a
> story for another time :).
> 
> For these changes:
> 
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thank you for the review. I will add it to the v3, which I am going to
send soon.

Regards,
Lukasz

> 
> Regards,
> Ionela.
> 
>> +
>>   	/*
>>   	 * The default for k_d and integral_cutoff is 0, so we can
>>   	 * leave them as they are.
>> -- 
>> 2.17.1
>>
> 
> 
> 
