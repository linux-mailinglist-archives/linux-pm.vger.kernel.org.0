Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBA53420D
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbiEYRLv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 13:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiEYRLu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 13:11:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3482A366B6
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 10:11:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq30so37074013lfb.3
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WYCjX5QtKBJqD2JABeX9HzAdSG6a8Grq0WGneMZcZEE=;
        b=2hT5HqVEm5g50zrmZEF9NVq8mZ86kDMKHQgo5mdbkgAIijaMqXCBJlGizl2R0+d3pM
         30ucRbkOOtWXLe8f/2F5E5ZwCa28Srfxo745/8Oh+MS4ITUoth/aCwhIOH8TYoHPnMu6
         MMUCcMz2mqXR++D2Y7q5OG4mEkSs/xdGNrrhM4N1PAdlZ4lDI5o6AOdUadx7f9Zn5Mlh
         xsPEIOVZltNydXW+2DWMcdmbLq2OqmtVg6dD/8gDOj5ejqnpLo9xE5KD70mRRyml9cjZ
         JTke2lv14j7FNJYOM5ZmGmDF9hzvOX+BP54hLJU2qf5bHOCtTmwmYH7EuZCitf03KAPU
         rgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WYCjX5QtKBJqD2JABeX9HzAdSG6a8Grq0WGneMZcZEE=;
        b=snzPum7jv5W+X+y6wEN9p2PFJanQ6/0M0DxSrmZkVkw0q9g9XVIZeWfsVFPJVrV4yN
         TuGw1W4jurDZDO3Zzzh6mjQ8fKuhiSK9J/9BvoXGJMG2ZJjlp2bHeWR0m0NmidgFURNo
         v5Ae7M3LxFh1mlsG1NMpyq5xDA9t6gfu65QlR1xAHFVCvYBmrCuk4JaVDmj6cBVYTUEJ
         /RoYdp5nu+yX69Mq525mdTyZAMf3PX5gqoTvSnVSTWkPYbcnMU3cNPEIrsB8rhsxvavz
         ygUcQPfFwSUnn1gWhRaAWzicj1IYc4AQ/N9w88WxACvOZXrCvXl5TWDPlhSItbp+mDZI
         kbXA==
X-Gm-Message-State: AOAM532DPO0yZ1rrdVu8vEGAQ8ja5OlHebS5poRjTgKcHY2jaKYB+8hk
        41MvCauLiCyESTbvNMlcgR6p+4ftI13rdoiX
X-Google-Smtp-Source: ABdhPJxpknDnQKBk4p/aZqPeZt+6ytgFyDg9KEq+55gWHBdi/p4G9h5+NS71FERfWKLIrgLhrltp/Q==
X-Received: by 2002:a05:6512:3e13:b0:471:f6a9:85d3 with SMTP id i19-20020a0565123e1300b00471f6a985d3mr23427634lfv.120.1653498707578;
        Wed, 25 May 2022 10:11:47 -0700 (PDT)
Received: from localhost (h-85-24-188-65.A463.priv.bahnhof.se. [85.24.188.65])
        by smtp.gmail.com with ESMTPSA id e1-20020ac25461000000b0047255d211d2sm3204039lfn.257.2022.05.25.10.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 10:11:47 -0700 (PDT)
Date:   Wed, 25 May 2022 19:11:46 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: rcar_gen3_thermal: Add r8a779f0 support
Message-ID: <Yo5jUjbN2xZqDfno@oden.dyn.berto.se>
References: <20220525151216.24133-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525151216.24133-1-wsa+renesas@sang-engineering.com>
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

Thanks for your patch.

On 2022-05-25 17:12:15 +0200, Wolfram Sang wrote:
> Add support for R-Car S4.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas S�derlund <niklas.soderlund@ragnatech.se>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 43eb25b167bc..ccdf8a24ddc7 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -399,6 +399,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
>  		.compatible = "renesas,r8a779a0-thermal",
>  		.data = &rcar_gen3_ths_tj_1,
>  	},
> +	{
> +		.compatible = "renesas,r8a779f0-thermal",
> +		.data = &rcar_gen3_ths_tj_1,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
> -- 
> 2.35.1
> 

-- 
Kind Regards,
Niklas S�derlund
