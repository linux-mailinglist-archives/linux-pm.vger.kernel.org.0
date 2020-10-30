Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8C2A093D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 16:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgJ3PIG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 11:08:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46717 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgJ3PIG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 11:08:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id j21so5781405ota.13;
        Fri, 30 Oct 2020 08:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJIofGEdCAI6rKjNbo2+4p8c6OcuJ3O33xZmukGYhi0=;
        b=HowPZNsQBls1vFWKAl6Am9N1iNU33VJByt/LlM2qOuQYy64xjtcWDF9EU7eT4Bq/pU
         m7G+8sG64swhxNdm/MQjkXliKlR6AJ5N4knLacHy6u+CH5OmHw6Pj16b5zTk9CuzkEHS
         7a7In48xUQs6NSZd/NBJr3Eq7wTPjSBNWLqK9rGtLQrJjdLVLfCrQv1nenoLIbJoK3Js
         ZHF4vPwjzSKdjXmNyr/H9Bl6hUnJSc+X20qd4MbQbT0Eh/gq21bXW8WP7MuJcQ79L0n3
         Ku4f+j1N/eWJxvIOCXP9fzFk2y61IKEGIUgESOGdgxxS6ogPjwd/9ZGhamDIL/tmwReT
         YZbA==
X-Gm-Message-State: AOAM533/n9ZK0IoyQt/ehkhyq60fMaA2JROf+PsTi+9Jo70BCOdfTFL7
        QK0jol5wAuxOtwv2Z54KpypK1hmP6Ohij9L3+lY=
X-Google-Smtp-Source: ABdhPJyW5Dk6HDaHEMpf5j92H6ArcYds1cfTLhFBrvl2IWVBhD/9PM1a6QGn6342b4TmUd8pNotuMczo5WP73QMcGp4=
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr2052764otq.321.1604070484872;
 Fri, 30 Oct 2020 08:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <2954009.kBar6x9KXa@kreacher> <207ae817a778d79a99c30cb48f2ea1f527416519.1604042421.git.viresh.kumar@linaro.org>
In-Reply-To: <207ae817a778d79a99c30cb48f2ea1f527416519.1604042421.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Oct 2020 16:07:52 +0100
Message-ID: <CAJZ5v0j2uoaUdSr1-OonPkR6QapjOm4RE2Ya=LBpV1KDrLF3gw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't skip freq update if
 need_freq_update is set
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        zhuguangqing <zhuguangqing@xiaomi.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 30, 2020 at 8:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cpufreq policy's frequency limits (min/max) can get changed at any
> point of time, while schedutil is trying to update the next frequency.
> Though the schedutil governor has necessary locking and support in place
> to make sure we don't miss any of those updates, there is a corner case
> where the governor will find that the CPU is already running at the
> desired frequency and so may skip an update.
>
> For example, consider that the CPU can run at 1 GHz, 1.2 GHz and 1.4 GHz
> and is running at 1 GHz currently. Schedutil tries to update the
> frequency to 1.2 GHz, during this time the policy limits get changed as
> policy->min = 1.4 GHz. As schedutil (and cpufreq core) does clamp the
> frequency at various instances, we will eventually set the frequency to
> 1.4 GHz, while we will save 1.2 GHz in sg_policy->next_freq.
>
> Now lets say the policy limits get changed back at this time with
> policy->min as 1 GHz. The next time schedutil is invoked by the
> scheduler, we will reevaluate the next frequency (because
> need_freq_update will get set due to limits change event) and lets say
> we want to set the frequency to 1.2 GHz again. At this point
> sugov_update_next_freq() will find the next_freq == current_freq and
> will abort the update, while the CPU actually runs at 1.4 GHz.
>
> Until now need_freq_update was used as a flag to indicate that the
> policy's frequency limits have changed, and that we should consider the
> new limits while reevaluating the next frequency.
>
> This patch fixes the above mentioned issue by extending the purpose of
> the need_freq_update flag. If this flag is set now, the schedutil
> governor will not try to abort a frequency change even if next_freq ==
> current_freq.
>
> As similar behavior is required in the case of
> CPUFREQ_NEED_UPDATE_LIMITS flag as well, need_freq_update will never be
> set to false if that flag is set for the driver.
>
> We also don't need to consider the need_freq_update flag in
> sugov_update_single() anymore to handle the special case of busy CPU, as
> we won't abort a frequency update anymore.
>
> Reported-by: zhuguangqing <zhuguangqing@xiaomi.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for following my suggestion!

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index c03a5775d019..c6861be02c86 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -102,9 +102,12 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>                                    unsigned int next_freq)
>  {
> -       if (sg_policy->next_freq == next_freq &&
> -           !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> -               return false;
> +       if (!sg_policy->need_freq_update) {
> +               if (sg_policy->next_freq == next_freq)
> +                       return false;
> +       } else if (!cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS)) {
> +               sg_policy->need_freq_update = false;
> +       }
>
>         sg_policy->next_freq = next_freq;
>         sg_policy->last_freq_update_time = time;
> @@ -162,11 +165,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>
>         freq = map_util_freq(util, freq, max);
>
> -       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update &&
> -           !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> +       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>                 return sg_policy->next_freq;
>
> -       sg_policy->need_freq_update = false;
>         sg_policy->cached_raw_freq = freq;
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
> @@ -442,7 +443,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>         struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         unsigned long util, max;
>         unsigned int next_f;
> -       bool busy;
>         unsigned int cached_freq = sg_policy->cached_raw_freq;
>
>         sugov_iowait_boost(sg_cpu, time, flags);
> @@ -453,9 +453,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>         if (!sugov_should_update_freq(sg_policy, time))
>                 return;
>
> -       /* Limits may have changed, don't skip frequency update */
> -       busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
> -
>         util = sugov_get_util(sg_cpu);
>         max = sg_cpu->max;
>         util = sugov_iowait_apply(sg_cpu, time, util, max);
> @@ -464,7 +461,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>          * Do not reduce the frequency if the CPU has not been idle
>          * recently, as the reduction is likely to be premature then.
>          */
> -       if (busy && next_f < sg_policy->next_freq) {
> +       if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
>                 next_f = sg_policy->next_freq;
>
>                 /* Restore cached freq as next_freq has changed */
> @@ -829,9 +826,10 @@ static int sugov_start(struct cpufreq_policy *policy)
>         sg_policy->next_freq                    = 0;
>         sg_policy->work_in_progress             = false;
>         sg_policy->limits_changed               = false;
> -       sg_policy->need_freq_update             = false;
>         sg_policy->cached_raw_freq              = 0;
>
> +       sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> +
>         for_each_cpu(cpu, policy->cpus) {
>                 struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
>
> --

I'll queue it up for -rc3 next week, thanks!
