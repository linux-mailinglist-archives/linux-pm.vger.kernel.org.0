Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE155212281
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 13:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgGBLp1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 07:45:27 -0400
Received: from foss.arm.com ([217.140.110.172]:42930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbgGBLp1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Jul 2020 07:45:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F5111FB;
        Thu,  2 Jul 2020 04:45:26 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5B083F71E;
        Thu,  2 Jul 2020 04:45:25 -0700 (PDT)
Date:   Thu, 2 Jul 2020 12:45:24 +0100
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
Subject: Re: [PATCH 2/8] cpufreq: move invariance setter calls in cpufreq core
Message-ID: <20200702114524.GC28120@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-3-ionela.voinescu@arm.com>
 <20200701095219.gxrkowtukosnfmwp@vireshk-i7>
 <20200701152751.GA29496@arm.com>
 <CAJZ5v0gg4CtixKXEWG4agPATJxm5NZ4bnNVsqt7mRpwZS0Nygw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gg4CtixKXEWG4agPATJxm5NZ4bnNVsqt7mRpwZS0Nygw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Wednesday 01 Jul 2020 at 17:51:26 (+0200), Rafael J. Wysocki wrote:
> On Wed, Jul 1, 2020 at 5:28 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >
> > Hey,
> >
> > On Wednesday 01 Jul 2020 at 16:16:19 (+0530), Viresh Kumar wrote:
> > > On 01-07-20, 10:07, Ionela Voinescu wrote:
> > > > From: Valentin Schneider <valentin.schneider@arm.com>
> > > >
> > > > To properly scale its per-entity load-tracking signals, the task scheduler
> > > > needs to be given a frequency scale factor, i.e. some image of the current
> > > > frequency the CPU is running at. Currently, this scale can be computed
> > > > either by using counters (APERF/MPERF on x86, AMU on arm64), or by
> > > > piggy-backing on the frequency selection done by cpufreq.
> > > >
> > > > For the latter, drivers have to explicitly set the scale factor
> > > > themselves, despite it being purely boiler-plate code: the required
> > > > information depends entirely on the kind of frequency switch callback
> > > > implemented by the driver, i.e. either of: target_index(), target(),
> > > > fast_switch() and setpolicy().
> > > >
> > > > The fitness of those callbacks with regard to driving the Frequency
> > > > Invariance Engine (FIE) is studied below:
> > > >
> > > > target_index()
> > > > ==============
> > > > Documentation states that the chosen frequency "must be determined by
> > > > freq_table[index].frequency". It isn't clear if it *has* to be that
> > > > frequency, or if it can use that frequency value to do some computation
> > > > that ultimately leads to a different frequency selection. All drivers
> > > > go for the former, while the vexpress-spc-cpufreq has an atypical
> > > > implementation.
> > > >
> > > > Thefore, the hook works on the asusmption the core can use
> > > > freq_table[index].frequency.
> > > >
> > > > target()
> > > > =======
> > > > This has been flagged as deprecated since:
> > > >
> > > >   commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
> > > >
> > > > It also doesn't have that many users:
> > > >
> > > >   cpufreq-nforce2.c:371:2:  .target = nforce2_target,
> > > >   cppc_cpufreq.c:416:2:             .target = cppc_cpufreq_set_target,
> > > >   pcc-cpufreq.c:573:2:              .target = pcc_cpufreq_target,
> > > >
> > > > Should we care about drivers using this hook, we may be able to exploit
> > > > cpufreq_freq_transition_{being, end}(). Otherwise, if FIE support is
> > > > desired in their current state, arch_set_freq_scale() could still be
> > > > called directly by the driver, while CPUFREQ_CUSTOM_SET_FREQ_SCALE
> > > > could be used to mark support for it.
> > > >
> > > > fast_switch()
> > > > =============
> > > > This callback *has* to return the frequency that was selected.
> > > >
> > > > setpolicy()
> > > > ===========
> > > > This callback does not have any designated way of informing what was the
> > > > end choice. But there are only two drivers using setpolicy(), and none
> > > > of them have current FIE support:
> > > >
> > > >   drivers/cpufreq/longrun.c:281:    .setpolicy      = longrun_set_policy,
> > > >   drivers/cpufreq/intel_pstate.c:2215:      .setpolicy      = intel_pstate_set_policy,
> > > >
> > > > The intel_pstate is known to use counter-driven frequency invariance.
> > >
> > > Same for acpi-cpufreq driver as well ?
> > >
> >
> > The acpi-cpufreq driver defines target_index() and fast_switch() so it
> > should go through the setting in cpufreq core. But x86 does not actually
> > define arch_set_freq_scale() so when called it won't do anything (won't
> > set any frequency scale factor), but rely on counters to set it through
> > the arch_scale_freq_tick().
> 
> Right.
> 
> So on x86 (Intel flavor of it at least), cpufreq has nothing to do
> with this regardless of what driver is in use.
> 
> > But this cpufreq functionality could potentially be used.
> 
> How so?
> 

I was thinking of a scenario in which counters were not available and
cpufreq could give a rough indication of the current performance, if
arch_set_freq_scale() would be defined to pass that information.
It's improbable, but the implementation would allow it.

> >
> > > And I think we should do the freq-invariance thing for all the above categories
> > > nevertheless.
> > >
> >
> > I'm not sure what you mean by this. You mean we should also (try to) set
> > the frequency scale factor for drivers defining setpolicy() and target()?
> 
> No, we shouldn't.
> 
> The sched tick potentially does that already and nothing more needs to
> be done unless we know it for the fact that the scale factor is not
> set by the tick.
> 
> > > > If FIE support is desired in their current state, arch_set_freq_scale()
> > > > could still be called directly by the driver, while
> > > > CPUFREQ_CUSTOM_SET_FREQ_SCALE could be used to mark support for it.
> > > >
> > > > Conclusion
> > > > ==========
> > > >
> > > > Given that the significant majority of current FIE enabled drivers use
> > > > callbacks that lend themselves to triggering the setting of the FIE scale
> > > > factor in a generic way, move the invariance setter calls to cpufreq core,
> > > > while filtering drivers that flag custom support using
> > > > CPUFREQ_CUSTOM_SET_FREQ_SCALE.
> > > >
> > > > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > > > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c | 20 +++++++++++++++++---
> > > >  1 file changed, 17 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 0128de3603df..83b58483a39b 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -2046,9 +2046,16 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> > > >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > > >                                     unsigned int target_freq)
> > > >  {
> > > > +   unsigned int freq;
> > > > +
> > > >     target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > > +   freq = cpufreq_driver->fast_switch(policy, target_freq);
> > > > +
> > >
> > > > +   if (freq && !(cpufreq_driver->flags & CPUFREQ_CUSTOM_SET_FREQ_SCALE))
> > > > +           arch_set_freq_scale(policy->related_cpus, freq,
> > > > +                               policy->cpuinfo.max_freq);
> 
> policy->cpuinfo.max_freq need not be the one to use in all cases when
> boost is supported.
> 
> policy->cpuinfo.max_freq may be the max boost freq and you may want to
> scale with respect to the max sustainable one anyway.
> 
> > > This needs to be a separate function.
> > >
> >
> > Yes, that would be nicer.
> >
> > > >
> > > > -   return cpufreq_driver->fast_switch(policy, target_freq);
> > > > +   return freq;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> > > >
> > > > @@ -2140,7 +2147,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
> > > >                         unsigned int relation)
> > > >  {
> > > >     unsigned int old_target_freq = target_freq;
> > > > -   int index;
> > > > +   int index, retval;
> > > >
> > > >     if (cpufreq_disabled())
> > > >             return -ENODEV;
> > > > @@ -2171,7 +2178,14 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
> > > >
> > > >     index = cpufreq_frequency_table_target(policy, target_freq, relation);
> > > >
> > > > -   return __target_index(policy, index);
> > > > +   retval = __target_index(policy, index);
> > > > +
> > > > +   if (!retval && !(cpufreq_driver->flags & CPUFREQ_CUSTOM_SET_FREQ_SCALE))
> > > > +           arch_set_freq_scale(policy->related_cpus,
> > > > +                               policy->freq_table[index].frequency,
> > >
> > > policy->cur gets updated for both target and target_index type drivers. You can
> > > use that safely. It gets updated after the postchange notification.
> > >
> >
> > This would allow us to cover the drivers that define target() as well (not
> > only target_index() and fast_switch()). Looking over the code we only take
> > that path (calling cpufreq_freq_transition_end()), for
> > !CPUFREQ_ASYNC_NOTIFICATION. But again, that's only used for
> > powernow-k8 which is deprecated.
> >
> > I'll attempt a nice way to use this.
> 
> On arches like x86, policy->cur may not be the current frequency of
> the CPU, though.  On relatively recent systems it actually isn't that
> frequency most of the time.
> 


Yes, as discussed on the other patches my reasoning was that
arch_set_freq_scale() would filter less accurate information from
cpufreq and give priority to counter use.

But I understand your reasoning on this, and that both you and Viresh
would prefer a more strict 'opt in' policy for which drivers are
appropriate for use with frequency invariance.

So I'll make the suggested changes.

Kind regards,
Ionela.

> Thanks!
