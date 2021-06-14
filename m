Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2F93A6B3C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 18:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhFNQGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 12:06:50 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:33738 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbhFNQGt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 12:06:49 -0400
Received: by mail-lf1-f41.google.com with SMTP id bp38so22026524lfb.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTise3u7DUw/GSwrfGFy2ZCu2gr1M+jVma19ukLn4cw=;
        b=wMamYv5y1SDOIBuBMVMUNWyN6l0EBkMyGouM/b6So5/CUEPxxYk1T6lCxM3kTpItRK
         2dlDTCjm5bQ52+vwyZPtee0AbnD+ULpJfAOAtGoLGwaJPmpgpW9vDiSi0xwvONZ1+yJL
         EwpTMssnf1Oc6Fu+0YycbXNMQVhM5vKLUg3JxcDbujE7MHiNNxI7moliMQfDC6NKYyGk
         GcE1QXP1CbMnKLY+oYLHvWDxSDVk38ethXqqZHwK1Iq8ow2g2UZloUPU0fVt/Z7Iq2Xp
         T96xPecbpiWrQ+cqLTkWb7encaaYuFiP+BlU2tLbFAp5V6ZgK4sL3kcLq8we7h3DriKq
         4nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTise3u7DUw/GSwrfGFy2ZCu2gr1M+jVma19ukLn4cw=;
        b=BZPjRpNvtcsmuWZxlF8dmET+P8I5ua7HhjywFPa6P+OlLGnuF5tkmpMI7kQJuSDyP/
         K2FFjSX0knLZfjadjNLQOTT+KtHDUJt5tXpstlJbuCSasxLfrVQ4I6XE74eqYrJnVnkG
         R1FD7/QLJ5VjwbNimZdDZhHKwFkLd5N8sJ5H7q4RrI7TSbA8jmqCJ54B7Z6D5CxBbj4q
         4yNMDHZIG6ellBaASXsj8R+5FdMmuu5vLMWEE5D0Z/3NNAbfhrb8884hrg0QgWgVLbcU
         HOpFVVJNivajDhQWmQcvpmVa1r/QtpwYqfJug68B8BuH0/rSkB6WHLE6T15K7jrTq209
         E1kQ==
X-Gm-Message-State: AOAM532lmfy0zGAX2XGfxNeJwOrW3Ho4CfUXKj6oODjRySajW02ltTHv
        B3RgsjAwG24IoXjgcOUOzuxDEEWihfMEmy9WZB6gMw==
X-Google-Smtp-Source: ABdhPJyOoWRlrED4Goky2EOjXReGM1dUHHdlbwtEtE4QvWtGuRvF53tM5yVcNSnmscF6Zb/ZVNJp9kUcBJNGi+q3F2o=
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr3929557lfp.286.1623686626088;
 Mon, 14 Jun 2021 09:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210610150324.22919-1-lukasz.luba@arm.com> <20210610150324.22919-3-lukasz.luba@arm.com>
In-Reply-To: <20210610150324.22919-3-lukasz.luba@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Jun 2021 18:03:34 +0200
Message-ID: <CAKfTPtAq5Hn7iQ-USO5La4B_jkYXzSvFSFrCDq47gjXDGghyTQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>, amitk@kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Jun 2021 at 17:03, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Energy Aware Scheduling (EAS) needs to be able to predict the frequency
> requests made by the SchedUtil governor to properly estimate energy used
> in the future. It has to take into account CPUs utilization and forecast
> Performance Domain (PD) frequency. There is a corner case when the max
> allowed frequency might be reduced due to thermal. SchedUtil is aware of
> that reduced frequency, so it should be taken into account also in EAS
> estimations.
>
> SchedUtil, as a CPUFreq governor, knows the maximum allowed frequency of
> a CPU, thanks to cpufreq_driver_resolve_freq() and internal clamping
> to 'policy::max'. SchedUtil is responsible to respect that upper limit
> while setting the frequency through CPUFreq drivers. This effective
> frequency is stored internally in 'sugov_policy::next_freq' and EAS has
> to predict that value.
>
> In the existing code the raw value of arch_scale_cpu_capacity() is used
> for clamping the returned CPU utilization from effective_cpu_util().
> This patch fixes issue with too big single CPU utilization, by introducing
> clamping to the allowed CPU capacity. The allowed CPU capacity is a CPU
> capacity reduced by thermal pressure signal. We rely on this load avg

you don't rely on load avg value but on raw thermal pressure value now

> geometric series in similar way as other mechanisms in the scheduler.
>
> Thanks to knowledge about allowed CPU capacity, we don't get too big value
> for a single CPU utilization, which is then added to the util sum. The
> util sum is used as a source of information for estimating whole PD energy.
> To avoid wrong energy estimation in EAS (due to capped frequency), make
> sure that the calculation of util sum is aware of allowed CPU capacity.
>
> This thermal pressure might be visible in scenarios where the CPUs are not
> heavily loaded, but some other component (like GPU) drastically reduced
> available power budget and increased the SoC temperature. Thus, we still
> use EAS for task placement and CPUs are not over-utilized.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/fair.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 161b92aa1c79..237726217dad 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6527,8 +6527,12 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>         struct cpumask *pd_mask = perf_domain_span(pd);
>         unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
>         unsigned long max_util = 0, sum_util = 0;
> +       unsigned long _cpu_cap, thermal_pressure;
>         int cpu;
>
> +       thermal_pressure = arch_scale_thermal_pressure(cpumask_first(pd_mask));

Do you really need to use this intermediate variable thermal_pressure
? Seems to be used only below

With these 2 comments above fixed,

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> +       _cpu_cap = cpu_cap - thermal_pressure;
> +
>         /*
>          * The capacity state of CPUs of the current rd can be driven by CPUs
>          * of another rd if they belong to the same pd. So, account for the
> @@ -6564,8 +6568,10 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                  * is already enough to scale the EM reported power
>                  * consumption at the (eventually clamped) cpu_capacity.
>                  */
> -               sum_util += effective_cpu_util(cpu, util_running, cpu_cap,
> -                                              ENERGY_UTIL, NULL);
> +               cpu_util = effective_cpu_util(cpu, util_running, cpu_cap,
> +                                             ENERGY_UTIL, NULL);
> +
> +               sum_util += min(cpu_util, _cpu_cap);
>
>                 /*
>                  * Performance domain frequency: utilization clamping
> @@ -6576,7 +6582,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                  */
>                 cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
>                                               FREQUENCY_UTIL, tsk);
> -               max_util = max(max_util, cpu_util);
> +               max_util = max(max_util, min(cpu_util, _cpu_cap));
>         }
>
>         return em_cpu_energy(pd->em_pd, max_util, sum_util);
> --
> 2.17.1
>
