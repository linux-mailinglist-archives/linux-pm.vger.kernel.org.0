Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3D7D60EA
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 06:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjJYEms (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 00:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYEmr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 00:42:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3869D
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 21:42:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b26a3163acso4191567b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 21:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698208965; x=1698813765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DYT1fD2DSphgBzv7/lthEuv9zef8MJVnLoaomzjgG2Y=;
        b=OJ8ne/4zQIJs5EEXfK96CAFB3NeZKlZLS6cppz/GrtqZCEUz8riVsrbwSYPsp3Fduo
         irEpGaakRokf9P+d1Tzjj2OwPCzLV8WGITuqyAHMZi6n357CnFtW0ql7JYJ4tdVU206C
         PC6kN8356wizV1rr81bWkJWYnwKT4UEvM4cI+60KfIJcjfZRbHYjkXWsE93Gv5m4Ac8U
         pv5QchzFWDZeAwobViWKeERLGG7tSrTv7KwcgJbttYmsl83ZC8sxToG7662Ds7ag1D/f
         rG9etA2LvJJgJznr7bP5WCN4IvtxPc8YTqDydEBeRpSc32y5rVvwnY7Qcv+f2E8I3dHO
         Dnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698208965; x=1698813765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYT1fD2DSphgBzv7/lthEuv9zef8MJVnLoaomzjgG2Y=;
        b=RYutjjBF+lGuwFsjXMIbHOnWbnMDD6WIkOVebLNGHjHU1QS5+89T7XTUJ8augJCpJp
         veX5zh89sFfuOGrxHOg/IkQAJbqMGnor/sl4nLu+FE61UL48w891gQPkO+CubTqfhwDS
         UsGnwcpigLcCsD15R9oK/lb2v4zkP+7LeuWJhKqZZiud0A1qpcT71yqXSsSVI3TqkgIO
         q97UEsvi069asqXFvMDCzc0wzfADm2b5iu6P1Y76GOKmXX8LGkG20xcqiG/66x638PsV
         VkNTwsD5RDLzsVgKQoFRBPUoWEUuCIt2/cVnrxctBWixW+MknwuqSIn/+NWbTELgTbul
         2ytw==
X-Gm-Message-State: AOJu0Yw/IN921JJf5ep1Za1rVJY1WsPVypo1xNGwP16fa7I+r0/Bil0r
        JIZPiSiNl06kLrngHUAqGi1W6w==
X-Google-Smtp-Source: AGHT+IHXUgyAMjaplGIdpYuyGXtJQ3ip1euOz4PIECNYhiBrZy4Z8+5Ri36HgQQcdQEuEOCY+x2gjA==
X-Received: by 2002:a05:6a00:2395:b0:6bd:9588:bd67 with SMTP id f21-20020a056a00239500b006bd9588bd67mr12254737pfc.24.1698208965219;
        Tue, 24 Oct 2023 21:42:45 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id z21-20020aa785d5000000b006979f70fdd5sm8387170pfn.219.2023.10.24.21.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 21:42:44 -0700 (PDT)
Date:   Wed, 25 Oct 2023 10:12:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/1] cpufreq: arm: Kconfig: Add i.MX7 to supported SoC
 for ARM_IMX_CPUFREQ_DT
Message-ID: <20231025044241.l7pqebusowbk3zsj@vireshk-i7>
References: <20231023094701.374791-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023094701.374791-1-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-23, 11:47, Alexander Stein wrote:
> Since commit a5a9dffcc903 ("ARM: imx: Switch imx7d to imx-cpufreq-dt
> for speed-grading") i.MX7 uses this driver as well. Add it to the
> description text.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 207618043ee0..f911606897b8 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -124,8 +124,8 @@ config ARM_IMX_CPUFREQ_DT
>  	tristate "Freescale i.MX8M cpufreq support"
>  	depends on ARCH_MXC && CPUFREQ_DT
>  	help
> -	  This adds cpufreq driver support for Freescale i.MX8M series SoCs,
> -	  based on cpufreq-dt.
> +	  This adds cpufreq driver support for Freescale i.MX7/i.MX8M
> +	  series SoCs, based on cpufreq-dt.
>  
>  	  If in doubt, say N.

Applied. Thanks.

-- 
viresh
