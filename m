Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DAF3B045B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhFVMak (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 08:30:40 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:42861 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhFVMaj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 08:30:39 -0400
Received: by mail-ot1-f45.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so20949762oth.9;
        Tue, 22 Jun 2021 05:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHtNQpCSXG22FMwHUu24sGvKayaAtRpBNbls39GRY0k=;
        b=fxRUVIhQfUbgt5T28jgXCetyExXj9U+0+MbKqK+yaXfRNHrGdaD/U+T68jXd3KPnDc
         0K57wLEUozn5sflb8WAq6TqjWVbVYB059M7mX8LIjaG9614rUP5FKagJSt3IcuyS7anR
         IuYcBb99Llp06nSdT2YBbDcvb433K+k1/rDvJ1xiE+EHZFaIp3FsJTbCobFO5O3Dh5Mq
         qAQ7EF9w6dkHKsIgU4AMp6rFXzWCkU/rtPZBFr0I8dnpwxax7wRrVccL5FAhobbzTlHH
         mQZt9oTWifEzVukglDcanE5yMre3teo2iA403N9Dm7tAgywcT+gUam8fb/hMqNIrtnDb
         8nFA==
X-Gm-Message-State: AOAM531NUKTy0qzycz/5Hv3S2P1Lw1MdW0ssG8AlDVjUDNd1W0dCm63V
        COWj7GSK3B3ZHVxZ9AXO0LkzN2eQA/nK/61dpOU=
X-Google-Smtp-Source: ABdhPJz11edPPEwIzAWit6kBhVDryZmRqBd5EY+LP4jHB0+T2TRFdm9ADW+e6N24AglBRWbewC8GNKXh8rFIBXNmq2c=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr3061137otb.206.1624364903953;
 Tue, 22 Jun 2021 05:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210622075925.16189-1-lukasz.luba@arm.com> <20210622075925.16189-4-lukasz.luba@arm.com>
In-Reply-To: <20210622075925.16189-4-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 14:28:11 +0200
Message-ID: <CAJZ5v0iVwpn0_wCZOh43DOeR2mudWYJyseMdtMsZGR-sjQ1X9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] cpufreq: Add Active Stats calls tracking
 frequency changes
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
> for each performance level. It accounts the real residency, when the CPU
> was not idle, at a given performance level. This patch adds needed calls
> which provide the CPU frequency transition events to the Active Stats
> framework.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 802abc925b2a..d79cb9310572 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -14,6 +14,7 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/active_stats.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpu_cooling.h>
> @@ -387,6 +388,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>
>                 cpufreq_stats_record_transition(policy, freqs->new);
>                 policy->cur = freqs->new;
> +
> +               active_stats_cpu_freq_change(policy->cpu, freqs->new);
>         }
>  }
>
> @@ -2085,6 +2088,8 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>                             policy->cpuinfo.max_freq);
>         cpufreq_stats_record_transition(policy, freq);
>
> +       active_stats_cpu_freq_fast_change(policy->cpu, freq);
> +

This is quite a bit of overhead and so why is it needed in addition to
the code below?

And pretty much the same goes for the idle loop change.  There is
quite a bit of instrumentation in that code already and it avoids
adding new locking for a reason.  Why is it a good idea to add more
locking to that code?

>         if (trace_cpu_frequency_enabled()) {
>                 for_each_cpu(cpu, policy->cpus)
>                         trace_cpu_frequency(freq, cpu);
> --
