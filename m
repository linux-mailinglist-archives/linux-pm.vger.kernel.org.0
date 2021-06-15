Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6D53A8404
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFOPdy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 11:33:54 -0400
Received: from foss.arm.com ([217.140.110.172]:38476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhFOPdy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Jun 2021 11:33:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1B8713A1;
        Tue, 15 Jun 2021 08:31:49 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B8203F70D;
        Tue, 15 Jun 2021 08:31:46 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        qperret@google.com, vincent.donnefort@arm.com,
        Beata.Michalska@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com, thara.gopinath@linaro.org,
        amit.kachhap@gmail.com, amitk@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org
References: <20210614185815.15136-1-lukasz.luba@arm.com>
 <20210614191128.22735-1-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <237ef538-c8ca-a103-b2cc-240fc70298fe@arm.com>
Date:   Tue, 15 Jun 2021 17:31:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210614191128.22735-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/06/2021 21:11, Lukasz Luba wrote:
> Energy Aware Scheduling (EAS) needs to be able to predict the frequency
> requests made by the SchedUtil governor to properly estimate energy used
> in the future. It has to take into account CPUs utilization and forecast
> Performance Domain (PD) frequency. There is a corner case when the max
> allowed frequency might be reduced due to thermal. SchedUtil is aware of
> that reduced frequency, so it should be taken into account also in EAS
> estimations.

It's important to highlight that this will only fix this issue between
schedutil and EAS when it's due to `thermal pressure` (today only via
CPU cooling). There are other places which could restrict policy->max
via freq_qos_update_request() and EAS will be unaware of it.

> SchedUtil, as a CPUFreq governor, knows the maximum allowed frequency of
> a CPU, thanks to cpufreq_driver_resolve_freq() and internal clamping
> to 'policy::max'. SchedUtil is responsible to respect that upper limit
> while setting the frequency through CPUFreq drivers. This effective
> frequency is stored internally in 'sugov_policy::next_freq' and EAS has
> to predict that value.
> 
> In the existing code the raw value of arch_scale_cpu_capacity() is used
> for clamping the returned CPU utilization from effective_cpu_util().
> This patch fixes issue with too big single CPU utilization, by introducing
> clamping to the allowed CPU capacity. The allowed CPU capacity is a CPU
> capacity reduced by thermal pressure raw value.
> 
> Thanks to knowledge about allowed CPU capacity, we don't get too big value
> for a single CPU utilization, which is then added to the util sum. The
> util sum is used as a source of information for estimating whole PD energy.
> To avoid wrong energy estimation in EAS (due to capped frequency), make
> sure that the calculation of util sum is aware of allowed CPU capacity.
> 
> This thermal pressure might be visible in scenarios where the CPUs are not
> heavily loaded, but some other component (like GPU) drastically reduced
> available power budget and increased the SoC temperature. Thus, we still
> use EAS for task placement and CPUs are not over-utilized.

IMHO, this means that this is catered for the IPA governor then. I'm not
sure if this would be beneficial when another thermal governor is used?

The mechanical side of the code would allow for such benefits, I just
don't know if their CPU cooling device + thermal zone setups would cater
for this?

> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/fair.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 161b92aa1c79..3634e077051d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6527,8 +6527,11 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  	struct cpumask *pd_mask = perf_domain_span(pd);
>  	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
>  	unsigned long max_util = 0, sum_util = 0;
> +	unsigned long _cpu_cap = cpu_cap;
>  	int cpu;
>  
> +	_cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));
> +

Maybe shorter?

        struct cpumask *pd_mask = perf_domain_span(pd);
-       unsigned long cpu_cap =
arch_scale_cpu_capacity(cpumask_first(pd_mask));
+       int cpu = cpumask_first(pd_mask);
+       unsigned long cpu_cap = arch_scale_cpu_capacity(cpu);
+       unsigned long _cpu_cap = cpu_cap - arch_scale_thermal_pressure(cpu);
        unsigned long max_util = 0, sum_util = 0;
-       unsigned long _cpu_cap = cpu_cap;
-       int cpu;
-
-       _cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));

>  	/*
>  	 * The capacity state of CPUs of the current rd can be driven by CPUs
>  	 * of another rd if they belong to the same pd. So, account for the
> @@ -6564,8 +6567,10 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  		 * is already enough to scale the EM reported power
>  		 * consumption at the (eventually clamped) cpu_capacity.
>  		 */
> -		sum_util += effective_cpu_util(cpu, util_running, cpu_cap,
> -					       ENERGY_UTIL, NULL);
> +		cpu_util = effective_cpu_util(cpu, util_running, cpu_cap,
> +					      ENERGY_UTIL, NULL);
> +
> +		sum_util += min(cpu_util, _cpu_cap);
>  
>  		/*
>  		 * Performance domain frequency: utilization clamping
> @@ -6576,7 +6581,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  		 */
>  		cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
>  					      FREQUENCY_UTIL, tsk);
> -		max_util = max(max_util, cpu_util);
> +		max_util = max(max_util, min(cpu_util, _cpu_cap));
>  	}
>  
>  	return em_cpu_energy(pd->em_pd, max_util, sum_util);

There is IPA specific code in cpufreq_set_cur_state() ->
get_state_freq() which accesses the EM:

    ...
    return cpufreq_cdev->em->table[idx].frequency;
    ...

Has it been discussed that the `per-PD max (allowed) CPU capacity` (1)
could be stored in the EM from there so that code like the EAS wakeup
code (compute_energy()) could retrieve this information from the EM?
And there wouldn't be any need to pass (1) into the EM (like now via
em_cpu_energy()).
This would be signalling within the EM compared to external signalling
via `CPU cooling -> thermal pressure <- EAS wakeup -> EM`.
