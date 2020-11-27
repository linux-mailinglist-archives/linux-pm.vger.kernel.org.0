Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F81A2C6377
	for <lists+linux-pm@lfdr.de>; Fri, 27 Nov 2020 11:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgK0Kx0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Nov 2020 05:53:26 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:36973 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgK0Kx0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Nov 2020 05:53:26 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 76AF01C49DE
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2020 10:53:24 +0000 (GMT)
Received: (qmail 14850 invoked from network); 27 Nov 2020 10:53:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Nov 2020 10:53:24 -0000
Date:   Fri, 27 Nov 2020 10:53:22 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: Allow configuration of the polling interval
 before cpuidle enters a c-state
Message-ID: <20201127105322.GO3371@techsingularity.net>
References: <20201126171824.GK3371@techsingularity.net>
 <CAJZ5v0hz4dBzUcvoyLoJf8Fmajws-uP3MB-_4dmzEYvMDJwEwQ@mail.gmail.com>
 <20201126203151.GM3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201126203151.GM3371@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 08:31:51PM +0000, Mel Gorman wrote:
> > > and it is reasonable behaviour but it should be tunable.
> > 
> > Only if there is no way to cover all of the relevant use cases in a
> > generally acceptable way without adding more module params etc.
> > 
> > In this particular case, it should be possible to determine a polling
> > limit acceptable to everyone.
> > 
> 
> Potentially yes. cpuidle is not my strong suit but it could try being
> adaptive the polling similar to how the menu governor tries to guess
> the typical interval. Basically it would have to pick a polling internal
> between 2 and TICK_NSEC. Superficially it a task is queued before polling
> finishes, decrease the interval and increase it otherwise. That is a mess
> though because then it may be polling for ages with nothing arriving. It
> would have to start tracking when the CPU exited idle to see if polling
> is even worthwhile. That
> 
> I felt that starting with anything that tried adapting the polling
> interval based on heuristics would meet higher resistance than making it
> tunable. Hence, make it tunable so at least the problem can be addressed
> when it's encountered.
> 

I looked at this again and determining a "polling limit acceptable
to everyone" looks like reimplementing haltpoll in the core or adding
haltpoll-like logic to each governor. I doubt that'll be a popular
approach.

The c1 exit latency as a hint is definitely too low though. I checked
one of the test machines to double check what the granularity of the time
checks in poll_idle() at boot time with something like this.

        for (i = 0; i < POLL_IDLE_RELAX_COUNT; i++) {
                cpu_relax();
        }

This takes roughly 1100ns on a test machine where the C1 exit latency is
2000ns. Lets say you have a basic pair of tasks communicating over a pipe
on the same machine (e.g. perf bench pipe). The time for a round-trip on
the same machine is roughly 7000ns meaning that polling is almost never
useful for a basic workload.


-- 
Mel Gorman
SUSE Labs
