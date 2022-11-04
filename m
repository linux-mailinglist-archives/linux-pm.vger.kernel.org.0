Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ED7619BB2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Nov 2022 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiKDPc6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Nov 2022 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiKDPcy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2022 11:32:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118312FC16
        for <linux-pm@vger.kernel.org>; Fri,  4 Nov 2022 08:32:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g62so4806460pfb.10
        for <linux-pm@vger.kernel.org>; Fri, 04 Nov 2022 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JEBUcA2t6bqsK4Hsh2ebBKZKN3WgFdpUWP7TxfqQKYY=;
        b=o1CmD/IdNI5q96kLE0W+toToUCsdEAFBMkd49bo5jyeyQu88+Hu3YRmMPOXX/ky0Yt
         WAw3L1b7/qp6DxE6XCgw6f+EAhk9p4HFy1v4d6Dml9gsJdD/HpPkSOWAfyMJiNx8DAc9
         JpIlG+/rEZ4r2hx12cbZJKm+Yek4DDzbhjvYaiwgBUrzkKiXVUkpc/4oi8jWa0Gcu+Tz
         a7GREl+55jdp/Yy8ORxJK1JWC2xQu0xaoQsuEeSmboZceuFpBIl+ZBLh92KNLR665QNr
         W5G/sBw/sDBQkpWanS94JrI5miUtMFdMNRyMeGIjMYsvJGQe4Y7ZFIwhfH1qQ6q/LHFw
         sIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEBUcA2t6bqsK4Hsh2ebBKZKN3WgFdpUWP7TxfqQKYY=;
        b=EYTA/XOxm/9GO6OnjdM/zqON/zCKF8GWnKKY6M6WUTt9GdfWbPRvduU6TOq6DZN7ms
         LE94S4mJbGnwgQhlnrdKc0dtwP8NwHtdUCp2JwuNzI001xVU/uZF1A/V83fxcVgPPegm
         dBtiiex0M1DpVx4ouJYWR6ECzGTdYSHHV+4kJJKewbn/l7+KT5XoEEO4nc/RBx3LQ+gt
         dhTjmFLdTVr/5eX2pRJJo9djxAK8kNMVHReLsm0Tfl8b8wi75B6jUgtvqMFBhR80F7Ly
         vnCBN+WLmsF19l+HveW4SWFu8fHkEymcDGXcMy6nkoa99SQJBi3ZcBA4iNcrs1+irO3U
         vq9Q==
X-Gm-Message-State: ACrzQf1UEoUbCXBuEYcqVP2fIVeOcxEPdiasQuat6AOAYRDiKxCLdLH8
        5yUKShzLsJZKRor8EpLe0s+0ZS1r9qPIANLl61eCgQ==
X-Google-Smtp-Source: AMsMyM6ZZoMhlfVRjVo5WbknplHhIA6yjPW6xCROznTYKXqTzR3KooBzxU0+EBEpgSDVc2SzjhGliCnff0IfzK6fwjo=
X-Received: by 2002:a05:6a00:1823:b0:56b:f348:998f with SMTP id
 y35-20020a056a00182300b0056bf348998fmr36258759pfa.28.1667575973544; Fri, 04
 Nov 2022 08:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221102142104.2006554-1-shawn.guo@linaro.org> <20221102142104.2006554-2-shawn.guo@linaro.org>
In-Reply-To: <20221102142104.2006554-2-shawn.guo@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Nov 2022 16:32:16 +0100
Message-ID: <CAPDyKFouo8LCrDe2tLjO=LXM3P7NDhTY2zoDzkdou+gVp8jtGQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PM: domains: Drop genpd status manipulation for
 hibernate restore
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2 Nov 2022 at 15:21, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> The genpd status manipulation for hibernate restore has really never
> worked as intended.  For example, if the genpd->status was GENPD_STATE_ON,
> the parent domain's `sd_count` must have been increased, so it needs to
> be adjusted too.  So drop this status manipulation.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Note that, I was trying to understand a little more about the
background to the below code, although it's not entirely easy to
browse the git history around this.

Unless Rafael thinks there are reasons to keep the code as is, I
wouldn't mind seeing it go away. So:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 6471b559230e..97deae1d4e77 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1374,20 +1374,7 @@ static int genpd_restore_noirq(struct device *dev)
>         if (IS_ERR(genpd))
>                 return -EINVAL;
>
> -       /*
> -        * At this point suspended_count == 0 means we are being run for the
> -        * first time for the given domain in the present cycle.
> -        */
>         genpd_lock(genpd);
> -       if (genpd->suspended_count++ == 0) {
> -               /*
> -                * The boot kernel might put the domain into arbitrary state,
> -                * so make it appear as powered off to genpd_sync_power_on(),
> -                * so that it tries to power it on in case it was really off.
> -                */
> -               genpd->status = GENPD_STATE_OFF;
> -       }
> -
>         genpd_sync_power_on(genpd, true, 0);
>         genpd_unlock(genpd);
>
> --
> 2.25.1
>
