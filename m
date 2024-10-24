Return-Path: <linux-pm+bounces-16346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC29ADEC2
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C54B24A60
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C661D432F;
	Thu, 24 Oct 2024 08:12:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4771D0171;
	Thu, 24 Oct 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757520; cv=none; b=Wj5jbYchMn6X4moWSDhgWH+o9/OH8o2C7gixc2xL/dRsJMN1uvqWpUuriNuC+3XEm2LDpdcKng0umTbJmkDKLCuTbgLGUwZFp7tvecFyTSKI2PeoQ7F1wFvqx+7zPwH/i3SMJoReY+7vYtLfeOV3mFKEaNs/heEDUWugeUlHn8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757520; c=relaxed/simple;
	bh=xVeVxnYTg0aQ3Y0nTvMq/IOhI4DDFQotZOuWq76PqzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iW4emMsVuJfWlbOakSUNbu+eHatuPHZzeCOR9RPZOK2iPd/hNQKt+NJuhH124Wj6P3yxr0fcIOLEvPgitX9T/EenUFFs0YWT1GrLtgXrHsfGZcZVO/22RgXVv/pB00RbtRB3aEJfZV/m+Gum0jlB/DI0L4ouYXUQUnrsgRd5DfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57DBE339;
	Thu, 24 Oct 2024 01:12:25 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99CEC3F73B;
	Thu, 24 Oct 2024 01:11:54 -0700 (PDT)
Message-ID: <5d271223-d05d-4dc5-9baa-a1b2a0d2905c@arm.com>
Date: Thu, 24 Oct 2024 09:13:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2.1 09/11] thermal: core: Add and use cooling device
 guard
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Linux PM <linux-pm@vger.kernel.org>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <5837621.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5837621.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/24 15:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add and use a special guard for cooling devices.
> 
> This allows quite a few error code paths to be simplified among
> other things and brings in code size reduction for a good measure.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/1890654.atdPhlSkOF@rjwysocki.net/
> 
> v2 -> v2.1: Add missing hunk in trans_table_show()
> 
> v1 -> v2: Rearrange cur_state_store()
> 
> ---
>   drivers/thermal/gov_power_allocator.c |   21 ++++++--------
>   drivers/thermal/gov_step_wise.c       |    6 ++--
>   drivers/thermal/thermal_core.c        |   17 +++--------
>   drivers/thermal/thermal_debugfs.c     |   25 ++++++++++------
>   drivers/thermal/thermal_helpers.c     |   19 +++---------
>   drivers/thermal/thermal_sysfs.c       |   51 ++++++++++++----------------------
>   include/linux/thermal.h               |    3 ++
>   7 files changed, 59 insertions(+), 83 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -758,12 +758,10 @@ static int thermal_instance_add(struct t
>   
>   	list_add_tail(&new_instance->trip_node, &td->thermal_instances);
>   
> -	mutex_lock(&cdev->lock);
> +	guard(cooling_dev)(cdev);
>   
>   	list_add_tail(&new_instance->cdev_node, &cdev->thermal_instances);
>   
> -	mutex_unlock(&cdev->lock);
> -
>   	return 0;
>   }
>   
> @@ -872,11 +870,9 @@ static void thermal_instance_delete(stru
>   {
>   	list_del(&instance->trip_node);
>   
> -	mutex_lock(&instance->cdev->lock);
> +	guard(cooling_dev)(instance->cdev);
>   
>   	list_del(&instance->cdev_node);
> -
> -	mutex_unlock(&instance->cdev->lock);
>   }
>   
>   /**
> @@ -1239,10 +1235,10 @@ void thermal_cooling_device_update(struc
>   	 * Update under the cdev lock to prevent the state from being set beyond
>   	 * the new limit concurrently.
>   	 */
> -	mutex_lock(&cdev->lock);
> +	guard(cooling_dev)(cdev);
>   
>   	if (cdev->ops->get_max_state(cdev, &cdev->max_state))
> -		goto unlock;
> +		return;
>   
>   	thermal_cooling_device_stats_reinit(cdev);
>   
> @@ -1269,12 +1265,9 @@ void thermal_cooling_device_update(struc
>   	}
>   
>   	if (cdev->ops->get_cur_state(cdev, &state) || state > cdev->max_state)
> -		goto unlock;
> +		return;
>   
>   	thermal_cooling_device_stats_update(cdev, state);
> -
> -unlock:
> -	mutex_unlock(&cdev->lock);
>   }
>   EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
>   
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -140,6 +140,9 @@ struct thermal_cooling_device {
>   #endif
>   };
>   
> +DEFINE_GUARD(cooling_dev, struct thermal_cooling_device *, mutex_lock(&_T->lock),
> +	     mutex_unlock(&_T->lock))
> +
>   /* Structure to define Thermal Zone parameters */
>   struct thermal_zone_params {
>   	const char *governor_name;
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -544,14 +544,15 @@ cur_state_store(struct device *dev, stru
>   	if (state > cdev->max_state)
>   		return -EINVAL;
>   
> -	mutex_lock(&cdev->lock);
> +	guard(cooling_dev)(cdev);
>   
>   	result = cdev->ops->set_cur_state(cdev, state);
> -	if (!result)
> -		thermal_cooling_device_stats_update(cdev, state);
> +	if (result)
> +		return result;
>   
> -	mutex_unlock(&cdev->lock);
> -	return result ? result : count;
> +	thermal_cooling_device_stats_update(cdev, state);
> +
> +	return count;
>   }
>   
>   static struct device_attribute
> @@ -625,21 +626,18 @@ static ssize_t total_trans_show(struct d
>   {
>   	struct thermal_cooling_device *cdev = to_cooling_device(dev);
>   	struct cooling_dev_stats *stats;
> -	int ret = 0;
> +	int ret;
>   
> -	mutex_lock(&cdev->lock);
> +	guard(cooling_dev)(cdev);
>   
>   	stats = cdev->stats;
>   	if (!stats)
> -		goto unlock;
> +		return 0;
>   
>   	spin_lock(&stats->lock);
>   	ret = sprintf(buf, "%u\n", stats->total_trans);
>   	spin_unlock(&stats->lock);
>   
> -unlock:
> -	mutex_unlock(&cdev->lock);
> -
>   	return ret;
>   }
>   
> @@ -652,11 +650,11 @@ time_in_state_ms_show(struct device *dev
>   	ssize_t len = 0;
>   	int i;
>   
> -	mutex_lock(&cdev->lock);
> +	guard(cooling_dev)(cdev);
>   
>   	stats = cdev->stats;
>   	if (!stats)
> -		goto unlock;
> +		return 0;
>   
>   	spin_lock(&stats->lock);
>   
> @@ -668,9 +666,6 @@ time_in_state_ms_show(struct device *dev
>   	}
>   	spin_unlock(&stats->lock);
>   
> -unlock:
> -	mutex_unlock(&cdev->lock);
> -
>   	return len;
>   }
>   
> @@ -682,11 +677,11 @@ reset_store(struct device *dev, struct d
>   	struct cooling_dev_stats *stats;
>   	int i, states;
>   
> -	mutex_lock(&cdev->lock);
> +	guard(cooling_dev)(cdev);
>   
>   	stats = cdev->stats;
>   	if (!stats)
> -		goto unlock;
> +		return count;
>   
>   	states = cdev->max_state + 1;
>   
> @@ -702,9 +697,6 @@ reset_store(struct device *dev, struct d
>   
>   	spin_unlock(&stats->lock);
>   
> -unlock:
> -	mutex_unlock(&cdev->lock);
> -
>   	return count;
>   }
>   
> @@ -716,13 +708,11 @@ static ssize_t trans_table_show(struct d
>   	ssize_t len = 0;
>   	int i, j;
>   
> -	mutex_lock(&cdev->lock);
> +	guard(cooling_dev)(cdev);
>   
>   	stats = cdev->stats;
> -	if (!stats) {
> -		len = -ENODATA;
> -		goto unlock;
> -	}
> +	if (!stats)
> +		return -ENODATA;
>   
>   	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
>   	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
> @@ -731,10 +721,8 @@ static ssize_t trans_table_show(struct d
>   			break;
>   		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
>   	}
> -	if (len >= PAGE_SIZE) {
> -		len = PAGE_SIZE;
> -		goto unlock;
> -	}
> +	if (len >= PAGE_SIZE)
> +		return PAGE_SIZE;
>   
>   	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
>   
> @@ -760,9 +748,6 @@ static ssize_t trans_table_show(struct d
>   		len = -EFBIG;
>   	}
>   
> -unlock:
> -	mutex_unlock(&cdev->lock);
> -
>   	return len;
>   }
>   
> Index: linux-pm/drivers/thermal/thermal_helpers.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_helpers.c
> +++ linux-pm/drivers/thermal/thermal_helpers.c
> @@ -58,17 +58,10 @@ bool thermal_trip_is_bound_to_cdev(struc
>   				   const struct thermal_trip *trip,
>   				   struct thermal_cooling_device *cdev)
>   {
> -	bool ret;
> -
>   	guard(thermal_zone)(tz);
> +	guard(cooling_dev)(cdev);
>   
> -	mutex_lock(&cdev->lock);
> -
> -	ret = thermal_instance_present(tz, cdev, trip);
> -
> -	mutex_unlock(&cdev->lock);
> -
> -	return ret;
> +	return thermal_instance_present(tz, cdev, trip);
>   }
>   EXPORT_SYMBOL_GPL(thermal_trip_is_bound_to_cdev);
>   
> @@ -197,12 +190,12 @@ void __thermal_cdev_update(struct therma
>    */
>   void thermal_cdev_update(struct thermal_cooling_device *cdev)
>   {
> -	mutex_lock(&cdev->lock);
> +	guard(cooling_dev)(cdev);
> +
>   	if (!cdev->updated) {
>   		__thermal_cdev_update(cdev);
>   		cdev->updated = true;
>   	}
> -	mutex_unlock(&cdev->lock);
>   }
>   
>   /**
> @@ -211,11 +204,9 @@ void thermal_cdev_update(struct thermal_
>    */
>   void thermal_cdev_update_nocheck(struct thermal_cooling_device *cdev)
>   {
> -	mutex_lock(&cdev->lock);
> +	guard(cooling_dev)(cdev);
>   
>   	__thermal_cdev_update(cdev);
> -
> -	mutex_unlock(&cdev->lock);
>   }
>   
>   /**
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -516,6 +516,19 @@ void thermal_debug_cdev_add(struct therm
>   	cdev->debugfs = thermal_dbg;
>   }
>   
> +static struct thermal_debugfs *thermal_debug_cdev_clear(struct thermal_cooling_device *cdev)
> +{
> +	struct thermal_debugfs *thermal_dbg;
> +
> +	guard(cooling_dev)(cdev);
> +
> +	thermal_dbg = cdev->debugfs;
> +	if (thermal_dbg)
> +		cdev->debugfs = NULL;
> +
> +	return thermal_dbg;
> +}
> +
>   /**
>    * thermal_debug_cdev_remove - Remove a cooling device debugfs entry
>    *
> @@ -527,17 +540,9 @@ void thermal_debug_cdev_remove(struct th
>   {
>   	struct thermal_debugfs *thermal_dbg;
>   
> -	mutex_lock(&cdev->lock);
> -
> -	thermal_dbg = cdev->debugfs;
> -	if (!thermal_dbg) {
> -		mutex_unlock(&cdev->lock);
> +	thermal_dbg = thermal_debug_cdev_clear(cdev);
> +	if (!thermal_dbg)
>   		return;
> -	}
> -
> -	cdev->debugfs = NULL;
> -
> -	mutex_unlock(&cdev->lock);
>   
>   	mutex_lock(&thermal_dbg->lock);
>   
> Index: linux-pm/drivers/thermal/gov_power_allocator.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> +++ linux-pm/drivers/thermal/gov_power_allocator.c
> @@ -549,18 +549,17 @@ static void allow_maximum_power(struct t
>   		cdev = instance->cdev;
>   
>   		instance->target = 0;
> -		mutex_lock(&cdev->lock);
> -		/*
> -		 * Call for updating the cooling devices local stats and avoid
> -		 * periods of dozen of seconds when those have not been
> -		 * maintained.
> -		 */
> -		cdev->ops->get_requested_power(cdev, &req_power);
> +		scoped_guard(cooling_dev, cdev) {
> +			/*
> +			 * Call for updating the cooling devices local stats and
> +			 * avoid periods of dozen of seconds when those have not
> +			 * been maintained.
> +			 */
> +			cdev->ops->get_requested_power(cdev, &req_power);
>   
> -		if (params->update_cdevs)
> -			__thermal_cdev_update(cdev);
> -
> -		mutex_unlock(&cdev->lock);
> +			if (params->update_cdevs)
> +				__thermal_cdev_update(cdev);
> +		}
>   	}
>   }
>   
> Index: linux-pm/drivers/thermal/gov_step_wise.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> +++ linux-pm/drivers/thermal/gov_step_wise.c
> @@ -97,9 +97,9 @@ static void thermal_zone_trip_update(str
>   
>   		instance->initialized = true;
>   
> -		mutex_lock(&instance->cdev->lock);
> -		instance->cdev->updated = false; /* cdev needs update */
> -		mutex_unlock(&instance->cdev->lock);
> +		scoped_guard(cooling_dev, instance->cdev) {
> +			instance->cdev->updated = false; /* cdev needs update */
> +		}
>   	}
>   }
>   
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

