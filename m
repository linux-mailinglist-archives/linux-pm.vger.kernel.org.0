Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDBFE7C4C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 23:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfJ1W0n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 18:26:43 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42386 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1W0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 18:26:40 -0400
Received: by mail-vs1-f65.google.com with SMTP id a143so6626184vsd.9
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 15:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+MNzgj2iEx0H0t+szsEnklppy3bGeslZUw6smpX9Jo=;
        b=HJOmAlie9b50Lm3WG1YnsV0rs2326f4Oex3+hqxn0T5wGape1k7vm3OISmfADnc9jR
         Y1DemMU/JntIkkF39zQVvktFEDocJO2Gg98htp9EjhfNzVWPqtuIRWp5Q0U497IdDstt
         Z/usgjaqAh60GXEoImXg0ksFjdsYvuRrltuxF482c3+zy37AJ9cUylh/XowiXxIYwPLe
         qnxy/J6q1EAUbbxETDPBeOgupJucvs/hRs/ofCGzJhzilsGTPC+rnpZsE+kpV2vbyD1o
         agZHXeUnKUdVqzaE+KZ1NxBy+SarDSTDfx3IpDBD39vjWL9hydpB9ifD559y8oSqZ3fu
         BYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+MNzgj2iEx0H0t+szsEnklppy3bGeslZUw6smpX9Jo=;
        b=et9KnnU/FyXFu6ctHVbKIctzRpwklS4SGLwK2UhEzU457CH8LxulMqrwxl9PMKx+n4
         yTEKbK/Z+W7xSWbyyXkruY8tR7LOCbkgbbA3tJVNVn69mEE93EgSu36tGmQtbEaT0aw7
         M0r2xoLdQlezDP248W0as4rFAVI2UAQ7DGqZJ/IEzXqThLPJYDJA6Y2NXMqe6KNrhfKd
         1qd07hdoApI81YEy8p3Bbz095QwEhY+7sEOFU1r6hV6f/I0imn2BBpUd7LbbfnvdnILC
         JdY3Emc8BtZEaALreq3Q2vUVM5LuqiM8M4abcTxBWX44Fn6qOu0i6rd2yVYZd6n/zkj8
         o/ow==
X-Gm-Message-State: APjAAAXEWOwEk6xOgbn6V+W9cpwzj6TfCTBTsKdSNPCg3o7FPzQpq4br
        TSIunwTSEcoMJ61ilFKOMZg/IO929iZz7YV90kJAUQ==
X-Google-Smtp-Source: APXvYqzcBVjx3JDXSzEykB+cM2WmaDt1uX8un+rod4VVVb3rK8ezHJSXpxGI1Fad9hre7H++4F7r4V3xQ7XhGwVDpZ0=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr4010400vsa.34.1572301597181;
 Mon, 28 Oct 2019 15:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191028143419.16236-1-daniel.lezcano@linaro.org>
In-Reply-To: <20191028143419.16236-1-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Oct 2019 23:26:00 +0100
Message-ID: <CAPDyKFqY0pwuD7U-YbdtwF8HqmZ2TVo3U=wbs50uXpWzTf-4NA@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] cpuidle: play_idle: Make play_idle more flexible
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 28 Oct 2019 at 15:34, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The play_idle function has two users, the intel powerclamp and the
> idle_injection.
>
> The idle injection cooling device uses the function via the
> idle_injection powercap's APIs. Unfortunately, play_idle is currently
> limited by the idle state depth: by default the deepest idle state is
> selected. On the ARM[64] platforms, most of the time it is the cluster
> idle state, the exit latency and the residency can be very high. That
> reduces the scope of the idle injection usage because the impact on
> the performances can be very significant.
>
> If the idle injection cycles can be done with a shallow state like a
> retention state, the cooling effect would eventually give similar
> results than the cpufreq cooling device.
>
> In order to prepare the function to receive an idle state parameter,
> let's replace the 'use_deepest_state' boolean field with 'use_state'
> and use this value to enter the specific idle state.
>
> The current code keeps the default behavior which is go to the deepest
> idle state.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>

This looks good to me! Just a minor nitpick, see more below. If you
don't like my suggestions, I am fine as is. Therefore:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>   V5:
>    - Fix s2idle default idle state value:
>      https://lkml.org/lkml/2019/10/15/522
> ---
>  drivers/cpuidle/cpuidle.c | 21 +++++++++++----------
>  include/linux/cpuidle.h   | 13 ++++++-------
>  kernel/sched/idle.c       | 11 +++++++----
>  3 files changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0895b988fa92..f8b54f277589 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -99,31 +99,31 @@ static int find_deepest_state(struct cpuidle_driver *drv,
>  }
>
>  /**
> - * cpuidle_use_deepest_state - Set/clear governor override flag.
> - * @enable: New value of the flag.
> + * cpuidle_use_state - Force the cpuidle framework to enter an idle state.
> + * @state: An integer for an idle state
>   *
> - * Set/unset the current CPU to use the deepest idle state (override governors
> - * going forward if set).
> + * Specify an idle state the cpuidle framework must step in and bypass
> + * the idle state selection process.
>   */
> -void cpuidle_use_deepest_state(bool enable)
> +void cpuidle_use_state(int state)

Rather than naming the in-param to "state", perhaps "state_idx", would
be more self-explanatory?

That kind of goes for all kind of parameter/function naming in this series.

>  {
>         struct cpuidle_device *dev;
>
>         preempt_disable();
>         dev = cpuidle_get_device();
>         if (dev)
> -               dev->use_deepest_state = enable;
> +               dev->use_state = state;

So, likewise here:

Perhaps this may be more self-explanatory.

"dev->use_state_idx = stated_idx"


>         preempt_enable();
>  }
>
>  /**
>   * cpuidle_find_deepest_state - Find the deepest available idle state.
> - * @drv: cpuidle driver for the given CPU.
> - * @dev: cpuidle device for the given CPU.
>   */
> -int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> -                              struct cpuidle_device *dev)
> +int cpuidle_find_deepest_state(void)
>  {
> +       struct cpuidle_device *dev = cpuidle_get_device();
> +       struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> +
>         return find_deepest_state(drv, dev, UINT_MAX, 0, false);
>  }
>
> @@ -554,6 +554,7 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
>  static void __cpuidle_device_init(struct cpuidle_device *dev)
>  {
>         memset(dev->states_usage, 0, sizeof(dev->states_usage));
> +       dev->use_state = CPUIDLE_STATE_NOUSE;
>         dev->last_residency = 0;
>         dev->next_hrtimer = 0;
>  }
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 4b6b5bea8f79..b5602ab28601 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -15,6 +15,7 @@
>  #include <linux/list.h>
>  #include <linux/hrtimer.h>
>
> +#define CPUIDLE_STATE_NOUSE    -1
>  #define CPUIDLE_STATE_MAX      10
>  #define CPUIDLE_NAME_LEN       16
>  #define CPUIDLE_DESC_LEN       32
> @@ -80,11 +81,11 @@ struct cpuidle_driver_kobj;
>  struct cpuidle_device {
>         unsigned int            registered:1;
>         unsigned int            enabled:1;
> -       unsigned int            use_deepest_state:1;
>         unsigned int            poll_time_limit:1;
>         unsigned int            cpu;
>         ktime_t                 next_hrtimer;
>
> +       int                     use_state;
>         int                     last_state_idx;
>         int                     last_residency;
>         u64                     poll_limit_ns;
> @@ -203,19 +204,17 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
>  #endif
>
>  #ifdef CONFIG_CPU_IDLE
> -extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> -                                     struct cpuidle_device *dev);
> +extern int cpuidle_find_deepest_state(void);
>  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>                                 struct cpuidle_device *dev);
> -extern void cpuidle_use_deepest_state(bool enable);
> +extern void cpuidle_use_state(int state);
>  #else
> -static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> -                                            struct cpuidle_device *dev)
> +static inline int cpuidle_find_deepest_state(void)
>  {return -ENODEV; }
>  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>                                        struct cpuidle_device *dev)
>  {return -ENODEV; }
> -static inline void cpuidle_use_deepest_state(bool enable)
> +static inline void cpuidle_use_state(int state)
>  {
>  }
>  #endif
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 8dad5aa600ea..fc7f5216b579 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -165,7 +165,8 @@ static void cpuidle_idle_call(void)
>          * until a proper wakeup interrupt happens.
>          */
>
> -       if (idle_should_enter_s2idle() || dev->use_deepest_state) {
> +       if (idle_should_enter_s2idle() ||
> +           dev->use_state != CPUIDLE_STATE_NOUSE) {
>                 if (idle_should_enter_s2idle()) {
>                         rcu_idle_enter();
>
> @@ -176,12 +177,14 @@ static void cpuidle_idle_call(void)
>                         }
>
>                         rcu_idle_exit();
> +                       next_state = cpuidle_find_deepest_state();
> +               } else {
> +                       next_state = dev->use_state;
>                 }
>
>                 tick_nohz_idle_stop_tick();
>                 rcu_idle_enter();
>
> -               next_state = cpuidle_find_deepest_state(drv, dev);
>                 call_cpuidle(drv, dev, next_state);
>         } else {
>                 bool stop_tick = true;
> @@ -328,7 +331,7 @@ void play_idle(unsigned long duration_us)
>         rcu_sleep_check();
>         preempt_disable();
>         current->flags |= PF_IDLE;
> -       cpuidle_use_deepest_state(true);
> +       cpuidle_use_state(cpuidle_find_deepest_state());
>
>         it.done = 0;
>         hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> @@ -339,7 +342,7 @@ void play_idle(unsigned long duration_us)
>         while (!READ_ONCE(it.done))
>                 do_idle();
>
> -       cpuidle_use_deepest_state(false);
> +       cpuidle_use_state(CPUIDLE_STATE_NOUSE);
>         current->flags &= ~PF_IDLE;
>
>         preempt_fold_need_resched();
> --
> 2.17.1
>
