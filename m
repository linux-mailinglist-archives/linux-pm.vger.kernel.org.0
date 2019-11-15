Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5C6FE146
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 16:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfKOPbu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 10:31:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38713 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfKOPbu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 10:31:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so11135949ljh.5
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykMLw7c6H8/K5CaztcyfkwioTDKwoxliChMIVSSHonE=;
        b=OEh7auQ/a82nLIsYH5bimIotZ6VGn0EP4rnWaNo08EsuWLTfnju/KOe/Vh8VX6fE5C
         hGyspaPy8Fhfy7l/5PT5aQ5gkMeVCa6SIQonXQuuASEjYRxOxNyOJEGMyeAbaWo8mzgq
         LJ/LEO8eib4gwWaT83FUU2b4icQH2AB8CfaMShV9nB+HiX5dlbJedQSTfhLxF3MOF93U
         b9+pU1VG/VH14u/Ssv1exGuRXH0MPl6Cf7MxEu8tmIJRu8JrxHQXeeqSZ347Bw+GqZkC
         Bd2248apFA2wYiD7C5emF1DhRFWM5qFXcPVkJp0zZi0aplWPH5uQi8GctTmt664UrHUb
         NaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykMLw7c6H8/K5CaztcyfkwioTDKwoxliChMIVSSHonE=;
        b=FeAiQ5QuteaI6cnAJAklxU2ib9oQxVgw7ZnUPYU5VIsh1h0+ipTN1OYF703uvM5y2e
         WPH173wNY/rkVrRYYbhgAQIovawO5qJQ6t5o7hg6QI33Gba5FNmA6sm0DAlvIon0IHa6
         AyozrJkLT8TX9TK9alvjFAhxg5P1T3K204RGohjdeWqHkDMpSnmY0go7iegtub+bDt4R
         cQGoyXFaqco6Rr0PCeMvWNL/CmZrSQjvtv0wKvdRZWh8XvQLtmTk4LtteZs+fo1mC0ys
         Qcz1wfGbN/qCxJFniXZV2PvBQE3faYp+D+MyQaeHl26mlK1DwuegE7l8es2ct43jJSEF
         hR1g==
X-Gm-Message-State: APjAAAWYlCjATgS1L/5KsMVmtf3i4W6muVJOyzKDqNnCZFubrmb57fyk
        fbOu380y32DxiIQfNYC6WKyYoUZ5lBXpWAIV/gobtA==
X-Google-Smtp-Source: APXvYqwlKVcJKcJym0hbZ2tjVVBo4LzGmnYLWGfHlD3WOYhJNMzYPHJf4/MpUQOsYELfViEMD6QYR4ykc2DiuV6pqCQ=
X-Received: by 2002:a2e:9748:: with SMTP id f8mr10390818ljj.87.1573831907226;
 Fri, 15 Nov 2019 07:31:47 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115132520.GJ4131@hirez.programming.kicks-ass.net> <CAKfTPtB4UGmZ53iVRsOV+k4MiS=Dzqw2-6_sBhko0bHRMAed2g@mail.gmail.com>
 <20191115151220.GO4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115151220.GO4131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 16:31:35 +0100
Message-ID: <CAKfTPtCg-zEysYmGSFTa4bjh0D=sf1UsT0WpeWcVrb9SLt+VZw@mail.gmail.com>
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

On Fri, 15 Nov 2019 at 16:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 15, 2019 at 02:37:27PM +0100, Vincent Guittot wrote:
> > On Fri, 15 Nov 2019 at 14:25, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Should not all 3 have their windows aligned and thus alway return the
> > > exact same value?
> >
> > rt and dl yes but not irq
> >
> > But having aligned window doesn't mean that they will all decay.
> > One can have been updated just before (during a dequeue as an example)
> > or at least less than 1ms before
>
> Now, the thing is, if that update happened in sched/rt, then it wouldn't
> have called cpufreq anyway. And once we're idle longer than a period,
> they'll all decay at once.
>
> Except indeed that IRQ stuff, which runs out of sync.
>
> That is, I'm just not convinced it matters much if we keep rq->cfs
> on the list forever (like UP). Because we'll only stop calling when
> update_blocked_averages() when everything hit 0, and up until that
> point, we'll get one update per period from rq->cfs.
>
> For good measure we can force an update when @done, at that point we
> know all 0s.
>
> How is something like this?
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 545bcb90b4de..a99ac2aa4a23 100644
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
> @@ -7453,7 +7454,7 @@ static void update_blocked_averages(int cpu)
>         struct cfs_rq *cfs_rq, *pos;
>         const struct sched_class *curr_class;
>         struct rq_flags rf;
> -       bool done = true;
> +       bool done = true, decayed = false;
>
>         rq_lock_irqsave(rq, &rf);
>         update_rq_clock(rq);
> @@ -7476,10 +7477,14 @@ static void update_blocked_averages(int cpu)
>          * list_add_leaf_cfs_rq() for details.
>          */
>         for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
> +               bool last = cfs_rq == &rq->cfs;
>                 struct sched_entity *se;
>
> -               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> +               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
>                         update_tg_load_avg(cfs_rq, 0);
> +                       if (last)

using this last make code more readable

> +                               decayed = true;
> +               }
>
>                 /* Propagate pending load changes to the parent, if any: */
>                 se = cfs_rq->tg->se[cpu];
> @@ -7490,7 +7495,7 @@ static void update_blocked_averages(int cpu)
>                  * There can be a lot of idle CPU cgroups.  Don't let fully
>                  * decayed cfs_rqs linger on the list.
>                  */
> -               if (cfs_rq_is_decayed(cfs_rq))
> +               if (!last && cfs_rq_is_decayed(cfs_rq))
>                         list_del_leaf_cfs_rq(cfs_rq);

Keeping root cfs in the list will not change anything now that
cfs_rq_util_change is in update_load_avg()
cfs_rq_util_change will not be called

>
>                 /* Don't need periodic decay once load/util_avg are null */
> @@ -7498,6 +7503,9 @@ static void update_blocked_averages(int cpu)
>                         done = false;
>         }
>
> +       if (decayed || done)

I'm not sure to get why you want to call cpufreq when done is true
which means that everything reaches 0
Why do you prefer to use done instead of ORing the decay of  rt, dl,
irq and cfs ?

> +               cpufreq_update_util(rq, 0);
> +
>         update_blocked_load_status(rq, !done);
>         rq_unlock_irqrestore(rq, &rf);
>  }
> @@ -7555,6 +7563,7 @@ static inline void update_blocked_averages(int cpu)
>         struct cfs_rq *cfs_rq = &rq->cfs;
>         const struct sched_class *curr_class;
>         struct rq_flags rf;
> +       bool done, decayed;
>
>         rq_lock_irqsave(rq, &rf);
>         update_rq_clock(rq);
> @@ -7568,9 +7577,13 @@ static inline void update_blocked_averages(int cpu)
>         update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>         update_irq_load_avg(rq, 0);
>
> -       update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +       decayed = update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +       done = !(cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
>
> -       update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
> +       if (decayed || done)
> +               cpufreq_update_util(rq, 0);
> +
> +       update_blocked_load_status(rq, !done);
>         rq_unlock_irqrestore(rq, &rf);
>  }
>
