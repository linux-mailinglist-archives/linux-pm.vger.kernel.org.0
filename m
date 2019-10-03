Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C997C9C40
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfJCK16 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 06:27:58 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56605 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfJCK16 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2019 06:27:58 -0400
Received: from 79.184.253.225.ipv4.supernova.orange.pl (79.184.253.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 5f3d4d156279d6fa; Thu, 3 Oct 2019 12:27:53 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v2 1/2] x86,sched: Add support for frequency invariance
Date:   Thu, 03 Oct 2019 12:27:52 +0200
Message-ID: <1906426.HDqaVa71mF@kreacher>
In-Reply-To: <20191002122926.385-2-ggherdovich@suse.cz>
References: <20191002122926.385-1-ggherdovich@suse.cz> <20191002122926.385-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 2, 2019 2:29:25 PM CEST Giovanni Gherdovich wrote:
> Implement arch_scale_freq_capacity() for 'modern' x86. This function
> is used by the scheduler to correctly account usage in the face of
> DVFS.
> 

[cut]

> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Acked-by: Doug Smythies <dsmythies@telus.net>
> ---
>  arch/x86/include/asm/topology.h |  33 +++++++
>  arch/x86/kernel/smpboot.c       | 195 +++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/core.c             |   1 +
>  kernel/sched/sched.h            |   7 ++
>  4 files changed, 235 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 4b14d2318251..260410306879 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -193,4 +193,37 @@ static inline void sched_clear_itmt_support(void)
>  }
>  #endif /* CONFIG_SCHED_MC_PRIO */
>  
> +#ifdef CONFIG_SMP
> +#include <asm/cpufeature.h>
> +
> +DECLARE_STATIC_KEY_FALSE(arch_scale_freq_key);
> +
> +#define arch_scale_freq_invariant() static_branch_likely(&arch_scale_freq_key)
> +
> +DECLARE_PER_CPU(unsigned long, arch_cpu_freq);
> +
> +static inline long arch_scale_freq_capacity(int cpu)
> +{
> +	if (arch_scale_freq_invariant())
> +		return per_cpu(arch_cpu_freq, cpu);
> +
> +	return 1024 /* SCHED_CAPACITY_SCALE */;
> +}
> +#define arch_scale_freq_capacity arch_scale_freq_capacity
> +
> +extern void arch_scale_freq_tick(void);
> +#define arch_scale_freq_tick arch_scale_freq_tick
> +
> +extern void x86_arch_scale_freq_tick_enable(void);
> +extern void x86_arch_scale_freq_tick_disable(void);
> +#else
> +static inline void x86_arch_scale_freq_tick_enable(void)
> +{
> +}
> +
> +static inline void x86_arch_scale_freq_tick_disable(void)
> +{
> +}
> +#endif
> +
>  #endif /* _ASM_X86_TOPOLOGY_H */
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 69881b2d446c..7aa72a51e1e9 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -147,6 +147,8 @@ static inline void smpboot_restore_warm_reset_vector(void)
>  	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
>  }
>  
> +static void set_cpu_max_freq(void);
> +
>  /*
>   * Report back to the Boot Processor during boot time or to the caller processor
>   * during CPU online.
> @@ -183,6 +185,8 @@ static void smp_callin(void)
>  	 */
>  	set_cpu_sibling_map(raw_smp_processor_id());
>  
> +	set_cpu_max_freq();
> +
>  	/*
>  	 * Get our bogomips.
>  	 * Update loops_per_jiffy in cpu_data. Previous call to
> @@ -1337,7 +1341,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
>  	set_sched_topology(x86_topology);
>  
>  	set_cpu_sibling_map(0);
> -
> +	set_cpu_max_freq();
>  	smp_sanity_check();
>  
>  	switch (apic_intr_mode) {
> @@ -1764,3 +1768,192 @@ void native_play_dead(void)
>  }
>  
>  #endif
> +
> +/*
> + * APERF/MPERF frequency ratio computation.
> + *
> + * The scheduler wants to do frequency invariant accounting and needs a <1
> + * ratio to account for the 'current' frequency, corresponding to
> + * freq_curr / freq_max.
> + *
> + * Since the frequency freq_curr on x86 is controlled by micro-controller and
> + * our P-state setting is little more than a request/hint, we need to observe
> + * the effective frequency 'BusyMHz', i.e. the average frequency over a time
> + * interval after discarding idle time. This is given by:
> + *
> + *   BusyMHz = delta_APERF / delta_MPERF * freq_base
> + *
> + * where freq_base is the max non-turbo P-state.
> + *
> + * The freq_max term has to be set to a somewhat arbitrary value, because we
> + * can't know which turbo states will be available at a given point in time:
> + * it all depends on the thermal headroom of the entire package. We set it to
> + * the turbo level with 4 cores active.
> + *
> + * Benchmarks show that's a good compromise between the 1C turbo ratio
> + * (freq_curr/freq_max would rarely reach 1) and something close to freq_base,
> + * which would ignore the entire turbo range (a conspicuous part, making
> + * freq_curr/freq_max always maxed out).
> + *
> + * Setting freq_max to anything less than the 1C turbo ratio makes the ratio
> + * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
> + */
> +
> +DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
> +
> +static DEFINE_PER_CPU(u64, arch_prev_aperf);
> +static DEFINE_PER_CPU(u64, arch_prev_mperf);
> +static u64 arch_max_freq = SCHED_CAPACITY_SCALE;
> +
> +static bool turbo_disabled(void)
> +{
> +	u64 misc_en;
> +	int err;
> +
> +	err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
> +	if (err)
> +		return false;
> +
> +	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> +}

This setting may be updated by the platform firmware (BIOS) in some cases
(see kernel.org BZ 200759, for example), so in general checking it once
at the init time is not enough.

> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +
> +#define ICPU(model) \
> +	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF, 0}
> +
> +static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
> +	ICPU(INTEL_FAM6_XEON_PHI_KNL),
> +	ICPU(INTEL_FAM6_XEON_PHI_KNM),
> +	{}
> +};
> +
> +static const struct x86_cpu_id has_turbo_ratio_group_limits[] = {
> +	ICPU(INTEL_FAM6_ATOM_GOLDMONT),
> +	ICPU(INTEL_FAM6_ATOM_GOLDMONT_D),
> +	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS),
> +	ICPU(INTEL_FAM6_SKYLAKE_X),
> +	{}
> +};
> +
> +static void core_set_cpu_max_freq(void)
> +{
> +	u64 ratio, turbo_ratio;
> +	int err;
> +
> +	if (smp_processor_id() != 0)
> +		return;
> +
> +	if (turbo_disabled() ||
> +		x86_match_cpu(has_knl_turbo_ratio_limits) ||
> +		x86_match_cpu(has_turbo_ratio_group_limits))
> +		return;
> +

I would move the checks above directly to intel_set_cpu_max_freq().

> +	err = rdmsrl_safe(MSR_PLATFORM_INFO, &ratio);
> +	if (err)
> +		return;
> +
> +	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &turbo_ratio);
> +	if (err)
> +		return;
> +
> +	ratio = (ratio >> 8) & 0xFF;                /* max P state ratio */
> +	turbo_ratio = (turbo_ratio >> 24) & 0xFF;   /* 4C turbo ratio */
> +
> +	arch_max_freq = div_u64(turbo_ratio * SCHED_CAPACITY_SCALE, ratio);
> +
> +	static_branch_enable(&arch_scale_freq_key);
> +}
> +
> +static void intel_set_cpu_max_freq(void)
> +{
> +	/*
> +	 * TODO: add support for:
> +	 *
> +	 * - Xeon Phi (KNM, KNL)
> +	 * - Xeon Gold/Platinum, Atom Goldmont/Goldmont Plus
> +	 * - Atom Silvermont
> +	 *
> +	 * which all now get by default arch_max_freq = SCHED_CAPACITY_SCALE
> +	 */
> +	core_set_cpu_max_freq();
> +}
> +
> +static void init_scale_freq(void *arg)
> +{
> +	u64 aperf, mperf;
> +
> +	rdmsrl(MSR_IA32_APERF, aperf);
> +	rdmsrl(MSR_IA32_MPERF, mperf);
> +
> +	this_cpu_write(arch_prev_aperf, aperf);
> +	this_cpu_write(arch_prev_mperf, mperf);
> +}
> +
> +static void set_cpu_max_freq(void)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> +		return;
> +
> +	switch (boot_cpu_data.x86_vendor) {
> +	case X86_VENDOR_INTEL:
> +		intel_set_cpu_max_freq();
> +		break;
> +	default:
> +		break;
> +	}

Why is the switch () needed?

It seems that

	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
		intel_set_cpu_max_freq();

would do the trick.

> +
> +	init_scale_freq(NULL);
> +}
> +
> +DEFINE_PER_CPU(unsigned long, arch_cpu_freq);
> +
> +static bool tick_disable;
> +
> +void arch_scale_freq_tick(void)
> +{
> +	u64 freq;
> +	u64 aperf, mperf;
> +	u64 acnt, mcnt;
> +
> +	if (!arch_scale_freq_invariant() || tick_disable)
> +		return;
> +

This may be a silly question, but can using tick_disable be avoided?

I guess it is there, because disabling the static branch from
x86_arch_scale_freq_tick_disable() would be unsafe, but I'm not
sure why that would be the case?

> +	rdmsrl(MSR_IA32_APERF, aperf);
> +	rdmsrl(MSR_IA32_MPERF, mperf);
> +
> +	acnt = aperf - this_cpu_read(arch_prev_aperf);
> +	mcnt = mperf - this_cpu_read(arch_prev_mperf);
> +	if (!mcnt)
> +		return;
> +
> +	this_cpu_write(arch_prev_aperf, aperf);
> +	this_cpu_write(arch_prev_mperf, mperf);
> +
> +	acnt <<= 2*SCHED_CAPACITY_SHIFT;
> +	mcnt *= arch_max_freq;
> +
> +	freq = div64_u64(acnt, mcnt);
> +
> +	if (freq > SCHED_CAPACITY_SCALE)
> +		freq = SCHED_CAPACITY_SCALE;
> +
> +	this_cpu_write(arch_cpu_freq, freq);
> +}
> +
> +void x86_arch_scale_freq_tick_enable(void)
> +{
> +	tick_disable = false;
> +}
> +
> +static void reset_scale_freq(void *arg)
> +{
> +	this_cpu_write(arch_cpu_freq, SCHED_CAPACITY_SCALE);
> +}
> +
> +void x86_arch_scale_freq_tick_disable(void)
> +{
> +	on_each_cpu(reset_scale_freq, NULL, 1);
> +	tick_disable = true;
> +}
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7880f4f64d0e..2bdce4a140ae 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3593,6 +3593,7 @@ void scheduler_tick(void)
>  	struct task_struct *curr = rq->curr;
>  	struct rq_flags rf;
>  
> +	arch_scale_freq_tick();
>  	sched_clock_tick();
>  
>  	rq_lock(rq, &rf);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 0db2c1b3361e..0fe4f2dcd175 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1953,6 +1953,13 @@ static inline int hrtick_enabled(struct rq *rq)
>  
>  #endif /* CONFIG_SCHED_HRTICK */
>  
> +#ifndef arch_scale_freq_tick
> +static __always_inline
> +void arch_scale_freq_tick(void)
> +{
> +}
> +#endif
> +
>  #ifndef arch_scale_freq_capacity
>  static __always_inline
>  unsigned long arch_scale_freq_capacity(int cpu)
> 




