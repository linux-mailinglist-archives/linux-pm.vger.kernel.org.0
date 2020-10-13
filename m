Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC3728CE7F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgJMMjI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 08:39:08 -0400
Received: from foss.arm.com ([217.140.110.172]:59338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbgJMMjD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 08:39:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB6311FB;
        Tue, 13 Oct 2020 05:39:02 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CA9F3F719;
        Tue, 13 Oct 2020 05:39:02 -0700 (PDT)
Date:   Tue, 13 Oct 2020 13:39:01 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201013123901.GA4945@arm.com>
References: <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
 <20201009140141.GA4048593@bogus>
 <2b7b6486-2898-1279-ce9f-9e7bd3512152@arm.com>
 <20201012105945.GA9219@arm.com>
 <500510b9-58f3-90b3-8c95-0ac481d468b5@arm.com>
 <20201012163032.GA30838@arm.com>
 <9fe56600-ba7d-d3b6-eea3-885475d94d7a@arm.com>
 <20201012220132.GA1715@arm.com>
 <CAJZ5v0hMtPARYezJEZqeUZBsyaSggQvtvvfEvONhz6Z=Y32bhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hMtPARYezJEZqeUZBsyaSggQvtvvfEvONhz6Z=Y32bhQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Tuesday 13 Oct 2020 at 13:53:37 (+0200), Rafael J. Wysocki wrote:
> On Tue, Oct 13, 2020 at 12:01 AM Ionela Voinescu
> <ionela.voinescu@arm.com> wrote:
> >
> > Hey Lukasz,
> >
> > I think after all this discussion (in our own way of describing things)
> > we agree on how the current cpufreq based FIE implementation is affected
> > in systems that use hardware coordination.
> >
> > What we don't agree on is the location where that implementation (that
> > uses the new mask and aggregation) should be.
> >
> > On Monday 12 Oct 2020 at 19:19:29 (+0100), Lukasz Luba wrote:
> > [..]
> > > The previous FIE implementation where arch_set_freq_scale()
> > > was called from the drivers, was better suited for this issue.
> > > Driver could just use internal dependency cpumask or even
> > > do the aggregation to figure out the max freq for cluster
> > > if there is a need, before calling arch_set_freq_scale().
> > >
> > > It is not perfect solution for software FIE, but one of possible
> > > when there is no hw counters.
> > >
> > [..]
> >
> > > Difference between new FIE and old FIE (from v5.8) is that the new one
> > > purely relies on schedutil max freq value (which will now be missing),
> > > while the old FIE was called by the driver and thus it was an option to
> > > fix only the affected cpufreq driver [1][2].
> > >
> >
> > My final argument is that now you have 2 drivers that would need this
> > support, next you'll have 3 (the new mediatek driver), and in the future
> > there will be more. So why limit and duplicate this functionality in the
> > drivers? Why not make it generic for all drivers to use if the system
> > is using hardware coordination?
> >
> > Additionally, I don't think drivers should not even need to know about
> > these dependency/clock domains. They should act at the level of the
> > policy, which in this case will be at the level of each CPU.
> 
> The policies come from the driver, though.
> 
> The driver decides how many CPUs will be there in a policy and how to
> handle them at the initialization time.

Yes, policies are built based on information populated from the drivers
at .init(): what CPUs will belong to a policy, what methods to use for
setting and getting frequency, etc.

So they do pass this information to the cpufreq core to be stored at the
level of the policy, but later drivers (in the majority of cases) will
not need to store on their own information on what CPUs belong to a
frequency domain, they rely on having passed that information to the
core, and the core mechanisms hold this information on the clock domains
(currently through policy->cpus and policy->related_cpus).

> 
> The core has no idea whether or not there is HW coordination in the
> system, the driver is expected to know that and take that into
> account.
> 

Given that multiple drivers could use hardware coordination, and
drivers already have a way to pass information about the type of
coordination to the core through policy->shared_type, could there be a
case for supporting this in the core, rather than the drivers?

In my head I'm finding this option better compared to having a select
set of drivers that would instruct the core to build the policies
per-cpu, while holding in the driver information about what CPUs
actually belong to clock domains.

Additionally, the cpufreq core will have to be able to present to other
frameworks (scheduler, thermal) this mask when requested, through a
cpufreq interface function. So in the end we'll still potentially end
up passing on this information from the driver to the core and then to
the user.

> Accordingly, it looks like there should be an option for drivers to
> arrange things in the most convenient way (from their perspective) and
> that option has gone away now.

IMO, even if this hardware coordination support is entirely managed by
the driver, one requirement is that other subsystems would be able to
acquire information about dependent cpus. The scheduler FIE should just
be another one of those users, with the decision on how that information
is handled residing in architecture code (arch_set_freq_scale()).
Architecture code might decide to have a default way of handling these
cases or not to support them at all.

Thank you,
Ionela.
