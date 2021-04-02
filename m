Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F841352D1F
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbhDBPzi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbhDBPyy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 11:54:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8668CC061797
        for <linux-pm@vger.kernel.org>; Fri,  2 Apr 2021 08:54:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x7so5091707wrw.10
        for <linux-pm@vger.kernel.org>; Fri, 02 Apr 2021 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ti7CnZ58ioPvRJAxkKcVR48hDbgDyg23JEYsm8ZJBog=;
        b=iSRjkTqLZUuJikPDzHYiXZ8jIF/uxsMAUYe4ao54ac2AYPnBjtwTdT3D7BomFgr1fe
         q47RUynjmfMwBWCvyHhC7HwslAUPDbmvLOmE17nksDiLS+3JJxxM1DRJ0nwZRVlDmMWT
         vm5HWYIyxaHdBCHzoBL66Shnbt0Zd52W88Lifkh1bFuydGOvx3lJU1Ed+zl55W33xRjF
         IebEDt1lmKXGs92j7jZhJnwIKuDd03ALBk75RimAeFcqxcBs/u1aJWhV/jkPSvUfpx+e
         os5TieoYDXBt6OrWbLDClxOabOCD237MiE1Vk59hOZlCVVr7ofnFC6E6KJfzLMKUpmNj
         jVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ti7CnZ58ioPvRJAxkKcVR48hDbgDyg23JEYsm8ZJBog=;
        b=YovrV6uW4A8Su7nopzhznwvgYDz8Sh8Sn07Kc5xTu9pDFecHFCswYhcZynjVhTnaZK
         YXIdydiklVMI7CFhTKBNvHr2snD6KAImVtAWdETJSU0EQNokWXwGXOC+7wvHpFMubFz0
         s2O3Zd09elwWCZ6chstoi/8//2iO8zYcTybG+q99AHy1Ss2IrcGzokytbjG8lwZ7b4jH
         Ud+FER57Ba43YXwdcz1qXuAFY4xn5tFcqeXnCA27r+sFNStVL1D9n2XpTpUTO2urH8qz
         q4f4XbObCrjCZqVq3fAW06Q+nt3v8/kn/GtB/7ywOu1Z29txWBB/KVMWzGFm1xl02IXd
         24kQ==
X-Gm-Message-State: AOAM531OUjIkxQrEay1R4WWtPytahI3riDy0CXZ9/iijQmLGSPn7dbm9
        g44D6rTKNpBx+/0/uD2MkN3sxA==
X-Google-Smtp-Source: ABdhPJzaVDJiLDo9IUQhDeV/SCNHxTwjdoKMLCtOajCASmmDBBxLQozwfEAS3QNWgYqpTWJRTQho5A==
X-Received: by 2002:adf:f742:: with SMTP id z2mr15552411wrp.130.1617378868075;
        Fri, 02 Apr 2021 08:54:28 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:34f1:44bb:31bf:7aaf? ([2a01:e34:ed2f:f020:34f1:44bb:31bf:7aaf])
        by smtp.googlemail.com with ESMTPSA id j123sm12943231wmb.1.2021.04.02.08.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 08:54:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: power_allocator: maintain the device
 statistics from going stale
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com
References: <20210331163352.32416-1-lukasz.luba@arm.com>
 <20210331163352.32416-2-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b27e0c79-de27-f9b1-ad16-17825b302615@linaro.org>
Date:   Fri, 2 Apr 2021 17:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210331163352.32416-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/03/2021 18:33, Lukasz Luba wrote:
> When the temperature is below the first activation trip point the cooling
> devices are not checked, so they cannot maintain fresh statistics. It
> leads into the situation, when temperature crosses first trip point, the
> statistics are stale and show state for very long period. 

Can you elaborate the statistics you are referring to ?

I can understand the pid controller needs temperature but I don't
understand the statistics with the cooling device.


> This has impact
> on IPA algorithm calculation and wrong decisions. Thus, check the cooling
> devices even when the temperature is low, to refresh these statistics.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 2802a0e13c88..0cbd10cab193 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -575,15 +575,27 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
>  {
>  	struct thermal_instance *instance;
>  	struct power_allocator_params *params = tz->governor_data;
> +	u32 req_power;
>  
>  	mutex_lock(&tz->lock);
>  	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		struct thermal_cooling_device *cdev = instance->cdev;
> +
>  		if ((instance->trip != params->trip_max_desired_temperature) ||
>  		    (!cdev_is_power_actor(instance->cdev)))
>  			continue;
>  
>  		instance->target = 0;
>  		mutex_lock(&instance->cdev->lock);
> +		/*
> +		 * Call for updating the cooling devices local stats and avoid
> +		 * periods of dozen of seconds when those have not been
> +		 * maintained. The long period would come into the first check
> +		 * when lower threshold is crossed. Thus, limit it to single
> +		 * one longer polling period.
> +		 */
> +		cdev->ops->get_requested_power(cdev, &req_power);
> +
>  		instance->cdev->updated = false;
>  		mutex_unlock(&instance->cdev->lock);
>  		thermal_cdev_update(instance->cdev);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
