Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4329BFBB62
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 23:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfKMWIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 17:08:42 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45815 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfKMWIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 17:08:42 -0500
Received: by mail-oi1-f194.google.com with SMTP id 14so3294352oir.12;
        Wed, 13 Nov 2019 14:08:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfLfWzCvWjnUrBVWFkt46gehHaJKbKq1rxN/hjJdf4I=;
        b=aKVFPOT+Ss9nXOSfMY3vSih2NyD1GBorgF7JsFBEeOGa8NkXpIx+NEd6ek5CaxT/o/
         dxIaLpuwQGZ48v4grmISVKc8N9W59aDSDFerH/KW3tztUQqyPUhLWocfgjyF/r6In8j8
         o0YJwW7tSzWMKlN4ZhMptaQmuQrs8LPNjONAqYy+id3HJkZM5WTAlK0wHSmo5carKrlI
         tkeuk4B+tG+h6QU8gMYLXL9FyyagrEo+jcgxbRNPkR1Ut0wsCmOIVMWbAicWS2f6j5XE
         DfqaguNj6MxS5yPWHrnGeLtMMAoMwgHJC6OXGoivsX48m56I3LzJe1xrIwAdTfLnS3tE
         3QuQ==
X-Gm-Message-State: APjAAAXcjsIPImJWg1tTiLSE36OrgYVu31kCYQ7aAaenrxm5f6ITAFWv
        F+sVbLvulbFqwANZq5F79xi4skaIqZ59wVo9NFc=
X-Google-Smtp-Source: APXvYqyB68Y4oQi9MF7eS/SkDk6oN8v5rDRu6919DWuCZFba7fXminPfsRrTPArVEMkjypxuDoeE2AqpMCf36blHHyE=
X-Received: by 2002:aca:530c:: with SMTP id h12mr842120oib.110.1573682920995;
 Wed, 13 Nov 2019 14:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20191113185419.13305-1-daniel.lezcano@linaro.org> <20191113185419.13305-2-daniel.lezcano@linaro.org>
In-Reply-To: <20191113185419.13305-2-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Nov 2019 23:08:30 +0100
Message-ID: <CAJZ5v0gjJFuUUaFD9g8H4WH0rx-xax_ArKmiJwarTt26_C-ACg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] sched: idle: Add a latency parameter to the
 play_idle function
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
> By default the play_idle() function leads to the deepest idle state
> selection which is not necessarily the state we are interested in when
> forcing the CPU to go to idle.
>
> Add a latency parameter to the play_idle() function, so the caller can
> use the constraint to allow a shallower state.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/idle_inject.c           | 2 +-
>  drivers/thermal/intel/intel_powerclamp.c | 2 +-
>  include/linux/cpu.h                      | 2 +-
>  kernel/sched/idle.c                      | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index cd1270614cc6..6f2bfb172e61 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -138,7 +138,7 @@ static void idle_inject_fn(unsigned int cpu)
>          */
>         iit->should_run = 0;
>
> -       play_idle(READ_ONCE(ii_dev->idle_duration_us));
> +       play_idle(READ_ONCE(ii_dev->idle_duration_us), UINT_MAX);
>  }
>
>  /**
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 53216dcbe173..dd1330d59176 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -430,7 +430,7 @@ static void clamp_idle_injection_func(struct kthread_work *work)
>         if (should_skip)
>                 goto balance;
>
> -       play_idle(jiffies_to_usecs(w_data->duration_jiffies));
> +       play_idle(jiffies_to_usecs(w_data->duration_jiffies), UINT_MAX);
>
>  balance:
>         if (clamping && w_data->clamping && cpu_online(w_data->cpu))
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index d0633ebdaa9c..241f558af17a 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -179,7 +179,7 @@ void arch_cpu_idle_dead(void);
>  int cpu_report_state(int cpu);
>  int cpu_check_up_prepare(int cpu);
>  void cpu_set_state_online(int cpu);
> -void play_idle(unsigned long duration_us);
> +void play_idle(unsigned long duration_us, unsigned int latency);
>
>  #ifdef CONFIG_HOTPLUG_CPU
>  bool cpu_wait_death(unsigned int cpu, int seconds);
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 00e064d3dfe1..56a8b9d35cb9 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -311,7 +311,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
>         return HRTIMER_NORESTART;
>  }
>
> -void play_idle(unsigned long duration_us)
> +void play_idle(unsigned long duration_us, unsigned int latency)

I'd rather rename this to something like play_idle_precise() and
redefine play_idle() as a single-argument wrapper around it.

Maybe also change the first arg to ns while at it (and keep us in play_idle())?

>  {
>         struct idle_timer it;
>
> @@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
>         rcu_sleep_check();
>         preempt_disable();
>         current->flags |= PF_IDLE;
> -       cpuidle_use_latency(1);
> +       cpuidle_use_latency(latency);
>
>         it.done = 0;
>         hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> --
> 2.17.1
>
