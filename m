Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AB3333B45
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 12:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhCJLWh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 06:22:37 -0500
Received: from foss.arm.com ([217.140.110.172]:44402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhCJLWT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Mar 2021 06:22:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AAA41FB;
        Wed, 10 Mar 2021 03:22:19 -0800 (PST)
Received: from [10.57.15.210] (unknown [10.57.15.210])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 577B83F85F;
        Wed, 10 Mar 2021 03:22:15 -0800 (PST)
Subject: Re: [PATCH v3 5/5] powercap/drivers/dtpm: Scale the power with the
 load
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210310110212.26512-1-daniel.lezcano@linaro.org>
 <20210310110212.26512-5-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d2a57633-074a-f0c3-25dc-7ebdf8455d2f@arm.com>
Date:   Wed, 10 Mar 2021 11:22:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210310110212.26512-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/10/21 11:02 AM, Daniel Lezcano wrote:
> Currently the power consumption is based on the current OPP power
> assuming the entire performance domain is fully loaded.
> 
> That gives very gross power estimation and we can do much better by
> using the load to scale the power consumption.
> 
> Use the utilization to normalize and scale the power usage over the
> max possible power.
> 
> Tested on a rock960 with 2 big CPUS, the power consumption estimation
> conforms with the expected one.
> 
> Before this change:
> 
> ~$ ~/dhrystone -t 1 -l 10000&
> ~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
> 2260000
> 
> After this change:
> 
> ~$ ~/dhrystone -t 1 -l 10000&
> ~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
> 1130000
> 
> ~$ ~/dhrystone -t 2 -l 10000&
> ~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
> 2260000
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> 
> V3:
>    - Fixed uninitialized 'cpu' in scaled_power_uw()
> V2:
>    - Replaced cpumask by em_span_cpus
>    - Changed 'util' metrics variable types
>    - Optimized utilization scaling power computation
>    - Renamed parameter name for scale_pd_power_uw()
> ---
>   drivers/powercap/dtpm_cpu.c | 46 +++++++++++++++++++++++++++++++------
>   1 file changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index ac7f2e7e262f..47854923d958 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -68,27 +68,59 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>   	return power_limit;
>   }
>   
> +static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
> +{
> +	unsigned long max = 0, sum_util = 0;
> +	int cpu;
> +
> +	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
> +
> +		/*
> +		 * The capacity is the same for all CPUs belonging to
> +		 * the same perf domain, so a single call to
> +		 * arch_scale_cpu_capacity() is enough. However, we
> +		 * need the CPU parameter to be initialized by the
> +		 * loop, so the call ends up in this block.
> +		 *
> +		 * We can initialize 'max' with a cpumask_first() call
> +		 * before the loop but the bits computation is not
> +		 * worth given the arch_scale_cpu_capacity() just
> +		 * returns a value where the resulting assembly code
> +		 * will be optimized by the compiler.
> +		 */
> +		max = arch_scale_cpu_capacity(cpu);
> +		sum_util += sched_cpu_util(cpu, max);
> +	}
> +
> +	/*
> +	 * In the improbable case where all the CPUs of the perf
> +	 * domain are offline, 'max' will be zero and will lead to an
> +	 * illegal operation with a zero division.
> +	 */
> +	return max ? (power * ((sum_util << 10) / max)) >> 10 : 0;
> +}
> +
>   static u64 get_pd_power_uw(struct dtpm *dtpm)
>   {
>   	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
>   	struct em_perf_domain *pd;
> -	struct cpumask cpus;
> +	struct cpumask *pd_mask;
>   	unsigned long freq;
> -	int i, nr_cpus;
> +	int i;
>   
>   	pd = em_cpu_get(dtpm_cpu->cpu);
> -	freq = cpufreq_quick_get(dtpm_cpu->cpu);
>   
> -	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
> -	nr_cpus = cpumask_weight(&cpus);
> +	pd_mask = em_span_cpus(pd);
> +
> +	freq = cpufreq_quick_get(dtpm_cpu->cpu);
>   
>   	for (i = 0; i < pd->nr_perf_states; i++) {
>   
>   		if (pd->table[i].frequency < freq)
>   			continue;
>   
> -		return pd->table[i].power *
> -			MICROWATT_PER_MILLIWATT * nr_cpus;
> +		return scale_pd_power_uw(pd_mask, pd->table[i].power *
> +					 MICROWATT_PER_MILLIWATT);
>   	}
>   
>   	return 0;
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
