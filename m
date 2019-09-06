Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA7AB660
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbfIFKvP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 06:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfIFKvP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Sep 2019 06:51:15 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51F7214E0;
        Fri,  6 Sep 2019 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567767075;
        bh=F40/vyERzL2PLT+u7CNuLPRmvSEYRMi6jl/F1YioOow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XC7BjD4hpWNrKK1pOpCRX02SjWQJCOK5gbUvFoli/8DoHFwcrigpVQp1QjIv24WpF
         3hJfKMDgOn65XmIZDcVCGO/8Sr3r8YzUkIFTLavQgHRoyJu9StYgFHDfQQAjBcVc19
         ARQKYejAHq4EGjxZetUnrB+vwDkoilM7UE3eDMcE=
Received: by mail-lj1-f173.google.com with SMTP id x18so5611106ljh.1;
        Fri, 06 Sep 2019 03:51:14 -0700 (PDT)
X-Gm-Message-State: APjAAAUh3hVUqSUtvNoPL9Hvk3wMzH3mgRGf+L8EaQysZkHZ9arQVoot
        jxTyhOuiAabRMC2SAg8vm0gG6SQ1YA731I0QBIk=
X-Google-Smtp-Source: APXvYqwz+PkOkcsh+hE8+0p+GyRXl5rEBYk6E+6at+bWRa6Bvz54E4CXhRKX/zpdsB3GgFZGBaVFW3t88k1Ohu8cSYo=
X-Received: by 2002:a2e:8785:: with SMTP id n5mr1760238lji.210.1567767072972;
 Fri, 06 Sep 2019 03:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190906101405eucas1p2e3da7b461810a3a520e76c636a06e486@eucas1p2.samsung.com>
 <20190906101344.3535-1-l.luba@partner.samsung.com> <20190906101344.3535-2-l.luba@partner.samsung.com>
In-Reply-To: <20190906101344.3535-2-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 6 Sep 2019 12:51:01 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdLhrvqR==k4a9w9cmdnwGRYaTXC1ya+vOeVaGpML0zcQ@mail.gmail.com>
Message-ID: <CAJKOXPdLhrvqR==k4a9w9cmdnwGRYaTXC1ya+vOeVaGpML0zcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] memory: Exynos5422: minor fixes in DMC
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 6 Sep 2019 at 12:14, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Small fixes captured by static analyzes.

Explain please what are the errors being fixed. Additionally error
message from tool might be useful.

Also:
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 8c2ec29a7d57..a809fa997c03 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -269,7 +269,7 @@ static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
>         return 0;
>
>  err_free_tables:
> -       kfree(dmc->opp);
> +       devm_kfree(dmc->dev, dmc->opp);
>  err_opp:
>         dev_pm_opp_of_remove_table(dmc->dev);
>
> @@ -732,7 +732,7 @@ static struct devfreq_dev_profile exynos5_dmc_df_profile = {
>   * statistics engine which supports only registered values. Thus, some alignment
>   * must be made.
>   */
> -unsigned long
> +static unsigned long
>  exynos5_dmc_align_init_freq(struct exynos5_dmc *dmc,
>                             unsigned long bootloader_init_freq)
>  {
> --
> 2.17.1
>
