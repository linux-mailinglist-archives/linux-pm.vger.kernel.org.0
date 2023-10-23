Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7B7D4148
	for <lists+linux-pm@lfdr.de>; Mon, 23 Oct 2023 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjJWU6i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Oct 2023 16:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjJWU6h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2023 16:58:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07DD19D;
        Mon, 23 Oct 2023 13:58:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDCFF2F4;
        Mon, 23 Oct 2023 13:59:15 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34DDA3F64C;
        Mon, 23 Oct 2023 13:58:34 -0700 (PDT)
Date:   Mon, 23 Oct 2023 21:58:32 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [RFC v3 6/6] arm64/amu: use capacity_ref_freq to set AMU ratio
Message-ID: <ZTbebQrK3K+JwWxR@arm.com>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018162540.667646-7-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wednesday 18 Oct 2023 at 18:25:40 (+0200), Vincent Guittot wrote:
> Use the new capacity_ref_freq to set the ratio that is used by AMU for
> computing the arch_scale_freq_capacity().
> This helps to keep everything aligned using the same reference for
> computing CPUs capacity.
> 
> The default value of the ratio ensures that arch_scale_freq_capacity()
> returns max capacity until it is set to its correct value with the
> cpu capacity and capacity_ref_freq.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  arch/arm64/kernel/topology.c  | 18 ++++++++++--------
>  drivers/base/arch_topology.c  | 14 ++++++++++++--
>  include/linux/arch_topology.h |  1 +
>  3 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 817d788cd866..0f8f6e90c46d 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -82,7 +82,12 @@ int __init parse_acpi_topology(void)
>  #undef pr_fmt
>  #define pr_fmt(fmt) "AMU: " fmt
>  
> -static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
> +/*
> + * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SHIFT until
> + * the CPU capacity and its assosciated frequency have been correctly
> + * initialized.

s/SCHED_CAPACITY_SHIFT/SCHED_CAPACITY_SCALE

> + */
> +static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) = (2 * SCHED_CAPACITY_SHIFT);

It should be 1UL << (2 * SCHED_CAPACITY_SHIFT).

>  static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
>  static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
>  static cpumask_var_t amu_fie_cpus;
> @@ -112,9 +117,9 @@ static inline bool freq_counters_valid(int cpu)
>  	return true;
>  }
>  
> -static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
> +int freq_inv_set_max_ratio(int cpu, u64 max_rate)
>  {
> -	u64 ratio;
> +	u64 ratio, ref_rate = arch_timer_get_rate();
>  
>  	if (unlikely(!max_rate || !ref_rate)) {
>  		pr_debug("CPU%d: invalid maximum or reference frequency.\n",
> @@ -142,7 +147,7 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
>  		return -EINVAL;
>  	}

The return value is no longer used so it might be worth declaring it to
return void and WARN_ONCE for unlikely(!max_rate || !ref_rate).

>  
> -	per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
> +	WRITE_ONCE(per_cpu(arch_max_freq_scale, cpu), (unsigned long)ratio);
>  
>  	return 0;
>  }
> @@ -195,10 +200,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
>  		return;
>  
>  	for_each_cpu(cpu, cpus) {
> -		if (!freq_counters_valid(cpu) ||
> -		    freq_inv_set_max_ratio(cpu,
> -					   cpufreq_get_hw_max_freq(cpu) * 1000ULL,
> -					   arch_timer_get_rate()))
> +		if (!freq_counters_valid(cpu))
>  			return;
>  	}
>  
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 2372ce791bb4..3a604b77b12d 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -344,6 +344,11 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>  	return !ret;
>  }
>  
> +int __weak freq_inv_set_max_ratio(int cpu, u64 max_rate)
> +{
> +	return 0;
> +}
> +
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  #include <acpi/cppc_acpi.h>
>  
> @@ -369,7 +374,6 @@ void topology_init_cpu_capacity_cppc(void)
>  			capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
>  
>  			per_cpu(capacity_ref_freq, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
> -
>  			pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
>  				 cpu, raw_capacity[cpu]);
>  			continue;
> @@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
>  	}
>  
>  	for_each_possible_cpu(cpu) {
> +		freq_inv_set_max_ratio(cpu,
> +				       per_cpu(capacity_ref_freq, cpu));
> +
>  		capacity = raw_capacity[cpu];
>  		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
>  				     capacity_scale);
> @@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>  
>  	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
>  
> -	for_each_cpu(cpu, policy->related_cpus)
> +	for_each_cpu(cpu, policy->related_cpus) {
>  		per_cpu(capacity_ref_freq, cpu) = policy->cpuinfo.max_freq;
> +		freq_inv_set_max_ratio(cpu,
> +				       per_cpu(capacity_ref_freq, cpu));

capacity_ref_freq is in KHz while arch_timer_get_rate() is in Hz. One or
the other needs to be scaled.

The same in topology_init_cpu_capacity_cppc().

Thanks,
Ionela.

> +	}
>  
>  	if (cpumask_empty(cpus_to_visit)) {
>  		topology_normalize_cpu_scale();
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 38ca6c76af56..b6e95d763279 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
>  void remove_cpu_topology(unsigned int cpuid);
>  void reset_cpu_topology(void);
>  int parse_acpi_topology(void);
> +int freq_inv_set_max_ratio(int cpu, u64 max_rate);
>  #endif
>  
>  #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
> -- 
> 2.34.1
> 
