Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFCF2D5AC6
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 13:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgLJMov (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 07:44:51 -0500
Received: from foss.arm.com ([217.140.110.172]:39776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgLJMov (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 07:44:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 906D231B;
        Thu, 10 Dec 2020 04:44:05 -0800 (PST)
Received: from [10.57.1.60] (unknown [10.57.1.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56583F718;
        Thu, 10 Dec 2020 04:44:03 -0800 (PST)
Subject: Re: [PATCH 2/5] thermal/core: Add critical and hot ops
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
 <20201210121514.25760-2-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <fd9b262a-cb9a-bd88-5790-0ca5f9a7bdad@arm.com>
Date:   Thu, 10 Dec 2020 12:44:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201210121514.25760-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/10/20 12:15 PM, Daniel Lezcano wrote:
> Currently there is no way to the sensors to directly call an ops in
> interrupt mode without calling thermal_zone_device_update assuming all
> the trip points are defined.
> 
> A sensor may want to do something special if a trip point is hot or
> critical.
> 
> This patch adds the critical and hot ops to the thermal zone device,
> so a sensor can directly invoke them or let the thermal framework to
> call the sensor specific ones.
> 
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_core.c | 43 +++++++++++++++++++++-------------
>   include/linux/thermal.h        |  3 +++
>   2 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index e6771e5aeedb..cee0b31b5cd7 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -375,6 +375,25 @@ static void thermal_emergency_poweroff(void)
>   			      msecs_to_jiffies(poweroff_delay_ms));
>   }
>   
> +void thermal_zone_device_critical(struct thermal_zone_device *tz)
> +{
> +	dev_emerg(&tz->device, "%s: critical temperature reached, "
> +		  "shutting down\n", tz->type);
> +
> +	mutex_lock(&poweroff_lock);
> +	if (!power_off_triggered) {
> +		/*
> +		 * Queue a backup emergency shutdown in the event of
> +		 * orderly_poweroff failure
> +		 */
> +		thermal_emergency_poweroff();
> +		orderly_poweroff(true);
> +		power_off_triggered = true;
> +	}
> +	mutex_unlock(&poweroff_lock);
> +}
> +EXPORT_SYMBOL(thermal_zone_device_critical);
> +
>   static void handle_critical_trips(struct thermal_zone_device *tz,
>   				  int trip, enum thermal_trip_type trip_type)
>   {
> @@ -391,22 +410,10 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>   	if (tz->ops->notify)
>   		tz->ops->notify(tz, trip, trip_type);
>   
> -	if (trip_type == THERMAL_TRIP_CRITICAL) {
> -		dev_emerg(&tz->device,
> -			  "critical temperature reached (%d C), shutting down\n",
> -			  tz->temperature / 1000);
> -		mutex_lock(&poweroff_lock);
> -		if (!power_off_triggered) {
> -			/*
> -			 * Queue a backup emergency shutdown in the event of
> -			 * orderly_poweroff failure
> -			 */
> -			thermal_emergency_poweroff();
> -			orderly_poweroff(true);
> -			power_off_triggered = true;
> -		}
> -		mutex_unlock(&poweroff_lock);
> -	}
> +	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
> +		tz->ops->hot(tz);
> +	else if (trip_type == THERMAL_TRIP_CRITICAL)
> +		tz->ops->critical(tz);

I can see that in the patch 3/5 there driver .critical() callback
calls framework thermal_zone_device_critical() at the end.
I wonder if we could always call this framework function.

Something like a helper function always called:
void _handle_critical( *tz)
{
	if (tz->ops->critical)
		tz->ops->critical(tz);

	thermal_zone_device_critical(tz);
}

and then called:

	else if (trip_type == THERMAL_TRIP_CRITICAL)
		_handle_critical(tz);

>   }
>   
>   static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
> @@ -1331,6 +1338,10 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>   
>   	tz->id = id;
>   	strlcpy(tz->type, type, sizeof(tz->type));
> +
> +	if (!ops->critical)
> +		ops->critical = thermal_zone_device_critical;

Then we could drop this default assignment.

> +
>   	tz->ops = ops;
>   	tz->tzp = tzp;
>   	tz->device.class = &thermal_class;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f23a388ded15..125c8a4d52e6 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -79,6 +79,8 @@ struct thermal_zone_device_ops {
>   			  enum thermal_trend *);
>   	int (*notify) (struct thermal_zone_device *, int,
>   		       enum thermal_trip_type);
> +	void (*hot)(struct thermal_zone_device *);
> +	void (*critical)(struct thermal_zone_device *);
>   };
>   
>   struct thermal_cooling_device_ops {
> @@ -399,6 +401,7 @@ void thermal_cdev_update(struct thermal_cooling_device *);
>   void thermal_notify_framework(struct thermal_zone_device *, int);
>   int thermal_zone_device_enable(struct thermal_zone_device *tz);
>   int thermal_zone_device_disable(struct thermal_zone_device *tz);
> +void thermal_zone_device_critical(struct thermal_zone_device *tz);
>   #else
>   static inline struct thermal_zone_device *thermal_zone_device_register(
>   	const char *type, int trips, int mask, void *devdata,
> 

I am just concerned about drivers which provide own .critical() callback
but forgot to call thermal_zone_device_critical() at the end and
framework could skip it.

Or we can make sure during the review that it's not an issue (and ignore
out of tree drivers)?

Regards,
Lukasz
