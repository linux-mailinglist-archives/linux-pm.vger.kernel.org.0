Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F9F15CEE6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 01:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgBNANu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 19:13:50 -0500
Received: from mx1.riseup.net ([198.252.153.129]:40830 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBNANu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 19:13:50 -0500
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48JYl11w11zF05L;
        Thu, 13 Feb 2020 16:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1581639229; bh=P0A/gzxSK94u+cnBuIATEY4Wa7qRwSMSPE7MOf74C24=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D69ILUCdS6awZUzO0JgmT/v4k1m/u5SSPWCXrcHDJXo6mhCs9VoiELLEYdkipSLyS
         oGZTcTnq0E51P9UfeoT9Y4hDIsstSHXCUDnxtOIuPnaoYwFHrcwVTXAfhxda35yoB9
         826cav195fI1F0RnBGuipsm8yrBUufrPIBkiFiSg=
X-Riseup-User-ID: C6024622F80096FB41027A7A213A34B97708CD4459B0B115C8E94E79DC288C5D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48JYl052X8z8smj;
        Thu, 13 Feb 2020 16:13:48 -0800 (PST)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU latency QoS interface
In-Reply-To: <CAJZ5v0jNFMwqSwSones91WgDwGqusyY1nEMDKAYuSZiLjH61dw@mail.gmail.com>
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net> <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com> <878sl6j4fd.fsf@riseup.net> <CAJZ5v0jNFMwqSwSones91WgDwGqusyY1nEMDKAYuSZiLjH61dw@mail.gmail.com>
Date:   Thu, 13 Feb 2020 16:14:44 -0800
Message-ID: <87tv3ugh3f.fsf@riseup.net>
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

> On Thu, Feb 13, 2020 at 9:07 AM Francisco Jerez <currojerez@riseup.net> wrote:
>>
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>
>> > On Thu, Feb 13, 2020 at 12:31 AM Francisco Jerez <currojerez@riseup.net> wrote:
>> >>
>> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>> >>
>> >> > Hi All,
>> >> >
>> >> > This series of patches is based on the observation that after commit
>> >> > c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
>> >> > in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
>> >> > code dedicated to the handling of global PM QoS classes in general.  That code
>> >> > takes up space and adds overhead in vain, so it is better to get rid of it.
>> >> >
>> >> > Moreover, with that unuseful code removed, the interface for adding QoS
>> >> > requests for CPU latency becomes inelegant and confusing, so it is better to
>> >> > clean it up.
>> >> >
>> >> > Patches [01/28-12/28] do the first part described above, which also includes
>> >> > some assorted cleanups of the core PM QoS code that doesn't go away.
>> >> >
>> >> > Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
>> >> > "define stubs, migrate users, change the API proper" manner), patches
>> >> > [26-27/28] update the general comments and documentation to match the code
>> >> > after the previous changes and the last one makes the CPU latency QoS depend
>> >> > on CPU_IDLE (because cpuidle is the only user of its target value today).
>> >> >
>> >> > The majority of the patches in this series don't change the functionality of
>> >> > the code at all (at least not intentionally).
>> >> >
>> >> > Please refer to the changelogs of individual patches for details.
>> >> >
>> >> > Thanks!
>> >>
>> >> Hi Rafael,
>> >>
>> >> I believe some of the interfaces removed here could be useful in the
>> >> near future.
>> >
>> > I disagree.
>> >
>> >>  It goes back to the energy efficiency- (and IGP graphics
>> >> performance-)improving series I submitted a while ago [1].  It relies on
>> >> some mechanism for the graphics driver to report an I/O bottleneck to
>> >> CPUFREQ, allowing it to make a more conservative trade-off between
>> >> energy efficiency and latency, which can greatly reduce the CPU package
>> >> energy usage of IO-bound applications (in some graphics benchmarks I've
>> >> seen it reduced by over 40% on my ICL laptop), and therefore also allows
>> >> TDP-bound applications to obtain a reciprocal improvement in throughput.
>> >>
>> >> I'm not particularly fond of the global PM QoS interfaces TBH, it seems
>> >> like an excessively blunt hammer to me, so I can very much relate to the
>> >> purpose of this series.  However the finer-grained solution I've
>> >> implemented has seen some push-back from i915 and CPUFREQ devs due to
>> >> its complexity, since it relies on task scheduler changes in order to
>> >> track IO bottlenecks per-process (roughly as suggested by Peter Zijlstra
>> >> during our previous discussions), pretty much in the spirit of PELT but
>> >> applied to IO utilization.
>> >>
>> >> With that in mind I was hoping we could take advantage of PM QoS as a
>> >> temporary solution [2], by introducing a global PM QoS class similar but
>> >> with roughly converse semantics to PM_QOS_CPU_DMA_LATENCY, allowing
>> >> device drivers to report a *lower* bound on CPU latency beyond which PM
>> >> shall not bother to reduce latency if doing so would have negative
>> >> consequences on the energy efficiency and/or parallelism of the system.
>> >
>> > So I really don't quite see how that could be responded to, by cpuidle
>> > say.  What exactly do you mean by "reducing latency" in particular?
>> >
>>
>> cpuidle wouldn't necessarily have to do anything about it since it would
>> be intended merely as a hint that a device in the system other than the
>> CPU has a bottleneck.  It could provide a lower bound for the wake-up
>> latency of the idle states that may be considered by cpuidle.  It seems
>> to me like it could be useful when a program can tell from the
>> characteristics of the workload that a latency reduction below a certain
>> time bound wouldn't materially affect the performance of the system
>> (e.g. if you have 20 ms to render a GPU-bound frame, you may not care at
>> all about the CPU taking a fraction of a millisecond more to wake up a
>> few times each frame).
>
> Well, this is not how cpuidle works.
>
> What it does is to try to find the deepest idle state that makes sense
> to let the CPU go into given all of the constraints etc.  IOW it never
> tries to reduce the latency, it looks how far it can go with possible
> energy savings given a specific latency limit (or no limit at all).
>

I didn't mean to say that cpuidle reduces latency except in relative
terms: If a sleep state is available but has too high exit latency to be
used under the current load conditions, an explicit hint from the
application or device driver saying "I'm okay with a wake-up+ramp-up
latency of the order of X nanoseconds" might allow it to do a better job
than any heuristic decision implemented in the idle governor.

>> For cpufreq I was planning to have it influence a time parameter of the
>> utilization averaging done by the governor, which would allow it to have
>> a more optimal response in the long term (in the sense of lowering the
>> energy cost of performing the same work in the specified timeframe),
>> even if such a large time parameter wouldn't normally be considered
>> appropriate for utilization averaging due to latency concerns.
>
> So this is fine in the schedutil case in principle, it but would not
> work with HWP, because that doesn't take the scheduler's utilization
> metrics into account.
>

The code I've been working on lately targets HWP platforms specifically,
but I've gotten it to work on non-HWP too with some minor changes in the
governor.  The same kernel interfaces should work whether the CPUFREQ
governor is delegating frequency selection to HWP or doing it directly.

> To cover the HWP case you need to influence the min and max frequency
> limits, realistically.
>

Indeed, the constraint I was planning to introduce eventually influences
the calculation of the HWP min/max frequencies in order to make sure
that the P-code ends up selecting a reasonably optimal frequency,
without fully removing it out of the picture, it's simply meant to
assist its decisions whenever the applications running on that CPU core
have a non-CPU bottleneck known to the kernel.

>> >> Of course one would expect the current PM_QOS_CPU_DMA_LATENCY upper
>> >> bound to take precedence over the new lower bound in cases where the
>> >> former is in conflict with the latter.
>> >
>> > So that needs to be done on top of this series.
>> >
>> >> I can think of several alternatives to that which don't involve
>> >> temporarily holding off your clean-up,
>> >
>> > The cleanup goes in.  Please work on top of it.
>> >
>>
>> Hopefully we can come up with an alternative in that case.  TBH I'd love
>> to see your clean-up go in too, but global PM QoS seemed fairly
>> appealing as a way to split up my work so it could be reviewed
>> incrementally, even though I'm aiming for a finer-grained solution than
>> that.
>
> Well, so "global PM QoS" really means a struct struct
> pm_qos_constraints object with a global reader of its target_value.
>
> Of course, pm_qos_update_target() is not particularly convenient to
> use, so you'd need to wrap it into an _add/update/remove_request()
> family of functions along the lines of the cpu_latency_qos_*() ones I
> suppose and you won't need the _apply() thing.
>

Yeah, sounds about right.

>> >> but none of them sound particularly exciting:
>> >>
>> >>  1/ Use an interface specific to CPUFREQ, pretty much like the one
>> >>     introduced in my original submission [1].
>> >
>> > It uses frequency QoS already today, do you really need something else?
>> >
>>
>> Yes.  I don't see how frequency QoS could be useful for this as-is,
>> unless we're willing to introduce code in every device driver that takes
>> advantage of this and have them monitor the utilization of every CPU in
>> the system, so they can calculate an appropriate max frequency
>> constraint -- One which we can be reasonably certain won't hurt the
>> long-term performance of the CPU cores these constraints are being
>> placed on.
>
> I'm not really sure if I understand you correctly.
>
> The frequency QoS in cpufreq is a way to influence the min and max
> freq limits used by it for each CPU.  That is done in a couple of
> places like store_max/min_perf_pct() in intel_pstate or
> processor_set_cur_state() (I guess the latter would be close to what
> you think about, but the other way around - you seem to want to
> influence the min and not the max).
>
I do want to influence the max frequency primarily.

> Now, the question what request value(s) to put in there and how to
> compute them is kind of a different one.
>

And the question of what frequency request to put in there is the really
tricky one IMO, because it requires every user of this interface to
monitor CPU performance counters in order to guess what an appropriate
frequency constraint is (i.e. one which won't interfere with the work of
other applications and that won't cause the bottleneck of the same
application to shift from the IO device to the CPU).  That's why
shifting from a frequency constraint to a response latency constraint
seems valuable to me: Even though the optimal CPU frequency constraint
is highly variable in time (based on the instantaneous balance between
CPU and IO load), the optimal latency constraint is approximately
constant for any given workload as long as it continues to be IO-bound
(since the greatest acceptable latency constraint might be a simple
function of the monitor refresh rate, network protocol constraints, IO
device latency, etc.).

>> >>  2/ Use per-CPU PM QoS, which AFAICT would require the graphics driver
>> >>     to either place a request on every CPU of the system (which would
>> >>     cause a frequent operation to have O(N) complexity on the number of
>> >>     CPUs on the system), or play a cat-and-mouse game with the task
>> >>     scheduler.
>> >
>> > That's in place already too in the form of device PM QoS; see
>> > drivers/base/power/qos.c.
>>
>> But wouldn't that have the drawbacks I was talking about above when
>> trying to use it in order to set this kind of constraints on CPU power
>> management?
>
> I guess so, but the alternatives have drawbacks too.
>
>> >
>> >>  3/ Add a new global PM QoS mechanism roughly duplicating the
>> >>     cpu_latency_qos_* interfaces introduced in this series.  Drop your
>> >>     change making this available to CPU IDLE only.
>> >
>> > It sounds like you really want performance for energy efficiency and
>> > CPU latency has a little to do with that.
>> >
>>
>> The mechanism I've been working on isn't intended to sacrifice long-term
>> performance of the CPU (e.g. if a CPU core is 100% utilized in the
>> steady state by the same or an unrelated application the CPUFREQ
>> governor should still request the maximum turbo frequency for it), it's
>> only meant to affect the trade-off between energy efficiency and latency
>> (e.g. the time it takes for the CPUFREQ governor to respond to an
>> oscillation of the workload that chooses to opt in).
>
> So the meaning of "latency" here is really different from the meaning
> of "latency" in the cpuidle context and in RT.
>
> I guess it would be better to call it "response time" in this case to
> avoid confusion.

I'm fine with calling this time parameter response time instead.  What
is going on under the hood is indeed somewhat different from the cpuidle
case, but the interpretation is closely related: Latency it takes for
the CPU to reach some nominal (e.g. maximum) level of performance after
wake-up in response to a step-function utilization.

>
> Let me ask if I understand you correctly: the problem is that for some
> workloads the time it takes to ramp up the frequency to an acceptable
> (or desirable, more generally) level is too high, so the approach
> under consideration is to clamp the min frequency, either effectively
> or directly, so as to reduce that time?
>

Nope, the problem is precisely the opposite: PM is responding too
quickly to transient oscillations of the CPU load, even though the
actual latency requirements of the workload are far less stringent,
leading to energy-inefficient behavior which severely reduces the
throughput of the system under TDP-bound conditions.

>> >>  3/ Go straight to a scheduling-based approach, which is likely to
>> >>     greatly increase the review effort required to upstream this
>> >>     feature.  (Peter might disagree though?)
>> >
>> > Are you familiar with the utilization clamps mechanism?
>> >
>>
>> Sure, that would be a possibility as alternative to PM QoS, but it would
>> most likely involve task scheduler changes to get it working
>> effectively, which Srinivas and Rodrigo have asked me to leave out from
>> my next RFC submission in the interest of reviewability.  I wouldn't
>> mind plumbing comparable information through utilization clamps instead
>> or as follow-up if you think that's the way forward.
>
> Well, like I said somewhere above (or previously), the main problem
> with utilization clamps is that they have no effect on HWP at the
> moment.  Currently, there is a little connection between the scheduler
> and the HWP algorithm running on the processor.  However, I would like
> to investigate that path, because the utilization clamps provide a
> good interface for applications to request a certain level of service
> from the scheduler (they can really be regarded as a QoS mechanism
> too) and connecting them to the HWP min and max limits somehow might
> work.
>

Yeah, it would be really nice to have the utilization clamps influence
the HWP P-state range.  That said I think the most straightforward way
to achieve this via utilization clamps would be to add a third "response
latency" clamp which defaults to infinity (if the application doesn't
care to set a latency requirement) and is aggregated across tasks queued
to the same RQ by taking the minimum value (so the most stringent
latency request is honored).

It may be technically possible to implement this based on the MAX clamp
alone, but it would have similar or worse drawbacks than the per-CPU
frequency QoS alternative we were discussing earlier: In order to avoid
hurting the performance of the application, each bottlenecking device
driver would have to periodically monitor the CPU utilization of every
thread of every process talking to the device, and periodically adjust
their MAX utilization clamps in order to adapt to fluctuations of the
balance between CPU and IO load.  That's O(n*f) run-time overhead on the
number of threads and utilization sampling frequency.  In comparison a
latency constraint would be pretty much a fire-and-forget.

Or it might be possible but likely as controversial to put all processes
talking to the same device under a single cgroup in order to manage them
with a single clamp -- Except I don't think that would easily scale to
multiple devices.

> Thanks!

Thanks for your feedback!

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXkXmdAAKCRCDmTidfVK/
WwxPAP9G/k6zSQQcrYMSzjmyfJbrN640vuNcBXCBk6ZhDUvKbQD/aPBTgr4tXIhz
i0oY4N6WEq109bOlM7x5r4MadgdyAMc=
=Vbzh
-----END PGP SIGNATURE-----
--==-=-=--
