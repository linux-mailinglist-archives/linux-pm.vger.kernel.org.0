Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BEF258BE1
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIAJoO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 05:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAJoN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 05:44:13 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B76C061244
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 02:44:12 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id b4so176911vkh.9
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqUZiaHDOQj+5c8K9wqMeMr/eDc8aliEs8X3DxTl3tk=;
        b=fY5cYkBOVZ1HM37AreZRTw42ZWtYbVvM3NAP98YJ1cRJKtnM7h920mI0A27h+i7jNf
         RxYECXXC/eLmLME1zKr3JAU6krXFQzYLdgHRCMM1FKGU6fNut51F0audXu80soF9ngqH
         ZyTjPhPn3fFYDJEe3bCW0GeMHPN5A68sAvdb5cWkTY4zIwrG2SBu19vkuKetqiKIAiJn
         CmIn84GnoH7iFuUMnhHAqv7i76zS0uVq+3REUvbfcStzf9TxYEaxZsllWXSE0ioSV/xG
         Oyrc3begPf37xQ4F6EkAD+G0MLmjT+BPE8Khg1FRveNRkr7I3J1mLXnXK/ASnfguPD6+
         gwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqUZiaHDOQj+5c8K9wqMeMr/eDc8aliEs8X3DxTl3tk=;
        b=JWoePGSKtpjNQq5DpNWTKn3ICGJk2+ONeHOWADxr+aOEZH/daGrMUgkb8iteJG8kd/
         qlgyBioF6M5nceFR5CQ3phxEVV1ivgv4HFlmtpeREEYncP4m8/UBeeqz7tm/mz1jJFQj
         nxZ//ghbxjf9Wet7RgXwJYe01W/D5OUvtQ1JLgtkkXms488Tyy/yG4SVdsdceaSQ3P8p
         Bnq/8A062HIVQjwzBTuViJyR4Gd6fxYeXiRNq4lF+q4x+3z5lFKytrgsX0KmL0hBrZ0z
         XLrts6kQd08Sd2+Ny3hPN4bEWE77vkpo3awY2mQYqFBf9W+nMCmndaB67n1T3NNastj9
         weEA==
X-Gm-Message-State: AOAM532fPO+FE8vMz+UeiKF+wV6AFERtcwnUQPqD6b/fV1acWI3YtFJM
        444cXYUuh8FMSHgdUDRwnKqPA6D6HZI1kHXBDGeY9Z/ta28S98i9
X-Google-Smtp-Source: ABdhPJzSCofoO5/tayrR6DtEc8vTonK5TYN4b3WS5gtZA3m8Hhk201a5hH4rlsEN0eC6E5TtI7haAjb25RAZxUyIgOk=
X-Received: by 2002:a1f:d084:: with SMTP id h126mr385794vkg.59.1598953450813;
 Tue, 01 Sep 2020 02:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200814123436.61851-1-ulf.hansson@linaro.org>
 <20200818123507.GD6873@bogus> <CAPDyKFqi4uOBQkTZMvSnDTCsKdNoToCO4s7h1CnR-mkJ2vBNSw@mail.gmail.com>
 <20200901090125.GA14397@bogus>
In-Reply-To: <20200901090125.GA14397@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Sep 2020 11:43:34 +0200
Message-ID: <CAPDyKFo-8D0HTmkrd1pC3hcCH5JvRP8nUCUYJKR2ZkrROPNGYQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Allow PM domain to be initialized even if
 no OSI mode
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 1 Sep 2020 at 11:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Aug 19, 2020 at 10:20:52AM +0200, Ulf Hansson wrote:
> > On Tue, 18 Aug 2020 at 14:35, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Fri, Aug 14, 2020 at 02:34:36PM +0200, Ulf Hansson wrote:
> > > > If the PSCI OSI mode isn't supported or fails to be enabled, the PM domain
> > > > topology with the genpd providers isn't initialized. This is perfectly fine
> > > > from cpuidle-psci point of view.
> > > >
> > >
> > > Indeed.
> > >
> > > > However, since the PM domain topology in the DTS files is a description of
> > > > the HW, no matter of whether the PSCI OSI mode is supported or not, other
> > > > consumers besides the CPUs may rely on it.
> > > >
> > >
> > > And why are they even registered as part of cpuidle-psci-domain ?
> > > If they have to be, can be decouple it completely from cpuidle then ?
> >
> > These devices can't be decoupled as they are a part of the CPU cluster
> > PM domain.
> >
> > This is for example the case RPMH (rsc) device for Qcom platforms, but
> > there are other platforms that need this too.
> >
> > >
> > > > Therefore, let's always allow the initialization of the PM domain topology
> > > > to succeed, independently of whether the PSCI OSI mode is supported.
> > > > Consequentially we need to track if we succeed to enable the OSI mode, as
> > > > to know when a domain idlestate can be selected.
> > > >
> > >
> > > I thought we had discussed this in past, why are we back to the same
> > > discussion ? I may need to read those again to get the context.
> >
> > That discussion was according to my understanding about whether we
> > should allow CPU devices to be managed by runtime PM and the CPU PM
> > domains, if OSI was *not* supported.
> >
> > We concluded that we didn't want to allow that, which makes sense -
> > and I am not changing that in $subject patch.
> >
> > >
> > > > Note that, CPU devices are still not being attached to the PM domain
> > > > topology, unless the PSCI OSI mode is supported.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/cpuidle/cpuidle-psci-domain.c | 49 +++++++++++++--------------
> > > >  1 file changed, 24 insertions(+), 25 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > > index b6e9649ab0da..55653c110e3a 100644
> > > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > > @@ -28,6 +28,7 @@ struct psci_pd_provider {
> > > >
> > > >  static LIST_HEAD(psci_pd_providers);
> > > >  static bool psci_pd_allow_domain_state;
> > > > +static bool psci_osi_mode_enabled;
> > > >
> > > >  static int psci_pd_power_off(struct generic_pm_domain *pd)
> > > >  {
> > > > @@ -37,7 +38,7 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
> > > >       if (!state->data)
> > > >               return 0;
> > > >
> > > > -     if (!psci_pd_allow_domain_state)
> > > > +     if (!psci_pd_allow_domain_state || !psci_osi_mode_enabled)
> > >
> > > I really don't like this check. Why do we have to keep checking
> > > psci_osi_mode_enabled every single time and that is the reason IIRC
> > > I was against this and just don't add the domains.
> >
> > You have a point about the check, it's not very nice - but from an
> > execution point of view, I don't think it's the end of the world.
> >
> > Note that, when not using OSI, then the ->power_off() callback will
> > not be invoked in the cpuidle path.
> >
>
> Then drop the check. I am confused as why we need that runtime check if
> we get the setup right.
>
> > Anyway, if you like, I can try to rework the code, so that the
> > ->power_off() callback doesn't get assigned, if we are not using OSI.
>
> +1 for sure.
>
> > Although, I am not sure the trouble is worth it, as I probably need to
> > try to enable OSI before initializing the genpd data structures. Then,
> > if failing with genpd initializations, I need to revert back to PC
> > mode.
> >
>
> Just to clarify, you can use psci_osi_mode_enabled anytime during
> initialisation and get the setup right so that we can drop unnecessary
> runtime check every single poweroff call. I prefer to remove that.

Okay, I will respin the series then.

Although, just to be clear, this means that I will have to invoke
psci_set_osi_mode() prior to initializing the PM domains. Then if it
turns out that initializing the PM domain fails, I will have to switch
back to PC mode.

To do that, I will probably need to extend psci_set_osi_mode() to take
a bool as a parameter (to indicate enable or disable OSI mode). You
are okay with this, right?

Kind regards
Uffe
