Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B63E7BD6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbhHJPM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 11:12:56 -0400
Received: from foss.arm.com ([217.140.110.172]:57726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242696AbhHJPMx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 11:12:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93DCA1FB;
        Tue, 10 Aug 2021 08:12:31 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB74D3F718;
        Tue, 10 Aug 2021 08:12:29 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
 <78bc08fe-71c2-398c-9a10-caa54b8bd866@arm.com> <YRKINFhDmYqvgxsN@google.com>
 <cf9d78fe-cff0-1992-2c15-7053e4431296@arm.com>
Message-ID: <b888407c-d444-8184-cbb7-ce8e925b254b@arm.com>
Date:   Tue, 10 Aug 2021 16:12:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cf9d78fe-cff0-1992-2c15-7053e4431296@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/10/21 3:18 PM, Lukasz Luba wrote:
> 
> 
> On 8/10/21 3:07 PM, Quentin Perret wrote:
>> On Tuesday 10 Aug 2021 at 13:28:21 (+0100), Lukasz Luba wrote:
>>>
>>>
>>> On 8/10/21 7:13 AM, Viresh Kumar wrote:
>>>> On 04-08-21, 18:21, Rafael J. Wysocki wrote:
>>>>> The cpufreq changes are mostly fine by me now, but I would like to
>>>>> hear from Viresh regarding this.
>>>>
>>>> I have few doubts/concerns here.
>>>>
>>>> Just to iterate it again, the idea here is to choose a higher
>>>> frequency, which will work in an efficient manner based on energy
>>>> consumption. So this _only_ works for the case where the caller asked
>>>> for CPUFREQ_RELATION_L.
>>>>
>>>> - The new flag being added here, CPUFREQ_RELATION_E, doesn't feel
>>>>     complete in this sense to me. It should rather be called as
>>>>     CPUFREQ_RELATION_LE instead as it is _always_ used with relation L.
>>>>
>>>> - IMO this has made the caller site a bit confusing now, i.e.  why we
>>>>     send CPUFREQ_RELATION_E sometimes and CPUFREQ_RELATION_H at other
>>>>     times. Why shouldn't the _H freq be efficient as well ? I 
>>>> understand
>>>>     that this was done to not do the efficient stuff in case of
>>>>     userspace/powersave/performance governors.
>>>>
>>>>     What about reusing following for finding all such cases ?
>>>>
>>>>           policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING
>>>>
>>>>     The driver can set a flag to tell if it wants efficient frequencies
>>>>     or not, and at runtime we apply efficient algorithm only if the
>>>>     current governor does DVFS, which will leave out
>>>>     userspace/performance/powersave.
>>>>
>>>>
>>>> Now the other thing I didn't like since the beginning, I still don't
>>>> like it :)
>>>>
>>>> A cpufreq table is provided by the driver, which can have some
>>>> inefficient frequencies. The inefficient frequencies can be caught by
>>>> many parts of the kernel, the current way (in this series) is via EM.
>>>> But this can totally be anything else as well, like a devfreq driver.
>>>
>>> Currently devfreq drivers and governors don't support 'inefficient'
>>> OPPs idea. They are not even 'utilization' driven yet. I'm not sure
>>> if that would make sense for their workloads. For now, they are far
>>> behind the CPUFreq/scheduler development in this field.
>>> It needs more research and experiments, to even estimate if this brings
>>> benefits. So, I would just skip devfreq use case...
>>>
>>>>
>>>> The way we have tied this whole thing with EM, via
>>>> cpufreq_read_inefficiencies_from_em(), is what I don't like. We have
>>>> closely bound the whole thing with one of the ways this can be done
>>>> and we shouldn't be polluting the cpufreq core with this IMHO. In a
>>>> sane world, the cpufreq core should just provide an API, like
>>>> cpufreq_set_freq_invariant() and it can be called by any part of
>>>> the kernel.
>>>>
>>>> I understand that the current problem is where do we make that call
>>>> from and I suggested dev_pm_opp_of_register_em() for the same earlier.
>>>> But that doesn't work as the policy isn't properly initialized by that
>>>> point.
>>>
>>> True, the policy is not initialized yet when cpufreq_driver::init()
>>> callback is called, which the current place for scmi-cpufreq.
>>>
>>> What about the other callback cpufreq_driver::ready() ?
>>> This might solve the two issues I mentioned below.
>>>
>>>>
>>>> Now that I see the current implementation, I think we can make it work
>>>> in a different way.
>>>>
>>>> - Copy what's done for thermal-cooling in cpufreq core, i.e.
>>>>     CPUFREQ_IS_COOLING_DEV flag, for the EM core as well. So the 
>>>> cpufreq
>>>>     drivers can set a flag, CPUFREQ_REGISTER_EM, and the cpufreq core
>>>>     can call dev_pm_opp_of_register_em() on their behalf. This call 
>>>> will
>>>>     be made from cpufreq_online(), just before/after
>>>>     cpufreq_thermal_control_enabled() stuff. By this point the 
>>>> policy is
>>>>     properly initialized and is also updated in
>>>>     per_cpu(cpufreq_cpu_data).
>>>>
>>>> - Now the cpufreq core can provide an API like
>>>>     cpufreq_set_freq_invariant(int cpu, unsigned long freq), which can
>>>>     be called from EM core's implementation of
>>>>     em_dev_register_perf_domain().
>>>>
>>>
>>> I have to point out that there are two issues (which we
>>> might solve):
>>> 1. Advanced setup, due to per-CPU performance requests,
>>> which are not limited to real DVFS domain.
>>> The scmi-cpufreq (and possibly some other soon) uses more
>>> tricky EM setup. As you might recall, the construction of temporary
>>> cpumask is a bit complex, since we want per-CPU policy, but the
>>> cpumask pass to EM has not a single bit but is 'spanned' with a few
>>> CPUs.
>>>
>>> 2. The scmi-cpufreq (and IIRC MTK cpufreq driver soon) requires
>>> custom struct em_data_callback, since the power data is coming from FW.
>>
>> +1, we really need this to work.
>>
>>> If there is a need for complex EM registration, maybe we could
>>> do it in the cpufreq_driver::ready(). The policy would be ready
>>> during that call, so it might fly.
>>
>> I remember trying this, but ran into issues as well FWIW. I would need
>> to check if this is still relevant, but at the time this was introduced
>> we needed to register the EM _before_ the policy notifier is called with
>> 'CPUFREQ_CREATE_POLICY', because this will trigger a sched domain
>> rebuild in the arch_topology driver, which allows the scheduler to pick
>> up the newly introduced EM data.
>>
> 
> Let me go through that code and experiment if there is an issue.

I've checked that. It's not the policy notifier and arch_topology which
cause an issue, but the cpufreq governor setup code. Anyway, we cannot
wait so late with the EM registration, till e.g. ::ready() callback.
Thanks!
