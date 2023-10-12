Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34E67C70E8
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379065AbjJLPE3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 11:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjJLPE2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 11:04:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE5FB8
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 08:04:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4066241289bso11672185e9.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697123065; x=1697727865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6/hE83dFOY8xzxiFaTi6nXaEfmM6cCFOZ7/7sFQHGk=;
        b=dV5J+rLf/BUMcDfUmM+7rUAfrOD9LChKnQYKT/tsR0d5OR+3J9UC/k3FVOzkX09Euv
         xO5zRpfRoqAiKH/4yyR39DoqSFVjPmtLy87mSlW/B/IzjY5DOvEcsWiVvKKI1iteMKTX
         2s4gYj3NvTYwg1RVcXq6bORxjgGCu3kFc68gwSYLjGwJAbRHPV9jHx3UfaPOgA8POgRP
         MpMfFcNEjiIhBjq1IJMiK6hkY/BLHkJi4/SgcSJI3vzyeGqvIJUAbwjdTzbfHNE7f1Xa
         CSdorFg/PhZqRFeDBhoOTxoKz8kY0KSe9BDa7jB8jGUdTBMpA/OGmzROxwFPUrsqflyj
         VIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697123065; x=1697727865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6/hE83dFOY8xzxiFaTi6nXaEfmM6cCFOZ7/7sFQHGk=;
        b=j3cZL0sDzLWtugmXODQTWtnEHyJluuuF/dPfC0ntMB00oJWMGAXmlwDJPCpj8uyMdV
         7hrkwLf0W4sGgsJZGWreiVQnz+07Jl1bnKpwlunwlGrX7DVIh9jsNZifGncwMJveFiY1
         g/in1JLNcj1wCQ8+azQx/flwuKfEiq6y3VZLzasf6gthdecZkVD1TifXzeqGEd8Liov+
         oePuqPGYR1W4proBEbiqd2OTnFyT+/f2f2SYuVfLLXCllogipctQ6dFoB1sI2MTR0duB
         6AKW5GKcwSPs1V/p2c7xmwrWgf+H3igW6d7T5+sBW0PjK3Di+xbuU+d2qXPL9cPIHr3x
         xa6w==
X-Gm-Message-State: AOJu0Yx6UsCE/bww/nv+6YM0A2FJhS0BBfN0/3oAnNL2KPX2mpxAvCqV
        2eK98lhGBaWBqfYvocf2s9yaew==
X-Google-Smtp-Source: AGHT+IFJyxI7rdj8mcmCS4wzYOwuGNkd6Yy6Le22kTlKe9nA4+WV6KUocuBsOLidG3+0B/Xr0jhs1w==
X-Received: by 2002:a05:600c:211:b0:405:3dbc:8823 with SMTP id 17-20020a05600c021100b004053dbc8823mr21915774wmi.12.1697123065350;
        Thu, 12 Oct 2023 08:04:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id q19-20020a1cf313000000b0040596352951sm71876wmq.5.2023.10.12.08.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:04:24 -0700 (PDT)
Message-ID: <a9c42b1d-919d-4c77-991d-be113b9cf2a5@linaro.org>
Date:   Thu, 12 Oct 2023 17:04:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] thermal: gov_fair_share: Rearrange
 get_trip_level()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <13365827.uLZWGnKmhe@kreacher> <2244940.iZASKD2KPV@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2244940.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2023 19:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make get_trip_level() use for_each_trip() to iterate over trip points
> and make it call thermal_zone_trip_id() to obtain the integer ID of a
> given trip point so as to avoid relying on the knowledge of struct
> thermal_zone_device internals.
> 
> The general functionality is not expected to be changed.
> 
> This change causes the governor to use trip pointers instead of trip
> indices everywhere except for the fair_share_throttle() second argument
> that will be modified subsequently along with the definition of the
> governor .throttle() callback.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_fair_share.c |   30 ++++++++++++++----------------
>   1 file changed, 14 insertions(+), 16 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_fair_share.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> +++ linux-pm/drivers/thermal/gov_fair_share.c
> @@ -15,29 +15,27 @@
>   
>   #include "thermal_core.h"
>   
> -/**
> - * get_trip_level: - obtains the current trip level for a zone
> - * @tz:		thermal zone device
> - */
>   static int get_trip_level(struct thermal_zone_device *tz)
>   {
> -	struct thermal_trip trip;
> -	int count;
> +	const struct thermal_trip *trip, *level_trip = NULL;
> +	int trip_level;
>   
> -	for (count = 0; count < tz->num_trips; count++) {
> -		__thermal_zone_get_trip(tz, count, &trip);
> -		if (tz->temperature < trip.temperature)
> +	for_each_trip(tz, trip) {
> +		if (level_trip && trip->temperature >= tz->temperature)
>   			break;

Even if very likely the trip points are ordered by the hardware 
enumeration, strictly we don't have yet the guarantee the trips are 
ordered (as that is the final goal to correctly detect thresholds 
crossing with the generic trip). We should go through all the trip 
points, no?

> +		level_trip = trip;
>   	}
>   
> -	/*
> -	 * count > 0 only if temperature is greater than first trip
> -	 * point, in which case, trip_point = count - 1
> -	 */
> -	if (count > 0)
> -		trace_thermal_zone_trip(tz, count - 1, trip.type);
> +	/*  Bail out if the temperature is not greater than any trips. */
> +	if (level_trip->temperature >= tz->temperature)
> +		return 0;

Isn't simpler to remove the test level_trip != NULL in the loop and then 
check here if it is NULL and then return 0.

> +	trip_level = thermal_zone_trip_id(tz, level_trip);
> +
> +	trace_thermal_zone_trip(tz, trip_level, level_trip->type);
>   
> -	return count;
> +	return trip_level;
>   }
>   
>   static long get_target_state(struct thermal_zone_device *tz,
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

