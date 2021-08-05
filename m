Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483E83E159B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 15:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbhHENYp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 09:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhHENYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 09:24:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20FEC0613C1
        for <linux-pm@vger.kernel.org>; Thu,  5 Aug 2021 06:24:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso6303825wms.5
        for <linux-pm@vger.kernel.org>; Thu, 05 Aug 2021 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Iqn99+NR+zmd9KKhJkQyCbBLw0GflZl6gBOww2IROEQ=;
        b=bntZ2ge6fBCva5wnFEiLi5KkcQnPrlapFhdlIYdpi/zryYWMl4JhyLt4t7jkgBoVyJ
         B99NN/s3Q3UpswilsW3N4F060uJGrJMPSOn+S0vGEESblbHZZ2ajFXghVNgNgZBXg4jD
         SHIxseSBoWquPW2FRcy9BKCWnlVUamaQvPuUM4tPmpaKAgSxeUuIadTIfOLw8JiSLOfb
         bCvSWkovYRsL6tBhAMKfPkZ68t+0ICdxuXlfSanQspDj80gi1WVOv4kCR8DxxashcJ3p
         JgYS3ns0cQcOCme3Pbm0/1PHopbtMYxWb9h1Y0WgR5n1Zb7L3MgX9cF2Y7STCCeKHg3W
         FsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Iqn99+NR+zmd9KKhJkQyCbBLw0GflZl6gBOww2IROEQ=;
        b=b6AW3vIR9lWZZpKsafs29G6pfOluWOCGoE8nc3pGt6AlybgAUo4iAlKw8pm4RczQ2Q
         7/hxXG9HGsyKIn+BEtx3a1lGk2Lb68i6Oqpx3MRzLs+12RSJqynA9OZpg54S/xqYuDJ+
         N+kEb92nzckvY7I6og2pn7qsG4ZFtqxd3fPhktn4K7GAHEVmLAue4lzxdz2q9nZXrLeV
         Nby+47MUT7hs9JBx8sjGCGUmfKLMVAiuQQjkG5azSj2auh6okvgeLLL1vMfa7nkwBUCh
         GYx0uyruKKQ/W28D5iqixT1kYG+X4l4nFV2zES99Pxg3kFCmK7BvoshXJCw+4/iCWRyg
         VBXA==
X-Gm-Message-State: AOAM532zvtKuk9q+LTIU7zGqpmRXUlpnY2cufbQLrqbtTEWbQaxLPg5p
        8f8MDbrF68Nz8pBTy3v7yfTpkA==
X-Google-Smtp-Source: ABdhPJwVUzR98VEgjB92sUkpVKaZ4Ofz1p2L3XASJNWwWEJZvLn12PanJY/w/oxqhpQc2OzbpJQsUg==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr4844376wmc.19.1628169868307;
        Thu, 05 Aug 2021 06:24:28 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id q17sm6203876wre.3.2021.08.05.06.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:24:27 -0700 (PDT)
Date:   Thu, 5 Aug 2021 14:24:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] mfd/cpuidle: ux500: Rename driver symbol
Message-ID: <YQvmiqe9gDJ42/0g@google.com>
References: <20210802090859.3237509-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210802090859.3237509-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 02 Aug 2021, Linus Walleij wrote:

> The PRCMU driver defines this as a DT node but there are no bindings
> for it and it needs no data from the device tree. Just spawn the
> device directly in the same way as the watchdog.
> 
> Name it "db8500-cpuidle" since there are no ambitions to support any
> more SoCs than this one.
> 
> This rids this annoying boot message:
> [    0.032610] cpuidle-dbx500: Failed to locate of_node [id: 0]
> 
> However I think the device still spawns and work just fine, despite
> not finding a device tree node.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Rafael/Daniel: it would be perfect if one of you could ACK
> this so that Lee can just merge this into the MFD tree as
> a non-urgent fix.
> ---
>  drivers/cpuidle/cpuidle-ux500.c | 2 +-
>  drivers/mfd/db8500-prcmu.c      | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidle-ux500.c
> index a2d34be17a09..f7d778580e9b 100644
> --- a/drivers/cpuidle/cpuidle-ux500.c
> +++ b/drivers/cpuidle/cpuidle-ux500.c
> @@ -117,7 +117,7 @@ static int dbx500_cpuidle_probe(struct platform_device *pdev)
>  
>  static struct platform_driver dbx500_cpuidle_plat_driver = {
>  	.driver = {
> -		.name = "cpuidle-dbx500",
> +		.name = "db8500-cpuidle",
>  	},
>  	.probe = dbx500_cpuidle_probe,
>  };
> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index 75049cf38832..64dd4f9a1e49 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -2951,14 +2951,16 @@ static const struct mfd_cell common_prcmu_devs[] = {
>  		.pdata_size = sizeof(db8500_wdt_pdata),
>  		.id = -1,
>  	},
> +	{
> +		.name = "db8500-cpuidle",
> +		.id = -1,
> +	},
>  };
>  
>  static const struct mfd_cell db8500_prcmu_devs[] = {
>  	MFD_CELL_OF("db8500-prcmu-regulators", NULL,
>  		    &db8500_regulators, sizeof(db8500_regulators), 0,
>  		    "stericsson,db8500-prcmu-regulator"),
> -	MFD_CELL_OF("cpuidle-dbx500",
> -		    NULL, NULL, 0, 0, "stericsson,cpuidle-dbx500"),

Probably neater (with less semantic changes) if you just used:

  MFD_CELL_NAME()

>  	MFD_CELL_OF("db8500-thermal",
>  		    NULL, NULL, 0, 0, "stericsson,db8500-thermal"),
>  };

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
