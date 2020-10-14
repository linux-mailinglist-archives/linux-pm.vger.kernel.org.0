Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AA928E241
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgJNOew (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 10:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgJNOew (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 10:34:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F286FC061755
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 07:34:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b8so4185619wrn.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mpnbVKj5Qvt4DLAKTdCVqMoS29Ls9wg8TdVumw+fCxI=;
        b=vCMS6T6nHEkh+s+Q2LVJ98o8dY2qydszI5cCQbV5feZqTzhNuEOXvuV+k4ViVXXLBg
         AAwjwORQfzTpmXQ+7JBR7bWx+2Clt3yI/2f5DG9FRpFbLcjkJsOGcStJ7P93PjPLOTwy
         y4Ig0aDQ9U4vKR/AqHc7SyCyjxWNo3ZqcoKTOOtjCMjMs64TW2v/lavmWZ3dzD1KS5N/
         GZOlV8wIwTuq6pMlOxNgx9/h+yw5R8CM1vlVdG0tJTCOL2w8NnzFzrTZmDliKDRZA+K0
         Awb7BHd6dejw+JxPPveRl7R73heF3KL46Yu6m0tX7tWFIYVG0f5RchI1NAdmI6+aGil4
         RRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mpnbVKj5Qvt4DLAKTdCVqMoS29Ls9wg8TdVumw+fCxI=;
        b=jf0wORuz761OFh8ZUUTgZ2pQ5ylzofaHqtNWN9He2PBhZs2e1dX4VBTsv6jB+eNsHz
         HfWZmy0ux2+Rwx7R/KTmK0fi0upSQYje64He8hai8aTIuvtiNCARyb9YpoM8JbOR2pbA
         vYPopF1+Yqy+a+/JLCYT7P0BQy/0L4knptRGBGSoV9KPsj50LS+9yDqX68zJG/KtJ6wf
         IuzikzsYZlN0oFbDZFduSNZ8NybavkoVJrNYDo36Slqou7pr8YTuhG9fTP1E3JfMqmyQ
         CrJdjbNQkK9VlpwgDlp0hYEP5vol5DYZXy1xOs4nNPMFJntXVl/1vriZGE6vIWXfKZbb
         HTug==
X-Gm-Message-State: AOAM532G3HPmlSDWN9e3QrrD08+2DEdEeBnQ18HFsAA6GUNIoJVclI6e
        Q9zV5YH4ehWuu5KSWhry3cxbvw==
X-Google-Smtp-Source: ABdhPJxIq6cbJb8jyXUYvZ0nHc3Wjr5aiEeT2TGg5YK+5ormUkrDUikCiPSvQ7U+JTvAn1RU0xXKbw==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr6283823wro.77.1602686090400;
        Wed, 14 Oct 2020 07:34:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f? ([2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f])
        by smtp.googlemail.com with ESMTPSA id z127sm4179758wmc.2.2020.10.14.07.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 07:34:49 -0700 (PDT)
Subject: Re: [PATCH 2/5] thermal: devfreq_cooling: get a copy of device status
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch
References: <20200921122007.29610-1-lukasz.luba@arm.com>
 <20200921122007.29610-3-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <199bf0e0-88b3-1908-c291-92c85bfe06b1@linaro.org>
Date:   Wed, 14 Oct 2020 16:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921122007.29610-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2020 14:20, Lukasz Luba wrote:
> Devfreq cooling needs to now the correct status of the device in order
> to operate. Do not rely on Devfreq last_status which might be a stale data
> and get more up-to-date values of the load.
> 
> Devfreq framework can change the device status in the background. To
> mitigate this situation make a copy of the status structure and use it
> for internal calculations.
> 
> In addition this patch adds normalization function, which also makes sure
> that whatever data comes from the device, it is in a sane range.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/devfreq_cooling.c | 52 +++++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 7063ccb7b86d..cf045bd4d16b 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -227,6 +227,24 @@ static inline unsigned long get_total_power(struct devfreq_cooling_device *dfc,
>  							       voltage);
>  }
>  
> +static void _normalize_load(struct devfreq_dev_status *status)
> +{
> +	/* Make some space if needed */
> +	if (status->busy_time > 0xffff) {
> +		status->busy_time >>= 10;
> +		status->total_time >>= 10;
> +	}
> +
> +	if (status->busy_time > status->total_time)
> +		status->busy_time = status->total_time;
> +
> +	status->busy_time *= 100;
> +	status->busy_time /= status->total_time ? : 1;
> +
> +	/* Avoid division by 0 */
> +	status->busy_time = status->busy_time ? : 1;
> +	status->total_time = 100;
> +}

Not sure that works if the devfreq governor is not on-demand.

Is it possible to use the energy model directly in devfreq to compute
the energy consumption given the state transitions since the last reading ?

The power will be read directly from devfreq which will return:

nrj + (current_power * (jiffies - last_update)) / (jiffies - last_update)

The devfreq cooling device driver would result in a much simpler code, no?

>  static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cdev,
>  					       struct thermal_zone_device *tz,
> @@ -234,14 +252,22 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>  {
>  	struct devfreq_cooling_device *dfc = cdev->devdata;
>  	struct devfreq *df = dfc->devfreq;
> -	struct devfreq_dev_status *status = &df->last_status;
> +	struct devfreq_dev_status status;
>  	unsigned long state;
> -	unsigned long freq = status->current_frequency;
> +	unsigned long freq;
>  	unsigned long voltage;
>  	u32 dyn_power = 0;
>  	u32 static_power = 0;
>  	int res;
>  
> +	mutex_lock(&df->lock);
> +	res = df->profile->get_dev_status(df->dev.parent, &status);
> +	mutex_unlock(&df->lock);
> +	if (res)
> +		return res;
> +
> +	freq = status.current_frequency;
> +
>  	state = freq_get_state(dfc, freq);
>  	if (state == THERMAL_CSTATE_INVALID) {
>  		res = -EAGAIN;
> @@ -269,16 +295,18 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>  	} else {
>  		dyn_power = dfc->power_table[state];
>  
> +		_normalize_load(&status);
> +
>  		/* Scale dynamic power for utilization */
> -		dyn_power *= status->busy_time;
> -		dyn_power /= status->total_time;
> +		dyn_power *= status.busy_time;
> +		dyn_power /= status.total_time;
>  		/* Get static power */
>  		static_power = get_static_power(dfc, freq);
>  
>  		*power = dyn_power + static_power;
>  	}
>  
> -	trace_thermal_power_devfreq_get_power(cdev, status, freq, *power);
> +	trace_thermal_power_devfreq_get_power(cdev, &status, freq, *power);
>  
>  	return 0;
>  fail:
> @@ -312,14 +340,20 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
>  {
>  	struct devfreq_cooling_device *dfc = cdev->devdata;
>  	struct devfreq *df = dfc->devfreq;
> -	struct devfreq_dev_status *status = &df->last_status;
> -	unsigned long freq = status->current_frequency;
> +	struct devfreq_dev_status status;
>  	unsigned long busy_time;
> +	unsigned long freq;
>  	s32 dyn_power;
>  	u32 static_power;
>  	s32 est_power;
>  	int i;
>  
> +	mutex_lock(&df->lock);
> +	status = df->last_status;
> +	mutex_unlock(&df->lock);
> +
> +	freq = status.current_frequency;
> +
>  	if (dfc->power_ops->get_real_power) {
>  		/* Scale for resource utilization */
>  		est_power = power * dfc->res_util;
> @@ -331,8 +365,8 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
>  		dyn_power = dyn_power > 0 ? dyn_power : 0;
>  
>  		/* Scale dynamic power for utilization */
> -		busy_time = status->busy_time ?: 1;
> -		est_power = (dyn_power * status->total_time) / busy_time;
> +		busy_time = status.busy_time ?: 1;
> +		est_power = (dyn_power * status.total_time) / busy_time;
>  	}
>  
>  	/*
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
