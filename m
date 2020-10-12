Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9796728BF87
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 20:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgJLSTg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 14:19:36 -0400
Received: from foss.arm.com ([217.140.110.172]:34120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387583AbgJLSTg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 14:19:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA5531B;
        Mon, 12 Oct 2020 11:19:35 -0700 (PDT)
Received: from [10.57.48.121] (unknown [10.57.48.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA7883F66B;
        Mon, 12 Oct 2020 11:19:31 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        chris.redpath@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7> <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
 <20201009140141.GA4048593@bogus>
 <2b7b6486-2898-1279-ce9f-9e7bd3512152@arm.com>
 <20201012105945.GA9219@arm.com>
 <500510b9-58f3-90b3-8c95-0ac481d468b5@arm.com>
 <20201012163032.GA30838@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9fe56600-ba7d-d3b6-eea3-885475d94d7a@arm.com>
Date:   Mon, 12 Oct 2020 19:19:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201012163032.GA30838@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/12/20 5:30 PM, Ionela Voinescu wrote:
> Hi Lukasz,
> 
> On Monday 12 Oct 2020 at 14:48:20 (+0100), Lukasz Luba wrote:
>>
>>
>> On 10/12/20 11:59 AM, Ionela Voinescu wrote:
>>> On Monday 12 Oct 2020 at 11:22:57 (+0100), Lukasz Luba wrote:
>>> [..]
>>>>>> I thought about it and looked for other platforms' DT to see if can reuse
>>>>>> existing opp information. Unfortunately I don't think it is optimal. The reason
>>>>>> being that, because cpus have the same opp table it does not necessarily mean
>>>>>> that they share a clock wire. It just tells us that they have the same
>>>>>> capabilities (literally just tells us they have the same V/f op points).
>>>>>> Unless I am missing something?
>>>>>>
>>>>>> When comparing with ACPI/_PSD it becomes more intuitive that there is no
>>>>>> equivalent way to reveal "perf-dependencies" in DT.
>>>>>
>>>>> You should be able to by examining the clock tree. But perhaps SCMI
>>>>> abstracts all that and just presents virtual clocks without parent
>>>>> clocks available to determine what clocks are shared? Fix SCMI if that's
>>>>> the case.
>>>>
>>>> True, the SCMI clock does not support discovery of clock tree:
>>>> (from 4.6.1 Clock management protocol background)
>>>> 'The protocol does not cover discovery of the clock tree, which must be
>>>> described through firmware tables instead.' [1]
>>>>
>>>> In this situation, would it make sense, instead of this binding from
>>>> patch 1/2, create a binding for internal firmware/scmi node?
>>>>
>>>> Something like:
>>>>
>>>> firmware {
>>>> 	scmi {
>>>> 	...		
>>>> 		scmi-perf-dep {
>>>> 			compatible = "arm,scmi-perf-dependencies";
>>>> 			cpu-perf-dep0 {
>>>> 				cpu-perf-affinity = <&CPU0>, <&CPU1>;
>>>> 			};
>>>> 			cpu-perf-dep1 {
>>>> 				cpu-perf-affinity = <&CPU3>, <&CPU4>;
>>>> 			};
>>>> 			cpu-perf-dep2 {
>>>> 				cpu-perf-affinity = <&CPU7>;
>>>> 			};
>>>> 		};
>>>> 	};
>>>> };
>>>>
>>>> The code which is going to parse the binding would be inside the
>>>> scmi perf protocol code and used via API by scmi-cpufreq.c.
>>>>
>>>
>>> While SCMI cpufreq would be able to benefit from the functionality that
>>> Nicola is trying to introduce, it's not the only driver, and more
>>> importantly, it's not *going* to be the only driver benefiting from
>>> this.
>>>
>>> Currently there is also qcom-cpufreq-hw.c and the future
>>> mediatek-cpufreq-hw.c that is currently under review [1]. They both do
>>> their frequency setting by interacting with HW/FW, and could either take
>>> or update their OPP tables from there. Therefore, if the platform would
>>> require it, they could also expose different controls for frequency
>>> setting and could benefit from additional information about clock
>>> domains (either through opp-shared or the new entries in Nicola's patch),
>>> without driver changes.
>>>
>>> Another point to be made is that I strongly believe this is going to be
>>> the norm in the future. Directly setting PLLs and regulator voltages
>>> has been proven unsafe and unsecure.
>>>
>>> Therefore, I see this as support for a generic cpufreq feature (a
>>> hardware coordination type), rather than support for a specific driver.
>>>
>>> [1] https://lkml.org/lkml/2020/9/10/11
>>>
>>>>
>>>> Now regarding the 'dependent_cpus' mask.
>>>>
>>>> We could avoid adding a new field 'dependent_cpus' in policy
>>>> struct, but I am not sure of one bit - Frequency Invariant Engine,
>>>> (which is also not fixed by just adding a new cpumask).
>>>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>     Let's take it step by step..
>>>>
>>>> We have 3 subsystems to fix:
>>>> 1. EAS - EM has API function which takes custom cpumask, so no issue,
>>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> 	   keep in mind that EAS it's using the max aggregation method
>>> 	   that schedutil is using. So if we are to describe the
>>> 	   functionality correctly, it needs both a cpumask describing
>>> 	   the frequency domains and an aggregation method.
>>
>> EAS does not use schedutil max agregation, it calculates max_util
>> internally.
>>
> 
> But isn't it the same logic mechanism that schedutil uses?

No, it's standalone, slightly different because no ioboosting.
As I said, on issue, just proper cpumask during EM registration is
needed and proper tasks utilization (assuming FIE works in the system).
No need of a new cpumask in policy.

> 
>> The compute_energy() loops through the CPUs in the domain and
>> takes the utilization from them via schedutil_cpu_util(cpu_rq(cpu)).
>> It figures out max_util and then em_cpu_energy() maps it to next
>    ^^^^^^^^^^^^^^^^^^^^^^^
> 
> Same for schedutil: sugov_next_freq_shared() calls sugov_get_util()
> which then calls schedutil_cpu_util().

Which we won't have in per-cpu solution and we would use simpler:
sugov_update_single()
and in FIE you won't see the aggregated max freq for the cluster.
Instead you will see N freq requests coming from N CPUs and going
into software FIE.


> 
> If your point is that one is applying the max function in compute_energy()
> while the other is doing it in sugov_next_freq_shared(), I'll re-enforce
> my argument that they are logically doing the same *type* of
> aggregation. EAS is relying on it and schedutil was purposely modified
> for this purpose:
> 
> 938e5e4b0d15  sched/cpufreq: Prepare schedutil for Energy Aware
> Scheduling
> 
>> frequency for the cluster. It just needs proper utilization from
>> CPUs, which is taken from run-queues, which is a sum of utilization
>> of tasks being there. This leads to problem how we account utilization
>> of a task. This is the place where the FIE is involved. EAS assumes the
>> utilization is calculated properly.
> 
> This is separate. Above we were discussing the aggregation method and
> what CPUs this is applied on. I'll continue on FIE below.

As I said EAS has no issues, it has it own 'aggregation' just needs
cpumask from EM.
FIE has issue, due to missing schedutil shared policy, in particular the
function:
sugov_next_freq_shared()
which figures out the freq max for the cluster.

> 
>>>
>>>>     fix would be to use it via the scmi-cpufreq.c
>>>
>>>> 2. IPA (for calculating the power of a cluster, not whole thermal needs
>>>>     this knowledge about 'dependent cpus') - this can be fixed internally
>>>
>>>> 3. Frequency Invariant Engine (FIE) - currently it relies on schedutil
>>>>     filtering and providing max freq of all cpus in the cluster into the
>>>>     FIE; this info is then populated to all 'related_cpus' which will
>>>>     have this freq (we know, because there is no other freq requests);
>>>>     Issues:
>>>> 3.1. Schedutil is not going to check all cpus in the cluster to take
>>>>     max freq, which is then passed into the cpufreq driver and FIE
>>>> 3.2. FIE would have to (or maybe we would drop it) have a logic similar
>>>>     to what schedutil does (max freq search and set, then filter next
>>>>     freq requests from other cpus in the next period e.g. 10ms)
>>>> 3.3. Schedutil is going to invoke freq change for each cpu independently
>>>>     and the current code just calls arch_set_freq_scale() - adding just
>>>>     'dependent_cpus' won't help
>>>
>>> I don't believe these are issues. As we need changes for EAS and IPA, we'd
>>> need changes for FIE. We don't need more than the cpumask that shows
>>> frequency domains as we already already have the aggregation method that
>>> schedutil uses to propagate the max frequency in a domain across CPUs.
>>
>> Schedutil is going to work in !policy_is_shared() mode, which leads to
>> sugov_update_single() being the 'main' function. We won't have
>> schedutil goodness which is handling related_cpus use case.
>>
> 
> Agreed! I did not mean that I'd rely on schedutil to do the aggregation
> and hand me the answer. But my suggestion is to use the same logical
> method - maximum, for cases where counters are not present.

In FIE generic code and this new 'dependent_cpus' mask?
Or with help of cpufreq driver, which would have internal cpu
dependency mask?

IMO the old FIE implementation where arch_set_freq_scale()
was called from the drivers had less issues, see below.

> 
>> Then in software FIE would you just change the call from:
>> 	arch_set_freq_scale(policy->related_cpus,...)
>> to:
>> 	arch_set_freq_scale(policy->dependent_cpus,...)
>> ?
>>
>> This code would be called from any CPU (without filtering) and it
>> would loop through cpumask updating freq_scale, which is wrong IMO.
>> You need some 'logic', which is not currently in there.
>>
> 
> Definitely! But that's because the FIE changes above are incomplete.
> That's why whomever does these changes should go beyond:
> s/related_cpus/dependent_cpus.
> 
> We don't need more information from DT additional to this dependent_cpus
> maks, but it does not mean the end solution for making use of it will be
> a simple "s/related_cpus/dependent_cpus".

The previous FIE implementation where arch_set_freq_scale()
was called from the drivers, was better suited for this issue.
Driver could just use internal dependency cpumask or even
do the aggregation to figure out the max freq for cluster
if there is a need, before calling arch_set_freq_scale().

It is not perfect solution for software FIE, but one of possible
when there is no hw counters.

> 
>> Leaving the 'related_cpus' would also be wrong (because real CPU
>> frequency is different, so we would account task utilization wrongly).
>>
>>>
>>> This would be the default method if cycle counters are not present. It
>>> might not reflect the frequency the cores actually get from HW, but for
>>> that cycle counters should be used.
>>
>> IMHO the configurations with per-cpu freq requests while there are CPUs
>> 'dependent' and there are no HW counters to use for tasks
>> utilization accounting - should be blocked. Then we don't need
>> 'dependent_cpus' in software FIE. Then one less from your requirements
>> list for new cpumask.
>>
> 
> I'd go for a default.. better have something than removing it
> altogether, but we'll see.
> 
> I'll stop this here as I think we're distracting a bit from the main
> purpose of this RFC. I don't believe FIE brings an additional
> requirement. 

You've put FIE as 3rd in the list in response to Rafael's question
'What would you use it for, specifically?'
when he ask regarding that new extra cpumask in policy.

That's why I am trying to figure out if we can eliminate FIE
form your list of sub-system which would need the extra mask.


"Software" FIE will need fixing/optimizing/bypassing
> (we'll agree later on the implementation) but it does not need anything
> else from DT/ACPI.

So we agree that software FIE needs fixes.

Difference between new FIE and old FIE (from v5.8) is that the new one
purely relies on schedutil max freq value (which will now be missing),
while the old FIE was called by the driver and thus it was an option to
fix only the affected cpufreq driver [1][2].

IMO we can avoid this new cpumask in policy.

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/v5.8/source/drivers/cpufreq/scmi-cpufreq.c#L58
[2] 
https://elixir.bootlin.com/linux/v5.8/source/drivers/cpufreq/qcom-cpufreq-hw.c#L79

> 
> Thank you,
> Ionela.
> 
>>>
>>>> 3.4 What would be the real frequency of these cpus and what would be
>>>>     set to FIE
>>>> 3.5 FIE is going to filter to soon requests from other dependent cpus?
>>>>
>>>> IMHO the FIE needs more bits than just a new cpumask.
>>>> Maybe we should consider to move FIE arch_set_freq_scale() call into the
>>>> cpufreq driver, which will know better how to aggregate/filter requests
>>>> and then call FIE update?
>>>
>>> I'm quite strongly against this :). As described before, this is not a
>>> feature that a single driver needs, and even if it was, the aggregation
>>> method for FIE is not a driver policy.
>>
>> Software version of FIE has issues in this case, schedutil or EAS won't
>> help (different code path).
>>
>> Regards,
>> Lukasz
