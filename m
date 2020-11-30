Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9BF2C8DAF
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 20:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgK3THi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 14:07:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46987 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgK3THi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 14:07:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id z23so8724843oti.13;
        Mon, 30 Nov 2020 11:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4c0ewLuKQihDqpCI4lI9QpkIZqIdg1WpJW+IRHNH1w=;
        b=p6orThEBqElLvkoivg/bmKWwQVY020zdBm83ixfszCkqGrSFUP4/JVcUYpK/oFecI0
         jzlAK+G0KshWDq2h7OYW+ykvuZz+WMEHDLu/W7xqhYRhiSKGfr2C8mGS6DVB1eWWWK74
         I6N6zoTzxB7apNGkGw48ZW5McJEoAB0xU58x1UtQFLoNv53wF2k64JqNKAx//bRaOtvk
         wHv1OpMxWPsMy4cxIYRAFVRw6s5jWj6NKeneJwHl3OoCU/LnEcAhwHgj/BeVD13qB09y
         Gh6cRVvnc8JRITeOeGnidWWOI52o61B4REpz/iMD71RftYuFbO8Vgr3LLpmWZE++tuK/
         vayg==
X-Gm-Message-State: AOAM530zCqHd+1YgB6gdWqv1wpDEbzXyRU3sHe9vRfp+XARthZe0WVaQ
        XHhhn7UXJen4ggNFQIXjmJfL9hShvpEaAlPcDqh/YZqx
X-Google-Smtp-Source: ABdhPJwLZ/wMFqEIaHyXCxGOtIBm+FERcwnNMKEkKUUTf6i3pI2tVTAAfp2GgUwslC24LBWAe0Olwx1M8zOiSPcO780=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr18570302otu.206.1606763215377;
 Mon, 30 Nov 2020 11:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20201130092241.GR3371@techsingularity.net>
In-Reply-To: <20201130092241.GR3371@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Nov 2020 20:06:44 +0100
Message-ID: <CAJZ5v0h-ZBUMKqP5om7h67iMTe87GUf2Bw5dJ9tQN6MKwaTWzA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Select polling interval based on a c-state with
 a longer target residency
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 30, 2020 at 10:22 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> It was noted that a few workloads that idle rapidly regressed when commit
> 36fcb4292473 ("cpuidle: use first valid target residency as poll time")
> was merged. The workloads in question were heavy communicators that idle
> rapidly and were impacted by the c-state exit latency as the active CPUs
> were not polling at the time of wakeup. As they were not particularly
> realistic workloads, it was not considered to be a major problem.
>
> Unfortunately, a bug was reported for a real workload in a production
> environment that relied on large numbers of threads operating in a worker
> pool pattern. These threads would idle for periods of time longer than the
> C1 target residency and so incurred the c-state exit latency penalty. The
> application is very sensitive to wakeup latency and indirectly relying
> on behaviour prior to commit on a37b969a61c1 ("cpuidle: poll_state: Add
> time limit to poll_idle()") to poll for long enough to avoid the exit
> latency cost.
>
> The target residency of C1 is typically very short. On some x86 machines,
> it can be as low as 2 microseconds. In poll_idle(), the clock is checked
> every POLL_IDLE_RELAX_COUNT interations of cpu_relax() and even one
> iteration of that loop can be over 1 microsecond so the polling interval is
> very close to the granularity of what poll_idle() can detect. Furthermore,
> a basic ping pong workload like perf bench pipe has a longer round-trip
> time than the 2 microseconds meaning that the CPU will almost certainly
> not be polling when the ping-pong completes.
>
> This patch selects a polling interval based on an enabled c-state that
> has an target residency longer than 10usec. If there is no enabled-cstate
> then polling will be up to a TICK_NSEC/16 similar to what it was up until
> kernel 4.20.
>
> As an example, consider a CPU with the following c-state information from
> an Intel CPU;
>
>         residency       exit_latency
> C1      2               2
> C1E     20              10
> C3      100             33
> C6      400             133
>
> The polling interval selected is 20usec. If booted with
> intel_idle.max_cstate=1 then the polling interval is 250usec as the deeper
> c-states were not available.
>
> On an AMD EPYC machine, the c-state information is more limited and looks
> like
>
>         residency       exit_latency
> C1      2               1
> C2      800             400
>
> The polling interval selected is 250usec. While C2 was considered, the
> polling interval was clamped by CPUIDLE_POLL_MAX.
>
> Note that it is not expected that polling will be a universal win. As
> well as potentially trading power for performance, the performance is not
> guaranteed if the extra polling prevented a turbo state being reached. The
> patch allows the polling interval to be tuned in case a corner-case is
> found and if a bug is filed, the tuning may advise how CPUIDLE_POLL_MIN
> should be adjusted (e.g. optional overrides per architecture) or if a
> different balance point than residency-exit_latency should be used.
>
> tbench4
>                              vanilla                polling
> Hmean     1        497.89 (   0.00%)      543.15 *   9.09%*
> Hmean     2        975.88 (   0.00%)     1059.73 *   8.59%*
> Hmean     4       1953.97 (   0.00%)     2081.37 *   6.52%*
> Hmean     8       3645.76 (   0.00%)     4052.95 *  11.17%*
> Hmean     16      6882.21 (   0.00%)     6995.93 *   1.65%*
> Hmean     32     10752.20 (   0.00%)    10731.53 *  -0.19%*
> Hmean     64     12875.08 (   0.00%)    12478.13 *  -3.08%*
> Hmean     128    21500.54 (   0.00%)    21098.60 *  -1.87%*
> Hmean     256    21253.70 (   0.00%)    21027.18 *  -1.07%*
> Hmean     320    20813.50 (   0.00%)    20580.64 *  -1.12%*
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 18 +++++++++
>  drivers/cpuidle/cpuidle.c                       | 49 ++++++++++++++++++++++++-
>  2 files changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 526d65d8573a..5b8545022564 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -719,6 +719,24 @@
>                         policy to use. This governor must be registered in the
>                         kernel before the cpufreq driver probes.
>
> +       cpuidle.poll=
> +                       [CPU_IDLE]
> +                       Format: <int>
> +                       Set the time in microseconds a CPU should poll in
> +                       cpuidle for a new task before entering a sleep
> +                       state. The default is determined by either the
> +                       tick or the enabled c-state latencies. Tuning is
> +                       not generally recommended but it may be needed
> +                       for workloads that are both latency-sensitive
> +                       and idling rapidly for short durations. Limiting
> +                       c-states can be insufficient if the polling
> +                       time is still too short, the application has no
> +                       knowledge of /dev/cpu_dma_latency, there are
> +                       multiple applications or the environment does
> +                       not allow the installation of a userspace tool
> +                       that controls cpu_dma_latency. This value may
> +                       be ignored by the idle governor (e.g. haltpoll).

OK, we can do this, but I'd use a shorter different description here
and a more detailed one in the admin-guide documentation.

Also this is about certain drivers only which support the "polling
idle state" (the ACPI one and intel_idle only AFAICS).  So I'm not
sure about the framework-level tunable here.

Moreover, to be precise, that value is the maximum time to do the
polling (in one go) in the case when requesting any "physical" idle
states is likely to hurt energy-efficiency or latency.  In particular,
it doesn't mean that idle CPUs will do the idle polling every time.

> +
>         cpu_init_udelay=N
>                         [X86] Delay for N microsec between assert and de-assert
>                         of APIC INIT to start processors.  This delay occurs
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 83af15f77f66..3be208e9043a 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -368,6 +368,26 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
>                 cpuidle_curr_governor->reflect(dev, index);
>  }
>
> +static struct kernel_param_ops poll_param_ops = {
> +       .set =          param_set_ulong,
> +       .get =          param_get_ulong,
> +};
> +
> +/*
> + * Min polling interval of 10usec is a guess. It is assuming that
> + * for most users, the time for a single ping-pong workload like
> + * perf bench pipe would generally complete within 10usec but
> + * this is hardware dependant. Actual time can be estimated with
> + *
> + * perf bench sched pipe -l 10000
> + *
> + * Run multiple times to avoid cpufreq effects.
> + */
> +#define CPUIDLE_POLL_MIN 10000

Well, if we consider providing this tunable, we should also make it
possible to set it to 0, because the "no polling" use case is valid
too (at least AFAICS).  But in the case of 0, the "polling idle state"
should be effectively disabled, so the governors don't need to bother
looking at it.

> +#define CPUIDLE_POLL_MAX (TICK_NSEC / 16)
> +
> +static unsigned long __read_mostly param_poll;
> +
>  /**
>   * cpuidle_poll_time - return amount of time to poll for,
>   * governors can override dev->poll_limit_ns if necessary
> @@ -382,20 +402,44 @@ u64 cpuidle_poll_time(struct cpuidle_driver *drv,
>         int i;
>         u64 limit_ns;
>
> +       BUILD_BUG_ON(CPUIDLE_POLL_MIN > CPUIDLE_POLL_MAX);
> +
>         if (dev->poll_limit_ns)
>                 return dev->poll_limit_ns;
>
> -       limit_ns = TICK_NSEC;
> +       /* Use module parameter if specified */
> +       if (param_poll) {
> +               param_poll *= NSEC_PER_USEC;
> +               param_poll = clamp_t(unsigned long, param_poll * NSEC_PER_USEC,
> +                                       CPUIDLE_POLL_MIN, CPUIDLE_POLL_MAX);
> +               limit_ns = param_poll;
> +               goto out;
> +       }
> +
> +       limit_ns = CPUIDLE_POLL_MAX;
>         for (i = 1; i < drv->state_count; i++) {
> +               u64 state_limit;
> +
>                 if (dev->states_usage[i].disable)
>                         continue;
>
> -               limit_ns = drv->states[i].target_residency_ns;
> +               state_limit = drv->states[i].target_residency_ns;
> +               if (state_limit < CPUIDLE_POLL_MIN)
> +                       continue;
> +
> +               limit_ns = min_t(u64, state_limit, CPUIDLE_POLL_MAX);
>                 break;
>         }
>
> +out:
>         dev->poll_limit_ns = limit_ns;
>
> +       /*
> +        * Polling parameter reported as usec to match the values reported
> +        * for c-cstate exit latencies in sysfs.
> +        */
> +       param_poll = div64_ul(dev->poll_limit_ns, NSEC_PER_USEC);
> +
>         return dev->poll_limit_ns;
>  }
>
> @@ -755,4 +799,5 @@ static int __init cpuidle_init(void)
>
>  module_param(off, int, 0444);
>  module_param_string(governor, param_governor, CPUIDLE_NAME_LEN, 0444);
> +module_param_cb(poll, &poll_param_ops, &param_poll, 0444);
>  core_initcall(cpuidle_init);
