Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC52C4398
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 16:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgKYPjP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 10:39:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33442 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731348AbgKYPjO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 10:39:14 -0500
Received: by mail-oi1-f195.google.com with SMTP id k26so3294536oiw.0;
        Wed, 25 Nov 2020 07:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5xSQTyUsJM93Omkz7IRjm41LBe2hmulti89Q+8iUXs=;
        b=ABtTFa3RsfQBp8Ju1uQu2nHbV0aGhj8+8Df6jJC/bqx7stK9llVw6sBDwBcVbRVJCj
         Iod1IidLLDPIG7f1N+WCcO9mtQSdmbKvQzHB4AO2ApyCMCYVjirY3qzE25S1OD7ozRbC
         gCZu3Irb/78h9W+d70eT65M01VBOFRY5JpVSs1K+tSU2JHn73sU7FyzJPnaVER0Rxxr2
         6nPK8DUtBDp04QSqvP1Zrncjo/rTDUEdEbOtGOKcqRTvwH86PgzBAW0iVpWFPz8EhDQt
         7TonUUaz6DAyX1xcui7/ELxAzdQaV+64Ot+jSMScrlhnL1cnubTwsJmqIH8w89WqDrnp
         V4sg==
X-Gm-Message-State: AOAM531FblKBp4m2tIpNs84jfwVmjy5MbcX9TCY868Hrd7Nopnzb5F3l
        X4HhsQGE/Byti6bZGS77AnZhVPzrkb4EqEWLKmc=
X-Google-Smtp-Source: ABdhPJziNLz54izQ6PorN/fd02CYz9ZBBteVjfLTJ4T0xPBTJ5aNIs3FpFGRLIwojB7tpQIuX2j1IcgD0r0R4tePVhY=
X-Received: by 2002:aca:da02:: with SMTP id r2mr2611827oig.157.1606318753021;
 Wed, 25 Nov 2020 07:39:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606198885.git.viresh.kumar@linaro.org> <9a5442b916f9667e714dd84fe4e3fc26f8bcc887.1606198885.git.viresh.kumar@linaro.org>
In-Reply-To: <9a5442b916f9667e714dd84fe4e3fc26f8bcc887.1606198885.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 16:39:01 +0100
Message-ID: <CAJZ5v0jp1Pana18qu_gQX9=dQZC-e4p87Q1jgh1jAqei5t7JmQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] sched/core: Rename schedutil_cpu_util() and allow
 rest of the kernel to use it
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
> There is nothing schedutil specific in schedutil_cpu_util(), rename it
> to effective_cpu_util(). Also create and expose another wrapper
> sched_cpu_util() which can be used by other parts of the kernel, like
> thermal core (that will be done in a later commit).
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

For the schedutil change:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/sched.h            | 21 +++++++++++++++++++++
>  kernel/sched/core.c              | 11 +++++++++--
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  kernel/sched/fair.c              |  6 +++---
>  kernel/sched/sched.h             | 19 ++-----------------
>  5 files changed, 36 insertions(+), 23 deletions(-)
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
> index b81265aec4a0..845c976ccd53 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5138,8 +5138,8 @@ struct task_struct *idle_task(int cpu)
>   * based on the task model parameters and gives the minimal utilization
>   * required to meet deadlines.
>   */
> -unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> -                                unsigned long max, enum schedutil_type type,
> +unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> +                                unsigned long max, enum cpu_util_type type,
>                                  struct task_struct *p)
>  {
>         unsigned long dl_util, util, irq;
> @@ -5223,6 +5223,13 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
>
>         return min(max, util);
>  }
> +
> +unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
> +                            unsigned long max)
> +{
> +       return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max, type,
> +                                 NULL);
> +}
>  #endif /* CONFIG_SMP */
>
>  /**
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 2d44befb322b..e71627a3792b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -178,7 +178,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>         sg_cpu->max = max;
>         sg_cpu->bw_dl = cpu_bw_dl(rq);
>
> -       return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
> +       return effective_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
>  }
>
>  /**
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 290f9e38378c..0e1c8eb7ad53 100644
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
> index 0db6bcf0881f..4fab3b930ace 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2485,23 +2485,8 @@ static inline unsigned long capacity_orig_of(int cpu)
>         return cpu_rq(cpu)->cpu_capacity_orig;
>  }
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
> -unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> -                                unsigned long max, enum schedutil_type type,
> +unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> +                                unsigned long max, enum cpu_util_type type,
>                                  struct task_struct *p);
>
>  static inline unsigned long cpu_bw_dl(struct rq *rq)
> --
> 2.25.0.rc1.19.g042ed3e048af
>
