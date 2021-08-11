Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55F33E93B3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 16:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhHKObP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 10:31:15 -0400
Received: from foss.arm.com ([217.140.110.172]:52068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232417AbhHKObP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Aug 2021 10:31:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 737AA1063;
        Wed, 11 Aug 2021 07:30:51 -0700 (PDT)
Received: from [10.57.12.152] (unknown [10.57.12.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01FAE3F718;
        Wed, 11 Aug 2021 07:30:49 -0700 (PDT)
Subject: Re: [PATCH V2 1/9] cpufreq: Auto-register with energy model if asked
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1628682874.git.viresh.kumar@linaro.org>
 <9ca302a02d6b51240af8668634c93972183b593f.1628682874.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <253884df-8504-c936-3692-df4997a97713@arm.com>
Date:   Wed, 11 Aug 2021 15:30:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9ca302a02d6b51240af8668634c93972183b593f.1628682874.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/11/21 12:58 PM, Viresh Kumar wrote:
> Many cpufreq drivers register with the energy model for each policy and
> do exactly the same thing. Follow the footsteps of thermal-cooling, to
> get it done from the cpufreq core itself.
> 
> Provide a new callback, which will be called, if present, by the cpufreq
> core at the right moment (more on that in the code's comment). Also
> provide a generic implementation that uses dev_pm_opp_of_register_em().
> 
> This also allows us to register with the EM at a later point of time,
> compared to ->init(), from where the EM core can access cpufreq policy
> directly using cpufreq_cpu_get() type of helpers and perform other work,
> like marking few frequencies inefficient, this will be done separately.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 12 ++++++++++++
>   include/linux/cpufreq.h   | 14 ++++++++++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 06c526d66dd3..75974e7d6cc5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1493,6 +1493,18 @@ static int cpufreq_online(unsigned int cpu)
>   		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   	}
>   
> +	/*
> +	 * Register with the energy model before sched_cpufreq_governor_change()
> +	 * is called, which will result in rebuilding of the sched domains,
> +	 * which should only be done once the energy model is properly
> +	 * initialized for the policy first.
> +	 *
> +	 * Also, this should be called before the policy is registered with
> +	 * cooling framework.
> +	 */
> +	if (cpufreq_driver->register_em)
> +		cpufreq_driver->register_em(policy);
> +
>   	ret = cpufreq_init_policy(policy);
>   	if (ret) {
>   		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9fd719475fcd..1295621f6c28 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -9,10 +9,12 @@
>   #define _LINUX_CPUFREQ_H
>   
>   #include <linux/clk.h>
> +#include <linux/cpu.h>
>   #include <linux/cpumask.h>
>   #include <linux/completion.h>
>   #include <linux/kobject.h>
>   #include <linux/notifier.h>
> +#include <linux/pm_opp.h>
>   #include <linux/pm_qos.h>
>   #include <linux/spinlock.h>
>   #include <linux/sysfs.h>
> @@ -373,6 +375,12 @@ struct cpufreq_driver {
>   	/* platform specific boost support code */
>   	bool		boost_enabled;
>   	int		(*set_boost)(struct cpufreq_policy *policy, int state);
> +
> +	/*
> +	 * Set by drivers that want the core to automatically register the
> +	 * policy's devices with Energy Model.

It covers one use case. I would add also something about customized EM
setup, which might be provided by drivers and implemented then in this
callback. It won't be only for automatic registration.


> +	 */
> +	void		(*register_em)(struct cpufreq_policy *policy);
>   };
>   
>   /* flags */
> @@ -1046,4 +1054,10 @@ unsigned int cpufreq_generic_get(unsigned int cpu);
>   void cpufreq_generic_init(struct cpufreq_policy *policy,
>   		struct cpufreq_frequency_table *table,
>   		unsigned int transition_latency);
> +
> +static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
> +{
> +	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
> +				  policy->related_cpus);
> +}
>   #endif /* _LINUX_CPUFREQ_H */
> 

There rest is OK,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
