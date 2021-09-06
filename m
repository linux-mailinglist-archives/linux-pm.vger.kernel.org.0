Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC6E401E22
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 18:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhIFQSo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 12:18:44 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:35400 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243804AbhIFQSn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 12:18:43 -0400
Received: by mail-oo1-f41.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so2121777oon.2;
        Mon, 06 Sep 2021 09:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tA/MucpEY8ZuGUVf58Grzx6UujU8J+E/O9wTb0bVLHk=;
        b=C5IU9YT1vz0OtiLY+/WYTBtpvX7OutxRz3YN1RuLf3rLrsCAMmPXAuMC9u/h3XJBC+
         V9oFrXPyVzqxPD1Wuq7FvQKlXUv/q3wefRMT7aS452FqfIlXb9xkSOepbmyuAFiphu3B
         +9ya945b+apIQjMioaPEpOJNjhdcwTw57EUZJsDAnBVNnAnbB401LtfTmKtFzL56Cd30
         spN1jksHy12Lod6kd6PQ5vYHK/OOiUSZ55iqqv90NO0y3OlmLRxqG6zbkm9UCmqm3/S4
         2u2Z4UXXLrungwq7Zo22f/xQMJOdBLBXhA00AXhJl0C/HZQ/94aWF/dT6EGhrI2GIBOH
         xEew==
X-Gm-Message-State: AOAM531ixaVt9krr5sdCmrYF+pt3Tr9tmlXfeuT0BcUU44Z1ItakH/Gi
        SPmZ+2NIYhcpPFH3FU03Vxslj2wsERD/2r+ENLtn59xB/H4=
X-Google-Smtp-Source: ABdhPJzqjyzDMTGlsIh5ttvDR1OWNj8OwTdwtNtIZwqFvNNXOWjHbMakb3yFaRpVQjmiZ9E8KKs7filoqMquVNWcocQ=
X-Received: by 2002:a4a:a552:: with SMTP id s18mr14585968oom.1.1630945057954;
 Mon, 06 Sep 2021 09:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210904053703.581297-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20210904053703.581297-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Sep 2021 18:17:27 +0200
Message-ID: <CAJZ5v0hQp8Hxf__tL22s0oOcTym5mx9tND34ijufTDE3_NSW6A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix for HWP interrupt before
 driver is ready
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Sep 4, 2021 at 7:37 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> In Lenovo X1 gen9 laptop, HWP interrupts arrive before driver is ready
> to handle on that CPU. Basically didn't even allocated memory for per
> cpu data structure and not even started interrupt enable process on that
> CPU. So interrupt handler observes a NULL pointer to schedule work.
>
> This interrupt was probably for SMM, but since it is redirected to
> OS by OSC call, OS receives it, but not ready to handle. That redirection
> of interrupt to OS was also done to solve one SMM crash on Yoga 260 for
> HWP interrupt a while back.
>
> To solve this the HWP interrupt handler should ignore such request if the
> driver is not ready. This will require some flag to wait till the driver
> setup a workqueue to handle on a CPU. We can't simply assume cpudata to
> be NULL and avoid processing as it may not be NULL but data structure is
> not in consistent state.
>
> So created a cpumask which sets the CPU on which interrupt was setup. If
> not setup, simply clear the interrupt status and return. Since the
> similar issue can happen during S3 resume, clear the bit during offline.
>
> Since interrupt timing may be before HWP is enabled, use safe MSR read
> writes as before the change for HWP interrupt.
>
> Fixes: d0e936adbd22 ("cpufreq: intel_pstate: Process HWP Guaranteed change notification")
> Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index b4ffe6c8a0d0..5ac86bfa1080 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -298,6 +298,8 @@ static bool hwp_boost __read_mostly;
>
>  static struct cpufreq_driver *intel_pstate_driver __read_mostly;
>
> +static cpumask_t hwp_intr_enable_mask;
> +
>  #ifdef CONFIG_ACPI
>  static bool acpi_ppc;
>  #endif
> @@ -1067,11 +1069,15 @@ static void intel_pstate_hwp_set(unsigned int cpu)
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
> @@ -1645,20 +1651,35 @@ void notify_hwp_interrupt(void)
>         if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
>                 return;
>
> -       rdmsrl(MSR_HWP_STATUS, value);
> +       rdmsrl_safe(MSR_HWP_STATUS, &value);
>         if (!(value & 0x01))
>                 return;
>
> +       if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask)) {
> +               wrmsrl_safe(MSR_HWP_STATUS, 0);
> +               return;
> +       }

Without additional locking, there is a race between this and
intel_pstate_disable_hwp_interrupt().

1. notify_hwp_interrupt() checks hwp_intr_enable_mask() and the target
CPU is in there, so it will go for scheduling the delayed work.
2. intel_pstate_disable_hwp_interrupt() runs between the check and the
cpudata load below.
3. hwp_notify_work is scheduled on the CPU that isn't there in the
mask any more.

I think that this should be avoided?

> +
>         cpudata = all_cpu_data[this_cpu];
>         schedule_delayed_work_on(this_cpu, &cpudata->hwp_notify_work, msecs_to_jiffies(10));
>  }
>
> +static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
> +{
> +
> +       if (cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask)) {
> +               wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
> +               cancel_delayed_work_sync(&cpudata->hwp_notify_work);
> +       }
> +}
> +
>  static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
>  {
>         /* Enable HWP notification interrupt for guaranteed performance change */
>         if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
>                 INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
>                 wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
> +               cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
>         }
>  }
>
> --
> 2.31.1
>
