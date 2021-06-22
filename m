Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90623B04A4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 14:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhFVMg3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 08:36:29 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43599 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhFVMg3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 08:36:29 -0400
Received: by mail-ot1-f48.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso21015720otu.10;
        Tue, 22 Jun 2021 05:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukJopPdTpEa+ImpsHAnJSt0S+hgCvfwUVOz1LgzX7Ks=;
        b=K/7ZJ+xVxHIh76wAuC5/E5xXT4cvEDgPhODNxJpdA/RBfGGUnL2OCMju5JU3rmPZCn
         OAMhLJrOKx3upnK11ag29dtHQSh2WCpMFztKtWCg1sn48G9jz3vddUTEzS4mSsqWRAjz
         tdeDHnNCPRf1L5KlcCGdeRCuUYdeNippnsftEbPdiujN0cLOLjQiTtq7+aiS1XpG5rGX
         2KT15siAlXHdiYC+3pp8uYNFvQURtV7j3ahxKu7lCFdxftVIONcA7WA0/Su6PHSQPAMw
         D7dBXOlhnl5YQVAMTmReXHKlYLtep9j4Xri177JJKSAk6kPLKHJ41Y880V6ZdUoouFZw
         LhhA==
X-Gm-Message-State: AOAM530IWdfAlGAXZITdB7zEB0MYwDxy81m8tt4I0F4huymkYHqweXi9
        i5yNdbdb6UR+yCrBn/jaxW1d+ifAoOtg8mixVfk=
X-Google-Smtp-Source: ABdhPJwPPzStcvS1Yu9sCQdl1M15jPrR6uHAm1d+c55oKiM4yG4Hm1H62+4vxR8Lmsrsa+zw938u7IdW/ZJGppFC2hA=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr2928120otm.260.1624365252125;
 Tue, 22 Jun 2021 05:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210622075925.16189-1-lukasz.luba@arm.com> <20210622075925.16189-3-lukasz.luba@arm.com>
In-Reply-To: <20210622075925.16189-3-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 14:33:59 +0200
Message-ID: <CAJZ5v0iGv_1d3BT0HowLgecOfhNHNQdOwH6Kef5WE4-zeBbp2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] cpuidle: Add Active Stats calls tracking idle entry/exit
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>, Beata.Michalska@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kachhap <amit.kachhap@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 9:59 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The Active Stats framework tracks and accounts the activity of the CPU
> for each performance level. It accounts the real residency,

No, it doesn't.  It just measures the time between the entry and exit
and that's not the real residency (because it doesn't take the exit
latency into account, for example).

> when the CPU was not idle, at a given performance level. This patch adds needed calls
> which provide the CPU idle entry/exit events to the Active Stats
> framework.

And it adds overhead to overhead-sensitive code.

AFAICS, some users of that code will not really get the benefit, so
adding the overhead to it is questionable.

First, why is the existing instrumentation in the idle loop insufficient?

Second, why do you need to add locking to this code?

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpuidle/cpuidle.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index ef2ea1b12cd8..24a33c6c4a62 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -8,6 +8,7 @@
>   * This code is licenced under the GPL.
>   */
>
> +#include <linux/active_stats.h>
>  #include <linux/clockchips.h>
>  #include <linux/kernel.h>
>  #include <linux/mutex.h>
> @@ -231,6 +232,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>         trace_cpu_idle(index, dev->cpu);
>         time_start = ns_to_ktime(local_clock());
>
> +       active_stats_cpu_idle_enter(time_start);
> +
>         stop_critical_timings();
>         if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
>                 rcu_idle_enter();
> @@ -243,6 +246,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>         time_end = ns_to_ktime(local_clock());
>         trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
>
> +       active_stats_cpu_idle_exit(time_end);
> +
>         /* The cpu is no longer idle or about to enter idle. */
>         sched_idle_set_state(NULL);
>
> --
> 2.17.1
>
