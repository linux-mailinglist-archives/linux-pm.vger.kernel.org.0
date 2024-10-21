Return-Path: <linux-pm+bounces-16162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E549A9384
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53301C22DAA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A628A1FEFB3;
	Mon, 21 Oct 2024 22:43:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9841E32BD;
	Mon, 21 Oct 2024 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550626; cv=none; b=QxX/XuCXNIzOm8BpKX8XfPdAGs6LVNe8Kvqb1yHbVTqweqsID+jE3PomvzfFly49j1JI+HJ9wxgTUdTiktaCXn33k0Ex3wc1sMxrIUOi0YPtpnKu38Ng2/jhAD/1BXCmmCyWatcmHXom7E9z/UsF+WMwXI6AO2gly7uJhJdAHx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550626; c=relaxed/simple;
	bh=0ugwyUDFWFNxQKuMRt0UJQCEwNVFaG/OEkVWhUZqUQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0Ah6dvwZJi5naoo+Ubtu8yh8aLV7F98NvuvpFs4mYUGkHgTrD7LU+BH3gQv8BQf6LutQYUcLyDDR8WQjqCytQKHBsAM/1spRA76GyA5WodFXyjL+kvSuD6H2QRwYCOqD4L8ppitLM5rk9ADoX3reiFNfwc5I00JQcJMgpt+btg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52F9C497;
	Mon, 21 Oct 2024 15:44:12 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C1613F71E;
	Mon, 21 Oct 2024 15:43:41 -0700 (PDT)
Message-ID: <872a0e63-b894-4ebc-b964-4caada63aad9@arm.com>
Date: Mon, 21 Oct 2024 23:44:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] thermal: core: Move lists of thermal instances
 to trip descriptors
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <5522726.Sb9uPGUboI@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5522726.Sb9uPGUboI@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In almost all places where a thermal zone's list of thermal instances
> is walked, there is a check to match a specific trip point and it is
> walked in vain whenever there are no cooling devices associated with
> the given trip.
> 
> To address this, store the lists of thermal instances in trip point
> descriptors instead of storing them in thermal zones and adjust all
> code using those lists accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/2196792.irdbgypaU6@rjwysocki.net/
> 
> v1 -> v2:
>     * Rebase.
>     * Retain power_actor_is_valid() in the Power allocator governor, but
>       drop its first parameter which is not needed any more.
> 
> ---
>   drivers/thermal/gov_bang_bang.c       |   11 ++++-----
>   drivers/thermal/gov_fair_share.c      |   16 ++++---------
>   drivers/thermal/gov_power_allocator.c |   40 +++++++++++++++++-----------------
>   drivers/thermal/gov_step_wise.c       |   16 ++++++-------
>   drivers/thermal/thermal_core.c        |   33 ++++++++++++++++------------
>   drivers/thermal/thermal_core.h        |    5 +---
>   drivers/thermal/thermal_helpers.c     |    5 ++--
>   7 files changed, 62 insertions(+), 64 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -490,7 +490,7 @@ static void thermal_zone_device_check(st
>   
>   static void thermal_zone_device_init(struct thermal_zone_device *tz)
>   {
> -	struct thermal_instance *pos;
> +	struct thermal_trip_desc *td;
>   
>   	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
>   
> @@ -498,8 +498,12 @@ static void thermal_zone_device_init(str
>   	tz->passive = 0;
>   	tz->prev_low_trip = -INT_MAX;
>   	tz->prev_high_trip = INT_MAX;
> -	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> -		pos->initialized = false;
> +	for_each_trip_desc(tz, td) {
> +		struct thermal_instance *instance;
> +
> +		list_for_each_entry(instance, &td->thermal_instances, trip_node)
> +			instance->initialized = false;
> +	}
>   }
>   
>   static void thermal_governor_trip_crossed(struct thermal_governor *governor,
> @@ -764,12 +768,12 @@ struct thermal_zone_device *thermal_zone
>    * Return: 0 on success, the proper error value otherwise.
>    */
>   static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
> -				     const struct thermal_trip *trip,
> +				     struct thermal_trip *trip,
>   				     struct thermal_cooling_device *cdev,
>   				     struct cooling_spec *cool_spec)
>   {
> -	struct thermal_instance *dev;
> -	struct thermal_instance *pos;
> +	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
> +	struct thermal_instance *dev, *instance;
>   	bool upper_no_limit;
>   	int result;
>   
> @@ -832,13 +836,13 @@ static int thermal_bind_cdev_to_trip(str
>   		goto remove_trip_file;
>   
>   	mutex_lock(&cdev->lock);
> -	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> -		if (pos->trip == trip && pos->cdev == cdev) {
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node)
> +		if (instance->cdev == cdev) {
>   			result = -EEXIST;
>   			break;
>   		}
>   	if (!result) {
> -		list_add_tail(&dev->tz_node, &tz->thermal_instances);
> +		list_add_tail(&dev->trip_node, &td->thermal_instances);
>   		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
>   
>   		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
> @@ -871,15 +875,16 @@ free_mem:
>    * This function is usually called in the thermal zone device .unbind callback.
>    */
>   static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
> -					  const struct thermal_trip *trip,
> +					  struct thermal_trip *trip,
>   					  struct thermal_cooling_device *cdev)
>   {
> +	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
>   	struct thermal_instance *pos, *next;
>   
>   	mutex_lock(&cdev->lock);
> -	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
> -		if (pos->trip == trip && pos->cdev == cdev) {
> -			list_del(&pos->tz_node);
> +	list_for_each_entry_safe(pos, next, &td->thermal_instances, trip_node) {
> +		if (pos->cdev == cdev) {
> +			list_del(&pos->trip_node);
>   			list_del(&pos->cdev_node);
>   
>   			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
> @@ -1460,7 +1465,6 @@ thermal_zone_device_register_with_trips(
>   		}
>   	}
>   
> -	INIT_LIST_HEAD(&tz->thermal_instances);
>   	INIT_LIST_HEAD(&tz->node);
>   	ida_init(&tz->ida);
>   	mutex_init(&tz->lock);
> @@ -1484,6 +1488,7 @@ thermal_zone_device_register_with_trips(
>   	tz->num_trips = num_trips;
>   	for_each_trip_desc(tz, td) {
>   		td->trip = *trip++;
> +		INIT_LIST_HEAD(&td->thermal_instances);
>   		/*
>   		 * Mark all thresholds as invalid to start with even though
>   		 * this only matters for the trips that start as invalid and
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -30,6 +30,7 @@ struct thermal_trip_desc {
>   	struct thermal_trip trip;
>   	struct thermal_trip_attrs trip_attrs;
>   	struct list_head notify_list_node;
> +	struct list_head thermal_instances;
>   	int notify_temp;
>   	int threshold;
>   };
> @@ -99,7 +100,6 @@ struct thermal_governor {
>    * @tzp:	thermal zone parameters
>    * @governor:	pointer to the governor for this thermal zone
>    * @governor_data:	private pointer for governor data
> - * @thermal_instances:	list of &struct thermal_instance of this thermal zone
>    * @ida:	&struct ida to generate unique id for this zone's cooling
>    *		devices
>    * @lock:	lock to protect thermal_instances list
> @@ -132,7 +132,6 @@ struct thermal_zone_device {
>   	struct thermal_zone_params *tzp;
>   	struct thermal_governor *governor;
>   	void *governor_data;
> -	struct list_head thermal_instances;
>   	struct ida ida;
>   	struct mutex lock;
>   	struct list_head node;
> @@ -229,7 +228,7 @@ struct thermal_instance {
>   	struct device_attribute attr;
>   	char weight_attr_name[THERMAL_NAME_LENGTH];
>   	struct device_attribute weight_attr;
> -	struct list_head tz_node; /* node in tz->thermal_instances */
> +	struct list_head trip_node; /* node in trip->thermal_instances */
>   	struct list_head cdev_node; /* node in cdev->thermal_instances */
>   	unsigned int weight; /* The weight of the cooling device */
>   	bool upper_no_limit;
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -67,6 +67,7 @@ static void bang_bang_control(struct the
>   			      const struct thermal_trip *trip,
>   			      bool crossed_up)
>   {
> +	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
>   	struct thermal_instance *instance;
>   
>   	lockdep_assert_held(&tz->lock);
> @@ -75,10 +76,8 @@ static void bang_bang_control(struct the
>   		thermal_zone_trip_id(tz, trip), trip->temperature,
>   		tz->temperature, trip->hysteresis);
>   
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -		if (instance->trip == trip)
> -			bang_bang_set_instance_target(instance, crossed_up);
> -	}
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node)
> +		bang_bang_set_instance_target(instance, crossed_up);
>   }
>   
>   static void bang_bang_manage(struct thermal_zone_device *tz)
> @@ -104,8 +103,8 @@ static void bang_bang_manage(struct ther
>   		 * to the thermal zone temperature and the trip point threshold.
>   		 */
>   		turn_on = tz->temperature >= td->threshold;
> -		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -			if (!instance->initialized && instance->trip == trip)
> +		list_for_each_entry(instance, &td->thermal_instances, trip_node) {
> +			if (!instance->initialized)
>   				bang_bang_set_instance_target(instance, turn_on);
>   		}
>   	}
> Index: linux-pm/drivers/thermal/gov_fair_share.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> +++ linux-pm/drivers/thermal/gov_fair_share.c
> @@ -44,7 +44,7 @@ static int get_trip_level(struct thermal
>   /**
>    * fair_share_throttle - throttles devices associated with the given zone
>    * @tz: thermal_zone_device
> - * @trip: trip point
> + * @td: trip point descriptor
>    * @trip_level: number of trips crossed by the zone temperature
>    *
>    * Throttling Logic: This uses three parameters to calculate the new
> @@ -61,29 +61,23 @@ static int get_trip_level(struct thermal
>    * new_state of cooling device = P3 * P2 * P1
>    */
>   static void fair_share_throttle(struct thermal_zone_device *tz,
> -				const struct thermal_trip *trip,
> +				const struct thermal_trip_desc *td,
>   				int trip_level)
>   {
>   	struct thermal_instance *instance;
>   	int total_weight = 0;
>   	int nr_instances = 0;
>   
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -		if (instance->trip != trip)
> -			continue;
> -
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
>   		total_weight += instance->weight;
>   		nr_instances++;
>   	}
>   
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
>   		struct thermal_cooling_device *cdev = instance->cdev;
>   		u64 dividend;
>   		u32 divisor;
>   
> -		if (instance->trip != trip)
> -			continue;
> -
>   		dividend = trip_level;
>   		dividend *= cdev->max_state;
>   		divisor = tz->num_trips;
> @@ -116,7 +110,7 @@ static void fair_share_manage(struct the
>   		    trip->type == THERMAL_TRIP_HOT)
>   			continue;
>   
> -		fair_share_throttle(tz, trip, trip_level);
> +		fair_share_throttle(tz, td, trip_level);
>   	}
>   }
>   
> Index: linux-pm/drivers/thermal/gov_power_allocator.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> +++ linux-pm/drivers/thermal/gov_power_allocator.c
> @@ -97,11 +97,9 @@ struct power_allocator_params {
>   	struct power_actor *power;
>   };
>   
> -static bool power_actor_is_valid(struct power_allocator_params *params,
> -				 struct thermal_instance *instance)
> +static bool power_actor_is_valid(struct thermal_instance *instance)
>   {
> -	return (instance->trip == params->trip_max &&
> -		 cdev_is_power_actor(instance->cdev));
> +	return cdev_is_power_actor(instance->cdev);
>   }
>   
>   /**
> @@ -118,13 +116,14 @@ static bool power_actor_is_valid(struct
>   static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
>   {
>   	struct power_allocator_params *params = tz->governor_data;
> +	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
>   	struct thermal_cooling_device *cdev;
>   	struct thermal_instance *instance;
>   	u32 sustainable_power = 0;
>   	u32 min_power;
>   
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -		if (!power_actor_is_valid(params, instance))
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
> +		if (!power_actor_is_valid(instance))
>   			continue;
>   
>   		cdev = instance->cdev;
> @@ -400,6 +399,7 @@ static void divvy_up_power(struct power_
>   static void allocate_power(struct thermal_zone_device *tz, int control_temp)
>   {
>   	struct power_allocator_params *params = tz->governor_data;
> +	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
>   	unsigned int num_actors = params->num_actors;
>   	struct power_actor *power = params->power;
>   	struct thermal_cooling_device *cdev;
> @@ -417,10 +417,10 @@ static void allocate_power(struct therma
>   	/* Clean all buffers for new power estimations */
>   	memset(power, 0, params->buffer_size);
>   
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
>   		struct power_actor *pa = &power[i];
>   
> -		if (!power_actor_is_valid(params, instance))
> +		if (!power_actor_is_valid(instance))
>   			continue;
>   
>   		cdev = instance->cdev;
> @@ -454,10 +454,10 @@ static void allocate_power(struct therma
>   		       power_range);
>   
>   	i = 0;
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
>   		struct power_actor *pa = &power[i];
>   
> -		if (!power_actor_is_valid(params, instance))
> +		if (!power_actor_is_valid(instance))
>   			continue;
>   
>   		power_actor_set_power(instance->cdev, instance,
> @@ -538,12 +538,13 @@ static void reset_pid_controller(struct
>   static void allow_maximum_power(struct thermal_zone_device *tz)
>   {
>   	struct power_allocator_params *params = tz->governor_data;
> +	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
>   	struct thermal_cooling_device *cdev;
>   	struct thermal_instance *instance;
>   	u32 req_power;
>   
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -		if (!power_actor_is_valid(params, instance))
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
> +		if (!power_actor_is_valid(instance))
>   			continue;
>   
>   		cdev = instance->cdev;
> @@ -581,13 +582,11 @@ static void allow_maximum_power(struct t
>   static int check_power_actors(struct thermal_zone_device *tz,
>   			      struct power_allocator_params *params)
>   {
> +	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
>   	struct thermal_instance *instance;
>   	int ret = 0;
>   
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -		if (instance->trip != params->trip_max)
> -			continue;
> -
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
>   		if (!cdev_is_power_actor(instance->cdev)) {
>   			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
>   				 instance->cdev->type);
> @@ -635,14 +634,15 @@ static void power_allocator_update_tz(st
>   				      enum thermal_notify_event reason)
>   {
>   	struct power_allocator_params *params = tz->governor_data;
> +	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
>   	struct thermal_instance *instance;
>   	int num_actors = 0;
>   
>   	switch (reason) {
>   	case THERMAL_TZ_BIND_CDEV:
>   	case THERMAL_TZ_UNBIND_CDEV:
> -		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> -			if (power_actor_is_valid(params, instance))
> +		list_for_each_entry(instance, &td->thermal_instances, trip_node)
> +			if (power_actor_is_valid(instance))
>   				num_actors++;
>   
>   		if (num_actors == params->num_actors)
> @@ -652,8 +652,8 @@ static void power_allocator_update_tz(st
>   		break;
>   	case THERMAL_INSTANCE_WEIGHT_CHANGED:
>   		params->total_weight = 0;
> -		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> -			if (power_actor_is_valid(params, instance))
> +		list_for_each_entry(instance, &td->thermal_instances, trip_node)
> +			if (power_actor_is_valid(instance))
>   				params->total_weight += instance->weight;
>   		break;
>   	default:
> Index: linux-pm/drivers/thermal/gov_step_wise.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> +++ linux-pm/drivers/thermal/gov_step_wise.c
> @@ -66,9 +66,10 @@ static unsigned long get_target_state(st
>   }
>   
>   static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> -				     const struct thermal_trip *trip,
> +				     const struct thermal_trip_desc *td,
>   				     int trip_threshold)
>   {
> +	const struct thermal_trip *trip = &td->trip;
>   	enum thermal_trend trend = get_tz_trend(tz, trip);
>   	int trip_id = thermal_zone_trip_id(tz, trip);
>   	struct thermal_instance *instance;
> @@ -82,12 +83,9 @@ static void thermal_zone_trip_update(str
>   	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
>   		trip_id, trip->type, trip_threshold, trend, throttle);
>   
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
>   		int old_target;
>   
> -		if (instance->trip != trip)
> -			continue;
> -
>   		old_target = instance->target;
>   		instance->target = get_target_state(instance, trend, throttle);
>   
> @@ -127,11 +125,13 @@ static void step_wise_manage(struct ther
>   		    trip->type == THERMAL_TRIP_HOT)
>   			continue;
>   
> -		thermal_zone_trip_update(tz, trip, td->threshold);
> +		thermal_zone_trip_update(tz, td, td->threshold);
>   	}
>   
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> -		thermal_cdev_update(instance->cdev);
> +	for_each_trip_desc(tz, td) {
> +		list_for_each_entry(instance, &td->thermal_instances, trip_node)
> +			thermal_cdev_update(instance->cdev);
> +	}
>   }
>   
>   static struct thermal_governor thermal_gov_step_wise = {
> Index: linux-pm/drivers/thermal/thermal_helpers.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_helpers.c
> +++ linux-pm/drivers/thermal/thermal_helpers.c
> @@ -43,10 +43,11 @@ static bool thermal_instance_present(str
>   				     struct thermal_cooling_device *cdev,
>   				     const struct thermal_trip *trip)
>   {
> +	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
>   	struct thermal_instance *ti;
>   
> -	list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
> -		if (ti->trip == trip && ti->cdev == cdev)
> +	list_for_each_entry(ti, &td->thermal_instances, trip_node) {
> +		if (ti->cdev == cdev)
>   			return true;
>   	}
>   
> 
> 
> 

Indeed, it looks better to not loop-and-continue to
figure out the needed trip and instances.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

