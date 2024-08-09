Return-Path: <linux-pm+bounces-12019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E419794C7EE
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 03:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145ED1C21ED6
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 01:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7933D1;
	Fri,  9 Aug 2024 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="z5SY/jme"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A28F5E
	for <linux-pm@vger.kernel.org>; Fri,  9 Aug 2024 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166034; cv=none; b=L3Qw+LLmmVO0vFrH4PTMKYF/A8OMr1+5KuiEvk0E7DRE9O/d0Zjoe9GU4DUlFSVKVucXdC8pqMssNoy1att11TUTQVoqru5Zw4VpW97PcWulIqUsx6fe7JxVwvTT7hRJlYPbhejHx7tMZIT29Y6dce6Cyyf0MqPIEzHK07t9TgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166034; c=relaxed/simple;
	bh=3N4rxxLKD7OLh7PnqGdW28E+CLlFABv0vNSTb9E1HJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFTJus5+yNHXswk3YVfSpyiA/tj3TIsCGfPUdvzj3HE6V08qyLt18p9aic6bSAFc8eWRi6c9LcKfMSIwRdGRzc0qxMHDDWKSD0VBMDJTowoAQswTm8i9z18T9FXOZ0HsS0uYDj3g0eMd7eEqx9sTFwGdlRBx0llb9kSxxH61/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=z5SY/jme; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-368380828d6so838911f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2024 18:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1723166031; x=1723770831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKi8gvUds/3EGR/43alqerH9No7svuEv/aij2D3EePk=;
        b=z5SY/jmemll8G3iOxHZ198mKEulAr3ez7f77nk7iJSUbVbrcwhgoHmMPqEWmqNw5Hu
         /i/l3GVhk5UOl4cxfFUeX35T1lgLZd3soGWaQpQbPQUpZsrP81e07xEVdXFlhd/8D7gd
         61wCXmAMXLyEcTR+cVEFg4esm6sPoB6OOo4tk2a4yxDJ6AXwyMs/bBWf+drPvmIvBG8z
         138JJOlUga1Mtt19T8TD45Obwp8FOiZCMur9nrzu4NY7mV1vFQ09HXNHFeM3nfDMsftP
         L3c2SzA96iQyqUYxtwFk+sFl8+fHCqd0LZOpPc7BGs+ubAjMyNkzlbQ2ROmaeFbY+jLA
         qhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723166031; x=1723770831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKi8gvUds/3EGR/43alqerH9No7svuEv/aij2D3EePk=;
        b=n+tUfluF1F9ha3EWGAH2+6iNtpj807J67NRpUqVz39UFsrUKmopaudSffNWplAAL+U
         QKJaKq4PHWjU7KTHz2rSbufH/uAdx/9RDmG9qGb5fETR1FBHY9d9rS6TOB8ydNjpWzp/
         LDutzu+MoBrtKIA3uW6ZaiheSj898XT3MS4dMoLC3joXLm4NCxqFOpR7O5uu4fdimSWn
         xNkexbGwlq2KUYQbUUo/o7CBlssFxJyS9HJbMMh84grNbFm58GIkGWnTBHxOXG+favmi
         2Fv3p6nrsXVT+2rs4GPwKYihFLNRy7SsckkX4qT+qMUAIhB+YGUTeOUdMfLNGOdWdu//
         BTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8aTaWIIosSRrSMRZrfB1mHFlEX9NDp3iV2y492Hrq6Xg/rbkYBm2hAHuu2QA232DdO+qLthe/+3m1y6ahTC24sfFBxppspmY=
X-Gm-Message-State: AOJu0YztHn371jtJdfKrF0H9j120HY+xXMPzbIBjuvSc5QXwm6yG5vHd
	WXKSREbTh7jsFZRnM2lEyLAIVaUInTup3vSWvHiJLXqpIniMNWzYNmEHZ4XDbFU=
X-Google-Smtp-Source: AGHT+IEmBl58aHXldv+P4VT7q++0t4DW3bKJb5PB8/HhChVYnoeiOuciJJectYGmIpLPDiE4+GNHHQ==
X-Received: by 2002:a5d:490c:0:b0:369:c6ec:27d5 with SMTP id ffacd0b85a97d-36d275007bbmr2571942f8f.30.1723166030458;
        Thu, 08 Aug 2024 18:13:50 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905962345sm97489445e9.5.2024.08.08.18.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 18:13:50 -0700 (PDT)
Date: Fri, 9 Aug 2024 02:13:49 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20240809011349.p7bs5ov2q6pqq3lv@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>

On 08/05/24 16:35, Christian Loehle wrote:
> On 7/28/24 19:45, Qais Yousef wrote:
> > Improve the interaction with cpufreq governors by making the
> > cpufreq_update_util() calls more intentional.
> > 
> > At the moment we send them when load is updated for CFS, bandwidth for
> > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > sent in a short period of time and potentially be ignored at a critical
> > moment due to the rate_limit_us in schedutil.
> > 
> > For example, simultaneous task enqueue on the CPU where 2nd task is
> > bigger and requires higher freq. The trigger to cpufreq_update_util() by
> > the first task will lead to dropping the 2nd request until tick. Or
> > another CPU in the same policy triggers a freq update shortly after.
> > 
> > Updates at enqueue for RT are not strictly required. Though they do help
> > to reduce the delay for switching the frequency and the potential
> > observation of lower frequency during this delay. But current logic
> > doesn't intentionally (at least to my understanding) try to speed up the
> > request.
> > 
> > To help reduce the amount of cpufreq updates and make them more
> > purposeful, consolidate them into these locations:
> > 
> > 1. context_switch()
> > 2. task_tick_fair()
> > 3. sched_balance_update_blocked_averages()
> > 4. on sched_setscheduler() syscall that changes policy or uclamp values
> > 5. on check_preempt_wakeup_fair() if wakeup preemption failed
> > 6. on __add_running_bw() to guarantee DL bandwidth requirements.
> > 
> > The update at context switch should help guarantee that RT get the right
> > frequency straightaway when they're RUNNING. As mentioned though the
> > update will happen slightly after enqueue_task(); though in an ideal
> > world these tasks should be RUNNING ASAP and this additional delay
> > should be negligible. For fair tasks we need to make sure we send
> > a single update for every decay for the root cfs_rq. Any changes to the
> > rq will be deferred until the next task is ready to run, or we hit TICK.
> > But we are guaranteed the task is running at a level that meets its
> > requirements after enqueue.
> > 
> > To guarantee RT and DL tasks updates are never missed, we add a new
> > SCHED_CPUFREQ_FORCE_UPDATE to ignore the rate_limit_us. If we are
> > already running at the right freq, the governor will end up doing
> > nothing, but we eliminate the risk of the task ending up accidentally
> > running at the wrong freq due to rate_limit_us.
> > 
> > Similarly for iowait boost, we ignore rate limits. We also handle a case
> > of a boost reset prematurely by adding a guard in sugov_iowait_apply()
> > to reduce the boost after 1ms which seems iowait boost mechanism relied
> > on rate_limit_us and cfs_rq.decayed preventing any updates to happen
> > soon after iowait boost.
> > 
> > The new SCHED_CPUFREQ_FORCE_UPDATE should not impact the rate limit
> > time stamps otherwise we can end up delaying updates for normal
> > requests.
> 
> Hi Qais,
> the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> freq updates still bothered me so let me share my thoughts even though
> it might be niche enough for us not to care.

It is a valid concern. I thought a lot about dropping it for iowait, but
I really had consistency of behavior in mind and was rooting for this logic to
be revamped soon to hopefully drop this altogether.

I don't mind dropping it. But I am keen on pushing it forward and reconsider if
someone reports it to be an actual problem rather than being held back by
hypothesis that we don't think are likely to be true.

For RT and DL though, I think being rate limited is really bad. It breaks
a promise we give to those tasks. I expect usage of RT on systems that cares
about power management to be minimal and niche. Serious realtime folks would
most certainly disable a lot of power management features as it is a major
source of latencies.

> 
> 1. On fast_switch systems, assuming they are fine with handling the
> actual updates, we have a bit more work on each context_switch() and
> some synchronisation, too. That should be fine, if anything there's
> some performance regression in a couple of niche cases.
> 
> 2. On !fast_switch systems this gets more interesting IMO. So we have
> a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> update request. This task will preempt whatever and currently will
> pretty much always be running on the CPU it ran last on (so first CPU
> of the PD).
> 
> The weirdest case I can think of right now is two FAIR iowait tasks on
> e.g. CPU1 keep waking up the DEADLINE task on CPU0 (same PD) regardless
> of what is running there.

This setup is very elaborate. The CPU frequency would be completely saturated
within few wake ups given how aggressive current iowait logic is. If sugov
continues to be triggered after this, the bug is on why it triggers as there's
no frequency to change.

> Potentially that means two fair tasks on one CPU CPU-starving an RT
> task on another CPU, because it keeps getting preempted by the DEADLINE
> sugov worker.

Deadline will look like a higher priority RT task. I'd expect the RT task to be
pushed to where the fair tasks are running and the fair tasks to end up waiting
or saved by load balance to move to another vacant CPU.

> For this to actually happen we need to ensure the tasks
> context-switching actually results in a different requested frequency
> every time, which is a bit unlikely without UCLAMP_MAX, let's say task
> A has 512, task B 1024, task C (RT on CPU1 should have uclamp_min<=512
> then too otherwise frequency may be dictated by the RT task anyway.)
> (Note the entire thing also works with Tasks A & B being lower-prio RT
> too, instead of FAIR and iowait.)
> 
> Note that due to the nature of SCHED_DEADLINE and the sugov task having
> 10s period and 1s runtime this behavior is limited to 1s every 10s.
> The remaining 9s (replenishment time) we won't see any cpufreq updates
> for that PD at all though.
> 
> To reproduce, I have [4,5] being one PD:
> 
> fio --minimal --time_based --name=cpu5_1024uclamp --filename=/dev/nullb0 --runtime=10 --rw=randread --bs=4k--direct=1 --cpus_allowed=5
> uclampset -M 512 fio --minimal --time_based --name=cpu5_512uclamp --filename=/dev/nullb0 --runtime=10 --rw=randread --bs=4k--direct=1 --cpus_allowed=5
> and then your RT task on CPU4.

Is the RT task affined to CPU4? If yes, then this is the problem. I'd say if
someone uses affinity because they think they know better but end up shooting
themselves in the foot, then that's their problem :-)

Affinities are evil. I think we should ban them (/me runs)

If RT is not affined to CPU4 only, then I'm surprised it doesn't get pushed
immediately if a deadline task woke up on the CPU it is running on. The only
reason an RT task would wait behind a deadline task is because all other CPUs
are occupied by a deadline task or another higher priority RT task. In your
case if you're not using affinities (and assuming it's a 2 CPUs sytem), then
I'd expect the fair tasks to wait behind the RT task and deadline.

If it is a UP system, then when RT wakes up, sugov will preempt it to change
freq, and then RT will go back to running until it gives up the CPU. And the
fair tasks will wait behind when RT stopped running.

> 
> Something like this would mitigate that, I think it makes sense even
> without your patch to get a more predictable idle pattern, just maybe
> not exactly this patch of course.
> 
> -->8--
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 64f614b3db20..c186f8f999fe 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -567,6 +567,8 @@ static void sugov_irq_work(struct irq_work *irq_work)
>  
>         sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
>  
> +       /* Try to wake the task here to not preempt or wake up another CPU. */
> +       sg_policy->worker.task->wake_cpu = smp_processor_id();

This is good and bad. Good because this CPU was already interrupted, so let it
finish the work. But bad, because something else important might be there
(another RT/deadline task) and better let the proper wakeup logic pick a more
suitable CPU.

>         kthread_queue_work(&sg_policy->worker, &sg_policy->work);
>  }
>  
> 
> 
> 

