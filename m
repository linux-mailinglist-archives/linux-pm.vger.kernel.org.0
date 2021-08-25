Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773BF3F7C1A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Aug 2021 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhHYSSZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Aug 2021 14:18:25 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40852 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhHYSSZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Aug 2021 14:18:25 -0400
Received: by mail-ot1-f48.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso117004otu.7;
        Wed, 25 Aug 2021 11:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQ0pZPWQx0ZHOI2wEp9wamWoXIMX5iP3PcetWMvFO/g=;
        b=dfB5DmEN21Ej4e2EzE1d61MTtzQ1UzHOajh3jWqcdgZ3uXcbotd6p7Q83VZtYRavFY
         dIWwtHAdLkscnop1FE64benYQHo5qvH4Inj1+7lDKWxklfJLaogeiLb2d0EZQzpRDTKH
         U1rlXPP1taw15SFJlLBD0+n/jZsOB7En7g8FSL9lTfriPhV7GucTJDH739FbNh0juF9V
         lv18ksyBZOx5pGFzmfGhEUQD/m4HHUJJR4c5NeC6BhV8ZiQ8tyyyvpvVsvKdboTDNnTs
         8q3YXxIUX/7wDg1S45cjs9qpoMU8rGLzICuKe27RIE4TlWeaSqPlxO7pGwJYUXqUTYwk
         Mz6Q==
X-Gm-Message-State: AOAM5307iXD0Kf80VdOO95AnytkbKpBDClAK80mDxvGRA99Y6oL+HyY8
        fXN4bSbNbVqJtNGOVBGtXWK+8q4DbXwtM0/isDY=
X-Google-Smtp-Source: ABdhPJxtNO2eegtOegb2C9Yt03ivbvRBEbfYOPZ5oAJGHuLq2dvU7KBgtu/I+X63rKxNNn7CmbZNRKid1WgYS3JRqPI=
X-Received: by 2002:a9d:a57:: with SMTP id 81mr24725554otg.260.1629915458885;
 Wed, 25 Aug 2021 11:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210823202412.25716-1-digetx@gmail.com> <CAPDyKFpsEMmuF4XzUX=ko4H3iBSu_77_+vozETg9njC94x8goA@mail.gmail.com>
In-Reply-To: <CAPDyKFpsEMmuF4XzUX=ko4H3iBSu_77_+vozETg9njC94x8goA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Aug 2021 20:17:27 +0200
Message-ID: <CAJZ5v0hox4Y7pQARTTjMkj5TdDkcuKkyeB3=YR3YFnAcGMUJeA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: domains: Improve runtime PM performance state handling
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 24, 2021 at 9:51 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 23 Aug 2021 at 22:25, Dmitry Osipenko <digetx@gmail.com> wrote:
> >
> > GENPD core doesn't support handling performance state changes while
> > consumer device is runtime-suspended or when runtime PM is disabled.
> > GENPD core may override performance state that was configured by device
> > driver while RPM of the device was disabled or device was RPM-suspended.
> > Let's close that gap by allowing drivers to control performance state
> > while RPM of a consumer device is disabled and to set up performance
> > state of RPM-suspended device that will be applied by GENPD core on
> > RPM-resume of the device.
> >
> > Fixes: 5937c3ce2122 ("PM: domains: Drop/restore performance state votes for devices at runtime PM")
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Rafael, if not too late, can you please queue this as a fix for v5.14?
> I haven't heard about any regression, but the error is there.

Done, thanks!


> > ---
> >  drivers/base/power/domain.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index e1c8994ae225..3a13a942d012 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -435,7 +435,7 @@ static void genpd_restore_performance_state(struct device *dev,
> >  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
> >  {
> >         struct generic_pm_domain *genpd;
> > -       int ret;
> > +       int ret = 0;
> >
> >         genpd = dev_to_genpd_safe(dev);
> >         if (!genpd)
> > @@ -446,7 +446,13 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
> >                 return -EINVAL;
> >
> >         genpd_lock(genpd);
> > -       ret = genpd_set_performance_state(dev, state);
> > +       if (pm_runtime_suspended(dev)) {
> > +               dev_gpd_data(dev)->rpm_pstate = state;
> > +       } else {
> > +               ret = genpd_set_performance_state(dev, state);
> > +               if (!ret)
> > +                       dev_gpd_data(dev)->rpm_pstate = 0;
> > +       }
> >         genpd_unlock(genpd);
> >
> >         return ret;
> > --
> > 2.32.0
> >
