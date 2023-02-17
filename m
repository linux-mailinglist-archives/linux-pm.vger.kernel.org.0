Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD169A575
	for <lists+linux-pm@lfdr.de>; Fri, 17 Feb 2023 07:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBQGDo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Feb 2023 01:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBQGDn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2023 01:03:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15DA211DE
        for <linux-pm@vger.kernel.org>; Thu, 16 Feb 2023 22:03:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B61861277
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 06:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D21C4339C
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 06:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676613819;
        bh=DywB9X931dYpzWP90TjnxeFMkF19ygIrzGTfPMEKafY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YOWJmcnlBsFDL9gNNYM/LYlCXcBMAXyYio/DTkqnrgD0LDHP+VhcKOasO6N7950E/
         1RvEErPAKvYxjbztWowZ9BaUBJkUv1dbWKeXegZF9vqjECX0gLf7n73zZNUAKZifq5
         BgG2sddKQHxACiSw2jQOw5/FzxY7DI/b+NMmcy41Gcbi2TeUwbH7sCUTMHk/77/kA1
         Ft0vZFy73sW7aIbupTxE9tZ/mgTPNE6WmVtdBil55tVEpWHXE47M5j0fIDSsgSw7aG
         CDNFqMs3X7ChMbDb2xMKvPm+/SLiVAob1cx/I71/2o3wgOymrKJUjRRPZj+xRq/fuB
         M8j4xMQW7CRTA==
Received: by mail-vs1-f52.google.com with SMTP id k4so4518351vsc.4
        for <linux-pm@vger.kernel.org>; Thu, 16 Feb 2023 22:03:39 -0800 (PST)
X-Gm-Message-State: AO0yUKUjllUTvqrl6Hluq0Z3DAxwH7aqpCcnvoU3UlqUnhop+6NliVBk
        4Bvmaqv7ibC+F9jx0pzXq1F0AAb9xzpVsbn13SB4rg==
X-Google-Smtp-Source: AK7set/SNybjJrtBUBvHw30NMjPKdxhhc+qpYd8hMX85jaCVgzzyVI7eteev3ae0hkZtI8pnLd/QNthEqdKeTNaf3yk=
X-Received: by 2002:a05:6102:209e:b0:3f9:ce06:90ff with SMTP id
 h30-20020a056102209e00b003f9ce0690ffmr1708242vsr.35.1676613818580; Thu, 16
 Feb 2023 22:03:38 -0800 (PST)
MIME-Version: 1.0
References: <202302171138053231478@zte.com.cn>
In-Reply-To: <202302171138053231478@zte.com.cn>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Fri, 17 Feb 2023 11:33:27 +0530
X-Gmail-Original-Message-ID: <CAHLCerPZ4JfWCNTOmkF9EYsVME2Z_EXY0uG9RchqPR+KOTwccQ@mail.gmail.com>
Message-ID: <CAHLCerPZ4JfWCNTOmkF9EYsVME2Z_EXY0uG9RchqPR+KOTwccQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/tsens: Use devm_platform_ioremap_resource()
To:     ye.xingchen@zte.com.cn
Cc:     daniel.lezcano@linaro.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        rafael@kernel.org, rui.zhang@intel.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 17, 2023 at 9:08 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to Use devm_platform_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Acked-by: Amit Kucheria <amitk@kernel.org>

> ---
>  drivers/thermal/qcom/tsens.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 8020ead2794e..bfe7e4728cf0 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -876,7 +876,6 @@ int __init init_common(struct tsens_priv *priv)
>         void __iomem *tm_base, *srot_base;
>         struct device *dev = priv->dev;
>         u32 ver_minor;
> -       struct resource *res;
>         u32 enabled;
>         int ret, i, j;
>         struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
> @@ -887,8 +886,7 @@ int __init init_common(struct tsens_priv *priv)
>         if (op->num_resources > 1) {
>                 /* DT with separate SROT and TM address space */
>                 priv->tm_offset = 0;
> -               res = platform_get_resource(op, IORESOURCE_MEM, 1);
> -               srot_base = devm_ioremap_resource(dev, res);
> +               srot_base = devm_platform_ioremap_resource(op, 1);
>                 if (IS_ERR(srot_base)) {
>                         ret = PTR_ERR(srot_base);
>                         goto err_put_device;
> @@ -906,8 +904,7 @@ int __init init_common(struct tsens_priv *priv)
>         }
>
>         if (tsens_version(priv) >= VER_0_1) {
> -               res = platform_get_resource(op, IORESOURCE_MEM, 0);
> -               tm_base = devm_ioremap_resource(dev, res);
> +               tm_base = devm_platform_ioremap_resource(op, 0);
>                 if (IS_ERR(tm_base)) {
>                         ret = PTR_ERR(tm_base);
>                         goto err_put_device;
> --
> 2.25.1
