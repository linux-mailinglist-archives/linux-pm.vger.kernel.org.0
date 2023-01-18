Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340E1671EF9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 15:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjAROJI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjAROIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 09:08:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95995AB49
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 05:49:15 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so2199480pjb.4
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 05:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vmpwSKy96IvoWT1NUUvPojI5sAkODWjoOuQyaQInS6U=;
        b=mEb404hxy0pL6ixKNtbP8zPYqXZLDXrgI9JCjAIc6kkXMZTW+3z79DE9pElKYzIKTG
         ppw2B8cPV7lwlPxPhDFucYmODyfQxakdR581XNLF7ZBtg3kkBV1+49J2ukGTVl2Gt6CS
         rcSy0XVhYbqxgmVdhsuk5X71RyR2R/ArVp2NXx30pXqbtHDVjFN08Apci3YG8DWLdz9+
         GzqqniBxtwKEG9q0wWlUiUa4zytccMxI7wzW9kkqqDJdtUejQ1JSCnUMR5Ymq8BguEg0
         r948aQ08jmcT5T145JL/hFk7g3nkC2DZzvVuIRRxVIZbB3SaTyhkXzUzqtGSp6+rkPXj
         jF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmpwSKy96IvoWT1NUUvPojI5sAkODWjoOuQyaQInS6U=;
        b=ShNbglCFX/DjqR6tSi0arfgtr91vnfgQxKzQANkhuiUKU81IBYhRZ3AiQ2g7mFoJsP
         lE8U9qo+Gk+ncyOBBj2KDJjJD2+Ez7ZdXqciWoBOc5W7s9xRC2O9dCVW3stu64+prZta
         sCLQaxM7RjI3/3CY2fIwpn6670UIGT5sZ98Gpiii2wTUB+kBDFJBpNRcYUx1yzFTeekI
         cWF8wRv6KYiXwRC6PE8GI9Y1uHXOhu3vDhTOwACuewskkl2qlBjDOPRQarckDv1YTP+K
         3loVAPcUzCCWKl4MdYdtJRg00DdaJDfWCYniPPlYMqrvL2/yNZ9nbV9IhbEVdXHgN4rw
         9nDw==
X-Gm-Message-State: AFqh2koaPZ1oN10G5PPlFaHbJemYzb4SGgEaeXRyt+a3xfWiDia7yVXh
        p4KrM56zn9XOY7nWNYuOkXUnCtxIYg66zkkr/q2mUQZasD3pCA==
X-Google-Smtp-Source: AMrXdXvulT2JwhqPioo7PVrXrIqQv3jR1gMsH7fiRTMeeKBvQyoM2qjOl2oavkErs726Ai9AHdDV3hmN4/a8+7zRZHM=
X-Received: by 2002:a17:90a:c004:b0:227:1f55:158d with SMTP id
 p4-20020a17090ac00400b002271f55158dmr653158pjt.92.1674049755009; Wed, 18 Jan
 2023 05:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20230113134056.257691-1-vincent.guittot@linaro.org>
 <20230115001906.v7uq4ddodrbvye7d@airbuntu> <CAKfTPtB7hk=7SinWAbs7SMQEs4OHSCC1hQQHRtfzN-JxnV7Jvg@mail.gmail.com>
 <20230117162022.q76yv3sq753tymfl@airbuntu>
In-Reply-To: <20230117162022.q76yv3sq753tymfl@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 18 Jan 2023 14:49:03 +0100
Message-ID: <CAKfTPtAZXMqE3-O+TiG0oHymcXp_hZ-x8G1JSEav51=AjpsyyA@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 17 Jan 2023 at 17:20, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/16/23 12:08, Vincent Guittot wrote:
> > On Sun, 15 Jan 2023 at 01:19, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 01/13/23 14:40, Vincent Guittot wrote:
> > > > By taking into account uclamp_min, the 1:1 relation between task misfit
> > > > and cpu overutilized is no more true as a task with a small util_avg of
> > > > may not fit a high capacity cpu because of uclamp_min constraint.
> > > >
> > > > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > > > a CPU except for the uclamp_min hint which is a performance requirement.
> > > >
> > > > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > > > can use this new value to take additional action to select the best CPU
> > > > that doesn't match uclamp_min hint.
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >
> > > > Change since v2:
> > > > - fix a condition in feec()
> > > > - add comments
> > > >
> > > >  kernel/sched/fair.c | 108 ++++++++++++++++++++++++++++++++++----------
> > > >  1 file changed, 83 insertions(+), 25 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index e9d906a9bba9..29adb9e27b3d 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -4525,8 +4525,7 @@ static inline int util_fits_cpu(unsigned long util,
> > > >        *     2. The system is being saturated when we're operating near
> > > >        *        max capacity, it doesn't make sense to block overutilized.
> > > >        */
> > > > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > > > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > > > +     uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
> > >
> > > I think this hunk is what is causing the overutilized issues Kajetan reported
> > > against your patch.
> >
> > Yeah, I have been to agressive with uclamp_max
> >
> > >
> > > For the big cpu, this expression will always be true. So overutilized will
> > > trigger only for little and medium cores.
> > >
> > > I appreciate writing the boolean in a shorter form might appear like less code,
> > > but it makes things harder to read too; the compiler should be good at
> > > simplifying the expression if it can, no?
> > >
> > > Shall we leave the original expression as-is since it's easier to reason about?
> > >
> > > I think already by 'saving' using another variable we reduced readability and
> > > lead to this error. First line checks if we are the max_capacity which is
> > > the corner case we'd like to avoid and accidentally lost
> > >
> > > v1 code was:
> > >
> > > +       max_capacity = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > > +       uclamp_max_fits = !max_capacity && (uclamp_max <= capacity_orig);
> > > +       fits = fits || uclamp_max_fits;
> > >
> > > I think that extra variable was well named to help make it obvious what corner
> > > case we're trying to catch here. Especially it matches the comment above it
> > > explaining this corner case. This auto variable should be free, no?
> > >
> > > Can we go back to this form please?
> >
> > Yes, I'm going to come back to previous version
> >
> > >
> > > >       fits = fits || uclamp_max_fits;
> > > >
> > > >       /*
> > > > @@ -4561,8 +4560,8 @@ static inline int util_fits_cpu(unsigned long util,
> > > >        * handle the case uclamp_min > uclamp_max.
> > > >        */
> > > >       uclamp_min = min(uclamp_min, uclamp_max);
> > > > -     if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> > > > -             fits = fits && (uclamp_min <= capacity_orig_thermal);
> > > > +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> > > > +             return -1;
> > >
> > > Here shouldn't this be
> > >
> > >         if (util < uclamp_min) {
> > >                 fits = fits && (uclamp_min <= capacity_orig);
> > >                 if (fits && (uclamp_min > capacity_orig_thermal))
> > >                         return -1;
> > >         }
> > >
> > > uclamp_min should fit capacity_orig first then we'd check for the corner case
> >
> > I don't get why we should test capacity_orig first ?
> >
> > case 1:
> >   capacity_orig = 800
> >   uclamp_min = 512
> >   capacity_orig_thermal = 400
> >   util = 200
> > util_fits_cpu should return -1
> >
> > case 2:
> >   uclamp_min = 900
> >   capacity_orig = 800
> >   capacity_orig_thermal = 400
> >   utili_avg = 200
> > util_fits_cpu should return -1 whereas with your proposal above it will return 0
>
> Ah. Our definition of what -1 means is different.
>
> I thought it's a fallback case for when we fit capacity_orig but due to thermal
> pressure we'll actually fail to get. So what I understood -1 would be is that:
>
>         We fit in capacity_orig but due to thermal pressure we will actually
>         not get the perf point we'd hope for. So might be worthwhile to search
>         harder if another CPU can fit.
>
> But your definition is:
>
>         If util fits but uclamp_min doesn't (regardless because of thermal
>         pressure or we fail capacity_orig); then fallback to the cpu with the
>         highest (capacity_orig - thermal_pressure) that fits util.
>
> Did I get this right?

Sorry I forgot to reply but yes that my definition

>
> Hmm, sounds reasonable, I need to sleep on it but this looks better, yes.
>
>
> Cheers
>
> --
> Qais Yousef
>
> >
> > > if thermal pressure is causing it not to fit. And all of this should only
> > > matter if utill < uclamp_min. Otherwise util_avg should be driving force if
> > > uclamp_max is not trumping it.
> > >
> > > I need time to update my unit test [1] to catch these error cases as I didn't
> > > see them. In the next version I think it's worth including the changes to
> > > remove the capacity inversion in the patch.
> > >
> > > [1] https://github.com/qais-yousef/uclamp_test/blob/master/uclamp_test_thermal_pressure.c
> > >
> > >
> > > Thanks!
> > >
> > > --
> > > Qais Yousef
> > >
> > > >
> > > >       return fits;
> > > >  }
> > > > @@ -4572,7 +4571,11 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> > > >       unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > > >       unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > > >       unsigned long util = task_util_est(p);
> > > > -     return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> > > > +     /*
> > > > +      * Return true only if the cpu fully fits the task requirements, which
> > > > +      * include the utilization but also the performance.
> > > > +      */
> > > > +     return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
> > > >  }
> > > >
> > > >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > > > @@ -6132,6 +6135,7 @@ static inline bool cpu_overutilized(int cpu)
> > > >       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> > > >       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> > > >
> > > > +     /* Return true only if the utlization doesn't fit its capacity */
> > > >       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> > > >  }
> > > >
> > > > @@ -6925,6 +6929,7 @@ static int
> > > >  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > > >  {
> > > >       unsigned long task_util, util_min, util_max, best_cap = 0;
> > > > +     int fits, best_fits = 0;
> > > >       int cpu, best_cpu = -1;
> > > >       struct cpumask *cpus;
> > > >
> > > > @@ -6940,12 +6945,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > > >
> > > >               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> > > >                       continue;
> > > > -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
> > > > +
> > > > +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> > > > +
> > > > +             /* This CPU fits with all capacity and performance requirements */
> > > > +             if (fits > 0)
> > > >                       return cpu;
> > > > +             /*
> > > > +              * Only the min performance (i.e. uclamp_min) doesn't fit. Look
> > > > +              * for the CPU with highest performance capacity.
> > > > +              */
> > > > +             else if (fits < 0)
> > > > +                     cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
> > > >
> > > > -             if (cpu_cap > best_cap) {
> > > > +             /*
> > > > +              * First, select cpu which fits better (-1 being better than 0).
> > > > +              * Then, select the one with largest capacity at same level.
> > > > +              */
> > > > +             if ((fits < best_fits) ||
> > > > +                 ((fits == best_fits) && (cpu_cap > best_cap))) {
> > > >                       best_cap = cpu_cap;
> > > >                       best_cpu = cpu;
> > > > +                     best_fits = fits;
> > > >               }
> > > >       }
> > > >
> > > > @@ -6958,7 +6979,11 @@ static inline bool asym_fits_cpu(unsigned long util,
> > > >                                int cpu)
> > > >  {
> > > >       if (sched_asym_cpucap_active())
> > > > -             return util_fits_cpu(util, util_min, util_max, cpu);
> > > > +             /*
> > > > +              * Return true only if the cpu fully fits the task requirements
> > > > +              * which include the utilization but also the performance.
> > > > +              */
> > > > +             return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
> > > >
> > > >       return true;
> > > >  }
> > > > @@ -7325,6 +7350,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >       unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
> > > >       struct root_domain *rd = this_rq()->rd;
> > > >       int cpu, best_energy_cpu, target = -1;
> > > > +     int prev_fits = -1, best_fits = -1;
> > > > +     unsigned long best_thermal_cap = 0;
> > > > +     unsigned long prev_thermal_cap = 0;
> > > >       struct sched_domain *sd;
> > > >       struct perf_domain *pd;
> > > >       struct energy_env eenv;
> > > > @@ -7360,6 +7388,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >               unsigned long prev_spare_cap = 0;
> > > >               int max_spare_cap_cpu = -1;
> > > >               unsigned long base_energy;
> > > > +             int fits, max_fits = -1;
> > > >
> > > >               cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> > > >
> > > > @@ -7412,7 +7441,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >                                       util_max = max(rq_util_max, p_util_max);
> > > >                               }
> > > >                       }
> > > > -                     if (!util_fits_cpu(util, util_min, util_max, cpu))
> > > > +
> > > > +                     fits = util_fits_cpu(util, util_min, util_max, cpu);
> > > > +                     if (!fits)
> > > >                               continue;
> > > >
> > > >                       lsub_positive(&cpu_cap, util);
> > > > @@ -7420,7 +7451,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >                       if (cpu == prev_cpu) {
> > > >                               /* Always use prev_cpu as a candidate. */
> > > >                               prev_spare_cap = cpu_cap;
> > > > -                     } else if (cpu_cap > max_spare_cap) {
> > > > +                             prev_fits = fits;
> > > > +                     } else if ((fits > max_fits) ||
> > > > +                                ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> > > >                               /*
> > > >                                * Find the CPU with the maximum spare capacity
> > > >                                * among the remaining CPUs in the performance
> > > > @@ -7428,6 +7461,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >                                */
> > > >                               max_spare_cap = cpu_cap;
> > > >                               max_spare_cap_cpu = cpu;
> > > > +                             max_fits = fits;
> > > >                       }
> > > >               }
> > > >
> > > > @@ -7446,26 +7480,50 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >                       if (prev_delta < base_energy)
> > > >                               goto unlock;
> > > >                       prev_delta -= base_energy;
> > > > +                     prev_thermal_cap = cpu_thermal_cap;
> > > >                       best_delta = min(best_delta, prev_delta);
> > > >               }
> > > >
> > > >               /* Evaluate the energy impact of using max_spare_cap_cpu. */
> > > >               if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
> > > > +                     /* Current best energy cpu fits better */
> > > > +                     if (max_fits < best_fits)
> > > > +                             continue;
> > > > +
> > > > +                     /*
> > > > +                      * Both don't fit performance (i.e. uclamp_min) but
> > > > +                      * best energy cpu has better performance.
> > > > +                      */
> > > > +                     if ((max_fits < 0) &&
> > > > +                         (cpu_thermal_cap <= best_thermal_cap))
> > > > +                             continue;
> > > > +
> > > >                       cur_delta = compute_energy(&eenv, pd, cpus, p,
> > > >                                                  max_spare_cap_cpu);
> > > >                       /* CPU utilization has changed */
> > > >                       if (cur_delta < base_energy)
> > > >                               goto unlock;
> > > >                       cur_delta -= base_energy;
> > > > -                     if (cur_delta < best_delta) {
> > > > -                             best_delta = cur_delta;
> > > > -                             best_energy_cpu = max_spare_cap_cpu;
> > > > -                     }
> > > > +
> > > > +                     /*
> > > > +                      * Both fit for the task but best energy cpu has lower
> > > > +                      * energy impact.
> > > > +                      */
> > > > +                     if ((max_fits > 0) && (best_fits > 0) &&
> > > > +                         (cur_delta >= best_delta))
> > > > +                             continue;
> > > > +
> > > > +                     best_delta = cur_delta;
> > > > +                     best_energy_cpu = max_spare_cap_cpu;
> > > > +                     best_fits = max_fits;
> > > > +                     best_thermal_cap = cpu_thermal_cap;
> > > >               }
> > > >       }
> > > >       rcu_read_unlock();
> > > >
> > > > -     if (best_delta < prev_delta)
> > > > +     if ((best_fits > prev_fits) ||
> > > > +         ((best_fits > 0) && (best_delta < prev_delta)) ||
> > > > +         ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
> > > >               target = best_energy_cpu;
> > > >
> > > >       return target;
> > > > @@ -10259,24 +10317,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> > > >        */
> > > >       update_sd_lb_stats(env, &sds);
> > > >
> > > > -     if (sched_energy_enabled()) {
> > > > -             struct root_domain *rd = env->dst_rq->rd;
> > > > -
> > > > -             if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> > > > -                     goto out_balanced;
> > > > -     }
> > > > -
> > > > -     local = &sds.local_stat;
> > > > -     busiest = &sds.busiest_stat;
> > > > -
> > > >       /* There is no busy sibling group to pull tasks from */
> > > >       if (!sds.busiest)
> > > >               goto out_balanced;
> > > >
> > > > +     busiest = &sds.busiest_stat;
> > > > +
> > > >       /* Misfit tasks should be dealt with regardless of the avg load */
> > > >       if (busiest->group_type == group_misfit_task)
> > > >               goto force_balance;
> > > >
> > > > +     if (sched_energy_enabled()) {
> > > > +             struct root_domain *rd = env->dst_rq->rd;
> > > > +
> > > > +             if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> > > > +                     goto out_balanced;
> > > > +     }
> > > > +
> > > >       /* ASYM feature bypasses nice load balance check */
> > > >       if (busiest->group_type == group_asym_packing)
> > > >               goto force_balance;
> > > > @@ -10289,6 +10346,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> > > >       if (busiest->group_type == group_imbalanced)
> > > >               goto force_balance;
> > > >
> > > > +     local = &sds.local_stat;
> > > >       /*
> > > >        * If the local group is busier than the selected busiest group
> > > >        * don't try and pull any tasks.
> > > > --
> > > > 2.34.1
> > > >
