Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A818AFBAA7
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 22:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKMV0v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 16:26:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33800 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMV0v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 16:26:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id l202so3244151oig.1;
        Wed, 13 Nov 2019 13:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ulm3TO78QEzNGSejaw7/WsSdRu/n1BBBFr2ZBtO2aiA=;
        b=Fmslr2aiYv8DiciTmRJSVU5IM8PiZ3GWEk2e3UDafKaIaxAp0AQ39+rczZojJMflKs
         xnyRNO/WaMIvlJutpX+GRKkY8XmCcqnpd3zdzJw4LHmXxX/260uri3N54ycWf/JH0xfT
         kKsbpxadiJiAb7GAGt1BR4q80j1Ya/DX+rEwbzTGGWcB+gXdff77r0ySFn7/BV/wF+nf
         icFkpb8doWbkd94CrTNTV1GLMr9aCywoxlJf6ifnHMeDMmYdUjKkTLB9ljkzZvHZuwa8
         J58pawU9/F/vAbrHTH/De1ukFkhFzJ2/7QbxZ6VgBEL1BFo0PesWsLW4Jwyc3Dkh+p+M
         cs0w==
X-Gm-Message-State: APjAAAUaNYak3IENuAXeHs+8SHiQSF3bvodlZhArmCFqfV7SxLS3Ew5Z
        h8l+hvLrHOz+UAAC1W0AlE3II2UC99dVLx2796A=
X-Google-Smtp-Source: APXvYqzBXbGOlS1Alwf55kEy55iqC7gLiVlimSASw9RmOY6WEwXBmwt6ERSXr5v0yU1vm5CKBpn+3IDSFDOMUzdB9Eo=
X-Received: by 2002:aca:1101:: with SMTP id 1mr639681oir.103.1573680410014;
 Wed, 13 Nov 2019 13:26:50 -0800 (PST)
MIME-Version: 1.0
References: <1573676461-7990-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1573676461-7990-1-git-send-email-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Nov 2019 22:26:36 +0100
Message-ID: <CAJZ5v0iM7v6QPKcGNoNqL-PitpOL41byOw_CZGAqhcJkvA1jXA@mail.gmail.com>
Subject: Re: [PATCH v3] sched/freq: move call to cpufreq_update_util
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, sargun@sargun.me,
        Tejun Heo <tj@kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>,
        xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 13, 2019 at 9:21 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> which might be inefficient when cpufreq driver has rate limitation.
>
> When a task is attached on a CPU, we have call path:
>
> update_load_avg()
>   update_cfs_rq_load_avg()
>     cfs_rq_util_change -- > trig frequency update
>   attach_entity_load_avg()
>     cfs_rq_util_change -- > trig frequency update
>
> The 1st frequency update will not take into account the utilization of the
> newly attached task and the 2nd one might be discard because of rate
> limitation of the cpufreq driver.
>
> update_cfs_rq_load_avg() is only called by update_blocked_averages()
> and update_load_avg() so we can move the call to
> cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> interesting to notice that update_load_avg() already calls directly
> cfs_rq_util_change() for !SMP case.
>
> This changes will also ensure that cpufreq_update_util() is called even
> when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> irq, rt or dl pelt signals.
>
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Looks reasonable to me:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> changes for v3:
> - fix typo
> - test the decay of root cfs_rq even for !CONFIG_FAIR_GROUP_SCHED case
>
>  kernel/sched/fair.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69a81a5..0a8f4ea 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3504,9 +3504,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>         cfs_rq->load_last_update_time_copy = sa->last_update_time;
>  #endif
>
> -       if (decayed)
> -               cfs_rq_util_change(cfs_rq, 0);
> -
>         return decayed;
>  }
>
> @@ -3616,8 +3613,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
> @@ -7543,6 +7544,7 @@ static void update_blocked_averages(int cpu)
>         const struct sched_class *curr_class;
>         struct rq_flags rf;
>         bool done = true;
> +       int decayed;
>
>         rq_lock_irqsave(rq, &rf);
>         update_rq_clock(rq);
> @@ -7552,9 +7554,9 @@ static void update_blocked_averages(int cpu)
>          * that RT, DL and IRQ signals have been updated before updating CFS.
>          */
>         curr_class = rq->curr->sched_class;
> -       update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -       update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -       update_irq_load_avg(rq, 0);
> +       decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> +       decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> +       decayed |= update_irq_load_avg(rq, 0);
>
>         /* Don't need periodic decay once load/util_avg are null */
>         if (others_have_blocked(rq))
> @@ -7567,9 +7569,13 @@ static void update_blocked_averages(int cpu)
>         for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
>                 struct sched_entity *se;
>
> -               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> +               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
>                         update_tg_load_avg(cfs_rq, 0);
>
> +                       if (cfs_rq == &rq->cfs)
> +                               decayed = 1;
> +               }
> +
>                 /* Propagate pending load changes to the parent, if any: */
>                 se = cfs_rq->tg->se[cpu];
>                 if (se && !skip_blocked_update(se))
> @@ -7588,6 +7594,9 @@ static void update_blocked_averages(int cpu)
>         }
>
>         update_blocked_load_status(rq, !done);
> +
> +       if (decayed)
> +               cpufreq_update_util(rq, 0);
>         rq_unlock_irqrestore(rq, &rf);
>  }
>
> @@ -7644,6 +7653,7 @@ static inline void update_blocked_averages(int cpu)
>         struct cfs_rq *cfs_rq = &rq->cfs;
>         const struct sched_class *curr_class;
>         struct rq_flags rf;
> +       int decayed;
>
>         rq_lock_irqsave(rq, &rf);
>         update_rq_clock(rq);
> @@ -7653,13 +7663,16 @@ static inline void update_blocked_averages(int cpu)
>          * that RT, DL and IRQ signals have been updated before updating CFS.
>          */
>         curr_class = rq->curr->sched_class;
> -       update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> -       update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> -       update_irq_load_avg(rq, 0);
> +       decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> +       decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> +       decayed |= update_irq_load_avg(rq, 0);
>
> -       update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +       decayed |= update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
>
>         update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
> +
> +       if (decayed)
> +               cpufreq_update_util(rq, 0);
>         rq_unlock_irqrestore(rq, &rf);
>  }
>
> --
> 2.7.4
>
