Return-Path: <linux-pm+bounces-5939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418E899101
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 00:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12898284353
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D713C3DE;
	Thu,  4 Apr 2024 22:08:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3461612D1EF;
	Thu,  4 Apr 2024 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268536; cv=none; b=ac1xkmXpCaIznJT6crl5/qnuRg/JxS+dtak/+S3kCZZfevkIdMpJEz7QOFuiUTq7Zf/aE8M0rI4lUnsdPszGp6FqIjLsb5dnbjdcr3CtSEdmeZKnRsewXA5ZXRrcvmta5WOG9Q/LUOtmuVOWj7x7QFMxYf9Tmn4H7s20b1tZse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268536; c=relaxed/simple;
	bh=8877Y/Ntz6dXmz5a1X+BI5NHZTjVYrl3/C712v15YWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dC9SdxaBXoU5G1h4dxn09OF24sbQ0sFi4tnHXwXB6AHga3ecCOlNRZA4gBk2MbgKo20dFwzgL2gla0OnnfFgRqY9hO90DWaL7Tibh+WTz4XTHuVZkiEoPSf+Z6FnVd8bYR9UGMqn0ypJTO/VC889HP0+3szukG4Cbwk3nkBJ6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E83BAFEC;
	Thu,  4 Apr 2024 15:09:22 -0700 (PDT)
Received: from [10.57.73.43] (unknown [10.57.73.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09C1D3F64C;
	Thu,  4 Apr 2024 15:08:50 -0700 (PDT)
Message-ID: <f73be143-a154-48e7-9ab3-c77b54b533fd@arm.com>
Date: Thu, 4 Apr 2024 23:08:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] thermal: core: Move threshold out of struct
 thermal_trip
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <4558251.LvFx2qVVIh@kreacher> <1884181.tdWV9SEqCh@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1884181.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/2/24 19:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The threshold field in struct thermal_trip is only used internally by
> the thermal core and it is better to prevent drivers from misusing it.
> It also takes some space unnecessarily in the trip tables passed by
> drivers to the core during thermal zone registration.
> 
> For this reason, introduce struct thermal_trip_desc as a wrapper around
> struct thermal_trip, move the threshold field directly into it and make
> the thermal core store struct thermal_trip_desc objects in the internal
> thermal zone trip tables.  Adjust all of the code using trip tables in
> the thermal core accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: Rebase on top of 6.9-rc2, minor changelog update.
> 
> v1 -> v2: No changes.
> 
> ---
>   drivers/thermal/gov_fair_share.c      |    7 +++--
>   drivers/thermal/gov_power_allocator.c |    6 ++--
>   drivers/thermal/thermal_core.c        |   46 +++++++++++++++++++---------------
>   drivers/thermal/thermal_core.h        |    7 +++--
>   drivers/thermal/thermal_debugfs.c     |    6 ++--
>   drivers/thermal/thermal_helpers.c     |    8 +++--
>   drivers/thermal/thermal_netlink.c     |    6 ++--
>   drivers/thermal/thermal_sysfs.c       |   20 +++++++-------
>   drivers/thermal/thermal_trip.c        |   15 +++++------
>   include/linux/thermal.h               |    9 ++++--
>   10 files changed, 78 insertions(+), 52 deletions(-)
> 
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -61,7 +61,6 @@ enum thermal_notify_event {
>    * struct thermal_trip - representation of a point in temperature domain
>    * @temperature: temperature value in miliCelsius
>    * @hysteresis: relative hysteresis in miliCelsius
> - * @threshold: trip crossing notification threshold miliCelsius
>    * @type: trip point type
>    * @priv: pointer to driver data associated with this trip
>    * @flags: flags representing binary properties of the trip
> @@ -69,12 +68,16 @@ enum thermal_notify_event {
>   struct thermal_trip {
>   	int temperature;
>   	int hysteresis;
> -	int threshold;
>   	enum thermal_trip_type type;
>   	u8 flags;
>   	void *priv;
>   };
>   
> +struct thermal_trip_desc {
> +	struct thermal_trip trip;
> +	int threshold;
> +};
> +
>   #define THERMAL_TRIP_FLAG_RW_TEMP	BIT(0)
>   #define THERMAL_TRIP_FLAG_RW_HYST	BIT(1)
>   
> @@ -203,7 +206,7 @@ struct thermal_zone_device {
>   #ifdef CONFIG_THERMAL_DEBUGFS
>   	struct thermal_debugfs *debugfs;
>   #endif
> -	struct thermal_trip trips[] __counted_by(num_trips);
> +	struct thermal_trip_desc trips[] __counted_by(num_trips);
>   };
>   
>   /**
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -361,17 +361,19 @@ static void handle_critical_trips(struct
>   }
>   
>   static void handle_thermal_trip(struct thermal_zone_device *tz,
> -				struct thermal_trip *trip)
> +				struct thermal_trip_desc *td)
>   {
> +	const struct thermal_trip *trip = &td->trip;
> +
>   	if (trip->temperature == THERMAL_TEMP_INVALID)
>   		return;
>   
>   	if (tz->last_temperature == THERMAL_TEMP_INVALID) {
>   		/* Initialization. */
> -		trip->threshold = trip->temperature;
> -		if (tz->temperature >= trip->threshold)
> -			trip->threshold -= trip->hysteresis;
> -	} else if (tz->last_temperature < trip->threshold) {
> +		td->threshold = trip->temperature;
> +		if (tz->temperature >= td->threshold)
> +			td->threshold -= trip->hysteresis;
> +	} else if (tz->last_temperature < td->threshold) {
>   		/*
>   		 * The trip threshold is equal to the trip temperature, unless
>   		 * the latter has changed in the meantime.  In either case,
> @@ -382,9 +384,9 @@ static void handle_thermal_trip(struct t
>   		if (tz->temperature >= trip->temperature) {
>   			thermal_notify_tz_trip_up(tz, trip);
>   			thermal_debug_tz_trip_up(tz, trip);
> -			trip->threshold = trip->temperature - trip->hysteresis;
> +			td->threshold = trip->temperature - trip->hysteresis;
>   		} else {
> -			trip->threshold = trip->temperature;
> +			td->threshold = trip->temperature;
>   		}
>   	} else {
>   		/*
> @@ -400,9 +402,9 @@ static void handle_thermal_trip(struct t
>   		if (tz->temperature < trip->temperature - trip->hysteresis) {
>   			thermal_notify_tz_trip_down(tz, trip);
>   			thermal_debug_tz_trip_down(tz, trip);
> -			trip->threshold = trip->temperature;
> +			td->threshold = trip->temperature;
>   		} else {
> -			trip->threshold = trip->temperature - trip->hysteresis;
> +			td->threshold = trip->temperature - trip->hysteresis;
>   		}
>   	}
>   
> @@ -458,7 +460,7 @@ static void thermal_zone_device_init(str
>   void __thermal_zone_device_update(struct thermal_zone_device *tz,
>   				  enum thermal_notify_event event)
>   {
> -	struct thermal_trip *trip;
> +	struct thermal_trip_desc *td;
>   
>   	if (tz->suspended)
>   		return;
> @@ -472,8 +474,8 @@ void __thermal_zone_device_update(struct
>   
>   	tz->notify_event = event;
>   
> -	for_each_trip(tz, trip)
> -		handle_thermal_trip(tz, trip);
> +	for_each_trip_desc(tz, td)
> +		handle_thermal_trip(tz, td);
>   
>   	monitor_thermal_zone(tz);
>   }
> @@ -766,7 +768,7 @@ int thermal_zone_bind_cooling_device(str
>   	if (trip_index < 0 || trip_index >= tz->num_trips)
>   		return -EINVAL;
>   
> -	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index], cdev,
> +	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
>   					 upper, lower, weight);
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
> @@ -825,7 +827,7 @@ int thermal_zone_unbind_cooling_device(s
>   	if (trip_index < 0 || trip_index >= tz->num_trips)
>   		return -EINVAL;
>   
> -	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index], cdev);
> +	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cdev);
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
>   
> @@ -1221,16 +1223,19 @@ static void thermal_set_delay_jiffies(un
>   
>   int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
>   {
> -	int i, ret = -EINVAL;
> +	const struct thermal_trip_desc *td;
> +	int ret = -EINVAL;
>   
>   	if (tz->ops.get_crit_temp)
>   		return tz->ops.get_crit_temp(tz, temp);
>   
>   	mutex_lock(&tz->lock);
>   
> -	for (i = 0; i < tz->num_trips; i++) {
> -		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
> -			*temp = tz->trips[i].temperature;
> +	for_each_trip_desc(tz, td) {
> +		const struct thermal_trip *trip = &td->trip;
> +
> +		if (trip->type == THERMAL_TRIP_CRITICAL) {
> +			*temp = trip->temperature;
>   			ret = 0;
>   			break;
>   		}
> @@ -1274,7 +1279,9 @@ thermal_zone_device_register_with_trips(
>   					const struct thermal_zone_params *tzp,
>   					int passive_delay, int polling_delay)
>   {
> +	const struct thermal_trip *trip = trips;
>   	struct thermal_zone_device *tz;
> +	struct thermal_trip_desc *td;
>   	int id;
>   	int result;
>   	struct thermal_governor *governor;
> @@ -1339,7 +1346,8 @@ thermal_zone_device_register_with_trips(
>   	tz->device.class = thermal_class;
>   	tz->devdata = devdata;
>   	tz->num_trips = num_trips;
> -	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
> +	for_each_trip_desc(tz, td)
> +		td->trip = *trip++;
>   
>   	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>   	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -120,8 +120,11 @@ void thermal_governor_update_tz(struct t
>   				enum thermal_notify_event reason);
>   
>   /* Helpers */
> -#define for_each_trip(__tz, __trip)	\
> -	for (__trip = __tz->trips; __trip - __tz->trips < __tz->num_trips; __trip++)
> +#define for_each_trip_desc(__tz, __td)	\
> +	for (__td = __tz->trips; __td - __tz->trips < __tz->num_trips; __td++)
> +
> +#define trip_to_trip_desc(__trip)	\
> +	container_of(__trip, struct thermal_trip_desc, trip)
>   
>   void __thermal_zone_set_trips(struct thermal_zone_device *tz);
>   int thermal_zone_trip_id(const struct thermal_zone_device *tz,
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -88,7 +88,7 @@ trip_point_type_show(struct device *dev,
>   	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	switch (tz->trips[trip_id].type) {
> +	switch (tz->trips[trip_id].trip.type) {

This could be a bit shorter, with some helper variable, but that's
minor cosmetic.

>   	case THERMAL_TRIP_CRITICAL:
>   		return sprintf(buf, "critical\n");
>   	case THERMAL_TRIP_HOT:
> @@ -120,7 +120,7 @@ trip_point_temp_store(struct device *dev
>   
>   	mutex_lock(&tz->lock);
>   
> -	trip = &tz->trips[trip_id];
> +	trip = &tz->trips[trip_id].trip;
>   
>   	if (temp != trip->temperature) {
>   		if (tz->ops.set_trip_temp) {
> @@ -150,7 +150,7 @@ trip_point_temp_show(struct device *dev,
>   	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
> +	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.temperature);
>   }
>   
>   static ssize_t
> @@ -171,7 +171,7 @@ trip_point_hyst_store(struct device *dev
>   
>   	mutex_lock(&tz->lock);
>   
> -	trip = &tz->trips[trip_id];
> +	trip = &tz->trips[trip_id].trip;
>   
>   	if (hyst != trip->hysteresis) {
>   		trip->hysteresis = hyst;
> @@ -194,7 +194,7 @@ trip_point_hyst_show(struct device *dev,
>   	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	return sprintf(buf, "%d\n", tz->trips[trip_id].hysteresis);
> +	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.hysteresis);
>   }
>   
>   static ssize_t
> @@ -393,7 +393,7 @@ static const struct attribute_group *the
>    */
>   static int create_trip_attrs(struct thermal_zone_device *tz)
>   {
> -	const struct thermal_trip *trip;
> +	const struct thermal_trip_desc *td;
>   	struct attribute **attrs;
>   
>   	/* This function works only for zones with at least one trip */
> @@ -429,8 +429,8 @@ static int create_trip_attrs(struct ther
>   		return -ENOMEM;
>   	}
>   
> -	for_each_trip(tz, trip) {
> -		int indx = thermal_zone_trip_id(tz, trip);
> +	for_each_trip_desc(tz, td) {
> +		int indx = thermal_zone_trip_id(tz, &td->trip);
>   
>   		/* create trip type attribute */
>   		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
> @@ -452,7 +452,7 @@ static int create_trip_attrs(struct ther
>   						tz->trip_temp_attrs[indx].name;
>   		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
>   		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
> -		if (trip->flags & THERMAL_TRIP_FLAG_RW_TEMP) {
> +		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_TEMP) {
>   			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
>   			tz->trip_temp_attrs[indx].attr.store =
>   							trip_point_temp_store;
> @@ -467,7 +467,7 @@ static int create_trip_attrs(struct ther
>   					tz->trip_hyst_attrs[indx].name;
>   		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
>   		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
> -		if (trip->flags & THERMAL_TRIP_FLAG_RW_HYST) {
> +		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_HYST) {
>   			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
>   			tz->trip_hyst_attrs[indx].attr.store =
>   					trip_point_hyst_store;
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -744,7 +744,7 @@ static void tze_seq_stop(struct seq_file
>   static int tze_seq_show(struct seq_file *s, void *v)
>   {
>   	struct thermal_zone_device *tz = s->private;
> -	struct thermal_trip *trip;
> +	struct thermal_trip_desc *td;
>   	struct tz_episode *tze;
>   	const char *type;
>   	int trip_id;
> @@ -757,7 +757,9 @@ static int tze_seq_show(struct seq_file
>   
>   	seq_printf(s, "| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |\n");
>   
> -	for_each_trip(tz, trip) {
> +	for_each_trip_desc(tz, td) {
> +		const struct thermal_trip *trip = &td->trip;
> +
>   		/*
>   		 * There is no possible mitigation happening at the
>   		 * critical trip point, so the stats will be always
> Index: linux-pm/drivers/thermal/thermal_netlink.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> +++ linux-pm/drivers/thermal/thermal_netlink.c
> @@ -442,7 +442,7 @@ out_cancel_nest:
>   static int thermal_genl_cmd_tz_get_trip(struct param *p)
>   {
>   	struct sk_buff *msg = p->msg;
> -	const struct thermal_trip *trip;
> +	const struct thermal_trip_desc *td;
>   	struct thermal_zone_device *tz;
>   	struct nlattr *start_trip;
>   	int id;
> @@ -462,7 +462,9 @@ static int thermal_genl_cmd_tz_get_trip(
>   
>   	mutex_lock(&tz->lock);
>   
> -	for_each_trip(tz, trip) {
> +	for_each_trip_desc(tz, td) {
> +		const struct thermal_trip *trip = &td->trip;
> +
>   		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID,
>   				thermal_zone_trip_id(tz, trip)) ||
>   		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip->type) ||
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -13,11 +13,11 @@ int for_each_thermal_trip(struct thermal
>   			  int (*cb)(struct thermal_trip *, void *),
>   			  void *data)
>   {
> -	struct thermal_trip *trip;
> +	struct thermal_trip_desc *td;
>   	int ret;
>   
> -	for_each_trip(tz, trip) {
> -		ret = cb(trip, data);
> +	for_each_trip_desc(tz, td) {
> +		ret = cb(&td->trip, data);
>   		if (ret)
>   			return ret;
>   	}
> @@ -63,7 +63,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_num_t
>    */
>   void __thermal_zone_set_trips(struct thermal_zone_device *tz)
>   {
> -	const struct thermal_trip *trip;
> +	const struct thermal_trip_desc *td;
>   	int low = -INT_MAX, high = INT_MAX;
>   	int ret;
>   
> @@ -72,7 +72,8 @@ void __thermal_zone_set_trips(struct the
>   	if (!tz->ops.set_trips)
>   		return;
>   
> -	for_each_trip(tz, trip) {
> +	for_each_trip_desc(tz, td) {
> +		const struct thermal_trip *trip = &td->trip;
>   		int trip_low;
>   
>   		trip_low = trip->temperature - trip->hysteresis;
> @@ -110,7 +111,7 @@ int __thermal_zone_get_trip(struct therm
>   	if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
>   		return -EINVAL;
>   
> -	*trip = tz->trips[trip_id];
> +	*trip = tz->trips[trip_id].trip;
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
> @@ -135,7 +136,7 @@ int thermal_zone_trip_id(const struct th
>   	 * Assume the trip to be located within the bounds of the thermal
>   	 * zone's trips[] table.
>   	 */
> -	return trip - tz->trips;
> +	return trip_to_trip_desc(trip) - tz->trips;
>   }
>   void thermal_zone_trip_updated(struct thermal_zone_device *tz,
>   			       const struct thermal_trip *trip)
> Index: linux-pm/drivers/thermal/gov_fair_share.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> +++ linux-pm/drivers/thermal/gov_fair_share.c
> @@ -17,10 +17,13 @@
>   
>   static int get_trip_level(struct thermal_zone_device *tz)
>   {
> -	const struct thermal_trip *trip, *level_trip = NULL;
> +	const struct thermal_trip *level_trip = NULL;
> +	const struct thermal_trip_desc *td;
>   	int trip_level = -1;
>   
> -	for_each_trip(tz, trip) {
> +	for_each_trip_desc(tz, td) {
> +		const struct thermal_trip *trip = &td->trip;
> +
>   		if (trip->temperature >= tz->temperature)
>   			continue;
>   
> Index: linux-pm/drivers/thermal/gov_power_allocator.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> +++ linux-pm/drivers/thermal/gov_power_allocator.c
> @@ -496,9 +496,11 @@ static void get_governor_trips(struct th
>   	const struct thermal_trip *first_passive = NULL;
>   	const struct thermal_trip *last_passive = NULL;
>   	const struct thermal_trip *last_active = NULL;
> -	const struct thermal_trip *trip;
> +	const struct thermal_trip_desc *td;
> +
> +	for_each_trip_desc(tz, td) {
> +		const struct thermal_trip *trip = &td->trip;
>   
> -	for_each_trip(tz, trip) {
>   		switch (trip->type) {
>   		case THERMAL_TRIP_PASSIVE:
>   			if (!first_passive) {
> Index: linux-pm/drivers/thermal/thermal_helpers.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_helpers.c
> +++ linux-pm/drivers/thermal/thermal_helpers.c
> @@ -50,7 +50,7 @@ get_thermal_instance(struct thermal_zone
>   	mutex_lock(&tz->lock);
>   	mutex_lock(&cdev->lock);
>   
> -	trip = &tz->trips[trip_index];
> +	trip = &tz->trips[trip_index].trip;
>   
>   	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
>   		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
> @@ -82,7 +82,7 @@ EXPORT_SYMBOL(get_thermal_instance);
>    */
>   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>   {
> -	const struct thermal_trip *trip;
> +	const struct thermal_trip_desc *td;
>   	int crit_temp = INT_MAX;
>   	int ret = -EINVAL;
>   
> @@ -91,7 +91,9 @@ int __thermal_zone_get_temp(struct therm
>   	ret = tz->ops.get_temp(tz, temp);
>   
>   	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
> -		for_each_trip(tz, trip) {
> +		for_each_trip_desc(tz, td) {
> +			const struct thermal_trip *trip = &td->trip;
> +
>   			if (trip->type == THERMAL_TRIP_CRITICAL) {
>   				crit_temp = trip->temperature;
>   				break;
> 
> 
> 

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

