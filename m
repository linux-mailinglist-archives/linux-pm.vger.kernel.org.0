Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2212CA6AE
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 16:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbgLAPIz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 10:08:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32971 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389268AbgLAPIz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 10:08:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id n12so1947674otk.0;
        Tue, 01 Dec 2020 07:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=los6TBVHUGFOLU6abZox4dFWWCfO+L91/MjJw40kkl8=;
        b=Hr+j2GJujk6vI/0wpzkyhOq3tkJ3vmgNeeyf4uFAkikghl4/FJOWpcNkBd2WYdrA1p
         KIHT9T+/VEUU1EeEFEjQto2G1M2XXdHcQ14A04fFL7Jc/wxbTE9XYJaJFieSE7m75dAz
         Xs0g1da8cNCkKGYSfaPq/E9U6fmsS1m+oxtDdiOIOJBkAu3JtYD9Fcwy6ZqIvquhP70o
         85T/frCmOzVvw/jfaVwy0PbPbLz/fTcQ4nf8pSlD6IkniniULjcQG1nO7SCkTjymvVNd
         MWyNjZRnc5a6pxaL6+aBSdc6f6Qg4r2ZLOsxW+j2uxWVFT2E+tIYj5whsspoRKNGql8W
         W1tA==
X-Gm-Message-State: AOAM533jgt7ZkfSWepkz1ylF1N2mCK7sMOOSRR1N629pknIo+IYEBGCY
        exLnBozcn3sBIVxjPoFDPTduwjRKEQZwqiry8bc=
X-Google-Smtp-Source: ABdhPJzasLJcr6mm7QWdQ6GYqhY6AJYSmvKmprGaTNhSnJzXA25+Ss6jPLVVJUsS/q8Ml6co6ThKVP6oImndIGCCZ2U=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr2112608ota.260.1606835293523;
 Tue, 01 Dec 2020 07:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20201130092241.GR3371@techsingularity.net> <CAJZ5v0h-ZBUMKqP5om7h67iMTe87GUf2Bw5dJ9tQN6MKwaTWzA@mail.gmail.com>
 <20201130223202.GT3371@techsingularity.net>
In-Reply-To: <20201130223202.GT3371@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Dec 2020 16:08:02 +0100
Message-ID: <CAJZ5v0gMyMhjmFwV=j2+iu21K+upvrt0m_d-b5nFE5EfccNHjg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Select polling interval based on a c-state with
 a longer target residency
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 30, 2020 at 11:32 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Nov 30, 2020 at 08:06:44PM +0100, Rafael J. Wysocki wrote:
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 526d65d8573a..5b8545022564 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -719,6 +719,24 @@
> > >                         policy to use. This governor must be registered in the
> > >                         kernel before the cpufreq driver probes.
> > >
> > > +       cpuidle.poll=
> > > +                       [CPU_IDLE]
> > > +                       Format: <int>
> > > +                       Set the time in microseconds a CPU should poll in
> > > +                       cpuidle for a new task before entering a sleep
> > > +                       state. The default is determined by either the
> > > +                       tick or the enabled c-state latencies. Tuning is
> > > +                       not generally recommended but it may be needed
> > > +                       for workloads that are both latency-sensitive
> > > +                       and idling rapidly for short durations. Limiting
> > > +                       c-states can be insufficient if the polling
> > > +                       time is still too short, the application has no
> > > +                       knowledge of /dev/cpu_dma_latency, there are
> > > +                       multiple applications or the environment does
> > > +                       not allow the installation of a userspace tool
> > > +                       that controls cpu_dma_latency. This value may
> > > +                       be ignored by the idle governor (e.g. haltpoll).
> >
> > OK, we can do this, but I'd use a shorter different description here
> > and a more detailed one in the admin-guide documentation.
> >
> > Also this is about certain drivers only which support the "polling
> > idle state" (the ACPI one and intel_idle only AFAICS).  So I'm not
> > sure about the framework-level tunable here.
> >
> > Moreover, to be precise, that value is the maximum time to do the
> > polling (in one go) in the case when requesting any "physical" idle
> > states is likely to hurt energy-efficiency or latency.  In particular,
> > it doesn't mean that idle CPUs will do the idle polling every time.
> >
>
> At first I was nodding along and thinking "sure". Then I started
> thinking about what the configuration space then looks like and how a
> user might reasonably interpret it. You were right during the review of
> the first version, it's a mess because it's driver specific and difficult
> to interpret even on a per-driver basis because there is no control of
> when a rescheduling event may occur.

Indeed.

> You suggest making poll=0 would be valid but that might be interpreted
> as being equivalent to idle=poll on x86 which is not the same thing.
> processor_idle and intel_idle would have understandable semantics if the
> parameter was maxpoll but it's not as understandable for haltpoll.

Well, my point was basically that if the plan was to add a boot
parameter to control the polling behavior, it would be prudent to also
allow the admin to specify that they didn't want any polling at all.

But frankly I was hoping to drive you away from that idea which seems
to have worked. :-)

> Finally, the parameter partially ties us into the current
> implementation. For example, the polling loop is based on clock time but
> we know looking up the clock is costly in itself so it's very granular
> based on the magic "check every 200 loops" logic meaning we can go over
> the expected maxiumum polling inverval. If we ever changed that into a
> calibration loop to estimate the number of loops then the polling interval
> changes slightly even for the same parameter as we no longer depend on the
> granularity of calling local_clock. If we ever decided to use adaptive
> polling similar to haltpoll then the behaviour changes again resulting
> in bugs because the driver.poll parameter means something new.

Right.

> Using min_cstate was definitely a hazard because it showed up in both
> microbenchmarks and real workloads but you were right, lets only
> introduce a tunable when and if there is no other choice in the matter.
>
> So, informally the following patch is the next candidate. I'm happy to
> resend it as a separate mail if you prefer and think the patch is ok.

I actually can apply it right away, so no need to resend.

Many thanks for looking into this!

> --8<--
> cpuidle: Select polling interval based on a c-state with a longer target residency
>
> It was noted that a few workloads that idle rapidly regressed when commit
> 36fcb4292473 ("cpuidle: use first valid target residency as poll time")
> was merged. The workloads in question were heavy communicators that idle
> rapidly and were impacted by the c-state exit latency as the active CPUs
> were not polling at the time of wakeup. As they were not particularly
> realistic workloads, it was not considered to be a major problem.
>
> Unfortunately, a bug was reported for a real workload in a production
> environment that relied on large numbers of threads operating in a worker
> pool pattern. These threads would idle for periods of time longer than the
> C1 target residency and so incurred the c-state exit latency penalty. The
> application is very sensitive to wakeup latency and indirectly relying
> on behaviour prior to commit on a37b969a61c1 ("cpuidle: poll_state: Add
> time limit to poll_idle()") to poll for long enough to avoid the exit
> latency cost.
>
> The target residency of C1 is typically very short. On some x86 machines,
> it can be as low as 2 microseconds. In poll_idle(), the clock is checked
> every POLL_IDLE_RELAX_COUNT interations of cpu_relax() and even one
> iteration of that loop can be over 1 microsecond so the polling interval is
> very close to the granularity of what poll_idle() can detect. Furthermore,
> a basic ping pong workload like perf bench pipe has a longer round-trip
> time than the 2 microseconds meaning that the CPU will almost certainly
> not be polling when the ping-pong completes.
>
> This patch selects a polling interval based on an enabled c-state that
> has an target residency longer than 10usec. If there is no enabled-cstate
> then polling will be up to a TICK_NSEC/16 similar to what it was up until
> kernel 4.20. Polling for a full tick is unlikely (rescheduling event)
> and is much longer than the existing target residencies for a deep c-state.
>
> As an example, consider a CPU with the following c-state information from
> an Intel CPU;
>
>         residency       exit_latency
> C1      2               2
> C1E     20              10
> C3      100             33
> C6      400             133
>
> The polling interval selected is 20usec. If booted with
> intel_idle.max_cstate=1 then the polling interval is 250usec as the deeper
> c-states were not available.
>
> On an AMD EPYC machine, the c-state information is more limited and
> looks like
>
>         residency       exit_latency
> C1      2               1
> C2      800             400
>
> The polling interval selected is 250usec. While C2 was considered, the
> polling interval was clamped by CPUIDLE_POLL_MAX.
>
> Note that it is not expected that polling will be a universal win. As
> well as potentially trading power for performance, the performance is not
> guaranteed if the extra polling prevented a turbo state being reached.
> Making it a tunable was considered but it's driver-specific, may be
> overridden by a governor and is not a guaranteed polling interval making
> it difficult to describe without knowledge of the implementation.
>
> tbench4
>                              vanilla                polling
> Hmean     1        497.89 (   0.00%)      543.15 *   9.09%*
> Hmean     2        975.88 (   0.00%)     1059.73 *   8.59%*
> Hmean     4       1953.97 (   0.00%)     2081.37 *   6.52%*
> Hmean     8       3645.76 (   0.00%)     4052.95 *  11.17%*
> Hmean     16      6882.21 (   0.00%)     6995.93 *   1.65%*
> Hmean     32     10752.20 (   0.00%)    10731.53 *  -0.19%*
> Hmean     64     12875.08 (   0.00%)    12478.13 *  -3.08%*
> Hmean     128    21500.54 (   0.00%)    21098.60 *  -1.87%*
> Hmean     256    21253.70 (   0.00%)    21027.18 *  -1.07%*
> Hmean     320    20813.50 (   0.00%)    20580.64 *  -1.12%*
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  drivers/cpuidle/cpuidle.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 83af15f77f66..ef2ea1b12cd8 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -368,6 +368,19 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
>                 cpuidle_curr_governor->reflect(dev, index);
>  }
>
> +/*
> + * Min polling interval of 10usec is a guess. It is assuming that
> + * for most users, the time for a single ping-pong workload like
> + * perf bench pipe would generally complete within 10usec but
> + * this is hardware dependant. Actual time can be estimated with
> + *
> + * perf bench sched pipe -l 10000
> + *
> + * Run multiple times to avoid cpufreq effects.
> + */
> +#define CPUIDLE_POLL_MIN 10000
> +#define CPUIDLE_POLL_MAX (TICK_NSEC / 16)
> +
>  /**
>   * cpuidle_poll_time - return amount of time to poll for,
>   * governors can override dev->poll_limit_ns if necessary
> @@ -382,15 +395,23 @@ u64 cpuidle_poll_time(struct cpuidle_driver *drv,
>         int i;
>         u64 limit_ns;
>
> +       BUILD_BUG_ON(CPUIDLE_POLL_MIN > CPUIDLE_POLL_MAX);
> +
>         if (dev->poll_limit_ns)
>                 return dev->poll_limit_ns;
>
> -       limit_ns = TICK_NSEC;
> +       limit_ns = CPUIDLE_POLL_MAX;
>         for (i = 1; i < drv->state_count; i++) {
> +               u64 state_limit;
> +
>                 if (dev->states_usage[i].disable)
>                         continue;
>
> -               limit_ns = drv->states[i].target_residency_ns;
> +               state_limit = drv->states[i].target_residency_ns;
> +               if (state_limit < CPUIDLE_POLL_MIN)
> +                       continue;
> +
> +               limit_ns = min_t(u64, state_limit, CPUIDLE_POLL_MAX);
>                 break;
>         }
>
