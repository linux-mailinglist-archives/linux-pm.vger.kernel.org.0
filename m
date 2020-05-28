Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A641E5BDB
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 11:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgE1J3i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 05:29:38 -0400
Received: from foss.arm.com ([217.140.110.172]:49970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbgE1J3i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 May 2020 05:29:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA5B431B;
        Thu, 28 May 2020 02:29:37 -0700 (PDT)
Received: from [10.37.12.44] (unknown [10.37.12.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 304353F6C4;
        Thu, 28 May 2020 02:29:34 -0700 (PDT)
Subject: Re: [RFC] GPU-bound energy efficiency improvements for the
 intel_pstate driver (v2.99)
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Francisco Jerez <currojerez@riseup.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
References: <20200428032258.2518-1-currojerez@riseup.net>
 <20200511105701.GA2940@hirez.programming.kicks-ass.net>
 <874ksmuqx6.fsf@riseup.net> <jhjwo5erb0e.mognet@arm.com>
 <87a72at44d.fsf@riseup.net> <jhjv9kxqdcf.mognet@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d6ad1c7e-7bce-4f16-3606-a9777ac07cc1@arm.com>
Date:   Thu, 28 May 2020 10:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <jhjv9kxqdcf.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/15/20 7:09 PM, Valentin Schneider wrote:
> 
> On 15/05/20 01:48, Francisco Jerez wrote:
>> Valentin Schneider <valentin.schneider@arm.com> writes:
>>
>>> (+Lukasz)
>>>
>>> On 11/05/20 22:01, Francisco Jerez wrote:
>>>>> What I'm missing is an explanation for why this isn't using the
>>>>> infrastructure that was build for these kinds of things? The thermal
>>>>> framework, was AFAIU, supposed to help with these things, and the IPA
>>>>> thing in particular is used by ARM to do exactly this GPU/CPU power
>>>>> budget thing.
>>>>>
>>>>> If thermal/IPA is found wanting, why aren't we improving that?
>>>>
>>>> The GPU/CPU power budget "thing" is only a positive side effect of this
>>>> series on some TDP-bound systems.  Its ultimate purpose is improving the
>>>> energy efficiency of workloads which have a bottleneck on a device other
>>>> than the CPU, by giving the bottlenecking device driver some influence
>>>> over the response latency of CPUFREQ governors via a PM QoS interface.
>>>> This seems to be completely outside the scope of the thermal framework
>>>> and IPA AFAIU.
>>>>
>>>
>>> It's been a while since I've stared at IPA, but it does sound vaguely
>>> familiar.
>>>
>>> When thermally constrained, IPA figures out a budget and splits it between
>>> actors (cpufreq and devfreq devices) depending on how much juice they are
>>> asking for; see cpufreq_get_requested_power() and
>>> devfreq_cooling_get_requested_power(). There's also some weighing involved.
>>>
>>
>> I'm aware of those.  Main problem is that the current mechanism for IPA
>> to figure out the requested power of each actor is based on a rough
>> estimate of their past power consumption: If an actor was operating at a
>> highly energy-inefficient regime it will end up requesting more power
>> than another actor with the same load but more energy-efficient
>> behavior.

This can be tweaked by changing the weight of an actor (unfortunately
not in a real-time by kernel). We usually setup them once, in DT.
So, it's possible to set different weight for the LITTLE cores (which
are more energy-efficient) and the big cores (in a good way or bad).

> 
> Right, we do mix load (busy time for either cpufreq and devfreq devices
> AFAIR) and current state (freq) into one single power value.
> 
>> The IPA power allocator is therefore ineffective at improving
>> the energy efficiency of an agent beyond its past behavior --
>> Furthermore it seems to *rely* on individual agents being somewhat
>> energetically responsible in order for its power allocation result to be
>> anywhere close to optimal.  But improving the energy efficiency of an
>> agent seems useful in its own right, whether IPA is used to balance
>> power across agents or not.  That's precisely the purpose of this
>> series.

I don't fully agree here, i.e. in a properly setup platform we promote
more energy-efficient LITTLE cores when there is a limited power budget. 
That would cause capping on big cores and scheduler should see it.
There are some limitations in the IPA, but the requirements where
different back then, mainline code was different, etc.

>>
>>> If you look at the cpufreq cooling side of things, you'll see it also uses
>>> the PM QoS interface. For instance, should IPA decide to cap the CPUs
>>> (perhaps because say the GPU is the one drawing most of the juice), it'll
>>> lead to a maximum frequency capping request.
>>>
>>> So it does sound like that's what you want, only not just when thermally
>>> constrained.
>>
>> Capping the CPU frequency from random device drivers is highly
>> problematic, because the CPU is a shared resource which a number of
>> different concurrent applications might be using beyond the GPU client.
>> The GPU driver has no visibility over its impact on the performance of
>> other applications.  And even in a single-task environment, in order to
>> behave as effectively as the present series the GPU driver would need to
>> monitor the utilization of *all* CPUs in the system and place a
>> frequency constraint on each one of them (since there is the potential
>> of the task scheduler migrating the process from one CPU to another
>> without notice).  Furthermore these frequency constraints would need to
>> be updated at high frequency in order to avoid performance degradation
>> whenever the balance of load between CPU and IO device fluctuates.
>>
>> The present series attempts to remove the burden of computing frequency
>> constraints out of individual device drivers into the CPUFREQ governor.
>> Instead the device driver provides a response latency constraint when it
>> encounters a bottleneck, which can be more easily derived from hardware
>> and protocol characteristics than a CPU frequency.  PM QoS aggregates
>> the response latency constraints provided by all applications and gives
>> CPUFREQ a single response latency target compatible with all of them (so
>> a device driver specifying a high latency target won't lead to
>> performance degradation in a concurrent application with lower latency
>> constraints).  The CPUFREQ governor then computes frequency constraints
>> for each CPU core that minimize energy usage without limiting
>> throughput, based on the results obtained from CPU performance counters,
>> while guaranteeing that a discontinuous transition in CPU utilization
>> leads to a proportional transition in the CPU frequency before the
>> specified response latency has elapsed.
> 
> Right, I think I see your point there. I'm thinking the 'actual' IPA gurus
> (Lukasz or even Javi) may want to have a look at this.
> 

This patch set AFAIU has different goals than IPA or any other thermal
governor.

I don't know the details of this Intel platform and the mechanisms
which are there for thermal and power budget, so I might be wrong in
some points (correct me where needed).

Main differences comparing to IPA in regards the platform:
- the series works on a platform which does not actually control the
frequency (AFAIK Intel freq can be changed by FW due to any reason).
IPA has been designed for platform which has full control over the
frequency.
- It does not work on Heterogeneous CPUs.
IPA is aware of big, LITTLE or even a different tracks used
- this patch set ignores the temperature probably assuming it is done
by something else (FW or thermal governor).
IPA has the PID built on top of temp sensor and must control it.

Different platforms, different behaviors, different requirements.
I agree IPA has to catch up with the new mainline solutions, though.

Regards,
Lukasz

