Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6428F8BE
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbgJOSi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 14:38:28 -0400
Received: from foss.arm.com ([217.140.110.172]:57454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733078AbgJOSi1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 14:38:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5776B13D5;
        Thu, 15 Oct 2020 11:38:26 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBD793F71F;
        Thu, 15 Oct 2020 11:38:25 -0700 (PDT)
Date:   Thu, 15 Oct 2020 19:38:24 +0100
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
Message-ID: <20201015183824.GA9440@arm.com>
References: <20201009140141.GA4048593@bogus>
 <2b7b6486-2898-1279-ce9f-9e7bd3512152@arm.com>
 <20201012105945.GA9219@arm.com>
 <500510b9-58f3-90b3-8c95-0ac481d468b5@arm.com>
 <20201012163032.GA30838@arm.com>
 <9fe56600-ba7d-d3b6-eea3-885475d94d7a@arm.com>
 <20201012220132.GA1715@arm.com>
 <CAJZ5v0hMtPARYezJEZqeUZBsyaSggQvtvvfEvONhz6Z=Y32bhQ@mail.gmail.com>
 <20201013123901.GA4945@arm.com>
 <CAJZ5v0gDfzFpJTLYMD=HsWKm5ORpx=398v+3q9DDoBbAh-aEsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gDfzFpJTLYMD=HsWKm5ORpx=398v+3q9DDoBbAh-aEsg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Sorry in advance for the long writing. I hope it makes sense.

On Thursday 15 Oct 2020 at 17:56:56 (+0200), Rafael J. Wysocki wrote:
> On Tue, Oct 13, 2020 at 2:39 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >
> > Hi Rafael,
> >
> > On Tuesday 13 Oct 2020 at 13:53:37 (+0200), Rafael J. Wysocki wrote:
> > > On Tue, Oct 13, 2020 at 12:01 AM Ionela Voinescu
> > > <ionela.voinescu@arm.com> wrote:
> > > >
> > > > Hey Lukasz,
> > > >
> > > > I think after all this discussion (in our own way of describing things)
> > > > we agree on how the current cpufreq based FIE implementation is affected
> > > > in systems that use hardware coordination.
> > > >
> > > > What we don't agree on is the location where that implementation (that
> > > > uses the new mask and aggregation) should be.
> > > >
> > > > On Monday 12 Oct 2020 at 19:19:29 (+0100), Lukasz Luba wrote:
> > > > [..]
> > > > > The previous FIE implementation where arch_set_freq_scale()
> > > > > was called from the drivers, was better suited for this issue.
> > > > > Driver could just use internal dependency cpumask or even
> > > > > do the aggregation to figure out the max freq for cluster
> > > > > if there is a need, before calling arch_set_freq_scale().
> > > > >
> > > > > It is not perfect solution for software FIE, but one of possible
> > > > > when there is no hw counters.
> > > > >
> > > > [..]
> > > >
> > > > > Difference between new FIE and old FIE (from v5.8) is that the new one
> > > > > purely relies on schedutil max freq value (which will now be missing),
> > > > > while the old FIE was called by the driver and thus it was an option to
> > > > > fix only the affected cpufreq driver [1][2].
> > > > >
> > > >
> > > > My final argument is that now you have 2 drivers that would need this
> > > > support, next you'll have 3 (the new mediatek driver), and in the future
> > > > there will be more. So why limit and duplicate this functionality in the
> > > > drivers? Why not make it generic for all drivers to use if the system
> > > > is using hardware coordination?
> > > >
> > > > Additionally, I don't think drivers should not even need to know about
> > > > these dependency/clock domains. They should act at the level of the
> > > > policy, which in this case will be at the level of each CPU.
> > >
> > > The policies come from the driver, though.
> > >
> > > The driver decides how many CPUs will be there in a policy and how to
> > > handle them at the initialization time.
> >
> > Yes, policies are built based on information populated from the drivers
> > at .init(): what CPUs will belong to a policy, what methods to use for
> > setting and getting frequency, etc.
> >
> > So they do pass this information to the cpufreq core to be stored at the
> > level of the policy, but later drivers (in the majority of cases) will
> > not need to store on their own information on what CPUs belong to a
> > frequency domain, they rely on having passed that information to the
> > core, and the core mechanisms hold this information on the clock domains
> > (currently through policy->cpus and policy->related_cpus).
> 
> Strictly speaking, not quite.
> 
> In fact policy->related_cpus is a set of CPUs that share a common perf
> control HW/FW interface which may or may not match the boundaries of
> clock domains etc.  That's what the entire cpufreq needs to know and
> cares about.
> 

Yes, generally speaking, you are absolutely correct, and actually this
is the motivation behind these patches: policy->related_cpus shows cpus
sharing the same perf controls, but we need "something else" to show us
the cpus sharing the same clocks.

It was my mistake for describing policy->related_cpus in the way I have
above, but my "excuse" is that I was referring to arm/arm64 platforms, in
the context of this cpufreq driver FIE, which is only present on
arm/arm64 platforms. I'll expand on this below.

Speaking practically, again referring to arm/arm64 platforms, for most*
of them, policy->related_cpus does also identify CPUs in the same clock
domain and therefore is used as if that was true. The obvious examples
are exactly the users that were presented as part of the motivation of
these patches: EAS, IPA, cpufreq-based FIE. They treat
policy->related_cpus as dependent cpus (cpus that change they performance
together or are clocked together).

*one of the exceptions is that old BL_SWITCHER support.

Another example of how the two (perf controls vs clock domains) are not
quite as separate in practice, is the cppc_cpufreq driver: that driver
reads the PSD domains and creates the policies based on the domains, not
based on the CPPC controls. It does mention only support for SW_ANY, but
that does not change the fact that the PSD (p-state dependency) is used to
populate policy->related_cpus and not any sharing of controls from _CPC.

Also, generically, policy->cpus (in schedutil or the ondemand governor)
is used as the basis for software coordination. I suppose software
coordination only has meaning at the level of a domain, so policy->cpus
is used as if providing the CPUs in a domain. If that wasn't the case,
their logic would not stand.

> AFAICS your scale invariance rework patches were based on the
> assumption that CPUs sharing an interface like that should also belong
> to the same frequency domain, which is reasonable and that's why I
> didn't have a problem with it, but if you were really assuming that
> policy->related_cpus must always reflect a frequency domain, then I'm
> afraid that you were not going in the right direction (the
> one-CPU-per-policy with HW coordination example should be sufficient
> to illustrate that).
> 

In my defence, I was definitely not assuming that, and I was one of the
first people bringing up HW_ALL in this thread :).

To expand on that, I never assumed policy->related_cpus *must always*
reflect frequency domains. But to that I have to add that FIE, as well
as EAS and IPA, are acting on policy->related_cpus as the closest to
accurate information on frequency domains that they can get. That is
the best information they have got and historically that was good enough.
That is exactly because on arm/arm64 platforms policy->related_cpus has,
more often than not, been describing clock domains as well. And again,
cpufreq-based FIE using policy->related_cpus is only implemented on
arm/arm64 platforms. For anything more accurate, counters should be
used.

Therefore, EAS, FIE, IPA, and even the schedutil and ondmand governors
for that matter, will always work best if policy->related_cpus reflects
the full composition of clock domains as well. It might not be always
true, but that is the best information that they can act on.

But now that new platforms are breaking these historical assumptions,
through these patches, the intention is to give these users better
information to act on, that is information about the real composition of
performance domains.

> It is correct that drivers generally don't need to know about the HW
> clock (or voltage for that matter) coordination dependencies, but the
> rest of cpufreq doesn't need to know about them either.  If that
> information is needed for something else, I don't see a reason to put
> it into cpufreq.

Right! If we say that cpufreq is meant for frequency control only, there
would be no reason. But I believe that is not so easy to separate
frequency control from frequency dependency. I suppose that was the
reason behind having policy->shared_type (as another example to
schedutil and ondemand software coordination). I believe coordination
only has meaning at the level of a domain and therefore should not
belong to a framework that would only reflect control.

Therefore, given precedents, it does seem consistent for information about
dependency domains to be placed in cpufreq as well, and possibly a good
place to make a clear separation between sharing of controls and sharing
of coordination.

But it might just be my interpretation. In any case, I appreciate your
time spent on this.

If cpufreq is not the correct location, are there better options that you
can recommend?

Thank you,
Ionela.
