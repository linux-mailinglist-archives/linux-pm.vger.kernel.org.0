Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF228D276
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 18:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgJMQmC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 12:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgJMQmC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 12:42:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53C2C0613D2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 09:42:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a72so263479wme.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HxknSNlLxQ0Cf80NE6o+Ttu+GCbA3nVGJK2vG3/NUKo=;
        b=a3j0tAokZ9mEnR7d5NcNPAeHTZdxsywUAv+GDtF/6D2VQNPmwgGO+y/OvBjKJyW5nC
         UvMTKLO9BdyyZRQc+Borz/6O+2xK2uQOWqwaHnudha/dDDrtypB2vC0+nz98URFHXIo5
         M4eeE5/tFeBn6DFmxOmuJP7YCCCHjSUGOAXfWgLYiQbc56FbpfWK/7Etegj2bAeZDX/r
         9/DssQkkw05nYdub/lIIU4bSNwQstlPdTobDwAbugl3KqmvdICZA0LuFXIShBeVBrH+g
         L3/fJY6GnPVmkDJeWnhPDkw4l58M2mwvwPplu1U3+/49LN8gsWoXjkbzHZ8aI6xV4l1p
         G2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HxknSNlLxQ0Cf80NE6o+Ttu+GCbA3nVGJK2vG3/NUKo=;
        b=mkP3/JQ0EUv+2Uhouom241z3ahEiVSdNGyYs0wk6mPA7dW1cxTTmxsee/5JahdPnsv
         9+rxCWX8VmFXjYTC14xgIiwe1nMZ5NAziuWxWHUilCOcnHxsCTzc4HiNZLVcR+9s0OFW
         Is231hK0oM6UnsHKnRRd6f9MLSXPmLV9MJX8umbzgpK39X+oCzejHd1PrcE5VPv2XURi
         luTi5PWHI0hpsg96gWTxUvpV2xPRUxo+Df/ykVsOpwaBWo6JjefR4Sisj6tF1qMMg14/
         fDnlLLcTxpI3mOcg2xgaWaO3lSr3ON+oCyL86/30SQ3saJdJj1Ewzn0henvujQ9ZztxO
         eHwA==
X-Gm-Message-State: AOAM5315qEbfj7vrRDeRBCzRdeSyLVXnT0eUFLCmNgiyJEQGOYrvyzso
        qfszfpWbdDRlo6VHvy9pgEcK7A==
X-Google-Smtp-Source: ABdhPJz1AJdUEHwlqCKQu2VFzETBR0RcF0aJeL7zzmLl2h/a1dNVOx9E1CfgefURzLm8NFfys9mIrQ==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr737320wma.150.1602607320088;
        Tue, 13 Oct 2020 09:42:00 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f? ([2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f])
        by smtp.googlemail.com with ESMTPSA id o3sm199694wru.15.2020.10.13.09.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 09:41:59 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] thermal: power allocator: change how estimation
 code is called
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, Dietmar.Eggemann@arm.com, ionela.voinescu@arm.com
References: <20201009135850.14727-1-lukasz.luba@arm.com>
 <20201009135850.14727-3-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <371617d1-fb1c-8e7b-0a50-e3ea07a1f825@linaro.org>
Date:   Tue, 13 Oct 2020 18:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009135850.14727-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/10/2020 15:58, Lukasz Luba wrote:
> The sustainable power value might come from the Device Tree or can be
> estimated in run time. There is no need to estimate every time when the
> governor is called and temperature is high. Instead, store the estimated
> value and make it available via standard sysfs interface so it can be
> checked from the user-space. Re-invoke the estimation only in case the
> sustainable power was set to 0. Apart from that the PID coefficients
> are not going to be force updated thus can better handle sysfs settings.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

[ ... ]

> -static void estimate_pid_constants(struct thermal_zone_device *tz,
> -				   u32 sustainable_power, int trip_switch_on,
> -				   int control_temp, bool force)
> +static void estimate_tzp_constants(struct thermal_zone_device *tz,
> +				   int trip_switch_on, int control_temp)
>  {
> -	int ret;
> -	int switch_on_temp;
>  	u32 temperature_threshold;
> +	int switch_on_temp;
> +	bool force = false;
> +	int ret;
>  	s32 k_i;
>  
> +	if (!tz->tzp->sustainable_power) {
> +		tz->tzp->sustainable_power = estimate_sustainable_power(tz);
> +		force = true;
> +		dev_info(&tz->device, "power_allocator: estimating sust. power and PID constants\n");
> +	}
> +
>  	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
>  	if (ret)
>  		switch_on_temp = 0;
>  
>  	temperature_threshold = control_temp - switch_on_temp;
>  	/*
> -	 * estimate_pid_constants() tries to find appropriate default
> +	 * estimate_tzp_constants() tries to find appropriate default
>  	 * values for thermal zones that don't provide them. If a
>  	 * system integrator has configured a thermal zone with two
>  	 * passive trip points at the same temperature, that person
> @@ -151,11 +151,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  		return;
>  
>  	if (!tz->tzp->k_po || force)
> -		tz->tzp->k_po = int_to_frac(sustainable_power) /
> +		tz->tzp->k_po = int_to_frac(tz->tzp->sustainable_power) /
>  			temperature_threshold;
>  
>  	if (!tz->tzp->k_pu || force)
> -		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
> +		tz->tzp->k_pu = int_to_frac(2 * tz->tzp->sustainable_power) /
>  			temperature_threshold;
>  
>  	if (!tz->tzp->k_i || force) {
> @@ -193,19 +193,13 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>  {
>  	s64 p, i, d, power_range;
>  	s32 err, max_power_frac;
> -	u32 sustainable_power;
>  	struct power_allocator_params *params = tz->governor_data;
>  
>  	max_power_frac = int_to_frac(max_allocatable_power);
>  
> -	if (tz->tzp->sustainable_power) {
> -		sustainable_power = tz->tzp->sustainable_power;
> -	} else {
> -		sustainable_power = estimate_sustainable_power(tz);
> -		estimate_pid_constants(tz, sustainable_power,
> -				       params->trip_switch_on, control_temp,
> -				       true);
> -	}
> +	if (!tz->tzp->sustainable_power)
> +		estimate_tzp_constants(tz, params->trip_switch_on,
> +				       control_temp);

The changes in this patch are appropriate and make sense but they are
not done at the right place.

estimate_tzp_constants() must be called when sustainable_power is
updated via DT/init or sysfs.

Keeping a function to estimate the sustainable power and another one to
estimate the k_* separated would be more clear.

Actually the confusion is coming from when the pid constants are
computed, I suggest moving the initialization of k_* out of this
function and killing the 'force' test.


[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
