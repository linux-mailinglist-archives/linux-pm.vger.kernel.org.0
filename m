Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666B531D885
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 12:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhBQLiF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 06:38:05 -0500
Received: from foss.arm.com ([217.140.110.172]:56714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhBQLbG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Feb 2021 06:31:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7203931B;
        Wed, 17 Feb 2021 03:30:13 -0800 (PST)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 043473F73B;
        Wed, 17 Feb 2021 03:30:12 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:30:11 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210217113011.GA22176@arm.com>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
 <20210217002422.GA17422@arm.com>
 <20210217042558.o4anjdkayzgqny55@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217042558.o4anjdkayzgqny55@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Replying this first as it's going to be relevant below:

> Just out of curiosity, what exactly did you test and what was the setup ? :)

I tested it on:

 - Juno R0 (CPUs [0, 3-5] are littles, CPUs [1-2] are bigs)
   + PMUs faking AMUs
   + userspace/schedutil +
   + cpufreq-FIE/!cpufreq-FIE
   + DT

This testing did not yet cover patch 2/2.

My checklist shows:
 - system invariance status correct - passed
 - scale factor correct (userspace cpufreq governor) - passed
 - arch_set_freq_scale bypassed - passed
 - partial "AMUs" support - failed (see below)
 - EAS enabling - passed

I don't have an automated process for this as many test cases involve
kernel source changes. In time I will automate all of these and
possibly cover all scenarios with FVP (fast models) testing, but for
now human error is possible :).

On Wednesday 17 Feb 2021 at 09:55:58 (+0530), Viresh Kumar wrote:
> On 17-02-21, 00:24, Ionela Voinescu wrote:
> > I think it could be merged in patch 1/2 as it's part of enabling the use
> > of multiple sources of information for FIE. Up to you!
> 
> Sure.
> 
> > >  static void amu_fie_setup(const struct cpumask *cpus)
> > >  {
> > > -	bool invariant;
> > >  	int cpu;
> > >  
> > >  	/* We are already set since the last insmod of cpufreq driver */
> > > @@ -257,25 +256,10 @@ static void amu_fie_setup(const struct cpumask *cpus)
> > >  
> > >  	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
> > >  
> > > -	invariant = topology_scale_freq_invariant();
> > > -
> > > -	/* We aren't fully invariant yet */
> > > -	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
> > > -		return;
> > > -
> > 
> > You still need these checks, otherwise you could end up with only part
> > of the CPUs setting a scale factor, when only part of the CPUs support
> > AMUs and there is no cpufreq support for FIE.
> 
> Both supports_scale_freq_counters() and topology_scale_freq_invariant() take
> care of this now and they will keep reporting the system as invariant until the
> time all the CPUs have counters (in absence of cpufreq).
> 

Correct!

> The topology_set_scale_freq_source() API is supposed to be called multiple
> times, probably once for each policy and so I don't see a need of these checks
> anymore.
> 

The problem is not topology_scale_freq_invariant() but whether a scale
factor is set for some CPUs.

Scenario (test system above):
 - "AMUs" are only supported for [1-2],
 - cpufreq_supports_freq_invariance() -> false

What should happen:
 - topology_scale_freq_invariant() -> false (passed)
 - all CPUs should have their freq_scale unmodified (1024) - (failed)
   because only 2 out of 6 CPUs have a method of setting a scale factor

What does happen:
 - arch_set_freq_tick() -> topology_set_freq_tick() will set a scale
   factor for [1-2] based on AMUs. This should not happen. We will end
   up with invariant signals for bigs and signals that are not freq
   invariant for littles.

Ionela.

> > Small(ish) optimisation at the beginning of this function:
> > 
> >     if (cpumask_empty(&scale_freq_counters_mask))
> >         scale_freq_invariant = topology_scale_freq_invariant();
> > 
> > This will save you a call to rebuild_sched_domains_energy(), which is
> > quite expensive, when cpufreq supports FIE and we also have counters.
> 
> Good Point.
>  
> > After comments addressed,
> > 
> > Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> 
> Thanks.
> 
> > Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> 
> 

> -- 
> viresh
