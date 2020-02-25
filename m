Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 361F316BE19
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 10:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgBYJ71 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 04:59:27 -0500
Received: from foss.arm.com ([217.140.110.172]:48508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbgBYJ71 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Feb 2020 04:59:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A46E230E;
        Tue, 25 Feb 2020 01:59:26 -0800 (PST)
Received: from [10.37.12.155] (unknown [10.37.12.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6BFF3F6CF;
        Tue, 25 Feb 2020 01:59:22 -0800 (PST)
Subject: Re: [PATCH v4 6/7] arm64: use activity monitors for frequency
 invariance
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, rjw@rjwysocki.net, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200224141142.25445-1-ionela.voinescu@arm.com>
 <20200224141142.25445-7-ionela.voinescu@arm.com> <jhjmu97ygk9.fsf@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <18604cef-1e26-96a6-38b3-ab03b1b53b48@arm.com>
Date:   Tue, 25 Feb 2020 09:59:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <jhjmu97ygk9.fsf@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/24/20 6:40 PM, Valentin Schneider wrote:
> 
> Ionela Voinescu writes:
> 
>> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
> 
> With the small nits below:
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index fa9528dfd0ce..7606cbd63517 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> +
>> +static inline int
> 
> That should be bool, seeing what it returns.
> 
>> +enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
>> +{
>> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>> +
>> +	if (!policy) {
>> +		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
>> +		return false;
>> +	}
>> +
>> +	if (cpumask_subset(policy->related_cpus, valid_cpus))
>> +		cpumask_or(amu_fie_cpus, policy->related_cpus,
>> +			   amu_fie_cpus);
>> +
>> +	cpufreq_cpu_put(policy);
>> +
>> +	return true;
>> +}
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 1eb81f113786..1ab2b7503d63 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -29,6 +29,14 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>>        unsigned long scale;
>>        int i;
>>
>> +	/*
>> +	 * If the use of counters for FIE is enabled, just return as we don't
>> +	 * want to update the scale factor with information from CPUFREQ.
>> +	 * Instead the scale factor will be updated from arch_scale_freq_tick.
>> +	 */
>> +	if (arch_cpu_freq_counters(cpus))
>> +		return;
>> +
>>        scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
>>
>>        for_each_cpu(i, cpus)
>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>> index eb2fe6edd73c..397aad6ae163 100644
>> --- a/include/linux/topology.h
>> +++ b/include/linux/topology.h
>> @@ -227,5 +227,12 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
>>        return cpumask_of_node(cpu_to_node(cpu));
>>   }
>>
>> +#ifndef arch_cpu_freq_counters
>> +static __always_inline
>> +bool arch_cpu_freq_counters(struct cpumask *cpus)
>> +{
>> +	return false;
>> +}
>> +#endif
>>
> 
> Apologies for commenting on this only now, I had missed it in my earlier
> round of review.
> 
> I would've liked to keep this contained within arm64 stuff until we agreed
> on a more generic counter-driven FIE interface, but seems like we can't evade
> it due to the arch_topology situation.
> 
> Would it make sense to relocate this stub to arch_topology.h instead, at
> least for the time being? That way the only non-arm64 changes are condensed
> in arch_topology (even if it doesn't change much in terms of header files,
> since topology.h imports arch_topology.h)

Or make it as a 'weak' and place it just above the arch_set_freq_scale()
in arch_topology.c, not touching headers?


