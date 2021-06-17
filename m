Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6093AB4D1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhFQNfk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 09:35:40 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:44943 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhFQNfi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 09:35:38 -0400
Received: by mail-ot1-f49.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso6109852otm.11;
        Thu, 17 Jun 2021 06:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uplD831DStQ1N/g38yxe3fctKRp7RZTAFl6NF9p1dbY=;
        b=kxxxpEI4hgadW2aXn3wj4HTYEEBQDyazhddReLhOPoI2Eve3CR4SLJfNRL1IgD3Fwe
         GNASat72jNyefOeqe+v6A9sJ4i72qbdHiXjKAj43Xk0yELfhSRvXompJHbO9PFjKi87J
         nQggP4TuA6I4UZuFqvRc5/VdPzesuIsmhQ0rGvXsAbMhiSAIUHsePFoz/22m9V7ZQHkl
         9CS5LRquA/h6UH/i3LNkcYwe8igQoKvdP/eX7m0gUp9Ldb3eegvSN2Ol9B9fQFrP3zJj
         ezl12AY02u2eQvk2yhaw4wBB4nxcV7vhJa7rHryWn9uUAAUGgNmozoonejIGTPdjKSzZ
         nDlw==
X-Gm-Message-State: AOAM5313R8o+cboj9D4F+prAyFkcmRsFMG5AT9f2hrFpilCoUzTr+atC
        6ANSthPREI71EppkDSf99yGIqstXYxuJbVxPkvw=
X-Google-Smtp-Source: ABdhPJyG8Xb3s9HktdqJ9NAE4FVQBVWDaCtM5GohFPMProI+vxpB8hmOShZpLaQkUC4E/9UT2N+fZqvqjtL1k+zires=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr4796335otb.206.1623936811005;
 Thu, 17 Jun 2021 06:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623825725.git.viresh.kumar@linaro.org> <2ffbaf079a21c2810c402cb5bba4e9c14c4a0ff4.1623825725.git.viresh.kumar@linaro.org>
In-Reply-To: <2ffbaf079a21c2810c402cb5bba4e9c14c4a0ff4.1623825725.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 15:33:19 +0200
Message-ID: <CAJZ5v0gBUMXs=oANZRuOO7uUVdSD-n1inwYsoLr5or=2gEa2Mg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] cpufreq: Add start_cpu() and stop_cpu() callbacks
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 16, 2021 at 8:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On CPU hot-unplug, the cpufreq core doesn't call any driver specific
> callback unless all the CPUs of a policy went away, in which case we
> call stop_cpu() callback.
>
> For the CPPC cpufreq driver, we need to perform per-cpu init/exit work
> which that can't be performed from policy specific init()/exit()
> callbacks.
>
> This patch adds a new callback, start_cpu() and modifies the stop_cpu()
> callback, to perform such CPU specific work.
>
> These routines are called whenever a CPU is added or removed from a
> policy.
>
> Note that this also moves the setting of policy->cpus to online CPUs
> only, outside of rwsem as we needed to call start_cpu() for online CPUs
> only. This shouldn't have any side effects.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/cpu-freq/cpu-drivers.rst |  7 +++++--
>  drivers/cpufreq/cpufreq.c              | 19 +++++++++++++++----
>  include/linux/cpufreq.h                |  5 ++++-
>  3 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
> index a697278ce190..15cfe42b4075 100644
> --- a/Documentation/cpu-freq/cpu-drivers.rst
> +++ b/Documentation/cpu-freq/cpu-drivers.rst
> @@ -71,8 +71,11 @@ And optionally
>   .exit - A pointer to a per-policy cleanup function called during
>   CPU_POST_DEAD phase of cpu hotplug process.
>
> - .stop_cpu - A pointer to a per-policy stop function called during
> - CPU_DOWN_PREPARE phase of cpu hotplug process.
> + .start_cpu - A pointer to a per-policy per-cpu start function called
> + during CPU online phase.
> +
> + .stop_cpu - A pointer to a per-policy per-cpu stop function called
> + during CPU offline phase.
>
>   .suspend - A pointer to a per-policy suspend function which is called
>   with interrupts disabled and _after_ the governor is stopped for the
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 802abc925b2a..128dfb1b0cdf 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1119,6 +1119,10 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
>
>         cpumask_set_cpu(cpu, policy->cpus);
>
> +       /* Do CPU specific initialization if required */
> +       if (cpufreq_driver->start_cpu)
> +               cpufreq_driver->start_cpu(policy, cpu);
> +
>         if (has_target()) {
>                 ret = cpufreq_start_governor(policy);
>                 if (ret)
> @@ -1375,13 +1379,19 @@ static int cpufreq_online(unsigned int cpu)
>                 cpumask_copy(policy->related_cpus, policy->cpus);
>         }
>
> -       down_write(&policy->rwsem);
>         /*
>          * affected cpus must always be the one, which are online. We aren't
>          * managing offline cpus here.
>          */
>         cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>
> +       /* Do CPU specific initialization if required */
> +       if (cpufreq_driver->start_cpu) {
> +               for_each_cpu(j, policy->cpus)
> +                       cpufreq_driver->start_cpu(policy, j);
> +       }
> +
> +       down_write(&policy->rwsem);
>         if (new_policy) {
>                 for_each_cpu(j, policy->related_cpus) {
>                         per_cpu(cpufreq_cpu_data, j) = policy;
> @@ -1581,6 +1591,10 @@ static int cpufreq_offline(unsigned int cpu)
>                 policy->cpu = cpumask_any(policy->cpus);
>         }
>
> +       /* Do CPU specific de-initialization if required */
> +       if (cpufreq_driver->stop_cpu)
> +               cpufreq_driver->stop_cpu(policy, cpu);
> +
>         /* Start governor again for active policy */
>         if (!policy_is_inactive(policy)) {
>                 if (has_target()) {
> @@ -1597,9 +1611,6 @@ static int cpufreq_offline(unsigned int cpu)
>                 policy->cdev = NULL;
>         }
>
> -       if (cpufreq_driver->stop_cpu)
> -               cpufreq_driver->stop_cpu(policy);
> -

This should be a separate patch IMO, after you've migrated everyone to
->offline/->exit.

BTW, IMO it might be better to migrate ->stop_cpu to ->offline rather
than to ->exit.

>         if (has_target())
>                 cpufreq_exit_governor(policy);
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 353969c7acd3..c281b3df4e2f 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -371,7 +371,10 @@ struct cpufreq_driver {
>         int             (*online)(struct cpufreq_policy *policy);
>         int             (*offline)(struct cpufreq_policy *policy);
>         int             (*exit)(struct cpufreq_policy *policy);
> -       void            (*stop_cpu)(struct cpufreq_policy *policy);
> +
> +       /* CPU specific start/stop */
> +       void            (*start_cpu)(struct cpufreq_policy *policy, unsigned int cpu);
> +       void            (*stop_cpu)(struct cpufreq_policy *policy, unsigned int cpu);
>         int             (*suspend)(struct cpufreq_policy *policy);
>         int             (*resume)(struct cpufreq_policy *policy);
>
> --
> 2.31.1.272.g89b43f80a514
>
