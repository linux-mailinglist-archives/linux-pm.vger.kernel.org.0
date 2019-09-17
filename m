Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3208CB5037
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 16:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfIQOUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 10:20:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:49554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfIQOUC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 10:20:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 077DCAF58;
        Tue, 17 Sep 2019 14:19:59 +0000 (UTC)
Message-ID: <1568730313.3329.1.camel@suse.cz>
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com,
        srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net
Date:   Tue, 17 Sep 2019 16:25:13 +0200
In-Reply-To: <000301d56a76$0022e630$0068b290$@net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
         <20190909024216.5942-2-ggherdovich@suse.cz>
         <000e01d568b5$87de9be0$979bd3a0$@net> <000301d56a76$0022e630$0068b290$@net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Doug,

thanks for testing as usual, having some review on the experimental results is
really helpful. Sorry for the late reply as I'm traveling at the moment.

You raise really good points regarding pinning workloads on cpus, my comments
below.

On Wed, 2019-09-11 at 08:28 -0700, Doug Smythies wrote:
> [...]
>
> I think the "gitsource" test, is the one I learned about here two years
> ago, [1]. It is an extremely good (best I know of) example of single
> threaded, high PID consumption (about 400 / second average, my computer
> [3]), performance issues on a multi CPU computer. I.E., this:
> 
> Dountil the list of tasks is finished:
>    Start the next task in the list of stuff to do.
>    Wait for it to finish
> Enduntil
>

yes that's the one.

> The problem with the test is its run to run variability, which was from
> all the disk I/O, as far as I could determine. At the time,
> I studied this to death [2], and made a more repeatable test, without
> any disk I/O.
> 
> While the challenges with this work flow have tended to be focused
> on the CPU frequency scaling driver, I have always considered
> the root issue here to be a scheduling issue. Excerpt from my notes
> [2]:
> 
> > The issue is that performance is much much better if the system is
> > forced to use only 1 CPU rather than relying on the defaults where
> > the CPU scheduler decides what to do.
> > The scheduler seems to not realize that the current CPU has just
> > become free, and assigns the new task to a new CPU. Thus the load
> > on any one CPU is so low that it doesn't ramp up the CPU frequency.
> > It would be better if somehow the scheduler knew that the current
> > active CPU was now able to take on the new task, overall resulting
> > on one fully loaded CPU at the highest CPU frequency.
> 
> I do not know if such is practical, and I didn't re-visit the issue.
>

You're absolutely right, pinning a serialized, fork-intensive workload such as
gitsource gives you as good of a performance as you can get, because it removes
the scheduler out of the picture.

So one might be tempted to flag this test as non-representative of a
real-world scenario; the reasons we keep looking at it are:

1. pinning may not always practical, as you mention
2. it's an adversary, worst-case sort of test for some scheduler code paths

Experience with enterprise use cases shows that pinning (as with 'taskset') is
done on a case-by-case basis, requires a little more cognitive load (you have
to know the workload in depth, profile it, write ad-hoc scripts to do the
pinning or modify the code of your software etc). In the case of "personal
computing" one hardly bothers about pinning at all.

You definitely want to try those things for the software that runs the core of
your business (say, sometimes the database server), but there is a ton of
ancillary infrastructure out there which is implemented in shell scripts
because it does the job just fine, and it doesn't harm if that goes a little
faster.

The unbound workload (no cpu pinning) will always perform worse than the bound
scenario, simply because the scheduler can't know the future, and it's a good
upper limit to keep in mind when evaluating these results. When a task is
freshly forked the schedutil governor can evaluate its compute need only by
the initialization value of the 'util' PELT signal (see "Per-entity load
tracking" at [LWN-1]); when a task is migrated from a CPU to another its
utilization score is transferred accordingly, so the accrued amount isn't lost
(see again PELT and also "Toward better CPU load estimation" at [LWN-2]).
These are active development areas in the scheduler, and gitsource (as well as
other tests) give an idea of the progress done so far.

[LWN-1] Per-entity load tracking, https://lwn.net/Articles/531853/
[LWN-2] Toward better CPU load estimation, https://lwn.net/Articles/741171/

> Anyway these are my results:
> 
> Kernel: 5.3-rc8 and + these patches
> Processor: i7-2600K
> 
> This is important, at least for the performance governor numbers:
> 
> cpu6: MSR_TURBO_RATIO_LIMIT: 0x23242526
> 35 * 100.0 = 3500.0 MHz max turbo 4 active cores
> 36 * 100.0 = 3600.0 MHz max turbo 3 active cores
> 37 * 100.0 = 3700.0 MHz max turbo 2 active cores
> 38 * 100.0 = 3800.0 MHz max turbo 1 active cores
> 
> For reference against which all other results are compared
> is the forced CPU affinity test run. i.e.:
> 
> taskset -c 3 test_script.
> 
> Mode          Governor                degradation     Power           Bzy_MHz
> Reference     perf 1 CPU              1.00            reference       3798
> -             performance             1.2             6% worse        3618
> passive       ondemand                2.3
> active        powersave               2.6
> passive       schedutil               2.7                             1600
> passive       schedutil-4C            1.68                            2515
> 
> Where degradation ratio is the time to execute / the reference time for
> the same conditions. The test runs over a wide range of processes per
> second, and the worst ratio has been selected for the above table.
> I have yet to write up this experiment, but the graphs that will
> eventually be used are at [4] and [5] (same data presented two
> different ways).

Your table is interesting; I'd say that the one to beat there (from the
schedutil point of view) is intel_pstate(active)/performance. I'm slightly
surprised that intel_pstate(passive)/ondemand is worse than
intel_pstate(active)/powersave, I'd have guessed the other way around but it's
also true that the latter lost some grip on iowait_boost in of the recent
dev cycles.

> 
> I did the "make test" method and, presenting the numbers your way,
> got that 4C took 0.69 times as long as the unpatched schedutil.
> Your numbers were same or better (copied below, lower is better):
> 80x-BROADWELL-NUMA:   0.49
> 8x-SKYLAKE-UMA:               0.55
> 48x-HASWELL-NUMA:             0.69
> 

I think your 0.69 and my three values tell the same story: schedutil really
needs to use the frequency invariant formula otherwise it's out of the
race. Enabling scale-invariance gives multple tens of percent point in
advantage.

Now, is it 0.69 or 0.49? There are many factors to it; that's why I'm happy I
can test on multiple machines and get a somehow more varied picture.

Also, didn't you mention you made several runs and selected the worst one for
the final score? I was less adventurous and took the average of 5 runs for my
gitsource executions :) that might contribute to a slightly higher final mark.

> > > 
> > > Compare it to the update formula of intel_pstate/powersave:
> > > 
> > >    freq_next = 1.25 * freq_max * Busy%
> > > 
> > > where again freq_max is 1C turbo and Busy% is the percentage of time not spent
> > > idling (calculated with delta_MPERF / delta_TSC);
> 
> Note that the delta_MPERF / delta_TSC method includes idle state 0 and the old
> method of utilization does not (at least not last time I investigated, which was
> awhile ago (and I can not find my notes)).

I think that depends on whether or not TSC stops at idle. As understand from
the Intel Software Developer manual (SDM) a TSC that stops at idle is called
"invariant TSC", and makes delta_MPERF / delta_TSC interesting. Otherwise the
two counters behaves exactly the same and the ratio is always 1, modulo the
delays in actually reading the two values. But all I know comes from
turbostat's man page and the SDM, so don't quote me on that :)


Thanks,
Giovanni
