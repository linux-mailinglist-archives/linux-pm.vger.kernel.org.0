Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFD15B064
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 20:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgBLS7h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 13:59:37 -0500
Received: from foss.arm.com ([217.140.110.172]:36592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbgBLS7h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 13:59:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A93F930E;
        Wed, 12 Feb 2020 10:59:36 -0800 (PST)
Received: from [10.37.12.230] (unknown [10.37.12.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F07773F68E;
        Wed, 12 Feb 2020 10:59:32 -0800 (PST)
Subject: Re: [PATCH v3 6/7] arm64: use activity monitors for frequency
 invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com,
        valentin.schneider@arm.com, rjw@rjwysocki.net
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-7-ionela.voinescu@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a63fd15f-f02d-6afe-6e1f-817b9eb452d1@arm.com>
Date:   Wed, 12 Feb 2020 18:59:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200211184542.29585-7-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela,

On 2/11/20 6:45 PM, Ionela Voinescu wrote:
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
>   - (optional) CONFIG_CPU_FREQ - the current frequency obtained using
>     counter information is divided by the maximum frequency obtained from
>     the cpufreq policy. But the use of cpufreq policy maximum frequency
>     is weak and cpu_get_max_freq can be redefined to provide the data
>     some other way.
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
>   arch/arm64/include/asm/topology.h |  16 +++
>   arch/arm64/kernel/cpufeature.c    |   4 +
>   arch/arm64/kernel/topology.c      | 185 ++++++++++++++++++++++++++++++
>   drivers/base/arch_topology.c      |   8 ++
>   include/linux/topology.h          |   7 ++
>   5 files changed, 220 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index a4d945db95a2..d910d463cf76 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -16,6 +16,22 @@ int pcibus_to_node(struct pci_bus *bus);
>   
>   #include <linux/arch_topology.h>
>   
> +#ifdef CONFIG_ARM64_AMU_EXTN
> +extern unsigned int cpu_get_max_freq(unsigned int cpu);
> +/*
> + * Replace default function that signals use of counters
> + * for frequency invariance for given CPUs.
> + */
> +bool topology_cpu_freq_counters(struct cpumask *cpus);
> +#define arch_cpu_freq_counters topology_cpu_freq_counters
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
> index 029a473ad273..a4620b269b56 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1172,12 +1172,16 @@ bool cpu_has_amu_feat(int cpu)
>   	return false;
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
>   		cpumask_set_cpu(smp_processor_id(), amu_cpus);
> +		init_cpu_freq_invariance_counters();
>   	}
>   }
>   
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index fa9528dfd0ce..3f6e379f07b3 100644
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
> @@ -120,4 +121,188 @@ int __init parse_acpi_topology(void)
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
> +/* Obtain max frequency (in KHz) as reported by hardware */
> +__weak unsigned int cpu_get_max_freq(unsigned int cpu)
> +{
> +	return 0;
> +}
> +
> +#ifdef CONFIG_CPU_FREQ
> +/* Replace max frequency getter with cpufreq based function */
> +#define cpu_get_max_freq cpufreq_get_hw_max_freq
> +#endif

Can we just use cpufreq_get_hw_max_freq()?
We have cpufreq_get_hw_max_freq returning 0 in such case, so it should
be OK.

Is there a possibility that some platform which has !CONFIG_CPU_FREQ
would define its own cpu_get_max_freq() overwriting the weak function
above?
Based on the code which checks 'if (unlikely(!max_freq_hz))' it should,
otherwise 'valid_cpus' is not set.

I would assume that we won't see such platform, interested
in AMU freq invariance without CONFIG_CPU_FREQ.

We already have a lot of these defines or __weak functions, which is
hard to follow.

Apart from that and the issue with cpu_has_amu_feat() it looks good.

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

As Suzuki pointed out with 'amu_cpus', make sure we read
a one instance of mask here.


Regards,
Lukasz
