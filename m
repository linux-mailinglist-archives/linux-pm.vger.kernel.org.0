Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C81234A88
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgGaRwh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 13:52:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45052 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbgGaRwg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 13:52:36 -0400
Received: from 89-64-88-186.dynamic.chello.pl (89.64.88.186) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 4c83340291e74d03; Fri, 31 Jul 2020 19:52:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Fri, 31 Jul 2020 19:52:32 +0200
Message-ID: <8215933.FmGRM78LtW@kreacher>
In-Reply-To: <87a6zhg735.fsf@riseup.net>
References: <3955470.QvD6XneCf3@kreacher> <4159348.LxVl7G3d3V@kreacher> <87a6zhg735.fsf@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, July 30, 2020 2:49:34 AM CEST Francisco Jerez wrote:
> 

[cut]

> >> >
> >> >> >> No, I explicitly dismissed that in my previous reply.
> >> >> >
> >> >> > But at the same time you seem to agree that without the non-CPU com=
> pon=3D
> >> ent
> >> >> > (or thermal pressure) the existing CPU performance scaling would be
> >> >> > sufficient.
> >> >> >
> >> >>=3D20
> >> >> Yes, but not necessarily in order to allow the non-CPU component to d=
> raw
> >> >> more power as you said above, but also because the existence of a
> >> >> bottleneck in a non-CPU component gives us an opportunity to improve =
> the
> >> >> energy efficiency of the CPU, regardless of whether that allows the
> >> >> workload to run faster.
> >> >
> >> > But why would the bottleneck be there otherwise?
> >> >
> >>=20
> >> Because some resource of the system (e.g. memory bandwidth, GPU fill
> >> rate) may be close to 100% utilized, causing a bottleneck for reasons
> >> unrelated to its energy usage.
> >
> > Well, not quite.  Or at least in that case the performance cannot be impr=
> oved
> > by limiting the CPU frequency below the frequency looked for by scaling
> > governors, AFAICS.
> >
> 
> Right, but it might still be possible to improve the energy efficiency
> of the workload even if its throughput cannot be improved, which seems
> like a worthwhile purpose in itself.

My point is that in this case the energy-efficiency of the processor cannot
be improved without decreasing performance.

For the processors that are relevant here, the most energy-efficient way to
run them is in the minimum P-state, but that rarely provides the required
performance.  Without the knowledge on how much performance really is required
we assume maximum achievable.  Anything else would need to involve some extra
policy knobs (which are missing ATM) and that is another problem.

I'm not saying that it is not a problem, but it is not possible to say how much
performance to sacrifice without any input from the user on that.

IOW, this is a topic for another discussion.

> > Scaling governors generally look for the maximum frequency at which there=
>  is no
> > CPU idle time in the workload.  At that frequency the CPU time required b=
> y the
> > workload to achieve the maximum performance is equal to the total CPU time
> > available to it.  I till refer to that frequency as the maximum effective
> > frequency (MEF) of the workload.
> >
> > By definition, running at frequencies above the MEF does not improve
> > performance, but it causes CPU idle time to appear.  OTOH running at
> > frequencies below the MEF increases the CPU time required by the workload
> > to achieve the maximum performance, so effectively the workload does
> > not get enough CPU time for the performance to be maximum, so it is lower
> > than at the MEF.
> >
> 
> Yes, we agree on that.
> 
> > Of course, the MEF is well-defined as long as the processor does not share
> > the power budget with another component that is also used by the workload
> > (say, a GPU).  Without the sharing of a power budget, the MEF can be dete=
> rmined
> > by looking at the CPU idle time (or CPU busy time, or CPU load, whichever=
>  is
> > the most convenient) alone, because it already depends on the speed of any
> > memory etc accessed by the workload and slowing down the processor doesn't
> > improve the performance (because the other components don't run any faster
> > as a result of that).
> >
> > However, if the processor is sharing the power budget with a GPU (say), it
> > is not enough to look at the CPU idle time to determine the MEF, because
> > slowing down the processor generally causes the GPU to get more power whi=
> ch
> > allows it to run faster and CPUs can do more work, because they spend less
> > time waiting for the GPU, so the CPU time available to the workload effec=
> tively
> > increases and it can achieve the maximum performance at a lower frequency.
> > So there is "effective MEF" depending on the relative performance balance
> > between the processor and the GPU and on what "fraction" of the workload
> > runs on the GPU.
> >
> 
> That doesn't mean that the MEF isn't well-defined in systems with a
> shared power budget.  If you define it as the lowest frequency at which
> the workload reaches maximum throughput, then there still is one even if
> the system is TDP-bound: the maximum frequency at which the CPU and
> device maintain their optimal power balance -- Above it the power budget
> of the device will be constrained, causing it to run at less than
> optimal throughput, also causing the workload as a whole to run at less
> than optimal throughput.

That is what I am calling the "effective MEF" and the main point is that it
cannot be determined by looking at the CPU idle time alone.

> That said I agree with you that it takes more than looking at the CPU
> utilization in order to determine the MEF in a system with a shared
> power budget -- Until you've reached a steady state close enough to the
> optimal power balance, at which point looking at the CPU utilization is
> really all it takes in order for the governor to estimate the MEF.

I'm not convinced, because in principle there may be many steady states
at "boundary" frequencies, such that the CPU idle time goes from zero to
nonzero when crossing the "boundary", in that case.

That generally depends on what OPPs are available (physically) to the
processor and the GPU (I'm using the GPU as an example, but that may be
something else sharing the power budget with the processor, like an FPGA).

For example, if increasing the CPU frequency above a "boundary" does not
cause it to take up enough of the power budget to force the GPU to switch
over to a lower-frequency OPP, it may very well cause some CPU idle time
to appear, but that doesn't mean that the optimum power balance has been
reached.

In general, the GPU needs to be monitored as well as the CPU and that's
why the GPU bottleneck detection in your patches is key.  But having
that in place one could simply put an upper limit on the CPU frequency
through the existing policy max QoS in the cpufreq framework in response
to the GPU bottleneck without changing the scaling governors.

> IOW, introducing additional power budget variables (in combination with
> additional power curve information from both the CPU and device) *might*
> help you reach the optimal steady state from a suboptimal state more
> quickly in principle, but it won't have any effect on the optimality of
> the final steady state as soon as it's reached.
> 
> Does that mean it's essential to introduce such power variables in order
> for the controller to approach the optimal steady state?  No, because
> any realistic controller attempting to approximate the MEF of the
> workload (whether it's monitoring the power consumption variables or
> not) necessarily needs to overshoot that MEF estimate by some factor in
> order to avoid getting stuck at a low frequency whenever the load
> fluctuates above the current MEF.  This means that even if at some point
> the power balance is far enough from the optimal ratio that the initial
> MEF estimate is off by a fraction greater than the overshoot factor of
> the controller, the controller will get immediate feedback of the
> situation as soon as the device throughput ramps up due to the released
> power budget, allowing it to make a more accurate approximation of the
> real MEF in a small number of iterations (of the order of 1 iteration
> surprisingly frequently).
> 
> > This means that the power budget sharing is essential here and the "if the
> > energy-efficiency of the processor is improved, the other components get
> > more power as a bonus" argument is not really valid.
> >
> 
> That was just a statement of my goals while working on the algorithm
> [improve the energy efficiency of the CPU in presence of an IO
> bottleneck], it's therefore axiomatic in nature rather than some sort of
> logical conclusion that can be dismissed as invalid.  You might say you
> have different goals in mind but that doesn't mean other people's are
> not valid.

Well, this really isn't about the goals but about understanding of what
really happens.

What I'm trying to say is that the sharing of energy budget is a necessary
condition allowing the processor's energy-efficiency to be improved without
sacrificing performance.

> > The frequency of the processor gets limited in order for the other compon=
> ents
> > to get more power, which then allows the processor to do more work in the
> > same time at the same frequency, so it becomes more energy-efficient.
> 
> Whenever the throughput of the workload is limited by its power budget,
> then yes, sure, but even when that's not the case it can be valuable to
> reduce the amount of energy the system is consuming in order to perform
> a certain task.

Yes, it is valuable, but this is a separate problem and addressing it
requires taking additional user input (regarding the energy vs performance
policy) into account.



