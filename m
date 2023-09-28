Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2727B212C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 17:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjI1P0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjI1P0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 11:26:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F3FD6
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 08:26:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so20471341e87.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1695914766; x=1696519566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CZ/zDwhOQDppGR7MzKf6vb93wC4sZ+GMBUdA6oEyzhc=;
        b=RSLAdaPJwO+/y24vvPltZHVVM0MDdiditeC+n+JpdIrupPQKvjLaJhTQ96mJAszthG
         bgQ/iuDykQqKlWAZ8r2L6vf7d46aIa+IIqoqmNeukCCpg4VHWg/W+rdLYk5DxX7kKui6
         wNa42EbnY8lbApcJLsFW64o8vRkrDqybgWgDx+xnX0pIfldEtvylP3aExSNMSGU4lBLC
         m2tqJGDMrYwPaahSjCjbW8EvWqFv1cfSp+8ncxDvq5QWOQaom5fdYutEtxP0+PBziuvX
         ShsOEHlds84pyC74PMjo04IzOTki5DNMI0aF7VGIXMUgaWXPDU2ILCIisMJdDfM+vQUH
         tIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695914766; x=1696519566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ/zDwhOQDppGR7MzKf6vb93wC4sZ+GMBUdA6oEyzhc=;
        b=ZFjTo8xOz4Kz9nYtXy1+qW72hIK8OaCvyE8JutX45i0H2zvAqr8lqhwqRLor5WPWtM
         NIkuQCAvSA6N3OeyZwnIN9IswYKwEV0VIU0rVLuczcsmWchp+AYmEM0bhygscmV4EdJx
         kHjsJez6OSMB3WXrqfv3XvqB4s6tOr+PGi0fe8ti+irw6KV6Pkk7KG9hHR4TCnLhk1d7
         /EBXk5LauX77nMTeHTyY44QzmZ8dWfSXmjnowue9dRoyOij9yZnjNRHy+d63GPFRjRS3
         rMTh2umcyEYGUja8XXAicslKIUpDT8ZhUhbtD+g1680g1+Y+oum6bJttuD4kBOw5H4nF
         lxWg==
X-Gm-Message-State: AOJu0Yx6T/EfEmRQdiIc3dxthJGvPoueT4WiaVjqM0/5P5OsgMGawIxR
        DFHHwxlS0djDGkdwehtS20uICQ==
X-Google-Smtp-Source: AGHT+IG6bal1q5BD8rsgHmRKZsqcyVOUYljgwmRInLdRiM413d6FSmhVtR+qDdDt6Hwd0UTJiGpytw==
X-Received: by 2002:a05:6512:3e1e:b0:500:79a6:38d4 with SMTP id i30-20020a0565123e1e00b0050079a638d4mr1858434lfv.40.1695914766482;
        Thu, 28 Sep 2023 08:26:06 -0700 (PDT)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id c14-20020a056512104e00b005047bf13b6fsm911431lfb.134.2023.09.28.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:26:05 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:26:05 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 20/31] thermal: rcar_gen3: Convert to platform remove
 callback returning void
Message-ID: <ZRWbDfbYFGt14RXT@oden.dyn.berto.se>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
 <20230927193736.2236447-21-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927193736.2236447-21-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2023-09-27 21:37:25 +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index bd2fb8c2e968..cafcb6d6e235 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -432,14 +432,12 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
>  
> -static int rcar_gen3_thermal_remove(struct platform_device *pdev)
> +static void rcar_gen3_thermal_remove(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> -
> -	return 0;
>  }
>  
>  static void rcar_gen3_hwmon_action(void *data)
> @@ -594,7 +592,7 @@ static struct platform_driver rcar_gen3_thermal_driver = {
>  		.of_match_table = rcar_gen3_thermal_dt_ids,
>  	},
>  	.probe		= rcar_gen3_thermal_probe,
> -	.remove		= rcar_gen3_thermal_remove,
> +	.remove_new	= rcar_gen3_thermal_remove,
>  };
>  module_platform_driver(rcar_gen3_thermal_driver);
>  
> -- 
> 2.40.1
> 

-- 
Kind Regards,
Niklas Söderlund
