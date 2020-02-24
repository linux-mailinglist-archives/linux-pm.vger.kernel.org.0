Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30C916A42B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 11:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBXKjg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 05:39:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33555 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBXKjf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 05:39:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id w6so8289307otk.0;
        Mon, 24 Feb 2020 02:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfCiZDK1CnODGfD7R/bmkbjrbPhAPqhXLKFJ2vQzq2Q=;
        b=WH7X6PxPCVf2QaHfHcZvmf3s6OLbOURVs4AdyUVIP5l2DRCAJNnfq0J0hElFPEa8Qo
         s/CLxrKLsj5/rLRP8IkW8ONy6hsiLwQbzY4a1SCxaHh20D4fIlOwBs7EECIKFhA7xj4U
         kpsqWA3/L3aPZLHEQUxaCK+7nYwudQWGRbwEU0SLFaiC9wpxySyxJHaUugoQLrN36Ctv
         M/cbyEbWlaShSCRU7Lt7e86haPS/0KptE9HhPQEu0dtMCLC/hENu1N/n/2ZWOKJdjego
         NzNNk52NtyvElC/2P6JDlSVisicTqS9lVj9EsdPrq/50V2uOMKiDNveaQUq69LA1JQP/
         zbhQ==
X-Gm-Message-State: APjAAAU8l37NyHiGtP0uaZnYJrX5oNDIuVM4tIdBbKD+oFEp3O0q4riN
        a5gFyQx1DtoU46bHFfkFAuaLzxLoEXlYSuGKAl0=
X-Google-Smtp-Source: APXvYqy8Scnn+Iklf474MLavNjhVwGP7WqIRW+5ATgatZLAqljUyUkEe9IwRKpcvEKlJSUSwNkJtUSrenRwB2LKnIa0=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr18590355otd.266.1582540774775;
 Mon, 24 Feb 2020 02:39:34 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net>
 <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com>
 <878sl6j4fd.fsf@riseup.net> <CAJZ5v0jNFMwqSwSones91WgDwGqusyY1nEMDKAYuSZiLjH61dw@mail.gmail.com>
 <CAJZ5v0iMvzFGbuYsOo+AkWAqUbkQVT-FHsTDbStPiNenw783LQ@mail.gmail.com>
 <87sgjegh20.fsf@riseup.net> <CAJZ5v0hm2vVbM5dXGitvvUrWoZXZXXaJ+P3x38BjHRukZKgB3Q@mail.gmail.com>
 <87imk8hpud.fsf@riseup.net>
In-Reply-To: <87imk8hpud.fsf@riseup.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Feb 2020 11:39:23 +0100
Message-ID: <CAJZ5v0iz5e6GhpJcphKtyzS=MeteuQeSVOVkL-9YjeQ3OWO-Jw@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry for the late response, I was offline for a major part of the
previous week.

On Fri, Feb 14, 2020 at 9:31 PM Francisco Jerez <currojerez@riseup.net> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Fri, Feb 14, 2020 at 1:14 AM Francisco Jerez <currojerez@riseup.net> wrote:
> >>
> >> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >>
> >> > On Thu, Feb 13, 2020 at 12:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > [cut]
> >
> >> >
> >> > I think that your use case is almost equivalent to the thermal
> >> > pressure one, so you'd want to limit the max and so that would be
> >> > something similar to store_max_perf_pct() with its input side hooked
> >> > up to a QoS list.
> >> >
> >> > But it looks like that QoS list would rather be of a "reservation"
> >> > type, so a request added to it would mean something like "leave this
> >> > fraction of power that appears to be available to the CPU subsystem
> >> > unused, because I need it for a different purpose".  And in principle
> >> > there might be multiple requests in there at the same time and those
> >> > "reservations" would add up.  So that would be a kind of "limited sum"
> >> > QoS type which wasn't even there before my changes.
> >> >
> >> > A user of that QoS list might then do something like
> >> >
> >> > ret = cpu_power_reserve_add(1, 4);
> >> >
> >> > meaning that it wants 25% of the "potential" CPU power to be not
> >> > utilized by CPU performance scaling and that could affect the
> >> > scheduler through load modifications (kind of along the thermal
> >> > pressure patchset discussed some time ago) and HWP (as well as the
> >> > non-HWP intel_pstate by preventing turbo frequencies from being used
> >> > etc).
> >>
> >> The problems with this are the same as with the per-CPU frequency QoS
> >> approach: How does the device driver know what the appropriate fraction
> >> of CPU power is?
> >
> > Of course it doesn't know and it may never know exactly, but it may guess.
> >
> > Also, it may set up a feedback loop: request an aggressive
> > reservation, run for a while, measure something and refine if there's
> > headroom.  Then repeat.
> >
>
> Yeah, of course, but that's obviously more computationally intensive and
> less accurate than computing an approximately optimal constraint in a
> single iteration (based on knowledge from performance counters and a
> notion of the latency requirements of the application), since such a
> feedback loop relies on repeatedly overshooting and undershooting the
> optimal value (the latter causes an artificial CPU bottleneck, possibly
> slowing down other applications too) in order to converge to and remain
> in a neighborhood of the optimal value.

I'm not saying that feedback loops are the way to go in general, but
that in some cases they are applicable and this particular case looks
like it may be one of them.

> Incidentally people tested a power balancing solution with a feedback
> loop very similar to the one you're describing side by side to the RFC
> patch series I provided a link to earlier (which targeted Gen9 LP
> parts), and the energy efficiency improvements they observed were
> roughly half of the improvement obtained with my series unsurprisingly.
>
> Not to speak about generalizing such a feedback loop to bottlenecks on
> multiple I/O devices.

The generalizing part I'm totally unconvinced above.

> >> Depending on the instantaneous behavior of the
> >> workload it might take 1% or 95% of the CPU power in order to keep the
> >> IO device busy.  Each user of this would need to monitor the performance
> >> of every CPU in the system and update the constraints on each of them
> >> periodically (whether or not they're talking to that IO device, which
> >> would possibly negatively impact the latency of unrelated applications
> >> running on other CPUs, unless we're willing to race with the task
> >> scheduler).
> >
> > No, it just needs to measure a signal representing how much power *it*
> > gets and decide whether or not it can let the CPU subsystem use more
> > power.
> >
>
> Well yes it's technically possible to set frequency constraints based on
> trial-and-error without sampling utilization information from the CPU
> cores, but don't we agree that this kind of information can be highly
> valuable?

OK, so there are three things, frequency constraints (meaning HWP min
and max limits, for example), frequency requests (this is what cpufreq
does) and power limits.

If the processor has at least some autonomy in driving the frequency,
using frequency requests (i.e. cpufreq governors) for limiting power
is inefficient in general, because the processor is not required to
grant those requests at all.

Using frequency limits may be good enough, but it generally limits the
processor's ability to respond at short-time scales (for example,
setting the max frequency limit will prevent the processor from using
frequencies above that limit even temporarily, but that might be the
most energy-efficient option in some cases).

Using power limits (which is what RAPL does) doesn't bring such shortcomings in.

> >> A solution based on utilization clamps (with some
> >> extensions) sounds more future-proof to me honestly.
> >
> > Except that it would be rather hard to connect it to something like
> > RAPL, which should be quite straightforward with the approach I'm
> > talking about.
> >
>
> I think using RAPL as additional control variable would be useful, but
> fully orthogonal to the cap being set by some global mechanism or being
> derived from the aggregation of a number of per-process power caps based
> on the scheduler behavior.

I'm not sure what do you mean by "the cap" here.  A maximum frequency
limit or something else?

> The latter sounds like the more reasonable
> fit for a multi-tasking, possibly virtualized environment honestly.
> Either way RAPL is neither necessary nor sufficient in order to achieve
> the energy efficiency improvement I'm working on.

The "not necessary" I can agree with, but I don't see any arguments
for the "not sufficient" statement.

> > The problem with all scheduler-based ways, again, is that there is no
> > direct connection between the scheduler and HWP,
>
> I was planning to introduce such a connection in RFC part 2.  I have a
> prototype for that based on a not particularly pretty custom interface,
> I wouldn't mind trying to get it to use utilization clamps if you think
> that's the way forward.

Well, I may think so, but that's just thinking at this point.  I have
no real numbers to support that theory.

> > or even with whatever the processor does with the P-states in the
> > turbo range.  If any P-state in the turbo range is requested, the
> > processor has a license to use whatever P-state it wants, so this
> > pretty much means allowing it to use as much power as it can.
> >
> > So in the first place, if you want to limit the use of power in the
> > CPU subsystem through frequency control alone, you need to prevent it
> > from using turbo P-states at all.  However, with RAPL you can just
> > limit power which may still allow some (but not all) turbo P-states to
> > be used.
>
> My goal is not to limit the use of power of the CPU (if it has enough
> load to utilize 100% of the cycles at turbo frequency so be it), but to
> get it to use it more efficiently.  If you are constrained by a given
> power budget (e.g. the TDP or the one you want set via RAPL) you can do
> more with it if you set a stable frequency rather than if you let the
> CPU bounce back and forth between turbo and idle.

Well, this basically means driving the CPU frequency by hand with the
assumption that the processor cannot do the right thing in this
respect, while in theory the HWP algorithm should be able to produce
the desired result.

IOW, your argumentation seems to go into the "HWP is useless"
direction, more or less and while there are people who will agree with
such a statement, others won't.

> This can only be
> achieved effectively if the frequency governor has a rough idea of the
> latency requirements of the workload, since it involves a
> latency/energy-efficiency trade-off.

Let me state this again (and this will be the last time, because I
don't really like to repeat points): the frequency governor can only
*request* the processor to do something in general and the request may
or may not be granted, for various reasons.  If it is not granted, the
whole "control" mechanism fails.
