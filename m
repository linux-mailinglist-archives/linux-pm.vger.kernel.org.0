Return-Path: <linux-pm+bounces-6945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528378AF52B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 19:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E43B2395E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A66913D8AA;
	Tue, 23 Apr 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="masjQu1D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7313C81E
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892479; cv=none; b=SL3AER4/iKloJCtKgAqYD906bQcmh0BuRf0dT6KG+111ej/7QVkvNItWHpY7Q8FZsRNIlyzdjbuok9oCCg+tIAucWoqCtVBJCmKpRhgEhRsh/i05Q3gfML4/LpPaDKjmj5Me0Ti+jKFK+V+VohYG6q0PeSgWhXbIb35c3WfeBUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892479; c=relaxed/simple;
	bh=VRmtG60B9osHPcKQSkyonwMiZpIwzyD1CMhJXOH1ZdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsfPla/gPJ1EmNOX/7cNNM6oHKgNX/Ywc2NVDkMJ7xvrqxXfetxqgzVyBQdEbSMYUXdJbgQ4+xR3qFr2Dt1S1V1qM7QIEvp7qc3x2BoonsGo8n3VmuK5ki6hI6LNZ4LAEJ2nX6JXaxRyye2N4/Qkwj6rd5BU8ExbKHGrYAIw1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=masjQu1D; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41adf552d74so3330655e9.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713892476; x=1714497276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yU9NG4PfeuqFBF1xqG8aCzFROrrhlwwa+QCtFZyoVE=;
        b=masjQu1D+mFuYGZN8W6e5IfNjDBJqy+gQz6+M6vlhc1DsouIpjp4xwhrhydjKJ3Jfd
         qdOGRCQ4/rR80rYvjynjRhwwDRNgmBIo9p5n+TcAqAJaXWIfeOJu5D+pduja7Qis2JCm
         wD16LVkk1Q+IWbaPpVy7ZRDoCIJ04H8fps8RgW6RDaPBW4pck17L1xsLx9eoCE4vGVAx
         +Z0nzqd9XbMxbzSEpTrk/YRv5+3bX09GWYAaUJlphw9URnNo6fP5nfdJTl5gi/fKTnrG
         0O/fXcFKXp4bkx5nPB1SJBAT/Rc5Ar1OzDvrn2IH3e94KNub/2pMex1hkXxOYLoL1PfO
         Mp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713892476; x=1714497276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yU9NG4PfeuqFBF1xqG8aCzFROrrhlwwa+QCtFZyoVE=;
        b=MzuO+x2+/M+TAVVUOpWAOOnvv+kTWih1kpgSOPoIeEP9fquYIR9NxQ+x5qeMd5xUOX
         jIki+aK2W3PqxbY7iTiMbZrDKSFVYUpae20zxDB64YKzYLLvwmO8JMpRVpp7EK2k5ZEX
         kI97zyn499QBtrQfDKxRf9L22HvqcNhhZXT8DcKYUDra0Gq0cpOEzIE8RTFDbLGZWSZI
         LMG0cqfuZsjORXKxLspy1xt+NdDlGCplH2uOcOJJzxi39kgiId3wy3cMAoKX3esbsD2s
         ZwH7+mxMh3glpmAsm2o6pqvqqzglryq1uRqQ/iyhlr9fpw3VVAlBvw2646Jy96JivPT8
         n7ag==
X-Forwarded-Encrypted: i=1; AJvYcCW1BFcccwzoCRtX/8WxFG7qbFEUOoOMBFY/15EsgPlMCPQZA0Lvw6wf9KHIOqpidauFuMzlMc3dcLEM9n02D+xKydOhdrqADCE=
X-Gm-Message-State: AOJu0YwONAk3tHdZJQCQkJLKHkXTTvnwmowsvOwwWQY1+2qf4ii19X3l
	olIvWnoG2cfJ5MHkjX8cYepVlXwwUINMew3SiP3CV2xa5HYHR/YOIVzpb/wop3c=
X-Google-Smtp-Source: AGHT+IGf909/0S9B4wGBkeGPPH5/DwwQ7oOO0hisRrYCa2a3mCRb/ynX7PbUWKDCAx5yXconTy2RHA==
X-Received: by 2002:a05:600c:4f49:b0:418:7401:b15f with SMTP id m9-20020a05600c4f4900b004187401b15fmr10168037wmq.38.1713892475838;
        Tue, 23 Apr 2024 10:14:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u18-20020a05600c19d200b0041896d2a05fsm20653037wmq.5.2024.04.23.10.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:14:35 -0700 (PDT)
Message-ID: <9f45fd2d-f1de-437f-ae8a-75ad51a5c061@linaro.org>
Date: Tue, 23 Apr 2024 19:14:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/16] thermal: core: Introduce .trip_crossed()
 callback for thermal governors
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2009494.usQuhbGJ8B@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2009494.usQuhbGJ8B@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:10, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce a new thermal governor callback called .trip_crossed()
> that will be invoked whenever a trip point is crossed by the zone
> temperature, either on the way up or on the way down.
> 
> The trip crossing direction information will be passed to it and if
> multiple trips are crossed in the same direction during one thermal zone
> update, the new callback will be invoked for them in temperature order,
> either ascending or descending, depending on the trip crossing
> direction.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   19 +++++++++++++++++--
>   drivers/thermal/thermal_core.h |    4 ++++
>   2 files changed, 21 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -302,11 +302,21 @@ static void monitor_thermal_zone(struct
>   		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>   }
>   
> +static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
> +{
> +	if (tz->governor)
> +		return tz->governor;
> +
> +	return def_governor;
> +}
> +
>   static void handle_non_critical_trips(struct thermal_zone_device *tz,
>   				      const struct thermal_trip *trip)
>   {
> -	tz->governor ? tz->governor->throttle(tz, trip) :
> -		       def_governor->throttle(tz, trip);
> +	struct thermal_governor *governor = thermal_get_tz_governor(tz);
> +
> +	if (governor->throttle)
> +		governor->throttle(tz, trip);
>   }
>   
>   void thermal_governor_update_tz(struct thermal_zone_device *tz,
> @@ -470,6 +480,7 @@ static int thermal_trip_notify_cmp(void
>   void __thermal_zone_device_update(struct thermal_zone_device *tz,
>   				  enum thermal_notify_event event)
>   {
> +	struct thermal_governor *governor = thermal_get_tz_governor(tz);
>   	struct thermal_trip_desc *td;
>   	LIST_HEAD(way_down_list);
>   	LIST_HEAD(way_up_list);
> @@ -493,12 +504,16 @@ void __thermal_zone_device_update(struct
>   	list_for_each_entry(td, &way_up_list, notify_list_node) {
>   		thermal_notify_tz_trip_up(tz, &td->trip);
>   		thermal_debug_tz_trip_up(tz, &td->trip);
> +		if (governor->trip_crossed)
> +			governor->trip_crossed(tz, &td->trip, true);

Is it possible to wrap this into a function ? So we keep the calls at 
the same level in this block

>   	}
>   
>   	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
>   	list_for_each_entry(td, &way_down_list, notify_list_node) {
>   		thermal_notify_tz_trip_down(tz, &td->trip);
>   		thermal_debug_tz_trip_down(tz, &td->trip);
> +		if (governor->trip_crossed)
> +			governor->trip_crossed(tz, &td->trip, false);

idem

>   	}
>   
>   	monitor_thermal_zone(tz);
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -30,6 +30,7 @@ struct thermal_trip_desc {
>    *		otherwise it fails.
>    * @unbind_from_tz:	callback called when a governor is unbound from a
>    *			thermal zone.
> + * @trip_crossed:	called for trip points that have just been crossed
>    * @throttle:	callback called for every trip point even if temperature is
>    *		below the trip point temperature
>    * @update_tz:	callback called when thermal zone internals have changed, e.g.
> @@ -40,6 +41,9 @@ struct thermal_governor {
>   	const char *name;
>   	int (*bind_to_tz)(struct thermal_zone_device *tz);
>   	void (*unbind_from_tz)(struct thermal_zone_device *tz);
> +	void (*trip_crossed)(struct thermal_zone_device *tz,
> +			     const struct thermal_trip *trip,
> +			     bool crossed_up);
>   	int (*throttle)(struct thermal_zone_device *tz,
>   			const struct thermal_trip *trip);
>   	void (*update_tz)(struct thermal_zone_device *tz,
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


