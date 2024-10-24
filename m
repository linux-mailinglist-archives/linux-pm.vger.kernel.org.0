Return-Path: <linux-pm+bounces-16363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0191D9AE274
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B342E282B02
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21DC1BD028;
	Thu, 24 Oct 2024 10:24:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32DF3399F;
	Thu, 24 Oct 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765471; cv=none; b=flTL/KEOZ3EeeaicNNij8U/mc7b1q+upMmAtVrgIJalegvpar+Dop57ZBcfvgjumh5ehtOvB33paJlUCWfddecnayRjoeELOOlniGSke4fWWD/aSkM0GrPZDbj7y++vXfiCBsFqj3slQmFtjbK0sFHz8/MLY5sM0mfb7A15fDiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765471; c=relaxed/simple;
	bh=E+e/AroX1Wji49UMxMg/TdFTBOxN8AaFTgxfuHxIddY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptCQEt0S8EZokHMbWoCn9ks4s3m3ruF48KYrwisUprq/qHXddbRqp3KSciD++PR8FctcCgM3gDC0BNr6r1pQEwVVwaMERdaRi1LAhXsak0VOvw+Xm9MSjmAiXcbd5zn1QP8oazgSHNLzf2ja479OnceAt22H9vlAz7oufEdKv6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF434339;
	Thu, 24 Oct 2024 03:24:57 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1433E3F71E;
	Thu, 24 Oct 2024 03:24:26 -0700 (PDT)
Message-ID: <b01cdc80-b644-40ee-ae24-559a95e2d2c9@arm.com>
Date: Thu, 24 Oct 2024 11:25:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/10] thermal: core: Relocate functions that update
 trip points
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <3248558.5fSG56mABF@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3248558.5fSG56mABF@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 12:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In preparation for subsequent changes, move two functions used
> for updating trip points, thermal_zone_set_trip_temp() and
> thermal_zone_set_trip_hyst(), to thermal_core.c.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   35 +++++++++++++++++++++++++++++++++++
>   drivers/thermal/thermal_trip.c |   35 -----------------------------------
>   2 files changed, 35 insertions(+), 35 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -541,6 +541,41 @@ static void thermal_trip_crossed(struct
>   	thermal_governor_trip_crossed(governor, tz, trip, crossed_up);
>   }
>   
> +void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
> +				struct thermal_trip *trip, int hyst)
> +{
> +	WRITE_ONCE(trip->hysteresis, hyst);
> +	thermal_notify_tz_trip_change(tz, trip);
> +}
> +
> +void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
> +				struct thermal_trip *trip, int temp)
> +{
> +	if (trip->temperature == temp)
> +		return;
> +
> +	WRITE_ONCE(trip->temperature, temp);
> +	thermal_notify_tz_trip_change(tz, trip);
> +
> +	if (temp == THERMAL_TEMP_INVALID) {
> +		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
> +
> +		/*
> +		 * If the trip has been crossed on the way up, some adjustments
> +		 * are needed to compensate for the lack of it going forward.
> +		 */
> +		if (tz->temperature >= td->threshold)
> +			thermal_zone_trip_down(tz, td);
> +
> +		/*
> +		 * Invalidate the threshold to avoid triggering a spurious
> +		 * trip crossing notification when the trip becomes valid.
> +		 */
> +		td->threshold = INT_MAX;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
> +
>   void __thermal_zone_device_update(struct thermal_zone_device *tz,
>   				  enum thermal_notify_event event)
>   {
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -88,38 +88,3 @@ int thermal_zone_trip_id(const struct th
>   	 */
>   	return trip_to_trip_desc(trip) - tz->trips;
>   }
> -
> -void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
> -				struct thermal_trip *trip, int hyst)
> -{
> -	WRITE_ONCE(trip->hysteresis, hyst);
> -	thermal_notify_tz_trip_change(tz, trip);
> -}
> -
> -void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
> -				struct thermal_trip *trip, int temp)
> -{
> -	if (trip->temperature == temp)
> -		return;
> -
> -	WRITE_ONCE(trip->temperature, temp);
> -	thermal_notify_tz_trip_change(tz, trip);
> -
> -	if (temp == THERMAL_TEMP_INVALID) {
> -		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
> -
> -		/*
> -		 * If the trip has been crossed on the way up, some adjustments
> -		 * are needed to compensate for the lack of it going forward.
> -		 */
> -		if (tz->temperature >= td->threshold)
> -			thermal_zone_trip_down(tz, td);
> -
> -		/*
> -		 * Invalidate the threshold to avoid triggering a spurious
> -		 * trip crossing notification when the trip becomes valid.
> -		 */
> -		td->threshold = INT_MAX;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

