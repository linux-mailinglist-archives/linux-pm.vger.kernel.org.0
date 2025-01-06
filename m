Return-Path: <linux-pm+bounces-19987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3013A02612
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 14:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC6D3A2100
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13B7433CB;
	Mon,  6 Jan 2025 13:00:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC6433CE;
	Mon,  6 Jan 2025 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168405; cv=none; b=cWj5A7Hxdp88l8jrO4J+XZWscbSslLu5MLJhXsF64Qd/yybflWyerVPFNyXb3/AeyHPvs4dPGPP1u76vnddVy4iT8swryLaYvolzxrYnvOVm/U5Y4ufGCM5RGyDkkLEjYlXTHNTRB3dCUX8jUS0+TMxn+MMWUkojevejouB3W3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168405; c=relaxed/simple;
	bh=wWWYHuaeWue2phOpJDTdfIEQY2PQpM/yv1lFi7COY4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WklZlLEuq0zuSPblkAcdpnwWmDQBJ2uiWUIJM5XfzUQ1D+iSBFRT+atsnhXMTRhdhy1df/vn5qwDqjkbFrSx8fFQruiGL+Xn2S9etfDtV1oHUMnS0xPb1etjGeyKO8VfyB6cIRqtvXGHzNDN+A+BSXNdMsK8rdXa+YgRC8yQi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1B7E143D;
	Mon,  6 Jan 2025 05:00:30 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C969C3F673;
	Mon,  6 Jan 2025 05:00:00 -0800 (PST)
Message-ID: <8f26fac2-787d-44a9-a0cd-c3035a91149c@arm.com>
Date: Mon, 6 Jan 2025 13:59:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v021 5/9] PM: EM: Introduce
 em_dev_expand_perf_domain()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
 <3353401.44csPzL39Z@rjwysocki.net>
 <31c86834-273b-458f-9914-eff76c283cfb@arm.com>
 <CAJZ5v0jus4bzeZhUK4WC7uypQkh-_MMuU1M54figsGV3+5OhUg@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0jus4bzeZhUK4WC7uypQkh-_MMuU1M54figsGV3+5OhUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/12/2024 21:40, Rafael J. Wysocki wrote:
> On Tue, Dec 17, 2024 at 10:38 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 29/11/2024 17:02, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Introduce a helper function for adding a CPU to an existing EM perf
>>> domain.
>>>
>>> Subsequently, this will be used by the intel_pstate driver to add new
>>> CPUs to existing perf domains when those CPUs go online for the first
>>> time after the initialization of the driver.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> v0.1 -> v0.2: No changes
>>
>> Could you add information why this new EM interface is needed?
> 
> There is some of it in the changelog already.
> 
> In fact, it is only needed in a corner case when the system starts
> with some CPUs offline and they only go online later (as a result of
> an explicit request from user space).  That is the only case when a
> new CPU may need to be added to an existing perf domain.

OK, I see. Arm doesn't need this since we derive the masks from the
CPUfreq policies so far.

I just verified, we both keep hotplugged-out CPU within the PD. That's
why we mask the PD cpus with cpu_online_mask in:

find_energy_efficient_cpu()

  ...

  for (; pd; pd = pd->next)

    cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);

>> IIRC, you can't use the existing way (cpufreq_driver::register_em) since
>> it gets called to early (3) for the PD cpumasks to be ready. This issue
>> will be there for any system in which uarch domains are not congruent
>> with clock domains which we hadn't have to deal with Arm's heterogeneous
>> CPUs so far.
> 
> Basically, yes.
> 
>> __init intel_pstate_init()
>>
>>   intel_pstate_register_driver()
>>
>>     cpufreq_register_driver()
>>
>>       subsys_interface_register()
>>
>>         sif->add_dev() -> cpufreq_add_dev()
>>
>>           cpufreq_online()
>>
>>             if (!new_policy && cpufreq_driver->online)
>>
>>             else
>>
>>               cpufreq_driver->init() -> intel_pstate_cpu_init()
>>
>>                 __intel_pstate_cpu_init()
>>
>>                   intel_pstate_init_cpu()
>>
>>                     intel_pstate_get_cpu_pstates()
>>
>>                       hybrid_add_to_domain()
>>
>>                         em_dev_expand_perf_domain()              <-- (1)
>>
>>                   intel_pstate_init_acpi_perf_limits()
>>
>>                     intel_pstate_set_itmt_prio()                 <-- (2)
>>
>>             if (new_policy)
>>
>>               cpufreq_driver->register_em()                      <-- (3)
>>
>>     hybrid_init_cpu_capacity_scaling()
>>
>>       hybrid_refresh_cpu_capacity_scaling()
>>
>>         __hybrid_refresh_cpu_capacity_scaling()                  <-- (4)
>>
>>         hybrid_register_all_perf_domains()
>>
>>           hybrid_register_perf_domain()
>>
>>             em_dev_register_perf_domain()                        <-- (5)
>>
>>       /* Enable EAS */
>>       sched_clear_itmt_support()                                 <-- (6)
>>
>> Debugging this on a 'nosmt' i7-13700K (online mask =
>> [0,2,4,6,8,10,12,14,16-23]
>>
>> (1) Add CPU to existing hybrid PD or create new hybrid PD.
> 
> Not exactly.
> 
> (1) is just to expand an existing perf domain if the CPU is new (was
> offline all the time previously).

OK.

> 
> Likewise, the direct hybrid_register_perf_domain() call in
> hybrid_add_to_domain() is to add a new perf domain if the given CPU is
> new (was offline all the time previously) and is the first one of the
> given type (say, the system is starting with all E-cores offline).
> It won't succeed before (4).
> 
> For CPUs that are online to start with, hybrid_add_to_domain() assigns
> them to hybrid domains and PDs are created for them in
> hybrid_register_all_perf_domains().

Understood.

> 
>> (2) Triggers sched domain rebuild (+ enabling EAS) already here during
>>     startup ?
> 
> This is just to enable ITMT which is the default mechanism for Intel
> hybrid platforms.  It also requires a rebuild of sched domains to be
> enabled.
> 
>>     IMHO, reason is that max_highest_perf > min_highest_perf because of
>>     different itmt prio
> 
> Yes (which means that the platform is at least not homogenous).
> 
> This really has been introduced for the handling of favored cores on
> otherwise non-hybrid platforms (say Tiger Lake).
> 
>>     Happens for CPU8 on my machine (after CPU8 is added to hybrid PD
>>     0,2,4,6,8) (itmt prio for CPU8=69 (1024) instead of 68 (1009)).
>>     So it looks like EAS is enabled before (6) ?
> 
> No, it is ITMT because CPU8 is a favored core.
> 
>> (3) ARM's way to do (5)
>> (4) Setting hybrid_max_perf_cpu
>> (5) Register EM here
>> (6) Actual call to initially triggers sched domain rebuild (+ enable
>>     EAS) (done already in (2) on my machine)
> 
> This is the second rebuild of sched domains to turn off ITMT and
> enable EAS.  The previous one is to enable ITMT.
> 
> The earlier enabling of ITMT could be avoided I think, but that would
> be a complication on platforms that contain favored cores but
> otherwise are not hybrid.

OK, the fact that EAS will already be enabled in (2) is not an issue IMHO.

> 
>> So (3) is not possible for Intel hybrid since the policy's cpumask(s)
> 
> It is possible in principle, but not particularly convenient because
> at that point it is not clear whether or not the platform is really
> hybrid and SMT is off and so whether or not EAS is to be used.
> 
>> contain only one CPUs, i.e. CPUs are not sharing clock.
>> And those cpumasks have to be build under (1) to be used in (5)?
> 
> They are built by the caller of (1) to be precise, but yes.

OK.

I still see an issue in putting all performance CPUs in one PD.

find_energy_efficient_cpu() assumes that all PD CPUs has the same CPU
capacity value.

  find_energy_efficient_cpu()

    ...

    for (; pd; pd = pd->next) {

      ...
      /* Account external pressure for the energy estimation */
      cpu = cpumask_first(cpus);
      cpu_actual_cap = get_actual_cpu_capacity(cpu); --> (1)


Even though X86 does not implement hw_load_avg() or
cpufreq_get_pressure() we would still assume that all PD CPUs have the
same cpu_capacity:


  get_actual_cpu_capacity() <-- (1)

    capacity = arch_scale_cpu_capacity(cpu)


Now the error introduced is small (1024 versus 1009) on my i7-13700K but
it's there. How big can those diffs based om itmt prio be?

