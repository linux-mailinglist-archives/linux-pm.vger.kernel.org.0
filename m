Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C447DB6D3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503364AbfJQTH2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 15:07:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56398 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503363AbfJQTH2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 15:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+iW1UtqQMUkClFUP9OfZlGcJ+KCRuTpNF/TmgYgEt/U=; b=qDpcNx0MrDAxV3GnJa1A1QBrl
        LL68RwtKOpen/rD5D+jpGbpw5+hc1x2D026QEBabOT0ees4y12rAy5nSS4GP3BnW8tpN4LUj18pnJ
        IVqQ37CIMfGDNo2TZhFN2UWA/07SrsI7pR4lOoChHRVT5XOYFuZKPhD9JldIfu02/DxU2UsbZnksd
        VKIbAJfH1RbOzLJ1ei+g2SazqlbY1h0nndbWi5c2cUV0cIB54q7U8sCmlarmns6F8gZUuPv3nFfxS
        IV/l4I53sLlRnjnrtLG8p+RsPJLa2P90vxBWcIdkoQ/nt4ZWc2kF5HI5e9BMtoCSw9mRHqPucTXen
        NtMDFjJIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLB7A-0005Tu-9Y; Thu, 17 Oct 2019 19:07:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCD86980D8F; Thu, 17 Oct 2019 21:07:08 +0200 (CEST)
Date:   Thu, 17 Oct 2019 21:07:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20191017190708.GF22902@worktop.programming.kicks-ass.net>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
 <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net>
 <7edb1b73-54e7-5729-db5d-6b3b1b616064@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7edb1b73-54e7-5729-db5d-6b3b1b616064@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 03:23:04PM +0100, Douglas Raillard wrote:
> On 10/17/19 10:50 AM, Peter Zijlstra wrote:

> > I'm still thinking about the exact means you're using to raise C; that
> > is, the 'util - util_est' as cost_margin. It hurts my brain still.
> 
> util_est is currently the best approximation of the actual portion of the CPU the task needs:
> 1) for periodic tasks, it's not too far from the duty cycle, and is always higher
> 
> 2) for aperiodic tasks, it (indirectly) takes into account the total time it took
>   to complete the previous activation, so the signal is not 100% composed of logical signals
>   only relevant for periodic tasks (although it's a big part of it).
> 
> 3) Point 1) and 2) together allows util_est to adapt to periodic tasks that changes
> their duty cycle over time, without needing a very long history (the last task period
> is sufficient).
> 
> For periodic tasks, the distance between instantaneous util_avg and the actual task
> duty cycle indicates somehow what is our best guess of the (potential) change in the task
> duty cycle.
> 
> util_est is the threshold (assuming util_avg increasing) for util_avg after which we know
> for sure that even if the task stopped right now, its duty cycle would be higher than
> during the previous period.
> This means for a given task and with (util >= util_est):
> 
> 1) util - util_est == 0 means the task duty cycle will be equal to the one during
>   during the previous activation, if the tasks stopped executing right now.
> 
> 2) util - util_est > 0 means the task duty cycle will be higher to the one during
>   during the previous activation, if the tasks stopped executing right now.

So far I can follow, 2) is indeed a fairly sane indication that
utilization is growing.

> Using the difference (util - util_est) will therefore give these properties to the boost signal:
> * no boost will be applied as long as the task has a constant or decreasing duty cycle.
> 
> * when we can detect that the duty cycle increases, we temporarily increase the frequency.
>   We start with a slight increase, and the longer we wait for the current period to finish,
>   the more we boost, since the more likely it is that the task has a much larger duty cycle
>   than anticipated. More specifically, the evaluation of "how much more" is done the exact
>   same way as it is done for PELT, since the dynamic of the boost is "inherited" from PELT.

Right, because as long it keeps running, util_est will not be changed,
so the difference will continue to increase.

What I don't see is how that that difference makes sense as input to:

  cost(x) : (1 + x) * cost_j

I suppose that limits the additional OPP to twice the previously
selected cost / efficiency (see the confusion from that other email).
But given that efficency drops (or costs rise) for higher OPPs that
still doesn't really make sense..

> Now if the task is aperiodic, the boost will allow reaching the highest frequency faster,
> which may or may not be desired. Ultimately, it's not more or less wrong than just picking
> the freq based on util_est alone, since util_est is already somewhat meaningless for aperiodic
> tasks. It just allows reaching the max freq at some point without waiting for too long, which is
> all what we can do without more info on the task.
> 
> When applying these boosting rules on the runqueue util signals, we are able to detect if at least one
> task needs boosting according to these rules. That only holds as long as the history we look at is
> the result of a stable set of tasks, i.e. no tasks added or removed from the rq.

So while I agree that 2) is a reasonable signal to work from, everything
that comes after is still much confusing me.

