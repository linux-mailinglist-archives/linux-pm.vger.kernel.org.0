Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E415F7BB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 21:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgBNUbt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 15:31:49 -0500
Received: from mx1.riseup.net ([198.252.153.129]:39218 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730112AbgBNUbt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Feb 2020 15:31:49 -0500
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48K4mM4k61zF0VW;
        Fri, 14 Feb 2020 12:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1581712307; bh=UDW59QgM48LzXutZWg8Zr3CXbTOd/mv0/7P22JtvSnY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YZafQIzcDWFgAxZ5vH05saipFOE71Y7JBj4iavNDhWxGVwcmH+Bn/Clr9Aair+WFh
         z1j/RV3ZCo6EM7SRprpgJ1dPinFZSYCtFcaRKUaNlAmPTx3KcQsJiXxFzluJMRymZ5
         D4j18sTr2tJA2WVhMqGCL9Kbomko7ulDcMT9YWSI=
X-Riseup-User-ID: 2F2AC137C94F413A53FC645837296E0BD74C8BB708B00DAFB1112017EF2AAE3C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48K4mL6FmJz8vYX;
        Fri, 14 Feb 2020 12:31:46 -0800 (PST)
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
In-Reply-To: <CAJZ5v0hm2vVbM5dXGitvvUrWoZXZXXaJ+P3x38BjHRukZKgB3Q@mail.gmail.com>
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net> <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com> <878sl6j4fd.fsf@riseup.net> <CAJZ5v0jNFMwqSwSones91WgDwGqusyY1nEMDKAYuSZiLjH61dw@mail.gmail.com> <CAJZ5v0iMvzFGbuYsOo+AkWAqUbkQVT-FHsTDbStPiNenw783LQ@mail.gmail.com> <87sgjegh20.fsf@riseup.net> <CAJZ5v0hm2vVbM5dXGitvvUrWoZXZXXaJ+P3x38BjHRukZKgB3Q@mail.gmail.com>
Date:   Fri, 14 Feb 2020 12:32:42 -0800
Message-ID: <87imk8hpud.fsf@riseup.net>
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

> On Fri, Feb 14, 2020 at 1:14 AM Francisco Jerez <currojerez@riseup.net> wrote:
>>
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>
>> > On Thu, Feb 13, 2020 at 12:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> [cut]
>
>> >
>> > I think that your use case is almost equivalent to the thermal
>> > pressure one, so you'd want to limit the max and so that would be
>> > something similar to store_max_perf_pct() with its input side hooked
>> > up to a QoS list.
>> >
>> > But it looks like that QoS list would rather be of a "reservation"
>> > type, so a request added to it would mean something like "leave this
>> > fraction of power that appears to be available to the CPU subsystem
>> > unused, because I need it for a different purpose".  And in principle
>> > there might be multiple requests in there at the same time and those
>> > "reservations" would add up.  So that would be a kind of "limited sum"
>> > QoS type which wasn't even there before my changes.
>> >
>> > A user of that QoS list might then do something like
>> >
>> > ret = cpu_power_reserve_add(1, 4);
>> >
>> > meaning that it wants 25% of the "potential" CPU power to be not
>> > utilized by CPU performance scaling and that could affect the
>> > scheduler through load modifications (kind of along the thermal
>> > pressure patchset discussed some time ago) and HWP (as well as the
>> > non-HWP intel_pstate by preventing turbo frequencies from being used
>> > etc).
>>
>> The problems with this are the same as with the per-CPU frequency QoS
>> approach: How does the device driver know what the appropriate fraction
>> of CPU power is?
>
> Of course it doesn't know and it may never know exactly, but it may guess.
>
> Also, it may set up a feedback loop: request an aggressive
> reservation, run for a while, measure something and refine if there's
> headroom.  Then repeat.
>

Yeah, of course, but that's obviously more computationally intensive and
less accurate than computing an approximately optimal constraint in a
single iteration (based on knowledge from performance counters and a
notion of the latency requirements of the application), since such a
feedback loop relies on repeatedly overshooting and undershooting the
optimal value (the latter causes an artificial CPU bottleneck, possibly
slowing down other applications too) in order to converge to and remain
in a neighborhood of the optimal value.

Incidentally people tested a power balancing solution with a feedback
loop very similar to the one you're describing side by side to the RFC
patch series I provided a link to earlier (which targeted Gen9 LP
parts), and the energy efficiency improvements they observed were
roughly half of the improvement obtained with my series unsurprisingly.

Not to speak about generalizing such a feedback loop to bottlenecks on
multiple I/O devices.

>> Depending on the instantaneous behavior of the
>> workload it might take 1% or 95% of the CPU power in order to keep the
>> IO device busy.  Each user of this would need to monitor the performance
>> of every CPU in the system and update the constraints on each of them
>> periodically (whether or not they're talking to that IO device, which
>> would possibly negatively impact the latency of unrelated applications
>> running on other CPUs, unless we're willing to race with the task
>> scheduler).
>
> No, it just needs to measure a signal representing how much power *it*
> gets and decide whether or not it can let the CPU subsystem use more
> power.
>

Well yes it's technically possible to set frequency constraints based on
trial-and-error without sampling utilization information from the CPU
cores, but don't we agree that this kind of information can be highly
valuable?

>> A solution based on utilization clamps (with some
>> extensions) sounds more future-proof to me honestly.
>
> Except that it would be rather hard to connect it to something like
> RAPL, which should be quite straightforward with the approach I'm
> talking about.
>

I think using RAPL as additional control variable would be useful, but
fully orthogonal to the cap being set by some global mechanism or being
derived from the aggregation of a number of per-process power caps based
on the scheduler behavior.  The latter sounds like the more reasonable
fit for a multi-tasking, possibly virtualized environment honestly.
Either way RAPL is neither necessary nor sufficient in order to achieve
the energy efficiency improvement I'm working on.

> The problem with all scheduler-based ways, again, is that there is no
> direct connection between the scheduler and HWP,

I was planning to introduce such a connection in RFC part 2.  I have a
prototype for that based on a not particularly pretty custom interface,
I wouldn't mind trying to get it to use utilization clamps if you think
that's the way forward.

> or even with whatever the processor does with the P-states in the
> turbo range.  If any P-state in the turbo range is requested, the
> processor has a license to use whatever P-state it wants, so this
> pretty much means allowing it to use as much power as it can.
>
> So in the first place, if you want to limit the use of power in the
> CPU subsystem through frequency control alone, you need to prevent it
> from using turbo P-states at all.  However, with RAPL you can just
> limit power which may still allow some (but not all) turbo P-states to
> be used.

My goal is not to limit the use of power of the CPU (if it has enough
load to utilize 100% of the cycles at turbo frequency so be it), but to
get it to use it more efficiently.  If you are constrained by a given
power budget (e.g. the TDP or the one you want set via RAPL) you can do
more with it if you set a stable frequency rather than if you let the
CPU bounce back and forth between turbo and idle.  This can only be
achieved effectively if the frequency governor has a rough idea of the
latency requirements of the workload, since it involves a
latency/energy-efficiency trade-off.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXkcD6wAKCRCDmTidfVK/
W8xqAP9m+jQ3Rp0GOFfNtJkPma7sqpuQwGB0G3rQEZq3nVYbhwD/buI2xcJubmuD
enQ8G39me8IzFy8dc57smMz3BqDV3ag=
=l5DG
-----END PGP SIGNATURE-----
--==-=-=--
