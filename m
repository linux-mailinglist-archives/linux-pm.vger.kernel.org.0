Return-Path: <linux-pm+bounces-12639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F151A959E8A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 15:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7721A1F212D8
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C019343E;
	Wed, 21 Aug 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdyMEPVR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6B18991D
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246471; cv=none; b=VEXZa5p2WdZC1lOV5LujsuOmRp7lBMHzuhDGj7dedBZtO9+Ho3ixfHITocJIqyVM9DDSWw43YnjfYd8lRLsMsLGThbDIj0txEJckdBvSyba1b7A6kB2JrljG00gcLaFbNAuyJTipN1S3K8J1nzvmCfZcDFBwVL8jxD9CORv7qSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246471; c=relaxed/simple;
	bh=N6b7TQ0w/aT1sCExNMeqF5cN4Hv52VbM+wz9fQBbo38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9HlVfYgkZvCBrriUy3kx2UfDAKr1lOqLHwR67Qzt8KMiOfV8E68Tf/OluwCLB4o/F01ByklziZhg7ziVnEYI0KwWxP0ddXAhrS3TpIgmJddNgoiRtjLTb+HFE0zZNUvklEUVogrxOCF7CNdef+VYusvUA33vx+KKw0U/zx52Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fdyMEPVR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281c164408so53369115e9.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724246468; x=1724851268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjyLUefD2WrDlcw4PaVFaBQU3Rva89tZ1mWX6pN2sHY=;
        b=fdyMEPVRzGJUNTF7YZcrhod/xtfsO+pXnzVsRAEdGsZ8stJXjuCAq2quJ+s9tDmF2u
         a6/iZHCm36zCneHVR5538dHz2prqEcQpg4lnl/bnprAekB5o9U0oBd5bIzQNgOM6AcrH
         6wUlz7WQa381NNZJXZWIB7gYvSmN/e7ma0xGVBknrZnXYt0wwvuhdS/FgNeTn5zJQ2kH
         DyFUF10Vll0V9zomEpXkN+tHUNCLGn+aZDZOheMyUebajRXHEF+8x2RaOLAdFK8MKYdz
         2+bEdQXxS00NfoeH9n6dDOr0QFhtaxxqmtow1tqOyqVGIFznXTMuXisCnS/Odab+bHKS
         b5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246468; x=1724851268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjyLUefD2WrDlcw4PaVFaBQU3Rva89tZ1mWX6pN2sHY=;
        b=LpU4WQO2wyY4enulPsWORHGaxaTtfzYV8sEiTUqEug1Me6OT0MgM+hgbz91kGYOrUW
         o7/fYxYfslq+dUtI4TUuJVlrzT4Loked2RVHjFBvaXgRk2oC5ApvXSKlArIyLR3ozZdD
         RDoczOErFixM8EZamxkNAl0yamFeITVAWV+8liCzCcPTc+IBQ0rz6da7yO42xFua67GY
         Mjo3/s7Y06ym40eSNX7umvneDmctBTHv8c4RjBmTTFiKmQjcKTmOA4EY6xV00tc6UNeU
         MItG2BTARW4VRazq1oEuaDPhtzbE1p0GzXn6iamZtP986YMrKbFInHzUIAAuLghtGJMK
         q+xA==
X-Forwarded-Encrypted: i=1; AJvYcCVD+xu3EukSt576FGTjNPOSzUH7uPztr+xpq+g2dRJNgQ60240+0eloEUPAYwX0W6EiUthfDIJb+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcQsdowSnfcvnm3xh/MUCVjLD10uqVNwzx3seXPMYRsiSyUSmu
	X95xuzXFfVHn+zZGveDiM9q0ATlK9SCIJQOrlQm0tbiQJ5e68/w7cEJyaRBUWrQ=
X-Google-Smtp-Source: AGHT+IGQs7VwLeC6YrkdKVPxQTpgywPJ0CfxAx7rT0X9k5hlN34LlzpZautcSNHM5vWLEE/aMz8eew==
X-Received: by 2002:a05:6000:1fa9:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-372fd6d6dfbmr1832180f8f.17.1724246467284;
        Wed, 21 Aug 2024 06:21:07 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-371898972a8sm15757828f8f.86.2024.08.21.06.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:21:06 -0700 (PDT)
Message-ID: <19beefd9-d3f9-4d43-a45d-d241996de2d0@linaro.org>
Date: Wed, 21 Aug 2024 15:21:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] thermal: core: Introduce .should_bind() thermal
 zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <9334403.CDJkKcVGEf@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9334403.CDJkKcVGEf@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current design of the code binding cooling devices to trip points in
> thermal zones is convoluted and hard to follow.
> 
> Namely, a driver that registers a thermal zone can provide .bind()
> and .unbind() operations for it, which are required to call either
> thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip(),
> respectively, or thermal_zone_bind_cooling_device() and
> thermal_zone_unbind_cooling_device(), respectively, for every relevant
> trip point and the given cooling device.  Moreover, if .bind() is
> provided and .unbind() is not, the cleanup necessary during the removal
> of a thermal zone or a cooling device may not be carried out.
> 
> In other words, the core relies on the thermal zone owners to do the
> right thing, which is error prone and far from obvious, even though all
> of that is not really necessary.  Specifically, if the core could ask
> the thermal zone owner, through a special thermal zone callback, whether
> or not a given cooling device should be bound to a given trip point in
> the given thermal zone, it might as well carry out all of the binding
> and unbinding by itself.  In particular, the unbinding can be done
> automatically without involving the thermal zone owner at all because
> all of the thermal instances associated with a thermal zone or cooling
> device going away must be deleted regardless.
> 
> Accordingly, introduce a new thermal zone operation, .should_bind(),
> that can be invoked by the thermal core for a given thermal zone,
> trip point and cooling device combination in order to check whether
> or not the cooling device should be bound to the trip point at hand.
> It takes an additional cooling_spec argument allowing the thermal
> zone owner to specify the highest and lowest cooling states of the
> cooling device and its weight for the given trip point binding.
> 
> Make the thermal core use this operation, if present, in the absence of
> .bind() and .unbind().  Note that .should_bind() will be called under
> the thermal zone lock.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v3: No changes (previously [08/17])
> 
> ---
>   drivers/thermal/thermal_core.c |  106 +++++++++++++++++++++++++++++++----------
>   include/linux/thermal.h        |   10 +++
>   2 files changed, 92 insertions(+), 24 deletions(-)
> 
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -85,11 +85,21 @@ struct thermal_trip {
>   
>   struct thermal_zone_device;
>   
> +struct cooling_spec {
> +	unsigned long upper;	/* Highest cooling state  */
> +	unsigned long lower;	/* Lowest cooling state  */
> +	unsigned int weight;	/* Cooling device weight */
> +};
> +
>   struct thermal_zone_device_ops {
>   	int (*bind) (struct thermal_zone_device *,
>   		     struct thermal_cooling_device *);
>   	int (*unbind) (struct thermal_zone_device *,
>   		       struct thermal_cooling_device *);
> +	bool (*should_bind) (struct thermal_zone_device *,
> +			     const struct thermal_trip *,
> +			     struct thermal_cooling_device *,
> +			     struct cooling_spec *);
>   	int (*get_temp) (struct thermal_zone_device *, int *);
>   	int (*set_trips) (struct thermal_zone_device *, int, int);
>   	int (*change_mode) (struct thermal_zone_device *,
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -991,12 +991,61 @@ static struct class *thermal_class;
>   
>   static inline
>   void print_bind_err_msg(struct thermal_zone_device *tz,
> +			const struct thermal_trip *trip,
>   			struct thermal_cooling_device *cdev, int ret)
>   {
> +	if (trip) {
> +		dev_err(&tz->device, "binding cdev %s to trip %d failed: %d\n",
> +			cdev->type, thermal_zone_trip_id(tz, trip), ret);
> +		return;
> +	}
> +
>   	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
>   		tz->type, cdev->type, ret);
>   }
>   
> +static void thermal_zone_cdev_binding(struct thermal_zone_device *tz,
> +				      struct thermal_cooling_device *cdev)

nit picking: is there a reason to use 'binding' instead of 'bind' ?

IMO it would appear more consistent to keep the same wording than the 
ops. The present participle is usually used to describe an action which 
is happening, usually to report back an event. Here it is more an action 
to be done (feel free to send a separate patch for the renaming).

Other than that

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

