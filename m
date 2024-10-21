Return-Path: <linux-pm+bounces-16159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4849A9366
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D51284214
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058491E2838;
	Mon, 21 Oct 2024 22:34:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA23137750;
	Mon, 21 Oct 2024 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550076; cv=none; b=XRU5qFnN5ns19gM8wmMukE4F3uerNKOjl56SiBdyqEsZEp4jV2YzEBS9+4im/hoYa8GVPOPJD0CsI4KfQnVqkEcD5K1ewMJf6R5yya0rn9Mqr7gvmxxczLn16kowIYWeN2886xgAGXhWXGbpiusHgsMOHTuOUhzyVYkpNhAHWHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550076; c=relaxed/simple;
	bh=69I2Kj+pqJEyuo97NNCgPGffEiN9AU+KmDUj8eJqI70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrhpcTgr86FMvKm7n6aPnVlzJE75tYxDEcNNnAY9WB3R/8/CjSDMuq7Y+MFmxycz/fRbmR5opgmvfHopxmAo0uah4mY/jzSyX+H1qlM+P083CdqVjVVUS1oFS1w/N2muGnnytdwNDmpYjgsIOpE0Gn/3zjawjO4gh/tBSBL90lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A770497;
	Mon, 21 Oct 2024 15:35:03 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87D4D3F71E;
	Mon, 21 Oct 2024 15:34:32 -0700 (PDT)
Message-ID: <be9ce314-57f1-4964-a1f5-0d8f466cc155@arm.com>
Date: Mon, 21 Oct 2024 23:35:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] thermal: core: Update thermal zones after
 cooling device binding
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <2226302.Icojqenx9y@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2226302.Icojqenx9y@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a new cooling device is registered and it is bound to at least one
> trip point in a given thermal zone, that thermal zone needs to be
> updated via __thermal_zone_device_update().
> 
> Instead of doing this with the help of the need_update atomic field in
> struct thermal_zone_device, which is not particularly straightforward,
> make __thermal_zone_cdev_bind() return a bool value indicating whether
> or not the given thermal zone needs to be updated because a new cooling
> device has been bound to it and update thermal_zone_cdev_bind() to
> call __thermal_zone_device_update() when this value is "true".
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/3603909.iIbC2pHGDl@rjwysocki.net/
> 
> v1 -> v2: Rebase.
> 
> ---
>   drivers/thermal/thermal_core.c |   23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -933,13 +933,14 @@ void print_bind_err_msg(struct thermal_z
>   		cdev->type, thermal_zone_trip_id(tz, trip), ret);
>   }
>   
> -static void __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
> +static bool __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
>   				     struct thermal_cooling_device *cdev)
>   {
>   	struct thermal_trip_desc *td;
> +	bool update_tz = false;
>   
>   	if (!tz->ops.should_bind)
> -		return;
> +		return false;
>   
>   	for_each_trip_desc(tz, td) {
>   		struct thermal_trip *trip = &td->trip;
> @@ -954,9 +955,15 @@ static void __thermal_zone_cdev_bind(str
>   			continue;
>   
>   		ret = thermal_bind_cdev_to_trip(tz, trip, cdev, &c);
> -		if (ret)
> +		if (ret) {
>   			print_bind_err_msg(tz, trip, cdev, ret);
> +			continue;
> +		}
> +
> +		update_tz = true;
>   	}
> +
> +	return update_tz;
>   }
>   
>   static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
> @@ -964,7 +971,8 @@ static void thermal_zone_cdev_bind(struc
>   {
>   	mutex_lock(&tz->lock);
>   
> -	__thermal_zone_cdev_bind(tz, cdev);
> +	if (__thermal_zone_cdev_bind(tz, cdev))
> +		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   
>   	mutex_unlock(&tz->lock);
>   }
> @@ -991,7 +999,7 @@ __thermal_cooling_device_register(struct
>   				  const struct thermal_cooling_device_ops *ops)
>   {
>   	struct thermal_cooling_device *cdev;
> -	struct thermal_zone_device *pos = NULL;
> +	struct thermal_zone_device *pos;
>   	unsigned long current_state;
>   	int id, ret;
>   
> @@ -1067,11 +1075,6 @@ __thermal_cooling_device_register(struct
>   	list_for_each_entry(pos, &thermal_tz_list, node)
>   		thermal_zone_cdev_bind(pos, cdev);
>   
> -	list_for_each_entry(pos, &thermal_tz_list, node)
> -		if (atomic_cmpxchg(&pos->need_update, 1, 0))
> -			thermal_zone_device_update(pos,
> -						   THERMAL_EVENT_UNSPECIFIED);
> -
>   	mutex_unlock(&thermal_list_lock);
>   
>   	return cdev;
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

