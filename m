Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 757B4FD0DF
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 23:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKNWSF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 17:18:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46427 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfKNWSE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 17:18:04 -0500
Received: by mail-oi1-f193.google.com with SMTP id n14so6778504oie.13;
        Thu, 14 Nov 2019 14:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvaIXmyjkpLo8dw69tP+rWKaaoE3Lzk6tMGk7heZwRg=;
        b=gQauNC0wiLdiA381knU7UBewKdSum8muOypnCmCbH5qsiUoCpNfk4jEFGRUKvs+bHg
         sFSeMasrVcOaoXunP1thtomJ4fyqEGS47KngoEjz/OmBsCEs/cWgrEMjy16gd5wOqQog
         ikmlMN4190x1E6O624QO8uTGd8mYEWJHV8D50TKrCxrWg2fH/SY84La86/B74akry6nZ
         cFrVNfuKZiWeA3xK7bd7VlBZeqgttk5oZAgUkNIsbzg6bllOxJY8MywlGeUkTwd8JqQ8
         142UVY/Fyd1uhhcSdM2+A+epATLkf8K9qrtAxRwPLOV0wS0dOzunEZgnf/9vlmsW1+Oo
         nOvQ==
X-Gm-Message-State: APjAAAVWQPXEpXEWzPVuRGKgasX11X7vTSvKJaBy5YeRFsv7GdAtCfLN
        CXX+14pX6ut6nKAnnDuodCOJtEBqHUiB+2NCnPM=
X-Google-Smtp-Source: APXvYqyN/BifFeHZOmj/U1xV2A+uIjeMTaXFtyUp9OTDS9tnC8cvy7HwaNh2lJCTtzTLS9KfQVPhQquagUJQrMK0qrc=
X-Received: by 2002:aca:c753:: with SMTP id x80mr5127204oif.115.1573769883243;
 Thu, 14 Nov 2019 14:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20191114204914.21206-1-daniel.lezcano@linaro.org>
In-Reply-To: <20191114204914.21206-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 23:17:52 +0100
Message-ID: <CAJZ5v0jE=wODwwMTPx6J8+A60asR5ZAcX2ezbYo8-1-BU3ru5w@mail.gmail.com>
Subject: Re: [PATCH V1 1/3] cpuidle: Replace use_deepest_state flag by forced_idle_latency_limit_ns
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

On Thu, Nov 14, 2019 at 9:49 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> We want to specify a latency constraint when choosing an idle state at
> play_idle time. Instead of duplicating the information in the
> structure or propagate the latency in the call stack, change the
> use_deepest_state by forced_latency_limit_ns to introduce this
> constraint. The idea being that when it is set, idle is forced
> (i.e. no governors), but there is a latency limit for the state to
> use.
>
> A zero latency constraint means "do not use the deepest idle state
> path" as the 'use_deepest_state' boolean was used in the
> cpuidle_idle_call.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c | 10 +++++-----
>  include/linux/cpuidle.h   |  6 +++---
>  kernel/sched/idle.c       |  6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 44ae39f2b47a..62226fadc02d 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -100,19 +100,19 @@ static int find_deepest_state(struct cpuidle_driver *drv,
>
>  /**
>   * cpuidle_use_deepest_state - Set/clear governor override flag.
> - * @enable: New value of the flag.
> + * @latency_limit_ns: A latency limit constraint
>   *
> - * Set/unset the current CPU to use the deepest idle state (override governors
> - * going forward if set).
> + * Set/unset the current CPU to use the deepest idle state with the exit
> + * latency within @latency_limit_ns
>   */
> -void cpuidle_use_deepest_state(bool enable)
> +void cpuidle_use_deepest_state(u64 latency_limit_ns)
>  {
>         struct cpuidle_device *dev;
>
>         preempt_disable();
>         dev = cpuidle_get_device();
>         if (dev)
> -               dev->use_deepest_state = enable;
> +               dev->forced_idle_latency_limit_ns = latency_limit_ns;
>         preempt_enable();
>  }
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index d23a3b1ddcf6..1f3f4dd01e48 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -83,7 +83,6 @@ struct cpuidle_driver_kobj;
>  struct cpuidle_device {
>         unsigned int            registered:1;
>         unsigned int            enabled:1;
> -       unsigned int            use_deepest_state:1;
>         unsigned int            poll_time_limit:1;
>         unsigned int            cpu;
>         ktime_t                 next_hrtimer;
> @@ -91,6 +90,7 @@ struct cpuidle_device {
>         int                     last_state_idx;
>         int                     last_residency;
>         u64                     poll_limit_ns;
> +       u64                     forced_idle_latency_limit_ns;
>         struct cpuidle_state_usage      states_usage[CPUIDLE_STATE_MAX];
>         struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
>         struct cpuidle_driver_kobj *kobj_driver;
> @@ -210,7 +210,7 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                       struct cpuidle_device *dev);
>  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>                                 struct cpuidle_device *dev);
> -extern void cpuidle_use_deepest_state(bool enable);
> +extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
>  #else
>  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                              struct cpuidle_device *dev)
> @@ -218,7 +218,7 @@ static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>                                        struct cpuidle_device *dev)
>  {return -ENODEV; }
> -static inline void cpuidle_use_deepest_state(bool enable)
> +static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
>  {
>  }
>  #endif
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 8dad5aa600ea..d4681b3d7074 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -165,7 +165,7 @@ static void cpuidle_idle_call(void)
>          * until a proper wakeup interrupt happens.
>          */
>
> -       if (idle_should_enter_s2idle() || dev->use_deepest_state) {
> +       if (idle_should_enter_s2idle() || dev->forced_idle_latency_limit_ns) {
>                 if (idle_should_enter_s2idle()) {
>                         rcu_idle_enter();
>
> @@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
>         rcu_sleep_check();
>         preempt_disable();
>         current->flags |= PF_IDLE;
> -       cpuidle_use_deepest_state(true);
> +       cpuidle_use_deepest_state(1);

This is kind of artificial without the changes in the second patch, so
I would fold the [2/3] into this one.

Apart from that the patches look reasonable to me.

>
>         it.done = 0;
>         hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> @@ -339,7 +339,7 @@ void play_idle(unsigned long duration_us)
>         while (!READ_ONCE(it.done))
>                 do_idle();
>
> -       cpuidle_use_deepest_state(false);
> +       cpuidle_use_deepest_state(0);
>         current->flags &= ~PF_IDLE;
>
>         preempt_fold_need_resched();
> --
