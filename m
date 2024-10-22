Return-Path: <linux-pm+bounces-16272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC99AB97C
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 00:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F271F23558
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23441C9EBC;
	Tue, 22 Oct 2024 22:31:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF86D18DF6B;
	Tue, 22 Oct 2024 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636260; cv=none; b=HRRcO2FyPV3JC1OH1YSMktKOXYU2PE6vUS0ElA29FOwhsRI1OWlrJHID7J1pXF45rPgBP4PX4YtNqwyXIUva4OyXler5TPUbxvvhgaxXVdkWWmshumYp1fUu80csw6dSJb3jaEfdVOpFOJ2y4nTKQVV03KRyuLMGBcVhbWPNmgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636260; c=relaxed/simple;
	bh=tGktF6vSZoG/5Nm3AOwDxotBmxHl3UEOtQYzSdmFcUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdHB2dwRNd0F9KigZ8kdFAserwZn1g9XfW0j2HUEkMi2qPb17Ed3R/+YESYwpIeL2+7BeFmgKQTihkfofuXNZctbsAh5YdKu1FsErYf3qn3T5pG/OWNoMZfWqjwVqWZPddSRapWITB381slto8/RP1dxUJPDClDfbjmnjnM8TlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED9CE497;
	Tue, 22 Oct 2024 15:31:26 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CEA83F528;
	Tue, 22 Oct 2024 15:30:55 -0700 (PDT)
Message-ID: <a67fe4fe-d4a8-4659-802f-8c7da4aa555b@arm.com>
Date: Tue, 22 Oct 2024 23:32:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] thermal: core: Separate thermal zone governor
 initialization
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <4408795.ejJDZkT8p0@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4408795.ejJDZkT8p0@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 23:20, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In preparation for a subsequent change that will switch over the thermal
> core to using a mutex guard for managing thermal_governor_lock, move
> the code running in thermal_zone_device_register_with_trips() under that
> lock into a separate function called thermal_zone_init_governor().
> 
> While at it, drop a useless comment.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-pm/2495577.jE0xQCEvom@rjwysocki.net/
> 
> ---
>   drivers/thermal/thermal_core.c |   36 +++++++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 15 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1343,6 +1343,25 @@ int thermal_zone_get_crit_temp(struct th
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>   
> +static int thermal_zone_init_governor(struct thermal_zone_device *tz)
> +{
> +	struct thermal_governor *governor;
> +	int ret;
> +
> +	mutex_lock(&thermal_governor_lock);
> +
> +	if (tz->tzp)
> +		governor = __find_governor(tz->tzp->governor_name);
> +	else
> +		governor = def_governor;
> +
> +	ret = thermal_set_governor(tz, governor);
> +
> +	mutex_unlock(&thermal_governor_lock);
> +
> +	return ret;
> +}
> +
>   static void thermal_zone_init_complete(struct thermal_zone_device *tz)
>   {
>   	struct thermal_cooling_device *cdev;
> @@ -1407,7 +1426,6 @@ thermal_zone_device_register_with_trips(
>   	struct thermal_trip_desc *td;
>   	int id;
>   	int result;
> -	struct thermal_governor *governor;
>   
>   	if (!type || strlen(type) == 0) {
>   		pr_err("No thermal zone type defined\n");
> @@ -1505,21 +1523,9 @@ thermal_zone_device_register_with_trips(
>   	if (result)
>   		goto release_device;
>   
> -	/* Update 'this' zone's governor information */
> -	mutex_lock(&thermal_governor_lock);
> -
> -	if (tz->tzp)
> -		governor = __find_governor(tz->tzp->governor_name);
> -	else
> -		governor = def_governor;
> -
> -	result = thermal_set_governor(tz, governor);
> -	if (result) {
> -		mutex_unlock(&thermal_governor_lock);
> +	result = thermal_zone_init_governor(tz);
> +	if (result)
>   		goto unregister;
> -	}
> -
> -	mutex_unlock(&thermal_governor_lock);
>   
>   	if (!tz->tzp || !tz->tzp->no_hwmon) {
>   		result = thermal_add_hwmon_sysfs(tz);
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

