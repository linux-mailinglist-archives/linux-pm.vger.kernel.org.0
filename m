Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A62961F2
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368822AbgJVPzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 11:55:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46622 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368710AbgJVPzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 11:55:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id l4so2196178oii.13;
        Thu, 22 Oct 2020 08:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWO3IQz78ceChK0zK3nyCefCsWEQdrrDKBxsqj0an60=;
        b=TiPwXLSZIOh1z/sxACbb7TpQynxLy//M1+ZIBgYTKmQse9veMarIu9sw+vZ1Pk9oao
         AEtlPHPpo6EltIE78gFX2ag+y3WvqIJAhTMovczFEiVkBxeGLjSZM0p6aRvB7u6RyrAv
         Rx9T9vGFZeYBRdMEv58B08APJkDw4mrvls+JCA7A69Ha9ze4FUCcunXk4Vo4IEymTmKx
         DrJ42F1KGmyqAQFRKQ12M66zwzee2Jm1ExbIXtMT+Wy53B2eHlWJKHlwfZKNCTVJKH3p
         +d3qbH21g0iSJMYNfSpTclBr+SyiRmCrg4mLrdozpDrmumifXwblYPO49GzOAMou9Mj2
         dgkg==
X-Gm-Message-State: AOAM530dtzhJOVdODfZVqcD8bnluhiegLj4y1W/tUdFUQfehmw7Hw3lg
        csNQL+xsXI1+DoWh0k5Zbvs7Dy8VKrgKhiGiw8A=
X-Google-Smtp-Source: ABdhPJx3LsO/I9oXAh+bfL7w6snnZhYs+BQDpxz7rtv6Z2IapOmG+qwXykVw+OcH6ZoN7TPhJT6oiqkoFtOh16u0kgo=
X-Received: by 2002:aca:724a:: with SMTP id p71mr1988454oic.157.1603382138228;
 Thu, 22 Oct 2020 08:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher> <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher> <20201022122949.GW2628@hirez.programming.kicks-ass.net>
 <20201022145250.GK32041@suse.de> <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Oct 2020 17:55:27 +0200
Message-ID: <CAJZ5v0hcUq1F4mXDtg9=Co90o-DwtZAN7_bMZfesgM6aoZ+aCg@mail.gmail.com>
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 5:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 22, 2020 at 03:52:50PM +0100, Mel Gorman wrote:
>
> > There are some questions
> > currently on whether schedutil is good enough when HWP is not available.
>
> Srinivas and Rafael will know better, but Intel does run a lot of tests
> and IIRC it was found that schedutil was on-par for !HWP. That was the
> basis for commit:
>
>   33aa46f252c7 ("cpufreq: intel_pstate: Use passive mode by default without HWP")
>
> But now it turns out that commit results in running intel_pstate-passive
> on ondemand, which is quite horrible.

It doesn't in general.  AFAICS this happens only if "ondemand" was
selected as the default governor in the old kernel config, which
should not be the common case.

But I do agree that this needs to be avoided.

> > There was some evidence (I don't have the data, Giovanni was looking into
> > it) that HWP was a requirement to make schedutil work well.
>
> That seems to be the question; Rafael just said the opposite.

I'm not aware of any data like that.

HWP should not be required and it should always be possible to make an
HWP system run without HWP (except for those with exotic BIOS
configs).  However, schedutil should work without HWP as well as (or
better than) the "ondemand" and "conservative" governors on top of the
same driver (whatever it is) and it should work as well as (or better
than) "raw" HWP (so to speak) on top of intel_pstate in the passive
mode with HWP enabled (before 5.9 it couldn't work in that
configuration at all and now it can do that, which I guess may be
regarded as an improvement).

> > For distros, switching to schedutil by default would be nice because
> > frequency selection state would follow the task instead of being per-cpu
> > and we could stop worrying about different HWP implementations but it's
>
> s/HWP/cpufreq-governors/ ? But yes.

Well, different HWP implementations in different processor generations
may be a concern as well in general.

> > not at the point where the switch is advisable. I would expect hard data
> > before switching the default and still would strongly advise having a
> > period of time where we can fall back when someone inevitably finds a
> > new corner case or exception.
>
> Which is why I advocated to make it 'difficult' to use the old ones and
> only later remove them.

Slightly less convenient may be sufficient IMV.

> > For reference, SLUB had the same problem for years. It was switched
> > on by default in the kernel config but it was a long time before
> > SLUB was generally equivalent to SLAB in terms of performance.
>
> I remember :-)
