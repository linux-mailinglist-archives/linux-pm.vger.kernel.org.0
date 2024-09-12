Return-Path: <linux-pm+bounces-14099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C10D976E56
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 18:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57631F21D18
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6714A78289;
	Thu, 12 Sep 2024 16:01:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7766F43144;
	Thu, 12 Sep 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156900; cv=none; b=lSAa32iRmt/CULHKeWdjiFSRyOHtE0yW5ObGcjfaOOFr2Zl6/MLXhrfDNznRgo20oSGcQIU0f3sTJlK5jDJeZT6j2giwxQGquBGogrxwcdV8yGTxWrMPVWRZOMR0+6azd/c31HuAUVMzzvI0ka29ESYda7i78V9Z06gqotPgOJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156900; c=relaxed/simple;
	bh=jYXw2uiElp5iGEHTeUqCiCGns270dC90YDCh7La/u5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUb/DoOE2K8oVYAFP7izLOPJ/ru1/rP9EhqvAwi3JgqGgJofRvwwlGMeLuiKPiyYk+xJc3lW9xDP51idiLQ/Uq5N2pHzT4Nra4B1zF93f4I1GPH0BHythlajgeZ7Z/PEBfkafI1LF0KPGkBSDuyHA2E2qqksXsrOEGGs1gZFuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00F3C152B;
	Thu, 12 Sep 2024 09:02:07 -0700 (PDT)
Received: from [10.1.32.61] (e127648.arm.com [10.1.32.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D09103F66E;
	Thu, 12 Sep 2024 09:01:35 -0700 (PDT)
Message-ID: <ac4c9060-e447-46da-9f37-167864a7906f@arm.com>
Date: Thu, 12 Sep 2024 17:01:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/schedutil: Only bind threads if needed
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Qais Yousef <qyousef@layalina.io>,
 Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com>
 <CAJZ5v0h_AFNe2ZynDseE7N_5U9DV4NnLEhw9w=ErGuBswfpWow@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0h_AFNe2ZynDseE7N_5U9DV4NnLEhw9w=ErGuBswfpWow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/12/24 16:41, Rafael J. Wysocki wrote:
> On Thu, Sep 12, 2024 at 3:53 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> Remove the unconditional binding of sugov kthreads to the affected CPUs
>> if the cpufreq driver indicates that updates can happen from any CPU.
>> This allows userspace to set affinities to either save power (waking up
>> bigger CPUs on HMP can be expensive) or increasing performance (by
>> letting the utilized CPUs run without preemption of the sugov kthread).
>>
>> Without this patch the behavior of sugov threads will basically be a
>> boot-time dice roll on which CPU of the PD has to handle all the
>> cpufreq updates. With the recent decreases of update filtering these
>> two basic problems become more and more apparent:
>> 1. The wake_cpu might be idle and we are waking it up from another
>> CPU just for the cpufreq update. Apart from wasting power, the exit
>> latency of it's idle state might be longer than the sugov threads
>> running time, essentially delaying the cpufreq update unnecessarily.
>> 2. We are preempting either the requesting or another busy CPU of the
>> PD, while the update could be done from a CPU that we deem less
>> important and pay the price of an IPI and two context-switches.
>>
>> The change is essentially not setting PF_NO_SETAFFINITY on
>> dvfs_possible_from_any_cpu, no behavior change if userspace doesn't
>> touch affinities.
> 
> I'd like to hear from Viresh on this.
> 
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>>  kernel/sched/syscalls.c          | 3 +++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index 43111a515a28..466fb79e0b81 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -683,7 +683,11 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>>         }
>>
>>         sg_policy->thread = thread;
>> -       kthread_bind_mask(thread, policy->related_cpus);
>> +       if (policy->dvfs_possible_from_any_cpu)
>> +               set_cpus_allowed_ptr(thread, policy->related_cpus);
>> +       else
>> +               kthread_bind_mask(thread, policy->related_cpus);
>> +
>>         init_irq_work(&sg_policy->irq_work, sugov_irq_work);
>>         mutex_init(&sg_policy->work_lock);
>>
>> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
>> index c62acf509b74..7d4a4edfcfb9 100644
>> --- a/kernel/sched/syscalls.c
>> +++ b/kernel/sched/syscalls.c
>> @@ -1159,6 +1159,9 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
>>         if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
>>                 return 0;
>>
>> +       if (dl_entity_is_special(&p->dl))
>> +               return 0;
>> +
> 
> Care to explain this particular piece?

Looks suspicious but the truncated comment below explains it:
	/*
	 * Since bandwidth control happens on root_domain basis,
	 * if admission test is enabled, we only admit -deadline
	 * tasks allowed to run on all the CPUs in the task's
	 * root_domain.
	 */
So that would only allow setting it to all CPUs for the relevant
platforms unfortunately.

That should be fine though since the sugov task is pretty much
a dummy in terms of bandwidth / admission control internally, so
no harm done to not enforce this when userspace wants to set
affinities.
...Unless Juri disagrees.

> 
>>         /*
>>          * Since bandwidth control happens on root_domain basis,
>>          * if admission test is enabled, we only admit -deadline
>> --


