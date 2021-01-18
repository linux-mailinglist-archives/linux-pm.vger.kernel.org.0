Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA12F9D6B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 12:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389708AbhARLBt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 06:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389851AbhARLAo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 06:00:44 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17766C061573
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 02:59:51 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id 187so4990433vsg.4
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JseCC4p4s98iO8n50GRDW5OTWNrzI0fkECROJrjMGE=;
        b=NgUvwwdEVgWzjDusuC7Exbnd00TYCQwbBhK+jgkTlaPu4vKeTBEpdszuT1NmcjU7RU
         K/wU7GuCei7Ksbn3EUSUh10WnSiVpxcCJoI8GQWhFwL9e6vQ9uhiRRVrXiSPDwWOh8P4
         KEpx9xX+1Q/DleR8mkF95QqhiMWlCJ/itl1pTkDikHKGELohS1TjqYlVcDfTdH1nYQ+L
         uzM4qDIMYim6Pobu8lViF65Zd5oG1qaRz3CBsRH6QhPbt4K3eXgojvvRj7RaXdY9UY/s
         rYbqXPnl7c2Rnca52tZBxRtvIIb2stQYWGDigxxUkv1d2SiJj4SmKJsrUWUNclYNHHgt
         hHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JseCC4p4s98iO8n50GRDW5OTWNrzI0fkECROJrjMGE=;
        b=lGT63EuNP5hr3PZb5Om6aEvyB6VhG0VZfzD1RZnXe40Sl4cpNttHZG1z+QFlAlizCG
         Adsh2nCmjrLGPMtyFOaz9Q00/uAWjVqKUygFkflkQ/8G5Y1ZQY12jBf3a5w0gUo2rGTZ
         kIfn1Hpum/ENwBXNPcrbcNYl04s5Twwpq+OHYD5fzfSnnsjl2LeT63xeI9/nUKKZ7jW0
         U205Y+j6jv3FxLhfyCAnJ0ImNnfhjLwQSHuAdsP4XT3cYznkTekKX1IiH8BErf3P6zfP
         1KssxDMSlBzXcNMPrFoATXoo1VHnABthb9u7y/a6iZzsWwGYlTIwZ8tfBNaNLFpmueR6
         iyGA==
X-Gm-Message-State: AOAM533YxHMzoxV7L/PcQecZ4zgJ6QxwU7QhPcK/8YKbx7R770C90X0C
        CIQJl1R2Jy3uIrhMgIXNEPX702Y4yNiqhXELuukVuA==
X-Google-Smtp-Source: ABdhPJyBUJWi5Ju6Q9MQQZnOi0LMGBdZYB4kjop78cF/auEd2OIrYF41hFiNnx9zHxsaCbDoK/AC+FZvrl2eso8c+m0=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr16749532vsd.55.1610967590293;
 Mon, 18 Jan 2021 02:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20210118011330.4145-1-digetx@gmail.com> <20210118011330.4145-2-digetx@gmail.com>
 <20210118072855.anncyl6z3e5uznvd@vireshk-i7>
In-Reply-To: <20210118072855.anncyl6z3e5uznvd@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jan 2021 11:59:13 +0100
Message-ID: <CAPDyKFquCGUSTvcCpmN0vm1eGEz9B_hYSNm7wojhgwuXT=jkEQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: domains: Make set_performance_state() callback optional
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 18 Jan 2021 at 08:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-01-21, 04:13, Dmitry Osipenko wrote:
> > Make set_performance_state() callback optional in order to remove the
> > need from power domain drivers to implement a dummy callback. If callback
> > isn't implemented by a GENPD driver, then the performance state is passed
> > to the parent domain.
> >
> > Tested-by: Peter Geis <pgwipeout@gmail.com>
> > Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> > Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/base/power/domain.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 9a14eedacb92..a3e1bfc233d4 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -339,9 +339,11 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> >                       goto err;
> >       }
> >
> > -     ret = genpd->set_performance_state(genpd, state);
> > -     if (ret)
> > -             goto err;
> > +     if (genpd->set_performance_state) {
> > +             ret = genpd->set_performance_state(genpd, state);
> > +             if (ret)
> > +                     goto err;
> > +     }
>
> Earlier in this routine we also have this:
>
> if (!parent->set_performance_state)
>         continue;
>
> Should we change that too ?

Good point! I certainly overlooked that when reviewing. We need to
reevaluate the new state when propagating to the parent(s).

To me, it looks like when doing the propagation we must check if the
parent has the ->set_performance_state() callback assigned. If so, we
should call dev_pm_opp_xlate_performance_state(), but otherwise just
use the value of "state", when doing the reevaluation.

Does it make sense?

>
> >
> >       genpd->performance_state = state;
> >       return 0;
> > @@ -399,9 +401,6 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
> >       if (!genpd)
> >               return -ENODEV;
> >
> > -     if (unlikely(!genpd->set_performance_state))
> > -             return -EINVAL;
> > -
> >       if (WARN_ON(!dev->power.subsys_data ||
> >                    !dev->power.subsys_data->domain_data))
> >               return -EINVAL;
>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --
> viresh

Kind regards
Uffe
