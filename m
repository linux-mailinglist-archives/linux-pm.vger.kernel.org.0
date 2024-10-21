Return-Path: <linux-pm+bounces-16158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826999A935E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E89283AF4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770121E2839;
	Mon, 21 Oct 2024 22:32:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2FB80C0C;
	Mon, 21 Oct 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549962; cv=none; b=FzlDCAqYGnwLmfkB/TZP0+RadLOlMXWuRDi09ABXl9bc0tfqD3ZFGJMjvWEBtLmbzDEPTI5fGix/iaVDzm4Hot1Gj3v4AC1NB9s8GBnKPGTKV7+8/6FDi5gzghby/f3LkpImIw7OzcGR3APc4ArmJXsoS+YY9aWpRSCO6qja6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549962; c=relaxed/simple;
	bh=m7c4CdhRAcygB80AOkGpbLxqgvTzNErkPOpW0llTSEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTEF+/hUoVjRjaT3oO9CDHXzGOe1vqcczdauHeRRq56TT7LXfycCGv7H7GyNCA1ccISdYEPME3bulaK/JwpM+YiZc5B4TIxFjzchbpTOcZrM5tbk98pTdKOnO7LGzjoTAx0dQksrTyI3O4OdMkVdAqoQUXBxCpj/MGAZKYOJjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19485497;
	Mon, 21 Oct 2024 15:33:09 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C83A3F71E;
	Mon, 21 Oct 2024 15:32:37 -0700 (PDT)
Message-ID: <8a8474c0-ea6c-4f8d-bf3a-7ea67fbab6bf@arm.com>
Date: Mon, 21 Oct 2024 23:33:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] thermal: core: Consolidate thermal zone locking
 in the exit path
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <1963152.taCxCBeP46@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1963152.taCxCBeP46@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In analogy with a previous change in the thermal zone initialization
> path, to avoid acquiring the thermal zone lock and releasing it multiple
> times back and forth unnecessarily, move all of the code running under
> thermal_list_lock in thermal_zone_device_unregister() into a new
> function called thermal_zone_exit() and make the latter acquire the
> thermal zone lock only once and release it along with thermal_list_lock.
> 
> For this purpose, provide an "unlocked" variant of
> thermal_zone_cdev_unbind() to be called by thermal_zone_exit() under the
> thermal zone lock.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/7729094.EvYhyI6sBW@rjwysocki.net/
> 
> v1 -> v2: Rebase, use list_del_init() for removing thermal zones from the
>            global list so that the new list_emty() check doesn't blow up.
> 
> ---
>   drivers/thermal/thermal_core.c |   66 ++++++++++++++++++++++++-----------------
>   1 file changed, 39 insertions(+), 27 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1266,15 +1266,21 @@ unlock_list:
>   }
>   EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
>   
> -static void thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
> -				     struct thermal_cooling_device *cdev)
> +static void __thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
> +				       struct thermal_cooling_device *cdev)
>   {
>   	struct thermal_trip_desc *td;
>   
> -	mutex_lock(&tz->lock);
> -
>   	for_each_trip_desc(tz, td)
>   		thermal_unbind_cdev_from_trip(tz, &td->trip, cdev);
> +}
> +
> +static void thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
> +				     struct thermal_cooling_device *cdev)
> +{
> +	mutex_lock(&tz->lock);
> +
> +	__thermal_zone_cdev_unbind(tz, cdev);
>   
>   	mutex_unlock(&tz->lock);
>   }
> @@ -1588,43 +1594,49 @@ struct device *thermal_zone_device(struc
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_device);
>   
> -/**
> - * thermal_zone_device_unregister - removes the registered thermal zone device
> - * @tz: the thermal zone device to remove
> - */
> -void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> +static bool thermal_zone_exit(struct thermal_zone_device *tz)
>   {
>   	struct thermal_cooling_device *cdev;
> -	struct thermal_zone_device *pos = NULL;
> -
> -	if (!tz)
> -		return;
> -
> -	thermal_debug_tz_remove(tz);
> +	bool ret = true;
>   
>   	mutex_lock(&thermal_list_lock);
> -	list_for_each_entry(pos, &thermal_tz_list, node)
> -		if (pos == tz)
> -			break;
> -	if (pos != tz) {
> -		/* thermal zone device not found */
> -		mutex_unlock(&thermal_list_lock);
> -		return;
> +
> +	if (list_empty(&tz->node)) {
> +		ret = false;
> +		goto unlock;
>   	}
>   
>   	mutex_lock(&tz->lock);
>   
>   	tz->state |= TZ_STATE_FLAG_EXIT;
> -	list_del(&tz->node);
> -
> -	mutex_unlock(&tz->lock);
> +	list_del_init(&tz->node);
>   
> -	/* Unbind all cdevs associated with 'this' thermal zone */
> +	/* Unbind all cdevs associated with this thermal zone. */
>   	list_for_each_entry(cdev, &thermal_cdev_list, node)
> -		thermal_zone_cdev_unbind(tz, cdev);
> +		__thermal_zone_cdev_unbind(tz, cdev);
> +
> +	mutex_unlock(&tz->lock);
>   
> +unlock:
>   	mutex_unlock(&thermal_list_lock);
>   
> +	return ret;
> +}
> +
> +/**
> + * thermal_zone_device_unregister - removes the registered thermal zone device
> + * @tz: the thermal zone device to remove
> + */
> +void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> +{
> +	if (!tz)
> +		return;
> +
> +	thermal_debug_tz_remove(tz);
> +
> +	if (!thermal_zone_exit(tz))
> +		return;
> +
>   	cancel_delayed_work_sync(&tz->poll_queue);
>   
>   	thermal_set_governor(tz, NULL);
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

