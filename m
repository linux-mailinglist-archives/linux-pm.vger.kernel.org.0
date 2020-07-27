Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292E022EDD0
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 15:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgG0Nsw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 09:48:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42891 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0Nsv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 09:48:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id v21so5065358otj.9;
        Mon, 27 Jul 2020 06:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G04O0/r0JtPjrA8T/yOTsq6lvTWvwXhHJzNHSD+Bvv0=;
        b=Gf359EdhteI4Nnq8Yld1iYnvTexUhH9eL8GOUhs/UP2BN6++DzC2jAzaiegIg8SAR6
         GgPsXH2riEdq/YZ5KGBsCkkftO8iyfdZ3snvhNvzvaU13qFDhjXKDAu0vRYshGVGN2T/
         5Tw6Opaf0JIVq8VySt11ydieDvi4SYdR6/WbmVl7/ZTC8HZ85D7LI9TIzpTXeInuNoMH
         YlVdh61tIoNiQtqhwmQJ/K84pm0V/UUIHk9siLcht/oAguHpNFtVYbf3gt7ZUC1cW4uC
         hgEWodd5x/1ie9cRSZcXvMjg9/UaRq1o3S32f4lgJ5DZ5YJkQiw6xXNTal8uuSKAKms4
         VtJg==
X-Gm-Message-State: AOAM531Csy/22jzx06rTDRHG2w2J9nWQ/lK4lcz3MGcilGELdEBWHb4p
        SejIt7TandJbMVFBjwQkalvsZUYyKojLo+slLGI=
X-Google-Smtp-Source: ABdhPJxQLiGqjTBzCpfevLDoRoDaKwlSc6cFqo2M+nGytqpin0EHVT6UPpVSxY5bGbBw9MjXXpk0V2Yid7ru5AgB5bY=
X-Received: by 2002:a9d:306:: with SMTP id 6mr10573023otv.167.1595857730290;
 Mon, 27 Jul 2020 06:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200722093732.14297-1-ionela.voinescu@arm.com> <20200722093732.14297-2-ionela.voinescu@arm.com>
In-Reply-To: <20200722093732.14297-2-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 15:48:39 +0200
Message-ID: <CAJZ5v0i5Xrk6oTt81aeXDi1F8gnEspJo9e6nGf10nSvBz-Dbkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] cpufreq: move invariance setter calls in cpufreq core
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 22, 2020 at 11:38 AM Ionela Voinescu
<ionela.voinescu@arm.com> wrote:
>
> From: Valentin Schneider <valentin.schneider@arm.com>
>
> To properly scale its per-entity load-tracking signals, the task scheduler
> needs to be given a frequency scale factor, i.e. some image of the current
> frequency the CPU is running at. Currently, this scale can be computed
> either by using counters (APERF/MPERF on x86, AMU on arm64), or by
> piggy-backing on the frequency selection done by cpufreq.
>
> For the latter, drivers have to explicitly set the scale factor
> themselves, despite it being purely boiler-plate code: the required
> information depends entirely on the kind of frequency switch callback
> implemented by the driver, i.e. either of: target_index(), target(),
> fast_switch() and setpolicy().
>
> The fitness of those callbacks with regard to driving the Frequency
> Invariance Engine (FIE) is studied below:
>
> target_index()
> ==============
> Documentation states that the chosen frequency "must be determined by
> freq_table[index].frequency". It isn't clear if it *has* to be that
> frequency, or if it can use that frequency value to do some computation
> that ultimately leads to a different frequency selection. All drivers
> go for the former, while the vexpress-spc-cpufreq has an atypical
> implementation which is handled separately.
>
> Therefore, the hook works on the assumption the core can use
> freq_table[index].frequency.
>
> target()
> =======
> This has been flagged as deprecated since:
>
>   commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
>
> It also doesn't have that many users:
>
>   cpufreq-nforce2.c:371:2:      .target = nforce2_target,
>   cppc_cpufreq.c:416:2:         .target = cppc_cpufreq_set_target,
>   gx-suspmod.c:439:2:           .target = cpufreq_gx_target,
>   pcc-cpufreq.c:573:2:          .target = pcc_cpufreq_target,

Also intel_pstate in the passive mode.

>
> Should we care about drivers using this hook, we may be able to exploit
> cpufreq_freq_transition_{being, end}(). This is handled in a separate
> patch.
>
> fast_switch()
> =============
> This callback *has* to return the frequency that was selected.
>
> setpolicy()
> ===========
> This callback does not have any designated way of informing what was the
> end choice. But there are only two drivers using setpolicy(), and none
> of them have current FIE support:
>
>   drivers/cpufreq/longrun.c:281:        .setpolicy      = longrun_set_policy,
>   drivers/cpufreq/intel_pstate.c:2215:  .setpolicy      = intel_pstate_set_policy,
>
> The intel_pstate is known to use counter-driven frequency invariance.
>
> Conclusion
> ==========
>
> Given that the significant majority of current FIE enabled drivers use
> callbacks that lend themselves to triggering the setting of the FIE scale
> factor in a generic way, move the invariance setter calls to cpufreq core.
>
> As a result of setting the frequency scale factor in cpufreq core, after
> callbacks that lend themselves to trigger it, remove this functionality
> from the driver side.
>
> To be noted that despite marking a successful frequency change, many
> cpufreq drivers will consider the new frequency as the requested
> frequency, although this is might not be the one granted by the hardware.
>
> Therefore, the call to arch_set_freq_scale() is a "best effort" one, and
> it is up to the architecture if the new frequency is used in the new
> frequency scale factor setting (determined by the implementation of
> arch_set_freq_scale()) or eventually used by the scheduler (determined
> by the implementation of arch_scale_freq_capacity()). The architecture
> is in a better position to decide if it has better methods to obtain
> more accurate information regarding the current frequency and use that
> information instead (for example, the use of counters).
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c           | 10 +---------
>  drivers/cpufreq/cpufreq.c              | 20 +++++++++++++++++---
>  drivers/cpufreq/qcom-cpufreq-hw.c      |  9 +--------
>  drivers/cpufreq/scmi-cpufreq.c         | 12 ++----------
>  drivers/cpufreq/scpi-cpufreq.c         |  6 +-----
>  drivers/cpufreq/vexpress-spc-cpufreq.c |  5 -----
>  6 files changed, 22 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 944d7b45afe9..9fd4ce774f12 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -40,16 +40,8 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
>  {
>         struct private_data *priv = policy->driver_data;
>         unsigned long freq = policy->freq_table[index].frequency;
> -       int ret;
> -
> -       ret = dev_pm_opp_set_rate(priv->cpu_dev, freq * 1000);
>
> -       if (!ret) {
> -               arch_set_freq_scale(policy->related_cpus, freq,
> -                                   policy->cpuinfo.max_freq);
> -       }
> -
> -       return ret;
> +       return dev_pm_opp_set_rate(priv->cpu_dev, freq * 1000);
>  }
>
>  /*
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 036f4cc42ede..bac4101546db 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2058,9 +2058,16 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>                                         unsigned int target_freq)
>  {
> +       unsigned int freq;
> +
>         target_freq = clamp_val(target_freq, policy->min, policy->max);
> +       freq = cpufreq_driver->fast_switch(policy, target_freq);
> +
> +       if (freq)
> +               arch_set_freq_scale(policy->related_cpus, freq,
> +                                   policy->cpuinfo.max_freq);

Why can't arch_set_freq_scale() handle freq == 0?
