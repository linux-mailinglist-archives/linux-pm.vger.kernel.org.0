Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4AE2588B4
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 09:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIAHFh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 03:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAHFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 03:05:35 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261CAC0612AC
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 00:05:35 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id u48so112068uau.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 00:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOWR/Dbxo4pn7ymdX+txi6UrCHlMOtlHu8p1YA8a1cU=;
        b=GajV9piXrWVG8LTZUr39pDhtjwA+g1sy0rFBzTIR0FwcbXFzxL8JOaRLQZppKz9e7D
         7kdX3Btriceh5sqW/sXN8OMlztH61BgiG7AftxFzS79V30mrdu6CnbN1QKeMQq5WsKv1
         uZ+ikVtk0vAd32Et7aQLNtxxp33AWn2dzIIhTtH4iUIuOfPQBquHfCy5TH5h+fPzKPz0
         y5jCXMrCtUgfUOOrhWuQaA+o4T4xAdQddIGCE4wa57bURRhjHHfrZVj8uDXSfEnq/GYo
         Pc71rEN3XLzh/iFac+UPO+jRdlikVo8priGFgKuLC581CuTHsKzZwQFvoc91sVHZHFq+
         4XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOWR/Dbxo4pn7ymdX+txi6UrCHlMOtlHu8p1YA8a1cU=;
        b=Q+COPe5UA3smZr/wAq2iMInYGuy2PdTrkpYWjinQDhQtFdDaZEJTDPlZ/MAN32r8rl
         00UWTfgjZTjYEs+szW8gpXXH710daoK+ELmd13onIMoTQsnjp/k07JE6zia2ecOeEi7b
         7gGR6H2q8hOn3hMittmXEVAGGUpxwAAR6QT/EgxgoPmJT6Sv2qA7wv6yVR+x3l4gQnFz
         HamMQ/Kc+1qk6ijnHPuH8WoxbEZNQG6EMvzoC7xhbvJkzz4SBgW385Lvce6KAEEmZJOf
         aM6W/7hrtnaGluOOPTE8J/oGp46afHXfCXcZ8NS+fhTUI6L7eXAGTfDev/ddZnfkkLpW
         05pA==
X-Gm-Message-State: AOAM5313dPcA/zArO2hmvHX8L8L/iw+dOgFCqoy1SW9zc94mE+nLDCQb
        73wW0mvkV+H8Pdv/rnekJivSUr/8jnv26UAiE01OGA==
X-Google-Smtp-Source: ABdhPJxPEmnQbxgLnQvWTHsOvluVxS/3Wx63yxDz5lYmOQFgzAjJ2k1l6GOcMftUD2/GFW7BraMgEKe29SCbEt9rSS8=
X-Received: by 2002:ab0:5e7:: with SMTP id e94mr203632uae.104.1598943932481;
 Tue, 01 Sep 2020 00:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200814123436.61851-1-ulf.hansson@linaro.org>
 <20200818123507.GD6873@bogus> <CAPDyKFqi4uOBQkTZMvSnDTCsKdNoToCO4s7h1CnR-mkJ2vBNSw@mail.gmail.com>
In-Reply-To: <CAPDyKFqi4uOBQkTZMvSnDTCsKdNoToCO4s7h1CnR-mkJ2vBNSw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Sep 2020 09:04:56 +0200
Message-ID: <CAPDyKFo-pW6rGViAUxacCxnhTcavEhR7q5jg8CRKS8DNB3_sSw@mail.gmail.com>
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

On Wed, 19 Aug 2020 at 10:20, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 18 Aug 2020 at 14:35, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Aug 14, 2020 at 02:34:36PM +0200, Ulf Hansson wrote:
> > > If the PSCI OSI mode isn't supported or fails to be enabled, the PM domain
> > > topology with the genpd providers isn't initialized. This is perfectly fine
> > > from cpuidle-psci point of view.
> > >
> >
> > Indeed.
> >
> > > However, since the PM domain topology in the DTS files is a description of
> > > the HW, no matter of whether the PSCI OSI mode is supported or not, other
> > > consumers besides the CPUs may rely on it.
> > >
> >
> > And why are they even registered as part of cpuidle-psci-domain ?
> > If they have to be, can be decouple it completely from cpuidle then ?
>
> These devices can't be decoupled as they are a part of the CPU cluster
> PM domain.
>
> This is for example the case RPMH (rsc) device for Qcom platforms, but
> there are other platforms that need this too.
>
> >
> > > Therefore, let's always allow the initialization of the PM domain topology
> > > to succeed, independently of whether the PSCI OSI mode is supported.
> > > Consequentially we need to track if we succeed to enable the OSI mode, as
> > > to know when a domain idlestate can be selected.
> > >
> >
> > I thought we had discussed this in past, why are we back to the same
> > discussion ? I may need to read those again to get the context.
>
> That discussion was according to my understanding about whether we
> should allow CPU devices to be managed by runtime PM and the CPU PM
> domains, if OSI was *not* supported.
>
> We concluded that we didn't want to allow that, which makes sense -
> and I am not changing that in $subject patch.
>
> >
> > > Note that, CPU devices are still not being attached to the PM domain
> > > topology, unless the PSCI OSI mode is supported.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/cpuidle/cpuidle-psci-domain.c | 49 +++++++++++++--------------
> > >  1 file changed, 24 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > index b6e9649ab0da..55653c110e3a 100644
> > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > @@ -28,6 +28,7 @@ struct psci_pd_provider {
> > >
> > >  static LIST_HEAD(psci_pd_providers);
> > >  static bool psci_pd_allow_domain_state;
> > > +static bool psci_osi_mode_enabled;
> > >
> > >  static int psci_pd_power_off(struct generic_pm_domain *pd)
> > >  {
> > > @@ -37,7 +38,7 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
> > >       if (!state->data)
> > >               return 0;
> > >
> > > -     if (!psci_pd_allow_domain_state)
> > > +     if (!psci_pd_allow_domain_state || !psci_osi_mode_enabled)
> >
> > I really don't like this check. Why do we have to keep checking
> > psci_osi_mode_enabled every single time and that is the reason IIRC
> > I was against this and just don't add the domains.
>
> You have a point about the check, it's not very nice - but from an
> execution point of view, I don't think it's the end of the world.
>
> Note that, when not using OSI, then the ->power_off() callback will
> not be invoked in the cpuidle path.
>
> Anyway, if you like, I can try to rework the code, so that the
> ->power_off() callback doesn't get assigned, if we are not using OSI.
> Although, I am not sure the trouble is worth it, as I probably need to
> try to enable OSI before initializing the genpd data structures. Then,
> if failing with genpd initializations, I need to revert back to PC
> mode.
>
> What do you think?

Sudeep, do any further comments on this? Or you want to give it your
blessings so Rafael can pick it up?

Kind regards
Uffe
