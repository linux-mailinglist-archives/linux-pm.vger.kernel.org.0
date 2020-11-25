Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1F2C4341
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 16:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgKYPgs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 10:36:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39156 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730762AbgKYPgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 10:36:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id z24so2571073oto.6;
        Wed, 25 Nov 2020 07:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdWYEG6bO7REfLvFs+b2+Rv03aviCzC1Gj+Qcf4HxmE=;
        b=qYNLxFGRnGAx4WbBMZdqKcO1yCxZonB7nYWCVSY/SZ/7oBL1/ZCyNJwhIbmOhibdHS
         3RyIWbeWoytdECw+OQD0vmxCopzBsUg3voAjuMStnSWJnIaS5MJL8+rHKkEtAF85BZNv
         EETC+ZkQ32Ymz6ayNm4rVO+EPeTWcvnM8U+Wb6tSv6pSJcSCmylrBKmJr5xwPxHjBoOO
         NlXSqtAG2hZIzg1hZp0c0GwVWS7fn9BO6p683tjKusyNdUF2hgX/vA2F3EY4b/UIfolN
         i4Uk1iFnTo50Odk756LGTcI+4aV6ExcI9gkDAATPVkgiayzqtuNO0Lp/mQQYYJgLwTF2
         bi6w==
X-Gm-Message-State: AOAM532ZPl9/p7NwKrZCFjAtFs0awjIwW656OAcWQBvVDpYgctAMmlOw
        dmvB//3Z9symo6qndpCF0gUKkAzBhsmkrOVC2hk=
X-Google-Smtp-Source: ABdhPJyFB8kcatLquZaRhm57RGkEio8a614ZZVcLM/xICN9Gau/Ge2wE3BIM0QhhOECIKeEBVh8tBfavTF8YISvOEy0=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr3177933ots.321.1606318605731;
 Wed, 25 Nov 2020 07:36:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606198885.git.viresh.kumar@linaro.org> <f2eeee144a2e50540bff77d7bbe7351f154e2742.1606198885.git.viresh.kumar@linaro.org>
In-Reply-To: <f2eeee144a2e50540bff77d7bbe7351f154e2742.1606198885.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 16:36:34 +0100
Message-ID: <CAJZ5v0g=2EHGMFUWQ_4+SA6gZN-3s0KTxT9VfY+Ah30e0NfhVw@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] sched/core: Move schedutil_cpu_util() to core.c
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

On Tue, Nov 24, 2020 at 7:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> There is nothing schedutil specific in schedutil_cpu_util(), move it to
> core.c and define it only for CONFIG_SMP.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

For the schedutil part:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/sched/core.c              | 108 +++++++++++++++++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c | 106 ------------------------------
>  kernel/sched/sched.h             |  12 +---
>  3 files changed, 109 insertions(+), 117 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d2003a7d5ab5..b81265aec4a0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5117,6 +5117,114 @@ struct task_struct *idle_task(int cpu)
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
> +unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> +                                unsigned long max, enum schedutil_type type,
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
> +#endif /* CONFIG_SMP */
> +
>  /**
>   * find_process_by_pid - find a process with a matching PID value.
>   * @pid: the pid in question.
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e254745a82cb..2d44befb322b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -169,112 +169,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
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
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index df80bfcea92e..0db6bcf0881f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2484,7 +2484,6 @@ static inline unsigned long capacity_orig_of(int cpu)
>  {
>         return cpu_rq(cpu)->cpu_capacity_orig;
>  }
> -#endif
>
>  /**
>   * enum schedutil_type - CPU utilization type
> @@ -2501,8 +2500,6 @@ enum schedutil_type {
>         ENERGY_UTIL,
>  };
>
> -#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> -
>  unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
>                                  unsigned long max, enum schedutil_type type,
>                                  struct task_struct *p);
> @@ -2533,14 +2530,7 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
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
> +#endif
>
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  static inline unsigned long cpu_util_irq(struct rq *rq)
> --
> 2.25.0.rc1.19.g042ed3e048af
>
