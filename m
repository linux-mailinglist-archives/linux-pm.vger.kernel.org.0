Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614D6321BF8
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 16:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBVP6V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 10:58:21 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37793 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhBVP6U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 10:58:20 -0500
Received: by mail-ot1-f45.google.com with SMTP id s6so12404498otk.4;
        Mon, 22 Feb 2021 07:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7vUYhzafhlcgMm2RFSd0Iajpd5S/uaFdPDm6SSIqyc=;
        b=k+ePGvPUWvSKIbK4kziz5O1LSnKabP7znCMUkeNOcoVlr8jzVuClmofr6t5HYm23ee
         jeKpJDM8IoKuQc6sR0x8VfQrmRx2WC69mJKp8NQEC0B2DiLIL6bhv3+KzWc6kfITCuw3
         66gQszR0ItNRj7VAiiVjNNPVdzPhMtb+gEQBytp9HmlFaKwtZ+GzL28Sm6HeBkc+aOug
         +RYGmbKu27OaAxl1BEfWLGQPs2aPFWDyu3GoDQOuYx2JgJJuP4V65+hii7P24PMzuUsN
         vDc9leOM44Y4z7B16Di+TYvn2JLRT+hP9UCN4b7Ne8DrQtGdJe6/CXkiHu7zOUVW4gnx
         kSgQ==
X-Gm-Message-State: AOAM5329t7M9nbsdBfpP3K2xoazKuctWrnODPVSQG1X6grpBFCZCw2YB
        eH/ZusFIl+Rr6A4thT8L8WFz0WsFuy90oFP9iE4=
X-Google-Smtp-Source: ABdhPJxbc6QD/y+obNFYjlYivq5Ve3TlzhcGDAH8or79smH+R2Y9EwqCKPmoTOzbGYqp8UABpgch0Eq0HWlASvMx/wk=
X-Received: by 2002:a9d:22a5:: with SMTP id y34mr13451658ota.321.1614009456538;
 Mon, 22 Feb 2021 07:57:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613991982.git.viresh.kumar@linaro.org> <51c2260e8760fdc0b489bed2ff2c6bb8209ea35d.1613991982.git.viresh.kumar@linaro.org>
In-Reply-To: <51c2260e8760fdc0b489bed2ff2c6bb8209ea35d.1613991982.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Feb 2021 16:57:25 +0100
Message-ID: <CAJZ5v0i_JeMMAJA-J7ghuQr_+uN6urCGTn0O0FyZ8x8ntpKcJg@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] cpufreq: cppc: Add support for frequency invariance
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 22, 2021 at 12:20 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The Frequency Invariance Engine (FIE) is providing a frequency scaling
> correction factor that helps achieve more accurate load-tracking.
>
> Normally, this scaling factor can be obtained directly with the help of
> the cpufreq drivers as they know the exact frequency the hardware is
> running at. But that isn't the case for CPPC cpufreq driver.

Even though the driver is located in drivers/cpufreq/ CPPC is part of
ACPI and so a CC to linux-acpi is missing.

> Another way of obtaining that is using the arch specific counter
> support, which is already present in kernel, but that hardware is
> optional for platforms.
>
> This patch thus obtains this scaling factor using the existing logic
> present in the cppc driver.

It would be nice to expand this a bit to describe the design.  Also
IMO it wouldn't hurt to add a kerneldoc comment describing it, say to
cppc_scale_freq_workfn().

And spelling CPPC consistently would be nice too.

> Note that the arch specific counters have
> higher priority than CPPC counters if available, though the CPPC driver
> doesn't need to have any special handling for that.
>
> To allow platforms to disable frequency invariance support if they want,
> this is all done under CONFIG_ACPI_CPPC_CPUFREQ_FIE, which is enabled by
> default.
>
> This also exports sched_setattr_nocheck() as the CPPC driver can be
> built as a module.
>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm    |   9 ++
>  drivers/cpufreq/cppc_cpufreq.c | 223 +++++++++++++++++++++++++++++++--
>  include/linux/arch_topology.h  |   1 +
>  kernel/sched/core.c            |   1 +
>  4 files changed, 222 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index e65e0a43be64..a3e2d6dfea70 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -19,6 +19,15 @@ config ACPI_CPPC_CPUFREQ
>
>           If in doubt, say N.
>
> +config ACPI_CPPC_CPUFREQ_FIE
> +       bool "Frequency Invariance support for CPPC cpufreq driver"
> +       depends on ACPI_CPPC_CPUFREQ

In theory, the CPPC cpufreq driver can be used on systems with
nontrivial arch_freq_scale_tick() in which case the latter should be
used I suppose.

Would that actually happen if this option is enabled?

> +       default y
> +       help
> +         This enables frequency invariance support for CPPC cpufreq driver.
> +
> +         If in doubt, say N.
> +
>  config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
>         tristate "Allwinner nvmem based SUN50I CPUFreq driver"
>         depends on ARCH_SUNXI
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 8a482c434ea6..fa1692db93c4 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -10,14 +10,18 @@
>
>  #define pr_fmt(fmt)    "CPPC Cpufreq:" fmt
>
> +#include <linux/arch_topology.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/dmi.h>
> +#include <linux/irq_work.h>
> +#include <linux/kthread.h>
>  #include <linux/time.h>
>  #include <linux/vmalloc.h>
> +#include <uapi/linux/sched/types.h>
>
>  #include <asm/unaligned.h>
>
> @@ -57,6 +61,182 @@ static struct cppc_workaround_oem_info wa_info[] = {
>         }
>  };
>
> +#ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
> +
> +/* Frequency invariance support */
> +struct cppc_freq_invariance {
> +       int cpu;
> +       struct irq_work irq_work;
> +       struct kthread_work work;
> +       struct cppc_perf_fb_ctrs prev_perf_fb_ctrs;
> +       struct cppc_cpudata *cpu_data;
> +};
> +
> +static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
> +static struct kthread_worker *kworker_fie;
> +
> +static struct cpufreq_driver cppc_cpufreq_driver;
> +static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
> +static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
> +                                struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +                                struct cppc_perf_fb_ctrs fb_ctrs_t1);
> +
> +static void cppc_scale_freq_workfn(struct kthread_work *work)
> +{
> +       struct cppc_freq_invariance *cppc_fi;
> +       struct cppc_perf_fb_ctrs fb_ctrs = {0};
> +       struct cppc_cpudata *cpu_data;
> +       unsigned long local_freq_scale;
> +       u64 perf;
> +
> +       cppc_fi = container_of(work, struct cppc_freq_invariance, work);
> +       cpu_data = cppc_fi->cpu_data;
> +
> +       if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
> +               pr_warn("%s: failed to read perf counters\n", __func__);
> +               return;
> +       }
> +
> +       cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
> +       perf = cppc_perf_from_fbctrs(cpu_data, cppc_fi->prev_perf_fb_ctrs,
> +                                    fb_ctrs);
> +
> +       perf <<= SCHED_CAPACITY_SHIFT;
> +       local_freq_scale = div64_u64(perf, cpu_data->perf_caps.highest_perf);
> +       if (WARN_ON(local_freq_scale > 1024))
> +               local_freq_scale = 1024;
> +
> +       per_cpu(freq_scale, cppc_fi->cpu) = local_freq_scale;
> +}
> +
> +static void cppc_irq_work(struct irq_work *irq_work)
> +{
> +       struct cppc_freq_invariance *cppc_fi;
> +
> +       cppc_fi = container_of(irq_work, struct cppc_freq_invariance, irq_work);
> +       kthread_queue_work(kworker_fie, &cppc_fi->work);
> +}
> +
> +static void cppc_scale_freq_tick(void)
> +{
> +       struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, smp_processor_id());
> +
> +       /*
> +        * cppc_get_perf_ctrs() can potentially sleep, call that from the right
> +        * context.
> +        */
> +       irq_work_queue(&cppc_fi->irq_work);
> +}
> +
> +static struct scale_freq_data cppc_sftd = {
> +       .source = SCALE_FREQ_SOURCE_CPPC,
> +       .set_freq_scale = cppc_scale_freq_tick,
> +};
> +
> +static void cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
> +                                            struct cppc_cpudata *cpu_data)
> +{
> +       struct cppc_freq_invariance *cppc_fi;
> +       int i;
> +
> +       for_each_cpu(i, policy->cpus) {
> +               cppc_fi = &per_cpu(cppc_freq_inv, i);
> +               cppc_fi->cpu = i;
> +               cppc_fi->cpu_data = cpu_data;
> +       }
> +}
> +
> +static void cppc_freq_invariance_exit(void)
> +{
> +       struct cppc_freq_invariance *cppc_fi;
> +       int i;
> +
> +       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +               return;
> +
> +       topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpu_present_mask);
> +
> +       for_each_possible_cpu(i) {
> +               cppc_fi = &per_cpu(cppc_freq_inv, i);
> +               irq_work_sync(&cppc_fi->irq_work);
> +       }
> +
> +       kthread_destroy_worker(kworker_fie);
> +       kworker_fie = NULL;
> +}
> +
> +static void __init cppc_freq_invariance_init(void)
> +{
> +       struct cppc_perf_fb_ctrs fb_ctrs = {0};
> +       struct cppc_freq_invariance *cppc_fi;
> +       struct sched_attr attr = {
> +               .size           = sizeof(struct sched_attr),
> +               .sched_policy   = SCHED_DEADLINE,
> +               .sched_nice     = 0,
> +               .sched_priority = 0,
> +               /*
> +                * Fake (unused) bandwidth; workaround to "fix"
> +                * priority inheritance.
> +                */
> +               .sched_runtime  = 1000000,
> +               .sched_deadline = 10000000,
> +               .sched_period   = 10000000,
> +       };
> +       int i, ret;
> +
> +       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +               return;
> +
> +       kworker_fie = kthread_create_worker(0, "cppc_fie");
> +       if (IS_ERR(kworker_fie))
> +               return;
> +
> +       for_each_possible_cpu(i) {
> +               cppc_fi = &per_cpu(cppc_freq_inv, i);
> +
> +               /* A policy failed to initialize, abort */
> +               if (unlikely(!cppc_fi->cpu_data))
> +                       return cppc_freq_invariance_exit();
> +
> +               kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> +               init_irq_work(&cppc_fi->irq_work, cppc_irq_work);

What would be wrong with doing the above in
cppc_freq_invariance_policy_init()?  It looks like a better place to
me.

> +               ret = sched_setattr_nocheck(kworker_fie->task, &attr);

And this needs to be done only once if I'm not mistaken.

> +               if (ret) {
> +                       pr_warn("%s: failed to set SCHED_DEADLINE: %d\n",
> +                               __func__, ret);
> +                       return cppc_freq_invariance_exit();
> +               }
> +
> +               ret = cppc_get_perf_ctrs(i, &fb_ctrs);
> +               if (ret) {
> +                       pr_warn("%s: failed to read perf counters: %d\n",
> +                               __func__, ret);
> +                       return cppc_freq_invariance_exit();
> +               }
> +
> +               cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
> +       }
> +
> +       /* Register for freq-invariance */
> +       topology_set_scale_freq_source(&cppc_sftd, cpu_present_mask);
> +}
> +
> +#else
> +static inline void
> +cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
> +                                struct cppc_cpudata *cpu_data)
> +{
> +}
> +
> +static inline void cppc_freq_invariance_exit(void)
> +{
> +}
> +
> +static inline void cppc_freq_invariance_init(void)
> +{
> +}
> +#endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
> +
>  /* Callback function used to retrieve the max frequency from DMI */
>  static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
>  {
> @@ -355,9 +535,12 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>         cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>
>         ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> -       if (ret)
> +       if (ret) {
>                 pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>                          caps->highest_perf, cpu, ret);
> +       } else {
> +               cppc_freq_invariance_policy_init(policy, cpu_data);
> +       }
>
>         return ret;
>  }
> @@ -370,12 +553,12 @@ static inline u64 get_delta(u64 t1, u64 t0)
>         return (u32)t1 - (u32)t0;
>  }
>
> -static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
> -                                    struct cppc_perf_fb_ctrs fb_ctrs_t0,
> -                                    struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
> +                                struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +                                struct cppc_perf_fb_ctrs fb_ctrs_t1)
>  {
>         u64 delta_reference, delta_delivered;
> -       u64 reference_perf, delivered_perf;
> +       u64 reference_perf;
>
>         reference_perf = fb_ctrs_t0.reference_perf;
>
> @@ -384,12 +567,21 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
>         delta_delivered = get_delta(fb_ctrs_t1.delivered,
>                                     fb_ctrs_t0.delivered);
>
> -       /* Check to avoid divide-by zero */
> -       if (delta_reference || delta_delivered)
> -               delivered_perf = (reference_perf * delta_delivered) /
> -                                       delta_reference;
> -       else
> -               delivered_perf = cpu_data->perf_ctrls.desired_perf;
> +       /* Check to avoid divide-by zero and invalid delivered_perf */
> +       if (!delta_reference || !delta_delivered)
> +               return cpu_data->perf_ctrls.desired_perf;
> +
> +       return (reference_perf * delta_delivered) / delta_reference;
> +}
> +
> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
> +                                    struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +                                    struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +{
> +       u64 delivered_perf;
> +
> +       delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs_t0,
> +                                              fb_ctrs_t1);
>
>         return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>  }
> @@ -514,6 +706,8 @@ static void cppc_check_hisi_workaround(void)
>
>  static int __init cppc_cpufreq_init(void)
>  {
> +       int ret;
> +
>         if ((acpi_disabled) || !acpi_cpc_valid())
>                 return -ENODEV;
>
> @@ -521,7 +715,11 @@ static int __init cppc_cpufreq_init(void)
>
>         cppc_check_hisi_workaround();
>
> -       return cpufreq_register_driver(&cppc_cpufreq_driver);
> +       ret = cpufreq_register_driver(&cppc_cpufreq_driver);
> +       if (!ret)
> +               cppc_freq_invariance_init();
> +
> +       return ret;
>  }
>
>  static inline void free_cpu_data(void)
> @@ -538,6 +736,7 @@ static inline void free_cpu_data(void)
>
>  static void __exit cppc_cpufreq_exit(void)
>  {
> +       cppc_freq_invariance_exit();
>         cpufreq_unregister_driver(&cppc_cpufreq_driver);
>
>         free_cpu_data();
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 3bcfba5c21a7..47ac4b41c28d 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -37,6 +37,7 @@ bool topology_scale_freq_invariant(void);
>  enum scale_freq_source {
>         SCALE_FREQ_SOURCE_CPUFREQ = 0,
>         SCALE_FREQ_SOURCE_ARCH,
> +       SCALE_FREQ_SOURCE_CPPC,
>  };
>
>  struct scale_freq_data {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ca2bb629595f..3adedc7b1725 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6386,6 +6386,7 @@ int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
>  {
>         return __sched_setscheduler(p, attr, false, true);
>  }
> +EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
>
>  /**
>   * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
> --
> 2.25.0.rc1.19.g042ed3e048af
>
