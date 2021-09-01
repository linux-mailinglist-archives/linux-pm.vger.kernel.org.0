Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F53FD5A5
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbhIAIeS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 04:34:18 -0400
Received: from foss.arm.com ([217.140.110.172]:34074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243502AbhIAIeD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Sep 2021 04:34:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 234D51FB;
        Wed,  1 Sep 2021 01:33:06 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 168603F5A1;
        Wed,  1 Sep 2021 01:33:04 -0700 (PDT)
Date:   Wed, 1 Sep 2021 09:32:59 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, lukasz.luba@arm.com,
        Quentin Perret <qperret@google.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/9] cpufreq: Add callback to register with energy
 model
Message-ID: <20210901083240.GA326977@e120877-lin.cambridge.arm.com>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
 <c17495b01b72b53bd290f442d39b060e015c7aea.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c17495b01b72b53bd290f442d39b060e015c7aea.1628742634.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 12, 2021 at 10:05:14AM +0530, Viresh Kumar wrote:
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
> Reviewed-by: Quentin Perret <qperret@google.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
>  include/linux/cpufreq.h   | 14 ++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 45f3416988f1..d301f39248a0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1491,6 +1491,19 @@ static int cpufreq_online(unsigned int cpu)
>  		write_lock_irqsave(&cpufreq_driver_lock, flags);
>  		list_add(&policy->policy_list, &cpufreq_policy_list);
>  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +
> +		/*
> +		 * Register with the energy model before
> +		 * sched_cpufreq_governor_change() is called, which will result
> +		 * in rebuilding of the sched domains, which should only be done
> +		 * once the energy model is properly initialized for the policy
> +		 * first.
> +		 *
> +		 * Also, this should be called before the policy is registered
> +		 * with cooling framework.
> +		 */
> +		if (cpufreq_driver->register_em)
> +			cpufreq_driver->register_em(policy);
>  	}
>  
>  	ret = cpufreq_init_policy(policy);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9fd719475fcd..c65a1d7385f8 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -9,10 +9,12 @@
>  #define _LINUX_CPUFREQ_H
>  
>  #include <linux/clk.h>
> +#include <linux/cpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/completion.h>
>  #include <linux/kobject.h>
>  #include <linux/notifier.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_qos.h>
>  #include <linux/spinlock.h>
>  #include <linux/sysfs.h>
> @@ -373,6 +375,12 @@ struct cpufreq_driver {
>  	/* platform specific boost support code */
>  	bool		boost_enabled;
>  	int		(*set_boost)(struct cpufreq_policy *policy, int state);
> +
> +	/*
> +	 * Set by drivers that want to register with the energy model after the
> +	 * policy is properly initialized, but before the governor is started.
> +	 */
> +	void		(*register_em)(struct cpufreq_policy *policy);
>  };
>  
>  /* flags */
> @@ -1046,4 +1054,10 @@ unsigned int cpufreq_generic_get(unsigned int cpu);
>  void cpufreq_generic_init(struct cpufreq_policy *policy,
>  		struct cpufreq_frequency_table *table,
>  		unsigned int transition_latency);
> +
> +static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
> +{
> +	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
> +				  policy->related_cpus);
> +}
>  #endif /* _LINUX_CPUFREQ_H */
> -- 
> 2.31.1.272.g89b43f80a514
> 

Tested on Hikey960 while working on the inefficient OPPs support.

Tested-by: Vincent Donnefort <vincent.donnefort@arm.com>
