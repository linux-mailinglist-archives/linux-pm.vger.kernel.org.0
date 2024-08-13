Return-Path: <linux-pm+bounces-12186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF90950F59
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 23:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3581F23B17
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 21:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB39419DF49;
	Tue, 13 Aug 2024 21:52:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from sxb1plsmtpa01-04.prod.sxb1.secureserver.net (sxb1plsmtpa01-04.prod.sxb1.secureserver.net [188.121.53.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F281E498
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585976; cv=none; b=mOdvR0fURbcpra0Oyc77Hz8MIcKaNKJ9fdtvgG+SLN3IIMVfabK3ZCnDCU7NWLfZ/Qb5HNAyIsFKGP+RBiB/XjyLs9Z/O2ThbDtrFLMWNcnUYr6s1+VtJMt2geS/0TWu5rsJnU6tR6udYcT7jGYIBnCvEUR+LcWH5ca8xu9NsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585976; c=relaxed/simple;
	bh=49NHkGj4gMT2BNbHsogNRL4db5RNDTOexw5fc9yMBwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oibihGzjzV5FBu/ZmaS0vVCaj04EL1M7/kHB3ixVh/YZALF7/vVH7vuxy3Kb5xQymPi5bwd0yabyyphQhwTJIEAFIkYYbxru3cycYLJ/uXFUIaD/qsjzIRt6cqKzlYPNrAG1BkcPALcgcfYjBopSDr/8LFehZ+ja112i1dG2uCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net; spf=pass smtp.mailfrom=piie.net; arc=none smtp.client-ip=188.121.53.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piie.net
Received: from [192.168.1.27] ([109.90.180.58])
	by :SMTPAUTH: with ESMTPSA
	id dykRsdOMofewidykTsOcWp; Tue, 13 Aug 2024 14:08:10 -0700
X-CMAE-Analysis: v=2.4 cv=fYxmyFQF c=1 sm=1 tr=0 ts=66bbcb3b
 a=ujCVow8R4Y5jPCx6COW8WA==:117 a=ujCVow8R4Y5jPCx6COW8WA==:17
 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=QyXUC8HyAAAA:8 a=t3YNmgBSAAAA:8
 a=uA_CGoYEU2hLf27nDvEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ctH_qozkpUrkr3SVbfwb:22
X-SECURESERVER-ACCT: peter@piie.net
Message-ID: <f8721601-3eb8-4655-a207-fb7e38de2867@piie.net>
Date: Tue, 13 Aug 2024 23:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to
 reduce overhead
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
 <2285575.iZASKD2KPV@rjwysocki.net>
Content-Language: en-US
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
In-Reply-To: <2285575.iZASKD2KPV@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGedixXDMi4Jj7OHNj9s1SlJyk2fAnQI15GP1ma5XklIJsg6LrNxyokXv2o2GRHRVqA8s5g+QZx6swcLlGCYbkaCYOoAjUKbTS4c9X+gvP9s+1xf7lYA
 f8yH5JdFbi/qWyBFgxSaAOattJZuIedYyknEAaRAY60W5D+RjEhcN0k5vnWuuwkxeoILKPdZ9NuFycUkXxeUTvT/HXcIEpObWq092nC0J1mQ/034cH1FRZp8
 LF3wsePwXYkDF8gdTwTkJEvep2WSidkBMUUDoOhqxayu+mwiNzWuWZOX2qey9ZDx13ZEZ2OE1Vt3OfYrpduIqFlPeq/iOOlBytwaJsunszcnB3Fe4ZqsLzXg
 GdSxoggLL6jFa+fpMHezO7zH0Nd5GQ==

On 13.08.24 16:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After running once, the for_each_trip_desc() loop in
> bang_bang_manage() is pure needless overhead because it is not going to
> make any changes unless a new cooling device has been bound to one of
> the trips in the thermal zone or the system is resuming from sleep.
> 
> For this reason, make bang_bang_manage() set governor_data for the
> thermal zone and check it upfront to decide whether or not it needs to
> do anything.
> 
> However, governor_data needs to be reset in some cases to let
> bang_bang_manage() know that it should walk the trips again, so add an
> .update_tz() callback to the governor and make the core additionally
> invoke it during system resume.
> 
> To avoid affecting the other users of that callback unnecessarily, add
> a special notification reason for system resume, THERMAL_TZ_RESUME, and
> also pass it to __thermal_zone_device_update() called during system
> resume for consistency.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Peter Kästle <peter@piie.net>

> ---
>   drivers/thermal/gov_bang_bang.c |   18 ++++++++++++++++++
>   drivers/thermal/thermal_core.c  |    3 ++-
>   include/linux/thermal.h         |    1 +
>   3 files changed, 21 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -86,6 +86,10 @@ static void bang_bang_manage(struct ther
>   	const struct thermal_trip_desc *td;
>   	struct thermal_instance *instance;
>   
> +	/* If the code below has run already, nothing needs to be done. */
> +	if (tz->governor_data)
> +		return;
> +
>   	for_each_trip_desc(tz, td) {
>   		const struct thermal_trip *trip = &td->trip;
>   
> @@ -107,11 +111,25 @@ static void bang_bang_manage(struct ther
>   				bang_bang_set_instance_target(instance, 0);
>   		}
>   	}
> +
> +	tz->governor_data = (void *)true;
> +}
> +
> +static void bang_bang_update_tz(struct thermal_zone_device *tz,
> +				enum thermal_notify_event reason)
> +{
> +	/*
> +	 * Let bang_bang_manage() know that it needs to walk trips after binding
> +	 * a new cdev and after system resume.
> +	 */
> +	if (reason == THERMAL_TZ_BIND_CDEV || reason == THERMAL_TZ_RESUME)
> +		tz->governor_data = NULL;
>   }
>   
>   static struct thermal_governor thermal_gov_bang_bang = {
>   	.name		= "bang_bang",
>   	.trip_crossed	= bang_bang_control,
>   	.manage		= bang_bang_manage,
> +	.update_tz	= bang_bang_update_tz,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1692,7 +1692,8 @@ static void thermal_zone_device_resume(s
>   
>   	thermal_debug_tz_resume(tz);
>   	thermal_zone_device_init(tz);
> -	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +	thermal_governor_update_tz(tz, THERMAL_TZ_RESUME);
> +	__thermal_zone_device_update(tz, THERMAL_TZ_RESUME);
>   
>   	complete(&tz->resume);
>   	tz->resuming = false;
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -55,6 +55,7 @@ enum thermal_notify_event {
>   	THERMAL_TZ_BIND_CDEV, /* Cooling dev is bind to the thermal zone */
>   	THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal zone */
>   	THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight changed */
> +	THERMAL_TZ_RESUME, /* Thermal zone is resuming after system sleep */
>   };
>   
>   /**
> 
> 
> 

