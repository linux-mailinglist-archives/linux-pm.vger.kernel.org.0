Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5604317AA72
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 17:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCEQXZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 11:23:25 -0500
Received: from foss.arm.com ([217.140.110.172]:50828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgCEQXZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Mar 2020 11:23:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B16D30E;
        Thu,  5 Mar 2020 08:23:25 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8755F3F534;
        Thu,  5 Mar 2020 08:23:23 -0800 (PST)
Date:   Thu, 5 Mar 2020 16:23:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] cpuidle: psci: Allow WFI to be the only state for
 the hierarchical topology
Message-ID: <20200305162321.GB53631@bogus>
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-5-ulf.hansson@linaro.org>
 <20200304122312.GE25004@bogus>
 <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 05, 2020 at 03:17:42PM +0100, Ulf Hansson wrote:
> On Wed, 4 Mar 2020 at 13:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The $subject is bit confusing. IIUC, if there are no idle states to
> > manage including hierarchical domain states you will not register the driver
> > right ? If so, you are not allowing WFI to be the only state, hence my
> > concern with $subject.
>
> I agree that's not so clear, but it wasn't easy to fit everything I
> wanted to say in one line. :-)
>

No worries, just wanted to clarified. Looking at the patch, lot of things
got clarified but thought we can always improve.

> Is this below better and okay for you?
>
> "cpuidle: psci: Update condition when avoiding driver registration".
>

Definitely better than $subject :)

> >
> > On Tue, Mar 03, 2020 at 09:35:59PM +0100, Ulf Hansson wrote:
> > > It's possible that only the WFI state is supported for the CPU, while also
> > > a shared idle state exists for a group of CPUs.
> > >
> > > When the hierarchical topology is used, the shared idle state may not be
> > > compatible with arm,idle-state, rather with "domain-idle-state", which
> > > makes dt_init_idle_driver() to return zero. This leads to that the
> > > cpuidle-psci driver bails out during initialization, avoiding to register a
> > > cpuidle driver and instead relies on the default architectural back-end
> > > (called via cpu_do_idle()). In other words, the shared idle state becomes
> > > unused.
> > >
> > > Let's fix this behaviour, by allowing the dt_init_idle_driver() to return 0
> > > and then continue with the initialization. If it turns out that the
> > > hierarchical topology is used and we have some additional states to manage,
> > > then continue with the cpuidle driver registration, otherwise bail out as
> > > before.
> > >
> > > Reported-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v2:
> > >       - Convert the error code returned from psci_cpu_suspend_enter() into an
> > >       expected error code by cpuidle core.
> > >
> > > ---
> > >  drivers/cpuidle/cpuidle-psci.c | 48 +++++++++++++++++++++-------------
> > >  1 file changed, 30 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > > index bae9140a65a5..ae0fabec2742 100644
> > > --- a/drivers/cpuidle/cpuidle-psci.c
> > > +++ b/drivers/cpuidle/cpuidle-psci.c
> > > @@ -56,16 +56,19 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> > >       u32 *states = data->psci_states;
> > >       struct device *pd_dev = data->dev;
> > >       u32 state;
> > > -     int ret;
> > > +     int ret = 0;
> > >
> > >       /* Do runtime PM to manage a hierarchical CPU toplogy. */
> > >       pm_runtime_put_sync_suspend(pd_dev);
> > >
> > >       state = psci_get_domain_state();
> > > -     if (!state)
> > > +     if (!state && states)
> > >               state = states[idx];
> > >
> > > -     ret = psci_enter_state(idx, state);
> > > +     if (state)
> > > +             ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> > > +     else
> > > +             cpu_do_idle();
> >
> > May be, I haven't followed this completely yet, but I don't want to be
> > in the position to replicated default arch idle hook. Just use the one
> > that exist by simply not registering the driver.
>
> That doesn't work for the configuration I am solving.
>
> Assume this scenario: We have WFI and a domain/cluster idle state.
> From the cpuidle governor point of view, it always selects the WFI
> state, which means idx is zero.
>

OK. The only state that cluster can enter when CPUs are in WFI are
cluster WFI and most hardware can handle it automatically. I don't see
the need to do any extra work for that.

> Then, after we have called pm_runtime_put_sync_suspend() a few lines
> above, we may potentially have a "domain state" to use, instead of the
> WFI state.
>

Are they any platforms with this potential "domain state" to use with
CPU WFI. I want to understand this better.

> In this case, if we would have called psci_enter_state(), that would
> lead us to calling cpu_do_idle() from the __CPU_PM_CPU_IDLE_ENTER()
> macro, becuase idx is zero. In other words, the domain state would
> become unused.
>

For a domain state to become unused with WFI, it needs to be available
and I am not 100% sure of that.

> Hope this clarifies what goes on here?
>

Yes.

--
Regards,
Sudeep
