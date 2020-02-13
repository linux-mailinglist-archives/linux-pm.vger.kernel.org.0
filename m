Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6035315BA81
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 09:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgBMIHM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 03:07:12 -0500
Received: from mx1.riseup.net ([198.252.153.129]:39080 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMIHM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 03:07:12 -0500
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48J8Hc3Mr2zFcgm;
        Thu, 13 Feb 2020 00:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1581581231; bh=i6XCqKpsnxNZhoDUvlm+3yHCAu9PgfVDDqrCmDF+rtw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=I08lYhc6dYxTj7VlnEEe4KbwMGDT0tppR+HviZHd3rdosjx9dQ4oR6tMIro/mocyV
         F1AFySN+z6R355oIrEJrTFa4smglUuAd/UN9F5m9vfuPk4HPwrsoFvUd6cDd1huEhD
         fMqU3Nj/ew3P0WK8mPKSESkaJTZwq/XRimCbc3uU=
X-Riseup-User-ID: 60ABCBD978563A2F0508A24490088834BD498EE4C193B1545FE5399A7CE0859E
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48J8HL6WLKz8trb;
        Thu, 13 Feb 2020 00:06:54 -0800 (PST)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU latency QoS interface
In-Reply-To: <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com>
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net> <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com>
Date:   Thu, 13 Feb 2020 00:07:50 -0800
Message-ID: <878sl6j4fd.fsf@riseup.net>
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

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Thu, Feb 13, 2020 at 12:31 AM Francisco Jerez <currojerez@riseup.net> wrote:
>>
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>
>> > Hi All,
>> >
>> > This series of patches is based on the observation that after commit
>> > c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
>> > in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
>> > code dedicated to the handling of global PM QoS classes in general.  That code
>> > takes up space and adds overhead in vain, so it is better to get rid of it.
>> >
>> > Moreover, with that unuseful code removed, the interface for adding QoS
>> > requests for CPU latency becomes inelegant and confusing, so it is better to
>> > clean it up.
>> >
>> > Patches [01/28-12/28] do the first part described above, which also includes
>> > some assorted cleanups of the core PM QoS code that doesn't go away.
>> >
>> > Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
>> > "define stubs, migrate users, change the API proper" manner), patches
>> > [26-27/28] update the general comments and documentation to match the code
>> > after the previous changes and the last one makes the CPU latency QoS depend
>> > on CPU_IDLE (because cpuidle is the only user of its target value today).
>> >
>> > The majority of the patches in this series don't change the functionality of
>> > the code at all (at least not intentionally).
>> >
>> > Please refer to the changelogs of individual patches for details.
>> >
>> > Thanks!
>>
>> Hi Rafael,
>>
>> I believe some of the interfaces removed here could be useful in the
>> near future.
>
> I disagree.
>
>>  It goes back to the energy efficiency- (and IGP graphics
>> performance-)improving series I submitted a while ago [1].  It relies on
>> some mechanism for the graphics driver to report an I/O bottleneck to
>> CPUFREQ, allowing it to make a more conservative trade-off between
>> energy efficiency and latency, which can greatly reduce the CPU package
>> energy usage of IO-bound applications (in some graphics benchmarks I've
>> seen it reduced by over 40% on my ICL laptop), and therefore also allows
>> TDP-bound applications to obtain a reciprocal improvement in throughput.
>>
>> I'm not particularly fond of the global PM QoS interfaces TBH, it seems
>> like an excessively blunt hammer to me, so I can very much relate to the
>> purpose of this series.  However the finer-grained solution I've
>> implemented has seen some push-back from i915 and CPUFREQ devs due to
>> its complexity, since it relies on task scheduler changes in order to
>> track IO bottlenecks per-process (roughly as suggested by Peter Zijlstra
>> during our previous discussions), pretty much in the spirit of PELT but
>> applied to IO utilization.
>>
>> With that in mind I was hoping we could take advantage of PM QoS as a
>> temporary solution [2], by introducing a global PM QoS class similar but
>> with roughly converse semantics to PM_QOS_CPU_DMA_LATENCY, allowing
>> device drivers to report a *lower* bound on CPU latency beyond which PM
>> shall not bother to reduce latency if doing so would have negative
>> consequences on the energy efficiency and/or parallelism of the system.
>
> So I really don't quite see how that could be responded to, by cpuidle
> say.  What exactly do you mean by "reducing latency" in particular?
>

cpuidle wouldn't necessarily have to do anything about it since it would
be intended merely as a hint that a device in the system other than the
CPU has a bottleneck.  It could provide a lower bound for the wake-up
latency of the idle states that may be considered by cpuidle.  It seems
to me like it could be useful when a program can tell from the
characteristics of the workload that a latency reduction below a certain
time bound wouldn't materially affect the performance of the system
(e.g. if you have 20 ms to render a GPU-bound frame, you may not care at
all about the CPU taking a fraction of a millisecond more to wake up a
few times each frame).

For cpufreq I was planning to have it influence a time parameter of the
utilization averaging done by the governor, which would allow it to have
a more optimal response in the long term (in the sense of lowering the
energy cost of performing the same work in the specified timeframe),
even if such a large time parameter wouldn't normally be considered
appropriate for utilization averaging due to latency concerns.

>> Of course one would expect the current PM_QOS_CPU_DMA_LATENCY upper
>> bound to take precedence over the new lower bound in cases where the
>> former is in conflict with the latter.
>
> So that needs to be done on top of this series.
>
>> I can think of several alternatives to that which don't involve
>> temporarily holding off your clean-up,
>
> The cleanup goes in.  Please work on top of it.
>

Hopefully we can come up with an alternative in that case.  TBH I'd love
to see your clean-up go in too, but global PM QoS seemed fairly
appealing as a way to split up my work so it could be reviewed
incrementally, even though I'm aiming for a finer-grained solution than
that.

>> but none of them sound particularly exciting:
>>
>>  1/ Use an interface specific to CPUFREQ, pretty much like the one
>>     introduced in my original submission [1].
>
> It uses frequency QoS already today, do you really need something else?
>

Yes.  I don't see how frequency QoS could be useful for this as-is,
unless we're willing to introduce code in every device driver that takes
advantage of this and have them monitor the utilization of every CPU in
the system, so they can calculate an appropriate max frequency
constraint -- One which we can be reasonably certain won't hurt the
long-term performance of the CPU cores these constraints are being
placed on.

>>  2/ Use per-CPU PM QoS, which AFAICT would require the graphics driver
>>     to either place a request on every CPU of the system (which would
>>     cause a frequent operation to have O(N) complexity on the number of
>>     CPUs on the system), or play a cat-and-mouse game with the task
>>     scheduler.
>
> That's in place already too in the form of device PM QoS; see
> drivers/base/power/qos.c.

But wouldn't that have the drawbacks I was talking about above when
trying to use it in order to set this kind of constraints on CPU power
management?

>
>>  3/ Add a new global PM QoS mechanism roughly duplicating the
>>     cpu_latency_qos_* interfaces introduced in this series.  Drop your
>>     change making this available to CPU IDLE only.
>
> It sounds like you really want performance for energy efficiency and
> CPU latency has a little to do with that.
>

The mechanism I've been working on isn't intended to sacrifice long-term
performance of the CPU (e.g. if a CPU core is 100% utilized in the
steady state by the same or an unrelated application the CPUFREQ
governor should still request the maximum turbo frequency for it), it's
only meant to affect the trade-off between energy efficiency and latency
(e.g. the time it takes for the CPUFREQ governor to respond to an
oscillation of the workload that chooses to opt in).

>>  3/ Go straight to a scheduling-based approach, which is likely to
>>     greatly increase the review effort required to upstream this
>>     feature.  (Peter might disagree though?)
>
> Are you familiar with the utilization clamps mechanism?
>

Sure, that would be a possibility as alternative to PM QoS, but it would
most likely involve task scheduler changes to get it working
effectively, which Srinivas and Rodrigo have asked me to leave out from
my next RFC submission in the interest of reviewability.  I wouldn't
mind plumbing comparable information through utilization clamps instead
or as follow-up if you think that's the way forward.

> Thanks!


--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXkUD1gAKCRCDmTidfVK/
W4cnAP4pEPRpAw0OBxBIt3r86nP0wOX/G59D7Y2BbQHs8KFxwQD8DfdRMkG1IIRB
E+qxtT3kGHxGaEbja8VFLuc6CeqbnSs=
=X4n0
-----END PGP SIGNATURE-----
--==-=-=--
