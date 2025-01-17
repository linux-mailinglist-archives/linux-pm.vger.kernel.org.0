Return-Path: <linux-pm+bounces-20604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87CA14B61
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 09:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249827A35FE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13B71F76C6;
	Fri, 17 Jan 2025 08:45:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622011F754C;
	Fri, 17 Jan 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103526; cv=none; b=Wy7kVZ8TXh2H5PyCkNKyEW/9VpX1tnNH1JoZQIb/aFBDNP8rYDnxc/6yYdyG8lCkV76ItJCsv7h8fbOFsyCYCPc77DCY4afODu65x5PccMENuvhH208tdihm9wZcySVI8Fx6TJoLW/C8no8zGjaDlRmztgx4Ft6ntEv8ridS0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103526; c=relaxed/simple;
	bh=sokJOXEbSlOKOIKJrL8uki2RfnfZMPBAna7fxrtFi1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hR10LLhkLDHHaSQe+67of8tqb0RhRSQUlqaitYNMaq4oIBr8XLgr11+7U+/Y9M2AQjhB0qKg5vF13Lmn6VdRv8IzzNGL1P2PRyDKPk2QnUA2o0aoUfXWz9i3l7ensg4KGuBVOeBx0vLUFVg3wPt8tuUobjgdiYR51o+NGLrrHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C189D11FB;
	Fri, 17 Jan 2025 00:45:51 -0800 (PST)
Received: from [10.57.76.33] (unknown [10.57.76.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90F713F7B4;
	Fri, 17 Jan 2025 00:45:22 -0800 (PST)
Message-ID: <93c705d7-b5c5-4820-b286-f6794e856a3e@arm.com>
Date: Fri, 17 Jan 2025 08:47:04 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] thermal: core: Rename callback functions in two
 governors
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <2772026.mvXUDI8C0e@rjwysocki.net>
 <5859084.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5859084.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 1/16/25 19:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The names of :trip_crossed() callback functions in the Bang-bang and
> User-space thermal governors don't match their current purpose any
> more after previous changes, so rename them.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_bang_bang.c  |   10 +++++-----
>   drivers/thermal/gov_user_space.c |   10 +++++-----
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -34,7 +34,7 @@
>   }
>   
>   /**
> - * bang_bang_control - controls devices associated with the given zone
> + * bang_bang_trip_crossed - controls devices associated with the given zone
>    * @tz: thermal_zone_device
>    * @trip: the trip point
>    * @crossed_up: whether or not the trip has been crossed on the way up
> @@ -61,9 +61,9 @@
>    *     (trip_temp - hyst) so that the fan gets turned off again.
>    *
>    */
> -static void bang_bang_control(struct thermal_zone_device *tz,
> -			      const struct thermal_trip *trip,
> -			      bool crossed_up)
> +static void bang_bang_trip_crossed(struct thermal_zone_device *tz,
> +				   const struct thermal_trip *trip,
> +				   bool crossed_up)
>   {
>   	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
>   	struct thermal_instance *instance;
> @@ -123,7 +123,7 @@
>   
>   static struct thermal_governor thermal_gov_bang_bang = {
>   	.name		= "bang_bang",
> -	.trip_crossed	= bang_bang_control,
> +	.trip_crossed	= bang_bang_trip_crossed,
>   	.manage		= bang_bang_manage,
>   	.update_tz	= bang_bang_update_tz,
>   };
> --- a/drivers/thermal/gov_user_space.c
> +++ b/drivers/thermal/gov_user_space.c
> @@ -23,16 +23,16 @@
>   }
>   
>   /**
> - * notify_user_space - Notifies user space about thermal events
> + * user_space_trip_crossed - Notify user space about trip crossing events
>    * @tz: thermal_zone_device
>    * @trip: trip point
>    * @crossed_up: whether or not the trip has been crossed on the way up
>    *
>    * This function notifies the user space through UEvents.
>    */
> -static void notify_user_space(struct thermal_zone_device *tz,
> -			      const struct thermal_trip *trip,
> -			      bool crossed_up)
> +static void user_space_trip_crossed(struct thermal_zone_device *tz,
> +				    const struct thermal_trip *trip,
> +				    bool crossed_up)
>   {
>   	char *thermal_prop[5];
>   	int i;
> @@ -52,7 +52,7 @@
>   
>   static struct thermal_governor thermal_gov_user_space = {
>   	.name		= "user_space",
> -	.trip_crossed	= notify_user_space,
> +	.trip_crossed	= user_space_trip_crossed,
>   	.bind_to_tz	= user_space_bind,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
> 
> 
> 

Make sense and LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

