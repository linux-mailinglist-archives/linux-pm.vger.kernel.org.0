Return-Path: <linux-pm+bounces-16161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776D9A9375
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00971F21473
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540DE1FBC81;
	Mon, 21 Oct 2024 22:36:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62025137750;
	Mon, 21 Oct 2024 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550207; cv=none; b=FmXoNyY0k3y4KzEsDVqlZbhU4YUrQG/bT+Ew2Qt2myX4Zu/myZKb3aqHiUiu13U/nFzTKq+idW2IVowEEZCndNbzPg9+OHxdJMfS1RlvkPWUoUoxDq6gS2jXR+p5XQBM1qLeO8fIfxAtPJWSNHqd1PDaMXAnC7UpNQNTwYTa6II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550207; c=relaxed/simple;
	bh=FgvSMqrpDYAWS/XarD4loHFGf/KijOACB4jjm3rxH8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E76pUOMHYZNtiVm04JmPdTWuP6U5gJ8Frxdk/OSVIiFuZ1alJbFhoSlTNLb4lT4SVYWWZbPWmnpRodI1SB9Q/YjRMy1TDsyta0DyB6JTI3CvgQHlqi7MOd2iTWCgPkRTsFyzKdG2pf5mmQxK/K63XjOHjWjMOE3YQ+OI89to+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D7AC497;
	Mon, 21 Oct 2024 15:37:14 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80C843F71E;
	Mon, 21 Oct 2024 15:36:43 -0700 (PDT)
Message-ID: <64b8bdfb-8f9e-4e18-b651-b213e14ba2b7@arm.com>
Date: Mon, 21 Oct 2024 23:37:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] thermal: core: Pass trip descriptors to trip
 bind/unbind functions
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <2246211.NgBsaNRSFp@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2246211.NgBsaNRSFp@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The code is somewhat cleaner if struct thermal_trip_desc pointers are
> passed to thermal_bind_cdev_to_trip(), thermal_unbind_cdev_from_trip(),
> and print_bind_err_msg() instead of struct thermal_trip pointers, so
> modify it accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/2954063.e9J7NaK4W3@rjwysocki.net/
> 
> v1 -> v2: Rebase and drop the leftover Subject: field from the preamble.
> 
> ---
>   drivers/thermal/thermal_core.c |   27 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 15 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -757,9 +757,9 @@ struct thermal_zone_device *thermal_zone
>   /**
>    * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
>    * @tz:		pointer to struct thermal_zone_device
> - * @trip:	trip point the cooling devices is associated with in this zone.
> + * @td:		descriptor of the trip point to bind @cdev to
>    * @cdev:	pointer to struct thermal_cooling_device
> - * @cool_spec:	cooling specification for @trip and @cdev
> + * @cool_spec:	cooling specification for the trip point and @cdev
>    *
>    * This interface function bind a thermal cooling device to the certain trip
>    * point of a thermal zone device.
> @@ -768,11 +768,10 @@ struct thermal_zone_device *thermal_zone
>    * Return: 0 on success, the proper error value otherwise.
>    */
>   static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
> -				     struct thermal_trip *trip,
> +				     struct thermal_trip_desc *td,
>   				     struct thermal_cooling_device *cdev,
>   				     struct cooling_spec *cool_spec)
>   {
> -	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
>   	struct thermal_instance *dev, *instance;
>   	bool upper_no_limit;
>   	int result;
> @@ -796,7 +795,7 @@ static int thermal_bind_cdev_to_trip(str
>   		return -ENOMEM;
>   
>   	dev->cdev = cdev;
> -	dev->trip = trip;
> +	dev->trip = &td->trip;
>   	dev->upper = cool_spec->upper;
>   	dev->upper_no_limit = upper_no_limit;
>   	dev->lower = cool_spec->lower;
> @@ -867,7 +866,7 @@ free_mem:
>   /**
>    * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
>    * @tz:		pointer to a struct thermal_zone_device.
> - * @trip:	trip point the cooling devices is associated with in this zone.
> + * @td:		descriptor of the trip point to unbind @cdev from
>    * @cdev:	pointer to a struct thermal_cooling_device.
>    *
>    * This interface function unbind a thermal cooling device from the certain
> @@ -875,10 +874,9 @@ free_mem:
>    * This function is usually called in the thermal zone device .unbind callback.
>    */
>   static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
> -					  struct thermal_trip *trip,
> +					  struct thermal_trip_desc *td,
>   					  struct thermal_cooling_device *cdev)
>   {
> -	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
>   	struct thermal_instance *pos, *next;
>   
>   	mutex_lock(&cdev->lock);
> @@ -930,11 +928,11 @@ static struct class *thermal_class;
>   
>   static inline
>   void print_bind_err_msg(struct thermal_zone_device *tz,
> -			const struct thermal_trip *trip,
> +			const struct thermal_trip_desc *td,
>   			struct thermal_cooling_device *cdev, int ret)
>   {
>   	dev_err(&tz->device, "binding cdev %s to trip %d failed: %d\n",
> -		cdev->type, thermal_zone_trip_id(tz, trip), ret);
> +		cdev->type, thermal_zone_trip_id(tz, &td->trip), ret);
>   }
>   
>   static bool __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
> @@ -947,7 +945,6 @@ static bool __thermal_zone_cdev_bind(str
>   		return false;
>   
>   	for_each_trip_desc(tz, td) {
> -		struct thermal_trip *trip = &td->trip;
>   		struct cooling_spec c = {
>   			.upper = THERMAL_NO_LIMIT,
>   			.lower = THERMAL_NO_LIMIT,
> @@ -955,12 +952,12 @@ static bool __thermal_zone_cdev_bind(str
>   		};
>   		int ret;
>   
> -		if (!tz->ops.should_bind(tz, trip, cdev, &c))
> +		if (!tz->ops.should_bind(tz, &td->trip, cdev, &c))
>   			continue;
>   
> -		ret = thermal_bind_cdev_to_trip(tz, trip, cdev, &c);
> +		ret = thermal_bind_cdev_to_trip(tz, td, cdev, &c);
>   		if (ret) {
> -			print_bind_err_msg(tz, trip, cdev, ret);
> +			print_bind_err_msg(tz, td, cdev, ret);
>   			continue;
>   		}
>   
> @@ -1279,7 +1276,7 @@ static void __thermal_zone_cdev_unbind(s
>   	struct thermal_trip_desc *td;
>   
>   	for_each_trip_desc(tz, td)
> -		thermal_unbind_cdev_from_trip(tz, &td->trip, cdev);
> +		thermal_unbind_cdev_from_trip(tz, td, cdev);
>   }
>   
>   static void thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

