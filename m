Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06B02CDA35
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgLCPiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 10:38:54 -0500
Received: from foss.arm.com ([217.140.110.172]:43494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbgLCPix (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Dec 2020 10:38:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8A311063;
        Thu,  3 Dec 2020 07:38:07 -0800 (PST)
Received: from [10.57.31.242] (unknown [10.57.31.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 304173F718;
        Thu,  3 Dec 2020 07:38:05 -0800 (PST)
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d9906ed8-e3bf-5e42-2e43-09071848ae48@arm.com>
Date:   Thu, 3 Dec 2020 15:38:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5d4743b9-5b2f-8494-8d10-6a5fd2c0fdfd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/3/20 1:09 PM, Daniel Lezcano wrote:
> On 18/11/2020 13:03, Lukasz Luba wrote:
>> Devfreq cooling needs to now the correct status of the device in order
>> to operate. Do not rely on Devfreq last_status which might be a stale data
>> and get more up-to-date values of the load.
>>
>> Devfreq framework can change the device status in the background. To
>> mitigate this situation make a copy of the status structure and use it
>> for internal calculations.
>>
>> In addition this patch adds normalization function, which also makes sure
>> that whatever data comes from the device, it is in a sane range.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/devfreq_cooling.c | 52 +++++++++++++++++++++++++------
>>   1 file changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
>> index 659c0143c9f0..925523694462 100644
>> --- a/drivers/thermal/devfreq_cooling.c
>> +++ b/drivers/thermal/devfreq_cooling.c
>> @@ -227,20 +227,46 @@ static inline unsigned long get_total_power(struct devfreq_cooling_device *dfc,
>>   							       voltage);
>>   }
>>   
>> +static void _normalize_load(struct devfreq_dev_status *status)
>> +{
>> +	/* Make some space if needed */
>> +	if (status->busy_time > 0xffff) {
>> +		status->busy_time >>= 10;
>> +		status->total_time >>= 10;
>> +	}
>> +
>> +	if (status->busy_time > status->total_time)
>> +		status->busy_time = status->total_time;
> 
> How the condition above is possible?

They should, be checked by the driver, but I cannot trust
and have to check for all corner cases: (div by 0, overflow
one of them, etc). The busy_time and total_time are unsigned long,
which means 4B on 32bit machines.
If these values are coming from device counters, which count every
busy cycle and total cycles of a clock of a device running at e.g.
1GHz they would overflow every ~4s.

Normally IPA polling are 1s and 100ms, it's platform specific. But there
are also 'empty' periods when IPA sees temperature very low and does not
even call the .get_requested_power() callbacks for the cooling devices,
just grants max freq to all. This is problematic. I am investigating it
and will propose a solution for IPA soon.

I would avoid all of this if devfreq core would have default for all
devices a reliable polling timer... Let me check some possibilities also
for this case.

> 
>> +	status->busy_time *= 100;
>> +	status->busy_time /= status->total_time ? : 1;
>> +
>> +	/* Avoid division by 0 */
>> +	status->busy_time = status->busy_time ? : 1;
>> +	status->total_time = 100;
> 
> Why not base the normalization on 1024? and use an intermediate u64.

You are the 2nd reviewer who is asking this. I tried to keep 'load' as
in range [0, 100] since we also have 'load' in cpufreq cooling in this
range. Maybe I should switch to 1024 (Ionela was also asking for this).

> 
> For example:
> 
> static u32 _normalize_load(struct devfreq_dev_status *status)
> {
> 	u64 load = 0;
> 
> 	/* Prevent divison by zero */
> 	if (!status->busy_time)
> 		return 0;
> 
> 	/*
> 	 * Assuming status->total_time is always greater or equal
> 	 * to status->busy_time, it can not be equal to zero because
> 	 * of the test above
> 	 */
> 	load = status->busy_time * 1024;
> 	load /= status->total_time;

I wanted to avoid any divisions which involve 64bit var on 32bit
machine.

> 
> 	/*
> 	 * load is always [1..1024[, so it can not be truncated by a
> 	 * u64 -> u32 coercive cast
> 	 */
> 	return (u32)load;
> }
> 
> 
>> +}
>>   
>>   static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cdev,
>>   					       u32 *power)
>>   {
>>   	struct devfreq_cooling_device *dfc = cdev->devdata;
>>   	struct devfreq *df = dfc->devfreq;
>> -	struct devfreq_dev_status *status = &df->last_status;
>> +	struct devfreq_dev_status status;
>>   	unsigned long state;
>> -	unsigned long freq = status->current_frequency;
>> +	unsigned long freq;
>>   	unsigned long voltage;
>>   	u32 dyn_power = 0;
>>   	u32 static_power = 0;
>>   	int res;
>>   
>> +	mutex_lock(&df->lock);
>> +	res = df->profile->get_dev_status(df->dev.parent, &status);
>> +	mutex_unlock(&df->lock);
>> +	if (res)
>> +		return res;
>> +
>> +	freq = status.current_frequency;
>> +
>>   	state = freq_get_state(dfc, freq);
>>   	if (state == THERMAL_CSTATE_INVALID) {
>>   		res = -EAGAIN;
>> @@ -268,16 +294,18 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>>   	} else {
>>   		dyn_power = dfc->power_table[state];
>>   
>> +		_normalize_load(&status);
> 
> 		load = _normalize_load(&status);
> 
>> +
>>   		/* Scale dynamic power for utilization */
>> -		dyn_power *= status->busy_time;
>> -		dyn_power /= status->total_time;
>> +		dyn_power *= status.busy_time;
>> +		dyn_power /= status.total_time;
> 
> 		/*
> 		 * May be change dyn_power to a u64 to prevent overflow
> 		 * when multiplied by 'load'
> 		 */
> 		dyn_power = (dyn_power * load) / 1024;

dyn_power value from EM should fit in 16bit [1], so we should be safe.

I will experiment with the 1024 code and check some corner cases.

Thank you Daniel for the review!

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/v5.10-rc5/source/kernel/power/energy_model.c#L135
