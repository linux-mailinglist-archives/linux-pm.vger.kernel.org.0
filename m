Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149143B07EB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFVOxb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 10:53:31 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:36742 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhFVOxa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 10:53:30 -0400
Received: by mail-oi1-f180.google.com with SMTP id r16so11560412oiw.3;
        Tue, 22 Jun 2021 07:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikdR2qd7ODXc0NnjAgqScSpE7yVB/MEFBaRgKO3qLbI=;
        b=a+pVMcemARtSaIQKs4/qa7dJepJ9zvs3ReA+K6vVjRif23o8jF0E05WBJC5Rccp6Ua
         T3PDgbrS5gZnwpLalcRz8Y3IXPma9JGOqo9NG2aNNtuQLimGqxIpCIzhdrEhP7cAEU//
         6hj+GU7ZmophEHftuO/QDmUvlp6+988Njknbly1ivxy82BSroXKhDgHDZV4a+NjEnv+s
         G6fmKNCRK1Ew/OEuOvJUUp9LL/9sxhjKt1s81ksgrRTOtBVxcEt/g5uZdah7Yac5H/AM
         Jo2Rh0Ws76lTPkQz1oVEFYK0FXjhmN1MR5XfBiJZD8rIz+8fFIvzmcuvwrVh7gRGp78H
         V/VQ==
X-Gm-Message-State: AOAM532owpkqGTqMFpzdTBkQ3iKBTdQ8HtaRYs4KBVdWSHJFwKL5fnFp
        UWs/KQ0FCjrPlSscvpZ8HXJcRz8emCTTxZBBdh/NHlqv
X-Google-Smtp-Source: ABdhPJyMhnA5198TjKEdO1lh7HWDPRDVu3Yv2on0cVxcjBU9SjPNouIaUK0k58sobKBDtFA3xoOA+1VWif6/D2TN+tQ=
X-Received: by 2002:a05:6808:8d9:: with SMTP id k25mr3337171oij.69.1624373474692;
 Tue, 22 Jun 2021 07:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210622075925.16189-1-lukasz.luba@arm.com> <20210622075925.16189-4-lukasz.luba@arm.com>
 <CAJZ5v0iVwpn0_wCZOh43DOeR2mudWYJyseMdtMsZGR-sjQ1X9Q@mail.gmail.com>
 <4e5476a6-fa9f-a9ef-ff26-8fa1b4bb90c0@arm.com> <CAJZ5v0i0KQwTWzbEPbs=0B-j7MkE6C1XP=mZaU1hhQm9HyZGJg@mail.gmail.com>
 <851205af-39d6-3864-bd28-ae84528946c4@arm.com>
In-Reply-To: <851205af-39d6-3864-bd28-ae84528946c4@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 16:51:03 +0200
Message-ID: <CAJZ5v0jiu=HpyGt7JpbFsS3dA1MWp9pi7K+wgP5gh+Xn3Jx9kA@mail.gmail.com>
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

On Tue, Jun 22, 2021 at 4:09 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/22/21 2:51 PM, Rafael J. Wysocki wrote:
> > On Tue, Jun 22, 2021 at 3:42 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 6/22/21 1:28 PM, Rafael J. Wysocki wrote:
> >>> On Tue, Jun 22, 2021 at 9:59 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>> The Active Stats framework tracks and accounts the activity of the CPU
> >>>> for each performance level. It accounts the real residency, when the CPU
> >>>> was not idle, at a given performance level. This patch adds needed calls
> >>>> which provide the CPU frequency transition events to the Active Stats
> >>>> framework.
> >>>>
> >>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >>>> ---
> >>>>    drivers/cpufreq/cpufreq.c | 5 +++++
> >>>>    1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >>>> index 802abc925b2a..d79cb9310572 100644
> >>>> --- a/drivers/cpufreq/cpufreq.c
> >>>> +++ b/drivers/cpufreq/cpufreq.c
> >>>> @@ -14,6 +14,7 @@
> >>>>
> >>>>    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >>>>
> >>>> +#include <linux/active_stats.h>
> >>>>    #include <linux/cpu.h>
> >>>>    #include <linux/cpufreq.h>
> >>>>    #include <linux/cpu_cooling.h>
> >>>> @@ -387,6 +388,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
> >>>>
> >>>>                   cpufreq_stats_record_transition(policy, freqs->new);
> >>>>                   policy->cur = freqs->new;
> >>>> +
> >>>> +               active_stats_cpu_freq_change(policy->cpu, freqs->new);
> >>>>           }
> >>>>    }
> >>>>
> >>>> @@ -2085,6 +2088,8 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> >>>>                               policy->cpuinfo.max_freq);
> >>>>           cpufreq_stats_record_transition(policy, freq);
> >>>>
> >>>> +       active_stats_cpu_freq_fast_change(policy->cpu, freq);
> >>>> +
> >>>
> >>> This is quite a bit of overhead and so why is it needed in addition to
> >>> the code below?
> >>
> >> The code below is tracing, which is good for post-processing. We use in
> >> our tool LISA, when we analyze the EAS decision, based on captured
> >> trace data.
> >>
> >> This new code is present at run time, so subsystems like our thermal
> >> governor IPA can use it and get better estimation about CPU used power
> >> for any arbitrary period, e.g. 50ms, 100ms, 300ms, ...
> >
> > So can it be made not run when the IPA is not using it?
>
> I can make a Kconfig for IPA to select this ACTIVE_STATS.
> Also, I can add description that this framework is mostly needed
> for IPA, so don't enable it if you don't use IPA (default is 'n'
> so it shouldn't harm others).
>
> This Active Stats shouldn't be stopped when thermal zone is switching
> between governors at run time, e.g. IPA -> step_wise -> IPA
> because when IPA is set next time, it might not have correct CPU
> stats (what is the current frequency and for how long it has been
> actively used).

But after a while it will collect enough useful data I suppose?

> Beside, switching governors at run time is not a good idea
> (apart from stress testing them ;) ).
>
> >
> >>>
> >>> And pretty much the same goes for the idle loop change.  There is
> >>> quite a bit of instrumentation in that code already and it avoids
> >>> adding new locking for a reason.  Why is it a good idea to add more
> >>> locking to that code?
> >>
> >> This active_stats_cpu_freq_fast_change() doesn't use the locking, it
> >> relies on schedutil lock in [1].
> >
> > Ah, OK.
> >
> > But it still adds overhead AFAICS.
>
> Agree, it's an extra code. For platforms which use IPA it's a
> justifiable cost, weighted by better estimation thanks to this calls.
> For other platforms, this framework will be set to default 'n' option.

A general problem with build-time configuration is for distros that
want to ship one kernel binary to run on multiple hardware platforms.
They need to enable those options anyway and then get the full cost on
the platforms that don't need it, but want to use the common binary
kernel.

Again, please consider making this new code run only when it is needed
even if configured in and if it runs, make it as low-overhead as
possible.
