Return-Path: <linux-pm+bounces-16265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C599AB830
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 23:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26043282C76
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256081CBEA6;
	Tue, 22 Oct 2024 21:08:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E6C59B71;
	Tue, 22 Oct 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631287; cv=none; b=LHMa2gB4UuEMhZslHQsr7XP8axyIoYwCzJW3JOgAo0Qbck9sfV0wsSFWr4B0FZ6FWWRwAh10tjnBV3b8X0TWXl3rHL2PeLeRhXKnRyeVh2ydowH/yMknO+5kBkIJhQFyc6TEo1DsqCOwBzj8LAfA2BSysjuBZ1vSvXn/autVwEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631287; c=relaxed/simple;
	bh=QfoauWacdRH4fKFWbPd349kvSGamjARqD6Cm+EFlUJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdwoXym78940GVX0Pu8GyPizoP3Nd2sVwOTv3mTUMLrxQ669KCotcWorpByHgmYFVOnXzaz/MtkkPmzQB1qUa0AhTVjJfvFN1ATmgEIRQWb4paEltA2tyRjrtVnqhbUFj+7AxY9VvGhFah/XbqNYaEGF3E133pK4xFzdf9W+ACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D94F497;
	Tue, 22 Oct 2024 14:08:33 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D45B13F71E;
	Tue, 22 Oct 2024 14:08:01 -0700 (PDT)
Message-ID: <d62d6745-678f-4168-964e-6c8366c128da@arm.com>
Date: Tue, 22 Oct 2024 22:09:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] thermal: core: Separate code running under
 thermal_list_lock
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <10572828.nUPlyArG6x@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <10572828.nUPlyArG6x@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 23:09, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To prepare for a subsequent change that will switch over the thermal
> core to using a mutex guard for thermal_list_lock management, move the
> code running under thermal_list_lock during the initialization and
> unregistration of cooling devices into separate functions.
> 
> While at it, drop some comments that do not add value.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-pm/1822468.VLH7GnMWUR@rjwysocki.net/
> 
> ---
>   drivers/thermal/thermal_core.c |   64 +++++++++++++++++++++++------------------
>   1 file changed, 36 insertions(+), 28 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -965,6 +965,20 @@ static void thermal_zone_cdev_bind(struc
>   		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   }
>   
> +static void thermal_cooling_device_init_complete(struct thermal_cooling_device *cdev)
> +{
> +	struct thermal_zone_device *tz;
> +
> +	mutex_lock(&thermal_list_lock);
> +
> +	list_add(&cdev->node, &thermal_cdev_list);
> +
> +	list_for_each_entry(tz, &thermal_tz_list, node)
> +		thermal_zone_cdev_bind(tz, cdev);
> +
> +	mutex_unlock(&thermal_list_lock);
> +}
> +
>   /**
>    * __thermal_cooling_device_register() - register a new thermal cooling device
>    * @np:		a pointer to a device tree node.
> @@ -987,7 +1001,6 @@ __thermal_cooling_device_register(struct
>   				  const struct thermal_cooling_device_ops *ops)
>   {
>   	struct thermal_cooling_device *cdev;
> -	struct thermal_zone_device *pos;
>   	unsigned long current_state;
>   	int id, ret;
>   
> @@ -1054,16 +1067,7 @@ __thermal_cooling_device_register(struct
>   	if (current_state <= cdev->max_state)
>   		thermal_debug_cdev_add(cdev, current_state);
>   
> -	/* Add 'this' new cdev to the global cdev list */
> -	mutex_lock(&thermal_list_lock);
> -
> -	list_add(&cdev->node, &thermal_cdev_list);
> -
> -	/* Update binding information for 'this' new cdev */
> -	list_for_each_entry(pos, &thermal_tz_list, node)
> -		thermal_zone_cdev_bind(pos, cdev);
> -
> -	mutex_unlock(&thermal_list_lock);
> +	thermal_cooling_device_init_complete(cdev);
>   
>   	return cdev;
>   
> @@ -1274,38 +1278,42 @@ static void thermal_zone_cdev_unbind(str
>   	__thermal_zone_cdev_unbind(tz, cdev);
>   }
>   
> -/**
> - * thermal_cooling_device_unregister - removes a thermal cooling device
> - * @cdev:	the thermal cooling device to remove.
> - *
> - * thermal_cooling_device_unregister() must be called when a registered
> - * thermal cooling device is no longer needed.
> - */
> -void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
> +static bool thermal_cooling_device_exit(struct thermal_cooling_device *cdev)
>   {
>   	struct thermal_zone_device *tz;
> -
> -	if (!cdev)
> -		return;
> -
> -	thermal_debug_cdev_remove(cdev);
> +	bool ret = true;
>   
>   	mutex_lock(&thermal_list_lock);
>   
>   	if (!thermal_cooling_device_present(cdev)) {
> -		mutex_unlock(&thermal_list_lock);
> -		return;
> +		ret = false;
> +		goto unlock;
>   	}
>   
>   	list_del(&cdev->node);
>   
> -	/* Unbind all thermal zones associated with 'this' cdev */
>   	list_for_each_entry(tz, &thermal_tz_list, node)
>   		thermal_zone_cdev_unbind(tz, cdev);
>   
> +unlock:
>   	mutex_unlock(&thermal_list_lock);
>   
> -	device_unregister(&cdev->device);
> +	return ret;
> +}
> +
> +/**
> + * thermal_cooling_device_unregister() - removes a thermal cooling device
> + * @cdev: Thermal cooling device to remove.
> + */
> +void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
> +{
> +	if (!cdev)
> +		return;
> +
> +	thermal_debug_cdev_remove(cdev);
> +
> +	if (thermal_cooling_device_exit(cdev))
> +		device_unregister(&cdev->device);
>   }
>   EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
>   
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

