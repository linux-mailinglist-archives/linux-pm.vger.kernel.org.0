Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75D22B65C7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 15:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgKQNQw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 08:16:52 -0500
Received: from foss.arm.com ([217.140.110.172]:56676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbgKQNQB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 08:16:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 854AA101E;
        Tue, 17 Nov 2020 05:16:00 -0800 (PST)
Received: from [10.57.25.49] (unknown [10.57.25.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C0C63F719;
        Tue, 17 Nov 2020 05:15:58 -0800 (PST)
Subject: Re: [PATCH v2 4/4] powercap/drivers/dtpm: Add CPU energy model based
 support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, ilina@codeaurora.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rkumbako@codeaurora.org,
        rui.zhang@intel.com
References: <20201116152649.11482-1-daniel.lezcano@linaro.org>
 <20201116152649.11482-5-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c467cb4d-2226-e558-e340-cd5764490078@arm.com>
Date:   Tue, 17 Nov 2020 13:15:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201116152649.11482-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Only one small comment regarding the setup of 'power_limit'.

On 11/16/20 3:26 PM, Daniel Lezcano wrote:
> With the powercap dtpm controller, we are able to plug devices with
> power limitation features in the tree.
> 
> The following patch introduces the CPU power limitation based on the
> energy model and the performance states.
> 
> The power limitation is done at the performance domain level. If some
> CPUs are unplugged, the corresponding power will be subtracted from
> the performance domain total power.
> 
> It is up to the platform to initialize the dtpm tree and add the CPU.
> 
> Here is an example to create a simple tree with one root node called
> "pkg" and the CPU's performance domains.
> 
> static int dtpm_register_pkg(struct dtpm_descr *descr)
> {
> 	struct dtpm *pkg;
> 	int ret;
> 
> 	pkg = dtpm_alloc();
> 	if (!pkg)
> 		return -ENOMEM;
> 
> 	ret = dtpm_register_parent(descr->name, pkg, descr->parent);
> 	if (ret)
> 		return ret;
> 
> 	return dtpm_register_cpu(pkg);
> }
> 
> static struct dtpm_descr descr = {
> 	.name = "pkg",
> 	.init = dtpm_register_pkg,
> };
> DTPM_DECLARE(descr);
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/powercap/Kconfig    |   7 +
>   drivers/powercap/Makefile   |   1 +
>   drivers/powercap/dtpm_cpu.c | 282 ++++++++++++++++++++++++++++++++++++
>   include/linux/cpuhotplug.h  |   1 +
>   include/linux/dtpm.h        |   3 +
>   5 files changed, 294 insertions(+)
>   create mode 100644 drivers/powercap/dtpm_cpu.c
> 
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index cc1953bd8bed..20b4325c6161 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -49,4 +49,11 @@ config DTPM
>   	help
>   	  This enables support for the power capping for the dynamic
>   	  thermal power management userspace engine.
> +
> +config DTPM_CPU
> +	bool "Add CPU power capping based on the energy model"
> +	depends on DTPM && ENERGY_MODEL
> +	help
> +	  This enables support for CPU power limitation based on
> +	  energy model.
>   endif
> diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
> index 6482ac52054d..fabcf388a8d3 100644
> --- a/drivers/powercap/Makefile
> +++ b/drivers/powercap/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_DTPM) += dtpm.o
> +obj-$(CONFIG_DTPM_CPU) += dtpm_cpu.o
>   obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
>   obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
>   obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> new file mode 100644
> index 000000000000..6bff5f27d891
> --- /dev/null
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * The DTPM CPU is based on the energy model. It hooks the CPU in the
> + * DTPM tree which in turns update the power number by propagating the
> + * power number from the CPU energy model information to the parents.
> + *
> + * The association between the power and the performance state, allows
> + * to set the power of the CPU at the OPP granularity.
> + *
> + * The CPU hotplug is supported and the power numbers will be updated
> + * if a CPU is hot plugged / unplugged.
> + */
> +#include <linux/cpumask.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/dtpm.h>
> +#include <linux/energy_model.h>
> +#include <linux/pm_qos.h>
> +#include <linux/slab.h>
> +#include <linux/units.h>
> +
> +static struct dtpm *__parent;
> +
> +static DEFINE_PER_CPU(struct dtpm *, dtpm_per_cpu);
> +
> +struct dtpm_cpu {
> +	struct freq_qos_request qos_req;
> +	int cpu;
> +};
> +
> +/*
> + * When a new CPU is inserted at hotplug or boot time, add the power
> + * contribution and update the dtpm tree.
> + */
> +static int power_add(struct dtpm *dtpm, struct em_perf_domain *em)
> +{
> +	u64 power_min, power_max;
> +
> +	power_min = em->table[0].power;
> +	power_min *= MICROWATT_PER_MILLIWATT;
> +	power_min += dtpm->power_min;
> +
> +	power_max = em->table[em->nr_perf_states - 1].power;
> +	power_max *= MICROWATT_PER_MILLIWATT;
> +	power_max += dtpm->power_max;
> +
> +	return dtpm_update_power(dtpm, power_min, power_max);
> +}
> +
> +/*
> + * When a CPU is unplugged, remove its power contribution from the
> + * dtpm tree.
> + */
> +static int power_sub(struct dtpm *dtpm, struct em_perf_domain *em)
> +{
> +	u64 power_min, power_max;
> +
> +	power_min = em->table[0].power;
> +	power_min *= MICROWATT_PER_MILLIWATT;
> +	power_min = dtpm->power_min - power_min;
> +
> +	power_max = em->table[em->nr_perf_states - 1].power;
> +	power_max *= MICROWATT_PER_MILLIWATT;
> +	power_max = dtpm->power_max - power_max;
> +
> +	return dtpm_update_power(dtpm, power_min, power_max);
> +}
> +
> +static int set_pd_power_limit(struct powercap_zone *pcz, int cid,
> +			      u64 power_limit)
> +{
> +	struct dtpm *dtpm = to_dtpm(pcz);
> +	struct dtpm_cpu *dtpm_cpu = dtpm->private;
> +	struct em_perf_domain *pd;
> +	struct cpumask cpus;
> +	unsigned long freq;
> +	u64 power;
> +	int i, nr_cpus;
> +
> +	spin_lock(&dtpm->lock);
> +
> +	power_limit = clamp_val(power_limit, dtpm->power_min, dtpm->power_max);
> +
> +	pd = em_cpu_get(dtpm_cpu->cpu);
> +
> +	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
> +
> +	nr_cpus = cpumask_weight(&cpus);
> +
> +	for (i = 0; i < pd->nr_perf_states; i++) {
> +
> +		power = pd->table[i].power * MICROWATT_PER_MILLIWATT * nr_cpus;
> +
> +		if (power > power_limit)
> +			break;
> +	}
> +
> +	freq = pd->table[i - 1].frequency;
> +
> +	dtpm->power_limit = pd->table[i - 1].power *
> +		MICROWATT_PER_MILLIWATT * nr_cpus;
> +
> +	spin_unlock(&dtpm->lock);
> +
> +	freq_qos_update_request(&dtpm_cpu->qos_req, freq);
> +
> +	return 0;
> +}
> +
> +static int get_pd_power_limit(struct powercap_zone *pcz, int cid, u64 *data)
> +{
> +	struct dtpm *dtpm = to_dtpm(pcz);
> +
> +	spin_lock(&dtpm->lock);
> +	*data = dtpm->power_limit;
> +	spin_unlock(&dtpm->lock);
> +
> +	return 0;
> +}
> +
> +static int get_pd_power_uw(struct powercap_zone *pcz, u64 *power_uw)
> +{
> +	struct dtpm *dtpm = to_dtpm(pcz);
> +	struct dtpm_cpu *dtpm_cpu = dtpm->private;
> +	struct em_perf_domain *pd;
> +	unsigned long freq;
> +	int i, nr_cpus;
> +
> +	freq = cpufreq_quick_get(dtpm_cpu->cpu);
> +	pd = em_cpu_get(dtpm_cpu->cpu);
> +	nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
> +
> +	for (i = 0; i < pd->nr_perf_states; i++) {
> +
> +		if (pd->table[i].frequency < freq)
> +			continue;
> +
> +		*power_uw = pd->table[i].power *
> +			MICROWATT_PER_MILLIWATT * nr_cpus;
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int cpu_release_zone(struct powercap_zone *pcz)
> +{
> +	struct dtpm *dtpm = to_dtpm(pcz);
> +	struct dtpm_cpu *dtpm_cpu = dtpm->private;
> +
> +	freq_qos_remove_request(&dtpm_cpu->qos_req);
> +	kfree(dtpm_cpu);
> +
> +	return dtpm_release_zone(pcz);
> +}
> +
> +static struct powercap_zone_constraint_ops pd_constraint_ops = {
> +	.set_power_limit_uw = set_pd_power_limit,
> +	.get_power_limit_uw = get_pd_power_limit,
> +};
> +
> +static struct powercap_zone_ops pd_zone_ops = {
> +	.get_power_uw = get_pd_power_uw,
> +	.release = cpu_release_zone,
> +};
> +
> +static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy;
> +	struct em_perf_domain *pd;
> +	struct dtpm *dtpm;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +
> +	if (!policy)
> +		return 0;
> +
> +	pd = em_cpu_get(cpu);
> +	if (!pd)
> +		return -EINVAL;
> +
> +	dtpm = per_cpu(dtpm_per_cpu, cpu);
> +
> +	power_sub(dtpm, pd);
> +
> +	if (cpumask_weight(policy->cpus) != 1)
> +		return 0;
> +
> +	for_each_cpu(cpu, policy->related_cpus)
> +		per_cpu(dtpm_per_cpu, cpu) = NULL;
> +
> +	dtpm_unregister(dtpm);
> +
> +	return 0;
> +}
> +
> +static int cpuhp_dtpm_cpu_online(unsigned int cpu)
> +{
> +        struct dtpm *dtpm;
> +	struct dtpm_cpu *dtpm_cpu;
> +	struct cpufreq_policy *policy;
> +	struct em_perf_domain *pd;
> +	char name[CPUFREQ_NAME_LEN];
> +	int ret;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +
> +	if (!policy)
> +		return 0;
> +
> +	pd = em_cpu_get(cpu);
> +	if (!pd)
> +		return -EINVAL;
> +
> +	dtpm = per_cpu(dtpm_per_cpu, cpu);
> +	if (dtpm)
> +		return power_add(dtpm, pd);

The dtpm->power_limit is not incremented in this path, when a new
CPU joins the cluster.
Is it correct?

Or maybe we need something like:
------------------------------>8---------------------
         if (dtpm) {
                 ret = power_add(dtpm, pd);
                 if (!ret)
                         dtpm->power_limit = dtpm->power_max;
                 return ret;
         }
------------------------8<---------------

The power_max should be updated after successful power_add().
It would disturb user set value in power_limit, though (described
below).


> +
> +	dtpm = dtpm_alloc();
> +	if (!dtpm)
> +		return -EINVAL;
> +
> +	dtpm_cpu = kzalloc(sizeof(dtpm_cpu), GFP_KERNEL);
> +	if (!dtpm_cpu) {
> +		kfree(dtpm);
> +		return -ENOMEM;
> +	}
> +
> +	dtpm->private = dtpm_cpu;
> +	dtpm_cpu->cpu = cpu;
> +
> +	for_each_cpu(cpu, policy->related_cpus)
> +		per_cpu(dtpm_per_cpu, cpu) = dtpm;
> +
> +	ret = power_add(dtpm, pd);
> +	if (ret)
> +		goto out_kfree_dtpm_cpu;
> +
> +	dtpm->power_limit = dtpm->power_max;

Here, the power_limit will be set only once with power_max
for a single CPU. I am not sure, but maybe we can simple say:

dtpm->power_limit = dtpm->power_max * cpumask_weight(policy->related_cpus)

an avoid touching it later (?)

Because this function can be called in runtime, when the power_limit
was already set by userspace, the hotpluging in/out/in... CPU shouldn't
change this limit.

Regards,
Lukasz
