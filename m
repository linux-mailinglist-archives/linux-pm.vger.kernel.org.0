Return-Path: <linux-pm+bounces-8898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B71990282F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 20:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB361C21997
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2918E22EEF;
	Mon, 10 Jun 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uoTQSO4Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3C11869
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042497; cv=none; b=PXERxTsQ2c+UzMTNN7HoqrpV7S0sN4ODkFepedEkbesgl0xBnjc6zd8x46bHBtrFVmzpcKL2cbDJvv+Rj/fPZ8fBpYDS9VQcjFCS5X17S/ijf3wVluufj1+NnM5NwCo6TyXDr41GJZoNXMKl15UwTG69ip9upKk/2cnihtTfi+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042497; c=relaxed/simple;
	bh=g2c7nnmBcEtmWKG2cdatzphUu9nwq1gexVv+zu2DXf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brFEhqEcTONU3t2aNC1povPHox91XMr5n/jp8J3Rjmbuzree5XEzp2L/2hcIrkWMGElxHrB6/9HLsDMg8rCxGJ4msQtxuiW9MnG/kegyZwIuVcfE6VExrrljphX1u1QLkQzPeR4w2aCpr9eC9w1okiTNnziXGHK5O4DG2DBi98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uoTQSO4Y; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so272276e87.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718042493; x=1718647293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=goT3FiiTHuDDxuZezrmRBAQweENaqO0vsQeYq6d8HbE=;
        b=uoTQSO4YWzo6jb60hVqRPaIvDykgE6xj3X15sEX5SDM5y7idRfZeGLGMNHjxBtT7CW
         FYe+gEmq5GxDVqpQ1j6bTVKQow7rJTtiTVA8BtafrxlnqBn4GftOPGU/zqEAOhNWfu7I
         +NStxP/R/J0rI5lhd0D3AGWKG3JpYBmzyxmKf5VD6my8Xu1R3EpcF04jxdjGAFw6FoMb
         nwon3kmwnh9bdCVcXI2Cpai6VRkb7WCZsvcc8KW//YK7DCRCD/X7QwDLG1YlGRgtTZoQ
         DHgJ3skQsel6hVsxpCHy5B+dC+OltY3VH4JQSBN0mAVe9QCgL03Ynrib19C1/5UoIXw5
         oFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042493; x=1718647293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goT3FiiTHuDDxuZezrmRBAQweENaqO0vsQeYq6d8HbE=;
        b=kmvVS8/J0sI2/zWKExkQab+pYAcKKGGK89caKGCdhbbr52cm4Cj8QdaqpMVIbpjfa9
         a3H0WfiMK08gnEW3Aa4g6U0kXPBN+SZQHsa5Vrhle8N/SaCnanSDFrEaVxRO4LoNPkFi
         Q0zub3FGp31HxTU4HGwR1qno7MvNFeob24PgIFKwWEQQyx4R2tmt1VzRShX/trsx+KeI
         UFv4MUIeimOKVbRBad8rpuVJGnsT5hquLoyahpNwX9GSklEBiDu8MyHtYZ6hcIJ5qui1
         fewMUHr63aVeq/JPAouIlwsvfCcuWPsY/u4Kxs5KkiiSv6BA1NC8KI0MNMmJQQgzhoNW
         sYxA==
X-Forwarded-Encrypted: i=1; AJvYcCXaUlRtNS7MwVAB0xZ9uBBvrCM0ll7C1U8cKDxw9VjmTdBefPJQeKpc7hiSsjpenhLn5j6XTqrajTG5qsyTuNAdeeuYUXnGJ7w=
X-Gm-Message-State: AOJu0Yz/Wl//P+RNCz5aTUhr5Gu7rECizhwPNKV1mSd1ivzH7PVpmYpF
	PImT1Jx9Ra61W0+fTD7bZ5NdLK3erOYNOFvefM+khdfUzZWuPrSXX3Hsua9RvEQ=
X-Google-Smtp-Source: AGHT+IFN2Eti8+gZyxEE3H8cpoOyZdBagWhMLrVC2RrY9w7xOb7/ljIQhtyFuW95vPKWpx4yq3PeQw==
X-Received: by 2002:a05:6512:282:b0:52c:901f:e4 with SMTP id 2adb3069b0e04-52c901f022amr813795e87.0.1718042493358;
        Mon, 10 Jun 2024 11:01:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa1desm150904605e9.11.2024.06.10.11.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 11:01:32 -0700 (PDT)
Message-ID: <e0a9f173-1abf-4faa-9a2d-b8310e72ef28@linaro.org>
Date: Mon, 10 Jun 2024 20:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] thermal: trip: Make thermal_zone_set_trips() use
 trip thresholds
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12458899.O9o76ZdvQC@kreacher> <2340783.ElGaqSPkdT@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2340783.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 18:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify thermal_zone_set_trips() to use trip thresholds instead of
> computing the low temperature for each trip to avoid deriving both
> the high and low temperature levels from the same trip (which may
> happen if the zone temperature falls into the hysteresis range of
> one trip).
> 
> Accordingly, make __thermal_zone_device_update() call
> thermal_zone_set_trips() later, when threshold values have been
> updated for all trips.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Rebase.
> 
> ---
>   drivers/thermal/thermal_core.c |    4 ++--
>   drivers/thermal/thermal_trip.c |   14 ++++----------
>   2 files changed, 6 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -513,13 +513,13 @@ void __thermal_zone_device_update(struct
>   	if (tz->temperature == THERMAL_TEMP_INVALID)
>   		return;
>   
> -	thermal_zone_set_trips(tz);
> -
>   	tz->notify_event = event;
>   
>   	for_each_trip_desc(tz, td)
>   		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);

Would it make sense to use the for_each_trip_desc() loop here and update
low and high on the fly in this loop ?

If a trip point is crossed the way up or down, then 
handle_thermal_trip() returns a value which in turn results in updating 
low and high. If low and high are changed then the we call 
thermal_zone_set_trips() after the loop.

The results for the thermal_zone_set_trips() will be the loop, the low, 
high, prev_low_trip and prev_high_trip variables going away.

The resulting function should be:

void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int 
high)
{
         int ret;

         lockdep_assert_held(&tz->lock);

         if (!tz->ops.set_trips)
                 return;

         /* 
 

          * Set a temperature window. When this window is left the 
driver 

          * must inform the thermal core via thermal_zone_device_update. 
 

          */
         ret = tz->ops.set_trips(tz, low, high);
         if (ret)
                 dev_err(&tz->device, "Failed to set trips: %d\n", ret);
}

But if you consider that is an additional change, then:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> +	thermal_zone_set_trips(tz);
> +
>   	list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
>   	list_for_each_entry(td, &way_up_list, notify_list_node)
>   		thermal_trip_crossed(tz, &td->trip, governor, true);
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -88,17 +88,11 @@ void thermal_zone_set_trips(struct therm
>   		return;
>   
>   	for_each_trip_desc(tz, td) {
> -		const struct thermal_trip *trip = &td->trip;
> -		int trip_low;
> +		if (td->threshold < tz->temperature && td->threshold > low)
> +			low = td->threshold;
>   
> -		trip_low = trip->temperature - trip->hysteresis;
> -
> -		if (trip_low < tz->temperature && trip_low > low)
> -			low = trip_low;
> -
> -		if (trip->temperature > tz->temperature &&
> -		    trip->temperature < high)
> -			high = trip->temperature;
> +		if (td->threshold > tz->temperature && td->threshold < high)
> +			high = td->threshold;
>   	}
>   
>   	/* No need to change trip points */
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


