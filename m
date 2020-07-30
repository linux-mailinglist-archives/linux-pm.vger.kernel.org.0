Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2207D23292A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 02:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG3Atj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 20:49:39 -0400
Received: from mx1.riseup.net ([198.252.153.129]:37994 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgG3Ati (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 20:49:38 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BHBdG1jpTzFdwv;
        Wed, 29 Jul 2020 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1596070178; bh=KhXGihc1+jBDcQWBleUD/RrGa5MUgxJIL3uPkZqTJCY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ap54z26GMP3e0DqbtIfiFgr4AeOIqvI0Wr5TpLc0KoTlWEze/JorHxuQEN5MkwUAu
         LdY0ISTNG2JkNr2RB0vnQa9OYPO5NwP31YfLHwg+un499nOhyPVNuWhHOq1gRDnV0b
         Lmdko4Ne5uYq9i+k0LObqWvK8giX2ms7qGi7GA2Q=
X-Riseup-User-ID: 8E681750F807C2D3BD8C7B19D5E784C71915F12D23C7C897C3443CCEDA6D9E11
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4BHBdF4RBlz8tJg;
        Wed, 29 Jul 2020 17:49:37 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
In-Reply-To: <4159348.LxVl7G3d3V@kreacher>
References: <3955470.QvD6XneCf3@kreacher> <2440238.9qpzlEPeD7@kreacher> <87v9i6g9gf.fsf@riseup.net> <4159348.LxVl7G3d3V@kreacher>
Date:   Wed, 29 Jul 2020 17:49:34 -0700
Message-ID: <87a6zhg735.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Wednesday, July 29, 2020 7:46:08 AM CEST Francisco Jerez wrote:
>>=20
>> --=3D=3D-=3D-=3D
>> Content-Type: multipart/mixed; boundary=3D"=3D-=3D-=3D"
>>=20
>> --=3D-=3D-=3D
>> Content-Type: text/plain; charset=3Dutf-8
>> Content-Disposition: inline
>> Content-Transfer-Encoding: quoted-printable
>>=20
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>=20
>> > On Tuesday, July 28, 2020 4:32:22 AM CEST Francisco Jerez wrote:
>> >>
>> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>> >>=3D20
>> >> > On Tuesday, July 21, 2020 1:20:14 AM CEST Francisco Jerez wrote:
>> >> >
>> >> > [cut]
>> >> >
>> >> >> >
>> >> >> > However, in the active mode the only updater of hwp_req_cached is
>> >> >> > intel_pstate_hwp_set() and this patch doesn't introduce any
>> >> >> > differences in behavior in that case.
>> >> >> >
>> >> >>=3D3D20
>> >> >> intel_pstate_hwp_set() is the only updater, but there are other
>> >> >> consumers that can get out of sync with the HWP request value writ=
ten=3D
>>  by
>> >> >> intel_pstate_set_energy_pref_index().  intel_pstate_hwp_boost_up()=
 se=3D
>> ems
>> >> >> like the most concerning example I named earlier.
>> >> >>=3D3D20
>> >> >> >> > So there may be a short time window after the
>> >> >> >> > intel_pstate_set_energy_pref_index() invocation in which the =
new=3D
>>  EPP
>> >> >> >> > value may not be in effect, but in general there is no guaran=
tee=3D
>>  th=3D3D
>> >> at
>> >> >> >> > the new EPP will take effect immediately after updating the M=
SR
>> >> >> >> > anyway, so that race doesn't matter.
>> >> >> >> >
>> >> >> >> > That said, that race is avoidable, but I was thinking that tr=
yin=3D
>> g to
>> >> >> >> > avoid it might not be worth it.  Now I see a better way to av=
oid=3D
>>  it,
>> >> >> >> > though, so I'm going to update the patch to that end.
>> >> >> >> >
>> >> >> >> >> Seems like a bug to me.
>> >> >> >> >
>> >> >> >> > It is racy, but not every race is a bug.
>> >> >> >> >
>> >> >> >>
>> >> >> >> Still seems like there is a bug in intel_pstate_set_energy_pref=
_in=3D
>> dex=3D3D
>> >> ()
>> >> >> >> AFAICT.
>> >> >> >
>> >> >> > If there is a bug, then what exactly is it, from the users' pers=
pec=3D
>> tiv=3D3D
>> >> e?
>> >> >> >
>> >> >>=3D3D20
>> >> >> It can be reproduced easily as follows:
>> >> >>=3D3D20
>> >> >> | echo 1 > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost
>> >> >> | for p in /sys/devices/system/cpu/cpufreq/policy*/energy_performa=
nce=3D
>> _pr=3D3D
>> >> eference; do echo performance > $p; done
>> >> >
>> >> > Is this the active mode or the passive mode with the $subject patch=
 ap=3D
>> pli=3D3D
>> >> ed?
>> >> >
>> >> > If the former, the issue is there regardless of the patch, so it ne=
eds=3D
>>  to=3D3D
>> >>  be
>> >> > fixed.
>> >> >
>> >> > If the latter, there should be no effect of hwp_dynamic_boost (whic=
h w=3D
>> as
>> >> > overlooked by me).
>> >> >
>> >>=3D20
>> >> This seems to be a problem in active mode only, so yeah the bug exists
>> >> regardless of your patch, but the fix is likely to allow you to simpl=
ify
>> >> this series slightly if it allows you to take full advantage of
>> >> hwp_req_cached and drop the additional EPP cache.
>> >
>> > The additional EPP cache is there to avoid synchronizing the scheduler
>> > context directly with a random process running on another CPU and doing
>> > things that may take time.
>> >
>> > The difference between the active mode and the passive mode in this re=
spe=3D
>> ct
>> > is that in the latter case hwp_req_cached generally needs to be update=
d f=3D
>> rom
>> > the scheduler context, whereas in the former case it does not.
>> >
>>=20
>> Hm, that's unfortunate.  Though I'd be surprised to see any appreciable
>> performance penalty from synchronizing with a sysfs handler that should
>> hardly ever be called.  Anyway thanks for the fix.
>
> No problem.
>
>> > [cut]
>> >
>> >> >> No, I explicitly dismissed that in my previous reply.
>> >> >
>> >> > But at the same time you seem to agree that without the non-CPU com=
pon=3D
>> ent
>> >> > (or thermal pressure) the existing CPU performance scaling would be
>> >> > sufficient.
>> >> >
>> >>=3D20
>> >> Yes, but not necessarily in order to allow the non-CPU component to d=
raw
>> >> more power as you said above, but also because the existence of a
>> >> bottleneck in a non-CPU component gives us an opportunity to improve =
the
>> >> energy efficiency of the CPU, regardless of whether that allows the
>> >> workload to run faster.
>> >
>> > But why would the bottleneck be there otherwise?
>> >
>>=20
>> Because some resource of the system (e.g. memory bandwidth, GPU fill
>> rate) may be close to 100% utilized, causing a bottleneck for reasons
>> unrelated to its energy usage.
>
> Well, not quite.  Or at least in that case the performance cannot be impr=
oved
> by limiting the CPU frequency below the frequency looked for by scaling
> governors, AFAICS.
>

Right, but it might still be possible to improve the energy efficiency
of the workload even if its throughput cannot be improved, which seems
like a worthwhile purpose in itself.

> Scaling governors generally look for the maximum frequency at which there=
 is no
> CPU idle time in the workload.  At that frequency the CPU time required b=
y the
> workload to achieve the maximum performance is equal to the total CPU time
> available to it.  I till refer to that frequency as the maximum effective
> frequency (MEF) of the workload.
>
> By definition, running at frequencies above the MEF does not improve
> performance, but it causes CPU idle time to appear.  OTOH running at
> frequencies below the MEF increases the CPU time required by the workload
> to achieve the maximum performance, so effectively the workload does
> not get enough CPU time for the performance to be maximum, so it is lower
> than at the MEF.
>

Yes, we agree on that.

> Of course, the MEF is well-defined as long as the processor does not share
> the power budget with another component that is also used by the workload
> (say, a GPU).  Without the sharing of a power budget, the MEF can be dete=
rmined
> by looking at the CPU idle time (or CPU busy time, or CPU load, whichever=
 is
> the most convenient) alone, because it already depends on the speed of any
> memory etc accessed by the workload and slowing down the processor doesn't
> improve the performance (because the other components don't run any faster
> as a result of that).
>
> However, if the processor is sharing the power budget with a GPU (say), it
> is not enough to look at the CPU idle time to determine the MEF, because
> slowing down the processor generally causes the GPU to get more power whi=
ch
> allows it to run faster and CPUs can do more work, because they spend less
> time waiting for the GPU, so the CPU time available to the workload effec=
tively
> increases and it can achieve the maximum performance at a lower frequency.
> So there is "effective MEF" depending on the relative performance balance
> between the processor and the GPU and on what "fraction" of the workload
> runs on the GPU.
>

That doesn't mean that the MEF isn't well-defined in systems with a
shared power budget.  If you define it as the lowest frequency at which
the workload reaches maximum throughput, then there still is one even if
the system is TDP-bound: the maximum frequency at which the CPU and
device maintain their optimal power balance -- Above it the power budget
of the device will be constrained, causing it to run at less than
optimal throughput, also causing the workload as a whole to run at less
than optimal throughput.

That said I agree with you that it takes more than looking at the CPU
utilization in order to determine the MEF in a system with a shared
power budget -- Until you've reached a steady state close enough to the
optimal power balance, at which point looking at the CPU utilization is
really all it takes in order for the governor to estimate the MEF.

IOW, introducing additional power budget variables (in combination with
additional power curve information from both the CPU and device) *might*
help you reach the optimal steady state from a suboptimal state more
quickly in principle, but it won't have any effect on the optimality of
the final steady state as soon as it's reached.

Does that mean it's essential to introduce such power variables in order
for the controller to approach the optimal steady state?  No, because
any realistic controller attempting to approximate the MEF of the
workload (whether it's monitoring the power consumption variables or
not) necessarily needs to overshoot that MEF estimate by some factor in
order to avoid getting stuck at a low frequency whenever the load
fluctuates above the current MEF.  This means that even if at some point
the power balance is far enough from the optimal ratio that the initial
MEF estimate is off by a fraction greater than the overshoot factor of
the controller, the controller will get immediate feedback of the
situation as soon as the device throughput ramps up due to the released
power budget, allowing it to make a more accurate approximation of the
real MEF in a small number of iterations (of the order of 1 iteration
surprisingly frequently).

> This means that the power budget sharing is essential here and the "if the
> energy-efficiency of the processor is improved, the other components get
> more power as a bonus" argument is not really valid.
>

That was just a statement of my goals while working on the algorithm
[improve the energy efficiency of the CPU in presence of an IO
bottleneck], it's therefore axiomatic in nature rather than some sort of
logical conclusion that can be dismissed as invalid.  You might say you
have different goals in mind but that doesn't mean other people's are
not valid.

> The frequency of the processor gets limited in order for the other compon=
ents
> to get more power, which then allows the processor to do more work in the
> same time at the same frequency, so it becomes more energy-efficient.

Whenever the throughput of the workload is limited by its power budget,
then yes, sure, but even when that's not the case it can be valuable to
reduce the amount of energy the system is consuming in order to perform
a certain task.  Ask the guy playing a videogame or watching a movie on
battery power while sitting on a train.  Or the datacenter operator
unable to bring another node online because of their power/thermal
dissipation budget.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXyIZHgAKCRCDmTidfVK/
W647AP0aA0Cwrzo1IAmnGs7hw378YfNEfUYN2opDnfe0dg9dHgD+NhLl8uSnnAMb
qvwudSByXqg/YP7f0NcLNKwR1XPDtEQ=
=eqns
-----END PGP SIGNATURE-----
--==-=-=--
