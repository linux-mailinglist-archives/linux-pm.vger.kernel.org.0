Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1577114FBC
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 12:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfLFLZ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 06:25:57 -0500
Received: from foss.arm.com ([217.140.110.172]:40270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfLFLZ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Dec 2019 06:25:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FFFC31B;
        Fri,  6 Dec 2019 03:25:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6458B3F52E;
        Fri,  6 Dec 2019 03:25:54 -0800 (PST)
Date:   Fri, 6 Dec 2019 11:25:49 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v3 10/13] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
Message-ID: <20191206112549.GA22964@e121166-lin.cambridge.arm.com>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
 <20191127102914.18729-11-ulf.hansson@linaro.org>
 <20191205183544.GB1516@e121166-lin.cambridge.arm.com>
 <CAPDyKFra-C_EKrcec6Yys2P10bB+KBtVAKNtVFgqDvV=tzbDRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFra-C_EKrcec6Yys2P10bB+KBtVAKNtVFgqDvV=tzbDRQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 05, 2019 at 09:25:54PM +0100, Ulf Hansson wrote:
> On Thu, 5 Dec 2019 at 19:35, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Wed, Nov 27, 2019 at 11:29:11AM +0100, Ulf Hansson wrote:
> >
> > [...]
> >
> > > -static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> > > +static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> > > +                                     struct device_node *cpu_node,
> > >                                       unsigned int state_count, int cpu)
> > >  {
> > >       int i, ret = 0;
> > > @@ -118,6 +152,11 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> > >               goto free_mem;
> > >       }
> > >
> > > +     /* Manage the deepest state via a dedicated enter-function. */
> > > +     if (dev)
> > > +             drv->states[state_count - 1].enter =
> > > +                     psci_enter_domain_idle_state;
> >
> >
> > It is unfortunate to make this arbitrary choice, it would be best
> > if you could detect which states are "domain" states aka are governed
> > by multiple cpus.
> 
> The domain states are managed and selected by the genpd providers, via
> using runtime PM reference counting. Please have a closer look at the
> code in cpuidle-psci-domain.c and in the generic PM domain, that
> should give you the needed details.
> 
> I am overriding the enter callback for the *deepest* known idle state
> of the CPU, which is according to what you requested [1].

Overriding it yes but I have not requested to do it only for the
deepest idle state that, I repeat, in my opinion is an arbitrary
choice that works for the platform you are testing on but is
not generic as it should.

You can merge it as it is but that's how things stand and adding
a comment to the *code* would help understand its logic.

> So, unless I am missing your point, I think the above code does
> exactly what you want, no?
> 
> In regards to the "arbitrary choice" of what cpuidle state to use,
> there are more details about why that is, in the changelog.
> 
> >
> > This inizialization though does not belong in here, it is done at driver
> > level, it should not be done in this per-cpu path. IIUC the logic the
> > enter pointer should only be overridden if and only if all cpus managed
> > by the driver have a corresponding device associated.
> 
> I think you have overlooked the fact that there are one cpuidle driver
> registered per CPU. The above doesn't make sense to me, sorry.

You are calling psci_dt_cpu_init_idle() for every possibile cpu.

Every time psci_dt_attach_cpu() is called, we check dev and override
the idle driver enter method. There is one driver, what I am saying
is that it is not correct to check dev and override the enter pointer
for *every* cpu that we try to attach to a power domain. This must
be done once for all by checking that *all* devices could be attached
to a power domain.

> > To be frank I would even move the psci_has_osi_support() check from
> > psci_dt_attach_cpu() to this path and prevent calling
> > psci_dt_attach_cpu() and the tail of the function if
> > (!psci_has_osi_support()).
> >
> > >       data->dev = dev;
> >
> > I think Sudeep already mentioned that, by using psci_has_osi_support()
> > as above you can prevent running this code, there is really no point,
> > the data->dev NULL sentinel is already initialized.
> 
> Yes, I discussed this with Sudeep, but we didn't reach a consensus.

Consensus was already reached.

http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1570.pdf

> Let me explain the reasons behind the selected approach, once more.
> 
> The data->dev is a pointer within a static declared struct. Are you
> sure it's assigned NULL by initialization? Don't we explicitly need to
> set it to NULL, else it will be undefined, no?

http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1570.pdf

6.7.9 (10) page 140

> Of course, I can move the check for psci_has_osi_support() into here
> and avoid calling psci_dt_attach_cpu(). Just wondering what that
> actually gain us, especially if we need to explicitly set the pointer
> to NULL anyway.

See above.

Thanks,
Lorenzo
