Return-Path: <linux-pm+bounces-11921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC2E947E36
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCB6B2692D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D01155743;
	Mon,  5 Aug 2024 15:35:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B911591F0;
	Mon,  5 Aug 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872114; cv=none; b=IO8KdlOYd6d4+t8eb3iAhXO/tUJAkKhxvDC/wUKkHr/eyBQJ0DmALJzx8gqo5muKnxbzeircT5obuZ8hkQ2QYQi0Viyd2lXWz8bkSY493gtJUvQxcQ5hg2kucrACvTt0jCZ0S66KavCWcbuFRopsIC33vxb7i59ZiFdUF32ZUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872114; c=relaxed/simple;
	bh=4u7UjoQLgL+KeaHczuoIUQ3UHNCfCFA+336jz9B9PNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDsX1JIsz62Vt7nJX1tS1DxGcLNkbZNEXjHAYJWuTJJHkRwMXi9tStubFosdPruatkjLGMKsxP+V4hpw/wpTTiF0OKonrwd2PZ/OuNHPaRAX6FQzkDvpAeK5IAVMjKbD78vkEYnx41SF5px5SVAkOQofAgJUf44lIoXGRqI9vD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E24106F;
	Mon,  5 Aug 2024 08:35:36 -0700 (PDT)
Received: from [10.1.25.54] (e127648.arm.com [10.1.25.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9BA3F6A8;
	Mon,  5 Aug 2024 08:35:07 -0700 (PDT)
Message-ID: <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
Date: Mon, 5 Aug 2024 16:35:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Hongyan Xia
 <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240728184551.42133-1-qyousef@layalina.io>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240728184551.42133-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/24 19:45, Qais Yousef wrote:
> Improve the interaction with cpufreq governors by making the
> cpufreq_update_util() calls more intentional.
> 
> At the moment we send them when load is updated for CFS, bandwidth for
> DL and at enqueue/dequeue for RT. But this can lead to too many updates
> sent in a short period of time and potentially be ignored at a critical
> moment due to the rate_limit_us in schedutil.
> 
> For example, simultaneous task enqueue on the CPU where 2nd task is
> bigger and requires higher freq. The trigger to cpufreq_update_util() by
> the first task will lead to dropping the 2nd request until tick. Or
> another CPU in the same policy triggers a freq update shortly after.
> 
> Updates at enqueue for RT are not strictly required. Though they do help
> to reduce the delay for switching the frequency and the potential
> observation of lower frequency during this delay. But current logic
> doesn't intentionally (at least to my understanding) try to speed up the
> request.
> 
> To help reduce the amount of cpufreq updates and make them more
> purposeful, consolidate them into these locations:
> 
> 1. context_switch()
> 2. task_tick_fair()
> 3. sched_balance_update_blocked_averages()
> 4. on sched_setscheduler() syscall that changes policy or uclamp values
> 5. on check_preempt_wakeup_fair() if wakeup preemption failed
> 6. on __add_running_bw() to guarantee DL bandwidth requirements.
> 
> The update at context switch should help guarantee that RT get the right
> frequency straightaway when they're RUNNING. As mentioned though the
> update will happen slightly after enqueue_task(); though in an ideal
> world these tasks should be RUNNING ASAP and this additional delay
> should be negligible. For fair tasks we need to make sure we send
> a single update for every decay for the root cfs_rq. Any changes to the
> rq will be deferred until the next task is ready to run, or we hit TICK.
> But we are guaranteed the task is running at a level that meets its
> requirements after enqueue.
> 
> To guarantee RT and DL tasks updates are never missed, we add a new
> SCHED_CPUFREQ_FORCE_UPDATE to ignore the rate_limit_us. If we are
> already running at the right freq, the governor will end up doing
> nothing, but we eliminate the risk of the task ending up accidentally
> running at the wrong freq due to rate_limit_us.
> 
> Similarly for iowait boost, we ignore rate limits. We also handle a case
> of a boost reset prematurely by adding a guard in sugov_iowait_apply()
> to reduce the boost after 1ms which seems iowait boost mechanism relied
> on rate_limit_us and cfs_rq.decayed preventing any updates to happen
> soon after iowait boost.
> 
> The new SCHED_CPUFREQ_FORCE_UPDATE should not impact the rate limit
> time stamps otherwise we can end up delaying updates for normal
> requests.

Hi Qais,
the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
freq updates still bothered me so let me share my thoughts even though
it might be niche enough for us not to care.

1. On fast_switch systems, assuming they are fine with handling the
actual updates, we have a bit more work on each context_switch() and
some synchronisation, too. That should be fine, if anything there's
some performance regression in a couple of niche cases.

2. On !fast_switch systems this gets more interesting IMO. So we have
a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
update request. This task will preempt whatever and currently will
pretty much always be running on the CPU it ran last on (so first CPU
of the PD).

The weirdest case I can think of right now is two FAIR iowait tasks on
e.g. CPU1 keep waking up the DEADLINE task on CPU0 (same PD) regardless
of what is running there.
Potentially that means two fair tasks on one CPU CPU-starving an RT
task on another CPU, because it keeps getting preempted by the DEADLINE
sugov worker.
For this to actually happen we need to ensure the tasks
context-switching actually results in a different requested frequency
every time, which is a bit unlikely without UCLAMP_MAX, let's say task
A has 512, task B 1024, task C (RT on CPU1 should have uclamp_min<=512
then too otherwise frequency may be dictated by the RT task anyway.)
(Note the entire thing also works with Tasks A & B being lower-prio RT
too, instead of FAIR and iowait.)

Note that due to the nature of SCHED_DEADLINE and the sugov task having
10s period and 1s runtime this behavior is limited to 1s every 10s.
The remaining 9s (replenishment time) we won't see any cpufreq updates
for that PD at all though.

To reproduce, I have [4,5] being one PD:

fio --minimal --time_based --name=cpu5_1024uclamp --filename=/dev/nullb0 --runtime=10 --rw=randread --bs=4k--direct=1 --cpus_allowed=5
uclampset -M 512 fio --minimal --time_based --name=cpu5_512uclamp --filename=/dev/nullb0 --runtime=10 --rw=randread --bs=4k--direct=1 --cpus_allowed=5
and then your RT task on CPU4.

Something like this would mitigate that, I think it makes sense even
without your patch to get a more predictable idle pattern, just maybe
not exactly this patch of course.

-->8--

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 64f614b3db20..c186f8f999fe 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -567,6 +567,8 @@ static void sugov_irq_work(struct irq_work *irq_work)
 
        sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
 
+       /* Try to wake the task here to not preempt or wake up another CPU. */
+       sg_policy->worker.task->wake_cpu = smp_processor_id();
        kthread_queue_work(&sg_policy->worker, &sg_policy->work);
 }
 




