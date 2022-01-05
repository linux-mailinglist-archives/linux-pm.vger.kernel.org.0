Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90C04858F6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jan 2022 20:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243390AbiAETNd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jan 2022 14:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243383AbiAETNd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jan 2022 14:13:33 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FC2C061245
        for <linux-pm@vger.kernel.org>; Wed,  5 Jan 2022 11:13:32 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p13so54977314lfh.13
        for <linux-pm@vger.kernel.org>; Wed, 05 Jan 2022 11:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2HdX9pP3Q9Z4uX3aqatRsjO5Pcb0UlsROg+qvzlzu6U=;
        b=4Ia3W4Dly6LiEQ5rKk1rFgj2unuQVnuNkmEoWAgTiBmpoDUNo6KDtGSZKFElawIMBB
         QwE/6lc0CZwbDgzPZ2bbDKdrYLRT11UUM+csHe46QZkEXwHi1FlJeynWBRWqqHoWgDAy
         2q05fAIpz6T9XP0OK8KtjGn/ZvyU9+WG2OoxJkBJzVCoVzHEk0AYJcLkxZvxcaCxCGOf
         cDaKc7AdX+oKzmjS4H6HlDoYv9flmnakaBP8MdY8BSaZ5mf941atiIRPyzOeycPGx8xX
         sofNg01bLqJR6YyT0Khy0MLKTWHYGDlOWVZ31wCoA5FZtOIjmi87B+1tWPnopguQMhns
         ayUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2HdX9pP3Q9Z4uX3aqatRsjO5Pcb0UlsROg+qvzlzu6U=;
        b=hetZkBw+qS/gLwMBBBrDyWPTy6RwRBMhmaoDUAONY1lQMkopCgssY0B2Ujx9QZYHX9
         qyFUb9qg5LZhzvZpPG+2JOF1jRQH4yB6ZtUvd4n6M2/8bG6/V+xaIOTkpfjYBfNepblf
         WhvlgpXdmNn7GGPJCNHdPIZ8IDhXROVpkRNITe0zL1NCQP+Z8XWJOjwHFH1zYcJphtYR
         JY9C7Cx26McTWj9bDBsRE4Gnahk1mZqFkohBPZ3bFXshPZXdmWdxm/9am2RnKbaZ/MLs
         JtDhAZa4Y7ZrkpcyXyeCRYR83llpx2Zq1uchk6v60Ma+1foAQ3ftgL+8aj0HSrZIv/se
         h/tQ==
X-Gm-Message-State: AOAM533QJMkFnJjSuzd4r6um7q4CwtK8ujEBj1q5sbtNAAu2+R/9tLoW
        3xoi2iAnj6Kefccu8l9xi1aJ2g==
X-Google-Smtp-Source: ABdhPJxJkJV4hQT7Y2RsB1BpVxL1CZQl3s9UDmLuhqUBJOe3uL8T7JoZSHRH5w4BepZxn7XdgmSiNA==
X-Received: by 2002:ac2:5b9a:: with SMTP id o26mr48055390lfn.479.1641410011203;
        Wed, 05 Jan 2022 11:13:31 -0800 (PST)
Received: from localhost (h-85-24-188-65.A463.priv.bahnhof.se. [85.24.188.65])
        by smtp.gmail.com with ESMTPSA id b18sm3226047ljq.62.2022.01.05.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 11:13:30 -0800 (PST)
Date:   Wed, 5 Jan 2022 20:13:30 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] thermal: rcar_thermal: Use
 platform_get_irq_optional() to get the interrupt
Message-ID: <YdXt2mDjZ0zikbt6@oden.dyn.berto.se>
References: <20220104145212.4608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220104145212.4608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lad,

Thanks for your work.

On 2022-01-04 14:52:11 +0000, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2-v3:
> * Fixed review comment pointed by Andy
> 
> v1->v2
> * Simplified checking error code
> * Break loop earlier if no interrupts are seen
> 
> v1: https://lkml.org/lkml/2021/12/18/163
> ---
>  drivers/thermal/rcar_thermal.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index b49f04daaf47..e480f7290ccf 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	struct rcar_thermal_common *common;
>  	struct rcar_thermal_priv *priv;
>  	struct device *dev = &pdev->dev;
> -	struct resource *res, *irq;
> +	struct resource *res;
>  	const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
>  	int mres = 0;
>  	int i;
> @@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	pm_runtime_get_sync(dev);
>  
>  	for (i = 0; i < chip->nirqs; i++) {
> -		irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> -		if (!irq)
> -			continue;
> +		int irq;
> +
> +		irq = platform_get_irq_optional(pdev, i);
> +		if (irq < 0 && irq != -ENXIO) {
> +			ret = irq;
> +			goto error_unregister;
> +		}
> +		if (!irq || irq == -ENXIO)
> +			break;

This do not look correct and differs form v1.

In the old code if we can't get an IRQ the loop is continued. This is 
used to detect if interrupts are supported or not on the platform.  This 
change will fail on all systems that don't describes interrupts in DT 
while the driver can function without interrupts.

Is there a reason you wish to do this change in addition to the switch 
to platform_get_irq_optional()? If so I think that should be done in a 
separate patch.

> +
>  		if (!common->base) {
>  			/*
>  			 * platform has IRQ support.
> @@ -487,7 +494,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  			idle = 0; /* polling delay is not needed */
>  		}
>  
> -		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq,
> +		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
>  				       IRQF_SHARED, dev_name(dev), common);
>  		if (ret) {
>  			dev_err(dev, "irq request failed\n ");
> -- 
> 2.17.1
> 

-- 
Kind Regards,
Niklas S�derlund
