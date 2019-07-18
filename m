Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4616CEBC
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390351AbfGRNTW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 09:19:22 -0400
Received: from foss.arm.com ([217.140.110.172]:58330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390534AbfGRNTT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 754B6344;
        Thu, 18 Jul 2019 06:19:18 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A94253F71F;
        Thu, 18 Jul 2019 06:19:15 -0700 (PDT)
Date:   Thu, 18 Jul 2019 14:19:13 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 09/18] drivers: firmware: psci: Add support for PM
 domains using genpd
Message-ID: <20190718131913.GB28633@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-10-ulf.hansson@linaro.org>
 <20190716150533.GD7250@e107155-lin>
 <CAPDyKFqaE2L419siFY=LGDsotAnpBt+H_vpmG62AqQw8UQJZJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqaE2L419siFY=LGDsotAnpBt+H_vpmG62AqQw8UQJZJA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 18, 2019 at 01:04:03PM +0200, Ulf Hansson wrote:
> On Tue, 16 Jul 2019 at 17:05, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, May 13, 2019 at 09:22:51PM +0200, Ulf Hansson wrote:
> > > When the hierarchical CPU topology layout is used in DT, we need to setup
> > > the corresponding PM domain data structures, as to allow a CPU and a group
> > > of CPUs to be power managed accordingly. Let's enable this by deploying
> > > support through the genpd interface.
> > >
> > > Additionally, when the OS initiated mode is supported by the PSCI FW, let's
> > > also parse the domain idle states DT bindings as to make genpd responsible
> > > for the state selection, when the states are compatible with
> > > "domain-idle-state". Otherwise, when only Platform Coordinated mode is
> > > supported, we rely solely on the state selection to be managed through the
> > > regular cpuidle framework.
> > >
> > > If the initialization of the PM domain data structures succeeds and the OS
> > > initiated mode is supported, we try to switch to it. In case it fails,
> > > let's fall back into a degraded mode, rather than bailing out and returning
> > > an error code.
> > >
> > > Due to that the OS initiated mode may become enabled, we need to adjust to
> > > maintain backwards compatibility for a kernel started through a kexec call.
> > > Do this by explicitly switch to Platform Coordinated mode during boot.
> > >
> > > Finally, the actual initialization of the PM domain data structures, is
> > > done via calling the new shared function, psci_dt_init_pm_domains().
> > > However, this is implemented by subsequent changes.
> > >
> > > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes:
> > >       - Simplify code setting domain_state at power off.
> > >       - Use the genpd ->free_state() callback to manage freeing of states.
> > >       - Fixup a bogus while loop.
> > >
> > > ---
> > >  drivers/firmware/psci/Makefile         |   2 +-
> > >  drivers/firmware/psci/psci.c           |   7 +-
> > >  drivers/firmware/psci/psci.h           |   5 +
> > >  drivers/firmware/psci/psci_pm_domain.c | 268 +++++++++++++++++++++++++
> > >  4 files changed, 280 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/firmware/psci/psci_pm_domain.c
> > >
> >
> > [...]
> >
> > >  #endif /* __PSCI_H */
> > > diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
> > > new file mode 100644
> > > index 000000000000..3c6ca846caf4
> > > --- /dev/null
> > > +++ b/drivers/firmware/psci/psci_pm_domain.c
> > > @@ -0,0 +1,268 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PM domains for CPUs via genpd - managed by PSCI.
> > > + *
> > > + * Copyright (C) 2019 Linaro Ltd.
> > > + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> > > + *
> > > + */
> > > +
> >
> > [...]
> >
> > > +static int psci_pd_power_off(struct generic_pm_domain *pd)
> > > +{
> > > +     struct genpd_power_state *state = &pd->states[pd->state_idx];
> > > +     u32 *pd_state;
> > > +
> > > +     /* If we have failed to enable OSI mode, then abort power off. */
> > > +     if (psci_has_osi_support() && !osi_mode_enabled)
> > > +             return -EBUSY;
> > > +
> > > +     if (!state->data)
> > > +             return 0;
> > > +
> > > +     /* When OSI mode is enabled, set the corresponding domain state. */
> > > +     pd_state = state->data;
> > > +     psci_set_domain_state(*pd_state);
> >
> > I trying to understand how would this scale to level 2(cluster of
> > clusters or for simply system). The current code for psci_set_domain_state
> > just stores the value @pd_state into per-cpu domain_state. E.g.: Now if
> > the system level pd is getting called after cluster PD, it will set the
> > domain state to system level PD state. It won't work with original
> > format and it may work with extended format if it's carefully crafted.
> > In short, the point is just over-writing domain_state is asking for
> > troubles IMO.
>
> Thanks for spotting this!
>
> While walking upwards in the PM domain topology, I thought I was ORing
> the domain states, but clearly the code isn't doing that.
>
> In principle we need to do the below instead.
>
> pd_state = state->data;
> composite_pd_state = *pd_state | psci_get_domain_state();
> psci_set_domain_state(composite_pd_state);
>

Yes 2 different issues here:
1. The direct assignment overwriting the value is problem which you agree.
2. The OR logic on it's own is bit not so clear from the specification.
   Since firmware authors need to be aware of this to make all these
   work. So it's not implicit, either we set this requirement in form
   of binding. We were also thinking of stating composite state in the
   DT, still just a thought, need to come up with examples/illustrations.

--
Regards,
Sudeep
