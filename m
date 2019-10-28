Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E1E7C4D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 23:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfJ1W0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 18:26:44 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41727 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbfJ1W0o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 18:26:44 -0400
Received: by mail-vs1-f67.google.com with SMTP id i22so1248859vsl.8
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Omz9xLOkdtGaoux0CR3i6tA3umZrfZXKt0cAz2+yPFU=;
        b=eGrodDAa9tFWKZtpKQmEaVqwKqGsf45nSQESIHP1XDDutX+ImXb0WuBpEUg1VY2k8m
         ezG4/JT3SGYQVMYgwHhwjN43dQM9IpNDrH3tVZnz0XXv0BaDMtKNu0R7lCpazs28T8ht
         P84XyOYK8KFft5MADgbrQE62oS4HGatruZPG+4LBb4rh8tn2szfcSZpGc8daZGIL/x0H
         5AP7se9n/Tzh/iJoYpFhCQxV1wU1XpNZzA5Ncoib+/7VROvpmqnHX+bIYGsU0ZCSceXM
         w8ZFuSCsEdDxSIgRWGVoFZdDepWilrkAt9OTh63Qs9hRsNdRFZONi/HityzHDejNwhPV
         sacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Omz9xLOkdtGaoux0CR3i6tA3umZrfZXKt0cAz2+yPFU=;
        b=GOHoobQBsbcbyJ+mb9HDtPifQp3MTTAGeD0i0ALN8ZZWQotqTNEmz/HlLziQ/KSqkI
         tzVZTw/hU5YDvMYw280Y/Ps/hB/cpYvBer30Tsc0NnCcAkC7nvMkOhXetJN1mGDS8Nzm
         IlBvFHPVnu3q7GDm2kKv2N87d7JRPL/C7A0z29s7Hq6UOI8r6aiUzS2CcnqOE46U+cn0
         3Rq9b/MYIVB9x7wjSZ9joy6zkwY1R53nDKiMkkAYupb36Aw/BpMiqiy87Tl4s8XIpmHS
         dG1PAHuurGtNFZjztLtjLx7k0kqBpEA1ynNgQVtzubO9nqdh+hhGvKNbW0A5RYw3mgoX
         V1Dw==
X-Gm-Message-State: APjAAAUVXw4JYKOcIC/Q/SGRLd34pQMatwwSrVETl/fGtjMiOkUs+ETo
        DKauwNNN9DfexxBzSqPGBv+O9G02yiqf5FMlvy5p1Q==
X-Google-Smtp-Source: APXvYqxJlTZH5aa8zYQWk7AaVuFRpPDX0Sg2n0FpitwMhMKqfCGE6iZbdS4COv2fc3e0oUT1OPFb6JtxbK3bjzvvXp0=
X-Received: by 2002:a67:ead4:: with SMTP id s20mr10336421vso.165.1572301602719;
 Mon, 28 Oct 2019 15:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191028143419.16236-1-daniel.lezcano@linaro.org> <20191028143419.16236-2-daniel.lezcano@linaro.org>
In-Reply-To: <20191028143419.16236-2-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Oct 2019 23:26:05 +0100
Message-ID: <CAPDyKFr2YrojMcFBenPgFK62tutTQ+Z8196cKtoC=AJq=SNPOg@mail.gmail.com>
Subject: Re: [PATCH V5 2/3] cpuidle: play_idle: Specify play_idle with an idle state
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
> Currently, the play_idle function does not allow to tell which idle
> state we want to go. Improve this by passing the idle state as
> parameter to the function.
>
> Export cpuidle_find_deepest_state() symbol as it is used from the
> intel_powerclamp driver as a module.
>
> There is no functional changes, the cpuidle state is the deepest one.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe



> ---
>   V4:
>    - Add EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state) for the
>      intel_powerclamp driver when this one is compiled as a module
>   V3:
>    - Add missing cpuidle.h header
> ---
>  drivers/cpuidle/cpuidle.c                | 1 +
>  drivers/powercap/idle_inject.c           | 4 +++-
>  drivers/thermal/intel/intel_powerclamp.c | 4 +++-
>  include/linux/cpu.h                      | 2 +-
>  kernel/sched/idle.c                      | 4 ++--
>  5 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index f8b54f277589..94804e532b9a 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -126,6 +126,7 @@ int cpuidle_find_deepest_state(void)
>
>         return find_deepest_state(drv, dev, UINT_MAX, 0, false);
>  }
> +EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state);
>
>  #ifdef CONFIG_SUSPEND
>  static void enter_s2idle_proper(struct cpuidle_driver *drv,
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index cd1270614cc6..233c878cbf46 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -38,6 +38,7 @@
>  #define pr_fmt(fmt) "ii_dev: " fmt
>
>  #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>  #include <linux/hrtimer.h>
>  #include <linux/kthread.h>
>  #include <linux/sched.h>
> @@ -138,7 +139,8 @@ static void idle_inject_fn(unsigned int cpu)
>          */
>         iit->should_run = 0;
>
> -       play_idle(READ_ONCE(ii_dev->idle_duration_us));
> +       play_idle(READ_ONCE(ii_dev->idle_duration_us),
> +                 cpuidle_find_deepest_state());
>  }
>
>  /**
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 53216dcbe173..b55786c169ae 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -29,6 +29,7 @@
>  #include <linux/delay.h>
>  #include <linux/kthread.h>
>  #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>  #include <linux/thermal.h>
>  #include <linux/slab.h>
>  #include <linux/tick.h>
> @@ -430,7 +431,8 @@ static void clamp_idle_injection_func(struct kthread_work *work)
>         if (should_skip)
>                 goto balance;
>
> -       play_idle(jiffies_to_usecs(w_data->duration_jiffies));
> +       play_idle(jiffies_to_usecs(w_data->duration_jiffies),
> +                 cpuidle_find_deepest_state());
>
>  balance:
>         if (clamping && w_data->clamping && cpu_online(w_data->cpu))
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index d0633ebdaa9c..23478208fc55 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -179,7 +179,7 @@ void arch_cpu_idle_dead(void);
>  int cpu_report_state(int cpu);
>  int cpu_check_up_prepare(int cpu);
>  void cpu_set_state_online(int cpu);
> -void play_idle(unsigned long duration_us);
> +void play_idle(unsigned long duration_us, int state);
>
>  #ifdef CONFIG_HOTPLUG_CPU
>  bool cpu_wait_death(unsigned int cpu, int seconds);
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index fc7f5216b579..af90abe0c1b3 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -314,7 +314,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
>         return HRTIMER_NORESTART;
>  }
>
> -void play_idle(unsigned long duration_us)
> +void play_idle(unsigned long duration_us, int state)
>  {
>         struct idle_timer it;
>
> @@ -331,7 +331,7 @@ void play_idle(unsigned long duration_us)
>         rcu_sleep_check();
>         preempt_disable();
>         current->flags |= PF_IDLE;
> -       cpuidle_use_state(cpuidle_find_deepest_state());
> +       cpuidle_use_state(state);
>
>         it.done = 0;
>         hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> --
> 2.17.1
>
