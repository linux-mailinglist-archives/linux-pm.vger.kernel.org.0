Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2743D39B446
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFDHtM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 03:49:12 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:42846 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDHtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 03:49:12 -0400
Received: by mail-vs1-f45.google.com with SMTP id l25so4358379vsb.9
        for <linux-pm@vger.kernel.org>; Fri, 04 Jun 2021 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAB/6IiQvwK0vmBrSOZ9AHubgs5wVP5OCQaOTQungHU=;
        b=r93Hcf2gKDxJxD7sCL4J7UW+y0jeQPhM6p6WHB2EqitRejm7Sie6mSX2PbGLo32str
         /umn9/KuKqntcE+dHSoTrjxSOcVd8D9wuxgMsFbuGq+Tuzrd4pF3D4QkQfz7vavo+Q51
         Lp+EQn7l2s7xPJMsdaNZVWBdcdQSZP4LNyLSbseK89q1hqnjXYIkm+893d0ZcZ8WPmBa
         cG9kfD+wxg5HGm2xYjI2FqmS2hLjKAPGju1OqW70FG7yTwlo2Wv6tWhmsWvyj/RlhmG7
         wyFLvGJ1+Q9CqbK815zv1uM0NaLEkPeLs+n0/88TUuHByqfUx7sK8bHTsd6YgU0khUx6
         VelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAB/6IiQvwK0vmBrSOZ9AHubgs5wVP5OCQaOTQungHU=;
        b=EBtMB3MDqesj15Au5uFUliCfHzDS9HYe/Z5o9KN+P2qRrAQtBraeg3psklvYHyxMIN
         WnwFtD/rF4j22fD+EjmbYl9yNGxK9BUmjLQUDugO91xM5Tek3E23caqRNZS2f0JX6gMg
         JpjSGy3m3tsQmx0R8fMByEc7vG8nGv3mu60QHdrnj4bRcKPcMULRrt8mlmoQX5jhsPIg
         9QXJq1vSNMejeGUhZLc4FtSGWN2ewy+aTSHsIB2X1/3cIKywgDwUYp7sGqpmWZ52a0db
         VmaSG+uWfhIqBSsEzaGo6mlX1K6bAVyr7h+e2u125THmRzaiVeuNwQ8wugoBviObrLfr
         ldow==
X-Gm-Message-State: AOAM530Q4n84nDicaFTGN80UhywodDxN+ZDGi+c/cjDxQzpEuw4tavnV
        76/pflZ6gSAd3z9E/uZCrrmTI36d9BomJpGLwj2vfw==
X-Google-Smtp-Source: ABdhPJxqmRIMNdHoQPDaXbkzRDE9ksj8Rs359ZncrcvP+073drlrxwxQ3qVjrviyosUp/MSSCg6/Hgu2SONimB0b+MU=
X-Received: by 2002:a05:6102:7c1:: with SMTP id y1mr1562104vsg.34.1622792771894;
 Fri, 04 Jun 2021 00:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-4-ulf.hansson@linaro.org> <20210603095538.b2t3cq25tq7v7kih@vireshk-i7>
 <CAPDyKFqNNeeMo6+gKgaPtPvgC_NuMxxYKkr+TzyP3vjYoHoDOw@mail.gmail.com>
 <CAPDyKFofsuY_RAMGsRLtKo=JxJ11DgGqOijZEEf1HEANCvomzg@mail.gmail.com> <20210604035312.jp2gshfigsodwvcg@vireshk-i7>
In-Reply-To: <20210604035312.jp2gshfigsodwvcg@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Jun 2021 09:45:35 +0200
Message-ID: <CAPDyKFq=mGOqYrX5322JOmJXm6Yg-zNh+g66BdaVVfE5JgciAQ@mail.gmail.com>
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

On Fri, 4 Jun 2021 at 05:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-06-21, 13:17, Ulf Hansson wrote:
> > On Thu, 3 Jun 2021 at 12:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > +static int genpd_drop_performance_state(struct device *dev)
> > > > > +{
> > > > > +     unsigned int prev_state = dev_gpd_data(dev)->performance_state;
> > > > > +
> > > > > +     if (!genpd_set_performance_state(dev, 0))
> > > > > +             return prev_state;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static void genpd_restore_performance_state(struct device *dev,
> > > > > +                                         unsigned int state)
> > > > > +{
> > > > > +     if (state)
> > > >
> > > > I will skip this check, as we are checking it in
> > > > genpd_set_performance_state() anyway ?
> > >
> > > I don't want us to override OPP votes made by the subsystem/driver
> > > level runtime PM callbacks. For example, if the drivers manage this
> > > thing themselves, that should be preserved.
> > >
> > > That said, by the check above I want to avoid setting the state to
> > > zero internally by genpd, if the driver level ->runtime_resume()
> > > callback has already restored the state.
> >
> > Ehh, forget about what I said about the ->runtime_resume() callback.
> >
> > I am mostly trying to avoid restoring a state that is zero, just to be
> > sure nobody else on some different level outside gendp, have decided
> > to set a new OPP in-between our calls to
> > genpd_drop|restore_performance state.
>
> What stops the core to call genpd_drop_performance_state() in the
> first place here, if the driver was doing its own thing ? If that gets
> called, then restore should be without any checks IMO. The state
> should already be 0 at this point of time, I don't know why this will
> get called again with state 0, but it will have no effect.
>
> Can you give some sort of flow sequence where I can see the problem a
> bit more clearly ?

Starting calls from the subsystem/driver:

------
dev_pm_genpd_set_performance_state(dev, 100);
"run a use case with device runtime resumed"
...
"use case ends"
dev_pm_genpd_set_performance_state(dev, 0);
pm_runtime_put()
    ->genpd_runtime_suspend()
    gpd_data->performance_state == 0, -> gpd_data->rpm_pstate = 0;
...
"new use case start"
dev_pm_genpd_set_performance_state(dev, 100);
pm_runtime_get_sync()
    ->genpd_runtime_resume()
    gpd_data->performance_state == 100, -> gpd_data->rpm_pstate = 0;
(This is where we need to check for "zero" to not override the value)
.....
------

I wouldn't say that the above is the way how I see the calls to
dev_pm_genpd_set_performance_state (or actually
dev_pm_opp_set_rate|opp()) being deployed. The calls should rather be
done from the subsystem/driver's ->runtime_suspend|resume() callback,
then the path above would work in the way you suggest.

Although, as we currently treat performance states and power states in
genpd orthogonally, I wanted to make sure we could cope with both
situations.

Did this help? :-)

Kind regards
Uffe
