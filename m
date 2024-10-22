Return-Path: <linux-pm+bounces-16267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2FA9AB8F9
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 23:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03337B233D0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 21:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730E91CCED1;
	Tue, 22 Oct 2024 21:44:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5C51386BF;
	Tue, 22 Oct 2024 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633483; cv=none; b=C+l5+wwvcIgVj30+NqOpp05vfYNCZmlwplil1kMSH2oCWQZYrPaLtIrMFqsMmfd2D7V1BYu8xn1zX5L9fCzM2hydYxWKQSFStn1001sJsQLIql/z1NK5QhjQvxP+FGxSXDwjBnh2J31VFWEd1hEtUlh2HHqmyV/4XMuTBePuXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633483; c=relaxed/simple;
	bh=HhRZ2fvE2gijWnwqyS+f/FtEc244e4OY/EDtWOfjlck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPP+EWCeqsMtOFN2LgHdLt2dUDyiMhmo0byQwvod82y0M4mL2UvMBrBdPCdUwh1qSaTdo4uywVPw9P90C7KicW5RIwx8tq9Rv6yajVD26J0OiT3ZFSdP4rLHmg3hcoeeAeYX/q8z3sZIX3DZMprsOyUXEuxntyAEvxF5IBibwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79C00497;
	Tue, 22 Oct 2024 14:45:09 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70B8C3F528;
	Tue, 22 Oct 2024 14:44:38 -0700 (PDT)
Message-ID: <b51726f2-7a6d-4ef2-8fdc-28e76e4ab5d0@arm.com>
Date: Tue, 22 Oct 2024 22:45:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] thermal: core: Introduce thermal_instance_add()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <3618899.iIbC2pHGDl@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3618899.iIbC2pHGDl@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 23:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To reduce the number of redundant result checks in
> thermal_bind_cdev_to_trip() and make the code in it easier to
> follow, move some of it to a new function called thermal_instance_add()
> and make thermal_bind_cdev_to_trip() invoke that function.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-pm/2641944.Lt9SDvczpP@rjwysocki.net/
> 
> ---
>   drivers/thermal/thermal_core.c |   46 ++++++++++++++++++++++++++---------------
>   1 file changed, 30 insertions(+), 16 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -743,6 +743,28 @@ struct thermal_zone_device *thermal_zone
>    *				     binding, and unbinding.
>    */
>   
> +static int thermal_instance_add(struct thermal_instance *new_instance,
> +				struct thermal_cooling_device *cdev,
> +				struct thermal_trip_desc *td)
> +{
> +	struct thermal_instance *instance;
> +
> +	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
> +		if (instance->cdev == cdev)
> +			return -EEXIST;
> +	}
> +
> +	list_add_tail(&new_instance->trip_node, &td->thermal_instances);
> +
> +	mutex_lock(&cdev->lock);
> +
> +	list_add_tail(&new_instance->cdev_node, &cdev->thermal_instances);
> +
> +	mutex_unlock(&cdev->lock);
> +
> +	return 0;
> +}
> +
>   /**
>    * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
>    * @tz:		pointer to struct thermal_zone_device
> @@ -761,7 +783,7 @@ static int thermal_bind_cdev_to_trip(str
>   				     struct thermal_cooling_device *cdev,
>   				     struct cooling_spec *cool_spec)
>   {
> -	struct thermal_instance *dev, *instance;
> +	struct thermal_instance *dev;
>   	bool upper_no_limit;
>   	int result;
>   
> @@ -823,23 +845,15 @@ static int thermal_bind_cdev_to_trip(str
>   	if (result)
>   		goto remove_trip_file;
>   
> -	mutex_lock(&cdev->lock);
> -	list_for_each_entry(instance, &td->thermal_instances, trip_node)
> -		if (instance->cdev == cdev) {
> -			result = -EEXIST;
> -			break;
> -		}
> -	if (!result) {
> -		list_add_tail(&dev->trip_node, &td->thermal_instances);
> -		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
> -	}
> -	mutex_unlock(&cdev->lock);
> +	result = thermal_instance_add(dev, cdev, td);
> +	if (result)
> +		goto remove_weight_file;
>   
> -	if (!result) {
> -		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
> -		return 0;
> -	}
> +	thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
> +
> +	return 0;
>   
> +remove_weight_file:
>   	device_remove_file(&tz->device, &dev->weight_attr);
>   remove_trip_file:
>   	device_remove_file(&tz->device, &dev->attr);
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

