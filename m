Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208DE21F219
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 15:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGNNFb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 09:05:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33157 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGNNFb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 09:05:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id h13so12986569otr.0;
        Tue, 14 Jul 2020 06:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsQNLe/BA5spAjR6HNPKokWsHGNEHDhOqKYNmI6E978=;
        b=NgXSEirKCnF+sDWU0CwGnwH9ivwB6hSyByw+j4ry6fcYKga1QhSlfrH05Rl2NLVtLd
         1+7l5CzJfVhe9A2Kqb4DY9L/t3UMnpj5h8YWT0WA+xvsYQMRVjRGI1hTPe+60aJc0qyx
         qYiUzIAO7Tj3Bvs5Vuici+l4C2On5rlBKwWgWNsfR7PQxuGCYzmXiEoEotyvMcT68c0j
         H1v3NrlmF6r5ck0Lsyb3+Or3kv0j9T86VtbF04qx4vZWfRmiv7wrNz3mq0c8OMqU6dI/
         eqjHDOjJOkVkpgf0UA6MxGFIFhaXO8A+ts8UGgvd5ATxw3h4WXuEW2LNuk2ZoIIWYPhD
         TvhA==
X-Gm-Message-State: AOAM531pWJs5W0S4M8xtP+09+psGyXnhBJunEhNHNPuWdnmJVIgcqqgN
        N3X8Fqy53epzn/rtW9wBzE7XEZwAFY2U8AAHEV8=
X-Google-Smtp-Source: ABdhPJyOh42BSODoXRB1w7iyb1wvgKwRrKCCOQ6fLdTWNfkGmNteB1ZCjapDc+TLAENIBVoA1nmL+jY+tg8Mcs811Zg=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr3843930ots.118.1594731930891;
 Tue, 14 Jul 2020 06:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594707424.git.viresh.kumar@linaro.org> <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
In-Reply-To: <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 15:05:18 +0200
Message-ID: <CAJZ5v0i=yNH9pGkty2QdeQLcqJcuY=pLx_XcY4VXs8bSqXL=dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 8:37 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Several parts of the kernel are already using the effective CPU
> utilization to get the current load on the CPU, do the same here instead
> of depending on the idle time of the CPU, which isn't that accurate
> comparatively.
>
> Note that, this (and CPU frequency scaling in general) doesn't work that
> well with idle injection as that is done from rt threads and is counted
> as load while it tries to do quite the opposite. That should be solved
> separately though.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpufreq_cooling.c | 65 +++++++------------------------
>  1 file changed, 15 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 6c0e1b053126..74340b2b0da7 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -23,6 +23,7 @@
>  #include <linux/thermal.h>
>
>  #include <trace/events/thermal.h>
> +#include "../../kernel/sched/sched.h"
>
>  /*
>   * Cooling state <-> CPUFreq frequency
> @@ -38,16 +39,6 @@
>   *     ...
>   */
>
> -/**
> - * struct time_in_idle - Idle time stats
> - * @time: previous reading of the absolute time that this cpu was idle
> - * @timestamp: wall time of the last invocation of get_cpu_idle_time_us()
> - */
> -struct time_in_idle {
> -       u64 time;
> -       u64 timestamp;
> -};
> -
>  /**
>   * struct cpufreq_cooling_device - data for cooling device with cpufreq
>   * @id: unique integer value corresponding to each cpufreq_cooling_device
> @@ -62,7 +53,6 @@ struct time_in_idle {
>   *     registered cooling device.
>   * @policy: cpufreq policy.
>   * @node: list_head to link all cpufreq_cooling_device together.
> - * @idle_time: idle time stats
>   * @qos_req: PM QoS contraint to apply
>   *
>   * This structure is required for keeping information of each registered
> @@ -76,7 +66,6 @@ struct cpufreq_cooling_device {
>         struct em_perf_domain *em;
>         struct cpufreq_policy *policy;
>         struct list_head node;
> -       struct time_in_idle *idle_time;
>         struct freq_qos_request qos_req;
>  };
>
> @@ -132,34 +121,21 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>  }
>
>  /**
> - * get_load() - get load for a cpu since last updated
> + * get_load() - get current load for a cpu
>   * @cpufreq_cdev:      &struct cpufreq_cooling_device for this cpu
>   * @cpu:       cpu number
> - * @cpu_idx:   index of the cpu in time_in_idle*
> + * @cpu_idx:   index of the cpu
>   *
> - * Return: The average load of cpu @cpu in percentage since this
> - * function was last called.
> + * Return: The current load of cpu @cpu in percentage.
>   */
>  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
>                     int cpu_idx)
>  {
> -       u32 load;
> -       u64 now, now_idle, delta_time, delta_idle;
> -       struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
> -
> -       now_idle = get_cpu_idle_time(cpu, &now, 0);
> -       delta_idle = now_idle - idle_time->time;
> -       delta_time = now - idle_time->timestamp;
> +       unsigned long util = cpu_util_cfs(cpu_rq(cpu));
> +       unsigned long max = arch_scale_cpu_capacity(cpu);
>
> -       if (delta_time <= delta_idle)
> -               load = 0;
> -       else
> -               load = div64_u64(100 * (delta_time - delta_idle), delta_time);
> -
> -       idle_time->time = now_idle;
> -       idle_time->timestamp = now;
> -
> -       return load;
> +       util = effective_cpu_util(cpu, util, max, ENERGY_UTIL, NULL);

Hmm.

It doesn't look like cpufreq_cdev and cpu_idx are needed any more in
this function, so maybe drop them from the arg list?  And then there
won't be anything specific to CPU cooling in this function, so maybe
move it to sched and export it from there properly?

Also it looks like max could be passed to it along with the CPU number
instead of being always taken as arch_scale_cpu_capacity(cpu).

> +       return (util * 100) / max;
>  }
>
>  /**
