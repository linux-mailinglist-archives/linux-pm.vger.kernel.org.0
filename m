Return-Path: <linux-pm+bounces-4263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA9A85FB60
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC23284841
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E8E1468F7;
	Thu, 22 Feb 2024 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q72bJHz3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAE36B15
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612570; cv=none; b=kczV0bOggL9jZHR659RbNRL+BsHuBNKMBOE3AljK85BALV/mGS4+xDcXKNU99Y3yZCLd2mAQo73+8HHNMv3MtgXP4cy6d3JD2yVjsKwdGA44qJojrsuoaJDN4P7ViuHNO90knWu48F9Y9WFzMOZcrlcAsmEM3Yan7rOWIxs2DiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612570; c=relaxed/simple;
	bh=HliuWGGmLq3LvWFnUzny9BGxNLmSfmBeFrSvnFUmeT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdikj9lELyj0D+y+BJ397N5/pm6Y2ApG51lsA5Lsh01XS2XqIgKzdV3jK0v+ZxwGEWZHQyvLXv4//u6PJTDyUZHN0rH0MmaXQXWVagMyXJAex5rfNVjSM/b8bNR/BqWFV+yKvtnu6i2GTSVXmhelJVTAFl91oBxCnpTE8EgjiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q72bJHz3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so13877395e9.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 06:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708612567; x=1709217367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97R8kfjvE4ydiVE9xk3Hq8ViU+odGzafXCe6ly6SQak=;
        b=q72bJHz3oZ5vkUpFZj9FecLT/Sx8TTW5RZRLvmol98Wb1rO7B0Ee8LsoZhYzv7Mtkk
         t85bGRbSoP2If6hUCTect2IhLzzMdUJNLETTOHWUEZEXvl4nfj53Sl+cZTeAStltJAm5
         7YvZ7fjNzgdmG2vmxvyRgT4C9rh5gJKfMo6xlmmts503a2RcOh44lmceBoJ56lOt4x+X
         9ljhSdC8ZdZq50W25CrFxYpJyHqPZ6N+ENGr43BTWUqZUuhjogyhGTSJ9U1F7QPF6yuI
         FN5FkMW1zTg0dy5pG3yqsreW/Yz4Bu+o7XHaP/IZxDuPkM0iy9K8nMsMiT+lJmLzfQFV
         OYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612567; x=1709217367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97R8kfjvE4ydiVE9xk3Hq8ViU+odGzafXCe6ly6SQak=;
        b=jwRKeJE52PJZ6lhJtGGFnYV+zLAIpvpX5kzQhl96TUKj1j3tf8SJNIJd2VQX4TmqV2
         dj39u677Ph9E/b6MY1ClaSN+3wrTvQhOY1BdXNVU0VnYZ7Aj1gkdxVhGhE/cdZZzweuP
         OdFOIuUNDshiDBLG32nTUurpY9rvYfnUmkrYuxRi5mPukpfO5oMFbagDRHTu+6ZKnpar
         +TD+7vYVXzGvuj/+VCI7KvyhWl7jyYBjWwq6hmGw7dGhjFIJiFHECjfLdwTdhe1q7nMC
         Dr453wJCYlIfvnHaTM+KBMFZxx9d8N1JLAopmTwsKyYmC+dn+c5ALKRalroWqmgv/8HU
         3nRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL72GBl6FfHn5YIP2MCl07tsJg4/5K2YPX32Keajf9JwXPqLCjcsKlmLIMlhMwF6qJ0R97xMxVgccRUZ/AnIuVFACztzcGcwQ=
X-Gm-Message-State: AOJu0YwBasbvNHcE5OO5Q9nrcTI/AVfMTrCncFRmFOJs5mXDljnjkL6u
	MkV66kwpkCsb3XP8n9nRaytKAxrS4y9e3E4Aq5PSsuWt5fGkxYBae9fhc5yUnjI=
X-Google-Smtp-Source: AGHT+IHu5V8esi5kOiAWFJ9acLTrnNi8Fr4bd1xwp17ik98eNa3jMw23rdKPpaaB5oRlxd4fqlFbhw==
X-Received: by 2002:adf:ff8a:0:b0:33d:30a4:d744 with SMTP id j10-20020adfff8a000000b0033d30a4d744mr10446253wrr.30.1708612566630;
        Thu, 22 Feb 2024 06:36:06 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id jj2-20020a05600c6a0200b004126732390asm6198255wmb.37.2024.02.22.06.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 06:36:06 -0800 (PST)
Message-ID: <59e8fd70-5ba6-4256-9127-bd5e76e6bc99@linaro.org>
Date: Thu, 22 Feb 2024 15:36:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] thermal: core: Add flags to struct thermal_trip
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <2173914.irdbgypaU6@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2173914.irdbgypaU6@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to allow thermal zone creators to specify the writability of
> trip point temperature and hysteresis on a per-trip basis, add a flags
> field to struct thermal_trip and define flags to represent the desired
> trip properties.
> 
> Also make thermal_zone_device_register_with_trips() set the
> THERMAL_TRIP_FLAG_RW_TEMP flag for all trips covered by the writable
> trips mask passed to it and modify the thermal sysfs code to look at
> the trip flags instead of using the writable trips mask directly or
> checking the presence of the .set_trip_hyst() zone callback.
> 
> Additionally, make trip_point_temp_store() and trip_point_hyst_store()
> fail with an error code if the trip passed to one of them has
> THERMAL_TRIP_FLAG_RW_TEMP or THERMAL_TRIP_FLAG_RW_HYST,
> respectively, clear in its flags.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>     * Rename trip flags (Stanislaw).
> 
> ---
>   drivers/thermal/thermal_core.c  |   12 +++++++++++-
>   drivers/thermal/thermal_core.h  |    2 +-
>   drivers/thermal/thermal_sysfs.c |   28 +++++++++++++++++++---------
>   include/linux/thermal.h         |    7 +++++++
>   4 files changed, 38 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -64,15 +64,23 @@ enum thermal_notify_event {
>    * @threshold: trip crossing notification threshold miliCelsius
>    * @type: trip point type
>    * @priv: pointer to driver data associated with this trip
> + * @flags: flags representing binary properties of the trip
>    */
>   struct thermal_trip {
>   	int temperature;
>   	int hysteresis;
>   	int threshold;
>   	enum thermal_trip_type type;
> +	u8 flags;
>   	void *priv;
>   };
>   
> +#define THERMAL_TRIP_FLAG_RW_TEMP	BIT(0)
> +#define THERMAL_TRIP_FLAG_RW_HYST	BIT(1)
> +
> +#define THERMAL_TRIP_FLAG_MASK_RW	(THERMAL_TRIP_FLAG_RW_TEMP | \
> +					 THERMAL_TRIP_FLAG_RW_HYST)

What about THERMAL_TRIP_FLAG_RW instead ?

>   struct thermal_zone_device_ops {
>   	int (*bind) (struct thermal_zone_device *,
>   		     struct thermal_cooling_device *);
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1356,13 +1356,23 @@ thermal_zone_device_register_with_trips(
>   	tz->devdata = devdata;
>   	tz->trips = trips;
>   	tz->num_trips = num_trips;
> +	if (num_trips > 0) {

Is this check really necessary? for_each_trip() should exit immediately 
if there is no trip points.

> +		struct thermal_trip *trip;
> +
> +		for_each_trip(tz, trip) {
> +			if (mask & 1)
> +				trip->flags |= THERMAL_TRIP_FLAG_RW_TEMP;
> +
> +			mask >>= 1;
> +		}
> +	}
>   
>   	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>   	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
>   
>   	/* sys I/F */
>   	/* Add nodes that are always present via .groups */
> -	result = thermal_zone_create_device_groups(tz, mask);
> +	result = thermal_zone_create_device_groups(tz);
>   	if (result)
>   		goto remove_id;
>   
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -131,7 +131,7 @@ void thermal_zone_trip_updated(struct th
>   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>   
>   /* sysfs I/F */
> -int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
> +int thermal_zone_create_device_groups(struct thermal_zone_device *tz);
>   void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
>   void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
>   void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_device *cdev);
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -122,6 +122,11 @@ trip_point_temp_store(struct device *dev
>   
>   	trip = &tz->trips[trip_id];
>   
> +	if (!(trip->flags & THERMAL_TRIP_FLAG_RW_TEMP)) {
> +		ret = -EPERM;
> +		goto unlock;
> +	}

Does it really happen?

If the sysfs file is created with the right permission regarding the 
trip->flags then this condition can never be true.

>   	if (temp != trip->temperature) {
>   		if (tz->ops->set_trip_temp) {
>   			ret = tz->ops->set_trip_temp(tz, trip_id, temp);
> @@ -173,6 +178,11 @@ trip_point_hyst_store(struct device *dev
>   
>   	trip = &tz->trips[trip_id];
>   
> +	if (!(trip->flags & THERMAL_TRIP_FLAG_RW_HYST)) {
> +		ret = -EPERM;
> +		goto unlock;
> +	}

Ditto

>   	if (hyst != trip->hysteresis) {
>   		if (tz->ops->set_trip_hyst) {
>   			ret = tz->ops->set_trip_hyst(tz, trip_id, hyst);
> @@ -392,17 +402,16 @@ static const struct attribute_group *the
>   /**
>    * create_trip_attrs() - create attributes for trip points
>    * @tz:		the thermal zone device
> - * @mask:	Writeable trip point bitmap.
>    *
>    * helper function to instantiate sysfs entries for every trip
>    * point and its properties of a struct thermal_zone_device.
>    *
>    * Return: 0 on success, the proper error value otherwise.
>    */
> -static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
> +static int create_trip_attrs(struct thermal_zone_device *tz)
>   {
> +	const struct thermal_trip *trip;
>   	struct attribute **attrs;
> -	int indx;
>   
>   	/* This function works only for zones with at least one trip */
>   	if (tz->num_trips <= 0)
> @@ -437,7 +446,9 @@ static int create_trip_attrs(struct ther
>   		return -ENOMEM;
>   	}
>   
> -	for (indx = 0; indx < tz->num_trips; indx++) {
> +	for_each_trip(tz, trip) {
> +		int indx = thermal_zone_trip_id(tz, trip);
> +
>   		/* create trip type attribute */
>   		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
>   			 "trip_point_%d_type", indx);
> @@ -458,7 +469,7 @@ static int create_trip_attrs(struct ther
>   						tz->trip_temp_attrs[indx].name;
>   		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
>   		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
> -		if (mask & (1 << indx)) {
> +		if (trip->flags & THERMAL_TRIP_FLAG_RW_TEMP) {
>   			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
>   			tz->trip_temp_attrs[indx].attr.store =
>   							trip_point_temp_store;
> @@ -473,7 +484,7 @@ static int create_trip_attrs(struct ther
>   					tz->trip_hyst_attrs[indx].name;
>   		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
>   		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
> -		if (tz->ops->set_trip_hyst) {
> +		if (trip->flags & THERMAL_TRIP_FLAG_RW_HYST) {
>   			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
>   			tz->trip_hyst_attrs[indx].attr.store =
>   					trip_point_hyst_store;
> @@ -505,8 +516,7 @@ static void destroy_trip_attrs(struct th
>   	kfree(tz->trips_attribute_group.attrs);
>   }
>   
> -int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
> -				      int mask)
> +int thermal_zone_create_device_groups(struct thermal_zone_device *tz)
>   {
>   	const struct attribute_group **groups;
>   	int i, size, result;
> @@ -522,7 +532,7 @@ int thermal_zone_create_device_groups(st
>   		groups[i] = thermal_zone_attribute_groups[i];
>   
>   	if (tz->num_trips) {
> -		result = create_trip_attrs(tz, mask);
> +		result = create_trip_attrs(tz);
>   		if (result) {
>   			kfree(groups);
>   
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


