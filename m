Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413C52D61C6
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 17:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390007AbgLJQ02 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 11:26:28 -0500
Received: from foss.arm.com ([217.140.110.172]:51572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392016AbgLJQ0X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 11:26:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39DF71FB;
        Thu, 10 Dec 2020 08:25:37 -0800 (PST)
Received: from [10.57.1.60] (unknown [10.57.1.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB913F68F;
        Thu, 10 Dec 2020 08:25:35 -0800 (PST)
Subject: Re: [PATCH v2 4/4] thermal/core: Remove ms based delay fields
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20201207190902.30464-1-daniel.lezcano@linaro.org>
 <20201207190902.30464-4-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5cc9554f-0351-4668-6276-f55696ca02ba@arm.com>
Date:   Thu, 10 Dec 2020 16:25:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201207190902.30464-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/7/20 7:09 PM, Daniel Lezcano wrote:
> The code does no longer use the ms unit based fields to set the
> delays as they are replaced by the jiffies.
> 
> Remove them and replace their user to use the jiffies version instead.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/platform/x86/acerhdf.c                     | 3 ++-
>   drivers/thermal/da9062-thermal.c                   | 4 ++--
>   drivers/thermal/gov_power_allocator.c              | 2 +-
>   drivers/thermal/thermal_core.c                     | 2 +-
>   drivers/thermal/thermal_core.h                     | 2 --
>   drivers/thermal/thermal_sysfs.c                    | 2 +-
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 ++++--
>   include/linux/thermal.h                            | 7 -------
>   8 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 7b26f601b407..b7dbcf6be13e 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -336,7 +336,8 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
>   			pr_notice("interval changed to: %d\n", interval);
>   
>   		if (thermal)
> -			thermal->polling_delay_ms = interval*1000;
> +			thermal->polling_delay_jiffies =
> +				msecs_to_jiffies(interval * 1000);
>   
>   		prev_interval = interval;
>   	}
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
> index ebb3d0b4a5be..180edec34e07 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -95,7 +95,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
>   		thermal_zone_device_update(thermal->zone,
>   					   THERMAL_EVENT_UNSPECIFIED);
>   
> -		delay = msecs_to_jiffies(thermal->zone->passive_delay_ms);
> +		delay = thermal->zone->passive_delay_jiffies;

We would use rounding down value to full seconds, but I couldn't
find any odd values in DT for this devices. So it should be OK.

>   		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
>   		return;
>   	}
> @@ -245,7 +245,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
>   
>   	dev_dbg(&pdev->dev,
>   		"TJUNC temperature polling period set at %d ms\n",
> -		thermal->zone->passive_delay_ms);
> +		jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
>   
>   	ret = platform_get_irq_byname(pdev, "THERMAL");
>   	if (ret < 0) {
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index f7a663f698d4..f8c3d1e40b86 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -258,7 +258,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>   	 * power being applied, slowing down the controller)
>   	 */
>   	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
> -	d = div_frac(d, tz->passive_delay_ms);
> +	d = div_frac(d, jiffies_to_msecs(tz->passive_delay_jiffies));
>   	params->prev_err = err;
>   
>   	power_range = p + i + d;
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 16ef5d652d85..aff15c6b1c61 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -313,7 +313,7 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
>   
>   	if (!stop && tz->passive)
>   		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
> -	else if (!stop && tz->polling_delay_ms)
> +	else if (!stop && tz->polling_delay_jiffies)
>   		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>   	else
>   		thermal_zone_device_set_polling(tz, 0);
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 2c9551ed5ef8..5baa308ee7a5 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -131,7 +131,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz);
>   static inline void thermal_zone_set_passive_delay(
>   	struct thermal_zone_device *tz, int delay_ms)
>   {
> -	tz->passive_delay_ms = delay_ms;
>   	tz->passive_delay_jiffies = msecs_to_jiffies(delay_ms);
>   	if (delay_ms > 1000)
>   		tz->passive_delay_jiffies = round_jiffies(tz->passive_delay_jiffies);
> @@ -140,7 +139,6 @@ static inline void thermal_zone_set_passive_delay(
>   static inline void thermal_zone_set_polling_delay(
>   	struct thermal_zone_device *tz, int delay_ms)
>   {
> -	tz->polling_delay_ms = delay_ms;
>   	tz->polling_delay_jiffies = msecs_to_jiffies(delay_ms);
>   	if (delay_ms > 1000)
>   		tz->polling_delay_jiffies = round_jiffies(tz->polling_delay_jiffies);
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 9598b288a0a1..8532b1dd0608 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -233,7 +233,7 @@ passive_store(struct device *dev, struct device_attribute *attr,
>   		return -EINVAL;
>   
>   	if (state && !tz->forced_passive) {
> -		if (!tz->passive_delay_ms)
> +		if (!tz->passive_delay_jiffies)
>   			thermal_zone_set_passive_delay(tz, 1000);
>   		thermal_zone_device_rebind_exception(tz, "Processor",
>   						     sizeof("Processor"));
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 4baff19e1142..f84375865c97 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -166,6 +166,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>   			     char *domain)
>   {
>   	struct ti_thermal_data *data;
> +	int interval;
>   
>   	data = ti_bandgap_get_sensor_data(bgp, id);
>   
> @@ -183,9 +184,10 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>   		return PTR_ERR(data->ti_thermal);
>   	}
>   
> +	interval = jiffies_to_msecs(data->ti_thermal->polling_delay_jiffies);

Same here, so it should be OK.

> +
>   	ti_bandgap_set_sensor_data(bgp, id, data);
> -	ti_bandgap_write_update_interval(bgp, data->sensor_id,
> -					data->ti_thermal->polling_delay_ms);
> +	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
>   
>   	return 0;
>   }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5dd9bdb6c6ad..f23a388ded15 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -116,13 +116,8 @@ struct thermal_cooling_device {
>    * @devdata:	private pointer for device private data
>    * @trips:	number of trip points the thermal zone supports
>    * @trips_disabled;	bitmap for disabled trips
> - * @passive_delay_ms:	number of milliseconds to wait between polls when
> - *			performing passive cooling.
>    * @passive_delay_jiffies: number of jiffies to wait between polls when
>    *			performing passive cooling.
> - * @polling_delay_ms:	number of milliseconds to wait between polls when
> - *			checking whether trip points have been crossed (0 for
> - *			interrupt driven systems)
>    * @polling_delay_jiffies: number of jiffies to wait between polls when
>    *			checking whether trip points have been crossed (0 for
>    *			interrupt driven systems)
> @@ -164,8 +159,6 @@ struct thermal_zone_device {
>   	void *devdata;
>   	int trips;
>   	unsigned long trips_disabled;	/* bitmap for disabled trips */
> -	int passive_delay_ms;
> -	int polling_delay_ms;
>   	int passive_delay_jiffies;
>   	int polling_delay_jiffies;
>   	int temperature;
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
