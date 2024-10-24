Return-Path: <linux-pm+bounces-16360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8084A9AE265
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F2B284538
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B171C07E9;
	Thu, 24 Oct 2024 10:20:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0AB1C07D8;
	Thu, 24 Oct 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765256; cv=none; b=YrNDDdQdXDJCL58k+p9FN4Oac16VKzNn+U9rWqXAXc1mU3YWGDD5wzRjcVRWPT1sSswYeC9i6HhTjMHI4amB7Z2f7o1cBAZswtwNpA67hEfwYJR56i9D8s2VipYu44CqzhL20K+GNzHIYUzg7zTog8TJ1wc4OBHYgQ24NikVEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765256; c=relaxed/simple;
	bh=rrnBHWUo2aaeyUFKZ5dcC6YbyBwFy4haspuNHfKJgW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lECPOrPIErf5hsWKI3UnFlRuSzdI7JD9EgKj4owSaAv1IIQQWfK6ulNO8a85Y9bqvi+aSDrTfgZWIutrbCJW9mUbhKVDNVfdmDZkPP2kSHA7JJsxUtiDDKMSY+9gspBFP1CezgPOIOuAVFSMieC5HAeyI2v1T1ytK5qzxNVE5I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A404339;
	Thu, 24 Oct 2024 03:21:23 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 666BF3F71E;
	Thu, 24 Oct 2024 03:20:52 -0700 (PDT)
Message-ID: <17578871-30aa-4f6e-8e75-bdbbb4324f3c@arm.com>
Date: Thu, 24 Oct 2024 11:22:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/10] thermal: core: Pass trip descriptor to
 thermal_trip_crossed()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <10547668.nUPlyArG6x@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <10547668.nUPlyArG6x@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 12:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In preparation for subsequent changes, modify thermal_trip_crossed()
> to take a trip descriptor pointer instead of a pointer to struct
> thermal_trip and propagate this change to thermal_zone_trip_down().
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   12 +++++++-----
>   drivers/thermal/thermal_core.h |    2 +-
>   drivers/thermal/thermal_trip.c |    2 +-
>   3 files changed, 9 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -526,10 +526,12 @@ static void thermal_governor_trip_crosse
>   }
>   
>   static void thermal_trip_crossed(struct thermal_zone_device *tz,
> -				 const struct thermal_trip *trip,
> +				 struct thermal_trip_desc *td,
>   				 struct thermal_governor *governor,
>   				 bool crossed_up)
>   {
> +	const struct thermal_trip *trip = &td->trip;
> +
>   	if (crossed_up) {
>   		thermal_notify_tz_trip_up(tz, trip);
>   		thermal_debug_tz_trip_up(tz, trip);
> @@ -589,12 +591,12 @@ void __thermal_zone_device_update(struct
>   	}
>   
>   	list_for_each_entry_safe(td, next, &way_up_list, list_node) {
> -		thermal_trip_crossed(tz, &td->trip, governor, true);
> +		thermal_trip_crossed(tz, td, governor, true);
>   		list_del_init(&td->list_node);
>   	}
>   
>   	list_for_each_entry_safe_reverse(td, next, &way_down_list, list_node) {
> -		thermal_trip_crossed(tz, &td->trip, governor, false);
> +		thermal_trip_crossed(tz, td, governor, false);
>   		list_del_init(&td->list_node);
>   	}
>   
> @@ -664,9 +666,9 @@ void thermal_zone_device_update(struct t
>   EXPORT_SYMBOL_GPL(thermal_zone_device_update);
>   
>   void thermal_zone_trip_down(struct thermal_zone_device *tz,
> -			    const struct thermal_trip *trip)
> +			    struct thermal_trip_desc *td)
>   {
> -	thermal_trip_crossed(tz, trip, thermal_get_tz_governor(tz), false);
> +	thermal_trip_crossed(tz, td, thermal_get_tz_governor(tz), false);
>   }
>   
>   int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -274,7 +274,7 @@ int thermal_zone_trip_id(const struct th
>   			 const struct thermal_trip *trip);
>   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>   void thermal_zone_trip_down(struct thermal_zone_device *tz,
> -			    const struct thermal_trip *trip);
> +			    struct thermal_trip_desc *td);
>   void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
>   				struct thermal_trip *trip, int hyst);
>   
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -118,7 +118,7 @@ void thermal_zone_set_trip_temp(struct t
>   				tz->passive--;
>   				WARN_ON_ONCE(tz->passive < 0);
>   			}
> -			thermal_zone_trip_down(tz, trip);
> +			thermal_zone_trip_down(tz, td);
>   		}
>   		/*
>   		 * Invalidate the threshold to avoid triggering a spurious
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

