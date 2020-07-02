Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3021227D
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgGBLo2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 07:44:28 -0400
Received: from foss.arm.com ([217.140.110.172]:42806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgGBLo2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Jul 2020 07:44:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B83631FB;
        Thu,  2 Jul 2020 04:44:27 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A3313F71E;
        Thu,  2 Jul 2020 04:44:27 -0700 (PDT)
Date:   Thu, 2 Jul 2020 12:44:25 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20200702114425.GB28120@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-2-ionela.voinescu@arm.com>
 <20200701094417.ffuvduz6pqknjcks@vireshk-i7>
 <20200701133330.GA32736@arm.com>
 <CAJZ5v0gT+xWwxcx3OZjXBnDLr9i4VOt2Vp3ScWBxbu+NiopkbA@mail.gmail.com>
 <20200702025818.s4oh7rzz3tr6zwqr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702025818.s4oh7rzz3tr6zwqr@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thursday 02 Jul 2020 at 08:28:18 (+0530), Viresh Kumar wrote:
> On 01-07-20, 18:05, Rafael J. Wysocki wrote:
> > On Wed, Jul 1, 2020 at 3:33 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > > On Wednesday 01 Jul 2020 at 16:16:17 (+0530), Viresh Kumar wrote:
> > > > I will rather suggest CPUFREQ_SKIP_SET_FREQ_SCALE as the name and
> > > > functionality. We need to give drivers a choice if they do not want
> > > > the core to do it on their behalf, because they are doing it on their
> > > > own or they don't want to do it.
> > 
> > Well, this would go backwards to me, as we seem to be designing an
> > opt-out flag for something that's not even implemented already.
> > 
> > I would go for an opt-in instead.  That would be much cleaner and less
> > prone to regressions IMO.
> 
> That's fine, I just wanted an option for drivers to opt-out of this
> thing. I felt okay with the opt-out flag as this should be enabled for
> most of the drivers and so enabling by default looked okay as well.
> 
> > > In this case we would not be able to tell if cpufreq (driver or core)
> > > can provide the frequency scale factor, so we would not be able to tell
> > > if the system is really frequency invariant; CPUFREQ_SKIP_SET_FREQ_SCALE
> 
> That is easy to fix. Let the drivers call
> enable_cpufreq_freq_invariance() and set the flag.
> 

Right! I suppose part of "the dream" :) was for drivers to be ignorant of
frequency invariance, and for the core to figure out if it has proper
information to potentially* pass to the scheduler.

*potentially = depending on the arch_set_freq_scale() definition.

> > > would be set if either:
> > >  - the driver calls arch_set_freq_scale() on its own
> > >  - the driver does not want arch_set_freq_scale() to be called.
> > >
> > > So at the core level we would not be able to distinguish between the
> > > two, and return whether cpufreq-based invariance is supported.
> > >
> > > I don't really see a reason why a driver would not want to set the
> > > frequency scale factor
> 
> A simple case where the driver doesn't have any idea what the real
> freq 

For me, this would have been filtered by either the type of callback
they use (target_index(), fast_switch() and even target() would offer
some close to accurate indication of the current frequency, while
setpolicy() it obviously targets a range of frequencies) or by the
definition of arch_set_freq_scale().

> ..of the CPU is and it doesn't have counters to guess it as well.
> 
> There can be other reasons which we aren't able to imagine at this
> point of time.
> 

But I understand both the points you and Rafael raised so it's obvious
that a 'opt in' flag would be the better option.

Thank you both,
Ionela.

> -- 
> viresh
