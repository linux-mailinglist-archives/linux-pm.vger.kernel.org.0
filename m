Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE442C5BF7
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 19:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404074AbgKZSYz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 13:24:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45237 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404028AbgKZSYy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:24:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id l206so3123504oif.12;
        Thu, 26 Nov 2020 10:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CeBIsTgv2OXbQ0s5p+qCPKhIhxADq0Kgs1y7GjU1q4=;
        b=oQxYnmDKRXU6VKSL8zBn0z4NMdgR+k+9tmKfcBmjKGARA1eJ34m0vUGCcTSxuS74E6
         LmlvqhbcihfMrdK/cFAto1vszfMZOOFDNeXUfle79u3cguU0CGEXgsePy6uCoZV5O/fB
         u8cvl/vyIrw+w2eUKgVWd453JT7xi0QttadU3peodUDr17Y5E7hyssWnsHS787jkl38y
         aPW6+aDTaiTlGOQT/ZOWSzr+LRKUoG3+8BVQUW9SdKpWEEoX1bt4ow1VXm7ohCg7zMGq
         1lPDcurq/ry2pp6NyQH0yurrEibrq/sYGt1KtaZFzkEp3K1Ycwmr6IeZIXEHYW4pYbkm
         IAlw==
X-Gm-Message-State: AOAM533hn1ZO4JZzrQLJwAEvpx7cg1HnSx3Jcqi4TbtV/K7r9ac60Avr
        GEOkDVwuIK5XiFS1n2zcbcpzNOkMJIZ8T6Y7B/c=
X-Google-Smtp-Source: ABdhPJwcv4N4tGVYy983i4LAa/FVbm6w8IR3F/d094yK3WYkikCe4MdVrIqft1PMFfspkiTltRT3BfUEEPHd5TKaLq4=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr2762003oib.69.1606415093334;
 Thu, 26 Nov 2020 10:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20201126171824.GK3371@techsingularity.net>
In-Reply-To: <20201126171824.GK3371@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Nov 2020 19:24:41 +0100
Message-ID: <CAJZ5v0hz4dBzUcvoyLoJf8Fmajws-uP3MB-_4dmzEYvMDJwEwQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Allow configuration of the polling interval
 before cpuidle enters a c-state
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 6:25 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> It was noted that a few workloads that idle rapidly regressed when commit
> 36fcb4292473 ("cpuidle: use first valid target residency as poll time")
> was merged. The workloads in question were heavy communicators that idle
> rapidly and were impacted by the c-state exit latency as the active CPUs
> were not polling at the time of wakeup. As they were not particularly
> realistic workloads, it was not considered to be a major problem.
>
> Unfortunately, a bug was then reported for a real workload in a production
> environment that relied on large numbers of threads operating in a worker
> pool pattern. These threads would idle for periods of time slightly
> longer than the C1 exit latency and so incurred the c-state exit latency.
> The application is sensitive to wakeup latency and appears to indirectly
> rely on behaviour prior to commit on a37b969a61c1 ("cpuidle: poll_state:
> Add time limit to poll_idle()") to poll for long enough to avoid the exit
> latency cost.

Well, this means that it depends on the governor to mispredict short
idle durations (so it selects "poll" over "C1" when it should select
"C1" often enough) and on the lack of a polling limit (or a large
enough one).

While the latter can be kind of addressed by increasing the polling
limit, the misprediction in the governor really isn't guaranteed to
happen and it really is necessary to have a PM QoS request in place to
ensure a suitable latency.

> The current behaviour favours power consumption over wakeup latency
> and it is reasonable behaviour but it should be tunable.

Only if there is no way to cover all of the relevant use cases in a
generally acceptable way without adding more module params etc.

In this particular case, it should be possible to determine a polling
limit acceptable to everyone.

BTW, I admit that using the exit latency of the lowest enabled C-state
was kind of arbitrary and it was based on the assumption that it would
make more sense to try to enter C1 instead of polling for that much
time, but C1 is an exception, because it is often artificially made
particularly attractive to the governors (by reducing its target
residency as much as possible).  Also making the polling limit that
short distorts the governor statistics somewhat.

So the polling limit equal to the target residency of C1 really may be
overly aggressive and something tick-based may work better in general
(e.g. 1/8 or 1/16 of the tick period).

In principle, a multiple of C1 target residency could be used too.

> In theory applications could use /dev/cpu_dma_latency but not all applications
> are aware of cpu_dma_latency. Similarly, a tool could be installed
> that opens cpu_dma_latency for the whole system but such a tool is not
> always available, is not always known to the sysadmin or the tool can have
> unexpected side-effects if it tunes more than cpu_dma_latency. In practice,
> it is more common for sysadmins to try idle=poll (which is x86 specific)

And really should be avoided if one cares about turbo or wants to
avoid thermal issues.

> or try disabling c-states and hope for the best.
>
> This patch makes it straight-forward to configure how long a CPU should
> poll before entering a c-state.

Well, IMV this is not straightforward at all.

It requires the admin to know how cpuidle works and why this
particular polling limit is likely to be suitable for the given
workload.  And whether or not the default polling limit should be
changed at all.

Honestly, nobody knows that in advance (with all due respect) and this
would cause people to try various settings at random and stick to the
one that they feel works best for them without much understanding.

> By default, there is no behaviour change.
> At build time a decision can be made to favour performance over power
> by default even if that potentially impacts turbo boosting for workloads
> that are sensitive to wakeup latency. In the event the kernel default is
> not suitable, the kernel command line can be used as a substitute for
> implementing cpu_dma_latency support in an application or requiring an
> additional tool to be installed.
>
> Note that it is not expected that tuning for longer polling times will be a
> universal win. For example, extra polling might prevent a turbo state being
> used or prevent hyperthread resources being released to an SMT sibling.
>
> By default, nothing has changed but here is an example of tbench4
> comparing the default "poll based on the min cstate" vs "poll based on
> the max cstate"
>
> tbench4
>                           min-cstate             max-cstate
> Hmean     1        512.88 (   0.00%)      566.74 *  10.50%*
> Hmean     2        999.47 (   0.00%)     1090.01 *   9.06%*
> Hmean     4       1960.83 (   0.00%)     2106.62 *   7.44%*
> Hmean     8       3828.61 (   0.00%)     4097.93 *   7.03%*
> Hmean     16      6899.44 (   0.00%)     7120.38 *   3.20%*
> Hmean     32     10718.38 (   0.00%)    10672.44 *  -0.43%*
> Hmean     64     12672.21 (   0.00%)    12608.15 *  -0.51%*
> Hmean     128    20744.83 (   0.00%)    21147.02 *   1.94%*
> Hmean     256    20646.60 (   0.00%)    20608.48 *  -0.18%*
> Hmean     320    20892.89 (   0.00%)    20831.99 *  -0.29%*

I'm wondering if you have similar results for "poll based on 2 x min
cstate" (or 4 x min cstate for that matter).
