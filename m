Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91AFB17A739
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 15:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCEOSV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 09:18:21 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33899 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCEOSV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 09:18:21 -0500
Received: by mail-vs1-f65.google.com with SMTP id y204so3654892vsy.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2020 06:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0wDyHzNqn+/6ChzKFPCyKMx102Jnw7HeFP/VoYqxN8=;
        b=SMkRCoBjs+DYJmTpaJRWyvYy3tXZsDisuWg4xIqbosMx73iqLgVTZ0/+4raYqhWTkM
         9Hsx7NMtX9xsRhjp/VmsLwUSOdFMayJJqT6z4pJRbEmNROUrvLwtSioer3lGiukKk8e6
         pnPNwZRM2qZwor1BcFvVRMfreayHRoUa66z19fiDp6ymT/a+ZiSaCbVTgbnpbMTHahZQ
         KTxSnbiQvfwAvNMvcc0ixae3qC/QaHa5qLGkTuUadJsEBriqu8+3tRvTTXHpfc0EA9C6
         CsQii4o7PAEldXZ9QKQHiNpG/xCZYQNbmD+umwVkvKetJuD/jUgcREy8Pu0GbFVxFG5Z
         lodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0wDyHzNqn+/6ChzKFPCyKMx102Jnw7HeFP/VoYqxN8=;
        b=GdDKRqWrZCe64DNKSXeK/WgGdtu9CSBNJ3h4KhkjBSCgmVSHGOHMO3kzTgrtCu2pCz
         OKLNNX62q+Tm8mdzDnnOXdHPDtFpatXCAtFZtAhtbvRSHcV3vCC+qCslO1GXFEYwUO2V
         8hLinlyibTm7gA8V6i7EVnZlCit1WTUHF9zFKrPm6NqTt3kU1qTgbKDDi4UIO2ycXYKN
         bdd4ewB3TVtTZNSW2YTXkZUza2a29H9vhhDZSABQ/jyyATWIrN/MrI7X3UtptNu/7rA5
         zHr8H3GSjgbu3G0ILocad0OWMpu4yZF87HU5VmiZQ/VuYJBvsmBozJ+oCjsW8/uEGfUi
         9zjw==
X-Gm-Message-State: ANhLgQ2iJrXv24Q0XCa/V2RMxwYudy2lLNIWS8CnnJc5Jq6HsatCdU6j
        RwAp5/uTs1SvU4O2AL8k3pNSQaQxiTmvkkunq1pm2A==
X-Google-Smtp-Source: ADFU+vtToLQ+muWK+2stMVmcNTMXIicD7xT/G3cpottHThd7RLHVKgCMu9PUBaA/UB1KH77w6dcpVPPrncDfMV9Crj0=
X-Received: by 2002:a67:800e:: with SMTP id b14mr5182339vsd.191.1583417898736;
 Thu, 05 Mar 2020 06:18:18 -0800 (PST)
MIME-Version: 1.0
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-5-ulf.hansson@linaro.org> <20200304122312.GE25004@bogus>
In-Reply-To: <20200304122312.GE25004@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Mar 2020 15:17:42 +0100
Message-ID: <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] cpuidle: psci: Allow WFI to be the only state for
 the hierarchical topology
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
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

On Wed, 4 Mar 2020 at 13:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The $subject is bit confusing. IIUC, if there are no idle states to
> manage including hierarchical domain states you will not register the driver
> right ? If so, you are not allowing WFI to be the only state, hence my
> concern with $subject.

I agree that's not so clear, but it wasn't easy to fit everything I
wanted to say in one line. :-)

Is this below better and okay for you?

"cpuidle: psci: Update condition when avoiding driver registration".

>
> On Tue, Mar 03, 2020 at 09:35:59PM +0100, Ulf Hansson wrote:
> > It's possible that only the WFI state is supported for the CPU, while also
> > a shared idle state exists for a group of CPUs.
> >
> > When the hierarchical topology is used, the shared idle state may not be
> > compatible with arm,idle-state, rather with "domain-idle-state", which
> > makes dt_init_idle_driver() to return zero. This leads to that the
> > cpuidle-psci driver bails out during initialization, avoiding to register a
> > cpuidle driver and instead relies on the default architectural back-end
> > (called via cpu_do_idle()). In other words, the shared idle state becomes
> > unused.
> >
> > Let's fix this behaviour, by allowing the dt_init_idle_driver() to return 0
> > and then continue with the initialization. If it turns out that the
> > hierarchical topology is used and we have some additional states to manage,
> > then continue with the cpuidle driver registration, otherwise bail out as
> > before.
> >
> > Reported-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Convert the error code returned from psci_cpu_suspend_enter() into an
> >       expected error code by cpuidle core.
> >
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 48 +++++++++++++++++++++-------------
> >  1 file changed, 30 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index bae9140a65a5..ae0fabec2742 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -56,16 +56,19 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> >       u32 *states = data->psci_states;
> >       struct device *pd_dev = data->dev;
> >       u32 state;
> > -     int ret;
> > +     int ret = 0;
> >
> >       /* Do runtime PM to manage a hierarchical CPU toplogy. */
> >       pm_runtime_put_sync_suspend(pd_dev);
> >
> >       state = psci_get_domain_state();
> > -     if (!state)
> > +     if (!state && states)
> >               state = states[idx];
> >
> > -     ret = psci_enter_state(idx, state);
> > +     if (state)
> > +             ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> > +     else
> > +             cpu_do_idle();
>
> May be, I haven't followed this completely yet, but I don't want to be
> in the position to replicated default arch idle hook. Just use the one
> that exist by simply not registering the driver.

That doesn't work for the configuration I am solving.

Assume this scenario: We have WFI and a domain/cluster idle state.
From the cpuidle governor point of view, it always selects the WFI
state, which means idx is zero.

Then, after we have called pm_runtime_put_sync_suspend() a few lines
above, we may potentially have a "domain state" to use, instead of the
WFI state.

In this case, if we would have called psci_enter_state(), that would
lead us to calling cpu_do_idle() from the __CPU_PM_CPU_IDLE_ENTER()
macro, becuase idx is zero. In other words, the domain state would
become unused.

Hope this clarifies what goes on here?

Kind regards
Uffe
