Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F18CF57F4
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbfKHT4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 14:56:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387487AbfKHT4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 14:56:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 056DB60909; Fri,  8 Nov 2019 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573242862;
        bh=RI8pAJ2oaXVf01TTf6CIgXgIZlbNFOUYc89nvR7jJEg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M/VKpoLAh4IuqvpTb4l6Ncc/ysc3Z3wdcQpAum90P8DyPhePEqjDGjQvfAj9XIVOV
         uIfYpr7taPThwDehSXhnkIKyfwHbI7tnY2qzVvJIFzlSBCMHoxU6HLy9y5Um6Wp+D+
         xtNLXBlttgX/obSW1G3HuPG6EKj7nUQHakOv+3Eg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.226.59.103] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkumbako@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6C7A60909;
        Fri,  8 Nov 2019 19:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573242857;
        bh=RI8pAJ2oaXVf01TTf6CIgXgIZlbNFOUYc89nvR7jJEg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cmd8pXp8cny6HvbtoRaaeL+v89GwX7T+3TJVCplfb1vn9gbzYgVYosD99CiYGQKXC
         eOBVJzkyqodeqqXyvXMe0JZSfwO+jG07B+tXm8tSTIDAH1B9gdO3d2wadMGakTdcfv
         d7i6VVRqw5o7Zex0DDfCo+lXF2+N8xfp1uOLdk9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6C7A60909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkumbako@codeaurora.org
Subject: Re: [PATCH 4/4] thermal: step_wise: Extend thermal step-wise governor
 to monitor falling temperature.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        amit.kucheria@verdurent.com, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
 <1568859503-19725-5-git-send-email-thara.gopinath@linaro.org>
From:   Ram Chandrasekar <rkumbako@codeaurora.org>
Message-ID: <7dbe01d9-6687-f4f8-0739-6b4ff6d4e59b@codeaurora.org>
Date:   Fri, 8 Nov 2019 12:54:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1568859503-19725-5-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/18/2019 8:18 PM, Thara Gopinath wrote:
>>From the step wise governor point of view, the policy decisions
> that has to taken on a thermal trip point that is defined to be monitored
> for falling temprature is the mirror opposite of the decisions it has
> to take on a trip point that is monitored for rising temperature.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>   drivers/thermal/step_wise.c | 59 +++++++++++++++++++++++++++++++++------------
>   1 file changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 6e051cb..aa8e0a0 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -35,7 +35,8 @@
>    *       deactivate the thermal instance
>    */
>   static unsigned long get_target_state(struct thermal_instance *instance,
> -				enum thermal_trend trend, bool throttle)
> +				enum thermal_trend trend, bool throttle,
> +				enum thermal_trip_monitor_type type)
>   {
>   	struct thermal_cooling_device *cdev = instance->cdev;
>   	unsigned long cur_state;
> @@ -65,11 +66,21 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>   
>   	switch (trend) {
>   	case THERMAL_TREND_RAISING:
> -		if (throttle) {
> -			next_target = cur_state < instance->upper ?
> -				    (cur_state + 1) : instance->upper;
> -			if (next_target < instance->lower)
> -				next_target = instance->lower;
> +		if (type == THERMAL_TRIP_MONITOR_FALLING) {
> +			if (cur_state <= instance->lower) {
> +				if (!throttle)
> +					next_target = THERMAL_NO_TARGET;
> +			} else {
> +				if (!throttle)
> +					next_target = cur_state - 1;
> +			}
> +		} else {
> +			if (throttle) {
> +				next_target = cur_state < instance->upper ?
> +					    (cur_state + 1) : instance->upper;
> +				if (next_target < instance->lower)
> +					next_target = instance->lower;
> +			}
>   		}
>   		break;
>   	case THERMAL_TREND_RAISE_FULL:
> @@ -77,14 +88,23 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>   			next_target = instance->upper;
>   		break;
>   	case THERMAL_TREND_DROPPING:
> -		if (cur_state <= instance->lower) {
> -			if (!throttle)
> -				next_target = THERMAL_NO_TARGET;
> +		if (type == THERMAL_TRIP_MONITOR_FALLING) {
> +			if (throttle) {
> +				next_target = cur_state < instance->upper ?
> +					(cur_state + 1) : instance->upper;
> +				if (next_target < instance->lower)
> +					next_target = instance->lower;
> +			}
>   		} else {
> -			if (!throttle) {
> -				next_target = cur_state - 1;
> -				if (next_target > instance->upper)
> -					next_target = instance->upper;
> +			if (cur_state <= instance->lower) {
> +				if (!throttle)
> +					next_target = THERMAL_NO_TARGET;
> +			} else {
> +				if (!throttle) {
> +					next_target = cur_state - 1;
> +					if (next_target > instance->upper)
> +						next_target = instance->upper;
> +				}
>   			}
>   		}
>   		break;
> @@ -117,6 +137,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>   {
>   	int trip_temp;
>   	enum thermal_trip_type trip_type;
> +	enum thermal_trip_monitor_type monitor_type =
> +					THERMAL_TRIP_MONITOR_RISING;
>   	enum thermal_trend trend;
>   	struct thermal_instance *instance;
>   	bool throttle = false;
> @@ -130,9 +152,15 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>   		tz->ops->get_trip_type(tz, trip, &trip_type);
>   	}
>   
> +	if (tz->ops->get_trip_monitor_type)
> +		tz->ops->get_trip_monitor_type(tz, trip, &monitor_type);
> +
>   	trend = get_tz_trend(tz, trip);
>   
> -	if (tz->temperature >= trip_temp) {
> +	if (((monitor_type == THERMAL_TRIP_MONITOR_RISING) &&
> +	      (tz->temperature >= trip_temp)) ||
> +	      ((monitor_type == THERMAL_TRIP_MONITOR_FALLING) &&
> +	      (tz->temperature <= trip_temp))) {
Governors monitoring warming devices need to have support for 
hysteresis. Assume a case where the device is in idle when the 
temperature goes below threshold and we trigger a mitigation. Even a 
minimal workload or even the processing of the threshold by the governor 
could warm the device and put the temperature above the threshold and we 
will have to remove any mitigation. To avoid this ping-pong, its best to 
add a hysteresis support.
>   		throttle = true;
>   		trace_thermal_zone_trip(tz, trip, trip_type);
>   	}
> @@ -147,7 +175,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>   			continue;
>   
>   		old_target = instance->target;
> -		instance->target = get_target_state(instance, trend, throttle);
> +		instance->target = get_target_state(instance, trend, throttle,
> +						    monitor_type);
>   		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
>   					old_target, (int)instance->target);
>   
> 
