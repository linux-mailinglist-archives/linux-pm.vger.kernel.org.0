Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D8A2518BE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 14:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHYMnd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 08:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHYMnc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 08:43:32 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A23C061755
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 05:43:31 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id v138so6237663vsv.7
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLVFtnGfv315f2cFlk5FripJT8yacKqKZDtbXzYmCDI=;
        b=U566dHbTo04FW3tyndOxJtS5iVLtX46FMq/KDV9EPwWlBk5Mg9Xrcq4mEdgd9Q5FhW
         YU1MTkJr+aQKkHRtX9aWTRspF57xJp+5fH/Jwt8yJixXdsQNSR8xFp5sFmwqnJanmZ64
         qx8DlZQRLvL8ZK/GfL+fARwSyLAbUZs/htfHFm/E3OOrRm/9q65uNNibeCCFSsoIJf6c
         iiiyzX/Et7x1vHs8Q8b2WQLPBWXI3YSSuKA/W8N33Ci1DkdpEpq4pmClA+1tZt8hPPwj
         vfXZFH65QtmU/hnLnMJOAEE/x4ptTxDxCeNmh4XKDY/6onNE4kpYTEVrCEuptUi7aPmQ
         2avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLVFtnGfv315f2cFlk5FripJT8yacKqKZDtbXzYmCDI=;
        b=nMjjdJHp+CzcbEFaO1OdFP4GUbF4pZuIyglb1Wy+blL/jPccUIRpHSpk3Zldw9Osx4
         WYFp4GwK/uEimxnQHT5EKQQWb7+9ZNLVSsZbTDnZFdE6stXyEWSDy6n9odfxYdgr8iiS
         gLKJkJDhxeLg3Vf6lex/rcIvp+FE4ksTcEQNsFUmrgxEdacUdScs6FU6VUMRmDkCSOfp
         Rlx0DAz6Qf8hVF0mKF1rcK3xkujmhLGN3fAgwZ1KH7pZDSInzhH5il+bHjFArKU6UyNO
         Kf8DKqYBmSmsXdgT6Drhi3YJ0PUj7+X+vd7PfPrKOV2k4p+jGot/tlha/3W/P452eh+B
         CybQ==
X-Gm-Message-State: AOAM530GwCcTytZVQUpQEoNR08ML54ZB095GoM/q9ofjOWJO9mAgSVXD
        Bgoi5PTBjnTbljxu9XJ3VHWR8bet+tXaP4rbpa7ZTg==
X-Google-Smtp-Source: ABdhPJwbwNg013MOScMFnsgy3TICJRQmBvzLvJLnTLM78u9drmk/zWgpSBbb1E/PUZIcr6dShagAtm53gGvBtrMWL1Y=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr5265924vso.165.1598359410979;
 Tue, 25 Aug 2020 05:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200730080146.25185-1-stephan@gerhold.net> <20200730080146.25185-4-stephan@gerhold.net>
 <20200824112744.jsyaxrfbybyjpwex@vireshk-i7> <20200824115549.GB208090@gerhold.net>
 <CAPDyKFojtArMRfO+Z8YaWCWw2fFYcO62x3eL1paNi5pKRg3Jww@mail.gmail.com>
 <20200824150831.GA842@gerhold.net> <20200825044308.4y3w2urcikban7if@vireshk-i7>
 <CAPDyKFp+71_WGwvdZ6DYamsDjgoRk57H5MjDAdQUtCtJpEHp2Q@mail.gmail.com> <20200825073348.GA1048@gerhold.net>
In-Reply-To: <20200825073348.GA1048@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Aug 2020 14:42:54 +0200
Message-ID: <CAPDyKFr-gfpVypFs_13hb9Pi5FfQoB32fg=C_gtdSKVDN1U=gQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] opp: Power on (virtual) power domains managed by
 the OPP core
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <nks@flawful.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 25 Aug 2020 at 09:34, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Tue, Aug 25, 2020 at 08:43:42AM +0200, Ulf Hansson wrote:
> > On Tue, 25 Aug 2020 at 06:43, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 24-08-20, 17:08, Stephan Gerhold wrote:
> > > > On Mon, Aug 24, 2020 at 04:36:57PM +0200, Ulf Hansson wrote:
> > > > > That said, perhaps should rely on the consumer to deploy runtime PM
> > > > > support, but let the OPP core to set up the device links for the genpd
> > > > > virtual devices!?
> > > > >
> > > >
> > > > Yes, that would be the alternative option.
> > >
> > > That is the right option IMO.
> > >
> > > > I would be fine with it as long as it also works for the CPUfreq case.
> > > >
> > > > I don't think anything manages runtime PM for the CPU device, just
> > > > like no-one calls dev_pm_opp_set_rate(cpu_dev, 0). So with my patch the
> > > > power domain is essentially kept always-on (except for system suspend).
> > > > At least in my case this is intended.
> > > >
> > > > If device links also keep the power domains on if the consumer device
> > > > does not make use of runtime PM it should work fine for my case.
> > >
> > > With device link, you only need to do rpm enable/disable on the consumer device
> > > and it will get propagated by itself.
> >
> > Note that the default state for the genpd virtual device(s) is that
> > runtime PM has been enabled for them. This means it's left in runtime
> > suspended state, which allows its PM domain to be powered off (if all
> > other devices and child domains for it allow that too, of course).
> >
> > >
> > > > Personally, I think my original patch (without device links) fits better
> > > > into the OPP API, for the following two reasons.
> > > >
> > > > With device links:
> > > >
> > > >   1. Unlike regulators/interconnects, attached power domains would be
> > > >      controlled by runtime PM instead of dev_pm_opp_set_rate(opp_dev, 0).
> > > >
> > > >   2. ... some driver using OPP tables might not make use of runtime PM.
> > > >      In that case, the power domains would stay on the whole time,
> > > >      even if dev_pm_opp_set_rate(opp_dev, 0) was called.
> > > >
> > > > With my patch, the power domain state is directly related to the
> > > > dev_pm_opp_set_rate(opp_dev, 0) call, which is more intuitive than
> > > > relying on the runtime PM state in my opinion.
> > >
> > > So opp-set-rate isn't in the best of shape TBH, some things are left for the
> > > drivers while other are done by it. Regulator-enable/disable was moved to it
> > > some time back as people needed something like that. While on the other hand,
> > > clk_enable/disable doesn't happen there, nor does rpm enable/disable.
> > >
> > > Maybe one day we may want to do that, but lets make sure someone wants to do
> > > that first.
> > >
> > > Anyway, even in that case both of the changes would be required. We must make
> > > device links nevertheless first. And later on if required, we may want to do rpm
> > > enable/disable on the consumer device itself.
> >
> > This sounds like a reasonable step-by-step approach.
> >
> > Then, to create the device links, we should use DL_FLAG_PM_RUNTIME,
> > DL_FLAG_STATELESS.
> >
>
> OK, I will give this a try later this week.
>
> > But whether we should use DL_FLAG_RPM_ACTIVE as well, to initially
> > runtime resume the supplier (the genpd virtual device), is harder to
> > know - as that kind of depends on expectations by the consumer device
> > driver.
> >
>
> I'm not sure I understand the purpose of that flag. I thought we want to
> link the PM state of the virtual genpd device (supplier) to the PM state
> of the device of the OPP table (consumer).

Correct, but this is about synchronizing the initial runtime PM state
of the consumer and supplier.

>
> Shouldn't it just determine the initial state based on the state of the
> consumer device?

We could do that. Then something along the lines of the below, should work:

pm_runtime_get_noresume(consumer) - to prevent runtime suspend, temporarily.

if(pm_runtime_active(consumer))
    create links with DL_FLAG_RPM_ACTIVE
else
    create links without DL_FLAG_RPM_ACTIVE

pm_runtime_put(consumer)

Kind regards
Uffe
