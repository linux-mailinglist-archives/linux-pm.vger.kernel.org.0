Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06B516997F
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2020 19:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgBWStT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Feb 2020 13:49:19 -0500
Received: from foss.arm.com ([217.140.110.172]:50664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWStT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Feb 2020 13:49:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0AA30E;
        Sun, 23 Feb 2020 10:49:17 -0800 (PST)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 377B73F703;
        Sun, 23 Feb 2020 10:49:17 -0800 (PST)
Date:   Sun, 23 Feb 2020 18:49:15 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, rjw@rjwysocki.net, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/7] arm64: use activity monitors for frequency
 invariance
Message-ID: <20200223184915.GA22925@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-7-ionela.voinescu@arm.com>
 <9eeda406-78a8-a910-f6ef-a367bf407a19@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eeda406-78a8-a910-f6ef-a367bf407a19@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Valentin,

Sorry for the delay in my reply and thank you very much for the review!

I will push v4 very soon with these changes.

On Monday 17 Feb 2020 at 16:59:24 (+0000), Valentin Schneider wrote:
> > +	 * Pre-compute the fixed ratio between the frequency of the constant
> > +	 * counter and the maximum frequency of the CPU.
> > +	 *
> > +	 *			      const_freq
> > +	 * arch_max_freq_scale =   ---------------- * SCHED_CAPACITY_SCALE²
> > +	 *			   cpuinfo_max_freq
> > +	 *
> > +	 * We use a factor of 2 * SCHED_CAPACITY_SHIFT -> SCHED_CAPACITY_SCALE²
> > +	 * in order to ensure a good resolution for arch_max_freq_scale for
> > +	 * very low arch timer frequencies (up to the KHz range which should be
>                                             ^^^^^
> <pedantic hat on>: s/up to/down to/

Done!

> > +	 * unlikely).
> > +	 */
> > +	ratio = (u64)arch_timer_get_rate() << (2 * SCHED_CAPACITY_SHIFT);
> > +	ratio = div64_u64(ratio, max_freq_hz);
> > +	if (!ratio) {
> > +		pr_err("System timer frequency too low.\n");
> 
> Should that be a WARN_ONCE() instead? If the arch timer freq is too low,
> we'll end up spamming this message, since we go through this for all CPUs.

Done!

> > +		return -EINVAL;
> > +	}
> > +
> > +	per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
> > +
> 
> It occurred to me that this isn't strictly speaking a per-CPU information as
> it only depends on the max possible frequency. Not really worth bothering
> about though, I think.
> 

Yes, it depends on the max possible frequency of all CPUs in a frequency
domain. But I wanted to put this factor in a per-cpu variable in order
to be able to retrieve it faster in topology_scale_freq_tick, rather
than having to consider policies and related CPUs in that function.

> > +	return 0;
> > +}
> > +
> > +static inline int
> > +enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
> > +{
> > +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > +
> > +	if (!policy) {
> > +		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
> > +		return false;
> > +	}
> > +
> > +	if (cpumask_subset(policy->related_cpus, valid_cpus)) {
> > +		cpumask_or(amu_fie_cpus, policy->related_cpus,
> > +			   amu_fie_cpus);
> > +		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> > +			cpumask_pr_args(amu_fie_cpus));
> 
> Could we have a single print of all CPUs in one go? AIUI this will generate a
> line per cpufreq policy. Maybe just something at the tail of init_amu_fie():
> 
> if (!cpumask_empty(amu_fie_cpus))
> 	pr_info(<blah>);
> 

Done. I've used this location as well to set the static key that you've
suggested below.

> > +	}
> > +
> > +	cpufreq_cpu_put(policy);
> > +
> > +	return true;
> > +}
> > +
> > +static int __init init_amu_fie(void)
> > +{
> > +	cpumask_var_t valid_cpus;
> > +	bool have_policy = false;
> > +	int cpu;
> > +
> > +	if (!zalloc_cpumask_var(&valid_cpus, GFP_KERNEL) ||
> > +	    !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
> > +		return -ENOMEM;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		if (validate_cpu_freq_invariance_counters(cpu))
> > +			continue;
> > +		cpumask_set_cpu(cpu, valid_cpus);
> > +		have_policy = enable_policy_freq_counters(cpu, valid_cpus) ||
> > +			      have_policy;
> 
> What about:
> 		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
> 

Done as well.

> > +	}
> > +
> > +	if (!have_policy) {
> > +		/*
> > +		 * If we are not restricted by cpufreq policies, we only enable
> > +		 * the use of the AMU feature for FIE if all CPUs support AMU.
> > +		 * Otherwise, enable_policy_freq_counters has already enabled
> > +		 * policy cpus.
> > +		 */
> > +		if (cpumask_equal(valid_cpus, cpu_possible_mask)) {
> 
> Mmm so I'm thinking what we want here is the cpu_present_mask rather than
> the possible one. This is very corner-casy, but I think that if we fail to
> boot a secondary, we'll have it possible but not present.
>

Yes, this is correct. It does depend on the stage it fails at: for
example if some feature checks fail, a CPU will not be marked in
cpu_present_mask (see cpu_die_early()), while the following will result
in possible == present.

---
[    0.056524] EFI services will not be available.
[    0.065690] smp: Bringing up secondary CPUs ...
[    0.098010] psci: failed to boot CPU1 (-22)
[    0.098037] CPU1: failed to boot: -22
[    0.130290] psci: failed to boot CPU2 (-22)
[    0.130315] CPU2: failed to boot: -22
[    0.162568] psci: failed to boot CPU3 (-22)
[    0.162594] CPU3: failed to boot: -22
[    0.194890] Detected PIPT I-cache on CPU4
[    0.194990] GICv3: CPU4: found redistributor 100 region
0:0x000000002f120000
[    0.195046] GICv3: CPU4: using allocated LPI pending table
@0x00000000fc0d0000
[    0.195133] CPU4: Booted secondary processor 0x0000000100
[0x410fd0f0]
[    0.227190] psci: failed to boot CPU5 (-22)
[    0.227412] CPU5: failed to boot: -22
[    0.259431] psci: failed to boot CPU6 (-22)
[    0.259522] CPU6: failed to boot: -22
[    0.291683] psci: failed to boot CPU7 (-22)
[    0.291709] CPU7: failed to boot: -22
[    0.291990] smp: Brought up 1 node, 2 CPUs  
[..]
root@buildroot:~# cat present
0-7
root@buildroot:~# cat possible
0-7

This failure happens while the CPU is being brought up (__cpu_up).
I'm not sure if this should result in set_cpu_present(cpu, 0) as well.
But it's unrelated to this..

In any case, your suggestion is valid and cpu_present_mask is better to
be used here.


> While at it you could make the loop only target present CPUs, but I think the
> one bit that matters is this check right here (!present should fail at
> validate_cpu_freq_invariance_counters()).
> 

Will change the loop as well. Thanks!

> > +			cpumask_or(amu_fie_cpus, amu_fie_cpus, valid_cpus);
> > +			pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> > +				cpumask_pr_args(amu_fie_cpus));
> > +		}
> > +	}
> > +
> > +	free_cpumask_var(valid_cpus);
> > +
> > +	return 0;
> > +}
> > +late_initcall_sync(init_amu_fie);
> > +
> > +bool topology_cpu_freq_counters(struct cpumask *cpus)
> > +{
> > +	return cpumask_available(amu_fie_cpus) &&
> > +	       cpumask_subset(cpus, amu_fie_cpus);
> > +}
> > +
> > +void topology_scale_freq_tick(void)
> > +{
> > +	u64 prev_core_cnt, prev_const_cnt;
> > +	u64 core_cnt, const_cnt, scale;
> > +	int cpu = smp_processor_id();
> > +
> > +	if (!cpumask_available(amu_fie_cpus) ||
> > +	    !cpumask_test_cpu(cpu, amu_fie_cpus))
> > +		return;
> 
> It might be a good idea to have a static key to gate our entry into this
> function - that way we can lessen our impact on older platforms (without AMUs)
> running a recent kernel with CONFIG_ARM64_AMU_EXTN=y.
> 
> x86 does just that, if you look at their arch_scale_freq_tick()
> implementation. FWIW I don't think we should bother with playing with the
> key counter to count AMU-enabled CPUs, just enable it at startup if we have
> > 1 such CPU and let the cpumask drive the rest.
> 
> In your check here, the static key check could replace the cpumask_available()
> check. The static key could also be used for topology_cpu_freq_counters().
>

Very good idea! Done as well. Yes, the counter (number of AMU enabled
CPUs) would not be of much help for the moment.

> > +
> > +	const_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
> > +	core_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
> > +	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
> > +	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
> > +
> > +	if (unlikely(core_cnt <= prev_core_cnt ||
> > +		     const_cnt <= prev_const_cnt))
> > +		goto store_and_exit;
> > +
> > +	/*
> > +	 *	    /\core    arch_max_freq_scale
> > +	 * scale =  ------- * --------------------
> > +	 *	    /\const   SCHED_CAPACITY_SCALE
> > +	 *
> > +	 * We shift by SCHED_CAPACITY_SHIFT (divide by SCHED_CAPACITY_SCALE)
> > +	 * in order to compensate for the SCHED_CAPACITY_SCALE² factor in
> > +	 * arch_max_freq_scale (used to ensure its resolution) while keeping
> > +	 * the scale value in the 0-SCHED_CAPACITY_SCALE capacity range.
> > +	 */
> 
> A simple "See validate_cpu_freq_invariance_counters() for details on the
> scale factor" would suffice wrt the shifting details.
>

Done!

Thank you,
Ionela.

> > +	scale = core_cnt - prev_core_cnt;
> > +	scale *= this_cpu_read(arch_max_freq_scale);
> > +	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
> > +			  const_cnt - prev_const_cnt);
> > +
> > +	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> > +	this_cpu_write(freq_scale, (unsigned long)scale);
> > +
> > +store_and_exit:
> > +	this_cpu_write(arch_core_cycles_prev, core_cnt);
> > +	this_cpu_write(arch_const_cycles_prev, const_cnt);
> > +}
> > +#endif /* CONFIG_ARM64_AMU_EXTN */
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 1eb81f113786..1ab2b7503d63 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -29,6 +29,14 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> >  	unsigned long scale;
> >  	int i;
> >  
> > +	/*
> > +	 * If the use of counters for FIE is enabled, just return as we don't
> > +	 * want to update the scale factor with information from CPUFREQ.
> > +	 * Instead the scale factor will be updated from arch_scale_freq_tick.
> > +	 */
> > +	if (arch_cpu_freq_counters(cpus))
> > +		return;
> > +
> >  	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
> >  
> >  	for_each_cpu(i, cpus)
> > diff --git a/include/linux/topology.h b/include/linux/topology.h
> > index eb2fe6edd73c..397aad6ae163 100644
> > --- a/include/linux/topology.h
> > +++ b/include/linux/topology.h
> > @@ -227,5 +227,12 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
> >  	return cpumask_of_node(cpu_to_node(cpu));
> >  }
> >  
> > +#ifndef arch_cpu_freq_counters
> > +static __always_inline
> > +bool arch_cpu_freq_counters(struct cpumask *cpus)
> > +{
> > +	return false;
> > +}
> > +#endif
> >  
> >  #endif /* _LINUX_TOPOLOGY_H */
> > 
