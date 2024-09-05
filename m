Return-Path: <linux-pm+bounces-13660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC096D22E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6FC2883BE
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C591898E4;
	Thu,  5 Sep 2024 08:32:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC3A16F839;
	Thu,  5 Sep 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525150; cv=none; b=fKF4ZNt6pRJDPTephxeQKUuSj3571nCVtw5B0PjhnogjT61Vpx1mlezw5LUGCe/du0Hi/pZ8q4/js1d26QqGCiDadun446QOn3tjOwVjxIEkI6p12kpTvayUgB1fPzNT6zG2nmfns5+Imghx53e57t83JcvpJ3/Dyk1tV4SbNkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525150; c=relaxed/simple;
	bh=dPaLBnlij2n0mAuk6CRDoMcb5cnlDujlkkSq6WQ7F88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtqXscowPU6mo27Qg3VFpsmtUyXdQCisHkqtMU/cCn8ZHibz60qNQD9UFzeqbjLOBieO1twlpFi30qe1wjfSjRYo/1UKiuaabghqTIxxYxug51VRd8ZPqrMpVFEKUD7ycqisi5Gv7FeDmFRzPNrykIn/gXxHZmk5VJ6vWTxDCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CD83FEC;
	Thu,  5 Sep 2024 01:32:53 -0700 (PDT)
Received: from [10.57.86.69] (unknown [10.57.86.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F8C3F66E;
	Thu,  5 Sep 2024 01:32:25 -0700 (PDT)
Message-ID: <71e26995-0438-4868-a96c-3c2f4c9f51e7@arm.com>
Date: Thu, 5 Sep 2024 09:33:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: gov_bang_bang: Adjust states of all
 uninitialized instances
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>,
 Linux PM <linux-pm@vger.kernel.org>
References: <6103874.lOV4Wx5bFT@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <6103874.lOV4Wx5bFT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/26/24 17:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a cooling device is registered after a thermal zone it should be
> bound to and the trip point it should be bound to has already been
> crossed by the zone temperature on the way up, the cooling device's
> state may need to be adjusted, but the Bang-bang governor will not
> do that because its .manage() callback only looks at thermal instances
> for trip points whose thresholds are below or at the zone temperature.
> 
> Address this by updating bang_bang_manage() to look at all of the
> uninitialized thermal instances and setting their target states in
> accordance with the position of the zone temperature with respect to
> the threshold of the given trip point.
> 
> Fixes: 5f64b4a1ab1b ("thermal: gov_bang_bang: Add .manage() callback")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Found by code inspection while considering a related change.
> 
> I don't thik it is super-urgent, but it qualifies as 6.12 material IMV.
> 
> ---
>   drivers/thermal/gov_bang_bang.c |   14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -92,23 +92,21 @@ static void bang_bang_manage(struct ther
>   
>   	for_each_trip_desc(tz, td) {
>   		const struct thermal_trip *trip = &td->trip;
> +		bool turn_on;
>   
> -		if (tz->temperature >= td->threshold ||
> -		    trip->temperature == THERMAL_TEMP_INVALID ||
> +		if (trip->temperature == THERMAL_TEMP_INVALID ||
>   		    trip->type == THERMAL_TRIP_CRITICAL ||
>   		    trip->type == THERMAL_TRIP_HOT)
>   			continue;
>   
>   		/*
> -		 * If the initial cooling device state is "on", but the zone
> -		 * temperature is not above the trip point, the core will not
> -		 * call bang_bang_control() until the zone temperature reaches
> -		 * the trip point temperature which may be never.  In those
> -		 * cases, set the initial state of the cooling device to 0.
> +		 * Adjust the target states for uninitialized thermal instances
> +		 * to the thermal zone temperature and the trip point threshold.
>   		 */
> +		turn_on = tz->temperature >= td->threshold;
>   		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>   			if (!instance->initialized && instance->trip == trip)
> -				bang_bang_set_instance_target(instance, 0);
> +				bang_bang_set_instance_target(instance, turn_on);
>   		}
>   	}
>   
> 
> 
> 

That makes sense.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

