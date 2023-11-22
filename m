Return-Path: <linux-pm+bounces-82-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382427F4829
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 14:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A91C20A06
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863A4D584;
	Wed, 22 Nov 2023 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28620D54;
	Wed, 22 Nov 2023 05:49:28 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1efba24b038so1412956fac.1;
        Wed, 22 Nov 2023 05:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660967; x=1701265767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84xM8yK9HNIk2icvMP5Oav2v48J9MplS1OkfA7Ab42Y=;
        b=vQZwvUPnLzfxEtdewagXeaPiTV0Dk5bkRBW/+60/xWxnPNgScgKnCtswp2uC6gpI0D
         b2a8LTf04DfQFYBc5v6bOoxbhnDPLbvpH+FPsA+RK4hMi1XxyOOBPEcA6W4eP9rV/UmN
         YOPbNt4RBDc7BpDwDHDJhZnUreQQqglkf2eAqzqYqHUOKOlFYC3wRs5qgxKc9wxKe5m7
         pG/uzfgAaKVRuxLvRLnCZ3M10ZTampGhjzc7hPBQWBNZS1i+oKj+Vrh7PGZnJALsdqnG
         i5fOg+tMs0QiYYpHLB039QhGRMffTJ8i1qVx5JP9P5nDGxdDBCIeoHFAeCyagqG0WnNP
         WqdQ==
X-Gm-Message-State: AOJu0Ywaix7oYwpStnhIaa0WyLK7MZ7b58jVpWlt7YsyVyAwW2fJnBrv
	rcAN/i5tb9CKGssJVd7aUJ0a8ib36l/WKqgD04s=
X-Google-Smtp-Source: AGHT+IHwUYk2kYnwP8kW0j5bevnLbL5hVDdgTzZyCKneaxd11aT2X6NQf71UtjDn6Ml3CqGZI6aBgs4pFVzPGl02zkg=
X-Received: by 2002:a05:6870:8318:b0:1e9:9e04:1d24 with SMTP id
 p24-20020a056870831800b001e99e041d24mr2817045oae.5.1700660967304; Wed, 22 Nov
 2023 05:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122133904.446032-1-vincent.guittot@linaro.org> <20231122133904.446032-2-vincent.guittot@linaro.org>
In-Reply-To: <20231122133904.446032-2-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Nov 2023 14:49:16 +0100
Message-ID: <CAJZ5v0gen0qK41LxTCQtD-6MBSyabi9m3FxNbepsg3oM3JEqGQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/schedutil: Rework performance estimation
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, qyousef@layalina.io, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, wyes.karny@amd.com, 
	beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 2:39=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> The current method to take into account uclamp hints when estimating the
> target frequency can end into situation where the selected target
> frequency is finally higher than uclamp hints whereas there are no real
> needs. Such cases mainly happen because we are currently mixing the
> traditional scheduler utilization signal with the uclamp performance
> hints. By adding these 2 metrics, we loose an important information when
> it comes to select the target frequency and we have to make some
> assumptions which can't fit all cases.
>
> Rework the interface between the scheduler and schedutil governor in orde=
r
> to propagate all information down to the cpufreq governor.
>
> effective_cpu_util() interface changes and now returns the actual
> utilization of the CPU with 2 optional inputs:
> - The minimum performance for this CPU; typically the capacity to handle
>   the deadline task and the interrupt pressure. But also uclamp_min
>   request when available.
> - The maximum targeting performance for this CPU which reflects the
>   maximum level that we would like to not exceed. By default it will be
>   the CPU capacity but can be reduced because of some performance hints
>   set with uclamp. The value can be lower than actual utilization and/or
>   min performance level.
>
> A new sugov_effective_cpu_perf() interface is also available to compute
> the final performance level that is targeted for the CPU after applying
> some cpufreq headroom and taking into account all inputs.
>
> With these 2 functions, schedutil is now able to decide when it must go
> above uclamp hints. It now also have a generic way to get the min
> perfromance level.
>
> The dependency between energy model and cpufreq governor and its headroom
> policy doesn't exist anymore.
>
> eenv_pd_max_util asks schedutil for the targeted performance after
> applying the impact of the waking task.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  include/linux/energy_model.h     |  1 -
>  kernel/sched/core.c              | 90 ++++++++++++++------------------
>  kernel/sched/cpufreq_schedutil.c | 35 +++++++++----
>  kernel/sched/fair.c              | 22 ++++++--
>  kernel/sched/sched.h             | 24 +++------
>  5 files changed, 89 insertions(+), 83 deletions(-)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b9caa01dfac4..adec808b371a 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -243,7 +243,6 @@ static inline unsigned long em_cpu_energy(struct em_p=
erf_domain *pd,
>         scale_cpu =3D arch_scale_cpu_capacity(cpu);
>         ps =3D &pd->table[pd->nr_perf_states - 1];
>
> -       max_util =3D map_util_perf(max_util);
>         max_util =3D min(max_util, allowed_cpu_cap);
>         freq =3D map_util_freq(max_util, ps->frequency, scale_cpu);
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2de77a6d5ef8..900b5bacb662 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7467,18 +7467,13 @@ int sched_core_idle_cpu(int cpu)
>   * required to meet deadlines.
>   */
>  unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> -                                enum cpu_util_type type,
> -                                struct task_struct *p)
> +                                unsigned long *min,
> +                                unsigned long *max)
>  {
> -       unsigned long dl_util, util, irq, max;
> +       unsigned long util, irq, scale;
>         struct rq *rq =3D cpu_rq(cpu);
>
> -       max =3D arch_scale_cpu_capacity(cpu);
> -
> -       if (!uclamp_is_used() &&
> -           type =3D=3D FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
> -               return max;
> -       }
> +       scale =3D arch_scale_cpu_capacity(cpu);
>
>         /*
>          * Early check to see if IRQ/steal time saturates the CPU, can be
> @@ -7486,45 +7481,49 @@ unsigned long effective_cpu_util(int cpu, unsigne=
d long util_cfs,
>          * update_irq_load_avg().
>          */
>         irq =3D cpu_util_irq(rq);
> -       if (unlikely(irq >=3D max))
> -               return max;
> +       if (unlikely(irq >=3D scale)) {
> +               if (min)
> +                       *min =3D scale;
> +               if (max)
> +                       *max =3D scale;
> +               return scale;
> +       }
> +
> +       if (min) {
> +               /*
> +                * The minimum utilization returns the highest level betw=
een:
> +                * - the computed DL bandwidth needed with the irq pressu=
re which
> +                *   steals time to the deadline task.
> +                * - The minimum performance requirement for CFS and/or R=
T.
> +                */
> +               *min =3D max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAM=
P_MIN));
> +
> +               /*
> +                * When a RT task is runnable and uclamp is not used, we =
must
> +                * ensure that the task will run at maximum compute capac=
ity.
> +                */
> +               if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt))
> +                       *min =3D max(*min, scale);
> +       }
>
>         /*
>          * Because the time spend on RT/DL tasks is visible as 'lost' tim=
e to
>          * CFS tasks and we use the same metric to track the effective
>          * utilization (PELT windows are synchronized) we can directly ad=
d them
>          * to obtain the CPU's actual utilization.
> -        *
> -        * CFS and RT utilization can be boosted or capped, depending on
> -        * utilization clamp constraints requested by currently RUNNABLE
> -        * tasks.
> -        * When there are no CFS RUNNABLE tasks, clamps are released and
> -        * frequency will be gracefully reduced with the utilization deca=
y.
>          */
>         util =3D util_cfs + cpu_util_rt(rq);
> -       if (type =3D=3D FREQUENCY_UTIL)
> -               util =3D uclamp_rq_util_with(rq, util, p);
> -
> -       dl_util =3D cpu_util_dl(rq);
> +       util +=3D cpu_util_dl(rq);
>
>         /*
> -        * For frequency selection we do not make cpu_util_dl() a permane=
nt part
> -        * of this sum because we want to use cpu_bw_dl() later on, but w=
e need
> -        * to check if the CFS+RT+DL sum is saturated (ie. no idle time) =
such
> -        * that we select f_max when there is no idle time.
> -        *
> -        * NOTE: numerical errors or stop class might cause us to not qui=
te hit
> -        * saturation when we should -- something for later.
> +        * The maximum hint is a soft bandwidth requirement which can be =
lower
> +        * than the actual utilization because of uclamp_max requirements
>          */
> -       if (util + dl_util >=3D max)
> -               return max;
> +       if (max)
> +               *max =3D min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
>
> -       /*
> -        * OTOH, for energy computation we need the estimated running tim=
e, so
> -        * include util_dl and ignore dl_bw.
> -        */
> -       if (type =3D=3D ENERGY_UTIL)
> -               util +=3D dl_util;
> +       if (util >=3D scale)
> +               return scale;
>
>         /*
>          * There is still idle time; further improve the number by using =
the
> @@ -7535,28 +7534,15 @@ unsigned long effective_cpu_util(int cpu, unsigne=
d long util_cfs,
>          *   U' =3D irq + --------- * U
>          *                 max
>          */
> -       util =3D scale_irq_capacity(util, irq, max);
> +       util =3D scale_irq_capacity(util, irq, scale);
>         util +=3D irq;
>
> -       /*
> -        * Bandwidth required by DEADLINE must always be granted while, f=
or
> -        * FAIR and RT, we use blocked utilization of IDLE CPUs as a mech=
anism
> -        * to gracefully reduce the frequency when no tasks show up for l=
onger
> -        * periods of time.
> -        *
> -        * Ideally we would like to set bw_dl as min/guaranteed freq and =
util +
> -        * bw_dl as requested freq. However, cpufreq is not yet ready for=
 such
> -        * an interface. So, we only do the latter for now.
> -        */
> -       if (type =3D=3D FREQUENCY_UTIL)
> -               util +=3D cpu_bw_dl(rq);
> -
> -       return min(max, util);
> +       return min(scale, util);
>  }
>
>  unsigned long sched_cpu_util(int cpu)
>  {
> -       return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NU=
LL);
> +       return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
>  }
>  #endif /* CONFIG_SMP */
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 5888176354e2..f3acf2cf26ed 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -47,7 +47,7 @@ struct sugov_cpu {
>         u64                     last_update;
>
>         unsigned long           util;
> -       unsigned long           bw_dl;
> +       unsigned long           bw_min;
>
>         /* The field below is for single-CPU policies only: */
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -143,7 +143,6 @@ static unsigned int get_next_freq(struct sugov_policy=
 *sg_policy,
>         unsigned int freq =3D arch_scale_freq_invariant() ?
>                                 policy->cpuinfo.max_freq : policy->cur;
>
> -       util =3D map_util_perf(util);
>         freq =3D map_util_freq(util, freq, max);
>
>         if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->need_fr=
eq_update)
> @@ -153,14 +152,30 @@ static unsigned int get_next_freq(struct sugov_poli=
cy *sg_policy,
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
>
> +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> +                                unsigned long min,
> +                                unsigned long max)
> +{
> +       /* Add dvfs headroom to actual utilization */
> +       actual =3D map_util_perf(actual);
> +       /* Actually we don't need to target the max performance */
> +       if (actual < max)
> +               max =3D actual;
> +
> +       /*
> +        * Ensure at least minimum performance while providing more compu=
te
> +        * capacity when possible.
> +        */
> +       return max(min, max);
> +}
> +
>  static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
> -       unsigned long util =3D cpu_util_cfs_boost(sg_cpu->cpu);
> -       struct rq *rq =3D cpu_rq(sg_cpu->cpu);
> +       unsigned long min, max, util =3D cpu_util_cfs_boost(sg_cpu->cpu);
>
> -       sg_cpu->bw_dl =3D cpu_bw_dl(rq);
> -       sg_cpu->util =3D effective_cpu_util(sg_cpu->cpu, util,
> -                                         FREQUENCY_UTIL, NULL);
> +       util =3D effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> +       sg_cpu->bw_min =3D min;
> +       sg_cpu->util =3D sugov_effective_cpu_perf(sg_cpu->cpu, util, min,=
 max);
>  }
>
>  /**
> @@ -306,7 +321,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu=
 *sg_cpu) { return false; }
>   */
>  static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
>  {
> -       if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
> +       if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
>                 sg_cpu->sg_policy->limits_changed =3D true;
>  }
>
> @@ -407,8 +422,8 @@ static void sugov_update_single_perf(struct update_ut=
il_data *hook, u64 time,
>             sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
>                 sg_cpu->util =3D prev_util;
>
> -       cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_=
dl),
> -                                  map_util_perf(sg_cpu->util), max_cap);
> +       cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> +                                  sg_cpu->util, max_cap);
>
>         sg_cpu->sg_policy->last_freq_update_time =3D time;
>  }
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 07f555857698..53e7bf2ccc44 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7780,7 +7780,7 @@ static inline void eenv_pd_busy_time(struct energy_=
env *eenv,
>         for_each_cpu(cpu, pd_cpus) {
>                 unsigned long util =3D cpu_util(cpu, p, -1, 0);
>
> -               busy_time +=3D effective_cpu_util(cpu, util, ENERGY_UTIL,=
 NULL);
> +               busy_time +=3D effective_cpu_util(cpu, util, NULL, NULL);
>         }
>
>         eenv->pd_busy_time =3D min(eenv->pd_cap, busy_time);
> @@ -7803,7 +7803,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cp=
umask *pd_cpus,
>         for_each_cpu(cpu, pd_cpus) {
>                 struct task_struct *tsk =3D (cpu =3D=3D dst_cpu) ? p : NU=
LL;
>                 unsigned long util =3D cpu_util(cpu, p, dst_cpu, 1);
> -               unsigned long eff_util;
> +               unsigned long eff_util, min, max;
>
>                 /*
>                  * Performance domain frequency: utilization clamping
> @@ -7812,7 +7812,23 @@ eenv_pd_max_util(struct energy_env *eenv, struct c=
pumask *pd_cpus,
>                  * NOTE: in case RT tasks are running, by default the
>                  * FREQUENCY_UTIL's utilization can be max OPP.
>                  */
> -               eff_util =3D effective_cpu_util(cpu, util, FREQUENCY_UTIL=
, tsk);
> +               eff_util =3D effective_cpu_util(cpu, util, &min, &max);
> +
> +               /* Task's uclamp can modify min and max value */
> +               if (tsk && uclamp_is_used()) {
> +                       min =3D max(min, uclamp_eff_value(p, UCLAMP_MIN))=
;
> +
> +                       /*
> +                        * If there is no active max uclamp constraint,
> +                        * directly use task's one otherwise keep max
> +                        */
> +                       if (uclamp_rq_is_idle(cpu_rq(cpu)))
> +                               max =3D uclamp_eff_value(p, UCLAMP_MAX);
> +                       else
> +                               max =3D max(max, uclamp_eff_value(p, UCLA=
MP_MAX));
> +               }
> +
> +               eff_util =3D sugov_effective_cpu_perf(cpu, eff_util, min,=
 max);
>                 max_util =3D max(max_util, eff_util);
>         }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8a70d51ffa33..c1574cd388e7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2994,24 +2994,14 @@ static inline void cpufreq_update_util(struct rq =
*rq, unsigned int flags) {}
>  #endif
>
>  #ifdef CONFIG_SMP
> -/**
> - * enum cpu_util_type - CPU utilization type
> - * @FREQUENCY_UTIL:    Utilization used to select frequency
> - * @ENERGY_UTIL:       Utilization used during energy calculation
> - *
> - * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ=
 time
> - * need to be aggregated differently depending on the usage made of them=
. This
> - * enum is used within effective_cpu_util() to differentiate the types o=
f
> - * utilization expected by the callers, and adjust the aggregation accor=
dingly.
> - */
> -enum cpu_util_type {
> -       FREQUENCY_UTIL,
> -       ENERGY_UTIL,
> -};
> -
>  unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> -                                enum cpu_util_type type,
> -                                struct task_struct *p);
> +                                unsigned long *min,
> +                                unsigned long *max);
> +
> +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> +                                unsigned long min,
> +                                unsigned long max);
> +
>
>  /*
>   * Verify the fitness of task @p to run on @cpu taking into account the
> --
> 2.34.1
>

