Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2422FFA2
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 04:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgG1Cca (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 22:32:30 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48398 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgG1Cca (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 22:32:30 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BG10s4PTDzFckP;
        Mon, 27 Jul 2020 19:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1595903549; bh=qvDFSVDMY2sUlRTLhD2twJz5sw8RaMjqzpS2Alt6Amw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MTSCKjcmkMsUSr9axeyh4ZSB4HMvWsPzdr10zMkzm9/xCz+AWYMb7uJEcDTK9T34s
         VBVZoBVMRxXyyZRUJbNYVpUMh0tRM7V+uQDiC0KbMpBKezghBx9uKodhoIxWwMIKA8
         /B2/iRFGL1YnzzMGfk5exUCP3jk2ew5t7t2U/+MQ=
X-Riseup-User-ID: 20F4519786F94601615189679F6EDBAEFFF5243EE1A6AC202363011546B83A5F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4BG10p388Mz8tRn;
        Mon, 27 Jul 2020 19:32:26 -0700 (PDT)
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
In-Reply-To: <1818916.Mrn9nftLre@kreacher>
References: <3955470.QvD6XneCf3@kreacher> <CAJZ5v0g2U+1wD5rUQwJ4_x9sQyvGyGiBiLFs7MA-xdhRBX9zBQ@mail.gmail.com> <87mu3thiz5.fsf@riseup.net> <1818916.Mrn9nftLre@kreacher>
Date:   Mon, 27 Jul 2020 19:32:22 -0700
Message-ID: <878sf4gyix.fsf@riseup.net>
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

> On Tuesday, July 21, 2020 1:20:14 AM CEST Francisco Jerez wrote:
>
> [cut]
>
>> >
>> > However, in the active mode the only updater of hwp_req_cached is
>> > intel_pstate_hwp_set() and this patch doesn't introduce any
>> > differences in behavior in that case.
>> >
>>=20
>> intel_pstate_hwp_set() is the only updater, but there are other
>> consumers that can get out of sync with the HWP request value written by
>> intel_pstate_set_energy_pref_index().  intel_pstate_hwp_boost_up() seems
>> like the most concerning example I named earlier.
>>=20
>> >> > So there may be a short time window after the
>> >> > intel_pstate_set_energy_pref_index() invocation in which the new EPP
>> >> > value may not be in effect, but in general there is no guarantee th=
at
>> >> > the new EPP will take effect immediately after updating the MSR
>> >> > anyway, so that race doesn't matter.
>> >> >
>> >> > That said, that race is avoidable, but I was thinking that trying to
>> >> > avoid it might not be worth it.  Now I see a better way to avoid it,
>> >> > though, so I'm going to update the patch to that end.
>> >> >
>> >> >> Seems like a bug to me.
>> >> >
>> >> > It is racy, but not every race is a bug.
>> >> >
>> >>
>> >> Still seems like there is a bug in intel_pstate_set_energy_pref_index=
()
>> >> AFAICT.
>> >
>> > If there is a bug, then what exactly is it, from the users' perspectiv=
e?
>> >
>>=20
>> It can be reproduced easily as follows:
>>=20
>> | echo 1 > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost
>> | for p in /sys/devices/system/cpu/cpufreq/policy*/energy_performance_pr=
eference; do echo performance > $p; done
>
> Is this the active mode or the passive mode with the $subject patch appli=
ed?
>
> If the former, the issue is there regardless of the patch, so it needs to=
 be
> fixed.
>
> If the latter, there should be no effect of hwp_dynamic_boost (which was
> overlooked by me).
>

This seems to be a problem in active mode only, so yeah the bug exists
regardless of your patch, but the fix is likely to allow you to simplify
this series slightly if it allows you to take full advantage of
hwp_req_cached and drop the additional EPP cache.

> [cut]
>=20=20
>> > To really decide what is better, the two alternatively would need to
>> > be compared quatitatively, but it doesn't look like they have been.
>> >
>>=20
>> That's a fair request, I'm all for justifying design decisions
>> quantitatively -- And in fact we did compare my non-HWP controller with
>> the GuC-based solution quantitatively in a BXT platform, and results
>> showed the kernel-based solution to be superior by a significant margin.
>
> Why do you think that this result is significant beyond BXT?
>

Because the limitations of GuC power management relative to the
kernel-driven solution haven't fundamentally changed since BXT.  Of
course it might be that the gap we observed was due to more accidental
reasons, like bugs in the BXT GuC power management code, it would
certainly make sense to recheck.

>> That was a couple of years ago though and many things have changed, we
>> can get you the results of the previous comparison or an updated
>> comparison if you don't find it appealing to look at old numbers.
>>=20
>
> [cut]
>
>> >>
>> >> If we define the instantaneous energy efficiency of a CPU (eta) to be
>> >> the ratio between its instantaneous frequency (f) and power consumpti=
on
>> >> (P),
>> >
>> > I'm sorry, but this definition is conceptually misguided.
>> >
>> > Energy-efficiency (denote it as \phi) can be defined as work/energy wh=
ich means
>> >
>> > \phi =3D dW / dE
>> >
>> > for the instantaneous one and in general that is not the same as the
>> > simple fraction below.
>> >
>>=20
>> Hah!  Actually both definitions are mathematically equivalent everywhere
>> they're both defined.  I assume that the 'd' symbols in your expression
>> denote Leibniz's notation for a total derivative (if they didn't --
>> e.g. if they denoted some sort finite increment instead then I would
>> disagree that your expression is a valid definition of *instantaneous*
>> energy efficiency).  In addition I assume that we agree on there being
>> two well-defined functions of time in the case that concerns us, which
>> we call "instantaneous power consumption" [P(t) =3D dE(t)/dt] and
>> "instantaneous frequency" [f(t) =3D dW(t)/dt].  With that in mind you ju=
st
>> have to apply the standard chain rule from calculus in order to prove
>> the equivalence of both expressions:
>>=20
>> | \phi =3D dW(t(E))/dE =3D dW(t)/dt * dt(E)/dE =3D dW(t)/dt * (dE(t)/dt)=
^-1 =3D
>> |      =3D f(t) * P(t)^-1 =3D eta
>
> Well, under certain assumptions, but OK, I stand corrected.
>
> [cut]
>
>>=20
>> > Regardless, the ultimate goal appears to be to allow the non-CPU
>> > component you care about draw more power.
>> >
>>=20
>> No, I explicitly dismissed that in my previous reply.
>
> But at the same time you seem to agree that without the non-CPU component
> (or thermal pressure) the existing CPU performance scaling would be
> sufficient.
>

Yes, but not necessarily in order to allow the non-CPU component to draw
more power as you said above, but also because the existence of a
bottleneck in a non-CPU component gives us an opportunity to improve the
energy efficiency of the CPU, regardless of whether that allows the
workload to run faster.

> [cut]
>
>> > Yes, it is, and so I don't quite see the connection between it and my =
question.
>> >
>> > Apparently, the unmodified performance scaling governors are not
>> > sufficient, so there must be something beyond the above which allows
>> > you to determine the frequency in question and so I'm asking what that
>> > is.
>> >
>>=20
>> The underlying heuristic assumption is the same as I outlined above, but
>> in any implementation of such a heuristic there is necessarily a
>> trade-off between responsiveness to short-term fluctuations and
>> long-term energy usage.  This trade-off is a function of the somewhat
>> arbitrary time interval I was referring to as "immediate past" -- A
>> longer time parameter allows the controller to consider a greater
>> portion of the workload's history while computing the response with
>> optimal energy usage, at the cost of increasing its reaction time to
>> discontinuous changes in the behavior of the workload (AKA increased
>> latency).
>
> OK
>
>> One of the key differences between the governor I proposed and the
>> pre-existing ones is that it doesn't attempt to come up with a magic
>> time parameter that works for everybody, because there isn't such a
>> thing, since different devices and applications have latency
>> requirements which often differ by orders of magnitude.
>
> The problem with this approach is that, generally speaking, the kernel
> has a definition of "close past" already, which comes from the PELT
> signal in the scheduler.
>
> That signal is used for more than just CPU performance scaling and there
> is a reason for that, as the scheduler's decisions generally need to be
> aligned with CPU performance scaling decisions.
>

Yes, I fully agree that in an ideal world the response latency
constraint I was referring to above would be tracked per-scheduling
entity and used as definition of "close past" by PELT too -- Actually I
think I mentioned I was working on a prototype with scheduler-level
tracking of latency constraints, but other folks requested the RFC to be
based on a simpler interface not requiring scheduler surgery to
implement, which is why I came up with the PM QoS-based interface.  I
believe we have discussed exposing this latency constraint as a third
clamp similar to utilization clamps -- I would be fine with such an
interface if you think it's the way to go.

That said, in most practical cases it should be possible to take close
to full advantage of the response latency information from the schedutil
governor, even if it's provided via PM QoS rather than having
per-scheduling entity granularity -- The time parameter used to control
CPU frequency would just be the most strict among the applications
running in the system, which should prevent performance loss in
applications with a low latency constraint, but might cause us to miss
out some opportunities for energy optimization in a multitasking
environment compared to the full scheduling-based solution.  Doesn't
seem like a deal-breaker to me though and it makes the code
substantially easier to review.

>> Instead, a PM QoS-based interface is introduced [2] which aggregates the
>> latency requirements from multiple clients, and forwards the result to t=
he
>> CPUFREQ governor which dynamically adjusts its time parameter to suit
>> the workloads (hence the name "variably low-pass filtering").
>>=20
>> Individual device drivers are generally in a better position to decide
>> what their latency requirements are than any central PM agent (including
>> the HWP) -- We can talk more about the algorithm used to do that as soon
>> as we've reached some agreement on the basics.
>>=20
>> [2] https://lwn.net/ml/linux-pm/20200428032258.2518-2-currojerez@riseup.=
net/
>
> Because "latency" is a bit overloaded as a technical term (there is the t=
ask
> wakeup latency, the CPU idle state exit latency, network latency and so o=
n),
> it would be good to come up with a better name for this concept.
>

Ah, yes, I think you suggested calling it scaling response frequency
instead, hopefully I updated every reference to response latency in the
code and comments, let me know if I missed any.

>> I'm having trouble coming up with simpler words to express the same
>> thing: My ultimate goal is to improve the energy efficiency of the CPU.
>> Improved energy balancing behavior is only a nice bonus.
>
> Which means doing the same amount of work in the same time while using le=
ss
> energy.
>
> So yes, I would like to talk about the algorithm.
>
> [cut]
>
>> > I guess you mean the paragraph regarding reaching a steady state etc.,
>> > but there's nothing about the CPU performance counters in there, so it
>> > is kind of hard for me to understand this remark.
>> >
>>=20
>> It comes from monitoring the CPU performance counters in the immediate
>> past (the exact definition of "immediate past" being a function of the
>> PM QoS constraints in place) in order to compute the average amount of
>> work delivered by the CPU thread per unit of time, which allows us to
>> find the most energy-efficient P-state which won't negatively impact the
>> performance of the workload under the assumption of steady state.
>
> That's what all CPU performance scaling governors attempt to do.
>
> To be more precise, they attempt to find the minimum P-state (or frequenc=
y)
> that won't negatively impact performance and they attempt to give a reaso=
nable
> performance ramp-up response at the same time.
>
> What you are saying basically means that you have a better CPU performance
> scaling algorithm than the ones used in the existing governors (which very
> well may be true) that can use additional input from entities like device
> drivers (which may know something about the workload that is not known to
> the scheduler).

Yeah, pretty much.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXx+ONgAKCRCDmTidfVK/
W4HOAP4zP7m7rB1cUnuSzqLXHGt8G+Gf049A9ZS/6u9hYgBSlwD/aOfDWDhf6yWg
cMKUT8xrphILI5CUobmf80l6IiJfEq8=
=GcEG
-----END PGP SIGNATURE-----
--==-=-=--
