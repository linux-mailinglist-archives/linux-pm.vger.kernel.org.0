Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064682D5FD9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 16:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391424AbgLJPgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 10:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391470AbgLJPeE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 10:34:04 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA958C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 07:33:23 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t16so5917434wra.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BX8FlXcAeITO8GBCPbbpAPphMG5hXTYl512HmcOYpdI=;
        b=F+B13M0jujoEH1aR4Gv8FLSiGZ9VT92nAU2ECDO6FjCDtta3hR5pzArm9oRB7b3ffE
         j01S5+YxvRxpowdWSmvThsF3Ki0uB8Vu5e3qrjimmxLrcd5ggdXEF1pZKTWXJl4EL3cA
         y2Z12IdC2UvIsbMiA7snU+YrYqHAKIxbk0I0uTs/saQfIcM5pSW69N3F9p5IlArrBdrO
         pPU6VVXq9ZqjuyOWmADT+s/bbAOHD0M57Pnj8l3pQCIrUz3VcZ1+aGuOVHlLTb6yDPWF
         Fcg4KJUo978Ue0Hn4NTggySH28VplRAMIECkepamsvz4cCmBipQWMcDFMtJs9PvqNoBx
         wuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BX8FlXcAeITO8GBCPbbpAPphMG5hXTYl512HmcOYpdI=;
        b=aNHhSzL3iZCW51rtWmoyCv1IeIauG1xc2wzIB6TpZmibuQ6dev5B8tgrWrkdrHtYyJ
         1RDz+oV5s90Y4vDafadkZs/6ns6j3UZI0lyQk8Ti2Xt67he1Mj3r3S77wMNxxNKcJ5xA
         ql0GUoeH6ZZJyUIwkysFA554BESJ5CVy11BU29d+4yDtz2yaRBnABXiY5XrFXTx/LOpf
         2gp0QSMMfZMv5bamYwLYY84cAcVm0Hm2zH4hxMTRIFxOs1QcGuFlfu3rje0T55Ks6Q9l
         ALkjOkelc1X62le+uRu8exNSdY1gDD56860rRMbOBZKTi+ApmEDA2QPBJqrYJdFvrsjB
         BOKg==
X-Gm-Message-State: AOAM533mGWI9dN89AFkIk3B7q/Fe1nHq1eaABy5SK89AEiX6gYlpEsF2
        7/E87pckiaCfjytzXrtaWGSUUw==
X-Google-Smtp-Source: ABdhPJyFqQ5no5M3vHphiDJLfb9Sw3cBDWC6kNP44r2OawsrrefVdfMR1rGqFxMeNCXikTNcC9sd/A==
X-Received: by 2002:a5d:5005:: with SMTP id e5mr8698319wrt.279.1607614402217;
        Thu, 10 Dec 2020 07:33:22 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4ea:d408:1aec:e109? ([2a01:e34:ed2f:f020:4ea:d408:1aec:e109])
        by smtp.googlemail.com with ESMTPSA id q15sm9974980wrw.75.2020.12.10.07.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 07:33:21 -0800 (PST)
Subject: Re: [PATCH v2 1/4] thermal/core: Rename passive_delay and
 polling_delay with units
To:     rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lukasz Luba <Lukasz.Luba@arm.com>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Keerthy <j-keerthy@ti.com>,
        Eduardo Valentin <edubezval@gmail.com>
References: <20201207190902.30464-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fed8cdb3-25d8-0d5d-ca19-f9cd35f9c22e@linaro.org>
Date:   Thu, 10 Dec 2020 16:33:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207190902.30464-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Cc'ing missing persons.

Sorry for the inconvenience, just a head up with those trivial changes
(1/4 and 4/4).


On 07/12/2020 20:08, Daniel Lezcano wrote:
> The input unit used by the thermal framework is the msec but it uses
> the jiffies to set the timers.
> 
> As it is stored in the thermal zone device structure, everytime the
> timer is setup at each polling interval, the msecs to jiffies
> conversion happens. The jiffies is the unit the thermal framework is
> using, so keeping it under the jiffies instead of msecs will save some
> pointless conversion.
> 
> Set the scene to directly store the delays under their jiffies
> form by adding to the variable name the 'ms' suffix.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/platform/x86/acerhdf.c                   |  2 +-
>  drivers/thermal/da9062-thermal.c                 |  4 ++--
>  drivers/thermal/gov_power_allocator.c            |  2 +-
>  drivers/thermal/thermal_core.c                   | 10 +++++-----
>  drivers/thermal/thermal_of.c                     | 16 ++++++++--------
>  drivers/thermal/thermal_sysfs.c                  |  6 +++---
>  .../thermal/ti-soc-thermal/ti-thermal-common.c   |  2 +-
>  include/linux/thermal.h                          |  8 ++++----
>  8 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index b6aa6e5514f4..7b26f601b407 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -336,7 +336,7 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
>  			pr_notice("interval changed to: %d\n", interval);
>  
>  		if (thermal)
> -			thermal->polling_delay = interval*1000;
> +			thermal->polling_delay_ms = interval*1000;
>  
>  		prev_interval = interval;
>  	}
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
> index 4d74994f160a..ebb3d0b4a5be 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -95,7 +95,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
>  		thermal_zone_device_update(thermal->zone,
>  					   THERMAL_EVENT_UNSPECIFIED);
>  
> -		delay = msecs_to_jiffies(thermal->zone->passive_delay);
> +		delay = msecs_to_jiffies(thermal->zone->passive_delay_ms);
>  		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
>  		return;
>  	}
> @@ -245,7 +245,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
>  
>  	dev_dbg(&pdev->dev,
>  		"TJUNC temperature polling period set at %d ms\n",
> -		thermal->zone->passive_delay);
> +		thermal->zone->passive_delay_ms);
>  
>  	ret = platform_get_irq_byname(pdev, "THERMAL");
>  	if (ret < 0) {
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 7a4170a0b51f..f7a663f698d4 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -258,7 +258,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>  	 * power being applied, slowing down the controller)
>  	 */
>  	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
> -	d = div_frac(d, tz->passive_delay);
> +	d = div_frac(d, tz->passive_delay_ms);
>  	params->prev_err = err;
>  
>  	power_range = p + i + d;
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 1bd23ff2247b..5b500d72aab4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -317,9 +317,9 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
>  	mutex_lock(&tz->lock);
>  
>  	if (!stop && tz->passive)
> -		thermal_zone_device_set_polling(tz, tz->passive_delay);
> -	else if (!stop && tz->polling_delay)
> -		thermal_zone_device_set_polling(tz, tz->polling_delay);
> +		thermal_zone_device_set_polling(tz, tz->passive_delay_ms);
> +	else if (!stop && tz->polling_delay_ms)
> +		thermal_zone_device_set_polling(tz, tz->polling_delay_ms);
>  	else
>  		thermal_zone_device_set_polling(tz, 0);
>  
> @@ -1340,8 +1340,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  	tz->device.class = &thermal_class;
>  	tz->devdata = devdata;
>  	tz->trips = trips;
> -	tz->passive_delay = passive_delay;
> -	tz->polling_delay = polling_delay;
> +	tz->passive_delay_ms = passive_delay;
> +	tz->polling_delay_ms = polling_delay;
>  
>  	/* sys I/F */
>  	/* Add nodes that are always present via .groups */
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 69ef12f852b7..c01248e48c09 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -51,8 +51,8 @@ struct __thermal_bind_params {
>  
>  /**
>   * struct __thermal_zone - internal representation of a thermal zone
> - * @passive_delay: polling interval while passive cooling is activated
> - * @polling_delay: zone polling interval
> + * @passive_delay_ms: polling interval while passive cooling is activated
> + * @polling_delay_ms: zone polling interval
>   * @slope: slope of the temperature adjustment curve
>   * @offset: offset of the temperature adjustment curve
>   * @ntrips: number of trip points
> @@ -64,8 +64,8 @@ struct __thermal_bind_params {
>   */
>  
>  struct __thermal_zone {
> -	int passive_delay;
> -	int polling_delay;
> +	int passive_delay_ms;
> +	int polling_delay_ms;
>  	int slope;
>  	int offset;
>  
> @@ -865,14 +865,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>  		pr_err("%pOFn: missing polling-delay-passive property\n", np);
>  		goto free_tz;
>  	}
> -	tz->passive_delay = prop;
> +	tz->passive_delay_ms = prop;
>  
>  	ret = of_property_read_u32(np, "polling-delay", &prop);
>  	if (ret < 0) {
>  		pr_err("%pOFn: missing polling-delay property\n", np);
>  		goto free_tz;
>  	}
> -	tz->polling_delay = prop;
> +	tz->polling_delay_ms = prop;
>  
>  	/*
>  	 * REVIST: for now, the thermal framework supports only
> @@ -1085,8 +1085,8 @@ int __init of_parse_thermal_zones(void)
>  		zone = thermal_zone_device_register(child->name, tz->ntrips,
>  						    mask, tz,
>  						    ops, tzp,
> -						    tz->passive_delay,
> -						    tz->polling_delay);
> +						    tz->passive_delay_ms,
> +						    tz->polling_delay_ms);
>  		if (IS_ERR(zone)) {
>  			pr_err("Failed to build %pOFn zone %ld\n", child,
>  			       PTR_ERR(zone));
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 0866e949339b..f465462d8aa1 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -233,12 +233,12 @@ passive_store(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  
>  	if (state && !tz->forced_passive) {
> -		if (!tz->passive_delay)
> -			tz->passive_delay = 1000;
> +		if (!tz->passive_delay_ms)
> +			tz->passive_delay_ms = 1000;
>  		thermal_zone_device_rebind_exception(tz, "Processor",
>  						     sizeof("Processor"));
>  	} else if (!state && tz->forced_passive) {
> -		tz->passive_delay = 0;
> +		tz->passive_delay_ms = 0;
>  		thermal_zone_device_unbind_exception(tz, "Processor",
>  						     sizeof("Processor"));
>  	}
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 2ce4b19f312a..4baff19e1142 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -185,7 +185,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>  
>  	ti_bandgap_set_sensor_data(bgp, id, data);
>  	ti_bandgap_write_update_interval(bgp, data->sensor_id,
> -					data->ti_thermal->polling_delay);
> +					data->ti_thermal->polling_delay_ms);
>  
>  	return 0;
>  }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index d07ea27e72a9..230d451bf335 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -116,9 +116,9 @@ struct thermal_cooling_device {
>   * @devdata:	private pointer for device private data
>   * @trips:	number of trip points the thermal zone supports
>   * @trips_disabled;	bitmap for disabled trips
> - * @passive_delay:	number of milliseconds to wait between polls when
> + * @passive_delay_ms:	number of milliseconds to wait between polls when
>   *			performing passive cooling.
> - * @polling_delay:	number of milliseconds to wait between polls when
> + * @polling_delay_ms:	number of milliseconds to wait between polls when
>   *			checking whether trip points have been crossed (0 for
>   *			interrupt driven systems)
>   * @temperature:	current temperature.  This is only for core code,
> @@ -159,8 +159,8 @@ struct thermal_zone_device {
>  	void *devdata;
>  	int trips;
>  	unsigned long trips_disabled;	/* bitmap for disabled trips */
> -	int passive_delay;
> -	int polling_delay;
> +	int passive_delay_ms;
> +	int polling_delay_ms;
>  	int temperature;
>  	int last_temperature;
>  	int emul_temperature;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
