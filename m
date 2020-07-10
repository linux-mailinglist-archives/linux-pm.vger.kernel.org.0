Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441B221B495
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 14:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgGJMBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 08:01:30 -0400
Received: from foss.arm.com ([217.140.110.172]:42150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgGJMB2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 08:01:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18297C0A;
        Fri, 10 Jul 2020 05:01:27 -0700 (PDT)
Received: from [10.37.12.58] (unknown [10.37.12.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DABCC3F887;
        Fri, 10 Jul 2020 05:01:23 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] cpuidle: psci: Fix error path via converting to a
 platform driver
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200707125804.13030-1-ulf.hansson@linaro.org>
 <20200707125804.13030-4-ulf.hansson@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <aa3e7d75-c54d-bb81-bd5c-a6f0aaf441c5@arm.com>
Date:   Fri, 10 Jul 2020 13:01:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200707125804.13030-4-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,


On 7/7/20 1:58 PM, Ulf Hansson wrote:
> The current error paths for the cpuidle-psci driver, may leak memory or
> possibly leave CPU devices attached to their PM domains. These are quite
> harmless issues, but still deserves to be taken care of.
> 
> Although, rather than fixing them by keeping track of allocations that
> needs to be freed, which tends to become a bit messy, let's convert into a
> platform driver. In this way, it gets easier to fix the memory leaks as we
> can rely on the devm_* functions.
> 
> Moreover, converting to a platform driver also enables support for deferred
> probe, which subsequent changes takes benefit from.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks good to me.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz


> ---
>   drivers/cpuidle/cpuidle-psci-domain.c |  10 +-
>   drivers/cpuidle/cpuidle-psci.c        | 141 +++++++++++++++-----------
>   drivers/cpuidle/cpuidle-psci.h        |   9 +-
>   3 files changed, 95 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index f07786aad673..e48e578aaa7d 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -287,7 +287,7 @@ static int __init psci_idle_init_domains(void)
>   }
>   subsys_initcall(psci_idle_init_domains);
>   
> -struct device __init *psci_dt_attach_cpu(int cpu)
> +struct device *psci_dt_attach_cpu(int cpu)
>   {
>   	struct device *dev;
>   
> @@ -301,3 +301,11 @@ struct device __init *psci_dt_attach_cpu(int cpu)
>   
>   	return dev;
>   }
> +
> +void psci_dt_detach_cpu(struct device *dev)
> +{
> +	if (IS_ERR_OR_NULL(dev))
> +		return;
> +
> +	dev_pm_domain_detach(dev, false);
> +}
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 3806f911b61c..74463841805f 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -17,9 +17,11 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
> +#include <linux/platform_device.h>
>   #include <linux/psci.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/slab.h>
> +#include <linux/string.h>
>   
>   #include <asm/cpuidle.h>
>   
> @@ -33,7 +35,7 @@ struct psci_cpuidle_data {
>   
>   static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
>   static DEFINE_PER_CPU(u32, domain_state);
> -static bool psci_cpuidle_use_cpuhp __initdata;
> +static bool psci_cpuidle_use_cpuhp;
>   
>   void psci_set_domain_state(u32 state)
>   {
> @@ -104,7 +106,7 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
>   	return 0;
>   }
>   
> -static void __init psci_idle_init_cpuhp(void)
> +static void psci_idle_init_cpuhp(void)
>   {
>   	int err;
>   
> @@ -127,30 +129,13 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
>   	return psci_enter_state(idx, state[idx]);
>   }
>   
> -static struct cpuidle_driver psci_idle_driver __initdata = {
> -	.name = "psci_idle",
> -	.owner = THIS_MODULE,
> -	/*
> -	 * PSCI idle states relies on architectural WFI to
> -	 * be represented as state index 0.
> -	 */
> -	.states[0] = {
> -		.enter                  = psci_enter_idle_state,
> -		.exit_latency           = 1,
> -		.target_residency       = 1,
> -		.power_usage		= UINT_MAX,
> -		.name                   = "WFI",
> -		.desc                   = "ARM WFI",
> -	}
> -};
> -
> -static const struct of_device_id psci_idle_state_match[] __initconst = {
> +static const struct of_device_id psci_idle_state_match[] = {
>   	{ .compatible = "arm,idle-state",
>   	  .data = psci_enter_idle_state },
>   	{ },
>   };
>   
> -int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
> +int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>   {
>   	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
>   
> @@ -167,9 +152,9 @@ int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
>   	return 0;
>   }
>   
> -static int __init psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
> -					    struct psci_cpuidle_data *data,
> -					    unsigned int state_count, int cpu)
> +static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
> +				     struct psci_cpuidle_data *data,
> +				     unsigned int state_count, int cpu)
>   {
>   	/* Currently limit the hierarchical topology to be used in OSI mode. */
>   	if (!psci_has_osi_support())
> @@ -190,9 +175,9 @@ static int __init psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
>   	return 0;
>   }
>   
> -static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> -					struct device_node *cpu_node,
> -					unsigned int state_count, int cpu)
> +static int psci_dt_cpu_init_idle(struct device *dev, struct cpuidle_driver *drv,
> +				 struct device_node *cpu_node,
> +				 unsigned int state_count, int cpu)
>   {
>   	int i, ret = 0;
>   	u32 *psci_states;
> @@ -200,7 +185,8 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>   	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
>   
>   	state_count++; /* Add WFI state too */
> -	psci_states = kcalloc(state_count, sizeof(*psci_states), GFP_KERNEL);
> +	psci_states = devm_kcalloc(dev, state_count, sizeof(*psci_states),
> +				   GFP_KERNEL);
>   	if (!psci_states)
>   		return -ENOMEM;
>   
> @@ -213,32 +199,26 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>   		of_node_put(state_node);
>   
>   		if (ret)
> -			goto free_mem;
> +			return ret;
>   
>   		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
>   	}
>   
> -	if (i != state_count) {
> -		ret = -ENODEV;
> -		goto free_mem;
> -	}
> +	if (i != state_count)
> +		return -ENODEV;
>   
>   	/* Initialize optional data, used for the hierarchical topology. */
>   	ret = psci_dt_cpu_init_topology(drv, data, state_count, cpu);
>   	if (ret < 0)
> -		goto free_mem;
> +		return ret;
>   
>   	/* Idle states parsed correctly, store them in the per-cpu struct. */
>   	data->psci_states = psci_states;
>   	return 0;
> -
> -free_mem:
> -	kfree(psci_states);
> -	return ret;
>   }
>   
> -static __init int psci_cpu_init_idle(struct cpuidle_driver *drv,
> -				     unsigned int cpu, unsigned int state_count)
> +static int psci_cpu_init_idle(struct device *dev, struct cpuidle_driver *drv,
> +			      unsigned int cpu, unsigned int state_count)
>   {
>   	struct device_node *cpu_node;
>   	int ret;
> @@ -254,14 +234,22 @@ static __init int psci_cpu_init_idle(struct cpuidle_driver *drv,
>   	if (!cpu_node)
>   		return -ENODEV;
>   
> -	ret = psci_dt_cpu_init_idle(drv, cpu_node, state_count, cpu);
> +	ret = psci_dt_cpu_init_idle(dev, drv, cpu_node, state_count, cpu);
>   
>   	of_node_put(cpu_node);
>   
>   	return ret;
>   }
>   
> -static int __init psci_idle_init_cpu(int cpu)
> +static void psci_cpu_deinit_idle(int cpu)
> +{
> +	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
> +
> +	psci_dt_detach_cpu(data->dev);
> +	psci_cpuidle_use_cpuhp = false;
> +}
> +
> +static int psci_idle_init_cpu(struct device *dev, int cpu)
>   {
>   	struct cpuidle_driver *drv;
>   	struct device_node *cpu_node;
> @@ -284,17 +272,26 @@ static int __init psci_idle_init_cpu(int cpu)
>   	if (ret)
>   		return ret;
>   
> -	drv = kmemdup(&psci_idle_driver, sizeof(*drv), GFP_KERNEL);
> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
>   	if (!drv)
>   		return -ENOMEM;
>   
> +	drv->name = "psci_idle";
> +	drv->owner = THIS_MODULE;
>   	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
>   
>   	/*
> -	 * Initialize idle states data, starting at index 1, since
> -	 * by default idle state 0 is the quiescent state reached
> -	 * by the cpu by executing the wfi instruction.
> -	 *
> +	 * PSCI idle states relies on architectural WFI to be represented as
> +	 * state index 0.
> +	 */
> +	drv->states[0].enter = psci_enter_idle_state;
> +	drv->states[0].exit_latency = 1;
> +	drv->states[0].target_residency = 1;
> +	drv->states[0].power_usage = UINT_MAX;
> +	strcpy(drv->states[0].name, "WFI");
> +	strcpy(drv->states[0].desc, "ARM WFI");
> +
> +	/*
>   	 * If no DT idle states are detected (ret == 0) let the driver
>   	 * initialization fail accordingly since there is no reason to
>   	 * initialize the idle driver if only wfi is supported, the
> @@ -302,48 +299,45 @@ static int __init psci_idle_init_cpu(int cpu)
>   	 * on idle entry.
>   	 */
>   	ret = dt_init_idle_driver(drv, psci_idle_state_match, 1);
> -	if (ret <= 0) {
> -		ret = ret ? : -ENODEV;
> -		goto out_kfree_drv;
> -	}
> +	if (ret <= 0)
> +		return ret ? : -ENODEV;
>   
>   	/*
>   	 * Initialize PSCI idle states.
>   	 */
> -	ret = psci_cpu_init_idle(drv, cpu, ret);
> +	ret = psci_cpu_init_idle(dev, drv, cpu, ret);
>   	if (ret) {
>   		pr_err("CPU %d failed to PSCI idle\n", cpu);
> -		goto out_kfree_drv;
> +		return ret;
>   	}
>   
>   	ret = cpuidle_register(drv, NULL);
>   	if (ret)
> -		goto out_kfree_drv;
> +		goto deinit;
>   
>   	cpuidle_cooling_register(drv);
>   
>   	return 0;
> -
> -out_kfree_drv:
> -	kfree(drv);
> +deinit:
> +	psci_cpu_deinit_idle(cpu);
>   	return ret;
>   }
>   
>   /*
> - * psci_idle_init - Initializes PSCI cpuidle driver
> + * psci_idle_probe - Initializes PSCI cpuidle driver
>    *
>    * Initializes PSCI cpuidle driver for all CPUs, if any CPU fails
>    * to register cpuidle driver then rollback to cancel all CPUs
>    * registration.
>    */
> -static int __init psci_idle_init(void)
> +static int psci_cpuidle_probe(struct platform_device *pdev)
>   {
>   	int cpu, ret;
>   	struct cpuidle_driver *drv;
>   	struct cpuidle_device *dev;
>   
>   	for_each_possible_cpu(cpu) {
> -		ret = psci_idle_init_cpu(cpu);
> +		ret = psci_idle_init_cpu(&pdev->dev, cpu);
>   		if (ret)
>   			goto out_fail;
>   	}
> @@ -356,9 +350,34 @@ static int __init psci_idle_init(void)
>   		dev = per_cpu(cpuidle_devices, cpu);
>   		drv = cpuidle_get_cpu_driver(dev);
>   		cpuidle_unregister(drv);
> -		kfree(drv);
> +		psci_cpu_deinit_idle(cpu);
>   	}
>   
>   	return ret;
>   }
> +
> +static struct platform_driver psci_cpuidle_driver = {
> +	.probe = psci_cpuidle_probe,
> +	.driver = {
> +		.name = "psci-cpuidle",
> +	},
> +};
> +
> +static int __init psci_idle_init(void)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	ret = platform_driver_register(&psci_cpuidle_driver);
> +	if (ret)
> +		return ret;
> +
> +	pdev = platform_device_register_simple("psci-cpuidle", -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		platform_driver_unregister(&psci_cpuidle_driver);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
>   device_initcall(psci_idle_init);
> diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
> index ac8170684d4f..d8e925e84c27 100644
> --- a/drivers/cpuidle/cpuidle-psci.h
> +++ b/drivers/cpuidle/cpuidle-psci.h
> @@ -3,15 +3,18 @@
>   #ifndef __CPUIDLE_PSCI_H
>   #define __CPUIDLE_PSCI_H
>   
> +struct device;
>   struct device_node;
>   
>   void psci_set_domain_state(u32 state);
> -int __init psci_dt_parse_state_node(struct device_node *np, u32 *state);
> +int psci_dt_parse_state_node(struct device_node *np, u32 *state);
>   
>   #ifdef CONFIG_ARM_PSCI_CPUIDLE_DOMAIN
> -struct device __init *psci_dt_attach_cpu(int cpu);
> +struct device *psci_dt_attach_cpu(int cpu);
> +void psci_dt_detach_cpu(struct device *dev);
>   #else
> -static inline struct device __init *psci_dt_attach_cpu(int cpu) { return NULL; }
> +static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
> +static inline void psci_dt_detach_cpu(struct device *dev) { }
>   #endif
>   
>   #endif /* __CPUIDLE_PSCI_H */
> 
