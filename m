Return-Path: <linux-pm+bounces-40892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD6ED221D8
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 03:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56107302AB9B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 02:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4F6226D00;
	Thu, 15 Jan 2026 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="o7v7lRLn";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="o7v7lRLn"
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB491A9FAB;
	Thu, 15 Jan 2026 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768443928; cv=none; b=qUOuDRrF54lm9YHui08D8EYLONSlYb0QvO2Yde9yAXfOWAJ8UncGsxL5/EcWj0q+aKJkGsnbb6A+EiQou5D9TEO+HEiIVo08UvtFC27QYVNdP/0Ww/PiYyDn7UZ83DOqm/MXedNxpuzghGA4NviI2e7m2FHASZbTozhWfZW4bRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768443928; c=relaxed/simple;
	bh=tePjPvbmp4Qs1vhN2jR7PpXRHE++IOgnVollqsLZtFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XcVRQNkBL6pkilveuHGAOtWkAz9tS1kps6nvvGmWHnqguqlB78si8Ca8X8vTdQQinW+/dCA3fuR53ro8dL0CPLi+lg9IZU1MbKdYYQvuEUS2Y3xN6y0i2VHyA/iSb8Jiv66X6nH1n+wHKFSKIvyKXnTAGFZSyOkSsg95waefYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=o7v7lRLn; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=o7v7lRLn; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=saUFQL/g3cE6eKk5bEpIBTIyqlTH6MdFAEJ77L3z1/4=;
	b=o7v7lRLn/ff3XvoCvFH3aDjlQycO2IqBk7/jeTbl/HOF7oj9c3csxJ3vAZxDNfjofQHIMBWxX
	d3HnuF7CKb9eNvaLphCDrLRJO6M2CvJaCgv95MxIofbyeAivVlcdjv+Md2ap2Y+RDErx65yvIA7
	dppsVbA7zIso74B4YtOSoro=
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4ds6Jl0kFpz1BG0T;
	Thu, 15 Jan 2026 10:25:11 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=saUFQL/g3cE6eKk5bEpIBTIyqlTH6MdFAEJ77L3z1/4=;
	b=o7v7lRLn/ff3XvoCvFH3aDjlQycO2IqBk7/jeTbl/HOF7oj9c3csxJ3vAZxDNfjofQHIMBWxX
	d3HnuF7CKb9eNvaLphCDrLRJO6M2CvJaCgv95MxIofbyeAivVlcdjv+Md2ap2Y+RDErx65yvIA7
	dppsVbA7zIso74B4YtOSoro=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ds6F1038GzmVXv;
	Thu, 15 Jan 2026 10:21:57 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B90C402AB;
	Thu, 15 Jan 2026 10:25:17 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Jan
 2026 10:25:16 +0800
Message-ID: <41b7398c-b1a4-4b87-b6f9-07eacf4f4752@huawei.com>
Date: Thu, 15 Jan 2026 10:25:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPOST PATCH v6 3/3] arm64: topology: Handle AMU FIE setup on
 CPU hotplug
To: Geert Uytterhoeven <geert@linux-m68k.org>, Beata Michalska
	<beata.michalska@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <sudeep.holla@arm.com>,
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, <ionela.voinescu@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<vincent.guittot@linaro.org>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, Linux-Renesas
	<linux-renesas-soc@vger.kernel.org>
References: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
 <20251230080115.2120612-4-zhenglifeng1@huawei.com>
 <CAMuHMdVeHk-Enc-M9ztwSdeAtE8YPKtJwq+273bGPEFOEsu=Rw@mail.gmail.com>
 <aWZriVlQZ5jRx2o4@arm.com>
 <CAMuHMdVgbQnaCQ8U8FK6J1vJLsqc0_MC7zSTX2B=rsuF2kpEKg@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAMuHMdVgbQnaCQ8U8FK6J1vJLsqc0_MC7zSTX2B=rsuF2kpEKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2026/1/14 21:54, Geert Uytterhoeven wrote:
> Hi Beata,
> 
> On Tue, 13 Jan 2026 at 16:58, Beata Michalska <beata.michalska@arm.com> wrote:
>> On Tue, Jan 13, 2026 at 11:51:45AM +0100, Geert Uytterhoeven wrote:
>>> On Tue, 30 Dec 2025 at 09:02, Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>>> Currently, when a cpufreq policy is created, the AMU FIE setup process
>>>> checks all CPUs in the policy -- including those that are offline. If any
>>>> of these CPUs are offline at that time, their AMU capability flag hasn't
>>>> been verified yet, leading the check fail. As a result, AMU FIE is not
>>>> enabled, even if the CPUs that are online do support it.
>>>>
>>>> Later, when the previously offline CPUs come online and report AMU support,
>>>> there's no mechanism in place to re-enable AMU FIE for the policy. This
>>>> leaves the entire frequency domain without AMU FIE, despite being eligible.
>>>>
>>>> Restrict the initial AMU FIE check to only those CPUs that are online at
>>>> the time the policy is created, and allow CPUs that come online later to
>>>> join the policy with AMU FIE enabled.
>>>>
>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>> Acked-by: Beata Michalska <beata.michalska@arm.com>
>>>
>>> Thanks for your patch, which is now commit 6fd9be0b7b2e957d
>>> ("arm64: topology: Handle AMU FIE setup on CPU hotplug") in
>>> arm64/for-next/core (next-20260107 and later).
>>>
>>>> --- a/arch/arm64/kernel/topology.c
>>>> +++ b/arch/arm64/kernel/topology.c
>>>> @@ -284,7 +284,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
>>>>         struct cpufreq_policy *policy = data;
>>>>
>>>>         if (val == CPUFREQ_CREATE_POLICY)
>>>> -               amu_fie_setup(policy->related_cpus);
>>>> +               amu_fie_setup(policy->cpus);
>>>>
>>>>         /*
>>>>          * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
>>>> @@ -303,10 +303,71 @@ static struct notifier_block init_amu_fie_notifier = {
>>>>         .notifier_call = init_amu_fie_callback,
>>>>  };
>>>>
>>>> +static int cpuhp_topology_online(unsigned int cpu)
>>>> +{
>>>> +       struct cpufreq_policy *policy = cpufreq_cpu_policy(cpu);
>>>> +
>>>> +       /* Those are cheap checks */
>>>> +
>>>> +       /*
>>>> +        * Skip this CPU if:
>>>> +        *  - it has no cpufreq policy assigned yet,
>>>> +        *  - no policy exists that spans CPUs with AMU counters, or
>>>> +        *  - it was already handled.
>>>> +        */
>>>> +       if (unlikely(!policy) || !cpumask_available(amu_fie_cpus) ||
>>>> +           cpumask_test_cpu(cpu, amu_fie_cpus))
>>>> +               return 0;
>>>> +
>>>> +       /*
>>>> +        * Only proceed if all already-online CPUs in this policy
>>>> +        * support AMU counters.
>>>> +        */
>>>> +       if (unlikely(!cpumask_subset(policy->cpus, amu_fie_cpus)))
>>>> +               return 0;
>>>> +
>>>> +       /*
>>>> +        * If the new online CPU cannot pass this check, all the CPUs related to
>>>> +        * the same policy should be clear from amu_fie_cpus mask, otherwise they
>>>> +        * may use different source of the freq scale.
>>>> +        */
>>>> +       if (!freq_counters_valid(cpu)) {
>>>> +               pr_warn("CPU[%u] doesn't support AMU counters\n", cpu);
>>>
>>> This is triggered during resume from s2ram on Renesas R-Car H3
>>> (big.LITTLE 4x Cortex-A57 + 4x Cortex-A53), when enabling the first
>>> little core:
>>>
>>>     AMU: CPU[4] doesn't support AMU counters
>>>
>>> Adding debug code:
>>>
>>>     pr_info("Calling
>>> topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, %*pbl)\n",
>>> cpumask_pr_args(policy->related_cpus));
>>>     pr_info("Calling cpumask_andnot(..., %*pbl, %*pbl)\n",
>>> cpumask_pr_args(amu_fie_cpus), cpumask_pr_args(policy->related_cpus));
>>>
>>> gives:
>>>
>>>     AMU: Calling topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, 4-7)
>>>     AMU: Calling cpumask_andnot(..., , 4-7)
>>>
>>> so AMU is disabled for all little cores.
>>>
>>> Since this only happens during s2ram, and not during initial CPU
>>> bring-up on boot, this looks wrong to me?
>> This does look rather surprising. If that CPU was marked as supporting AMUs at
>> the initial bring-up it should be part of amu_fie_cpus mask, so the hp callback
>> should bail out straight away. Would you be able to add some logs to see what
>> that mask actually contains ?
>> Furthermore, freq_counters_valid is logging issues when validating the counters.
>> Would you be able to re-run it with the debug level to see what might be
>> happening under the hood, although I am still unsure why it is even reaching
>> that point ...
> 
> Adding extra debugging info, and "#define DEBUG" at the top.
> 
> During boot:
> 
>     AMU: amu_fie_setup:260: cpus 0-3 amu_fie_cpus
>     ^^^ empty amu_fie_cpus
>     AMU: CPU0: counters are not supported.
>     ^^^ pr_debug
>     AMU: amu_fie_setup:260: cpus 4-7 amu_fie_cpus
>     ^^^ empty amu_fie_cpus
>     AMU: CPU4: counters are not supported.
>     ^^^ pr_debug
> 
> During resume from s2ram:
> 
>     AMU: cpuhp_topology_online:314: cpu 1 amu_fie_cpus
>     AMU: cpuhp_topology_online:343: skipped
> (!cpumask_subset(policy->cpus, amu_fie_cpus))
>     AMU: cpuhp_topology_online:314: cpu 2 amu_fie_cpus
>     AMU: cpuhp_topology_online:343: skipped
> (!cpumask_subset(policy->cpus, amu_fie_cpus))
>     AMU: cpuhp_topology_online:314: cpu 3 amu_fie_cpus
>     AMU: cpuhp_topology_online:343: skipped
> (!cpumask_subset(policy->cpus, amu_fie_cpus))
>     AMU: cpuhp_topology_online:314: cpu 4 amu_fie_cpus
>     AMU: CPU4: counters are not supported.
>     ^^^ pr_debug
>     AMU: CPU[4] doesn't support AMU counters
>     ^^^ pr_warn
>     AMU: Calling topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, 4-7)
>     AMU: Calling cpumask_andnot(..., , 4-7)

Something strange here. If AMU is not supported at all, amu_fie_cpus should
never be available and cpuhp_topology_online() should return in the first
'if'. Why it runs this far?

>     AMU: cpuhp_topology_online:314: cpu 5 amu_fie_cpus
>     AMU: cpuhp_topology_online:343: skipped
> (!cpumask_subset(policy->cpus, amu_fie_cpus))
>     AMU: cpuhp_topology_online:314: cpu 6 amu_fie_cpus
>     AMU: cpuhp_topology_online:343: skipped
> (!cpumask_subset(policy->cpus, amu_fie_cpus))
>     AMU: cpuhp_topology_online:314: cpu 7 amu_fie_cpus
>     AMU: cpuhp_topology_online:343: skipped
> (!cpumask_subset(policy->cpus, amu_fie_cpus))
> 
> Hence there is no issue, as AMU is not supported at all!
> 
> The confusing part is in the (absence of) logging.
> If AMU is not supported, freq_counters_valid() uses:
> 
>      pr_debug("CPU%d: counters are not supported.\n", cpu);
> 
> which is typically not printed, unless DEBUG is enabled.
> 
> If freq_counters_valid() failed, the new cpuhp_topology_online() uses:
> 
>     pr_warn("CPU[%u] doesn't support AMU counters\n", cpu);
> 
> which is always printed.
> 
> Given freq_counters_valid() already prints a (debug) message, I think
> the pr_warn() should just be removed.  Do you agree, or is there still
> another incorrect check that should prevent getting this far?

I'm OK with removing it.

> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


