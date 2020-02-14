Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2541415D5F1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 11:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgBNKm5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 05:42:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40619 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbgBNKm5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 05:42:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id a142so8970303oii.7;
        Fri, 14 Feb 2020 02:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElQ4XTao5BBX71Zwi3H6xOYBPtV7GHSLam5Ec0mM0f0=;
        b=GuchQ/sJt7GQabRkHIKwMCfTKcHuUawD4K22DmE4t5hdZwP1kHXHzFWkrZPpeCObTr
         JsLM85g08tP3MDjaRi4Vx0md/6e36uryPVFRRl0c1dOLDgEDhlT8/s9Mbv05lXPwlAHk
         dkCN+C3MXFqKarZ0zZs/2UOKS4mtKvhV9UpqlMUj2eXNNeDJtwRE9U9trDBhnpH9tPsk
         g4YJnMisCn+anUpEi9dWyUjDgRdz8nco2F7nGtzuYwTZlz97Q9hTaw2FOVwyQXOorpv/
         1WOG2Oq06o7w9UUonN6r7piivmvnOkg9idQC0kMoN7TL22IJ53m8cPmVAklt3/swCMiZ
         kQDA==
X-Gm-Message-State: APjAAAWa53WQNYswYT1w1RDtTgYFJK0gdWojybEDQIWPlJN7ZIPKRy9X
        w5bZ8hIZ2CV9DRKpubGWwwKg5DwQa9D9NPgYR4oWEg==
X-Google-Smtp-Source: APXvYqzimSl+0e2efwrs0p3a3e4x5f5/qW30jMLg+PuMujuKXKW9v8A00J4QynLY5a6KdAn8yYXbIsx6KjB+fxi9vfk=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr1448301oif.57.1581676975796;
 Fri, 14 Feb 2020 02:42:55 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net>
 <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com>
 <878sl6j4fd.fsf@riseup.net> <CAJZ5v0jNFMwqSwSones91WgDwGqusyY1nEMDKAYuSZiLjH61dw@mail.gmail.com>
 <CAJZ5v0iMvzFGbuYsOo+AkWAqUbkQVT-FHsTDbStPiNenw783LQ@mail.gmail.com> <87sgjegh20.fsf@riseup.net>
In-Reply-To: <87sgjegh20.fsf@riseup.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Feb 2020 11:42:44 +0100
Message-ID: <CAJZ5v0hm2vVbM5dXGitvvUrWoZXZXXaJ+P3x38BjHRukZKgB3Q@mail.gmail.com>
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

On Fri, Feb 14, 2020 at 1:14 AM Francisco Jerez <currojerez@riseup.net> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Thu, Feb 13, 2020 at 12:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:

[cut]

> >
> > I think that your use case is almost equivalent to the thermal
> > pressure one, so you'd want to limit the max and so that would be
> > something similar to store_max_perf_pct() with its input side hooked
> > up to a QoS list.
> >
> > But it looks like that QoS list would rather be of a "reservation"
> > type, so a request added to it would mean something like "leave this
> > fraction of power that appears to be available to the CPU subsystem
> > unused, because I need it for a different purpose".  And in principle
> > there might be multiple requests in there at the same time and those
> > "reservations" would add up.  So that would be a kind of "limited sum"
> > QoS type which wasn't even there before my changes.
> >
> > A user of that QoS list might then do something like
> >
> > ret = cpu_power_reserve_add(1, 4);
> >
> > meaning that it wants 25% of the "potential" CPU power to be not
> > utilized by CPU performance scaling and that could affect the
> > scheduler through load modifications (kind of along the thermal
> > pressure patchset discussed some time ago) and HWP (as well as the
> > non-HWP intel_pstate by preventing turbo frequencies from being used
> > etc).
>
> The problems with this are the same as with the per-CPU frequency QoS
> approach: How does the device driver know what the appropriate fraction
> of CPU power is?

Of course it doesn't know and it may never know exactly, but it may guess.

Also, it may set up a feedback loop: request an aggressive
reservation, run for a while, measure something and refine if there's
headroom.  Then repeat.

> Depending on the instantaneous behavior of the
> workload it might take 1% or 95% of the CPU power in order to keep the
> IO device busy.  Each user of this would need to monitor the performance
> of every CPU in the system and update the constraints on each of them
> periodically (whether or not they're talking to that IO device, which
> would possibly negatively impact the latency of unrelated applications
> running on other CPUs, unless we're willing to race with the task
> scheduler).

No, it just needs to measure a signal representing how much power *it*
gets and decide whether or not it can let the CPU subsystem use more
power.

> A solution based on utilization clamps (with some
> extensions) sounds more future-proof to me honestly.

Except that it would be rather hard to connect it to something like
RAPL, which should be quite straightforward with the approach I'm
talking about.

The problem with all scheduler-based ways, again, is that there is no
direct connection between the scheduler and HWP, or even with whatever
the processor does with the P-states in the turbo range.  If any
P-state in the turbo range is requested, the processor has a license
to use whatever P-state it wants, so this pretty much means allowing
it to use as much power as it can.

So in the first place, if you want to limit the use of power in the
CPU subsystem through frequency control alone, you need to prevent it
from using turbo P-states at all.  However, with RAPL you can just
limit power which may still allow some (but not all) turbo P-states to
be used.
