Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77579234DB0
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGaWnW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 18:43:22 -0400
Received: from mx1.riseup.net ([198.252.153.129]:38620 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgGaWnV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 18:43:21 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BJMkc3nhvzDt1H;
        Fri, 31 Jul 2020 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1596235400; bh=6MLQuFL3I6PKFEa9Q4Dd5Un1sLtaq9w3Cd48YMDN+eA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GRvSHnw8U09i/GMLBAgi7q8B3jRJ/g4WmtfnxSgsQQI3ZK0AHAdq4wnL2ftrXuFf7
         lzCXE3W8350z1BwaR88AwcDWAhz0QXNOFmsHdC4BTVS/uJxyx5JVFux9rmMpPt6IeK
         zs3rvy5Anx3/jqKND5aa/NNyIgTQLZFxexfRiYJ4=
X-Riseup-User-ID: 1F5351C64414F83B204040C693392CE5611017C62A5812F2E0F28D50A3FB4662
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 4BJMkb5dkVzJmgK;
        Fri, 31 Jul 2020 15:43:19 -0700 (PDT)
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
In-Reply-To: <8215933.FmGRM78LtW@kreacher>
References: <3955470.QvD6XneCf3@kreacher> <4159348.LxVl7G3d3V@kreacher> <87a6zhg735.fsf@riseup.net> <8215933.FmGRM78LtW@kreacher>
Date:   Fri, 31 Jul 2020 15:43:16 -0700
Message-ID: <871rkre263.fsf@riseup.net>
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

> On Thursday, July 30, 2020 2:49:34 AM CEST Francisco Jerez wrote:
>>=20
>
> [cut]
>
>> >> >
>> >> >> >> No, I explicitly dismissed that in my previous reply.
>> >> >> >
>> >> >> > But at the same time you seem to agree that without the non-CPU =
com=3D
>> pon=3D3D
>> >> ent
>> >> >> > (or thermal pressure) the existing CPU performance scaling would=
 be
>> >> >> > sufficient.
>> >> >> >
>> >> >>=3D3D20
>> >> >> Yes, but not necessarily in order to allow the non-CPU component t=
o d=3D
>> raw
>> >> >> more power as you said above, but also because the existence of a
>> >> >> bottleneck in a non-CPU component gives us an opportunity to impro=
ve =3D
>> the
>> >> >> energy efficiency of the CPU, regardless of whether that allows the
>> >> >> workload to run faster.
>> >> >
>> >> > But why would the bottleneck be there otherwise?
>> >> >
>> >>=3D20
>> >> Because some resource of the system (e.g. memory bandwidth, GPU fill
>> >> rate) may be close to 100% utilized, causing a bottleneck for reasons
>> >> unrelated to its energy usage.
>> >
>> > Well, not quite.  Or at least in that case the performance cannot be i=
mpr=3D
>> oved
>> > by limiting the CPU frequency below the frequency looked for by scaling
>> > governors, AFAICS.
>> >
>>=20
>> Right, but it might still be possible to improve the energy efficiency
>> of the workload even if its throughput cannot be improved, which seems
>> like a worthwhile purpose in itself.
>
> My point is that in this case the energy-efficiency of the processor cann=
ot
> be improved without decreasing performance.
>

Well in principle it can whenever there is a bottleneck in a non-CPU
component.

> For the processors that are relevant here, the most energy-efficient way =
to
> run them is in the minimum P-state, but that rarely provides the required
> performance.  Without the knowledge on how much performance really is req=
uired
> we assume maximum achievable.  Anything else would need to involve some e=
xtra
> policy knobs (which are missing ATM) and that is another problem.
>

But there is a middle ground between limiting the workload to run at the
minimum P-state and having it run at the maximum achievable P-state.
The MEF estimation we were just talking about can help.  However due to
its heuristic nature I certainly see the merit of having policy knobs
allowing the optimization to be controlled by users, which is why I
added such controls in v2.99, at your request.

> I'm not saying that it is not a problem, but it is not possible to say ho=
w much
> performance to sacrifice without any input from the user on that.
>
> IOW, this is a topic for another discussion.
>

I have the vague recollection that you brought that up already and I
agreed and implemented the changes you asked for.

>> > Scaling governors generally look for the maximum frequency at which th=
ere=3D
>>  is no
>> > CPU idle time in the workload.  At that frequency the CPU time require=
d b=3D
>> y the
>> > workload to achieve the maximum performance is equal to the total CPU =
time
>> > available to it.  I till refer to that frequency as the maximum effect=
ive
>> > frequency (MEF) of the workload.
>> >
>> > By definition, running at frequencies above the MEF does not improve
>> > performance, but it causes CPU idle time to appear.  OTOH running at
>> > frequencies below the MEF increases the CPU time required by the workl=
oad
>> > to achieve the maximum performance, so effectively the workload does
>> > not get enough CPU time for the performance to be maximum, so it is lo=
wer
>> > than at the MEF.
>> >
>>=20
>> Yes, we agree on that.
>>=20
>> > Of course, the MEF is well-defined as long as the processor does not s=
hare
>> > the power budget with another component that is also used by the workl=
oad
>> > (say, a GPU).  Without the sharing of a power budget, the MEF can be d=
ete=3D
>> rmined
>> > by looking at the CPU idle time (or CPU busy time, or CPU load, whiche=
ver=3D
>>  is
>> > the most convenient) alone, because it already depends on the speed of=
 any
>> > memory etc accessed by the workload and slowing down the processor doe=
sn't
>> > improve the performance (because the other components don't run any fa=
ster
>> > as a result of that).
>> >
>> > However, if the processor is sharing the power budget with a GPU (say)=
, it
>> > is not enough to look at the CPU idle time to determine the MEF, becau=
se
>> > slowing down the processor generally causes the GPU to get more power =
whi=3D
>> ch
>> > allows it to run faster and CPUs can do more work, because they spend =
less
>> > time waiting for the GPU, so the CPU time available to the workload ef=
fec=3D
>> tively
>> > increases and it can achieve the maximum performance at a lower freque=
ncy.
>> > So there is "effective MEF" depending on the relative performance bala=
nce
>> > between the processor and the GPU and on what "fraction" of the worklo=
ad
>> > runs on the GPU.
>> >
>>=20
>> That doesn't mean that the MEF isn't well-defined in systems with a
>> shared power budget.  If you define it as the lowest frequency at which
>> the workload reaches maximum throughput, then there still is one even if
>> the system is TDP-bound: the maximum frequency at which the CPU and
>> device maintain their optimal power balance -- Above it the power budget
>> of the device will be constrained, causing it to run at less than
>> optimal throughput, also causing the workload as a whole to run at less
>> than optimal throughput.
>
> That is what I am calling the "effective MEF" and the main point is that =
it
> cannot be determined by looking at the CPU idle time alone.
>

And my main point is that it can (by looking at its average frequency
alone -- closely related but not fully equivalent to CPU idle time) *if*
the workload has reached a steady state close enough to its optimal
power balance.  Then I tried to explain how the governor I implemented
approaches such an optimal steady state from any arbitrary sub-optimal
state *without* relying on monitoring power consumption via RAPL.

>> That said I agree with you that it takes more than looking at the CPU
>> utilization in order to determine the MEF in a system with a shared
>> power budget -- Until you've reached a steady state close enough to the
>> optimal power balance, at which point looking at the CPU utilization is
>> really all it takes in order for the governor to estimate the MEF.
>
> I'm not convinced, because in principle there may be many steady states
> at "boundary" frequencies, such that the CPU idle time goes from zero to
> nonzero when crossing the "boundary", in that case.
>
> That generally depends on what OPPs are available (physically) to the
> processor and the GPU (I'm using the GPU as an example, but that may be
> something else sharing the power budget with the processor, like an FPGA).
>
> For example, if increasing the CPU frequency above a "boundary" does not
> cause it to take up enough of the power budget to force the GPU to switch
> over to a lower-frequency OPP, it may very well cause some CPU idle time
> to appear, but that doesn't mean that the optimum power balance has been
> reached.
>

But you do agree that, under the assumption (1) of steady state, and the
assumption (2) that the processor has already crossed the right
boundaries for the power balance to be close to optimal, it is
sufficient to look at its average frequency ("average" defined with a
time parameter consistent with the latency constraints of the workload)
in order to estimate its MEF.  Or?

Due to the optimality assumption (2), the computational power that the
workload can extract out of the bottlenecking device is maximal, which
means that the amount of time the CPU spends waiting for the device per
unit of CPU work is minimal, which means that even if we run the CPU at
a higher frequency it won't take less time per unit of CPU work, which
means that we have reached the MEF.  Due to the steady state assumption
(1) we can then extrapolate the MEF estimate computed for the immediate
past into the immediate future, which is the heuristic part of this.

Then it remains to show that the controller will approach such an
optimal steady state even if assumption (2) doesn't hold initially,
which is what I tried to do in my previous e-mail at a high level.  Let
me know if my explanation wasn't clear enough.

> In general, the GPU needs to be monitored as well as the CPU and that's
> why the GPU bottleneck detection in your patches is key.  But having
> that in place one could simply put an upper limit on the CPU frequency
> through the existing policy max QoS in the cpufreq framework in response
> to the GPU bottleneck without changing the scaling governors.
>

Yes, at the cost of monitoring the average frequency of every CPU from
every IO device driver that can potentially benefit from improved CPU
energy efficiency, in order for each of them to compute an appropriate
MEF estimate for each CPU.  And at the cost of performance degradation
in a multitasking environment whenever two or more different process
impose conflicting frequency QoS constraints based on conflicting
latency requirements -- Or in a multitasking environment where a certain
process needs to be excluded from the frequency constraint, which you
were advocating for earlier in this thread.

>> IOW, introducing additional power budget variables (in combination with
>> additional power curve information from both the CPU and device) *might*
>> help you reach the optimal steady state from a suboptimal state more
>> quickly in principle, but it won't have any effect on the optimality of
>> the final steady state as soon as it's reached.
>>=20
>> Does that mean it's essential to introduce such power variables in order
>> for the controller to approach the optimal steady state?  No, because
>> any realistic controller attempting to approximate the MEF of the
>> workload (whether it's monitoring the power consumption variables or
>> not) necessarily needs to overshoot that MEF estimate by some factor in
>> order to avoid getting stuck at a low frequency whenever the load
>> fluctuates above the current MEF.  This means that even if at some point
>> the power balance is far enough from the optimal ratio that the initial
>> MEF estimate is off by a fraction greater than the overshoot factor of
>> the controller, the controller will get immediate feedback of the
>> situation as soon as the device throughput ramps up due to the released
>> power budget, allowing it to make a more accurate approximation of the
>> real MEF in a small number of iterations (of the order of 1 iteration
>> surprisingly frequently).
>>=20
>> > This means that the power budget sharing is essential here and the "if=
 the
>> > energy-efficiency of the processor is improved, the other components g=
et
>> > more power as a bonus" argument is not really valid.
>> >
>>=20
>> That was just a statement of my goals while working on the algorithm
>> [improve the energy efficiency of the CPU in presence of an IO
>> bottleneck], it's therefore axiomatic in nature rather than some sort of
>> logical conclusion that can be dismissed as invalid.  You might say you
>> have different goals in mind but that doesn't mean other people's are
>> not valid.
>
> Well, this really isn't about the goals but about understanding of what
> really happens.
>
> What I'm trying to say is that the sharing of energy budget is a necessary
> condition allowing the processor's energy-efficiency to be improved witho=
ut
> sacrificing performance.
>

And I disagree it's a necessary condition.  As a counterexample consider
a video game being rendered at 60 FPS on a discrete GPU without energy
budget sharing.  Suppose that only 40% of the CPU computational capacity
is needed in order to achieve that, but the CPU frequency peaks at 80%
of its maximum.  Then assume that we clamp the CPU frequency at 40% of
its maximum, still within the convexity range of its power curve.  While
doing that we have improved the processor's energy efficiency without
sacrificing performance.  And there was no sharing of energy budget
whatsoever.

>> > The frequency of the processor gets limited in order for the other com=
pon=3D
>> ents
>> > to get more power, which then allows the processor to do more work in =
the
>> > same time at the same frequency, so it becomes more energy-efficient.
>>=20
>> Whenever the throughput of the workload is limited by its power budget,
>> then yes, sure, but even when that's not the case it can be valuable to
>> reduce the amount of energy the system is consuming in order to perform
>> a certain task.
>
> Yes, it is valuable, but this is a separate problem and addressing it
> requires taking additional user input (regarding the energy vs performance
> policy) into account.

Yes, I agree that taking user input is valuable.  Feel free to provide
any feed-back on that matter if you don't consider the current policy
mechanism to be satisfactory.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXySehAAKCRCDmTidfVK/
W4sbAP9h7sVyir5IoMHWqOnpSnA4YfLzz7qy5rrrtEXlbF0PfwD9EdFb26UzSlDQ
RC94Apf9mfJsqQ9K/NpJiKkcOUTPexk=
=7apW
-----END PGP SIGNATURE-----
--==-=-=--
