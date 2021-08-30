Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB48E3FB307
	for <lists+linux-pm@lfdr.de>; Mon, 30 Aug 2021 11:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhH3JUu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Aug 2021 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbhH3JUu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Aug 2021 05:20:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BE1C061575
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 02:19:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c8so17317235lfi.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pzw+rQU/7LroOYAK+nS9BT5tTrKS/NZABtpjiR6i+Uw=;
        b=g4n0e6KkqstYAYXfLtVZ6z8ps9mcdXxZDMemgfR1mW5RcHBXZKTUzzJlaEHHnrpmV4
         UeVptvlCBTKk4y25Rmgx86kEzCP/NPkNL2ZTBmZhpswN4QV+Rjz5ESvbYCpqk1uL5Fw4
         zlWkn6orfLBpW5BK5UWjguRL+PfBK8T0oNYKiLf5XpGhy+cdUK4LyflIaLprVKMp1umn
         YJo0SsY4qIzaaCBM52wYdtanJZMBpPjvcIlJiIS+yzBYHyqyvbdKEjPmy91T9T/NC0lV
         JN9tPHJE6zBTc0pe+RRZBOPux/wEq08uJCJj0MuOMPWZ1bC8GEnNKvGMBTW/xlA7RH3S
         E1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pzw+rQU/7LroOYAK+nS9BT5tTrKS/NZABtpjiR6i+Uw=;
        b=ql9kgIlQ3TNZtz2uQYKdXvcli6sSeYRu/2v4rSydVSUe/powfVpQhs9G168PJ82Z51
         cEgobyjuzr6A12PBkm9mCL7uEogyeTZ43SKklm18er+3AWekplcSRQmfJBG+H0Nhc5A/
         xzSAK6OM5OejBWZe9st+rYDOUcaK+bop1uxIgcmmjNTRFR4STeCY0tmU9u4AUEVxcU8J
         8Ug2TSaKqoPM94CUhljW0fu3351g/dvGGKjRxxJdAh7pd+H5q46tqLYHUx8lHiP3dClD
         QWYE9lczUpas+Z5XQpxLtsb+aUsOIsdVmbQ1dCk3v+fpi/4V9r1OZei2fovZkmQCOI1W
         G2Nw==
X-Gm-Message-State: AOAM532OM0h1ZvctxW+vKx4h76knCTa9oD4uZbjDQPywwxHhfP6cJ2Ju
        VU7i6xXKDBngGF2h7TJK1Tuspnr+zzn8ANHeZr8MGg==
X-Google-Smtp-Source: ABdhPJxWT8YcQ5s4ung2OKaPoLPad/GV7TbG07i+HNSy4hgGpxV5yAOOK5PYz6GGvKpQq/NBq+zCJ+CeQG7zx8Bld/Y=
X-Received: by 2002:a05:6512:3094:: with SMTP id z20mr8728652lfd.584.1630315194536;
 Mon, 30 Aug 2021 02:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210827013415.24027-1-digetx@gmail.com> <20210827013415.24027-5-digetx@gmail.com>
 <CAPDyKFqYWxY9znP1BEzogu0k7J1KRMXoSkUOeN4xHRq=gCHvTw@mail.gmail.com> <de5b2730-3032-f279-671a-b26c256b28f8@gmail.com>
In-Reply-To: <de5b2730-3032-f279-671a-b26c256b28f8@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Aug 2021 11:19:18 +0200
Message-ID: <CAPDyKFo=SFpm+uJYH4UDfKWLVnkP2cKkBcbOQeVhU5hRxHUMCw@mail.gmail.com>
Subject: Re: [PATCH v9 4/8] PM: domains: Add get_performance_state() callback
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Dmitry Baryshkov, Bjorn Andersson

On Fri, 27 Aug 2021 at 17:50, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 27.08.2021 17:23, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, 27 Aug 2021 at 03:37, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> Add get_performance_state() callback that retrieves and initializes
> >> performance state of a device attached to a power domain. This removes
> >> inconsistency of the performance state with hardware state.
> >
> > Can you please try to elaborate a bit more on the use case. Users need
> > to know when it makes sense to implement the callback - and so far we
> > tend to document this through detailed commit messages.
> >
> > Moreover, please state that implementing the callback is optional.
>
> Noted
>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/base/power/domain.c | 32 +++++++++++++++++++++++++++++---
> >>  include/linux/pm_domain.h   |  2 ++
> >>  2 files changed, 31 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> >> index 3a13a942d012..8b828dcdf7f8 100644
> >> --- a/drivers/base/power/domain.c
> >> +++ b/drivers/base/power/domain.c
> >> @@ -2700,15 +2700,41 @@ static int __genpd_dev_pm_attach(struct device=
 *dev, struct device *base_dev,
> >>                 goto err;
> >>         } else if (pstate > 0) {
> >>                 ret =3D dev_pm_genpd_set_performance_state(dev, pstate=
);
> >> -               if (ret)
> >> +               if (ret) {
> >> +                       dev_err(dev, "failed to set required performan=
ce state for power-domain %s: %d\n",
> >> +                               pd->name, ret);
> >
> > Moving the dev_err() here, leads to that we won't print an error if
> > of_get_required_opp_performance_state() fails, a few lines above, is
> > that intentional?
>
> Not intentional, I'll add another message.
>
> >>                         goto err;
> >> +               }
> >>                 dev_gpd_data(dev)->default_pstate =3D pstate;
> >>         }
> >> +
> >> +       if (pd->get_performance_state && !dev_gpd_data(dev)->default_p=
state) {
> >> +               bool dev_suspended =3D false;
> >> +
> >> +               ret =3D pd->get_performance_state(pd, base_dev, &dev_s=
uspended);
> >> +               if (ret < 0) {
> >> +                       dev_err(dev, "failed to get performance state =
for power-domain %s: %d\n",
> >> +                               pd->name, ret);
> >> +                       goto err;
> >> +               }
> >> +
> >> +               pstate =3D ret;
> >> +
> >> +               if (dev_suspended) {
> >
> > The dev_suspended thing looks weird.
> >
> > Perhaps it was needed before dev_pm_genpd_set_performance_state()
> > didn't check pm_runtime_disabled()?
>
> There are two possible variants here:
>
> 1. Device is suspended
> 2. Device is active
>
> If device is suspended, then it will be activated on RPM-resume and h/w
> state will require a specific performance state when resumed. Hence only
> the the rpm_pstate should be set, otherwise SoC may start to consume
> extra power if device won't be resumed by a consumer driver and
> performance state is bumped without a real need.
>
> If device is known to be active, then the performance state should be
> updated immediately, otherwise we have inconsistent state with hardware.
>
> For Tegra dev_suspended=3Dtrue because in general it should be safe to
> assume that hardware is suspended since it's either stopped by the PD
> driver on initial power_on or it's assumed to be disabled by a consumer
> driver during probe. Technically it's possible to check clock and reset
> state of an attached device from the get_performance_state() to find the
> real state of device, but it's not necessary to do so far.

I follow your reasoning above, but I fail to understand your point, sorry.

Your recent patch ("PM: domains: Improve runtime PM performance state
handling"), made dev_pm_genpd_set_performance_state() to call
pm_runtime_suspended(), to check whether it should assign
dev_gpd_data(dev)->rpm_pstate, which postpones the vote until the
device gets runtime resumed - or call genpd_set_performance_state() to
immediately vote for a new performance state.

That updated behaviour of dev_pm_genpd_set_performance_state should be
sufficient, I think.

In other words, please drop the "dev_suspended" parameter from the
->get_performance_state() callback, as it doesn't make sense to me.

>
> I'll add comment to the code.
>
> >> +                       dev_gpd_data(dev)->rpm_pstate =3D pstate;
> >> +               } else if (pstate > 0) {
> >> +                       ret =3D dev_pm_genpd_set_performance_state(dev=
, pstate);
> >> +                       if (ret) {
> >> +                               dev_err(dev, "failed to set required p=
erformance state for power-domain %s: %d\n",
> >> +                                       pd->name, ret);
> >> +                               goto err;
> >> +                       }
> >> +               }
> >> +       }
> >
> > Overall, what we seem to be doing here, is to retrieve a value for an
> > initial/default performance state for a device and then we want to set
> > it to make sure the vote becomes aggregated and finally set for the
> > genpd.
> >
> > With your suggested change, there are now two ways to get the
> > initial/default state. One is through the existing
> > of_get_required_opp_performance_state() and the other is by using a
> > new genpd callback.
> >
> > That said, perhaps we would get a bit cleaner code by moving the "get
> > initial/default performance state" thingy, into a separate function
> > and then call it from here. If this function returns a valid
> > performance state, then we should continue to set the state, by
> > calling dev_pm_genpd_set_performance_state() and update
> > dev_gpd_data(dev)->default_pstate accordingly.
> >
> > Would that work, do you think?
>
> To be honest, I'm now confused by
> of_get_required_opp_performance_state(). It assumes that device is
> active all the time while attached and that device is stopped on detach.
>
> If hardware is always-on, then it should be wrong to drop the
> performance state on detach.
>
> If hardware isn't always-on, then it might be suspended during
> attachment, and thus, only the rpm_pstate should be set. It's also not
> guaranteed that consumer driver will suspend device on unbind, leaving
> it active on detach, thus it should be wrong to drop performance state
> on detach.

I assume the new behaviour in dev_pm_genpd_set_performance_state()
should address most of your concerns above, no?

When it comes to the detaching, the best we can do is to drop the
performance state vote for the device, no matter if it's an always on
HW or not. Simply because after a detach, genpd loses track of the
device, which means it can't account for performance states votes for
it anyway.

>
> Hence I think the default_pstate is a bit out of touch. If this
> attach/detach behaviour is specific to QCOM driver/hardware, then maybe
> of_get_required_opp_performance_state() should be moved out to a
> get_performance_state() of the QCOM PD driver?

That may work, but I hope it's unnecessary.

Overall, the important part is the updated path in
dev_pm_genpd_set_performance_state() where we now call
pm_runtime_suspended(). I am pretty sure this should work fine for
Qcom platforms/drivers too, but let's see if Rajendra, Dmitry or Bjorn
have some concerns about this.

>
> I added Rajendra Nayak to explain.
>
> For now we're bailing out if default_pstate is set because it conflicts
> with get_performance_state().
>
> But we can factor out the code into a separate function anyways to make
> it cleaner a tad.

Yes, please.

[...]

Kind regards
Uffe
