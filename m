Return-Path: <linux-pm+bounces-20999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E881A205CB
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 09:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 527667A2521
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 08:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917271DEFE5;
	Tue, 28 Jan 2025 08:17:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4445D1DEFF1;
	Tue, 28 Jan 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052258; cv=none; b=WGhlu2k0PPpepjvifhWs5wJa/8InE1oA8WRWr1NGbynecKtXIqp5R7lCqm0XH+C5+Jpt+rB+CtlM7l84Lzi8JP5oskWCNnoBOzOLsAiFoCRUupKYFLuW1riTthKBtY01AIt9O6+tCVyi8nIYcgg9Zbg9ng9EggBpJPadJ6NUuSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052258; c=relaxed/simple;
	bh=ZefN+19FZJsYqwINpUePiyb3x6/oAThHnHnVCY+7+ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av85L2vZlIje5AS/+fFPW22IfIoVE1Z5sUXezR5YK27LGD2SD8fMzNRVZoe3Ih05XS2qrf75FctJzeP7dyvaYZ3CJvP0dP/hOeNI/bTSKqCpRFGdAiPSW1afNy6qBD1JhNdfLRXaZ66+F2y95ll4WtPEQqXMWZATnAPsLfzM1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13257497;
	Tue, 28 Jan 2025 00:18:02 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B20BB3F694;
	Tue, 28 Jan 2025 00:17:31 -0800 (PST)
Date: Tue, 28 Jan 2025 09:16:52 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, viresh.kumar@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com, zhanjie9@hisilicon.com
Subject: Re: [PATCH v9 4/5] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <Z5iSdJAVRXohKu9s@arm.com>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-5-beata.michalska@arm.com>
 <e78d7ddd-6e49-4b16-a1e5-79558d73ce52@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78d7ddd-6e49-4b16-a1e5-79558d73ce52@linux.microsoft.com>

On Fri, Jan 24, 2025 at 10:13:30AM +0530, Prasanna Kumar T S M wrote:
> 
> On 21-01-2025 14:14, Beata Michalska wrote:
> > With the Frequency Invariance Engine (FIE) being already wired up with
> > sched tick and making use of relevant (core counter and constant
> > counter) AMU counters, getting the average frequency for a given CPU,
> > can be achieved by utilizing the frequency scale factor which reflects
> > an average CPU frequency for the last tick period length.
> > 
> > The solution is partially based on APERF/MPERF implementation of
> > arch_freq_get_on_cpu.
> > 
> > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >   arch/arm64/kernel/topology.c | 109 +++++++++++++++++++++++++++++++----
> >   1 file changed, 99 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index cb180684d10d..5f5738b174c7 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/cpufreq.h>
> >   #include <linux/init.h>
> >   #include <linux/percpu.h>
> > +#include <linux/sched/isolation.h>
> >   #include <asm/cpu.h>
> >   #include <asm/cputype.h>
> > @@ -88,18 +89,28 @@ int __init parse_acpi_topology(void)
> >    * initialized.
> >    */
> >   static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
> > -static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> > -static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> >   static cpumask_var_t amu_fie_cpus;
> > +struct amu_cntr_sample {
> > +	u64		arch_const_cycles_prev;
> > +	u64		arch_core_cycles_prev;
> > +	unsigned long	last_scale_update;
> > +};
> > +
> > +static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
> > +
> >   void update_freq_counters_refs(void)
> >   {
> > -	this_cpu_write(arch_core_cycles_prev, read_corecnt());
> > -	this_cpu_write(arch_const_cycles_prev, read_constcnt());
> > +	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> > +
> > +	amu_sample->arch_core_cycles_prev = read_corecnt();
> > +	amu_sample->arch_const_cycles_prev = read_constcnt();
> >   }
> >   static inline bool freq_counters_valid(int cpu)
> >   {
> > +	struct amu_cntr_sample *amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> > +
> >   	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> >   		return false;
> > @@ -108,8 +119,8 @@ static inline bool freq_counters_valid(int cpu)
> >   		return false;
> >   	}
> > -	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
> > -		     !per_cpu(arch_core_cycles_prev, cpu))) {
> > +	if (unlikely(!amu_sample->arch_const_cycles_prev ||
> > +		     !amu_sample->arch_core_cycles_prev)) {
> >   		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
> >   		return false;
> >   	}
> > @@ -152,17 +163,22 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
> >   static void amu_scale_freq_tick(void)
> >   {
> > +	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> >   	u64 prev_core_cnt, prev_const_cnt;
> >   	u64 core_cnt, const_cnt, scale;
> > -	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
> > -	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
> > +	prev_const_cnt = amu_sample->arch_const_cycles_prev;
> > +	prev_core_cnt = amu_sample->arch_core_cycles_prev;
> >   	update_freq_counters_refs();
> > -	const_cnt = this_cpu_read(arch_const_cycles_prev);
> > -	core_cnt = this_cpu_read(arch_core_cycles_prev);
> > +	const_cnt = amu_sample->arch_const_cycles_prev;
> > +	core_cnt = amu_sample->arch_core_cycles_prev;
> > +	/*
> > +	 * This should not happen unless the AMUs have been reset and the
> > +	 * counter values have not been restored - unlikely
> > +	 */
> >   	if (unlikely(core_cnt <= prev_core_cnt ||
> >   		     const_cnt <= prev_const_cnt))
> >   		return;
> > @@ -182,6 +198,8 @@ static void amu_scale_freq_tick(void)
> >   	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> >   	this_cpu_write(arch_freq_scale, (unsigned long)scale);
> > +
> > +	amu_sample->last_scale_update = jiffies;
> >   }
> >   static struct scale_freq_data amu_sfd = {
> > @@ -189,6 +207,77 @@ static struct scale_freq_data amu_sfd = {
> >   	.set_freq_scale = amu_scale_freq_tick,
> >   };
> > +static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
> > +{
> > +	return cpumask_available(amu_fie_cpus) &&
> > +		cpumask_test_cpu(cpu, amu_fie_cpus);
> > +}
> > +
> > +#define AMU_SAMPLE_EXP_MS	20
> > +
> > +int arch_freq_get_on_cpu(int cpu)
> > +{
> > +	struct amu_cntr_sample *amu_sample;
> > +	unsigned int start_cpu = cpu;
> > +	unsigned long last_update;
> > +	unsigned int freq = 0;
> > +	u64 scale;
> > +
> > +	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
> > +		return -EOPNOTSUPP;
> > +
> > +retry:
> > +	amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> > +
> > +	last_update = amu_sample->last_scale_update;
> > +
> > +	/*
> > +	 * For those CPUs that are in full dynticks mode, or those that have
> > +	 * not seen tick for a while, try an alternative source for the counters
> > +	 * (and thus freq scale), if available, for given policy: this boils
> > +	 * down to identifying an active cpu within the same freq domain, if any.
> > +	 */
> > +	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
> > +	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
> > +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > +		int ref_cpu = cpu;
> > +
> > +		if (!policy)
> > +			return -EINVAL;
> > +
> > +		if (!cpumask_intersects(policy->related_cpus,
> > +					housekeeping_cpumask(HK_TYPE_TICK))) {
> > +			cpufreq_cpu_put(policy);
> > +			return -EOPNOTSUPP;
> > +		}
> > +
> > +
> > +		do {
> > +			ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
> > +						    start_cpu, false);
> > +
> > +		} while (ref_cpu < nr_cpu_ids && idle_cpu(ref_cpu));
> > +
> > +		cpufreq_cpu_put(policy);
> > +
> > +		if (ref_cpu >= nr_cpu_ids)
> > +			/* No alternative to pull info from */
> > +			return -EAGAIN;
> > +
> > +		cpu = ref_cpu;
> > +		goto retry;
> 
> If you are going to spin a new revision, can you use while loop instead of
> using goto for looping? This will help improve the readability.
Can do, I guess, if you believe it will be more readable that way - me myself
slightly hesitating about that.

---
BR
Beata
> 
> > +	}
> > +	/*
> > +	 * Reversed computation to the one used to determine
> > +	 * the arch_freq_scale value
> > +	 * (see amu_scale_freq_tick for details)
> > +	 */
> > +	scale = arch_scale_freq_capacity(cpu);
> > +	freq = scale * arch_scale_freq_ref(cpu);
> > +	freq >>= SCHED_CAPACITY_SHIFT;
> > +	return freq;
> > +}
> > +
> >   static void amu_fie_setup(const struct cpumask *cpus)
> >   {
> >   	int cpu;

