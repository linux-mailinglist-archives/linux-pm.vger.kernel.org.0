Return-Path: <linux-pm+bounces-16153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5001E9A933A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265C21F21C8C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229211E2839;
	Mon, 21 Oct 2024 22:25:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118D433D8;
	Mon, 21 Oct 2024 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549500; cv=none; b=AR88aZ/HyUSW9nyNmY1y7TpQ6fPJXMpowPkXcuypRAIGBAbIGyXXyVOXH1oPsaWaYfRUn0PYccpUyVSBXOs3ifIeZkGEM2WQrTVXcz7EqQzfFroM8kCtrGMM2WFqnHoHshbw2Xux4VCnrsG951iYqNdqtLtAzq0Wee7IK3pOv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549500; c=relaxed/simple;
	bh=1quJ70PHVAFiGCbTmU5DWWW6j2chOCF8o4r7b2YCC5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRuekMdNGqeHmL1l6RxZJ2f4u/dm0K2WAM6zPovSXlc+f0mo8a9UG+nueDdfrihRibcD1i3ogYK43a/6lh7xHwyhGCwYw0n6rdmq7XE33k7NNXlA1PsQkZRFfZV9WN37z438UGeNuOrEj2VIyftpc6o9k1Opp63YLbN1DFQb43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11B2A497;
	Mon, 21 Oct 2024 15:25:27 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F37D3F71E;
	Mon, 21 Oct 2024 15:24:56 -0700 (PDT)
Message-ID: <3b9688a6-517a-4317-8f59-8476e0462a40@arm.com>
Date: Mon, 21 Oct 2024 23:26:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] thermal: core: Mark thermal zones as
 initializing to start with
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <9360231.CDJkKcVGEf@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <9360231.CDJkKcVGEf@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After thermal_zone_device_register_with_trips() has called
> device_register() and it has registered the new thermal zone device
> with the driver core, user space may access its sysfs attributes and,
> among other things, it may enable the thermal zone before it is ready.
> 
> To address this, introduce a new thermal zone state flag for
> initialization and set it before calling device_register() in
> thermal_zone_device_register_with_trips().  This causes
> __thermal_zone_device_update() to return early until the new flag
> is cleared.
> 
> To clear it when the thermal zone is ready, introduce a new
> function called thermal_zone_init_complete() that will also invoke
> __thermal_zone_device_update() after clearing that flag (both under the
> thernal zone lock) and make thermal_zone_device_register_with_trips()
> call the new function instead of checking need_update and calling
> thermal_zone_device_update() when it is set.
> 
> After this change, if user space enables the thermal zone prematurely,
> __thermal_zone_device_update() will return early for it until
> thermal_zone_init_complete() is called.  In turn, if the thermal zone
> is not enabled by user space before thermal_zone_init_complete() is
> called, the __thermal_zone_device_update() call in it will return early
> because the thermal zone has not been enabled yet, but that function
> will be invoked again by thermal_zone_device_set_mode() when the thermal
> zone is enabled and it will not return early this time.
> 
> The checking of need_update is not necessary any more because the
> __thermal_zone_device_update() calls potentially triggered by cooling
> device binding take place before calling thermal_zone_init_complete(),
> so they all will return early, which means that
> thermal_zone_init_complete() must call __thermal_zone_device_update()
> in case the thermal zone is enabled prematurely by user space.
> 
> Fixes: 203d3d4aa482 ("the generic thermal sysfs driver")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/2973309.e9J7NaK4W3@rjwysocki.net/
> 
> v1 -> v2: Rebase and add a Fixes tag.
> 
> ---
>   drivers/thermal/thermal_core.c |   16 +++++++++++++---
>   drivers/thermal/thermal_core.h |    1 +
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1332,6 +1332,16 @@ int thermal_zone_get_crit_temp(struct th
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>   
> +static void thermal_zone_init_complete(struct thermal_zone_device *tz)
> +{
> +	mutex_lock(&tz->lock);
> +
> +	tz->state &= ~TZ_STATE_FLAG_INIT;
> +	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +
> +	mutex_unlock(&tz->lock);
> +}
> +
>   /**
>    * thermal_zone_device_register_with_trips() - register a new thermal zone device
>    * @type:	the thermal zone device type
> @@ -1451,6 +1461,8 @@ thermal_zone_device_register_with_trips(
>   	tz->passive_delay_jiffies = msecs_to_jiffies(passive_delay);
>   	tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
>   
> +	tz->state = TZ_STATE_FLAG_INIT;
> +
>   	/* sys I/F */
>   	/* Add nodes that are always present via .groups */
>   	result = thermal_zone_create_device_groups(tz);
> @@ -1504,9 +1516,7 @@ thermal_zone_device_register_with_trips(
>   
>   	mutex_unlock(&thermal_list_lock);
>   
> -	/* Update the new thermal zone and mark it as already updated. */
> -	if (atomic_cmpxchg(&tz->need_update, 1, 0))
> -		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +	thermal_zone_init_complete(tz);
>   
>   	thermal_notify_tz_create(tz);
>   
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -63,6 +63,7 @@ struct thermal_governor {
>   
>   #define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
>   #define	TZ_STATE_FLAG_RESUMING	BIT(1)
> +#define	TZ_STATE_FLAG_INIT	BIT(2)
>   
>   #define TZ_STATE_READY		0
>   
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

