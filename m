Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D443A2902
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 12:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJKJD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 06:09:03 -0400
Received: from foss.arm.com ([217.140.110.172]:55910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhFJKJD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Jun 2021 06:09:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A57CD6E;
        Thu, 10 Jun 2021 03:07:07 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55C1A3F694;
        Thu, 10 Jun 2021 03:07:04 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        vincent.donnefort@arm.com, Beata.Michalska@arm.com,
        mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        segall@google.com, mgorman@suse.de, bristot@redhat.com
References: <20210604080954.13915-1-lukasz.luba@arm.com>
 <20210604080954.13915-2-lukasz.luba@arm.com>
 <2f2fc758-92c6-5023-4fcb-f9558bf3369e@arm.com>
 <905f1d29-50f9-32be-4199-fc17eab79d04@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3cfa5690-644b-ba80-3fc3-7c5a3f292e70@arm.com>
Date:   Thu, 10 Jun 2021 12:07:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <905f1d29-50f9-32be-4199-fc17eab79d04@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/06/2021 11:04, Lukasz Luba wrote:
> 
> 
> On 6/10/21 9:42 AM, Dietmar Eggemann wrote:
> 
> [snip]
> 
>>
>> So essentially what you want to do is:
>>
>> Make EAS aware of the frequency clamping schedutil can be faced with:
>>
>>    get_next_freq() -> cpufreq_driver_resolve_freq() ->
>> clamp_val(target_freq, policy->min, policy->max) (1)
>>
>> by subtracting CPU's Thermal Pressure (ThPr) signal from the original
>> CPU capacity `arch_scale_cpu_capacity()` (2).
>>
>> ---
>>
>> Isn't there a conceptional flaw in this design? Let's say we have a
>> big.Little system with two cpufreq cooling devices and a thermal zone
>> (something like Hikey 960). To create a ThPr scenario we have to run
>> stuff on the CPUs (e.g. hackbench (3)).
>> Eventually cpufreq_set_cur_state() [drivers/thermal/cpufreq_cooling.c]
>> will set thermal_pressure to `(2) - (2)*freq/policy->cpuinfo.max_freq`
>> and PELT will provide the ThPr signal via thermal_load_avg().
>> But to create this scenario, the system will become overutilized
>> (system-wide data, if one CPU is overutilized, the whole system is) so
>> EAS is disabled (i.e. find_energy_efficient_cpu() and compute_emergy()
>> are not executed).
> 
> Not always, it depends on thermal governor decision, workload and
> 'power actors' (in IPA naming convention). Then it depends when and how
> hard you clamp the CPUs. They (CPUs) don't have to be always
> overutilized, they might be even 50-70% utilized but the GPU reduced
> power budget by 2 Watts, so CPUs left with only 1W. Which is still OK
> for the CPUs, since they are only 'feeding' the GPU with new 'jobs'.

All this pretty much confines the usefulness of you proposed change. A
precise description of it with the patches is necessary to allow people
to start from there while exploring your patches.

>> I can see that there are episodes in which EAS is running and
>> thermal_load_avg() != 0 but those have to be when (3) has stopped and
>> you see the ThPr signal just decaying (no accruing of new ThPr). The
>> cpufreq cooling device can still issue cpufreq_set_cur_state() but only
>> with decreasing states.
> 
> It is true for some CPU heavy workloads, when no other SoC components
> are involved like: GPU, DSP, ISP, encoders, etc. For other workloads
> when CPUs don't have to do a lot, but thermal pressure might be seen on
> them, this patch help.
> 
>>
>> ---
>>
>> IMHO, a precise description of how you envision the system setup,
>> incorporating all participating subsystems, would be helpful here.
> 
> True, I hope this description above would help to understand the
> scenario.

This description belongs in the patch header. The scenario in which your
functionality would improve things has to be clear.
I'm sure that not everybody looking at this patches is immediately aware
on how IPA setups work and which specific setup you have in mind here.

>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>   kernel/sched/fair.c | 17 ++++++++++++++---
>>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 161b92aa1c79..1aeddecabc20 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6527,6 +6527,7 @@ compute_energy(struct task_struct *p, int
>>> dst_cpu, struct perf_domain *pd)
>>>       struct cpumask *pd_mask = perf_domain_span(pd);
>>>       unsigned long cpu_cap =
>>> arch_scale_cpu_capacity(cpumask_first(pd_mask));
>>>       unsigned long max_util = 0, sum_util = 0;
>>> +    unsigned long _cpu_cap = cpu_cap;
>>>       int cpu;
>>>         /*
>>> @@ -6558,14 +6559,24 @@ compute_energy(struct task_struct *p, int
>>> dst_cpu, struct perf_domain *pd)
>>>                   cpu_util_next(cpu, p, -1) + task_util_est(p);
>>>           }
>>>   +        /*
>>> +         * Take the thermal pressure from non-idle CPUs. They have
>>> +         * most up-to-date information. For idle CPUs thermal pressure
>>> +         * signal is not updated so often.
>>> +         */
>>> +        if (!idle_cpu(cpu))
>>> +            _cpu_cap = cpu_cap - thermal_load_avg(cpu_rq(cpu));
>>> +
>>
>> This one is probably the result of the fact that cpufreq cooling device
>> sets the ThPr for all CPUs of the policy (Frequency Domain (FD) or
>> Performance Domain (PD)) but PELT updates are happening per-CPU. And
>> only !idle CPUs get the update in scheduler_tick().
>>
>> Looks like thermal_pressure [per_cpu(thermal_pressure, cpu),
>> drivers/base/arch_topology.c] set by cpufreq_set_cur_state() is always
>> in sync with policy->max/cpuinfo_max_freq).
>> So for your use case this instantaneous `signal` is better than the PELT
>> one. It's precise (no decaying when frequency clamping is already gone)
>> and you avoid the per-cpu update issue.
> 
> Yes, this code implementation tries to address those issues.

The point I was making here is: why using the PELT signal
thermal_load_avg() and not per_cpu(thermal_pressure, cpu) directly,
given the fact that the latter perfectly represents the frequency clamping?
