Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4183B22EE2A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 16:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgG0OCb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 10:02:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35720 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgG0OCa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 10:02:30 -0400
Received: by mail-oi1-f193.google.com with SMTP id k4so14414251oik.2;
        Mon, 27 Jul 2020 07:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRY3UX2NBXS9aSshDQuKlv62KiLkLKBPXBEuh/ff5bQ=;
        b=VZSmWFSCFyGTLM566ozWQhgVUteuGMUYaoXa9BG44LFRqw1G5DrZBZNJ62ADFNOGb8
         iFkvT+SOwbwhZrPvbhPFAWvvBdX7lb5Mn0hUXE/v+4jyiMfh2tzRuQMKd6UQsSV/9jnw
         +G+HKy93qhzOFhdrv7BI1MhGfvVBiU3qlkWc0FE74hrA7MLuX1WUCWdWsGJ1WALS8NM2
         VNTmu7I6K6IjnlYfMHLlebau8zeEvmDuPxf0bysUUCDlaEMJstnCEpQV2KEo7p0J1UBM
         7PDz86fG561/8xGuB8yHbCadYlJmGENpvaCogo2+TJTEAN5so005tHFoFvleQi1r67QU
         H3hw==
X-Gm-Message-State: AOAM532vU3HiT73XGhfXmUdNw41TTbcshn4WfuvjI16YclzPNC9t5zFS
        SSiNHLmKrzygkoNmuQiMFucu6yPjl1697WEV+bU=
X-Google-Smtp-Source: ABdhPJwVRDYwbcsm/QOnkqd5RoiNowF+0IcXiCPMz8Ihy8I8/y2G9R4k8waaFkVE53P3g1YaEJL9s8CrE7Grwj7SSFc=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr19034751oia.103.1595858549233;
 Mon, 27 Jul 2020 07:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200722093732.14297-1-ionela.voinescu@arm.com> <20200722093732.14297-5-ionela.voinescu@arm.com>
In-Reply-To: <20200722093732.14297-5-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 16:02:18 +0200
Message-ID: <CAJZ5v0jvvEvxs2dwsGd1kerTT3pJTJj6fVg0ndtdeUhiq+K_UQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] cpufreq: report whether cpufreq supports Frequency
 Invariance (FI)
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 22, 2020 at 11:38 AM Ionela Voinescu
<ionela.voinescu@arm.com> wrote:
>
> Now that the update of the FI scale factor is done in cpufreq core for
> selected functions - target(), target_index() and fast_switch(),
> we can provide feedback to the task scheduler and architecture code
> on whether cpufreq supports FI.
>
> For this purpose, provide error and debug messages, together with an
> external function to expose whether the cpufreq drivers support FI, by
> using a static key.
>
> The logic behind the enablement of cpufreq-based invariance is as
> follows:
>  - cpufreq-based invariance is disabled by default
>  - cpufreq-based invariance is enabled if any of the callbacks
>    above is implemented while the unsupported setpolicy() is not
>  - if enabled, cpufreq-based invariance will be disabled during the
>    call of the default arch_set_freq_scale() function which does
>    not set a scale factor.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 28 ++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   |  5 +++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 3497c1cd6818..1d0b046fe8e9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -61,6 +61,9 @@ static struct cpufreq_driver *cpufreq_driver;
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
>
> +/* Mark support for the scheduler's frequency invariance engine */
> +static DEFINE_STATIC_KEY_FALSE(cpufreq_set_freq_scale);
> +
>  /* Flag to suspend/resume CPUFreq governors */
>  static bool cpufreq_suspended;
>
> @@ -69,6 +72,25 @@ static inline bool has_target(void)
>         return cpufreq_driver->target_index || cpufreq_driver->target;
>  }
>
> +static inline
> +void enable_cpufreq_freq_invariance(struct cpufreq_driver *driver)
> +{
> +       if ((driver->target || driver->target_index || driver->fast_switch) &&
> +           !driver->setpolicy) {
> +
> +               static_branch_enable_cpuslocked(&cpufreq_set_freq_scale);
> +               pr_debug("%s: Driver %s can provide frequency invariance.",
> +                        __func__, driver->name);
> +       } else
> +               pr_err("%s: Driver %s cannot provide frequency invariance.",
> +               __func__, driver->name);

This doesn't follow the kernel coding style (the braces around the
pr_err() statement are missing).

Besides, IMO on architectures where arch_set_freq_scale() is empty,
this should be empty as well.

> +}
> +
> +bool cpufreq_sets_freq_scale(void)
> +{
> +       return static_branch_likely(&cpufreq_set_freq_scale);
> +}
> +
>  /* internal prototypes */
>  static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
>  static int cpufreq_init_governor(struct cpufreq_policy *policy);
> @@ -159,6 +181,9 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time);
>  __weak void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>                 unsigned long max_freq)
>  {
> +       if (cpufreq_sets_freq_scale())
> +               static_branch_disable_cpuslocked(&cpufreq_set_freq_scale);
> +
>  }
>  EXPORT_SYMBOL_GPL(arch_set_freq_scale);
>
> @@ -2722,6 +2747,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>         cpufreq_driver = driver_data;
>         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
> +       enable_cpufreq_freq_invariance(cpufreq_driver);
> +
>         if (driver_data->setpolicy)
>                 driver_data->flags |= CPUFREQ_CONST_LOOPS;
>
> @@ -2791,6 +2818,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
>         cpus_read_lock();
>         subsys_interface_unregister(&cpufreq_interface);
>         remove_boost_sysfs_file();
> +       static_branch_disable_cpuslocked(&cpufreq_set_freq_scale);
>         cpuhp_remove_state_nocalls_cpuslocked(hp_online);
>
>         write_lock_irqsave(&cpufreq_driver_lock, flags);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index e62b022cb07e..f81215ad76f1 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -217,6 +217,7 @@ void refresh_frequency_limits(struct cpufreq_policy *policy);
>  void cpufreq_update_policy(unsigned int cpu);
>  void cpufreq_update_limits(unsigned int cpu);
>  bool have_governor_per_policy(void);
> +bool cpufreq_sets_freq_scale(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
>  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
>  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
> @@ -237,6 +238,10 @@ static inline unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
>  {
>         return 0;
>  }
> +static inline bool cpufreq_sets_freq_scale(void)
> +{
> +       return false;
> +}
>  static inline void disable_cpufreq(void) { }
>  #endif
>
> --
> 2.17.1
>
