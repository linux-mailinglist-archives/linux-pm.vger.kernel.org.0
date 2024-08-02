Return-Path: <linux-pm+bounces-11830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48725945B94
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 11:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0445F282E76
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0EF1DC488;
	Fri,  2 Aug 2024 09:55:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DF31DC483;
	Fri,  2 Aug 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592538; cv=none; b=eLspkjrBmPupkpswNHBwoH9YdT5gbOQXcXq+6Q/VfdGkvaku8b4EFXTe7DZ/mSn8aLuvpS7Ot+ftu6vtpNvy/ItNl/4dNJ29h6WXw/HiAYyFAKYR0giidZesA3svZrZhdth8YAHUtjD8iHPOroUWevdZnO5GVvC7MFtGtH+/akw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592538; c=relaxed/simple;
	bh=ReVQBjv/zIHokT+Y0qUIR2D0HxAinI1Zgi+V2uOs+/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ge3CH1J1HzH8evz8VOLoRbM9/TrjBcAsCQP+yAIFP6mEEkAceKpFrHrzxxC9hxqOpZR8onyP/5vTltJdwA7MhUxpTz35YvYrSBleCNL3sqG41tI00+4LQGal6GPRPO/E5IyUbs0d4rKY59bwHHtSFV7lf2YcMJ8XVJH1wy7MS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53CE81007;
	Fri,  2 Aug 2024 02:56:02 -0700 (PDT)
Received: from [10.57.12.204] (unknown [10.57.12.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF3ED3F64C;
	Fri,  2 Aug 2024 02:55:35 -0700 (PDT)
Message-ID: <fb56f08a-ca88-44d9-9f88-896b7bd0701c@arm.com>
Date: Fri, 2 Aug 2024 10:56:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 8/8] thermal: trip: Drop
 thermal_zone_get_trip()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <2211925.irdbgypaU6@rjwysocki.net>
 <2220301.Mh6RI2rZIc@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2220301.Mh6RI2rZIc@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/24 17:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are no more callers of thermal_zone_get_trip() in the tree, so
> drop it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_trip.c |   14 --------------
>   include/linux/thermal.h        |    2 --
>   2 files changed, 16 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -108,20 +108,6 @@ void thermal_zone_set_trips(struct therm
>   		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
>   }
>   
> -int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> -			  struct thermal_trip *trip)
> -{
> -	if (!tz || !trip || trip_id < 0 || trip_id >= tz->num_trips)
> -		return -EINVAL;
> -
> -	mutex_lock(&tz->lock);
> -	*trip = tz->trips[trip_id].trip;
> -	mutex_unlock(&tz->lock);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
> -
>   int thermal_zone_trip_id(const struct thermal_zone_device *tz,
>   			 const struct thermal_trip *trip)
>   {
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -202,8 +202,6 @@ static inline void devm_thermal_of_zone_
>   }
>   #endif
>   
> -int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> -			  struct thermal_trip *trip);
>   int for_each_thermal_trip(struct thermal_zone_device *tz,
>   			  int (*cb)(struct thermal_trip *, void *),
>   			  void *data);
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

