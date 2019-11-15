Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FCFDB83
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 11:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKOKiN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 05:38:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59142 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfKOKiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 05:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kF17KYqpXXxrOXvE5ZmPkjCvqdlqrYPD5aCNtqKBz40=; b=Ynvb5DGRQwGex8Q0NTJer5TLU
        KlzMAbWWklLqeWAgE0WFxer4N5SAkywU6V6El8MJ1ylwwM4rQKYH6wU2YzqYQ7EB941XJ7jseH62B
        uGh3Hl1VvE3HjmC8EWWC0y/rlsSLNjalUONSoHmPisftHOxBV0C3oScR+EhQdVX75aOwu0YN/Wuzj
        uOOBcWME6abYJoXrPT02rwEnOTuRzPy7DDNSSj8pU+dLCIrMkGinOVgv1JA4DSBrNMUtFBMdZB5re
        rT+3mIB0u/9//YqC2mNMaEgxxrMve9qZiycW0oskf54iG8Z3kcGFDFfdpHu0zrnwgp5I9yeVMxnlF
        49GqRWJsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVYyw-0006Pz-8Q; Fri, 15 Nov 2019 10:37:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8DCD2303D9F;
        Fri, 15 Nov 2019 11:36:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79AC42B0BC1FB; Fri, 15 Nov 2019 11:37:35 +0100 (CET)
Date:   Fri, 15 Nov 2019 11:37:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
Message-ID: <20191115103735.GE4131@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net>
 <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 11:18:00AM +0100, Vincent Guittot wrote:
> On Fri, 15 Nov 2019 at 10:55, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> > > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> > > which might be inefficient when cpufreq driver has rate limitation.
> > >
> > > When a task is attached on a CPU, we have call path:
> > >
> > > update_load_avg()
> > >   update_cfs_rq_load_avg()
> > >     cfs_rq_util_change -- > trig frequency update
> > >   attach_entity_load_avg()
> > >     cfs_rq_util_change -- > trig frequency update
> > >
> > > The 1st frequency update will not take into account the utilization of the
> > > newly attached task and the 2nd one might be discard because of rate
> > > limitation of the cpufreq driver.
> >
> > Doesn't this just show that a dumb rate limit in the driver is broken?
> 
> But the rate limit may come from HW constraints that forces to wait
> let say 4ms or even 10ms between each frequency update.

Sure, but then it can still remember the value passed in last and use
that state later.

It doesn't _have_ to completely discard values.

> > > update_cfs_rq_load_avg() is only called by update_blocked_averages()
> > > and update_load_avg() so we can move the call to
> > > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> > > interesting to notice that update_load_avg() already calls directly
> > > cfs_rq_util_change() for !SMP case.
> > >
> > > This changes will also ensure that cpufreq_update_util() is called even
> > > when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> > > irq, rt or dl pelt signals.
> >
> > I don't think it does that; that is, iirc the return value of
> > ___update_load_sum() is 1 every time a period lapses. So even if the avg
> > is 0 and doesn't change, it'll still return 1 on every period.
> >
> > Which is what that dumb rate-limit thing wants of course. But I'm still
> > thinking that it's stupid to do. If nothing changes, don't generate
> > events.
> 
> When everything (irq, dl, rt, cfs) is 0, we don't generate events
> because update_blocked_averages is no more called because
> rq->has_blocked_load is clear

Aah.. Ok, let me look at this thing again.

> > If anything, update_blocked_avgerages() should look at
> > @done/others_have_blocked() to emit events for rt,dl,irq.
> 
> other_have_blocked can be set but no decay happened during the update
> and we don't need to call cpufreq_update_util

True.
