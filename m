Return-Path: <linux-pm+bounces-12187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F6950FD9
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 00:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B071C21253
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 22:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E417B515;
	Tue, 13 Aug 2024 22:50:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from sxb1plsmtpa01-06.prod.sxb1.secureserver.net (sxb1plsmtpa01-06.prod.sxb1.secureserver.net [188.121.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD936B11
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589418; cv=none; b=Gnuy/ialALM7pdCRAl84Hx9whKP67O7TDpRPkt4aTFET8MfcKTc7yU/z5LOEHLJKAGjtTSzz/GRkZj0OQ2GelF8HP3K53aX2B1v3qj0CKobsy3a1ZvNzrfd263MBSs0c6NUe0PKIvEp4XvD6dALAgVuABvab4XEdgTeYqMD1C24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589418; c=relaxed/simple;
	bh=ADG7AH3HN31VssqW1Hewadr6tVB7m/orTsrpRP0ma6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvWgLlQoWPV1o7dGlxctNG/UJga+6xHUouexN57D7SkypVVJBm8coGL1E8VCxPAbtc3KoRSIz1vXk2qLtIJ4IQolH1wNiu87tdMph327Vk/Ldf6p9hN2ef2kHJk/LCSdzq+kqOGggF603vdlJcbMM0DieKRwQT1LlNPD9/Oc2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net; spf=pass smtp.mailfrom=piie.net; arc=none smtp.client-ip=188.121.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piie.net
Received: from [192.168.1.27] ([109.90.180.58])
	by :SMTPAUTH: with ESMTPSA
	id dykEs5O0xTMVOdykHs3cz1; Tue, 13 Aug 2024 14:07:57 -0700
X-CMAE-Analysis: v=2.4 cv=NLMe+F6g c=1 sm=1 tr=0 ts=66bbcb2e
 a=ujCVow8R4Y5jPCx6COW8WA==:117 a=ujCVow8R4Y5jPCx6COW8WA==:17
 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=t3YNmgBSAAAA:8 a=_AnaibG7rSRyTGc1P44A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=ctH_qozkpUrkr3SVbfwb:22
X-SECURESERVER-ACCT: peter@piie.net
Message-ID: <291044b7-7300-42c2-91e6-fef164482cf3@piie.net>
Date: Tue, 13 Aug 2024 23:07:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] thermal: gov_bang_bang: Add .manage() callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
 <8419356.T7Z3S40VBb@rjwysocki.net>
Content-Language: en-US
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
In-Reply-To: <8419356.T7Z3S40VBb@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFgj87bxNoFCN/OgepJh3I/BU6nwBryiNondlgXH4qzKEU8qtJ85d09w0g1zBMFW6HN82SpEu/k8ajo+yGo5SDca3t4KYQetco/LA/JoGd7PX1ogiCOh
 N/28KtQ/9imJusOcVtrURIsVgkLSUvf1YiQTLFhrWABzqzhX6rPf7g9NZVv3IHyDklpeY0kWDIy8uBLXH8LGXJLMIogmaxtPQoyAryB1IfBQDmmqq3Hcb1LH
 +3sc1+IOms4OtgYUKN0XIWGYkKxlkdt+FZnhje4r+Cs0HalVaGtZ/4ZT7Yj3FO7Jerd1Bi2ZPG7E1jDH9iniUwhOVAXnpzcpZyM/Uwh8yeuN0pLn2fQ50EiR
 w86h8R7vhR7fjcGjLFsiIIKxc24ZGw==

On 13.08.24 16:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent changes, the Bang-bang governor may not adjust the
> initial configuration of cooling devices to the actual situation.
> 
> Namely, if a cooling device bound to a certain trip point starts in
> the "on" state and the thermal zone temperature is below the threshold
> of that trip point, the trip point may never be crossed on the way up
> in which case the state of the cooling device will never be adjusted
> because the thermal core will never invoke the governor's
> .trip_crossed() callback.  [Note that there is no issue if the zone
> temperature is at the trip threshold or above it to start with because
> .trip_crossed() will be invoked then to indicate the start of thermal
> mitigation for the given trip.]
> 
> To address this, add a .manage() callback to the Bang-bang governor
> and use it to ensure that all of the thermal instances managed by the
> governor have been initialized properly and the states of all of the
> cooling devices involved have been adjusted to the current zone
> temperature as appropriate.
> 
> Fixes: 530c932bdf75 ("thermal: gov_bang_bang: Use .trip_crossed() instead of .throttle()")
> Link: https://lore.kernel.org/linux-pm/1bfbbae5-42b0-4c7d-9544-e98855715294@piie.net/
> Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

oops, previously sent from wrong email address, here again from correct one...
Acked-by: Peter Kästle <peter@piie.net>

> ---
>   drivers/thermal/gov_bang_bang.c |   30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -26,6 +26,7 @@ static void bang_bang_set_instance_targe
>   	 * when the trip is crossed on the way down.
>   	 */
>   	instance->target = target;
> +	instance->initialized = true;
>   
>   	dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
>   
> @@ -80,8 +81,37 @@ static void bang_bang_control(struct the
>   	}
>   }
>   
> +static void bang_bang_manage(struct thermal_zone_device *tz)
> +{
> +	const struct thermal_trip_desc *td;
> +	struct thermal_instance *instance;
> +
> +	for_each_trip_desc(tz, td) {
> +		const struct thermal_trip *trip = &td->trip;
> +
> +		if (tz->temperature >= td->threshold ||
> +		    trip->temperature == THERMAL_TEMP_INVALID ||
> +		    trip->type == THERMAL_TRIP_CRITICAL ||
> +		    trip->type == THERMAL_TRIP_HOT)
> +			continue;
> +
> +		/*
> +		 * If the initial cooling device state is "on", but the zone
> +		 * temperature is not above the trip point, the core will not
> +		 * call bang_bang_control() until the zone temperature reaches
> +		 * the trip point temperature which may be never.  In those
> +		 * cases, set the initial state of the cooling device to 0.
> +		 */
> +		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +			if (!instance->initialized && instance->trip == trip)
> +				bang_bang_set_instance_target(instance, 0);
> +		}
> +	}
> +}
> +
>   static struct thermal_governor thermal_gov_bang_bang = {
>   	.name		= "bang_bang",
>   	.trip_crossed	= bang_bang_control,
> +	.manage		= bang_bang_manage,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
> 
> 
> 

