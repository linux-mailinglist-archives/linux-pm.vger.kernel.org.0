Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3561365A1F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 15:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhDTNay (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhDTNax (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 09:30:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D06C06138A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 06:30:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n10-20020a05600c4f8ab0290130f0d3cba3so1100723wmq.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jzWHsyN0ouTXQZ1m1iLRKWJKUoOGAIFoQPUyqNWL1Rk=;
        b=C5cHo69OGH5oEJK7cJBWcWEdCHdi+ff0qQaNXid3xwJg+My0bUKSGba0wFoh5moxfX
         EHkq3de9MDLRdTuXPkz76TqPmbLRp3ZizPXaSgBBOlSuklWnhyqJGLgM96E15we/N/kE
         W1a/hCBgdjZLvboXZOqD57RI3VlzgN93b3O1luWTA/G5omKUHwC5sTMUGwFTImlMOcCA
         lV4eAZtVappiXv1RWw3Cc2T/wkGrtlVrP7AXAUlYy/rgxzYonF0qN1cIk9K1PNTdEEar
         FYTh2L+3Md7+JrUT07hzyLGFeBENeQDXSWU2jj5ffkaZ1Hz87/3LGCdZjWT2hRkOd/PC
         rcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jzWHsyN0ouTXQZ1m1iLRKWJKUoOGAIFoQPUyqNWL1Rk=;
        b=FKQQrui7KG9fgYAkoGdykQYX4oVTSRqfEt60Ecq1IY+IKZnyyMLnIHxiFy7ePjvcxc
         HFJFgcXXsOPKUhEsdbTmYnmjoXH5GTTF4Z0msx08vmO8drMm/yhxKhMWsdgZIooGU3N6
         4UHqBqPwWo8jzxKgK4C/O/0za7rYsZJOo2QyZsnVHQiAzUak+KnIl2orMVTEknmsWcqJ
         HuS+IbKub0huNVmppb7JJF16TcDJZz42y/aOs3fEDCyn9EwtvH8uT6aaAb2boNZEgaHM
         IVNjVw6MnKP4O3ftWHD1En3X4uKQyf5IYewUR4juATrC8sRaMPFkVQe1TmyBiz7wUE1V
         tPDA==
X-Gm-Message-State: AOAM532BZXLgAmBHSLY74w9+R8Or7UR3/q/yc5WSst7RE3/stbNiBpUw
        L5XbKWOnp2Jws3Q5U05JIlOL8ikvlYZYcDP1
X-Google-Smtp-Source: ABdhPJzzfK8CwIY0cZqsrLMW7HsEAgftwvJVT/pIFM4iaWSK86lBUUOpYf0omAIh+EmsC7+fZu7mKw==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr4554602wmj.149.1618925421002;
        Tue, 20 Apr 2021 06:30:21 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a079:f96:da87:2d00? ([2a01:e34:ed2f:f020:a079:f96:da87:2d00])
        by smtp.googlemail.com with ESMTPSA id f24sm3325837wmb.32.2021.04.20.06.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 06:30:20 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal: power_allocator: update once cooling
 devices when temp is low
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com
References: <20210419084536.25000-1-lukasz.luba@arm.com>
 <20210419084536.25000-3-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c69e2ba0-b382-01a0-292f-019fffd365e0@linaro.org>
Date:   Tue, 20 Apr 2021 15:30:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210419084536.25000-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/04/2021 10:45, Lukasz Luba wrote:
> The cooling device state change generates an event, also when there is no
> need, because temperature is low and device is not throttled. Avoid to
> unnecessary update the cooling device which means also not sending event.
> The cooling device state has not changed because the temperature is still
> below the first activation trip point value, so we can do this.
> Add a tracking mechanism to make sure it updates cooling devices only
> once - when the temperature dropps below first trip point.
> 
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index d393409fb786..f379f1aaa3b5 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -571,7 +571,7 @@ static void reset_pid_controller(struct power_allocator_params *params)
>  	params->prev_err = 0;
>  }
>  
> -static void allow_maximum_power(struct thermal_zone_device *tz)
> +static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
>  {
>  	struct thermal_instance *instance;
>  	struct power_allocator_params *params = tz->governor_data;
> @@ -594,9 +594,13 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
>  		 */
>  		cdev->ops->get_requested_power(cdev, &req_power);
>  
> -		instance->cdev->updated = false;
> +		if (update)
> +			instance->cdev->updated = false;
> +
>  		mutex_unlock(&instance->cdev->lock);
> -		(instance->cdev);
> +
> +		if (update)
> +			thermal_cdev_update(instance->cdev);

This cdev update has something bad IMHO. It is protected by a mutex but
the 'updated' field is left unprotected before calling
thermal_cdev_update().

It is not the fault of this code but how the cooling device are updated
and how it interacts with the thermal instances.

IMO, part of the core code needs to revisited.

This change tight a bit more the knot.

Would it make sense to you if we create a function eg.
__thermal_cdev_update()

And then we have:

void thermal_cdev_update(struct thermal_cooling_device *cdev)
{
        mutex_lock(&cdev->lock);
        /* cooling device is updated*/
        if (cdev->updated) {
                mutex_unlock(&cdev->lock);
                return;
        }

	__thermal_cdev_update(cdev);

        thermal_cdev_set_cur_state(cdev, target);

        cdev->updated = true;
        mutex_unlock(&cdev->lock);
        trace_cdev_update(cdev, target);
        dev_dbg(&cdev->device, "set to state %lu\n", target);
}

And in this file we do instead:

-		instance->cdev->updated = false;
+		if (update)
+			__thermal_cdev_update(instance->cdev);
  		mutex_unlock(&instance->cdev->lock);
-		thermal_cdev_update(instance->cdev);

>  	}
>  	mutex_unlock(&tz->lock);
>  }
> @@ -710,6 +714,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
>  	int ret;
>  	int switch_on_temp, control_temp;
>  	struct power_allocator_params *params = tz->governor_data;
> +	bool update;
>  
>  	/*
>  	 * We get called for every trip point but we only need to do
> @@ -721,9 +726,10 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
>  	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
>  				     &switch_on_temp);
>  	if (!ret && (tz->temperature < switch_on_temp)) {
> +		update = (tz->last_temperature >= switch_on_temp);
>  		tz->passive = 0;
>  		reset_pid_controller(params);
> -		allow_maximum_power(tz);
> +		allow_maximum_power(tz, update);
>  		return 0;
>  	}
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
