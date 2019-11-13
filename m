Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C9FBB30
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 23:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfKMWAA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 17:00:00 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43584 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfKMWAA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 17:00:00 -0500
Received: by mail-oi1-f193.google.com with SMTP id l20so3274441oie.10;
        Wed, 13 Nov 2019 13:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVTAbnfUlPnBx7RdvKTWW6/dcTysSXTAMT9PhFN67xc=;
        b=F+duNKpfPYya/+pUyRdcCaTgSQkzXy0dkxLS6ynwG6yjCXu9bJ0+TKAxOi+S10eVZc
         Lo3PAwjanvtnAcTq/fOZvDDUcxIKrmF5/e0adAxFHGzJy/8K16AvzBltamVgQUW7Hfon
         HIMTcf/FO4vYm8fIQNxCUrk1sRRKAJO7nkXrKIZ2YGk0DQi5DQXoX1DZonvJpm9NTL5w
         JGzKABr03iGLSHLUk1paS2V7gdQ+6aVEQPu0GtdcB/I+uC5RpZjQqJG44TGRNgm7jVef
         uaKp4LTAoXDg1b+BoOl7E1wkHBL1P3OjMu1oGWCHtQatKiQxqxLrxGecNS4pjokxwe4N
         dDwA==
X-Gm-Message-State: APjAAAV8rJyJ/RmpXFmcc1U69gBT5EZIbSzS+n8jS8GUdSLPgb3+zME+
        HIQqNu4lM/pAnRbYuMuh6vz1gKpt6Ok1PAIjTAI=
X-Google-Smtp-Source: APXvYqzFTZrgpuyN0PvxPJ3n9WHGSw+9M7YWstNbP6CU6LxPlGspXQFkzp1E4iSlXIUr2JgoHxJ0twMdQooFIATVRrU=
X-Received: by 2002:aca:c753:: with SMTP id x80mr673314oif.115.1573682398432;
 Wed, 13 Nov 2019 13:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20191113185419.13305-1-daniel.lezcano@linaro.org>
In-Reply-To: <20191113185419.13305-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Nov 2019 22:59:47 +0100
Message-ID: <CAJZ5v0hs5nJmWLY2Ox_0hg3tVipoJRS3uhQr=Wv5MPgGLyP+Ow@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] cpuidle: Replace use_deepest_state flag by use_latency
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 13, 2019 at 7:54 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> We want to specify a latency constraint when choosing an idle state at
> play_idle time. Instead of duplicating the information in the
> structure or propagate the latency in the call stack, change the
> use_deepest_state by use_latency to introduce this constraint.
>
> A zero latency constraint means "do not use the deepest idle state
> path" as the 'use_deepest_state' boolean was used in the
> cpuidle_idle_call.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c | 6 +++---
>  include/linux/cpuidle.h   | 6 +++---
>  kernel/sched/idle.c       | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 44ae39f2b47a..f68a6c9e8482 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -100,19 +100,19 @@ static int find_deepest_state(struct cpuidle_driver *drv,
>
>  /**
>   * cpuidle_use_deepest_state - Set/clear governor override flag.
> - * @enable: New value of the flag.
> + * @latency: A latency constraint

I would call this latency_limit.

Maybe even latency_limit_ns (or us, whatever is more suitable), to
make it clear which unit of time is used here.

>   *
>   * Set/unset the current CPU to use the deepest idle state (override governors
>   * going forward if set).

I would update the comment too, something like:

"Set/unset the current CPU to use the deepest idle state with the exit
latency within @latency_limit"

>   */
> -void cpuidle_use_deepest_state(bool enable)
> +void cpuidle_use_latency(unsigned int latency)

I wouldn't change the name of the function (because why really?).

>  {
>         struct cpuidle_device *dev;
>
>         preempt_disable();
>         dev = cpuidle_get_device();
>         if (dev)
> -               dev->use_deepest_state = enable;
> +               dev->use_latency = latency;
>         preempt_enable();
>  }
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index d23a3b1ddcf6..32018704f4ea 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -83,8 +83,8 @@ struct cpuidle_driver_kobj;
>  struct cpuidle_device {
>         unsigned int            registered:1;
>         unsigned int            enabled:1;
> -       unsigned int            use_deepest_state:1;
>         unsigned int            poll_time_limit:1;
> +       unsigned int            use_latency;

And maybe call this forced_idle_latency_limit or similar?

The idea being that when it is set, idle is forced (i.e. no
governors), but there is a latency limit for the state to use.

>         unsigned int            cpu;
>         ktime_t                 next_hrtimer;
>
> @@ -210,7 +210,7 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                       struct cpuidle_device *dev);
>  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>                                 struct cpuidle_device *dev);
> -extern void cpuidle_use_deepest_state(bool enable);
> +extern void cpuidle_use_latency(unsigned int latency);
>  #else
>  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                              struct cpuidle_device *dev)
> @@ -218,7 +218,7 @@ static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>                                        struct cpuidle_device *dev)
>  {return -ENODEV; }
> -static inline void cpuidle_use_deepest_state(bool enable)
> +static inline void cpuidle_use_latency(unsigned int latency)
>  {
>  }
>  #endif
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 8dad5aa600ea..00e064d3dfe1 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -165,7 +165,7 @@ static void cpuidle_idle_call(void)
>          * until a proper wakeup interrupt happens.
>          */
>
> -       if (idle_should_enter_s2idle() || dev->use_deepest_state) {
> +       if (idle_should_enter_s2idle() || dev->use_latency) {
>                 if (idle_should_enter_s2idle()) {
>                         rcu_idle_enter();
>
> @@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
>         rcu_sleep_check();
>         preempt_disable();
>         current->flags |= PF_IDLE;
> -       cpuidle_use_deepest_state(true);
> +       cpuidle_use_latency(1);
>
>         it.done = 0;
>         hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> @@ -339,7 +339,7 @@ void play_idle(unsigned long duration_us)
>         while (!READ_ONCE(it.done))
>                 do_idle();
>
> -       cpuidle_use_deepest_state(false);
> +       cpuidle_use_latency(0);
>         current->flags &= ~PF_IDLE;
>
>         preempt_fold_need_resched();
> --
