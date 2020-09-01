Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05605259035
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 16:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIAOUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 10:20:32 -0400
Received: from foss.arm.com ([217.140.110.172]:42194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgIAOTr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 10:19:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B1E81045;
        Tue,  1 Sep 2020 07:11:49 -0700 (PDT)
Received: from bogus (unknown [10.57.5.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2F473F66F;
        Tue,  1 Sep 2020 07:11:47 -0700 (PDT)
Date:   Tue, 1 Sep 2020 15:11:41 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] cpuidle: psci: Allow PM domain to be initialized
 even if no OSI mode
Message-ID: <20200901141141.GA11121@bogus>
References: <20200901121226.217568-1-ulf.hansson@linaro.org>
 <20200901121226.217568-3-ulf.hansson@linaro.org>
 <20200901133218.GB27090@bogus>
 <CAPDyKFrpfXD4tdghXyFPZUNT138FOi643rxTgrtjTBXP1S1nSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrpfXD4tdghXyFPZUNT138FOi643rxTgrtjTBXP1S1nSg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 03:49:55PM +0200, Ulf Hansson wrote:
> On Tue, 1 Sep 2020 at 15:32, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Tue, Sep 01, 2020 at 02:12:26PM +0200, Ulf Hansson wrote:
> > > If the PSCI OSI mode isn't supported or fails to be enabled, the PM domain
> > > topology with the genpd providers isn't initialized. This is perfectly fine
> > > from cpuidle-psci point of view.
> > >
> > > However, since the PM domain topology in the DTS files is a description of
> > > the HW, no matter of whether the PSCI OSI mode is supported or not, other
> > > consumers besides the CPUs may rely on it.
> > >
> > > Therefore, let's always allow the initialization of the PM domain topology
> > > to succeed, independently of whether the PSCI OSI mode is supported.
> > > Consequentially we need to track if we succeed to enable the OSI mode, as
> > > to know when a domain idlestate can be selected.
> > >
> > > Note that, CPU devices are still not being attached to the PM domain
> > > topology, unless the PSCI OSI mode is supported.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v2:
> > >       - Assign the genpd ->power_off() callback, only when the PSCI OSI mode
> > >       has been successfully enabled.
> > >
> > > ---
> > >  drivers/cpuidle/cpuidle-psci-domain.c | 57 ++++++++++++++-------------
> > >  1 file changed, 29 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > index b6ab0415f450..256e7e35b5af 100644
> > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > @@ -105,7 +105,7 @@ static void psci_pd_free_states(struct genpd_power_state *states,
> > >       kfree(states);
> > >  }
> > >
> > > -static int psci_pd_init(struct device_node *np)
> > > +static int psci_pd_init(struct device_node *np, bool use_osi)
> > >  {
> > >       struct generic_pm_domain *pd;
> > >       struct psci_pd_provider *pd_provider;
> > > @@ -135,11 +135,14 @@ static int psci_pd_init(struct device_node *np)
> > >
> > >       pd->free_states = psci_pd_free_states;
> > >       pd->name = kbasename(pd->name);
> > > -     pd->power_off = psci_pd_power_off;
> > >       pd->states = states;
> > >       pd->state_count = state_count;
> > >       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
> > >
> > > +     /* Use the ->power_off() callback when OSI is enabled. */
> >
> > IIUC, you did mention that we need to attach PD even when the OSI fails
> > as this could be shared domain. With the below conditional assignment
> > of power_off, I understand that if OSI fails and we have domains attached,
> > then it will be always ON ?
>
> From a genpd point of view, the corresponding PM domain can be powered
> off (as long as all attached consumers allow that as well, of course).
>

Can be powered off ? Or will be powered off ? It sounds wrong if it will
be powered off as the domain needs to be powered up for CPU to be running.
It sounds like we may be out of sync though not a big issue, it sounds
weird for me.

> Hmm, maybe we should add a GENPD_FLAG_ALWAYS_ON, to really enforce
> that it stays on?
>

Should that not be default for CPU power domains if OSI can't be enabled ?

--
Regards,
Sudeep
