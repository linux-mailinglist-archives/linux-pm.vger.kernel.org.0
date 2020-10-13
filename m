Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358C828CC13
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 12:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgJMK7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 06:59:47 -0400
Received: from foss.arm.com ([217.140.110.172]:55194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728700AbgJMK7r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 06:59:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64DBD1FB;
        Tue, 13 Oct 2020 03:59:46 -0700 (PDT)
Received: from [10.57.51.141] (unknown [10.57.51.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FE6A3F719;
        Tue, 13 Oct 2020 03:59:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: power allocator: change the 'k_i'
 coefficient estimation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, Dietmar.Eggemann@arm.com
References: <20201002122416.13659-1-lukasz.luba@arm.com>
 <20201002122416.13659-2-lukasz.luba@arm.com>
 <cc0e6d85-28ad-3cfc-e5b8-75820552b716@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5f682bbb-b250-49e6-dbb7-aea522a58595@arm.com>
Date:   Tue, 13 Oct 2020 11:59:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cc0e6d85-28ad-3cfc-e5b8-75820552b716@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 10/13/20 11:21 AM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 02/10/2020 14:24, Lukasz Luba wrote:
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
>> index 5cb518d8f156..f69fafe486a5 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -131,6 +131,7 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>>   	int ret;
>>   	int switch_on_temp;
>>   	u32 temperature_threshold;
>> +	s32 k_i;
>>   
>>   	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
>>   	if (ret)
>> @@ -156,8 +157,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
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
> I do not understand the rational behind this change.

This is the unfortunate impact of the EM abstract scale of power values.
IPA didn't have to deal with it, because we always had milli-Watts.
Because the EM allows the bogoWatts and some vendors already have
them I have to re-evaluate the IPA.

> 
> Do you have some values to share describing what would be the impact of
> this change?

Yes, here is an example:
EM has 3 devices with abstract scale power values, where minimum power
is 25 and max is 200. The minimum power is used by
estimate_sustainable_power()
as a sum of all devices' min power. Sustainable power is going to be
estimated to 75.

Then in the code we have 'temperature_threshold' which is in
milli-Celcius, thus 15degC is 15000.

We estimate 'k_po' according to:
int_to_frac(sustainable_power) / temperature_threshold;

which is:
(75 << 10) / 15000 = ~75000 / 15000 = 5 <-- 'k_po'

then k_pu:
((2*75) << 10) / 15000 = ~150000 / 15000 = 10

Then the old 'k_i' is just hard-coded 10, which is
the same order of magnitude to what is in 'k_pu'.
It should be 1 order of magnitude smaller than 'k_pu'.

I did some experiments and the bigger 'k_i' slows down a lot
the rising temp. That's why this change.

It was OK to have k_i=10 when we were in milliWatts world,
when the min power value was bigger, thus 'k_pu' was also bigger
than our hard-coded 'k_i'.

> 
> Depending on the thermal behavior of a board, these coefficients could
> be very different, no ?
> 

Yes, I strongly believe that vendor engineers will make experiments with
these values and not go with default. Then they will store the k_pu,
k_po, k_i via sysfs interface, with also sustainable_power.

But I have to also fix the hard-coded k_i in the estimation. As
described above, when we have small power values from abstract scale,
the k_i stays too big.

Regards,
Lukasz
