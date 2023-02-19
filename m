Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6123269C12C
	for <lists+linux-pm@lfdr.de>; Sun, 19 Feb 2023 16:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjBSPIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Feb 2023 10:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBSPIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Feb 2023 10:08:45 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A2D11668
        for <linux-pm@vger.kernel.org>; Sun, 19 Feb 2023 07:08:40 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z28so683978ljq.9
        for <linux-pm@vger.kernel.org>; Sun, 19 Feb 2023 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dSBge9mIuTlc4vzvyJj2lqtZNbusVps3AymwUTX05O0=;
        b=Rg8Mi4g0jIhYFY8bF3M1CocgMhbf6Jwd+9Lp7p32VUgd7WYBmWl362prsopmEmz1v6
         gqUlrYhOfRNmHMg5UgzkHwFHX0wLorFG4amGbldvxSgrJqX0aWbuMeEav8XyZOYByyFS
         sftmzfqzI7Zv3gE8NjBNZn/RAlXVaaEKjkQmDpAMd1HuweVBrY5WslRAO4lYhmc1jL9d
         ag6MECnD+FYGONxykSkOT4969YmF1bbjmdixwolttdyrtQI8KZplRvOh1pxnyZAMrl72
         LdNUIL5hHMgBpxGyj0ZlEUjDk8nDuSYRDcT41p6Afbbi19aLJ7fGntrcROk7D4fEgsc/
         ttLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSBge9mIuTlc4vzvyJj2lqtZNbusVps3AymwUTX05O0=;
        b=EdtYPxSnE078KzOpPhSDgFxAP9A3XsHjdCqF6QwVZEaV/zDXL5fws0KdXUoyb995pF
         mCwnv0ESt91GvpsZ0vWErVOo5/uAKXAkDYL2o/jeKrn9iBbBoWHshAMtNFHHC3y84IG2
         d4jq9y4vwzPktOFKEg1HZKNEWfzXrD0hYZo5CQleU6Yo7/CZzcPWbyaa3cYSwZtPzs4E
         qOYCB6o4BI9pYOHBCuqqNVVs/arN7rI1opEDUwojLwrqx4xpijMkgVP3w7xt2GBFYt6g
         /VsW4hQH8+x+0PmMXHOarpnToV72kpRBu61x+GcQjsG+izqNa8Fr7LCgvT+zY/iaazGC
         vwvg==
X-Gm-Message-State: AO0yUKXVqVFnEoQipJqrIcMLYMFqOkCMXj26F+KxPj9vWaNtWLhOZq2h
        Z38ZAzi0BwmBEfUHz0bMeRiw1A==
X-Google-Smtp-Source: AK7set9giO9XVeahsn5If/QkM7Bceqee8m29SoUZWhwnHzM4iwAul8hcSgT6JpcSwcRdV6dUhBPZ6w==
X-Received: by 2002:a2e:be93:0:b0:28b:9582:2bb with SMTP id a19-20020a2ebe93000000b0028b958202bbmr559114ljr.44.1676819318825;
        Sun, 19 Feb 2023 07:08:38 -0800 (PST)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id u12-20020ac24c2c000000b004b567e1f8e5sm1267703lfq.125.2023.02.19.07.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 07:08:38 -0800 (PST)
Date:   Sun, 19 Feb 2023 16:08:37 +0100
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v1 04/17] thermal/hwmon: Do not set no_hwmon before
 calling thermal_add_hwmon_sysfs()
Message-ID: <Y/I7dZiHqT0xH7tC@oden.dyn.berto.se>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
 <20230219143657.241542-5-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230219143657.241542-5-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Thanks for your work.

On 2023-02-19 15:36:44 +0100, Daniel Lezcano wrote:
> The thermal->tzp->no_hwmon parameter is only used when calling
> thermal_zone_device_register().
> 
> Setting it to 'false' before calling thermal_add_hwmon_sysfs() has no
> effect.
> 
> Remove the call and again prevent the drivers to access the thermal
> internals.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/broadcom/bcm2711_thermal.c | 1 -
>  drivers/thermal/broadcom/bcm2835_thermal.c | 1 -
>  drivers/thermal/rcar_gen3_thermal.c        | 1 -
>  drivers/thermal/rcar_thermal.c             | 5 -----

For R-Car,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  drivers/thermal/rockchip_thermal.c         | 1 -
>  drivers/thermal/rzg2l_thermal.c            | 1 -
>  6 files changed, 10 deletions(-)
> 
> diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
> index 18b1a4d9ecc7..0a499435431c 100644
> --- a/drivers/thermal/broadcom/bcm2711_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2711_thermal.c
> @@ -98,7 +98,6 @@ static int bcm2711_thermal_probe(struct platform_device *pdev)
>  
>  	priv->thermal = thermal;
>  
> -	thermal->tzp->no_hwmon = false;
>  	return thermal_add_hwmon_sysfs(thermal);
>  }
>  
> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
> index de2f573863da..8ed7a80122a0 100644
> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
> @@ -267,7 +267,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>  	 * Thermal_zone doesn't enable hwmon as default,
>  	 * enable it here
>  	 */
> -	tz->tzp->no_hwmon = false;
>  	err = thermal_add_hwmon_sysfs(tz);
>  	if (err)
>  		goto err_tz;
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 8ad713cb4bf7..4ea9d4bd8e6f 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -527,7 +527,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		}
>  		tsc->zone = zone;
>  
> -		tsc->zone->tzp->no_hwmon = false;
>  		ret = thermal_add_hwmon_sysfs(tsc->zone);
>  		if (ret)
>  			goto error_unregister;
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 538ed6731589..919f0e32d3c5 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -509,11 +509,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		}
>  
>  		if (chip->use_of_thermal) {
> -			/*
> -			 * thermal_zone doesn't enable hwmon as default,
> -			 * but, enable it here to keep compatible
> -			 */
> -			priv->zone->tzp->no_hwmon = false;
>  			ret = thermal_add_hwmon_sysfs(priv->zone);
>  			if (ret)
>  				goto error_unregister;
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index bd593ec712ee..3211b70c85b9 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1451,7 +1451,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < thermal->chip->chn_num; i++) {
>  		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
> -		thermal->sensors[i].tzd->tzp->no_hwmon = false;
>  		error = thermal_add_hwmon_sysfs(thermal->sensors[i].tzd);
>  		if (error)
>  			dev_warn(&pdev->dev,
> diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
> index d3ba2a74e42d..a2f21c941cfe 100644
> --- a/drivers/thermal/rzg2l_thermal.c
> +++ b/drivers/thermal/rzg2l_thermal.c
> @@ -216,7 +216,6 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
>  	}
>  
>  	priv->zone = zone;
> -	priv->zone->tzp->no_hwmon = false;
>  	ret = thermal_add_hwmon_sysfs(priv->zone);
>  	if (ret)
>  		goto err;
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
