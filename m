Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEC22C5D11
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 21:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390665AbgKZUb5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 15:31:57 -0500
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:44139 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390663AbgKZUb5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 15:31:57 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id D170E1C43F4
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 20:31:53 +0000 (GMT)
Received: (qmail 26680 invoked from network); 26 Nov 2020 20:31:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Nov 2020 20:31:53 -0000
Date:   Thu, 26 Nov 2020 20:31:51 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: Allow configuration of the polling interval
 before cpuidle enters a c-state
Message-ID: <20201126203151.GM3371@techsingularity.net>
References: <20201126171824.GK3371@techsingularity.net>
 <CAJZ5v0hz4dBzUcvoyLoJf8Fmajws-uP3MB-_4dmzEYvMDJwEwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hz4dBzUcvoyLoJf8Fmajws-uP3MB-_4dmzEYvMDJwEwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 07:24:41PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 26, 2020 at 6:25 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> > It was noted that a few workloads that idle rapidly regressed when commit
> > 36fcb4292473 ("cpuidle: use first valid target residency as poll time")
> > was merged. The workloads in question were heavy communicators that idle
> > rapidly and were impacted by the c-state exit latency as the active CPUs
> > were not polling at the time of wakeup. As they were not particularly
> > realistic workloads, it was not considered to be a major problem.
> >
> > Unfortunately, a bug was then reported for a real workload in a production
> > environment that relied on large numbers of threads operating in a worker
> > pool pattern. These threads would idle for periods of time slightly
> > longer than the C1 exit latency and so incurred the c-state exit latency.
> > The application is sensitive to wakeup latency and appears to indirectly
> > rely on behaviour prior to commit on a37b969a61c1 ("cpuidle: poll_state:
> > Add time limit to poll_idle()") to poll for long enough to avoid the exit
> > latency cost.
> 
> Well, this means that it depends on the governor to mispredict short
> idle durations (so it selects "poll" over "C1" when it should select
> "C1" often enough) and on the lack of a polling limit (or a large
> enough one).
> 

Potentially. I was limited to what degree the load could be analysed
unfortunately other than noting that the polling time should have been

> While the latter can be kind of addressed by increasing the polling
> limit, the misprediction in the governor really isn't guaranteed to
> happen and it really is necessary to have a PM QoS request in place to
> ensure a suitable latency.
> 

Indeed, so yes, the application should be using cpu_dma_latency but not
all of them do.

> > The current behaviour favours power consumption over wakeup latency
> > and it is reasonable behaviour but it should be tunable.
> 
> Only if there is no way to cover all of the relevant use cases in a
> generally acceptable way without adding more module params etc.
> 
> In this particular case, it should be possible to determine a polling
> limit acceptable to everyone.
> 

Potentially yes. cpuidle is not my strong suit but it could try being
adaptive the polling similar to how the menu governor tries to guess
the typical interval. Basically it would have to pick a polling internal
between 2 and TICK_NSEC. Superficially it a task is queued before polling
finishes, decrease the interval and increase it otherwise. That is a mess
though because then it may be polling for ages with nothing arriving. It
would have to start tracking when the CPU exited idle to see if polling
is even worthwhile. That

I felt that starting with anything that tried adapting the polling
interval based on heuristics would meet higher resistance than making it
tunable. Hence, make it tunable so at least the problem can be addressed
when it's encountered.

> BTW, I admit that using the exit latency of the lowest enabled C-state
> was kind of arbitrary and it was based on the assumption that it would
> make more sense to try to enter C1 instead of polling for that much
> time, but C1 is an exception, because it is often artificially made
> particularly attractive to the governors (by reducing its target
> residency as much as possible).  Also making the polling limit that
> short distorts the governor statistics somewhat.
> 
> So the polling limit equal to the target residency of C1 really may be
> overly aggressive and something tick-based may work better in general
> (e.g. 1/8 or 1/16 of the tick period).
> 

Really, tying it to the c-states at all is a little counter-intuitive
because a task wakeup interarrival time has nothing to do with c-states.
It just happened to have some nice numbers that were smaller than the
tick and as you say, c1 may be artifically attractive to the governor if
the polling interval affects target residency estimations.

> In principle, a multiple of C1 target residency could be used too.
> 

Yes but then you hit the problem that C1 exit latencies can be very
different or not even exist. A fixed scaling factor might be great on
one machine and useless on another.

> > In theory applications could use /dev/cpu_dma_latency but not all applications
> > are aware of cpu_dma_latency. Similarly, a tool could be installed
> > that opens cpu_dma_latency for the whole system but such a tool is not
> > always available, is not always known to the sysadmin or the tool can have
> > unexpected side-effects if it tunes more than cpu_dma_latency. In practice,
> > it is more common for sysadmins to try idle=poll (which is x86 specific)
> 
> And really should be avoided if one cares about turbo or wants to
> avoid thermal issues.
> 

Yes.

> > or try disabling c-states and hope for the best.
> >
> > This patch makes it straight-forward to configure how long a CPU should
> > poll before entering a c-state.
> 
> Well, IMV this is not straightforward at all.
> 
> It requires the admin to know how cpuidle works and why this
> particular polling limit is likely to be suitable for the given
> workload.  And whether or not the default polling limit should be
> changed at all.
> 

I tried to make the parameter documentation as clear as possible so a
decision can be made without necessarily knowing how cpuidle works. If
they don't detect it needs to change, the'll never bother.

> Honestly, nobody knows that in advance (with all due respect) and this
> would cause people to try various settings at random and stick to the
> one that they feel works best for them without much understanding.
> 

More than likely, yes. However, I would point out that quite a lot of
"tuning" efforts are based on people randomly flipping tunables and hoping
for the best.

> > By default, there is no behaviour change.
> > At build time a decision can be made to favour performance over power
> > by default even if that potentially impacts turbo boosting for workloads
> > that are sensitive to wakeup latency. In the event the kernel default is
> > not suitable, the kernel command line can be used as a substitute for
> > implementing cpu_dma_latency support in an application or requiring an
> > additional tool to be installed.
> >
> > Note that it is not expected that tuning for longer polling times will be a
> > universal win. For example, extra polling might prevent a turbo state being
> > used or prevent hyperthread resources being released to an SMT sibling.
> >
> > By default, nothing has changed but here is an example of tbench4
> > comparing the default "poll based on the min cstate" vs "poll based on
> > the max cstate"
> >
> > tbench4
> >                           min-cstate             max-cstate
> > Hmean     1        512.88 (   0.00%)      566.74 *  10.50%*
> > Hmean     2        999.47 (   0.00%)     1090.01 *   9.06%*
> > Hmean     4       1960.83 (   0.00%)     2106.62 *   7.44%*
> > Hmean     8       3828.61 (   0.00%)     4097.93 *   7.03%*
> > Hmean     16      6899.44 (   0.00%)     7120.38 *   3.20%*
> > Hmean     32     10718.38 (   0.00%)    10672.44 *  -0.43%*
> > Hmean     64     12672.21 (   0.00%)    12608.15 *  -0.51%*
> > Hmean     128    20744.83 (   0.00%)    21147.02 *   1.94%*
> > Hmean     256    20646.60 (   0.00%)    20608.48 *  -0.18%*
> > Hmean     320    20892.89 (   0.00%)    20831.99 *  -0.29%*
> 
> I'm wondering if you have similar results for "poll based on 2 x min
> cstate" (or 4 x min cstate for that matter).

Fixed value of 30 generally worked out roughly the same performance as
picking the setting the polling interval based on the shallowest
c-state. I did not do many experiments with different possible values as
I felt the optimal value would be both workload and machine dependant.

-- 
Mel Gorman
SUSE Labs
