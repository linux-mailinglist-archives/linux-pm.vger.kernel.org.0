Return-Path: <linux-pm+bounces-940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A91E80E99F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 12:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D13F1C20A4E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4845CD18;
	Tue, 12 Dec 2023 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lskCaD5x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03134AB
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 03:06:47 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ba0dfc9001so722000b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 03:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702379206; x=1702984006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNxF7QXliSE92DNXgeY61a9nlDcm8BgNVtHOlvR8QXg=;
        b=lskCaD5xq9Kt2OFx1ULEtynGD+FaRQ5Dfv5sSKaR+fhuTWSyhs1vXWszeDjVNjnULL
         C5xWFRzXyjvP/AXIKlebUJhSPQ8+VO6uu/jJLLnUs4SrYtOdvWFV8hn86f2jCRUBBK5Z
         T3Ixrf+7iGVxVgJyOwcIh9oe7ZGCEqjmzpwwLN3ZEOqMEhqZkNCwuYFvuYLounVK20rH
         BweM7NZMjjxO7uApMVnL1xEVvc2VfW4E7J5SD8nsfYDhOaUzrc9kL48itMg+wIx3WFkj
         X9EvsChxHNoo8eWwjhfrCnioNXxLtmsjFI6xPm6uMVmWeSPpsFiWPbH4ksihtzwPwcAa
         GRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702379206; x=1702984006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNxF7QXliSE92DNXgeY61a9nlDcm8BgNVtHOlvR8QXg=;
        b=Jz0stve1jisD2O2Qi2pWmX9s11LIa0JL1JLtoNG5zDYghd/l0Sgg7XumRPA2Akodpz
         KhUAusDn6/PUXxCt3OSeDBe+KKQLSKHR4Y3U0gsOTB5ddNprVfqjGs1RLFrSJSsIaYs2
         3K4Ci0ZydWHRjYmMOsXsk0DyNsgxf0279vE9dX1RMEklmpB4pGzqIY+JIOxZkCX28dsf
         BwwcRcfswJxf9Gh+qRyjtdQ6iL31xhr+sl1icTzaH9KZYZu8yWmARPmcLIRQaUcCZZ6i
         Jj4yRpt3alWnmAerMeDDrGKgCsnlE8ZdaXmVe6HBkPR2mgpo4CNH36URoH0mpw3oGMrF
         p9qQ==
X-Gm-Message-State: AOJu0YxgS2K9AXGZcU4XHOCW9C9BJs986IR52OcYuFzYLdbPTn/lxFgq
	9OHccqNaagJWfVbj6n2hpaU8nqMm/wYbpATFaDww/Q==
X-Google-Smtp-Source: AGHT+IG9VsGCBbFb71zjlG6HiglE/1G6CAxNkD5Lw3EuI8Ai5PbeHso86ikiUCm9LTYCj3UWUX926IkgL86FRkRwkPM=
X-Received: by 2002:a05:6808:6506:b0:3ba:b1f:f468 with SMTP id
 fm6-20020a056808650600b003ba0b1ff468mr2183045oib.103.1702379206210; Tue, 12
 Dec 2023 03:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208015242.385103-1-qyousef@layalina.io> <20231208015242.385103-2-qyousef@layalina.io>
In-Reply-To: <20231208015242.385103-2-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 12 Dec 2023 12:06:33 +0100
Message-ID: <CAKfTPtAKainBfpPOKTJ21zQmmYw7O0Z0v8utfg=QTBtE1L5O_w@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling cpufreq_update_util()
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>, 
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>, 
	Hongyan Xia <hongyan.xia2@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Dec 2023 at 02:52, Qais Yousef <qyousef@layalina.io> wrote:
>
> Due to the way code is structured, it makes a lot of sense to trigger
> cpufreq_update_util() from update_load_avg(). But this is too aggressive
> as in most cases we are iterating through entities in a loop to
> update_load_avg() in the hierarchy. So we end up sending too many
> request in an loop as we're updating the hierarchy.
>
> Combine this with the rate limit in schedutil, we could end up
> prematurely send up a wrong frequency update before we have actually
> updated all entities appropriately.
>
> Be smarter about it by limiting the trigger to perform frequency updates
> after all accounting logic has done. This ended up being in the
> following points:
>
> 1. enqueue/dequeue_task_fair()
> 2. throttle/unthrottle_cfs_rq()
> 3. attach/detach_task_cfs_rq()
> 4. task_tick_fair()
> 5. __sched_group_set_shares()
>
> This is not 100% ideal still due to other limitations that might be
> a bit harder to handle. Namely we can end up with premature update
> request in the following situations:
>
> a. Simultaneous task enqueue on the CPU where 2nd task is bigger and
>    requires higher freq. The trigger to cpufreq_update_util() by the
>    first task will lead to dropping the 2nd request until tick. Or
>    another CPU in the same policy trigger a freq update.
>
> b. CPUs sharing a policy can end up with the same race in a but the
>    simultaneous enqueue happens on different CPUs in the same policy.
>
> The above though are limitations in the governor/hardware, and from
> scheduler point of view at least that's the best we can do. The
> governor might consider smarter logic to aggregate near simultaneous
> request and honour the higher one.
>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 55 ++++++++++++---------------------------------
>  1 file changed, 14 insertions(+), 41 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b83448be3f79..f99910fc6705 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3997,29 +3997,6 @@ static inline void update_cfs_group(struct sched_entity *se)
>  }
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
> -static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
> -{
> -       struct rq *rq = rq_of(cfs_rq);
> -
> -       if (&rq->cfs == cfs_rq) {
> -               /*
> -                * There are a few boundary cases this might miss but it should
> -                * get called often enough that that should (hopefully) not be
> -                * a real problem.
> -                *
> -                * It will not get called when we go idle, because the idle
> -                * thread is a different class (!fair), nor will the utilization
> -                * number include things like RT tasks.
> -                *
> -                * As is, the util number is not freq-invariant (we'd have to
> -                * implement arch_scale_freq_capacity() for that).
> -                *
> -                * See cpu_util_cfs().
> -                */
> -               cpufreq_update_util(rq, flags);
> -       }
> -}
> -
>  #ifdef CONFIG_SMP
>  static inline bool load_avg_is_decayed(struct sched_avg *sa)
>  {
> @@ -4648,8 +4625,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>
>         add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
>
> -       cfs_rq_util_change(cfs_rq, 0);
> -
>         trace_pelt_cfs_tp(cfs_rq);
>  }
>
> @@ -4678,8 +4653,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>
>         add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
>
> -       cfs_rq_util_change(cfs_rq, 0);
> -
>         trace_pelt_cfs_tp(cfs_rq);
>  }
>
> @@ -4726,11 +4699,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>                  */
>                 detach_entity_load_avg(cfs_rq, se);
>                 update_tg_load_avg(cfs_rq);
> -       } else if (decayed) {
> -               cfs_rq_util_change(cfs_rq, 0);
> -
> -               if (flags & UPDATE_TG)
> -                       update_tg_load_avg(cfs_rq);
> +       } else if (decayed && (flags & UPDATE_TG)) {
> +               update_tg_load_avg(cfs_rq);
>         }
>  }
>
> @@ -5114,7 +5084,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
>  {
> -       cfs_rq_util_change(cfs_rq, 0);
>  }
>
>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
> @@ -5807,6 +5776,8 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>         sub_nr_running(rq, task_delta);
>
>  done:
> +       cpufreq_update_util(rq, 0);
> +
>         /*
>          * Note: distribution will already see us throttled via the
>          * throttled-list.  rq->lock protects completion.
> @@ -5899,6 +5870,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  unthrottle_throttle:
>         assert_list_leaf_cfs_rq(rq);
>
> +       cpufreq_update_util(rq, 0);
> +
>         /* Determine whether we need to wake up potentially idle CPU: */
>         if (rq->curr == rq->idle && rq->cfs.nr_running)
>                 resched_curr(rq);
> @@ -6704,14 +6677,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>          */
>         util_est_enqueue(&rq->cfs, p);
>
> -       /*
> -        * If in_iowait is set, the code below may not trigger any cpufreq
> -        * utilization updates, so do it here explicitly with the IOWAIT flag
> -        * passed.
> -        */
> -       if (p->in_iowait)
> -               cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> -
>         for_each_sched_entity(se) {
>                 if (se->on_rq)
>                         break;
> @@ -6772,6 +6737,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  enqueue_throttle:
>         assert_list_leaf_cfs_rq(rq);
>

Here and in the other places below,  you lose :

 -       } else if (decayed) {

The decayed condition ensures a rate limit (~1ms) in the number of
calls to cpufreq_update_util.

enqueue/dequeue/tick don't create any sudden change in the PELT
signals that would require to update cpufreq of the change unlike
attach/detach


> +       cpufreq_update_util(rq, p->in_iowait ? SCHED_CPUFREQ_IOWAIT : 0);
> +
>         hrtick_update(rq);
>  }
>
> @@ -6849,6 +6816,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>
>  dequeue_throttle:
>         util_est_update(&rq->cfs, p, task_sleep);
> +       cpufreq_update_util(rq, 0);
>         hrtick_update(rq);
>  }
>
> @@ -8482,6 +8450,7 @@ done: __maybe_unused;
>
>         update_misfit_status(p, rq);
>         sched_fair_update_stop_tick(rq, p);
> +       cpufreq_update_util(rq, 0);
>
>         return p;
>
> @@ -12615,6 +12584,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>
>         update_misfit_status(curr, rq);
>         update_overutilized_status(task_rq(curr));
> +       cpufreq_update_util(rq, 0);
>
>         task_tick_core(rq, curr);
>  }
> @@ -12739,6 +12709,7 @@ static void detach_task_cfs_rq(struct task_struct *p)
>         struct sched_entity *se = &p->se;
>
>         detach_entity_cfs_rq(se);
> +       cpufreq_update_util(task_rq(p), 0);
>  }
>
>  static void attach_task_cfs_rq(struct task_struct *p)
> @@ -12746,6 +12717,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
>         struct sched_entity *se = &p->se;
>
>         attach_entity_cfs_rq(se);
> +       cpufreq_update_util(task_rq(p), 0);
>  }
>
>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
> @@ -12991,6 +12963,7 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
>                         update_load_avg(cfs_rq_of(se), se, UPDATE_TG);
>                         update_cfs_group(se);
>                 }
> +               cpufreq_update_util(rq, 0);
>                 rq_unlock_irqrestore(rq, &rf);
>         }
>
> --
> 2.34.1
>

