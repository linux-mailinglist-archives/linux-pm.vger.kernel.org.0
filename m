Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27B02AD6D5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 13:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgKJMuX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 07:50:23 -0500
Received: from foss.arm.com ([217.140.110.172]:55320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730543AbgKJMuX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 07:50:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7845812FC;
        Tue, 10 Nov 2020 04:50:22 -0800 (PST)
Received: from [10.57.21.178] (unknown [10.57.21.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF59E3F6CF;
        Tue, 10 Nov 2020 04:50:18 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 4/4] powercap/drivers/dtpm: Add CPU energy model based
 support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Price <steven.price@arm.com>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <20201006122024.14539-5-daniel.lezcano@linaro.org>
Message-ID: <8d630cb1-0cf6-b8f3-5ca9-507411030832@arm.com>
Date:   Tue, 10 Nov 2020 12:50:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201006122024.14539-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/6/20 1:20 PM, Daniel Lezcano wrote:
> With the powercap dtpm controller, we are able to plug devices with
> power limitation features in the tree.
> 
> The following patch introduces the CPU power limitation based on the
> energy model and the performance states.
> 
> The power limitation is done at the performance domain level. If some
> CPUs are unplugged, the corresponding power will be substracted from

s/substracted/subtracted


> the performance domain total power.
> 
> It is up to the platform to initialize the dtpm tree and add the CPU.
> 
> Here is an example to create a simple tree with one root node called
> "pkg" and the cpu's performance domains.

s/cpu/CPU to be aligned with previous 'CPU'

> 
> int dtpm_register_pkg(struct dtpm_descr *descr)
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
> struct dtpm_descr descr = {
> 	.name = "pkg",
> 	.init = dtpm_register_pkg,
> };
> DTPM_DECLARE(descr);
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/powercap/Kconfig    |   8 ++
>   drivers/powercap/Makefile   |   1 +
>   drivers/powercap/dtpm_cpu.c | 242 ++++++++++++++++++++++++++++++++++++
>   include/linux/cpuhotplug.h  |   1 +
>   include/linux/dtpm.h        |   3 +
>   5 files changed, 255 insertions(+)
>   create mode 100644 drivers/powercap/dtpm_cpu.c
> 
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index 777cf60300b8..240dc09e8dc2 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -49,4 +49,12 @@ config DTPM
>   	help
>   	  This enables support for the power capping for the dynamic
>   	  thermal management userspace engine.
> +
> +config DTPM_CPU
> +	bool "Add CPU power capping based on the energy model"
> +	depends on DTPM && ENERGY_MODEL
> +	help
> +	  This enables support for CPU power limitation based on
> +	  energy model.
> +
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
> index 000000000000..23ebf704c599
> --- /dev/null
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
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
> +	unsigned long freq;
> +	int i, nr_cpus;
> +
> +	spin_lock(&dtpm->lock);
> +
> +	power_limit = clamp_val(power_limit, dtpm->power_min, dtpm->power_max);
> +
> +	pd = em_cpu_get(dtpm_cpu->cpu);
> +
> +	nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
> +
> +	for (i = 0; i < pd->nr_perf_states; i++) {
> +
> +		u64 power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
> +
> +		if ((power * nr_cpus) > power_limit)
> +			break;
> +	}
> +
> +	freq = pd->table[i - 1].frequency;
> +
> +	freq_qos_update_request(&dtpm_cpu->qos_req, freq);
> +
> +	dtpm->power_limit = power_limit;
> +
> +	spin_unlock(&dtpm->lock);
> +
> +	return 0;
> +}
> +
> +static int get_pd_power_limit(struct powercap_zone *pcz, int cid, u64 *data)
> +{
> +	struct dtpm *dtpm = to_dtpm(pcz);
> +
> +	spin_lock(&dtpm->lock);
> +	*data = dtpm->power_max;
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
> +
> +	return dtpm_release_zone(pcz);

The dtpm_cpu should be freed somewhere, maybe here or below.

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

Is it the right place to call kfree(dtpm_cpu)?

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
> +
> +	dtpm = dtpm_alloc();
> +	if (!dtpm)
> +		return -EINVAL;
> +
> +	dtpm_cpu = kzalloc(sizeof(dtpm_cpu), GFP_KERNEL);

We have to free this dtpm_cpu somewhere.

> +	if (!dtpm_cpu)
> +		return -ENOMEM;
> +
> +	dtpm->private = dtpm_cpu;
> +	dtpm_cpu->cpu = cpu;
> +
> +	for_each_cpu(cpu, policy->related_cpus)
> +		per_cpu(dtpm_per_cpu, cpu) = dtpm;
> +
> +	ret = power_add(dtpm, pd);
> +	if (ret)
> +		return ret;
> +
> +	dtpm->power_limit = dtpm->power_max;
> +
> +	sprintf(name, "cpu%d", dtpm_cpu->cpu);
> +
> +	ret = dtpm_register(name, dtpm, __parent, &pd_zone_ops,
> +			    1, &pd_constraint_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = freq_qos_add_request(&policy->constraints,
> +				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
> +				   pd->table[pd->nr_perf_states - 1].frequency);
> +	return ret;
> +}
> +
> +int dtpm_register_cpu(struct dtpm *parent)
> +{
> +	__parent = parent;
> +
> +	return cpuhp_setup_state(CPUHP_AP_DTPM_CPU_ONLINE,
> +				 "dtpm_cpu:online",
> +				 cpuhp_dtpm_cpu_online,
> +				 cpuhp_dtpm_cpu_offline);

Shouldn't be the DTPM_CPU dependent on HOTPLUG_CPU in Kconfig?
Most of platforms enable it by default, though.

> +}
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index bf9181cef444..6792bad4a435 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -190,6 +190,7 @@ enum cpuhp_state {
>   	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
>   	CPUHP_AP_X86_HPET_ONLINE,
>   	CPUHP_AP_X86_KVM_CLK_ONLINE,
> +	CPUHP_AP_DTPM_CPU_ONLINE,
>   	CPUHP_AP_ACTIVE,
>   	CPUHP_ONLINE,
>   };
> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
> index 6696bdcfdb87..b62215a13baa 100644
> --- a/include/linux/dtpm.h
> +++ b/include/linux/dtpm.h
> @@ -70,4 +70,7 @@ int dtpm_register_parent(const char *name, struct dtpm *dtpm,
>   int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent,
>   		  struct powercap_zone_ops *ops, int nr_constraints,
>   		  struct powercap_zone_constraint_ops *const_ops);
> +
> +int dtpm_register_cpu(struct dtpm *parent);
> +

This function needs a sibling under in #ifdef CONFIG_DTPM_CPU #else.

>   #endif
> 

The code might a few print debugs which helps with experimenting.

In general, it looks good.

Regards,
Lukasz
