Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF1616B1EF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 22:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBXVQO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 16:16:14 -0500
Received: from mx1.riseup.net ([198.252.153.129]:51906 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgBXVQO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Feb 2020 16:16:14 -0500
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48RFH15NQXzF00S;
        Mon, 24 Feb 2020 13:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1582578974; bh=L0+6AdvBLtE+R3pTYEnO/b72g4awwI7J3xRkDeWL4XQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UanxhMHAm324IKaumjbJmXIFK9JUpK+9SyAYGPUgd9aGw/lxiJzKyE20N7e9+SDjz
         B585ys9nEyFZ1w96XBLTX7PXRU08D8MPyNXRJAI1kkoP6cI9a83gn6cOYu8vm7gsb2
         cAt7hiUEo4DrtjqxTPU/PUbrXNiECYG1MAIOOG/o=
X-Riseup-User-ID: CACFD77AC6A979ED6FD404C940A78177ED8DA9B9A5CD45A9B3ACC96E7F6896B2
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48RFH12WxYz8smj;
        Mon, 24 Feb 2020 13:16:13 -0800 (PST)
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
In-Reply-To: <CAJZ5v0iz5e6GhpJcphKtyzS=MeteuQeSVOVkL-9YjeQ3OWO-Jw@mail.gmail.com>
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net> <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com> <878sl6j4fd.fsf@riseup.net> <CAJZ5v0jNFMwqSwSones91WgDwGqusyY1nEMDKAYuSZiLjH61dw@mail.gmail.com> <CAJZ5v0iMvzFGbuYsOo+AkWAqUbkQVT-FHsTDbStPiNenw783LQ@mail.gmail.com> <87sgjegh20.fsf@riseup.net> <CAJZ5v0hm2vVbM5dXGitvvUrWoZXZXXaJ+P3x38BjHRukZKgB3Q@mail.gmail.com> <87imk8hpud.fsf@riseup.net> <CAJZ5v0iz5e6GhpJcphKtyzS=MeteuQeSVOVkL-9YjeQ3OWO-Jw@mail.gmail.com>
Date:   Mon, 24 Feb 2020 13:16:14 -0800
Message-ID: <87k14belep.fsf@riseup.net>
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

> Sorry for the late response, I was offline for a major part of the
> previous week.
>
> On Fri, Feb 14, 2020 at 9:31 PM Francisco Jerez <currojerez@riseup.net> wrote:
>>
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>
>> > On Fri, Feb 14, 2020 at 1:14 AM Francisco Jerez <currojerez@riseup.net> wrote:
>> >>
>> >> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>> >>
>> >> > On Thu, Feb 13, 2020 at 12:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> >
>> > [cut]
>> >
>> >> >
>> >> > I think that your use case is almost equivalent to the thermal
>> >> > pressure one, so you'd want to limit the max and so that would be
>> >> > something similar to store_max_perf_pct() with its input side hooked
>> >> > up to a QoS list.
>> >> >
>> >> > But it looks like that QoS list would rather be of a "reservation"
>> >> > type, so a request added to it would mean something like "leave this
>> >> > fraction of power that appears to be available to the CPU subsystem
>> >> > unused, because I need it for a different purpose".  And in principle
>> >> > there might be multiple requests in there at the same time and those
>> >> > "reservations" would add up.  So that would be a kind of "limited sum"
>> >> > QoS type which wasn't even there before my changes.
>> >> >
>> >> > A user of that QoS list might then do something like
>> >> >
>> >> > ret = cpu_power_reserve_add(1, 4);
>> >> >
>> >> > meaning that it wants 25% of the "potential" CPU power to be not
>> >> > utilized by CPU performance scaling and that could affect the
>> >> > scheduler through load modifications (kind of along the thermal
>> >> > pressure patchset discussed some time ago) and HWP (as well as the
>> >> > non-HWP intel_pstate by preventing turbo frequencies from being used
>> >> > etc).
>> >>
>> >> The problems with this are the same as with the per-CPU frequency QoS
>> >> approach: How does the device driver know what the appropriate fraction
>> >> of CPU power is?
>> >
>> > Of course it doesn't know and it may never know exactly, but it may guess.
>> >
>> > Also, it may set up a feedback loop: request an aggressive
>> > reservation, run for a while, measure something and refine if there's
>> > headroom.  Then repeat.
>> >
>>
>> Yeah, of course, but that's obviously more computationally intensive and
>> less accurate than computing an approximately optimal constraint in a
>> single iteration (based on knowledge from performance counters and a
>> notion of the latency requirements of the application), since such a
>> feedback loop relies on repeatedly overshooting and undershooting the
>> optimal value (the latter causes an artificial CPU bottleneck, possibly
>> slowing down other applications too) in order to converge to and remain
>> in a neighborhood of the optimal value.
>
> I'm not saying that feedback loops are the way to go in general, but
> that in some cases they are applicable and this particular case looks
> like it may be one of them.
>
>> Incidentally people tested a power balancing solution with a feedback
>> loop very similar to the one you're describing side by side to the RFC
>> patch series I provided a link to earlier (which targeted Gen9 LP
>> parts), and the energy efficiency improvements they observed were
>> roughly half of the improvement obtained with my series unsurprisingly.
>>
>> Not to speak about generalizing such a feedback loop to bottlenecks on
>> multiple I/O devices.
>
> The generalizing part I'm totally unconvinced above.
>

One of the main problems I see with generalizing a driver-controlled
feedback loop to multiple devices is that any one of the drivers has no
visibility over the performance of other workloads running on the same
CPU core but not tied to the same feedback loop.  E.g. consider a
GPU-bound application running concurrently with some latency-bound
application on the same CPU core: It would be easy (if somewhat
inaccurate) for the GPU driver to monitor the utilization of the one
device it controls in order to prevent performance loss as a result of
its frequency constraints, but how could it tell whether it's having a
negative impact on the performance of the other non-GPU-bound
application?  It doesn't seem possible to avoid that without the driver
monitoring the performance counters of each CPU core *and* having some
sort of interface in place for other unrelated applications to
communicate their latency constraints (which brings us back to the PM
QoS discussion).

>> >> Depending on the instantaneous behavior of the
>> >> workload it might take 1% or 95% of the CPU power in order to keep the
>> >> IO device busy.  Each user of this would need to monitor the performance
>> >> of every CPU in the system and update the constraints on each of them
>> >> periodically (whether or not they're talking to that IO device, which
>> >> would possibly negatively impact the latency of unrelated applications
>> >> running on other CPUs, unless we're willing to race with the task
>> >> scheduler).
>> >
>> > No, it just needs to measure a signal representing how much power *it*
>> > gets and decide whether or not it can let the CPU subsystem use more
>> > power.
>> >
>>
>> Well yes it's technically possible to set frequency constraints based on
>> trial-and-error without sampling utilization information from the CPU
>> cores, but don't we agree that this kind of information can be highly
>> valuable?
>
> OK, so there are three things, frequency constraints (meaning HWP min
> and max limits, for example), frequency requests (this is what cpufreq
> does) and power limits.
>
> If the processor has at least some autonomy in driving the frequency,
> using frequency requests (i.e. cpufreq governors) for limiting power
> is inefficient in general, because the processor is not required to
> grant those requests at all.
>

For limiting power yes, I agree that it would be less effective than a
RAPL constraint, but the purpose of my proposal is not to set an upper
limit on the power usage of the CPU in absolute terms, but in terms
relative to its performance: Given that the energy efficiency of the CPU
is steadily decreasing with frequency past the inflection point of the
power curve, it's more energy-efficient to set a frequency constraint
rather than to set a constraint on its long-term average power
consumption while letting the clock frequency swing arbitrarily around
the most energy-efficient frequency.

Please don't get me wrong: I think that leveraging RAPL constraints as
additional variable is authentically useful especially for thermal
management, but it's largely complementary to frequency constraints
which provide a more direct way to control the energy efficiency of the
CPU.

But even if we decide to use RAPL for this, wouldn't the RAPL governor
need to make a certain latency trade-off?  In order to avoid performance
degradation it would be necessary for the governor to respond to changes
in the load of the CPU, and some awareness of the latency constraints of
the application seems necessary either way in order to do that
effectively.  IOW the kind of latency constraint I wanted to propose
would be useful to achieve the most energy-efficient outcome whether we
use RAPL, frequency constraints, or both.

> Using frequency limits may be good enough, but it generally limits the
> processor's ability to respond at short-time scales (for example,
> setting the max frequency limit will prevent the processor from using
> frequencies above that limit even temporarily, but that might be the
> most energy-efficient option in some cases).
>
> Using power limits (which is what RAPL does) doesn't bring such shortcomings in.

But preventing a short-term oscillation of the CPU frequency is the
desired outcome rather than a shortcoming whenever the time scale of the
oscillation is orders of magnitude smaller than the latency requirements
known to the application, since it lowers the energy efficiency (and
therefore parallelism) of the system without any visible benefit for the
workload.  The mechanism I'm proposing wouldn't prevent such short-term
oscillations when needed except when an application or device driver
explicitly requests PM to damp them.

>
>> >> A solution based on utilization clamps (with some
>> >> extensions) sounds more future-proof to me honestly.
>> >
>> > Except that it would be rather hard to connect it to something like
>> > RAPL, which should be quite straightforward with the approach I'm
>> > talking about.
>> >
>>
>> I think using RAPL as additional control variable would be useful, but
>> fully orthogonal to the cap being set by some global mechanism or being
>> derived from the aggregation of a number of per-process power caps based
>> on the scheduler behavior.
>
> I'm not sure what do you mean by "the cap" here.  A maximum frequency
> limit or something else?
>

Either a frequency or a power cap.  Either way it seems valuable (but
not strictly necessary up front) for the cap to be derived from the
scheduler's behavior.

>> The latter sounds like the more reasonable
>> fit for a multi-tasking, possibly virtualized environment honestly.
>> Either way RAPL is neither necessary nor sufficient in order to achieve
>> the energy efficiency improvement I'm working on.
>
> The "not necessary" I can agree with, but I don't see any arguments
> for the "not sufficient" statement.
>

Not sufficient since RAPL doesn't provide as much of a direct limit on
the energy efficiency of the system as a frequency constraint would
[More on that above].

>> > The problem with all scheduler-based ways, again, is that there is no
>> > direct connection between the scheduler and HWP,
>>
>> I was planning to introduce such a connection in RFC part 2.  I have a
>> prototype for that based on a not particularly pretty custom interface,
>> I wouldn't mind trying to get it to use utilization clamps if you think
>> that's the way forward.
>
> Well, I may think so, but that's just thinking at this point.  I have
> no real numbers to support that theory.
>

Right.  And the only way to get numbers is to implement it.  I wouldn't
mind giving that a shot as a follow up.  But a PM QoS-based solution is
likely to give most of the benefit in the most common scenarios.

>> > or even with whatever the processor does with the P-states in the
>> > turbo range.  If any P-state in the turbo range is requested, the
>> > processor has a license to use whatever P-state it wants, so this
>> > pretty much means allowing it to use as much power as it can.
>> >
>> > So in the first place, if you want to limit the use of power in the
>> > CPU subsystem through frequency control alone, you need to prevent it
>> > from using turbo P-states at all.  However, with RAPL you can just
>> > limit power which may still allow some (but not all) turbo P-states to
>> > be used.
>>
>> My goal is not to limit the use of power of the CPU (if it has enough
>> load to utilize 100% of the cycles at turbo frequency so be it), but to
>> get it to use it more efficiently.  If you are constrained by a given
>> power budget (e.g. the TDP or the one you want set via RAPL) you can do
>> more with it if you set a stable frequency rather than if you let the
>> CPU bounce back and forth between turbo and idle.
>
> Well, this basically means driving the CPU frequency by hand with the
> assumption that the processor cannot do the right thing in this
> respect, while in theory the HWP algorithm should be able to produce
> the desired result.
>
> IOW, your argumentation seems to go into the "HWP is useless"
> direction, more or less and while there are people who will agree with
> such a statement, others won't.
>

I don't want to drive the CPU frequency by hand, and I don't think HWP
is useless by any means.  The purpose of my changes is to get HWP to do
a better job by constraining its response to a reasonable range based on
information which is largely unavailable to HWP -- E.g.: What are the
latency constraints of the application?  Does the application have an IO
bottleneck?  Which CPU core did we schedule the IO-bottlenecking
application to?

>> This can only be
>> achieved effectively if the frequency governor has a rough idea of the
>> latency requirements of the workload, since it involves a
>> latency/energy-efficiency trade-off.
>
> Let me state this again (and this will be the last time, because I
> don't really like to repeat points): the frequency governor can only
> *request* the processor to do something in general and the request may
> or may not be granted, for various reasons.  If it is not granted, the
> whole "control" mechanism fails.

And what's wrong with that?  The purpose of the latency constraint
interface is not to provide a hard limit on the CPU frequency, but to
give applications some influence on the latency trade-off made by the
governor whenever it isn't in conflict with the constraints set by other
applications (possibly as a result of them being part of the same clock
domain which may indeed cause the effective frequency to deviate from
the range specified by the P-state governor).  IOW the CPU frequency
momentarily exceeding the optimal value for any specific application
wouldn't violate the interface.  The result can still be massively more
energy-efficient than placing a long-term power constraint, or not
placing any constraint at all, even if P-state requests are not
guaranteed to succeed in general.

Regards,
Francisco.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXlQ9HgAKCRCDmTidfVK/
WzlNAP9PkK8q+HxhB149Oonyz5mKrS125tf24VCGQGDflN/A/AD/ajzg1UcP7OFY
3m2ha5ENi9q48B2ySmHDy/6BS+mav1M=
=fBxC
-----END PGP SIGNATURE-----
--==-=-=--
