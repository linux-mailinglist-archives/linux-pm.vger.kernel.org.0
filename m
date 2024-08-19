Return-Path: <linux-pm+bounces-12495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F87957598
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 22:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECA2284578
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354C158A30;
	Mon, 19 Aug 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9pm3z2G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4749627;
	Mon, 19 Aug 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099052; cv=none; b=gcQSsQkFhLondlkb2efooBM+yczHEKoWqau8hKBHNc76OppoSNMOVXAM1G16fBDNqVvF8XSQVKlS/ukI77lidrEvln9BiGcaok0y9hwBXzqv94mej04DZu9oGGoAP9dphCpG58T1URa6RJt+8sc3764VDJqH6lQtjgABwqjKdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099052; c=relaxed/simple;
	bh=lJAfsS6Ds7PJvfsXrqipaZ5Mdxiz/mplkKdNmc7L1Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuNs1YHnXRTrOdnubXmIaXi+mZ/VT6VVn0cZP3IY7A8ka2JihPrHAZx0vt4533pmWgdWgFM5cSg5eAbx+KOaW8ce/6qiQd1xSiTKiym2K0K6oy+JzCm84MnG8/iLVEDK2FElOyAwvmIhpXEpdD6N5Pg11/4t02rRhxdrZld1Auk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9pm3z2G; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso37350605e9.0;
        Mon, 19 Aug 2024 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724099049; x=1724703849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVCycw6rNWu2pw2q882mngKNNnr7/8neNXxEraVA4KY=;
        b=e9pm3z2GdpZUeUA4F7qgu/aagx2+EhizwEEnr4bY7Hriqedl8Od+HKUQOoPgcZF62/
         CgCnyUNK0JZm45IWrgMO6y84Cj/e3A4clyrmk+gxx1TL34VnKEpppL2tdINGMq65srjE
         9uTRhMfA8lhPjQZU1P00xQY5o6qg8vXJaXUKfqfoHIGg6X/O2EjrxtNpsHV18pohHXuz
         /LeB/RqlgMsNDA0jv25JlNI71VhjYIdN/7USlC1NNcUFjD/j/eWZSdDQk/nrN9Tq1CbV
         sg4DW1eim8En6FOGheiQhPH6/1Gbx7xfVLt9UmvFwc74k3VDaFVpqv9CdJNAd1Zzd13F
         32GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099049; x=1724703849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVCycw6rNWu2pw2q882mngKNNnr7/8neNXxEraVA4KY=;
        b=KjiBOanfRlLso0+UFeXvh0djylJRg1SUaiXIDYQPEl0Fm3xFVWf2yD/wIZj0lRURB5
         MYbWKU6BFTQr1nNW/tJfxLm2Wq3TAiNBsFZcf6a6XDu/OCXZCXcJu5J0ahTE3XzYi/oq
         tMhHngqGDYCHVRJePBRHIvg24Gb4kYJcvcs/AN6dvbiiP/SmKB5kaDKpc1Vt6JEUE5be
         gaOn+g/34g93POjzsbv2ariRJoMECBZkHPvuvNsdTOug6LJHJC/266PllDZms7JB4Bc9
         IAtZzykEZisVq/Wv1oP9hqI6Ez6OgVeL8MutFj948DAOmh4NTWyHAz4svv/A9UkuM/VT
         mHyg==
X-Forwarded-Encrypted: i=1; AJvYcCU/+ohsLBChq/XtaR7/mkBj87zK3XuUsKkeWX1Ohg0rYEaw7KqofvCCBJkhYnpSWKDfr3s0ztWcWAOnLtyyFqQupqWZUw==@vger.kernel.org, AJvYcCXQfNrlz+8vpjcki2hWgkbaZTF6QRlMMNG0Fo20SaQKbUVJu2Vnd9cM3W3cp3+yxb1cpwgVjALOxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOTLTm+Q53I09CQyoYHI0UYxhdkttouM439u+ErukfNO7yYQk
	LEIGiDtl5HlMHhXOkwhZJdSWbNdFb1aiLX7/Mp1Uje4RUYGVoLhQ
X-Google-Smtp-Source: AGHT+IEifSQEVUjxtxewiggCSeVR5saXlASCFGnXqU4frqD/nSgv4RYjrS7emBwsXb5H4PXapuNAlA==
X-Received: by 2002:a5d:6886:0:b0:371:83ae:808f with SMTP id ffacd0b85a97d-3719429e8bdmr9020902f8f.0.1724099048489;
        Mon, 19 Aug 2024 13:24:08 -0700 (PDT)
Received: from [192.168.1.27] (ip-109-090-180-058.um36.pools.vodafone-ip.de. [109.90.180.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897029sm11315468f8f.74.2024.08.19.13.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:24:07 -0700 (PDT)
Message-ID: <52ae162a-96e3-4b7f-ace6-c4d1bb2dc004@gmail.com>
Date: Mon, 19 Aug 2024 22:24:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] platform/x86: acerhdf: Use the .should_bind()
 thermal zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba
 <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Peter Kaestle <peter@piie.net>,
 platform-driver-x86@vger.kernel.org
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3779411.MHq7AAxBmi@rjwysocki.net>
Content-Language: en-US
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <xypiie@gmail.com>
In-Reply-To: <3779411.MHq7AAxBmi@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.08.24 18:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the acerhdf driver use the .should_bind() thermal zone
> callback to provide the thermal core with the information on whether or
> not to bind the given cooling device to the given trip point in the
> given thermal zone.  If it returns 'true', the thermal core will bind
> the cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> The previously existing acerhdf_bind() function bound cooling devices
> to thermal trip point 0 only, so the new callback needs to return 'true'
> for trip point 0.  However, it is straightforward to observe that trip
> point 0 is an active trip point and the only other trip point in the
> driver's thermal zone is a critical one, so it is sufficient to return
> 'true' from that callback if the type of the given trip point is
> THERMAL_TRIP_ACTIVE.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Tested-by: Peter Kästle <peter@piie.net>

> ---
> 
> v2 -> v3: Reorder (previously [12/17]) and add the ACK from Hans
> 
> v1 -> v2: No changes
> 
> This patch only depends on the [06/14] introducing the .should_bind()
> thermal zone callback:
> 
> https://lore.kernel.org/linux-pm/9334403.CDJkKcVGEf@rjwysocki.net/
> 
> ---
>   drivers/platform/x86/acerhdf.c |   33 ++++++---------------------------
>   1 file changed, 6 insertions(+), 27 deletions(-)
> 
> Index: linux-pm/drivers/platform/x86/acerhdf.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/acerhdf.c
> +++ linux-pm/drivers/platform/x86/acerhdf.c
> @@ -378,33 +378,13 @@ static int acerhdf_get_ec_temp(struct th
>   	return 0;
>   }
>   
> -static int acerhdf_bind(struct thermal_zone_device *thermal,
> -			struct thermal_cooling_device *cdev)
> +static bool acerhdf_should_bind(struct thermal_zone_device *thermal,
> +				const struct thermal_trip *trip,
> +				struct thermal_cooling_device *cdev,
> +				struct cooling_spec *c)
>   {
>   	/* if the cooling device is the one from acerhdf bind it */
> -	if (cdev != cl_dev)
> -		return 0;
> -
> -	if (thermal_zone_bind_cooling_device(thermal, 0, cdev,
> -			THERMAL_NO_LIMIT, THERMAL_NO_LIMIT,
> -			THERMAL_WEIGHT_DEFAULT)) {
> -		pr_err("error binding cooling dev\n");
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -static int acerhdf_unbind(struct thermal_zone_device *thermal,
> -			  struct thermal_cooling_device *cdev)
> -{
> -	if (cdev != cl_dev)
> -		return 0;
> -
> -	if (thermal_zone_unbind_cooling_device(thermal, 0, cdev)) {
> -		pr_err("error unbinding cooling dev\n");
> -		return -EINVAL;
> -	}
> -	return 0;
> +	return cdev == cl_dev && trip->type == THERMAL_TRIP_ACTIVE;
>   }
>   
>   static inline void acerhdf_revert_to_bios_mode(void)
> @@ -447,8 +427,7 @@ static int acerhdf_get_crit_temp(struct
>   
>   /* bind callback functions to thermalzone */
>   static struct thermal_zone_device_ops acerhdf_dev_ops = {
> -	.bind = acerhdf_bind,
> -	.unbind = acerhdf_unbind,
> +	.should_bind = acerhdf_should_bind,
>   	.get_temp = acerhdf_get_ec_temp,
>   	.change_mode = acerhdf_change_mode,
>   	.get_crit_temp = acerhdf_get_crit_temp,
> 
> 
> 

