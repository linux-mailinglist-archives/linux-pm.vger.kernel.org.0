Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C65F3A186B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhFIPDw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 11:03:52 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40928 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhFIPDt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 11:03:49 -0400
Received: by mail-ot1-f46.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so309270otr.7;
        Wed, 09 Jun 2021 08:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSfVvyXRa8dUAx7XvmzO3Q5udvWlZkBfdASbmEb2RnY=;
        b=QdkSV0l0tmQAxQ8vtWtJa7mTmi1DJeRuDfRGldT6C2AIw99HMhxDLiU/3qTu8+yl0y
         wul2ZH+oxbzl5TLsinUONzBlUb2dUo4KQEr3Y+j7Eqhy3Bw9nUI1DKEWYmiwFDzM2PjW
         ZKNPdw+BjUgiq40H91aupnmkd1VeCb8X5h/zMSbWeLQDw7Epylqcha5iWPfv/2Ipo+it
         oVhBFzkZmPBqSauGP66u4q1SssszuMLkf7VMtFiyGd1gepUGf/7hqH9e24ElHsYHhCY+
         VEhvY0FrvFEpGqsQq2k+BuiqG+x5pic+kn/a56X2zyDSryvYmpeMjmNY+Li1e0n36W6Y
         5xmg==
X-Gm-Message-State: AOAM533XPWCVxmWyYbWvlEd+ob0hOlYzHQZWgqd13VSd+B6873UaY+b+
        XjMDRyUwgSoAhMru4n4z06bsOheJIWHU6lXMDLQ=
X-Google-Smtp-Source: ABdhPJxNLoohY77wODoSnozvjbLIYdazf96SjlxIyJgh+1YaEGNVBawFtU1m8qhmdk+/iT1meEUBZQ2FkOMLAHz/Mcg=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr20141607otq.321.1623250913228;
 Wed, 09 Jun 2021 08:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210604080954.13915-1-lukasz.luba@arm.com> <20210604080954.13915-3-lukasz.luba@arm.com>
In-Reply-To: <20210604080954.13915-3-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 17:01:42 +0200
Message-ID: <CAJZ5v0ji=601eHQzHP1KuiA_TRUBaeEL6=sSLR_sW12MS_8QcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/cpufreq: Consider reduced CPU capacity in
 energy calculation
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, Beata.Michalska@arm.com,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 4, 2021 at 10:10 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Energy Aware Scheduling (EAS) needs to predict the decisions made by
> SchedUtil. The map_util_freq() exists to do that.
>
> There are corner cases where the max allowed frequency might be reduced
> (due to thermal). SchedUtil as a CPUFreq governor, is aware of that
> but EAS is not. This patch aims to address it.
>
> SchedUtil stores the maximum allowed frequency in
> 'sugov_policy::next_freq' field. EAS has to predict that value, which is
> the real used frequency. That value is made after a call to
> cpufreq_driver_resolve_freq() which clamps to the CPUFreq policy limits.
> In the existing code EAS is not able to predict that real frequency.
> This leads to energy estimation errors.
>
> To avoid wrong energy estimation in EAS (due to frequency miss prediction)
> make sure that the step which calculates Performance Domain frequency,
> is also aware of the allowed CPU capacity.
>
> Furthermore, modify map_util_freq() to not extend the frequency value.
> Instead, use map_util_perf() to extend the util value in both places:
> SchedUtil and EAS, but for EAS clamp it to max allowed CPU capacity.
> In the end, we achieve the same desirable behavior for both subsystems
> and alignment in regards to the real CPU frequency.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

For the schedutil part

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/energy_model.h     | 16 +++++++++++++---
>  include/linux/sched/cpufreq.h    |  2 +-
>  kernel/sched/cpufreq_schedutil.c |  1 +
>  kernel/sched/fair.c              |  2 +-
>  4 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 757fc60658fa..3f221dbf5f95 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -91,6 +91,8 @@ void em_dev_unregister_perf_domain(struct device *dev);
>   * @pd         : performance domain for which energy has to be estimated
>   * @max_util   : highest utilization among CPUs of the domain
>   * @sum_util   : sum of the utilization of all CPUs in the domain
> + * @allowed_cpu_cap    : maximum allowed CPU capacity for the @pd, which
> +                         might reflect reduced frequency (due to thermal)
>   *
>   * This function must be used only for CPU devices. There is no validation,
>   * i.e. if the EM is a CPU type and has cpumask allocated. It is called from
> @@ -100,7 +102,8 @@ void em_dev_unregister_perf_domain(struct device *dev);
>   * a capacity state satisfying the max utilization of the domain.
>   */
>  static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> -                               unsigned long max_util, unsigned long sum_util)
> +                               unsigned long max_util, unsigned long sum_util,
> +                               unsigned long allowed_cpu_cap)
>  {
>         unsigned long freq, scale_cpu;
>         struct em_perf_state *ps;
> @@ -112,11 +115,17 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>         /*
>          * In order to predict the performance state, map the utilization of
>          * the most utilized CPU of the performance domain to a requested
> -        * frequency, like schedutil.
> +        * frequency, like schedutil. Take also into account that the real
> +        * frequency might be set lower (due to thermal capping). Thus, clamp
> +        * max utilization to the allowed CPU capacity before calculating
> +        * effective frequency.
>          */
>         cpu = cpumask_first(to_cpumask(pd->cpus));
>         scale_cpu = arch_scale_cpu_capacity(cpu);
>         ps = &pd->table[pd->nr_perf_states - 1];
> +
> +       max_util = map_util_perf(max_util);
> +       max_util = min(max_util, allowed_cpu_cap);
>         freq = map_util_freq(max_util, ps->frequency, scale_cpu);
>
>         /*
> @@ -209,7 +218,8 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
>         return NULL;
>  }
>  static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> -                       unsigned long max_util, unsigned long sum_util)
> +                       unsigned long max_util, unsigned long sum_util,
> +                       unsigned long allowed_cpu_cap)
>  {
>         return 0;
>  }
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index 6205578ab6ee..bdd31ab93bc5 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -26,7 +26,7 @@ bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy);
>  static inline unsigned long map_util_freq(unsigned long util,
>                                         unsigned long freq, unsigned long cap)
>  {
> -       return (freq + (freq >> 2)) * util / cap;
> +       return freq * util / cap;
>  }
>
>  static inline unsigned long map_util_perf(unsigned long util)
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 4f09afd2f321..57124614363d 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -151,6 +151,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         unsigned int freq = arch_scale_freq_invariant() ?
>                                 policy->cpuinfo.max_freq : policy->cur;
>
> +       util = map_util_perf(util);
>         freq = map_util_freq(util, freq, max);
>
>         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1aeddecabc20..9a79bbd9425b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6590,7 +6590,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                 max_util = max(max_util, min(cpu_util, _cpu_cap));
>         }
>
> -       return em_cpu_energy(pd->em_pd, max_util, sum_util);
> +       return em_cpu_energy(pd->em_pd, max_util, sum_util, _cpu_cap);
>  }
>
>  /*
> --
> 2.17.1
>
