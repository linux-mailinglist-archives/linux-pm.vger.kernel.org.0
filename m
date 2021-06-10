Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A563A2756
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 10:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhFJIox (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 04:44:53 -0400
Received: from foss.arm.com ([217.140.110.172]:53868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhFJIov (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Jun 2021 04:44:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9653D6E;
        Thu, 10 Jun 2021 01:42:55 -0700 (PDT)
Received: from [10.57.4.220] (unknown [10.57.4.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18C303F719;
        Thu, 10 Jun 2021 01:42:52 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20210604080954.13915-1-lukasz.luba@arm.com>
 <20210604080954.13915-2-lukasz.luba@arm.com>
 <CAKfTPtA0j-hgXC2_LUcbRcWLkLsAB6H_EYewEHJJW+3dVu_hLQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b01020e5-9f52-87aa-30e3-284e8f86a9df@arm.com>
Date:   Thu, 10 Jun 2021 09:42:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA0j-hgXC2_LUcbRcWLkLsAB6H_EYewEHJJW+3dVu_hLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/10/21 8:59 AM, Vincent Guittot wrote:
> On Fri, 4 Jun 2021 at 10:10, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Energy Aware Scheduling (EAS) needs to be able to predict the frequency
>> requests made by the SchedUtil governor to properly estimate energy used
>> in the future. It has to take into account CPUs utilization and forecast
>> Performance Domain (PD) frequency. There is a corner case when the max
>> allowed frequency might be reduced due to thermal. SchedUtil is aware of
>> that reduced frequency, so it should be taken into account also in EAS
>> estimations.
>>
>> SchedUtil, as a CPUFreq governor, knows the maximum allowed frequency of
>> a CPU, thanks to cpufreq_driver_resolve_freq() and internal clamping
>> to 'policy::max'. SchedUtil is responsible to respect that upper limit
>> while setting the frequency through CPUFreq drivers. This effective
>> frequency is stored internally in 'sugov_policy::next_freq' and EAS has
>> to predict that value.
>>
>> In the existing code the raw value of arch_scale_cpu_capacity() is used
>> for clamping the returned CPU utilization from effective_cpu_util().
>> This patch fixes issue with too big single CPU utilization, by introducing
>> clamping to the allowed CPU capacity. The allowed CPU capacity is a CPU
>> capacity reduced by thermal pressure signal. We rely on this load avg
>> geometric series in similar way as other mechanisms in the scheduler.
>>
>> Thanks to knowledge about allowed CPU capacity, we don't get too big value
>> for a single CPU utilization, which is then added to the util sum. The
>> util sum is used as a source of information for estimating whole PD energy.
>> To avoid wrong energy estimation in EAS (due to capped frequency), make
>> sure that the calculation of util sum is aware of allowed CPU capacity.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/sched/fair.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 161b92aa1c79..1aeddecabc20 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6527,6 +6527,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>>          struct cpumask *pd_mask = perf_domain_span(pd);
>>          unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
>>          unsigned long max_util = 0, sum_util = 0;
>> +       unsigned long _cpu_cap = cpu_cap;
>>          int cpu;
>>
>>          /*
>> @@ -6558,14 +6559,24 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>>                                  cpu_util_next(cpu, p, -1) + task_util_est(p);
>>                  }
>>
>> +               /*
>> +                * Take the thermal pressure from non-idle CPUs. They have
>> +                * most up-to-date information. For idle CPUs thermal pressure
>> +                * signal is not updated so often.
> 
> What do you mean by "not updated so often" ? Do you have a value ?
> 
> Thermal pressure is updated at the same rate as other PELT values of
> an idle CPU. Why is it a problem there ?
> 


For idle CPU the value is updated 'remotely' by some other CPU
running nohz_idle_balance(). That goes into
update_blocked_averages() if the flags and checks are OK inside
update_nohz_stats(). Sometimes this is not called
because other_have_blocked() returned false. It can happen for a long
idle CPU, which all signals in that function has 0 [1].

This will cause that we don't check what is a new value stored by
thermal cpufreq_cooling for the thermal pressure [2]. We should feed
that value into the 'signal' machinery inside the
__update_blocked_others() [3]. Unfortunately, in a corner case there's
a flag (rq->has_blocked_load) which blocks the check of a
raw thermal value and prevents feeding it into thermal pressure signal
(since it's a long idle CPU, there is no load) [4].

It has implication on this patch, because I cannot e.g. take first
CPU from the PD mask and blindly check it's thermal pressure,
because it can be idle for a long time. I don't want to have two
loop, first just for taking the latest thermal pressure for the PD.
Thus, I want to re-use the existing loop to take the latest information
from non-idle CPU and pass use.

Regards,
Lukasz


[1] https://elixir.bootlin.com/linux/latest/source/kernel/sched/fair.c#L7909
[2] 
https://elixir.bootlin.com/linux/latest/source/drivers/thermal/cpufreq_cooling.c#L494
[3] https://elixir.bootlin.com/linux/latest/source/kernel/sched/fair.c#L7958
[4] https://elixir.bootlin.com/linux/latest/source/kernel/sched/fair.c#L8433
