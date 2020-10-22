Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D0295D06
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 12:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444348AbgJVKzd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 06:55:33 -0400
Received: from foss.arm.com ([217.140.110.172]:54176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444254AbgJVKzd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 06:55:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B81C4D6E;
        Thu, 22 Oct 2020 03:55:32 -0700 (PDT)
Received: from [10.57.20.67] (unknown [10.57.20.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BF123F66B;
        Thu, 22 Oct 2020 03:55:30 -0700 (PDT)
Subject: Re: [PATCH 2/5] thermal: devfreq_cooling: get a copy of device status
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amit.kucheria@verdurent.com,
        airlied@linux.ie, daniel.lezcano@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, rui.zhang@intel.com,
        orjan.eide@arm.com
References: <20200921122007.29610-1-lukasz.luba@arm.com>
 <20200921122007.29610-3-lukasz.luba@arm.com> <20201007161120.GC15063@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <76e0ef49-5898-adbb-0c54-23d5999f4907@arm.com>
Date:   Thu, 22 Oct 2020 11:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201007161120.GC15063@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela,


On 10/7/20 5:11 PM, Ionela Voinescu wrote:
> On Monday 21 Sep 2020 at 13:20:04 (+0100), Lukasz Luba wrote:
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
>> index 7063ccb7b86d..cf045bd4d16b 100644
>> --- a/drivers/thermal/devfreq_cooling.c
>> +++ b/drivers/thermal/devfreq_cooling.c
>> @@ -227,6 +227,24 @@ static inline unsigned long get_total_power(struct devfreq_cooling_device *dfc,
>>   							       voltage);
>>   }
>>   
>> +static void _normalize_load(struct devfreq_dev_status *status)
> 
> Is there a reason for the leading "_" ?
> AFAIK, "__name()" is meant to suggest a "worker" function for another
> "name()" function, but that would not apply here.

It is just a local name. Check e.g. ./drivers/opp/core.c there is a few:
_generic_set_opp_regulator(), _generic_set_opp_clk_only(),
_get_opp_count(), _find_opp_table(), _set_opp_bw(), etc.

It is just a shorter name for me, '_' means here locality.
Instead of calling it devfreq_cooling_normalize_load().

> 
>> +{
>> +	/* Make some space if needed */
>> +	if (status->busy_time > 0xffff) {
>> +		status->busy_time >>= 10;
>> +		status->total_time >>= 10;
>> +	}
> 
> How about removing the above code and adding here:
> 
> status->busy_time = status->busy_time ? : 1;

It's not equivalent. The code operates on raw device values, which
might be big (e.g. read from counters). If it's lager than the 0xffff,
it is going to be shifted to get smaller.

> 
>> +
>> +	if (status->busy_time > status->total_time)
> 
> This check would then cover the possibility that total_time is 0.
> 
>> +		status->busy_time = status->total_time;
> 
> But a reversal is needed here:
> 		status->total_time = status->busy_time;

No, I want to clamp the busy_time, which should not be bigger that
total time. It could happen when we deal with 'raw' values from device
counters.

> 
>> +
>> +	status->busy_time *= 100;
>> +	status->busy_time /= status->total_time ? : 1;
>> +
>> +	/* Avoid division by 0 */
>> +	status->busy_time = status->busy_time ? : 1;
>> +	status->total_time = 100;
> 
> Then all of this code can be replaced by:
> 
> status->busy_time = (unsigned long)div64_u64((u64)status->busy_time << 10,
> 					     status->total_time);
> status->total_time = 1 << 10;

No, the total_time closed to 'unsigned long' would overflow.

> 
> This way you gain some resolution to busy_time and the divisions in the
> callers would just become shifts by 10.


I don't want to gain more resolution here. I want to be prepare for raw
(not processed yet) big values coming from driver.

Regards,
Lukasz

> 
> Hope it helps,
> Ionela.
> 
