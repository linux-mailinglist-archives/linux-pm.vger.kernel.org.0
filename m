Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60A215B5B9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 01:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgBMAQ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 19:16:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39600 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgBMAQz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 19:16:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so3856944oty.6;
        Wed, 12 Feb 2020 16:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XI34I6WG5cLO+IgVIv5RydOAiN6nIiwYbnYoCUKFLk=;
        b=dAPiFd+zJYHknfheTFxz769Gfrs5LDUqufR50NKXumQR4tneo5tmA7bpkGou/hp5j5
         ppGgD8LAXPQBswgNT3PgkmAvkU391h+z9rw3itMva2ZgmhD9/kTerruAsIfJNj3tSWv9
         34wHU/tKoS/I3KpWuKzZAyn6X/Rh7xMsnvVcVDDeCL9RsmtzDWp1IypsSDD32GK65gFG
         eEDvFiwMscPppWcKsA0cMVBqTgqO3KPvpzjnLY3Dh6dd2UvtT+2p8Fmbe7HR6Pa/6uee
         6bhxcd7JnyBXoeKWBntSBZ9MmhZSMmpwmY0jjNGsSLsSqhyPunU0uLSc0xMTXTEdmA5+
         HABw==
X-Gm-Message-State: APjAAAWpNVBk2aWBHVdJ/Ajwwpq9KujwwSg74M+PQesZgkgmcsvzl8ut
        6q45Of4jjo47ilA4Lg30njsDlxpKkeL5Yr3pAIg=
X-Google-Smtp-Source: APXvYqzCjosDGyoF+GSyhDK4xJdLQQpA5vtY7pWUxrUuPlSlWLSCbL0WCZhsfzBrvkujPWkg8kndIBiPkjrIrmSGzaU=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr11454498otn.262.1581553014559;
 Wed, 12 Feb 2020 16:16:54 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net>
In-Reply-To: <87wo8rjsa4.fsf@riseup.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Feb 2020 01:16:43 +0100
Message-ID: <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Thu, Feb 13, 2020 at 12:31 AM Francisco Jerez <currojerez@riseup.net> wrote:
>
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>
> > Hi All,
> >
> > This series of patches is based on the observation that after commit
> > c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
> > in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
> > code dedicated to the handling of global PM QoS classes in general.  That code
> > takes up space and adds overhead in vain, so it is better to get rid of it.
> >
> > Moreover, with that unuseful code removed, the interface for adding QoS
> > requests for CPU latency becomes inelegant and confusing, so it is better to
> > clean it up.
> >
> > Patches [01/28-12/28] do the first part described above, which also includes
> > some assorted cleanups of the core PM QoS code that doesn't go away.
> >
> > Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> > "define stubs, migrate users, change the API proper" manner), patches
> > [26-27/28] update the general comments and documentation to match the code
> > after the previous changes and the last one makes the CPU latency QoS depend
> > on CPU_IDLE (because cpuidle is the only user of its target value today).
> >
> > The majority of the patches in this series don't change the functionality of
> > the code at all (at least not intentionally).
> >
> > Please refer to the changelogs of individual patches for details.
> >
> > Thanks!
>
> Hi Rafael,
>
> I believe some of the interfaces removed here could be useful in the
> near future.

I disagree.

>  It goes back to the energy efficiency- (and IGP graphics
> performance-)improving series I submitted a while ago [1].  It relies on
> some mechanism for the graphics driver to report an I/O bottleneck to
> CPUFREQ, allowing it to make a more conservative trade-off between
> energy efficiency and latency, which can greatly reduce the CPU package
> energy usage of IO-bound applications (in some graphics benchmarks I've
> seen it reduced by over 40% on my ICL laptop), and therefore also allows
> TDP-bound applications to obtain a reciprocal improvement in throughput.
>
> I'm not particularly fond of the global PM QoS interfaces TBH, it seems
> like an excessively blunt hammer to me, so I can very much relate to the
> purpose of this series.  However the finer-grained solution I've
> implemented has seen some push-back from i915 and CPUFREQ devs due to
> its complexity, since it relies on task scheduler changes in order to
> track IO bottlenecks per-process (roughly as suggested by Peter Zijlstra
> during our previous discussions), pretty much in the spirit of PELT but
> applied to IO utilization.
>
> With that in mind I was hoping we could take advantage of PM QoS as a
> temporary solution [2], by introducing a global PM QoS class similar but
> with roughly converse semantics to PM_QOS_CPU_DMA_LATENCY, allowing
> device drivers to report a *lower* bound on CPU latency beyond which PM
> shall not bother to reduce latency if doing so would have negative
> consequences on the energy efficiency and/or parallelism of the system.

So I really don't quite see how that could be responded to, by cpuidle
say.  What exactly do you mean by "reducing latency" in particular?

> Of course one would expect the current PM_QOS_CPU_DMA_LATENCY upper
> bound to take precedence over the new lower bound in cases where the
> former is in conflict with the latter.

So that needs to be done on top of this series.

> I can think of several alternatives to that which don't involve
> temporarily holding off your clean-up,

The cleanup goes in.  Please work on top of it.

> but none of them sound particularly exciting:
>
>  1/ Use an interface specific to CPUFREQ, pretty much like the one
>     introduced in my original submission [1].

It uses frequency QoS already today, do you really need something else?

>  2/ Use per-CPU PM QoS, which AFAICT would require the graphics driver
>     to either place a request on every CPU of the system (which would
>     cause a frequent operation to have O(N) complexity on the number of
>     CPUs on the system), or play a cat-and-mouse game with the task
>     scheduler.

That's in place already too in the form of device PM QoS; see
drivers/base/power/qos.c.

>  3/ Add a new global PM QoS mechanism roughly duplicating the
>     cpu_latency_qos_* interfaces introduced in this series.  Drop your
>     change making this available to CPU IDLE only.

It sounds like you really want performance for energy efficiency and
CPU latency has a little to do with that.

>  3/ Go straight to a scheduling-based approach, which is likely to
>     greatly increase the review effort required to upstream this
>     feature.  (Peter might disagree though?)

Are you familiar with the utilization clamps mechanism?

Thanks!
