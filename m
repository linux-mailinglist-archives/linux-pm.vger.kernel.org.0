Return-Path: <linux-pm+bounces-11829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E31D2945B86
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A691C22AFB
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3651DB45F;
	Fri,  2 Aug 2024 09:54:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7494C1DB420;
	Fri,  2 Aug 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592479; cv=none; b=YokMeuwNkrGl78/lgK1ODcmJ1sAN4b/hcrJkk2Dzeu6bzLJ44exzRzXqu7Nqnx5XSJypM2nhJDqQEJLueCdKi12cCy3ciQV3h3IPeeFducSkRntlIEbTOQWQgif64lqT0KcmGWlPVhKTdHV/9u4yPx5iJuF+g1B91Nx6V6UUmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592479; c=relaxed/simple;
	bh=URGYJ8RhefVSHn8gJtEsUTIEneupGZk4EK/IbPVtF64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsS0Uru2JmNzy5LHiCKCSA7GYUyyxA4pa7iFWkI1JocF1LWfuhKeBS8L4USN0JlnN6PCL+CV7GIBD4jSCnOCymuRU7g7NbkTA49Nvu9itaniKcp1dSc1JlU3M8QvfiSvHrCDlV4EXQvsChajU4h73QpaOg8dS1y85/RJIiE2iTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3E8E1007;
	Fri,  2 Aug 2024 02:55:02 -0700 (PDT)
Received: from [10.57.12.204] (unknown [10.57.12.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E862E3F64C;
	Fri,  2 Aug 2024 02:54:35 -0700 (PDT)
Message-ID: <4ecc1d54-a17e-4cda-a3a8-6d12afcd1823@arm.com>
Date: Fri, 2 Aug 2024 10:55:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] thermal: trip: Get rid of
 thermal_zone_get_num_trips()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 linux-renesas-soc@vger.kernel.org
References: <2211925.irdbgypaU6@rjwysocki.net>
 <2636988.Lt9SDvczpP@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2636988.Lt9SDvczpP@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/24 17:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The only existing caller of thermal_zone_get_num_trips(), which is
> rcar_gen3_thermal_probe(), uses this function to put the number of
> trip points into a kernel log message, but this information is also
> available from the thermal sysfs interface.
> 
> For this reason, remove the thermal_zone_get_num_trips() call from
> rcar_gen3_thermal_probe() and drop the former altogether.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> A new version, based on the discussion following the v1:
> 
> https://lore.kernel.org/linux-pm/20240617183949.GO382677@ragnatech.se/
> 
> The Renesas driver change does not depend on the previous patches
> in the series.
> 
> ---
>   drivers/thermal/renesas/rcar_gen3_thermal.c |    6 +-----
>   drivers/thermal/thermal_trip.c              |    6 ------
>   include/linux/thermal.h                     |    1 -
>   3 files changed, 1 insertion(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -563,11 +563,7 @@ static int rcar_gen3_thermal_probe(struc
>   		if (ret)
>   			goto error_unregister;
>   
> -		ret = thermal_zone_get_num_trips(tsc->zone);
> -		if (ret < 0)
> -			goto error_unregister;
> -
> -		dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, ret);
> +		dev_info(dev, "Sensor %u: Loaded\n", i);
>   	}
>   
>   	if (!priv->num_tscs) {
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -55,12 +55,6 @@ int thermal_zone_for_each_trip(struct th
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_for_each_trip);
>   
> -int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
> -{
> -	return tz->num_trips;
> -}
> -EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
> -
>   /**
>    * thermal_zone_set_trips - Computes the next trip points for the driver
>    * @tz: a pointer to a thermal zone device structure
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -210,7 +210,6 @@ int for_each_thermal_trip(struct thermal
>   int thermal_zone_for_each_trip(struct thermal_zone_device *tz,
>   			       int (*cb)(struct thermal_trip *, void *),
>   			       void *data);
> -int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
>   void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
>   				struct thermal_trip *trip, int temp);
>   
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

