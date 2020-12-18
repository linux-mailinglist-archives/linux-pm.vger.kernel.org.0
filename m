Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1D42DE62D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 16:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgLRPG2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 10:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgLRPG1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2020 10:06:27 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D68C0617B0
        for <linux-pm@vger.kernel.org>; Fri, 18 Dec 2020 07:05:47 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 143so2187155qke.10
        for <linux-pm@vger.kernel.org>; Fri, 18 Dec 2020 07:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oNg9fsqgN01iZDjFmGDppzyqEcee51C5C07Q60xgAD8=;
        b=GOxEeLjpPQyQV9lrjpq19FcBzloQtCxYDK8Znr7NnsLOS3t9R9HEFQc9ArER8I97P4
         WQ9cA5VURzeXEeM5EcTOk1uwhrcpj4Z371c0d3DCceg7oRSw8YTufT1AzM+XplyTez58
         1wJW28vMdE/Ya4pZ4ExLHg+pVilmRqDnq/S2W9ULGb2JSsHJJLTs4BVd9Vc2Mzz5nCOF
         3HJOqZ3ufTUybpavulfzR46IOt91JBQLNBhUFAyIWS3i7ZZUJ3hs5JoG/B052KY7Dudv
         G7q4Pnyn8RUXQLKr6gc3HX0vdDp4/UnmlhwEEI2Rc5rpR/hL2GehXlIAtOsxx0YgNvQo
         sIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oNg9fsqgN01iZDjFmGDppzyqEcee51C5C07Q60xgAD8=;
        b=QticQcxwQM2UkQLQgFx3Ncd8KPNjxcUu0gGVuOwQ6pu29+5g8h9EjOaHWxBtBoInN2
         mzIkNsdvPIXs8xqBsVomw0sYOCBFH/nf7Ok0GCGwvca8kHn1iMjCLByS2m98lOT63uI4
         OGEKb4lsCJ8YRz+oFn2/C6L4nd93GrcOcdgLeFwMHjfPSDoqcuym4STDL98H7RA57Ohe
         qgBDbnNhC43RSpNacxMzhCcHxFjEDsNyu9ulLFpbr915msTgULm8ZG9r4vXIU6TbSGgp
         CeAU4Ilb4lckFfRIyjl7fDgCzedxEVt5s7Dq0HviaPOGrAgePiQMmI8OvGQR7IwNv9Dv
         pwiQ==
X-Gm-Message-State: AOAM5315PxyQdW5MGkB9NVsjvxAkRynj9ll9qA/C3D0wmwOGHBXRgbHa
        cMs/iVlZHft9ecZs2ljYs+loEg==
X-Google-Smtp-Source: ABdhPJxFsKoqc3zvhIKHNop0WtnpS02QFC4/cOUF4uDZvI+umf9+vEg91W191jekGR84q9ozG1vWqg==
X-Received: by 2002:a37:a64b:: with SMTP id p72mr5312567qke.304.1608303946528;
        Fri, 18 Dec 2020 07:05:46 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id s21sm5377130qtn.13.2020.12.18.07.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 07:05:45 -0800 (PST)
Subject: Re: [PATCH v2 1/3] thermal/core: Precompute the delays from msecs to
 jiffies
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>
References: <20201216220337.839878-1-daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <6a57bf9a-c4f4-2350-8bd2-01717d966611@linaro.org>
Date:   Fri, 18 Dec 2020 10:05:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201216220337.839878-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/16/20 5:03 PM, Daniel Lezcano wrote:
> The delays are stored in ms units and when the polling function is
> called this delay is converted into jiffies at each call.
> 
> Instead of doing the conversion again and again, compute the jiffies
> at init time and use the value directly when setting the polling.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   drivers/thermal/thermal_core.c    | 3 +++
>   drivers/thermal/thermal_core.h    | 1 +
>   drivers/thermal/thermal_helpers.c | 7 +++++++
>   include/linux/thermal.h           | 7 +++++++
>   4 files changed, 18 insertions(+)

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index bcc2ea4f5482..2c41d4a0923f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1315,6 +1315,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>   	tz->passive_delay = passive_delay;
>   	tz->polling_delay = polling_delay;
>   
> +	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
> +	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> +
>   	/* sys I/F */
>   	/* Add nodes that are always present via .groups */
>   	result = thermal_zone_create_device_groups(tz, mask);
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index e50c6b2909fe..90f9a80c8b23 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -123,6 +123,7 @@ int thermal_build_list_of_policies(char *buf);
>   
>   /* Helpers */
>   void thermal_zone_set_trips(struct thermal_zone_device *tz);
> +void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
>   
>   /* sysfs I/F */
>   int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index c94bc824e5d3..7f50f412e02a 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -175,6 +175,13 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
>   	mutex_unlock(&tz->lock);
>   }
>   
> +void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
> +{
> +	*delay_jiffies = msecs_to_jiffies(delay_ms);
> +	if (delay_ms > 1000)
> +		*delay_jiffies = round_jiffies(*delay_jiffies);
> +}
> +
>   static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
>   				       int target)
>   {
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 060a2160add4..d1b82c70de69 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -117,9 +117,14 @@ struct thermal_cooling_device {
>    * @trips_disabled;	bitmap for disabled trips
>    * @passive_delay:	number of milliseconds to wait between polls when
>    *			performing passive cooling.
> + * @passive_delay_jiffies: number of jiffies to wait between polls when
> + *			performing passive cooling.
>    * @polling_delay:	number of milliseconds to wait between polls when
>    *			checking whether trip points have been crossed (0 for
>    *			interrupt driven systems)
> + * @polling_delay_jiffies: number of jiffies to wait between polls when
> + *			checking whether trip points have been crossed (0 for
> + *			interrupt driven systems)
>    * @temperature:	current temperature.  This is only for core code,
>    *			drivers should use thermal_zone_get_temp() to get the
>    *			current temperature
> @@ -155,6 +160,8 @@ struct thermal_zone_device {
>   	void *devdata;
>   	int trips;
>   	unsigned long trips_disabled;	/* bitmap for disabled trips */
> +	unsigned long passive_delay_jiffies;
> +	unsigned long polling_delay_jiffies;
>   	int passive_delay;
>   	int polling_delay;
>   	int temperature;
> 

-- 
Warm Regards
Thara
