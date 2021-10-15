Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D6842F016
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhJOMBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhJOMB3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:01:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C22C061762
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 04:59:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso2201342wms.4
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 04:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7h9E2vwxmrUICs9+zLHmg65aoJcUn9hY4EUmVewELqc=;
        b=eV/pNLOElvJcTV37BGDjthMCwciEsnPZNEnZiVpOFrXf7js6fzypLvB7AbOygzTCnL
         /cuIfU4rLg+800jOZx48ua8zF8ifO9lUrRgl8xJH1xwg1GNKtThf0jpKTyqwJHwqMCfD
         MlQ6mpoN32xiVXdK0D2ndIWHwCEtJVQP3h83ppkUsNQbruRkBgkNm4fusNRrumIIu3DN
         xGP4Ec2NTuOjq/uAQx7HGs1mCP/QntjAB3Tb0SAge88pPacIM9taBouiR3c5X5vOpZCN
         tBiFtUYebUxMs2odcqUGAPVyKNcUYKCTzLtvkOLqrFJMb0oxN1RP+I654n8hSxEaK/+N
         vByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7h9E2vwxmrUICs9+zLHmg65aoJcUn9hY4EUmVewELqc=;
        b=3swmAHubHvC3H1u0I0R9dH9ErsxN2mC5gu6+/93mH07wXZVY5pXeKiGK6byDLl7Btp
         2tI1na95hW0Yv/WCLXIJmHOJhyrbkvG9X3DcwEp1G5b/BzPDkCx9x5DSCW8Ha3TqOjkY
         tk7jjtnH/Zm4Yy9J7edTqcOibhCS8kPPKv68zrvhf/qFZ9BXuDmatGRqic8L8XAklnRf
         ISXnGtPl/vTbvt474zdUYZhYSJIXdPsd/C3ydC/ArDayaotkPgSIpkshMLR00POpshNL
         vYTcrg0kCHqvJh9ObHVtqO9Nplx5jQAamTXCDmclDS0/FdygEaJmqR9dr+J9wjZZhOZJ
         Cwvg==
X-Gm-Message-State: AOAM531BoG9pmJRe71tgD9FJu45T0WGnR4wGjcDijAiYYXFNOIdAzArn
        ZDKfL/hy4geDGC0N+acc66YbqA==
X-Google-Smtp-Source: ABdhPJx8SnCKKiDqzn7qZsfHPDrfb116wn2vDMpmvYjxhdzPOlP+xy0dJs6NqjPW0pzpEoKEGQpUFw==
X-Received: by 2002:a05:600c:1c1b:: with SMTP id j27mr11548052wms.1.1634299161723;
        Fri, 15 Oct 2021 04:59:21 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c62a:318d:9792:450f? ([2a01:e34:ed2f:f020:c62a:318d:9792:450f])
        by smtp.googlemail.com with ESMTPSA id q12sm999293wrp.13.2021.10.15.04.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 04:59:21 -0700 (PDT)
Subject: Re: [PATCH -next] Fix null pointer dereference in thermal_release()
To:     Yuanzheng Song <songyuanzheng@huawei.com>, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211015083230.67658-1-songyuanzheng@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4242ca53-0384-9153-c984-92969372afd3@linaro.org>
Date:   Fri, 15 Oct 2021 13:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015083230.67658-1-songyuanzheng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/10/2021 10:32, Yuanzheng Song wrote:
> If both dev_set_name() and device_register() failed, then
> null pointer dereference occurs in thermal_release() which
> will use strncmp() to compare the name.
> 
> So fix it by adding dev_set_name() return value check.
> 
> Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>

Applied, thanks

> ---
>  drivers/thermal/thermal_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9e243d9f929e..6904b97fd6ea 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -904,6 +904,10 @@ __thermal_cooling_device_register(struct device_node *np,
>  		goto out_kfree_cdev;
>  	cdev->id = ret;
>  
> +	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> +	if (ret)
> +		goto out_ida_remove;
> +
>  	cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
>  	if (!cdev->type) {
>  		ret = -ENOMEM;
> @@ -918,7 +922,6 @@ __thermal_cooling_device_register(struct device_node *np,
>  	cdev->device.class = &thermal_class;
>  	cdev->devdata = devdata;
>  	thermal_cooling_device_setup_sysfs(cdev);
> -	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>  	ret = device_register(&cdev->device);
>  	if (ret)
>  		goto out_kfree_type;
> @@ -1229,6 +1232,10 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  	tz->id = id;
>  	strlcpy(tz->type, type, sizeof(tz->type));
>  
> +	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
> +	if (result)
> +		goto remove_id;
> +
>  	if (!ops->critical)
>  		ops->critical = thermal_zone_device_critical;
>  
> @@ -1250,7 +1257,6 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  	/* A new thermal zone needs to be updated anyway. */
>  	atomic_set(&tz->need_update, 1);
>  
> -	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
>  	result = device_register(&tz->device);
>  	if (result)
>  		goto release_device;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
