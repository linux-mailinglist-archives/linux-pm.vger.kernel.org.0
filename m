Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D3E2A8057
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 15:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgKEOEX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 09:04:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35792 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgKEOEX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 09:04:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id c80so1775814oib.2;
        Thu, 05 Nov 2020 06:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCz3t7gRNskWfm/udOw8gOa/VD6zVDcIDOXphY/tPco=;
        b=PT4VnyrDEYFcnjdnZ2+JRnMptuVmbTo8Of8sMuCjp53rr+6F+pwMOc8owYw6z/NaLx
         i9Z+Vo8zlQ37myH0XGYv2K1QeoFW5KgsTIVnU5kg9/ryynhUk5fjzyKwn9Ui2bkNSHv3
         rvmIrZStNJZ6TsOvz2Y2gD2XKc2+0lRLexB6YoF4pobgDw0IlGClPYgcJ69/hiKVqH9i
         scAHENmh5qDVeUIU7MZrMIFTmuPT5Wvwp1lJj8Uwogg+sB5E85Uf0yeDjyDIuYBkIJfS
         o161zWuCUtxQsgFbDsYMT7KwAOyV8IGkyayLjXbAaYnjazPpm4oEmhs+5gGlW/92o4eU
         xo7A==
X-Gm-Message-State: AOAM5300ysxh4rpoOFYNHhwvTvCAGnK+xmAipRxrTcojUVLvmcLbIfoU
        B04gB/V7M7myyXCC0TNtLcEalgX4DVW1IUbea+k=
X-Google-Smtp-Source: ABdhPJxdmeRZW4IhoL8PeRW3nHA54DDXatn8B2JQDv5YhiECeakMK9m0IYm4Kfu0Aesz5E+bd1etFcD6ZhOmXuS1Xkc=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr1646251oiw.69.1604585061876;
 Thu, 05 Nov 2020 06:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20201015144431.9979-1-daniel.lezcano@linaro.org> <20201015144431.9979-4-daniel.lezcano@linaro.org>
In-Reply-To: <20201015144431.9979-4-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Nov 2020 15:04:10 +0100
Message-ID: <CAJZ5v0i-1eZ+j_6C83qs1-q1FSw0Yx96yQyy0KQBvDxX6KF=3w@mail.gmail.com>
Subject: Re: [PATCH 4/5] cpuidle: governor: Export the needed symbols
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 15, 2020 at 4:45 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> In the next patch, the governors will be converted to modules. Export
> the symbols of the different functions used by the governors.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/governor.c | 3 +++
>  include/linux/tick.h       | 2 ++
>  kernel/sched/core.c        | 1 +
>  kernel/time/tick-sched.c   | 9 +++++++++
>  4 files changed, 15 insertions(+)
>
> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
> index 6ec27ef096f5..2791fe352f51 100644
> --- a/drivers/cpuidle/governor.c
> +++ b/drivers/cpuidle/governor.c
> @@ -120,6 +120,7 @@ void cpuidle_unregister_governor(struct cpuidle_governor *gov)
>
>         mutex_unlock(&cpuidle_lock);
>  }
> +EXPORT_SYMBOL(cpuidle_unregister_governor);
>
>  /**
>   * cpuidle_register_governor - registers a governor
> @@ -150,6 +151,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
>
>         return ret;
>  }
> +EXPORT_SYMBOL(cpuidle_register_governor);
>
>  /**
>   * cpuidle_governor_latency_req - Compute a latency constraint for CPU
> @@ -166,3 +168,4 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
>
>         return (s64)device_req * NSEC_PER_USEC;
>  }
> +EXPORT_SYMBOL(cpuidle_governor_latency_req);
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 7340613c7eff..8349ba050b9c 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -124,6 +124,7 @@ enum tick_dep_bits {
>
>  #ifdef CONFIG_NO_HZ_COMMON
>  extern bool tick_nohz_enabled;
> +extern bool tick_nohz_is_enabled(void);
>  extern bool tick_nohz_tick_stopped(void);
>  extern bool tick_nohz_tick_stopped_cpu(int cpu);
>  extern void tick_nohz_idle_stop_tick(void);
> @@ -149,6 +150,7 @@ static inline void tick_nohz_idle_stop_tick_protected(void)
>
>  #else /* !CONFIG_NO_HZ_COMMON */
>  #define tick_nohz_enabled (0)
> +static inline int tick_nohz_is_enabled(void) { return 0 };
>  static inline int tick_nohz_tick_stopped(void) { return 0; }
>  static inline int tick_nohz_tick_stopped_cpu(int cpu) { return 0; }
>  static inline void tick_nohz_idle_stop_tick(void) { }
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d95dc3f4644..ceba61bb364d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3838,6 +3838,7 @@ unsigned long nr_iowait_cpu(int cpu)
>  {
>         return atomic_read(&cpu_rq(cpu)->nr_iowait);
>  }
> +EXPORT_SYMBOL_GPL(nr_iowait_cpu);

Hmm.  See below.

>
>  /*
>   * IO-wait accounting, and how its mostly bollocks (on SMP).
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index f0199a4ba1ad..537716124d46 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -500,12 +500,19 @@ static int __init setup_tick_nohz(char *str)
>
>  __setup("nohz=", setup_tick_nohz);
>
> +bool tick_nohz_is_enabled(void)
> +{
> +       return tick_nohz_enabled;
> +}
> +EXPORT_SYMBOL_GPL(tick_nohz_is_enabled);
> +
>  bool tick_nohz_tick_stopped(void)
>  {
>         struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
>
>         return ts->tick_stopped;
>  }
> +EXPORT_SYMBOL_GPL(tick_nohz_tick_stopped);
>
>  bool tick_nohz_tick_stopped_cpu(int cpu)
>  {
> @@ -1066,6 +1073,7 @@ bool tick_nohz_idle_got_tick(void)
>         }
>         return false;
>  }
> +EXPORT_SYMBOL_GPL(tick_nohz_idle_got_tick);
>
>  /**
>   * tick_nohz_get_next_hrtimer - return the next expiration time for the hrtimer
> @@ -1117,6 +1125,7 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
>
>         return ktime_sub(next_event, now);
>  }
> +EXPORT_SYMBOL_GPL(tick_nohz_get_sleep_length);

Peter please correct me if I'm mistaken, but IMV the above are core
kernel internals and they should not be accessible to random modular
stuff.

>
>  /**
>   * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
> --
