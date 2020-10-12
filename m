Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF928BEEA
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403986AbgJLRTF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 13:19:05 -0400
Received: from foss.arm.com ([217.140.110.172]:59096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403963AbgJLRTF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 13:19:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7CB5D6E;
        Mon, 12 Oct 2020 10:19:03 -0700 (PDT)
Received: from [10.57.48.121] (unknown [10.57.48.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A00F3F66B;
        Mon, 12 Oct 2020 10:19:00 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        chris.redpath@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7> <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7> <20201012154915.GD16519@bogus>
 <20201012165219.GA3573@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <17819d4d-9e7e-9a38-4227-d0d10a0749f1@arm.com>
Date:   Mon, 12 Oct 2020 18:18:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201012165219.GA3573@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/12/20 5:52 PM, Ionela Voinescu wrote:
> On Monday 12 Oct 2020 at 16:49:30 (+0100), Sudeep Holla wrote:
>> On Fri, Oct 09, 2020 at 11:09:21AM +0530, Viresh Kumar wrote:
>>> On 08-10-20, 17:00, Nicola Mazzucato wrote:
>>>> On 10/8/20 4:03 PM, Ionela Voinescu wrote:
>>>>> Hi Viresh,
>>>>>
>>>>> On Thursday 08 Oct 2020 at 16:32:41 (+0530), Viresh Kumar wrote:
>>>>>> On 07-10-20, 13:58, Nicola Mazzucato wrote:
>>>>>>> Hi Viresh,
>>>>>>>
>>>>>>> performance controls is what is exposed by the firmware through a protocol that
>>>>>>> is not capable of describing hardware (say SCMI). For example, the firmware can
>>>>>>> tell that the platform has N controls, but it can't say to which hardware they
>>>>>>> are "wired" to. This is done in dt, where, for example, we map these controls
>>>>>>> to cpus, gpus, etc.
>>>>>>>
>>>>>>> Let's focus on cpus.
>>>>>>>
>>>>>>> Normally we would have N of performance controls (what comes from f/w)
>>>>>>> that that correspond to hardware clock/dvfs domains.
>>>>>>>
>>>>>>> However, some firmware implementations might benefit from having finer
>>>>>>> grained information about the performance requirements (e.g.
>>>>>>> per-CPU) and therefore choose to present M performance controls to the
>>>>>>> OS. DT would be adjusted accordingly to "wire" these controls to cpus
>>>>>>> or set of cpus.
>>>>>>> In this scenario, the f/w will make aggregation decisions based on the
>>>>>>> requests it receives on these M controls.
>>>>>>>
>>>>>>> Here we would have M cpufreq policies which do not necessarily reflect the
>>>>>>> underlying clock domains, thus some s/w components will underperform
>>>>>>> (EAS and thermal, for example).
>>>>>>>
>>>>>>> A real example would be a platform in which the firmware describes the system
>>>>>>> having M per-cpu control, and the cpufreq subsystem will have M policies while
>>>>>>> in fact these cpus are "performance-dependent" each other (e.g. are in the same
>>>>>>> clock domain).
>>>>>>
>>>>>> If the CPUs are in the same clock domain, they must be part of the
>>>>>> same cpufreq policy.
>>>>>
>>>>> But cpufreq does not currently support HW_ALL (I'm using the ACPI
>>>>> coordination type to describe the generic scenario of using hardware
>>>>> aggregation and coordination when establishing the clock rate of CPUs).
>>>>>
>>>>> Adding support for HW_ALL* will involve either bypassing some
>>>>> assumptions around cpufreq policies or making core cpufreq changes.
>>>>>
>>>>> In the way I see it, support for HW_ALL involves either:
>>>>>
>>>>>   - (a) Creating per-cpu policies in order to allow each of the CPUs to
>>>>>     send their own frequency request to the hardware which will do
>>>>>     aggregation and clock rate decision at the level of the clock
>>>>>     domain. The PSD domains (ACPI) and the new DT binding will tell
>>>>>     which CPUs are actually in the same clock domain for whomever is
>>>>>     interested, despite those CPUs not being in the same policy.
>>>>>     This requires the extra mask that Nicola introduced.
>>>>>
>>>>>   - (b) Making deep changes to cpufreq (core/governors/drivers) to allow:
>>>>>     - Governors to stop aggregating (usually max) the information
>>>>>       for each of the CPUs in the policy and convey to the core
>>>>>       information for each CPU.
>>>>>     - Cpufreq core to be able to receive and pass this information
>>>>>       down to the drivers.
>>>>>     - Drivers to be able to have some per cpu structures to hold
>>>>>       frequency control (let's say SCP fast channel addresses) for
>>>>>       each of the CPUs in the policy. Or have these structures in the
>>>>>       cpufreq core/policy, to avoid code duplication in drivers.
>>>>>
>>>>> Therefore (a) is the least invasive but we'll be bypassing the rule
>>>>> above. But to make that rule stick we'll have to make invasive cpufreq
>>>>> changes (b).
>>>>
>>>> Regarding the 'rule' above of one cpufreq policy per clock domain, I would like
>>>> to share my understanding on it. Perhaps it's a good opportunity to shed some light.
>>>>
>>>> Looking back in the history of CPUFreq, related_cpus was originally designed
>>>> to hold the map of cpus within the same clock. Later on, the meaning of this
>>>> cpumask changed [1].
>>>> This led to the introduction of a new cpumask 'freqdomain_cpus'
>>>> within acpi-cpufreq to keep the knowledge of hardware clock domains for
>>>> sysfs consumers since related_cpus was not suitable anymore for this.
>>>> Further on, this cpumask was assigned to online+offline cpus within the same clk
>>>> domain when sw coordination is in use [2].
>>>>
>>>> My interpretation is that there is no guarantee that related_cpus holds the
>>>> 'real' hardware clock implementation. As a consequence, it is not true anymore
>>>> that cpus that are in the same clock domain will be part of the same
>>>> policy.
>>>>
>>>> This guided me to think it would be better to have a cpumask which always holds
>>>> the real hw clock domains in the policy.
>>>>
>>>>>
>>>>> This is my current understanding and I'm leaning towards (a). What do
>>>>> you think?
>>>>>
>>>>> *in not so many words, this is what these patches are trying to propose,
>>>>> while also making sure it's supported for both ACPI and DT.
>>>>>
>>>>> BTW, thank you for your effort in making sense of this!
>>>>>
>>>>> Regards,
>>>>> Ionela.
>>>>>
>>>>
>>>> This could be a platform where per-cpu and perf-dependencies will be used:
>>>>
>>>> CPU:              0    1    2    3    4    5    6    7
>>>> Type:             A    A    A    A    B    B    B    B
>>>> Cluster:         [                                    ]
>>>> perf-controls:   [  ] [  ] [  ] [ ]  [ ]  [ ]  [ ]  [ ]
>>>> perf-dependency: [                ]  [                ]
>>>> HW clock:        [                ]  [                ]
>>>>
>>>> The firmware will present 8 controls to the OS and each control is mapped to a
>>>> cpu device via the standard dt. This is done so we can achieve hw coordination.
>>>> What is required in these systems is to present to OS the information of which
>>>> cpus belong to which clock domain. In other words, when hw coordinates we don't
>>>> have any way at present in dt to understand how these cpus are dependent
>>>> each other, from performance perspective (as opposed to ACPI where we have
>>>> _PSD). Hence my proposal for the new cpu-perf-dependencies.
>>>> This is regardless whether we decide to go for either a policy per-cpu or a
>>>> policy per-domain.
>>>>
>>>> Hope it helps.
>>>
>>> Oh yes, I get it now. Finally. Thanks for helping me out :)
>>>
>>> So if I can say all this stuff in simple terms, this is what it will
>>> be like:
>>>
>>> - We don't want software aggregation of frequencies and so we need to
>>>    have per-cpu policies even when they share their clock lines.
>>>
>>> - But we still need a way for other frameworks to know which CPUs
>>>    share the clock lines (that's what the perf-dependency is all about,
>>>    right ?).
>>>
>>> - We can't get it from SCMI, but need a DT based solution.
>>>
>>> - Currently for the cpufreq-case we relied for this on the way OPP
>>>    tables for the CPUs were described. i.e. the opp-table is marked as
>>>    "shared" and multiple CPUs point to it.
>>>
>>> - I wonder if we can keep using that instead of creating new bindings
>>>    for exact same stuff ? Though the difference here would be that the
>>>    OPP may not have any other entries.
>>
>> Well summarised, sorry for chiming in late. I could have not summarised
>> any better. Just saw the big thread and was thinking of summarising.
>> If the last point on OPP is possible(i.e. no OPP entries but just use
>> it for fetch the information) for $subject patch is trying to achieve,
>> then it would be good.
>>
> 
> Just to put in my two pennies worth: using opp-shared (in possibly empty
> OPP table) as alternative to cpu-perf-dependencies sounds good enough
> to me as well.

+1

Regards,
Lukasz

> 
> Thanks,
> Ionela.
> 
>> -- 
>> Regards,
>> Sudeep
