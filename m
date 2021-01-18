Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527AF2FA5A4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 17:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406226AbhARQIO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 11:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406435AbhARQHz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 11:07:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93A5C061574
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 08:07:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o10so167949wmc.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 08:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lkU/Vu2jsZl8gjMBcdEUs2PWYLIzcsKski8kSUkVIow=;
        b=H9pW3X8pb8YGtrePLFXvUc63OFgGS5pBMVP0vjva3ryV6ExKJW1VDQ8/Dbl3oHK93+
         4/vxpoI4sqy6qRqYC+C6v9xsLKyhuhdb6qok7xZglGUSKs4E5C7vZCRiKuyiLYcPV4Gj
         eYMk5RlUrs1sv9qqKXwHAPeCTD5AgoIqVicrICrFY0cFzNzOc65xiKMMXkrewcJ+xML/
         jFmoj9m92iP38brqRL602VT9YA9gv3DImWnysywWN+mpIA1rorPxZKY6wFs2LNibN5kw
         WWJqLPMaPsMPoLCL/4sY5r7CesKwiRVp+vJNn8HEfn2GY8bo93JL3FGsI4MGbqh+CABu
         mBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lkU/Vu2jsZl8gjMBcdEUs2PWYLIzcsKski8kSUkVIow=;
        b=HOY+Mm9bjF1gycNwRmOL5+cYHW+VCc2QYQm1e7/hL1haBquOa3WfxpXSmsBS3H57X/
         dDr16y0KvJrqkYXjnoqtUroZjMOOROmFWGLQqx2rpD7zwEx/dHeESKWIMysOKcG28tYy
         i7nhRdnP4ShPW6ojKNPRSpDpeYwZ9zEf4VAxJVaZAcvSPMMJ5Q6ZDf9c9o8v4X88hpyL
         cY2CXG8CbDISgwOmZ9IDQHYa5RCy78QL08xVAoz68wYbr7AL7Dp5bkeZ7abUYSMNT2Kc
         hEyAnkPZmkf6Vx+Vxox2gU/XO2QGtmMLZKEiLEdTAzzxbA4LzE1/y5Lgtv2mt9L7XxM/
         q4VQ==
X-Gm-Message-State: AOAM532NQjjrmbF6911XdkyX/hfSCPJcrcVnrjjykaniUE5+cTLfs3+F
        aVMagFmiNrcwCdTpkcd4xdVk3Q==
X-Google-Smtp-Source: ABdhPJxQjU0YQYOIDMQJh2zQ8Lznp+KQPAh88kwLXthcsOXeKCX71nsdYi74mGirMwu3hwp+YrT/Hw==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr75991wmi.35.1610986033465;
        Mon, 18 Jan 2021 08:07:13 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:2095:8614:d69:136f? ([2a01:e34:ed2f:f020:2095:8614:d69:136f])
        by smtp.googlemail.com with ESMTPSA id p15sm31181362wrt.15.2021.01.18.08.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 08:07:12 -0800 (PST)
Subject: Re: [PATCH] thermal: power allocator: Add control for non-power actor
 devices
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com
References: <20210105190107.30479-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3b98cbfa-3bfb-607c-aa4d-2c2ef3e61990@linaro.org>
Date:   Mon, 18 Jan 2021 17:07:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210105190107.30479-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/01/2021 20:01, Lukasz Luba wrote:
> The cooling devices which are used in IPA should provide power mapping
> functions. The callback functions are used for power estimation and state
> setting. When these functions are missing IPA ignores such cooling devices
> and does not limit their performance. It could happen that the platform
> configuration is missing these functions in example when the Energy Model
> was not setup properly (missing DT entry 'dynamic-power-coefficient').
> 
> The patch adds basic control over these devices' performance. It
> manages to throttle them to stay safe and not overheat. It also adds a
> warning during the binding phase, so it can be captured during testing.
> 
> The patch covers also a corner case when all of the cooling devices are
> non-power actors.

In my opinion this is a user space problem. If a device does not have
power information, then it should use the step-wise governor instead.

It is not the power allocator to overcome a wrong or unsupported setup.

Usually, the default governor is the step-wise and the userspace sets
the power allocator policy.

A solution can be to fail to change the policy or bind if the associated
cooling devices are not all power actors.

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 71 +++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 7a4170a0b51f..bcd1d524a1ba 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -276,6 +276,33 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>  	return power_range;
>  }
>  
> +/**
> + * control_non_power_actor() - control performance of a cooling device which
> + *				is not a power actor
> + * @instance:   thermal instance to update
> + * @throttle:	boolean flag indicating the action
> + *
> + * Set the min/max performance point for a given cooling device, with respect
> + * to limits. It is needed only for devices which are not power actors and
> + * don't provide the power mapping functions. These devices will be capped
> + * more strictly to provide safe conditions and not overheat them.
> + */
> +static void control_non_power_actor(struct thermal_instance *instance,
> +				    bool throttle)
> +{
> +	struct thermal_cooling_device *cdev = instance->cdev;
> +
> +	if (throttle)
> +		instance->target = instance->upper;
> +	else
> +		instance->target = instance->lower;
> +
> +	mutex_lock(&cdev->lock);
> +	cdev->updated = false;
> +	mutex_unlock(&cdev->lock);
> +	thermal_cdev_update(cdev);
> +}
> +
>  /**
>   * power_actor_set_power() - limit the maximum power a cooling device consumes
>   * @cdev:	pointer to &thermal_cooling_device
> @@ -405,7 +432,7 @@ static int allocate_power(struct thermal_zone_device *tz,
>  
>  	if (!num_actors) {
>  		ret = -ENODEV;
> -		goto unlock;
> +		goto safety_throttling;
>  	}
>  
>  	/*
> @@ -495,6 +522,16 @@ static int allocate_power(struct thermal_zone_device *tz,
>  				      control_temp - tz->temperature);
>  
>  	kfree(req_power);
> +
> +safety_throttling:
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		if (instance->trip != trip_max_desired_temperature)
> +			continue;
> +
> +		if (!cdev_is_power_actor(instance->cdev))
> +			control_non_power_actor(instance, true);
> +	}
> +
>  unlock:
>  	mutex_unlock(&tz->lock);
>  
> @@ -576,9 +613,13 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
>  
>  	mutex_lock(&tz->lock);
>  	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -		if ((instance->trip != params->trip_max_desired_temperature) ||
> -		    (!cdev_is_power_actor(instance->cdev)))
> +		if (instance->trip != params->trip_max_desired_temperature)
> +			continue;
> +
> +		if (!cdev_is_power_actor(instance->cdev)) {
> +			control_non_power_actor(instance, false);
>  			continue;
> +		}
>  
>  		instance->target = 0;
>  		mutex_lock(&instance->cdev->lock);
> @@ -589,6 +630,28 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
>  	mutex_unlock(&tz->lock);
>  }
>  
> +/**
> + * check_power_actors() - Check all cooling devices and warn when they are
> + *			not power actors
> + * @tz:		thermal zone to operate on
> + *
> + * Check all cooling devices in the @tz and warn when they are not power
> + * actors. These cooling devices will be throttled aggressively because they
> + * miss needed callbacks. The warning would help to investigate the issue,
> + * which could be e.g. lack of Energy Model for a given device.
> + */
> +static void check_power_actors(struct thermal_zone_device *tz)
> +{
> +	struct thermal_instance *instance;
> +
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		if (!cdev_is_power_actor(instance->cdev)) {
> +			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
> +				 instance->cdev->type);
> +		}
> +	}
> +}
> +
>  /**
>   * power_allocator_bind() - bind the power_allocator governor to a thermal zone
>   * @tz:	thermal zone to bind it to
> @@ -637,6 +700,8 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>  
>  	tz->governor_data = params;
>  
> +	check_power_actors(tz);
> +
>  	return 0;
>  
>  free_params:
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
