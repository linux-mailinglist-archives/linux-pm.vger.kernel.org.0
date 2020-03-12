Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F636182F69
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 12:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCLLkC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 07:40:02 -0400
Received: from foss.arm.com ([217.140.110.172]:60922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLLkC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Mar 2020 07:40:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67AA031B;
        Thu, 12 Mar 2020 04:40:01 -0700 (PDT)
Received: from [10.37.12.166] (unknown [10.37.12.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7158A3F67D;
        Thu, 12 Mar 2020 04:39:58 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: devfreq_cooling: Use PM QoS to set frequency
 limits
To:     Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>
References: <CGME20200116231233epcas1p363ab7e3ad2966d0ae7bac11e33aa6b83@epcas1p3.samsung.com>
 <20200116151219.v2.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
 <d73e67eb-4f2d-dc4b-c718-929a964d3640@samsung.com>
 <20200312003519.GD144492@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f09ad5b3-c997-187a-d637-cc7cdcb282f9@arm.com>
Date:   Thu, 12 Mar 2020 11:39:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200312003519.GD144492@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matthias,

I just saw this email below the patch. I wasn't aware that you
are working on this. I will have to update my changes...

It looks good to me.
Unfortunately, it does not apply on top of Amit's commit
1b5cb9570670a6277cc0 thermal: devfreq_cooling: Appease the kernel-doc deity

Could you check this?

Other then that

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

On 3/12/20 12:35 AM, Matthias Kaehlcke wrote:
> Is any further action needed from my side or can this land?
> 
> Thanks
> 
> Matthias
> 
> On Fri, Jan 17, 2020 at 02:22:02PM +0900, Chanwoo Choi wrote:
>> On 1/17/20 8:12 AM, Matthias Kaehlcke wrote:
>>> Now that devfreq supports limiting the frequency range of a device
>>> through PM QoS make use of it instead of disabling OPPs that should
>>> not be used.
>>>
>>> The switch from disabling OPPs to PM QoS introduces a subtle behavioral
>>> change in case of conflicting requests (min > max): PM QoS gives
>>> precedence to the MIN_FREQUENCY request, while higher OPPs disabled
>>> with dev_pm_opp_disable() would override MIN_FREQUENCY.
>>>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>
>>> Changes in v2:
>>> - added documentation for 'req_max_freq'
>>> - fixed jumps in of_devfreq_cooling_register_power() unwind
>>> - added comment about behavioral change to the commit message
>>>
>>>   drivers/thermal/devfreq_cooling.c | 70 ++++++++++---------------------
>>>   1 file changed, 23 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
>>> index ef59256887ff63..cbbaf5bc425d1a 100644
>>> --- a/drivers/thermal/devfreq_cooling.c
>>> +++ b/drivers/thermal/devfreq_cooling.c
>>> @@ -24,11 +24,13 @@
>>>   #include <linux/idr.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/pm_opp.h>
>>> +#include <linux/pm_qos.h>
>>>   #include <linux/thermal.h>
>>>   
>>>   #include <trace/events/thermal.h>
>>>   
>>> -#define SCALE_ERROR_MITIGATION 100
>>> +#define HZ_PER_KHZ		1000
>>> +#define SCALE_ERROR_MITIGATION	100
>>>   
>>>   static DEFINE_IDA(devfreq_ida);
>>>   
>>> @@ -53,6 +55,8 @@ static DEFINE_IDA(devfreq_ida);
>>>    *		'utilization' (which is	'busy_time / 'total_time').
>>>    *		The 'res_util' range is from 100 to (power_table[state] * 100)
>>>    *		for the corresponding 'state'.
>>> + * @req_max_freq:	PM QoS request for limiting the maximum frequency
>>> + *			of the devfreq device.
>>>    */
>>>   struct devfreq_cooling_device {
>>>   	int id;
>>> @@ -65,49 +69,9 @@ struct devfreq_cooling_device {
>>>   	struct devfreq_cooling_power *power_ops;
>>>   	u32 res_util;
>>>   	int capped_state;
>>> +	struct dev_pm_qos_request req_max_freq;
>>>   };
>>>   
>>> -/**
>>> - * partition_enable_opps() - disable all opps above a given state
>>> - * @dfc:	Pointer to devfreq we are operating on
>>> - * @cdev_state:	cooling device state we're setting
>>> - *
>>> - * Go through the OPPs of the device, enabling all OPPs until
>>> - * @cdev_state and disabling those frequencies above it.
>>> - */
>>> -static int partition_enable_opps(struct devfreq_cooling_device *dfc,
>>> -				 unsigned long cdev_state)
>>> -{
>>> -	int i;
>>> -	struct device *dev = dfc->devfreq->dev.parent;
>>> -
>>> -	for (i = 0; i < dfc->freq_table_size; i++) {
>>> -		struct dev_pm_opp *opp;
>>> -		int ret = 0;
>>> -		unsigned int freq = dfc->freq_table[i];
>>> -		bool want_enable = i >= cdev_state ? true : false;
>>> -
>>> -		opp = dev_pm_opp_find_freq_exact(dev, freq, !want_enable);
>>> -
>>> -		if (PTR_ERR(opp) == -ERANGE)
>>> -			continue;
>>> -		else if (IS_ERR(opp))
>>> -			return PTR_ERR(opp);
>>> -
>>> -		dev_pm_opp_put(opp);
>>> -
>>> -		if (want_enable)
>>> -			ret = dev_pm_opp_enable(dev, freq);
>>> -		else
>>> -			ret = dev_pm_opp_disable(dev, freq);
>>> -
>>> -		if (ret)
>>> -			return ret;
>>> -	}
>>> -
>>> -	return 0;
>>> -}
>>> -
>>>   static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
>>>   					 unsigned long *state)
>>>   {
>>> @@ -134,7 +98,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>>>   	struct devfreq_cooling_device *dfc = cdev->devdata;
>>>   	struct devfreq *df = dfc->devfreq;
>>>   	struct device *dev = df->dev.parent;
>>> -	int ret;
>>> +	unsigned long freq;
>>>   
>>>   	if (state == dfc->cooling_state)
>>>   		return 0;
>>> @@ -144,9 +108,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>>>   	if (state >= dfc->freq_table_size)
>>>   		return -EINVAL;
>>>   
>>> -	ret = partition_enable_opps(dfc, state);
>>> -	if (ret)
>>> -		return ret;
>>> +	freq = dfc->freq_table[state];
>>> +
>>> +	dev_pm_qos_update_request(&dfc->req_max_freq,
>>> +				  DIV_ROUND_UP(freq, HZ_PER_KHZ));
>>>   
>>>   	dfc->cooling_state = state;
>>>   
>>> @@ -529,9 +494,15 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>>>   	if (err)
>>>   		goto free_dfc;
>>>   
>>> -	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
>>> +	err = dev_pm_qos_add_request(df->dev.parent, &dfc->req_max_freq,
>>> +				     DEV_PM_QOS_MAX_FREQUENCY,
>>> +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
>>>   	if (err < 0)
>>>   		goto free_tables;
>>> +
>>> +	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
>>> +	if (err < 0)
>>> +		goto remove_qos_req;
>>>   	dfc->id = err;
>>>   
>>>   	snprintf(dev_name, sizeof(dev_name), "thermal-devfreq-%d", dfc->id);
>>> @@ -552,6 +523,10 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>>>   
>>>   release_ida:
>>>   	ida_simple_remove(&devfreq_ida, dfc->id);
>>> +
>>> +remove_qos_req:
>>> +	dev_pm_qos_remove_request(&dfc->req_max_freq);
>>> +
>>>   free_tables:
>>>   	kfree(dfc->power_table);
>>>   	kfree(dfc->freq_table);
>>> @@ -600,6 +575,7 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
>>>   
>>>   	thermal_cooling_device_unregister(dfc->cdev);
>>>   	ida_simple_remove(&devfreq_ida, dfc->id);
>>> +	dev_pm_qos_remove_request(&dfc->req_max_freq);
>>>   	kfree(dfc->power_table);
>>>   	kfree(dfc->freq_table);
>>>   
>>>
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> -- 
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
