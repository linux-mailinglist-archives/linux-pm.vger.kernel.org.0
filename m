Return-Path: <linux-pm+bounces-12171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8203F950A18
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 18:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3762B282BE3
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99A1A256C;
	Tue, 13 Aug 2024 16:26:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBCF1A0B05;
	Tue, 13 Aug 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566375; cv=none; b=cPmrn9X5GzNIAFP3cK08oiYm8SbVfAVx5wjhpyIA8hK2fwJpx9sQnYfgeOdVwfDvEp0IRQAoTHShQPRltLKZ50JLkiaGEmocMsmORP9QoPKoPghE3SHmfKCQKHPD5hmQJD6HD7LOxYXIOggIGv+wCcj75zyBnWH+GJaGY7koiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566375; c=relaxed/simple;
	bh=CIdIywtMybE4qzk2fc4+X7ax6VAHi/2wrUQv7J5GpyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0sM340QuQu+BS8mttyKwsWhz7AjoF4ODJaz2mx+a2GZ2oJnxv8ZuVoQ2X2KbAxeS/tmKPoeUbFOb3x9K7JWkhCJKVAZpNADn122O42a0TM+jH3ghqpWuFqZRU2GL/DV2jP4qqcTGCsE4X5SNGeMqHqKvGz+/bGKttGfQ9egzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A01F12FC;
	Tue, 13 Aug 2024 09:26:38 -0700 (PDT)
Received: from [10.57.84.20] (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C00A3F6A8;
	Tue, 13 Aug 2024 09:26:09 -0700 (PDT)
Message-ID: <bfcd8175-c6bc-41a2-8ee9-93061e446c40@arm.com>
Date: Tue, 13 Aug 2024 17:26:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Hongyan Xia
 <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/24 09:27, Vincent Guittot wrote:
> On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
>>>
>>> On 7/28/24 19:45, Qais Yousef wrote:
>>>> Improve the interaction with cpufreq governors by making the
>>>> cpufreq_update_util() calls more intentional.
>>>>
>>>> At the moment we send them when load is updated for CFS, bandwidth for
>>>> DL and at enqueue/dequeue for RT. But this can lead to too many updates
>>>> sent in a short period of time and potentially be ignored at a critical
>>>> moment due to the rate_limit_us in schedutil.
>>>>
>>>> For example, simultaneous task enqueue on the CPU where 2nd task is
>>>> bigger and requires higher freq. The trigger to cpufreq_update_util() by
>>>> the first task will lead to dropping the 2nd request until tick. Or
>>>> another CPU in the same policy triggers a freq update shortly after.
>>>>
>>>> Updates at enqueue for RT are not strictly required. Though they do help
>>>> to reduce the delay for switching the frequency and the potential
>>>> observation of lower frequency during this delay. But current logic
>>>> doesn't intentionally (at least to my understanding) try to speed up the
>>>> request.
>>>>
>>>> To help reduce the amount of cpufreq updates and make them more
>>>> purposeful, consolidate them into these locations:
>>>>
>>>> 1. context_switch()
>>>> 2. task_tick_fair()
>>>> 3. sched_balance_update_blocked_averages()
>>>> 4. on sched_setscheduler() syscall that changes policy or uclamp values
>>>> 5. on check_preempt_wakeup_fair() if wakeup preemption failed
>>>> 6. on __add_running_bw() to guarantee DL bandwidth requirements.
>>>>
>>>> The update at context switch should help guarantee that RT get the right
>>>> frequency straightaway when they're RUNNING. As mentioned though the
>>>> update will happen slightly after enqueue_task(); though in an ideal
>>>> world these tasks should be RUNNING ASAP and this additional delay
>>>> should be negligible. For fair tasks we need to make sure we send
>>>> a single update for every decay for the root cfs_rq. Any changes to the
>>>> rq will be deferred until the next task is ready to run, or we hit TICK.
>>>> But we are guaranteed the task is running at a level that meets its
>>>> requirements after enqueue.
>>>>
>>>> To guarantee RT and DL tasks updates are never missed, we add a new
>>>> SCHED_CPUFREQ_FORCE_UPDATE to ignore the rate_limit_us. If we are
>>>> already running at the right freq, the governor will end up doing
>>>> nothing, but we eliminate the risk of the task ending up accidentally
>>>> running at the wrong freq due to rate_limit_us.
>>>>
>>>> Similarly for iowait boost, we ignore rate limits. We also handle a case
>>>> of a boost reset prematurely by adding a guard in sugov_iowait_apply()
>>>> to reduce the boost after 1ms which seems iowait boost mechanism relied
>>>> on rate_limit_us and cfs_rq.decayed preventing any updates to happen
>>>> soon after iowait boost.
>>>>
>>>> The new SCHED_CPUFREQ_FORCE_UPDATE should not impact the rate limit
>>>> time stamps otherwise we can end up delaying updates for normal
>>>> requests.
>>>
>>> Hi Qais,
>>> the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
>>> freq updates still bothered me so let me share my thoughts even though
>>> it might be niche enough for us not to care.
>>>
>>> 1. On fast_switch systems, assuming they are fine with handling the
>>> actual updates, we have a bit more work on each context_switch() and
>>> some synchronisation, too. That should be fine, if anything there's
>>> some performance regression in a couple of niche cases.
>>>
>>> 2. On !fast_switch systems this gets more interesting IMO. So we have
>>> a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
>>> update request. This task will preempt whatever and currently will
>>> pretty much always be running on the CPU it ran last on (so first CPU
>>> of the PD).
>>
>> The !fast_switch is a bit of concern for me too but not for the same
>> reason and maybe the opposite of yours IIUC your proposal below:
>>
>> With fast_switch we have the following sequence:
>>
>> sched_switch() to task A
>> cpufreq_driver_fast_switch -> write new freq target
>> run task A
>>
>> This is pretty straight forward but we have the following sequence
>> with !fast_switch
>>
>> sched_switch() to task A
>> queue_irq_work -> raise an IPI on local CPU
>> Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
>> with 1 CPU per PD)
>> sched_switch() to sugov dl task
>> __cpufreq_driver_target() which can possibly block on a lock
>> sched_switch() to task A
>> run task A
>>
> 
> sent a bit too early
> 
>> We can possibly have 2 context switch and one IPi for each "normal"
>> context switch which is not really optimal
> 
> It would be good to find a way to skip the spurious back and forth
> between the normal task and sugov

Just to confirm I understand your concern correctly, that's more or
less the behavior without Qais' patch as well though, isn't it?
Ignoring the move from "This happens at enqueue" vs. "this
happens at context switch".
Since sugov doesn't queue any work if the desired frequency doesn't
change I imagine it's not too bad?
Or are you more concerned that the work is queued multiple times
simultaneously for multiple CPUs of the same PD? If so we can
work around that with the work_in_progress state to at least limit
that window by a lot.

[snip]

