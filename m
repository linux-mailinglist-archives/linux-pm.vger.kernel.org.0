Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D812915BDAE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 12:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgBMLeb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 06:34:31 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45816 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMLea (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 06:34:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so5400222oic.12;
        Thu, 13 Feb 2020 03:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LcEOVOrNACpietqV5HqnU8n3yySEMTmPlNme/pw1So=;
        b=CZIHrVMqxSvEXII+HCD0tr7H9+MXHBlW/4+2c8qSDZ5dcI5cqFKNCVCRAByZ7yA4Uf
         HLl0icDmQnnB2YTJbwXK6X1rOxu9DViTTiAM6i9uZw+EdVo6dwYAgIEEwqQUSOzr4MVB
         yeL/f+whJEOIQPfOto4tRzXLyOBfi/qXLH7wbea+yY/HAKc2+0H+lRPEAKW2h0OeyOjB
         Rk9IL9g6jdpgDXx0+d1+7WR62tfFFe6sM8nO4xayQv4KjO8MjWr7cOuVezIFKMImINZg
         m0+619CtpEEEKPUB59yFhB38nFuIQwRbC0OV8XaSrZdVBGpERUlITvQPoIXkgoWyQSWy
         /jiQ==
X-Gm-Message-State: APjAAAXV48+WLqynJSXQdO6LvqZjeNGLCP62PQpZlu85foBpEhPGLZOz
        Yuy1F3pI1WwdXuy0a9KCkAfCUBewVD00TFTLSY51uUGj
X-Google-Smtp-Source: APXvYqyC0wd9W1GcpP3VMPfjFJXTT+I0epOUUgXlK5lsHOFYA17pFyr83rlbynXQ9zVIZNdtkF/VXcXCtU/BdJ117I4=
X-Received: by 2002:a05:6808:8e1:: with SMTP id d1mr2552887oic.68.1581593669780;
 Thu, 13 Feb 2020 03:34:29 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net>
 <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com> <878sl6j4fd.fsf@riseup.net>
In-Reply-To: <878sl6j4fd.fsf@riseup.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Feb 2020 12:34:18 +0100
Message-ID: <CAJZ5v0jNFMwqSwSones91WgDwGqusyY1nEMDKAYuSZiLjH61dw@mail.gmail.com>
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

On Thu, Feb 13, 2020 at 9:07 AM Francisco Jerez <currojerez@riseup.net> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Thu, Feb 13, 2020 at 12:31 AM Francisco Jerez <currojerez@riseup.net> wrote:
> >>
> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> >>
> >> > Hi All,
> >> >
> >> > This series of patches is based on the observation that after commit
> >> > c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
> >> > in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
> >> > code dedicated to the handling of global PM QoS classes in general.  That code
> >> > takes up space and adds overhead in vain, so it is better to get rid of it.
> >> >
> >> > Moreover, with that unuseful code removed, the interface for adding QoS
> >> > requests for CPU latency becomes inelegant and confusing, so it is better to
> >> > clean it up.
> >> >
> >> > Patches [01/28-12/28] do the first part described above, which also includes
> >> > some assorted cleanups of the core PM QoS code that doesn't go away.
> >> >
> >> > Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> >> > "define stubs, migrate users, change the API proper" manner), patches
> >> > [26-27/28] update the general comments and documentation to match the code
> >> > after the previous changes and the last one makes the CPU latency QoS depend
> >> > on CPU_IDLE (because cpuidle is the only user of its target value today).
> >> >
> >> > The majority of the patches in this series don't change the functionality of
> >> > the code at all (at least not intentionally).
> >> >
> >> > Please refer to the changelogs of individual patches for details.
> >> >
> >> > Thanks!
> >>
> >> Hi Rafael,
> >>
> >> I believe some of the interfaces removed here could be useful in the
> >> near future.
> >
> > I disagree.
> >
> >>  It goes back to the energy efficiency- (and IGP graphics
> >> performance-)improving series I submitted a while ago [1].  It relies on
> >> some mechanism for the graphics driver to report an I/O bottleneck to
> >> CPUFREQ, allowing it to make a more conservative trade-off between
> >> energy efficiency and latency, which can greatly reduce the CPU package
> >> energy usage of IO-bound applications (in some graphics benchmarks I've
> >> seen it reduced by over 40% on my ICL laptop), and therefore also allows
> >> TDP-bound applications to obtain a reciprocal improvement in throughput.
> >>
> >> I'm not particularly fond of the global PM QoS interfaces TBH, it seems
> >> like an excessively blunt hammer to me, so I can very much relate to the
> >> purpose of this series.  However the finer-grained solution I've
> >> implemented has seen some push-back from i915 and CPUFREQ devs due to
> >> its complexity, since it relies on task scheduler changes in order to
> >> track IO bottlenecks per-process (roughly as suggested by Peter Zijlstra
> >> during our previous discussions), pretty much in the spirit of PELT but
> >> applied to IO utilization.
> >>
> >> With that in mind I was hoping we could take advantage of PM QoS as a
> >> temporary solution [2], by introducing a global PM QoS class similar but
> >> with roughly converse semantics to PM_QOS_CPU_DMA_LATENCY, allowing
> >> device drivers to report a *lower* bound on CPU latency beyond which PM
> >> shall not bother to reduce latency if doing so would have negative
> >> consequences on the energy efficiency and/or parallelism of the system.
> >
> > So I really don't quite see how that could be responded to, by cpuidle
> > say.  What exactly do you mean by "reducing latency" in particular?
> >
>
> cpuidle wouldn't necessarily have to do anything about it since it would
> be intended merely as a hint that a device in the system other than the
> CPU has a bottleneck.  It could provide a lower bound for the wake-up
> latency of the idle states that may be considered by cpuidle.  It seems
> to me like it could be useful when a program can tell from the
> characteristics of the workload that a latency reduction below a certain
> time bound wouldn't materially affect the performance of the system
> (e.g. if you have 20 ms to render a GPU-bound frame, you may not care at
> all about the CPU taking a fraction of a millisecond more to wake up a
> few times each frame).

Well, this is not how cpuidle works.

What it does is to try to find the deepest idle state that makes sense
to let the CPU go into given all of the constraints etc.  IOW it never
tries to reduce the latency, it looks how far it can go with possible
energy savings given a specific latency limit (or no limit at all).

> For cpufreq I was planning to have it influence a time parameter of the
> utilization averaging done by the governor, which would allow it to have
> a more optimal response in the long term (in the sense of lowering the
> energy cost of performing the same work in the specified timeframe),
> even if such a large time parameter wouldn't normally be considered
> appropriate for utilization averaging due to latency concerns.

So this is fine in the schedutil case in principle, it but would not
work with HWP, because that doesn't take the scheduler's utilization
metrics into account.

To cover the HWP case you need to influence the min and max frequency
limits, realistically.

> >> Of course one would expect the current PM_QOS_CPU_DMA_LATENCY upper
> >> bound to take precedence over the new lower bound in cases where the
> >> former is in conflict with the latter.
> >
> > So that needs to be done on top of this series.
> >
> >> I can think of several alternatives to that which don't involve
> >> temporarily holding off your clean-up,
> >
> > The cleanup goes in.  Please work on top of it.
> >
>
> Hopefully we can come up with an alternative in that case.  TBH I'd love
> to see your clean-up go in too, but global PM QoS seemed fairly
> appealing as a way to split up my work so it could be reviewed
> incrementally, even though I'm aiming for a finer-grained solution than
> that.

Well, so "global PM QoS" really means a struct struct
pm_qos_constraints object with a global reader of its target_value.

Of course, pm_qos_update_target() is not particularly convenient to
use, so you'd need to wrap it into an _add/update/remove_request()
family of functions along the lines of the cpu_latency_qos_*() ones I
suppose and you won't need the _apply() thing.

> >> but none of them sound particularly exciting:
> >>
> >>  1/ Use an interface specific to CPUFREQ, pretty much like the one
> >>     introduced in my original submission [1].
> >
> > It uses frequency QoS already today, do you really need something else?
> >
>
> Yes.  I don't see how frequency QoS could be useful for this as-is,
> unless we're willing to introduce code in every device driver that takes
> advantage of this and have them monitor the utilization of every CPU in
> the system, so they can calculate an appropriate max frequency
> constraint -- One which we can be reasonably certain won't hurt the
> long-term performance of the CPU cores these constraints are being
> placed on.

I'm not really sure if I understand you correctly.

The frequency QoS in cpufreq is a way to influence the min and max
freq limits used by it for each CPU.  That is done in a couple of
places like store_max/min_perf_pct() in intel_pstate or
processor_set_cur_state() (I guess the latter would be close to what
you think about, but the other way around - you seem to want to
influence the min and not the max).

Now, the question what request value(s) to put in there and how to
compute them is kind of a different one.

> >>  2/ Use per-CPU PM QoS, which AFAICT would require the graphics driver
> >>     to either place a request on every CPU of the system (which would
> >>     cause a frequent operation to have O(N) complexity on the number of
> >>     CPUs on the system), or play a cat-and-mouse game with the task
> >>     scheduler.
> >
> > That's in place already too in the form of device PM QoS; see
> > drivers/base/power/qos.c.
>
> But wouldn't that have the drawbacks I was talking about above when
> trying to use it in order to set this kind of constraints on CPU power
> management?

I guess so, but the alternatives have drawbacks too.

> >
> >>  3/ Add a new global PM QoS mechanism roughly duplicating the
> >>     cpu_latency_qos_* interfaces introduced in this series.  Drop your
> >>     change making this available to CPU IDLE only.
> >
> > It sounds like you really want performance for energy efficiency and
> > CPU latency has a little to do with that.
> >
>
> The mechanism I've been working on isn't intended to sacrifice long-term
> performance of the CPU (e.g. if a CPU core is 100% utilized in the
> steady state by the same or an unrelated application the CPUFREQ
> governor should still request the maximum turbo frequency for it), it's
> only meant to affect the trade-off between energy efficiency and latency
> (e.g. the time it takes for the CPUFREQ governor to respond to an
> oscillation of the workload that chooses to opt in).

So the meaning of "latency" here is really different from the meaning
of "latency" in the cpuidle context and in RT.

I guess it would be better to call it "response time" in this case to
avoid confusion.

Let me ask if I understand you correctly: the problem is that for some
workloads the time it takes to ramp up the frequency to an acceptable
(or desirable, more generally) level is too high, so the approach
under consideration is to clamp the min frequency, either effectively
or directly, so as to reduce that time?

> >>  3/ Go straight to a scheduling-based approach, which is likely to
> >>     greatly increase the review effort required to upstream this
> >>     feature.  (Peter might disagree though?)
> >
> > Are you familiar with the utilization clamps mechanism?
> >
>
> Sure, that would be a possibility as alternative to PM QoS, but it would
> most likely involve task scheduler changes to get it working
> effectively, which Srinivas and Rodrigo have asked me to leave out from
> my next RFC submission in the interest of reviewability.  I wouldn't
> mind plumbing comparable information through utilization clamps instead
> or as follow-up if you think that's the way forward.

Well, like I said somewhere above (or previously), the main problem
with utilization clamps is that they have no effect on HWP at the
moment.  Currently, there is a little connection between the scheduler
and the HWP algorithm running on the processor.  However, I would like
to investigate that path, because the utilization clamps provide a
good interface for applications to request a certain level of service
from the scheduler (they can really be regarded as a QoS mechanism
too) and connecting them to the HWP min and max limits somehow might
work.

Thanks!
