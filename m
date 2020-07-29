Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C631A2323C7
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgG2RxS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 13:53:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56218 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgG2RxS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 13:53:18 -0400
Received: from 89-64-89-103.dynamic.chello.pl (89.64.89.103) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id a89a326552f6a4de; Wed, 29 Jul 2020 19:52:45 +0200
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
Date:   Wed, 29 Jul 2020 19:52:44 +0200
Message-ID: <4159348.LxVl7G3d3V@kreacher>
In-Reply-To: <87v9i6g9gf.fsf@riseup.net>
References: <3955470.QvD6XneCf3@kreacher> <2440238.9qpzlEPeD7@kreacher> <87v9i6g9gf.fsf@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, July 29, 2020 7:46:08 AM CEST Francisco Jerez wrote:
> 
> --==-=-=
> Content-Type: multipart/mixed; boundary="=-=-="
> 
> --=-=-=
> Content-Type: text/plain; charset=utf-8
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> > On Tuesday, July 28, 2020 4:32:22 AM CEST Francisco Jerez wrote:
> >>
> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> >>=20
> >> > On Tuesday, July 21, 2020 1:20:14 AM CEST Francisco Jerez wrote:
> >> >
> >> > [cut]
> >> >
> >> >> >
> >> >> > However, in the active mode the only updater of hwp_req_cached is
> >> >> > intel_pstate_hwp_set() and this patch doesn't introduce any
> >> >> > differences in behavior in that case.
> >> >> >
> >> >>=3D20
> >> >> intel_pstate_hwp_set() is the only updater, but there are other
> >> >> consumers that can get out of sync with the HWP request value written=
>  by
> >> >> intel_pstate_set_energy_pref_index().  intel_pstate_hwp_boost_up() se=
> ems
> >> >> like the most concerning example I named earlier.
> >> >>=3D20
> >> >> >> > So there may be a short time window after the
> >> >> >> > intel_pstate_set_energy_pref_index() invocation in which the new=
>  EPP
> >> >> >> > value may not be in effect, but in general there is no guarantee=
>  th=3D
> >> at
> >> >> >> > the new EPP will take effect immediately after updating the MSR
> >> >> >> > anyway, so that race doesn't matter.
> >> >> >> >
> >> >> >> > That said, that race is avoidable, but I was thinking that tryin=
> g to
> >> >> >> > avoid it might not be worth it.  Now I see a better way to avoid=
>  it,
> >> >> >> > though, so I'm going to update the patch to that end.
> >> >> >> >
> >> >> >> >> Seems like a bug to me.
> >> >> >> >
> >> >> >> > It is racy, but not every race is a bug.
> >> >> >> >
> >> >> >>
> >> >> >> Still seems like there is a bug in intel_pstate_set_energy_pref_in=
> dex=3D
> >> ()
> >> >> >> AFAICT.
> >> >> >
> >> >> > If there is a bug, then what exactly is it, from the users' perspec=
> tiv=3D
> >> e?
> >> >> >
> >> >>=3D20
> >> >> It can be reproduced easily as follows:
> >> >>=3D20
> >> >> | echo 1 > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost
> >> >> | for p in /sys/devices/system/cpu/cpufreq/policy*/energy_performance=
> _pr=3D
> >> eference; do echo performance > $p; done
> >> >
> >> > Is this the active mode or the passive mode with the $subject patch ap=
> pli=3D
> >> ed?
> >> >
> >> > If the former, the issue is there regardless of the patch, so it needs=
>  to=3D
> >>  be
> >> > fixed.
> >> >
> >> > If the latter, there should be no effect of hwp_dynamic_boost (which w=
> as
> >> > overlooked by me).
> >> >
> >>=20
> >> This seems to be a problem in active mode only, so yeah the bug exists
> >> regardless of your patch, but the fix is likely to allow you to simplify
> >> this series slightly if it allows you to take full advantage of
> >> hwp_req_cached and drop the additional EPP cache.
> >
> > The additional EPP cache is there to avoid synchronizing the scheduler
> > context directly with a random process running on another CPU and doing
> > things that may take time.
> >
> > The difference between the active mode and the passive mode in this respe=
> ct
> > is that in the latter case hwp_req_cached generally needs to be updated f=
> rom
> > the scheduler context, whereas in the former case it does not.
> >
> 
> Hm, that's unfortunate.  Though I'd be surprised to see any appreciable
> performance penalty from synchronizing with a sysfs handler that should
> hardly ever be called.  Anyway thanks for the fix.

No problem.

> > [cut]
> >
> >> >> No, I explicitly dismissed that in my previous reply.
> >> >
> >> > But at the same time you seem to agree that without the non-CPU compon=
> ent
> >> > (or thermal pressure) the existing CPU performance scaling would be
> >> > sufficient.
> >> >
> >>=20
> >> Yes, but not necessarily in order to allow the non-CPU component to draw
> >> more power as you said above, but also because the existence of a
> >> bottleneck in a non-CPU component gives us an opportunity to improve the
> >> energy efficiency of the CPU, regardless of whether that allows the
> >> workload to run faster.
> >
> > But why would the bottleneck be there otherwise?
> >
> 
> Because some resource of the system (e.g. memory bandwidth, GPU fill
> rate) may be close to 100% utilized, causing a bottleneck for reasons
> unrelated to its energy usage.

Well, not quite.  Or at least in that case the performance cannot be improved
by limiting the CPU frequency below the frequency looked for by scaling
governors, AFAICS.

Scaling governors generally look for the maximum frequency at which there is no
CPU idle time in the workload.  At that frequency the CPU time required by the
workload to achieve the maximum performance is equal to the total CPU time
available to it.  I till refer to that frequency as the maximum effective
frequency (MEF) of the workload.

By definition, running at frequencies above the MEF does not improve
performance, but it causes CPU idle time to appear.  OTOH running at
frequencies below the MEF increases the CPU time required by the workload
to achieve the maximum performance, so effectively the workload does
not get enough CPU time for the performance to be maximum, so it is lower
than at the MEF.

Of course, the MEF is well-defined as long as the processor does not share
the power budget with another component that is also used by the workload
(say, a GPU).  Without the sharing of a power budget, the MEF can be determined
by looking at the CPU idle time (or CPU busy time, or CPU load, whichever is
the most convenient) alone, because it already depends on the speed of any
memory etc accessed by the workload and slowing down the processor doesn't
improve the performance (because the other components don't run any faster
as a result of that).

However, if the processor is sharing the power budget with a GPU (say), it
is not enough to look at the CPU idle time to determine the MEF, because
slowing down the processor generally causes the GPU to get more power which
allows it to run faster and CPUs can do more work, because they spend less
time waiting for the GPU, so the CPU time available to the workload effectively
increases and it can achieve the maximum performance at a lower frequency.
So there is "effective MEF" depending on the relative performance balance
between the processor and the GPU and on what "fraction" of the workload
runs on the GPU.

This means that the power budget sharing is essential here and the "if the
energy-efficiency of the processor is improved, the other components get
more power as a bonus" argument is not really valid.

The frequency of the processor gets limited in order for the other components
to get more power, which then allows the processor to do more work in the
same time at the same frequency, so it becomes more energy-efficient.



