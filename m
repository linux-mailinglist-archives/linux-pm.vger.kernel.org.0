Return-Path: <linux-pm+bounces-16152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B42649A9338
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA52F1C21ACB
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60771E283A;
	Mon, 21 Oct 2024 22:22:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B7433D8;
	Mon, 21 Oct 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549357; cv=none; b=jvM6wPiOfiguG+uhoW5b85Gb9BzwpJZRl0FYfHS+gtJ+Rk3m0FM0Kdr6g+yJcYHHX7UEnSYNOn2pX4zf6GX5Ayi68v9ATgZF8eOWOGR/Hxf/wC6EVfcOvCb+7kZHqwS2eUF+dvhXU8dm5ibdXoZGuzOTr5MolGP/nVkx5GKUb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549357; c=relaxed/simple;
	bh=fCITHyJLnrqPuzGdHO7doJEsyzBVBGiiwWm56sxcivo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PssRbNfL6as9s72nTzyjayYiF0tYsLq4u2R217YcxO980K8lnFUhbi7OhhC7L1Gpu9A9c+dzyZLRMfgUh6QJ7p04MdWG1bvU7e01KJpfLPh/2Pa3W2//oxIw1xEAd2ofEw7zXqD4HLC++d94ZwcIRr7GIwClo+RX3BZShqzVTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7ECC497;
	Mon, 21 Oct 2024 15:23:03 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E876E3F71E;
	Mon, 21 Oct 2024 15:22:32 -0700 (PDT)
Message-ID: <3adbae5c-f6c2-4a9c-8544-7020b84a8845@arm.com>
Date: Mon, 21 Oct 2024 23:23:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] thermal: core: Represent suspend-related thermal
 zone flags as bits
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <7733910.EvYhyI6sBW@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <7733910.EvYhyI6sBW@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using two separate fields in struct thermal_zone_device for
> representing flags related to thermal zone suspend, represent them
> explicitly as bits in one u8 "state" field.
> 
> Subsequently, that field will be used for addressing race conditions
> related to thermal zone initialization and exit.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/2215885.irdbgypaU6@rjwysocki.net/
> 
> v1 -> v2: The thermal zone guard has not been introduced yet, so adjust for that.
> 
> ---
>   drivers/thermal/thermal_core.c |   11 +++++------
>   drivers/thermal/thermal_core.h |   11 +++++++----
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -547,7 +547,7 @@ void __thermal_zone_device_update(struct
>   	int low = -INT_MAX, high = INT_MAX;
>   	int temp, ret;
>   
> -	if (tz->suspended || tz->mode != THERMAL_DEVICE_ENABLED)
> +	if (tz->state != TZ_STATE_READY || tz->mode != THERMAL_DEVICE_ENABLED)
>   		return;
>   
>   	ret = __thermal_zone_get_temp(tz, &temp);
> @@ -1662,7 +1662,7 @@ static void thermal_zone_device_resume(s
>   
>   	mutex_lock(&tz->lock);
>   
> -	tz->suspended = false;
> +	tz->state &= ~(TZ_STATE_FLAG_SUSPENDED | TZ_STATE_FLAG_RESUMING);

I see, we now clean both in on go...

>   
>   	thermal_debug_tz_resume(tz);
>   	thermal_zone_device_init(tz);
> @@ -1670,7 +1670,6 @@ static void thermal_zone_device_resume(s
>   	__thermal_zone_device_update(tz, THERMAL_TZ_RESUME);
>   
>   	complete(&tz->resume);
> -	tz->resuming = false;

so handled as well.

>   
>   	mutex_unlock(&tz->lock);
>   }
> @@ -1679,7 +1678,7 @@ static void thermal_zone_pm_prepare(stru
>   {
>   	mutex_lock(&tz->lock);
>   
> -	if (tz->resuming) {
> +	if (tz->state & TZ_STATE_FLAG_RESUMING) {
>   		/*
>   		 * thermal_zone_device_resume() queued up for this zone has not
>   		 * acquired the lock yet, so release it to let the function run
> @@ -1692,7 +1691,7 @@ static void thermal_zone_pm_prepare(stru
>   		mutex_lock(&tz->lock);
>   	}
>   
> -	tz->suspended = true;
> +	tz->state |= TZ_STATE_FLAG_SUSPENDED;
>   
>   	mutex_unlock(&tz->lock);
>   }
> @@ -1704,7 +1703,7 @@ static void thermal_zone_pm_complete(str
>   	cancel_delayed_work(&tz->poll_queue);
>   
>   	reinit_completion(&tz->resume);
> -	tz->resuming = true;
> +	tz->state |= TZ_STATE_FLAG_RESUMING;
>   
>   	/*
>   	 * Replace the work function with the resume one, which will restore the
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -61,6 +61,11 @@ struct thermal_governor {
>   	struct list_head	governor_list;
>   };
>   
> +#define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
> +#define	TZ_STATE_FLAG_RESUMING	BIT(1)
> +
> +#define TZ_STATE_READY		0
> +
>   /**
>    * struct thermal_zone_device - structure for a thermal zone
>    * @id:		unique id number for each thermal zone
> @@ -100,8 +105,7 @@ struct thermal_governor {
>    * @node:	node in thermal_tz_list (in thermal_core.c)
>    * @poll_queue:	delayed work for polling
>    * @notify_event: Last notification event
> - * @suspended: thermal zone suspend indicator
> - * @resuming:	indicates whether or not thermal zone resume is in progress
> + * @state: 	current state of the thermal zone
>    * @trips:	array of struct thermal_trip objects
>    */
>   struct thermal_zone_device {
> @@ -134,8 +138,7 @@ struct thermal_zone_device {
>   	struct list_head node;
>   	struct delayed_work poll_queue;
>   	enum thermal_notify_event notify_event;
> -	bool suspended;
> -	bool resuming;
> +	u8 state;
>   #ifdef CONFIG_THERMAL_DEBUGFS
>   	struct thermal_debugfs *debugfs;
>   #endif
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

