Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C12B9298
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 13:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKSMbH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 07:31:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40147 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgKSMbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 07:31:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id m143so6082597oig.7;
        Thu, 19 Nov 2020 04:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcSyl8CDZbLiKmm8MH3XxpP6PQE/c7e8eMMjEOXEYx4=;
        b=ToD6Uui8hI2uoD4UQCCfrGzxBC2FOpEdLnLaRPd/KWxqArQF1HsgTUFxX9I1IfOFmR
         tTnUym6WDwQaOOeN9Vz1fF0CMOWq9/2BgHdkPR2WprkSNaHCLRI9Qv3xqjhCAAP94VYC
         Xc7XHl3ZrZPVO9Cqe3Lc4l3UAG9Lap5Ektnvs7YALA07DfwwIYcbH5YuXCYQ1lv6WxTn
         mf0G+N855+qhmG2gTNwiWXlRn3Py5nP/f1ZykBApLOfJ4UTwsWvqsaZpvcnY/4pHy8wV
         cILciXcidK33DTRCNlTy1UfU/gwrk0OZkXGsWy982uh/Px8mRTpSs2tkpzwFoPX9/29w
         DsjA==
X-Gm-Message-State: AOAM532f4AajXhD550iJT8/QteLPhKVMGkrveulD64yrPbP+LBMy7K++
        gGJSJyU4p6FgYpmgAD2E/2JPMnF4J3zaW5jWlMk=
X-Google-Smtp-Source: ABdhPJzaljU7s50QUeVaBPjGvw2R7FMxQdIvi47xwpG7Z1TW8wZkNXSxp0mgixWpfolRsLugsTpKwnVMlaqo2oqDVNw=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr2096246oib.69.1605789063985;
 Thu, 19 Nov 2020 04:31:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605770951.git.viresh.kumar@linaro.org> <a04646d277f1c93b248346db61c369cb8e7c2d02.1605770951.git.viresh.kumar@linaro.org>
In-Reply-To: <a04646d277f1c93b248346db61c369cb8e7c2d02.1605770951.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Nov 2020 13:30:53 +0100
Message-ID: <CAJZ5v0jViXY56t5LZ-UzTuzA=tq306P0YHwGheoUk+YyTri1xg@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] sched/core: Rename and move schedutil_cpu_util()
 to core.c
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 19, 2020 at 8:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> There is nothing schedutil specific in schedutil_cpu_util(), move it to
> core.c and rename it to sched_cpu_util(), so it can be used from other
> parts of the kernel as well.

The patch does more than this, though.

I would do that in two patches: (1) move the function as is and (2)
rename it and rearrange the users.

> The cpufreq_cooling stuff will make use of this in a later commit.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/sched.h            |  21 ++++++
>  kernel/sched/core.c              | 115 ++++++++++++++++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c | 116 +------------------------------
>  kernel/sched/fair.c              |   6 +-
>  kernel/sched/sched.h             |  31 +--------
>  5 files changed, 145 insertions(+), 144 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 063cd120b459..926b944dae5e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1926,6 +1926,27 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
>  #define TASK_SIZE_OF(tsk)      TASK_SIZE
>  #endif
>
> +#ifdef CONFIG_SMP
> +/**
> + * enum cpu_util_type - CPU utilization type
> + * @FREQUENCY_UTIL:    Utilization used to select frequency
> + * @ENERGY_UTIL:       Utilization used during energy calculation
> + *
> + * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
> + * need to be aggregated differently depending on the usage made of them. This
> + * enum is used within sched_cpu_util() to differentiate the types of
> + * utilization expected by the callers, and adjust the aggregation accordingly.
> + */
> +enum cpu_util_type {
> +       FREQUENCY_UTIL,
> +       ENERGY_UTIL,
> +};
> +
> +/* Returns effective CPU utilization, as seen by the scheduler */
> +unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
> +                            unsigned long max);
> +#endif /* CONFIG_SMP */
> +
>  #ifdef CONFIG_RSEQ
>
>  /*
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d2003a7d5ab5..845c976ccd53 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5117,6 +5117,121 @@ struct task_struct *idle_task(int cpu)
>         return cpu_rq(cpu)->idle;
>  }
>
> +#ifdef CONFIG_SMP
> +/*
> + * This function computes an effective utilization for the given CPU, to be
> + * used for frequency selection given the linear relation: f = u * f_max.
> + *
> + * The scheduler tracks the following metrics:
> + *
> + *   cpu_util_{cfs,rt,dl,irq}()
> + *   cpu_bw_dl()
> + *
> + * Where the cfs,rt and dl util numbers are tracked with the same metric and
> + * synchronized windows and are thus directly comparable.
> + *
> + * The cfs,rt,dl utilization are the running times measured with rq->clock_task
> + * which excludes things like IRQ and steal-time. These latter are then accrued
> + * in the irq utilization.
> + *
> + * The DL bandwidth number otoh is not a measured metric but a value computed
> + * based on the task model parameters and gives the minimal utilization
> + * required to meet deadlines.
> + */
> +unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> +                                unsigned long max, enum cpu_util_type type,
> +                                struct task_struct *p)
> +{
> +       unsigned long dl_util, util, irq;
> +       struct rq *rq = cpu_rq(cpu);
> +
> +       if (!uclamp_is_used() &&
> +           type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
> +               return max;
> +       }
> +
> +       /*
> +        * Early check to see if IRQ/steal time saturates the CPU, can be
> +        * because of inaccuracies in how we track these -- see
> +        * update_irq_load_avg().
> +        */
> +       irq = cpu_util_irq(rq);
> +       if (unlikely(irq >= max))
> +               return max;
> +
> +       /*
> +        * Because the time spend on RT/DL tasks is visible as 'lost' time to
> +        * CFS tasks and we use the same metric to track the effective
> +        * utilization (PELT windows are synchronized) we can directly add them
> +        * to obtain the CPU's actual utilization.
> +        *
> +        * CFS and RT utilization can be boosted or capped, depending on
> +        * utilization clamp constraints requested by currently RUNNABLE
> +        * tasks.
> +        * When there are no CFS RUNNABLE tasks, clamps are released and
> +        * frequency will be gracefully reduced with the utilization decay.
> +        */
> +       util = util_cfs + cpu_util_rt(rq);
> +       if (type == FREQUENCY_UTIL)
> +               util = uclamp_rq_util_with(rq, util, p);
> +
> +       dl_util = cpu_util_dl(rq);
> +
> +       /*
> +        * For frequency selection we do not make cpu_util_dl() a permanent part
> +        * of this sum because we want to use cpu_bw_dl() later on, but we need
> +        * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
> +        * that we select f_max when there is no idle time.
> +        *
> +        * NOTE: numerical errors or stop class might cause us to not quite hit
> +        * saturation when we should -- something for later.
> +        */
> +       if (util + dl_util >= max)
> +               return max;
> +
> +       /*
> +        * OTOH, for energy computation we need the estimated running time, so
> +        * include util_dl and ignore dl_bw.
> +        */
> +       if (type == ENERGY_UTIL)
> +               util += dl_util;
> +
> +       /*
> +        * There is still idle time; further improve the number by using the
> +        * irq metric. Because IRQ/steal time is hidden from the task clock we
> +        * need to scale the task numbers:
> +        *
> +        *              max - irq
> +        *   U' = irq + --------- * U
> +        *                 max
> +        */
> +       util = scale_irq_capacity(util, irq, max);
> +       util += irq;
> +
> +       /*
> +        * Bandwidth required by DEADLINE must always be granted while, for
> +        * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
> +        * to gracefully reduce the frequency when no tasks show up for longer
> +        * periods of time.
> +        *
> +        * Ideally we would like to set bw_dl as min/guaranteed freq and util +
> +        * bw_dl as requested freq. However, cpufreq is not yet ready for such
> +        * an interface. So, we only do the latter for now.
> +        */
> +       if (type == FREQUENCY_UTIL)
> +               util += cpu_bw_dl(rq);
> +
> +       return min(max, util);
> +}
> +
> +unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
> +                            unsigned long max)
> +{
> +       return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max, type,
> +                                 NULL);
> +}
> +#endif /* CONFIG_SMP */
> +
>  /**
>   * find_process_by_pid - find a process with a matching PID value.
>   * @pid: the pid in question.
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e254745a82cb..a6de75c8b984 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -169,122 +169,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
>
> -/*
> - * This function computes an effective utilization for the given CPU, to be
> - * used for frequency selection given the linear relation: f = u * f_max.
> - *
> - * The scheduler tracks the following metrics:
> - *
> - *   cpu_util_{cfs,rt,dl,irq}()
> - *   cpu_bw_dl()
> - *
> - * Where the cfs,rt and dl util numbers are tracked with the same metric and
> - * synchronized windows and are thus directly comparable.
> - *
> - * The cfs,rt,dl utilization are the running times measured with rq->clock_task
> - * which excludes things like IRQ and steal-time. These latter are then accrued
> - * in the irq utilization.
> - *
> - * The DL bandwidth number otoh is not a measured metric but a value computed
> - * based on the task model parameters and gives the minimal utilization
> - * required to meet deadlines.
> - */
> -unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> -                                unsigned long max, enum schedutil_type type,
> -                                struct task_struct *p)
> -{
> -       unsigned long dl_util, util, irq;
> -       struct rq *rq = cpu_rq(cpu);
> -
> -       if (!uclamp_is_used() &&
> -           type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
> -               return max;
> -       }
> -
> -       /*
> -        * Early check to see if IRQ/steal time saturates the CPU, can be
> -        * because of inaccuracies in how we track these -- see
> -        * update_irq_load_avg().
> -        */
> -       irq = cpu_util_irq(rq);
> -       if (unlikely(irq >= max))
> -               return max;
> -
> -       /*
> -        * Because the time spend on RT/DL tasks is visible as 'lost' time to
> -        * CFS tasks and we use the same metric to track the effective
> -        * utilization (PELT windows are synchronized) we can directly add them
> -        * to obtain the CPU's actual utilization.
> -        *
> -        * CFS and RT utilization can be boosted or capped, depending on
> -        * utilization clamp constraints requested by currently RUNNABLE
> -        * tasks.
> -        * When there are no CFS RUNNABLE tasks, clamps are released and
> -        * frequency will be gracefully reduced with the utilization decay.
> -        */
> -       util = util_cfs + cpu_util_rt(rq);
> -       if (type == FREQUENCY_UTIL)
> -               util = uclamp_rq_util_with(rq, util, p);
> -
> -       dl_util = cpu_util_dl(rq);
> -
> -       /*
> -        * For frequency selection we do not make cpu_util_dl() a permanent part
> -        * of this sum because we want to use cpu_bw_dl() later on, but we need
> -        * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
> -        * that we select f_max when there is no idle time.
> -        *
> -        * NOTE: numerical errors or stop class might cause us to not quite hit
> -        * saturation when we should -- something for later.
> -        */
> -       if (util + dl_util >= max)
> -               return max;
> -
> -       /*
> -        * OTOH, for energy computation we need the estimated running time, so
> -        * include util_dl and ignore dl_bw.
> -        */
> -       if (type == ENERGY_UTIL)
> -               util += dl_util;
> -
> -       /*
> -        * There is still idle time; further improve the number by using the
> -        * irq metric. Because IRQ/steal time is hidden from the task clock we
> -        * need to scale the task numbers:
> -        *
> -        *              max - irq
> -        *   U' = irq + --------- * U
> -        *                 max
> -        */
> -       util = scale_irq_capacity(util, irq, max);
> -       util += irq;
> -
> -       /*
> -        * Bandwidth required by DEADLINE must always be granted while, for
> -        * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
> -        * to gracefully reduce the frequency when no tasks show up for longer
> -        * periods of time.
> -        *
> -        * Ideally we would like to set bw_dl as min/guaranteed freq and util +
> -        * bw_dl as requested freq. However, cpufreq is not yet ready for such
> -        * an interface. So, we only do the latter for now.
> -        */
> -       if (type == FREQUENCY_UTIL)
> -               util += cpu_bw_dl(rq);
> -
> -       return min(max, util);
> -}
> -
>  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
> -       struct rq *rq = cpu_rq(sg_cpu->cpu);
> -       unsigned long util = cpu_util_cfs(rq);
> -       unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> -
> -       sg_cpu->max = max;
> -       sg_cpu->bw_dl = cpu_bw_dl(rq);
> +       sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
> +       sg_cpu->bw_dl = cpu_bw_dl(cpu_rq(sg_cpu->cpu));
>
> -       return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
> +       return sched_cpu_util(sg_cpu->cpu, FREQUENCY_UTIL, sg_cpu->max);

I don't see much value in using this wrapper here TBH and it
introduces an otherwise redundant cpu_rq() computation.

>  }
>
>  /**
