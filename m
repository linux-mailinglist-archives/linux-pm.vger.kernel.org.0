Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B814D296CFF
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462312AbgJWKnt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 06:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370818AbgJWKnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 06:43:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8636C0613D2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 03:43:46 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c141so1512974lfg.5
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hX2vYJZ80wn7kxAb5HtIBdRCSK0BTvIRqh4ttR+s86k=;
        b=cutOjjAt8yIVSUEEQbVLDFpj+ssrPK5V9esf+lWhCzeVi/rzRNSft9+oR8a2IL1QPe
         0kjp0xj3i1+0Y739FAjly7OkgMqnXergJNo59lJ+QFs5A7FG36TYLE7J/vw+N5Y3RX3h
         CGkGYWAgBIS+fljN7LXJCJMAfHFHawqZHxRho/IfhFrnNYISyXR9UpPWISiToLKEVOxS
         4sYQctZuD6bftNBCg5ZINU+7n0m+nd9c8uFl1KJFI4ql+eAktRrO2wtUH5JHXLyxpme/
         +oE1lyPoUELIsCMSohv1l250LZJyYq32/98UHapakW2sPP0XDwpsd5RkjmHQuuNrG9iJ
         dlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hX2vYJZ80wn7kxAb5HtIBdRCSK0BTvIRqh4ttR+s86k=;
        b=Pyhbr3GGcJ+aw6QhTIF85kD9gW5IxvwYkostvAul7kF+a3uHmkVnTJVvyAP61klSG3
         t7JOgHAjwz8vfJcQBzDYHqmpjXVtcVbL0saMA5KrXd4u8sDSPx+NeoK92Ko08ZeKPrEI
         Jx1ysJ/UOCY/qn9C0TbumDsOaS2/oBrjjhio9ZoxaOEYmENWT9EpP3IKduLrLd/zTufT
         M2WbwiYLaAtELHr608EBNOicivAVh/QaBHU7TRvu+Iz7PyB8IRO7EUWqfzeBN8ppvHAK
         UOQWp1OE9dFuL3E4791lOl96FQ2bfsKVwkyLr9MPLlEO2L2FwUIJmahyiCQO1Kf1vsWO
         gTRA==
X-Gm-Message-State: AOAM532FbzpkcDQ8FfyITjGKhy1RqG8UBJRIMmfH7LOpmsdNVr9f42X+
        r1Mb4HHmTtfPswJHMjSnGfY9WVyLEjLocqPmuIaakg==
X-Google-Smtp-Source: ABdhPJz8uzOFUY3Q1SSFbiYNf287Ci+dzAhGsTFJRXpQ7gqA79ErRGP4da6Nbj4Pgw70H1JbZFonqqydYVUJahP+T1Y=
X-Received: by 2002:ac2:5e6c:: with SMTP id a12mr600297lfr.568.1603449824767;
 Fri, 23 Oct 2020 03:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603448113.git.viresh.kumar@linaro.org> <80c66f55ac7f04b3ecd4ebf12d69d86c89480fa7.1603448113.git.viresh.kumar@linaro.org>
In-Reply-To: <80c66f55ac7f04b3ecd4ebf12d69d86c89480fa7.1603448113.git.viresh.kumar@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 23 Oct 2020 12:43:33 +0200
Message-ID: <CAKfTPtBxhofb0mVz4Dc=Fqycgf8p5F3s2J4LBxNTL+uBHBU3Ww@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] sched/core: Rename and move schedutil_cpu_util()
 to core.c
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 23 Oct 2020 at 12:20, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> There is nothing schedutil specific in schedutil_cpu_util(), move it to
> core.c and rename it to sched_cpu_util(), so it can be used from other

I wonder if pelt.c would be a better place for this than core.c ?

> parts of the kernel as well.
>
> The cpufreq_cooling stuff will make use of this in a later commit.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/sched.h            |  19 +++++
>  kernel/sched/core.c              | 113 ++++++++++++++++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c | 116 +------------------------------
>  kernel/sched/fair.c              |   6 +-
>  kernel/sched/sched.h             |  29 +-------
>  5 files changed, 140 insertions(+), 143 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 393db0690101..3c27c10141cb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1930,6 +1930,25 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
>  #define TASK_SIZE_OF(tsk)      TASK_SIZE
>  #endif
>
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
> +
>  #ifdef CONFIG_RSEQ
>
>  /*
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d2003a7d5ab5..369ff54d11d4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5117,6 +5117,119 @@ struct task_struct *idle_task(int cpu)
>         return cpu_rq(cpu)->idle;
>  }
>
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
> +
>  /**
>   * find_process_by_pid - find a process with a matching PID value.
>   * @pid: the pid in question.
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 5ae7b4e6e8d6..0c5c61a095f6 100644
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
>  }
>
>  /**
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aa4c6227cd6d..52e2d866e875 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6499,7 +6499,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                  * is already enough to scale the EM reported power
>                  * consumption at the (eventually clamped) cpu_capacity.
>                  */
> -               sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
> +               sum_util += effective_cpu_util(cpu, util_cfs, cpu_cap,
>                                                ENERGY_UTIL, NULL);
>
>                 /*
> @@ -6509,7 +6509,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                  * NOTE: in case RT tasks are running, by default the
>                  * FREQUENCY_UTIL's utilization can be max OPP.
>                  */
> -               cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
> +               cpu_util = effective_cpu_util(cpu, util_cfs, cpu_cap,
>                                               FREQUENCY_UTIL, tsk);
>                 max_util = max(max_util, cpu_util);
>         }
> @@ -6607,7 +6607,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                          * IOW, placing the task there would make the CPU
>                          * overutilized. Take uclamp into account to see how
>                          * much capacity we can get out of the CPU; this is
> -                        * aligned with schedutil_cpu_util().
> +                        * aligned with sched_cpu_util().
>                          */
>                         util = uclamp_rq_util_with(cpu_rq(cpu), util, p);
>                         if (!fits_capacity(util, cpu_cap))
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index df80bfcea92e..0f0439344eec 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2486,25 +2486,8 @@ static inline unsigned long capacity_orig_of(int cpu)
>  }
>  #endif
>
> -/**
> - * enum schedutil_type - CPU utilization type
> - * @FREQUENCY_UTIL:    Utilization used to select frequency
> - * @ENERGY_UTIL:       Utilization used during energy calculation
> - *
> - * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
> - * need to be aggregated differently depending on the usage made of them. This
> - * enum is used within schedutil_freq_util() to differentiate the types of
> - * utilization expected by the callers, and adjust the aggregation accordingly.
> - */
> -enum schedutil_type {
> -       FREQUENCY_UTIL,
> -       ENERGY_UTIL,
> -};
> -
> -#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> -
> -unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> -                                unsigned long max, enum schedutil_type type,
> +unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> +                                unsigned long max, enum cpu_util_type type,
>                                  struct task_struct *p);
>
>  static inline unsigned long cpu_bw_dl(struct rq *rq)
> @@ -2533,14 +2516,6 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
>  {
>         return READ_ONCE(rq->avg_rt.util_avg);
>  }
> -#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
> -static inline unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> -                                unsigned long max, enum schedutil_type type,
> -                                struct task_struct *p)
> -{
> -       return 0;
> -}
> -#endif /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
>
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  static inline unsigned long cpu_util_irq(struct rq *rq)
> --
> 2.25.0.rc1.19.g042ed3e048af
>
