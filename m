Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0487C439870
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 16:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhJYO1L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 10:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhJYO1L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 10:27:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C9C061745
        for <linux-pm@vger.kernel.org>; Mon, 25 Oct 2021 07:24:48 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o11so17003208ljg.10
        for <linux-pm@vger.kernel.org>; Mon, 25 Oct 2021 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCLWc6tK++jiN9zGsXc9TCTyw2tPvCSesyYp3yxB14g=;
        b=OmTNf9PSVGw0ESwpLkP8gP6NADKkE7bFUzZbw5aV7age4uqgYkOoXg1irhnL7DtsS+
         sfkGCuw741zT27U72lvHAFGE1Oi8aqMDz9GDZWDXLgpoElk5bY3GkYrY06yTy3hedAGY
         SsOLhVlJsdRe7Zh4HhD73T9AHN5QhM/LAwR3drP1o23k0XztZXaxvA7KAeutpcqDrDVf
         BEMtPHOCEmBZr7vhoHd5KWM7h9EI1Z+RJRr0m0o/nBt/YNeysm7m+Kqrg19J7MbctIUe
         g97IVFawwldnecLY7kSqyf0Oy07XiNdN53wdFr2rT+Un/JH7TMsHco0yeHic5CjFO/oz
         zz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCLWc6tK++jiN9zGsXc9TCTyw2tPvCSesyYp3yxB14g=;
        b=pc2VzR9KNUGQMPipXmAiwLbcqvtoBmLAhH+WUkgJh0Tk64XShaWtGKwkAyrD2V+v9i
         T3BP4dxLZRUO0u9Vcma06Eg0e5lfGEEQZ6KWTf1EGsyq+pkxpkjbVWipn7KDj0PEIwFY
         0T/hPIBn2hcB4hz4iD6OoCm3MLBgDzccx89a8SeD057Hkf9vN7/fhgTzdtA3fOPKgRfM
         eUw87qZ7f0uFIxFkEaiTMB8f6wmF9CqFWixcxluBtRJxhtctQxQB9YvsbZsnG/vRskf9
         YmlcjZSI+YAT5f9OqQAzU7dOG5eK4Q8YOPwnZ/+AS8x8unhfS+e+CZC0NG5Yr+I3MxXg
         qQ1w==
X-Gm-Message-State: AOAM533W4d0K7/dl0v3Sad6wCwymig8RSB2W7iGXMSQpGM50ZfB0LCcf
        bHLeb+MQjtPkabSr6IovCkIEAjd0t9SVrjjMeq/jMg==
X-Google-Smtp-Source: ABdhPJzHiy7PdDc4xSqR3BgEttEbPVn2weofwhPQAt8vYuWmB6roFr9pOh2Z9Noa48dPvEspq2J5hnRmytmXVGcCKX0=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr20112969ljp.367.1635171886990;
 Mon, 25 Oct 2021 07:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <2230995.ElGaqSPkdT@kreacher> <2813389.e9J7NaK4W3@kreacher>
In-Reply-To: <2813389.e9J7NaK4W3@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Oct 2021 16:24:10 +0200
Message-ID: <CAPDyKFoVGgCNz6AMUpwSwodJvEQN0L1LoaNQ4-A2sDn_K1RfSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Pause cpuidle later and resume it earlier
 during system transitions
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 22 Oct 2021 at 18:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 8651f97bd951 ("PM / cpuidle: System resume hang fix with
> cpuidle") that introduced cpuidle pausing during system suspend
> did that to work around a platform firmware issue causing systems
> to hang during resume if CPUs were allowed to enter idle states
> in the system suspend and resume code paths.
>
> However, pausing cpuidle before the last phase of suspending
> devices is the source of an otherwise arbitrary difference between
> the suspend-to-idle path and other system suspend variants, so it is
> cleaner to do that later, before taking secondary CPUs offline (it
> is still safer to take secondary CPUs offline with cpuidle paused,
> though).
>
> Modify the code accordingly, but in order to avoid code duplication,
> introduce new wrapper functions, pm_sleep_disable_secondary_cpus()
> and pm_sleep_enable_secondary_cpus(), to combine cpuidle_pause()
> and cpuidle_resume(), respectively, with the handling of secondary
> CPUs during system-wide transitions to sleep states.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |    8 +-------
>  kernel/power/hibernate.c  |   12 +++++++-----
>  kernel/power/power.h      |   14 ++++++++++++++
>  kernel/power/suspend.c    |   10 ++--------
>  4 files changed, 24 insertions(+), 20 deletions(-)
>
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -403,9 +403,6 @@ static int suspend_enter(suspend_state_t
>         if (error)
>                 goto Devices_early_resume;
>
> -       if (state != PM_SUSPEND_TO_IDLE)
> -               cpuidle_pause();
> -
>         error = dpm_suspend_noirq(PMSG_SUSPEND);
>         if (error) {
>                 pr_err("noirq suspend of devices failed\n");
> @@ -423,7 +420,7 @@ static int suspend_enter(suspend_state_t
>                 goto Platform_wake;
>         }
>
> -       error = suspend_disable_secondary_cpus();
> +       error = pm_sleep_disable_secondary_cpus();
>         if (error || suspend_test(TEST_CPUS))
>                 goto Enable_cpus;
>
> @@ -453,16 +450,13 @@ static int suspend_enter(suspend_state_t
>         BUG_ON(irqs_disabled());
>
>   Enable_cpus:
> -       suspend_enable_secondary_cpus();
> +       pm_sleep_enable_secondary_cpus();
>
>   Platform_wake:
>         platform_resume_noirq(state);
>         dpm_resume_noirq(PMSG_RESUME);
>
>   Platform_early_resume:
> -       if (state != PM_SUSPEND_TO_IDLE)
> -               cpuidle_resume();
> -
>         platform_resume_early(state);
>
>   Devices_early_resume:
> Index: linux-pm/kernel/power/hibernate.c
> ===================================================================
> --- linux-pm.orig/kernel/power/hibernate.c
> +++ linux-pm/kernel/power/hibernate.c
> @@ -300,7 +300,7 @@ static int create_image(int platform_mod
>         if (error || hibernation_test(TEST_PLATFORM))
>                 goto Platform_finish;
>
> -       error = suspend_disable_secondary_cpus();
> +       error = pm_sleep_disable_secondary_cpus();
>         if (error || hibernation_test(TEST_CPUS))
>                 goto Enable_cpus;
>
> @@ -342,7 +342,7 @@ static int create_image(int platform_mod
>         local_irq_enable();
>
>   Enable_cpus:
> -       suspend_enable_secondary_cpus();
> +       pm_sleep_enable_secondary_cpus();
>
>         /* Allow architectures to do nosmt-specific post-resume dances */
>         if (!in_suspend)
> @@ -466,6 +466,8 @@ static int resume_target_kernel(bool pla
>         if (error)
>                 goto Cleanup;
>
> +       cpuidle_pause();
> +
>         error = hibernate_resume_nonboot_cpu_disable();
>         if (error)
>                 goto Enable_cpus;
> @@ -509,7 +511,7 @@ static int resume_target_kernel(bool pla
>         local_irq_enable();
>
>   Enable_cpus:
> -       suspend_enable_secondary_cpus();
> +       pm_sleep_enable_secondary_cpus();
>
>   Cleanup:
>         platform_restore_cleanup(platform_mode);
> @@ -587,7 +589,7 @@ int hibernation_platform_enter(void)
>         if (error)
>                 goto Platform_finish;
>
> -       error = suspend_disable_secondary_cpus();
> +       error = pm_sleep_disable_secondary_cpus();
>         if (error)
>                 goto Enable_cpus;
>
> @@ -609,7 +611,7 @@ int hibernation_platform_enter(void)
>         local_irq_enable();
>
>   Enable_cpus:
> -       suspend_enable_secondary_cpus();
> +       pm_sleep_enable_secondary_cpus();
>
>   Platform_finish:
>         hibernation_ops->finish();
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -32,7 +32,6 @@
>  #include <linux/suspend.h>
>  #include <trace/events/power.h>
>  #include <linux/cpufreq.h>
> -#include <linux/cpuidle.h>
>  #include <linux/devfreq.h>
>  #include <linux/timer.h>
>
> @@ -879,7 +878,6 @@ void dpm_resume_early(pm_message_t state
>  void dpm_resume_start(pm_message_t state)
>  {
>         dpm_resume_noirq(state);
> -       cpuidle_resume();
>         dpm_resume_early(state);
>  }
>  EXPORT_SYMBOL_GPL(dpm_resume_start);
> @@ -1518,13 +1516,9 @@ int dpm_suspend_end(pm_message_t state)
>         if (error)
>                 goto out;
>
> -       cpuidle_pause();
> -
>         error = dpm_suspend_noirq(state);
> -       if (error) {
> -               cpuidle_resume();
> +       if (error)
>                 dpm_resume_early(resume_event(state));
> -       }
>
>  out:
>         dpm_show_time(starttime, state, error, "end");
> Index: linux-pm/kernel/power/power.h
> ===================================================================
> --- linux-pm.orig/kernel/power/power.h
> +++ linux-pm/kernel/power/power.h
> @@ -4,6 +4,8 @@
>  #include <linux/utsname.h>
>  #include <linux/freezer.h>
>  #include <linux/compiler.h>
> +#include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>
>  struct swsusp_info {
>         struct new_utsname      uts;
> @@ -310,3 +312,15 @@ extern int pm_wake_lock(const char *buf)
>  extern int pm_wake_unlock(const char *buf);
>
>  #endif /* !CONFIG_PM_WAKELOCKS */
> +
> +static inline int pm_sleep_disable_secondary_cpus(void)
> +{
> +       cpuidle_pause();
> +       return suspend_disable_secondary_cpus();
> +}
> +
> +static inline void pm_sleep_enable_secondary_cpus(void)
> +{
> +       suspend_enable_secondary_cpus();
> +       cpuidle_resume();
> +}
>
>
>
