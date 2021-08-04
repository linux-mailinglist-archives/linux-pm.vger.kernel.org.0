Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E293E0770
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhHDSUP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 14:20:15 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:47044 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhHDSUO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 14:20:14 -0400
Received: by mail-oi1-f175.google.com with SMTP id o185so3831811oih.13;
        Wed, 04 Aug 2021 11:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQtRG+kcJY8+d+MzcBYysp8mkLiIFLkwgsiApH3VJfI=;
        b=B09JOd+F76m/3aq5g2vnA+0uGmOqErCCbPgaDQuePSm9l4Gt/XXbGwbr++6rlB3TP/
         kyw/NgoiAKlQkEtHZB9trkyHm9NTTTPfppOtUaXEoF54GsIs1MGcisCHnBrbPozn+J0d
         C+hZJWBezSGrHDV67U9YR4TW96/xc1NSSEUeKJSKY0tFo8BihsmOuNyDhcL9Ya3bXYGF
         jn3WTsOSYwdzgQ+mt4iIzS3GClG0bcVBEgRJ1AjIxp87XBbuSuD8C/3Gk1WceGUsoPs1
         BBM+KG2F5pcPCzmaIKgGisIGjRh4TkdKPauw1KBWPIp04AM4qsY9r1Xfmo8KCFPiYQZj
         V2qg==
X-Gm-Message-State: AOAM531gMHoNjQzaOAIvfDFKZacdT9CK+wNEh33f+hCdrc57Hbznf6AL
        ZOTyTUAs97Kf6zb3gvB8PsVzEw/IG0GU9RgGsdM=
X-Google-Smtp-Source: ABdhPJwBHYsAfqwY0SwVu2njyN3i4m9YHXdC+LOAuyTQUd0TFN3J3Uwq8gGRFTMzZTK85RSVu9R+cWh5eeua1H9RYlA=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr578297oib.71.1628101200721;
 Wed, 04 Aug 2021 11:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210803141621.780504-1-bigeasy@linutronix.de> <20210803141621.780504-29-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-29-bigeasy@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 20:19:49 +0200
Message-ID: <CAJZ5v0giGz92S-9yVw4bLdoZtRFGZw7KqcX8jPZz7k0FQVuBEw@mail.gmail.com>
Subject: Re: [PATCH 28/38] cpufreq: Replace deprecated CPU-hotplug functions.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 3, 2021 at 4:17 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
>
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
>
> Cc: linux-pm@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/cpufreq/acpi-cpufreq.c     | 4 ++--
>  drivers/cpufreq/cpufreq.c          | 6 +++---
>  drivers/cpufreq/cpufreq_ondemand.c | 4 ++--
>  drivers/cpufreq/intel_pstate.c     | 4 ++--
>  drivers/cpufreq/powernow-k8.c      | 6 +++---
>  drivers/cpufreq/powernv-cpufreq.c  | 4 ++--
>  6 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 7e7450453714d..b49612895c786 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -163,9 +163,9 @@ static ssize_t store_cpb(struct cpufreq_policy *policy, const char *buf,
>         if (ret || val > 1)
>                 return -EINVAL;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         set_boost(policy, val);
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         return count;
>  }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 45f3416988f1a..06c526d66dd38 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2654,18 +2654,18 @@ int cpufreq_boost_trigger_state(int state)
>         cpufreq_driver->boost_enabled = state;
>         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         for_each_active_policy(policy) {
>                 ret = cpufreq_driver->set_boost(policy, state);
>                 if (ret)
>                         goto err_reset_state;
>         }
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         return 0;
>
>  err_reset_state:
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         write_lock_irqsave(&cpufreq_driver_lock, flags);
>         cpufreq_driver->boost_enabled = !state;
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index ac361a8b1d3bb..eb4320b619c9c 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -418,7 +418,7 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
>         default_powersave_bias = powersave_bias;
>         cpumask_clear(&done);
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         for_each_online_cpu(cpu) {
>                 struct cpufreq_policy *policy;
>                 struct policy_dbs_info *policy_dbs;
> @@ -442,7 +442,7 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
>                 od_tuners = dbs_data->tuners;
>                 od_tuners->powersave_bias = default_powersave_bias;
>         }
> -       put_online_cpus();
> +       cpus_read_unlock();
>  }
>
>  void od_register_powersave_bias_handler(unsigned int (*f)
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index bb4549959b113..2d83a9f9651b0 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2969,7 +2969,7 @@ static void intel_pstate_driver_cleanup(void)
>  {
>         unsigned int cpu;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         for_each_online_cpu(cpu) {
>                 if (all_cpu_data[cpu]) {
>                         if (intel_pstate_driver == &intel_pstate)
> @@ -2979,7 +2979,7 @@ static void intel_pstate_driver_cleanup(void)
>                         all_cpu_data[cpu] = NULL;
>                 }
>         }
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         intel_pstate_driver = NULL;
>  }
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index b9ccb6a3dad98..12ab4014af712 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1180,7 +1180,7 @@ static int powernowk8_init(void)
>         if (!x86_match_cpu(powernow_k8_ids))
>                 return -ENODEV;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         for_each_online_cpu(i) {
>                 smp_call_function_single(i, check_supported_cpu, &ret, 1);
>                 if (!ret)
> @@ -1188,10 +1188,10 @@ static int powernowk8_init(void)
>         }
>
>         if (supported_cpus != num_online_cpus()) {
> -               put_online_cpus();
> +               cpus_read_unlock();
>                 return -ENODEV;
>         }
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         ret = cpufreq_register_driver(&cpufreq_amd64_driver);
>         if (ret)
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 005600cef2730..23a06cba392cd 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -918,7 +918,7 @@ static void powernv_cpufreq_work_fn(struct work_struct *work)
>         unsigned int cpu;
>         cpumask_t mask;
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         cpumask_and(&mask, &chip->mask, cpu_online_mask);
>         smp_call_function_any(&mask,
>                               powernv_cpufreq_throttle_check, NULL, 0);
> @@ -939,7 +939,7 @@ static void powernv_cpufreq_work_fn(struct work_struct *work)
>                 cpufreq_cpu_put(policy);
>         }
>  out:
> -       put_online_cpus();
> +       cpus_read_unlock();
>  }
>
>  static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
> --

Applied as 5.15 material, thanks!
