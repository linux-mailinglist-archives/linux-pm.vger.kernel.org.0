Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606283A2B99
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFJMcC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 08:32:02 -0400
Received: from foss.arm.com ([217.140.110.172]:58694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhFJMcB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Jun 2021 08:32:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BCABED1;
        Thu, 10 Jun 2021 05:30:04 -0700 (PDT)
Received: from [10.57.4.220] (unknown [10.57.4.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A7143F73D;
        Thu, 10 Jun 2021 05:30:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20210604080954.13915-1-lukasz.luba@arm.com>
 <20210604080954.13915-2-lukasz.luba@arm.com>
 <2f2fc758-92c6-5023-4fcb-f9558bf3369e@arm.com>
 <905f1d29-50f9-32be-4199-fc17eab79d04@arm.com>
 <3cfa5690-644b-ba80-3fc3-7c5a3f292e70@arm.com>
 <c77d00b9-d7a3-0e8a-a528-ab0c1773496f@arm.com>
 <CAKfTPtAc62gyjxSiSY2vD_qr-WjqbC91_GF-LXgNXh8T0Xx-yw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d4383b7a-a5e7-18ca-14ed-c533b4d43f62@arm.com>
Date:   Thu, 10 Jun 2021 13:30:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAc62gyjxSiSY2vD_qr-WjqbC91_GF-LXgNXh8T0Xx-yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/10/21 1:19 PM, Vincent Guittot wrote:
> On Thu, 10 Jun 2021 at 12:37, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 6/10/21 11:07 AM, Dietmar Eggemann wrote:
>>> On 10/06/2021 11:04, Lukasz Luba wrote:
>>>>
>>
>> [snip]
>>
>>>> Not always, it depends on thermal governor decision, workload and
>>>> 'power actors' (in IPA naming convention). Then it depends when and how
>>>> hard you clamp the CPUs. They (CPUs) don't have to be always
>>>> overutilized, they might be even 50-70% utilized but the GPU reduced
>>>> power budget by 2 Watts, so CPUs left with only 1W. Which is still OK
>>>> for the CPUs, since they are only 'feeding' the GPU with new 'jobs'.
>>>
>>> All this pretty much confines the usefulness of you proposed change. A
>>> precise description of it with the patches is necessary to allow people
>>> to start from there while exploring your patches.
>>
>> OK, I see your point.
>>
>> [snip]
>>
>>>> True, I hope this description above would help to understand the
>>>> scenario.
>>>
>>> This description belongs in the patch header. The scenario in which your
>>> functionality would improve things has to be clear.
>>> I'm sure that not everybody looking at this patches is immediately aware
>>> on how IPA setups work and which specific setup you have in mind here.
>>
>> Agree. I will add this description into the patch header for v3.
>>
>> [snip]
>>
>>>>
>>>> Yes, this code implementation tries to address those issues.
>>>
>>> The point I was making here is: why using the PELT signal
>>> thermal_load_avg() and not per_cpu(thermal_pressure, cpu) directly,
>>> given the fact that the latter perfectly represents the frequency clamping?
>>>
>>
>> Good question. I wanted to be aligned with other parts in the fair.c
>> like cpu_capacity() and all it's users. The CPU capacity is reduced by
>> RT, DL, IRQ and thermal load avg, not the 'raw' value from the
>> per-cpu variable.
>>
>> TBH I cannot recall what was the argument back then
>> when thermal pressure geometric series was introduced.
>> Maybe to have a better control how fast it raises and decays
>> so other mechanisms in the scheduler will see the change in thermal
>> as not so sharp... (?)
>>
>>
>> Vincent do you remember the motivation to have geometric series
>> in thermal pressure and not use just the 'raw' value from per-cpu?
> 
> In order to have thermal pressure  synced with other metrics used by
> the scheduler like util/rt/dl_avg. As an example, when thermal
> pressure will decrease because thermal capping is removed, the
> utilization will increase at the same pace as thermal will decrease
> and it will not create some fake spare cycle. util_avg is the average
> expected utilization of the cpu, thermal pressure reflects the average
> stolen capacity for the same averaging time scale but this can be the
> result of a toggle between several OPP
> 
> Using current capping is quite volatile to make a decision as it might
> have changed by the time you apply your decision.
> 

So for this scenario, where we want to just align EAS with SchedUtil
frequency decision, which is instantaneous and has 'raw' value
of capping from policy->max, shouldn't we use:

thermal_pressure = arch_scale_thermal_pressure(cpu_id)

instead of geometric series thermal_pressure signal?

This would avoid the hassling with idle CPUs and not updated
thermal signal.
