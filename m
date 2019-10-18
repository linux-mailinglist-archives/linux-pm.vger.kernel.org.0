Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF60DC462
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 14:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409959AbfJRMHg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 08:07:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36532 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407893AbfJRMHg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 08:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ld3ezfhAeRAVMvme4hYBgPVlITvE7jdd02JDmyHHw5E=; b=K4yx40Wue8PpFsluPTTZOLS/Z
        o1YGDCxVGg8GF6+6OKbofSckHJprqRpAv97h1IraU011eeT3rolFn6XjXvSlbtGJAp9jULVKr5dFM
        vksiGf6Giu7IthRFtNmHcePYWYiP5DqpjF3XHOav5VEHL5/UiTzEPeYI6DtuGsLkDFUI2axD8UOd9
        a0Wsnl/hiRSu9AT+EM1UE55J6RVwrb0cgmTz28F12QvyywuUV315ldsmXLwfONk1cXg76pJJKHLEs
        1UxLWBcxwcv402iGXRGgRQoTYqMgNKYvCqrbwxAVC75iZXad0Ckb7VMbzIa+uo7QsxOgoE+viBoQU
        QM6AF/EOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLR2Q-0003jS-TS; Fri, 18 Oct 2019 12:07:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89523301124;
        Fri, 18 Oct 2019 14:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E0A9200DE9E2; Fri, 18 Oct 2019 14:07:19 +0200 (CEST)
Date:   Fri, 18 Oct 2019 14:07:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@google.com,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20191018120719.GH2328@hirez.programming.kicks-ass.net>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
 <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net>
 <7edb1b73-54e7-5729-db5d-6b3b1b616064@arm.com>
 <20191017190708.GF22902@worktop.programming.kicks-ass.net>
 <0b807cb3-6a88-1138-dc66-9a32d9bba7ea@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b807cb3-6a88-1138-dc66-9a32d9bba7ea@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 12:46:25PM +0100, Douglas Raillard wrote:

> > What I don't see is how that that difference makes sense as input to:
> > 
> >    cost(x) : (1 + x) * cost_j
> 
> The actual input is:
> x = (EM_COST_MARGIN_SCALE/SCHED_CAPACITY_SCALE) * (util - util_est)
> 
> Since EM_COST_MARGIN_SCALE == SCHED_CAPACITY_SCALE == 1024, this factor of 1
> is not directly reflected in the code but is important for units
> consistency.

But completely irrelevant for the actual math and conceptual
understanding. Just because computers suck at real numbers, and floats
are expensive, doesn't mean we have to burden ourselves with fixed point
when writing equations.

Also, as a physicist I'm prone to normalizing everything to 1, because
that's lazy.

> > I suppose that limits the additional OPP to twice the previously
> > selected cost / efficiency (see the confusion from that other email).
> > But given that efficency drops (or costs rise) for higher OPPs that
> > still doesn't really make sense..

> Yes, this current limit to +100% freq boosting is somehow arbitrary and
> could probably benefit from being tunable in some way (Kconfig option
> maybe). When (margin > 0), we end up selecting an OPP that has a higher cost
> than the one strictly required, which is expected. The goal is to speed
> things up at the expense of more power consumed to achieve the same work,
> hence at a lower efficiency (== higher cost).

No, no Kconfig knobs.

> That's the main reason why this boosting apply a margin on the cost of the
> selected OPP rather than just inflating the util. This allows controlling
> directly how much more power (battery life) we are going to spend to achieve
> some work that we know could be achieved with less power.

But you're not; the margin is relative to the OPP, it is not absolute.

Or rather, the only actual limit is in relation to the max OPP. So you
have very little actual control over how much more energy you're
spending.

> > So while I agree that 2) is a reasonable signal to work from, everything
> > that comes after is still much confusing me.

> "When applying these boosting rules on the runqueue util signals ...":
> Assuming the set of enqueued tasks stays the same between 2 observations
> from schedutil, if we see the rq util_avg increase above its
> util_est.enqueued, that means that at least one task had its util_avg go
> above util_est.enqueued. We might miss some boosting opportunities if some
> (util - util_est) compensates:
> TASK_1(util - util_est) = - TASK_2(util - util_est)
> but working on the aggregated value is much easier in schedutil, to avoid
> crawling the list of entities.

That still does not explain why 'util - util_est', when >0, makes for a
sensible input into an OPP relative function.

I agree that 'util - util_est', when >0, indicates utilization is
increasing (for the aperiodic blah blah blah). But after that I'm still
confused.
