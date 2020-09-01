Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A462591C3
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 16:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgIAOy7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 10:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIALj5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 07:39:57 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F106C061244
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 04:39:56 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b16so413772vsl.6
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6L+TDogzAER773ZdFo+H+0TV0kvO7SaRNcvrJ210L2s=;
        b=mQdBuJS+sc1Fvm4vd6YuBeYHdqrN3y5ctJeaEYmmfWfWaeFY/pHsX12lsAhhdsZHR+
         uBjXHoDSD8r8XTo9xLpLhA7HjQCIliF0Nen1iSKqNbQ6MGopQBOq6OPLZECmpTT+Lc9D
         MyRz2Y8Can++5ya1rGVWEdln2mc23i783jluIHOIPUgYRKRyUX0GQSjL47+Whnupr03A
         MQB6PrPLkV5bFZzsZy+UgxWcx/CffvJWVRKVIAfn7z2Pxrcg3fa/VHA/1aBPct1PLrsJ
         9LWReLMYocdNMXyNX5faZ5/IDW/jTe3x/FoAnVNRPSfe7pNmcg1WL2N7woebr/KPFB8X
         I7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6L+TDogzAER773ZdFo+H+0TV0kvO7SaRNcvrJ210L2s=;
        b=FQ/dt+zH+EHIi7mIjV91ZayM2kaY5c+pD2GLSbGcP8alRKrLf0yEC4oT5nDQ2xbiNm
         HDvjXaWv6yir7QZoSBYF5JqQFpRV2UxsiUS5R1RDrKXuJRnvEfZwt+PHRQTe58mxblDU
         qFWFweFr3OnXZ1waQ19Idli6CzD41iv+KEaMGDZvqWa9biXc6VkENBNl/4grccBIMHws
         flI0xsANq64T2wz1tVHf8SBULSy3fSjoIER94kDfxhNxpvv0lFpnuql7Zt0wfi780ux/
         lIfP250N6wG+o340oOMcAe/my5zjH0QsK7LDMg9pNcsNUQB9X890nOpQedpauwPirvHs
         Ljkw==
X-Gm-Message-State: AOAM532q+KGnmx5bZfJpJFIPPbloBM+Fdq0w4fuOUDw/nNdYivwovnX+
        jHkBkWIqEJc9nLvAqZUL7lZccvpPqtq5xr6PgPGgZDOzIguW/Q==
X-Google-Smtp-Source: ABdhPJwSAHj4HbGtzMQvPZ9Xn/EaksBQgjtdikKE2EnREJeDXgmn/LZc3hpRSxNQ9mA3Zbk7LFqnf6ToIQgqcu4FF2k=
X-Received: by 2002:a67:f916:: with SMTP id t22mr840497vsq.72.1598960395219;
 Tue, 01 Sep 2020 04:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200814123436.61851-1-ulf.hansson@linaro.org>
 <20200818123507.GD6873@bogus> <CAPDyKFqi4uOBQkTZMvSnDTCsKdNoToCO4s7h1CnR-mkJ2vBNSw@mail.gmail.com>
 <20200901090125.GA14397@bogus> <CAPDyKFo-8D0HTmkrd1pC3hcCH5JvRP8nUCUYJKR2ZkrROPNGYQ@mail.gmail.com>
 <20200901101725.GA23815@bogus>
In-Reply-To: <20200901101725.GA23815@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Sep 2020 13:39:18 +0200
Message-ID: <CAPDyKFogD+yxMhCGY6EeKmhenp_HU4DtTt3=npdPPvMAt2sgNw@mail.gmail.com>
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

On Tue, 1 Sep 2020 at 12:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Sep 01, 2020 at 11:43:34AM +0200, Ulf Hansson wrote:
> > On Tue, 1 Sep 2020 at 11:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Wed, Aug 19, 2020 at 10:20:52AM +0200, Ulf Hansson wrote:
> > > > On Tue, 18 Aug 2020 at 14:35, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > > > > On Fri, Aug 14, 2020 at 02:34:36PM +0200, Ulf Hansson wrote:
> > > > > > If the PSCI OSI mode isn't supported or fails to be enabled, the PM domain
> > > > > > topology with the genpd providers isn't initialized. This is perfectly fine
> > > > > > from cpuidle-psci point of view.
> > > > > >
> > > > >
> > > > > Indeed.
> > > > >
> > > > > > However, since the PM domain topology in the DTS files is a description of
> > > > > > the HW, no matter of whether the PSCI OSI mode is supported or not, other
> > > > > > consumers besides the CPUs may rely on it.
> > > > > >
> > > > >
> > > > > And why are they even registered as part of cpuidle-psci-domain ?
> > > > > If they have to be, can be decouple it completely from cpuidle then ?
> > > >
> > > > These devices can't be decoupled as they are a part of the CPU cluster
> > > > PM domain.
> > > >
> > > > This is for example the case RPMH (rsc) device for Qcom platforms, but
> > > > there are other platforms that need this too.
> > > >
> > > > >
> > > > > > Therefore, let's always allow the initialization of the PM domain topology
> > > > > > to succeed, independently of whether the PSCI OSI mode is supported.
> > > > > > Consequentially we need to track if we succeed to enable the OSI mode, as
> > > > > > to know when a domain idlestate can be selected.
> > > > > >
> > > > >
> > > > > I thought we had discussed this in past, why are we back to the same
> > > > > discussion ? I may need to read those again to get the context.
> > > >
> > > > That discussion was according to my understanding about whether we
> > > > should allow CPU devices to be managed by runtime PM and the CPU PM
> > > > domains, if OSI was *not* supported.
> > > >
> > > > We concluded that we didn't want to allow that, which makes sense -
> > > > and I am not changing that in $subject patch.
> > > >
> > > > >
> > > > > > Note that, CPU devices are still not being attached to the PM domain
> > > > > > topology, unless the PSCI OSI mode is supported.
> > > > > >
> > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > ---
> > > > > >  drivers/cpuidle/cpuidle-psci-domain.c | 49 +++++++++++++--------------
> > > > > >  1 file changed, 24 insertions(+), 25 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > > > > index b6e9649ab0da..55653c110e3a 100644
> > > > > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > > > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > > > > @@ -28,6 +28,7 @@ struct psci_pd_provider {
> > > > > >
> > > > > >  static LIST_HEAD(psci_pd_providers);
> > > > > >  static bool psci_pd_allow_domain_state;
> > > > > > +static bool psci_osi_mode_enabled;
> > > > > >
> > > > > >  static int psci_pd_power_off(struct generic_pm_domain *pd)
> > > > > >  {
> > > > > > @@ -37,7 +38,7 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
> > > > > >       if (!state->data)
> > > > > >               return 0;
> > > > > >
> > > > > > -     if (!psci_pd_allow_domain_state)
> > > > > > +     if (!psci_pd_allow_domain_state || !psci_osi_mode_enabled)
> > > > >
> > > > > I really don't like this check. Why do we have to keep checking
> > > > > psci_osi_mode_enabled every single time and that is the reason IIRC
> > > > > I was against this and just don't add the domains.
> > > >
> > > > You have a point about the check, it's not very nice - but from an
> > > > execution point of view, I don't think it's the end of the world.
> > > >
> > > > Note that, when not using OSI, then the ->power_off() callback will
> > > > not be invoked in the cpuidle path.
> > > >
> > >
> > > Then drop the check. I am confused as why we need that runtime check if
> > > we get the setup right.
> > >
> > > > Anyway, if you like, I can try to rework the code, so that the
> > > > ->power_off() callback doesn't get assigned, if we are not using OSI.
> > >
> > > +1 for sure.
> > >
> > > > Although, I am not sure the trouble is worth it, as I probably need to
> > > > try to enable OSI before initializing the genpd data structures. Then,
> > > > if failing with genpd initializations, I need to revert back to PC
> > > > mode.
> > > >
> > >
> > > Just to clarify, you can use psci_osi_mode_enabled anytime during
> > > initialisation and get the setup right so that we can drop unnecessary
> > > runtime check every single poweroff call. I prefer to remove that.
> >
> > Okay, I will respin the series then.
> >
> > Although, just to be clear, this means that I will have to invoke
> > psci_set_osi_mode() prior to initializing the PM domains. Then if it
> > turns out that initializing the PM domain fails, I will have to switch
> > back to PC mode.
> >
> > To do that, I will probably need to extend psci_set_osi_mode() to take
> > a bool as a parameter (to indicate enable or disable OSI mode). You
> > are okay with this, right?
> >
>
> I am fine with that. I assume by disable OSI mode, you are referring to
> switch back to PC mode.

Correct. New version is about to be posted.

Kind regards
Uffe
