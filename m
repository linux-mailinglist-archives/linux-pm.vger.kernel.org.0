Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD43B2C67B4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Nov 2020 15:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgK0OTG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Nov 2020 09:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730812AbgK0OTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Nov 2020 09:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606486743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGjwqW83+DhoUby3LrbvuhiDweHj1KLhNuKB+bNrk1s=;
        b=S9Ub3DbwCmvWkCQy9+gdAhwvmztCgovSvlm0W8n9ZsRXGXC/XSlm99R+ptFtiQwNoj1po8
        CmY2X5m63SEBZTwG4Q4QXI2bRxFrDgot1lRoGuoixx8Ftzqod9+rm6AWWvw9/FS02nSZWG
        nH+QDHAfefPTuSfPfUlortGzaLOjFjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-GL5megLeOX6SpBpCwDv27Q-1; Fri, 27 Nov 2020 09:18:59 -0500
X-MC-Unique: GL5megLeOX6SpBpCwDv27Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BC56107ACF7;
        Fri, 27 Nov 2020 14:18:58 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D475A5C276;
        Fri, 27 Nov 2020 14:18:57 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id EB3BD4172ED9; Fri, 27 Nov 2020 11:08:11 -0300 (-03)
Date:   Fri, 27 Nov 2020 11:08:11 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: Allow configuration of the polling interval
 before cpuidle enters a c-state
Message-ID: <20201127140811.GA39892@fuller.cnet>
References: <20201126171824.GK3371@techsingularity.net>
 <CAJZ5v0hz4dBzUcvoyLoJf8Fmajws-uP3MB-_4dmzEYvMDJwEwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hz4dBzUcvoyLoJf8Fmajws-uP3MB-_4dmzEYvMDJwEwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 07:24:41PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 26, 2020 at 6:25 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
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
> While the latter can be kind of addressed by increasing the polling
> limit, the misprediction in the governor really isn't guaranteed to
> happen and it really is necessary to have a PM QoS request in place to
> ensure a suitable latency.
> 
> > The current behaviour favours power consumption over wakeup latency
> > and it is reasonable behaviour but it should be tunable.
> 
> Only if there is no way to cover all of the relevant use cases in a
> generally acceptable way without adding more module params etc.
> 
> In this particular case, it should be possible to determine a polling
> limit acceptable to everyone.
> 
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
> In principle, a multiple of C1 target residency could be used too.
> 
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

KVM polling (virt/kvm/kvm_main.c grow_halt_poll_ns/shrink_halt_poll_ns)
tries to adjust the polling window based on poll success/failure. 

The cpuidle haltpoll governor (for KVM guests) uses the same adjustment
logic.

Perhaps a similar (or improved) scheme can be adapted to baremetal.

https://www.kernel.org/doc/Documentation/virtual/kvm/halt-polling.txt
> 
> Honestly, nobody knows that in advance (with all due respect) and this
> would cause people to try various settings at random and stick to the
> one that they feel works best for them without much understanding.
> 
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

