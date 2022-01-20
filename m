Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551824944B4
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jan 2022 01:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiATAew (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jan 2022 19:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357875AbiATAeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jan 2022 19:34:44 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF1C06173E
        for <linux-pm@vger.kernel.org>; Wed, 19 Jan 2022 16:34:43 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id x193so7136690oix.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Jan 2022 16:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PQWbtRSfMI7cW/DhHLCe9Ue9Xg2UF+u+efuIrUmVbXc=;
        b=HY3JN2cYz9Vn+FroIekigaULfIoV0MBiYUnhUW5W/kBL8/hfrYf5Jy4nth38EXvVK8
         0Wl1B4dLorFOSy2vffyfMSw5ACZeqefyfeEMjpTRGh1XuLmVoOHTq87i/wSUDHRhJhuh
         iE5oSDnoNHiekVZp7mUdC1+tJ3U07RVgk5NVsXc5zOUAMhc2hE8y4oHwsbK+Ax1v/C/w
         EaHtQChiDQyzp27QCjBPKmhUwwFUciWdrQKXhHla8PrCmjyqExQIA/G9Wfnzp/JqOw+N
         LTmok3Ulqvj7JDHCgzIOGu9vvtlpM7hhl5PZ8u2m1L+r99GK6Pj0sVRFFAC6bFXhbRWm
         mg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQWbtRSfMI7cW/DhHLCe9Ue9Xg2UF+u+efuIrUmVbXc=;
        b=wxIRx4dMEGse/zTtasejwT6AJ86H7UIVzZ30OivXlnDzwoYFo4s9g/apo7wPDUy+fY
         KoiKK/EccBhSqmnd8RGIXEko5TZn4rSA+/+u3CBAtTxiddZUqjeUxsmotFXRh+iOy3le
         C7D5Xyh8tHk2YfkxzT7wangSy/RiI++QKbbpSjzkaGqIsUR2CLj28NxHgQmO7v0oQe5s
         zBS3QG3LIQkPJRJbbMctQpsX2bTlpFgUL/z0x1jftPLXPwvN/vgjj58OFHwvF8jKuNAJ
         nU285Gm2DYKYhmn8eklj37igaCNQEjW63e3bqBfZExnGoGXyDGb/em72wbFUxpSmUURW
         TqqQ==
X-Gm-Message-State: AOAM531TFMmcFLbnThsFhtKeZYY9OstztqnZ/ILugRVbtWwSbCqtFvOd
        og94oA8IM3vMVqYWyo+Y/hS9DQ==
X-Google-Smtp-Source: ABdhPJx52YvWMWkLgw7UPU1nTlyknc2cYQgXvX5a70ux3nqbMHpQ68EKdDORSWSHJkxbWRxIQV39MQ==
X-Received: by 2002:a05:6808:999:: with SMTP id a25mr5520344oic.75.1642638883193;
        Wed, 19 Jan 2022 16:34:43 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id v27sm569715ots.62.2022.01.19.16.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 16:34:42 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:35:17 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Benjamin Li <benl@squareup.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: thermal: tsens: respect thermal_device_mode
 in threshold irq reporting
Message-ID: <YeiuRXFR1yer9vxe@ripper>
References: <20220114031730.25621-1-benl@squareup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114031730.25621-1-benl@squareup.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 13 Jan 19:17 PST 2022, Benjamin Li wrote:

> 'echo disabled > .../thermal_zoneX/mode' will disable the thermal core's
> polling mechanism to check for threshold trips. This is used sometimes to
> run performance test cases.
> 
> However, tsens supports an interrupt mechanism to receive notification of
> trips, implemented in commit 634e11d5b450 ("drivers: thermal: tsens: Add
> interrupt support").
> 
> Currently the thermal zone mode that's set by userspace is not checked
> before propagating threshold trip events from IRQs. Let's fix this to
> restore the abilty to disable thermal throttling at runtime.
> 
> ====================
> 
> Tested on MSM8939 running 5.16.0. This platform has 8 cores; the first
> four thermal zones control cpu0-3 and the last zone is for the other four
> CPUs together.
> 
>   for f in /sys/class/thermal/thermal_zone*; do
>     echo "disabled" > $f/mode
>     echo $f | paste - $f/type $f/mode
>   done
> 
> /sys/class/thermal/thermal_zone0	cpu0-thermal	disabled
> /sys/class/thermal/thermal_zone1	cpu1-thermal	disabled
> /sys/class/thermal/thermal_zone2	cpu2-thermal	disabled
> /sys/class/thermal/thermal_zone3	cpu3-thermal	disabled
> /sys/class/thermal/thermal_zone4	cpu4567-thermal	disabled
> 
> With mitigation thresholds at 75 degC and load running, we can now cruise
> past temp=75000 without CPU throttling kicking in.
> 
>   watch -n 1 "grep '' /sys/class/thermal/*/temp
>       /sys/class/thermal/*/cur_state
>       /sys/bus/cpu/devices/cpu*/cpufreq/cpuinfo_cur_freq"
> 
> /sys/class/thermal/thermal_zone0/temp:82000
> /sys/class/thermal/thermal_zone1/temp:84000
> /sys/class/thermal/thermal_zone2/temp:87000
> /sys/class/thermal/thermal_zone3/temp:84000
> /sys/class/thermal/thermal_zone4/temp:84000
> /sys/class/thermal/cooling_device0/cur_state:0
> /sys/class/thermal/cooling_device1/cur_state:0
> /sys/bus/cpu/devices/cpu0/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu1/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu2/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu3/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu4/cpufreq/cpuinfo_cur_freq:800000
> /sys/bus/cpu/devices/cpu5/cpufreq/cpuinfo_cur_freq:800000
> /sys/bus/cpu/devices/cpu6/cpufreq/cpuinfo_cur_freq:800000
> /sys/bus/cpu/devices/cpu7/cpufreq/cpuinfo_cur_freq:800000
> 
> Reported-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> ---
> Changes in v2:
> - Reordered sentences in first part of commit message to make sense.

Didn't spot the v2 before replying to v1, still looks good :)

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> 
>  drivers/thermal/qcom/tsens.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 99a8d9f3e03c..0b6299512e7c 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -509,13 +509,16 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>  		spin_unlock_irqrestore(&priv->ul_lock, flags);
>  
>  		if (trigger) {
> -			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> -				hw_id, __func__, temp);
> -			thermal_zone_device_update(s->tzd,
> -						   THERMAL_EVENT_UNSPECIFIED);
> +			if (s->tzd->mode == THERMAL_DEVICE_ENABLED) {
> +				dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> +					hw_id, __func__, temp);
> +				thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
> +			} else {
> +				dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC) skipped as zone disabled\n",
> +					hw_id, __func__, temp);
> +			}
>  		} else {
> -			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> -				hw_id, __func__, temp);
> +			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n", hw_id, __func__, temp);
>  		}
>  
>  		if (tsens_version(priv) < VER_0_1) {
> -- 
> 2.17.1
> 
