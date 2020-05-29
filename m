Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB31E8025
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 16:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE2OZn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 10:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgE2OZn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 10:25:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5FC03E969;
        Fri, 29 May 2020 07:25:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so2849817ljn.4;
        Fri, 29 May 2020 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+x/HozBMUVG0fYhv606kvBcyvrxPAixfEDDmKOre/r0=;
        b=F3jDGaN78tmB4Pdu9T/Ke3U3OlCn/Qz8z7UE6eoGNpXSWAA32ttpTlLTCEtW4LOTmP
         z/h0iPu7wQeK4yDvv2y/uQfp26YdmzVZdiaqBm1IdROy4dZC9rnFScYoyS/2FHz+XQH8
         poHryAAeGoGeP2HGkD04Cge2ePMcQ4qvMypNiU0O4KthC/InZBP6eebjNRHnPx8k8RUT
         uBlQ4VXM8zCf6PrLEE7S/vf8xKimXvo+irHVx8MEbG0Laxp3EDrESOJTO6XJ/FlxLiPB
         w+pmc9lcrM1/oMR2r97gERdUTEmUMdnCOPoWBy64xn1qRMTXRV0QDuQH1pQfhPKuGgWo
         pSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+x/HozBMUVG0fYhv606kvBcyvrxPAixfEDDmKOre/r0=;
        b=pZu5klOm1DNNmTiJbdFJbmamtdD7NdAV595dXsWZWfqbhk2vV5l3+tPsXn9tA5KG+o
         /3pk7U1Ma9g1wxRi5QvexozOeA/ZkGaj89dvGDzGBJcK+yQgf5PVuqLCJrzc06qWx0QK
         17DVpAj4/BeuwScePM0DAvKQeKNnMkcV11r807aYA6BMngVYXU2iIB3xyemcOnbMBC/R
         e6GNsCRJizQkxQwMeDpoVc5xWQ6/vqQHGui26yie+YYhvX9opPNAYg3vC0kCCHA4ervL
         tU+Pj389ZEumoLltoU/phLO2KWqUZTYPNyQD7JoKeCJDPXsd6sgSiHrgzNIAe0dtXYLc
         Ye6w==
X-Gm-Message-State: AOAM533RNeC0yji/aZZneuuKPhcsZBuO6iAJK8adgjI/0E+wD+jeinv6
        rZ1GDS59XdaktFDW0+5UwSm11p7ZlUKyyN0gPqKeLn0G
X-Google-Smtp-Source: ABdhPJxBkdyQ/00pqmzdxItPvPVjZZTwKY476wSCWcKsUVy9VXdj4jQQIavPp1Cz6eUQjjyikG3GxXmjMZ/H7vJ+NzQ=
X-Received: by 2002:a2e:8755:: with SMTP id q21mr4263731ljj.123.1590762340141;
 Fri, 29 May 2020 07:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <1590371941-25430-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1590371941-25430-1-git-send-email-yangtiezhu@loongson.cn>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 29 May 2020 22:25:02 +0800
Message-ID: <CADBw62pW3StqqAm-35zSsWkTo6040zDyEG1K2+tFzE9HxuaUFw@mail.gmail.com>
Subject: Re: [PATCH] thermal: sprd: Fix return value of sprd_thm_probe()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, May 25, 2020 at 10:00 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> to check the return value and return PTR_ERR() if failed.
>
> Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Good catch. Thanks.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/thermal/sprd_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index a340374..4cde70d 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -348,8 +348,8 @@ static int sprd_thm_probe(struct platform_device *pdev)
>
>         thm->var_data = pdata;
>         thm->base = devm_platform_ioremap_resource(pdev, 0);
> -       if (!thm->base)
> -               return -ENOMEM;
> +       if (IS_ERR(thm->base))
> +               return PTR_ERR(thm->base);
>
>         thm->nr_sensors = of_get_child_count(np);
>         if (thm->nr_sensors == 0 || thm->nr_sensors > SPRD_THM_MAX_SENSOR) {
> --
> 2.1.0
>


-- 
Baolin Wang
