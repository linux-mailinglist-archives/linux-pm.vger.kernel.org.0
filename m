Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14090231931
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 07:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgG2FqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 01:46:13 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44108 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgG2FqN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 01:46:13 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BGjFw3HP2zFdxH;
        Tue, 28 Jul 2020 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1596001572; bh=9yzh9iwy3im0s4hjRtrLqdUhdhTIl9Lv1iM4f2Q/dV4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sWc08l6k8PNU/YDEbEJ0DQsyZUeU0vRcmpSTmR76X66uuDOxVt8orZjI079KKQi73
         uNnpyqlPuEYndOaH+3gYiDiwI/ufeyqvNjeR+V60pDo28EyhdGAzF6+isAt7jqEY4h
         V3AXuXBk4LjB/0+FMibpbTJuT0HMClIebKRSbuww=
X-Riseup-User-ID: 176B80C0579BEB7E7E18DD0534432018D6C4D568D5E175B7868611CF71FEBB80
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 4BGjFv4FN8zJmps;
        Tue, 28 Jul 2020 22:46:11 -0700 (PDT)
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
In-Reply-To: <2440238.9qpzlEPeD7@kreacher>
References: <3955470.QvD6XneCf3@kreacher> <1818916.Mrn9nftLre@kreacher> <878sf4gyix.fsf@riseup.net> <2440238.9qpzlEPeD7@kreacher>
Date:   Tue, 28 Jul 2020 22:46:08 -0700
Message-ID: <87v9i6g9gf.fsf@riseup.net>
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

> On Tuesday, July 28, 2020 4:32:22 AM CEST Francisco Jerez wrote:
>>
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>=20
>> > On Tuesday, July 21, 2020 1:20:14 AM CEST Francisco Jerez wrote:
>> >
>> > [cut]
>> >
>> >> >
>> >> > However, in the active mode the only updater of hwp_req_cached is
>> >> > intel_pstate_hwp_set() and this patch doesn't introduce any
>> >> > differences in behavior in that case.
>> >> >
>> >>=3D20
>> >> intel_pstate_hwp_set() is the only updater, but there are other
>> >> consumers that can get out of sync with the HWP request value written=
 by
>> >> intel_pstate_set_energy_pref_index().  intel_pstate_hwp_boost_up() se=
ems
>> >> like the most concerning example I named earlier.
>> >>=3D20
>> >> >> > So there may be a short time window after the
>> >> >> > intel_pstate_set_energy_pref_index() invocation in which the new=
 EPP
>> >> >> > value may not be in effect, but in general there is no guarantee=
 th=3D
>> at
>> >> >> > the new EPP will take effect immediately after updating the MSR
>> >> >> > anyway, so that race doesn't matter.
>> >> >> >
>> >> >> > That said, that race is avoidable, but I was thinking that tryin=
g to
>> >> >> > avoid it might not be worth it.  Now I see a better way to avoid=
 it,
>> >> >> > though, so I'm going to update the patch to that end.
>> >> >> >
>> >> >> >> Seems like a bug to me.
>> >> >> >
>> >> >> > It is racy, but not every race is a bug.
>> >> >> >
>> >> >>
>> >> >> Still seems like there is a bug in intel_pstate_set_energy_pref_in=
dex=3D
>> ()
>> >> >> AFAICT.
>> >> >
>> >> > If there is a bug, then what exactly is it, from the users' perspec=
tiv=3D
>> e?
>> >> >
>> >>=3D20
>> >> It can be reproduced easily as follows:
>> >>=3D20
>> >> | echo 1 > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost
>> >> | for p in /sys/devices/system/cpu/cpufreq/policy*/energy_performance=
_pr=3D
>> eference; do echo performance > $p; done
>> >
>> > Is this the active mode or the passive mode with the $subject patch ap=
pli=3D
>> ed?
>> >
>> > If the former, the issue is there regardless of the patch, so it needs=
 to=3D
>>  be
>> > fixed.
>> >
>> > If the latter, there should be no effect of hwp_dynamic_boost (which w=
as
>> > overlooked by me).
>> >
>>=20
>> This seems to be a problem in active mode only, so yeah the bug exists
>> regardless of your patch, but the fix is likely to allow you to simplify
>> this series slightly if it allows you to take full advantage of
>> hwp_req_cached and drop the additional EPP cache.
>
> The additional EPP cache is there to avoid synchronizing the scheduler
> context directly with a random process running on another CPU and doing
> things that may take time.
>
> The difference between the active mode and the passive mode in this respe=
ct
> is that in the latter case hwp_req_cached generally needs to be updated f=
rom
> the scheduler context, whereas in the former case it does not.
>

Hm, that's unfortunate.  Though I'd be surprised to see any appreciable
performance penalty from synchronizing with a sysfs handler that should
hardly ever be called.  Anyway thanks for the fix.

> [cut]
>
>> >> No, I explicitly dismissed that in my previous reply.
>> >
>> > But at the same time you seem to agree that without the non-CPU compon=
ent
>> > (or thermal pressure) the existing CPU performance scaling would be
>> > sufficient.
>> >
>>=20
>> Yes, but not necessarily in order to allow the non-CPU component to draw
>> more power as you said above, but also because the existence of a
>> bottleneck in a non-CPU component gives us an opportunity to improve the
>> energy efficiency of the CPU, regardless of whether that allows the
>> workload to run faster.
>
> But why would the bottleneck be there otherwise?
>

Because some resource of the system (e.g. memory bandwidth, GPU fill
rate) may be close to 100% utilized, causing a bottleneck for reasons
unrelated to its energy usage.

>> > [cut]
>> >
>> >> > Yes, it is, and so I don't quite see the connection between it and =
my =3D
>> question.
>> >> >
>> >> > Apparently, the unmodified performance scaling governors are not
>> >> > sufficient, so there must be something beyond the above which allows
>> >> > you to determine the frequency in question and so I'm asking what t=
hat
>> >> > is.
>> >> >
>> >>=3D20
>> >> The underlying heuristic assumption is the same as I outlined above, =
but
>> >> in any implementation of such a heuristic there is necessarily a
>> >> trade-off between responsiveness to short-term fluctuations and
>> >> long-term energy usage.  This trade-off is a function of the somewhat
>> >> arbitrary time interval I was referring to as "immediate past" -- A
>> >> longer time parameter allows the controller to consider a greater
>> >> portion of the workload's history while computing the response with
>> >> optimal energy usage, at the cost of increasing its reaction time to
>> >> discontinuous changes in the behavior of the workload (AKA increased
>> >> latency).
>> >
>> > OK
>> >
>> >> One of the key differences between the governor I proposed and the
>> >> pre-existing ones is that it doesn't attempt to come up with a magic
>> >> time parameter that works for everybody, because there isn't such a
>> >> thing, since different devices and applications have latency
>> >> requirements which often differ by orders of magnitude.
>> >
>> > The problem with this approach is that, generally speaking, the kernel
>> > has a definition of "close past" already, which comes from the PELT
>> > signal in the scheduler.
>> >
>> > That signal is used for more than just CPU performance scaling and the=
re
>> > is a reason for that, as the scheduler's decisions generally need to be
>> > aligned with CPU performance scaling decisions.
>> >
>>=20
>> Yes, I fully agree that in an ideal world the response latency
>> constraint I was referring to above would be tracked per-scheduling
>> entity and used as definition of "close past" by PELT too -- Actually I
>> think I mentioned I was working on a prototype with scheduler-level
>> tracking of latency constraints, but other folks requested the RFC to be
>> based on a simpler interface not requiring scheduler surgery to
>> implement, which is why I came up with the PM QoS-based interface.  I
>> believe we have discussed exposing this latency constraint as a third
>> clamp similar to utilization clamps -- I would be fine with such an
>> interface if you think it's the way to go.
>
> I'm not sure yet to be honest.
>
>> That said, in most practical cases it should be possible to take close
>> to full advantage of the response latency information from the schedutil
>> governor, even if it's provided via PM QoS rather than having
>> per-scheduling entity granularity -- The time parameter used to control
>> CPU frequency would just be the most strict among the applications
>> running in the system, which should prevent performance loss in
>> applications with a low latency constraint, but might cause us to miss
>> out some opportunities for energy optimization in a multitasking
>> environment compared to the full scheduling-based solution.  Doesn't
>> seem like a deal-breaker to me though and it makes the code
>> substantially easier to review.
>
> I agree on the simplicity side, but the reason why I think that the sched=
uler
> needs to be involved ultimately is because it may have a reason to ignore=
 the
> bottleneck and go ahead with its decisions anyway.

Yes, definitely.  One of the cases I was considering where it would make
sense to do that is whenever a process with e.g. realtime priority
starts executing in a given GPU.  But that can be done regardless of
whether the latency constraint is tracked through the scheduler or PM
QoS, similar to the way you handle realtime priority in schedutil right
now.  The main functional difference between the scheduling and PM QoS
approach would be the granularity of the latency constraint computation,
we could always arrange for the same set of processes to be excluded
from the optimization.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXyENIAAKCRCDmTidfVK/
W4r3AQCR1GaCYtHMVnRojtT4WI0a/7qQHl3mlgNmWX+IaMWMagD/Sam6ewgwwdjF
UqLNNXEPiHYnmAA3yKo8PmQ5p2D4sSo=
=57aL
-----END PGP SIGNATURE-----
--==-=-=--
