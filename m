Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60F3327FE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 15:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhCIOCT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 09:02:19 -0500
Received: from foss.arm.com ([217.140.110.172]:54264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhCIOCN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 09:02:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 973A031B;
        Tue,  9 Mar 2021 06:02:12 -0800 (PST)
Received: from [10.57.15.199] (unknown [10.57.15.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B0803F71B;
        Tue,  9 Mar 2021 06:02:11 -0800 (PST)
Subject: Re: [PATCH 1/5] powercap/drivers/dtpm: Encapsulate even more the code
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4207e928-3716-1dfa-2044-965ade3bd362@arm.com>
Date:   Tue, 9 Mar 2021 14:02:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210301212149.22877-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/1/21 9:21 PM, Daniel Lezcano wrote:
> In order to increase the self-encapsulation of the dtpm generic code,
> the following changes are adding a power update ops to the dtpm
> ops. That allows the generic code to call directly the dtpm backend
> function to update the power values.
> 
> The power update function does compute the power characteristics when
> the function is invoked. In the case of the CPUs, the power
> consumption depends on the number of online CPUs. The online CPUs mask
> is not up to date at CPUHP_AP_ONLINE_DYN state in the tear down
> callback. That is the reason why the online / offline are at separate
> state. As there is already an existing state for DTPM, this one is
> only moved to the DEAD state, so there is no addition of new state
> with these changes.

AFAICS in this implementation we don't remove the dtmp node when we
hotplug out the CPU - which is very good. It should be mentioned in this
description explicietely IMO.

I see the reason behind this new DEAD state, which we need for
operating on updated cpu_online_mask with the currently off CPU bit set
to 0. This also might be added either here or in the comment above the
cpuhp_


> 
> That simplifies the code for the next changes and results in a more
> self-encapsulated code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/powercap/dtpm.c     |  54 ++++++++--------
>   drivers/powercap/dtpm_cpu.c | 124 +++++++++++++-----------------------
>   include/linux/cpuhotplug.h  |   2 +-
>   include/linux/dtpm.h        |   3 +-
>   4 files changed, 76 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index c2185ec5f887..1085dccf9c58 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -116,8 +116,6 @@ static void __dtpm_sub_power(struct dtpm *dtpm)
>   		parent->power_limit -= dtpm->power_limit;
>   		parent = parent->parent;
>   	}
> -
> -	__dtpm_rebalance_weight(root);
>   }
>   
>   static void __dtpm_add_power(struct dtpm *dtpm)
> @@ -130,45 +128,45 @@ static void __dtpm_add_power(struct dtpm *dtpm)
>   		parent->power_limit += dtpm->power_limit;
>   		parent = parent->parent;
>   	}
> +}
> +
> +static int __dtpm_update_power(struct dtpm *dtpm)
> +{
> +	int ret;
> +
> +	__dtpm_sub_power(dtpm);
>   
> -	__dtpm_rebalance_weight(root);
> +	ret = dtpm->ops->upt_power_uw(dtpm);
> +	if (ret)
> +		pr_err("Failed to update power for '%s': %d\n",
> +		       dtpm->zone.name, ret);
> +
> +	if (!test_bit(DTPM_POWER_LIMIT_FLAG, &dtpm->flags))
> +		dtpm->power_limit = dtpm->power_max;
> +
> +	__dtpm_add_power(dtpm);
> +
> +	if (root)
> +		__dtpm_rebalance_weight(root);
> +
> +	return ret;
>   }
>   
>   /**
>    * dtpm_update_power - Update the power on the dtpm
>    * @dtpm: a pointer to a dtpm structure to update
> - * @power_min: a u64 representing the new power_min value
> - * @power_max: a u64 representing the new power_max value
>    *
>    * Function to update the power values of the dtpm node specified in
>    * parameter. These new values will be propagated to the tree.
>    *
>    * Return: zero on success, -EINVAL if the values are inconsistent
>    */
> -int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max)
> +int dtpm_update_power(struct dtpm *dtpm)
>   {
> -	int ret = 0;
> +	int ret;
>   
>   	mutex_lock(&dtpm_lock);
> -
> -	if (power_min == dtpm->power_min && power_max == dtpm->power_max)
> -		goto unlock;
> -
> -	if (power_max < power_min) {
> -		ret = -EINVAL;
> -		goto unlock;
> -	}
> -
> -	__dtpm_sub_power(dtpm);
> -
> -	dtpm->power_min = power_min;
> -	dtpm->power_max = power_max;
> -	if (!test_bit(DTPM_POWER_LIMIT_FLAG, &dtpm->flags))
> -		dtpm->power_limit = power_max;
> -
> -	__dtpm_add_power(dtpm);
> -
> -unlock:
> +	ret = __dtpm_update_power(dtpm);
>   	mutex_unlock(&dtpm_lock);
>   
>   	return ret;
> @@ -436,6 +434,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
>   
>   	if (dtpm->ops && !(dtpm->ops->set_power_uw &&
>   			   dtpm->ops->get_power_uw &&
> +			   dtpm->ops->upt_power_uw &&
>   			   dtpm->ops->release))
>   		return -EINVAL;
>   
> @@ -455,7 +454,8 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
>   		root = dtpm;
>   	}
>   
> -	__dtpm_add_power(dtpm);
> +	if (dtpm->ops && !dtpm->ops->upt_power_uw(dtpm))
> +		__dtpm_add_power(dtpm);
>   
>   	pr_info("Registered dtpm node '%s' / %llu-%llu uW, \n",
>   		dtpm->zone.name, dtpm->power_min, dtpm->power_max);
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 51c366938acd..aff79c649345 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -14,6 +14,8 @@
>    * The CPU hotplug is supported and the power numbers will be updated
>    * if a CPU is hot plugged / unplugged.
>    */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>   #include <linux/cpumask.h>
>   #include <linux/cpufreq.h>
>   #include <linux/cpuhotplug.h>
> @@ -23,8 +25,6 @@
>   #include <linux/slab.h>
>   #include <linux/units.h>
>   
> -static struct dtpm *__parent;
> -
>   static DEFINE_PER_CPU(struct dtpm *, dtpm_per_cpu);
>   
>   struct dtpm_cpu {
> @@ -32,57 +32,16 @@ struct dtpm_cpu {
>   	int cpu;
>   };
>   
> -/*
> - * When a new CPU is inserted at hotplug or boot time, add the power
> - * contribution and update the dtpm tree.
> - */
> -static int power_add(struct dtpm *dtpm, struct em_perf_domain *em)
> -{
> -	u64 power_min, power_max;
> -
> -	power_min = em->table[0].power;
> -	power_min *= MICROWATT_PER_MILLIWATT;
> -	power_min += dtpm->power_min;
> -
> -	power_max = em->table[em->nr_perf_states - 1].power;
> -	power_max *= MICROWATT_PER_MILLIWATT;
> -	power_max += dtpm->power_max;
> -
> -	return dtpm_update_power(dtpm, power_min, power_max);
> -}
> -
> -/*
> - * When a CPU is unplugged, remove its power contribution from the
> - * dtpm tree.
> - */
> -static int power_sub(struct dtpm *dtpm, struct em_perf_domain *em)
> -{
> -	u64 power_min, power_max;
> -
> -	power_min = em->table[0].power;
> -	power_min *= MICROWATT_PER_MILLIWATT;
> -	power_min = dtpm->power_min - power_min;
> -
> -	power_max = em->table[em->nr_perf_states - 1].power;
> -	power_max *= MICROWATT_PER_MILLIWATT;
> -	power_max = dtpm->power_max - power_max;
> -
> -	return dtpm_update_power(dtpm, power_min, power_max);
> -}
> -
>   static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>   {
>   	struct dtpm_cpu *dtpm_cpu = dtpm->private;
> -	struct em_perf_domain *pd;
> +	struct em_perf_domain *pd = em_cpu_get(dtpm_cpu->cpu);
>   	struct cpumask cpus;
>   	unsigned long freq;
>   	u64 power;
>   	int i, nr_cpus;
>   
> -	pd = em_cpu_get(dtpm_cpu->cpu);
> -
>   	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
> -
>   	nr_cpus = cpumask_weight(&cpus);
>   
>   	for (i = 0; i < pd->nr_perf_states; i++) {
> @@ -113,6 +72,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>   
>   	pd = em_cpu_get(dtpm_cpu->cpu);
>   	freq = cpufreq_quick_get(dtpm_cpu->cpu);
> +
>   	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
>   	nr_cpus = cpumask_weight(&cpus);
>   
> @@ -128,6 +88,27 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>   	return 0;
>   }
>   
> +static int upt_pd_power_uw(struct dtpm *dtpm)
> +{
> +	struct dtpm_cpu *dtpm_cpu = dtpm->private;
> +	struct em_perf_domain *em = em_cpu_get(dtpm_cpu->cpu);
> +	struct cpumask cpus;

Maybe using cpumask_var_t, allocate and then free is more frendly
for the static analyzies tools, instead of cpumask on stack.
It's in a few places, but should harm platforms which use EM, so
up to you.

> +	int nr_cpus;
> +
> +	cpumask_and(&cpus, cpu_online_mask, to_cpumask(em->cpus));
> +	nr_cpus = cpumask_weight(&cpus);
> +
> +	dtpm->power_min = em->table[0].power;
> +	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
> +	dtpm->power_min *= nr_cpus;
> +
> +	dtpm->power_max = em->table[em->nr_perf_states - 1].power;
> +	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
> +	dtpm->power_max *= nr_cpus;
> +
> +	return 0;
> +}
> +
>   static void pd_release(struct dtpm *dtpm)
>   {
>   	struct dtpm_cpu *dtpm_cpu = dtpm->private;
> @@ -141,37 +122,25 @@ static void pd_release(struct dtpm *dtpm)
>   static struct dtpm_ops dtpm_ops = {
>   	.set_power_uw = set_pd_power_limit,
>   	.get_power_uw = get_pd_power_uw,
> +	.upt_power_uw = upt_pd_power_uw,

I'd just use full names here.

>   	.release = pd_release,
>   };
>   
>   static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
>   {
> -	struct cpufreq_policy *policy;
> +	struct cpumask cpus;

It's not needed, or I'm missing something

>   	struct em_perf_domain *pd;
>   	struct dtpm *dtpm;
>   
> -	policy = cpufreq_cpu_get(cpu);
> -
> -	if (!policy)
> -		return 0;
> -
>   	pd = em_cpu_get(cpu);
>   	if (!pd)
>   		return -EINVAL;
>   
> -	dtpm = per_cpu(dtpm_per_cpu, cpu);
> -
> -	power_sub(dtpm, pd);
> -
> -	if (cpumask_weight(policy->cpus) != 1)
> -		return 0;
> -
> -	for_each_cpu(cpu, policy->related_cpus)
> -		per_cpu(dtpm_per_cpu, cpu) = NULL;
> +	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));

and the same here.

>   
> -	dtpm_unregister(dtpm);
> +	dtpm = per_cpu(dtpm_per_cpu, cpu);
>   
> -	return 0;
> +	return dtpm_update_power(dtpm);
>   }
>   
>   static int cpuhp_dtpm_cpu_online(unsigned int cpu)
> @@ -184,7 +153,6 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>   	int ret = -ENOMEM;
>   
>   	policy = cpufreq_cpu_get(cpu);
> -
>   	if (!policy)
>   		return 0;
>   
> @@ -194,7 +162,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>   
>   	dtpm = per_cpu(dtpm_per_cpu, cpu);
>   	if (dtpm)
> -		return power_add(dtpm, pd);
> +		return dtpm_update_power(dtpm);
>   
>   	dtpm = dtpm_alloc(&dtpm_ops);
>   	if (!dtpm)
> @@ -210,27 +178,20 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>   	for_each_cpu(cpu, policy->related_cpus)
>   		per_cpu(dtpm_per_cpu, cpu) = dtpm;
>   
> -	sprintf(name, "cpu%d", dtpm_cpu->cpu);
> +	sprintf(name, "cpu%d-cpufreq", dtpm_cpu->cpu);
>   
> -	ret = dtpm_register(name, dtpm, __parent);
> +	ret = dtpm_register(name, dtpm, NULL);
>   	if (ret)
>   		goto out_kfree_dtpm_cpu;
>   
> -	ret = power_add(dtpm, pd);
> -	if (ret)
> -		goto out_dtpm_unregister;
> -
>   	ret = freq_qos_add_request(&policy->constraints,
>   				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
>   				   pd->table[pd->nr_perf_states - 1].frequency);
>   	if (ret)
> -		goto out_power_sub;
> +		goto out_dtpm_unregister;
>   
>   	return 0;
>   
> -out_power_sub:
> -	power_sub(dtpm, pd);
> -
>   out_dtpm_unregister:
>   	dtpm_unregister(dtpm);
>   	dtpm_cpu = NULL;
> @@ -248,10 +209,17 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>   
>   int dtpm_register_cpu(struct dtpm *parent)
>   {
> -	__parent = parent;
> +	int ret;
>   
> -	return cpuhp_setup_state(CPUHP_AP_DTPM_CPU_ONLINE,
> -				 "dtpm_cpu:online",
> -				 cpuhp_dtpm_cpu_online,
> -				 cpuhp_dtpm_cpu_offline);
> +	ret = cpuhp_setup_state(CPUHP_AP_DTPM_CPU_DEAD, "dtpm_cpu:offline",
> +				NULL, cpuhp_dtpm_cpu_offline);

Maybe a comment  above this line with description why we need this?

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "dtpm_cpu:online",
> +				cpuhp_dtpm_cpu_online, NULL);

For this, a small comment also wouldn't harm.

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
>   }
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index ee09a39627d6..fcb2967fb5ba 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -61,6 +61,7 @@ enum cpuhp_state {
>   	CPUHP_LUSTRE_CFS_DEAD,
>   	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
>   	CPUHP_PADATA_DEAD,
> +	CPUHP_AP_DTPM_CPU_DEAD,
>   	CPUHP_WORKQUEUE_PREP,
>   	CPUHP_POWER_NUMA_PREPARE,
>   	CPUHP_HRTIMERS_PREPARE,
> @@ -193,7 +194,6 @@ enum cpuhp_state {
>   	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
>   	CPUHP_AP_X86_HPET_ONLINE,
>   	CPUHP_AP_X86_KVM_CLK_ONLINE,
> -	CPUHP_AP_DTPM_CPU_ONLINE,
>   	CPUHP_AP_ACTIVE,
>   	CPUHP_ONLINE,
>   };
> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
> index e80a332e3d8a..d29be6a0e513 100644
> --- a/include/linux/dtpm.h
> +++ b/include/linux/dtpm.h
> @@ -29,6 +29,7 @@ struct dtpm {
>   struct dtpm_ops {
>   	u64 (*set_power_uw)(struct dtpm *, u64);
>   	u64 (*get_power_uw)(struct dtpm *);
> +	int (*upt_power_uw)(struct dtpm *);

IMHO as an API the full name 'update_power_uq' looks better here.

>   	void (*release)(struct dtpm *);
>   };
>   
> @@ -62,7 +63,7 @@ static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
>   	return container_of(zone, struct dtpm, zone);
>   }
>   
> -int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max);
> +int dtpm_update_power(struct dtpm *dtpm);
>   
>   int dtpm_release_zone(struct powercap_zone *pcz);
>   
> 
