Return-Path: <linux-pm+bounces-16358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8F19AE256
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2911F24A22
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507A91BD028;
	Thu, 24 Oct 2024 10:18:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7D516FF3B;
	Thu, 24 Oct 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765098; cv=none; b=R/gtrQYU5fZqOIMy/9x1OPDu+zFkCEiv7GwqGLo4pdshqkZslc3CethQ9Ey3ScKSYsW9dPfSrjPObOpoVkgF2jEsPJP+xaAVkF6KXMEF+KgXrTCYol+PuEmP6Q6hVGrZe2p6BoQm/nn+amzDaZkPr95PO3elOHA/evmTVuAW694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765098; c=relaxed/simple;
	bh=viWfJSrnNhJzfw8t+utuEkHn4lUMEac/Jo/ArkQA3VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL+ORj9TJN68MM6mE2zgmE/ssWLjBUzW1CpmN7BbNjgnhrIbJ/ylZyHxWoGadhA1TyP2vPvBmvn2Jexg0T6hkUb8hJgy2SyibpbOtdAxOe/mZS1AX7X+BKbOFqxgn4VdmBUK+oCnXvVX7nkK4Hz/tbZxgg/Kodqv6VexPatJs58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69780497;
	Thu, 24 Oct 2024 03:18:44 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B30FB3F71E;
	Thu, 24 Oct 2024 03:18:13 -0700 (PDT)
Message-ID: <9e84763a-5dd2-43c6-88fd-06433e2749cb@arm.com>
Date: Thu, 24 Oct 2024 11:19:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] thermal: core: Prepare for moving trips between
 sorted lists
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <2960197.e9J7NaK4W3@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2960197.e9J7NaK4W3@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 12:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Subsequently, trips will be moved between sorted lists in multiple
> places, so replace add_trip_to_sorted_list() with an analogous
> function, move_trip_to_sorted_list(), that will move a given trip
> to a given sorted list.
> 
> To allow list_del() used in the new function to work, initialize the
> list_node fields in trip descriptors where applicable so they are
> always valid.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -408,11 +408,17 @@ static void handle_critical_trips(struct
>   		tz->ops.hot(tz);
>   }
>   
> -static void add_trip_to_sorted_list(struct thermal_trip_desc *td,
> -				    struct list_head *list)
> +static void move_trip_to_sorted_list(struct thermal_trip_desc *td,
> +				     struct list_head *list)
>   {
>   	struct thermal_trip_desc *entry;
>   
> +	/*
> +	 * Delete upfront and then add to make relocation within the same list
> +	 * work.
> +	 */
> +	list_del(&td->list_node);
> +
>   	/* Assume that the new entry is likely to be the last one. */
>   	list_for_each_entry_reverse(entry, list, list_node) {
>   		if (entry->notify_temp <= td->notify_temp) {
> @@ -453,7 +459,7 @@ static void handle_thermal_trip(struct t
>   		 */
>   		if (tz->temperature < trip->temperature - trip->hysteresis) {
>   			td->notify_temp = trip->temperature - trip->hysteresis;
> -			add_trip_to_sorted_list(td, way_down_list);
> +			move_trip_to_sorted_list(td, way_down_list);
>   
>   			if (trip->type == THERMAL_TRIP_PASSIVE) {
>   				tz->passive--;
> @@ -469,7 +475,7 @@ static void handle_thermal_trip(struct t
>   		 * threshold is then set to the low temperature of the trip.
>   		 */
>   		td->notify_temp = trip->temperature;
> -		add_trip_to_sorted_list(td, way_up_list);
> +		move_trip_to_sorted_list(td, way_up_list);
>   
>   		td->threshold -= trip->hysteresis;
>   
> @@ -538,7 +544,7 @@ void __thermal_zone_device_update(struct
>   				  enum thermal_notify_event event)
>   {
>   	struct thermal_governor *governor = thermal_get_tz_governor(tz);
> -	struct thermal_trip_desc *td;
> +	struct thermal_trip_desc *td, *next;
>   	LIST_HEAD(way_down_list);
>   	LIST_HEAD(way_up_list);
>   	int low = -INT_MAX, high = INT_MAX;
> @@ -586,11 +592,15 @@ void __thermal_zone_device_update(struct
>   
>   	thermal_zone_set_trips(tz, low, high);
>   
> -	list_for_each_entry(td, &way_up_list, list_node)
> +	list_for_each_entry_safe(td, next, &way_up_list, list_node) {
>   		thermal_trip_crossed(tz, &td->trip, governor, true);
> +		list_del_init(&td->list_node);
> +	}
>   
> -	list_for_each_entry_reverse(td, &way_down_list, list_node)
> +	list_for_each_entry_safe_reverse(td, next, &way_down_list, list_node) {
>   		thermal_trip_crossed(tz, &td->trip, governor, false);
> +		list_del_init(&td->list_node);
> +	}
>   
>   	if (governor->manage)
>   		governor->manage(tz);
> @@ -1490,6 +1500,7 @@ thermal_zone_device_register_with_trips(
>   	for_each_trip_desc(tz, td) {
>   		td->trip = *trip++;
>   		INIT_LIST_HEAD(&td->thermal_instances);
> +		INIT_LIST_HEAD(&td->list_node);
>   		/*
>   		 * Mark all thresholds as invalid to start with even though
>   		 * this only matters for the trips that start as invalid and
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

