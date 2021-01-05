Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC112EAF25
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 16:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbhAEPpL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 10:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAEPpK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 10:45:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C83CC061574
        for <linux-pm@vger.kernel.org>; Tue,  5 Jan 2021 07:44:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v14so3420998wml.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Jan 2021 07:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u8B6Jcqsj2qQHBVOgCivAszp3Mr4Z2LIctYHDfeemKo=;
        b=rdkjlnzWp+2zOi5b7d3ppqU3lIZOJ5blen0fY3s5Lownn35zv1OY5oSXisTXNXbPyC
         Ah5BTaAA34KGKm3jno6izGQnj64gA8NV4bnBGGFhoxXY1cRienDsq01Ly1HW5H5v+TQx
         RWOPXFrWoVhDadJzet0FLMTTT4lZz790d5QI/C4J4dpDywH6AsGpYvxaqVY/qSlO/BPg
         ZsWCmKKl3DTc8YgbmzfK8jhQJyf6JzeXIk/ww02n/CzBftFPbXesLu8JnbSGmtitC9xf
         E+awFJNqK1Q5XoKUMT9yHEi6NGaQRncmPO1aB1pii/ZEpU2u3J2T0L7B86U71oVchq4x
         u48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u8B6Jcqsj2qQHBVOgCivAszp3Mr4Z2LIctYHDfeemKo=;
        b=Jftii3wa78Rk8WENqnyEinE3LJ9JmW6tBbWbvqGPbIQwHMaZc/+BcfdUmPsgo5YWbK
         KY0EaFAUkZaZpIGqZLYop1rFV+/5U7+PPnXeVHFy/7tldsoG96lmdO1VkI4iMSf+XI0X
         OugZ/Yai0PvezbhpDROWcez9wW/lVTNq4F6y8HSlInOMkqtcwRP2czR9IiJtgUO8Md67
         aXzedbqNme5F639SgboWPQCGOlP1DERgdfBe+6HGIkaZli/Yk4ryHJpMr9lYEmG+DSxg
         Z3JKZf79PDZKdgLr3kSQRYFKixu1myKnlYwMmjruAOnOK8KC9B5ffPpJJrsG7sXFg1kY
         C80g==
X-Gm-Message-State: AOAM533nJbTvk2lIvDQynFeka9U2W2uEpNO1JnKXx3ysB0j542ZHDrrz
        Da6Lf5YoD6RMt1UWoIuFSEswDw==
X-Google-Smtp-Source: ABdhPJwPZdpUvNf4958mHWq+C7VzsGf8VpOVbdIf0IvglN6LK/TbWfdvoLZMv0Z1Xr0zlF0zVNQlLw==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr4128150wmj.154.1609861468726;
        Tue, 05 Jan 2021 07:44:28 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-152-224.adsl.proxad.net. [82.252.152.224])
        by smtp.googlemail.com with ESMTPSA id s6sm191847wro.79.2021.01.05.07.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:44:27 -0800 (PST)
Subject: Re: [PATCH 4/6] acpi/drivers/thermal: Remove TRIPS_NONE cooling
 device binding
To:     rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        thara.gopinath@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
 <20201214233811.485669-4-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1de4868e-6229-ed33-f45a-7cd82d3ee48a@linaro.org>
Date:   Tue, 5 Jan 2021 16:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214233811.485669-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rui,


On 15/12/2020 00:38, Daniel Lezcano wrote:
> The loop is here to create default cooling device binding on the
> THERMAL_TRIPS_NONE number which is used to be the 'forced_passive'
> feature. However, we removed all code dealing with that in the thermal
> core, thus this binding does no longer make sense.
> 
> Remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Are you fine with this change?

Thanks

  -- Daniel

> ---
>  drivers/acpi/thermal.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index b5e4bc9e3282..26a89ff80a0e 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -764,25 +764,6 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
>  		}
>  	}
>  
> -	for (i = 0; i < tz->devices.count; i++) {
> -		handle = tz->devices.handles[i];
> -		status = acpi_bus_get_device(handle, &dev);
> -		if (ACPI_SUCCESS(status) && (dev == device)) {
> -			if (bind)
> -				result = thermal_zone_bind_cooling_device
> -						(thermal, THERMAL_TRIPS_NONE,
> -						 cdev, THERMAL_NO_LIMIT,
> -						 THERMAL_NO_LIMIT,
> -						 THERMAL_WEIGHT_DEFAULT);
> -			else
> -				result = thermal_zone_unbind_cooling_device
> -						(thermal, THERMAL_TRIPS_NONE,
> -						 cdev);
> -			if (result)
> -				goto failed;
> -		}
> -	}
> -
>  failed:
>  	return result;
>  }
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
