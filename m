Return-Path: <linux-pm+bounces-16355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB32E9AE23C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F2D1F24B69
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC81C0DE2;
	Thu, 24 Oct 2024 10:13:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0B71C07FE;
	Thu, 24 Oct 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764829; cv=none; b=MkmDf57w3xdI8xa1knn/ZWbKVzrih9bwrmBSKBckmR7rPXgiq6ppKNRgwTx761T8X2iE6wBQ0HeUMOKSv77NtyjAQ6XzJaCpuEwaZ8uw28oNLuW4veUBZbVW91hzMn/8g1uPV6EzCqlT31iXPph+jqn98wKc4Rms3O8lQ4IaMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764829; c=relaxed/simple;
	bh=yKX+zGcg103/MnGDt0P8L+cG+mLN/s/N4JARKMf5clU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0Z48942CCjNl4QcOQSYKipkaSUnH8nC3ld738v6ZVjs2onGzHGi7mUjCt5XT+Cn8+gMfxj1/k+eSsxL4FiHNbJ95JPweDB6dUib1q2s6zu/V9IRCRQua2jmLHjEXN74BPfALdUcJP4GfGLl2vZQ5IVkAF/eXUECEp0oAvXH+o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B48D339;
	Thu, 24 Oct 2024 03:14:15 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C826F3F71E;
	Thu, 24 Oct 2024 03:13:44 -0700 (PDT)
Message-ID: <e5c96b65-8efe-4209-ad32-1d99c7174794@arm.com>
Date: Thu, 24 Oct 2024 11:14:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] thermal: core: Build sorted lists instead of
 sorting them later
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <4930656.GXAFRqVoOG@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4930656.GXAFRqVoOG@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 12:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since it is not expected that multiple trip points will be crossed
> in one go very often (if this happens, there are too many trip points
> in the given thermal zone or they are checked too rarely), quite likely
> it is more efficient to build a sorted list of crossed trip points than
> to put them on an unsorted list and sort it later.
> 
> Moreover, trip points are often sorted in ascending temperature order
> during thermal zone registration. so building a sorted list out of

nit: small s

> them is quite straightforward and relatively inexpensive.
> 
> Accordingly, make handle_thermal_trip() maintain list ordering when
> adding trip points to the lists and get rid of separate list sorting
> in __thermal_zone_device_update().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   33 ++++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 15 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -15,7 +15,6 @@
>   #include <linux/slab.h>
>   #include <linux/kdev_t.h>
>   #include <linux/idr.h>
> -#include <linux/list_sort.h>
>   #include <linux/thermal.h>
>   #include <linux/reboot.h>
>   #include <linux/string.h>
> @@ -409,6 +408,21 @@ static void handle_critical_trips(struct
>   		tz->ops.hot(tz);
>   }
>   
> +static void add_trip_to_sorted_list(struct thermal_trip_desc *td,
> +				    struct list_head *list)
> +{
> +	struct thermal_trip_desc *entry;
> +
> +	/* Assume that the new entry is likely to be the last one. */
> +	list_for_each_entry_reverse(entry, list, notify_list_node) {
> +		if (entry->notify_temp <= td->notify_temp) {
> +			list_add(&td->notify_list_node, &entry->notify_list_node);
> +			return;
> +		}
> +	}
> +	list_add(&td->notify_list_node, list);
> +}
> +
>   static void handle_thermal_trip(struct thermal_zone_device *tz,
>   				struct thermal_trip_desc *td,
>   				struct list_head *way_up_list,
> @@ -438,8 +452,8 @@ static void handle_thermal_trip(struct t
>   		 * In that case, the trip temperature becomes the new threshold.
>   		 */
>   		if (tz->temperature < trip->temperature - trip->hysteresis) {
> -			list_add(&td->notify_list_node, way_down_list);
>   			td->notify_temp = trip->temperature - trip->hysteresis;
> +			add_trip_to_sorted_list(td, way_down_list);
>   
>   			if (trip->type == THERMAL_TRIP_PASSIVE) {
>   				tz->passive--;
> @@ -454,8 +468,9 @@ static void handle_thermal_trip(struct t
>   		 * if the zone temperature exceeds the trip one.  The new
>   		 * threshold is then set to the low temperature of the trip.
>   		 */
> -		list_add_tail(&td->notify_list_node, way_up_list);
>   		td->notify_temp = trip->temperature;
> +		add_trip_to_sorted_list(td, way_up_list);
> +
>   		td->threshold -= trip->hysteresis;
>   
>   		if (trip->type == THERMAL_TRIP_PASSIVE)
> @@ -519,16 +534,6 @@ static void thermal_trip_crossed(struct
>   	thermal_governor_trip_crossed(governor, tz, trip, crossed_up);
>   }
>   
> -static int thermal_trip_notify_cmp(void *not_used, const struct list_head *a,
> -				   const struct list_head *b)
> -{
> -	struct thermal_trip_desc *tda = container_of(a, struct thermal_trip_desc,
> -						     notify_list_node);
> -	struct thermal_trip_desc *tdb = container_of(b, struct thermal_trip_desc,
> -						     notify_list_node);
> -	return tda->notify_temp - tdb->notify_temp;
> -}
> -
>   void __thermal_zone_device_update(struct thermal_zone_device *tz,
>   				  enum thermal_notify_event event)
>   {
> @@ -581,11 +586,9 @@ void __thermal_zone_device_update(struct
>   
>   	thermal_zone_set_trips(tz, low, high);
>   
> -	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
>   	list_for_each_entry(td, &way_up_list, notify_list_node)
>   		thermal_trip_crossed(tz, &td->trip, governor, true);
>   
> -	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
>   	list_for_each_entry_reverse(td, &way_down_list, notify_list_node)
>   		thermal_trip_crossed(tz, &td->trip, governor, false);
>   
> 
> 
> 

Make sense, LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

