Return-Path: <linux-pm+bounces-594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695A38006A6
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 10:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4497B20E30
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769081CA94;
	Fri,  1 Dec 2023 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBn2mY83"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8D10A
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 01:16:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bd928b13cso658769e87.2
        for <linux-pm@vger.kernel.org>; Fri, 01 Dec 2023 01:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701422181; x=1702026981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVjKjSVZ+ujLV75tkLx5CjREzgdBFdRC8nDJUfgafzk=;
        b=aBn2mY83nVtPtaepsJjxdB/yrKX/zlGFzWWl5H2BOXxOPbi7VGQ0hd3a4tuaiayJOs
         gjLWk1BVZHUBw7gsW+UopJINhZMdjjZ7P/4100YiixX1BACADCuBAPr8Xu9cOithfqQO
         V1BGA55bWqGHJmF0wAUcJLG9Ns/MNsHPFOlE2dp8tzHT5JeR7kezMY3yyv89xoKMnK5r
         FRjKTqjKyN1t6M1Dpt9+VMDb59qIX8Ik5R2/ej3XTzOFQ05PkJHVALR30ykoKiEz2pfL
         kvraUdM26LHPBzpQhH3C294YmYkL6t0QTGFJALoN2HRJ4Gnwemd6QBn19vJtZMkr9T8J
         R3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701422181; x=1702026981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVjKjSVZ+ujLV75tkLx5CjREzgdBFdRC8nDJUfgafzk=;
        b=afh181P3egXRELrtkoP5KBl3R3o1/3UaeVthkbJpKnG2aRHOktbfqZPXngK9CAS9VO
         BFHDb1+MP0mPLQmXg8ARJC7lOpBuxggka4HVyFBzMffjds22XRGsYJmSy3wxM6GalAGi
         EU6f4MBdP04n3Qv1iyj+km6rAYNQRy+xI6u+RLTYwfG0q2BHknV2CiFlGYjtWp2nmBSW
         qAL+FvkkpN9YnG+s/adGU28R7WaqfFMNqXjlF8n3qLUlQLtpTTUkxAbZJQD5DWhqL7oZ
         QnLsaZdkBcy1cYjbQ6vQC1WYoD/Q0YFsSKwIDy5KKDvvk0d4MuRazUdqotqmXzJpK4mb
         3uMw==
X-Gm-Message-State: AOJu0YySE0YhkqH4NJXKbsS1n+bhrmNOoQnZS++hdflgnimC9+mJV7jT
	jyMUCQH2qT+G2I6eSIJohohT0A==
X-Google-Smtp-Source: AGHT+IHQdT2Lq25jwAYWP+l9dCfUeBcnEsEOBR3CyDx5/QCu+ECu3f/tHVQy2/IHKVL9Ipn12mbmCA==
X-Received: by 2002:a05:6512:e9a:b0:50b:c8b5:ae96 with SMTP id bi26-20020a0565120e9a00b0050bc8b5ae96mr684937lfb.57.1701422181119;
        Fri, 01 Dec 2023 01:16:21 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:cafc:3e65:338f:2bec? ([2a05:6e02:1041:c10:cafc:3e65:338f:2bec])
        by smtp.googlemail.com with ESMTPSA id u6-20020a5d6da6000000b00332e84210c2sm3684363wrs.88.2023.12.01.01.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 01:16:20 -0800 (PST)
Message-ID: <c68cdec6-a3ba-491d-8193-0f3d13705d5f@linaro.org>
Date: Fri, 1 Dec 2023 10:16:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] thermal: sysfs: Eliminate unnecessary zone locking
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <5754079.DvuYhMxLoT@kreacher> <2933888.e9J7NaK4W3@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2933888.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/11/2023 19:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The _show() callback functions of the trip point sysfs attributes,
> temperature, hysteresis and type, need not use thermal zone locking,
> because the layout of the data structures they access does not change
> after the thermal zone registration.
> 
> Namely, they all need to access a specific entry in the thermal
> zone's trips[] table that is always present for non-tripless thermal
> zones and its size cannot change after the thermal zone has been
> registered.  Thus it is always safe to access the trips[] table of a
> registered thermal zone from each of the sysfs attributes in question.
> 
> Moreover, the type of a trip point does not change after registering its
> thermal zone, and while its temperature and hysteresis can change, for
> example due to a firmware-induced thermal zone update, holding the zone
> lock around reading them is pointless, because it does not prevent stale
> values from being returned to user space.  For example, a trip point
> temperature can always change ater trip_point_temp_show() has read it
> and before the function's return statement is executed, regardless of
> whether or not zone locking is used.
> 
> For this reason, drop the zone locking from trip_point_type_show(),
> trip_point_temp_show(), and trip_point_hyst_show().

Isn't the lock used to protect against device_del() from 
thermal_zone_device_unregister() ?


> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_sysfs.c |   60 ++++++++++++++--------------------------
>   1 file changed, 21 insertions(+), 39 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -83,25 +83,18 @@ trip_point_type_show(struct device *dev,
>   		     char *buf)
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	struct thermal_trip trip;
> -	int trip_id, result;
> +	int trip_id;
> +
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
>   
>   	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	mutex_lock(&tz->lock);
> -
> -	if (device_is_registered(dev))
> -		result = __thermal_zone_get_trip(tz, trip_id, &trip);
> -	else
> -		result = -ENODEV;
> -
> -	mutex_unlock(&tz->lock);
> -
> -	if (result)
> -		return result;
> +	if (trip_id < 0 || trip_id > tz->num_trips)
> +		return -EINVAL;
>   
> -	switch (trip.type) {
> +	switch (tz->trips[trip_id].type) {
>   	case THERMAL_TRIP_CRITICAL:
>   		return sprintf(buf, "critical\n");
>   	case THERMAL_TRIP_HOT:
> @@ -164,25 +157,18 @@ trip_point_temp_show(struct device *dev,
>   		     char *buf)
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	struct thermal_trip trip;
> -	int trip_id, ret;
> +	int trip_id;
> +
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
>   
>   	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	mutex_lock(&tz->lock);
> -
> -	if (device_is_registered(dev))
> -		ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> -	else
> -		ret = -ENODEV;
> -
> -	mutex_unlock(&tz->lock);
> -
> -	if (ret)
> -		return ret;
> +	if (trip_id < 0 || trip_id > tz->num_trips)
> +		return -EINVAL;
>   
> -	return sprintf(buf, "%d\n", trip.temperature);
> +	return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
>   }
>   
>   static ssize_t
> @@ -234,22 +220,18 @@ trip_point_hyst_show(struct device *dev,
>   		     char *buf)
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	struct thermal_trip trip;
> -	int trip_id, ret;
> +	int trip_id;
> +
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
>   
>   	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	mutex_lock(&tz->lock);
> -
> -	if (device_is_registered(dev))
> -		ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> -	else
> -		ret = -ENODEV;
> -
> -	mutex_unlock(&tz->lock);
> +	if (trip_id < 0 || trip_id > tz->num_trips)
> +		return -EINVAL;
>   
> -	return ret ? ret : sprintf(buf, "%d\n", trip.hysteresis);
> +	return sprintf(buf, "%d\n", tz->trips[trip_id].hysteresis);
>   }
>   
>   static ssize_t
> 
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


