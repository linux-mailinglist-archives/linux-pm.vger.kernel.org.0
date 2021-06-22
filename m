Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373CE3B0638
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhFVNy1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 09:54:27 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43876 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFVNy0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 09:54:26 -0400
Received: by mail-ot1-f44.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso21248164otu.10;
        Tue, 22 Jun 2021 06:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OE2Mk9QdTDme3m1WozqakgyokZ60Oww1ipgpJqvrp3c=;
        b=qwp14xglvFmTj+3RWJbaj2jXN3u8nPFSWUy6zGAQ6H+p83oNP2lzZZL4RTuRz1mCe6
         yBHsUAtGwuT78D818xb5NSriHZh8zcKBzLQ97nComMJsU/qt4/NQwoIxV+6eKExbRCJK
         4qguz9QHDEtONeh4xSSc0Iw690EZj6XQ57z1vOjhEJQMEijbZIoKbarPlTvIjZGNGAR9
         +86H2JTjOHlv0ewhiRutARZNeT63LgBC6kJp7ca/4f8FLoITYy+uwg8jOmTgWksYLSRj
         ZrWU7nDSn74tH/gBJ15RbyKJmYLV3hWQexeV6r2GmLiMB37+QYJNZnr8ZR8cTMAmU1dU
         5LDg==
X-Gm-Message-State: AOAM532KDn9KFz8y70mNkAbjQ7gfKn031ffojvaBqBLqM91D0mtYhzSr
        8dFbtb0btwEwPOsnyuhwfRwTPV6exJfaSaF9HYdSelvJ
X-Google-Smtp-Source: ABdhPJzRCtCGsPR6RmcfGaTG8OMcUVbw+kvFvbbHq9GlIsjJFxzKY5QtacJd/A0kc9ODZfW720T9G4vHtaJodE9sb9I=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr3220982otm.260.1624369929664;
 Tue, 22 Jun 2021 06:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210622075925.16189-1-lukasz.luba@arm.com> <20210622075925.16189-4-lukasz.luba@arm.com>
 <CAJZ5v0iVwpn0_wCZOh43DOeR2mudWYJyseMdtMsZGR-sjQ1X9Q@mail.gmail.com> <4e5476a6-fa9f-a9ef-ff26-8fa1b4bb90c0@arm.com>
In-Reply-To: <4e5476a6-fa9f-a9ef-ff26-8fa1b4bb90c0@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 15:51:58 +0200
Message-ID: <CAJZ5v0i0KQwTWzbEPbs=0B-j7MkE6C1XP=mZaU1hhQm9HyZGJg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] cpufreq: Add Active Stats calls tracking
 frequency changes
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Jun 22, 2021 at 3:42 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/22/21 1:28 PM, Rafael J. Wysocki wrote:
> > On Tue, Jun 22, 2021 at 9:59 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> The Active Stats framework tracks and accounts the activity of the CPU
> >> for each performance level. It accounts the real residency, when the CPU
> >> was not idle, at a given performance level. This patch adds needed calls
> >> which provide the CPU frequency transition events to the Active Stats
> >> framework.
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   drivers/cpufreq/cpufreq.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 802abc925b2a..d79cb9310572 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -14,6 +14,7 @@
> >>
> >>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >>
> >> +#include <linux/active_stats.h>
> >>   #include <linux/cpu.h>
> >>   #include <linux/cpufreq.h>
> >>   #include <linux/cpu_cooling.h>
> >> @@ -387,6 +388,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
> >>
> >>                  cpufreq_stats_record_transition(policy, freqs->new);
> >>                  policy->cur = freqs->new;
> >> +
> >> +               active_stats_cpu_freq_change(policy->cpu, freqs->new);
> >>          }
> >>   }
> >>
> >> @@ -2085,6 +2088,8 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> >>                              policy->cpuinfo.max_freq);
> >>          cpufreq_stats_record_transition(policy, freq);
> >>
> >> +       active_stats_cpu_freq_fast_change(policy->cpu, freq);
> >> +
> >
> > This is quite a bit of overhead and so why is it needed in addition to
> > the code below?
>
> The code below is tracing, which is good for post-processing. We use in
> our tool LISA, when we analyze the EAS decision, based on captured
> trace data.
>
> This new code is present at run time, so subsystems like our thermal
> governor IPA can use it and get better estimation about CPU used power
> for any arbitrary period, e.g. 50ms, 100ms, 300ms, ...

So can it be made not run when the IPA is not using it?

> >
> > And pretty much the same goes for the idle loop change.  There is
> > quite a bit of instrumentation in that code already and it avoids
> > adding new locking for a reason.  Why is it a good idea to add more
> > locking to that code?
>
> This active_stats_cpu_freq_fast_change() doesn't use the locking, it
> relies on schedutil lock in [1].

Ah, OK.

But it still adds overhead AFAICS.

> >
> >>          if (trace_cpu_frequency_enabled()) {
> >>                  for_each_cpu(cpu, policy->cpus)
> >>                          trace_cpu_frequency(freq, cpu);
> >> --
>
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/cpufreq_schedutil.c#L447
