Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA685788447
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 12:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjHYKIK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 06:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbjHYKH4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 06:07:56 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7257170F
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 03:07:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d77b9d574f8so704236276.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692958073; x=1693562873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HW2UAF/HSUIpmZEoZVJNF0dPuvEW58zX0YFi51LhB1E=;
        b=b3UMKdL2iuUpE6zhi/YRcnml7zUhIBr/ysr7d7OvrWUPMA2p/iPFOJoZzH8iek6u21
         p6nwMDPhYozdS3G5HqR/Zh0LL58cWOgiawMAswE35kpwr1MraB50LR1pyhwNP/RiBWdB
         IYC3meTb/ym87FSeSeCL2dDlT6eEjVB6a0FUsp+gf5KTQSM06ejmQ8oFT5i3d/YjmrG9
         R1zM0aBNyAR7T9ARkn9nzV56cLdrlwMMIvF12wZDsMjISue58N913b2bThfdfl4tK0re
         CQzP1YMFalw1HzYGo2y9EXz13drwvOVNSTbUMlSXtb/I5Pv9AveIHsnfqoyexoB3jSyv
         70Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692958073; x=1693562873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HW2UAF/HSUIpmZEoZVJNF0dPuvEW58zX0YFi51LhB1E=;
        b=lt0rUDhwUIMcqbiyb4dFz3C+JRv0UYVhEa11LJiW8E4uEaCnAjlZnujDElWEmjruV0
         SfIUsOM5k2Vy7jMWFLY3nbEpRxg7BNyKYPBTtiQ4wdl633dl3S9JEUT8IB49xU6ngx91
         AUAzJi6xy02uw/qQMZglna6/CLS9TZ5OaYGqyz8PyMd5Sr5QWD6tk7uYBYNXUOYdD9gT
         pKLyEnD+rvtA6u5GvgIBv/wHno2c6Cz1wsUAa8i9VYbyvLnP8R1fVZDQYu4ibHFUXHlk
         RFUdwQjw+kgBseBimYcNVBxJ63mrDuZfcxNdP0YDdiiJGH0nZy1xvWlIohYIDewknUl3
         6McA==
X-Gm-Message-State: AOJu0Yz1KHEx8Z+9B7Wb/IJh+1Dsq4YQnGv4afKMw+Wdtupw09RbrDut
        yOGrsRujpXjw+AyKkNBhYyH7yeNZXm/LbbeDOw630w==
X-Google-Smtp-Source: AGHT+IGrY/SuELYe2QJoSZ91zaP3rjUC9R5T6a9GvcGhiDoaU9nFEc/WpF/A5UvPtJC28KU4TeQ0sJogFfgsSye5jJ0=
X-Received: by 2002:a25:7656:0:b0:c4b:ada8:8b86 with SMTP id
 r83-20020a257656000000b00c4bada88b86mr18833327ybc.64.1692958072991; Fri, 25
 Aug 2023 03:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230818070149.23103-1-zhangzekun11@huawei.com> <CAPDyKFrL86MdfUwYm9UWy4AZtWBq0j_6sP8rimF7fwEXh0XtRw@mail.gmail.com>
In-Reply-To: <CAPDyKFrL86MdfUwYm9UWy4AZtWBq0j_6sP8rimF7fwEXh0XtRw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Aug 2023 12:07:17 +0200
Message-ID: <CAPDyKFqR3jBR=oUDw-cqjpbOSaMC3pXBZ3DTwsJc0UZoohPsfA@mail.gmail.com>
Subject: Re: [PATCH] soc: ti: Use for_each_node_with_property() simplify code logic
To:     Zhang Zekun <zhangzekun11@huawei.com>
Cc:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 18 Aug 2023 at 11:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 18 Aug 2023 at 09:10, Zhang Zekun <zhangzekun11@huawei.com> wrote:
> >
> > Introduct for_each_node_with_property() to iterate through the
> > nodes, this can simplify the code logic a bit, no functional
> > change here.
>
> I would prefer if we can start using the prefix "genpd: ti*" for the
> commit message header.
>
> >
> > Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
>
> This looks good to me and I can pick it up, but awaiting and ack from
> the soc maintainers too.

Applied for next and by amending the commit msg header, thanks!

Kind regards
Uffe


>
> Kind regards
> Uffe
>
> > ---
> >  drivers/genpd/ti/ti_sci_pm_domains.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/genpd/ti/ti_sci_pm_domains.c b/drivers/genpd/ti/ti_sci_pm_domains.c
> > index a33ec7eaf23d..34645104fe45 100644
> > --- a/drivers/genpd/ti/ti_sci_pm_domains.c
> > +++ b/drivers/genpd/ti/ti_sci_pm_domains.c
> > @@ -119,7 +119,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct ti_sci_genpd_provider *pd_provider;
> >         struct ti_sci_pm_domain *pd;
> > -       struct device_node *np = NULL;
> > +       struct device_node *np;
> >         struct of_phandle_args args;
> >         int ret;
> >         u32 max_id = 0;
> > @@ -138,11 +138,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
> >         INIT_LIST_HEAD(&pd_provider->pd_list);
> >
> >         /* Find highest device ID used for power domains */
> > -       while (1) {
> > -               np = of_find_node_with_property(np, "power-domains");
> > -               if (!np)
> > -                       break;
> > -
> > +       for_each_node_with_property(np, "power-domains") {
> >                 index = 0;
> >
> >                 while (1) {
> > --
> > 2.17.1
> >
