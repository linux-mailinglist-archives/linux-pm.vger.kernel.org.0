Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BEE401A31
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhIFKyv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 06:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhIFKyu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 06:54:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199D2C061757
        for <linux-pm@vger.kernel.org>; Mon,  6 Sep 2021 03:53:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s10so12702031lfr.11
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 03:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gx7CzA9H5t8Q6YIUiDy50cgQCSUuGZRW9M0PvGf1e+8=;
        b=WEQdc/lDDWHm94kOPKlfiP5vyqlzNbKrHHreAdWyjgMj8wWcG2YynXytxMeQExqeit
         i9+mqRVKVmboCVuAmC2DbRwfpZpm0mLfNif8/T2Zylz+phuUlLIVdMV/KF+9mS2vlsln
         DF8YKwG4vNinl+URdiYrTlU9CywxheCDZRcX6Te/M5Y5vpCOwBU82SWry1VBYR9QRrxn
         m8GOGq1aAU4sf627hQ4JSqPo3F3ZkhwHYi+TyN+OedRxpA/D1zXkxaumZQ+zYRDVql51
         csU4a/6aZSzBrM/PtmPgz1zpZUye5gN8D77UfZQcwUH79kfzS7PN7NoOQNnlPcWCPO1O
         ItKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gx7CzA9H5t8Q6YIUiDy50cgQCSUuGZRW9M0PvGf1e+8=;
        b=EVOCiob9X59M4cLFP/vn9jl+GNGsqSHwbNbmyX1K3jYfROGjYYZNqqUDoa4oyHevrR
         sTKeAsKkWnCuGO78eFmqth3/6XsD0J/lwWflAQ8x0SUY9BMQTX+PnNN/SIqJ0MOfSBFS
         LyPIud/AGJZ9MzHJ7Y5qmjb6Bzyx/L3j0inoH36/uwOwFYNNIAwCU7bhd3XV+ZYQbdKt
         ysF5gf/KZ4xqmNBgEs7TM276ovVwliZtFHo3shYdavX35hLOaVB4b2svEcyRyPaSwLQh
         0wYw5MugZvmHHQc4y/vtoVH7c0PwG6U5QzwZztcT2vxlKRc1khCMMhkqtErjjk66O6Zf
         TPGg==
X-Gm-Message-State: AOAM532i+4X4n+YB+EDSosXgAsaPAiFjy9BU+8NT5t1ds2nvFBfLPAan
        1wnmYYqXY0GhBFSE328GWNmMX+aF6ljQ0gkN1aJr3w==
X-Google-Smtp-Source: ABdhPJwJDHgrqkxSr3wn3QEIowOpkYm54q1MmO15LwQCkmLv+BUgrPsUbkkvnSZhpy2AcM+35l0VsgyIpHWVpf6WAyQ=
X-Received: by 2002:a05:6512:31c7:: with SMTP id j7mr8817802lfe.373.1630925623772;
 Mon, 06 Sep 2021 03:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-4-ulf.hansson@linaro.org> <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
 <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com>
 <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com> <CAPDyKFqE+thX0pLTg9d-ds7Tj3hsB78EmDB1Cryh26tN3kvQDA@mail.gmail.com>
 <3d92711f-ce30-2c19-c6a4-bb77d32df2dd@gmail.com>
In-Reply-To: <3d92711f-ce30-2c19-c6a4-bb77d32df2dd@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 12:53:07 +0200
Message-ID: <CAPDyKFpJU3g2OzJeR9KUdtN-8wJsDckqVAMQMHBV=enu=DfURg@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

On Sun, 5 Sept 2021 at 11:11, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 03.09.2021 17:09, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, 3 Sept 2021 at 12:06, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 03.09.2021 11:55, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Fri, 3 Sept 2021 at 08:00, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>>>
> >>>> 02.09.2021 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>> Hardware may be preprogrammed to a specific performance state, whic=
h may
> >>>>> not be zero initially during boot. This may lead to that genpd's cu=
rrent
> >>>>> performance state becomes inconsistent with the state of the hardwa=
re. To
> >>>>> deal with this, the driver for a device that is being attached to i=
ts
> >>>>> genpd, need to request an initial performance state vote, which is
> >>>>> typically done by calling some of the OPP APIs while probing.
> >>>>>
> >>>>> In some cases this would lead to boilerplate code in the drivers. L=
et's
> >>>>> make it possible to avoid this, by adding a new optional callback t=
o genpd
> >>>>> and invoke it per device during the attach process. In this way, th=
e genpd
> >>>>> provider driver can inform genpd about the initial performance stat=
e that
> >>>>> is needed for the device.
> >>>>>
> >>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>>> ---
> >>>>>  drivers/base/power/domain.c | 8 +++++---
> >>>>>  include/linux/pm_domain.h   | 2 ++
> >>>>>  2 files changed, 7 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domai=
n.c
> >>>>> index 800adf831cae..1a6f3538af8d 100644
> >>>>> --- a/drivers/base/power/domain.c
> >>>>> +++ b/drivers/base/power/domain.c
> >>>>> @@ -2640,13 +2640,15 @@ static void genpd_dev_pm_sync(struct device=
 *dev)
> >>>>>       genpd_queue_power_off_work(pd);
> >>>>>  }
> >>>>>
> >>>>> -static int genpd_get_default_performance_state(struct device *dev,
> >>>>> +static int genpd_get_default_performance_state(struct generic_pm_d=
omain *genpd,
> >>>>> +                                            struct device *dev,
> >>>>>                                              unsigned int index)
> >>>>>  {
> >>>>>       int pstate =3D of_get_required_opp_performance_state(dev->of_=
node, index);
> >>>>>
> >>>>>       if (pstate =3D=3D -ENODEV || pstate =3D=3D -EOPNOTSUPP)
> >>>>> -             return 0;
> >>>>> +             pstate =3D genpd->dev_get_performance_state ?
> >>>>> +                      genpd->dev_get_performance_state(genpd, dev)=
 : 0;
> >>>>>
> >>>>>       return pstate;
> >>>>>  }
> >>>>> @@ -2701,7 +2703,7 @@ static int __genpd_dev_pm_attach(struct devic=
e *dev, struct device *base_dev,
> >>>>>       }
> >>>>>
> >>>>>       /* Set the default performance state */
> >>>>> -     pstate =3D genpd_get_default_performance_state(dev, index);
> >>>>> +     pstate =3D genpd_get_default_performance_state(pd, dev, index=
);
> >>>>
> >>>> If base device is suspended, then its performance state is zero.
> >>>>
> >>>> When device will be rpm-resumed, then its performance should be set =
to
> >>>> the default state.
> >>>> You're setting performance state of the wrong device, it should be t=
he
> >> Are you okay with my variant of handling the suspended device?
> >
> > Not sure if you intended to post this line?
> >
> > In any case, I am happy to help and review to move things forward.
>
> It's not clear to me whether you omitted handling the case of
> rpm-suspended device on purpose or not. I think it should be a part of
> this patch, but sounds like you want to work on it separately, correct?

I didn't omit the handling, but instead relied solely on the
pm_runtime_suspended() check in dev_pm_genpd_set_performance_state().

>
> >>>> base device and not the virtual domain device.
> >>>
> >>> No I am not. :-) Let me elaborate.
> >>>
> >>> For the single PM domain case, 'dev' and 'base_dev' are pointing to
> >>> the same device. So this works fine.
> >>>
> >>> For the multiple PM domain case or when attaching goes via
> >>> genpd_dev_pm_attach_by_id(), 'dev' is the virtual device registered i=
n
> >>> genpd_dev_pm_attach_by_id(). In this case, it's 'dev' that is becomin=
g
> >>> attached to genpd and not the 'base_dev'. Note also that, runtime PM
> >>> has not been enabled for 'dev' yet at this point and 'dev' has been
> >>> assigned the same OF node as 'base_dev", to allow OF parsing to work
> >>> as is for it.
> >>>
> >>> Moreover, to deal with runtime PM in the multiple PM domain case, the
> >>> consumer driver should create a device link. Along the lines of this:
> >>> device_link_add(base_dev, dev, DL_FLAG_PM_RUNTIME |
> >>> DL_FLAG_STATELESS), thus assigning the virtual device ('dev') as the
> >>> supplier for its consumer device ('base_dev').
> >>>
> >>>>
> >>>> These all is handled properly by my patch [1]. Hence it's complicate=
d
> >>>> for the reason.
> >>>
> >>> See above. It shouldn't have to be complicated. If it still is, there
> >>> is something to fix for the multiple PM domain case.
> >>>> [1]
> >> Alright, it actually works now on Tegra using the dev in the callback
> >> for the case of multiple domains, I re-checked it. Previously, when I
> >> tried that, there was a conflict in regards to OPP usage, I don't
> >> remember details anymore. Maybe the recent changes that were suggested
> >> by Viresh helped with that. So yes, there is no need to pass the base
> >> device anymore.
> >
> > Great! So, it seems like $subject patch should be a way forward for you=
 then?
>
> The current behaviour is incorrect for Tegra because it needs to set the
> rpm_pstate for rpm-suspended device, instead of bumping the state
> immediately.
>
> Power management is defeated without it on Tegra because SoC will start
> to consume extra power while device that needs this power is suspended.

Okay, I understand your concern.

For devices that may remain runtime suspended when their consumer
drivers probes them, the behaviour may be suboptimal. This because it
could lead to having an active performance state vote for a runtime
suspended device, at least until it gets runtime resumed and then
runtime suspended again.

This all boils down to how the consumer driver deploys support for
runtime PM - and genpd doesn't know nor can control that.

I wonder if we perhaps should just leave this as is then. In other
words, rely on the consumer driver to vote for an initial performance
state of the device during ->probe(). In this way, the consumer driver
can decide what is the best thing to do, rather than letting genpd
make guesses.

Note that, comparing what we have done for power on/off during
attach/probe. For the legacy case (the single PM domain case) we power
on the PM domain. For the multiple PM domain case, we leave the PM
domain as is.

>
> Otherwise $subject looks okay.
>
> > BTW, I forgot to add your Suggested-by: tag for the patch, you
> > certainly deserve at least that. Or perhaps you are fine with
> > co-developed by tag?
>
> Either is fine. Although, won't it be easier to keep these PD patches
> within the Tegra series since it depends on them? I can pick up the
> patches into the next version of Tegra series.

Let's see. If we can agree on how to deal with this series, maybe we
can ask Rafael to send another pull-request before rc1 is out, so you
can base your series for Tegra more easily on top.

Kind regards
Uffe
