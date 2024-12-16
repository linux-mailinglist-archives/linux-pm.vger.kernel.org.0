Return-Path: <linux-pm+bounces-19316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2F9F3493
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3E51887E10
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 15:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C75136349;
	Mon, 16 Dec 2024 15:33:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB417C64;
	Mon, 16 Dec 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363183; cv=none; b=ESrJNMgSgWjRQqIj2O7rsi9YmkpY5G729FABRem/06X9B8HwzwA5a0nokSIQvlq0MHmOgCCRv7SfFbUWUSMO2JJCouAH1dHQi2rZcn4ZaTmtl7vZCB4HhFActOyq4FhcI5Nuw8y2y2qYC6HdedX5hxrgvULqi2hzNEIHSofBKB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363183; c=relaxed/simple;
	bh=FIjk2JadPX3SOeaRmRdQ5IzfvRfOxxHL8+Hs00XtXWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4KFnTohkXzN1qKVer4CMb8Sd/np1Fb4U2TS7ZpPpDu/knBMdyX40qbLrYcjQW0N3dy46MnM0fpT8pXa07GHrcx7KtsK55u47Zx9+CXlQIZKdeF8ohO1CGCz2wHmFbgZWOppYb2IIjfjMCz9DrMpASO3IAh1M8aL0vaR6cQIcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69396113E;
	Mon, 16 Dec 2024 07:33:28 -0800 (PST)
Received: from [10.57.62.54] (unknown [10.57.62.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A19B53F528;
	Mon, 16 Dec 2024 07:32:57 -0800 (PST)
Message-ID: <c920700c-9969-4c23-a1fc-a88c87dc98a6@arm.com>
Date: Mon, 16 Dec 2024 16:32:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v0.1 6/6] cpufreq: intel_pstate: Add basic EAS
 support on hybrid platforms
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <len.brown@intel.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Christian Loehle <Christian.Loehle@arm.com>
References: <3607404.iIbC2pHGDl@rjwysocki.net>
 <115421572.nniJfEyVGO@rjwysocki.net>
 <2b0953b5-4978-446a-b686-5b8d1541a265@arm.com>
 <CAJZ5v0hH424_4N1TZVVgKCegUsAisjdAXr7KekafJteSSLEnHA@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAJZ5v0hH424_4N1TZVVgKCegUsAisjdAXr7KekafJteSSLEnHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/19/24 18:20, Rafael J. Wysocki wrote:
> On Mon, Nov 18, 2024 at 5:34 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>>
>>
>> On 11/8/24 17:46, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Modify intel_pstate to register stub EM perf domains for CPUs on
>>> hybrid platforms via em_dev_register_perf_domain() and to use
>>> em_dev_expand_perf_domain() introduced previously for adding new
>>> CPUs to existing EM perf domains when those CPUs become online for
>>> the first time after driver initialization.
>>>
>>> This change is targeting platforms (for example, Lunar Lake) where
>>> "small" CPUs (E-cores) are always more energy-efficient than the "big"
>>> or "performance" CPUs (P-cores) when run at the same HWP performance
>>> level, so it is sufficient to tell the EAS that E-cores are always
>>> preferred (so long as there is enough spare capacity on one of them
>>> to run the given task).
>>>
>>> Accordingly, the perf domains are registered per CPU type (that is,
>>> all P-cores belong to one perf domain and all E-cores belong to another
>>> perf domain) and they are registered only if asymmetric CPU capacity is
>>> enabled.  Each perf domain has a one-element states table and that
>>> element only contains the relative cost value (the other fields in
>>> it are not initialized, so they are all equal to zero), and the cost
>>> value for the E-core perf domain is lower.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>    drivers/cpufreq/intel_pstate.c |  110 ++++++++++++++++++++++++++++++++++++++---
>>>    1 file changed, 104 insertions(+), 6 deletions(-)
>>>
>>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
>>> @@ -8,6 +8,7 @@
>>>
>>>    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>
>>> +#include <linux/energy_model.h>
>>>    #include <linux/kernel.h>
>>>    #include <linux/kernel_stat.h>
>>>    #include <linux/module.h>
>>> @@ -938,6 +939,12 @@ static struct freq_attr *hwp_cpufreq_att
>>>        NULL,
>>>    };
>>>
>>> +enum hybrid_cpu_type {
>>> +     HYBRID_PCORE = 0,
>>> +     HYBRID_ECORE,
>>> +     HYBRID_NR_TYPES
>>> +};
>>> +
>>>    static struct cpudata *hybrid_max_perf_cpu __read_mostly;
>>>    /*
>>>     * Protects hybrid_max_perf_cpu, the capacity_perf fields in struct cpudata,
>>> @@ -945,6 +952,86 @@ static struct cpudata *hybrid_max_perf_c
>>>     */
>>>    static DEFINE_MUTEX(hybrid_capacity_lock);
>>>
>>> +#ifdef CONFIG_ENERGY_MODEL
>>> +struct hybrid_em_perf_domain {
>>> +     cpumask_t cpumask;
>>> +     struct device *dev;
>>> +     struct em_data_callback cb;
>>> +};
>>> +
>>> +static int hybrid_pcore_cost(struct device *dev, unsigned long freq,
>>> +                          unsigned long *cost)
>>> +{
>>> +     /*
>>> +      * The number used here needs to be higher than the analogous
>>> +      * one in hybrid_ecore_cost() below.  The units and the actual
>>> +      * values don't matter.
>>> +      */
>>> +     *cost = 2;
>>> +     return 0;
>>> +}
>>> +
>>> +static int hybrid_ecore_cost(struct device *dev, unsigned long freq,
>>> +                          unsigned long *cost)
>>> +{
>>> +     *cost = 1;
>>> +     return 0;
>>> +}
>>
>> The artificial EM was introduced for CPPC based platforms since these platforms
>> only provide an 'efficiency class' entry to describe the relative efficiency
>> of CPUs. The case seems similar to yours.
> 
> It is, but I don't particularly like the CPPC driver's approach to this.
> 
>> 'Fake' OPPs were created to have an incentive for EAS to balance the load on
>> the CPUs in one perf. domain. Indeed, in feec(), during the energy
>> computation of a pd, if the cost is independent from the max_util value,
>> then one CPU in the pd could end up having a high util, and another CPU a
>> NULL util.
> 
> Isn't this a consequence of disabling load balancing by EAS?

Yes. Going in that direction, this patch from Vincent should help balancing
the load in your case I think. The patch evaluates other factors when the energy
cost of multiple CPU-candidates is the same.

Meaning, if all CPUs of the same type have only one OPP, the number of tasks
and the the load of the CPUs is then compared. This is not the case currently.
Doing so will help to avoid having one CPU close to being overutilized while
others are idle.

However I think it would still be better to have multiple OPPs in the energy model.
Indeed, it would be closer to reality as I assume that for Intel aswell, there
might be frequency domains and the frequency of the domain is lead by the most
utilized CPU.
This would also avoid hitting corner cases. As if there is one big task and many
small tasks, balancing on the number of tasks per CPU is not the best idea.

https://lore.kernel.org/all/20240830130309.2141697-4-vincent.guittot@linaro.org/

> 
>> For CPPC platforms, this was problematic as a lower OPP could have been
>> selected for the same load, so energy was lost for no reason.
>>
>> In your case it seems that the OPP selection is done independently on each
>> CPU. However I assume it is still more energy efficient to have 2 CPUs
>> loaded at 50% than one CPU loaded at 100% and an idle CPU.
> 
> Maybe.
> 
> It really depends on the cost of the idle state etc.
> 
>> Also as Dietmar suggested, maybe it would make sense to have some
>> way to prefer an CPU with a "energy saving" HFI configuration than
>> a similar CPU with a "performance" HFI configuration.
> 
> As it happens, E-cores have higher energy-efficiency scores in HFI AFAICS.
> 
>> Also, out of curiosity, do you have energy numbers to share ?
> 
> Not yet, but there will be some going forward.
> 
> Thanks!

