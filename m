Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D08D1337F0
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 01:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgAHAbz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 19:31:55 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:59237 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgAHAbz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 19:31:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578443514; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Z7BlDSHpENI8oTNIekEC/fQs16wNbuD2eY0egRw6Q1M=; b=DS0//9CYZzneSl1gL0Ru+/VXD/1K26CIgiTMsgBTp55b5Jj3Eg7MNsXOXE46A32SKvGgeQyI
 bCpCOAmlb7/i1cRRGkoofVXfr5Obtu6EycqL3NxmCql4Dm6Nof7FPKRXQhlHpioUJN+0L6Kg
 1Ibg7zIo5u1+No69TvFR0pPoZnU=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1522f9.7ff4c7091f48-smtp-out-n01;
 Wed, 08 Jan 2020 00:31:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8BD03C447A1; Wed,  8 Jan 2020 00:31:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.226.59.103] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkumbako)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84400C43383;
        Wed,  8 Jan 2020 00:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84400C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rkumbako@codeaurora.org
Subject: Re: [PATCH] drivers: thermal: step_wise: add support for hysteresis
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org, j-keerthy@ti.com,
        thara.gopinath@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
References: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
 <962d48d2-87fd-1236-0623-148352a98de6@linaro.org>
From:   Ram Chandrasekar <rkumbako@codeaurora.org>
Message-ID: <4f75a862-4525-fe11-ed03-f53a13926c15@codeaurora.org>
Date:   Tue, 7 Jan 2020 17:31:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <962d48d2-87fd-1236-0623-148352a98de6@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/11/2019 6:35 AM, Daniel Lezcano wrote:
> On 21/11/2019 06:50, Amit Kucheria wrote:
>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>
>> Currently, step wise governor increases the mitigation when the
>> temperature goes above a threshold and decreases the mitigation when the
>> temperature goes below the threshold.
>>
>> If there is a case where the
>> temperature is wavering around the threshold, the mitigation will be
>> applied and removed every iteration, which is not very efficient.
>>
>> The use of hysteresis temperature could avoid this ping-pong of
>> mitigation by relaxing the mitigation to happen only when the
>> temperature goes below this lower hysteresis value.
> 
> What I'm worried about is how the hysteresis is used in the current
> code, where the destination of this data is to set the value in the
> sensor hardware if it is supported.
> 
> Using the hysteresis in the governor seems like abusing the initial
> purpose of this information.
> 
> Moreover, the hysteresis creates a gray area where the above algorithm
> (DROPPING && !throttle) => state-- or (RAISING && throttle) => state++
> may drop the performances because we will continue mitigating even below
> the threshold.
> 
> As the governor is an open-loop controller, I'm not sure if we can do
> something except adding some kind of low pass filter to prevent
> mitigation bounces.
> 

We have two different use cases for the step wise algorithm, and the 
hysteresis makes sense only in one.

For example, say we are controlling CPU junction temperature at 95C. 
When using step wise, mitigation is applied iteratively and there is a 
possibility that temperature can shoot up before the algorithm can reach 
an optimal mitigation level to keep the temperature near threshold.

In order to help this state machine, we use a second back stop rule in 
the same thermal zone at a higher temperature (say 105C) with a 
hysteresis of 10C to mitigate CPU to a fixed value, by specifying 
upper/lower limit to be the same. The idea is that the second rule will 
place a hard hammer to bring the temperature down close to 95C and then 
it will remove the mitigation. Once mitigation is removed, the junction 
temperature rule state machine will re-adjust from that point to an 
optimal mitigation level. The junction temperature rule doesn’t use 
hysteresis.

Another example is skin temperature mitigation for mobile devices, where 
the step wise algorithm with hysteresis just reduces the operating max 
frequency to a fixed value, when the threshold is reached. And the 
junction temperature rule starts mitigating from this operating max.

That is the reason we have not generalized or mandated the hysteresis 
usage in this patch. The idea is to use it selectively based on use case.


>> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> [Rebased patch from downstream]
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>   drivers/thermal/step_wise.c | 35 ++++++++++++++++++++++++-----------
>>   1 file changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
>> index 6e051cbd824ff..2c8a34a7cf959 100644
>> --- a/drivers/thermal/step_wise.c
>> +++ b/drivers/thermal/step_wise.c
>> @@ -24,7 +24,7 @@
>>    *       for this trip point
>>    *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
>>    *       for this trip point
>> - * If the temperature is lower than a trip point,
>> + * If the temperature is lower than a hysteresis temperature,
>>    *    a. if the trend is THERMAL_TREND_RAISING, do nothing
>>    *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
>>    *       state for this trip point, if the cooling state already
>> @@ -115,30 +115,31 @@ static void update_passive_instance(struct thermal_zone_device *tz,
>>   
>>   static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>>   {
>> -	int trip_temp;
>> +	int trip_temp, hyst_temp;
>>   	enum thermal_trip_type trip_type;
>>   	enum thermal_trend trend;
>>   	struct thermal_instance *instance;
>> -	bool throttle = false;
>> +	bool throttle;
>>   	int old_target;
>>   
>>   	if (trip == THERMAL_TRIPS_NONE) {
>> -		trip_temp = tz->forced_passive;
>> +		hyst_temp = trip_temp = tz->forced_passive;
>>   		trip_type = THERMAL_TRIPS_NONE;
>>   	} else {
>>   		tz->ops->get_trip_temp(tz, trip, &trip_temp);
>> +		hyst_temp = trip_temp;
>> +		if (tz->ops->get_trip_hyst) {
>> +			tz->ops->get_trip_hyst(tz, trip, &hyst_temp);
>> +			hyst_temp = trip_temp - hyst_temp;
>> +		}
>>   		tz->ops->get_trip_type(tz, trip, &trip_type);
>>   	}
>>   
>>   	trend = get_tz_trend(tz, trip);
>>   
>> -	if (tz->temperature >= trip_temp) {
>> -		throttle = true;
>> -		trace_thermal_zone_trip(tz, trip, trip_type);
>> -	}
>> -
>> -	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
>> -				trip, trip_type, trip_temp, trend, throttle);
>> +	dev_dbg(&tz->device,
>> +		"Trip%d[type=%d,temp=%d,hyst=%d]:trend=%d,throttle=%d\n",
>> +		trip, trip_type, trip_temp, hyst_temp, trend, throttle);
>>   
>>   	mutex_lock(&tz->lock);
>>   
>> @@ -147,6 +148,18 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>>   			continue;
>>   
>>   		old_target = instance->target;
>> +		throttle = false;
>> +		/*
>> +		 * Lower the mitigation only if the temperature
>> +		 * goes below the hysteresis temperature.
>> +		 */
>> +		if (tz->temperature >= trip_temp ||
>> +		    (tz->temperature >= hyst_temp &&
>> +		     old_target != THERMAL_NO_TARGET)) {
>> +			throttle = true;
>> +			trace_thermal_zone_trip(tz, trip, trip_type);
>> +		}
>> +
>>   		instance->target = get_target_state(instance, trend, throttle);
>>   		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
>>   					old_target, (int)instance->target);
>>
> 
> 
