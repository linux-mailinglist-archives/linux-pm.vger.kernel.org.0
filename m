Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F33497591
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jan 2022 21:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiAWUvG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jan 2022 15:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbiAWUvF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jan 2022 15:51:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE26C06173B
        for <linux-pm@vger.kernel.org>; Sun, 23 Jan 2022 12:51:04 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f17so10003549wrx.1
        for <linux-pm@vger.kernel.org>; Sun, 23 Jan 2022 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2pHn6VFDo9V2iSXX9J9tHBEdex+fcc+UCqRoXLJMgfA=;
        b=u7fVTzQ6f8YyT+tk5WCIgGkmFky4Kcvn84tExuIQDd06RmqpdKZnulep6DITSmFKkk
         J54RZ/MMcsimwKPeDCdotQEwwgZDQcF9AfoM0F0ER1rSuIUvrui5Hwy23EvedJloXgEP
         6J6gOKRGBkbVq48w+7npzU+DbFA5XhRkAt4T8aWDG/1WUSO+bd05O3xmzyg9nURx5OEu
         Iy3Fghakg5P2fHo491YIqx8KWuReEJlhlNkwvFTtAj+SniXh1rRVInY9eusZkmPZYb1Q
         HvajymQpzGoZKuF7IOizmVc0D5/v2UfUDZB9gUxk4TXD9RKOI8X2nwWqSew3Up6YcFMz
         OATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2pHn6VFDo9V2iSXX9J9tHBEdex+fcc+UCqRoXLJMgfA=;
        b=pzctSsBdQWQqUatJni8p+um72QkQtoLxUnc5h2jvr9GAmYcNdEIDdHSEaI/7L1xAQl
         bMjjnMmJjMp8FcWYXqh56oiWuU7xHjicn2o6IwuUEcwkL5zPLgTaomYAvSK0e50Hi8LU
         IITwl8nlIkLAG029P3o52msPCQXnbWcWfI15dlqOsXF0ImOW6m6N3A4itNHyuQfjRz9G
         Rm2OroHeanx1LOmNt4kho/9tSpdvX5tnZD9VB13IJ2LVzSrhxedyNqiQXwvy+ONx1YFu
         e9jS0LZFQwWvUGS0/xqiOWtfatfoL6+uEuSvRzu3gYWd9o0v9Grcr8AS8Ld91jwIIAyX
         WCaw==
X-Gm-Message-State: AOAM533vMDKgb7t8xpvy2bY05/CHPd9+673dffGTJRFKeiby8YHK7TG1
        QXHU87/eCOxPjWbJnNwgKvlKVQ==
X-Google-Smtp-Source: ABdhPJzUD9odvsvXXSjI4kETOSZIO7NqgLWJ4W3Auo3/TX8DjFvn0/iI5iV43Dzfz4qKw+sRLZoaWA==
X-Received: by 2002:adf:f810:: with SMTP id s16mr11946882wrp.25.1642971062941;
        Sun, 23 Jan 2022 12:51:02 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:bc8d:48f2:4c8a:bfa9? ([2a01:e34:ed2f:f020:bc8d:48f2:4c8a:bfa9])
        by smtp.googlemail.com with ESMTPSA id u19sm7495797wmm.39.2022.01.23.12.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 12:51:02 -0800 (PST)
Subject: Re: [PATCH v3] thermal/core: Clear all mitigation when thermal zone
 is disabled
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <927aca29-fca7-bdf9-9ad6-2599125ca1b4@linaro.org>
Date:   Sun, 23 Jan 2022 21:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Manaf,

semantically speaking disabling a thermal zone would be to detach the
thermal zone from its governor and stop the monitoring.

May be add the functions

 - thermal_governor_attach(struct thermal_zone_device *tzd)
   {
        ...
        if (tz->governor && tz->governor->bind_to_tz) {
                if (tz->governor->bind_to_tz(tz)) {
	}
        ...
   }

 - thermal_governor_detach(struct thermal_zone_device *tzd)
   {
        ...
        if (tz->governor && tz->governor->unbind_from_tz)
                tz->governor->unbind_from_tz(tz);
        ...
   }

And add in the step_wise and power_allocator the reset of the governor's
data as well as the cooling device instances in the unbind_from_tz()
callback

Then, thermal_zone_device_enable() attaches and
thermal_zone_device_disable() detaches the governor.

Does it make sense ?


On 07/01/2022 19:56, Manaf Meethalavalappu Pallikunhi wrote:
> Whenever a thermal zone is in trip violated state, there is a chance
> that the same thermal zone mode can be disabled either via thermal
> core API or via thermal zone sysfs. Once it is disabled, the framework
> bails out any re-evaluation of thermal zone. It leads to a case where
> if it is already in mitigation state, it will stay the same state
> until it is re-enabled.
> 
> To avoid above mentioned issue, on thermal zone disable request
> reset thermal zone and clear mitigation for each trip explicitly.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---
>  drivers/thermal/thermal_core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 51374f4..e288c82 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -447,10 +447,18 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>  
>  	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>  
> -	if (mode == THERMAL_DEVICE_ENABLED)
> +	if (mode == THERMAL_DEVICE_ENABLED) {
>  		thermal_notify_tz_enable(tz->id);
> -	else
> +	} else {
> +		int trip;
> +
> +		/* make sure all previous throttlings are cleared */
> +		thermal_zone_device_init(tz);
> +		for (trip = 0; trip < tz->trips; trip++)
> +			handle_thermal_trip(tz, trip);
> +
>  		thermal_notify_tz_disable(tz->id);
> +	}
>  
>  	return ret;
>  }
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
