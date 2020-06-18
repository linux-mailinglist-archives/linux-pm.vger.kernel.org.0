Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112141FF61D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgFRPDk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 11:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgFRPDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 11:03:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6CDC06174E
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 08:03:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so7670753lji.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7OlS+GwL++zlMgerOt6xFjvAHKRx4D54ivq6twtNuM=;
        b=ORkvlLBgA1esosGkQurOfdfuJxZ0oPmeMhen/wNR1FzPkfy6vGdg7sWvoHcpsdWMaX
         jcmbDInP1C1eDa0Yz4ZkIM3/TD9XzZDdtY8ZEoew7sVTTsP4mFHchNH9dfuI2rPyu9ZY
         LiEEs8x0+h5BOSmQb/6QcRjNwq7HUp6A2a/hSt8H88+oVDAaKyZ645nQ7w9Olfr4Uxt/
         ojF7/AFTOM9HL9G4fSQBZINpWagLIlc/OzmlfUc8ikGPtdBqCmhGLPt8ym4cBQ9vn40s
         yNQD1DElZFIVv8VkRTZPuG89oo3pOA8AzQ0ew6quWVgEPlyHCec9SW78vEbQfLqAkzOf
         FlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7OlS+GwL++zlMgerOt6xFjvAHKRx4D54ivq6twtNuM=;
        b=L6XtQ7uB+XdVfK8TsAY2wxpvydlepI/yyzSIw9mNW9+y4WV4h3ETWGchK+wfj36Vo5
         c5I91wRzAMzTxbVYVjJ2jR8SSQQNQL/t+FcEnnX3jE/rqpf5SkO+K9dGNoYecF4XxcTP
         VJNpP3Q/QWGmMUVlO+k48yYa2VtttZ0YbwQaM+eFcbkS6cuOcHWMJJ5kafcTYwyh49SA
         YWiFMCpxvE/1qL2B8CxqKjPQB+cOCg2YJG2m31pMPaQjX9WHUUw8Lnx/ZySaltltTmFM
         plQuY7SuNPppUrAI0FgSor5u5TeUFzy7fvvgw5xq34QrqpY2QpR6cWUEGEaBK8BbS+3y
         NEDw==
X-Gm-Message-State: AOAM531ReiE3U8L7PI+mkXXtqbTXeKnmUBb6uTXZGNnqmPcqoUcenU2h
        jZS6w9w3YqxqMqetsWtkOkEj01xpcCQnsI5d7vwPwA==
X-Google-Smtp-Source: ABdhPJzxxMz2ip/Y2ppi+/Zj9M3CIDCys8ygeYZUmjcfeK8RW5W/JrTu/UQEH/73a4HCtAjAw7pksbTZY/UxwSH+914=
X-Received: by 2002:a2e:541e:: with SMTP id i30mr2366630ljb.156.1592492616104;
 Thu, 18 Jun 2020 08:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200614010755.9129-1-valentin.schneider@arm.com> <20200614010755.9129-2-valentin.schneider@arm.com>
In-Reply-To: <20200614010755.9129-2-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 18 Jun 2020 17:03:24 +0200
Message-ID: <CAKfTPtCyi9acak95_2_2uL3Cf0OMAbZhDav2LbPY+ULPrD7z4w@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal/cpu-cooling, sched/core: Cleanup thermal
 pressure definition
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 14 Jun 2020 at 03:10, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> The following commit:
>
>   14533a16c46d ("thermal/cpu-cooling, sched/core: Move the arch_set_thermal_pressure() API to generic scheduler code")
>
> moved the definition of arch_set_thermal_pressure() to sched/core.c, but
> kept its declaration in linux/arch_topology.h. When building e.g. an x86
> kernel with CONFIG_SCHED_THERMAL_PRESSURE=y, cpufreq_cooling.c ends up
> getting the declaration of arch_set_thermal_pressure() from
> include/linux/arch_topology.h, which is somewhat awkward.
>
> On top of this, the public setter, arch_set_thermal_pressure(), is defined
> unconditionally in sched/core.c while the public getter,
> arch_scale_thermal_pressure(), is hardcoded to return 0 unless it has been
> redefined by the architecture. arch_*() functions are meant to be defined
> by architectures, so revert the aforementioned commit and re-implement it
> in a way that keeps arch_set_thermal_pressure() architecture-definable.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  drivers/base/arch_topology.c      | 11 +++++++++++
>  drivers/thermal/cpufreq_cooling.c |  5 +++++
>  include/linux/arch_topology.h     |  3 ---
>  kernel/sched/core.c               | 11 -----------
>  4 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 4d0a0038b476..d14cab7dfa3c 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -54,6 +54,17 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>         per_cpu(cpu_scale, cpu) = capacity;
>  }
>
> +DEFINE_PER_CPU(unsigned long, thermal_pressure);
> +
> +void arch_set_thermal_pressure(const struct cpumask *cpus,
> +                              unsigned long th_pressure)
> +{
> +       int cpu;
> +
> +       for_each_cpu(cpu, cpus)
> +               WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
> +}
> +
>  static ssize_t cpu_capacity_show(struct device *dev,
>                                  struct device_attribute *attr,
>                                  char *buf)
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index e297e135c031..a1efd379b683 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -417,6 +417,11 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
>         return 0;
>  }
>
> +__weak void
> +arch_set_thermal_pressure(const struct cpumask *cpus, unsigned long th_pressure)
> +{
> +}

Having this weak function declared in cpufreq_cooling is weird. This
means that we will have to do so for each one that wants to use it.

Can't you declare an empty function in a common header file ?

> +
>  /**
>   * cpufreq_set_cur_state - callback function to set the current cooling state.
>   * @cdev: thermal cooling device pointer.
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 0566cb3314ef..81bd1c627195 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -39,9 +39,6 @@ static inline unsigned long topology_get_thermal_pressure(int cpu)
>         return per_cpu(thermal_pressure, cpu);
>  }
>
> -void arch_set_thermal_pressure(struct cpumask *cpus,
> -                              unsigned long th_pressure);
> -
>  struct cpu_topology {
>         int thread_id;
>         int core_id;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43ba2d4a8eca..7861d21f3c2b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3628,17 +3628,6 @@ unsigned long long task_sched_runtime(struct task_struct *p)
>         return ns;
>  }
>
> -DEFINE_PER_CPU(unsigned long, thermal_pressure);
> -
> -void arch_set_thermal_pressure(struct cpumask *cpus,
> -                              unsigned long th_pressure)
> -{
> -       int cpu;
> -
> -       for_each_cpu(cpu, cpus)
> -               WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
> -}
> -
>  /*
>   * This function gets called by the timer code, with HZ frequency.
>   * We call it with interrupts disabled.
> --
> 2.27.0
>
