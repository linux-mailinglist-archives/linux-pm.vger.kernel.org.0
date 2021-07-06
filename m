Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6273BDAC6
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 17:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhGFP6p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 11:58:45 -0400
Received: from foss.arm.com ([217.140.110.172]:45610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhGFP6p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 11:58:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24973106F;
        Tue,  6 Jul 2021 08:56:06 -0700 (PDT)
Received: from [10.57.7.228] (unknown [10.57.7.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03AE03F73B;
        Tue,  6 Jul 2021 08:56:03 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/6] Introduce Active Stats framework with CPU
 performance statistics
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>, Beata.Michalska@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kachhap <amit.kachhap@gmail.com>
References: <20210706131828.22309-1-lukasz.luba@arm.com>
 <CAJZ5v0ga1O9Y9Lam=BoXofE7sjTNpYVSTjAWvSGZ+j__aCeXJw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1de9d474-fdeb-8db6-0b01-53a90f7c20c8@arm.com>
Date:   Tue, 6 Jul 2021 16:56:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ga1O9Y9Lam=BoXofE7sjTNpYVSTjAWvSGZ+j__aCeXJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/6/21 4:28 PM, Rafael J. Wysocki wrote:
> On Tue, Jul 6, 2021 at 3:18 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi all,
>>
>> This patch set introduces a new mechanism: Active Stats framework (ASF), which
>> gathers and maintains statistics of CPU performance - time residency at each
>> performance state.
>>
>> The ASF tracks all the frequency transitions as well as CPU
>> idle entry/exit events for all CPUs. Based on that it accounts the active
>> (non-idle) residency time for each CPU at each frequency. This information can
>> be used by some other subsystems (like thermal governor) to enhance their
>> estimations about CPU usage at a given period.
> 
> This seems to mean that what is needed is something like the cpufreq
> stats but only collected during the time when CPUs are not in idle
> states.

Yes

> 
>> Does it fix something in mainline?
>> Yes, there is thermal governor Intelligent Power Allocation (IPA), which
>> estimates the CPUs power used in the past. IPA is sampling the CPU utilization
>> and frequency and relies on the info available at the time of sampling
>> and this imposes the estimation errors.
>> The use of ASF solve the issue and enables IPA to make better estimates.
> 
> Obviously the IPA is not used on all platforms where cpufreq and
> cpuidle are used.  What platforms are going to benefit from this
> change?

Arm platforms which still use kernel thermal to control temperature,
such as Chromebooks or mid-, low-end phones.

> 
>> Why it couldn't be done using existing frameworks?
>> The CPUFreq and CPUIdle statistics are not combined, so it is not possible
>> to derive the information on how long exactly the CPU was running with a given
>> frequency.
> 
> But it doesn't mean that the statistics could not be combined.
> 
> For instance, the frequency of the CPU cannot change via cpufreq when
> active_stats_cpu_idle_enter() is running, so instead of using an
> entirely new framework for collecting statistics it might update the
> existing cpufreq stats to register that event.

True, but keep in mind that the cpufreq most likely works for a few
CPUs (policy::related_cpus), while cpuidle in a per-cpu fashion.
I would say that cpuidle should check during enter/exit what is
the currently set frequency for cluster and account its active
period.

> 
> And analogously for the wakeup.
> 
>> This new framework combines that information and provides
>> it in a handy way.
> 
> I'm not convinced about the last piece.

The handy structure is called Active Stats Monitor. It samples
the stats gathered after processing idle. That private
structure maintains statistics which are for a given period
(current snapshot - previous snapshot).

> 
>> IMHO it has to be implemented as a new framework, next to
>> CPUFreq and CPUIdle, due to a clean design and not just hooks from thermal
>> governor into the frequency change and idle code paths.
> 
> As far as the design is concerned, I'm not sure if I agree with it.
> 
>  From my perspective it's all a 1000-line patch that I have to read and
> understand to figure out what the design is.

I can help you with understanding it with some design docs if you want.

> 
>> Tha patch 4/6 introduces a new API for cooling devices, which allows to
>> stop tracking the freq and idle statistics.
>>
>> The patch set contains also a patches 5/6 6/6 which adds the new power model
>> based on ASF into the cpufreq cooling (used by thermal governor IPA).
>> It is added as ifdef option, since Active Stats might be not compiled in.
>> The ASF is a compile time option, but that might be changed and IPA could
>> select it, which would allow to remove some redundant code from
>> cpufreq_cooling.c.
>>
>> Comments and suggestions are very welcome.
> 
> I'm totally not convinced that it is necessary to put the extra 1000
> lines of code into the kernel to address the problem at hand.
> 

I understand your concerns. If you have another idea than this framework
I'm happy to hear it. Maybe better stats in cpuidle, which would be
are of the cpufreq?



