Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8128F3A2608
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 10:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFJIEC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 04:04:02 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:34453 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFJIDI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 04:03:08 -0400
Received: by mail-lj1-f177.google.com with SMTP id bn21so3605870ljb.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnj374tBN1u0+7qzi9RKeRcyClGo5IdIx87fr4lI2T4=;
        b=nqcO9g0E4Qf3YS7ABNZtJzHFbs6Xy34fW1S4RMW7INVdY2S2dJUQwa4MGPys+j4iZ2
         1hZfHyQ4x1DMc9DaryQ8C3U2ZyJCikaCzD0ZNFNuIg/bCHh+K4CV/yInNNA+4FPwoRJw
         y27fIdieonmaslTYC9fhiPSDCxUs7J5XhCVpAHdbbLQ/Gi4h4DWE20YQ1NopfnO+iV1w
         q/n70V4CR1RrixxYGS7u9oV3Ck5T3dtfW/gWOJLYaGoho5oLgNpC+Vow0jkIkfJK65Wl
         qtw3bXSDYKgjmsuoZ69n+R+h9itRC9rKu4kV2YYtiaTm61kKIioUXs+UmIhrRbr9Adk4
         r2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnj374tBN1u0+7qzi9RKeRcyClGo5IdIx87fr4lI2T4=;
        b=MEEFCHyxld9FwcfByIZZKJxJ5Hier7OK5qLlcnsTFDhGGYV9fw+iGybTTGaVwO6vWg
         rZz9GedapYDRXZGqR/zLQguc06Cr2rG7fXXtUhJ+sxjSbHSgQpq0s0PZXYvvwzkXYVOi
         kCYwsYl317q53LjYsKvZ4Ml2uPrZ81hXi8Nd6oRKBfwl3oJo2QXiiDuzP5QxCK9jwULu
         mhHz+KSmHNvfgrMsXz8rBEdQ42/tXliGe/lqy+0IQ/sIHljINzOUsaBn1spu/5M7oZ5z
         CInkuPQ7hBGB6PfvGkUu8YnM7b/2T/hLvd+96V4GYc6BFdtcVoh6+rYXP9E9lz4x5rre
         cebQ==
X-Gm-Message-State: AOAM533PvktODU03L1VDy54vYg/4IueUfE4Wh0Vlo0UalIIlQ4MND0QR
        8/Lzbt1YWnWnD9kRX1PijOC1obk3dOlYkyJtnoyw5w==
X-Google-Smtp-Source: ABdhPJz05kC51ip+oetI/9VPzB8Yy8WyxSKGzbYUkHB4rkOAkgNKdyqgm+ow5Df5e9CdZj6h6Zb7iQ6EUkrSdDrOL5M=
X-Received: by 2002:a05:651c:4cf:: with SMTP id e15mr1180751lji.401.1623312002168;
 Thu, 10 Jun 2021 01:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210604080954.13915-1-lukasz.luba@arm.com> <20210604080954.13915-2-lukasz.luba@arm.com>
In-Reply-To: <20210604080954.13915-2-lukasz.luba@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Jun 2021 09:59:51 +0200
Message-ID: <CAKfTPtA0j-hgXC2_LUcbRcWLkLsAB6H_EYewEHJJW+3dVu_hLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 4 Jun 2021 at 10:10, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Energy Aware Scheduling (EAS) needs to be able to predict the frequency
> requests made by the SchedUtil governor to properly estimate energy used
> in the future. It has to take into account CPUs utilization and forecast
> Performance Domain (PD) frequency. There is a corner case when the max
> allowed frequency might be reduced due to thermal. SchedUtil is aware of
> that reduced frequency, so it should be taken into account also in EAS
> estimations.
>
> SchedUtil, as a CPUFreq governor, knows the maximum allowed frequency of
> a CPU, thanks to cpufreq_driver_resolve_freq() and internal clamping
> to 'policy::max'. SchedUtil is responsible to respect that upper limit
> while setting the frequency through CPUFreq drivers. This effective
> frequency is stored internally in 'sugov_policy::next_freq' and EAS has
> to predict that value.
>
> In the existing code the raw value of arch_scale_cpu_capacity() is used
> for clamping the returned CPU utilization from effective_cpu_util().
> This patch fixes issue with too big single CPU utilization, by introducing
> clamping to the allowed CPU capacity. The allowed CPU capacity is a CPU
> capacity reduced by thermal pressure signal. We rely on this load avg
> geometric series in similar way as other mechanisms in the scheduler.
>
> Thanks to knowledge about allowed CPU capacity, we don't get too big value
> for a single CPU utilization, which is then added to the util sum. The
> util sum is used as a source of information for estimating whole PD energy.
> To avoid wrong energy estimation in EAS (due to capped frequency), make
> sure that the calculation of util sum is aware of allowed CPU capacity.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/fair.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 161b92aa1c79..1aeddecabc20 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6527,6 +6527,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>         struct cpumask *pd_mask = perf_domain_span(pd);
>         unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
>         unsigned long max_util = 0, sum_util = 0;
> +       unsigned long _cpu_cap = cpu_cap;
>         int cpu;
>
>         /*
> @@ -6558,14 +6559,24 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                                 cpu_util_next(cpu, p, -1) + task_util_est(p);
>                 }
>
> +               /*
> +                * Take the thermal pressure from non-idle CPUs. They have
> +                * most up-to-date information. For idle CPUs thermal pressure
> +                * signal is not updated so often.

What do you mean by "not updated so often" ? Do you have a value ?

Thermal pressure is updated at the same rate as other PELT values of
an idle CPU. Why is it a problem there ?

> +                */
> +               if (!idle_cpu(cpu))
> +                       _cpu_cap = cpu_cap - thermal_load_avg(cpu_rq(cpu));
> +
>                 /*
>                  * Busy time computation: utilization clamping is not
>                  * required since the ratio (sum_util / cpu_capacity)
>                  * is already enough to scale the EM reported power
>                  * consumption at the (eventually clamped) cpu_capacity.
>                  */
> -               sum_util += effective_cpu_util(cpu, util_running, cpu_cap,
> -                                              ENERGY_UTIL, NULL);
> +               cpu_util = effective_cpu_util(cpu, util_running, cpu_cap,
> +                                             ENERGY_UTIL, NULL);
> +
> +               sum_util += min(cpu_util, _cpu_cap);
>
>                 /*
>                  * Performance domain frequency: utilization clamping
> @@ -6576,7 +6587,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                  */
>                 cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
>                                               FREQUENCY_UTIL, tsk);
> -               max_util = max(max_util, cpu_util);
> +               max_util = max(max_util, min(cpu_util, _cpu_cap));
>         }
>
>         return em_cpu_energy(pd->em_pd, max_util, sum_util);
> --
> 2.17.1
>
