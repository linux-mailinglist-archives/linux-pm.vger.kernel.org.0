Return-Path: <linux-pm+bounces-12133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4B694FFD9
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 10:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A033B283117
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076C16D33F;
	Tue, 13 Aug 2024 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVWrY9NC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF113C691
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537678; cv=none; b=Kd2mBaOSHq7DeDodeSVnDfLc9AdcECY1ryd4rrRJXd2mdm+I1HdClTVZLvPcpmXUMoBh+3ZOEXges1x8mat9R6SJYrbjPKiK0spBpMuz9iQKVaQDbfWNVPHi2ZB2bclf9+6oewGdBwHqqk8cW5wykSbvQ3S34MlTtFbWZN757zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537678; c=relaxed/simple;
	bh=IP3KEm67mgSOdJpJTuBwzBjKzk84f2nu1P/skHs5p24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k64chuLcZ42oZckntf58bUa5gULkJgp8+dqtc/xYojNrjL/YxntgwZYrZbT7+b7pTWGj3HnUUj30gV8j+3yRBuljWxPswNbVurIdss8F2bYg/MPDsAMzsCEmMx4oBg6ebHJ2EDYy3SAleYyC8ijZTyaU+WFr1uNMZ6sBnanNqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVWrY9NC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d37e5b7b02so1060520a91.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723537675; x=1724142475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cBbzC92qXIijkNr2TtUD2im5u0ZIM+YN6x7DE29vMbY=;
        b=lVWrY9NC0zhqhga31MTXz/tgX70TidEX748MyJ5Xw0fh+zQA1r3s1v1A7d+V+rWtjn
         HBKnYpnoBWSQ9gMg/hJlsevejPXO84lCk5UH3AoBTkuo7joeR9Kw6sJLdFkTSFs/2Q/q
         4iCJ1EcivoF+8RMIEDgO7e5WP+7a8ar+oZjuCv+awVM805MF2dKIQ36H3xCh2EIl8i9U
         NkTdF2s5dbTy+22KngndPSrWZJ/YLBj098HM3UMNiSoCjiQOUe3MwhNuTIKf+QOuQ/lR
         Gph6wfVgdUG3dvfIA1e9PUEHSziQGgjqb7ygtcr6tpOWrEQapQHcUTDTHGc+cqu0vdOH
         2oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723537675; x=1724142475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBbzC92qXIijkNr2TtUD2im5u0ZIM+YN6x7DE29vMbY=;
        b=NzXLxZ69AdBjGLZvvNMnEtBA0E0f3XTJ4VK3zMcKwLJhl/RNmJWOnxMb3Zo2tVaX9a
         RF9G+F1pFYUtXfZsnrqUcXifRDFvmqipncs4jiDIXVJ1XKxvdamR8JgHeAoObrDfi8rt
         +bzUNyNlUfoojdyx9OiOH9RbelBz0/WIQn/IS/BK+pwK/6cfJZ1rHzf0+TBl5vEUUq67
         9SfNj3pBNvLsigQhtgrVL2j5Ib/Z0F6HG+36eFds4JtOqLp6s5mHEi+VbxaJqcPgMnx5
         WDDrd0h2KuWIh6FBPxMKoH2Z6EHEmMQwN0BQkDF4l4pcp7FuhEFjrz69TtJxc5yynnbM
         6htA==
X-Forwarded-Encrypted: i=1; AJvYcCXImZ2JWEK18XzQw1Y9LUoLZjs9j0FP+0cdtVL4keGqyZoxkdRsij/xR5SVNb/ywbnJqqV4pwDFrEaMtv8CnPKHDx6pSDvt+bs=
X-Gm-Message-State: AOJu0YzdkIa3Ee6Zzo0NYlJJ2Wm6r5OReqGYNkeanViZ7fuJDEFcXdQH
	hgI7iaCBfI/WgoLDxllGoqzQlwMwjwzBZtWjiSCsZAlyjQif7ZXV1MOGX4XWGC/17TUHXjRhj1V
	xPuXdR6taGIJs/ZnTW42BlA5HPZ35oHZsMRbA7A==
X-Google-Smtp-Source: AGHT+IEK2c2ohUMnIfnbxQfkjEH5wi8gHRe7e+qoccGbjLk/5+ZZ4a9JSKtFwXUEFSdznl33JpRXYYhAhqIMRm1Sx/s=
X-Received: by 2002:a17:90b:4d06:b0:2c9:7a8d:43f7 with SMTP id
 98e67ed59e1d1-2d39253978bmr2974232a91.23.1723537675304; Tue, 13 Aug 2024
 01:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Aug 2024 10:27:44 +0200
Message-ID: <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Christian Loehle <christian.loehle@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
> >
> > On 7/28/24 19:45, Qais Yousef wrote:
> > > Improve the interaction with cpufreq governors by making the
> > > cpufreq_update_util() calls more intentional.
> > >
> > > At the moment we send them when load is updated for CFS, bandwidth for
> > > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > > sent in a short period of time and potentially be ignored at a critical
> > > moment due to the rate_limit_us in schedutil.
> > >
> > > For example, simultaneous task enqueue on the CPU where 2nd task is
> > > bigger and requires higher freq. The trigger to cpufreq_update_util() by
> > > the first task will lead to dropping the 2nd request until tick. Or
> > > another CPU in the same policy triggers a freq update shortly after.
> > >
> > > Updates at enqueue for RT are not strictly required. Though they do help
> > > to reduce the delay for switching the frequency and the potential
> > > observation of lower frequency during this delay. But current logic
> > > doesn't intentionally (at least to my understanding) try to speed up the
> > > request.
> > >
> > > To help reduce the amount of cpufreq updates and make them more
> > > purposeful, consolidate them into these locations:
> > >
> > > 1. context_switch()
> > > 2. task_tick_fair()
> > > 3. sched_balance_update_blocked_averages()
> > > 4. on sched_setscheduler() syscall that changes policy or uclamp values
> > > 5. on check_preempt_wakeup_fair() if wakeup preemption failed
> > > 6. on __add_running_bw() to guarantee DL bandwidth requirements.
> > >
> > > The update at context switch should help guarantee that RT get the right
> > > frequency straightaway when they're RUNNING. As mentioned though the
> > > update will happen slightly after enqueue_task(); though in an ideal
> > > world these tasks should be RUNNING ASAP and this additional delay
> > > should be negligible. For fair tasks we need to make sure we send
> > > a single update for every decay for the root cfs_rq. Any changes to the
> > > rq will be deferred until the next task is ready to run, or we hit TICK.
> > > But we are guaranteed the task is running at a level that meets its
> > > requirements after enqueue.
> > >
> > > To guarantee RT and DL tasks updates are never missed, we add a new
> > > SCHED_CPUFREQ_FORCE_UPDATE to ignore the rate_limit_us. If we are
> > > already running at the right freq, the governor will end up doing
> > > nothing, but we eliminate the risk of the task ending up accidentally
> > > running at the wrong freq due to rate_limit_us.
> > >
> > > Similarly for iowait boost, we ignore rate limits. We also handle a case
> > > of a boost reset prematurely by adding a guard in sugov_iowait_apply()
> > > to reduce the boost after 1ms which seems iowait boost mechanism relied
> > > on rate_limit_us and cfs_rq.decayed preventing any updates to happen
> > > soon after iowait boost.
> > >
> > > The new SCHED_CPUFREQ_FORCE_UPDATE should not impact the rate limit
> > > time stamps otherwise we can end up delaying updates for normal
> > > requests.
> >
> > Hi Qais,
> > the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> > freq updates still bothered me so let me share my thoughts even though
> > it might be niche enough for us not to care.
> >
> > 1. On fast_switch systems, assuming they are fine with handling the
> > actual updates, we have a bit more work on each context_switch() and
> > some synchronisation, too. That should be fine, if anything there's
> > some performance regression in a couple of niche cases.
> >
> > 2. On !fast_switch systems this gets more interesting IMO. So we have
> > a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> > update request. This task will preempt whatever and currently will
> > pretty much always be running on the CPU it ran last on (so first CPU
> > of the PD).
>
> The !fast_switch is a bit of concern for me too but not for the same
> reason and maybe the opposite of yours IIUC your proposal below:
>
> With fast_switch we have the following sequence:
>
> sched_switch() to task A
> cpufreq_driver_fast_switch -> write new freq target
> run task A
>
> This is pretty straight forward but we have the following sequence
> with !fast_switch
>
> sched_switch() to task A
> queue_irq_work -> raise an IPI on local CPU
> Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
> with 1 CPU per PD)
> sched_switch() to sugov dl task
> __cpufreq_driver_target() which can possibly block on a lock
> sched_switch() to task A
> run task A
>

sent a bit too early

> We can possibly have 2 context switch and one IPi for each "normal"
> context switch which is not really optimal

It would be good to find a way to skip the spurious back and forth
between the normal task and sugov

>
> >
> > The weirdest case I can think of right now is two FAIR iowait tasks on
> > e.g. CPU1 keep waking up the DEADLINE task on CPU0 (same PD) regardless
> > of what is running there.
> > Potentially that means two fair tasks on one CPU CPU-starving an RT
> > task on another CPU, because it keeps getting preempted by the DEADLINE
> > sugov worker.
> > For this to actually happen we need to ensure the tasks
> > context-switching actually results in a different requested frequency
> > every time, which is a bit unlikely without UCLAMP_MAX, let's say task
> > A has 512, task B 1024, task C (RT on CPU1 should have uclamp_min<=512
> > then too otherwise frequency may be dictated by the RT task anyway.)
> > (Note the entire thing also works with Tasks A & B being lower-prio RT
> > too, instead of FAIR and iowait.)
> >
> > Note that due to the nature of SCHED_DEADLINE and the sugov task having
> > 10s period and 1s runtime this behavior is limited to 1s every 10s.
> > The remaining 9s (replenishment time) we won't see any cpufreq updates
> > for that PD at all though.
> >
> > To reproduce, I have [4,5] being one PD:
> >
> > fio --minimal --time_based --name=cpu5_1024uclamp --filename=/dev/nullb0 --runtime=10 --rw=randread --bs=4k--direct=1 --cpus_allowed=5
> > uclampset -M 512 fio --minimal --time_based --name=cpu5_512uclamp --filename=/dev/nullb0 --runtime=10 --rw=randread --bs=4k--direct=1 --cpus_allowed=5
> > and then your RT task on CPU4.
> >
> > Something like this would mitigate that, I think it makes sense even
> > without your patch to get a more predictable idle pattern, just maybe
> > not exactly this patch of course.
> >
> > -->8--
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 64f614b3db20..c186f8f999fe 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -567,6 +567,8 @@ static void sugov_irq_work(struct irq_work *irq_work)
> >
> >         sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
> >
> > +       /* Try to wake the task here to not preempt or wake up another CPU. */
> > +       sg_policy->worker.task->wake_cpu = smp_processor_id();
> >         kthread_queue_work(&sg_policy->worker, &sg_policy->work);
> >  }
> >
> >
> >
> >

