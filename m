Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0165853D
	for <lists+linux-pm@lfdr.de>; Wed, 28 Dec 2022 18:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiL1RTI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 12:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiL1RTG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 12:19:06 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3901D13E91
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 09:19:04 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 7so10936236pga.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 09:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EUlJlHQ0p4OntnSSNEGBWSTWJ/42bQkKo0ofMi0pBuk=;
        b=Q0h9LWzKtFQPx/bu4O6dVKTxuX2Azp6np30WKP5RC8fhH4pmYJVBK+taRGQJb0B8xa
         nM6igmrej6hlwcmRefx0zMzwGVatIKTsCZXyzVMNZfNWPiq+Pf7UAycu7hsTr/cdC6O+
         Mww2X7f5eWMH8pGpSShRulSe+LuW3LdREbUbz2PsKQiRPdBRUrSMn6fjKgw1RPOH/KtA
         9ml4fDfGOQIOF2CMJR489rAQ5L9VC1hE1A+De72NaBQ88COIl7qQ6EMrz4yaZGdPKayh
         rS35VMEI0ZETEVFdSTGVCsVBhiNK1bhy12ogx/fexjxBhWtptEEiUNxqBp08XTmL8qNf
         ZVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUlJlHQ0p4OntnSSNEGBWSTWJ/42bQkKo0ofMi0pBuk=;
        b=iWF6fxi9bq01Kx9G7ETANthxVKGmYCfuW29vsfu0ZR//a8BZeD02IzBgDWflQuBXUg
         OIqu94oxNPDxkkAac2lk1xuaNnS3nOuQZSCupPFaHptoHAQz2dGNgNUSvBFo4I+8Et0y
         3p5ObQlIXPduCfLxLfUU2pQhTnn0pb2vHqC6QXaPvyzCapZz/TKhp4tqIumHk7f40Xq7
         dHciW0eByn132Re15vh3mPcAv2FXTXsjrTXFrTNrTZlTBIeoHy5J1B/2doa4HyXvxXwi
         w7HXn+owBIuECmDGbECVFzsW9cOTkRV+7cwkaU9525LhwDsV2+3wvAopOzgb9QY5SF/V
         sUKw==
X-Gm-Message-State: AFqh2krDjUprruQBQ5LbV9/gDPaI/d4fhbyWOMQR1M35y1SbJNzZPrJs
        WI+bt8jo2EX7a+CktbQ4X43I0wRbtnGRbRdGT2UeUQ==
X-Google-Smtp-Source: AMrXdXu7oYeRgtm4/fFIjRwRZ2bTLWalvoGD0pq2mMhWscDE+3/ME+07xBNTKQvh9g0i4/atQZtS0ajPeOD8WW5MsOA=
X-Received: by 2002:a63:f80f:0:b0:499:4375:f5e8 with SMTP id
 n15-20020a63f80f000000b004994375f5e8mr470895pgh.545.1672247943468; Wed, 28
 Dec 2022 09:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20221203143323.w32boxa6asqvvdnp@airbuntu> <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu> <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu> <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu> <CAKfTPtBX0ugM87CEjAXUbVhnTZTwAAnjXu2fRfc6ezHE8=aC6w@mail.gmail.com>
 <20221220123254.to6tzznxloxq725q@airbuntu> <20221220135034.GA12359@vingu-book>
 <20221223115845.3azncwqlyo4zx262@airbuntu> <CAKfTPtCLE8DSa_kV4NgLqhGF--VkOV2x+bf_6NRL76NFnwmq2g@mail.gmail.com>
In-Reply-To: <CAKfTPtCLE8DSa_kV4NgLqhGF--VkOV2x+bf_6NRL76NFnwmq2g@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Dec 2022 18:18:51 +0100
Message-ID: <CAKfTPtAXufGFEfhxk3K43W_1=foVZ1X8zR8B14hzKk_NpLJLdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 27 Dec 2022 at 14:33, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 23 Dec 2022 at 12:58, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 12/20/22 14:50, Vincent Guittot wrote:
> >
> > Thanks for the patch!
> >
> > > Hereafter is what I came with in order to decouple misfit task with cpu
> > > overutilized. We keep using util_fits_cpu but with 3 values so we can keep
> > > using it with cpu_overutilized but exclude the case of misfit task
> > > because uclmap_min. Also select_idle_capacity() and feec() keep selecting the
> > > big cpu even if it doesn't fit only because of uclamp_min
> > >
> > >
> > > Subject: [PATCH] sched/fair: unlink misfit task from cpu overutilized
> > >
> > > By taking into account uclamp_min, the 1:1 relation between task misfit and
> > > cpu overutilized is no more true as a task with a util_avg of 20as an
> > > example may not fit a 1024 capacity cpu because of a uclamp_min constraint.
> > >
> > > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > > a CPU except for the uclamp_min hint which is a bandwidth requriement.
> >
> > nit: mixing uclamp with bandwidth has been a source of a lot of confusion when
> > discussing uclamp. Can we use performance requirement instead please?
>
> ok
>
> >
> > >
> > > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > > can use this new value to take additional action to select the best cpu
> > > that doesn't match uclamp_min.
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  kernel/sched/fair.c | 73 ++++++++++++++++++++++++++++++---------------
> > >  1 file changed, 49 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 4423681baf15..705335d6af65 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4578,8 +4578,7 @@ static inline int util_fits_cpu(unsigned long util,
> > >        *     2. The system is being saturated when we're operating near
> > >        *        max capacity, it doesn't make sense to block overutilized.
> > >        */
> > > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > > +     uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
> > >       fits = fits || uclamp_max_fits;
> > >
> > >       /*
> > > @@ -4614,8 +4613,8 @@ static inline int util_fits_cpu(unsigned long util,
> > >        * handle the case uclamp_min > uclamp_max.
> > >        */
> > >       uclamp_min = min(uclamp_min, uclamp_max);
> > > -     if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> > > -             fits = fits && (uclamp_min <= capacity_orig_thermal);
> > > +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> > > +             return -1;
> > >
> > >       return fits;
> >
> > nit: return !!fits?
> >
> > We check explicitly == 1 below and I'm not sure all the boolean check above
> > will guarantee we will end up return 1 for true on all combination of
> > compilerls/archs.
> >
> > >  }
> > > @@ -4625,7 +4624,7 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> > >       unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > >       unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > >       unsigned long util = task_util_est(p);
> > > -     return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> > > +     return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) == 1);
> >
> > Or make this >  0?
>
> yes, will use > 0
>
> >
> > >  }
> > >
> > >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > > @@ -6064,7 +6063,10 @@ static inline void hrtick_update(struct rq *rq)
> > >  #ifdef CONFIG_SMP
> > >  static inline bool cpu_overutilized(int cpu)
> > >  {
> > > -     return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
> > > +     unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> > > +     unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> > > +
> > > +     return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> > >  }
> > >
> > >  static inline void update_overutilized_status(struct rq *rq)
> > > @@ -6857,6 +6859,7 @@ static int
> > >  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > >  {
> > >       unsigned long task_util, util_min, util_max, best_cap = 0;
> > > +     int fits, best_fits = -1;
> > >       int cpu, best_cpu = -1;
> > >       struct cpumask *cpus;
> > >
> > > @@ -6872,12 +6875,24 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > >
> > >               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> > >                       continue;
> > > -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
> > > +
> > > +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> > > +
> > > +             /* This cpu fits with all capacity requirements */
> >
> > nit: s#capacity#capacity & performance#?
> >
> > > +             if (fits > 0)
> > >                       return cpu;
> > > +             /*
> > > +              * Only the min bandwidth (i.e. uclamp_min) doesn't fit. Look
> > > +              * for the cpu with highest bandwidth capacity.
> > > +              */
> >
> > s/bandwidth/performance/?
> >
> > > +             else if (fits < 0)
> > > +                     cpu_cap = capacity_of(cpu) - thermal_load_avg(cpu_rq(cpu));
> >
> > Hmm. Isn't capacity_of() already takes into account thermal_load_avg()?
> >
> > Did you mean capacity_orig_of()?
>
> Yes
>
> >
> > >
> > > -             if (cpu_cap > best_cap) {
> > > +             if ((fits > best_fits) ||
> > > +                 ((fits == best_fits) && (cpu_cap > best_cap))) {
> > >                       best_cap = cpu_cap;
> > >                       best_cpu = cpu;
> > > +                     best_fits = fits;
> >
> > I'm not sure if this logic is correct. It's a bit of a mind  bender.
> >
> >         @iter#0
> >
> >                 fits <= 0
> >                 best_fits <= -1
> >
> >                 if (fits > best_fits) // 0 > -1 => True
> >                         ...     // update best_cap if larger
> >                         best_fits <= 0
> >
> >         @iter#1
> >
> >                 fits <= -1
> >                 best_fits <= 0
> >
> >                 if (fits > best_fits) // -1 > 0 => False
> >
> >                 if (fits == best_fits) // -1 == 0 => False
> >
> >                 // We will never update best_cap for all fits = -1 after
> >                 // encountering the first fits = 0
> >
> > I think we should reverse the initial values and split the conditions
>
> The copy/paste from feec() was too quick. It should be :
>
> +             if ((fits < best_fits) ||
> +                 ((fits == best_fits) && (cpu_cap > best_cap))) {
>
> I don't think that the split gives any benefit but makes it more
> difficult to read. I will add a comment
> /*
> * Select the CPU which fits better first (-1 being better than 0).
> * Then, select the one with the largest capacity at the same level.
> */
>
> >
> >         int fits, best_fits = 0;
> >
> >                 if ((fits < best_fits)) {
> >                         /* Reset best_cap for first "fits_but" */
> >                         best_cap = cpu_cap;
> >                         best_cpu = cpu;
> >                         best_fits = fits;
> >                 } else if ((fits == best_fits) && (cpu_cap > best_cap))) {
> >                         best_cap = cpu_cap;
> >                         best_cpu = cpu;
> >                 }
> >
> > Which give us
> >
> >         @iter#0
> >
> >                 fits <= 0
> >                 best_fits <= 0
> >
> >                 if (fits < best_fits) // 0 < 0 => False
> >
> >                 if (fits == best_fits) // 0 == 0 => True
> >                         ...     // update best_cap if larger
> >
> >         @iter#1
> >
> >                 fits <= -1
> >                 best_fits <= 0
> >
> >                 if (fits < best_fits) // -1 < 0 => True
> >                         ...     // reset best_cap to first "fits_but" hit
> >                         best_fits <= -1
> >
> >         @iter#2
> >
> >                 fits <= 0
> >                 best_fits <= -1
> >
> >                 if (fits < best_fits) // 0 < -1 => False
> >
> >                 if (fits == best_fits) // 0 == -1 => False
> >
> >                 // We should never update best_cap for all fits == 0 now
> >
> >         @iter#3
> >
> >                 fits <= -1
> >                 best_fits <= -1
> >
> >                 if (fits < best_fits) // -1 < -1 => False
> >
> >                 if (fits == best_fits) // -1 == -1 => True
> >                         ...     // update best_cap if larger
> >
> >                 // Only fits = -1 will update best_cap if larger now
> >
> > Of course any hit with fits = 1 will return the cpu immediately.
> >
> >
> > >               }
> > >       }
> > >
> > > @@ -6890,7 +6905,7 @@ static inline bool asym_fits_cpu(unsigned long util,
> > >                                int cpu)
> > >  {
> > >       if (sched_asym_cpucap_active())
> > > -             return util_fits_cpu(util, util_min, util_max, cpu);
> > > +             return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
> > >
> > >       return true;
> > >  }
> > > @@ -7257,6 +7272,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >       unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
> > >       struct root_domain *rd = this_rq()->rd;
> > >       int cpu, best_energy_cpu, target = -1;
> > > +     int prev_fits = -1, best_fits = -1;
> > >       struct sched_domain *sd;
> > >       struct perf_domain *pd;
> > >       struct energy_env eenv;
> > > @@ -7288,10 +7304,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >               unsigned long cpu_cap, cpu_thermal_cap, util;
> > >               unsigned long cur_delta, max_spare_cap = 0;
> > >               unsigned long rq_util_min, rq_util_max;
> > > -             unsigned long util_min, util_max;
> > > +             unsigned long util_min = 0, util_max = 1024;
> >
> > Why this change? Are you hitting the same warning reported by Dan?
>
> While debugging, I got random util_min|max values passed to
> util_fits_cpu(). I agree that this is not a real problem because it
> means that !uclamp_is_used() and the values will not be used in
> util_fits_cpu() in this case but this is a hidden dependency which
> seems a bit weak.
>
> I can probably remove it from this patch as it's out of the scope
>
> >
> > >               unsigned long prev_spare_cap = 0;
> > >               int max_spare_cap_cpu = -1;
> > >               unsigned long base_energy;
> > > +             int fits, max_fits = -1;
> > >
> > >               cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> > >
> > > @@ -7344,7 +7361,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >                                       util_max = max(rq_util_max, p_util_max);
> > >                               }
> > >                       }
> > > -                     if (!util_fits_cpu(util, util_min, util_max, cpu))
> > > +
> > > +                     fits = util_fits_cpu(util, util_min, util_max, cpu);
> > > +                     if (!fits)
> > >                               continue;
> > >
> > >                       lsub_positive(&cpu_cap, util);
> > > @@ -7352,7 +7371,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >                       if (cpu == prev_cpu) {
> > >                               /* Always use prev_cpu as a candidate. */
> > >                               prev_spare_cap = cpu_cap;
> > > -                     } else if (cpu_cap > max_spare_cap) {
> > > +                             prev_fits = fits;
> > > +                     } else if ((fits > max_fits) ||
> > > +                                ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> > >                               /*
> > >                                * Find the CPU with the maximum spare capacity
> > >                                * among the remaining CPUs in the performance
> > > @@ -7360,6 +7381,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >                                */
> > >                               max_spare_cap = cpu_cap;
> > >                               max_spare_cap_cpu = cpu;
> > > +                             max_fits = fits;
> >
> > Should we reset best_delta here?
> >
> > Because we update max_fits here..
> >
> > >                       }
> > >               }
> > >
> > > @@ -7389,15 +7411,18 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >                       if (cur_delta < base_energy)
> > >                               goto unlock;
> > >                       cur_delta -= base_energy;
> > > -                     if (cur_delta < best_delta) {
> > > +                     if ((fits > max_fits) ||
> > > +                         ((fits == max_fits) && (cur_delta < best_delta))) {
> >
> > .. on first first transitions from -1 to 1; this condition will be
> > skipped if cur_delta is lower than best delta. best_delta here could be the
> > previous -1 fitting cpu.
>
> But we want a cpu that fits in priority then the one with the smallest delta.
>
> >
> > We should reset best_delta on first transition then look if we encounter
> > something with a better delta?
>
> my mistake... This should be
>
> +                     if ((max_fits > best_fits) ||
> +                         ((max_fits == best_fits) && (cur_delta <
> best_delta))) {
>
> I'm going to prepare a new version

I just sent a new version here:
https://lore.kernel.org/lkml/20221228165415.3436-1-vincent.guittot@linaro.org/

>
> >
> >
> > Thanks!
> >
> > --
> > Qais Yousef
> >
> > >                               best_delta = cur_delta;
> > >                               best_energy_cpu = max_spare_cap_cpu;
> > > +                             best_fits = max_fits;
> > >                       }
> > >               }
> > >       }
> > >       rcu_read_unlock();
> > >
> > > -     if (best_delta < prev_delta)
> > > +     if ((best_fits > prev_fits) ||
> > > +         ((best_fits == prev_fits) && (best_delta < prev_delta)))
> > >               target = best_energy_cpu;
> > >
> > >       return target;
> > > @@ -10164,24 +10189,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> > >        */
> > >       update_sd_lb_stats(env, &sds);
> > >
> > > -     if (sched_energy_enabled()) {
> > > -             struct root_domain *rd = env->dst_rq->rd;
> > > -
> > > -             if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> > > -                     goto out_balanced;
> > > -     }
> > > -
> > > -     local = &sds.local_stat;
> > > -     busiest = &sds.busiest_stat;
> > > -
> > >       /* There is no busy sibling group to pull tasks from */
> > >       if (!sds.busiest)
> > >               goto out_balanced;
> > >
> > > +     busiest = &sds.busiest_stat;
> > > +
> > >       /* Misfit tasks should be dealt with regardless of the avg load */
> > >       if (busiest->group_type == group_misfit_task)
> > >               goto force_balance;
> > >
> > > +     if (sched_energy_enabled()) {
> > > +             struct root_domain *rd = env->dst_rq->rd;
> > > +
> > > +             if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> > > +                     goto out_balanced;
> > > +     }
> > > +
> > >       /* ASYM feature bypasses nice load balance check */
> > >       if (busiest->group_type == group_asym_packing)
> > >               goto force_balance;
> > > @@ -10194,6 +10218,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> > >       if (busiest->group_type == group_imbalanced)
> > >               goto force_balance;
> > >
> > > +     local = &sds.local_stat;
> > >       /*
> > >        * If the local group is busier than the selected busiest group
> > >        * don't try and pull any tasks.
> > > --
> > > 2.17.1
> > >
> > >
> > >
> > > >
> > > >
> > > > Thanks!!
> > > >
> > > > --
> > > > Qais Yousef
