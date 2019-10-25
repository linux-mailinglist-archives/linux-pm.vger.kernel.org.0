Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78562E519B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440810AbfJYQvQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 12:51:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35999 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440793AbfJYQvP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2019 12:51:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id u16so2302549lfq.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2019 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiOTygXbDKrYQL09NBGtGxxHh+cjKKps5VsTzvQh9uU=;
        b=Th4ij+Lc/8Bo/uugPI1jq65sIDjnyNfmWFr/lyGbd4AaiAqVPcqfolY/zN4ev4nN1P
         PNv1mml7QhKBECIz/16IEM8fIeizlembJBNRTA/3I6UmkZ8NAXMXaD4fkKFign+4WxKN
         2MT1WsmbRaqyZZuPW+zETYU/uH33qpeCq6/rwyoTJ7Cw7SXM4EIrFF+L87Y2+xw2Zq20
         CLqIINvPd2y+mwaHUVrgRACoGA2WltM6fsJuVmUaBl6mYBoLUIDzKlI2pU4qZQLrA2/8
         MVg3VbXPeMNz73vJLQN4PHBSCHqPlOI9zTcCWLA+aI2SYoBpSZffsrERXdJX33NQ4b7k
         D7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiOTygXbDKrYQL09NBGtGxxHh+cjKKps5VsTzvQh9uU=;
        b=bGGBoDwvCxrgNcxXTGUNxnezeZG1kSqIP2SxdcWb9sBcGvyRVyojS4iaTC8Jc/3FKD
         cCPhP113GkpqdR5k3Qwdxhq7TPtA1r6T44o5tL6VHfoXtJ0rHNn5bHl+HPGjJz8FJJJo
         YFy9xdkVCNtjMV0w3yrZ7pQlrDAQejA+7moIi9qvkbvK3vdqBiE/DkNIdtZYbouOfBWa
         bx60nOsOOglOKplbQn39gbEmRQJsN4VpvR0Ngd8We4MpwVlXYg+xzfOmLGmoF4CCA+jz
         L+awL0B7TSxFWvoIQ+3BtxTO648Oj4nNm37qiG2wrKKSdWnVtBkgpbsjgEOh5xAW8nzR
         5Brg==
X-Gm-Message-State: APjAAAU3OcZNOULQcJ3mandmYkmb8mj2dKNlw2kQOb4cq79HbMTlnt5z
        dz9HngEYE6k/9UtTLKt4rQ0Ub9UIGd1IdoUQ1cwtuA==
X-Google-Smtp-Source: APXvYqwfjO8QJQNG5ueZVjSO+qmEER1wgu5HXr4sDZlDBle96ivSoeHaSj41A0QHAjwDobcKB98UYHcd4J/UDNdQXjM=
X-Received: by 2002:a19:ca13:: with SMTP id a19mr3303908lfg.133.1572022273329;
 Fri, 25 Oct 2019 09:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
In-Reply-To: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 25 Oct 2019 18:51:01 +0200
Message-ID: <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
To:     Doug Smythies <doug.smythies@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,


On Fri, 25 Oct 2019 at 17:55, Doug Smythies <doug.smythies@gmail.com> wrote:
>
> This reverts commit 039ae8bcf7a5f4476f4487e6bf816885fb3fb617,
> which, in turn, was a re-apply of
> commit a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")
> after it was reverted via
> commit c40f7d74c741 ("sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c")
>
> For an idle system, the cfs_rq_is_decayed function components can underflow to 0 and
> incorrectly return TRUE, when the item should not be deleted from the list.

The patch from Rik solves the problem of cfs_rq_is_decayed wrongly returns true
https://lore.kernel.org/lkml/20190906191237.27006-6-riel@surriel.com/

>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: sargun@sargun.me
> Cc: tj@kernel.org
> Cc: xiexiuqi@huawei.com
> Cc: xiezhipeng1@huawei.com
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> ---
> Note 1: Both this reversion and just deleting the cfs_rq_is_decayed function
> and it's call and leaving the other changes have been tested. I do not know
> which solution is better. (ie for the "list_for_each_entry_rcu" part of it.)
>
> Note 2: Previous controversy over this patch was based on heavy workloads,
> but this is based on minimal or no workload, or "idle".
> Where "idle" on my test server, with no gui and many services disabled,
> tends to mean more "idle" than most systems.
>
> Note 3: While this supporting data only involves the intel_pstate CPU
> frequency scaling driver as a casualty, it is beyond my capabilities
> to determine what other tasks that should be running might be omitted.
>
> Use case example 1:
> System Idle: The intel pstate CPU frequency scaling driver:
> Mode: Active, non-hwp, powersave governor.
> Expected behaviour: There is never ever a duration (time between calls to
> the driver / per CPU) longer than 4 seconds (the watchdog time, I think).
> Actual behaviour: There are long long gaps between calls to the driver:
>
> Kernel: 5.4-rc2 CPU:7
> duration: 327.17 Seconds. (this is one of many hundreds of examples.)
> mpref: 44023326
> apref: 20716861
> tsc: 1.11604E+12
> load: 0
> CPU frequency: 1.6053 GHz (average over this 327 second sample period).
> old pstate: 16 (the lowest for my processor)
> new pstate: 16
>
> Kernel: 5.4-rc2 + reversion (either method)
> After several hours of testing, maximum durations were never more
> than 4 seconds (well plus some jitter).
> reversion method: max=4.07908 seconds
> CPU:7
> mperf: 492578
> apref: 231813 (56,829 per second average is consistent with other tests)
> tsc: 13914264074
> load: 0
> CPU frequency: 1.6052 GHz
> old pstate: 16 (the lowest for my precessor)
> new pstate: 16
>
> On average, the non-reverted kernel executes the driver 25% less
> than the reverted kernel during idle.
>
> O.K. so who cares, the requested pstate doesn't change?
> First, one wonders if the math could overflow.
> (although 7180ddd suggests maybe it won't)
> Second, the sample is largely dominated by obsolete information.
> Third, this can be problematic, and potentially wastes energy,
> for the busy to idle transition.
>
> Use case example 2:
> The busy to idle transition:
>
> Typically, the pstate request response to a busy to idle transition
> is very slow because the duration suddenly goes from, typically,
> 10 milliseconds to much much longer, up to 4 seconds. Transition
> times to the system being fully idle, with all requested pstates
> being at minimum, takes around 8 seconds with this reversion,
> and, potentially, a very very long time (over 100 seconds has been
> measured) without.
>
> Again, so who cares, if the processor is in a deep idle state anyway,
> not consuming much energy? O.K. but what if it is in an idle state
> where energy consumption is a function of the requested pstate?
> For example, for my processor (i7-2600K), idle state 1, then processor
> package energy can be over double what it should be for many 10s of
> seconds.
>
> Experiment method:
>
> enable only idle state 1
> Dountil stopped
>   apply a 100% load (all CPUs)
>   after awhile (about 50 seconds) remove the load.
>   allow a short transient delay (1 second).
>   measure the processor package joules used over the next 149 seconds.
> Enduntil
>
> Kernel k5.4-rc2 + reversion (this method)
> Average processor package power: 9.148 watts (128 samples, > 7 hours)
> Minimum: 9.02 watts
> Maximum: 9.29 watts
> Note: outlyer data point group removed, as it was assumed the computer
> had something to do and wasn't actually "idle".
>
> Kernel 5.4-rc2:
> Average processor package power: 9.969 watts (150 samples, > 8 hours)
> Or 9% more energy for the idle phases of the work load.
> Minimum: 9.15 watts
> Maximum: 13.79 watts (51% more power)
>
> ---
>  kernel/sched/fair.c | 43 +++++++++----------------------------------
>  1 file changed, 9 insertions(+), 34 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 83ab35e..51625b8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -381,10 +381,9 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
>         SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
>  }
>
> -/* Iterate thr' all leaf cfs_rq's on a runqueue */
> -#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)                     \
> -       list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,    \
> -                                leaf_cfs_rq_list)
> +/* Iterate through all cfs_rq's on a runqueue in bottom-up order */
> +#define for_each_leaf_cfs_rq(rq, cfs_rq) \
> +       list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
>
>  /* Do the two (enqueued) entities belong to the same group ? */
>  static inline struct cfs_rq *
> @@ -481,8 +480,8 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
>  {
>  }
>
> -#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)     \
> -               for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
> +#define for_each_leaf_cfs_rq(rq, cfs_rq)       \
> +               for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
>
>  static inline struct sched_entity *parent_entity(struct sched_entity *se)
>  {
> @@ -7502,27 +7501,10 @@ static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>
> -static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> -{
> -       if (cfs_rq->load.weight)
> -               return false;
> -
> -       if (cfs_rq->avg.load_sum)
> -               return false;
> -
> -       if (cfs_rq->avg.util_sum)
> -               return false;
> -
> -       if (cfs_rq->avg.runnable_load_sum)
> -               return false;
> -
> -       return true;
> -}
> -
>  static void update_blocked_averages(int cpu)
>  {
>         struct rq *rq = cpu_rq(cpu);
> -       struct cfs_rq *cfs_rq, *pos;
> +       struct cfs_rq *cfs_rq;
>         const struct sched_class *curr_class;
>         struct rq_flags rf;
>         bool done = true;
> @@ -7534,7 +7516,7 @@ static void update_blocked_averages(int cpu)
>          * Iterates the task_group tree in a bottom up fashion, see
>          * list_add_leaf_cfs_rq() for details.
>          */
> -       for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
> +       for_each_leaf_cfs_rq(rq, cfs_rq) {
>                 struct sched_entity *se;
>
>                 if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> @@ -7545,13 +7527,6 @@ static void update_blocked_averages(int cpu)
>                 if (se && !skip_blocked_update(se))
>                         update_load_avg(cfs_rq_of(se), se, 0);
>
> -               /*
> -                * There can be a lot of idle CPU cgroups.  Don't let fully
> -                * decayed cfs_rqs linger on the list.
> -                */
> -               if (cfs_rq_is_decayed(cfs_rq))
> -                       list_del_leaf_cfs_rq(cfs_rq);
> -
>                 /* Don't need periodic decay once load/util_avg are null */
>                 if (cfs_rq_has_blocked(cfs_rq))
>                         done = false;
> @@ -10444,10 +10419,10 @@ const struct sched_class fair_sched_class = {
>  #ifdef CONFIG_SCHED_DEBUG
>  void print_cfs_stats(struct seq_file *m, int cpu)
>  {
> -       struct cfs_rq *cfs_rq, *pos;
> +       struct cfs_rq *cfs_rq;
>
>         rcu_read_lock();
> -       for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
> +       for_each_leaf_cfs_rq(cpu_rq(cpu), cfs_rq)
>                 print_cfs_rq(m, cpu, cfs_rq);
>         rcu_read_unlock();
>  }
> --
> 2.7.4
>
