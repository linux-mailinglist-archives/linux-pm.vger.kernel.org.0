Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DB62C0EEB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 16:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbgKWPdC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 10:33:02 -0500
Received: from foss.arm.com ([217.140.110.172]:54438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389535AbgKWPdC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Nov 2020 10:33:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4876D1396;
        Mon, 23 Nov 2020 07:33:01 -0800 (PST)
Received: from [10.57.28.98] (unknown [10.57.28.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9A8F3F718;
        Mon, 23 Nov 2020 07:32:58 -0800 (PST)
Subject: Re: [PATCH V3 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>, linux-pm@vger.kernel.org
References: <cover.1605770951.git.viresh.kumar@linaro.org>
 <1fa9994395764ba19cfe6240d8b3c1ce390e8f82.1605770951.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <aefcc0e2-6c13-625a-4367-fe665330c0db@arm.com>
Date:   Mon, 23 Nov 2020 15:32:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1fa9994395764ba19cfe6240d8b3c1ce390e8f82.1605770951.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/19/20 7:38 AM, Viresh Kumar wrote:
> Several parts of the kernel are already using the effective CPU
> utilization (as seen by the scheduler) to get the current load on the
> CPU, do the same here instead of depending on the idle time of the CPU,
> which isn't that accurate comparatively.
> 
> This is also the right thing to do as it makes the cpufreq governor
> (schedutil) align better with the cpufreq_cooling driver, as the power
> requested by cpufreq_cooling governor will exactly match the next
> frequency requested by the schedutil governor since they are both using
> the same metric to calculate load.
> 
> Note that, this (and CPU frequency scaling in general) doesn't work that
> well with idle injection as that is done from rt threads and is counted
> as load while it tries to do quite the opposite. That should be solved
> separately though.
> 
> This was tested on ARM Hikey6220 platform with hackbench, sysbench and
> schbench. None of them showed any regression or significant
> improvements. Schbench is the most important ones out of these as it
> creates the scenario where the utilization numbers provide a better
> estimate of the future.
> 
> Scenario 1: The CPUs were mostly idle in the previous polling window of
> the IPA governor as the tasks were sleeping and here are the details
> from traces (load is in %):
> 
>   Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=203 load={{0x35,0x1,0x0,0x31,0x0,0x0,0x64,0x0}} dynamic_power=1339
>   New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=600 load={{0x60,0x46,0x45,0x45,0x48,0x3b,0x61,0x44}} dynamic_power=3960
> 
> Here, the "Old" line gives the load and requested_power (dynamic_power
> here) numbers calculated using the idle time based implementation, while
> "New" is based on the CPU utilization from scheduler.
> 
> As can be clearly seen, the load and requested_power numbers are simply
> incorrect in the idle time based approach and the numbers collected from
> CPU's utilization are much closer to the reality.
> 
> Scenario 2: The CPUs were busy in the previous polling window of the IPA
> governor:
> 
>   Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=800 load={{0x64,0x64,0x64,0x64,0x64,0x64,0x64,0x64}} dynamic_power=5280
>   New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=708 load={{0x4d,0x5c,0x5c,0x5b,0x5c,0x5c,0x51,0x5b}} dynamic_power=4672
> 
> As can be seen, the idle time based load is 100% for all the CPUs as it
> took only the last window into account, but in reality the CPUs aren't
> that loaded as shown by the utilization numbers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/thermal/cpufreq_cooling.c | 68 ++++++++++++++++++++++++-------
>   1 file changed, 54 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index cc2959f22f01..a364a2fd84b1 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -76,7 +76,9 @@ struct cpufreq_cooling_device {
>   	struct em_perf_domain *em;
>   	struct cpufreq_policy *policy;
>   	struct list_head node;
> +#ifndef CONFIG_SMP
>   	struct time_in_idle *idle_time;
> +#endif
>   	struct freq_qos_request qos_req;
>   };
>   
> @@ -132,14 +134,35 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>   }
>   
>   /**
> - * get_load() - get load for a cpu since last updated
> - * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
> - * @cpu:	cpu number
> - * @cpu_idx:	index of the cpu in time_in_idle*
> + * get_load() - get load for a cpu
> + * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
> + * @cpu: cpu number
> + * @cpu_idx: index of the cpu in time_in_idle array
>    *
>    * Return: The average load of cpu @cpu in percentage since this
>    * function was last called.
>    */
> +#ifdef CONFIG_SMP
> +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> +		    int cpu_idx)
> +{
> +	unsigned long max = arch_scale_cpu_capacity(cpu);
> +	unsigned long util;
> +
> +	util = sched_cpu_util(cpu, ENERGY_UTIL, max);
> +	return (util * 100) / max;
> +}
> +
> +static inline int allocate_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
> +{
> +	return 0;
> +}
> +
> +static inline void free_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
> +{
> +}
> +
> +#else /* !CONFIG_SMP */
>   static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
>   		    int cpu_idx)
>   {
> @@ -162,6 +185,26 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
>   	return load;
>   }
>   
> +static int allocate_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
> +{
> +	unsigned int num_cpus = cpumask_weight(cpufreq_cdev->policy->related_cpus);
> +
> +	cpufreq_cdev->idle_time = kcalloc(num_cpus,
> +					 sizeof(*cpufreq_cdev->idle_time),
> +					 GFP_KERNEL);
> +	if (!cpufreq_cdev->idle_time)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void free_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
> +{
> +	kfree(cpufreq_cdev->idle_time);
> +	cpufreq_cdev->idle_time = NULL;
> +}
> +#endif /* CONFIG_SMP */
> +
>   /**
>    * get_dynamic_power() - calculate the dynamic power
>    * @cpufreq_cdev:	&cpufreq_cooling_device for this cdev
> @@ -487,7 +530,7 @@ __cpufreq_cooling_register(struct device_node *np,
>   	struct thermal_cooling_device *cdev;
>   	struct cpufreq_cooling_device *cpufreq_cdev;
>   	char dev_name[THERMAL_NAME_LENGTH];
> -	unsigned int i, num_cpus;
> +	unsigned int i;
>   	struct device *dev;
>   	int ret;
>   	struct thermal_cooling_device_ops *cooling_ops;
> @@ -498,7 +541,6 @@ __cpufreq_cooling_register(struct device_node *np,
>   		return ERR_PTR(-ENODEV);
>   	}
>   
> -
>   	if (IS_ERR_OR_NULL(policy)) {
>   		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
>   		return ERR_PTR(-EINVAL);
> @@ -516,12 +558,10 @@ __cpufreq_cooling_register(struct device_node *np,
>   		return ERR_PTR(-ENOMEM);
>   
>   	cpufreq_cdev->policy = policy;
> -	num_cpus = cpumask_weight(policy->related_cpus);
> -	cpufreq_cdev->idle_time = kcalloc(num_cpus,
> -					 sizeof(*cpufreq_cdev->idle_time),
> -					 GFP_KERNEL);
> -	if (!cpufreq_cdev->idle_time) {
> -		cdev = ERR_PTR(-ENOMEM);
> +
> +	ret = allocate_idle_time(cpufreq_cdev);
> +	if (ret) {
> +		cdev = ERR_PTR(ret);
>   		goto free_cdev;
>   	}
>   
> @@ -581,7 +621,7 @@ __cpufreq_cooling_register(struct device_node *np,
>   remove_ida:
>   	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
>   free_idle_time:
> -	kfree(cpufreq_cdev->idle_time);
> +	free_idle_time(cpufreq_cdev);
>   free_cdev:
>   	kfree(cpufreq_cdev);
>   	return cdev;
> @@ -674,7 +714,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>   	thermal_cooling_device_unregister(cdev);
>   	freq_qos_remove_request(&cpufreq_cdev->qos_req);
>   	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
> -	kfree(cpufreq_cdev->idle_time);
> +	free_idle_time(cpufreq_cdev);
>   	kfree(cpufreq_cdev);
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
> 


LGTM. It has potential. We will see how far we can improve IPA with this
model.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
