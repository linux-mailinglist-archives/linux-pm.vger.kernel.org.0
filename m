Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B473E526
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 18:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjFZQcp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFZQco (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 12:32:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDFAC6
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:32:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so4753228e87.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20221208.gappssmtp.com; s=20221208; t=1687797161; x=1690389161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0spNFz+6TM92jRoxw5G7AF/wIRfrOXvYpPWbmprIXQ0=;
        b=bNQJ0XiyhHi5XxjG11HtTNvuMxuntTsRrq1w9EvHnyN7Zpkc8umTMfwxfdjeLOy2vs
         MN9vhfr2ork5nEb/Z0jFpfZVfiwDO7CMypPRDJVBKZHHDDsaegkZ0JIH9oa5RG49+E+W
         mrUxFr1Oy75jYbWU6giYlwttRipEzz5Cj8whYY9Tih+vgpwCLWw7h990wTlOFYDYtuMB
         E3z7euApPPR+u0f898aqxW9zBUNwQcKIV0OIgNfUNZDmVNwXgx86WIWQpOcVo10PXhB6
         6KAMMhWc18oirihv5STYNqS0J9R6jxAYvt2geSklsdeD9/m3/IZ0CNcClV9BSXsi0IzF
         9JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797161; x=1690389161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0spNFz+6TM92jRoxw5G7AF/wIRfrOXvYpPWbmprIXQ0=;
        b=mFAGFPoPg920y7CoQyu95H33vZCcTk/HDdTEjHt+yD223PlF6eD9IR2vE7CaCd47mF
         vFovHidVfy1aJZ1LPsems/VDViP80d2XG3SecH+8g2JvNEXt7qTn4rbGnb+6SeT/qE8Y
         H/mfaQO/qpnV0rxvfpsKzfSJDZQoACsMJYbUdLFt5ACRaqMVhqzE0K3+3N7QBa6VDSzE
         PMrTHILWmmOiLdtK+5WU2Gt0dStax6mOTrm9a3+aCy8dEjWT5tHeK3g0UkMlrv5gefkr
         1HWuCxcf6pW/aeNu9j2cFcV4SxFKmbiFaVOhKCz59S5AIoyFVtJoaujV9dnA+bxyE9xl
         nHXQ==
X-Gm-Message-State: AC+VfDwo0EXeOzPuFy0fWiM2Fxkt2AcVDwViM9dm9gy7m18C9PVZOHfM
        z056x6Ny+EvzSMXH6WAsC9ji6A==
X-Google-Smtp-Source: ACHHUZ6If5m3B5Z98g30pqHfybyOWpNJUXCNnfUdLuTPjPZL0VqCyS79QjQbxszAnNWWhF8w8nqX+A==
X-Received: by 2002:a05:6512:3e0e:b0:4fb:393:26c3 with SMTP id i14-20020a0565123e0e00b004fb039326c3mr2873589lfv.15.1687797160565;
        Mon, 26 Jun 2023 09:32:40 -0700 (PDT)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm1156326lfb.262.2023.06.26.09.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:32:39 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:32:38 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] thermal/drivers/rcar: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZJm9ptHGdkO8EbOd@oden.dyn.berto.se>
References: <20230626124334.15100-1-frank.li@vivo.com>
 <20230626124334.15100-5-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626124334.15100-5-frank.li@vivo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yangtao,

Thanks for your work.

On 2023-06-26 20:43:32 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/thermal/rcar_thermal.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index b8571f7090aa..04a52d82022c 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -397,7 +397,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	struct rcar_thermal_common *common;
>  	struct rcar_thermal_priv *priv;
>  	struct device *dev = &pdev->dev;
> -	struct resource *res;
>  	const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
>  	int mres = 0;
>  	int i;
> @@ -435,9 +434,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  			 * Then, driver uses common registers
>  			 * rcar_has_irq_support() will be enabled
>  			 */
> -			res = platform_get_resource(pdev, IORESOURCE_MEM,
> -						    mres++);
> -			common->base = devm_ioremap_resource(dev, res);
> +			common->base = devm_platform_ioremap_resource(pdev, mres++);

This change is fine, please post a separate patch for it.

>  			if (IS_ERR(common->base)) {
>  				ret = PTR_ERR(common->base);
>  				goto error_unregister;
> @@ -459,17 +456,13 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	}
>  
>  	for (i = 0;; i++) {
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, mres++);
> -		if (!res)
> -			break;

This change is not OK as it changes the behavior of the driver same as 
in patch 5/6.

Nacked-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> -
>  		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  		if (!priv) {
>  			ret = -ENOMEM;
>  			goto error_unregister;
>  		}
>  
> -		priv->base = devm_ioremap_resource(dev, res);
> +		priv->base = devm_platform_ioremap_resource(pdev, mres++);
>  		if (IS_ERR(priv->base)) {
>  			ret = PTR_ERR(priv->base);
>  			goto error_unregister;
> -- 
> 2.39.0
> 

-- 
Kind Regards,
Niklas Söderlund
