Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6914BFEB47
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2019 09:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfKPIr4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Nov 2019 03:47:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44650 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfKPIr4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Nov 2019 03:47:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id z188so9805054lfa.11
        for <linux-pm@vger.kernel.org>; Sat, 16 Nov 2019 00:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bp91uD0/PiW/BRpY7HaS8KieB9FSTnD2w31WsW+jdmY=;
        b=y/4486Eimo018DrcBEqfmHn2cw4vwyZQL2FCCIS1qbeA6plSyTD641cf2JiLmZfIuo
         4f0qXk8sgbQTXuOb/5CIVc6wl0W5vCcFS25hiBBIp9Fq2tktamU1gw7VQNYUpzoUaHMu
         ycZsSZbULIx8Olov6AhZCOyf2wnVMOJSvf4o1A+uxVRblkzfC0IatMiqu6G5df85zk9a
         Io1BLR+3IbByD/Qq3QcLtR3qugFClG7AUpW/HFFWBH1sz3hAGw64mo7WSgsVWbyPfJVa
         BBbIaNGv5XC7DOSBrgZLLhPkuJAy67DG3p5TCdVdJ8iDVWKax6JIx59FE/uv+cRyWYji
         SyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bp91uD0/PiW/BRpY7HaS8KieB9FSTnD2w31WsW+jdmY=;
        b=KGYirsPeZcfSIcl4MD1nhHxQEhjrBmOSJDUq+qq1c833NgNusjMudbNe9OPyzyGTVI
         zHpPgpRU/cLRCLL8G9SjAGvu6wVOo9rs3tfzTpKME3044dR2zGFgo4n7tEh84vW/ENby
         lbl4VvspdmSeyGgWtG2pJeg8RwiZbuPtgEWgSgUtF/rL/1DFXKtdWS28epmnPIC2qVLN
         ItVT4rlJ0DIBsu7aOpMfwV7Le4LwwiluZsnEIL1hsnlwHMQSQt9znunJGgxMI8r88OpC
         4IFMXk2AuiQE+IzEbImjBscxhuRAtbj0JQAORx/hj/WIWq/IOvaB4WvL5WSD763IJdXe
         otww==
X-Gm-Message-State: APjAAAWH6mWizvozf6U7X1YxTlW+cLSHoT121ZQpxWohEsRNS33etY/b
        DEHvAdzdHCkiKYBSI3E9Wa9+cMjrMKW7ofyg+dyqSQ==
X-Google-Smtp-Source: APXvYqzMLc7nuk9MO3TViXexHb2VFT5V9zfY78caMJQJZvQ3BdJcJwM2SZ/Hh81F2Ka+cDnlzaN/kpIyULvjcA/Io38=
X-Received: by 2002:a19:800a:: with SMTP id b10mr14490861lfd.15.1573894073025;
 Sat, 16 Nov 2019 00:47:53 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org> <20191115215228.GN3079@worktop.programming.kicks-ass.net>
In-Reply-To: <20191115215228.GN3079@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 16 Nov 2019 09:47:41 +0100
Message-ID: <CAKfTPtDyZ5gom41S-8Nu+BMK7hPijWoZPqo0HFYkRnNmWo1UTA@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Nov 2019 at 22:52, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> > which might be inefficient when cpufreq driver has rate limitation.
> >
> > When a task is attached on a CPU, we have call path:
> >
> > update_load_avg()
> >   update_cfs_rq_load_avg()
> >     cfs_rq_util_change -- > trig frequency update
> >   attach_entity_load_avg()
> >     cfs_rq_util_change -- > trig frequency update
> >
> > The 1st frequency update will not take into account the utilization of the
> > newly attached task and the 2nd one might be discard because of rate
> > limitation of the cpufreq driver.
> >
> > update_cfs_rq_load_avg() is only called by update_blocked_averages()
> > and update_load_avg() so we can move the call to
> > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> > interesting to notice that update_load_avg() already calls directly
> > cfs_rq_util_change() for !SMP case.
> >
> > This changes will also ensure that cpufreq_update_util() is called even
> > when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> > irq, rt or dl pelt signals.
> >
> > Reported-by: Doug Smythies <dsmythies@telus.net>
> > Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---
>
> OK, but shall we write it like so instead?

Yes. Looks good to me

>
> ---
>  kernel/sched/fair.c | 111 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 62 insertions(+), 49 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 545bcb90b4de..7a762266c335 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3508,9 +3508,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>         cfs_rq->load_last_update_time_copy = sa->last_update_time;
>  #endif
>
> -       if (decayed)
> -               cfs_rq_util_change(cfs_rq, 0);
> -
>         return decayed;
>  }
>
> @@ -3620,8 +3617,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>                 attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
>                 update_tg_load_avg(cfs_rq, 0);
>
> -       } else if (decayed && (flags & UPDATE_TG))
> -               update_tg_load_avg(cfs_rq, 0);
> +       } else if (decayed) {
> +               cfs_rq_util_change(cfs_rq, 0);
> +
> +               if (flags & UPDATE_TG)
> +                       update_tg_load_avg(cfs_rq, 0);
> +       }
>  }
>
>  #ifndef CONFIG_64BIT
> @@ -7428,6 +7429,28 @@ static inline bool others_have_blocked(struct rq *rq) { return false; }
>  static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
>  #endif
>
> +static bool __update_blocked_others(struct rq *rq, bool *done)
> +{
> +       const struct sched_class *curr_class;
> +       u64 now = rq_clock_pelt(rq);
> +       bool decayed;
> +
> +       /*
> +        * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
> +        * DL and IRQ signals have been updated before updating CFS.
> +        */
> +       curr_class = rq->curr->sched_class;
> +
> +       decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> +                 update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> +                 update_irq_load_avg(rq, 0);
> +
> +       if (others_have_blocked(rq))
> +               *done = false;
> +
> +       return decayed;
> +}
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>
>  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> @@ -7447,29 +7470,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>         return true;
>  }
>
> -static void update_blocked_averages(int cpu)
> +static bool __update_blocked_fair(struct rq *rq, bool *done)
>  {
> -       struct rq *rq = cpu_rq(cpu);
>         struct cfs_rq *cfs_rq, *pos;
> -       const struct sched_class *curr_class;
> -       struct rq_flags rf;
> -       bool done = true;
> -
> -       rq_lock_irqsave(rq, &rf);
> -       update_rq_clock(rq);
> -
> -       /*
> -        * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
> -        * that RT, DL and IRQ signals have been updated before updating CFS.
> -        */
> -       curr_class = rq->curr->sched_class;
> -       update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -       update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -       update_irq_load_avg(rq, 0);
> -
> -       /* Don't need periodic decay once load/util_avg are null */
> -       if (others_have_blocked(rq))
> -               done = false;
> +       bool decayed = false;
> +       int cpu = cpu_of(rq);
>
>         /*
>          * Iterates the task_group tree in a bottom up fashion, see
> @@ -7478,9 +7483,13 @@ static void update_blocked_averages(int cpu)
>         for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
>                 struct sched_entity *se;
>
> -               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> +               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
>                         update_tg_load_avg(cfs_rq, 0);
>
> +                       if (cfs_rq == &rq->cfs)
> +                               decayed = true;
> +               }
> +
>                 /* Propagate pending load changes to the parent, if any: */
>                 se = cfs_rq->tg->se[cpu];
>                 if (se && !skip_blocked_update(se))
> @@ -7495,11 +7504,10 @@ static void update_blocked_averages(int cpu)
>
>                 /* Don't need periodic decay once load/util_avg are null */
>                 if (cfs_rq_has_blocked(cfs_rq))
> -                       done = false;
> +                       *done = false;
>         }
>
> -       update_blocked_load_status(rq, !done);
> -       rq_unlock_irqrestore(rq, &rf);
> +       return decayed;
>  }
>
>  /*
> @@ -7549,29 +7557,16 @@ static unsigned long task_h_load(struct task_struct *p)
>                         cfs_rq_load_avg(cfs_rq) + 1);
>  }
>  #else
> -static inline void update_blocked_averages(int cpu)
> +static bool __update_blocked_fair(struct rq *rq, bool *done)
>  {
> -       struct rq *rq = cpu_rq(cpu);
>         struct cfs_rq *cfs_rq = &rq->cfs;
> -       const struct sched_class *curr_class;
> -       struct rq_flags rf;
> -
> -       rq_lock_irqsave(rq, &rf);
> -       update_rq_clock(rq);
> -
> -       /*
> -        * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
> -        * that RT, DL and IRQ signals have been updated before updating CFS.
> -        */
> -       curr_class = rq->curr->sched_class;
> -       update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -       update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -       update_irq_load_avg(rq, 0);
> +       bool decayed;
>
> -       update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +       decayed = update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +       if (cfs_rq_has_blocked(cfs_rq))
> +               *done = false;
>
> -       update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
> -       rq_unlock_irqrestore(rq, &rf);
> +       return decayed;
>  }
>
>  static unsigned long task_h_load(struct task_struct *p)
> @@ -7580,6 +7575,24 @@ static unsigned long task_h_load(struct task_struct *p)
>  }
>  #endif
>
> +static void update_blocked_averages(int cpu)
> +{
> +       bool decayed = false, done = true;
> +       struct rq *rq = cpu_rq(cpu);
> +       struct rq_flags rf;
> +
> +       rq_lock_irqsave(rq, &rf);
> +       update_rq_clock(rq);
> +
> +       decayed |= __update_blocked_others(rq, &done);
> +       decayed |= __update_blocked_fair(rq, &done);
> +
> +       update_blocked_load_status(rq, !done);
> +       if (decayed)
> +               cpufreq_update_util(rq, 0);
> +       rq_unlock_irqrestore(rq, &rf);
> +}
> +
>  /********** Helpers for find_busiest_group ************************/
>
>  /*
>
