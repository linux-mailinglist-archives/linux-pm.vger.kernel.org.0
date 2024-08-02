Return-Path: <linux-pm+bounces-11827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A176E945B60
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 11:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D8AB21BDB
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B951DC461;
	Fri,  2 Aug 2024 09:47:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFEA1DB44C;
	Fri,  2 Aug 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592033; cv=none; b=J+Nyql18DGS26P4JIX/8FRTA8/KXIJLxajxwp5vmYUW3v2ZKcPfmCSZtH+KbetcucoLq1X0fDh/Lq7+l/9LkF6rmQSi3vlCHrgtilJcT2wO3PwkhcEELS4OPYU4Fo4t2TkG15MvGrPQf2wrwzIbndd+C1rXQXW9wrX/YLdLebiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592033; c=relaxed/simple;
	bh=nQShOS8cSUcF088ozKt9T071B+hV5HljZ1NTVyh3H70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbPq4SDqoAH3h6k4OoIH0Y9nmaExzZlYu+6evEKr6yAP/+riFRvbwTdXTlW1ZdlQ3FAwhl/Vc7pcxYRGy+KM8rZfnKcEAkKnUqxOLas9SjhDQFAI87fzs2T0ytvHgfv6k8/rcjql2OsYUgzWzdG5elgzJpdPLoBz/ZdwIxYaTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22FCB1007;
	Fri,  2 Aug 2024 02:47:36 -0700 (PDT)
Received: from [10.57.12.204] (unknown [10.57.12.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F65D3F766;
	Fri,  2 Aug 2024 02:47:08 -0700 (PDT)
Message-ID: <2fb8441b-d0bb-4e63-998d-cc764db30a23@arm.com>
Date: Fri, 2 Aug 2024 10:47:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 5/8] thermal: tegra: Use
 thermal_zone_for_each_trip() for walking trip points
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
References: <2211925.irdbgypaU6@rjwysocki.net>
 <1819430.VLH7GnMWUR@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1819430.VLH7GnMWUR@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/24 17:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is generally inefficient to iterate over trip indices and call
> thermal_zone_get_trip() every time to get the struct thermal_trip
> corresponding to the given trip index, so modify the Tegra thermal
> drivers to use thermal_zone_for_each_trip() for walking trips.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This patch does not depend on patches [1-3/8].
> 
> ---
>   drivers/thermal/tegra/soctherm.c        |   38 ++++++++++++++++----------------
>   drivers/thermal/tegra/tegra30-tsensor.c |   25 ++++++++++-----------
>   2 files changed, 33 insertions(+), 30 deletions(-)
> 
> Index: linux-pm/drivers/thermal/tegra/soctherm.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/tegra/soctherm.c
> +++ linux-pm/drivers/thermal/tegra/soctherm.c
> @@ -682,24 +682,25 @@ static const struct thermal_zone_device_
>   	.set_trips = tegra_thermctl_set_trips,
>   };
>   
> -static int get_hot_temp(struct thermal_zone_device *tz, int *trip_id, int *temp)
> +static int get_hot_trip_cb(struct thermal_trip *trip, void *arg)
>   {
> -	int i, ret;
> -	struct thermal_trip trip;
> +	const struct thermal_trip **trip_ret = arg;
>   
> -	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
> +	if (trip->type != THERMAL_TRIP_HOT)
> +		return 0;
>   
> -		ret = thermal_zone_get_trip(tz, i, &trip);
> -		if (ret)
> -			return -EINVAL;
> -
> -		if (trip.type == THERMAL_TRIP_HOT) {
> -			*trip_id = i;
> -			return 0;
> -		}
> -	}
> +	*trip_ret = trip;
> +	/* Return nonzero to terminate the search. */
> +	return 1;
> +}
>   
> -	return -EINVAL;
> +static const struct thermal_trip *get_hot_trip(struct thermal_zone_device *tz)
> +{
> +	const struct thermal_trip *trip = NULL;
> +
> +	thermal_zone_for_each_trip(tz, get_hot_trip_cb, &trip);
> +
> +	return trip;
>   }
>   
>   /**
> @@ -731,8 +732,9 @@ static int tegra_soctherm_set_hwtrips(st
>   				      struct thermal_zone_device *tz)
>   {
>   	struct tegra_soctherm *ts = dev_get_drvdata(dev);
> +	const struct thermal_trip *hot_trip;
>   	struct soctherm_throt_cfg *stc;
> -	int i, trip, temperature, ret;
> +	int i, temperature, ret;
>   
>   	/* Get thermtrips. If missing, try to get critical trips. */
>   	temperature = tsensor_group_thermtrip_get(ts, sg->id);
> @@ -749,8 +751,8 @@ static int tegra_soctherm_set_hwtrips(st
>   	dev_info(dev, "thermtrip: will shut down when %s reaches %d mC\n",
>   		 sg->name, temperature);
>   
> -	ret = get_hot_temp(tz, &trip, &temperature);
> -	if (ret) {
> +	hot_trip = get_hot_trip(tz);
> +	if (!hot_trip) {
>   		dev_info(dev, "throttrip: %s: missing hot temperature\n",
>   			 sg->name);
>   		return 0;
> @@ -763,7 +765,7 @@ static int tegra_soctherm_set_hwtrips(st
>   			continue;
>   
>   		cdev = ts->throt_cfgs[i].cdev;
> -		if (get_thermal_instance(tz, cdev, trip))
> +		if (thermal_trip_is_bound_to_cdev(tz, hot_trip, cdev))
>   			stc = find_throttle_cfg_by_name(ts, cdev->type);
>   		else
>   			continue;
> Index: linux-pm/drivers/thermal/tegra/tegra30-tsensor.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/tegra/tegra30-tsensor.c
> +++ linux-pm/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -308,6 +308,18 @@ struct trip_temps {
>   	int crit_trip;
>   };
>   
> +static int tegra_tsensor_get_trips_cb(struct thermal_trip *trip, void *arg)
> +{
> +	struct trip_temps *temps = arg;
> +
> +	if (trip->type == THERMAL_TRIP_HOT)
> +		temps->hot_trip = trip->temperature;
> +	else if (trip->type == THERMAL_TRIP_CRITICAL)
> +		temps->crit_trip = trip->temperature;
> +
> +	return 0;
> +}
> +
>   static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
>   					       struct trip_temps *temps)
>   {
> @@ -320,18 +332,7 @@ static void tegra_tsensor_get_hw_channel
>   	temps->hot_trip  = 85000;
>   	temps->crit_trip = 90000;
>   
> -	for (i = 0; i < thermal_zone_get_num_trips(tzd); i++) {
> -
> -		struct thermal_trip trip;
> -
> -		thermal_zone_get_trip(tzd, i, &trip);
> -
> -		if (trip.type == THERMAL_TRIP_HOT)
> -			temps->hot_trip = trip.temperature;
> -
> -		if (trip.type == THERMAL_TRIP_CRITICAL)
> -			temps->crit_trip = trip.temperature;
> -	}
> +	thermal_zone_for_each_trip(tzd, tegra_tsensor_get_trips_cb, temps);
>   
>   	/* clamp hardware trips to the calibration limits */
>   	temps->hot_trip = clamp(temps->hot_trip, 25000, 90000);
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

