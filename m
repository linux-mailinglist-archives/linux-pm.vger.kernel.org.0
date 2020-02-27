Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6DEF1712B7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 09:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgB0IoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 03:44:01 -0500
Received: from foss.arm.com ([217.140.110.172]:46996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbgB0IoB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Feb 2020 03:44:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E20111FB;
        Thu, 27 Feb 2020 00:43:57 -0800 (PST)
Received: from [10.37.12.169] (unknown [10.37.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FF4C3F819;
        Thu, 27 Feb 2020 00:43:52 -0800 (PST)
Subject: Re: [PATCH v5 6/7] arm64: use activity monitors for frequency
 invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        rjw@rjwysocki.net, pkondeti@codeaurora.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200226132947.29738-1-ionela.voinescu@arm.com>
 <20200226132947.29738-7-ionela.voinescu@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1da054d0-fef2-8a0b-b513-f2709b6d0208@arm.com>
Date:   Thu, 27 Feb 2020 08:43:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226132947.29738-7-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/26/20 1:29 PM, Ionela Voinescu wrote:
> The Frequency Invariance Engine (FIE) is providing a frequency
> scaling correction factor that helps achieve more accurate
> load-tracking.
> 
> So far, for arm and arm64 platforms, this scale factor has been
> obtained based on the ratio between the current frequency and the
> maximum supported frequency recorded by the cpufreq policy. The
> setting of this scale factor is triggered from cpufreq drivers by
> calling arch_set_freq_scale. The current frequency used in computation
> is the frequency requested by a governor, but it may not be the
> frequency that was implemented by the platform.
> 
> This correction factor can also be obtained using a core counter and a
> constant counter to get information on the performance (frequency based
> only) obtained in a period of time. This will more accurately reflect
> the actual current frequency of the CPU, compared with the alternative
> implementation that reflects the request of a performance level from
> the OS.
> 
> Therefore, implement arch_scale_freq_tick to use activity monitors, if
> present, for the computation of the frequency scale factor.
> 
> The use of AMU counters depends on:
>   - CONFIG_ARM64_AMU_EXTN - depents on the AMU extension being present
>   - CONFIG_CPU_FREQ - the current frequency obtained using counter
>     information is divided by the maximum frequency obtained from the
>     cpufreq policy.
> 
> While it is possible to have a combination of CPUs in the system with
> and without support for activity monitors, the use of counters for
> frequency invariance is only enabled for a CPU if all related CPUs
> (CPUs in the same frequency domain) support and have enabled the core
> and constant activity monitor counters. In this way, there is a clear
> separation between the policies for which arch_set_freq_scale (cpufreq
> based FIE) is used, and the policies for which arch_scale_freq_tick
> (counter based FIE) is used to set the frequency scale factor. For
> this purpose, a late_initcall_sync is registered to trigger validation
> work for policies that will enable or disable the use of AMU counters
> for frequency invariance. If CONFIG_CPU_FREQ is not defined, the use
> of counters is enabled on all CPUs only if all possible CPUs correctly
> support the necessary counters.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   arch/arm64/include/asm/topology.h |   9 ++
>   arch/arm64/kernel/cpufeature.c    |   4 +
>   arch/arm64/kernel/topology.c      | 180 ++++++++++++++++++++++++++++++
>   drivers/base/arch_topology.c      |  12 ++
>   include/linux/arch_topology.h     |   2 +
>   5 files changed, 207 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index a4d945db95a2..21d4d40d6243 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -16,6 +16,15 @@ int pcibus_to_node(struct pci_bus *bus);
>   
>   #include <linux/arch_topology.h>
>   
> +#ifdef CONFIG_ARM64_AMU_EXTN
> +/*
> + * Replace task scheduler's default counter-based
> + * frequency-invariance scale factor setting.
> + */
> +void topology_scale_freq_tick(void);
> +#define arch_scale_freq_tick topology_scale_freq_tick
> +#endif /* CONFIG_ARM64_AMU_EXTN */
> +
>   /* Replace task scheduler's default frequency-invariant accounting */
>   #define arch_scale_freq_capacity topology_get_freq_scale
>   
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 60cebc071603..b8ec6c544d32 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1241,12 +1241,16 @@ bool cpu_has_amu_feat(int cpu)
>   	return cpumask_test_cpu(cpu, &amu_cpus);
>   }
>   
> +/* Initialize the use of AMU counters for frequency invariance */
> +extern void init_cpu_freq_invariance_counters(void);
> +
>   static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
>   {
>   	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
>   		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
>   			smp_processor_id());
>   		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
> +		init_cpu_freq_invariance_counters();
>   	}
>   }
>   
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index fa9528dfd0ce..0801a0f3c156 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -14,6 +14,7 @@
>   #include <linux/acpi.h>
>   #include <linux/arch_topology.h>
>   #include <linux/cacheinfo.h>
> +#include <linux/cpufreq.h>
>   #include <linux/init.h>
>   #include <linux/percpu.h>
>   
> @@ -120,4 +121,183 @@ int __init parse_acpi_topology(void)
>   }
>   #endif
>   
> +#ifdef CONFIG_ARM64_AMU_EXTN
>   
> +#undef pr_fmt
> +#define pr_fmt(fmt) "AMU: " fmt
> +
> +static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
> +static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> +static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> +static cpumask_var_t amu_fie_cpus;
> +
> +/* Initialize counter reference per-cpu variables for the current CPU */
> +void init_cpu_freq_invariance_counters(void)
> +{
> +	this_cpu_write(arch_core_cycles_prev,
> +		       read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0));
> +	this_cpu_write(arch_const_cycles_prev,
> +		       read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0));
> +}
> +
> +static int validate_cpu_freq_invariance_counters(int cpu)
> +{
> +	u64 max_freq_hz, ratio;
> +
> +	if (!cpu_has_amu_feat(cpu)) {
> +		pr_debug("CPU%d: counters are not supported.\n", cpu);
> +		return -EINVAL;
> +	}
> +
> +	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
> +		     !per_cpu(arch_core_cycles_prev, cpu))) {
> +		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
> +		return -EINVAL;
> +	}
> +
> +	/* Convert maximum frequency from KHz to Hz and validate */
> +	max_freq_hz = cpufreq_get_hw_max_freq(cpu) * 1000;
> +	if (unlikely(!max_freq_hz)) {
> +		pr_debug("CPU%d: invalid maximum frequency.\n", cpu);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Pre-compute the fixed ratio between the frequency of the constant
> +	 * counter and the maximum frequency of the CPU.
> +	 *
> +	 *			      const_freq
> +	 * arch_max_freq_scale =   ---------------- * SCHED_CAPACITY_SCALE²
> +	 *			   cpuinfo_max_freq
> +	 *
> +	 * We use a factor of 2 * SCHED_CAPACITY_SHIFT -> SCHED_CAPACITY_SCALE²
> +	 * in order to ensure a good resolution for arch_max_freq_scale for
> +	 * very low arch timer frequencies (down to the KHz range which should
> +	 * be unlikely).
> +	 */
> +	ratio = (u64)arch_timer_get_rate() << (2 * SCHED_CAPACITY_SHIFT);
> +	ratio = div64_u64(ratio, max_freq_hz);
> +	if (!ratio) {
> +		WARN_ONCE(1, "System timer frequency too low.\n");
> +		return -EINVAL;
> +	}
> +
> +	per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
> +
> +	return 0;
> +}
> +
> +static inline bool
> +enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +
> +	if (!policy) {
> +		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
> +		return false;
> +	}
> +
> +	if (cpumask_subset(policy->related_cpus, valid_cpus))
> +		cpumask_or(amu_fie_cpus, policy->related_cpus,
> +			   amu_fie_cpus);
> +
> +	cpufreq_cpu_put(policy);
> +
> +	return true;
> +}
> +
> +static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
> +#define amu_freq_invariant() static_branch_unlikely(&amu_fie_key)
> +
> +static int __init init_amu_fie(void)
> +{
> +	cpumask_var_t valid_cpus;
> +	bool have_policy = false;
> +	int ret = 0;
> +	int cpu;
> +
> +	if (!zalloc_cpumask_var(&valid_cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto free_valid_mask;
> +	}
> +
> +	for_each_present_cpu(cpu) {
> +		if (validate_cpu_freq_invariance_counters(cpu))
> +			continue;
> +		cpumask_set_cpu(cpu, valid_cpus);
> +		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
> +	}
> +
> +	/*
> +	 * If we are not restricted by cpufreq policies, we only enable
> +	 * the use of the AMU feature for FIE if all CPUs support AMU.
> +	 * Otherwise, enable_policy_freq_counters has already enabled
> +	 * policy cpus.
> +	 */
> +	if (!have_policy && cpumask_equal(valid_cpus, cpu_present_mask))
> +		cpumask_or(amu_fie_cpus, amu_fie_cpus, valid_cpus);
> +
> +	if (!cpumask_empty(amu_fie_cpus)) {
> +		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> +			cpumask_pr_args(amu_fie_cpus));
> +		static_branch_enable(&amu_fie_key);
> +	}
> +
> +free_valid_mask:
> +	free_cpumask_var(valid_cpus);
> +
> +	return ret;
> +}
> +late_initcall_sync(init_amu_fie);
> +
> +bool arch_freq_counters_available(struct cpumask *cpus)
> +{
> +	return amu_freq_invariant() &&
> +	       cpumask_subset(cpus, amu_fie_cpus);
> +}
> +
> +void topology_scale_freq_tick(void)
> +{
> +	u64 prev_core_cnt, prev_const_cnt;
> +	u64 core_cnt, const_cnt, scale;
> +	int cpu = smp_processor_id();
> +
> +	if (!amu_freq_invariant())
> +		return;
> +
> +	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
> +		return;
> +
> +	const_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
> +	core_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
> +	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
> +	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
> +
> +	if (unlikely(core_cnt <= prev_core_cnt ||
> +		     const_cnt <= prev_const_cnt))
> +		goto store_and_exit;
> +
> +	/*
> +	 *	    /\core    arch_max_freq_scale
> +	 * scale =  ------- * --------------------
> +	 *	    /\const   SCHED_CAPACITY_SCALE
> +	 *
> +	 * See validate_cpu_freq_invariance_counters() for details on
> +	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
> +	 */
> +	scale = core_cnt - prev_core_cnt;
> +	scale *= this_cpu_read(arch_max_freq_scale);
> +	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
> +			  const_cnt - prev_const_cnt);
> +
> +	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> +	this_cpu_write(freq_scale, (unsigned long)scale);
> +
> +store_and_exit:
> +	this_cpu_write(arch_core_cycles_prev, core_cnt);
> +	this_cpu_write(arch_const_cycles_prev, const_cnt);
> +}
> +#endif /* CONFIG_ARM64_AMU_EXTN */
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 6119e11a9f95..8d63673c1689 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -21,6 +21,10 @@
>   #include <linux/sched.h>
>   #include <linux/smp.h>
>   
> +__weak bool arch_freq_counters_available(struct cpumask *cpus)
> +{
> +	return false;
> +}
>   DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>   
>   void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> @@ -29,6 +33,14 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>   	unsigned long scale;
>   	int i;
>   
> +	/*
> +	 * If the use of counters for FIE is enabled, just return as we don't
> +	 * want to update the scale factor with information from CPUFREQ.
> +	 * Instead the scale factor will be updated from arch_scale_freq_tick.
> +	 */
> +	if (arch_freq_counters_available(cpus))
> +		return;
> +
>   	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
>   
>   	for_each_cpu(i, cpus)
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 3015ecbb90b1..1ccdddb541a7 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -33,6 +33,8 @@ unsigned long topology_get_freq_scale(int cpu)
>   	return per_cpu(freq_scale, cpu);
>   }
>   
> +bool arch_freq_counters_available(struct cpumask *cpus);
> +
>   struct cpu_topology {
>   	int thread_id;
>   	int core_id;
> 


Looks good

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
