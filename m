Return-Path: <linux-pm+bounces-7571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1684F8BDF91
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 12:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445F3B20CC1
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 10:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6D14EC4D;
	Tue,  7 May 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8hVrEEY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F0814EC4A
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077296; cv=none; b=W1bYtEEolQQ0LqtGpsMZU55MqNjlthWLjcneXLTsEwMxxvZz5eatQzVyPF0IUgbsdcBESwZheTWSWb25lVvGz1R/45iPLwhD4SQnFTzc6hMciJ06q0QvfPadlp7AYqtVkeW2j4c8wzGLahSk577j+SHHF2Dicwg/n9xRGhNTw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077296; c=relaxed/simple;
	bh=ziYwxg7UfTki/esMFXwt9j6TqrVbrfc57RE28HUUd2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYqM2lN9pDrca9qaKQh/I7kS5Ef+Yuefq6p4QFBNQGau44IUgKAPmve+oEMeDC4m5Q7MCCMUlxOj5BQ9Ixhj0phy+FIUhJp4D3Xpdxcjux3xMbNptrtxSa/JDa+VI6uEiKMuxvcRnO41Wo/DbWDcqAq9uz6uNjxXwa3P2X1Nx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A8hVrEEY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b2b42b5126so2567880a91.3
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2024 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715077293; x=1715682093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kRLPb9vDYyVzmxI5CfMybdMM1SAWwt9F3E1u1mQFxEU=;
        b=A8hVrEEYUzsgKk+MksEDv1hBybcsWh6ED0zUXonFi8zuDOsigTOBDtp5UY3gp8ZY3i
         K3HMWZx1IxBVuGGSIlzwkZom111gsR73cLBteZ8iRz8DcygD0elj+mrXJmxulpTRCJct
         h7Emnygc4rEE0fKys8ISBQYliQxmrjH1eUrrkb2IZc2nd705ppsMPbnUDcas4tL4DmBJ
         gKwCLA1ILmRq2lyDgJjnCLSHemgl4jvbr8sX0bvvPvxYLg9BhU7vRCKYqKDN76Jjy+of
         e9p5osTNioIbbQ8iFg3fZ394n6Nr3frn1sWcEjwIT4yUXhHE65YTpHADqvmdzFgtTLHC
         08pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715077293; x=1715682093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRLPb9vDYyVzmxI5CfMybdMM1SAWwt9F3E1u1mQFxEU=;
        b=nIvTh3juETTpEH3cyxx7l+/+M70RpXCS7f0qOCm71aQMEG5MaUikvqW5bYi9VQuZc5
         8cmXRt767gH05XEMRes6Bi9C+YlD+VT+X/W9Cz44LRNtkYRod80eF51EPciECYK2muet
         +WOHLR4ilq8XCUinET/Tvk0zpm8xoIJFtUoC9PxD1ppOfluigroqTpTt2+cnGwaoG6wl
         SjLgQGg1EzPS7GYMNr/nOcKgKVfcuG81qqsYDC00p1/Tk/KxuI1xDssh4uMu5lbfUHw6
         Maa7rjdUF1n6rqMHUPbL0Cqf1Oh1eu0+7oy4fn+PFUAKYTAW2Z2XVKfngBwB3UkwASwq
         GHnw==
X-Forwarded-Encrypted: i=1; AJvYcCU2nve0Ro14MULa/0Aq/cSgJmDp/nkaGoampHooZFA6/J4DWylhW+tmQjWmB4oCA3zUEF83FNZSSFzSjCc+7J8MRt9hm9wX/1c=
X-Gm-Message-State: AOJu0Yx/T4dhhS+HTpukhnstxSjX+eU54afjSY3x0IHm5dATxUjEfezs
	OQTN0Hrvbqus6MV07HrkdmeOAfnnQZM7PA9FHBGd7jQVOEGp4oMc3fvN9665iN/TdlcM5rpwftZ
	hQp1CmG7WEHSn7WO4+LxBAbTB/gq5rg6pD5DAfA==
X-Google-Smtp-Source: AGHT+IHiy7QPMHu8qfFpKoJqif1cVrJhriSvHZ/CApC2SmFKE02VRFkfqtx2L1L0kMOskkjSnnfEZC/EZS+c9Zu01eQ=
X-Received: by 2002:a17:90a:2f04:b0:2b4:abc7:d64b with SMTP id
 s4-20020a17090a2f0400b002b4abc7d64bmr8685362pjd.6.1715077292903; Tue, 07 May
 2024 03:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505233103.168766-1-qyousef@layalina.io> <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>
In-Reply-To: <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 7 May 2024 12:21:21 +0200
Message-ID: <CAKfTPtAmC6QoP_hz8Wx2wrhaZ9TrC-9b4qEnNLKru7ZAjB0FAA@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 10:58, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Mon, 6 May 2024 at 01:31, Qais Yousef <qyousef@layalina.io> wrote:
> >
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
>
> I don't see any cpufreq update when switching from idle to CFS. We
> have to wait for the next tick to get a freq update whatever the value
> of util_est and uclamp

This seems to happen when the tick is not stopped

>
> > 2. task_tick_fair()
>
> Updating only during tick is ok with a tick at 1000hz/1000us when we
> compare it with the1048us slice of pelt but what about 4ms or even
> 10ms tick ? we can have an increase of almost 200 in 10ms
>
> > 3. {attach, detach}_entity_load_avg()
>
> At enqueue/dequeue, the util_est will be updated and can make cpu
> utilization quite different especially with long sleeping tasks. The
> same applies for uclamp_min/max hints of a newly enqueued task. We
> might end up waiting 4/10ms depending of the tick period.
>
> > 4. update_blocked_averages()
> >
> > The update at context switch should help guarantee that DL and RT get
> > the right frequency straightaway when they're RUNNING. As mentioned
> > though the update will happen slightly after enqueue_task(); though in
> > an ideal world these tasks should be RUNNING ASAP and this additional
> > delay should be negligible. For fair tasks we need to make sure we send
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
> > on rate_limit_us and cfs_rq.decay preventing any updates to happen soon
> > after iowait boost.
> >
> > The new SCHED_CPUFREQ_FORCE_UPDATE should not impact the rate limit
> > time stamps otherwise we can end up delaying updates for normal
> > requests.
> >
> > As a simple optimization, we avoid sending cpufreq updates when
> > switching from RT to another RT as RT tasks run at max freq by default.
> > If CONFIG_UCLAMP_TASK is enabled, we can do a simple check to see if
> > uclamp_min is different to avoid unnecessary cpufreq update as most RT
> > tasks are likely to be running at the same performance level, so we can
> > avoid unnecessary overhead of forced updates when there's nothing to do.
> >
> > We also also ensure to ignore cpufreq udpates for sugov workers at
> > context switch. It doesn't make sense for the kworker that applies the
> > frequency update (which is a DL task) to trigger a frequency update
> > itself.
> >
> > The update at task_tick_fair will guarantee that the governor will
> > follow any updates to load for tasks/CPU or due to new enqueues/dequeues
> > to the rq. Since DL and RT always run at constant frequencies and have
> > no load tracking, this is only required for fair tasks.
> >
> > The update at attach/detach_entity_load_avg() will ensure we adapt to
> > big changes when tasks are added/removed from cgroups.
> >
> > The update at update_blocked_averages() will ensure we decay frequency
> > as the CPU becomes idle for long enough.
> >
> > Results of
> >
> >         taskset 1 perf stat --repeat 10 -e cycles,instructions,task-clock perf bench sched pipe
> >
> > on AMD 3900X to verify any potential overhead because of the addition at
> > context switch against v6.8.7 stable kernel
> >
> > v6.8.7: schedutil:
> > ------------------
> >
> >  Performance counter stats for 'perf bench sched pipe' (10 runs):
> >
> >        850,276,689      cycles:u                  #    0.078 GHz                      ( +-  0.88% )
> >         82,724,245      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
> >          10,881.41 msec task-clock:u              #    0.995 CPUs utilized            ( +-  0.12% )
> >
> >            10.9377 +- 0.0135 seconds time elapsed  ( +-  0.12% )
> >
> > v6.8.7: performance:
> > --------------------
> >
> >  Performance counter stats for 'perf bench sched pipe' (10 runs):
> >
> >        874,154,415      cycles:u                  #    0.080 GHz                      ( +-  0.78% )
> >         82,724,420      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
> >          10,916.47 msec task-clock:u              #    0.999 CPUs utilized            ( +-  0.09% )
> >
> >            10.9308 +- 0.0100 seconds time elapsed  ( +-  0.09% )
> >
> > v6.8.7+patch: schedutil:
> > ------------------------
> >
> >  Performance counter stats for 'perf bench sched pipe' (10 runs):
> >
> >        816,938,281      cycles:u                  #    0.075 GHz                      ( +-  0.84% )
> >         82,724,163      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
> >          10,907.62 msec task-clock:u              #    1.004 CPUs utilized            ( +-  0.11% )
> >
> >            10.8627 +- 0.0121 seconds time elapsed  ( +-  0.11% )
> >
> > v6.8.7+patch: performance:
> > --------------------------
> >
> >  Performance counter stats for 'perf bench sched pipe' (10 runs):
> >
> >        814,038,416      cycles:u                  #    0.074 GHz                      ( +-  1.21% )
> >         82,724,356      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
> >          10,886.69 msec task-clock:u              #    0.996 CPUs utilized            ( +-  0.17% )
> >
> >            10.9298 +- 0.0181 seconds time elapsed  ( +-  0.17% )
> >
> > Note worthy that we still have the following race condition on systems
> > that have shared policy:
> >
> > * CPUs with shared policy can end up sending simultaneous cpufreq
> >   updates requests where the 2nd one will be unlucky and get blocked by
> >   the rate_limit_us (schedutil).
> >
> > We can potentially address this limitation later, but it is out of the
> > scope of this patch.
> >
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >
> > Changes since v1:
> >
> >         * Use taskset and measure with performance governor as Ingo suggested
> >         * Remove the static key as I found out we always register a function
> >           for cpu_dbs in cpufreq_governor.c; and as Christian pointed out it
> >           trigger a lock debug warning.
> >         * Improve detection of sugov workers by using SCHED_FLAG_SUGOV
> >         * Guard against NSEC_PER_MSEC instead of TICK_USEC to avoid prematurely
> >           reducing iowait boost as the latter was a NOP and like
> >           sugov_iowait_reset() like Christian pointed out.
> >
> > v1 discussion: https://lore.kernel.org/all/20240324020139.1032473-1-qyousef@layalina.io/
> >
> >  include/linux/sched/cpufreq.h    |  3 +-
> >  kernel/sched/core.c              | 68 +++++++++++++++++++++++++++++++-
> >  kernel/sched/cpufreq_schedutil.c | 55 +++++++++++++++++++-------
> >  kernel/sched/deadline.c          |  4 --
> >  kernel/sched/fair.c              | 53 ++++---------------------
> >  kernel/sched/rt.c                |  8 +---
> >  kernel/sched/sched.h             |  5 +++
> >  7 files changed, 122 insertions(+), 74 deletions(-)
> >
> > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > index bdd31ab93bc5..2d0a45aba16f 100644
> > --- a/include/linux/sched/cpufreq.h
> > +++ b/include/linux/sched/cpufreq.h
> > @@ -8,7 +8,8 @@
> >   * Interface between cpufreq drivers and the scheduler:
> >   */
> >
> > -#define SCHED_CPUFREQ_IOWAIT   (1U << 0)
> > +#define SCHED_CPUFREQ_IOWAIT           (1U << 0)
> > +#define SCHED_CPUFREQ_FORCE_UPDATE     (1U << 1) /* ignore transition_delay_us */
> >
> >  #ifdef CONFIG_CPU_FREQ
> >  struct cpufreq_policy;
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 1a914388144a..e6fe7dbd1f89 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5134,6 +5134,65 @@ static inline void balance_callbacks(struct rq *rq, struct balance_callback *hea
> >
> >  #endif
> >
> > +static inline void update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> > +{
> > +#ifdef CONFIG_CPU_FREQ
> > +       unsigned int flags = 0;
> > +
> > +#ifdef CONFIG_SMP
> > +       if (unlikely(current->sched_class == &stop_sched_class))
> > +               return;
> > +#endif
> > +
> > +       if (unlikely(current->sched_class == &idle_sched_class))
> > +               return;
> > +
> > +       if (unlikely(task_has_idle_policy(current)))
> > +               return;
> > +
> > +       if (likely(fair_policy(current->policy))) {
> > +
> > +               if (unlikely(current->in_iowait)) {
> > +                       flags |= SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE;
> > +                       goto force_update;
> > +               }
> > +
> > +#ifdef CONFIG_SMP
> > +               /*
> > +                * Allow cpufreq updates once for every update_load_avg() decay.
> > +                */
> > +               if (unlikely(rq->cfs.decayed)) {
> > +                       rq->cfs.decayed = false;
> > +                       goto force_update;
> > +               }
> > +#endif
> > +               return;
> > +       }
> > +
> > +       /*
> > +        * RT and DL should always send a freq update. But we can do some
> > +        * simple checks to avoid it when we know it's not necessary.
> > +        */
> > +       if (rt_task(current) && rt_task(prev)) {
> > +#ifdef CONFIG_UCLAMP_TASK
> > +               unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> > +               unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);
> > +
> > +               if (curr_uclamp_min == prev_uclamp_min)
> > +#endif
> > +                       return;
> > +       } else if (dl_task(current) && current->dl.flags & SCHED_FLAG_SUGOV) {
> > +               /* Ignore sugov kthreads, they're responding to our requests */
> > +               return;
> > +       }
> > +
> > +       flags |= SCHED_CPUFREQ_FORCE_UPDATE;
> > +
> > +force_update:
> > +       cpufreq_update_util(rq, flags);
> > +#endif
> > +}
> > +
> >  static inline void
> >  prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> >  {
> > @@ -5151,7 +5210,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
> >  #endif
> >  }
> >
> > -static inline void finish_lock_switch(struct rq *rq)
> > +static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
> >  {
> >         /*
> >          * If we are tracking spinlock dependencies then we have to
> > @@ -5160,6 +5219,11 @@ static inline void finish_lock_switch(struct rq *rq)
> >          */
> >         spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
> >         __balance_callbacks(rq);
> > +       /*
> > +        * Request freq update after __balance_callbacks to take into account
> > +        * any changes to rq.
> > +        */
> > +       update_cpufreq_ctx_switch(rq, prev);
> >         raw_spin_rq_unlock_irq(rq);
> >  }
> >
> > @@ -5278,7 +5342,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> >         perf_event_task_sched_in(prev, current);
> >         finish_task(prev);
> >         tick_nohz_task_switch();
> > -       finish_lock_switch(rq);
> > +       finish_lock_switch(rq, prev);
> >         finish_arch_post_lock_switch();
> >         kcov_finish_switch(current);
> >         /*
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index eece6244f9d2..e8b65b75e7f3 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -59,7 +59,8 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
> >
> >  /************************ Governor internals ***********************/
> >
> > -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> > +static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
> > +                                    unsigned int flags)
> >  {
> >         s64 delta_ns;
> >
> > @@ -87,13 +88,16 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >                 return true;
> >         }
> >
> > +       if (unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
> > +               return true;
> > +
> >         delta_ns = time - sg_policy->last_freq_update_time;
> >
> >         return delta_ns >= sg_policy->freq_update_delay_ns;
> >  }
> >
> >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> > -                                  unsigned int next_freq)
> > +                                  unsigned int next_freq, unsigned int flags)
> >  {
> >         if (sg_policy->need_freq_update)
> >                 sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > @@ -101,7 +105,9 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >                 return false;
> >
> >         sg_policy->next_freq = next_freq;
> > -       sg_policy->last_freq_update_time = time;
> > +
> > +       if (!unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
> > +               sg_policy->last_freq_update_time = time;
> >
> >         return true;
> >  }
> > @@ -249,9 +255,10 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> >                                unsigned int flags)
> >  {
> >         bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
> > +       bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
> >
> >         /* Reset boost if the CPU appears to have been idle enough */
> > -       if (sg_cpu->iowait_boost &&
> > +       if (sg_cpu->iowait_boost && !forced_update &&
> >             sugov_iowait_reset(sg_cpu, time, set_iowait_boost))
> >                 return;
> >
> > @@ -294,17 +301,34 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> >   * being more conservative on tasks which does sporadic IO operations.
> >   */
> >  static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> > -                              unsigned long max_cap)
> > +                              unsigned long max_cap, unsigned int flags)
> >  {
> > +       bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
> > +       s64 delta_ns = time - sg_cpu->last_update;
> > +
> >         /* No boost currently required */
> >         if (!sg_cpu->iowait_boost)
> >                 return 0;
> >
> > +       if (forced_update)
> > +               goto apply_boost;
> > +
> >         /* Reset boost if the CPU appears to have been idle enough */
> >         if (sugov_iowait_reset(sg_cpu, time, false))
> >                 return 0;
> >
> >         if (!sg_cpu->iowait_boost_pending) {
> > +               /*
> > +                * This logic relied on PELT signal decays happening once every
> > +                * 1ms. But due to changes to how updates are done now, we can
> > +                * end up with more request coming up leading to iowait boost
> > +                * to be prematurely reduced. Make the assumption explicit
> > +                * until we improve the iowait boost logic to be better in
> > +                * general as it is due for an overhaul.
> > +                */
> > +               if (delta_ns <= NSEC_PER_MSEC)
> > +                       goto apply_boost;
> > +
> >                 /*
> >                  * No boost pending; reduce the boost value.
> >                  */
> > @@ -315,6 +339,7 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> >                 }
> >         }
> >
> > +apply_boost:
> >         sg_cpu->iowait_boost_pending = false;
> >
> >         /*
> > @@ -358,10 +383,10 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
> >
> >         ignore_dl_rate_limit(sg_cpu);
> >
> > -       if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
> > +       if (!sugov_should_update_freq(sg_cpu->sg_policy, time, flags))
> >                 return false;
> >
> > -       boost = sugov_iowait_apply(sg_cpu, time, max_cap);
> > +       boost = sugov_iowait_apply(sg_cpu, time, max_cap, flags);
> >         sugov_get_util(sg_cpu, boost);
> >
> >         return true;
> > @@ -397,7 +422,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> >                 sg_policy->cached_raw_freq = cached_freq;
> >         }
> >
> > -       if (!sugov_update_next_freq(sg_policy, time, next_f))
> > +       if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
> >                 return;
> >
> >         /*
> > @@ -449,10 +474,12 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
> >         cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> >                                    sg_cpu->util, max_cap);
> >
> > -       sg_cpu->sg_policy->last_freq_update_time = time;
> > +       if (!unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
> > +               sg_cpu->sg_policy->last_freq_update_time = time;
> >  }
> >
> > -static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> > +static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time,
> > +                                          unsigned int flags)
> >  {
> >         struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> >         struct cpufreq_policy *policy = sg_policy->policy;
> > @@ -465,7 +492,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> >                 struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> >                 unsigned long boost;
> >
> > -               boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
> > +               boost = sugov_iowait_apply(j_sg_cpu, time, max_cap, flags);
> >                 sugov_get_util(j_sg_cpu, boost);
> >
> >                 util = max(j_sg_cpu->util, util);
> > @@ -488,10 +515,10 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
> >
> >         ignore_dl_rate_limit(sg_cpu);
> >
> > -       if (sugov_should_update_freq(sg_policy, time)) {
> > -               next_f = sugov_next_freq_shared(sg_cpu, time);
> > +       if (sugov_should_update_freq(sg_policy, time, flags)) {
> > +               next_f = sugov_next_freq_shared(sg_cpu, time, flags);
> >
> > -               if (!sugov_update_next_freq(sg_policy, time, next_f))
> > +               if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
> >                         goto unlock;
> >
> >                 if (sg_policy->policy->fast_switch_enabled)
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index a04a436af8cc..02c9c2488091 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -252,8 +252,6 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
> >         dl_rq->running_bw += dl_bw;
> >         SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
> >         SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
> > -       /* kick cpufreq (see the comment in kernel/sched/sched.h). */
> > -       cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
> >  }
> >
> >  static inline
> > @@ -266,8 +264,6 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
> >         SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
> >         if (dl_rq->running_bw > old)
> >                 dl_rq->running_bw = 0;
> > -       /* kick cpufreq (see the comment in kernel/sched/sched.h). */
> > -       cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
> >  }
> >
> >  static inline
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9eb63573110c..cbe79c8ac2ed 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3982,29 +3982,6 @@ static inline void update_cfs_group(struct sched_entity *se)
> >  }
> >  #endif /* CONFIG_FAIR_GROUP_SCHED */
> >
> > -static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
> > -{
> > -       struct rq *rq = rq_of(cfs_rq);
> > -
> > -       if (&rq->cfs == cfs_rq) {
> > -               /*
> > -                * There are a few boundary cases this might miss but it should
> > -                * get called often enough that that should (hopefully) not be
> > -                * a real problem.
> > -                *
> > -                * It will not get called when we go idle, because the idle
> > -                * thread is a different class (!fair), nor will the utilization
> > -                * number include things like RT tasks.
> > -                *
> > -                * As is, the util number is not freq-invariant (we'd have to
> > -                * implement arch_scale_freq_capacity() for that).
> > -                *
> > -                * See cpu_util_cfs().
> > -                */
> > -               cpufreq_update_util(rq, flags);
> > -       }
> > -}
> > -
> >  #ifdef CONFIG_SMP
> >  static inline bool load_avg_is_decayed(struct sched_avg *sa)
> >  {
> > @@ -4682,7 +4659,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >
> >         add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
> >
> > -       cfs_rq_util_change(cfs_rq, 0);
> > +       cpufreq_update_util(rq_of(cfs_rq), 0);
> >
> >         trace_pelt_cfs_tp(cfs_rq);
> >  }
> > @@ -4712,7 +4689,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >
> >         add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
> >
> > -       cfs_rq_util_change(cfs_rq, 0);
> > +       cpufreq_update_util(rq_of(cfs_rq), 0);
> >
> >         trace_pelt_cfs_tp(cfs_rq);
> >  }
> > @@ -4729,7 +4706,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >  {
> >         u64 now = cfs_rq_clock_pelt(cfs_rq);
> > -       int decayed;
> >
> >         /*
> >          * Track task load average for carrying it to new CPU after migrated, and
> > @@ -4738,8 +4714,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >         if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
> >                 __update_load_avg_se(now, cfs_rq, se);
> >
> > -       decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> > -       decayed |= propagate_entity_load_avg(se);
> > +       cfs_rq->decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> > +       cfs_rq->decayed |= propagate_entity_load_avg(se);
> >
> >         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> >
> > @@ -4760,11 +4736,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >                  */
> >                 detach_entity_load_avg(cfs_rq, se);
> >                 update_tg_load_avg(cfs_rq);
> > -       } else if (decayed) {
> > -               cfs_rq_util_change(cfs_rq, 0);
> > -
> > -               if (flags & UPDATE_TG)
> > -                       update_tg_load_avg(cfs_rq);
> > +       } else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
> > +               update_tg_load_avg(cfs_rq);
> >         }
> >  }
> >
> > @@ -5139,7 +5112,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> >
> >  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
> >  {
> > -       cfs_rq_util_change(cfs_rq, 0);
> >  }
> >
> >  static inline void remove_entity_load_avg(struct sched_entity *se) {}
> > @@ -6754,14 +6726,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >          */
> >         util_est_enqueue(&rq->cfs, p);
> >
> > -       /*
> > -        * If in_iowait is set, the code below may not trigger any cpufreq
> > -        * utilization updates, so do it here explicitly with the IOWAIT flag
> > -        * passed.
> > -        */
> > -       if (p->in_iowait)
> > -               cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> > -
> >         for_each_sched_entity(se) {
> >                 if (se->on_rq)
> >                         break;
> > @@ -9351,10 +9315,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
> >         unsigned long hw_pressure;
> >         bool decayed;
> >
> > -       /*
> > -        * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
> > -        * DL and IRQ signals have been updated before updating CFS.
> > -        */
> >         curr_class = rq->curr->sched_class;
> >
> >         hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> > @@ -12685,6 +12645,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> >
> >         update_misfit_status(curr, rq);
> >         check_update_overutilized_status(task_rq(curr));
> > +       cpufreq_update_util(rq, 0);
> >
> >         task_tick_core(rq, curr);
> >  }
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 3261b067b67e..fe6d8b0ffa95 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -556,11 +556,8 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
> >
> >         rt_se = rt_rq->tg->rt_se[cpu];
> >
> > -       if (!rt_se) {
> > +       if (!rt_se)
> >                 dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
> > -               /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> > -               cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
> > -       }
> >         else if (on_rt_rq(rt_se))
> >                 dequeue_rt_entity(rt_se, 0);
> >  }
> > @@ -1065,9 +1062,6 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
> >                 add_nr_running(rq, rt_rq->rt_nr_running);
> >                 rt_rq->rt_queued = 1;
> >         }
> > -
> > -       /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> > -       cpufreq_update_util(rq, 0);
> >  }
> >
> >  #if defined CONFIG_SMP
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index cb3792c04eea..86cec2145221 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -632,6 +632,11 @@ struct cfs_rq {
> >                 unsigned long   runnable_avg;
> >         } removed;
> >
> > +       /*
> > +        * Store whether last update_load_avg() has decayed
> > +        */
> > +       bool                    decayed;
> > +
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >         u64                     last_update_tg_load_avg;
> >         unsigned long           tg_load_avg_contrib;
> > --
> > 2.34.1
> >

