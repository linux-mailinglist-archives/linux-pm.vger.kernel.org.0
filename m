Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556DFC8841
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfJBMW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 08:22:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:55570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfJBMW0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 08:22:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72B1CACC3;
        Wed,  2 Oct 2019 12:22:23 +0000 (UTC)
Message-ID: <1570019274.22393.2.camel@suse.cz>
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <qperret@qperret.net>,
        srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Date:   Wed, 02 Oct 2019 14:27:54 +0200
In-Reply-To: <20190924160022.GB2386@hirez.programming.kicks-ass.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
         <20190909024216.5942-2-ggherdovich@suse.cz>
         <20190914105708.GA12877@qperret.net> <1568730466.3329.4.camel@suse.cz>
         <20190924140332.GL2369@hirez.programming.kicks-ass.net>
         <20190924160022.GB2386@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-09-24 at 18:00 +0200, Peter Zijlstra wrote:
> On Tue, Sep 24, 2019 at 04:03:32PM +0200, Peter Zijlstra wrote:
> 
> > > I'll check what's the cost of static_cpu_has() and if it's non-negligible I'll
> > > do what you suggest (x86-specific version of arch_scale_freq_invariant().
> > 
> > static_cpu_has() is an alternative and ends up being a static branch
> > (similar to static_key) once the alternative patching runs.
> 
> That said; I think you want a static key anyway, because if we can't
> tell the max_freq we don't want to use the invariant stuff.
> 
> Something a little like so on top perhaps.
> 
> Also, the below fixes that silly tick_disable stuff.

Thanks for this patch, I'll add this change in v2.

Can you elaborate on what you don't like in the tick_disable mechanism?

After reading your comments I realized there is a problem, but I'm not sure is
the same you're addressing.

More on this below, under your edit of the function
x86_arch_scale_freq_tick_disable().

> 
> ---
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -196,20 +196,24 @@ static inline void sched_clear_itmt_supp
>  #ifdef CONFIG_SMP
>  #include <asm/cpufeature.h>
>  
> -#define arch_scale_freq_tick arch_scale_freq_tick
> -#define arch_scale_freq_capacity arch_scale_freq_capacity
> +DECLARE_STATIC_KEY_FALSE(arch_scale_freq_key);
> +
> +#define arch_scale_freq_invariant() static_branch_likely(&arch_scale_freq_key)

This confused me for a second but then I realized that this #define comes
before the one in kernel/sched/sched.h where arch_scale_freq_invariant() is
defined again but guarded against previous definitions, so it all falls into
place; code from schedutil will see this one.

>  
>  DECLARE_PER_CPU(unsigned long, arch_cpu_freq);
>  
>  static inline long arch_scale_freq_capacity(int cpu)
>  {
> -	if (static_cpu_has(X86_FEATURE_APERFMPERF))
> +	if (arch_scale_freq_invariant())
>  		return per_cpu(arch_cpu_freq, cpu);
>  
>  	return 1024 /* SCHED_CAPACITY_SCALE */;
>  }
> +#define arch_scale_freq_capacity arch_scale_freq_capacity
>  
>  extern void arch_scale_freq_tick(void);
> +#define arch_scale_freq_tick arch_scale_freq_tick
> +
>  extern void x86_arch_scale_freq_tick_enable(void);
>  extern void x86_arch_scale_freq_tick_disable(void);
>  #else
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1799,6 +1799,8 @@ void native_play_dead(void)
>   * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
>   */
>  
> +DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
> +
>  static DEFINE_PER_CPU(u64, arch_prev_aperf);
>  static DEFINE_PER_CPU(u64, arch_prev_mperf);
>  static u64 arch_max_freq = SCHED_CAPACITY_SCALE;
> @@ -1860,6 +1862,8 @@ static void core_set_cpu_max_freq(void)
>  	turbo_ratio = (turbo_ratio >> 24) & 0xFF;   /* 4C turbo ratio */
>  
>  	arch_max_freq = div_u64(turbo_ratio * SCHED_CAPACITY_SCALE, ratio);
> +
> +	static_key_enable(&arch_scale_freq_key);
>  }
>  
>  static void intel_set_cpu_max_freq(void)
> @@ -1876,10 +1880,19 @@ static void intel_set_cpu_max_freq(void)
>  	core_set_cpu_max_freq();
>  }
>  
> -static void set_cpu_max_freq(void)
> +static void init_scale_freq(void *arg)
>  {
>  	u64 aperf, mperf;
>  
> +	rdmsrl(MSR_IA32_APERF, aperf);
> +	rdmsrl(MSR_IA32_MPERF, mperf);
> +
> +	this_cpu_write(arch_prev_aperf, aperf);
> +	this_cpu_write(arch_prev_mperf, mperf);
> +}
> +
> +static void set_cpu_max_freq(void)
> +{
>  	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
>  		return;
>  
> @@ -1891,11 +1904,7 @@ static void set_cpu_max_freq(void)
>  		break;
>  	}
>  
> -	rdmsrl(MSR_IA32_APERF, aperf);
> -	rdmsrl(MSR_IA32_MPERF, mperf);
> -
> -	this_cpu_write(arch_prev_aperf, aperf);
> -	this_cpu_write(arch_prev_mperf, mperf);
> +	init_scale_freq(NULL);
>  }
>  
>  DEFINE_PER_CPU(unsigned long, arch_cpu_freq);
> @@ -1908,7 +1917,7 @@ void arch_scale_freq_tick(void)
>  	u64 aperf, mperf;
>  	u64 acnt, mcnt;
>  
> -	if (!static_cpu_has(X86_FEATURE_APERFMPERF) || tick_disable)
> +	if (!arch_scale_freq_invariant() || tick_disable)
>  		return;
>  
>  	rdmsrl(MSR_IA32_APERF, aperf);
> @@ -1940,5 +1949,6 @@ void x86_arch_scale_freq_tick_enable(voi
>  
>  void x86_arch_scale_freq_tick_disable(void)
>  {
> +	on_each_cpu(init_scale_freq, NULL, 1);
>  	tick_disable = true;

I don't see why the call init_scale_freq() here is needed; why would I care of
what's in arch_prev_[am]perf at this point. arch_scale_freq_tick() will see
that tick_disable == true and exit early before reading arch_prev_[am]perf.

The problem IMO emerges in the following configuration, which is a bug in the
patch I sent:

  * arch_scale_freq_invariant() is true (because we have APERF/MPERF)
  * arch_scale_freq_capacity() is non-trivial (reads arch_cpu_freq)
  * tick calculations are disabled

In this case arch_scale_freq_capacity() feeds stale data to the function
update_rq_clock_pelt() in kernel/sched/pelt.h. I initially missed this problem
because I forgot that PELT signals have more users than just the schedutil
governor (load balancer etc).

This is exactly the situation produced by patch 2/2 which disables the tick
calculations for intel_cpufreq (aka intel_pstate=passive).

I think the fix for this is to set arch_cpu_freq (each per-cpu instance of the
variable) to SCHED_CAPACITY_SCALE here in x86_arch_scale_freq_tick_disable().
That would render the scaling factor for invariance moot (always 1), just as
it is w/o scale invariance.

I'm sending v2 with all your amendmends except this last one.


Giovanni
