Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B905523FD84
	for <lists+linux-pm@lfdr.de>; Sun,  9 Aug 2020 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgHIJMe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Aug 2020 05:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgHIJMe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 9 Aug 2020 05:12:34 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A5720729;
        Sun,  9 Aug 2020 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596964353;
        bh=EvMkiAV/QPaNxSiF1QV6aIN8GUE6bYJn6W6e14MfThU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DOzwTXZctisZhFn3SMxaGkMAKPzOBqgDA8rZVkrzEHJTCnkctn56nOVEW8Bxh/KVm
         VKg3RJtRqoTwIPmAv1Nhw1q8b5G9H6u7dfMU/7CyXJUO8B2xnTmAgu7PrVH/1kUQRS
         sFbtIsBnnLeGufxim4j5A1e82yoJ4LPfGa4ztatU=
Received: by mail-lj1-f180.google.com with SMTP id t23so6504149ljc.3;
        Sun, 09 Aug 2020 02:12:33 -0700 (PDT)
X-Gm-Message-State: AOAM530jM2F/lvAc3BAx5ZZyWkOCLlRLP9cQ1xJyM9jmG98VyRBsIMjY
        2uOapglOfRYRq0W80rIFSSXAQUgXLnswGbcdixM=
X-Google-Smtp-Source: ABdhPJznCulEjN/KcLzYGMk3mIIrcG1fmWkPOR29sS+cEcZOxbPrWV3J7BBHAjxBcBj1e9zHDrdwzNW8LNaWXqSZ+VM=
X-Received: by 2002:a2e:86da:: with SMTP id n26mr10264938ljj.311.1596964351660;
 Sun, 09 Aug 2020 02:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200724180857.22119-1-krzk@kernel.org> <3522860a-8158-6e71-9d65-01d0e0c15f0d@arm.com>
In-Reply-To: <3522860a-8158-6e71-9d65-01d0e0c15f0d@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 9 Aug 2020 11:12:20 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe3OeKFhmtbF4OZup_ii_rxRHTaSK5BT-3T6ijqUukqtg@mail.gmail.com>
Message-ID: <CAJKOXPe3OeKFhmtbF4OZup_ii_rxRHTaSK5BT-3T6ijqUukqtg@mail.gmail.com>
Subject: Re: [RFC] memory: exynos5422-dmc: Document mutex scope
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 04, 2020 at 11:40:07AM +0100, Lukasz Luba wrote:
> Hi Krzysztof,
>
> On 7/24/20 7:08 PM, Krzysztof Kozlowski wrote:
> > Document scope of the mutex used by driver.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > It seems mutex was introduced to protect:
> > 1. setting actual frequency/voltage,
> > 2. dmc->curr_rate (in exynos5_dmc_get_cur_freq()).
> >
> > However dmc->curr_rate in exynos5_dmc_get_status() is not protected. Is
> > it a bug?
>
> The callback get_dev_status() from devfreq->profile, which here is the
> exynos5_dmc_get_status() should be already called with devfreq->lock
> mutex hold, like e.g from simple_ondemand governor or directly
> using update_devfreq exported function:
> update_devfreq()
>   ->get_target_freq()
>     devfreq_update_stats()
>         df->profile->get_dev_status()
>
> The dmc->curr_rate is also used from sysfs interface from devfreq.
> The local dmc lock serializes also this use case (when the HW freq
> has changed but not set yet into curr_rate.

These are different locks. You cannot protect dmc->curr_rate with
devfreq->lock in one place and dmc-lock in other place. This won't
protect it.

> > ---
> >   drivers/memory/samsung/exynos5422-dmc.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> > index 93e9c2429c0d..0388066a7d96 100644
> > --- a/drivers/memory/samsung/exynos5422-dmc.c
> > +++ b/drivers/memory/samsung/exynos5422-dmc.c
> > @@ -114,6 +114,7 @@ struct exynos5_dmc {
> >     void __iomem *base_drexi0;
> >     void __iomem *base_drexi1;
> >     struct regmap *clk_regmap;
> > +   /* Protects curr_rate and frequency/voltage setting section */
> >     struct mutex lock;
> >     unsigned long curr_rate;
> >     unsigned long curr_volt;
> >
>
> I assume this missing comment for the lock was required by some scripts.
> In this case LGTM:
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Such comments are always useful. It is also pointed by strict
checkpatch:
CHECK: struct mutex definition without comment

Best regards,
Krzysztof
