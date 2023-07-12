Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A7F750988
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjGLNXf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjGLNXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 09:23:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2104119A0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 06:23:07 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so114740301fa.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20221208.gappssmtp.com; s=20221208; t=1689168185; x=1691760185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cFbSFj9le/usrCi2OxYHwS0d4kbQdwC9hFOkQplOr7s=;
        b=y9Dk2RnSmhBdUuFNGlfxUKPD2/zFsx9LtPsqr3+Ll7Ldjus4MTVnbVWDhy9gXP56Wj
         uCdINq8m0ym5JfEwKMi4/uw4G34TDwII5Kbz0VuQ4BPeDmP9McF7RO4SqRUrJOYJ34wD
         I9L7llj+bdDYjwgnZTrDlTx1uxwm7jim5/tNaDVf+/IAwmWLjPFSIVk5VPgU94saeZMC
         0yvYpu2AOIYnTRIBBdVoR7S3/ZHvEu2H1TC98PujEU/R/GMQ68cLu4L/LhxZzNug1X/N
         IwoFjjZMGJ8U/gYgeb62v05NSkeNxzX4jZ1nxL79YD8h22/7nLkIfb9MqVUfvWzX9uYt
         SjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689168185; x=1691760185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFbSFj9le/usrCi2OxYHwS0d4kbQdwC9hFOkQplOr7s=;
        b=jX78n0o62BiCRFIYswUfaP5/YcORbZAXzvUwYCcloGcQniV3rT3rOe9S/pF3ZSJ6b0
         hQeg660Zy+0Veiml6TY2GpWHaT+kPe4YKY2Bm4xzAMHtTeHjeeyvRYgyn45Wacj6Ag57
         OSCBs71eiEa3dWmYiauMP7KHwYizGxq4+MBsBcbYCN+q9nu8dwgufCSB8TtWjm4X6qR1
         sXfecr2777ZtPoO7UXkfLd5WWEopm7XUo0SGMoWvBBhUDNgrAvyqeU16UY7VMCjSQm/m
         PqwdZEudIxz4AHuvW2iaVKNw9pxxB0ayAIBiqpLVCfozcE2o4mKgnzQZskVFF3IHIaTs
         5ESA==
X-Gm-Message-State: ABy/qLbRsBRiFbcDtsKpX32wn757Pv/472BJeQru14ox2qLpCqoz6Vus
        z71i95QC+ggI/p5u+ssUKfHmuw==
X-Google-Smtp-Source: APBJJlEjY62aR6eUpwBN6FjTaX14zPhrcQ7k6aIg1dZBoRF9vUfb3XIfKktTWtBpZChaqYbEu/YzfA==
X-Received: by 2002:a05:6512:2344:b0:4fb:8574:a9c6 with SMTP id p4-20020a056512234400b004fb8574a9c6mr18519564lfu.10.1689168185304;
        Wed, 12 Jul 2023 06:23:05 -0700 (PDT)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id f11-20020ac2532b000000b004fb76438a83sm709467lfh.171.2023.07.12.06.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:23:04 -0700 (PDT)
Date:   Wed, 12 Jul 2023 15:23:04 +0200
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
Subject: Re: [PATCH 21/27] thermal/drivers/rcar_thermal: Convert to platform
 remove callback returning void
Message-ID: <ZK6pOIET7MnkkP-d@oden.dyn.berto.se>
References: <20230712081258.29254-1-frank.li@vivo.com>
 <20230712081258.29254-21-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712081258.29254-21-frank.li@vivo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2023-07-12 16:12:52 +0800, Yangtao Li wrote:
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
>  drivers/thermal/rcar_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index b8571f7090aa..b4c58c5f6f6d 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -371,7 +371,7 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
>  /*
>   *		platform functions
>   */
> -static int rcar_thermal_remove(struct platform_device *pdev)
> +static void rcar_thermal_remove(struct platform_device *pdev)
>  {
>  	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
>  	struct device *dev = &pdev->dev;
> @@ -388,8 +388,6 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> -
> -	return 0;
>  }
>  
>  static int rcar_thermal_probe(struct platform_device *pdev)
> @@ -581,7 +579,7 @@ static struct platform_driver rcar_thermal_driver = {
>  		.of_match_table = rcar_thermal_dt_ids,
>  	},
>  	.probe		= rcar_thermal_probe,
> -	.remove		= rcar_thermal_remove,
> +	.remove_new	= rcar_thermal_remove,
>  };
>  module_platform_driver(rcar_thermal_driver);
>  
> -- 
> 2.39.0
> 

-- 
Kind Regards,
Niklas Söderlund
