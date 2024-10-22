Return-Path: <linux-pm+bounces-16270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D504F9AB966
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 00:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060851C210DA
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167421CCB58;
	Tue, 22 Oct 2024 22:22:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148D11A2547;
	Tue, 22 Oct 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635725; cv=none; b=OyA4270gPfkMPGrov/GGG69kUqKJaIf6uiN4QwThZ9m9VFShB3jw78+D35OwKwOcg3WcosxSdIolJy3tGdrKVP/uLl2BNv4py0JsQiZle3hrkb7IveCqfZPmF4dsOUtiAlD0NJPkzT9eUsIIP3hc6972d/xNtxKoQoSm0Z42ckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635725; c=relaxed/simple;
	bh=8xyrjJ3jUJlSYyKe/7D6pnYkrtio2NI0cUYAyczc2J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8ZwK8VpsYwOD7NOzWgYAvgsYW8aVUvh18aQ8AFON+yzbzbNXE0o9YR8rVPRsxEX3D2nVqF9tArmwi3CHkz96jWn0i0lhU7fBVCwZBBvB4AArlxmUuta//obOZvzkAyfJ7/GPqDAjUUJcCGW6eHLX0B1UHt0BLekJp54BebzSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9903497;
	Tue, 22 Oct 2024 15:22:30 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E91B33F528;
	Tue, 22 Oct 2024 15:21:59 -0700 (PDT)
Message-ID: <51bdabae-6464-4a11-8017-b97d51223466@arm.com>
Date: Tue, 22 Oct 2024 23:23:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] thermal: core: Introduce
 thermal_cdev_update_nocheck()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <1835097.VLH7GnMWUR@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1835097.VLH7GnMWUR@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 23:16, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Three thermal governors call __thermal_cdev_update() under the
> cdev lock without doing any checks, so in order to reduce the
> related code duplication, introduce a new helper function called
> thermal_cdev_update_nocheck() for them and make them use it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-pm/3791590.MHq7AAxBmi@rjwysocki.net/
> 
> ---
>   drivers/thermal/gov_bang_bang.c       |    4 +---
>   drivers/thermal/gov_fair_share.c      |    4 +---
>   drivers/thermal/gov_power_allocator.c |    5 ++---
>   drivers/thermal/thermal_core.h        |    1 +
>   drivers/thermal/thermal_helpers.c     |   13 +++++++++++++
>   5 files changed, 18 insertions(+), 9 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -30,9 +30,7 @@ static void bang_bang_set_instance_targe
>   
>   	dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
>   
> -	mutex_lock(&instance->cdev->lock);
> -	__thermal_cdev_update(instance->cdev);
> -	mutex_unlock(&instance->cdev->lock);
> +	thermal_cdev_update_nocheck(instance->cdev);
>   }
>   
>   /**
> Index: linux-pm/drivers/thermal/gov_fair_share.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> +++ linux-pm/drivers/thermal/gov_fair_share.c
> @@ -89,9 +89,7 @@ static void fair_share_throttle(struct t
>   		}
>   		instance->target = div_u64(dividend, divisor);
>   
> -		mutex_lock(&cdev->lock);
> -		__thermal_cdev_update(cdev);
> -		mutex_unlock(&cdev->lock);
> +		thermal_cdev_update_nocheck(cdev);
>   	}
>   }
>   
> Index: linux-pm/drivers/thermal/gov_power_allocator.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> +++ linux-pm/drivers/thermal/gov_power_allocator.c
> @@ -322,9 +322,8 @@ power_actor_set_power(struct thermal_coo
>   		return ret;
>   
>   	instance->target = clamp_val(state, instance->lower, instance->upper);
> -	mutex_lock(&cdev->lock);
> -	__thermal_cdev_update(cdev);
> -	mutex_unlock(&cdev->lock);
> +
> +	thermal_cdev_update_nocheck(cdev);
>   
>   	return 0;
>   }
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -213,6 +213,7 @@ static inline bool cdev_is_power_actor(s
>   }
>   
>   void thermal_cdev_update(struct thermal_cooling_device *);
> +void thermal_cdev_update_nocheck(struct thermal_cooling_device *cdev);
>   void __thermal_cdev_update(struct thermal_cooling_device *cdev);
>   
>   int get_tz_trend(struct thermal_zone_device *tz, const struct thermal_trip *trip);
> Index: linux-pm/drivers/thermal/thermal_helpers.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_helpers.c
> +++ linux-pm/drivers/thermal/thermal_helpers.c
> @@ -206,6 +206,19 @@ void thermal_cdev_update(struct thermal_
>   }
>   
>   /**
> + * thermal_cdev_update_nocheck() - Unconditionally update cooling device state
> + * @cdev: Target cooling device.
> + */
> +void thermal_cdev_update_nocheck(struct thermal_cooling_device *cdev)
> +{
> +	mutex_lock(&cdev->lock);
> +
> +	__thermal_cdev_update(cdev);
> +
> +	mutex_unlock(&cdev->lock);
> +}
> +
> +/**
>    * thermal_zone_get_slope - return the slope attribute of the thermal zone
>    * @tz: thermal zone device with the slope attribute
>    *
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

