Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 528D4CE179
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 14:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfJGMUN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 08:20:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46749 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfJGMUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2019 08:20:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so9066080lfc.13
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2019 05:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Os8LYv3GlllnxFiVD99J7Y92c/T0ucky+2nt+k6FyD8=;
        b=mR7p6gOhRZycmGgMGM/nfB2/sGvy8dAPH9Cpr7Ms03Nn4uWxNlSKaeP9/QclKqLjRI
         2B3cMpwOWVIcSb2mNu6wjAKEkbyDoz+5EYo09IMgDN4r9OgckJDd4PPZJ4TRqMPgucVW
         8bh2Zr0hWxZvzcovM9IHDO1ybwB7MnMlROpybCDAVnu9jIH4+MakavriEv7ahqAZRAZG
         X4xQJfZaUWearOANKC5IZZmKhhXxhh+pN81QQNfmn1s8lGkoo2XBzb7kcl6QGDdw+6dG
         TdyHF3SMI86zpi7OgPBk7noyErxatG240L2l0Yl0Dl8HHBgDF57SwjINN2jGoKhowqHa
         6qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Os8LYv3GlllnxFiVD99J7Y92c/T0ucky+2nt+k6FyD8=;
        b=d21Red4CXFxx8t2EOhfHZ6g/FmwCcf8VM7Ee5Zbla3tQt8LYQdzytn3e6M3E6ErCRG
         aQiNiuaGkCLb3WodqBXpwRy+JmzWpnsGYpF81hWN6+BQW2vUPFUAKBmsnY7rzfhMnW9F
         XxcsVySElEHIQGKtBCJ56N/kzaBh4kGGAkH5IC5k4A3F+jB4tQojzDLeDpq1nQXHby/Y
         TbB7ehGcwKzJ4XN/a0jhRbMVbvuZWTdKq3assJiWX6mTN+d2WDXvPfTwrS0SH5hfpMs8
         fuprGDmm9B2K7f7J4ZAFDlsabMP2tLCKlZHI4L5f/urE/Jbav9AIWKTmK6HAgpn2V5JS
         K3SA==
X-Gm-Message-State: APjAAAWKkn8+dCHgnVfKT2tx2+NwDsDfzROmKuzNjanE8HeAiXtrnXdP
        3/YEi+vymY7cEr4bPjqeMTS9uQzJ+sk4zJKjKQHvaw==
X-Google-Smtp-Source: APXvYqxf/tMLWirlJUBDHtyLASCbu0L1Io8T6H/E2rHDE5v5FpZsYtBYcnZp9lPm9/POUZ/hSgLnNu9FM9B/M4EK6fs=
X-Received: by 2002:a05:6512:411:: with SMTP id u17mr6401412lfk.151.1570450809085;
 Mon, 07 Oct 2019 05:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191007083051.4820-1-parth@linux.ibm.com> <20191007083051.4820-5-parth@linux.ibm.com>
In-Reply-To: <20191007083051.4820-5-parth@linux.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 7 Oct 2019 14:19:57 +0200
Message-ID: <CAKfTPtCgoTJXxbYyza1W55ayw9QeM7fue2e91Xpt804sL9GQWA@mail.gmail.com>
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

On Mon, 7 Oct 2019 at 10:31, Parth Shah <parth@linux.ibm.com> wrote:
>
> The algorithm finds the first non idle core in the system and tries to
> place a task in the idle CPU in the chosen core. To maintain
> cache hotness, work of finding non idle core starts from the prev_cpu,
> which also reduces task ping-pong behaviour inside of the core.
>
> Define a new method to select_non_idle_core which keep tracks of the idle
> and non-idle CPUs in the core and based on the heuristics determines if the
> core is sufficiently busy to place the incoming backgroung task. The
> heuristic further defines the non-idle CPU into either busy (>12.5% util)
> CPU and overutilized (>80% util) CPU.
> - The core containing more idle CPUs and no busy CPUs is not selected for
>   packing
> - The core if contains more than 1 overutilized CPUs are exempted from
>   task packing
> - Pack if there is atleast one busy CPU and overutilized CPUs count is <2
>
> Value of 12.5% utilization for busy CPU gives sufficient heuristics for CPU
> doing enough work and not become idle in nearby timeframe.
>
> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> ---
>  kernel/sched/core.c |  3 ++
>  kernel/sched/fair.c | 95 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6e1ae8046fe0..7e3aff59540a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6402,6 +6402,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
>
>  DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
>  DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
> +DECLARE_PER_CPU(cpumask_var_t, turbo_sched_mask);
>
>  void __init sched_init(void)
>  {
> @@ -6442,6 +6443,8 @@ void __init sched_init(void)
>                         cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>                 per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
>                         cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +               per_cpu(turbo_sched_mask, i) = (cpumask_var_t)kzalloc_node(
> +                       cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>         }
>  #endif /* CONFIG_CPUMASK_OFFSTACK */
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b798fe7ff7cd..d4a1b6474338 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5353,6 +5353,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  /* Working cpumask for: load_balance, load_balance_newidle. */
>  DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
>  DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
> +/* A cpumask to find active cores in the system. */
> +DEFINE_PER_CPU(cpumask_var_t, turbo_sched_mask);
>
>  #ifdef CONFIG_NO_HZ_COMMON
>
> @@ -5964,6 +5966,76 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         return cpu;
>  }
>
> +#ifdef CONFIG_SCHED_SMT
> +static inline bool is_background_task(struct task_struct *p)
> +{
> +       if (p->flags & PF_CAN_BE_PACKED)
> +               return true;
> +
> +       return false;
> +}
> +
> +#define busyness_threshold     (100 >> 3)
> +#define is_cpu_busy(util) ((util) > busyness_threshold)
> +
> +/*
> + * Try to find a non idle core in the system  based on few heuristics:
> + * - Keep track of overutilized (>80% util) and busy (>12.5% util) CPUs
> + * - If none CPUs are busy then do not select the core for task packing
> + * - If atleast one CPU is busy then do task packing unless overutilized CPUs
> + *   count is < busy/2 CPU count
> + * - Always select idle CPU for task packing
> + */
> +static int select_non_idle_core(struct task_struct *p, int prev_cpu, int target)
> +{
> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
> +       int iter_cpu, sibling;
> +
> +       cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
> +
> +       for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
> +               int idle_cpu_count = 0, non_idle_cpu_count = 0;
> +               int overutil_cpu_count = 0;
> +               int busy_cpu_count = 0;
> +               int best_cpu = iter_cpu;
> +
> +               for_each_cpu(sibling, cpu_smt_mask(iter_cpu)) {
> +                       __cpumask_clear_cpu(sibling, cpus);
> +                       if (idle_cpu(iter_cpu)) {
> +                               idle_cpu_count++;
> +                               best_cpu = iter_cpu;
> +                       } else {
> +                               non_idle_cpu_count++;
> +                               if (cpu_overutilized(iter_cpu))
> +                                       overutil_cpu_count++;
> +                               if (is_cpu_busy(cpu_util(iter_cpu)))
> +                                       busy_cpu_count++;
> +                       }
> +               }
> +
> +               /*
> +                * Pack tasks to this core if
> +                * 1. Idle CPU count is higher and atleast one is busy
> +                * 2. If idle_cpu_count < non_idle_cpu_count then ideally do
> +                * packing but if there are more CPUs overutilized then don't
> +                * overload it.

Could you give details about the rationale behind these conditions ?

> +                */
> +               if (idle_cpu_count > non_idle_cpu_count) {
> +                       if (busy_cpu_count)
> +                               return best_cpu;
> +               } else {
> +                       /*
> +                        * Pack tasks if at max 1 CPU is overutilized
> +                        */
> +                       if (overutil_cpu_count < 2)
> +                               return best_cpu;
> +               }
> +       }
> +
> +       return select_idle_sibling(p, prev_cpu, target);
> +}
> +#endif /* CONFIG_SCHED_SMT */
> +
>  /*
>   * Try and locate an idle core/thread in the LLC cache domain.
>   */
> @@ -6418,6 +6490,23 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>         return -1;
>  }
>
> +#ifdef CONFIG_SCHED_SMT
> +/*
> + * Select all classified background tasks for task packing
> + */
> +static inline int turbosched_select_non_idle_core(struct task_struct *p,
> +                                                 int prev_cpu, int target)
> +{
> +       return select_non_idle_core(p, prev_cpu, target);
> +}
> +#else
> +static inline int turbosched_select_non_idle_core(struct task_struct *p,
> +                                                 int prev_cpu, int target)
> +{
> +       return select_idle_sibling(p, prev_cpu, target);

should be better to make turbosched_select_non_idle_core empty and
make sure that __turbo_sched_enabled is never enabled if
CONFIG_SCHED_SMT is disabled

> +}
> +#endif
> +
>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> @@ -6483,7 +6572,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>         } else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
>                 /* Fast path */
>
> -               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +               if (is_turbosched_enabled() && unlikely(is_background_task(p)))
> +                       new_cpu = turbosched_select_non_idle_core(p, prev_cpu,
> +                                                                 new_cpu);

Could you add turbosched_select_non_idle_core() similarly to
find_energy_efficient_cpu() ?
Add it at the beg select_task_rq_fair()
Return immediately with theCPU if you have found one
Or let the normal path select a CPU if the
turbosched_select_non_idle_core() has not been able to find a suitable
CPU for packing


> +               else
> +                       new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>
>                 if (want_affine)
>                         current->recent_used_cpu = cpu;
> --
> 2.17.1
>
