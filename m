Return-Path: <linux-pm+bounces-16155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7A39A9353
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F563283AB7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712C1FCC7F;
	Mon, 21 Oct 2024 22:29:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4821DDAB;
	Mon, 21 Oct 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549785; cv=none; b=fBUkkm6YcHEAzgQs2PUp7W11YoRM9tfdMUskEyQX8qoJQU55r0wWgagX8HyDn1xXyVRC9K0oE3bvUP9I9iyOtd2N8lvK/64fNY5fBcTyXdjiXMRtwz59EHAkOWqqKKlIQ7sf5a6Kw6TijVlA2CCFNRSo1u8oocLC7p1XwQZcfhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549785; c=relaxed/simple;
	bh=dKZrfhPdmyuzohwpr6Ekx7caFoT70m1yEyJd4AdAoyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfebGjrRrvJxEz1tMG/QBUvCktBqSBdGOs0cSuzF3nlcbuOCj9gU/HjYspCRcrIIKyiBAKaad0B5LI1JOfIQ9G/0AzG7vLT63c0hZLlCxw0fFkPjXAZ5Pkp7IZvAIEZlLIkAiHr3WOW2PEDDXR8pdpn6w6O0PSibj6Zew78Vpfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D96B1497;
	Mon, 21 Oct 2024 15:30:12 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEC963F71E;
	Mon, 21 Oct 2024 15:29:41 -0700 (PDT)
Message-ID: <1ef9dcdc-763d-418b-8d22-6ba139671f70@arm.com>
Date: Mon, 21 Oct 2024 23:30:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] thermal: core: Consolidate thermal zone locking
 during initialization
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <1920382.CQOukoFCf9@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1920382.CQOukoFCf9@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The part of thermal zone initialization carried out under
> thermal_list_lock acquires the thermal zone lock and releases it
> multiple times back and forth which is not really necessary.
> 
> Instead of doing this, make it acquire the thermal zone lock once after
> acquiring thermal_list_lock and release it along with that lock.
> 
> For this purpose, move all of the code in question to
> thermal_zone_init_complete() introduced previously and provide an
> "unlocked" variant of thermal_zone_cdev_bind() to be invoked from
> there.
> 
> Also notice that a thermal zone does not need to be added to
> thermal_tz_list under its own lock, so make the new code acquire
> the thermal zone lock after adding it to the list.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/10548633.nUPlyArG6x@rjwysocki.net/
> 
> v1 -> v2: Rebase, update the changelog.
> 
> ---
>   drivers/thermal/thermal_core.c |   39 ++++++++++++++++++++++-----------------
>   1 file changed, 22 insertions(+), 17 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -933,16 +933,14 @@ void print_bind_err_msg(struct thermal_z
>   		cdev->type, thermal_zone_trip_id(tz, trip), ret);
>   }
>   
> -static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
> -				   struct thermal_cooling_device *cdev)
> +static void __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
> +				     struct thermal_cooling_device *cdev)
>   {
>   	struct thermal_trip_desc *td;
>   
>   	if (!tz->ops.should_bind)
>   		return;
>   
> -	mutex_lock(&tz->lock);
> -
>   	for_each_trip_desc(tz, td) {
>   		struct thermal_trip *trip = &td->trip;
>   		struct cooling_spec c = {
> @@ -959,6 +957,14 @@ static void thermal_zone_cdev_bind(struc
>   		if (ret)
>   			print_bind_err_msg(tz, trip, cdev, ret);
>   	}
> +}
> +
> +static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
> +				   struct thermal_cooling_device *cdev)
> +{
> +	mutex_lock(&tz->lock);
> +
> +	__thermal_zone_cdev_bind(tz, cdev);
>   
>   	mutex_unlock(&tz->lock);
>   }
> @@ -1336,8 +1342,18 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_
>   
>   static void thermal_zone_init_complete(struct thermal_zone_device *tz)
>   {
> +	struct thermal_cooling_device *cdev;
> +
> +	mutex_lock(&thermal_list_lock);
> +
> +	list_add_tail(&tz->node, &thermal_tz_list);
> +
>   	mutex_lock(&tz->lock);
>   
> +	/* Bind cooling devices for this zone. */
> +	list_for_each_entry(cdev, &thermal_cdev_list, node)
> +		__thermal_zone_cdev_bind(tz, cdev);
> +
>   	tz->state &= ~TZ_STATE_FLAG_INIT;
>   	/*
>   	 * If system suspend or resume is in progress at this point, the
> @@ -1350,6 +1366,8 @@ static void thermal_zone_init_complete(s
>   	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   
>   	mutex_unlock(&tz->lock);
> +
> +	mutex_unlock(&thermal_list_lock);
>   }
>   
>   /**
> @@ -1386,7 +1404,6 @@ thermal_zone_device_register_with_trips(
>   					unsigned int polling_delay)
>   {
>   	const struct thermal_trip *trip = trips;
> -	struct thermal_cooling_device *cdev;
>   	struct thermal_zone_device *tz;
>   	struct thermal_trip_desc *td;
>   	int id;
> @@ -1514,20 +1531,8 @@ thermal_zone_device_register_with_trips(
>   			goto unregister;
>   	}
>   
> -	mutex_lock(&thermal_list_lock);
> -
> -	mutex_lock(&tz->lock);
> -	list_add_tail(&tz->node, &thermal_tz_list);
> -	mutex_unlock(&tz->lock);
> -
> -	/* Bind cooling devices for this zone */
> -	list_for_each_entry(cdev, &thermal_cdev_list, node)
> -		thermal_zone_cdev_bind(tz, cdev);
> -
>   	thermal_zone_init_complete(tz);
>   
> -	mutex_unlock(&thermal_list_lock);
> -
>   	thermal_notify_tz_create(tz);
>   
>   	thermal_debug_tz_add(tz);
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

