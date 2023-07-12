Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636BA75097F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjGLNWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 09:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjGLNWj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 09:22:39 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFEDC0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 06:22:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso112361291fa.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20221208.gappssmtp.com; s=20221208; t=1689168154; x=1691760154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=li3E/61ADcsZod/5LKw2HR315GVhjLDgclmxVHETTdU=;
        b=vr4zuyl2lwmVevSgLN6VT7Lpy4p1zh2Px0CUy22opH8BhKEMTUw5CKdfR/cLCK8iPK
         x4YyI8W8hnzF4e3rlBS0ynGh9WVddaYEqRwpmqb9ONcD92l/oELnz5CTL69U0Wvwah7q
         f7JL9jpPIUkRKGuTstdsrsC4mjv1PYCEyo1A3RV+/nIzLudDBDWlaE5AkrcjZjQP5aNd
         xnsWniweqY8WEhnXDQcry/0KfM3t+vw6+qyy+ADIlvY8VAEqJV+GdpFSxVEspbZb+ytM
         wYKodM3e2prVxnhlGEk/0jQWBvdWvdhivzyRUbtBfQZGyNQ6ehrpSzZJ4xhtMZZXxwnc
         BN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689168154; x=1691760154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=li3E/61ADcsZod/5LKw2HR315GVhjLDgclmxVHETTdU=;
        b=juv5kNA82ezzBu6yN2c0kZjxkpjh0GH351DE4/QimTmzcRciJFcTAaNbhrYjERI2kb
         nGZUc7/jVOz+m1Dnhk9RwZH6Xya6LeAVbrnvNWlIXeZwcYDY+aU+xZ9L7bKSoTGiQed5
         txU6/z8GXNfDfJTS6PGBpbbudX3HtyMckkp54RawKSYQP4t80PjkOY3FOGBGYxI7Te4M
         CrbdU1WmucF1W7Sv5qYXpho+JekOJXGWBmW3g2esWGK5k+BDSMFfU9cSaT35pLhL721u
         KONLepTKdUK8ubNSA7N3PGTxIFYZ3gBn+LJGc8zm12gENliTnoFbH54V7Yqus/Rxih/D
         370Q==
X-Gm-Message-State: ABy/qLbZqLKmFuiQZoDUaqNPa1dKqWlyK3rVua07amwDJv/9IUqZEfbE
        +Ugs5pD88DfkQU2juBz1fEG55w==
X-Google-Smtp-Source: APBJJlGdBgrCo61F9SOyQp2F2oByZi4gaqkoAQSJlEtoOkq/ftxZNCEkur9U9EKBzKrGwjTBOXqUSQ==
X-Received: by 2002:a2e:8450:0:b0:2b6:d137:b5a1 with SMTP id u16-20020a2e8450000000b002b6d137b5a1mr17662236ljh.43.1689168154106;
        Wed, 12 Jul 2023 06:22:34 -0700 (PDT)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id u6-20020a2e8446000000b002b70ae126fasm966585ljh.129.2023.07.12.06.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:22:33 -0700 (PDT)
Date:   Wed, 12 Jul 2023 15:22:32 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/27] drivers/thermal/rcar_gen3_thermal: Convert to
 platform remove callback returning void
Message-ID: <ZK6pGInuXe9wipWf@oden.dyn.berto.se>
References: <20230712081258.29254-1-frank.li@vivo.com>
 <20230712081258.29254-4-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712081258.29254-4-frank.li@vivo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2023-07-12 16:12:35 +0800, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 9029d01e029b..1405163caa34 100644
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
> 2.39.0
> 

-- 
Kind Regards,
Niklas Söderlund
