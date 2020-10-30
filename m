Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2E2A09BD
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgJ3P0q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 11:26:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41240 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgJ3P0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 11:26:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id k65so7006156oih.8;
        Fri, 30 Oct 2020 08:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EQDzHk8IlUo/Q7O0mgQPpOp0accA5iV/LrucZmEgdc=;
        b=pTBE+rdeElribli3O1mXJSvpsmu8m3VTqFPjKvs9txjTVcgNRV0ukviu1lD4fudUsK
         bLwrhMIKeS4hnhRvLL6QM/hm0CgU2Lvaw8nmOnibQcuGISF0kiBTc0jDwmUavs5d02Em
         xmc0BFXofJtb0lmehWiPZG+x3JjQBKOaC1Blbw9HB7WoZqhP/amwalFKq6X89wBhHITl
         cyd6GjWTLg+7bCfzvsSPRbhOA51H2fKeNhIWSe0Y0XRAS3JMyxMrxJ55oDWeDfXF+21g
         lvDT6rjhmxdk3geW3GzJ/wcS4j2KlOVQhnNjbZg22PedLFPrHjGVtKbQv+dfVHFZ1fYt
         AdPw==
X-Gm-Message-State: AOAM530datHPvv3GDWvN2KiK1+LhZeFNY1LGvKGmog7JGZEAWGgRZoXR
        dC1j5Vvft3yP8+H0lgproESJp0gtXWlU5v9whJs=
X-Google-Smtp-Source: ABdhPJy7JKMNayUP87P7qDpr/wye21t/8MnbLwLaIOORhFEMPPcV2Ss8hvjhOf3vRORYXAYPbAwsiFVFdFJjEI6t+SQ=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr2012412oiw.69.1604071603323;
 Fri, 30 Oct 2020 08:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201027180713.7642-1-ionela.voinescu@arm.com> <20201027180713.7642-2-ionela.voinescu@arm.com>
In-Reply-To: <20201027180713.7642-2-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Oct 2020 16:26:32 +0100
Message-ID: <CAJZ5v0gg7dz44s_fjtJKm8Sv87RZypxYe3EwXX74oAuk31GW1Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/3] sched/topology,schedutil: wrap sched
 domains rebuild
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 7:08 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Add the rebuild_sched_domains_energy() function to wrap the functionality
> that rebuilds the scheduling domains if any of the Energy Aware Scheduling
> (EAS) initialisation conditions change. This functionality is used when
> schedutil is added or removed or when EAS is enabled or disabled
> through the sched_energy_aware sysctl.
>
> Therefore, create a single function that is used in both these cases and
> that can be later reused.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Acked-by: Quentin Perret <qperret@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

For the schedutil part:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming the patch to be taken care of by Peter.

> ---
>  include/linux/sched/topology.h   |  8 ++++++++
>  kernel/sched/cpufreq_schedutil.c |  9 +--------
>  kernel/sched/topology.c          | 18 +++++++++++-------
>  3 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 9ef7bf686a9f..8f0f778b7c91 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -225,6 +225,14 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
>
>  #endif /* !CONFIG_SMP */
>
> +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> +extern void rebuild_sched_domains_energy(void);
> +#else
> +static inline void rebuild_sched_domains_energy(void)
> +{
> +}
> +#endif
> +
>  #ifndef arch_scale_cpu_capacity
>  /**
>   * arch_scale_cpu_capacity - get the capacity scale factor of a given CPU.
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e254745a82cb..37b303890336 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -899,16 +899,9 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>  cpufreq_governor_init(schedutil_gov);
>
>  #ifdef CONFIG_ENERGY_MODEL
> -extern bool sched_energy_update;
> -extern struct mutex sched_energy_mutex;
> -
>  static void rebuild_sd_workfn(struct work_struct *work)
>  {
> -       mutex_lock(&sched_energy_mutex);
> -       sched_energy_update = true;
> -       rebuild_sched_domains();
> -       sched_energy_update = false;
> -       mutex_unlock(&sched_energy_mutex);
> +       rebuild_sched_domains_energy();
>  }
>  static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index dd7770226086..270bafb73506 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -211,6 +211,15 @@ unsigned int sysctl_sched_energy_aware = 1;
>  DEFINE_MUTEX(sched_energy_mutex);
>  bool sched_energy_update;
>
> +void rebuild_sched_domains_energy(void)
> +{
> +       mutex_lock(&sched_energy_mutex);
> +       sched_energy_update = true;
> +       rebuild_sched_domains();
> +       sched_energy_update = false;
> +       mutex_unlock(&sched_energy_mutex);
> +}
> +
>  #ifdef CONFIG_PROC_SYSCTL
>  int sched_energy_aware_handler(struct ctl_table *table, int write,
>                 void *buffer, size_t *lenp, loff_t *ppos)
> @@ -223,13 +232,8 @@ int sched_energy_aware_handler(struct ctl_table *table, int write,
>         ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>         if (!ret && write) {
>                 state = static_branch_unlikely(&sched_energy_present);
> -               if (state != sysctl_sched_energy_aware) {
> -                       mutex_lock(&sched_energy_mutex);
> -                       sched_energy_update = 1;
> -                       rebuild_sched_domains();
> -                       sched_energy_update = 0;
> -                       mutex_unlock(&sched_energy_mutex);
> -               }
> +               if (state != sysctl_sched_energy_aware)
> +                       rebuild_sched_domains_energy();
>         }
>
>         return ret;
> --
> 2.17.1
>
