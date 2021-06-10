Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492943A2754
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 10:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFJIoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 04:44:22 -0400
Received: from foss.arm.com ([217.140.110.172]:53836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhFJIoQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Jun 2021 04:44:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CCACD6E;
        Thu, 10 Jun 2021 01:42:20 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7AD23F719;
        Thu, 10 Jun 2021 01:42:17 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        qperret@google.com, vincent.donnefort@arm.com,
        Beata.Michalska@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com
References: <20210604080954.13915-1-lukasz.luba@arm.com>
 <20210604080954.13915-2-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2f2fc758-92c6-5023-4fcb-f9558bf3369e@arm.com>
Date:   Thu, 10 Jun 2021 10:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604080954.13915-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/06/2021 10:09, Lukasz Luba wrote:
> Energy Aware Scheduling (EAS) needs to be able to predict the frequency
> requests made by the SchedUtil governor to properly estimate energy used
> in the future. It has to take into account CPUs utilization and forecast
> Performance Domain (PD) frequency. There is a corner case when the max
> allowed frequency might be reduced due to thermal. SchedUtil is aware of
> that reduced frequency, so it should be taken into account also in EAS
> estimations.
> 
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
> capacity reduced by thermal pressure signal. We rely on this load avg
> geometric series in similar way as other mechanisms in the scheduler.
> 
> Thanks to knowledge about allowed CPU capacity, we don't get too big value
> for a single CPU utilization, which is then added to the util sum. The
> util sum is used as a source of information for estimating whole PD energy.
> To avoid wrong energy estimation in EAS (due to capped frequency), make
> sure that the calculation of util sum is aware of allowed CPU capacity.
> 

So essentially what you want to do is:

Make EAS aware of the frequency clamping schedutil can be faced with:

  get_next_freq() -> cpufreq_driver_resolve_freq() ->
clamp_val(target_freq, policy->min, policy->max) (1)

by subtracting CPU's Thermal Pressure (ThPr) signal from the original
CPU capacity `arch_scale_cpu_capacity()` (2).

---

Isn't there a conceptional flaw in this design? Let's say we have a
big.Little system with two cpufreq cooling devices and a thermal zone
(something like Hikey 960). To create a ThPr scenario we have to run
stuff on the CPUs (e.g. hackbench (3)).
Eventually cpufreq_set_cur_state() [drivers/thermal/cpufreq_cooling.c]
will set thermal_pressure to `(2) - (2)*freq/policy->cpuinfo.max_freq`
and PELT will provide the ThPr signal via thermal_load_avg().
But to create this scenario, the system will become overutilized
(system-wide data, if one CPU is overutilized, the whole system is) so
EAS is disabled (i.e. find_energy_efficient_cpu() and compute_emergy()
are not executed).

I can see that there are episodes in which EAS is running and
thermal_load_avg() != 0 but those have to be when (3) has stopped and
you see the ThPr signal just decaying (no accruing of new ThPr). The
cpufreq cooling device can still issue cpufreq_set_cur_state() but only
with decreasing states.

---

IMHO, a precise description of how you envision the system setup,
incorporating all participating subsystems, would be helpful here.

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/fair.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 161b92aa1c79..1aeddecabc20 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6527,6 +6527,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  	struct cpumask *pd_mask = perf_domain_span(pd);
>  	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
>  	unsigned long max_util = 0, sum_util = 0;
> +	unsigned long _cpu_cap = cpu_cap;
>  	int cpu;
>  
>  	/*
> @@ -6558,14 +6559,24 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  				cpu_util_next(cpu, p, -1) + task_util_est(p);
>  		}
>  
> +		/*
> +		 * Take the thermal pressure from non-idle CPUs. They have
> +		 * most up-to-date information. For idle CPUs thermal pressure
> +		 * signal is not updated so often.
> +		 */
> +		if (!idle_cpu(cpu))
> +			_cpu_cap = cpu_cap - thermal_load_avg(cpu_rq(cpu));
> +

This one is probably the result of the fact that cpufreq cooling device
sets the ThPr for all CPUs of the policy (Frequency Domain (FD) or
Performance Domain (PD)) but PELT updates are happening per-CPU. And
only !idle CPUs get the update in scheduler_tick().

Looks like thermal_pressure [per_cpu(thermal_pressure, cpu),
drivers/base/arch_topology.c] set by cpufreq_set_cur_state() is always
in sync with policy->max/cpuinfo_max_freq).
So for your use case this instantaneous `signal` is better than the PELT
one. It's precise (no decaying when frequency clamping is already gone)
and you avoid the per-cpu update issue.

>  		/*
>  		 * Busy time computation: utilization clamping is not
>  		 * required since the ratio (sum_util / cpu_capacity)
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
> @@ -6576,7 +6587,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  		 */
>  		cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
>  					      FREQUENCY_UTIL, tsk);
> -		max_util = max(max_util, cpu_util);
> +		max_util = max(max_util, min(cpu_util, _cpu_cap));
>  	}
>  
>  	return em_cpu_energy(pd->em_pd, max_util, sum_util);
>
