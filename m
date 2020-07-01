Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293B0211257
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 20:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgGASGe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 14:06:34 -0400
Received: from foss.arm.com ([217.140.110.172]:35098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730227AbgGASGe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 14:06:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AC6F1FB;
        Wed,  1 Jul 2020 11:06:33 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE11C3F73C;
        Wed,  1 Jul 2020 11:06:32 -0700 (PDT)
Date:   Wed, 1 Jul 2020 19:06:31 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] cpufreq: allow drivers to flag custom support for
 freq invariance
Message-ID: <20200701180631.GA12482@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-2-ionela.voinescu@arm.com>
 <20200701094417.ffuvduz6pqknjcks@vireshk-i7>
 <20200701133330.GA32736@arm.com>
 <CAJZ5v0gT+xWwxcx3OZjXBnDLr9i4VOt2Vp3ScWBxbu+NiopkbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gT+xWwxcx3OZjXBnDLr9i4VOt2Vp3ScWBxbu+NiopkbA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Thank you for the review!

On Wednesday 01 Jul 2020 at 18:05:33 (+0200), Rafael J. Wysocki wrote:
> On Wed, Jul 1, 2020 at 3:33 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >
> > Hi,
> >
> > Thank you for taking a look over these so quickly.
> >
> > On Wednesday 01 Jul 2020 at 16:16:17 (+0530), Viresh Kumar wrote:
> > > On 01-07-20, 10:07, Ionela Voinescu wrote:
> > > > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > > > index 3494f6763597..42668588f9f8 100644
> > > > --- a/include/linux/cpufreq.h
> > > > +++ b/include/linux/cpufreq.h
> > > > @@ -293,7 +293,7 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
> > > >
> > > >  struct cpufreq_driver {
> > > >     char            name[CPUFREQ_NAME_LEN];
> > > > -   u8              flags;
> > > > +   u16             flags;
> > >
> > > Lets make it u32.
> > >
> > > >     void            *driver_data;
> > > >
> > > >     /* needed by all drivers */
> > > > @@ -417,6 +417,14 @@ struct cpufreq_driver {
> > > >   */
> > > >  #define CPUFREQ_IS_COOLING_DEV                     BIT(7)
> > > >
> > > > +/*
> > > > + * Set by drivers which implement the necessary calls to the scheduler's
> > > > + * frequency invariance engine. The use of this flag will result in the
> > > > + * default arch_set_freq_scale calls being skipped in favour of custom
> > > > + * driver calls.
> > > > + */
> > > > +#define CPUFREQ_CUSTOM_SET_FREQ_SCALE              BIT(8)
> > >
> > > I will rather suggest CPUFREQ_SKIP_SET_FREQ_SCALE as the name and
> > > functionality. We need to give drivers a choice if they do not want
> > > the core to do it on their behalf, because they are doing it on their
> > > own or they don't want to do it.
> 
> Well, this would go backwards to me, as we seem to be designing an
> opt-out flag for something that's not even implemented already.
> 
> I would go for an opt-in instead.  That would be much cleaner and less
> prone to regressions IMO.
> 
> >
> > In this case we would not be able to tell if cpufreq (driver or core)
> > can provide the frequency scale factor, so we would not be able to tell
> > if the system is really frequency invariant; CPUFREQ_SKIP_SET_FREQ_SCALE
> > would be set if either:
> >  - the driver calls arch_set_freq_scale() on its own
> >  - the driver does not want arch_set_freq_scale() to be called.
> >
> > So at the core level we would not be able to distinguish between the
> > two, and return whether cpufreq-based invariance is supported.
> >
> > I don't really see a reason why a driver would not want to set the
> > frequency scale factor, if it has the proper mechanisms to do so
> > (therefore excluding the exceptions mentioned in 2/8). I think the
> > cpufreq core or drivers should produce the information (set the scale
> > factor) and it should be up to the users to decide whether to use it or
> > not. But being invariant should always be the default.
> 
> So instead of what is being introduced by this patch, there should be
> an opt-in mechanism for drivers to tell the core to do the freq-scale
> factor setting on behalf of the driver.
> 


This could work better as it covers the following scenarios:
 - All the drivers in patch 3/8 would just use the flag to inform the
   the core that it can call arch_set_freq_scale() on their behalf.
 - It being omitted truly conveys the message that cpufreq information
   should not be used for frequency invariance, no matter the
   implementation of arch_set_freq_scale() (more details below)

The only case that it does not cover is is the scenario in patch 4/8:
one in which the driver is atypical and it needs its own calls to
arch_set_freq_scale(), while it still wants to be able to report support
for frequency invariance through cpufreq_sets_freq_scale() and later
arch_scale_freq_invariant(). But the jury is still out on whether that
part of the vexpress-spc driver should be given that much consideration.

My choice of flag was considering this case and potentially other future
ones like it, but this alternative also sounds good to me.


> Then, the driver would be responsible to only opt-in for that if it
> knows it for a fact that the sched tick doesn't set the freq-scale
> factor.
> 

I think that would create a tight coupling between the driver and the
architecture, when arch_set_freq_scale() is already meant to have the
same purpose, but it also provides some flexibility. Let me expand on
this below.

> > Therefore, there are a few reasons I went for
> > CPUFREQ_CUSTOM_SET_FREQ_SCALE instead:
> >  - It tells us if the driver has custom mechanisms to set the scale
> >    factor to filter the setting in cpufreq core and to inform the
> >    core on whether the system is frequency invariant.
> >  - It does have a user in the vexpress-spc driver.
> >  - Currently there aren't drivers that could but choose not to set
> >    the frequency scale factor, and it my opinion this should not be
> >    the case.
> 
> Well, that depends on what you mean by "could".
> 
> For example, it doesn't really make sense to set the freq-scale factor
> in either the ACPI cpufreq driver or intel_pstate, because the
> frequency (or P-state to be precise) requested by them may not be the
> one the CPU ends up running at and even so it may change at any time
> for various reasons (eg. in the turbo range).  However, the ACPI
> cpufreq driver as well as intel_pstate in the passive mode both set
> policy->cur, so that might be used for setting the freq-scale factor
> in principle, but that freq-scale factor may not be very useful in
> practice.
> 

Yes, this completely makes sense, and if there are more accurate methods
of obtaining information about the current performance level, by using
counters for example, they should definitely be used.

But in my opinion it should not be up to the driver to choose between
the methods. The driver and core would only have some information on the
current performance level (more or less accurate) and
arch_set_freq_scale() is called to *potentially* use it to set the scale
factor. So the use of policy->cur would be entirely dependent on the
implementation of arch_set_freq_scale().

There could be a few scenarios here:
 - arch_set_freq_scale() is left to its weak default that does nothing
   (which would be the case for when the ACPI cpufreq driver or
   intel_psate are used)
 - arch_set_freq_scale() is implemented in such a way that takes into
   account the presence of a counter-based method of setting the scale
   factor and makes that take precedence (currently done for the users
   of the arch_topology driver). This also provides support for platforms
   that have partial support for counters, where the use of cpufreq
   information is still useful for the CPUs that don't support counters.
   For those cases, some information, although not entirely accurate,
   is still better than no information at all.

So I believe cpufreq should just provide the information, if it can,
and let the user decide whether to use it, or what source of information
takes precedence. Therefore, arch_set_freq_scale() would decide to
whether to filter it out.

In any case, your suggestion regarding the choice of flag would make
bypassing the use of cpufreq information in setting the scale factor
explicit, no matter the definition of arch_set_freq_scale(). But it
would also require writers of cpufreq driver code to remember to
consider the setting of that flag.

I'll consider this more while gauging interest in 4/8.

Many thanks,
Ionela.

> Thanks!
