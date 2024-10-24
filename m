Return-Path: <linux-pm+bounces-16364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D709AE2A2
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5101E28259D
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB911C4A20;
	Thu, 24 Oct 2024 10:32:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B141BD4FD;
	Thu, 24 Oct 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765929; cv=none; b=TkdV9oZM0Vzpjw/pVLkQNzAOfVwBAQuYdNnwOHTQDFYpDz3uLOM2+/mNW9xOXUNeRSpiKXuEcUFRutXpHuP7nuStj8RJQzw1yu1IxFVmdAKmRHGQJ2Vo3kySxXBDtcEieFC+nxRcqPfBNFOCD5n51AVvXCQhM8lb4QEoMUXyA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765929; c=relaxed/simple;
	bh=N1a2FCIhwf8tN2yAf7wZiMKfvXB5fJELff9cA4vITLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFBFZCKWGYGi04haaQbsztFS0CKo10BmM+QD8MnaRi+SHPvxiWRR/mSHpYlqiHVONsJR/yZkf3LQ2VVAze/zDaTwchRWml/0RXpFv94kq3EhVz2iDj4GjnIKNcjVUCJLiIewFGGK2y75Fu8/MLpMparAZMLbVIFVjb8tVI9N21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBD95339;
	Thu, 24 Oct 2024 03:32:35 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21D163F71E;
	Thu, 24 Oct 2024 03:32:04 -0700 (PDT)
Message-ID: <d2239ab1-ae95-4b51-9cc5-8aac9eb67970@arm.com>
Date: Thu, 24 Oct 2024 11:33:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/10] thermal: core: Eliminate
 thermal_zone_trip_down()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <1807510.VLH7GnMWUR@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1807510.VLH7GnMWUR@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 12:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since thermal_zone_set_trip_temp() is not located in the same file

nit: s/not/now

> as thermal_trip_crossed(), it can invoke the latter directly without
> using the thermal_zone_trip_down() wrapper that has no other users.
> 
> Update thermal_zone_set_trip_temp() accordingly and drop
> thermal_zone_trip_down().
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |    8 +-------
>   drivers/thermal/thermal_core.h |    2 --
>   2 files changed, 1 insertion(+), 9 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -565,7 +565,7 @@ void thermal_zone_set_trip_temp(struct t
>   		 * are needed to compensate for the lack of it going forward.
>   		 */
>   		if (tz->temperature >= td->threshold)
> -			thermal_zone_trip_down(tz, td);
> +			thermal_trip_crossed(tz, td, thermal_get_tz_governor(tz), false);

minor thing:
won't that be too long line?
IMHO we can add somewhere earlier:
struct thermal_governor *gov = thermal_get_tz_governor(tz);
and use it here

>   
>   		/*
>   		 * Invalidate the threshold to avoid triggering a spurious
> @@ -699,12 +699,6 @@ void thermal_zone_device_update(struct t
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_device_update);
>   
> -void thermal_zone_trip_down(struct thermal_zone_device *tz,
> -			    struct thermal_trip_desc *td)
> -{
> -	thermal_trip_crossed(tz, td, thermal_get_tz_governor(tz), false);
> -}
> -
>   int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
>   			      void *data)
>   {
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -273,8 +273,6 @@ void thermal_zone_set_trips(struct therm
>   int thermal_zone_trip_id(const struct thermal_zone_device *tz,
>   			 const struct thermal_trip *trip);
>   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
> -void thermal_zone_trip_down(struct thermal_zone_device *tz,
> -			    struct thermal_trip_desc *td);
>   void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
>   				struct thermal_trip *trip, int hyst);
>   
> 
> 
> 

other than that, LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

