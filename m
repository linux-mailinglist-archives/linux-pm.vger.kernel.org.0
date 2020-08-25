Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF03F2515CA
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgHYJ4e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 05:56:34 -0400
Received: from foss.arm.com ([217.140.110.172]:55038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgHYJ4c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 05:56:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B095530E;
        Tue, 25 Aug 2020 02:56:31 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51D3B3F66B;
        Tue, 25 Aug 2020 02:56:31 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:56:29 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
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
Message-ID: <20200825095629.GA15469@arm.com>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
 <20200709124349.GA15342@arm.com>
 <20200710030032.3yq3lqqybhy5m744@vireshk-i7>
 <CAKfTPtBpOdRSV0gb2CoC8J9GnuPiqZ+MbQLLc6NdSmjJhb0cgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBpOdRSV0gb2CoC8J9GnuPiqZ+MbQLLc6NdSmjJhb0cgA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

On Friday 24 Jul 2020 at 11:38:59 (+0200), Vincent Guittot wrote:
> On Fri, 10 Jul 2020 at 05:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Thanks for the quick reply Ionela.
> >
> > On 09-07-20, 13:43, Ionela Voinescu wrote:
> > > I'll put all my comments here for now, as they refer more to the design
> > > of the solution.
> > >
> > > I hope it won't be too repetitive compared to what we previously discussed
> > > offline.
> >
> > > I understand you want to get additional points of view.
> >
> > Not necessarily, I knew you would be one of the major reviewers here
> > :)
> >
> > I posted so you don't need to review in private anymore and then the
> > code is somewhat updated since the previous time.
> >
> > > On Thursday 09 Jul 2020 at 15:43:32 (+0530), Viresh Kumar wrote:
> > > I believe the code is unnecessarily invasive for the functionality it
> > > tries to introduce and it does break existing functionality.
> > >
> > >
> > >  - (1) From code readability and design point of view, this switching
> > >        between an architectural method and a driver method complicates
> > >        an already complicated situation. We already have code that
> > >        chooses between a cpufreq-based method and a counter based method
> > >        for frequency invariance. This would basically introduce a choice
> > >        between a cpufreq-based method through arch_set_freq_scale(), an
> > >        architectural counter-based method through arch_set_freq_tick(),
> > >        and another cpufreq-based method that piggy-backs on the
> > >        architectural arch_set_freq_tick().
> >
> > I agree.
> >
> > >        As discussed offline, before I even try to begin accepting the
> > >        possibility of this complicated mix, I would like to know why
> > >        methods of obtaining the same thing by using the cpufreq
> > >        arch_set_freq_scale()
> >
> > The problem is same as that was in case of x86, we don't know the real
> > frequency the CPU may be running at and we need something that fires
> > up periodically in a guaranteed way to capture the freq-scale.
> 
> Yeah it's exactly the same behavior as x86 and re using the same
> mechanism seems the  best solution
> 
> The main problem is that AMU currently assumes that it will be the
> only to support such tick based mechanism whereas others like cppc can
> provides similar information
> 

Yes, I agree that a similar method to the use of AMUs or APERF/MPERF would
result in a more accurate frequency scale factor.

> >
> > Though I am thinking now if we can trust the target_index() helper and
> > keep updating the freq-scale based on the delta between last call to
> > it and the latest call. I am not sure if it will be sufficient.
> >
> > >        or even the more invasive wrapping of the
> > >        counter read functions is not working.
> >
> > I am not sure I understood this one.
> >

I've been putting some more thought/code into this one and I believe
something as follows might look nicer as well as cover a few corner cases
(ignore implementation details for now, they can be changed):

- Have a per cpu value that marks the use of either AMUs, CPPC, or
  cpufreq for freq invariance (can be done with per-cpu variable or with
  cpumasks)

- arch_topology.c: initialization code as follows:

	for_each_present_cpu(cpu) {
		if (freq_inv_amus_valid(cpu) &&
		    !freq_inv_set_max_ratio(cpufreq_get_hw_max_freq(cpu) * 1000,
					    arch_timer_get_rate(), cpu)) {
			per_cpu(inv_source, cpu) = INV_AMU_COUNTERS;
			continue;
		}
		if (freq_inv_cppc_counters_valid(cpu) &&
		    !freq_inv_set_max_ratio(cppc_max_perf, cppc_ref_perf, cpu)) {
			per_cpu(inv_source, cpu) = INV_CPPC_COUNTERS;
			continue;
		}
		if (!cpufreq_supports_freq_invariance() ||
		    freq_inv_set_max_ratio(cpufreq_get_hw_max_freq(cpu),
					   1, cpu)) {
			pr_info("FIE disabled: no valid source for CPU%d.", cpu);
			return 0;
		}
	}
  This would live in an equivalent of the init function we have now for
  AMU counters only (init_amu_fie), made to handle more sources and moved
  to arch_topology.c.
  The freq_inv_set_max_ratio() would be a generic version of what is now
  validate_cpu_freq_invariance_counters() (only the ratio computation and
  setting).

 - Finally, 
	void freq_inv_update_counter_refs(void)
	{
		this_cpu_write(arch_core_cycles_prev, read_corecnt());
		this_cpu_write(arch_const_cycles_prev, read_constcnt());
	}
  This would be an equivalent of init_cpu_freq_invariance_counters().
  There is the option of either read_{corecnt/constcnt}() to either do AMU
  reads or CPPC counter reads depending on inv_source, or for either arm64
  or cppc code to define the entire freq_inv_update_counter_refs().

 - Given all of the above, topology_scale_freq_tick() can then be made generic

	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
	freq_inv_update_counter_refs();
	const_cnt = this_cpu_read(arch_const_cycles_prev);
	core_cnt = this_cpu_read(arch_core_cycles_prev);

I have some versions of code that do this generalisation for AMUs and cpufreq
with a common topology_set_freq_scale() that is to be used for both
arch_set_freq_scale() and arch_set_freq_tick(). But it's written with this
usecase in mind so it can be extended to use CPPC counters as source as well,
as detailed above.

So, this is basically what I had in mind when recommending "wrapping of the
counter read functions" :). This would basically reuse much of what is now
the AMU invariance code while allowing for CPPC counters as a possible source.

I'll stop here for now to see what you guys think about this.

Thanks,
Ionela.

> > >  - (2) For 1/3, the presence of AMU counters does not guarantee their
> > >        usability for frequency invariance. I know you wanted to avoid
> > >        the complications of AMUs being marked as supporting invariance
> > >        after the cpufreq driver init function, but this breaks the
> > >        scenario in which the maximum frequency is invalid.
> >
> > Is that really a scenario ? i.e. Invalid maximum frequency ? Why would
> > that ever happen ?
> >
> > And I am not sure if this breaks anything which already exists,
> > because all we are doing in this case now is not registering cppc for
> > FI, which should be fine.
> 
> IIUC, AMU must wait for cpufreq drivers to be registered in order to
> get the maximum freq and being able to enable its FIE support.
> Could we have a sequence like:
> cppc register its scale_freq_tick function
> AMU can then override the tick function for cpu which supports AMU
> 
> >
> > >  - (3) For 2/3, currently we support platforms that have partial support
> > >        for AMUs, while this would not be supported here. The suggestions
> > >        at (1) would give us this for free.
> >
> > As both were counter based mechanisms, I thought it would be better
> > and more consistent if only one of them is picked. Though partial
> > support of AMUs would still work without the CPPC driver.
> >
> > --
> > viresh
