Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2BB31A270
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 17:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBLQPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 11:15:00 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46375 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBLQO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 11:14:59 -0500
Received: by mail-oi1-f181.google.com with SMTP id f3so98926oiw.13;
        Fri, 12 Feb 2021 08:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXNUtlsEhBTv3Qbo5ZsDYSNl4IO2zUHe9HmhCN3Jg7I=;
        b=Cf0oLZOXRkFG1LpB0GovV7bcZR1+TimOsEErnW7xrjG5NZe5CtOX3RFgv+YXrT0FaR
         lv4ucuhE2sydTPz8M6jq6uUpKjsik1nqVR7WRHDyYTJCiWqkFuKDgSmalyqRr+G7UmDF
         dWqYorHN5I8MXqF6vnWQzcWX7viFE9L+dcuvTmWVuJKpDD5VD1zT/WMdTq8ADP/0nT8X
         /JjbXz3mGQKDLyP5U51jbbEw+C3XJbU75MV4OXgE8hG2WPMgKcZYreT6ujcyx3VasPdR
         yfVWNBl0h97Kf9ATTIniEkbh9rHM68BK85MmO7XgCvwCicDdxE/xbjIK4p0fosCOGFmP
         o14Q==
X-Gm-Message-State: AOAM5321+WcA1jlgw5uV8xpUBUiSsfPsCUUorSm3bu66OZU4JmYkHwQD
        3RmmbCa/kIe/poGPXZ8VZsTVRnUlNLk1m/SzAeA=
X-Google-Smtp-Source: ABdhPJydAzUv2dYl07m2W1w3jEZK6q+SCpUnAQh+fGtgPe6wIfXgqozSW4a4KCEMUzSxWlN6CzNsEUMNmxxQ4dDEuMw=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr47022oia.157.1613146455073;
 Fri, 12 Feb 2021 08:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20210208030723.781-1-zbestahu@gmail.com>
In-Reply-To: <20210208030723.781-1-zbestahu@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 17:14:03 +0100
Message-ID: <CAJZ5v0hmgQp--uhRMZbqZnOvQPy9zLfQx_u=xAewmV=LgT6rPA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't use the limits_changed flag any more
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com,
        zhangwen@yulong.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 8, 2021 at 4:08 AM Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> The limits_changed flag was introduced by commit 600f5badb78c
> ("cpufreq: schedutil: Don't skip freq update when limits change") due
> to race condition where need_freq_update is cleared in get_next_freq()
> which causes reducing the CPU frequency is ineffective while busy.
>
> But now, the race condition above is gone because get_next_freq()
> doesn't clear the flag any more after commit 23a881852f3e ("cpufreq:
> schedutil: Don't skip freq update if need_freq_update is set").
>
> Moreover, need_freq_update currently will be set to true only in
> sugov_should_update_freq() if CPUFREQ_NEED_UPDATE_LIMITS is not set
> for the driver. However, limits may have changed at any time.

Yes, they may change at any time.

> And subsequent frequence update is depending on need_freq_update.

I'm not following, sorry.

need_freq_update is set in sugov_should_update_freq() when
limits_changed is cleared and it cannot be modified until
sugov_update_next_freq() runs on the same CPU.

> So, we may skip this update.

I'm not sure why?

> Hence, let's remove it to avoid above issue and make code more simple.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 41e498b..7dd85fb 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -40,7 +40,6 @@ struct sugov_policy {
>         struct task_struct      *thread;
>         bool                    work_in_progress;
>
> -       bool                    limits_changed;
>         bool                    need_freq_update;
>  };
>
> @@ -89,11 +88,8 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>         if (!cpufreq_this_cpu_can_update(sg_policy->policy))
>                 return false;
>
> -       if (unlikely(sg_policy->limits_changed)) {
> -               sg_policy->limits_changed = false;
> -               sg_policy->need_freq_update = true;
> +       if (unlikely(sg_policy->need_freq_update))
>                 return true;
> -       }
>
>         delta_ns = time - sg_policy->last_freq_update_time;
>
> @@ -323,7 +319,7 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
>  static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
>  {
>         if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
> -               sg_policy->limits_changed = true;
> +               sg_policy->need_freq_update = true;
>  }
>
>  static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
> @@ -759,7 +755,6 @@ static int sugov_start(struct cpufreq_policy *policy)
>         sg_policy->last_freq_update_time        = 0;
>         sg_policy->next_freq                    = 0;
>         sg_policy->work_in_progress             = false;
> -       sg_policy->limits_changed               = false;
>         sg_policy->cached_raw_freq              = 0;
>
>         sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> @@ -813,7 +808,7 @@ static void sugov_limits(struct cpufreq_policy *policy)
>                 mutex_unlock(&sg_policy->work_lock);
>         }
>
> -       sg_policy->limits_changed = true;
> +       sg_policy->need_freq_update = true;

This may be running in parallel with sugov_update_next_freq() on a
different CPU, so the latter may clear need_freq_update right after it
has been set here unless I'm overlooking something.

>  }
>
>  struct cpufreq_governor schedutil_gov = {
> --
> 1.9.1
>
