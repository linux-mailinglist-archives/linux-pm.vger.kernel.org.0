Return-Path: <linux-pm+bounces-16274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2B9AB9A8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 00:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9A41F22F0A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3A21CEAA7;
	Tue, 22 Oct 2024 22:49:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A131CEAAD;
	Tue, 22 Oct 2024 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637372; cv=none; b=eoooE85UqE3M0Det/hwFCmJu1Fz0vYS78f+v00h5n+CNOjtyjjqVtwHDy1Q1hhUG2yLlTBFvoKOE4c3AUakNpYXTPQ1eepKC8vDBdQq8ZPmfOLVDGTv56J9zjSLduQ9i5sSuTPda/YJs5DiEqq5aSI97h+P5WQvE0AyaOvq+tsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637372; c=relaxed/simple;
	bh=aL4tpothJzNMNS1XfuEVFWaiG2OKDo2nNUDJ1IDKIyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmvevpYYj8aG9125k49HDpZfUSGm6Kf0+vHdSG26kijbmViPTCbZM1zkX0khQh+1RPuQeU1llifcxTYBVWL2Fw0iZv/V4emfUaj94LYvfTmG6wbuw4aGBGWtlNv+XdzODsGGabX0YRvmoen3MdcS2i8PlPU+/LWnqlfXb9XONXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 457FE497;
	Tue, 22 Oct 2024 15:49:58 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43C9F3F528;
	Tue, 22 Oct 2024 15:49:27 -0700 (PDT)
Message-ID: <8a4153ed-8a08-459f-86dc-d44f8026e9a7@arm.com>
Date: Tue, 22 Oct 2024 23:50:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] thermal: core: Manage thermal_list_lock using a
 mutex guard
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <2010397.PYKUYFuaPT@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2010397.PYKUYFuaPT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 23:10, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Switch over the thermal core to using a mutex guard for
> thermal_list_lock management.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-pm/2018087.usQuhbGJ8B@rjwysocki.net/
> 
> ---
>   drivers/thermal/thermal_core.c |  148 ++++++++++++++++++-----------------------
>   1 file changed, 68 insertions(+), 80 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -140,7 +140,7 @@ int thermal_register_governor(struct the
>   			def_governor = governor;
>   	}
>   
> -	mutex_lock(&thermal_list_lock);
> +	guard(mutex)(&thermal_list_lock);
>   
>   	list_for_each_entry(pos, &thermal_tz_list, node) {
>   		/*
> @@ -163,7 +163,6 @@ int thermal_register_governor(struct the
>   		}
>   	}
>   
> -	mutex_unlock(&thermal_list_lock);
>   	mutex_unlock(&thermal_governor_lock);
>   
>   	return err;
> @@ -181,7 +180,9 @@ void thermal_unregister_governor(struct
>   	if (!__find_governor(governor->name))
>   		goto exit;
>   
> -	mutex_lock(&thermal_list_lock);
> +	list_del(&governor->governor_list);
> +
> +	guard(mutex)(&thermal_list_lock);
>   
>   	list_for_each_entry(pos, &thermal_tz_list, node) {
>   		if (!strncasecmp(pos->governor->name, governor->name,
> @@ -189,8 +190,6 @@ void thermal_unregister_governor(struct
>   			thermal_set_governor(pos, NULL);
>   	}
>   
> -	mutex_unlock(&thermal_list_lock);
> -	list_del(&governor->governor_list);
>   exit:
>   	mutex_unlock(&thermal_governor_lock);
>   }
> @@ -686,51 +685,52 @@ int for_each_thermal_cooling_device(int
>   					      void *), void *data)
>   {
>   	struct thermal_cooling_device *cdev;
> -	int ret = 0;
>   
> -	mutex_lock(&thermal_list_lock);
> +	guard(mutex)(&thermal_list_lock);
> +
>   	list_for_each_entry(cdev, &thermal_cdev_list, node) {
> +		int ret;
> +
>   		ret = cb(cdev, data);
>   		if (ret)
> -			break;
> +			return ret;
>   	}
> -	mutex_unlock(&thermal_list_lock);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
>   			  void *data)
>   {
>   	struct thermal_zone_device *tz;
> -	int ret = 0;
>   
> -	mutex_lock(&thermal_list_lock);
> +	guard(mutex)(&thermal_list_lock);
> +
>   	list_for_each_entry(tz, &thermal_tz_list, node) {
> +		int ret;
> +
>   		ret = cb(tz, data);
>   		if (ret)
> -			break;
> +			return ret;
>   	}
> -	mutex_unlock(&thermal_list_lock);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   struct thermal_zone_device *thermal_zone_get_by_id(int id)
>   {
> -	struct thermal_zone_device *tz, *match = NULL;
> +	struct thermal_zone_device *tz;
> +
> +	guard(mutex)(&thermal_list_lock);
>   
> -	mutex_lock(&thermal_list_lock);
>   	list_for_each_entry(tz, &thermal_tz_list, node) {
>   		if (tz->id == id) {
>   			get_device(&tz->device);
> -			match = tz;
> -			break;
> +			return tz;
>   		}
>   	}
> -	mutex_unlock(&thermal_list_lock);
>   
> -	return match;
> +	return NULL;
>   }
>   
>   /*
> @@ -969,14 +969,12 @@ static void thermal_cooling_device_init_
>   {
>   	struct thermal_zone_device *tz;
>   
> -	mutex_lock(&thermal_list_lock);
> +	guard(mutex)(&thermal_list_lock);
>   
>   	list_add(&cdev->node, &thermal_cdev_list);
>   
>   	list_for_each_entry(tz, &thermal_tz_list, node)
>   		thermal_zone_cdev_bind(tz, cdev);
> -
> -	mutex_unlock(&thermal_list_lock);
>   }
>   
>   /**
> @@ -1210,10 +1208,10 @@ void thermal_cooling_device_update(struc
>   	 * Hold thermal_list_lock throughout the update to prevent the device
>   	 * from going away while being updated.
>   	 */
> -	mutex_lock(&thermal_list_lock);
> +	guard(mutex)(&thermal_list_lock);
>   
>   	if (!thermal_cooling_device_present(cdev))
> -		goto unlock_list;
> +		return;
>   
>   	/*
>   	 * Update under the cdev lock to prevent the state from being set beyond
> @@ -1255,9 +1253,6 @@ void thermal_cooling_device_update(struc
>   
>   unlock:
>   	mutex_unlock(&cdev->lock);
> -
> -unlock_list:
> -	mutex_unlock(&thermal_list_lock);
>   }
>   EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
>   
> @@ -1281,24 +1276,18 @@ static void thermal_zone_cdev_unbind(str
>   static bool thermal_cooling_device_exit(struct thermal_cooling_device *cdev)
>   {
>   	struct thermal_zone_device *tz;
> -	bool ret = true;
>   
> -	mutex_lock(&thermal_list_lock);
> +	guard(mutex)(&thermal_list_lock);
>   
> -	if (!thermal_cooling_device_present(cdev)) {
> -		ret = false;
> -		goto unlock;
> -	}
> +	if (!thermal_cooling_device_present(cdev))
> +		return false;
>   
>   	list_del(&cdev->node);
>   
>   	list_for_each_entry(tz, &thermal_tz_list, node)
>   		thermal_zone_cdev_unbind(tz, cdev);
>   
> -unlock:
> -	mutex_unlock(&thermal_list_lock);
> -
> -	return ret;
> +	return true;
>   }
>   
>   /**
> @@ -1345,7 +1334,7 @@ static void thermal_zone_init_complete(s
>   {
>   	struct thermal_cooling_device *cdev;
>   
> -	mutex_lock(&thermal_list_lock);
> +	guard(mutex)(&thermal_list_lock);
>   
>   	list_add_tail(&tz->node, &thermal_tz_list);
>   
> @@ -1365,8 +1354,6 @@ static void thermal_zone_init_complete(s
>   		tz->state |= TZ_STATE_FLAG_SUSPENDED;
>   
>   	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> -
> -	mutex_unlock(&thermal_list_lock);
>   }
>   
>   /**
> @@ -1587,14 +1574,11 @@ EXPORT_SYMBOL_GPL(thermal_zone_device);
>   static bool thermal_zone_exit(struct thermal_zone_device *tz)
>   {
>   	struct thermal_cooling_device *cdev;
> -	bool ret = true;
>   
> -	mutex_lock(&thermal_list_lock);
> +	guard(mutex)(&thermal_list_lock);
>   
> -	if (list_empty(&tz->node)) {
> -		ret = false;
> -		goto unlock;
> -	}
> +	if (list_empty(&tz->node))
> +		return false;
>   
>   	guard(thermal_zone)(tz);
>   
> @@ -1605,10 +1589,7 @@ static bool thermal_zone_exit(struct the
>   	list_for_each_entry(cdev, &thermal_cdev_list, node)
>   		__thermal_zone_cdev_unbind(tz, cdev);
>   
> -unlock:
> -	mutex_unlock(&thermal_list_lock);
> -
> -	return ret;
> +	return true;
>   }
>   
>   /**
> @@ -1660,24 +1641,23 @@ struct thermal_zone_device *thermal_zone
>   	unsigned int found = 0;
>   
>   	if (!name)
> -		goto exit;
> +		return ERR_PTR(-EINVAL);
> +
> +	guard(mutex)(&thermal_list_lock);
>   
> -	mutex_lock(&thermal_list_lock);
>   	list_for_each_entry(pos, &thermal_tz_list, node)
>   		if (!strncasecmp(name, pos->type, THERMAL_NAME_LENGTH)) {
>   			found++;
>   			ref = pos;
>   		}
> -	mutex_unlock(&thermal_list_lock);
>   
> -	/* nothing has been found, thus an error code for it */
> -	if (found == 0)
> -		ref = ERR_PTR(-ENODEV);
> -	else if (found > 1)
> -	/* Success only when an unique zone is found */
> -		ref = ERR_PTR(-EEXIST);
> +	if (!found)
> +		return ERR_PTR(-ENODEV);
> +
> +	/* Success only when one zone is found. */
> +	if (found > 1)
> +		return ERR_PTR(-EEXIST);
>   
> -exit:
>   	return ref;
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
> @@ -1718,6 +1698,18 @@ static void thermal_zone_pm_prepare(stru
>   	tz->state |= TZ_STATE_FLAG_SUSPENDED;
>   }
>   
> +static void thermal_pm_notify_prepare(void)
> +{
> +	struct thermal_zone_device *tz;
> +
> +	guard(mutex)(&thermal_list_lock);
> +
> +	thermal_pm_suspended = true;
> +
> +	list_for_each_entry(tz, &thermal_tz_list, node)
> +		thermal_zone_pm_prepare(tz);
> +}
> +
>   static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
>   {
>   	guard(thermal_zone)(tz);
> @@ -1736,35 +1728,31 @@ static void thermal_zone_pm_complete(str
>   	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
>   }
>   
> -static int thermal_pm_notify(struct notifier_block *nb,
> -			     unsigned long mode, void *_unused)
> +static void thermal_pm_notify_complete(void)
>   {
>   	struct thermal_zone_device *tz;
>   
> +	guard(mutex)(&thermal_list_lock);
> +
> +	thermal_pm_suspended = false;
> +
> +	list_for_each_entry(tz, &thermal_tz_list, node)
> +		thermal_zone_pm_complete(tz);
> +}
> +
> +static int thermal_pm_notify(struct notifier_block *nb,
> +			     unsigned long mode, void *_unused)
> +{
>   	switch (mode) {
>   	case PM_HIBERNATION_PREPARE:
>   	case PM_RESTORE_PREPARE:
>   	case PM_SUSPEND_PREPARE:
> -		mutex_lock(&thermal_list_lock);
> -
> -		thermal_pm_suspended = true;
> -
> -		list_for_each_entry(tz, &thermal_tz_list, node)
> -			thermal_zone_pm_prepare(tz);
> -
> -		mutex_unlock(&thermal_list_lock);
> +		thermal_pm_notify_prepare();
>   		break;
>   	case PM_POST_HIBERNATION:
>   	case PM_POST_RESTORE:
>   	case PM_POST_SUSPEND:
> -		mutex_lock(&thermal_list_lock);
> -
> -		thermal_pm_suspended = false;
> -
> -		list_for_each_entry(tz, &thermal_tz_list, node)
> -			thermal_zone_pm_complete(tz);
> -
> -		mutex_unlock(&thermal_list_lock);
> +		thermal_pm_notify_complete();
>   		break;
>   	default:
>   		break;
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

