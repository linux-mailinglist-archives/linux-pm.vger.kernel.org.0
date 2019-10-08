Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65FCCFECC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 18:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfJHQUj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 12:20:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41316 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHQUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 12:20:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id f5so18216892ljg.8
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2019 09:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBV/bDuP3cuK3VnnwAv7FGfurNyoJY5z9Lybw7jFwWQ=;
        b=brcllcP3tDKv4glmvksYNL7w5tMWBGD2AbB3qGsTDvyvhCNvWgf6H5d0ixS3Q0XX9W
         BxFZHgh7EiOqGp/PlOV1oAAPu027PRYdpLD1r4GYmY3lqRc5UI44+ofRup4T4IxKHuS5
         hXvkLlq/dHmxrM1R58/eIBY2wluWdu9wWaMbwTfh+piUrKTeSvIlHbdco+ZLCZFGsugF
         VfUIHrBxQZXHJ+yjYC+mvflj2CsCHikChT6/D8xfy8sCo7Hi9saWGgb0nANaorYNuVR3
         ruEqOiHtnF3TJWt5WusP4xwx6uwji/YsD/4EmXKvcIY1AaBr/X8gMRQbUFx1ODWzWpbP
         8TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBV/bDuP3cuK3VnnwAv7FGfurNyoJY5z9Lybw7jFwWQ=;
        b=fwFNU6IKrwJBoaO8dkrekN88W6AJXvnwg8CTU9/W+pasjJERRudH/Tx3vOmZSyd5z0
         lLjw3lYcxzJVKup2mwWHIarxHS6z5mG5sSrmU6oz6o7XkWLJpG0N7OGzBrY6fSlbzHM2
         Rs4HNM+tkxwKtIWmTjOeQ72Y92MkYeQpHeno67qhEYR+yE6ri/+erZEWjNJlRBY5MeK3
         t3P7/b8w8BeFyEmfgay/oensgH3tA9nlqy9FC4FFUpQvjRwwNND2VcSBS+byEbXevKSw
         raqKTRmC14wHGJ3G4IUtT6r7srU9E8qSx1eSnbpozdl6rDpUj43yGm4laGgg+v44K4+C
         +spQ==
X-Gm-Message-State: APjAAAVXnxN6VyAviQu3HgEGpWEzREepQck+/tR66usPxWWi1u1gh8yI
        X6bhOWaGJr0AdaVhFtAq6fOQUDRB2zvLSkNdEaUkdA==
X-Google-Smtp-Source: APXvYqxvw7NqVOT6Q6Otde3Yn+LxktBe7LDsiuKR1Bt7yU+7B9/vRnLsBZPUs9re5BQASYuDGgGNDHENKIPBhudEWqQ=
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr22512561lje.193.1570551636291;
 Tue, 08 Oct 2019 09:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191007083051.4820-1-parth@linux.ibm.com> <20191007083051.4820-5-parth@linux.ibm.com>
 <CAKfTPtCgoTJXxbYyza1W55ayw9QeM7fue2e91Xpt804sL9GQWA@mail.gmail.com> <80bb34ec-6358-f4dc-d20d-cde6c9d7e197@linux.ibm.com>
In-Reply-To: <80bb34ec-6358-f4dc-d20d-cde6c9d7e197@linux.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Oct 2019 18:20:24 +0200
Message-ID: <CAKfTPtDEp7s-1F2mOHd0sYqD=TzGcufKS0orddMLaMePUp8T2g@mail.gmail.com>
Subject: Re: [RFC v5 4/6] sched/fair: Tune task wake-up logic to pack small
 background tasks on fewer cores
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Quentin Perret <quentin.perret@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 7 Oct 2019 at 18:54, Parth Shah <parth@linux.ibm.com> wrote:
>
>
>
> On 10/7/19 5:49 PM, Vincent Guittot wrote:
> > On Mon, 7 Oct 2019 at 10:31, Parth Shah <parth@linux.ibm.com> wrote:
> >>
> >> The algorithm finds the first non idle core in the system and tries to
> >> place a task in the idle CPU in the chosen core. To maintain
> >> cache hotness, work of finding non idle core starts from the prev_cpu,
> >> which also reduces task ping-pong behaviour inside of the core.
> >>
> >> Define a new method to select_non_idle_core which keep tracks of the idle
> >> and non-idle CPUs in the core and based on the heuristics determines if the
> >> core is sufficiently busy to place the incoming backgroung task. The
> >> heuristic further defines the non-idle CPU into either busy (>12.5% util)
> >> CPU and overutilized (>80% util) CPU.
> >> - The core containing more idle CPUs and no busy CPUs is not selected for
> >>   packing
> >> - The core if contains more than 1 overutilized CPUs are exempted from
> >>   task packing
> >> - Pack if there is atleast one busy CPU and overutilized CPUs count is <2
> >>
> >> Value of 12.5% utilization for busy CPU gives sufficient heuristics for CPU
> >> doing enough work and not become idle in nearby timeframe.
> >>
> >> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> >> ---
> >>  kernel/sched/core.c |  3 ++
> >>  kernel/sched/fair.c | 95 ++++++++++++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 97 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index 6e1ae8046fe0..7e3aff59540a 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -6402,6 +6402,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
> >>
> >>  DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
> >>  DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
> >> +DECLARE_PER_CPU(cpumask_var_t, turbo_sched_mask);
> >>
> >>  void __init sched_init(void)
> >>  {
> >> @@ -6442,6 +6443,8 @@ void __init sched_init(void)
> >>                         cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> >>                 per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
> >>                         cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> >> +               per_cpu(turbo_sched_mask, i) = (cpumask_var_t)kzalloc_node(
> >> +                       cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> >>         }
> >>  #endif /* CONFIG_CPUMASK_OFFSTACK */
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index b798fe7ff7cd..d4a1b6474338 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -5353,6 +5353,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>  /* Working cpumask for: load_balance, load_balance_newidle. */
> >>  DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
> >>  DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
> >> +/* A cpumask to find active cores in the system. */
> >> +DEFINE_PER_CPU(cpumask_var_t, turbo_sched_mask);
> >>
> >>  #ifdef CONFIG_NO_HZ_COMMON
> >>
> >> @@ -5964,6 +5966,76 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >>         return cpu;
> >>  }
> >>
> >> +#ifdef CONFIG_SCHED_SMT
> >> +static inline bool is_background_task(struct task_struct *p)
> >> +{
> >> +       if (p->flags & PF_CAN_BE_PACKED)
> >> +               return true;
> >> +
> >> +       return false;
> >> +}
> >> +
> >> +#define busyness_threshold     (100 >> 3)
> >> +#define is_cpu_busy(util) ((util) > busyness_threshold)
> >> +
> >> +/*
> >> + * Try to find a non idle core in the system  based on few heuristics:
> >> + * - Keep track of overutilized (>80% util) and busy (>12.5% util) CPUs
> >> + * - If none CPUs are busy then do not select the core for task packing
> >> + * - If atleast one CPU is busy then do task packing unless overutilized CPUs
> >> + *   count is < busy/2 CPU count
> >> + * - Always select idle CPU for task packing
> >> + */
> >> +static int select_non_idle_core(struct task_struct *p, int prev_cpu, int target)
> >> +{
> >> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
> >> +       int iter_cpu, sibling;
> >> +
> >> +       cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
> >> +
> >> +       for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
> >> +               int idle_cpu_count = 0, non_idle_cpu_count = 0;
> >> +               int overutil_cpu_count = 0;
> >> +               int busy_cpu_count = 0;
> >> +               int best_cpu = iter_cpu;
> >> +
> >> +               for_each_cpu(sibling, cpu_smt_mask(iter_cpu)) {
> >> +                       __cpumask_clear_cpu(sibling, cpus);
> >> +                       if (idle_cpu(iter_cpu)) {
> >> +                               idle_cpu_count++;
> >> +                               best_cpu = iter_cpu;
> >> +                       } else {
> >> +                               non_idle_cpu_count++;
> >> +                               if (cpu_overutilized(iter_cpu))
> >> +                                       overutil_cpu_count++;
> >> +                               if (is_cpu_busy(cpu_util(iter_cpu)))
> >> +                                       busy_cpu_count++;
> >> +                       }
> >> +               }
> >> +
> >> +               /*
> >> +                * Pack tasks to this core if
> >> +                * 1. Idle CPU count is higher and atleast one is busy
> >> +                * 2. If idle_cpu_count < non_idle_cpu_count then ideally do
> >> +                * packing but if there are more CPUs overutilized then don't
> >> +                * overload it.
> >
> > Could you give details about the rationale behind these conditions ?
>
> sure. but first maybe some background is required for busy_cpu.
> Task packing needs to be done across cores minimizing number of busy cores
> in the chip. Hence when picking a core for packing a background task it
> will be good to not select a core which is in deeper idle-states.

Make sense.
find_idlest_group_cpu() is doing something similar with the help of cpuidle
Don't you have such information available in your cpuidle driver ?

>
> Usually deeper idle states have target_residency >= 10ms which are really
> power saving states and saved power can be channeled to active cores.
> A CPU with utilization of 12.5% is most probably not going to those deeper
> idle states and picking a CPU with >= 12.5% util seems to be a good
> approximation.

you should better use idle_get_state(rq)

>
> Now going to the _main point_, task packing needs to take care of the
> following scenarios:
> 1. Not select a core having all the CPUs idle or <= 12.5% util
> 2. Do not select a core with 2 or more CPUs overloaded (>=80% util)

Why is it always 2 CPUs ? it seems that you can have 1/2/4/8 CPUs but
you keep using 2 CPUs as a threshold

> 3. Select a core even if 1 CPU is overloaded as background tasks are
> usually short running and spending time for selecting better alternative is
> not worth the investment here
> 4. Select a core if at least one CPU is busy (>=12.5% util)
> 5. On selecting a core, select an idle CPU in it.
>
> Hence to satisfy this scenarios for SMT-1/2/4 (POWER9) or 8 (POWER8 has
> 8-threads per core/ POWER9 has feature to make fake SMT-8), the approach
> keeps track of idle, non-idle, busy and overloaded CPU count in the core
> and uses above approach to find _sufficiently_ non-idle core, which seems
> to be a good heuristics to do task packing without much of regression on
> CPU intensive threads.
>
> So as per the comments in this patch, first point covers the scenario 1 and
> 4 (if part in the code), and second point covers scenario 2 and 3 (else
> part in the code).
>
> >> +                */
> >> +               if (idle_cpu_count > non_idle_cpu_count) {
> >> +                       if (busy_cpu_count)
> >> +                               return best_cpu;
> >> +               } else {
> >> +                       /*
> >> +                        * Pack tasks if at max 1 CPU is overutilized
> >> +                        */
> >> +                       if (overutil_cpu_count < 2)
> >> +                               return best_cpu;
> >> +               }
> >> +       }
> >> +
> >> +       return select_idle_sibling(p, prev_cpu, target);
> >> +}
> >> +#endif /* CONFIG_SCHED_SMT */
> >> +
> >>  /*
> >>   * Try and locate an idle core/thread in the LLC cache domain.
> >>   */
> >> @@ -6418,6 +6490,23 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >>         return -1;
> >>  }
> >>
> >> +#ifdef CONFIG_SCHED_SMT
> >> +/*
> >> + * Select all classified background tasks for task packing
> >> + */
> >> +static inline int turbosched_select_non_idle_core(struct task_struct *p,
> >> +                                                 int prev_cpu, int target)
> >> +{
> >> +       return select_non_idle_core(p, prev_cpu, target);
> >> +}
> >> +#else
> >> +static inline int turbosched_select_non_idle_core(struct task_struct *p,
> >> +                                                 int prev_cpu, int target)
> >> +{
> >> +       return select_idle_sibling(p, prev_cpu, target);
> >
> > should be better to make turbosched_select_non_idle_core empty and
> > make sure that __turbo_sched_enabled is never enabled if
> > CONFIG_SCHED_SMT is disabled
> >
>
> Totally agreed. I thought keeping like this so as to not have any "#def.."
> in select_task_rq_fair method.
> So can I do this by adding a new method like __select_idle_sibling() which
> will call turbosched_select_non_idle_core() in case of SCHED_SMT present
> and otherwise will call the regular select_idle_sibling()?
>
> >> +}
> >> +#endif
> >> +
> >>  /*
> >>   * select_task_rq_fair: Select target runqueue for the waking task in domains
> >>   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> >> @@ -6483,7 +6572,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
> >>         } else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
> >>                 /* Fast path */
> >>
> >> -               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> >> +               if (is_turbosched_enabled() && unlikely(is_background_task(p)))
> >> +                       new_cpu = turbosched_select_non_idle_core(p, prev_cpu,
> >> +                                                                 new_cpu);
> >
> > Could you add turbosched_select_non_idle_core() similarly to
> > find_energy_efficient_cpu() ?
> > Add it at the beg select_task_rq_fair()
> > Return immediately with theCPU if you have found one
> > Or let the normal path select a CPU if the
> > turbosched_select_non_idle_core() has not been able to find a suitable
> > CPU for packing
> >
>
> of course. I can do that.
> I was just not aware about the effect of wake_affine and so was waiting for
> such comments to be sure of. Thanks for this.
> Maybe I can add just below the sched_energy_present(){...} construct giving
> precedence to EAS? I'm asking this because I remember Patrick telling me to
> leverage task packing for android as well?

After  sched_energy_present(){...} seems to be a good place.

Leveraging task packing for android means that it task pacing should
collaborate with EAS and find_energy_efficient_cpu()

>
>
> Thank you very much for looking at the patches.
> Parth
>
> >
> >> +               else
> >> +                       new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> >>
> >>                 if (want_affine)
> >>                         current->recent_used_cpu = cpu;
> >> --
> >> 2.17.1
> >>
>
