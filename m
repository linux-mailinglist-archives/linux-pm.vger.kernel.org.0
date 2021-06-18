Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E5E3ACA82
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 14:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFRMDP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 08:03:15 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44892 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFRMDO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 08:03:14 -0400
Received: by mail-ot1-f41.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so2811541ote.11;
        Fri, 18 Jun 2021 05:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUMzu/K3B6PimF7v/SKPUw8+mIM9nScsj4NJiw7kNYY=;
        b=HKxxDJRN31u5tezSAqPCn255Ex/5ygIIZMl01jJi/vhcpdQSqQYNZu/GeEPeby4YJS
         jhxK3P7BYsqLUcXOcE80v3/GqrW5/eQJSfyvEOaBfT6nr8QuWnsAw9dOYYeXQ2/oG3Vk
         0W8JueMOM+elHI+JYolA+l30ele7ejpTtgfdU3ZIlv6+/pBgSVtrcYVzY1ERXvQ0wd3o
         fiER3zOkkpVX6CTX2LD7dJwB8T3NIxE49Hecyl6cIWX/EEee7sldEJ14OeuyjR+3I9rC
         SbX59wyQFQiuufxywABmH++pwM2KIIepec292qBiugfH7Iv+g2sw8mGcvhVgIaizcP4+
         sOUg==
X-Gm-Message-State: AOAM531MnJnwleA9n+yGQPcG2lwhF3gVGPoXy2jSknFQlwQeNZe1dUU5
        0YlffYF7G2GAiPeo3Ppk3E/xpzDA0QzplbuC9xo=
X-Google-Smtp-Source: ABdhPJwXy4gTSGVhvCzM3rJDQWci+0jDQzP22arVzZyHcAroQNPEwD2D91i6XX7OIJMe5YXGbHGZHnDQZ5sqlvAZ6wI=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr9458774otb.206.1624017665309;
 Fri, 18 Jun 2021 05:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <5c8da9d378dee39d9c6063713b093f51d271fa9d.1623825358.git.viresh.kumar@linaro.org>
 <c31424b7962608eb13f946a665ba6848c4986856.1623986349.git.viresh.kumar@linaro.org>
In-Reply-To: <c31424b7962608eb13f946a665ba6848c4986856.1623986349.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jun 2021 14:00:54 +0200
Message-ID: <CAJZ5v0h37bs0xLUCeD7ZuZfXLPBx=6Mpr-Y+Ef=qcnDA4aoLbQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] cpufreq: intel_pstate: Migrate away from
 ->stop_cpu() callback
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 18, 2021 at 5:22 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
> interface") added the stop_cpu() callback to allow the drivers to do
> clean up before the CPU is completely down and its state can't be
> modified.
>
> At that time the CPU hotplug framework used to call the cpufreq core's
> registered notifier for different events like CPU_DOWN_PREPARE and
> CPU_POST_DEAD. The stop_cpu() callback was called during the
> CPU_DOWN_PREPARE event.
>
> This is no longer the case, cpuhp_cpufreq_offline() is called only once
> by the CPU hotplug core now and we don't really need to separately
> call stop_cpu() for cpufreq drivers.
>
> Migrate to using the exit() and offline() callbacks instead of
> stop_cpu().
>
> We need to clear util hook from both the callbacks, exit() and
> offline(), since it is possible that only exit() gets called sometimes
> (specially on errors) or both get called at other times.
> intel_pstate_clear_update_util_hook() anyway have enough protection in
> place if it gets called a second time and will return early then.
>
> Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2->V3:
> - Update intel_pstate_cpu_offline() as well.
> - Improved commit log.
>
>  drivers/cpufreq/intel_pstate.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 0e69dffd5a76..8f8a2d9d7daa 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2335,6 +2335,8 @@ static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
>
>         pr_debug("CPU %d going offline\n", cpu->cpu);
>
> +       intel_pstate_clear_update_util_hook(policy->cpu);
> +
>         if (cpu->suspended)
>                 return 0;
>
> @@ -2374,17 +2376,12 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
>         return 0;
>  }
>
> -static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
> -{
> -       pr_debug("CPU %d stopping\n", policy->cpu);
> -
> -       intel_pstate_clear_update_util_hook(policy->cpu);
> -}
> -
>  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
>  {
>         pr_debug("CPU %d exiting\n", policy->cpu);
>
> +       intel_pstate_clear_update_util_hook(policy->cpu);

This change is not needed now, because ->offline always runs before
->exit if present.

> +
>         policy->fast_switch_possible = false;
>
>         return 0;
> @@ -2451,7 +2448,6 @@ static struct cpufreq_driver intel_pstate = {
>         .resume         = intel_pstate_resume,
>         .init           = intel_pstate_cpu_init,
>         .exit           = intel_pstate_cpu_exit,
> -       .stop_cpu       = intel_pstate_stop_cpu,
>         .offline        = intel_pstate_cpu_offline,
>         .online         = intel_pstate_cpu_online,
>         .update_limits  = intel_pstate_update_limits,
> --
> 2.31.1.272.g89b43f80a514
>
