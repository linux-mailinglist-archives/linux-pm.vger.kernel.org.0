Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1012F242F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 01:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390518AbhALAZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 19:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403928AbhAKXOQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 18:14:16 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A380EC061794
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 15:13:35 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id o20so406117ilj.11
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 15:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rrRq5mHSq4NB5JLwy/mYqVFr8iEMeG5LcRfheBfLpZk=;
        b=ceLOYbplpX8PK8IkU4hodjUkUzzbeQ4iQnbP1dGKtgMR0T23ZDmuTHVbrLybQSpWWQ
         LhggthDyaxieWogbXE1qAiDh9SBFcR6Nel0lifbe5wG7nU/dS0OgRujyo0rUyU728WoP
         TDCV8Q4s3AyjyRQBI2bSyEiL88J0kExw0iBWEX3QrxlKa/DMTGedbHZdgUd7D7RHEYJL
         2mHVXaWjNwhPFvqHl1ZEt0Euc4PC0dVrgdhDebc7wP2BEkCKUdI94q6wlC6EhHwpUcQ3
         a7s8Gu3NKPIbV38FeEMmCvUMazx26AE917vOKjmWnRrEeeD/3IM0ylTvGQC1G9znqLb9
         OJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rrRq5mHSq4NB5JLwy/mYqVFr8iEMeG5LcRfheBfLpZk=;
        b=YyChOsbPbqaSW1sg/63gQlSCylwlWUX8S1k6gZ9MBSWcejF1ww4EE6qCIxougszA6g
         3Jd4tt79anHx4EAmnxHDcpIOJVOG9e9Rgv7FUpWGgT6DnG3alyYpWemKpnY6ID5RvbIJ
         7Vvbt2jvp4GPqdjqREV2RQWHf3/W8QuPwblm6g9P+5ZCCgkO/geBOXc3Tp9R6S3oM9JH
         wS/4c1vPCOftzCaDl20P73qR8X6kMSbrq2S49x/zfX2aoainrhnlWsU2M3NWWpKfpaLE
         XI0P8gOAZl6DeP0uU10Drgh1k7bscZ2hbI5cM5xkQm51C9ys0azE5UX0JcFrIFmxM3QI
         Dovw==
X-Gm-Message-State: AOAM5308tvC23WuEsaIa0LzOrQUu8PQwYpE/YjYwltGkHQtF7EC5TjT+
        qEOC943+hPZEWN8C+Bs9klBj8g==
X-Google-Smtp-Source: ABdhPJy24jGvmbWDWgUyA/ln48Z2jWKXj5z5gpXJIpkDApwErfBJmQT+T1aH5HZK+71MhDAVmYie8g==
X-Received: by 2002:a05:6e02:5d0:: with SMTP id l16mr1343949ils.90.1610406814979;
        Mon, 11 Jan 2021 15:13:34 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id r3sm756226ilt.76.2021.01.11.15.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 15:13:32 -0800 (PST)
Subject: Re: [PATCH 1/6] thermal/core: Remove the 'forced_passive' option
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <314b70a1-8c39-bd2c-cba8-937657658930@linaro.org>
Date:   Mon, 11 Jan 2021 18:13:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214233811.485669-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/14/20 6:38 PM, Daniel Lezcano wrote:
> The code was reorganized in 2012 with the commit 0c01ebbfd3caf1.
> 
> The main change is a loop on the trip points array and a unconditional
> call to the throttle() ops of the governors for each of them even if
> the trip temperature is not reached yet.
> 
> With this change, the 'forced_passive' is no longer checked in the
> thermal_zone_device_update() function but in the step wise governor's
> throttle() callback.
> 
> As the force_passive does no belong to the trip point array, the
> thermal_zone_device_update() can not compare with the specified
> passive temperature, thus does not detect the passive limit has been
> crossed. Consequently, throttle() is never called and the
> 'forced_passive' branch is unreached.
> 
> In addition, the default processor cooling device is not automatically
> bound to the thermal zone if there is not passive trip point, thus the
> 'forced_passive' can not operate.
> 
> If there is an active trip point, then the throttle function will be
> called to mitigate at this temperature and the 'forced_passive' will
> override the mitigation of the active trip point in this case but with
> the default cooling device bound to the thermal zone, so usually a
> fan, and that is not a passive cooling effect.
> 
> Given the regression exists since more than 8 years, nobody complained
> and at the best of my knowledge there is no bug open in
> https://bugzilla.kernel.org, it is reasonable to say it is unused.
> 
> Remove the 'forced_passive' related code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

> ---
>   .../driver-api/thermal/sysfs-api.rst          | 13 ---
>   drivers/thermal/gov_step_wise.c               | 14 +---
>   drivers/thermal/thermal_sysfs.c               | 80 -------------------
>   include/linux/thermal.h                       |  4 -
>   4 files changed, 3 insertions(+), 108 deletions(-)
> 
> diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> index e7520cb439ac..a4969c474cc3 100644
> --- a/Documentation/driver-api/thermal/sysfs-api.rst
> +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> @@ -520,19 +520,6 @@ available_policies
>   
>   	RW, Optional
>   
> -passive
> -	Attribute is only present for zones in which the passive cooling
> -	policy is not supported by native thermal driver. Default is zero
> -	and can be set to a temperature (in millidegrees) to enable a
> -	passive trip point for the zone. Activation is done by polling with
> -	an interval of 1 second.
> -
> -	Unit: millidegrees Celsius
> -
> -	Valid values: 0 (disabled) or greater than 1000
> -
> -	RW, Optional
> -
>   emul_temp
>   	Interface to set the emulated temperature method in thermal zone
>   	(sensor). After setting this temperature, the thermal zone may pass
> diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
> index 2ae7198d3067..12acb12aac50 100644
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -109,7 +109,7 @@ static void update_passive_instance(struct thermal_zone_device *tz,
>   	 * If value is +1, activate a passive instance.
>   	 * If value is -1, deactivate a passive instance.
>   	 */
> -	if (type == THERMAL_TRIP_PASSIVE || type == THERMAL_TRIPS_NONE)
> +	if (type == THERMAL_TRIP_PASSIVE)
>   		tz->passive += value;
>   }
>   
> @@ -122,13 +122,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>   	bool throttle = false;
>   	int old_target;
>   
> -	if (trip == THERMAL_TRIPS_NONE) {
> -		trip_temp = tz->forced_passive;
> -		trip_type = THERMAL_TRIPS_NONE;
> -	} else {
> -		tz->ops->get_trip_temp(tz, trip, &trip_temp);
> -		tz->ops->get_trip_type(tz, trip, &trip_type);
> -	}
> +	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> +	tz->ops->get_trip_type(tz, trip, &trip_type);
>   
>   	trend = get_tz_trend(tz, trip);
>   
> @@ -189,9 +184,6 @@ static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
>   
>   	thermal_zone_trip_update(tz, trip);
>   
> -	if (tz->forced_passive)
> -		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE);
> -
>   	mutex_lock(&tz->lock);
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 0866e949339b..4e7f9e880d76 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -216,49 +216,6 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
>   	return ret ? ret : sprintf(buf, "%d\n", temperature);
>   }
>   
> -static ssize_t
> -passive_store(struct device *dev, struct device_attribute *attr,
> -	      const char *buf, size_t count)
> -{
> -	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	int state;
> -
> -	if (sscanf(buf, "%d\n", &state) != 1)
> -		return -EINVAL;
> -
> -	/* sanity check: values below 1000 millicelcius don't make sense
> -	 * and can cause the system to go into a thermal heart attack
> -	 */
> -	if (state && state < 1000)
> -		return -EINVAL;
> -
> -	if (state && !tz->forced_passive) {
> -		if (!tz->passive_delay)
> -			tz->passive_delay = 1000;
> -		thermal_zone_device_rebind_exception(tz, "Processor",
> -						     sizeof("Processor"));
> -	} else if (!state && tz->forced_passive) {
> -		tz->passive_delay = 0;
> -		thermal_zone_device_unbind_exception(tz, "Processor",
> -						     sizeof("Processor"));
> -	}
> -
> -	tz->forced_passive = state;
> -
> -	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> -
> -	return count;
> -}
> -
> -static ssize_t
> -passive_show(struct device *dev, struct device_attribute *attr,
> -	     char *buf)
> -{
> -	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -
> -	return sprintf(buf, "%d\n", tz->forced_passive);
> -}
> -
>   static ssize_t
>   policy_store(struct device *dev, struct device_attribute *attr,
>   	     const char *buf, size_t count)
> @@ -403,7 +360,6 @@ static DEVICE_ATTR_RW(sustainable_power);
>   
>   /* These thermal zone device attributes are created based on conditions */
>   static DEVICE_ATTR_RW(mode);
> -static DEVICE_ATTR_RW(passive);
>   
>   /* These attributes are unconditionally added to a thermal zone */
>   static struct attribute *thermal_zone_dev_attrs[] = {
> @@ -438,45 +394,9 @@ static const struct attribute_group thermal_zone_mode_attribute_group = {
>   	.attrs = thermal_zone_mode_attrs,
>   };
>   
> -/* We expose passive only if passive trips are present */
> -static struct attribute *thermal_zone_passive_attrs[] = {
> -	&dev_attr_passive.attr,
> -	NULL,
> -};
> -
> -static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
> -					       struct attribute *attr,
> -					       int attrno)
> -{
> -	struct device *dev = kobj_to_dev(kobj);
> -	struct thermal_zone_device *tz;
> -	enum thermal_trip_type trip_type;
> -	int count, passive = 0;
> -
> -	tz = container_of(dev, struct thermal_zone_device, device);
> -
> -	for (count = 0; count < tz->trips && !passive; count++) {
> -		tz->ops->get_trip_type(tz, count, &trip_type);
> -
> -		if (trip_type == THERMAL_TRIP_PASSIVE)
> -			passive = 1;
> -	}
> -
> -	if (!passive)
> -		return attr->mode;
> -
> -	return 0;
> -}
> -
> -static const struct attribute_group thermal_zone_passive_attribute_group = {
> -	.attrs = thermal_zone_passive_attrs,
> -	.is_visible = thermal_zone_passive_is_visible,
> -};
> -
>   static const struct attribute_group *thermal_zone_attribute_groups[] = {
>   	&thermal_zone_attribute_group,
>   	&thermal_zone_mode_attribute_group,
> -	&thermal_zone_passive_attribute_group,
>   	/* This is not NULL terminated as we create the group dynamically */
>   };
>   
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index c80032322158..a57232a9a6f9 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -131,9 +131,6 @@ struct thermal_cooling_device {
>   			trip point.
>    * @prev_high_trip:	the above current temperature if you've crossed a
>   			passive trip point.
> - * @forced_passive:	If > 0, temperature at which to switch on all ACPI
> - *			processor cooling devices.  Currently only used by the
> - *			step-wise governor.
>    * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
>    * @ops:	operations this &thermal_zone_device supports
>    * @tzp:	thermal zone parameters
> @@ -167,7 +164,6 @@ struct thermal_zone_device {
>   	int passive;
>   	int prev_low_trip;
>   	int prev_high_trip;
> -	unsigned int forced_passive;
>   	atomic_t need_update;
>   	struct thermal_zone_device_ops *ops;
>   	struct thermal_zone_params *tzp;
> 

-- 
Warm Regards
Thara
