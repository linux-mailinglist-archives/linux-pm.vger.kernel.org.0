Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260E5296450
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 19:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368666AbgJVR74 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 13:59:56 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:41794 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504374AbgJVR7z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 13:59:55 -0400
Received: by mail-oo1-f67.google.com with SMTP id n2so557571ooo.8;
        Thu, 22 Oct 2020 10:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBB6Akes8L8je/MlcV0jvER5QOo/7ixN2ULx0PgA70w=;
        b=WL0GaNgwt7BDr9xWrqOy5ZMgZK391KEnoPV8gsLtG872frqofJDU1N2kMaDVOVw7iy
         e4iTqKus3sJGDqjdYubHBlYac9/vvEMgpFqLnyOBJJoC+CviccRytNOTT3JK+PqwO/aj
         yZJ4pKOFrjg540ychuysDhlejRRS0nEH7JcPY9XOaklFpf/8CcWuMrPolMsMuOQZgCRr
         nSjnJ5LBAQGNgo1JiW3T7Te68pTgQuDVbF1kwCN5qwp8GRKxrO/t9fBTEMwx8ZSPDTbH
         7wHlCM1nxa9nqwWdCtvYoVErv+jm+MfnJzHIhZ1/SZXrDIxFjD3iNhA5uLfF03kxG8Fw
         hTWQ==
X-Gm-Message-State: AOAM530vv6SI1iaLWWEfH38breZ1VShWr8ku2MAXswdvhAFf/0jYixrw
        iHCkOOeOxXBME2YxWLCNAxFUJeXD9RFv2ZCRrZ4=
X-Google-Smtp-Source: ABdhPJxNM+8Sd/29ieJXvaIiWFkJhcvV+ua3fK3Puj70TxMcR0d3dfyt6JAFV6a0/ihwwZ76iQA4OOwwq7BsBy+Iu8s=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr2796476ooa.1.1603389594117;
 Thu, 22 Oct 2020 10:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher> <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher> <20201022122949.GW2628@hirez.programming.kicks-ass.net>
 <20201022145250.GK32041@suse.de> <6606e5f4-3f66-5844-da02-5b11e1464be6@canonical.com>
 <20201022151200.GC92942@lorien.usersys.redhat.com> <20201022163509.GM32041@suse.de>
In-Reply-To: <20201022163509.GM32041@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Oct 2020 19:59:43 +0200
Message-ID: <CAJZ5v0he839sJNh0xjmvLqzuE7X27PgJKxtSV8giZh004E7pXw@mail.gmail.com>
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
To:     Mel Gorman <mgorman@suse.de>
Cc:     Phil Auld <pauld@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Thu, Oct 22, 2020 at 6:35 PM Mel Gorman <mgorman@suse.de> wrote:
>
> On Thu, Oct 22, 2020 at 11:12:00AM -0400, Phil Auld wrote:
> > > > AFAIK, not quite (added Giovanni as he has been paying more attention).
> > > > Schedutil has improved since it was merged but not to the extent where
> > > > it is a drop-in replacement. The standard it needs to meet is that
> > > > it is at least equivalent to powersave (in intel_pstate language)
> > > > or ondemand (acpi_cpufreq) and within a reasonable percentage of the
> > > > performance governor. Defaulting to performance is a) giving up and b)
> > > > the performance governor is not a universal win. There are some questions
> > > > currently on whether schedutil is good enough when HWP is not available.
> > > > There was some evidence (I don't have the data, Giovanni was looking into
> > > > it) that HWP was a requirement to make schedutil work well. That is a
> > > > hazard in itself because someone could test on the latest gen Intel CPU
> > > > and conclude everything is fine and miss that Intel-specific technology
> > > > is needed to make it work well while throwing everyone else under a bus.
> > > > Giovanni knows a lot more than I do about this, I could be wrong or
> > > > forgetting things.
> > > >
> > > > For distros, switching to schedutil by default would be nice because
> > > > frequency selection state would follow the task instead of being per-cpu
> > > > and we could stop worrying about different HWP implementations but it's
> > > > not at the point where the switch is advisable. I would expect hard data
> > > > before switching the default and still would strongly advise having a
> > > > period of time where we can fall back when someone inevitably finds a
> > > > new corner case or exception.
> > >
> > > ..and it would be really useful for distros to know when the hard data
> > > is available so that they can make an informed decision when to move to
> > > schedutil.
> > >
> >
> > I think distros are on the hook to generate that hard data themselves
> > with which to make such a decision.  I don't expect it to be done by
> > someone else.
> >
>
> Yep, distros are on the hook. When I said "I would expect hard data",
> it was in the knowledge that for openSUSE/SLE, we (as in SUSE) would be
> generating said data and making a call based on it. I'd be surprised if
> Phil was not thinking along the same lines.
>
> > > > For reference, SLUB had the same problem for years. It was switched
> > > > on by default in the kernel config but it was a long time before
> > > > SLUB was generally equivalent to SLAB in terms of performance. Block
> > > > multiqueue also had vaguely similar issues before the default changes
> > > > and a period of time before it was removed removed (example whinging mail
> > > > https://lore.kernel.org/lkml/20170803085115.r2jfz2lofy5spfdb@techsingularity.net/)
> > > > It's schedutil's turn :P
> > > >
> > >
> >
> > Agreed. I'd like the option to switch back if we make the default change.
> > It's on the table and I'd like to be able to go that way.
> >
>
> Yep. It sounds chicken, but it's a useful safety net and a reasonable
> way to deprecate a feature. It's also useful for bug creation -- User X
> running whatever found that schedutil is worse than the old governor and
> had to temporarily switch back. Repeat until complaining stops and then
> tear out the old stuff.
>
> When/if there is a patch setting schedutil as the default, cc suitable
> distro people (Giovanni and myself for openSUSE).

So for the record, Giovanni was on the CC list of the "cpufreq:
intel_pstate: Use passive mode by default without HWP" patch that this
discussion resulted from (and which kind of belongs to the above
category).

> Other distros assuming they're watching can nominate their own victim.

But no other victims had been nominated at that time.
