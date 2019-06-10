Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678603B398
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbfFJK7J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 06:59:09 -0400
Received: from foss.arm.com ([217.140.110.172]:40554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388100AbfFJK7J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jun 2019 06:59:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04AE8337;
        Mon, 10 Jun 2019 03:59:08 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18E233F557;
        Mon, 10 Jun 2019 04:00:46 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:59:03 +0100
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
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 09/18] drivers: firmware: psci: Add support for PM
 domains using genpd
Message-ID: <20190610105903.GC26602@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-10-ulf.hansson@linaro.org>
 <20190607152751.GH15577@e107155-lin>
 <CAPDyKFq3FFZEAEKrPfvBPUpAGKaTo05zS0-5sfgBjGFhRZ0b=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq3FFZEAEKrPfvBPUpAGKaTo05zS0-5sfgBjGFhRZ0b=w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 10, 2019 at 12:21:41PM +0200, Ulf Hansson wrote:
> On Fri, 7 Jun 2019 at 17:27, Sudeep Holla <sudeep.holla@arm.com> wrote:
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

[...]

> > > +
> > > +static int psci_pd_parse_states(struct device_node *np,
> > > +                     struct genpd_power_state **states, int *state_count)
> > > +{
> > > +     int ret;
> > > +
> > > +     /* Parse the domain idle states. */
> > > +     ret = of_genpd_parse_idle_states(np, states, state_count);
> > > +     if (ret)
> > > +             return ret;
> > > +
> >
> >
> > Lots of things here in this file are not psci specific. They can be
> > moved as generic CPU PM domain support.
>
> What exactly do you mean by CPU PM domain support?
>
> The current split is based upon how the generic PM domain (genpd)
> supports CPU devices (see GENPD_FLAG_CPU_DOMAIN), which is already
> available.
>
> I agree that finding the right balance between what can be made
> generic and driver specific is not always obvious. Often it's better
> to start with having more things in the driver code, then move things
> into a common framework, later on, when that turns out to make sense.
>

Indeed, I agree. But when reviewing this time I thought it should be
possible to push generic stuff into existing dt_idle_driver. I must
admit that I haven't thought much in details, just thought of expressing
the idea and see. But yes it's difficult to find the balance but at the
same time we need reasons to have these in psci :)


> >
> > > +     /* Fill out the PSCI specifics for each found state. */
> > > +     ret = psci_pd_parse_state_nodes(*states, *state_count);
> > > +     if (ret)
> > > +             kfree(*states);
> > > +
> >
> > Things like above are PSCI.
> >
> > I am trying to see if we can do something to achieve partitions like we
> > have today: psci.c just has PSCI specific stuff and dt_idle_states.c
> > deals with generic idle stuff.
> 
> I am open to any suggestions. Although, I am not sure I understand
> your comment and nor the reason to why you want me to change.
> 
> So, what is the problem with having the code that you refer to, inside
> drivers/firmware/psci/psci_pm_domain.c? Can't we just start with that
> and see how it plays?
> 

I need to think how to partition this well. I don't have suggestions
right away, but I need to get convinced what we have here is best we
can do or come up with a better solution. I didn't like it as is at
this time.

--
Regards,
Sudeep
