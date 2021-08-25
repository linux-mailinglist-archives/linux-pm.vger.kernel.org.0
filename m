Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE73F7C0E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Aug 2021 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhHYSMC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Aug 2021 14:12:02 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:41697 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhHYSMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Aug 2021 14:12:02 -0400
Received: by mail-oo1-f49.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso71901ooq.8;
        Wed, 25 Aug 2021 11:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpcvr3wsH/0+uMmFyZBQHvL6hlaoyNWVH8S6h4BXx28=;
        b=Eu61w5oaOmBgT3Z5ELtrN3BZMicHrYxecDjn0YmGIgMAtKf1ipIxO7CwDvLXizRmqP
         l0mNdEnvdIOlISn+AOz+eoZMJUsXIyiiMeQj85HD784KoQOSH9C2KdZrjbREoMNvCFBt
         3JOZrM9Zz6IRACkTvQ9+18n7VZ4a3UNJYx168hl63NsRszV0y+cYnnbEhyFMvGEdZSlh
         DqUE98GEE26pXzJunQnvoJi0fgx6HGkcDMPXCP6T0IxVFDHp+JdvKAgRFVrSMQSNkCNB
         dXbb6BK9ob6rCgl7jB5tVi9tWZrmz/UZ7H9fKtnDhSWDGAW+xSc2nnTPJXIHYUzSTeak
         XeYQ==
X-Gm-Message-State: AOAM530eI+zKA2/SnX+ByqwIHDPN9fvUHeAMOUfsPihJEb9EmMmA/9Pd
        yRWiaNOMgnyBu3E6Jbv+wYFFdby65/MkT0pS5lg=
X-Google-Smtp-Source: ABdhPJy9qjo30rEmuYI/rdvfLQwm+jTFvw9V9GUe56bADFlUzAHcjHFtiaB1BVI2D2ITLn4yiJxFeK3tDkMIo3OjCpc=
X-Received: by 2002:a4a:ca83:: with SMTP id x3mr13476790ooq.2.1629915075634;
 Wed, 25 Aug 2021 11:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210820024006.2347720-1-srinivas.pandruvada@linux.intel.com> <20210820024006.2347720-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20210820024006.2347720-2-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Aug 2021 20:11:04 +0200
Message-ID: <CAJZ5v0gjh7k5Zingv06b-bwFG9E+SZysW6GJQA8pwcTsMqEjCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Process HWP Guaranteed change notification
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 20, 2021 at 4:40 AM Srinivas Pandruvada
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
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied along with the [1/2] as 5.15 material, thanks!

> ---
>  drivers/cpufreq/intel_pstate.c | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index bb4549959b11..0fd2375c1f1e 100644
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
> @@ -1625,6 +1628,40 @@ static void intel_pstate_sysfs_hide_hwp_dynamic_boost(void)
>
>  /************************** sysfs end ************************/
>
> +static void intel_pstate_notify_work(struct work_struct *work)
> +{
> +       mutex_lock(&intel_pstate_driver_lock);
> +       cpufreq_update_policy(smp_processor_id());
> +       wrmsrl(MSR_HWP_STATUS, 0);
> +       mutex_unlock(&intel_pstate_driver_lock);
> +}
> +
> +void notify_hwp_interrupt(void)
> +{
> +       unsigned int this_cpu = smp_processor_id();
> +       struct cpudata *cpudata;
> +       u64 value;
> +
> +       if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> +               return;
> +
> +       rdmsrl(MSR_HWP_STATUS, value);
> +       if (!(value & 0x01))
> +               return;
> +
> +       cpudata = all_cpu_data[this_cpu];
> +       schedule_delayed_work_on(this_cpu, &cpudata->hwp_notify_work, msecs_to_jiffies(10));
> +}
> +
> +static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
> +{
> +       /* Enable HWP notification interrupt for guaranteed performance change */
> +       if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
> +               INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
> +               wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
> +       }
> +}
> +
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>  {
>         /* First disable HWP notification interrupt as we don't process them */
> @@ -1634,6 +1671,8 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>         wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
>         if (cpudata->epp_default == -EINVAL)
>                 cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
> +
> +       intel_pstate_enable_hwp_interrupt(cpudata);
>  }
>
>  static int atom_get_min_pstate(void)
> --
> 2.31.1
>
