Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189675B3F73
	for <lists+linux-pm@lfdr.de>; Fri,  9 Sep 2022 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiIITYM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Sep 2022 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiIITYL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2022 15:24:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89791449C7
        for <linux-pm@vger.kernel.org>; Fri,  9 Sep 2022 12:24:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s10so2406200ljp.5
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2022 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=FullVTAt4NLdIeDKelIlCFqGink5lLzTlWXTWIoGShU=;
        b=gY7m5pkzHy9mVSPHdaIRzFpSD5O8vMgSFKnzkWSWOvdqJ91rm8AxYSjgqnXlB0PMQV
         uEuwbcIjgM8TeBsRJOpLXjP14xJzR8FEkO46TBZFDbS4lc1Yc9mZEotUGvHRooVMu2BS
         qJMHKXbr32g9pP5VOvmB3s3g8GtEyZRToMURsHxjrz4EQl3pl3mOjmaxt2qvAH0Y45Ty
         SLCqVKciLk/dvdnbF75ie9iIu5SmthPlKkxeEW4vwGhRfNdZEwFnYUcM4oy59BqJAayl
         4Fb1aGtMMq8WZzsTFmpTedDZteouaXVGsS35EmKWN6+Z1qCEtmr4zEJdKI4L3qkhOm4W
         sywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FullVTAt4NLdIeDKelIlCFqGink5lLzTlWXTWIoGShU=;
        b=EHeZE4TR+6wu8iibvuA1z/CJRNTIo10V/0ALZ7cpU5nLlRgHxYSlo58TSs9xeg+pcl
         nf3tGiHRpauVVlZDzqYXXfBuQ47NmwTl8z39RQy9KO0gAX9+LGQhXU1gQypBYg+nXkZQ
         dDfskg3HdQ8CrfEU8curjysCb8ug4ef14VdNKy3zuXNBZv1xilTHtsVJtt5PaccU7KzX
         tJl5djuDcKaKq6KRyWFE/nDw7CJyxk/77YreEnaHoX1SBj6umcwT0K3AOAkxuo6JMgfP
         QqBCeItED4iXz1kpTtbR5umjoCteDaQryZvV4/TVlYHU+kBtsL1rMpCC81Nz4hvo2BTz
         5dBg==
X-Gm-Message-State: ACgBeo2UtcLny4RY88bZRnscgtXv+BPM4adphaRSbYH7dgSkvLDr2Tum
        +QlgoLmbkYVwZpnKcz7gooreEQ==
X-Google-Smtp-Source: AA6agR7Xty6bEZNFwVc9o5UlVTQNSYuLoZRzQM8sveYXmZcNyTkmFx7ajfrc9c6uuG8EUv5awnTy4w==
X-Received: by 2002:a2e:92c4:0:b0:25d:9d30:5d61 with SMTP id k4-20020a2e92c4000000b0025d9d305d61mr4726427ljh.202.1662751446993;
        Fri, 09 Sep 2022 12:24:06 -0700 (PDT)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id e22-20020ac24e16000000b004926689d410sm28982lfr.171.2022.09.09.12.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:24:06 -0700 (PDT)
Date:   Fri, 9 Sep 2022 21:24:05 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH] thermal: rcar_thermal: Constify static
 thermal_zone_device_ops
Message-ID: <YxuS1ZjrPzTvMQWg@oden.dyn.berto.se>
References: <20220909182838.11154-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909182838.11154-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lad,

Thanks for your work.

On 2022-09-09 19:28:38 +0100, Lad Prabhakar wrote:
> The only usage of rcar_thermal_zone_of_ops is to pass its address to
> devm_thermal_of_zone_register(), which takes a pointer to const struct
> thermal_zone_device_ops. Make it const to allow the compiler to put
> it in read-only memory.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Niklas S�derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 4df42d70d867..61c2b8855cb8 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -316,7 +316,7 @@ static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
>  	return 0;
>  }
>  
> -static struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
> +static const struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
>  	.get_temp	= rcar_thermal_get_temp,
>  };
>  
> -- 
> 2.25.1
> 

-- 
Kind Regards,
Niklas S�derlund
