Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DACC15CEEC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 01:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBNAOj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 19:14:39 -0500
Received: from mx1.riseup.net ([198.252.153.129]:41144 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBNAOj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 19:14:39 -0500
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48JYly23SCzF05L;
        Thu, 13 Feb 2020 16:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1581639278; bh=60n+OWOuJ6Miu2grDRB6tuflvnrqZgVDmlZGTC9aFe8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=crRbyyVoU1YUUlXvPsTEbfmvHasc5epdTPxie7oTKig8rlWMZGrL0OXzkv3EtYBa4
         KUh2ts5SVxSE0SDgxEznO1Nx7AWQm0lNM34y16Ub8esP8MoesZ6TmcPVu833dvJtmn
         QE1XrKXwPfIIoEYUCSSyoo3nILnyXFryDLCWloMI=
X-Riseup-User-ID: 9B1E63B9FE8651B525B285C968AA4869985FFA754E782CD33899CDC445BE7CDF
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48JYlx3J63z8smj;
        Thu, 13 Feb 2020 16:14:37 -0800 (PST)
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
In-Reply-To: <CAJZ5v0iMvzFGbuYsOo+AkWAqUbkQVT-FHsTDbStPiNenw783LQ@mail.gmail.com>
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net> <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com> <878sl6j4fd.fsf@riseup.net> <CAJZ5v0jNFMwqSwSones91WgDwGqusyY1nEMDKAYuSZiLjH61dw@mail.gmail.com> <CAJZ5v0iMvzFGbuYsOo+AkWAqUbkQVT-FHsTDbStPiNenw783LQ@mail.gmail.com>
Date:   Thu, 13 Feb 2020 16:15:35 -0800
Message-ID: <87sgjegh20.fsf@riseup.net>
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

> On Thu, Feb 13, 2020 at 12:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Feb 13, 2020 at 9:07 AM Francisco Jerez <currojerez@riseup.net> wrote:
>> >
>> > "Rafael J. Wysocki" <rafael@kernel.org> writes:
>> >
>> > > On Thu, Feb 13, 2020 at 12:31 AM Francisco Jerez <currojerez@riseup.net> wrote:
>> > >>
>> > >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>> > >>
>> > >> > Hi All,
>> > >> >
>> > >> > This series of patches is based on the observation that after commit
>> > >> > c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
>> > >> > in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
>> > >> > code dedicated to the handling of global PM QoS classes in general.  That code
>> > >> > takes up space and adds overhead in vain, so it is better to get rid of it.
>> > >> >
>> > >> > Moreover, with that unuseful code removed, the interface for adding QoS
>> > >> > requests for CPU latency becomes inelegant and confusing, so it is better to
>> > >> > clean it up.
>> > >> >
>> > >> > Patches [01/28-12/28] do the first part described above, which also includes
>> > >> > some assorted cleanups of the core PM QoS code that doesn't go away.
>> > >> >
>> > >> > Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
>> > >> > "define stubs, migrate users, change the API proper" manner), patches
>> > >> > [26-27/28] update the general comments and documentation to match the code
>> > >> > after the previous changes and the last one makes the CPU latency QoS depend
>> > >> > on CPU_IDLE (because cpuidle is the only user of its target value today).
>> > >> >
>> > >> > The majority of the patches in this series don't change the functionality of
>> > >> > the code at all (at least not intentionally).
>> > >> >
>> > >> > Please refer to the changelogs of individual patches for details.
>> > >> >
>> > >> > Thanks!
>> > >>
>> > >> Hi Rafael,
>> > >>
>> > >> I believe some of the interfaces removed here could be useful in the
>> > >> near future.
>> > >
>> > > I disagree.
>> > >
>> > >>  It goes back to the energy efficiency- (and IGP graphics
>> > >> performance-)improving series I submitted a while ago [1].  It relies on
>> > >> some mechanism for the graphics driver to report an I/O bottleneck to
>> > >> CPUFREQ, allowing it to make a more conservative trade-off between
>> > >> energy efficiency and latency, which can greatly reduce the CPU package
>> > >> energy usage of IO-bound applications (in some graphics benchmarks I've
>> > >> seen it reduced by over 40% on my ICL laptop), and therefore also allows
>> > >> TDP-bound applications to obtain a reciprocal improvement in throughput.
>> > >>
>> > >> I'm not particularly fond of the global PM QoS interfaces TBH, it seems
>> > >> like an excessively blunt hammer to me, so I can very much relate to the
>> > >> purpose of this series.  However the finer-grained solution I've
>> > >> implemented has seen some push-back from i915 and CPUFREQ devs due to
>> > >> its complexity, since it relies on task scheduler changes in order to
>> > >> track IO bottlenecks per-process (roughly as suggested by Peter Zijlstra
>> > >> during our previous discussions), pretty much in the spirit of PELT but
>> > >> applied to IO utilization.
>> > >>
>> > >> With that in mind I was hoping we could take advantage of PM QoS as a
>> > >> temporary solution [2], by introducing a global PM QoS class similar but
>> > >> with roughly converse semantics to PM_QOS_CPU_DMA_LATENCY, allowing
>> > >> device drivers to report a *lower* bound on CPU latency beyond which PM
>> > >> shall not bother to reduce latency if doing so would have negative
>> > >> consequences on the energy efficiency and/or parallelism of the system.
>> > >
>> > > So I really don't quite see how that could be responded to, by cpuidle
>> > > say.  What exactly do you mean by "reducing latency" in particular?
>> > >
>> >
>> > cpuidle wouldn't necessarily have to do anything about it since it would
>> > be intended merely as a hint that a device in the system other than the
>> > CPU has a bottleneck.  It could provide a lower bound for the wake-up
>> > latency of the idle states that may be considered by cpuidle.  It seems
>> > to me like it could be useful when a program can tell from the
>> > characteristics of the workload that a latency reduction below a certain
>> > time bound wouldn't materially affect the performance of the system
>> > (e.g. if you have 20 ms to render a GPU-bound frame, you may not care at
>> > all about the CPU taking a fraction of a millisecond more to wake up a
>> > few times each frame).
>>
>> Well, this is not how cpuidle works.
>>
>> What it does is to try to find the deepest idle state that makes sense
>> to let the CPU go into given all of the constraints etc.  IOW it never
>> tries to reduce the latency, it looks how far it can go with possible
>> energy savings given a specific latency limit (or no limit at all).
>>
>> > For cpufreq I was planning to have it influence a time parameter of the
>> > utilization averaging done by the governor, which would allow it to have
>> > a more optimal response in the long term (in the sense of lowering the
>> > energy cost of performing the same work in the specified timeframe),
>> > even if such a large time parameter wouldn't normally be considered
>> > appropriate for utilization averaging due to latency concerns.
>>
>> So this is fine in the schedutil case in principle, it but would not
>> work with HWP, because that doesn't take the scheduler's utilization
>> metrics into account.
>>
>> To cover the HWP case you need to influence the min and max frequency
>> limits, realistically.
>>
>> > >> Of course one would expect the current PM_QOS_CPU_DMA_LATENCY upper
>> > >> bound to take precedence over the new lower bound in cases where the
>> > >> former is in conflict with the latter.
>> > >
>> > > So that needs to be done on top of this series.
>> > >
>> > >> I can think of several alternatives to that which don't involve
>> > >> temporarily holding off your clean-up,
>> > >
>> > > The cleanup goes in.  Please work on top of it.
>> > >
>> >
>> > Hopefully we can come up with an alternative in that case.  TBH I'd love
>> > to see your clean-up go in too, but global PM QoS seemed fairly
>> > appealing as a way to split up my work so it could be reviewed
>> > incrementally, even though I'm aiming for a finer-grained solution than
>> > that.
>>
>> Well, so "global PM QoS" really means a struct struct
>> pm_qos_constraints object with a global reader of its target_value.
>>
>> Of course, pm_qos_update_target() is not particularly convenient to
>> use, so you'd need to wrap it into an _add/update/remove_request()
>> family of functions along the lines of the cpu_latency_qos_*() ones I
>> suppose and you won't need the _apply() thing.
>>
>> > >> but none of them sound particularly exciting:
>> > >>
>> > >>  1/ Use an interface specific to CPUFREQ, pretty much like the one
>> > >>     introduced in my original submission [1].
>> > >
>> > > It uses frequency QoS already today, do you really need something else?
>> > >
>> >
>> > Yes.  I don't see how frequency QoS could be useful for this as-is,
>> > unless we're willing to introduce code in every device driver that takes
>> > advantage of this and have them monitor the utilization of every CPU in
>> > the system, so they can calculate an appropriate max frequency
>> > constraint -- One which we can be reasonably certain won't hurt the
>> > long-term performance of the CPU cores these constraints are being
>> > placed on.
>>
>> I'm not really sure if I understand you correctly.
>>
>> The frequency QoS in cpufreq is a way to influence the min and max
>> freq limits used by it for each CPU.  That is done in a couple of
>> places like store_max/min_perf_pct() in intel_pstate or
>> processor_set_cur_state() (I guess the latter would be close to what
>> you think about, but the other way around - you seem to want to
>> influence the min and not the max).
>
> It looks like *I* got this part the other way around. :-/
>
> I think that your use case is almost equivalent to the thermal
> pressure one, so you'd want to limit the max and so that would be
> something similar to store_max_perf_pct() with its input side hooked
> up to a QoS list.
>
> But it looks like that QoS list would rather be of a "reservation"
> type, so a request added to it would mean something like "leave this
> fraction of power that appears to be available to the CPU subsystem
> unused, because I need it for a different purpose".  And in principle
> there might be multiple requests in there at the same time and those
> "reservations" would add up.  So that would be a kind of "limited sum"
> QoS type which wasn't even there before my changes.
>
> A user of that QoS list might then do something like
>
> ret = cpu_power_reserve_add(1, 4);
>
> meaning that it wants 25% of the "potential" CPU power to be not
> utilized by CPU performance scaling and that could affect the
> scheduler through load modifications (kind of along the thermal
> pressure patchset discussed some time ago) and HWP (as well as the
> non-HWP intel_pstate by preventing turbo frequencies from being used
> etc).

The problems with this are the same as with the per-CPU frequency QoS
approach: How does the device driver know what the appropriate fraction
of CPU power is?  Depending on the instantaneous behavior of the
workload it might take 1% or 95% of the CPU power in order to keep the
IO device busy.  Each user of this would need to monitor the performance
of every CPU in the system and update the constraints on each of them
periodically (whether or not they're talking to that IO device, which
would possibly negatively impact the latency of unrelated applications
running on other CPUs, unless we're willing to race with the task
scheduler).  A solution based on utilization clamps (with some
extensions) sounds more future-proof to me honestly.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXkXmpwAKCRCDmTidfVK/
W31/AP43ywUfhaoXFSDwsN1dg4hkSyGuaJsEL0HiTRSsNhw0agD9E1F+X4wCB6O8
6t8qtinlC++Q/3Qn0XuU8qlaDZRrzho=
=CEo3
-----END PGP SIGNATURE-----
--==-=-=--
