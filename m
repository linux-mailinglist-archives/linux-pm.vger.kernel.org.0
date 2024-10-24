Return-Path: <linux-pm+bounces-16361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A19AE26C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BA61F2462C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C761ABEB1;
	Thu, 24 Oct 2024 10:23:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1534A1C233E;
	Thu, 24 Oct 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765387; cv=none; b=sBwat65XQwVjTeIfrCovxhvjxaeCIgfgCdlRCUZzTcpZ6VWw3i71dVmywr5Alc8iHXImNQKe7FjunUJv+lyQnI5oWn3zPOkDtoihZcGkoQqfs29R2vncPmn92Zt2+PabdQjZJLwj07KIN8Si/aoHOvo1VNCJJjDC0G/nKBCFja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765387; c=relaxed/simple;
	bh=B+1RfBYiqs79yFlaFW0DvH0tktjVn9e4WTKZNVljEio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2+rfRUCEwPBIQS9eiIthZA8TsoUTixM6dZqWjA+IYprIoSLZ9LvP5u1h4i+2F0GhT+p84279Mc7clfxbOyCAOuCSRcJDOmcYX4Q3LTpXoJ5kWAq+DYbqqtqJO8wTDIKB0pv5tI4aIpdaZCIdGXU9YiGFfV2VAmUyGbn8zK8swI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49110339;
	Thu, 24 Oct 2024 03:23:34 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98F7E3F71E;
	Thu, 24 Oct 2024 03:23:03 -0700 (PDT)
Message-ID: <75ca3ac0-be7c-4be5-be50-11b90b690102@arm.com>
Date: Thu, 24 Oct 2024 11:24:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/10] thermal: core: Move some trip processing to
 thermal_trip_crossed()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <1982859.PYKUYFuaPT@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1982859.PYKUYFuaPT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 12:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that some processing related to trip point crossing carried out
> in handle_thermal_trip() and thermal_zone_set_trip_temp() may as well
> be done in thermal_trip_crossed(), which allows code duplication to be
> reduced, so change the code accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   21 ++++++++++-----------
>   drivers/thermal/thermal_trip.c |   17 ++++++-----------
>   2 files changed, 16 insertions(+), 22 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -460,11 +460,6 @@ static void handle_thermal_trip(struct t
>   		if (tz->temperature < trip->temperature - trip->hysteresis) {
>   			td->notify_temp = trip->temperature - trip->hysteresis;
>   			move_trip_to_sorted_list(td, way_down_list);
> -
> -			if (trip->type == THERMAL_TRIP_PASSIVE) {
> -				tz->passive--;
> -				WARN_ON(tz->passive < 0);
> -			}
>   		} else {
>   			td->threshold -= trip->hysteresis;
>   		}
> @@ -478,12 +473,6 @@ static void handle_thermal_trip(struct t
>   		move_trip_to_sorted_list(td, way_up_list);
>   
>   		td->threshold -= trip->hysteresis;
> -
> -		if (trip->type == THERMAL_TRIP_PASSIVE)
> -			tz->passive++;
> -		else if (trip->type == THERMAL_TRIP_CRITICAL ||
> -			 trip->type == THERMAL_TRIP_HOT)
> -			handle_critical_trips(tz, trip);
>   	}
>   }
>   
> @@ -533,9 +522,19 @@ static void thermal_trip_crossed(struct
>   	const struct thermal_trip *trip = &td->trip;
>   
>   	if (crossed_up) {
> +		if (trip->type == THERMAL_TRIP_PASSIVE)
> +			tz->passive++;
> +		else if (trip->type == THERMAL_TRIP_CRITICAL ||
> +			 trip->type == THERMAL_TRIP_HOT)
> +			handle_critical_trips(tz, trip);
> +
>   		thermal_notify_tz_trip_up(tz, trip);
>   		thermal_debug_tz_trip_up(tz, trip);
>   	} else {
> +		if (trip->type == THERMAL_TRIP_PASSIVE) {
> +			tz->passive--;
> +			WARN_ON(tz->passive < 0);
> +		}
>   		thermal_notify_tz_trip_down(tz, trip);
>   		thermal_debug_tz_trip_down(tz, trip);
>   	}
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -108,18 +108,13 @@ void thermal_zone_set_trip_temp(struct t
>   	if (temp == THERMAL_TEMP_INVALID) {
>   		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
>   
> -		if (tz->temperature >= td->threshold) {
> -			/*
> -			 * The trip has been crossed on the way up, so some
> -			 * adjustments are needed to compensate for the lack
> -			 * of it going forward.
> -			 */
> -			if (trip->type == THERMAL_TRIP_PASSIVE) {
> -				tz->passive--;
> -				WARN_ON_ONCE(tz->passive < 0);
> -			}
> +		/*
> +		 * If the trip has been crossed on the way up, some adjustments
> +		 * are needed to compensate for the lack of it going forward.
> +		 */
> +		if (tz->temperature >= td->threshold)
>   			thermal_zone_trip_down(tz, td);
> -		}
> +
>   		/*
>   		 * Invalidate the threshold to avoid triggering a spurious
>   		 * trip crossing notification when the trip becomes valid.
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

