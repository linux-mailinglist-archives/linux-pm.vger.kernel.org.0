Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8FABC3EF
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409291AbfIXINI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 04:13:08 -0400
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:48986 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406311AbfIXINI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 04:13:08 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Sep 2019 04:13:07 EDT
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id 2D2DAD7E
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 09:06:14 +0100 (IST)
Received: (qmail 32284 invoked from network); 24 Sep 2019 08:06:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Sep 2019 08:06:13 -0000
Date:   Tue, 24 Sep 2019 09:06:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Giovanni Gherdovich' <ggherdovich@suse.cz>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com,
        srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
Message-ID: <20190924080608.GA3321@techsingularity.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
 <20190909024216.5942-2-ggherdovich@suse.cz>
 <000e01d568b5$87de9be0$979bd3a0$@net>
 <000301d56a76$0022e630$0068b290$@net>
 <1568730313.3329.1.camel@suse.cz>
 <001a01d56ef8$7abb07c0$70311740$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <001a01d56ef8$7abb07c0$70311740$@net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 19, 2019 at 07:42:29AM -0700, Doug Smythies wrote:
> On 2019.09.17 07:25 Giovanni Gherdovich wrote:
> >On Wed, 2019-09-11 at 08:28 -0700, Doug Smythies wrote:
> > [...]
> 
> >> The problem with the test is its run to run variability, which was from
> >> all the disk I/O, as far as I could determine. At the time,
> >> I studied this to death [2], and made a more repeatable test, without
> >> any disk I/O.
> >> 
> >> While the challenges with this work flow have tended to be focused
> >> on the CPU frequency scaling driver, I have always considered
> >> the root issue here to be a scheduling issue. Excerpt from my notes
> >> [2]:
> >> 
> >>> The issue is that performance is much much better if the system is
> >>> forced to use only 1 CPU rather than relying on the defaults where
> >>> the CPU scheduler decides what to do.
> >>> The scheduler seems to not realize that the current CPU has just
> >>> become free, and assigns the new task to a new CPU. Thus the load
> >>> on any one CPU is so low that it doesn't ramp up the CPU frequency.
> >>> It would be better if somehow the scheduler knew that the current
> >>> active CPU was now able to take on the new task, overall resulting
> >>> on one fully loaded CPU at the highest CPU frequency.
> >> 
> >> I do not know if such is practical, and I didn't re-visit the issue.
> >>
> >
> > You're absolutely right, pinning a serialized, fork-intensive workload such as
> > gitsource gives you as good of a performance as you can get, because it removes
> > the scheduler out of the picture.
> >
> > So one might be tempted to flag this test as non-representative of a
> > real-world scenario;
> 
> Disagree. I consider this test to be very representative of real-world
> scenarios. However, and I do not know for certain, the relatively high
> average fork rate of the gitsource "make test" is less common.
> 

I think it's common enough to be interesting. What I would be very cautious
of is considering this patch in the context of the scheduler decisions
made for synchronous tasks. By synchronous, I mean any waker/wakee
pattern where the waker always goes immediately to sleep. In that case,
it is best for the wakee to use the same CPU as the waker. Unfortunately,
the kernel has tried numerous times to accurately detect when a waker
will immediately go to sleep and it has never worked out properly. When
the sync wakeup hint was strictly obeyed, there were too many cases where
the waker did not immediately sleep and there was a latency hit for the
wakee when nearby cores were idle. `perf sched pipe is an excellent example
of a case where staking the wakee on the same CPU as the waker performs
excellently but there are too many other realistic workloads where it is
a sub-optimal decision such as a waker waking multiple wakees before it
goes to sleep meaning stacking should definitely not happen.

Hence, I think this patchset should be considered on its own merits.
There will always be some guesswork when deciding what factor to use
to account for turbo but the patch is still better than allowing the
estimated utilisation to vary depending on the CPU frequency.

I think the patch is fine and should be merged with the main caveat being
that some CPU families may need to use a different calculation to account
for turbo boost which is a per-arch and per-cpu-family decision. What,
if anything, should change in this patchset before it can be merged? Even
if there is follow-on work that is necessary then it still looks like a
reasonable starting point to me. If the waker/wakee stacking problem was
revisited, it would still be orthogonal to this patch and they would not
be in conflict.

> > I think your 0.69 and my three values tell the same story: schedutil really
> > needs to use the frequency invariant formula otherwise it's out of the
> > race. Enabling scale-invariance gives multple tens of percent point in
> > advantage.
> 
> Agreed. This frequency invariant addition is great. However, if
> schedutil is "out of the race" without it, as you say, then isn't
> intel_pstate(passive)/ondemand out of the race also? It performs
> just as poorly for this test, until very low PIDs per second.
> 

In the intel_pstate case, there have been hacks carried out of tree
trying to avoid some of the downsides of it. It also had things like IO
wait boosting in mainline which was partially to handle the case where
history was lost and in some cases to avoid problems when the wakup on
IO completion moved a task to another CPU.

I think it's a fair assessment to say that schedutil suffers if
frequency invariance is not used regardless of what the other cpufreq
drivers do.

> >>>> Compare it to the update formula of intel_pstate/powersave:
> >>> 
> >>>    freq_next = 1.25 * freq_max * Busy%
> >>> 
> >>> where again freq_max is 1C turbo and Busy% is the percentage of time not spent
> >>> idling (calculated with delta_MPERF / delta_TSC);
> >> 
> >> Note that the delta_MPERF / delta_TSC method includes idle state 0 and the old
> >> method of utilization does not (at least not last time I investigated, which was
> >> awhile ago (and I can not find my notes)).
> >
> > I think that depends on whether or not TSC stops at idle. As understand from
> > the Intel Software Developer manual (SDM) a TSC that stops at idle is called
> > "invariant TSC", and makes delta_MPERF / delta_TSC interesting. Otherwise the
> > two counters behaves exactly the same and the ratio is always 1, modulo the
> > delays in actually reading the two values. But all I know comes from
> > turbostat's man page and the SDM, so don't quote me on that :)
> 
> I was only talking about idle state 0 (polling), where TSC does not stop.
> 
> By the way, I have now done some tests with this patch set and multi-threaded
> stuff. Nothing to report, it all looks great.
> 
> [1] http://www.smythies.com/~doug/linux/single-threaded/gg-pidps2.png
> 

Is that an acked-by?

Thanks.

-- 
Mel Gorman
SUSE Labs
