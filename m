Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5403010ED3E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 17:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfLBQe6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 11:34:58 -0500
Received: from foss.arm.com ([217.140.110.172]:56198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbfLBQe6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Dec 2019 11:34:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2DB331B;
        Mon,  2 Dec 2019 08:34:57 -0800 (PST)
Received: from localhost (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 442633F52E;
        Mon,  2 Dec 2019 08:34:57 -0800 (PST)
Date:   Mon, 2 Dec 2019 16:34:55 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Message-ID: <20191202162232.GA9777@arm.com>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
 <20191113124654.18122-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113124654.18122-2-ggherdovich@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Giovanni,

On Wednesday 13 Nov 2019 at 13:46:49 (+0100), Giovanni Gherdovich wrote:
[...]
> ---
>  arch/x86/include/asm/topology.h |  23 ++++++
>  arch/x86/kernel/smpboot.c       | 176 +++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/core.c             |   1 +
>  kernel/sched/sched.h            |   7 ++
>  4 files changed, 206 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 4b14d2318251..9b3aca463c8f 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -193,4 +193,27 @@ static inline void sched_clear_itmt_support(void)
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

I see further down in the code that you gate the setting of
arch_cpu_freq by arch_scale_freq_invariant() as well, so it might be
cleaner to remove the condition here and just return the value of the
per_cpu variable. That variable should also have an initial value of
SCHED_FREQ_CAPACITY_SCALE (1024) and if it happens that frequency
invariance is not enabled, then 1024 will always be returned as no code
would have set it to anything else.

Also, arm64 names this cpu variable freq_scale instead of arch_cpu_freq.
It would be nice to have the same name here, to easily understand
similarities in this functionality on both sides.

If arch_cpu_freq seems more complete, you might want to rename it to
arch_cpu_freq_scale, although longer, to clearly state that this is a
scale value and not an absolute frequency value.

> +	return 1024 /* SCHED_CAPACITY_SCALE */;
> +}
> +#define arch_scale_freq_capacity arch_scale_freq_capacity
> +
> +extern void arch_scale_freq_tick(void);
> +#define arch_scale_freq_tick arch_scale_freq_tick
> +
> +#endif
> +
>  #endif /* _ASM_X86_TOPOLOGY_H */
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 69881b2d446c..814d7900779d 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
[...]
> +
> +DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
> +
> +static DEFINE_PER_CPU(u64, arch_prev_aperf);
> +static DEFINE_PER_CPU(u64, arch_prev_mperf);
> +static u64 arch_max_freq = SCHED_CAPACITY_SCALE;
> +

Same here: the scale suffix would make the math below clearer.

[...]
> +static void intel_set_cpu_max_freq(void)
> +{
> +	/*
> +	 * TODO: add support for:
> +	 *
> +	 * - Xeon Gold/Platinum
> +	 * - Xeon Phi (KNM, KNL)
> +	 * - Atom Goldmont
> +	 * - Atom Silvermont
> +	 *
> +	 * which all now get by default arch_max_freq = SCHED_CAPACITY_SCALE
> +	 */
> +
> +	static_branch_enable(&arch_scale_freq_key);
> +
> +	if (turbo_disabled() ||
> +		x86_match_cpu(has_skx_turbo_ratio_limits) ||
> +		x86_match_cpu(has_knl_turbo_ratio_limits) ||
> +		x86_match_cpu(has_glm_turbo_ratio_limits))
> +		return;
> +
> +	core_set_cpu_max_freq();
> +}
> +
> +static void init_scale_freq(void *arg)

This function does not initialise the frequency scale factor so the name
is confusing to me. How about init_counters_refs or init_fie_counters_refs
(fie = frequency invariance engine)?

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

Similarly for the name of this function: it seems to both set the max
frequency ratio and initialise the references to the aperf and mperf
counters. Also, in the process it enables frequency invariance.
So this function seems to do all the preparation work for frequency
invariance so a more generic name (init_fie/init_frequency_invariance)
would work better in my opinion.

> +{
> +	if (smp_processor_id() != 0 || !boot_cpu_has(X86_FEATURE_APERFMPERF))
> +		return;
> +
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		intel_set_cpu_max_freq();

I see above that you enable the static key (and therefore frequency
invariance before setting the max frequency ratio (if possible) and
before you initialise the counter references. Is there any reason for
doing this?

In my mind the more clear process is:
 - Obtain and set max frequency ratio
 - Initialise counter references
 - If all above goes well enable the static key (and frequency
   invariance)

Thanks,
Ionela.

