Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F14BA0F7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 14:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiBQNW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Feb 2022 08:22:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbiBQNWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Feb 2022 08:22:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A7D11C39
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 05:22:10 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i11so2955579lfu.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 05:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EY4j+oM8cn7vYGKtEF2tzpVEZCHYXK2JURuNjwopTw=;
        b=kduzqmfEqxbHDUgUXrQclE3JtdsvXWr75nwItngZZiLOGjCqOKwB2nRX1DL5iG6r7B
         /vGvr/TNVkOLxlBxhGRGCl3glo5yvXcxU6c7dd/s+CQoVhC14Tih0jGSWU7bKCV759N9
         0QhAU4c57O7IqgStPym1LrlxNUBcMBHwnCrLGVfowoxhj3LHmQ07Z6lHOcOFTwJ5ISL/
         QK37rfZo7xGmCvkAySuKzKu/KNjYL/UkuB//MdfnmWspBpYG2Fj9t/0Ww4Ttul5XwlqF
         CCSyBF/G3XjKV7/wQW/P3dAODzMdMCuMm6eTXefuxHtbkh2iP8gHRMv2RAWNFu9+TN1/
         8HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EY4j+oM8cn7vYGKtEF2tzpVEZCHYXK2JURuNjwopTw=;
        b=n23wMkB0/1Y919p0eB1PQ3Syt+zseqFouYrneFpYx9wFUODRAWTQrHf1ZG9pEq/H2h
         LAY9l1OybDNFy/BtZ/8exDLeWrmiWkOgYuHTi8YKpt3zUm+WQerMBzXrbZHdKfHV1ipR
         nqJi34Nqh/47+SXFR/2hexXaAFQkLyon2JTZoVb2hZJkAMOjmQXdwc8Rg3v5qt8GfJn1
         kIKYOwaREsnKxY0kgryu50dXyQt/1zdUFlsu6GEe1AXOA+XK9PUxuKpUoiXcqRueGom3
         igBMAlyKroFkM6Heq1qFVHSIQ2T7dXiSwET5xSX0bNItuSAN+0diDf5uVIYLAYqX1gM1
         Bv7w==
X-Gm-Message-State: AOAM53037MLP0SfLFTi1Nm0jV7rmn1rquZAggaBOGgY/m3ekwRkoGC0l
        chH5kS7BMtjTyMoROFFB3drPsNjgCS0QflwHa57wKg==
X-Google-Smtp-Source: ABdhPJzafXtiHCJClXvfvyVdYWtrkRnjKKOAEEPES+t05l2rICWKILqPgTORWYqMCiCakdRFT7+ODuiTJ6cX/7YSM/k=
X-Received: by 2002:a05:6512:3604:b0:443:5d4b:3760 with SMTP id
 f4-20020a056512360400b004435d4b3760mr2018666lfs.358.1645104128404; Thu, 17
 Feb 2022 05:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org> <20220130210210.549877-7-daniel.lezcano@linaro.org>
In-Reply-To: <20220130210210.549877-7-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 14:21:31 +0100
Message-ID: <CAPDyKFqY+UhY-dXN9E4cL9Me50BgUcMvCKz1_naZ7AbA_ak4kg@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] dtpm/soc/rk3399: Add the ability to unload the module
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The dtpm hierarchy can now be removed with the
> dtpm_destroy_hierarchy() function. Add the module_exit() callback so
> the module can be unloaded by removing the previously created
> hierarchy.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/rockchip/dtpm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
> index ebebb748488b..5a23784b5221 100644
> --- a/drivers/soc/rockchip/dtpm.c
> +++ b/drivers/soc/rockchip/dtpm.c
> @@ -52,6 +52,12 @@ static int __init rockchip_dtpm_init(void)
>  }
>  module_init(rockchip_dtpm_init);
>
> +static void __exit rockchip_dtpm_exit(void)
> +{
> +       return dtpm_destroy_hierarchy();
> +}
> +module_exit(rockchip_dtpm_exit);
> +
>  MODULE_SOFTDEP("pre: panfrost cpufreq-dt");
>  MODULE_DESCRIPTION("Rockchip DTPM driver");
>  MODULE_LICENSE("GPL");
> --
> 2.25.1
>
