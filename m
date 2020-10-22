Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60977295DAB
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 13:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502959AbgJVLpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 07:45:47 -0400
Received: from foss.arm.com ([217.140.110.172]:55238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502778AbgJVLpr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 07:45:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D0D8D6E;
        Thu, 22 Oct 2020 04:45:46 -0700 (PDT)
Received: from [10.57.20.67] (unknown [10.57.20.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 933593F66B;
        Thu, 22 Oct 2020 04:45:43 -0700 (PDT)
Subject: Re: [PATCH 2/5] thermal: devfreq_cooling: get a copy of device status
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch
References: <20200921122007.29610-1-lukasz.luba@arm.com>
 <20200921122007.29610-3-lukasz.luba@arm.com>
 <199bf0e0-88b3-1908-c291-92c85bfe06b1@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4ac3b6b0-0e3f-3971-78e6-362c367f8c30@arm.com>
Date:   Thu, 22 Oct 2020 12:45:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <199bf0e0-88b3-1908-c291-92c85bfe06b1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 10/14/20 3:34 PM, Daniel Lezcano wrote:
> On 21/09/2020 14:20, Lukasz Luba wrote:
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
>> +{
>> +	/* Make some space if needed */
>> +	if (status->busy_time > 0xffff) {
>> +		status->busy_time >>= 10;
>> +		status->total_time >>= 10;
>> +	}
>> +
>> +	if (status->busy_time > status->total_time)
>> +		status->busy_time = status->total_time;
>> +
>> +	status->busy_time *= 100;
>> +	status->busy_time /= status->total_time ? : 1;
>> +
>> +	/* Avoid division by 0 */
>> +	status->busy_time = status->busy_time ? : 1;
>> +	status->total_time = 100;
>> +}
> 
> Not sure that works if the devfreq governor is not on-demand.
> 
> Is it possible to use the energy model directly in devfreq to compute
> the energy consumption given the state transitions since the last reading ?

This change is actually trying to create a safety net for what we do.

In the original code we take the last_state directly:
-	struct devfreq_dev_status *status = &df->last_status;

Then we simply multiply by 'busy_time' and div by 'total_time',
without checks... The values might be huge or zero, etc.
The _normalize_load() introduces this safety.

Apart from that, just simply taking a pointer to &df->last_status does
not protect us from:
- working on a struct which might be modified at the same time in
   background - not safe
- that struct might not be updated by long time, because devfreq
   didn't check it for a long (there are two polling modes in devfreq)

So taking a mutex and then a trigger the device status check and
make a copy of newest data. It is more safe.

I think this can be treated as a fix, not a feature.

> 
> The power will be read directly from devfreq which will return:
> 
> nrj + (current_power * (jiffies - last_update)) / (jiffies - last_update)
> 
> The devfreq cooling device driver would result in a much simpler code, no?

This is something that I would like to address after the EM changes are
merged. It would be the next step, how to estimate the power by taking
into consideration more information. This patch series just tries to
make it possible to use EM. The model improvements would be next.

Thank you Daniel for your review.

Regards,
Lukasz
