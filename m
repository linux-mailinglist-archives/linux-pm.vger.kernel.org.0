Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8243029617D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 17:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368446AbgJVPMT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 11:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S368357AbgJVPMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 11:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603379536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDlJvVtWMlPWw+lQx90tQ7kEfUNHvkpfYYWbomFbvhA=;
        b=QacrUXZGTFkmWMLriwhtv9Xp3reNIXmA+Mip6T76HeNKWBRbZfG+SGSKdSp6nrNda1wAkk
        O3XDu4ag9sqoxBgaXo1dtn70S20a5IvDLdGfJDEDit+Yk88ODhMbcWkDz5btxz0dOU0EYN
        /D2eyG0Hf158yRdDwRGW2Y4IsV7awHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-nYS15yLeNbO5z0Blf0cGTA-1; Thu, 22 Oct 2020 11:12:13 -0400
X-MC-Unique: nYS15yLeNbO5z0Blf0cGTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 108C41882FA1;
        Thu, 22 Oct 2020 15:12:11 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-70.phx2.redhat.com [10.3.113.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4253C55776;
        Thu, 22 Oct 2020 15:12:02 +0000 (UTC)
Date:   Thu, 22 Oct 2020 11:12:00 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mel Gorman <mgorman@suse.de>,
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
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
Message-ID: <20201022151200.GC92942@lorien.usersys.redhat.com>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher>
 <20201022122949.GW2628@hirez.programming.kicks-ass.net>
 <20201022145250.GK32041@suse.de>
 <6606e5f4-3f66-5844-da02-5b11e1464be6@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6606e5f4-3f66-5844-da02-5b11e1464be6@canonical.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 03:58:13PM +0100 Colin Ian King wrote:
> On 22/10/2020 15:52, Mel Gorman wrote:
> > On Thu, Oct 22, 2020 at 02:29:49PM +0200, Peter Zijlstra wrote:
> >> On Thu, Oct 22, 2020 at 02:19:29PM +0200, Rafael J. Wysocki wrote:
> >>>> However I do want to retire ondemand, conservative and also very much
> >>>> intel_pstate/active mode.
> >>>
> >>> I agree in general, but IMO it would not be prudent to do that without making
> >>> schedutil provide the same level of performance in all of the relevant use
> >>> cases.
> >>
> >> Agreed; I though to have understood we were there already.
> > 
> > AFAIK, not quite (added Giovanni as he has been paying more attention).
> > Schedutil has improved since it was merged but not to the extent where
> > it is a drop-in replacement. The standard it needs to meet is that
> > it is at least equivalent to powersave (in intel_pstate language)
> > or ondemand (acpi_cpufreq) and within a reasonable percentage of the
> > performance governor. Defaulting to performance is a) giving up and b)
> > the performance governor is not a universal win. There are some questions
> > currently on whether schedutil is good enough when HWP is not available.
> > There was some evidence (I don't have the data, Giovanni was looking into
> > it) that HWP was a requirement to make schedutil work well. That is a
> > hazard in itself because someone could test on the latest gen Intel CPU
> > and conclude everything is fine and miss that Intel-specific technology
> > is needed to make it work well while throwing everyone else under a bus.
> > Giovanni knows a lot more than I do about this, I could be wrong or
> > forgetting things.
> > 
> > For distros, switching to schedutil by default would be nice because
> > frequency selection state would follow the task instead of being per-cpu
> > and we could stop worrying about different HWP implementations but it's
> > not at the point where the switch is advisable. I would expect hard data
> > before switching the default and still would strongly advise having a
> > period of time where we can fall back when someone inevitably finds a
> > new corner case or exception.
> 
> ..and it would be really useful for distros to know when the hard data
> is available so that they can make an informed decision when to move to
> schedutil.
>

I think distros are on the hook to generate that hard data themselves
with which to make such a decision.  I don't expect it to be done by
someone else. 

> > 
> > For reference, SLUB had the same problem for years. It was switched
> > on by default in the kernel config but it was a long time before
> > SLUB was generally equivalent to SLAB in terms of performance. Block
> > multiqueue also had vaguely similar issues before the default changes
> > and a period of time before it was removed removed (example whinging mail
> > https://lore.kernel.org/lkml/20170803085115.r2jfz2lofy5spfdb@techsingularity.net/)
> > It's schedutil's turn :P
> > 
> 

Agreed. I'd like the option to switch back if we make the default change.
It's on the table and I'd like to be able to go that way. 

Cheers,
Phil

-- 

