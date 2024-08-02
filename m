Return-Path: <linux-pm+bounces-11828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D6945B7C
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 11:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C564282DC0
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 09:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96171DB429;
	Fri,  2 Aug 2024 09:52:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2E54C62A;
	Fri,  2 Aug 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592356; cv=none; b=E/oG1SPQmJp3bNufJCGz42hf3/Vto4aohglRGdFFScd8TP0ZGQNiO2o6gQ+QznNNI1dFmbWIALExjUMQaibm1r4bd0k0Jas6/IJf50o2tYt68NHXRdv+eF4Csb6FPK2ib5nGSxImNNX5aLDvM8BVCI+JJIFIbxhdB4Vxc83xvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592356; c=relaxed/simple;
	bh=rnFqcYhnMeDXtV6Y5+tdT+M0WG9C98IBz7b+htCMRe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSLWXfT9FeDjQpBeaWfeIE454TeCJxmRGxijTNS1fFHOUF8UGmJeaH5+wTqaOxqKV1bCUnS/Lpsjv52Br6GZ+oFBtGPiEKEPA8nAEkjrqoq6D7Z3yjmrKXHMJkumSGJH19cLt1Mqnhd0GNDP/lZsne06yfRfNrFcqV41jIKE0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133041007;
	Fri,  2 Aug 2024 02:53:00 -0700 (PDT)
Received: from [10.57.12.204] (unknown [10.57.12.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9089C3F64C;
	Fri,  2 Aug 2024 02:52:33 -0700 (PDT)
Message-ID: <7a0ec54f-2dc1-4941-9890-260c71ed4a17@arm.com>
Date: Fri, 2 Aug 2024 10:53:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 6/8] thermal: helpers: Drop
 get_thermal_instance()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <2211925.irdbgypaU6@rjwysocki.net>
 <2014591.usQuhbGJ8B@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2014591.usQuhbGJ8B@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/24 17:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are no more users of get_thermal_instance(), so drop it.
> 
> While at it, replace get_instance() returning a pointer to struct
> thermal_instance with thermal_instance_present() returning a bool
> which is more straightforward.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.h    |    5 -----
>   drivers/thermal/thermal_helpers.c |   30 ++++++------------------------
>   2 files changed, 6 insertions(+), 29 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -204,11 +204,6 @@ void __thermal_cdev_update(struct therma
>   
>   int get_tz_trend(struct thermal_zone_device *tz, const struct thermal_trip *trip);
>   
> -struct thermal_instance *
> -get_thermal_instance(struct thermal_zone_device *tz,
> -		     struct thermal_cooling_device *cdev,
> -		     int trip);
> -
>   /*
>    * This structure is used to describe the behavior of
>    * a certain cooling device on a certain trip point
> Index: linux-pm/drivers/thermal/thermal_helpers.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_helpers.c
> +++ linux-pm/drivers/thermal/thermal_helpers.c
> @@ -39,18 +39,18 @@ int get_tz_trend(struct thermal_zone_dev
>   	return trend;
>   }
>   
> -static struct thermal_instance *get_instance(struct thermal_zone_device *tz,
> -					     struct thermal_cooling_device *cdev,
> -					     const struct thermal_trip *trip)
> +static bool thermal_instance_present(struct thermal_zone_device *tz,
> +				     struct thermal_cooling_device *cdev,
> +				     const struct thermal_trip *trip)
>   {
>   	struct thermal_instance *ti;
>   
>   	list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
>   		if (ti->trip == trip && ti->cdev == cdev)
> -			return ti;
> +			return true;
>   	}
>   
> -	return NULL;
> +	return false;
>   }
>   
>   bool thermal_trip_is_bound_to_cdev(struct thermal_zone_device *tz,
> @@ -62,7 +62,7 @@ bool thermal_trip_is_bound_to_cdev(struc
>   	mutex_lock(&tz->lock);
>   	mutex_lock(&cdev->lock);
>   
> -	ret = !!get_instance(tz, cdev, trip);
> +	ret = thermal_instance_present(tz, cdev, trip);
>   
>   	mutex_unlock(&cdev->lock);
>   	mutex_unlock(&tz->lock);
> @@ -71,24 +71,6 @@ bool thermal_trip_is_bound_to_cdev(struc
>   }
>   EXPORT_SYMBOL_GPL(thermal_trip_is_bound_to_cdev);
>   
> -struct thermal_instance *
> -get_thermal_instance(struct thermal_zone_device *tz,
> -		     struct thermal_cooling_device *cdev, int trip_index)
> -{
> -	struct thermal_instance *ti;
> -
> -	mutex_lock(&tz->lock);
> -	mutex_lock(&cdev->lock);
> -
> -	ti = get_instance(tz, cdev, &tz->trips[trip_index].trip);
> -
> -	mutex_unlock(&cdev->lock);
> -	mutex_unlock(&tz->lock);
> -
> -	return ti;
> -}
> -EXPORT_SYMBOL(get_thermal_instance);
> -
>   /**
>    * __thermal_zone_get_temp() - returns the temperature of a thermal zone
>    * @tz: a valid pointer to a struct thermal_zone_device
> 
> 
> 

LGTM, small nit: you can also remove the description of that
get_thermal_instance() from
Documentation/driver-api/thermal/sysfs-api.rst
It sneaked in somehow...

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


