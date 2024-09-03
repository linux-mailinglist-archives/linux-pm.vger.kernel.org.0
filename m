Return-Path: <linux-pm+bounces-13428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C829969F94
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F29D1C21569
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6CF4A3E;
	Tue,  3 Sep 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N3WWkJQx"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93428817;
	Tue,  3 Sep 2024 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371858; cv=none; b=f8M4qM4oKWrfU+LP9c5IEnmMGAAfXe7mhVThW97km1Hoi6PTFMn9S/dprNIRrM8ve70bjYrGR+NfF3A2ilXd4EApE2ek260XgVQNH7RM4GMMJqBCjmbc7t5N7F6m9hKjko6GU1/fmK22ZbCRVOdrmbq5Z65R1u8kvzezhQOrVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371858; c=relaxed/simple;
	bh=0A66mT8r9YoaYUyW9ONA676xXy6aMTuyDw8oDq6HUM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ3tVSC186uDMEufCFN0fMb/skufCbz1LRbkdc+SnOXNDmzZwTa7ppAgQf8ufXfeJrZqhsGCMmObuoeh/GuGLfkl1wqJvKmzVFWKputA9re930H8azGh2+r1wITPeH38oJDPri7HTwNXHhmmaLuf6b9GlGNIZVuUU9pBaIrX6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N3WWkJQx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VLo6LDGE+KsW/QUB23qEvFKA62MSYEGqSUVWTjDNnEQ=; b=N3WWkJQxGUOv7HQjdVxBCvrTwd
	ISAcQ61tk7JfZysghPuL6kMz1uO1VlEnAa1b1ojnAjdgLxciLiYBb2xg/OV5Go7iw2A/rziHvcvTw
	WQdZpzszsTKf4d2e5oXmF4P3BkhAJANoCtWPNUBQVE/p9ZvWAyx19azYqe0Rd947R6F54iKATQLRO
	NRndRJlv8Dl1YvrpOm9jqQhQGDWs1JV97W5NGAqO02BEpPEITWTNi6aC2OFHabB4RMlnX14JPNAYp
	XYKgEvacLR7LSVP739Ik96x9Ks+cJbFi+/eahLrEW67YcQoUv7edVn0GWHYADyeUC7sEg+2E7ftQc
	aGi8pR5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slU2C-0000000CLFM-1txR;
	Tue, 03 Sep 2024 13:57:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 18FDA30050D; Tue,  3 Sep 2024 15:57:28 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:57:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 1/2] x86/sched: Add basic support for CPU capacity
 scaling
Message-ID: <20240903135728.GY4723@noisy.programming.kicks-ass.net>
References: <3310447.aeNJFYEL58@rjwysocki.net>
 <10523497.nUPlyArG6x@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10523497.nUPlyArG6x@rjwysocki.net>

On Wed, Aug 28, 2024 at 01:47:25PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order be able to compute the sizes of tasks consistently across all
> CPUs in a hybrid system, it is necessary to provide CPU capacity scaling
> information to the scheduler via arch_scale_cpu_capacity().  Moreover,
> the value returned by arch_scale_freq_capacity() for the given CPU must
> correspond to the arch_scale_cpu_capacity() return value for it, or
> utilization computations will be inaccurate.
> 
> Add support for it through per-CPU variables holding the capacity and
> maximum-to-base frequency ratio (times SCHED_CAPACITY_SCALE) that will
> be returned by arch_scale_cpu_capacity() and used by scale_freq_tick()
> to compute arch_freq_scale for the current CPU, respectively.
> 
> In order to avoid adding measurable overhead for non-hybrid x86 systems,
> which are the vast majority in the field, whether or not the new hybrid
> CPU capacity scaling will be in effect is controlled by a static key.
> This static key is set by calling arch_enable_hybrid_capacity_scale()
> which also allocates memory for the per-CPU data and initializes it.
> Next, arch_set_cpu_capacity() is used to set the per-CPU variables
> mentioned above for each CPU and arch_rebuild_sched_domains() needs
> to be called for the scheduler to realize that capacity-aware
> scheduling can be used going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks about right; would be good to hear from the AMD folks if they can
use it as is, but if not, it should be simple enough to fix up later.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/include/asm/topology.h  |   13 +++++
>  arch/x86/kernel/cpu/aperfmperf.c |   89 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 100 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/arch/x86/include/asm/topology.h
> ===================================================================
> --- linux-pm.orig/arch/x86/include/asm/topology.h
> +++ linux-pm/arch/x86/include/asm/topology.h
> @@ -282,9 +282,22 @@ static inline long arch_scale_freq_capac
>  }
>  #define arch_scale_freq_capacity arch_scale_freq_capacity
>  
> +bool arch_enable_hybrid_capacity_scale(void);
> +void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long max_cap,
> +			   unsigned long cap_freq, unsigned long base_freq);
> +
> +unsigned long arch_scale_cpu_capacity(int cpu);
> +#define arch_scale_cpu_capacity arch_scale_cpu_capacity
> +
>  extern void arch_set_max_freq_ratio(bool turbo_disabled);
>  extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
>  #else
> +static inline bool arch_enable_hybrid_capacity_scale(void) { return false; }
> +static inline void arch_set_cpu_capacity(int cpu, unsigned long cap,
> +					 unsigned long max_cap,
> +					 unsigned long cap_freq,
> +					 unsigned long base_freq) { }
> +
>  static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
>  static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
>  #endif
> Index: linux-pm/arch/x86/kernel/cpu/aperfmperf.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/cpu/aperfmperf.c
> +++ linux-pm/arch/x86/kernel/cpu/aperfmperf.c
> @@ -349,9 +349,89 @@ static DECLARE_WORK(disable_freq_invaria
>  DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
>  EXPORT_PER_CPU_SYMBOL_GPL(arch_freq_scale);
>  
> +static DEFINE_STATIC_KEY_FALSE(arch_hybrid_cap_scale_key);
> +
> +struct arch_hybrid_cpu_scale {
> +	unsigned long capacity;
> +	unsigned long freq_ratio;
> +};
> +
> +static struct arch_hybrid_cpu_scale __percpu *arch_cpu_scale;
> +
> +/**
> + * arch_enable_hybrid_capacity_scale - Enable hybrid CPU capacity scaling
> + *
> + * Allocate memory for per-CPU data used by hybrid CPU capacity scaling,
> + * initialize it and set the static key controlling its code paths.
> + *
> + * Must be called before arch_set_cpu_capacity().
> + */
> +bool arch_enable_hybrid_capacity_scale(void)
> +{
> +	int cpu;
> +
> +	if (static_branch_unlikely(&arch_hybrid_cap_scale_key)) {
> +		WARN_ONCE(1, "Hybrid CPU capacity scaling already enabled");
> +		return true;
> +	}
> +
> +	arch_cpu_scale = alloc_percpu(struct arch_hybrid_cpu_scale);
> +	if (!arch_cpu_scale)
> +		return false;
> +
> +	for_each_possible_cpu(cpu) {
> +		per_cpu_ptr(arch_cpu_scale, cpu)->capacity = SCHED_CAPACITY_SCALE;
> +		per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio = arch_max_freq_ratio;
> +	}
> +
> +	static_branch_enable(&arch_hybrid_cap_scale_key);
> +
> +	pr_info("Hybrid CPU capacity scaling enabled\n");
> +
> +	return true;
> +}
> +
> +/**
> + * arch_set_cpu_capacity - Set scale-invariance parameters for a CPU
> + * @cpu: Target CPU.
> + * @cap: Capacity of @cpu at its maximum frequency, relative to @max_cap.
> + * @max_cap: System-wide maximum CPU capacity.
> + * @cap_freq: Frequency of @cpu corresponding to @cap.
> + * @base_freq: Frequency of @cpu at which MPERF counts.
> + *
> + * The units in which @cap and @max_cap are expressed do not matter, so long
> + * as they are consistent, because the former is effectively divided by the
> + * latter.  Analogously for @cap_freq and @base_freq.
> + *
> + * After calling this function for all CPUs, call arch_rebuild_sched_domains()
> + * to let the scheduler know that capacity-aware scheduling can be used going
> + * forward.
> + */
> +void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long max_cap,
> +			   unsigned long cap_freq, unsigned long base_freq)
> +{
> +	if (static_branch_likely(&arch_hybrid_cap_scale_key)) {
> +		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capacity,
> +			   div_u64(cap << SCHED_CAPACITY_SHIFT, max_cap));
> +		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio,
> +			   div_u64(cap_freq << SCHED_CAPACITY_SHIFT, base_freq));
> +	} else {
> +		WARN_ONCE(1, "Hybrid CPU capacity scaling not enabled");
> +	}
> +}
> +
> +unsigned long arch_scale_cpu_capacity(int cpu)
> +{
> +	if (static_branch_unlikely(&arch_hybrid_cap_scale_key))
> +		return READ_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capacity);
> +
> +	return SCHED_CAPACITY_SCALE;
> +}
> +EXPORT_SYMBOL_GPL(arch_scale_cpu_capacity);
> +
>  static void scale_freq_tick(u64 acnt, u64 mcnt)
>  {
> -	u64 freq_scale;
> +	u64 freq_scale, freq_ratio;
>  
>  	if (!arch_scale_freq_invariant())
>  		return;
> @@ -359,7 +439,12 @@ static void scale_freq_tick(u64 acnt, u6
>  	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
>  		goto error;
>  
> -	if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
> +	if (static_branch_unlikely(&arch_hybrid_cap_scale_key))
> +		freq_ratio = READ_ONCE(this_cpu_ptr(arch_cpu_scale)->freq_ratio);
> +	else
> +		freq_ratio = arch_max_freq_ratio;
> +
> +	if (check_mul_overflow(mcnt, freq_ratio, &mcnt) || !mcnt)
>  		goto error;
>  
>  	freq_scale = div64_u64(acnt, mcnt);
> 
> 
> 

