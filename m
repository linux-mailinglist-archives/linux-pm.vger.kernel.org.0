Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE23631ED21
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 18:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhBRRRa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 12:17:30 -0500
Received: from foss.arm.com ([217.140.110.172]:53168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233541AbhBRQiV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Feb 2021 11:38:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0CFED1;
        Thu, 18 Feb 2021 08:35:40 -0800 (PST)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 340213F73D;
        Thu, 18 Feb 2021 08:35:40 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:35:38 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 2/2] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210218163538.GA3105@arm.com>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <59f48538545d080cb1c7b201d2d779ab513d2c0c.1611829953.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f48538545d080cb1c7b201d2d779ab513d2c0c.1611829953.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thursday 28 Jan 2021 at 16:18:56 (+0530), Viresh Kumar wrote:
> The Frequency Invariance Engine (FIE) is providing a frequency scaling
> correction factor that helps achieve more accurate load-tracking.
> 
> Normally, this scaling factor can be obtained directly with the help of
> the cpufreq drivers as they know the exact frequency the hardware is
> running at. But that isn't the case for CPPC cpufreq driver.
> 
> Another way of obtaining that is using the arch specific counter
> support, which is already present in kernel, but that hardware is
> optional for platforms.
> 
> This patch thus obtains this scaling factor using the existing logic
> present in the cppc driver. Note that the arch specific counters have
> higher priority than CPPC counters if available, though the CPPC driver
> doesn't need to have any special handling for that.
> 
> This also exports sched_setattr_nocheck() as the CPPC driver can be
> built as a module.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 179 ++++++++++++++++++++++++++++++---
>  include/linux/arch_topology.h  |   1 +
>  kernel/sched/core.c            |   1 +
>  3 files changed, 169 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 8a482c434ea6..53815f6d2797 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -10,14 +10,18 @@
>  
>  #define pr_fmt(fmt)	"CPPC Cpufreq:"	fmt
>  
> +#include <linux/arch_topology.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/dmi.h>
> +#include <linux/irq_work.h>
> +#include <linux/kthread.h>
>  #include <linux/time.h>
>  #include <linux/vmalloc.h>
> +#include <uapi/linux/sched/types.h>
>  
>  #include <asm/unaligned.h>
>  
> @@ -39,6 +43,17 @@ static LIST_HEAD(cpu_data_list);
>  
>  static bool boost_supported;
>  
> +struct cppc_freq_invariance {
> +	struct kthread_worker *worker;
> +	struct irq_work irq_work;
> +	struct kthread_work work;
> +	struct cppc_perf_fb_ctrs prev_perf_fb_ctrs;
> +	struct cppc_cpudata *cpu_data;
> +	unsigned int max_freq;

You don't really need to store max_freq, actually, as you can (and you
do) use highest_perf directly in the cppc_scale_freq_workfn().

I think in an initial comment I mentioned you should store either
highest_perf or nominal_perf, depending on whether boost is
supported/enabled, but using highest_perf in all cases might be best.

The only difference is when boost is supported but not enabled, which
means the OS's requests will be capped to nominal_perf, but FW/HW
could still give as much as highest_perf. Even if FW/HW never does
exceed nominal_perf, there are mechanisms in the scheduler (after
Vincent's PELT rewrite) that ensure utilization can still reach 1024.

So if you always use highest_perf in cppc_scale_freq_workfn(), you
should not need to store max_freq.

> +};
> +
> +static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_f_i);
> +

nit: I would like s/cppc_f_i/cppc_freq_inv better

>  struct cppc_workaround_oem_info {
>  	char oem_id[ACPI_OEM_ID_SIZE + 1];
>  	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> @@ -292,7 +307,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	unsigned int cpu = policy->cpu;
>  	struct cppc_cpudata *cpu_data;
>  	struct cppc_perf_caps *caps;
> -	int ret;
> +	int ret, i;
>  
>  	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
>  	if (!cpu_data) {
> @@ -343,6 +358,11 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		return -EFAULT;
>  	}
>  
> +	for_each_cpu(i, policy->cpus) {
> +		per_cpu(cppc_f_i, i).max_freq = policy->cpuinfo.max_freq;
> +		per_cpu(cppc_f_i, i).cpu_data = cpu_data;
> +	}
> +
>  	/*
>  	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
>  	 * is supported.
> @@ -370,12 +390,12 @@ static inline u64 get_delta(u64 t1, u64 t0)
>  	return (u32)t1 - (u32)t0;
>  }
>  
> -static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
> -				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
> -				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
> +				 struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +				 struct cppc_perf_fb_ctrs fb_ctrs_t1)
>  {
>  	u64 delta_reference, delta_delivered;
> -	u64 reference_perf, delivered_perf;
> +	u64 reference_perf;
>  
>  	reference_perf = fb_ctrs_t0.reference_perf;
>  
> @@ -385,11 +405,20 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
>  				    fb_ctrs_t0.delivered);
>  
>  	/* Check to avoid divide-by zero */
> -	if (delta_reference || delta_delivered)

This is broken actually, it should have been:

if (delta_reference && delta_delivered)

.. both of them need to be !0 to avoid divide-by 0 and for the
delivered_perf to make sens (!0).

> -		delivered_perf = (reference_perf * delta_delivered) /
> -					delta_reference;
> -	else
> -		delivered_perf = cpu_data->perf_ctrls.desired_perf;
> +	if (!delta_reference && !delta_delivered)
> +		return cpu_data->perf_ctrls.desired_perf;
> +

.. which here turns into:

if (!delta_reference || !delta_delivered)

.. if any is 0, we return desired_perf.

> +	return (reference_perf * delta_delivered) / delta_reference;
> +}
> +
> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +{
> +	u64 delivered_perf;
> +
> +	delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs_t0,
> +					       fb_ctrs_t1);
>  
>  	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>  }
> @@ -420,7 +449,7 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> -	int ret;
> +	int ret, i;
>  
>  	if (!boost_supported) {
>  		pr_err("BOOST not supported by CPU or firmware\n");
> @@ -435,6 +464,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>  						       caps->nominal_perf);
>  	policy->cpuinfo.max_freq = policy->max;
>  
> +	for_each_cpu(i, policy->related_cpus)
> +		per_cpu(cppc_f_i, i).max_freq = policy->cpuinfo.max_freq;
> +
>  	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>  	if (ret < 0)
>  		return ret;
> @@ -512,8 +544,126 @@ static void cppc_check_hisi_workaround(void)
>  	acpi_put_table(tbl);
>  }
>  
> +static void cppc_scale_freq_workfn(struct kthread_work *work)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +	struct cppc_perf_fb_ctrs fb_ctrs = {0};
> +	int cpu = raw_smp_processor_id();
> +	struct cppc_cpudata *cpu_data;
> +	u64 perf;
> +
> +	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
> +	cpu_data = cppc_fi->cpu_data;
> +
> +	if (cppc_get_perf_ctrs(cpu, &fb_ctrs)) {
> +		pr_info("%s: cppc_get_perf_ctrs() failed\n", __func__);
> +		return;
> +	}
> +
> +	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
> +	perf = cppc_perf_from_fbctrs(cpu_data, cppc_fi->prev_perf_fb_ctrs,
> +				     fb_ctrs);
> +
> +	perf <<= SCHED_CAPACITY_SHIFT;
> +	per_cpu(freq_scale, cpu) = div64_u64(perf, cpu_data->perf_caps.highest_perf);

s/per_cpu(freq_scale, cpu)=/this_cpu_write

Let's also cap this to 1024, to be on the safe side.

> +}
> +
> +static void cppc_irq_work(struct irq_work *irq_work)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +
> +	cppc_fi = container_of(irq_work, struct cppc_freq_invariance, irq_work);
> +	kthread_queue_work(cppc_fi->worker, &cppc_fi->work);
> +}
> +
> +static void cppc_scale_freq_tick(void)
> +{
> +	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_f_i, raw_smp_processor_id());
> +

You can use smp_processor_id() here as this is called from interrupt
context.

> +	/*
> +	 * cppc_get_perf_ctrs() can potentially sleep, call that from the right
> +	 * context.
> +	 */
> +	irq_work_queue(&cppc_fi->irq_work);
> +}
> +
> +static struct scale_freq_data cppc_sftd = {
> +	.source = SCALE_FREQ_SOURCE_CPPC,
> +	.set_freq_scale = cppc_scale_freq_tick,
> +};
> +
> +static void cppc_freq_invariance_exit(void)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +	int i;
> +
> +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +		return;
> +
> +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpu_present_mask);
> +
> +	for_each_possible_cpu(i) {
> +		cppc_fi = &per_cpu(cppc_f_i, i);
> +		if (cppc_fi->worker) {
> +			irq_work_sync(&cppc_fi->irq_work);
> +			kthread_destroy_worker(cppc_fi->worker);
> +			cppc_fi->worker = NULL;
> +		}
> +	}
> +}
> +
> +static void __init cppc_freq_invariance_init(void)
> +{
> +	struct cppc_perf_fb_ctrs fb_ctrs = {0};
> +	struct cppc_freq_invariance *cppc_fi;
> +	struct sched_attr attr = {
> +		.size		= sizeof(struct sched_attr),
> +		.sched_policy	= SCHED_DEADLINE,
> +		.sched_nice	= 0,
> +		.sched_priority	= 0,
> +		/*
> +		 * Fake (unused) bandwidth; workaround to "fix"
> +		 * priority inheritance.
> +		 */
> +		.sched_runtime	= 1000000,
> +		.sched_deadline = 10000000,
> +		.sched_period	= 10000000,
> +	};
> +	struct kthread_worker *worker;
> +	int i, ret;
> +
> +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +		return;
> +
> +	for_each_possible_cpu(i) {
> +		cppc_fi = &per_cpu(cppc_f_i, i);
> +
> +		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> +		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
> +		worker = kthread_create_worker_on_cpu(i, 0, "cppc:%d", i);

I keep going back on forth in my mind on whether we need to create the
worker to run the work on each CPU. Because reading CPPC counters should
be possible from any CPU, for any CPU. So as long as we take the CPU ID
on the tick and pass it to the worker, that work does not have to
specifically run on that CPU. Eliminating this restriction could speed up
things.

What do you think?

> +		if (IS_ERR(worker))
> +			return cppc_freq_invariance_exit();
> +
> +		cppc_fi->worker = worker;
> +		ret = sched_setattr_nocheck(worker->task, &attr);
> +		if (ret) {
> +			pr_warn("%s: failed to set SCHED_DEADLINE\n", __func__);
> +			return cppc_freq_invariance_exit();
> +		}
> +
> +		ret = cppc_get_perf_ctrs(i, &fb_ctrs);
> +		if (!ret)
> +			per_cpu(cppc_fi->prev_perf_fb_ctrs, i) = fb_ctrs;

Why do you ignore the error here? If counters are not supported (reading
the registers returns 0, for example), I think it might be best to
cppc_freq_invariance_exit(). If they read 0 and we ignore this, we might
end up doing all that work on the tick without any benefit, as we'd
always use desired_perf instead of a current performance value obtained
from counters.

> +	}
> +
> +	/* Register for freq-invariance */
> +	topology_set_scale_freq_source(&cppc_sftd, cpu_present_mask);
> +}
> +
>  static int __init cppc_cpufreq_init(void)
>  {
> +	int ret;
> +
>  	if ((acpi_disabled) || !acpi_cpc_valid())
>  		return -ENODEV;
>  
> @@ -521,7 +671,11 @@ static int __init cppc_cpufreq_init(void)
>  
>  	cppc_check_hisi_workaround();
>  
> -	return cpufreq_register_driver(&cppc_cpufreq_driver);
> +	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
> +	if (!ret)
> +		cppc_freq_invariance_init();

Should there be a way to disable this? I'm only thinking about the fact
that reading some of these counters could be very expensive, and doing
it for a large number of CPUs, every few ms on the tick, might be a cost
that some platforms might now want to pay for the benefit of having
somewhat more accurate FIE support.

Thanks,
Ionela.

> +
> +	return ret;
>  }
>  
>  static inline void free_cpu_data(void)
> @@ -538,6 +692,7 @@ static inline void free_cpu_data(void)
>  
>  static void __exit cppc_cpufreq_exit(void)
>  {
> +	cppc_freq_invariance_exit();
>  	cpufreq_unregister_driver(&cppc_cpufreq_driver);
>  
>  	free_cpu_data();
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 3bcfba5c21a7..47ac4b41c28d 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -37,6 +37,7 @@ bool topology_scale_freq_invariant(void);
>  enum scale_freq_source {
>  	SCALE_FREQ_SOURCE_CPUFREQ = 0,
>  	SCALE_FREQ_SOURCE_ARCH,
> +	SCALE_FREQ_SOURCE_CPPC,
>  };
>  
>  struct scale_freq_data {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8c5481077c9c..85d1d23951ba 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6190,6 +6190,7 @@ int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
>  {
>  	return __sched_setscheduler(p, attr, false, true);
>  }
> +EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
>  
>  /**
>   * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
