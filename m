Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775FE399FA4
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 13:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCLTj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 07:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCLTj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 07:19:39 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0678FC06174A
        for <linux-pm@vger.kernel.org>; Thu,  3 Jun 2021 04:17:55 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id i29so2763922vsr.11
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4ObDIp6BcuLfbXjzjA+gyGEMD4dFtav2yXYyJcMRtQ=;
        b=UA0/7uockS4ysIkv6KrOoSyHbe66enVPJ+TPG+u5e9lopkcEFg5aFQZcZBJwy4UqXA
         QJy9pk2CTMDVX5RuIjC//eUktpneTYvzkiDegW7kqAOsITRsJymo5KhZbhhShF9TGPzV
         e4gKZOoKBQeoCs0tnF10/hh7lsWGaBgH4SsjhOkQE7ap8r+tE9q6OodvFhoTIniodAlO
         glAvhw4x11uXQxPKqeL2LdtZ/04/uZERRY5O/08s842rYD0oo388E9tXKfqB4UwJJp8V
         NzE0pog6T3jx5o9+Bpeby2qAt0lfeNst3qGbFxjEx3Mbty5EyGSiIkLI/MkDq5RksAmr
         0Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4ObDIp6BcuLfbXjzjA+gyGEMD4dFtav2yXYyJcMRtQ=;
        b=UcDILylGdoB6o1Z3fgmfuF08tWzHvWtb755B0HFFzWO3/h1MsifvQWwf7wSUGpxNF6
         p0LK+cuqKBOkJas3vZQqufnCcRU2s8Ggtn5KHMFAqU5EKlCMKfT74OCBTjBcVcqERRJa
         YJPG1TFJlEakDdhFsoBMyq8TvNytt9whaC8iPSAwqW3qiH2xmJLngZTwxX0ygVFiVqOi
         d9kiZPP40i+BRIjecbUoGPoWc9zDiH3xsyjqBR+Z0VDFqWRUjlvwG5jKym8FL8d8eCYY
         TkMJpW/MzRnYeeHcANS7cLYOp3nx/oeyvSviyvbPrPjmIq1pZc3GHqnCMbeZQQyIHHtY
         szaw==
X-Gm-Message-State: AOAM5327sl1iwQTPsRVC96ybusW1K7vEv8+2q5iVqsqZ9kxZcmtDbo+7
        0OW3ZHK5XeDn5JvvEgjmBfsd6vkUIgc3FVV5taGptw==
X-Google-Smtp-Source: ABdhPJyttrR1f0i6p93DW3UL+QBi7kipiNBNI1S0EoDnYGaGmoeAD7V4no8SOj3dUlgXTgT4pA/0US3xSn86y0NvYBQ=
X-Received: by 2002:a67:e359:: with SMTP id s25mr2203007vsm.55.1622719074185;
 Thu, 03 Jun 2021 04:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-4-ulf.hansson@linaro.org> <20210603095538.b2t3cq25tq7v7kih@vireshk-i7>
 <CAPDyKFqNNeeMo6+gKgaPtPvgC_NuMxxYKkr+TzyP3vjYoHoDOw@mail.gmail.com>
In-Reply-To: <CAPDyKFqNNeeMo6+gKgaPtPvgC_NuMxxYKkr+TzyP3vjYoHoDOw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Jun 2021 13:17:18 +0200
Message-ID: <CAPDyKFofsuY_RAMGsRLtKo=JxJ11DgGqOijZEEf1HEANCvomzg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 3 Jun 2021 at 12:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 3 Jun 2021 at 11:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 03-06-21, 11:34, Ulf Hansson wrote:
> > > A subsystem/driver that need to manage OPPs for its device, should
> > > typically drop its vote for the OPP when the device becomes runtime
> > > suspended. In this way, the corresponding aggregation of the performance
> > > state votes that is managed in genpd for the attached PM domain, may find
> > > that the aggregated vote can be decreased. Hence, it may allow genpd to set
> > > the lower performance state for the PM domain, thus avoiding to waste
> > > energy.
> > >
> > > To accomplish this, typically a subsystem/driver would need to call
> > > dev_pm_opp_set_rate|opp() for its device from its ->runtime_suspend()
> > > callback, to drop the vote for the OPP. Accordingly, it needs another call
> > > to dev_pm_opp_set_rate|opp() to restore the vote for the OPP from its
> > > ->runtime_resume() callback.
> > >
> > > To avoid boilerplate code in subsystems/driver to deal with these things,
> > > let's instead manage this internally in genpd.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v2:
> > >       - Rebased.
> > >       - A few minor cosmetic changes.
> > >       - Deal with the error path in genpd_runtime_resume().
> > >
> > > ---
> > >  drivers/base/power/domain.c | 27 +++++++++++++++++++++++++--
> > >  include/linux/pm_domain.h   |  1 +
> > >  2 files changed, 26 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index ef25a5b18587..e5d97174c254 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -400,6 +400,23 @@ static int genpd_set_performance_state(struct device *dev, unsigned int state)
> > >       return ret;
> > >  }
> > >
> > > +static int genpd_drop_performance_state(struct device *dev)
> >
> > What about passing the state pointer here? that will simplify the
> > callers to just a call.
>
> Not sure I get that. Can you elaborate a bit more?
>
> >
> > > +{
> > > +     unsigned int prev_state = dev_gpd_data(dev)->performance_state;
> > > +
> > > +     if (!genpd_set_performance_state(dev, 0))
> > > +             return prev_state;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void genpd_restore_performance_state(struct device *dev,
> > > +                                         unsigned int state)
> > > +{
> > > +     if (state)
> >
> > I will skip this check, as we are checking it in
> > genpd_set_performance_state() anyway ?
>
> I don't want us to override OPP votes made by the subsystem/driver
> level runtime PM callbacks. For example, if the drivers manage this
> thing themselves, that should be preserved.
>
> That said, by the check above I want to avoid setting the state to
> zero internally by genpd, if the driver level ->runtime_resume()
> callback has already restored the state.

Ehh, forget about what I said about the ->runtime_resume() callback.

I am mostly trying to avoid restoring a state that is zero, just to be
sure nobody else on some different level outside gendp, have decided
to set a new OPP in-between our calls to
genpd_drop|restore_performance state.

[...]

Kind regards
Uffe
