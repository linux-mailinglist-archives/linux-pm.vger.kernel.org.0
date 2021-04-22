Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BCB367FD5
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhDVLxr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDVLxr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 07:53:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A096C06138B
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 04:53:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v13so9807005ple.9
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oJ5PI+C0iW8MjYYI+zo8bYrw6tKqKNz0a6ReKOiPnic=;
        b=lmakWLsF6TnHDfCWNmOebmdaXTVSd+Ue3lQGW11wPhnGii6yOhFeyOfN624e123ffU
         SU7E25BrieeLyV6AoyJAbzxyyGrF3Z4qQndsw1u6oN49cOPYCUVsRVYaCmLi/to43fCm
         iTEFO43zkfbW+mgE/GspzhP2qmxiA4ucj+Qc7EXtWjRf+9xuMxxYleBmbqClQxt3N4uk
         VgQqgaWuR4te2sL5t0qmqCSYMjkAeSBpNgLLUReZUrCem9SOr8N5JaFWTW7VRwoqBT8f
         bq0IvwZoFt/rv1mwAF0DUJkJBKXBAOKjt0HMulPFKq2hDIefHxm55/A1y8Fztd1V/xTd
         XkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oJ5PI+C0iW8MjYYI+zo8bYrw6tKqKNz0a6ReKOiPnic=;
        b=kSUH395W3oPwWUMEPH3DiC6qIH7sDENChFPI3xYKxxjHuuyyjHAdwQWkDRwaNHivlM
         Zw+auQCYm21HflxWRTy4ONEWlX/72ubLwijpNLldKd317rPhE/7ZQTa0ztjazlK5ubb9
         qOrCZXUksAoaI8uEfq7JAl82kIb2iEU5+yWQQDa0amHM5McYLf1gdbGR1UoicynH+LZ9
         V9Jnok2/yTtS7bOjXfNKzblc7hPCMX9ywTTi0QmczRcZbRFcUH6ULryye4Tq2RZ9Kfof
         nxVUTvUX1pBiESAmgiJTXIXuIEOvpJamhB4/hCZ3TWtXYwsSx41hMXMEDTa0jFUfqIDj
         uL+g==
X-Gm-Message-State: AOAM532ijnLMd7dCPpS2QjugnNSj2W80mc6a/bKTHJnNliyreyy9VgWk
        2SSGBIOFiJLoZfAd+dmJPDaQYA==
X-Google-Smtp-Source: ABdhPJyvBI8w/qg0ggMAj7JbYXljgRJdzULHT3v2Qs3Quk1T927HwoNiaZ91ja0QjHP9y+WyYKYtVA==
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr3636650pjb.37.1619092392514;
        Thu, 22 Apr 2021 04:53:12 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id d21sm2254101pjx.24.2021.04.22.04.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 04:53:11 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:23:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal/core: Remove unused EXPORT_SYMBOLS
Message-ID: <20210422115309.atwqchh2fxpnpvtt@vireshk-i7>
References: <20210422113457.51578-1-daniel.lezcano@linaro.org>
 <20210422113457.51578-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422113457.51578-2-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-04-21, 13:34, Daniel Lezcano wrote:
> The functions exported in the thermal_helpers.c file are only used by
> the governors and those are not compilable as module.
> 
> Remove the EXPORT_SYMBOL as no module code needs them.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../driver-api/thermal/sysfs-api.rst          | 28 +------------------
>  drivers/thermal/thermal_helpers.c             |  3 --
>  2 files changed, 1 insertion(+), 30 deletions(-)
> 
> diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> index 4b638c14bc16..c35266bbc119 100644
> --- a/Documentation/driver-api/thermal/sysfs-api.rst
> +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> @@ -711,33 +711,7 @@ method, the sys I/F structure will be built like this::
>      |---temp1_input:		37000
>      |---temp1_crit:		100000
>  
> -4. Export Symbol APIs
> -=====================
> -
> -4.1. get_tz_trend
> ------------------
> -
> -This function returns the trend of a thermal zone, i.e the rate of change
> -of temperature of the thermal zone. Ideally, the thermal sensor drivers
> -are supposed to implement the callback. If they don't, the thermal
> -framework calculated the trend by comparing the previous and the current
> -temperature values.
> -
> -4.2. get_thermal_instance
> --------------------------
> -
> -This function returns the thermal_instance corresponding to a given
> -{thermal_zone, cooling_device, trip_point} combination. Returns NULL
> -if such an instance does not exist.
> -
> -4.3. thermal_cdev_update
> -------------------------
> -
> -This function serves as an arbitrator to set the state of a cooling
> -device. It sets the cooling device to the deepest cooling state if
> -possible.
> -
> -5. thermal_emergency_poweroff
> +4. thermal_emergency_poweroff
>  =============================
>  
>  On an event of critical trip temperature crossing. Thermal framework
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 7f50f412e02a..0ecf2c66aa76 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -39,7 +39,6 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
>  
>  	return trend;
>  }
> -EXPORT_SYMBOL(get_tz_trend);
>  
>  struct thermal_instance *
>  get_thermal_instance(struct thermal_zone_device *tz,
> @@ -63,7 +62,6 @@ get_thermal_instance(struct thermal_zone_device *tz,
>  
>  	return target_instance;
>  }
> -EXPORT_SYMBOL(get_thermal_instance);
>  
>  /**
>   * thermal_zone_get_temp() - returns the temperature of a thermal zone
> @@ -221,7 +219,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  	trace_cdev_update(cdev, target);
>  	dev_dbg(&cdev->device, "set to state %lu\n", target);
>  }
> -EXPORT_SYMBOL(thermal_cdev_update);
>  
>  /**
>   * thermal_zone_get_slope - return the slope attribute of the thermal zone

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
