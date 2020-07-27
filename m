Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5082622EDF2
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgG0Nwx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 09:52:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34598 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgG0Nwx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 09:52:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id a26so3556146otf.1;
        Mon, 27 Jul 2020 06:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoIlXcMF9D4zeeYXp6UIV7DtFwc5SM0pMI4P1+Jngt0=;
        b=PhDhku7wcRGPO2TcVoDlkzmXZfOUZdKZJikdeXgJvby1CyQa2Ju/NYj5od0Qz1qWGY
         t6+zwnDmDyQxYGFHmh5zC6IbN/xodrImP3qBlmujrhHbz8SGyma1S0uW4PdstZtYpgQV
         XFUt2m4d0e+e8ZJHupyZM1LGwT3FAl+NpoddNs3Bhs33tMIQBnEw3Czg1utvUibDCkdP
         dgibiznNWyd+ZeYpaifQFOHzGTePuKt6UnrPc2AyGXWZ8BbXl9FvDTFXHUD+g+ycF8BR
         BLPdjtrEGes1DowckY+uB5QwUCuyp5jKVSLCISVMqlzQvTVlavb4UYIsRgn1E8w9mNGF
         9Wlw==
X-Gm-Message-State: AOAM5336Tgk48D5bdvpWPVRRiAC2UVEzOrD6E4MpXiikkBcJjJ3sN28d
        8B+9G9c1aWwtFFNpqZCTG55qnEckkVUITyazLXk=
X-Google-Smtp-Source: ABdhPJz0eM8K7znzqJEUlA6BVvoNfTYawdzuFTAmQYRguizkocRok1Q5QrJvACM7dP3OmxvPAAYrFafrcmdq6gAQET8=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr20473486oth.262.1595857971989;
 Mon, 27 Jul 2020 06:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200722093732.14297-1-ionela.voinescu@arm.com> <20200722093732.14297-3-ionela.voinescu@arm.com>
In-Reply-To: <20200722093732.14297-3-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 15:52:41 +0200
Message-ID: <CAJZ5v0iiF75+POMF5oX8_NOBiLLqMQSYTTf-X0QoLAPV7fF0-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] cpufreq: set invariance scale factor on transition end
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
> While the move of the invariance setter calls (arch_set_freq_scale())
> from cpufreq drivers to cpufreq core maintained the previous
> functionality for existing drivers that use target_index() and
> fast_switch() for frequency switching, it also gives the possibility
> of adding support for users of the target() callback, which is exploited
> here.
>
> To be noted that the target() callback has been flagged as deprecated
> since:
>
> commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
>
> It also doesn't have that many users:
>
>   cpufreq-nforce2.c:371:2:      .target = nforce2_target,
>   cppc_cpufreq.c:416:2:         .target = cppc_cpufreq_set_target,
>   gx-suspmod.c:439:2:           .target = cpufreq_gx_target,
>   pcc-cpufreq.c:573:2:          .target = pcc_cpufreq_target,
>
> Similarly to the path taken for target_index() calls in the cpufreq core
> during a frequency change, all of the drivers above will mark the end of a
> frequency change by a call to cpufreq_freq_transition_end().
>
> Therefore, cpufreq_freq_transition_end() can be used as the location for
> the arch_set_freq_scale() call to potentially inform the scheduler of the
> frequency change.
>
> This change maintains the previous functionality for the drivers that
> implement the target_index() callback, while also adding support for the
> few drivers that implement the deprecated target() callback.
>
> Two notes are worthwhile here:
>  - In __target_index(), cpufreq_freq_transition_end() is called only for
>    drivers that have synchronous notifications enabled. There is only one
>    driver that disables them,
>
>    drivers/cpufreq/powernow-k8.c:1142: .flags = CPUFREQ_ASYNC_NOTIFICATION,
>
>    which is deprecated.
>
>  - Despite marking a successful frequency change, many cpufreq drivers
>    will populate the new policy->cur with the new requested frequency,
>    although this might not be the one granted by the hardware.
>
>    Therefore, the call to arch_set_freq_scale() is a "best effort" one,
>    and it is up to the architecture if the new frequency is used in the
>    new frequency scale factor setting or eventually used by the scheduler.
>    The architecture is in a better position to decide if it has better
>    methods to obtain more accurate information regarding the current
>    frequency (for example the use of counters).
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index bac4101546db..3497c1cd6818 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -448,6 +448,10 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>
>         cpufreq_notify_post_transition(policy, freqs, transition_failed);
>
> +       arch_set_freq_scale(policy->related_cpus,
> +                           policy->cur,
> +                           policy->cpuinfo.max_freq);
> +
>         policy->transition_ongoing = false;
>         policy->transition_task = NULL;
>
> @@ -2159,7 +2163,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>                             unsigned int relation)
>  {
>         unsigned int old_target_freq = target_freq;
> -       int index, retval;
> +       int index;
>
>         if (cpufreq_disabled())
>                 return -ENODEV;
> @@ -2190,14 +2194,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>
>         index = cpufreq_frequency_table_target(policy, target_freq, relation);
>
> -       retval = __target_index(policy, index);
> -
> -       if (!retval)
> -               arch_set_freq_scale(policy->related_cpus,
> -                                   policy->freq_table[index].frequency,
> -                                   policy->cpuinfo.max_freq);
> -
> -       return retval;
> +       return __target_index(policy, index);
>  }
>  EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
>
> --

I would fold this patch into the previous one.

I don't see much reason for it to be separate and it looks like
folding it in would cause the previous patch to be simpler.
