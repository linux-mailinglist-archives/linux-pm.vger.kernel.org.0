Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798B329EC4F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 13:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgJ2Mwy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 08:52:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56684 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ2Mwy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 08:52:54 -0400
Received: from 89-64-89-121.dynamic.chello.pl (89.64.89.121) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 9b25f128a723335f; Thu, 29 Oct 2020 13:52:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     zhuguangqing83 <zhuguangqing83@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        'zhuguangqing' <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] cpufreq: schedutil: set sg_policy->next_freq to the final cpufreq
Date:   Thu, 29 Oct 2020 13:52:50 +0100
Message-ID: <2954009.kBar6x9KXa@kreacher>
In-Reply-To: <20201029071952.7yh5ncnxqxf62pjw@vireshk-i7>
References: <095901d6ad94$e48d5140$ada7f3c0$@gmail.com> <20201029071952.7yh5ncnxqxf62pjw@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, October 29, 2020 8:19:52 AM CET Viresh Kumar wrote:
> Your mail client is screwing the "In-reply-to" field of the message
> and that prevents it to appear properly in the thread in mailboxes of
> other people, please fix that.
> 
> On 29-10-20, 09:43, zhuguangqing83 wrote:
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 0c5c61a095f6..bf7800e853d3 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -105,7 +105,6 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> > >         if (sg_policy->next_freq == next_freq)
> > >                 return false;
> > > 
> > > -       sg_policy->next_freq = next_freq;
> > >         sg_policy->last_freq_update_time = time;
> > > 
> > >         return true;
> > 
> > It's a little strange that sg_policy->next_freq and 
> > sg_policy->last_freq_update_time are not updated at the same time.
> > 
> > > @@ -115,7 +114,7 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
> > >                               unsigned int next_freq)
> > >  {
> > >         if (sugov_update_next_freq(sg_policy, time, next_freq))
> > > -               cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
> > > +               sg_policy->next_freq = cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
> > >  }
> > > 
> > 
> > Great, it also takes into account the issue that 0 is returned by the
> > driver's ->fast_switch() callback to indicate an error condition.
> 
> Yes but even my change wasn't good enough, more on it later.
> 
> > For policy->min/max may be not the real CPU frequency in OPPs, so
> 
> No, that can't happen. If userspace tries to set a value too large or
> too small, we clamp that too to policy->max/min and so the below
> problem shall never occur.
> 
> > next_freq got from get_next_freq() which is after clamping between
> > policy->min and policy->max may be not the real CPU frequency in OPPs.
> > In that case, if we use a real CPU frequency in OPPs returned from
> > cpufreq_driver_fast_switch() to compare with next_freq,
> > "if (sg_policy->next_freq == next_freq)" will never be satisfied, so we
> > change the CPU frequency every time schedutil callback gets called from
> > the scheduler. I see the current code in get_next_freq() as following,
> > the issue mentioned above should not happen. Maybe it's just one of my
> > unnecessary worries.
> 
> Coming back to my patch (and yours too), it only fixes the fast-switch
> case and not the slow path which can also end up clamping the
> frequency. And to be honest, even the drivers can have their own
> clamping code in place, no one is stopping them too.
> 
> And we also need to do something about the cached_raw_freq as well, as
> it will not be in sync with next_freq anymore.

I'm not actually sure why freq is not clamped between the policy min
and max before comparing it with the cached "raw" value.

IIRC the reason for having cached_raw_freq is because freq may not
correspond to any of the available values in the driver's table, but
why does it not take the policy min and max into account?

> Here is another attempt from me tackling this problem. The idea is to
> check if the previous freq update went as expected or not. And if not,
> we can't rely on next_freq or cached_raw_freq anymore.

Well, need_update_freq was kind of supposed to be the flag for that.

IOW, if need_update_freq is set, all of the cached frequency values should
be discarded and the update should go to the driver, or at least to
__cpufreq_driver_target().  [Note that if user space flips one of the
limits to a new value and back to the previous one between two consecutive
utilization updates from the scheduler, we'll end up invoking the driver
even though the frequency hasn't really changed, but that's part of the
design.]

IOW, when need_freq_update is set in sugov_should_update_freq(), it should
guarantee that the update will reach either cpufreq_driver_fast_switch()
or __cpufreq_driver_target().  IMO this needs to be fixed first.

Now, say this is the case.

Can we miss a limits update?

If limits_changed is set in sugov_limits() before sugov_should_update_freq()
checks it, then all should be fine if I'm not missing anything, so say it is
set after that check.

First, suppose that it wasn't set before, so the check fails and the update
goes with need_update_freq unset.  In that case the next run will have
need_freq_update set and it will reach the "lower level".

In turn, if it was set before, the check succeeds and now limits_changed is
cleared and need_freq_update is set.  Obviously, there is a race between
sugov_limits() and sugov_should_update_freq() and say the former wins, so
limits_changed is set again and the current update as well as the next update
will both have need_freq_update set and the both of them will reach the
"lower level".  This is fine.

OTOH, if sugov_should_update_freq() wins the race, limits_changed will remain
unset, so the next update will not have need_freq_update set, but it will be
set for the current one which will reach the "lower level".

So this should work in either case if I'm not mistaken.

Hence, the problem appears to be that setting need_freq_update does not guarantee
that the update will reach the "lower level" and it looks like need_freq_update
is cleared too early: it should be cleared in sugov_update_next_freq() which
should let the update reach the "lower level" if need_freq_update is set.



