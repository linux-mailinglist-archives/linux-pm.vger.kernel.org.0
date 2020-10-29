Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39429E72B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 10:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgJ2JYG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 05:24:06 -0400
Received: from foss.arm.com ([217.140.110.172]:57062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgJ2JYG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 05:24:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7349D139F;
        Thu, 29 Oct 2020 02:24:05 -0700 (PDT)
Received: from [10.57.13.20] (unknown [10.57.13.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03BAD3F719;
        Thu, 29 Oct 2020 02:24:03 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] thermal: power allocator: change how estimation
 code is called
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, Dietmar.Eggemann@arm.com, ionela.voinescu@arm.com
References: <20201009135850.14727-1-lukasz.luba@arm.com>
 <20201009135850.14727-3-lukasz.luba@arm.com>
 <371617d1-fb1c-8e7b-0a50-e3ea07a1f825@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <38aa72f6-25fd-b7a5-07c0-9db7f0233479@arm.com>
Date:   Thu, 29 Oct 2020 09:24:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <371617d1-fb1c-8e7b-0a50-e3ea07a1f825@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 10/13/20 5:41 PM, Daniel Lezcano wrote:
> On 09/10/2020 15:58, Lukasz Luba wrote:
>> The sustainable power value might come from the Device Tree or can be
>> estimated in run time. There is no need to estimate every time when the
>> governor is called and temperature is high. Instead, store the estimated
>> value and make it available via standard sysfs interface so it can be
>> checked from the user-space. Re-invoke the estimation only in case the
>> sustainable power was set to 0. Apart from that the PID coefficients
>> are not going to be force updated thus can better handle sysfs settings.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
> 
> [ ... ]
> 
>> -static void estimate_pid_constants(struct thermal_zone_device *tz,
>> -				   u32 sustainable_power, int trip_switch_on,
>> -				   int control_temp, bool force)
>> +static void estimate_tzp_constants(struct thermal_zone_device *tz,
>> +				   int trip_switch_on, int control_temp)
>>   {
>> -	int ret;
>> -	int switch_on_temp;
>>   	u32 temperature_threshold;
>> +	int switch_on_temp;
>> +	bool force = false;
>> +	int ret;
>>   	s32 k_i;
>>   
>> +	if (!tz->tzp->sustainable_power) {
>> +		tz->tzp->sustainable_power = estimate_sustainable_power(tz);
>> +		force = true;
>> +		dev_info(&tz->device, "power_allocator: estimating sust. power and PID constants\n");
>> +	}
>> +
>>   	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
>>   	if (ret)
>>   		switch_on_temp = 0;
>>   
>>   	temperature_threshold = control_temp - switch_on_temp;
>>   	/*
>> -	 * estimate_pid_constants() tries to find appropriate default
>> +	 * estimate_tzp_constants() tries to find appropriate default
>>   	 * values for thermal zones that don't provide them. If a
>>   	 * system integrator has configured a thermal zone with two
>>   	 * passive trip points at the same temperature, that person
>> @@ -151,11 +151,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>>   		return;
>>   
>>   	if (!tz->tzp->k_po || force)
>> -		tz->tzp->k_po = int_to_frac(sustainable_power) /
>> +		tz->tzp->k_po = int_to_frac(tz->tzp->sustainable_power) /
>>   			temperature_threshold;
>>   
>>   	if (!tz->tzp->k_pu || force)
>> -		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
>> +		tz->tzp->k_pu = int_to_frac(2 * tz->tzp->sustainable_power) /
>>   			temperature_threshold;
>>   
>>   	if (!tz->tzp->k_i || force) {
>> @@ -193,19 +193,13 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>>   {
>>   	s64 p, i, d, power_range;
>>   	s32 err, max_power_frac;
>> -	u32 sustainable_power;
>>   	struct power_allocator_params *params = tz->governor_data;
>>   
>>   	max_power_frac = int_to_frac(max_allocatable_power);
>>   
>> -	if (tz->tzp->sustainable_power) {
>> -		sustainable_power = tz->tzp->sustainable_power;
>> -	} else {
>> -		sustainable_power = estimate_sustainable_power(tz);
>> -		estimate_pid_constants(tz, sustainable_power,
>> -				       params->trip_switch_on, control_temp,
>> -				       true);
>> -	}
>> +	if (!tz->tzp->sustainable_power)
>> +		estimate_tzp_constants(tz, params->trip_switch_on,
>> +				       control_temp);
> 
> The changes in this patch are appropriate and make sense but they are
> not done at the right place.
> 
> estimate_tzp_constants() must be called when sustainable_power is
> updated via DT/init or sysfs.
> 
> Keeping a function to estimate the sustainable power and another one to
> estimate the k_* separated would be more clear.
> 
> Actually the confusion is coming from when the pid constants are
> computed, I suggest moving the initialization of k_* out of this
> function and killing the 'force' test.
> 
> 
> [ ... ]
> 
> 

Thank you for the review. I will re-write the patch
and address your suggestion.

Regards,
Lukasz
