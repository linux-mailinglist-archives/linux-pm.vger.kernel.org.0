Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78BEF3D8F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 02:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfKHBo2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 20:44:28 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34964 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfKHBo2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 20:44:28 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so3899251oig.2;
        Thu, 07 Nov 2019 17:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/rBJ22YHi1HXWqKEgiaMq62ifYRRLK0BmfqfUuN/oU=;
        b=XL4NSNvb+wz6QkjKscxfpN4ymwom2d2eOYTPaBDCbe3/o4Hifm5vkydiQmm4kn+TpO
         /0G4jnDMB9/rfHOmH39UC0UHfAXQjH0WjDur3DBmBZ7pppOaVleA7CNfkai2d2fIAD6k
         NpjLKwVb6uQOM0QiLZZ5uBVabXxEtceHl3fTv1cXl1iQBcOwD3t3psS9eX8JoXRRTE1E
         tyEENZ3UroWr4DlM1ceSGYeVp7mOE46D4NSC2PX8wB3G94WopQUK+zBK/0Y6PuGY8SJA
         dIvLCllatBY1CxDBqxnPE92+obeIj3Bx/2bx/+E0lAzxCKZnd5FqY6ipq7dAOpBEx4yN
         knJg==
X-Gm-Message-State: APjAAAXKhqapk21H5drfj5YN5cQ+AXDycDglDGnqzB19Qof9qO6bVQ75
        FHkUjuGVT1renNImgrbl47ye8LThUJ/i62I7ZsISdw==
X-Google-Smtp-Source: APXvYqxBn4/dn0TpjMA7UsfM2SxBj14f7AEDky1qbw4OHs4yWpeXs2NEhxm/XIa/rvMezjAS7nhz+W5I5ao9U4kslSQ=
X-Received: by 2002:aca:530c:: with SMTP id h12mr2225747oib.110.1573177464503;
 Thu, 07 Nov 2019 17:44:24 -0800 (PST)
MIME-Version: 1.0
References: <10494959.bKODIZ00nm@kreacher> <3269796.AzLOQfDnpo@kreacher>
In-Reply-To: <3269796.AzLOQfDnpo@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Nov 2019 02:44:13 +0100
Message-ID: <CAJZ5v0jM3+qMvO6dx=FmK-xF0q3YKOwBf-yUPXSBfRjxJ59Cpg@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Use nanoseconds as the unit of time
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 7, 2019 at 3:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Currently, the cpuidle subsystem uses microseconds as the unit of
> time which (among other things) causes the idle loop to incur some
> integer division overhead for no clear benefit.
>
> In order to allow cpuidle to measure time in nanoseconds, add two
> additional fields, exit_latency_ns and target_residency_ns, to
> represent the exit latency and target residency of an idle state
> in nanoseconds, respectively, to struct cpuidle_state_usage and
> initialize them with the help of the corresponding values in
> microseconds provided by drivers.  In addition to that, change
> cpuidle_governor_latency_req() to return the idle state exit
> latency constraint in nanoseconds.
>
> With that, meeasure idle state residency (last_residency_ns in
> struct cpuidle_device and time_ns in struct cpuidle_driver) in
> nanoseconds and update the cpuidle core and governors accordingly.
>
> However, the menu governor still computes typical intervals in
> microseconds to avoid integer overflows.

Since this addresses all of the comments received by the RFC version
that was posted over a month ago and I don't see any more issues with
it, I'm tempted to simply queue it up for 5.5 unless somebody sees a
good enough reason why that would be a bad idea.

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> -> v2:
>  - Fix the direction of the comparison in cpuidle_governor_latency_req() (was
>    "less than", should be "greater than").
>  - Use predicted_ns and TICK_NSEC instead of predicted_us and TICK_USEC,
>    respectively, in one leftover location in menu_select().
>  - Use target_residency_ns and exit_latency_ns when reading the
>    "residency" and "latency" sysfs attributes, respectively (in case the
>    values in us are not set by the driver).
>
> Changes since RFC:
>  - Rework the predicted_us and predicted_ns computation in the
>    menu governor (Peter).
>  - Rebase on top of the current linux-next with
>    https://patchwork.kernel.org/patch/11225501/ applied.
>
> ---
>  drivers/cpuidle/cpuidle.c            |   36 +++++------
>  drivers/cpuidle/driver.c             |   29 ++++++--
>  drivers/cpuidle/governor.c           |    7 +-
>  drivers/cpuidle/governors/haltpoll.c |    7 --
>  drivers/cpuidle/governors/ladder.c   |   25 ++++---
>  drivers/cpuidle/governors/menu.c     |  113 +++++++++++++++++------------------
>  drivers/cpuidle/governors/teo.c      |   76 +++++++++++------------
>  drivers/cpuidle/sysfs.c              |   20 +++++-
>  include/linux/cpuidle.h              |    8 +-
>  kernel/sched/idle.c                  |    2
>  10 files changed, 172 insertions(+), 151 deletions(-)
>
> Index: linux-pm/include/linux/cpuidle.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpuidle.h
> +++ linux-pm/include/linux/cpuidle.h
> @@ -35,7 +35,7 @@ struct cpuidle_driver;
>  struct cpuidle_state_usage {
>         unsigned long long      disable;
>         unsigned long long      usage;
> -       unsigned long long      time; /* in US */
> +       u64                     time_ns;
>         unsigned long long      above; /* Number of times it's been too deep */
>         unsigned long long      below; /* Number of times it's been too shallow */
>  #ifdef CONFIG_SUSPEND
> @@ -48,6 +48,8 @@ struct cpuidle_state {
>         char            name[CPUIDLE_NAME_LEN];
>         char            desc[CPUIDLE_DESC_LEN];
>
> +       u64             exit_latency_ns;
> +       u64             target_residency_ns;
>         unsigned int    flags;
>         unsigned int    exit_latency; /* in US */
>         int             power_usage; /* in mW */
> @@ -89,7 +91,7 @@ struct cpuidle_device {
>         ktime_t                 next_hrtimer;
>
>         int                     last_state_idx;
> -       int                     last_residency;
> +       u64                     last_residency_ns;
>         u64                     poll_limit_ns;
>         struct cpuidle_state_usage      states_usage[CPUIDLE_STATE_MAX];
>         struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
> @@ -263,7 +265,7 @@ struct cpuidle_governor {
>
>  #ifdef CONFIG_CPU_IDLE
>  extern int cpuidle_register_governor(struct cpuidle_governor *gov);
> -extern int cpuidle_governor_latency_req(unsigned int cpu);
> +extern s64 cpuidle_governor_latency_req(unsigned int cpu);
>  #else
>  static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
>  {return 0;}
> Index: linux-pm/drivers/cpuidle/driver.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/driver.c
> +++ linux-pm/drivers/cpuidle/driver.c
> @@ -165,16 +165,27 @@ static void __cpuidle_driver_init(struct
>         if (!drv->cpumask)
>                 drv->cpumask = (struct cpumask *)cpu_possible_mask;
>
> -       /*
> -        * Look for the timer stop flag in the different states, so that we know
> -        * if the broadcast timer has to be set up.  The loop is in the reverse
> -        * order, because usually one of the deeper states have this flag set.
> -        */
> -       for (i = drv->state_count - 1; i >= 0 ; i--) {
> -               if (drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP) {
> +       for (i = 0; i < drv->state_count; i++) {
> +               struct cpuidle_state *s = &drv->states[i];
> +
> +               /*
> +                * Look for the timer stop flag in the different states and if
> +                * it is found, indicate that the broadcast timer has to be set
> +                * up.
> +                */
> +               if (s->flags & CPUIDLE_FLAG_TIMER_STOP)
>                         drv->bctimer = 1;
> -                       break;
> -               }
> +
> +               /*
> +                * The core will use the target residency and exit latency
> +                * values in nanoseconds, but allow drivers to provide them in
> +                * microseconds too.
> +                */
> +               if (s->target_residency > 0)
> +                       s->target_residency_ns = s->target_residency * NSEC_PER_USEC;
> +
> +               if (s->exit_latency > 0)
> +                       s->exit_latency_ns = s->exit_latency * NSEC_PER_USEC;
>         }
>  }
>
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -75,24 +75,24 @@ int cpuidle_play_dead(void)
>
>  static int find_deepest_state(struct cpuidle_driver *drv,
>                               struct cpuidle_device *dev,
> -                             unsigned int max_latency,
> +                             u64 max_latency_ns,
>                               unsigned int forbidden_flags,
>                               bool s2idle)
>  {
> -       unsigned int latency_req = 0;
> +       u64 latency_req = 0;
>         int i, ret = 0;
>
>         for (i = 1; i < drv->state_count; i++) {
>                 struct cpuidle_state *s = &drv->states[i];
>
>                 if (dev->states_usage[i].disable ||
> -                   s->exit_latency <= latency_req ||
> -                   s->exit_latency > max_latency ||
> +                   s->exit_latency_ns <= latency_req ||
> +                   s->exit_latency_ns > max_latency_ns ||
>                     (s->flags & forbidden_flags) ||
>                     (s2idle && !s->enter_s2idle))
>                         continue;
>
> -               latency_req = s->exit_latency;
> +               latency_req = s->exit_latency_ns;
>                 ret = i;
>         }
>         return ret;
> @@ -124,7 +124,7 @@ void cpuidle_use_deepest_state(bool enab
>  int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                struct cpuidle_device *dev)
>  {
> -       return find_deepest_state(drv, dev, UINT_MAX, 0, false);
> +       return find_deepest_state(drv, dev, U64_MAX, 0, false);
>  }
>
>  #ifdef CONFIG_SUSPEND
> @@ -180,7 +180,7 @@ int cpuidle_enter_s2idle(struct cpuidle_
>          * that interrupts won't be enabled when it exits and allows the tick to
>          * be frozen safely.
>          */
> -       index = find_deepest_state(drv, dev, UINT_MAX, 0, true);
> +       index = find_deepest_state(drv, dev, U64_MAX, 0, true);
>         if (index > 0)
>                 enter_s2idle_proper(drv, dev, index);
>
> @@ -209,7 +209,7 @@ int cpuidle_enter_state(struct cpuidle_d
>          * CPU as a broadcast timer, this call may fail if it is not available.
>          */
>         if (broadcast && tick_broadcast_enter()) {
> -               index = find_deepest_state(drv, dev, target_state->exit_latency,
> +               index = find_deepest_state(drv, dev, target_state->exit_latency_ns,
>                                            CPUIDLE_FLAG_TIMER_STOP, false);
>                 if (index < 0) {
>                         default_idle_call();
> @@ -247,7 +247,7 @@ int cpuidle_enter_state(struct cpuidle_d
>                 local_irq_enable();
>
>         if (entered_state >= 0) {
> -               s64 diff, delay = drv->states[entered_state].exit_latency;
> +               s64 diff, delay = drv->states[entered_state].exit_latency_ns;
>                 int i;
>
>                 /*
> @@ -255,15 +255,13 @@ int cpuidle_enter_state(struct cpuidle_d
>                  * This can be moved to within driver enter routine,
>                  * but that results in multiple copies of same code.
>                  */
> -               diff = ktime_us_delta(time_end, time_start);
> -               if (diff > INT_MAX)
> -                       diff = INT_MAX;
> +               diff = ktime_sub(time_end, time_start);
>
> -               dev->last_residency = (int)diff;
> -               dev->states_usage[entered_state].time += dev->last_residency;
> +               dev->last_residency_ns = diff;
> +               dev->states_usage[entered_state].time_ns += diff;
>                 dev->states_usage[entered_state].usage++;
>
> -               if (diff < drv->states[entered_state].target_residency) {
> +               if (diff < drv->states[entered_state].target_residency_ns) {
>                         for (i = entered_state - 1; i >= 0; i--) {
>                                 if (dev->states_usage[i].disable)
>                                         continue;
> @@ -281,14 +279,14 @@ int cpuidle_enter_state(struct cpuidle_d
>                                  * Update if a deeper state would have been a
>                                  * better match for the observed idle duration.
>                                  */
> -                               if (diff - delay >= drv->states[i].target_residency)
> +                               if (diff - delay >= drv->states[i].target_residency_ns)
>                                         dev->states_usage[entered_state].below++;
>
>                                 break;
>                         }
>                 }
>         } else {
> -               dev->last_residency = 0;
> +               dev->last_residency_ns = 0;
>         }
>
>         return entered_state;
> @@ -381,7 +379,7 @@ u64 cpuidle_poll_time(struct cpuidle_dri
>                 if (dev->states_usage[i].disable)
>                         continue;
>
> -               limit_ns = (u64)drv->states[i].target_residency * NSEC_PER_USEC;
> +               limit_ns = (u64)drv->states[i].target_residency_ns;
>         }
>
>         dev->poll_limit_ns = limit_ns;
> @@ -552,7 +550,7 @@ static void __cpuidle_unregister_device(
>  static void __cpuidle_device_init(struct cpuidle_device *dev)
>  {
>         memset(dev->states_usage, 0, sizeof(dev->states_usage));
> -       dev->last_residency = 0;
> +       dev->last_residency_ns = 0;
>         dev->next_hrtimer = 0;
>  }
>
> Index: linux-pm/drivers/cpuidle/sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/sysfs.c
> +++ linux-pm/drivers/cpuidle/sysfs.c
> @@ -273,16 +273,30 @@ static ssize_t show_state_##_name(struct
>         return sprintf(buf, "%s\n", state->_name);\
>  }
>
> -define_show_state_function(exit_latency)
> -define_show_state_function(target_residency)
> +#define define_show_state_time_function(_name) \
> +static ssize_t show_state_##_name(struct cpuidle_state *state, \
> +                                 struct cpuidle_state_usage *state_usage, \
> +                                 char *buf) \
> +{ \
> +       return sprintf(buf, "%llu\n", ktime_to_us(state->_name##_ns)); \
> +}
> +
> +define_show_state_time_function(exit_latency)
> +define_show_state_time_function(target_residency)
>  define_show_state_function(power_usage)
>  define_show_state_ull_function(usage)
> -define_show_state_ull_function(time)
>  define_show_state_str_function(name)
>  define_show_state_str_function(desc)
>  define_show_state_ull_function(above)
>  define_show_state_ull_function(below)
>
> +static ssize_t show_state_time(struct cpuidle_state *state,
> +                              struct cpuidle_state_usage *state_usage,
> +                              char *buf)
> +{
> +       return sprintf(buf, "%llu\n", ktime_to_us(state_usage->time_ns));
> +}
> +
>  static ssize_t show_state_disable(struct cpuidle_state *state,
>                                   struct cpuidle_state_usage *state_usage,
>                                   char *buf)
> Index: linux-pm/drivers/cpuidle/governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governor.c
> +++ linux-pm/drivers/cpuidle/governor.c
> @@ -107,11 +107,14 @@ int cpuidle_register_governor(struct cpu
>   * cpuidle_governor_latency_req - Compute a latency constraint for CPU
>   * @cpu: Target CPU
>   */
> -int cpuidle_governor_latency_req(unsigned int cpu)
> +s64 cpuidle_governor_latency_req(unsigned int cpu)
>  {
>         int global_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
>         struct device *device = get_cpu_device(cpu);
>         int device_req = dev_pm_qos_raw_resume_latency(device);
>
> -       return device_req < global_req ? device_req : global_req;
> +       if (device_req > global_req)
> +               device_req = global_req;
> +
> +       return (s64)device_req * NSEC_PER_USEC;
>  }
> Index: linux-pm/drivers/cpuidle/governors/ladder.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/ladder.c
> +++ linux-pm/drivers/cpuidle/governors/ladder.c
> @@ -27,8 +27,8 @@ struct ladder_device_state {
>         struct {
>                 u32 promotion_count;
>                 u32 demotion_count;
> -               u32 promotion_time;
> -               u32 demotion_time;
> +               u64 promotion_time_ns;
> +               u64 demotion_time_ns;
>         } threshold;
>         struct {
>                 int promotion_count;
> @@ -68,9 +68,10 @@ static int ladder_select_state(struct cp
>  {
>         struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
>         struct ladder_device_state *last_state;
> -       int last_residency, last_idx = dev->last_state_idx;
> +       int last_idx = dev->last_state_idx;
>         int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
> -       int latency_req = cpuidle_governor_latency_req(dev->cpu);
> +       s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
> +       s64 last_residency;
>
>         /* Special case when user has set very strict latency requirement */
>         if (unlikely(latency_req == 0)) {
> @@ -80,13 +81,13 @@ static int ladder_select_state(struct cp
>
>         last_state = &ldev->states[last_idx];
>
> -       last_residency = dev->last_residency - drv->states[last_idx].exit_latency;
> +       last_residency = dev->last_residency_ns - drv->states[last_idx].exit_latency_ns;
>
>         /* consider promotion */
>         if (last_idx < drv->state_count - 1 &&
>             !dev->states_usage[last_idx + 1].disable &&
> -           last_residency > last_state->threshold.promotion_time &&
> -           drv->states[last_idx + 1].exit_latency <= latency_req) {
> +           last_residency > last_state->threshold.promotion_time_ns &&
> +           drv->states[last_idx + 1].exit_latency_ns <= latency_req) {
>                 last_state->stats.promotion_count++;
>                 last_state->stats.demotion_count = 0;
>                 if (last_state->stats.promotion_count >= last_state->threshold.promotion_count) {
> @@ -98,11 +99,11 @@ static int ladder_select_state(struct cp
>         /* consider demotion */
>         if (last_idx > first_idx &&
>             (dev->states_usage[last_idx].disable ||
> -           drv->states[last_idx].exit_latency > latency_req)) {
> +           drv->states[last_idx].exit_latency_ns > latency_req)) {
>                 int i;
>
>                 for (i = last_idx - 1; i > first_idx; i--) {
> -                       if (drv->states[i].exit_latency <= latency_req)
> +                       if (drv->states[i].exit_latency_ns <= latency_req)
>                                 break;
>                 }
>                 ladder_do_selection(dev, ldev, last_idx, i);
> @@ -110,7 +111,7 @@ static int ladder_select_state(struct cp
>         }
>
>         if (last_idx > first_idx &&
> -           last_residency < last_state->threshold.demotion_time) {
> +           last_residency < last_state->threshold.demotion_time_ns) {
>                 last_state->stats.demotion_count++;
>                 last_state->stats.promotion_count = 0;
>                 if (last_state->stats.demotion_count >= last_state->threshold.demotion_count) {
> @@ -150,9 +151,9 @@ static int ladder_enable_device(struct c
>                 lstate->threshold.demotion_count = DEMOTION_COUNT;
>
>                 if (i < drv->state_count - 1)
> -                       lstate->threshold.promotion_time = state->exit_latency;
> +                       lstate->threshold.promotion_time_ns = state->exit_latency_ns;
>                 if (i > first_idx)
> -                       lstate->threshold.demotion_time = state->exit_latency;
> +                       lstate->threshold.demotion_time_ns = state->exit_latency_ns;
>         }
>
>         return 0;
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -33,7 +33,7 @@
>  #define INTERVALS (1UL << INTERVAL_SHIFT)
>  #define RESOLUTION 1024
>  #define DECAY 8
> -#define MAX_INTERESTING 50000
> +#define MAX_INTERESTING (50000 * NSEC_PER_USEC)
>
>
>  /*
> @@ -120,14 +120,14 @@ struct menu_device {
>         int             needs_update;
>         int             tick_wakeup;
>
> -       unsigned int    next_timer_us;
> +       u64             next_timer_ns;
>         unsigned int    bucket;
>         unsigned int    correction_factor[BUCKETS];
>         unsigned int    intervals[INTERVALS];
>         int             interval_ptr;
>  };
>
> -static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters)
> +static inline int which_bucket(u64 duration_ns, unsigned long nr_iowaiters)
>  {
>         int bucket = 0;
>
> @@ -140,15 +140,15 @@ static inline int which_bucket(unsigned
>         if (nr_iowaiters)
>                 bucket = BUCKETS/2;
>
> -       if (duration < 10)
> +       if (duration_ns < 10ULL * NSEC_PER_USEC)
>                 return bucket;
> -       if (duration < 100)
> +       if (duration_ns < 100ULL * NSEC_PER_USEC)
>                 return bucket + 1;
> -       if (duration < 1000)
> +       if (duration_ns < 1000ULL * NSEC_PER_USEC)
>                 return bucket + 2;
> -       if (duration < 10000)
> +       if (duration_ns < 10000ULL * NSEC_PER_USEC)
>                 return bucket + 3;
> -       if (duration < 100000)
> +       if (duration_ns < 100000ULL * NSEC_PER_USEC)
>                 return bucket + 4;
>         return bucket + 5;
>  }
> @@ -276,13 +276,13 @@ static int menu_select(struct cpuidle_dr
>                        bool *stop_tick)
>  {
>         struct menu_device *data = this_cpu_ptr(&menu_devices);
> -       int latency_req = cpuidle_governor_latency_req(dev->cpu);
> -       int i;
> -       int idx;
> -       unsigned int interactivity_req;
> +       s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
>         unsigned int predicted_us;
> +       u64 predicted_ns;
> +       u64 interactivity_req;
>         unsigned long nr_iowaiters;
>         ktime_t delta_next;
> +       int i, idx;
>
>         if (data->needs_update) {
>                 menu_update(drv, dev);
> @@ -290,14 +290,14 @@ static int menu_select(struct cpuidle_dr
>         }
>
>         /* determine the expected residency time, round up */
> -       data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
> +       data->next_timer_ns = tick_nohz_get_sleep_length(&delta_next);
>
>         nr_iowaiters = nr_iowait_cpu(dev->cpu);
> -       data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
> +       data->bucket = which_bucket(data->next_timer_ns, nr_iowaiters);
>
>         if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
> -           ((data->next_timer_us < drv->states[1].target_residency ||
> -             latency_req < drv->states[1].exit_latency) &&
> +           ((data->next_timer_ns < drv->states[1].target_residency_ns ||
> +             latency_req < drv->states[1].exit_latency_ns) &&
>              !dev->states_usage[0].disable)) {
>                 /*
>                  * In this case state[0] will be used no matter what, so return
> @@ -308,18 +308,15 @@ static int menu_select(struct cpuidle_dr
>                 return 0;
>         }
>
> -       /*
> -        * Force the result of multiplication to be 64 bits even if both
> -        * operands are 32 bits.
> -        * Make sure to round up for half microseconds.
> -        */
> -       predicted_us = DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_timer_us *
> -                                        data->correction_factor[data->bucket],
> -                                        RESOLUTION * DECAY);
> -       /*
> -        * Use the lowest expected idle interval to pick the idle state.
> -        */
> -       predicted_us = min(predicted_us, get_typical_interval(data, predicted_us));
> +       /* Round up the result for half microseconds. */
> +       predicted_us = div_u64(data->next_timer_ns *
> +                              data->correction_factor[data->bucket] +
> +                              (RESOLUTION * DECAY * NSEC_PER_USEC) / 2,
> +                              RESOLUTION * DECAY * NSEC_PER_USEC);
> +       /* Use the lowest expected idle interval to pick the idle state. */
> +       predicted_ns = (u64)min(predicted_us,
> +                               get_typical_interval(data, predicted_us)) *
> +                               NSEC_PER_USEC;
>
>         if (tick_nohz_tick_stopped()) {
>                 /*
> @@ -330,14 +327,15 @@ static int menu_select(struct cpuidle_dr
>                  * the known time till the closest timer event for the idle
>                  * state selection.
>                  */
> -               if (predicted_us < TICK_USEC)
> -                       predicted_us = ktime_to_us(delta_next);
> +               if (predicted_ns < TICK_NSEC)
> +                       predicted_ns = delta_next;
>         } else {
>                 /*
>                  * Use the performance multiplier and the user-configurable
>                  * latency_req to determine the maximum exit latency.
>                  */
> -               interactivity_req = predicted_us / performance_multiplier(nr_iowaiters);
> +               interactivity_req = div64_u64(predicted_ns,
> +                                             performance_multiplier(nr_iowaiters));
>                 if (latency_req > interactivity_req)
>                         latency_req = interactivity_req;
>         }
> @@ -356,19 +354,19 @@ static int menu_select(struct cpuidle_dr
>                 if (idx == -1)
>                         idx = i; /* first enabled state */
>
> -               if (s->target_residency > predicted_us) {
> +               if (s->target_residency_ns > predicted_ns) {
>                         /*
>                          * Use a physical idle state, not busy polling, unless
>                          * a timer is going to trigger soon enough.
>                          */
>                         if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -                           s->exit_latency <= latency_req &&
> -                           s->target_residency <= data->next_timer_us) {
> -                               predicted_us = s->target_residency;
> +                           s->exit_latency_ns <= latency_req &&
> +                           s->target_residency_ns <= data->next_timer_ns) {
> +                               predicted_ns = s->target_residency_ns;
>                                 idx = i;
>                                 break;
>                         }
> -                       if (predicted_us < TICK_USEC)
> +                       if (predicted_ns < TICK_NSEC)
>                                 break;
>
>                         if (!tick_nohz_tick_stopped()) {
> @@ -378,7 +376,7 @@ static int menu_select(struct cpuidle_dr
>                                  * tick in that case and let the governor run
>                                  * again in the next iteration of the loop.
>                                  */
> -                               predicted_us = drv->states[idx].target_residency;
> +                               predicted_ns = drv->states[idx].target_residency_ns;
>                                 break;
>                         }
>
> @@ -388,13 +386,13 @@ static int menu_select(struct cpuidle_dr
>                          * closest timer event, select this one to avoid getting
>                          * stuck in the shallow one for too long.
>                          */
> -                       if (drv->states[idx].target_residency < TICK_USEC &&
> -                           s->target_residency <= ktime_to_us(delta_next))
> +                       if (drv->states[idx].target_residency_ns < TICK_NSEC &&
> +                           s->target_residency_ns <= delta_next)
>                                 idx = i;
>
>                         return idx;
>                 }
> -               if (s->exit_latency > latency_req)
> +               if (s->exit_latency_ns > latency_req)
>                         break;
>
>                 idx = i;
> @@ -408,12 +406,10 @@ static int menu_select(struct cpuidle_dr
>          * expected idle duration is shorter than the tick period length.
>          */
>         if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> -            predicted_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
> -               unsigned int delta_next_us = ktime_to_us(delta_next);
> -
> +            predicted_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
>                 *stop_tick = false;
>
> -               if (idx > 0 && drv->states[idx].target_residency > delta_next_us) {
> +               if (idx > 0 && drv->states[idx].target_residency_ns > delta_next) {
>                         /*
>                          * The tick is not going to be stopped and the target
>                          * residency of the state to be returned is not within
> @@ -425,7 +421,7 @@ static int menu_select(struct cpuidle_dr
>                                         continue;
>
>                                 idx = i;
> -                               if (drv->states[i].target_residency <= delta_next_us)
> +                               if (drv->states[i].target_residency_ns <= delta_next)
>                                         break;
>                         }
>                 }
> @@ -461,7 +457,7 @@ static void menu_update(struct cpuidle_d
>         struct menu_device *data = this_cpu_ptr(&menu_devices);
>         int last_idx = dev->last_state_idx;
>         struct cpuidle_state *target = &drv->states[last_idx];
> -       unsigned int measured_us;
> +       u64 measured_ns;
>         unsigned int new_factor;
>
>         /*
> @@ -479,7 +475,7 @@ static void menu_update(struct cpuidle_d
>          * assume the state was never reached and the exit latency is 0.
>          */
>
> -       if (data->tick_wakeup && data->next_timer_us > TICK_USEC) {
> +       if (data->tick_wakeup && data->next_timer_ns > TICK_NSEC) {
>                 /*
>                  * The nohz code said that there wouldn't be any events within
>                  * the tick boundary (if the tick was stopped), but the idle
> @@ -489,7 +485,7 @@ static void menu_update(struct cpuidle_d
>                  * have been idle long (but not forever) to help the idle
>                  * duration predictor do a better job next time.
>                  */
> -               measured_us = 9 * MAX_INTERESTING / 10;
> +               measured_ns = 9 * MAX_INTERESTING / 10;
>         } else if ((drv->states[last_idx].flags & CPUIDLE_FLAG_POLLING) &&
>                    dev->poll_time_limit) {
>                 /*
> @@ -499,28 +495,29 @@ static void menu_update(struct cpuidle_d
>                  * the CPU might have been woken up from idle by the next timer.
>                  * Assume that to be the case.
>                  */
> -               measured_us = data->next_timer_us;
> +               measured_ns = data->next_timer_ns;
>         } else {
>                 /* measured value */
> -               measured_us = dev->last_residency;
> +               measured_ns = dev->last_residency_ns;
>
>                 /* Deduct exit latency */
> -               if (measured_us > 2 * target->exit_latency)
> -                       measured_us -= target->exit_latency;
> +               if (measured_ns > 2 * target->exit_latency_ns)
> +                       measured_ns -= target->exit_latency_ns;
>                 else
> -                       measured_us /= 2;
> +                       measured_ns /= 2;
>         }
>
>         /* Make sure our coefficients do not exceed unity */
> -       if (measured_us > data->next_timer_us)
> -               measured_us = data->next_timer_us;
> +       if (measured_ns > data->next_timer_ns)
> +               measured_ns = data->next_timer_ns;
>
>         /* Update our correction ratio */
>         new_factor = data->correction_factor[data->bucket];
>         new_factor -= new_factor / DECAY;
>
> -       if (data->next_timer_us > 0 && measured_us < MAX_INTERESTING)
> -               new_factor += RESOLUTION * measured_us / data->next_timer_us;
> +       if (data->next_timer_ns > 0 && measured_ns < MAX_INTERESTING)
> +               new_factor += RESOLUTION * div64_u64(measured_ns,
> +                                                    data->next_timer_ns);
>         else
>                 /*
>                  * we were idle so long that we count it as a perfect
> @@ -540,7 +537,7 @@ static void menu_update(struct cpuidle_d
>         data->correction_factor[data->bucket] = new_factor;
>
>         /* update the repeating-pattern data */
> -       data->intervals[data->interval_ptr++] = measured_us;
> +       data->intervals[data->interval_ptr++] = ktime_to_us(measured_ns);
>         if (data->interval_ptr >= INTERVALS)
>                 data->interval_ptr = 0;
>  }
> Index: linux-pm/drivers/cpuidle/governors/teo.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> +++ linux-pm/drivers/cpuidle/governors/teo.c
> @@ -104,7 +104,7 @@ struct teo_cpu {
>         u64 sleep_length_ns;
>         struct teo_idle_state states[CPUIDLE_STATE_MAX];
>         int interval_idx;
> -       unsigned int intervals[INTERVALS];
> +       u64 intervals[INTERVALS];
>  };
>
>  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> @@ -117,9 +117,8 @@ static DEFINE_PER_CPU(struct teo_cpu, te
>  static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  {
>         struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> -       unsigned int sleep_length_us = ktime_to_us(cpu_data->sleep_length_ns);
>         int i, idx_hit = -1, idx_timer = -1;
> -       unsigned int measured_us;
> +       u64 measured_ns;
>
>         if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
>                 /*
> @@ -127,23 +126,21 @@ static void teo_update(struct cpuidle_dr
>                  * enough to the closest timer event expected at the idle state
>                  * selection time to be discarded.
>                  */
> -               measured_us = UINT_MAX;
> +               measured_ns = U64_MAX;
>         } else {
> -               unsigned int lat;
> +               u64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
>
> -               lat = drv->states[dev->last_state_idx].exit_latency;
> -
> -               measured_us = ktime_to_us(cpu_data->time_span_ns);
> +               measured_ns = cpu_data->time_span_ns;
>                 /*
>                  * The delay between the wakeup and the first instruction
>                  * executed by the CPU is not likely to be worst-case every
>                  * time, so take 1/2 of the exit latency as a very rough
>                  * approximation of the average of it.
>                  */
> -               if (measured_us >= lat)
> -                       measured_us -= lat / 2;
> +               if (measured_ns >= lat_ns)
> +                       measured_ns -= lat_ns / 2;
>                 else
> -                       measured_us /= 2;
> +                       measured_ns /= 2;
>         }
>
>         /*
> @@ -155,9 +152,9 @@ static void teo_update(struct cpuidle_dr
>
>                 cpu_data->states[i].early_hits -= early_hits >> DECAY_SHIFT;
>
> -               if (drv->states[i].target_residency <= sleep_length_us) {
> +               if (drv->states[i].target_residency_ns <= cpu_data->sleep_length_ns) {
>                         idx_timer = i;
> -                       if (drv->states[i].target_residency <= measured_us)
> +                       if (drv->states[i].target_residency_ns <= measured_ns)
>                                 idx_hit = i;
>                 }
>         }
> @@ -193,7 +190,7 @@ static void teo_update(struct cpuidle_dr
>          * Save idle duration values corresponding to non-timer wakeups for
>          * pattern detection.
>          */
> -       cpu_data->intervals[cpu_data->interval_idx++] = measured_us;
> +       cpu_data->intervals[cpu_data->interval_idx++] = measured_ns;
>         if (cpu_data->interval_idx > INTERVALS)
>                 cpu_data->interval_idx = 0;
>  }
> @@ -203,11 +200,11 @@ static void teo_update(struct cpuidle_dr
>   * @drv: cpuidle driver containing state data.
>   * @dev: Target CPU.
>   * @state_idx: Index of the capping idle state.
> - * @duration_us: Idle duration value to match.
> + * @duration_ns: Idle duration value to match.
>   */
>  static int teo_find_shallower_state(struct cpuidle_driver *drv,
>                                     struct cpuidle_device *dev, int state_idx,
> -                                   unsigned int duration_us)
> +                                   u64 duration_ns)
>  {
>         int i;
>
> @@ -216,7 +213,7 @@ static int teo_find_shallower_state(stru
>                         continue;
>
>                 state_idx = i;
> -               if (drv->states[i].target_residency <= duration_us)
> +               if (drv->states[i].target_residency_ns <= duration_ns)
>                         break;
>         }
>         return state_idx;
> @@ -232,8 +229,9 @@ static int teo_select(struct cpuidle_dri
>                       bool *stop_tick)
>  {
>         struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> -       int latency_req = cpuidle_governor_latency_req(dev->cpu);
> -       unsigned int duration_us, hits, misses, early_hits;
> +       s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
> +       u64 duration_ns;
> +       unsigned int hits, misses, early_hits;
>         int max_early_idx, constraint_idx, idx, i;
>         ktime_t delta_tick;
>
> @@ -244,8 +242,8 @@ static int teo_select(struct cpuidle_dri
>
>         cpu_data->time_span_ns = local_clock();
>
> -       cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
> -       duration_us = ktime_to_us(cpu_data->sleep_length_ns);
> +       duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> +       cpu_data->sleep_length_ns = duration_ns;
>
>         hits = 0;
>         misses = 0;
> @@ -262,7 +260,7 @@ static int teo_select(struct cpuidle_dri
>                          * Ignore disabled states with target residencies beyond
>                          * the anticipated idle duration.
>                          */
> -                       if (s->target_residency > duration_us)
> +                       if (s->target_residency_ns > duration_ns)
>                                 continue;
>
>                         /*
> @@ -301,7 +299,7 @@ static int teo_select(struct cpuidle_dri
>                          * shallow for that role.
>                          */
>                         if (!(tick_nohz_tick_stopped() &&
> -                             drv->states[idx].target_residency < TICK_USEC)) {
> +                             drv->states[idx].target_residency_ns < TICK_NSEC)) {
>                                 early_hits = cpu_data->states[i].early_hits;
>                                 max_early_idx = idx;
>                         }
> @@ -315,10 +313,10 @@ static int teo_select(struct cpuidle_dri
>                         misses = cpu_data->states[i].misses;
>                 }
>
> -               if (s->target_residency > duration_us)
> +               if (s->target_residency_ns > duration_ns)
>                         break;
>
> -               if (s->exit_latency > latency_req && constraint_idx > i)
> +               if (s->exit_latency_ns > latency_req && constraint_idx > i)
>                         constraint_idx = i;
>
>                 idx = i;
> @@ -327,7 +325,7 @@ static int teo_select(struct cpuidle_dri
>
>                 if (early_hits < cpu_data->states[i].early_hits &&
>                     !(tick_nohz_tick_stopped() &&
> -                     drv->states[i].target_residency < TICK_USEC)) {
> +                     drv->states[i].target_residency_ns < TICK_NSEC)) {
>                         early_hits = cpu_data->states[i].early_hits;
>                         max_early_idx = i;
>                 }
> @@ -343,7 +341,7 @@ static int teo_select(struct cpuidle_dri
>          */
>         if (hits <= misses && max_early_idx >= 0) {
>                 idx = max_early_idx;
> -               duration_us = drv->states[idx].target_residency;
> +               duration_ns = drv->states[idx].target_residency_ns;
>         }
>
>         /*
> @@ -364,9 +362,9 @@ static int teo_select(struct cpuidle_dri
>                  * the current expected idle duration value.
>                  */
>                 for (i = 0; i < INTERVALS; i++) {
> -                       unsigned int val = cpu_data->intervals[i];
> +                       u64 val = cpu_data->intervals[i];
>
> -                       if (val >= duration_us)
> +                       if (val >= duration_ns)
>                                 continue;
>
>                         count++;
> @@ -378,17 +376,17 @@ static int teo_select(struct cpuidle_dri
>                  * values are in the interesting range.
>                  */
>                 if (count > INTERVALS / 2) {
> -                       unsigned int avg_us = div64_u64(sum, count);
> +                       u64 avg_ns = div64_u64(sum, count);
>
>                         /*
>                          * Avoid spending too much time in an idle state that
>                          * would be too shallow.
>                          */
> -                       if (!(tick_nohz_tick_stopped() && avg_us < TICK_USEC)) {
> -                               duration_us = avg_us;
> -                               if (drv->states[idx].target_residency > avg_us)
> +                       if (!(tick_nohz_tick_stopped() && avg_ns < TICK_NSEC)) {
> +                               duration_ns = avg_ns;
> +                               if (drv->states[idx].target_residency_ns > avg_ns)
>                                         idx = teo_find_shallower_state(drv, dev,
> -                                                                      idx, avg_us);
> +                                                                      idx, avg_ns);
>                         }
>                 }
>         }
> @@ -398,9 +396,7 @@ static int teo_select(struct cpuidle_dri
>          * expected idle duration is shorter than the tick period length.
>          */
>         if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> -           duration_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
> -               unsigned int delta_tick_us = ktime_to_us(delta_tick);
> -
> +           duration_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
>                 *stop_tick = false;
>
>                 /*
> @@ -409,8 +405,8 @@ static int teo_select(struct cpuidle_dri
>                  * till the closest timer including the tick, try to correct
>                  * that.
>                  */
> -               if (idx > 0 && drv->states[idx].target_residency > delta_tick_us)
> -                       idx = teo_find_shallower_state(drv, dev, idx, delta_tick_us);
> +               if (idx > 0 && drv->states[idx].target_residency_ns > delta_tick)
> +                       idx = teo_find_shallower_state(drv, dev, idx, delta_tick);
>         }
>
>         return idx;
> @@ -454,7 +450,7 @@ static int teo_enable_device(struct cpui
>         memset(cpu_data, 0, sizeof(*cpu_data));
>
>         for (i = 0; i < INTERVALS; i++)
> -               cpu_data->intervals[i] = UINT_MAX;
> +               cpu_data->intervals[i] = U64_MAX;
>
>         return 0;
>  }
> Index: linux-pm/drivers/cpuidle/governors/haltpoll.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/haltpoll.c
> +++ linux-pm/drivers/cpuidle/governors/haltpoll.c
> @@ -49,7 +49,7 @@ static int haltpoll_select(struct cpuidl
>                            struct cpuidle_device *dev,
>                            bool *stop_tick)
>  {
> -       int latency_req = cpuidle_governor_latency_req(dev->cpu);
> +       s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
>
>         if (!drv->state_count || latency_req == 0) {
>                 *stop_tick = false;
> @@ -75,10 +75,9 @@ static int haltpoll_select(struct cpuidl
>         return 0;
>  }
>
> -static void adjust_poll_limit(struct cpuidle_device *dev, unsigned int block_us)
> +static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>  {
>         unsigned int val;
> -       u64 block_ns = block_us*NSEC_PER_USEC;
>
>         /* Grow cpu_halt_poll_us if
>          * cpu_halt_poll_us < block_ns < guest_halt_poll_us
> @@ -115,7 +114,7 @@ static void haltpoll_reflect(struct cpui
>         dev->last_state_idx = index;
>
>         if (index != 0)
> -               adjust_poll_limit(dev, dev->last_residency);
> +               adjust_poll_limit(dev, dev->last_residency_ns);
>  }
>
>  /**
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -104,7 +104,7 @@ static int call_cpuidle(struct cpuidle_d
>          * update no idle residency and return.
>          */
>         if (current_clr_polling_and_test()) {
> -               dev->last_residency = 0;
> +               dev->last_residency_ns = 0;
>                 local_irq_enable();
>                 return -EBUSY;
>         }
>
>
>
