Return-Path: <linux-pm+bounces-20606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87127A14B74
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 09:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70151888BF3
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2521F8689;
	Fri, 17 Jan 2025 08:50:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13A1F754C;
	Fri, 17 Jan 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103850; cv=none; b=Uo3XjmyC0sqbfBrYT217le3f7uc5UXbCXvjPq5hYGCAgbR8RUDmeP5nzrtzQep8UQasZxpyB8jgIclw1pJTB4CqWiIlsXGFZL5KRsUx8t3hPajJUMpwKDk1q8cO4nHieQS/tvHmmK7/lGXesXJRYS2Kb5dpMHxqL/Xu2grZcHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103850; c=relaxed/simple;
	bh=KErP8MgJxQFJW/J+MbgUBtrYsMqwcnvc+jrzbyhiR38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nu39AczzVrDjTupf5n4fsJB296y1PVgGJsjh7iox2y0dmHYW5fG2LxehheHmRlfPeAvtfpZ+08Yxk6uBGM5CNVNqCYPGOQCnYR79F416u5JzsfJGEEYsEZtH7B5kWJ9N0qRANl6GKedbL8y3B7x/NUR5JMUmchxfRxH2d+wKkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3285911FB;
	Fri, 17 Jan 2025 00:51:16 -0800 (PST)
Received: from [10.57.76.33] (unknown [10.57.76.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE9EB3F73F;
	Fri, 17 Jan 2025 00:50:46 -0800 (PST)
Message-ID: <2fe91241-f0e1-4c4a-bc75-40f3780909af@arm.com>
Date: Fri, 17 Jan 2025 08:52:28 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] thermal: core: Rename function argument related to
 trip crossing
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <2772026.mvXUDI8C0e@rjwysocki.net>
 <2360961.ElGaqSPkdT@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2360961.ElGaqSPkdT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/25 19:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rename the 'crossed_up' function argument to 'upward', which is more
> proper English and a better match for representing temperature change
> direction, everywhere in the code.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_bang_bang.c  |    6 +++---
>   drivers/thermal/gov_user_space.c |    4 ++--
>   drivers/thermal/thermal_core.c   |   10 +++++-----
>   drivers/thermal/thermal_core.h   |    2 +-
>   4 files changed, 11 insertions(+), 11 deletions(-)
> 
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -58,11 +58,11 @@
>    * bang_bang_trip_crossed - controls devices associated with the given zone
>    * @tz: thermal_zone_device
>    * @trip: the trip point
> - * @crossed_up: whether or not the trip has been crossed on the way up
> + * @upward: whether or not the trip has been crossed on the way up
>    */
>   static void bang_bang_trip_crossed(struct thermal_zone_device *tz,
>   				   const struct thermal_trip *trip,
> -				   bool crossed_up)
> +				   bool upward)
>   {
>   	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
>   	struct thermal_instance *instance;
> @@ -74,7 +74,7 @@
>   		tz->temperature, trip->hysteresis);
>   
>   	list_for_each_entry(instance, &td->thermal_instances, trip_node)
> -		bang_bang_set_instance_target(instance, crossed_up);
> +		bang_bang_set_instance_target(instance, upward);
>   }
>   
>   static void bang_bang_manage(struct thermal_zone_device *tz)
> --- a/drivers/thermal/gov_user_space.c
> +++ b/drivers/thermal/gov_user_space.c
> @@ -26,13 +26,13 @@
>    * user_space_trip_crossed - Notify user space about trip crossing events
>    * @tz: thermal_zone_device
>    * @trip: trip point
> - * @crossed_up: whether or not the trip has been crossed on the way up
> + * @upward: whether or not the trip has been crossed on the way up
>    *
>    * This function notifies the user space through UEvents.
>    */
>   static void user_space_trip_crossed(struct thermal_zone_device *tz,
>   				    const struct thermal_trip *trip,
> -				    bool crossed_up)
> +				    bool upward)
>   {
>   	char *thermal_prop[5];
>   	int i;
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -454,23 +454,23 @@
>   static void thermal_governor_trip_crossed(struct thermal_governor *governor,
>   					  struct thermal_zone_device *tz,
>   					  const struct thermal_trip *trip,
> -					  bool crossed_up)
> +					  bool upward)
>   {
>   	if (trip->type == THERMAL_TRIP_HOT || trip->type == THERMAL_TRIP_CRITICAL)
>   		return;
>   
>   	if (governor->trip_crossed)
> -		governor->trip_crossed(tz, trip, crossed_up);
> +		governor->trip_crossed(tz, trip, upward);
>   }
>   
>   static void thermal_trip_crossed(struct thermal_zone_device *tz,
>   				 struct thermal_trip_desc *td,
>   				 struct thermal_governor *governor,
> -				 bool crossed_up)
> +				 bool upward)
>   {
>   	const struct thermal_trip *trip = &td->trip;
>   
> -	if (crossed_up) {
> +	if (upward) {
>   		if (trip->type == THERMAL_TRIP_PASSIVE)
>   			tz->passive++;
>   		else if (trip->type == THERMAL_TRIP_CRITICAL ||
> @@ -493,7 +493,7 @@
>   		dev_info(&tz->device, "Trip crossed down: %d\n",
>   			 trip->temperature - trip->hysteresis);
>   	}
> -	thermal_governor_trip_crossed(governor, tz, trip, crossed_up);
> +	thermal_governor_trip_crossed(governor, tz, trip, upward);
>   }
>   
>   void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -56,7 +56,7 @@
>   	void (*unbind_from_tz)(struct thermal_zone_device *tz);
>   	void (*trip_crossed)(struct thermal_zone_device *tz,
>   			     const struct thermal_trip *trip,
> -			     bool crossed_up);
> +			     bool upward);
>   	void (*manage)(struct thermal_zone_device *tz);
>   	void (*update_tz)(struct thermal_zone_device *tz,
>   			  enum thermal_notify_event reason);
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

