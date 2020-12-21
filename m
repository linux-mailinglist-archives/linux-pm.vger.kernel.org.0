Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B42DFDEC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 17:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgLUQMx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 11:12:53 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:46022 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLUQMx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 11:12:53 -0500
Received: by mail-oi1-f178.google.com with SMTP id f132so11685694oib.12;
        Mon, 21 Dec 2020 08:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRk2AFQYlWxWo/NpbZ7IksLBNZ8aNd1stHsai1MrXF8=;
        b=rLW6yWeY1RzcsFgwCJb8IOo8ik5sIolv2M+oyDB5JqvEqinG4X5C3sIwhfw6cYzR0j
         m9cTQpC3thjON0EwdGQK5hpx6oXOnWu1wUroHQ9YkCWLSrJ3N8M0BD9vm/eZYnpvludo
         P3sWbiaP1ruM1VqYjp7bt0DcNO8kN8bdbo57ODevkWr7bHzJmAB3ZkdGO8tBdRGLQ7ph
         Tz1ahY1FUAtm6MGxSup4slJOQsjcfkq4kHZIi07tZExLQ6FI+1eo68MDedhZb32oQahR
         efqC1r94JM/IYmVfChEUTEeehFF95nMPvoFxijuN2jAoYN2+5M2VRzR3ewHVfUApNOQH
         QzTg==
X-Gm-Message-State: AOAM533P0nUQshAES+a+XSufKxaWGb08ttMpv7715JBiii61sHKA/IyF
        160m9puaTEz3q7dI55v9APr+omnFV0DJbYbVUV8=
X-Google-Smtp-Source: ABdhPJxQsny2WXWz8Op2WKwnVpmoUNB6jDMkz19SY8tMq89no2meDRTgYqlrsPoZ9GKT55rAL9cBhD2cRTBpquZFilI=
X-Received: by 2002:aca:4892:: with SMTP id v140mr11504292oia.71.1608567131470;
 Mon, 21 Dec 2020 08:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20360841.iInq7taT2Z@kreacher> <3827230.0GnL3RTcl1@kreacher> <1608307905.26567.46.camel@suse.com>
In-Reply-To: <1608307905.26567.46.camel@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Dec 2020 17:11:59 +0100
Message-ID: <CAJZ5v0jfgFRqXisWQUH0J-Xfvh_jjWw8mC_AKyd-tAgRNamj9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] cpufreq: Allow drivers to receive more information
 from the governor
To:     Giovanni Gherdovich <ggherdovich@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Dec 18, 2020 at 5:22 PM Giovanni Gherdovich
<ggherdovich@suse.com> wrote:
>
> On Mon, 2020-12-14 at 21:01 +0100, Rafael J. Wysocki wrote:
> > Hi,
> >
> > The timing of this is not perfect (sorry about that), but here's a refresh
> > of this series.
> >
> > The majority of the previous cover letter still applies:
> > [...]
>
> Hello,
>
> the series is tested using
>
> -> tbench (packets processing with loopback networking, measures throughput)
> -> dbench (filesystem operations, measures average latency)
> -> kernbench (kernel compilation, elapsed time)
> -> and gitsource (long-running shell script, elapsed time)
>
> These are chosen because none of them is bound by compute and all are
> sensitive to freq scaling decisions. The machines are a Cascade Lake based
> server, a client Skylake and a Coffee Lake laptop.

First of all, many thanks for the results!

Any test results input is always much appreciated for all of the
changes under consideration.

> What's being compared:
>
> sugov-HWP.desired : the present series;  intel_pstate=passive,  governor=schedutil
> sugov-HWP.min     : mainline;            intel_pstate=passive,  governor=schedutil
> powersave-HWP     : mainline;            intel_pstate=active,   governor=powersave
> perfgov-HWP       : mainline;            intel_pstate=active,   governor=performance
> sugov-no-HWP      : HWP disabled;        intel_pstate=passive,  governor=schedutil
>
> Dbench and Kernbench have neutral results, but Tbench has sugov-HWP.desired
> lose in both performance and performance-per-watt, while Gitsource show the
> series as faster in raw performance but again worse than the competition in
> efficiency.

Well, AFAICS tbench "likes" high turbo and is sensitive to the
response time (as indicated by the fact that it is also sensitive to
the polling limit value in cpuidle).

Using the target perf to set HWP_REQ.DESIRED (instead of using it to
set HWP_REQ.MIN) generally causes the turbo to be less aggressive and
the response time to go up, so the tbench result is not a surprise at
all.  This case represents the tradeoff being made here (as noted by
Doug in one of his previous messages).

The gitsource result is a bit counter-intuitive, but my conclusions
drawn from it are quite different from yours (more on that below).

> 1. SUMMARY BY BENCHMARK
>    1.1. TBENCH
>    1.2. DBENCH
>    1.3. KERNBENCH
>    1.4. GITSOURCE
> 2. SUMMARY BY USER PROFILE
>    2.1. PERFORMANCE USER: what if I switch pergov -> schedutil?
>    2.2. DEFAULT USER: what if I switch powersave -> schedutil?
>    2.3. DEVELOPER: what if I switch sugov-HWP.min -> sugov-HWP.desired?
> 3. RESULTS TABLES
>    PERFORMANCE RATIOS
>    PERFORMANCE-PER-WATT RATIOS
>
>
> 1. SUMMARY BY BENCHMARK
> ~~~~~~~~~~~~~~~~~~~~~~~
>
> Tbench: sugov-HWP.desired is the worst performance on all three
>     machines. sugov-HWP.min is between 20% and 90% better. The baseline
>     sugov-HWP.desired offers a lower throughput, but does it increase
>     efficiency? It actually doesn't: on two out of three machines the
>     incumbent code (current sugov, or intel_pstate=active) has 10% to 35%
>     better efficiency. In other word, the status quo is both faster and more
>     efficient than the proposed series on this benchmark.
>     The absolute power consumption is lower, but the delivered performance is
>     "even more lower", and that's why performance-per-watt shows a net loss.

This benchmark is best off when run under the performance governor and
the observation that sugov-HWP.min is almost as good as the
performance governor for it is a consequence of a bias towards
performance in the former (which need not be regarded as a good
thing).

The drop in energy-efficiency is somewhat disappointing, but not
entirely unexpected too.

> Dbench: generally neutral, in both performance and efficiency. Powersave is
>     occasionally behind the pack in performance, 5% to 15%. A 15% performance
>     loss on the Coffe Lake is compensated by an 80% improved efficiency. To be
>     noted that on the same Coffee Lake sugov-no-HWP is 20% ahead of the pack
>     in efficiency.
>
> Kernbench: neutral, in both performance and efficiency. powersave looses 14%
>     to the pack in performance on the Cascade Lake.
>
> Gitsource: this test show the most compelling case against the
>     sugov-HWP.desired series: on the Cascade Lake sugov-HWP.desired is 10%
>     faster than sugov-HWP.min (it was expected to be slower!) and 35% less
>     efficient (we expected more performance-per-watt, not less).

This is a bit counter-intuitive, so it is good to try to understand
what's going on instead of drawing conclusions right away from pure
numbers.

My interpretation of the available data is that gitsource benefits
from the "race-to-idle" effect in terms of energy-efficiency which
also causes it to suffer in terms of performance.  Namely, completing
the given piece of work faster causes some CPU idle time to become
available and that effectively reduces power, but it also increases
the response time (by the idle state exit latency) which causes
performance to drop. Whether or not this effect can be present depends
on what CPU idle states are available etc. and it may be a pure
coincidence.

What sugov-HWP.desired really does is to bias the frequency towards
whatever is perceived by schedutil as sufficient to run the workload
(which is a key property of it - see below) and it appears to do the
job here quite well, but it eliminates the "race-to-idle" effect that
the workload benefited from originally and, like it or not, schedutil
cannot know about that effect.

That effect can only be present if the frequencies used for running
the workload are too high and by a considerable margin (sufficient for
a deep enough idle state to be entered).  In some cases running the
workload too fast helps (like in this one, although this time it
happens to hurt performance), but in some cases it really hurts
energy-efficiency and the question is whether or not this should be
always done.

There is a whole broad category of workloads involving periodic tasks
that do the same amount of work in every period regardless of the
frequency they run at (as long as the frequency is sufficient to avoid
"overrunning" the period) and they almost never benefit from
"race-to-idle".There is zero benefit from running them too fast and
the energy-efficiency goes down the sink when that happens.

Now the problem is that with sugov-HWP.min the users who care about
these workloads don't even have an option to use the task utilization
history recorded by the scheduler to bias the frequency towards the
"sufficient" level, because sugov-HWP.min only sets a lower bound on
the frequency selection to improve the situation, so the choice
between it and sugov-HWP.desired boils down to whether or not to give
that option to them and my clear preference is for that option to
exist.  Sorry about that.  [Note that it really is an option, though,
because "pure" HWP is still the default for HWP-enabled systems.]

It may be possible to restore some "race-to-idle" benefits by tweaking
HWP_REQ.EPP in the future, but that needs to be investigated.

BTW, what EPP value was there on the system where you saw better
performance under sugov-HWP.desired?  If it was greater than zero, it
would be useful to decrease EPP (by adjusting the
energy_performance_preference attributes in sysfs for all CPUs) and
see what happens to the performance difference then.


>
> 2. SUMMARY BY USER PROFILE
> ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> If I was a perfgov-HWP user, I would be 20%-90% faster than with other governors
> on tbench an gitsource. This speed gap comes with an unexpected efficiency
> bonus on both test. Since dbench and kernbench have a flat profile across the
> board, there is no incentive to try another governor.
>
> If I was a powersave-HWP user, I'd be the slower of the bunch. The lost
> performance is not, in general, balanced by better efficiency. This only
> happens on Coffee Lake, which is a CPU for the mobile market and possibly HWP
> has efficiency-oriented tuning there. Any flavor of schedutil would be an
> improvement.
>
> From a developer perspective, the obstacles to move from HWP.min to
> HWP.desired are tbench, where HWP.desired is worse than having no HWP support
> at all, and gitsource, where HWP.desired has the opposite properties than
> those advertised (it's actually faster but less efficient).
>
>
> 3. RESULTS TABLES
> ~~~~~~~~~~~~~~~~~
>
> Tilde (~) means the result is the same as baseline (or, the ratio is close to 1).
> The double asterisk (**) is a visual aid and means the result is better than
> baseline (higher or lower depending on the case).
>
>
> | 80x_CASCADELAKE_NUMA: Intel Cascade Lake, 40 cores / 80 threads, NUMA, SATA SSD storage
> + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> |            sugov-HWP.des  sugov-HWP.min  powersave-HWP  perfgov-HWP  sugov-no-HWP   better if
> + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> |                                         PERFORMANCE RATIOS
> | tbench         1.00           1.89**         1.88**        1.89**        1.17**       higher
> | dbench         1.00           ~              1.06          ~             ~            lower
> | kernbench      1.00           ~              1.14          ~             ~            lower
> | gitsource      1.00           1.11           2.70          0.80**        ~            lower
> + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> |                                    PERFORMANCE-PER-WATT RATIOS
> | tbench         1.00           1.36**         1.38**        1.33**        1.04**       higher
> | dbench         1.00           ~              ~             ~             ~            higher
> | kernbench      1.00           ~              ~             ~             ~            higher
> | gitsource      1.00           1.36**         0.63          1.22**        1.02**       higher
>
>
> | 8x_COFFEELAKE_UMA: Intel Coffee Lake, 4 cores / 8 threads, UMA, NVMe SSD storage
> + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> |            sugov-HWP.des  sugov-HWP.min  powersave-HWP  perfgov-HWP  sugov-no-HWP   better if
> + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> |                                         PERFORMANCE RATIOS
> | tbench         1.00           1.27**         1.30**        1.30**        1.31**       higher
> | dbench         1.00           ~              1.15          ~             ~            lower
> | kernbench      1.00           ~              ~             ~             ~            lower
> | gitsource      1.00           ~              2.09          ~             ~            lower
> + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> |                                    PERFORMANCE-PER-WATT RATIOS
> | tbench         1.00           ~              ~             ~             ~            higher
> | dbench         1.00           ~              1.82**        ~             1.22**       higher
> | kernbench      1.00           ~              ~             ~             ~            higher
> | gitsource      1.00           ~              1.56**        ~             1.17**       higher
>
>
> | 8x_SKYLAKE_UMA: Intel Skylake (client), 4 cores / 8 threads, UMA, SATA SSD storage
> + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> |            sugov-HWP.des  sugov-HWP.min  powersave-HWP  perfgov-HWP  sugov-no-HWP   better if
> + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> |                                         PERFORMANCE RATIOS
> | tbench         1.00           1.21**         1.22**        1.20**        1.06**       higher
> | dbench         1.00           ~              ~             ~             ~            lower
> | kernbench      1.00           ~              ~             ~             ~            lower
> | gitsource      1.00           ~              1.71          0.96**        ~            lower
> + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> |                                    PERFORMANCE-PER-WATT RATIOS
> | tbench         1.00           1.11**         1.12**        1.10**        1.03**       higher
> | dbench         1.00           ~              ~             ~             ~            higher
> | kernbench      1.00           ~              ~             ~             ~            higher
> | gitsource      1.00           ~              0.75          ~             ~            higher
