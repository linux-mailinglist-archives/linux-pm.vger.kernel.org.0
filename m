Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458312320C3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgG2OjQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 10:39:16 -0400
Received: from foss.arm.com ([217.140.110.172]:52760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgG2OjP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 10:39:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE3F530E;
        Wed, 29 Jul 2020 07:39:14 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 901B63F66E;
        Wed, 29 Jul 2020 07:39:14 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:39:13 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200729143903.GC12941@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-5-ionela.voinescu@arm.com>
 <CAJZ5v0jvvEvxs2dwsGd1kerTT3pJTJj6fVg0ndtdeUhiq+K_UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jvvEvxs2dwsGd1kerTT3pJTJj6fVg0ndtdeUhiq+K_UQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Monday 27 Jul 2020 at 16:02:18 (+0200), Rafael J. Wysocki wrote:
> On Wed, Jul 22, 2020 at 11:38 AM Ionela Voinescu
> <ionela.voinescu@arm.com> wrote:
[..]
> > +static inline
> > +void enable_cpufreq_freq_invariance(struct cpufreq_driver *driver)
> > +{
> > +       if ((driver->target || driver->target_index || driver->fast_switch) &&
> > +           !driver->setpolicy) {
> > +
> > +               static_branch_enable_cpuslocked(&cpufreq_set_freq_scale);
> > +               pr_debug("%s: Driver %s can provide frequency invariance.",
> > +                        __func__, driver->name);
> > +       } else
> > +               pr_err("%s: Driver %s cannot provide frequency invariance.",
> > +               __func__, driver->name);
> 
> This doesn't follow the kernel coding style (the braces around the
> pr_err() statement are missing).
> 

I'll fix this.

Also, depending on the result of the discussion below, it might be best
for this to be a warning, not an error.

> Besides, IMO on architectures where arch_set_freq_scale() is empty,
> this should be empty as well.
>

Yes, you are right, there are two aspects here:
 - (1) Whether a driver *can* provide frequency invariance. IOW, whether
   it implements the callbacks that result in the call to
   arch_set_freq_scale().

 - (2) Whether cpufreq/driver *does* provide frequency invariance. IOW,
   whether the call to arch_set_freq_scale() actually results in the
   setting of the scale factor.

Even when creating this v2 I was going back and forth between the options
for this:

(a) cpufreq should report whether it *can* provide frequency invariance
    (as described at (1)). If we go for this, for clarity I should change

    s/cpufreq_set_freq_scale/cpufreq_can_set_freq_scale_key
    s/cpufreq_sets_freq_scale()/cpufreq_can_set_freq_scale()

    Through this, cpufreq only reports that it calls
    arch_set_freq_scale(), independent on whether that call results in a
    scale factor being set. Then it would be up to the caller to ensure
    this information is used with a proper definition of
    arch_set_freq_scale().

(b) cpufreq should report whether it *does* provide frequency invariance

    A way of doing this is to use a arch_set_freq_scale define (as done
    for other arch functions, for example arch_scale_freq_tick()) and
    guard this enable_cpufreq_freq_invariance() function based on that
    definition.
    Therefore, cpufreq_sets_freq_scale() would report whether
    enable_cpufreq_freq_invariance() was successful and there is an
    external definition of arch_set_freq_scale() that sets the scale
    factor.


The current version is somewhat a combination of (a) and (b):
cpufreq_set_freq_scale would initially be enabled if the proper callbacks
are implemented (a), but later if the weak version of
arch_set_freq_scale() is called, we disabled it (b) (as can be seen below).

[..]
> >  __weak void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> >                 unsigned long max_freq)
> >  {
> > +       if (cpufreq_sets_freq_scale())
> > +               static_branch_disable_cpuslocked(&cpufreq_set_freq_scale);
> > +
> >  }
> >  EXPORT_SYMBOL_GPL(arch_set_freq_scale);

I suppose a clear (a) or (b) solution might be better here.

IMO, given that (b) cannot actually guarantee that a scale factor is set
through arch_set_freq_scale() given cpufreq information about current and
maximum frequencies, for me (a) is preferred as it conveys the only
information that cpufreq can convey - the fact that it *can* set the scale
factor, not that it *does*.

Can you please confirm whether you still prefer (b), given the details
above?

Thank you,
Ionela.
