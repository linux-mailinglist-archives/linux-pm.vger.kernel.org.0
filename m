Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875A2786B41
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjHXJMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 05:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbjHXJMg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 05:12:36 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639DC198E
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 02:12:27 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58c92a2c52dso69582347b3.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 02:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692868346; x=1693473146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QWfWxMile/WgNFhvo8ZVwxIXeay3uNKMaVUJZ+Cgck=;
        b=uAMAMZb+Pl3xrF//1gf2QoomFCCwtreyRs4xAteq5++ErX/Jag+1pyV60vqF13g6qc
         EWQYleaROyiNyiEmpy54E9f7zGOrUG370OYBBm53fN4GEz471yoC/pFSQ4b14keMgBFm
         7ng6XIVQDxokSMklzIx+h8oZmarkKwbhTXrdGoqOePObuS5InclzCeCyXR6taZUn2/wm
         U8QcZHCo3Fu9mOTcf8df+zbEUZ95ISfluXVW/6MIO2ViQ1iN12idqCJ7OBm8cAynaU/6
         8Rsxe2AbXcTdn7pUXHPXDkQsstCnPF7swZ8nB3HO7IXLrfEtfHeOeBuSelO97JOAqEdm
         5Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692868346; x=1693473146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QWfWxMile/WgNFhvo8ZVwxIXeay3uNKMaVUJZ+Cgck=;
        b=VsFsDef1+L4KNmN0iQA47wIO4ZdAVlNfWoZzMKS+U3ojB8klaQ4qIKWqgT/MpWULQD
         NJSSHVz6H7+PgLU7Wo19FcbVjTMP5CE+PusPwJEzF/dFS2Nlqwfb2VUZYcvxRxMkt5Rt
         A1+FRLXsVZqDXEmj3E+edo/uXiwqvEFF/Q9I7mtcaiWJ/LJA97S3xOCiRBicSG1ad+9Z
         ftE9pGdoCk5yt/S/MDZUrQ+S7Ohe5f2ovylGxWEmYykXl1YMot379FuLYAX/Dq1gpcba
         rRdsxnuofI+0rnIkFIpXmo5k/7857SK8Bs8ndijOvQ5s4ooTwMwwffmTrzb8Gp82Mdsn
         J1lg==
X-Gm-Message-State: AOJu0YwS2sJh/oHGchn329yAAbZ8LFgNmrXFhKYaxDAsS5ltN4AWAXVN
        Io8PL46/qVhwzknUyLBzKSZMSitUQ29uK1/A9V2jrg==
X-Google-Smtp-Source: AGHT+IG3MvSq6xCe2a9q8hrZuopq70FerXK1DSmW4enmcJthTLxeat5RRxOKu4JoydhBbHioOu9VOWz1zigWQTudXgY=
X-Received: by 2002:a0d:d713:0:b0:56d:d58:82b7 with SMTP id
 z19-20020a0dd713000000b0056d0d5882b7mr16106989ywd.23.1692868346583; Thu, 24
 Aug 2023 02:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230823170438.2489746-1-robh@kernel.org>
In-Reply-To: <20230823170438.2489746-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 11:11:49 +0200
Message-ID: <CAPDyKFrO5B-WoWgKYbogTwUEwCqm_0A_NEn0XV8hdQtpOkE0yQ@mail.gmail.com>
Subject: Re: [PATCH v2] genpd: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev
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

On Wed, 23 Aug 2023 at 19:05, Rob Herring <robh@kernel.org> wrote:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
> v2: Previously sent for drivers/soc/. Gathered up files which got moved
>     to genpd to new patch.
> ---
>  drivers/genpd/mediatek/mtk-pm-domains.c | 2 +-
>  drivers/genpd/mediatek/mtk-scpsys.c     | 2 +-
>  drivers/genpd/sunxi/sun20i-ppu.c        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/genpd/mediatek/mtk-pm-domains.c b/drivers/genpd/mediatek/mtk-pm-domains.c
> index 354249cc1b12..ee962804b830 100644
> --- a/drivers/genpd/mediatek/mtk-pm-domains.c
> +++ b/drivers/genpd/mediatek/mtk-pm-domains.c
> @@ -8,8 +8,8 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/of.h>
>  #include <linux/of_clk.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/regmap.h>
> diff --git a/drivers/genpd/mediatek/mtk-scpsys.c b/drivers/genpd/mediatek/mtk-scpsys.c
> index 7a668888111c..b374d01fdac7 100644
> --- a/drivers/genpd/mediatek/mtk-scpsys.c
> +++ b/drivers/genpd/mediatek/mtk-scpsys.c
> @@ -7,7 +7,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
> diff --git a/drivers/genpd/sunxi/sun20i-ppu.c b/drivers/genpd/sunxi/sun20i-ppu.c
> index 98cb41d36560..8700f9dd5f75 100644
> --- a/drivers/genpd/sunxi/sun20i-ppu.c
> +++ b/drivers/genpd/sunxi/sun20i-ppu.c
> @@ -5,7 +5,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/reset.h>
> --
> 2.40.1
>
