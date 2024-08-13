Return-Path: <linux-pm+bounces-12182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F5950E4B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 23:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC52284609
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219D31A4F21;
	Tue, 13 Aug 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa7Wepjf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482E4F881;
	Tue, 13 Aug 2024 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583048; cv=none; b=MU6Vbp0/4dUnljt9Ck7/KR952mNERozx8rjMN3PPdwrtqj9X3r9Oz2SJVKuG8RAWBHRz5wN3OxW7EOxENRJ+h8dEdl8JNANtI3AISJNxZr/18mMrR0/xpZOByKC/H0do9ZKv6Ve53KMEDsewAC1fO/Dc2f1UCTPPVeve2gwt1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583048; c=relaxed/simple;
	bh=BeZ4zeDsDD4qaxCTYVtGeUUUAP2EXQz+4t0sERKRuYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lg7WriG2AeHSVVhYzpCeZ4ZIOxs4FxUZGswDJl7L5dzjdR1scqwrXD55NSqQGL++lXfu64R+0rSgwSmY6tM/0BxZz7KSWfl6bctxqfLE8yxEalgV/GIiN1ZkV5VYCk2GdMg5i3mNz6F+htCF18xwqgep0fJVnxpatIDVTYoXk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa7Wepjf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37172a83a4bso504031f8f.0;
        Tue, 13 Aug 2024 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723583045; x=1724187845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pq4vwAWzw7NDYGM/OYhrRF0z/C++6CZtjYnOgaxGwpQ=;
        b=Fa7WepjfmEIV4WkT8ZAOkglbVprsfGBjuaSJeaZjkQiyp4QpckOei7BKCOSFiaFB2w
         o/VnTCg/hqlFpdV+bAvS28PzlJaNTD8XBaw/Zh/x+I14GiFiXfbVmvkj9x6ebka66eBb
         Dxq7RvFKQuazT4skJAe99d8ZkpbDVtU9lSvHfVNzGQ5sLsHsQ5aVNDJzXiH/kF2uMq/T
         zm0LnhVUHX9nPl6JUZ4dx62tcPcs23QcGRjaXoxzZHwIolJn8pU2qL6tBRUhqVxyi47O
         hGRTPqVjRNRrCsMPqbY2PdUbAT7EObQld+m/CHJGvOoIcaqQ/r5NliqofJX0T5YVfma6
         dNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723583045; x=1724187845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq4vwAWzw7NDYGM/OYhrRF0z/C++6CZtjYnOgaxGwpQ=;
        b=K5yUcDBdIQcXxT/s8Qre6VLbFXdodPcJ+oaC9qykA2hJYpbClbhLiK3lmcj+g/O1de
         tg9qZiJ7AAsa96tQqfQS052T0GKsCuxExUyDcNA0MvjAvuRfMlqzU71WW3iNsE2IGUbB
         wiTI8bdcnWeujU3i/T5ymiK0atdny4JOsAtfZA3f0X3wUPFPIceusA0Sc+9kmmlPjNZG
         sdrUVNfe+8FwDe/tVG5OrQSrAJJNmTcTge3NKpzmTkSN14pT5wsxCvfxGMl3NVGe2K7F
         DXc6xK8QgGpetLUbFS+TmXeceiakt8NRw6bkT5A05NYtsmXO51qel0YDeYvg2bi4iyKZ
         p+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoHPcbEamNMnpsimFjG5vOloNlDEMqAXCYtpGLV1dfqUKoudAthK6UmSrc1IevEAJ5L1O42GAwIDB9R61wi7ci2IC7szJ6jvA=
X-Gm-Message-State: AOJu0Ywoozc+W/96toAup4NmiKtNQOmbSlK3oXqBY+TcLbDouV6T/iyc
	+akrUjdplEId9VJ60g62VqgHPvzRVTZ8BbvvsCAz7ZryrsGETGD0
X-Google-Smtp-Source: AGHT+IEUQOcuI/Ms63cwuOEwGUlBHyTaNvR7Aaywh2Q/WEM9aZnSfw0Ww6YCeNpu4MgLW5qsV2v1QQ==
X-Received: by 2002:a5d:6644:0:b0:368:7422:d966 with SMTP id ffacd0b85a97d-3717779efd1mr457800f8f.33.1723583044151;
        Tue, 13 Aug 2024 14:04:04 -0700 (PDT)
Received: from [192.168.1.27] (ip-109-090-180-058.um36.pools.vodafone-ip.de. [109.90.180.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36bb07sm11415651f8f.5.2024.08.13.14.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 14:04:03 -0700 (PDT)
Message-ID: <e03ddc4e-b209-4cfc-bf98-625d03340550@gmail.com>
Date: Tue, 13 Aug 2024 23:04:01 +0200
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
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <xypiie@gmail.com>
In-Reply-To: <8419356.T7Z3S40VBb@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

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

