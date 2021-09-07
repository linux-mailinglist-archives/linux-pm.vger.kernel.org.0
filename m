Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4510A4026A0
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbhIGJ7m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244858AbhIGJ73 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 05:59:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC893C061757
        for <linux-pm@vger.kernel.org>; Tue,  7 Sep 2021 02:58:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k13so18464409lfv.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZTLi4zR4aFY8TcodEJa1buz2G69bROdSrdlPAPmsilY=;
        b=pTmLd8HTwFi9UhYcOcow/QqB/QxmdZRomDi9kPA2eitbbEkuuPO7EqYtaCT6bO52zZ
         eOojjflE7OW+XKPfxxMy0QzvmYcWn2KdUy51LRvGc/7tt1TwsdxemUVNIcdVVaqD4BD7
         Q9boyNkd+irK8EmgrxDS7eaBT7jUrrrYAJF1RCwDAQz1WjjM0vlaTrmgKBl07Lba8M9n
         8RNGzuNc2W8wuN9eE5ZmGcN+S2kzRsvMNHYqdCf3xZOnN2jOacQV794Z6h6jw+dwgfu3
         2pehJib8/Fo6dfwW0P5+NQgM8d+7oEeP0/M0AYDj8lyCcjWTQsqlnCKRAp6AL3Df44el
         /njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZTLi4zR4aFY8TcodEJa1buz2G69bROdSrdlPAPmsilY=;
        b=lqPLvVkfRIPnIIe08AowZdqP4pL9tkyaOFiLnbGCQmCfUW3CBB3Q/FEUu6tGv8uBzD
         boeFmsIBgaXXoOpJr+X+VKCGk3q1fDCXCq99ZhXE8kTcby+FqSAbaOXW1ZxUxfPv9byb
         88niZgtT2dBwaKz8PxDwfP3dmq3XobcE0vVezwasl+ycJnCmF8+xNV2Cz0qdthAhq3gw
         X+zHr5HZmyJrF15WHVd43xPshybLqvkWtCBFl9DClgijo/z0L7uKTGiOBEkk33IFr7qr
         1jAumoWe40my3KSZuvLWp4i6WZUxUxRf4xcjAhCE50dE2flKoeb6LjOOMndH2r4RSGlZ
         npLQ==
X-Gm-Message-State: AOAM5322tJMRfoIiuMljLxv/aXkWuqPKwX0g+WRQy8YhD+etH4z2cyVD
        mt/rGv9SLzUzlgBoRSCPNxXbGJMMaOdNgVQVS3kJuw==
X-Google-Smtp-Source: ABdhPJzUvDN7fTUp3Xk2hPeTqLOTCeVyaGIxF/0e8evJX4z6TVXW3S17UGT7jP0M5pefCX6oAHIPDQ6H7zshS5FGRdI=
X-Received: by 2002:a05:6512:1043:: with SMTP id c3mr11804424lfb.358.1631008700965;
 Tue, 07 Sep 2021 02:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-4-ulf.hansson@linaro.org> <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
 <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com>
 <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com> <CAPDyKFqE+thX0pLTg9d-ds7Tj3hsB78EmDB1Cryh26tN3kvQDA@mail.gmail.com>
 <3d92711f-ce30-2c19-c6a4-bb77d32df2dd@gmail.com> <CAPDyKFpJU3g2OzJeR9KUdtN-8wJsDckqVAMQMHBV=enu=DfURg@mail.gmail.com>
 <fbca049a-e673-1598-658f-a7bb5de52f18@gmail.com>
In-Reply-To: <fbca049a-e673-1598-658f-a7bb5de52f18@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Sep 2021 11:57:43 +0200
Message-ID: <CAPDyKFqw2tp3-J8dW03Kqw9xC_gO7nWfEckMvT3=zB0AbR8jeA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 6 Sept 2021 at 16:35, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 06.09.2021 13:53, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, 5 Sept 2021 at 11:11, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 03.09.2021 17:09, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Fri, 3 Sept 2021 at 12:06, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>>>
> >>>> 03.09.2021 11:55, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>> On Fri, 3 Sept 2021 at 08:00, Dmitry Osipenko <digetx@gmail.com> wr=
ote:
> >>>>>>
> >>>>>> 02.09.2021 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>>> Hardware may be preprogrammed to a specific performance state, wh=
ich may
> >>>>>>> not be zero initially during boot. This may lead to that genpd's =
current
> >>>>>>> performance state becomes inconsistent with the state of the hard=
ware. To
> >>>>>>> deal with this, the driver for a device that is being attached to=
 its
> >>>>>>> genpd, need to request an initial performance state vote, which i=
s
> >>>>>>> typically done by calling some of the OPP APIs while probing.
> >>>>>>>
> >>>>>>> In some cases this would lead to boilerplate code in the drivers.=
 Let's
> >>>>>>> make it possible to avoid this, by adding a new optional callback=
 to genpd
> >>>>>>> and invoke it per device during the attach process. In this way, =
the genpd
> >>>>>>> provider driver can inform genpd about the initial performance st=
ate that
> >>>>>>> is needed for the device.
> >>>>>>>
> >>>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>>>>> ---
> >>>>>>>  drivers/base/power/domain.c | 8 +++++---
> >>>>>>>  include/linux/pm_domain.h   | 2 ++
> >>>>>>>  2 files changed, 7 insertions(+), 3 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/dom=
ain.c
> >>>>>>> index 800adf831cae..1a6f3538af8d 100644
> >>>>>>> --- a/drivers/base/power/domain.c
> >>>>>>> +++ b/drivers/base/power/domain.c
> >>>>>>> @@ -2640,13 +2640,15 @@ static void genpd_dev_pm_sync(struct devi=
ce *dev)
> >>>>>>>       genpd_queue_power_off_work(pd);
> >>>>>>>  }
> >>>>>>>
> >>>>>>> -static int genpd_get_default_performance_state(struct device *de=
v,
> >>>>>>> +static int genpd_get_default_performance_state(struct generic_pm=
_domain *genpd,
> >>>>>>> +                                            struct device *dev,
> >>>>>>>                                              unsigned int index)
> >>>>>>>  {
> >>>>>>>       int pstate =3D of_get_required_opp_performance_state(dev->o=
f_node, index);
> >>>>>>>
> >>>>>>>       if (pstate =3D=3D -ENODEV || pstate =3D=3D -EOPNOTSUPP)
> >>>>>>> -             return 0;
> >>>>>>> +             pstate =3D genpd->dev_get_performance_state ?
> >>>>>>> +                      genpd->dev_get_performance_state(genpd, de=
v) : 0;
> >>>>>>>
> >>>>>>>       return pstate;
> >>>>>>>  }
> >>>>>>> @@ -2701,7 +2703,7 @@ static int __genpd_dev_pm_attach(struct dev=
ice *dev, struct device *base_dev,
> >>>>>>>       }
> >>>>>>>
> >>>>>>>       /* Set the default performance state */
> >>>>>>> -     pstate =3D genpd_get_default_performance_state(dev, index);
> >>>>>>> +     pstate =3D genpd_get_default_performance_state(pd, dev, ind=
ex);
> >>>>>>
> >>>>>> If base device is suspended, then its performance state is zero.
> >>>>>>
> >>>>>> When device will be rpm-resumed, then its performance should be se=
t to
> >>>>>> the default state.
> >>>>>> You're setting performance state of the wrong device, it should be=
 the
> >>>> Are you okay with my variant of handling the suspended device?
> >>>
> >>> Not sure if you intended to post this line?
> >>>
> >>> In any case, I am happy to help and review to move things forward.
> >>
> >> It's not clear to me whether you omitted handling the case of
> >> rpm-suspended device on purpose or not. I think it should be a part of
> >> this patch, but sounds like you want to work on it separately, correct=
?
> >
> > I didn't omit the handling, but instead relied solely on the
> > pm_runtime_suspended() check in dev_pm_genpd_set_performance_state().
>
> It doesn't work as expected for Tegra because pm_runtime_suspended()
> returns false while RPM is disabled and it's normally disabled at the
> attachment time.

Runtime PM is in most cases (probably all) not enabled for the device
when attaching.

This isn't specific to Tegra, but a common behavior of how it works
during attach.

>
> >>>>>> base device and not the virtual domain device.
> >>>>>
> >>>>> No I am not. :-) Let me elaborate.
> >>>>>
> >>>>> For the single PM domain case, 'dev' and 'base_dev' are pointing to
> >>>>> the same device. So this works fine.
> >>>>>
> >>>>> For the multiple PM domain case or when attaching goes via
> >>>>> genpd_dev_pm_attach_by_id(), 'dev' is the virtual device registered=
 in
> >>>>> genpd_dev_pm_attach_by_id(). In this case, it's 'dev' that is becom=
ing
> >>>>> attached to genpd and not the 'base_dev'. Note also that, runtime P=
M
> >>>>> has not been enabled for 'dev' yet at this point and 'dev' has been
> >>>>> assigned the same OF node as 'base_dev", to allow OF parsing to wor=
k
> >>>>> as is for it.
> >>>>>
> >>>>> Moreover, to deal with runtime PM in the multiple PM domain case, t=
he
> >>>>> consumer driver should create a device link. Along the lines of thi=
s:
> >>>>> device_link_add(base_dev, dev, DL_FLAG_PM_RUNTIME |
> >>>>> DL_FLAG_STATELESS), thus assigning the virtual device ('dev') as th=
e
> >>>>> supplier for its consumer device ('base_dev').
> >>>>>
> >>>>>>
> >>>>>> These all is handled properly by my patch [1]. Hence it's complica=
ted
> >>>>>> for the reason.
> >>>>>
> >>>>> See above. It shouldn't have to be complicated. If it still is, the=
re
> >>>>> is something to fix for the multiple PM domain case.
> >>>>>> [1]
> >>>> Alright, it actually works now on Tegra using the dev in the callbac=
k
> >>>> for the case of multiple domains, I re-checked it. Previously, when =
I
> >>>> tried that, there was a conflict in regards to OPP usage, I don't
> >>>> remember details anymore. Maybe the recent changes that were suggest=
ed
> >>>> by Viresh helped with that. So yes, there is no need to pass the bas=
e
> >>>> device anymore.
> >>>
> >>> Great! So, it seems like $subject patch should be a way forward for y=
ou then?
> >>
> >> The current behaviour is incorrect for Tegra because it needs to set t=
he
> >> rpm_pstate for rpm-suspended device, instead of bumping the state
> >> immediately.
> >>
> >> Power management is defeated without it on Tegra because SoC will star=
t
> >> to consume extra power while device that needs this power is suspended=
.
> >
> > Okay, I understand your concern.
> >
> > For devices that may remain runtime suspended when their consumer
> > drivers probes them, the behaviour may be suboptimal. This because it
> > could lead to having an active performance state vote for a runtime
> > suspended device, at least until it gets runtime resumed and then
> > runtime suspended again.
> >
> > This all boils down to how the consumer driver deploys support for
> > runtime PM - and genpd doesn't know nor can control that.
>
> Previously, I added the 'dev_suspended' argument to the
> dev_get_performance_state() callback to allow PD driver to decide
> whether state should applied immediately or on rpm-resume, but you asked
> to remove it because it didn't make sense to you [1].
>
> [1]
> https://lore.kernel.org/linux-pm/CAPDyKFo=3DSFpm+uJYH4UDfKWLVnkP2cKkBcbOQ=
eVhU5hRxHUMCw@mail.gmail
>
> Does it make sense now?

Unfortunately, no, it still doesn't. Let me try to elaborate why below.

>
> > I wonder if we perhaps should just leave this as is then. In other
> > words, rely on the consumer driver to vote for an initial performance
> > state of the device during ->probe(). In this way, the consumer driver
> > can decide what is the best thing to do, rather than letting genpd
> > make guesses.
>
> The point of this series is to remove the boilerplate code from consumer
> drivers.
>
> I already implemented variant with the explicit state syncing done by
> consumer drivers, but Viresh suggested that it should be done by the PD
> driver, this is why we're discussing it all over again.
>
> We either need to add quirks to consumer drivers or make PD API more
> flexible. You're not in favor of extending the PD API. To me the variant
> with the PD API extension is a bit nicer since it removes the
> boilerplate code, but I also see why you don't like it.

I don't mind extending the genpd API, but it needs to serve a good purpose.

As I said earlier, genpd doesn't know nor can control how the consumer
driver deploys runtime PM. Unfortunately, that also includes genpd
providers, as the behavior isn't a platform or PM domain specific
thing. This means genpd needs to be generic enough so it works for all
cases.

In the $subject patch, we rely on the pm_runtime_suspended() check in
dev_pm_genpd_set_performance_state(), which should work for all cases,
even if it may be sub-optimal for some scenarios.

Note that, in the approach your suggested [1],
pm_runtime_status_suspended() is used instead. This doesn't work when
a consumer driver doesn't enable runtime PM - or calls
pm_runtime_set_active() during ->probe(), because
genpd_runtime_resume() won't be invoked to restore the gpd->rpm_state.

That said, I wouldn't mind to simply skip adding the
->dev_get_performance_state() all together, if that is what you
prefer? In this way, it becomes the responsibility for the consumer
driver to do right thing, with the cost of some boilerplate code added
in its ->probe() routine.

>
> Viresh, are you okay with going back to the variant with the
> dev_pm_opp_sync() helper?

Rather than trying this again, I would suggest you start by open
coding these parts, for now. But I leave that to Viresh to decide.

[...]

Kind regards
Uffe

[1]
[PATCH v10 4/8] PM: domains: Add dev_get_performance_state() callback
