Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A7A21F1E7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 14:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgGNMwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 08:52:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34422 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNMwy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 08:52:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id e90so12953921ote.1;
        Tue, 14 Jul 2020 05:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4I1sELXCmqS6NNJrJ2mhXkXbWty737WKNFh+t7WOqyI=;
        b=iG10tDCyldPBrHVzdtcyqD6Vpk9qx82FqJjhS6uu/0FRWFUk+Sv+GwlFLbcDjsH6V3
         Fzeu0jBHS8WfFUmCvRgJYgnLEj8X/6D5AQSC7Sv1PWHwlmkL+kHOQLq9CS245sWyYSfG
         VeLrdJ0wW09LthsyAa1FAS9PohQk28PhJkjJc1UPOykCtS6ihMbsffvqpu3UbnixQSpW
         /ZGLkNOcbVKBJZRVCqIwe9soGa16vsy0+LJWlsj9EVS8zP8maglrjfqHK4tUYujEN+pB
         CA46+GK1t79ZG6YZGRRH1ixhHosgqHCnZb6wD69aS9FcN+QNPMtp8EOvG9QVGTd9Je4F
         IJdw==
X-Gm-Message-State: AOAM531Be/wKwPxC19c9e+GANDExPsVenggWzruXeHdnm0EK0TBEh/3X
        HwyeeCoOqJXhQyUfE1d2nCP1Fdr/QLt081+2onY=
X-Google-Smtp-Source: ABdhPJyuRSR59MzSXnaDDJvByPqwrTS+oMSWhpVsLrkpEVpDnfZKeng1FMkzzPb1sESbEUjv+ddKFr5edfQZMEcOOc0=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr3792659ota.167.1594731172938;
 Tue, 14 Jul 2020 05:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594707424.git.viresh.kumar@linaro.org> <83d42cb2e589235750d68c9beada882ec93aeedd.1594707424.git.viresh.kumar@linaro.org>
In-Reply-To: <83d42cb2e589235750d68c9beada882ec93aeedd.1594707424.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 14:52:40 +0200
Message-ID: <CAJZ5v0h2jh=nrVG+gKWUKwCBYGtJjAFgs9yh81G=eNa4sd+fhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/core: Rename and move schedutil_cpu_util to core.c
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 8:37 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> There is nothing schedutil specific in schedutil_cpu_util() and is used
> by fair.c as well. Allow it to be used by other parts of the kernel as
> well.
>
> Move it to core.c and rename it to effective_cpu_util(). While at it,
> rename "enum schedutil_type" as well.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

> ---
>  kernel/sched/core.c              | 106 ++++++++++++++++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c | 108 +------------------------------
>  kernel/sched/fair.c              |   6 +-
>  kernel/sched/sched.h             |  20 ++----
>  4 files changed, 115 insertions(+), 125 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a2a244af9a53..c5b345fdf81d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4879,6 +4879,112 @@ struct task_struct *idle_task(int cpu)
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
>  /**
>   * find_process_by_pid - find a process with a matching PID value.
>   * @pid: the pid in question.
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index dc6835bc6490..e9623527741b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -183,112 +183,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
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
>         struct rq *rq = cpu_rq(sg_cpu->cpu);
> @@ -298,7 +192,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>         sg_cpu->max = max;
>         sg_cpu->bw_dl = cpu_bw_dl(rq);
>
> -       return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
> +       return effective_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
>  }
>
>  /**
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3213cb247aff..94d564745499 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6490,7 +6490,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                  * is already enough to scale the EM reported power
>                  * consumption at the (eventually clamped) cpu_capacity.
>                  */
> -               sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
> +               sum_util += effective_cpu_util(cpu, util_cfs, cpu_cap,
>                                                ENERGY_UTIL, NULL);
>
>                 /*
> @@ -6500,7 +6500,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                  * NOTE: in case RT tasks are running, by default the
>                  * FREQUENCY_UTIL's utilization can be max OPP.
>                  */
> -               cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
> +               cpu_util = effective_cpu_util(cpu, util_cfs, cpu_cap,
>                                               FREQUENCY_UTIL, tsk);
>                 max_util = max(max_util, cpu_util);
>         }
> @@ -6597,7 +6597,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                          * IOW, placing the task there would make the CPU
>                          * overutilized. Take uclamp into account to see how
>                          * much capacity we can get out of the CPU; this is
> -                        * aligned with schedutil_cpu_util().
> +                        * aligned with effective_cpu_util().
>                          */
>                         util = uclamp_rq_util_with(cpu_rq(cpu), util, p);
>                         if (!fits_capacity(util, cpu_cap))
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 65b72e0487bf..dabfc7fa1270 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2465,24 +2465,22 @@ static inline unsigned long capacity_orig_of(int cpu)
>  #endif
>
>  /**
> - * enum schedutil_type - CPU utilization type
> + * enum cpu_util_type - CPU utilization type
>   * @FREQUENCY_UTIL:    Utilization used to select frequency
>   * @ENERGY_UTIL:       Utilization used during energy calculation
>   *
>   * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
>   * need to be aggregated differently depending on the usage made of them. This
> - * enum is used within schedutil_freq_util() to differentiate the types of
> + * enum is used within effective_cpu_util() to differentiate the types of
>   * utilization expected by the callers, and adjust the aggregation accordingly.
>   */
> -enum schedutil_type {
> +enum cpu_util_type {
>         FREQUENCY_UTIL,
>         ENERGY_UTIL,
>  };
>
> -#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> -
> -unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> -                                unsigned long max, enum schedutil_type type,
> +unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> +                                unsigned long max, enum cpu_util_type type,
>                                  struct task_struct *p);
>
>  static inline unsigned long cpu_bw_dl(struct rq *rq)
> @@ -2511,14 +2509,6 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
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
