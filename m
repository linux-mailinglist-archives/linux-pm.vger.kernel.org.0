Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA11C2DFF20
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 19:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgLUSA4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 13:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgLUSAz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 13:00:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFF8C061282
        for <linux-pm@vger.kernel.org>; Mon, 21 Dec 2020 09:59:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cw27so10446392edb.5
        for <linux-pm@vger.kernel.org>; Mon, 21 Dec 2020 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PWkuqGttRqaAWl7rLMPpmQ8BaJ8J691WwUxkaIeGvJo=;
        b=Pw3Y/B1bOAivORcFJlAOiE/TgmnVI0I1sU9H5ia7NuFe4VXUTfiApqcVow14tFqldX
         OGbFlIRh7PQA3vo8JnOyrl7+IDEzOeokd7ThHFiJuZkN8EHu75ngLXvY+tdPooVNRG9x
         sQcN8CjmYDLuspof92kxN6UIlh8Hly6xH9nHx7Jf/NBuNwip1HNTG9c/Bwcsc+uOI74r
         tGEAHrT0q7D9VJyPJgGxflmhGFzlmPRMXYsh11LEuUyMcWHvmFFou53APCj7JTMwHk2a
         E/zQoi0zgnhefzFfrJ1q064KIl+0WGIYByP3zR4JN4Woh8kebctrUblLjtSKL86qioDI
         UYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PWkuqGttRqaAWl7rLMPpmQ8BaJ8J691WwUxkaIeGvJo=;
        b=nlqnf15mfu7E+2XDPJnh5wylFM+zjdZVs5zxhNcO+pDgc2cf+yRHj6P+ttPGXzPj0l
         otjcfyHfcJKB8yrCRaXxkxXp+MlqT/PXlKuuh9e15CDg6qzXOwE/Cbekjr6ljIDOjJ4l
         lD9fvLR/94ZQy4zlVDkDEqH2HCkHcPvAgDG65IhY6az+ftQNJn/yUyYofBERfRwTVdhr
         IuzRA9ffWkMf9jbdvOfO9yVwmtwBRLKLS4SQueRx4zK9Ea5OSnNESkZtw859Poon9eg4
         y1UykRYpg4E7V3qqz/mjaCJCy2lXkOAFIgcfOMDzedegYvRHcBhH3DCUCScaYdicvlp5
         WbRw==
X-Gm-Message-State: AOAM530pcAHgtMDmoaillxqBx1lhVd92+1et/scw2dIrw/Ou5zVcoKwT
        aqD/cwkQPLIAwq8IYyipLU/GC2AhE20PQA==
X-Google-Smtp-Source: ABdhPJxmfWLb890lhymXiKGMR1EgHfj3V6RlHNfL0ZjOQ+DewACWtK30ZB6q0lhoORVLIINzQgCzIw==
X-Received: by 2002:a50:955b:: with SMTP id v27mr15811429eda.324.1608559167996;
        Mon, 21 Dec 2020 05:59:27 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-148-164.adsl.proxad.net. [82.252.148.164])
        by smtp.googlemail.com with ESMTPSA id a6sm28826279edv.74.2020.12.21.05.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 05:59:27 -0800 (PST)
Subject: Re: [PATCH 1/2] thermal: int340x: Add critical callback to override
 default shutdown behavior
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     andrzej.p@collabora.com, mjg59@google.com,
        srinivas.pandruvada@linux.intel.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Kaestle <peter@piie.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201221135206.17671-1-kai.heng.feng@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <20e74dc1-1f1d-6dee-19a7-e9a975b66606@linaro.org>
Date:   Mon, 21 Dec 2020 14:59:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221135206.17671-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/12/2020 14:52, Kai-Heng Feng wrote:
> We are seeing thermal shutdown on Intel based mobile workstations, the
> shutdown happens during the first trip handle in
> thermal_zone_device_register():
> kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down
> 
> However, we shouldn't do a thermal shutdown here, since
> 1) We may want to use a dedicated daemon, Intel's thermald in this case,
> to handle thermal shutdown.
> 
> 2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
> ThermalZone namespace. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
> "... If this object it present under a device, the device’s driver
> evaluates this object to determine the device’s critical cooling
> temperature trip point. This value may then be used by the device’s
> driver to program an internal device temperature sensor trip point."
> 
> So a "critical trip" here merely means we should take a more aggressive
> cooling method.
> 
> As int340x device isn't present under ACPI ThermalZone, override the
> default .critical callback to prevent surprising thermal shutdown.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I'll submit those changes for v5.11-rc1 and change the subject by:

thermal: int340x: Fix unexpected shutdown at critical temperature
thermal: pch: Fix unexpected shutdown at critical temperature

Sounds good ?

> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 6 ++++++
>  .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 823354a1a91a..9778a6dba939 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -431,9 +431,15 @@ static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
>  	return result;
>  }
>  
> +static void int3400_thermal_critical(struct thermal_zone_device *thermal)
> +{
> +	dev_dbg(&thermal->device, "%s: critical temperature reached\n", thermal->type);
> +}
> +
>  static struct thermal_zone_device_ops int3400_thermal_ops = {
>  	.get_temp = int3400_thermal_get_temp,
>  	.change_mode = int3400_thermal_change_mode,
> +	.critical = int3400_thermal_critical,
>  };
>  
>  static struct thermal_zone_params int3400_thermal_params = {
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 6e479deff76b..d1248ba943a4 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -146,12 +146,18 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
>  	return 0;
>  }
>  
> +static void int340x_thermal_critical(struct thermal_zone_device *zone)
> +{
> +	dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
> +}
> +
>  static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
>  	.get_temp       = int340x_thermal_get_zone_temp,
>  	.get_trip_temp	= int340x_thermal_get_trip_temp,
>  	.get_trip_type	= int340x_thermal_get_trip_type,
>  	.set_trip_temp	= int340x_thermal_set_trip_temp,
>  	.get_trip_hyst =  int340x_thermal_get_trip_hyst,
> +	.critical	= int340x_thermal_critical,
>  };
>  
>  static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
