Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2429322F65F
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 19:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbgG0RPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 13:15:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54586 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgG0RPn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 13:15:43 -0400
Received: from 89-64-87-33.dynamic.chello.pl (89.64.87.33) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 001477bcdc783229; Mon, 27 Jul 2020 19:15:39 +0200
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
Date:   Mon, 27 Jul 2020 19:15:39 +0200
Message-ID: <1818916.Mrn9nftLre@kreacher>
In-Reply-To: <87mu3thiz5.fsf@riseup.net>
References: <3955470.QvD6XneCf3@kreacher> <CAJZ5v0g2U+1wD5rUQwJ4_x9sQyvGyGiBiLFs7MA-xdhRBX9zBQ@mail.gmail.com> <87mu3thiz5.fsf@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, July 21, 2020 1:20:14 AM CEST Francisco Jerez wrote:

[cut]

> >
> > However, in the active mode the only updater of hwp_req_cached is
> > intel_pstate_hwp_set() and this patch doesn't introduce any
> > differences in behavior in that case.
> >
> 
> intel_pstate_hwp_set() is the only updater, but there are other
> consumers that can get out of sync with the HWP request value written by
> intel_pstate_set_energy_pref_index().  intel_pstate_hwp_boost_up() seems
> like the most concerning example I named earlier.
> 
> >> > So there may be a short time window after the
> >> > intel_pstate_set_energy_pref_index() invocation in which the new EPP
> >> > value may not be in effect, but in general there is no guarantee that
> >> > the new EPP will take effect immediately after updating the MSR
> >> > anyway, so that race doesn't matter.
> >> >
> >> > That said, that race is avoidable, but I was thinking that trying to
> >> > avoid it might not be worth it.  Now I see a better way to avoid it,
> >> > though, so I'm going to update the patch to that end.
> >> >
> >> >> Seems like a bug to me.
> >> >
> >> > It is racy, but not every race is a bug.
> >> >
> >>
> >> Still seems like there is a bug in intel_pstate_set_energy_pref_index()
> >> AFAICT.
> >
> > If there is a bug, then what exactly is it, from the users' perspective?
> >
> 
> It can be reproduced easily as follows:
> 
> | echo 1 > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost
> | for p in /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference; do echo performance > $p; done

Is this the active mode or the passive mode with the $subject patch applied?

If the former, the issue is there regardless of the patch, so it needs to be
fixed.

If the latter, there should be no effect of hwp_dynamic_boost (which was
overlooked by me).

[cut]
 
> > To really decide what is better, the two alternatively would need to
> > be compared quatitatively, but it doesn't look like they have been.
> >
> 
> That's a fair request, I'm all for justifying design decisions
> quantitatively -- And in fact we did compare my non-HWP controller with
> the GuC-based solution quantitatively in a BXT platform, and results
> showed the kernel-based solution to be superior by a significant margin.

Why do you think that this result is significant beyond BXT?

> That was a couple of years ago though and many things have changed, we
> can get you the results of the previous comparison or an updated
> comparison if you don't find it appealing to look at old numbers.
> 

[cut]

> >>
> >> If we define the instantaneous energy efficiency of a CPU (eta) to be
> >> the ratio between its instantaneous frequency (f) and power consumption
> >> (P),
> >
> > I'm sorry, but this definition is conceptually misguided.
> >
> > Energy-efficiency (denote it as \phi) can be defined as work/energy which means
> >
> > \phi = dW / dE
> >
> > for the instantaneous one and in general that is not the same as the
> > simple fraction below.
> >
> 
> Hah!  Actually both definitions are mathematically equivalent everywhere
> they're both defined.  I assume that the 'd' symbols in your expression
> denote Leibniz's notation for a total derivative (if they didn't --
> e.g. if they denoted some sort finite increment instead then I would
> disagree that your expression is a valid definition of *instantaneous*
> energy efficiency).  In addition I assume that we agree on there being
> two well-defined functions of time in the case that concerns us, which
> we call "instantaneous power consumption" [P(t) = dE(t)/dt] and
> "instantaneous frequency" [f(t) = dW(t)/dt].  With that in mind you just
> have to apply the standard chain rule from calculus in order to prove
> the equivalence of both expressions:
> 
> | \phi = dW(t(E))/dE = dW(t)/dt * dt(E)/dE = dW(t)/dt * (dE(t)/dt)^-1 =
> |      = f(t) * P(t)^-1 = eta

Well, under certain assumptions, but OK, I stand corrected.

[cut]

> 
> > Regardless, the ultimate goal appears to be to allow the non-CPU
> > component you care about draw more power.
> >
> 
> No, I explicitly dismissed that in my previous reply.

But at the same time you seem to agree that without the non-CPU component
(or thermal pressure) the existing CPU performance scaling would be
sufficient.

[cut]

> > Yes, it is, and so I don't quite see the connection between it and my question.
> >
> > Apparently, the unmodified performance scaling governors are not
> > sufficient, so there must be something beyond the above which allows
> > you to determine the frequency in question and so I'm asking what that
> > is.
> >
> 
> The underlying heuristic assumption is the same as I outlined above, but
> in any implementation of such a heuristic there is necessarily a
> trade-off between responsiveness to short-term fluctuations and
> long-term energy usage.  This trade-off is a function of the somewhat
> arbitrary time interval I was referring to as "immediate past" -- A
> longer time parameter allows the controller to consider a greater
> portion of the workload's history while computing the response with
> optimal energy usage, at the cost of increasing its reaction time to
> discontinuous changes in the behavior of the workload (AKA increased
> latency).

OK

> One of the key differences between the governor I proposed and the
> pre-existing ones is that it doesn't attempt to come up with a magic
> time parameter that works for everybody, because there isn't such a
> thing, since different devices and applications have latency
> requirements which often differ by orders of magnitude.

The problem with this approach is that, generally speaking, the kernel
has a definition of "close past" already, which comes from the PELT
signal in the scheduler.

That signal is used for more than just CPU performance scaling and there
is a reason for that, as the scheduler's decisions generally need to be
aligned with CPU performance scaling decisions.

> Instead, a PM QoS-based interface is introduced [2] which aggregates the
> latency requirements from multiple clients, and forwards the result to the
> CPUFREQ governor which dynamically adjusts its time parameter to suit
> the workloads (hence the name "variably low-pass filtering").
> 
> Individual device drivers are generally in a better position to decide
> what their latency requirements are than any central PM agent (including
> the HWP) -- We can talk more about the algorithm used to do that as soon
> as we've reached some agreement on the basics.
> 
> [2] https://lwn.net/ml/linux-pm/20200428032258.2518-2-currojerez@riseup.net/

Because "latency" is a bit overloaded as a technical term (there is the task
wakeup latency, the CPU idle state exit latency, network latency and so on),
it would be good to come up with a better name for this concept.

> I'm having trouble coming up with simpler words to express the same
> thing: My ultimate goal is to improve the energy efficiency of the CPU.
> Improved energy balancing behavior is only a nice bonus.

Which means doing the same amount of work in the same time while using less
energy.

So yes, I would like to talk about the algorithm.

[cut]

> > I guess you mean the paragraph regarding reaching a steady state etc.,
> > but there's nothing about the CPU performance counters in there, so it
> > is kind of hard for me to understand this remark.
> >
> 
> It comes from monitoring the CPU performance counters in the immediate
> past (the exact definition of "immediate past" being a function of the
> PM QoS constraints in place) in order to compute the average amount of
> work delivered by the CPU thread per unit of time, which allows us to
> find the most energy-efficient P-state which won't negatively impact the
> performance of the workload under the assumption of steady state.

That's what all CPU performance scaling governors attempt to do.

To be more precise, they attempt to find the minimum P-state (or frequency)
that won't negatively impact performance and they attempt to give a reasonable
performance ramp-up response at the same time.

What you are saying basically means that you have a better CPU performance
scaling algorithm than the ones used in the existing governors (which very
well may be true) that can use additional input from entities like device
drivers (which may know something about the workload that is not known to
the scheduler).



