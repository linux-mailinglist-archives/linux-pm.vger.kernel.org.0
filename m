Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF0223948
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgGQKan (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 06:30:43 -0400
Received: from foss.arm.com ([217.140.110.172]:51194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgGQKam (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Jul 2020 06:30:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9387BD6E;
        Fri, 17 Jul 2020 03:30:41 -0700 (PDT)
Received: from [10.37.12.35] (unknown [10.37.12.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF3DA3F66E;
        Fri, 17 Jul 2020 03:30:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <681fb3e8-d645-2558-38de-b39b372499de@arm.com>
 <CAKfTPtA+BPegK2h6PQMFs+p4dpxO+sk1FDQuOfJvSpGCJ-rBrA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <cd0749b3-75a1-3cd2-b6d7-d6e9c08acf75@arm.com>
Date:   Fri, 17 Jul 2020 11:30:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA+BPegK2h6PQMFs+p4dpxO+sk1FDQuOfJvSpGCJ-rBrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/17/20 10:46 AM, Vincent Guittot wrote:
> On Thu, 16 Jul 2020 at 16:24, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Peter,
>>
>> Thank you for summarizing this. I've put my comments below.
>>
>> On 7/16/20 12:56 PM, Peter Zijlstra wrote:
>>> On Tue, Jul 14, 2020 at 12:06:53PM +0530, Viresh Kumar wrote:
>>>>    /**
>>>> + * get_load() - get current load for a cpu
>>>>     * @cpufreq_cdev:  &struct cpufreq_cooling_device for this cpu
>>>>     * @cpu:   cpu number
>>>> + * @cpu_idx:        index of the cpu
>>>>     *
>>>> + * Return: The current load of cpu @cpu in percentage.
>>>>     */
>>>>    static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
>>>>                   int cpu_idx)
>>>>    {
>>>> +    unsigned long util = cpu_util_cfs(cpu_rq(cpu));
>>>> +    unsigned long max = arch_scale_cpu_capacity(cpu);
>>>>
>>>> +    util = effective_cpu_util(cpu, util, max, ENERGY_UTIL, NULL);
>>>> +    return (util * 100) / max;
>>>>    }
>>>
>>> So there's a number of things... let me recap a bunch of things that
>>> got mentioned on IRC earlier this week and then continue from there..
>>>
>>> So IPA* (or any other thermal governor) needs energy estimates for the
>>> various managed devices, cpufreq_cooling, being the driver for the CPU
>>> device, needs to provide that and in return receives feedback on how
>>> much energy it is allowed to consume, cpufreq_cooling then dynamically
>>> enables/disables OPP states.
>>
>> Currently, only IPA uses the power estimation, other governors don't
>> use these API functions in cpufreq_cooling.
>>
>>>
>>> There are actually two methods the thermal governor will use:
>>> get_real_power() and get_requested_power().
>>>
>>> The first isn't used anywhere in mainline, but could be implemented on
>>> hardware that has energy counters (like say x86 RAPL).
>>
>> The first is only present as callback for registered devfreq cooling,
>> which is registered by devfreq driver. If that driver provides the
>> get_real_power(), it will be called from get_requested_power().
>> Thus, it's likely that IPA would get real power value from HW.
>>
>> I was planning to add it also to cpufreq_cooling callbacks years
>> ago...
>>
>>>
>>> The second attempts to guesstimate power, and is the subject of this
>>> patch.
>>>
>>> Currently cpufreq_cooling appears to estimate the CPU energy usage by
>>> calculating the percentage of idle time using the per-cpu cpustat stuff,
>>> which is pretty horrific.
>>
>> Even worse, it then *samples* the *current* CPU frequency at that
>> particular point in time and assumes that when the CPU wasn't idle
>> during that period - it had *this* frequency...
> 
> So there is 2 problems in the power calculation of cpufreq cooling device :
> - How to get an accurate utilization level of the cpu which is what
> this patch is trying to fix because using idle time is just wrong
> whereas scheduler utilization is frequency invariant
> - How to get power estimate from this utilization level. And as you
> pointed out, using the current freq which is not accurate.




> 
>>
>>>
>>> This patch then attempts to improve upon that by using the scheduler's
>>> cpu_util(ENERGY_UTIL) estimate, which is also used to select OPP state
>>> and improves upon avg idle. This should be a big improvement as higher
>>
>> IMHO this patch set doesn't address the real problem: 'sampling
>> freq problem' described above. There was no issue with getting idle
>> period. The avg freq was the problem, in that period when the
> 
> Not sure that you can say that avg freq is a bigger problem than
> getting the load because there is a real issue with tracking idle
> period for estimating load because running slower reduces the idle
> time and increases artificially the load. That's why we implemented
> frequency invariance in PELT.

If you take a closer look into the code, you see that wrong
freq picks the wrong power value from the EM, the line:
freq = cpufreq_quick_get(policy->cpu)
then check the function cpu_freq_to_power().
The power is calculated by:
  (raw_cpu_power * cpufreq_cdev->last_load) / 100

The load estimation error is also an issue, but the comprehensive
solution should address possibly all existing issues.

I don't know if you were approached also by the same vendor,
complaining on IPA issues. Do you have some requirements? Or deadlines,
for which kernel version you have to fix it?
We can discuss this out offline if you like.

> 
> At the opposite when the thermal mitigation happens, the frequency
> will be most probably capped by cpu cooling device and will most
> probably stay at the capped value

I don't think that we can rely on such assumption. The whole
cpufreq_get_requested_power() should be changed.

> 
>> CPUs were running. The model implemented in alg was also a problem.
>>
>> The whole period (e.g. CPU freqs which were used or idle state)
>>
>> ^(CPU freq)
>> |
>> |                            sampling the current freq
>> |                _______        |
>> |               |      |        |
>> |________       |      |        |
>> |       |       |      |        |
>> |       | idle  |      |________v________...
>> |_ _____|_______|__________________________> (time)
>>     start of period               end
>>     |<------- (typically 100ms)-->|
>>
>>
>>
>>> frequency consumes more energy, but should we not also consider that:
>>>
>>>        E = C V^2 f
>>>
>>> The EAS energy model has tables for the OPPs that contain this, but in
>>> this case we seem to be assuming a linear enery/frequency curve, which
>>> is just not the case.
>>
>> I am not sure if I got your point. To understand your point better
>> I think some drawing would be required. I will skip this patch
>> and old mainline code and focus on your proposed solution
>> (because this patch set does not address 'sampling freq problem').
>>
>>>
>>> I suppose we could do something like **:
>>>
>>>        100 * util^3 / max^3
>>>
>>> which assumes V~f.
>>
>> In EM we keep power values in the array and these values grow
>> exponentially. Each OPP has it corresponding
>>
>> P_x = C (V_x)^2 f_x    , where x is the OPP id thus corresponding V,f
>>
>> so we have discrete power values, growing like:
>>
>> ^(power)
>> |
>> |
>> |                          *
>> |
>> |
>> |                       *
>> |                       |
>> |                   *   |
>> |                       | <----- power estimation function
>> |            *          |        should not use linear 'util/max_util'
>> |   *                   |        relation here *
>> |_______________________|_____________> (freq)
>>      opp0     opp1  opp2 opp3 opp4
>>
>> What is the problem
>> First:
>> We need to pick the right Power from the array. I would suggest
>> to pick the max allowed frequency for that whole period, because
>> we don't know if the CPUs were using it (it's likely).
>> Second:
>> Then we have the utilization, which can be considered as:
>> 'idle period & running period with various freq inside', lets
>> call it avg performance in that whole period.
>> Third:
>> Try to estimate the power used in that whole period having
>> the avg performance and max performance.
> 
> We already have a function that is doing such kind of computation
> based of the utilization of the CPU : em_pd_energy(). And we could
> reuse some of this function if not exactly this one

Yes and I think we should use this information. I am going to
talk with Daniel about EM evolution (this is one of the topics
from my side). Next, it is going to be a LPC event, where we
can also discuss with broader audience.

Regards,
Lukasz

