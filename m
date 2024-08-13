Return-Path: <linux-pm+bounces-12132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2910794FFC8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 10:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89EE0B22F1F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F098313A244;
	Tue, 13 Aug 2024 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lf5YwlBR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F73130A54
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537552; cv=none; b=AnX+aALOUGTJWryjaQ1aA7aMQk2TsrmbxPKK9J5uCwA8514DN0pE4l5LfI4Ap08sMjPqnuuLmlsDCL8Nm3+LTkiJdlMA/ysWbnP3cPg794AFFe5Hux3efhNbpwi3hnB+IiFk1UKqtToNwj3y5bUhDzSEIVNaRRjNJUF7y/nRx0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537552; c=relaxed/simple;
	bh=3kVlJQU0BIp2rBktBQ7VmHxx5xBs7qhHp4dNn8b+7kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mccCbdpICVuNPUgMMUVvMUZWjejCQcEfDzeJALoTDTCxPUJbe+DPnotboSCuEdygYYKuTvp3zBzBATo7Gg4utRUGRUcPZzlz1Wy95ToppkrtrWUmc90KSuVEuydwnMUli27/rzvey2DNzVQrLp+cLFQAhxnXKq2i024ElLKtDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lf5YwlBR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a130ae7126so3680587a12.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 01:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723537550; x=1724142350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo6QM0sBKGRYLVNN4IyVM/GTsc0sueI/A0itTKYR/es=;
        b=Lf5YwlBRF20w3YaZgvOyChpSP/WwXdiFOLGFwQupfV06e40rSsF5YfTKY6B7LDILG0
         DxY2cVSpUNVCTaBw3PbzBBgvDpOyNJ9dY06DZtC0J4GeyQzxc2G5eUFZhdcEDut8YRBT
         9zqsjTTJwbxuKHldksPJqIKa66CVARoYsQettzzOBUpavGLr8ahuZIG+eraAxW0NOSGa
         9QnnOxMjmRHWObAmlOWdh6Gj6SVw/KnGSIn4f4Zdtmb5jYdxt0aVaOWslAo49/UL8Wn4
         Pg5nZbC7G0MYNkArnOutTaR8M5tT6dTDhM5Gh3q9qILbCRoAqvl0GZmElFZ37Z5hpDR6
         3mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723537550; x=1724142350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bo6QM0sBKGRYLVNN4IyVM/GTsc0sueI/A0itTKYR/es=;
        b=V0v41KEykD7BpCXvwXI3kGdZt08zPBzgBZY/ebZn24tl5Swa/KMovMedRSFsiU5B2s
         OQkCwwoBTr8FoMUQ+qflYZYmrG5dXfW3mElKszf+0tonJR5al3VeaJYK4nYLSAVB8HV9
         +gkk1EYm2LLZ23FPMHd72sC02V0xWTNH5WaSwxY4fgx0EY89LjMcpllkB/Jfru4+BQt0
         NEXRzn+EfBCvbsXXrUwjG/BWdd7p0YHqOMzwriebIVIoM0XIg+8kePtDNAP+NX5acWHO
         eBy4Z56j5mm07iNwFkpac3JyRB3r+8nD+rC8TOe3NFMS6btt2RgjajbAhX68uC6g4Jlw
         oVmg==
X-Forwarded-Encrypted: i=1; AJvYcCXlGejkNgleCO5cI4xckn0GXGc98qReUl93U8j8GEqgOIg/Kq9KeHH03+V0o55fFNOcOfOMaeb9TuTVEzvAsds7RaajC9obAqg=
X-Gm-Message-State: AOJu0YxLlRFDpAKCxZXY9i6BJb6toBweFCoQGSi7H37zE1AX4AYhB8+w
	EAM1KtNlORYiU95EJXN4NOFhFP+P4sf9mlPdC9kide+JZupXuLidaaLQBsTWEhEjfom7/4wyRUW
	k2Ns4uaQWWwYKfkXOAtCTsrAANsrXxfW6aWjj2w==
X-Google-Smtp-Source: AGHT+IH+JUSUQX/w+WP6cJs+S6/ZzZT4XCqDPnT0rLsrzQJZAvyq0RqmK3imTC9gS9X41NL9e1jPOHmTOl7sVhhJSaw=
X-Received: by 2002:a17:90a:110f:b0:2ca:d1dc:47e2 with SMTP id
 98e67ed59e1d1-2d392652468mr3058025a91.33.1723537550475; Tue, 13 Aug 2024
 01:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
In-Reply-To: <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Aug 2024 10:25:39 +0200
Message-ID: <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
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

On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
>
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

The !fast_switch is a bit of concern for me too but not for the same
reason and maybe the opposite of yours IIUC your proposal below:

With fast_switch we have the following sequence:

sched_switch() to task A
cpufreq_driver_fast_switch -> write new freq target
run task A

This is pretty straight forward but we have the following sequence
with !fast_switch

sched_switch() to task A
queue_irq_work -> raise an IPI on local CPU
Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
with 1 CPU per PD)
sched_switch() to sugov dl task
__cpufreq_driver_target() which can possibly block on a lock
sched_switch() to task A
run task A

We can possibly have 2 context switch and one IPi for each "normal"
context switch which is not really optimal

>
> The weirdest case I can think of right now is two FAIR iowait tasks on
> e.g. CPU1 keep waking up the DEADLINE task on CPU0 (same PD) regardless
> of what is running there.
> Potentially that means two fair tasks on one CPU CPU-starving an RT
> task on another CPU, because it keeps getting preempted by the DEADLINE
> sugov worker.
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
>         kthread_queue_work(&sg_policy->worker, &sg_policy->work);
>  }
>
>
>
>

