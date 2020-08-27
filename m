Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2593D2548D2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgH0POT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 11:14:19 -0400
Received: from foss.arm.com ([217.140.110.172]:57246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgH0LjV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Aug 2020 07:39:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6082212FC;
        Thu, 27 Aug 2020 04:27:42 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 015683F68F;
        Thu, 27 Aug 2020 04:27:41 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:27:40 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [RFC 0/3] cpufreq: cppc: Add support for frequency invariance
Message-ID: <20200827112740.GA9923@arm.com>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
 <20200709124349.GA15342@arm.com>
 <20200710030032.3yq3lqqybhy5m744@vireshk-i7>
 <CAKfTPtBpOdRSV0gb2CoC8J9GnuPiqZ+MbQLLc6NdSmjJhb0cgA@mail.gmail.com>
 <20200825095629.GA15469@arm.com>
 <20200827075149.ixunmyi3m6ygtehu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827075149.ixunmyi3m6ygtehu@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Thursday 27 Aug 2020 at 13:21:49 (+0530), Viresh Kumar wrote:
> On 25-08-20, 10:56, Ionela Voinescu wrote:
> > I've been putting some more thought/code into this one and I believe
> > something as follows might look nicer as well as cover a few corner cases
> > (ignore implementation details for now, they can be changed):
> 
> I saw the other patchset you sent where AMU can be used as the backend
> for CPPC driver, which means that if AMU IP is present on the platform
> it will be used by the CPPC to get the perf counts, right ?
> 
> > - Have a per cpu value that marks the use of either AMUs, CPPC, or
> >   cpufreq for freq invariance (can be done with per-cpu variable or with
> >   cpumasks)
> > 
> > - arch_topology.c: initialization code as follows:
> > 
> > 	for_each_present_cpu(cpu) {
> > 		if (freq_inv_amus_valid(cpu) &&
> > 		    !freq_inv_set_max_ratio(cpufreq_get_hw_max_freq(cpu) * 1000,
> > 					    arch_timer_get_rate(), cpu)) {
> > 			per_cpu(inv_source, cpu) = INV_AMU_COUNTERS;
> > 			continue;
> > 		}
> > 		if (freq_inv_cppc_counters_valid(cpu) &&
> > 		    !freq_inv_set_max_ratio(cppc_max_perf, cppc_ref_perf, cpu)) {
> > 			per_cpu(inv_source, cpu) = INV_CPPC_COUNTERS;
> > 			continue;
> > 		}
> > 		if (!cpufreq_supports_freq_invariance() ||
> > 		    freq_inv_set_max_ratio(cpufreq_get_hw_max_freq(cpu),
> > 					   1, cpu)) {
> > 			pr_info("FIE disabled: no valid source for CPU%d.", cpu);
> > 			return 0;
> > 		}
> > 	}
> 
> Based on that (your other patchset), I think this can get further
> simplified to whomsoever can register first for freq invariance.
> 

I don't see it as anyone registering for freq invariance, rather the
freq invariance framework chooses its source of information (AMU, CPPC,
cpufreq).

> i.e. if CPPC registers for it first then there is no need to check
> AMUs further (as CPPC will be using AMUs anyway), else we will
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Not necessarily. Even if AMUs are present, they are only used for CPPC's
delivered and reference performance counters if the ACPI _CPC entry
specifies FFH as method:

  ResourceTemplate(){Register(FFixedHW, 0x40, 0, 1, 0x4)},
  ResourceTemplate(){Register(FFixedHW, 0x40, 0, 0, 0x4)},

> fallback to AMU, else cpufreq.
> 
> Is that understanding correct ?

While I understand your point (accessing AMUs through CPPC's read
functions to implement invariance) I don't think it's worth tying the
two together.

I see the two functionalities as independent:
 - frequency invariance with whichever source of information is valid
   (AMUs, cpufreq, etc) is separate from
 - CPPC's delivered and reference performance counters, which currently
   are used in cpufreq's .get() function.

Therefore, taking each of the scenarios one by one:
 - All CPUs support AMUs: the freq invariance initialisation code will
   find AMUs valid and it will use them to set the scale factor;
   completely independently, if the FFH method is specified for CPPC's
   delivered and reference performance counters, it will also use
   AMUs, even if, let's say, invariance is disabled.

 - None of the CPUs support AMUs, but the _CPC entry specifies some
   platform specific counters for delivered and reference performance.
   With the current mainline code neither cpufreq or counter based
   invariance is supported, but the CPPC counters can be used in the
   cppc_cpufreq driver for the .get() function.

   But with the above new functionality we can detect that AMUs are not
   supported and expose the CPPC counters to replace them in
   implementing invariance.

 - Mixed scenarios are also supported if we play our cards right and
   implement the above per-cpu.


I'm thinking that having some well defined invariance sources might work
well: it will simplify the init function (go through all registered
sources and choose (per-cpu) the one that's valid) and allow for
otherwise generic invariance support. Something like:

enum freq_inv_source {INV_CPUFREQ, INV_AMU_COUNTERS, INV_CPPC_COUNTERS};

struct freq_inv_source {
	enum freq_inv_source source;
	bool (*valid)(int cpu);
	u64 (*read_corecnt)(int cpu);
	u64 (*read_constcnt)(int cpu);
	u64 (*max_rate)(int cpu);
	u64 (*ref_rate)(int cpu);
}

I am in the middle of unifying AMU counter and cpufreq invariance through
something like this, so if you like the idea and you don't think I'm
stepping too much on your toes with this, I can consider the usecase in
my (what should be) generic support. So in the end this might end up
being just a matter of adding a new invariance source (CPPC counters).

My only worry is that while I know how a cpufreq source behaves and how
AMU counters behave, I'm not entirely sure what to expect from CPPC
counters: if they are always appropriate for updates on the tick (not
blocking), if they both stop during idle, if there is save/restore
functionality before/after idle, etc.

What do you think?

Regards,
Ionela.

> -- 
> viresh
