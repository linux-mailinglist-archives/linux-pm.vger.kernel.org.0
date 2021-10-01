Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1482D41F533
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 20:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhJASyw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 14:54:52 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36430 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhJASyw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 14:54:52 -0400
Received: by mail-oi1-f171.google.com with SMTP id y201so12609423oie.3;
        Fri, 01 Oct 2021 11:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LeRZ4siCQNNShxombOIyD9QXy3lIZzLXSiHOTCmsFWk=;
        b=j75zY7l2+DNye95CK2yVICKr3ppssjubvfzrlr7hWLdzcW2Tpd30940HnDyFGKj679
         9g1E9MXQS1Sti8VSgs9p8+f+1Q+luDq5EVERgvWdywkOQjmHk4lvb3HO4RTydC9LRn8f
         N4nvk91QJWWMRD+Yv/6VqrD996GtQi6Yr+IbKadIJSWwgjziHJVnYM9lrQrILlYWBvRp
         So9xWqZYNIqjBuZcU04/KAJDiE6hHy6quBfhDEjmjI9pRf1bkBq8VZrCRFUGQz/Y1F0d
         EQp8oezzdJ5XYYb2mpwvJo72DVdeiW0DeaQHQ6z6d5ykjaIymzN60TjnMtz8Z/UingmO
         02ig==
X-Gm-Message-State: AOAM5316iMlkx8xQUsXwG3Sao35KS9QsJHtOmTRHX6UkX3e5iSK2XGql
        7wS7XbNiYnAFxZqp92ajbmTM0mjMUnc9ic5m3pU=
X-Google-Smtp-Source: ABdhPJx+1wlbEORb+lwxHZDGnTQbx5Q/8vGXb/WTMNv/knz87rJ1qBuZKsiTwCQvc12I86WZvcIIaWYikGfUt0476+o=
X-Received: by 2002:a54:4f15:: with SMTP id e21mr5180052oiy.71.1633114387553;
 Fri, 01 Oct 2021 11:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210928164217.950960-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20210928164217.950960-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Oct 2021 20:52:56 +0200
Message-ID: <CAJZ5v0jzbm5xnFSceQNmZjDQ0eU=i_f_WnDcoa05rEQ083mDkg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Process HWP Guaranteed change notification
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, pablomh@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 28, 2021 at 6:42 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> It is possible that HWP guaranteed ratio is changed in response to
> change in power and thermal limits. For example when Intel Speed Select
> performance profile is changed or there is change in TDP, hardware can
> send notifications. It is possible that the guaranteed ratio is
> increased. This creates an issue when turbo is disabled, as the old
> limits set in MSR_HWP_REQUEST are still lower and hardware will clip
> to older limits.
>
> This change enables HWP interrupt and process HWP interrupts. When
> guaranteed is changed, calls cpufreq_update_policy() so that driver
> callbacks are called to update to new HWP limits. This callback
> is called from a delayed workqueue of 10ms to avoid frequent updates.
>
> Although the scope of IA32_HWP_INTERRUPT is per logical cpu, on some
> plaforms interrupt is generated on all CPUs. This is particularly a
> problem during initialization, when the driver didn't allocated
> data for other CPUs. So this change uses a cpumask of enabled CPUs and
> process interrupts on those CPUs only.
>
> When the cpufreq offline() or suspend()callback is called, HWP interrupt
> is disabled on those CPUs and also cancels any pending work item.
>
> Spin lock is used to protect data and processing shared with interrupt
> handler. Here READ_ONCE(), WRITE_ONCE() macros are used to designate
> shared data, even though spin lock act as an optmization barrier here.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> This patch is a replacement from the patch submitted to 5.15 and later
> reverted.

Applied as 5.16 material, thanks!

>  drivers/cpufreq/intel_pstate.c | 117 +++++++++++++++++++++++++++++++--
>  1 file changed, 111 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8c176b7dae41..facc56dd58dd 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -32,6 +32,7 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/cpufeature.h>
>  #include <asm/intel-family.h>
> +#include "../drivers/thermal/intel/thermal_interrupt.h"
>
>  #define INTEL_PSTATE_SAMPLING_INTERVAL (10 * NSEC_PER_MSEC)
>
> @@ -219,6 +220,7 @@ struct global_params {
>   * @sched_flags:       Store scheduler flags for possible cross CPU update
>   * @hwp_boost_min:     Last HWP boosted min performance
>   * @suspended:         Whether or not the driver has been suspended.
> + * @hwp_notify_work:   workqueue for HWP notifications.
>   *
>   * This structure stores per CPU instance data for all CPUs.
>   */
> @@ -257,6 +259,7 @@ struct cpudata {
>         unsigned int sched_flags;
>         u32 hwp_boost_min;
>         bool suspended;
> +       struct delayed_work hwp_notify_work;
>  };
>
>  static struct cpudata **all_cpu_data;
> @@ -985,11 +988,15 @@ static void intel_pstate_hwp_set(unsigned int cpu)
>         wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
>  }
>
> +static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata);
> +
>  static void intel_pstate_hwp_offline(struct cpudata *cpu)
>  {
>         u64 value = READ_ONCE(cpu->hwp_req_cached);
>         int min_perf;
>
> +       intel_pstate_disable_hwp_interrupt(cpu);
> +
>         if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
>                 /*
>                  * In case the EPP has been set to "performance" by the
> @@ -1053,6 +1060,9 @@ static int intel_pstate_suspend(struct cpufreq_policy *policy)
>
>         cpu->suspended = true;
>
> +       /* disable HWP interrupt and cancel any pending work */
> +       intel_pstate_disable_hwp_interrupt(cpu);
> +
>         return 0;
>  }
>
> @@ -1546,15 +1556,105 @@ static void intel_pstate_sysfs_hide_hwp_dynamic_boost(void)
>
>  /************************** sysfs end ************************/
>
> +static void intel_pstate_notify_work(struct work_struct *work)
> +{
> +       struct cpudata *cpudata =
> +               container_of(to_delayed_work(work), struct cpudata, hwp_notify_work);
> +
> +       cpufreq_update_policy(cpudata->cpu);
> +       wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
> +}
> +
> +static DEFINE_SPINLOCK(hwp_notify_lock);
> +static cpumask_t hwp_intr_enable_mask;
> +
> +void notify_hwp_interrupt(void)
> +{
> +       unsigned int this_cpu = smp_processor_id();
> +       struct cpudata *cpudata;
> +       unsigned long flags;
> +       u64 value;
> +
> +       if (!READ_ONCE(hwp_active) || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> +               return;
> +
> +       rdmsrl_safe(MSR_HWP_STATUS, &value);
> +       if (!(value & 0x01))
> +               return;
> +
> +       spin_lock_irqsave(&hwp_notify_lock, flags);
> +
> +       if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
> +               goto ack_intr;
> +
> +       /*
> +        * Currently we never free all_cpu_data. And we can't reach here
> +        * without this allocated. But for safety for future changes, added
> +        * check.
> +        */
> +       if (unlikely(!READ_ONCE(all_cpu_data)))
> +               goto ack_intr;
> +
> +       /*
> +        * The free is done during cleanup, when cpufreq registry is failed.
> +        * We wouldn't be here if it fails on init or switch status. But for
> +        * future changes, added check.
> +        */
> +       cpudata = READ_ONCE(all_cpu_data[this_cpu]);
> +       if (unlikely(!cpudata))
> +               goto ack_intr;
> +
> +       schedule_delayed_work(&cpudata->hwp_notify_work, msecs_to_jiffies(10));
> +
> +       spin_unlock_irqrestore(&hwp_notify_lock, flags);
> +
> +       return;
> +
> +ack_intr:
> +       wrmsrl_safe(MSR_HWP_STATUS, 0);
> +       spin_unlock_irqrestore(&hwp_notify_lock, flags);
> +}
> +
> +static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
> +{
> +       unsigned long flags;
> +
> +       /* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
> +       wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
> +
> +       spin_lock_irqsave(&hwp_notify_lock, flags);
> +       if (cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask))
> +               cancel_delayed_work(&cpudata->hwp_notify_work);
> +       spin_unlock_irqrestore(&hwp_notify_lock, flags);
> +}
> +
> +static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
> +{
> +       /* Enable HWP notification interrupt for guaranteed performance change */
> +       if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
> +               unsigned long flags;
> +
> +               spin_lock_irqsave(&hwp_notify_lock, flags);
> +               INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
> +               cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
> +               spin_unlock_irqrestore(&hwp_notify_lock, flags);
> +
> +               /* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
> +               wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
> +       }
> +}
> +
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>  {
> -       /* First disable HWP notification interrupt as we don't process them */
> +       /* First disable HWP notification interrupt till we activate again */
>         if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
>                 wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
>
>         wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
>         if (cpudata->epp_default == -EINVAL)
>                 cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
> +
> +       intel_pstate_enable_hwp_interrupt(cpudata);
>  }
>
>  static int atom_get_min_pstate(void)
> @@ -2266,7 +2366,7 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>                 if (!cpu)
>                         return -ENOMEM;
>
> -               all_cpu_data[cpunum] = cpu;
> +               WRITE_ONCE(all_cpu_data[cpunum], cpu);
>
>                 cpu->cpu = cpunum;
>
> @@ -2929,8 +3029,10 @@ static void intel_pstate_driver_cleanup(void)
>                         if (intel_pstate_driver == &intel_pstate)
>                                 intel_pstate_clear_update_util_hook(cpu);
>
> +                       spin_lock(&hwp_notify_lock);
>                         kfree(all_cpu_data[cpu]);
> -                       all_cpu_data[cpu] = NULL;
> +                       WRITE_ONCE(all_cpu_data[cpu], NULL);
> +                       spin_unlock(&hwp_notify_lock);
>                 }
>         }
>         cpus_read_unlock();
> @@ -3199,6 +3301,7 @@ static bool intel_pstate_hwp_is_enabled(void)
>
>  static int __init intel_pstate_init(void)
>  {
> +       static struct cpudata **_all_cpu_data;
>         const struct x86_cpu_id *id;
>         int rc;
>
> @@ -3224,7 +3327,7 @@ static int __init intel_pstate_init(void)
>                  * deal with it.
>                  */
>                 if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) || hwp_forced) {
> -                       hwp_active++;
> +                       WRITE_ONCE(hwp_active, 1);
>                         hwp_mode_bdw = id->driver_data;
>                         intel_pstate.attr = hwp_cpufreq_attrs;
>                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> @@ -3275,10 +3378,12 @@ static int __init intel_pstate_init(void)
>
>         pr_info("Intel P-state driver initializing\n");
>
> -       all_cpu_data = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> -       if (!all_cpu_data)
> +       _all_cpu_data = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> +       if (!_all_cpu_data)
>                 return -ENOMEM;
>
> +       WRITE_ONCE(all_cpu_data, _all_cpu_data);
> +
>         intel_pstate_request_control_from_smm();
>
>         intel_pstate_sysfs_expose_params();
> --
> 2.31.1
>
