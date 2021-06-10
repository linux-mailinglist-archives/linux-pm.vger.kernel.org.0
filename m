Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7F3A2B5C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 14:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFJMXH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 08:23:07 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44655 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFJMXG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 08:23:06 -0400
Received: by mail-lj1-f180.google.com with SMTP id d2so4564816ljj.11
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5saXN8y8jJnqzcobNPFjAY/LSyHRP80akt09QmswJ4=;
        b=e/2hVyE4fRiykxrzhmxMG/q+qyIOL1MUvYrqhuSdWzN0nMeZlMi6Ajpaw+yaKeMCCS
         1h+y8jHR3niT07qbiKeaxsBaO/Adscm/eTQ6wpQ5HTbpLbdhg8m+lqvjk1F6Pgzp8+QI
         lkF2vcJ0Xc90f3pr5jPsg4LpqetxOmykeLl/H2Nwq5+6h8ZxBpQxEVjyRlzJifg5YlyJ
         WBOaau+HOhP2WsGfdwpOC6qxAM/6Gok0rv55SGkDxEeYkUBSeE6kh+NVv+mLL/3SaF2e
         k7zUqJDpac9+h1UAGSBMOA7SXTBDS3PfAExcqauPcvHZ53nSu6E1DftRONJZPJGiPTH8
         WOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5saXN8y8jJnqzcobNPFjAY/LSyHRP80akt09QmswJ4=;
        b=kqEDgZ57279iqYvmGguH2S8jpjdM9OqVjHC8+A6kX7t5tL6kfssnOdk5PxxZEC5Kzn
         pqwULXXgNLh/TlY3w/iQgStorQ7fjtR5hOSCHyJECmd1QNhIKSJz4FtHS/B9T4wEi/ZK
         p0KEaYL2uc8Cn4u+L4YkVPrZeCbp7QYDAkELnuSVvOmB+fUUS/FBXhseInFKEKmqp5S9
         qpJs58Pj4ss/Hdglk1wqra7K3Viz6FRLkvm/EdwKAz7QpU62X6NOXhdbIQFdvR6uS8kG
         OCNExde41XIfgTKZ+DWEO3N9F+lw+kPEJlYpkhy6ctEQPnt9Y6GIoNPUaXv0z5BzOJu6
         WkDw==
X-Gm-Message-State: AOAM531b4dgoLNwe0OUtz9amJGQPEsqWwcY76US9EwFG37gneyxEB4Jj
        YAKuHzhmxi8ijKrsF4KlttYIpmjn3xiuSzfGY7Jo9Q==
X-Google-Smtp-Source: ABdhPJwFSEoSyIsifCA2OLdHCyYtfNKqc6atLULHS9wJFnsphHwklXtKHggSuzsWiXxUg8L+g/Ml9vrU9ci8RJd/5z0=
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr1941210lji.209.1623327597098;
 Thu, 10 Jun 2021 05:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210604080954.13915-1-lukasz.luba@arm.com> <20210604080954.13915-2-lukasz.luba@arm.com>
 <2f2fc758-92c6-5023-4fcb-f9558bf3369e@arm.com> <905f1d29-50f9-32be-4199-fc17eab79d04@arm.com>
 <3cfa5690-644b-ba80-3fc3-7c5a3f292e70@arm.com> <c77d00b9-d7a3-0e8a-a528-ab0c1773496f@arm.com>
In-Reply-To: <c77d00b9-d7a3-0e8a-a528-ab0c1773496f@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Jun 2021 14:19:44 +0200
Message-ID: <CAKfTPtAc62gyjxSiSY2vD_qr-WjqbC91_GF-LXgNXh8T0Xx-yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Jun 2021 at 12:37, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/10/21 11:07 AM, Dietmar Eggemann wrote:
> > On 10/06/2021 11:04, Lukasz Luba wrote:
> >>
>
> [snip]
>
> >> Not always, it depends on thermal governor decision, workload and
> >> 'power actors' (in IPA naming convention). Then it depends when and how
> >> hard you clamp the CPUs. They (CPUs) don't have to be always
> >> overutilized, they might be even 50-70% utilized but the GPU reduced
> >> power budget by 2 Watts, so CPUs left with only 1W. Which is still OK
> >> for the CPUs, since they are only 'feeding' the GPU with new 'jobs'.
> >
> > All this pretty much confines the usefulness of you proposed change. A
> > precise description of it with the patches is necessary to allow people
> > to start from there while exploring your patches.
>
> OK, I see your point.
>
> [snip]
>
> >> True, I hope this description above would help to understand the
> >> scenario.
> >
> > This description belongs in the patch header. The scenario in which your
> > functionality would improve things has to be clear.
> > I'm sure that not everybody looking at this patches is immediately aware
> > on how IPA setups work and which specific setup you have in mind here.
>
> Agree. I will add this description into the patch header for v3.
>
> [snip]
>
> >>
> >> Yes, this code implementation tries to address those issues.
> >
> > The point I was making here is: why using the PELT signal
> > thermal_load_avg() and not per_cpu(thermal_pressure, cpu) directly,
> > given the fact that the latter perfectly represents the frequency clamping?
> >
>
> Good question. I wanted to be aligned with other parts in the fair.c
> like cpu_capacity() and all it's users. The CPU capacity is reduced by
> RT, DL, IRQ and thermal load avg, not the 'raw' value from the
> per-cpu variable.
>
> TBH I cannot recall what was the argument back then
> when thermal pressure geometric series was introduced.
> Maybe to have a better control how fast it raises and decays
> so other mechanisms in the scheduler will see the change in thermal
> as not so sharp... (?)
>
>
> Vincent do you remember the motivation to have geometric series
> in thermal pressure and not use just the 'raw' value from per-cpu?

In order to have thermal pressure  synced with other metrics used by
the scheduler like util/rt/dl_avg. As an example, when thermal
pressure will decrease because thermal capping is removed, the
utilization will increase at the same pace as thermal will decrease
and it will not create some fake spare cycle. util_avg is the average
expected utilization of the cpu, thermal pressure reflects the average
stolen capacity for the same averaging time scale but this can be the
result of a toggle between several OPP

Using current capping is quite volatile to make a decision as it might
have changed by the time you apply your decision.
