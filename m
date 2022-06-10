Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B59D5466FB
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 15:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiFJNAV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jun 2022 09:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiFJNAU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 09:00:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEB43CBE29
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 06:00:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p18so1116421lfr.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1WVlkN+j9O2yrmJYHu/e/RTX9FG4N3bxp7VZVWMImKA=;
        b=fUG79jG7lhF37awsbk/sDeiVyV0xag+XKVjBfgMCygEIc3wM7n7+k6yssEy6qHmEsy
         Cygvc+bNCJnT0melbOcs06zikHZuTznd2o/3dMitJKAJNMmG6mdsgV44a7iRjTX7twsq
         bqEL27kq0DU1driC3wb2a3XEcNrr/mXB8ng8zDfWEaqSdHOk3f2bzc1PQL1NXpA1Xgf8
         p3+QwiwCCRPwPCX/6BWKgG98X+JAlluSolQFHfxye7IEfOAxkCgE0nlLtNcgXIj3vq3A
         hM0VTCEzaIHeyeSEgQtDPbbHy2ryMwaiwjgsIcTTP5P3zslhvWHKJZ3/EtgEWiIzPJCh
         fYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1WVlkN+j9O2yrmJYHu/e/RTX9FG4N3bxp7VZVWMImKA=;
        b=r6c2bPY0kVXRiXdAvLv94WtEltDWVY6R69LMZcSKTQJkq0CgO4X0Pf2J+7X82golIy
         P5jWcwMwn3b7DsffmEPsS8S6BPSVtceOZFjyPzOH/PvuUCBQfMwjNj4PKUHNnaqzSwM8
         Af9pib2F1mM2QdqHOtpv47c6UBJQooX1gosSAoLcNA0IgwHSf/gc9JIdnLKbGdFL2K1v
         9zpFT0BJxAIj3fABHYpcZRskbAzCXG7nZMdaCpQx/DjNkutDWvuuvJmqCoM7E9YAD5r4
         gfG/2rMPAQg4lR/xZlg/qnLDYybzaVcJLJgSBuTeqLJMU9RT0pATaQy3Y6l5da6bKICL
         x9Zw==
X-Gm-Message-State: AOAM530o7Dgb0IG/eDakoA2AFYLpj/TwRhgfxZLibuojfXOCh5PXASl9
        gU116tK3IXXcowpX8h5X/t1CwtCWOFraFw==
X-Google-Smtp-Source: ABdhPJzIuovLMBrYREHuC6TbDDdse6irHhXThv7vAOYtB+Kyc5bKxI76QDfNtgdaxQvva9tMX0c5ZA==
X-Received: by 2002:ac2:4e0a:0:b0:479:5311:52e8 with SMTP id e10-20020ac24e0a000000b00479531152e8mr14189486lfr.115.1654866015480;
        Fri, 10 Jun 2022 06:00:15 -0700 (PDT)
Received: from localhost (h-85-24-188-65.A463.priv.bahnhof.se. [85.24.188.65])
        by smtp.gmail.com with ESMTPSA id d21-20020a05651c089500b0025567827117sm4117163ljq.13.2022.06.10.06.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 06:00:14 -0700 (PDT)
Date:   Fri, 10 Jun 2022 15:00:14 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: rcar_gen3_thermal: improve logging during
 probe
Message-ID: <YqNAXofRPsDasXi4@oden.dyn.berto.se>
References: <20220609200709.4455-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609200709.4455-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2022-06-09 22:07:09 +0200, Wolfram Sang wrote:
> When setting up a new board, a plain "Can't register thermal zone"
> didn't help me much because the thermal zones in DT were all fine. I
> just had a sensor entry too much in the parent TSC node. Reword the
> failure/success messages to contain the sensor number to make it easier
> to understand which sensor is affected. Example output now:
> 
> rcar_gen3_thermal e6198000.thermal: Sensor 0: Loaded 1 trip point
> rcar_gen3_thermal e6198000.thermal: Sensor 1: Loaded 1 trip point
> rcar_gen3_thermal e6198000.thermal: Sensor 2: Loaded 1 trip point
> rcar_gen3_thermal e6198000.thermal: Sensor 3: Can't register thermal zone
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Change from v1: reword the dev_info string to be more like the original
> one. Added a check to add the plural-'s' only when needed.
> 
> Geert: is this better now?
> 
>  drivers/thermal/rcar_gen3_thermal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index ccdf8a24ddc7..f7357b5bd506 100644
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
> @@ -533,7 +533,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto error_unregister;
>  
> -		dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
> +		dev_info(dev, "Sensor %u: Loaded %u trip point%s\n", i, ret,
> +			 ret == 1 ? "" : "s");

Bikeshedding, I'm not keen on this style as it makes it harder IMHO to 
grep for log strings in the code. But I don't dislike it enough to ask 
you to change it ;-) So if you and Geert are happy with this style,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Do feel free to keep the tag if you send a version without the plural 
special case.

>  	}
>  
>  	if (!priv->num_tscs) {
> -- 
> 2.35.1
> 

-- 
Kind Regards,
Niklas Söderlund
