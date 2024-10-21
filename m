Return-Path: <linux-pm+bounces-16154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77219A9340
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CB8B222CD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED601E04AB;
	Mon, 21 Oct 2024 22:26:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA92DDAB;
	Mon, 21 Oct 2024 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549609; cv=none; b=K6ERlRin74ogiI0YPKSXh2/zXzrhP0aOnPJzuLpoj+gpwB6sLR/9+zzoB1TaRtfJzKLay0bGYOthbdXU3+pm+IEFEPb3vxv6gBDfuTa95j0OCj40ur/IORFZ7BURrRhw8zGyyjSUId/wxR+VxhTN6OZXWn4ieG8ZZH2cbmSCxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549609; c=relaxed/simple;
	bh=RuX1L8iuJqcQbNrzI28tutoy+bCv2zh8/mlt17M1kLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMgFN0XgccYhLtx1lZnAbY9Jvo2CGw4QOeL3GBUKiuZ+avneLvVBTFX4KUGgVGD63y/dAASDKbGf+vkTsF9d4LPbuuHl2V60/3mTUBCZqwWbPO//5YxZVra8730NTVLDquVmA00GV9OartNmoytfXwYDedtv+zUYSFuetlVUNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C093497;
	Mon, 21 Oct 2024 15:27:17 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B4F03F71E;
	Mon, 21 Oct 2024 15:26:46 -0700 (PDT)
Message-ID: <8556b1b6-e557-46db-bcc0-a2c542b7ed2c@arm.com>
Date: Mon, 21 Oct 2024 23:27:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] thermal: core: Fix race between zone
 registration and system suspend
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <8490245.NyiUUSuA9g@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <8490245.NyiUUSuA9g@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the registration of a thermal zone takes place at the time when
> system suspend is started, thermal_pm_notify() can run before the new
> thermal zone is added to thermal_tz_list and its "suspended" flag will
> not be set.  Consequently, if __thermal_zone_device_update() is called
> for that thermal zone, it will not return early as expected which may
> cause some destructive interference with the system suspend or resume
> flow to occur.
> 
> To avoid that, make thermal_zone_init_complete() introduced previously
> set the "suspended" flag for new thermal zones if it runs during system
> suspend or resume.
> 
> Fixes: 4e814173a8c4 ("thermal: core: Fix thermal zone suspend-resume synchronization")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/3335807.44csPzL39Z@rjwysocki.net/
> 
> v1 -> v2: Rebase and add a fixes tag.
> 
> ---
>   drivers/thermal/thermal_core.c |   18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -40,6 +40,8 @@ static DEFINE_MUTEX(thermal_governor_loc
>   
>   static struct thermal_governor *def_governor;
>   
> +static bool thermal_pm_suspended;
> +
>   /*
>    * Governor section: set of functions to handle thermal governors
>    *
> @@ -1337,6 +1339,14 @@ static void thermal_zone_init_complete(s
>   	mutex_lock(&tz->lock);
>   
>   	tz->state &= ~TZ_STATE_FLAG_INIT;
> +	/*
> +	 * If system suspend or resume is in progress at this point, the
> +	 * new thermal zone needs to be marked as suspended because
> +	 * thermal_pm_notify() has run already.
> +	 */
> +	if (thermal_pm_suspended)
> +		tz->state |= TZ_STATE_FLAG_SUSPENDED;
> +
>   	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   
>   	mutex_unlock(&tz->lock);
> @@ -1514,10 +1524,10 @@ thermal_zone_device_register_with_trips(
>   	list_for_each_entry(cdev, &thermal_cdev_list, node)
>   		thermal_zone_cdev_bind(tz, cdev);
>   
> -	mutex_unlock(&thermal_list_lock);
> -
>   	thermal_zone_init_complete(tz);
>   
> +	mutex_unlock(&thermal_list_lock);
> +
>   	thermal_notify_tz_create(tz);
>   
>   	thermal_debug_tz_add(tz);
> @@ -1737,6 +1747,8 @@ static int thermal_pm_notify(struct noti
>   	case PM_SUSPEND_PREPARE:
>   		mutex_lock(&thermal_list_lock);
>   
> +		thermal_pm_suspended = true;
> +
>   		list_for_each_entry(tz, &thermal_tz_list, node)
>   			thermal_zone_pm_prepare(tz);
>   
> @@ -1747,6 +1759,8 @@ static int thermal_pm_notify(struct noti
>   	case PM_POST_SUSPEND:
>   		mutex_lock(&thermal_list_lock);
>   
> +		thermal_pm_suspended = false;
> +
>   		list_for_each_entry(tz, &thermal_tz_list, node)
>   			thermal_zone_pm_complete(tz);
>   
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

