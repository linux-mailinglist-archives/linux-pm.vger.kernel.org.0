Return-Path: <linux-pm+bounces-16365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 139B69AE2AA
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F071C214D5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4465C1C3029;
	Thu, 24 Oct 2024 10:34:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A71B4F32;
	Thu, 24 Oct 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766064; cv=none; b=lGcMrr8J08cQO/TFMCVERo6w802DhyHDxjcXeP7b5pVge1qyMzetl/t31t8gJQJhxe4dT2NHgJOdDd1SRilA63iiV06Ej73Iso8N5IZBQnr9UJamJe2I7S6Xh4qQia7xkStf2L2KCc2m5DOdqugoJOFZ75W5p7/37fqIZpMq+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766064; c=relaxed/simple;
	bh=zoSatyeq/nJa/bmRmfWpyIufx5ozTS503XF4YEA+oZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDxHwdJrmxGfjTVMKjHrHF2PW7cSnvETKtmYTvgJJWrsA7V/kyASjnVt2rKEtKxzldiqdsEeB8txCRbTBEAA1+OfTCq1ILh3i8wkRsfmTy8LNMnthHzzpDEtbo5ZTeJvFW2hi4B1uiAa/O5Zr13Hht5LgKq6khyVjTJrYDSW7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B972B339;
	Thu, 24 Oct 2024 03:34:50 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 111223F71E;
	Thu, 24 Oct 2024 03:34:19 -0700 (PDT)
Message-ID: <c6826bf9-86d2-4edd-81d5-eb4175fa5085@arm.com>
Date: Thu, 24 Oct 2024 11:35:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/10] thermal: core: Relocate thermal zone
 initialization routine
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <1906685.CQOukoFCf9@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1906685.CQOukoFCf9@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 12:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move thermal_zone_device_init() along with thermal_zone_device_check()
> closer to the callers of the former, where they fit better together.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   82 ++++++++++++++++++++---------------------
>   1 file changed, 41 insertions(+), 41 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -429,14 +429,6 @@ static void move_trip_to_sorted_list(str
>   	list_add(&td->list_node, list);
>   }
>   
> -static void thermal_zone_device_check(struct work_struct *work)
> -{
> -	struct thermal_zone_device *tz = container_of(work, struct
> -						      thermal_zone_device,
> -						      poll_queue.work);
> -	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> -}
> -
>   static void move_to_trips_high(struct thermal_zone_device *tz,
>   			       struct thermal_trip_desc *td)
>   {
> @@ -458,39 +450,6 @@ static void move_to_trips_invalid(struct
>   	list_move(&td->list_node, &tz->trips_invalid);
>   }
>   
> -static void thermal_zone_device_init(struct thermal_zone_device *tz)
> -{
> -	struct thermal_trip_desc *td, *next;
> -
> -	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
> -
> -	tz->temperature = THERMAL_TEMP_INIT;
> -	tz->passive = 0;
> -	tz->prev_low_trip = -INT_MAX;
> -	tz->prev_high_trip = INT_MAX;
> -	for_each_trip_desc(tz, td) {
> -		struct thermal_instance *instance;
> -
> -		list_for_each_entry(instance, &td->thermal_instances, trip_node)
> -			instance->initialized = false;
> -	}
> -	/*
> -	 * At this point, all valid trips need to be moved to trips_high so that
> -	 * mitigation can be started if the zone temperature is above them.
> -	 */
> -	list_for_each_entry_safe(td, next, &tz->trips_invalid, list_node) {
> -		if (td->trip.temperature != THERMAL_TEMP_INVALID)
> -			move_to_trips_high(tz, td);
> -	}
> -	/* The trips_reached list may not be empty during system resume. */
> -	list_for_each_entry_safe(td, next, &tz->trips_reached, list_node) {
> -		if (td->trip.temperature == THERMAL_TEMP_INVALID)
> -			move_to_trips_invalid(tz, td);
> -		else
> -			move_to_trips_high(tz, td);
> -	}
> -}
> -
>   static void thermal_governor_trip_crossed(struct thermal_governor *governor,
>   					  struct thermal_zone_device *tz,
>   					  const struct thermal_trip *trip,
> @@ -1425,6 +1384,47 @@ int thermal_zone_get_crit_temp(struct th
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>   
> +static void thermal_zone_device_check(struct work_struct *work)
> +{
> +	struct thermal_zone_device *tz = container_of(work, struct
> +						      thermal_zone_device,
> +						      poll_queue.work);
> +	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +}
> +
> +static void thermal_zone_device_init(struct thermal_zone_device *tz)
> +{
> +	struct thermal_trip_desc *td, *next;
> +
> +	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
> +
> +	tz->temperature = THERMAL_TEMP_INIT;
> +	tz->passive = 0;
> +	tz->prev_low_trip = -INT_MAX;
> +	tz->prev_high_trip = INT_MAX;
> +	for_each_trip_desc(tz, td) {
> +		struct thermal_instance *instance;
> +
> +		list_for_each_entry(instance, &td->thermal_instances, trip_node)
> +			instance->initialized = false;
> +	}
> +	/*
> +	 * At this point, all valid trips need to be moved to trips_high so that
> +	 * mitigation can be started if the zone temperature is above them.
> +	 */
> +	list_for_each_entry_safe(td, next, &tz->trips_invalid, list_node) {
> +		if (td->trip.temperature != THERMAL_TEMP_INVALID)
> +			move_to_trips_high(tz, td);
> +	}
> +	/* The trips_reached list may not be empty during system resume. */
> +	list_for_each_entry_safe(td, next, &tz->trips_reached, list_node) {
> +		if (td->trip.temperature == THERMAL_TEMP_INVALID)
> +			move_to_trips_invalid(tz, td);
> +		else
> +			move_to_trips_high(tz, td);
> +	}
> +}
> +
>   static int thermal_zone_init_governor(struct thermal_zone_device *tz)
>   {
>   	struct thermal_governor *governor;
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

