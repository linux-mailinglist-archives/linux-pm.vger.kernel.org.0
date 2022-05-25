Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA46534217
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245640AbiEYRP4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiEYRP4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 13:15:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9360FAE264
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 10:15:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so37028227lfg.7
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sI2Wocy1ntKwbEGnl4R+SFzpoCuuRMbqnsuPfEzI51w=;
        b=BmLpY+TC2QEXNErk3B5qUbojsrHYedpcVGjRX5c0z89L7OaMpOPOwVJ4RjhcalhjKI
         PD/+LL8PvHNh/gDDfy0Vnca+9RyCRmBYP/PlKAul5ez101mr39cDRdEs+gh5kVscQd1E
         YXD1Yg07UbWFeeDD2dNw+KqbTtEYmxXpyrimq2o076zFUXA+9GMQtpAAKn06ouvfIozT
         K4VAxvA65ZjsRNNn/ohvqgq8OyCjIHOMlgk9KCJpVs8be6n4CqBBK8XV9rRklGtpGO3s
         r9lnk41dFTYhZoylNEGz2E27xavSqikhxg40gtHO9tySdQ3IXTPA9bvhZquFVX98f8rD
         N8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sI2Wocy1ntKwbEGnl4R+SFzpoCuuRMbqnsuPfEzI51w=;
        b=RzpGJ7HILatSZ4rgN9NT1aLMyQHOZJ2+zFooFZBqDV2+w9O00szJcgtfolUk5Ztc0J
         VqEE0FFzrU82ELhLROX/UqA1M+HdxvNmRVHY0pgOAvwQsh8iahBKdl7pt16AjPFBXBSx
         up7WrDM8Ku3u/eZo8WkkIZQ+3XaW2kGGvOB7T7IT8jRFPgwLo5hPH+NOPHMR1EJ+2/jx
         +LNjjYT+gnE9yEHwUv1UuOdLqhFJ5KqCyrmyIIZXcfiA95C8fGH00g7wWGtwn1WLukwd
         5aTyt7F2wMjJhm4w1zJWayihAw5+aAkXdRivZ2Q88tYm1gGVlqaNOS7jfZoaNiX6WD79
         AnJw==
X-Gm-Message-State: AOAM533fyBRzJwT4t9hNjYBqlYXn29i4txf7L9EQX/PlBIJ1P1EZe85R
        hySAE1issjdXd6imWVVfdparu+D9kAHw9Ytf
X-Google-Smtp-Source: ABdhPJw9mZOmDbw8QxxV8w/apB2QQOz7tzAqEp0FDcRF4KN8AKQLDDmUd2YbM07YMjVJtq1emlzrRw==
X-Received: by 2002:a05:6512:3b88:b0:478:5a4e:8c90 with SMTP id g8-20020a0565123b8800b004785a4e8c90mr17665303lfv.43.1653498952954;
        Wed, 25 May 2022 10:15:52 -0700 (PDT)
Received: from localhost (h-85-24-188-65.A463.priv.bahnhof.se. [85.24.188.65])
        by smtp.gmail.com with ESMTPSA id e17-20020a05651236d100b004787d40697dsm1538418lfs.228.2022.05.25.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 10:15:52 -0700 (PDT)
Date:   Wed, 25 May 2022 19:15:51 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: rcar_gen3_thermal: improve logging during
 probe
Message-ID: <Yo5kRyBNxiCAWQV4@oden.dyn.berto.se>
References: <20220525151216.24133-1-wsa+renesas@sang-engineering.com>
 <20220525151216.24133-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525151216.24133-2-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2022-05-25 17:12:16 +0200, Wolfram Sang wrote:
> When setting up a new board, a plain "Can't register thermal zone"
> didn't help me much because the thermal zones in DT were all fine. I
> just had a sensor entry too much in the parent TSC node. Reword the
> failure/success messages to contain the sensor number to make it easier
> to understand which sensor is affected. Example output now:
> 
> rcar_gen3_thermal e6198000.thermal: Sensor 0: Trip points loaded: 1
> rcar_gen3_thermal e6198000.thermal: Sensor 1: Trip points loaded: 1
> rcar_gen3_thermal e6198000.thermal: Sensor 2: Trip points loaded: 1
> rcar_gen3_thermal e6198000.thermal: Sensor 3: Can't register thermal zone
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index ccdf8a24ddc7..ca5558178374 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -511,7 +511,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
>  							    &rcar_gen3_tz_of_ops);
>  		if (IS_ERR(zone)) {
> -			dev_err(dev, "Can't register thermal zone\n");
> +			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
>  			ret = PTR_ERR(zone);
>  			goto error_unregister;
>  		}
> @@ -533,7 +533,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto error_unregister;
>  
> -		dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
> +		dev_info(dev, "Sensor %u: Trip points loaded: %u\n", i, ret);
>  	}
>  
>  	if (!priv->num_tscs) {
> -- 
> 2.35.1
> 

-- 
Kind Regards,
Niklas Söderlund
