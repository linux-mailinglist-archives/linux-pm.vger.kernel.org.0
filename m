Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5246296611
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 22:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901257AbgJVUjc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 16:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S371724AbgJVUjb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 16:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603399170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Es6PtacViKqb4jQqg5gw1aMx5VJx45xwSoGJuNjLWg=;
        b=Ior1q17y+hc6lmWPcJ1XGsLp6cjaaxLLTF8vFy7pgXjdtk2NcFKvsOvS8sTnkIolhU6IzB
        cVFjaL6ZwVTBABOob3nTiU50XwTDgG0sJYl+Iufmcc4Ikxsap6HyQN7frjmQEoL4/UAGSi
        iEOjELQ12OV3RWrtvqs2dFFUVeCpWuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-ryZ9fepCPgylb0QODfouhA-1; Thu, 22 Oct 2020 16:39:27 -0400
X-MC-Unique: ryZ9fepCPgylb0QODfouhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A6FA1006CA9;
        Thu, 22 Oct 2020 20:39:24 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-70.phx2.redhat.com [10.3.113.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24C9660BFA;
        Thu, 22 Oct 2020 20:39:15 +0000 (UTC)
Date:   Thu, 22 Oct 2020 16:39:13 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
Message-ID: <20201022203913.GJ92942@lorien.usersys.redhat.com>
References: <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher>
 <20201022122949.GW2628@hirez.programming.kicks-ass.net>
 <20201022145250.GK32041@suse.de>
 <6606e5f4-3f66-5844-da02-5b11e1464be6@canonical.com>
 <20201022151200.GC92942@lorien.usersys.redhat.com>
 <20201022163509.GM32041@suse.de>
 <CAJZ5v0he839sJNh0xjmvLqzuE7X27PgJKxtSV8giZh004E7pXw@mail.gmail.com>
 <20201022203255.GN32041@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022203255.GN32041@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 09:32:55PM +0100 Mel Gorman wrote:
> On Thu, Oct 22, 2020 at 07:59:43PM +0200, Rafael J. Wysocki wrote:
> > > > Agreed. I'd like the option to switch back if we make the default change.
> > > > It's on the table and I'd like to be able to go that way.
> > > >
> > >
> > > Yep. It sounds chicken, but it's a useful safety net and a reasonable
> > > way to deprecate a feature. It's also useful for bug creation -- User X
> > > running whatever found that schedutil is worse than the old governor and
> > > had to temporarily switch back. Repeat until complaining stops and then
> > > tear out the old stuff.
> > >
> > > When/if there is a patch setting schedutil as the default, cc suitable
> > > distro people (Giovanni and myself for openSUSE).
> > 
> > So for the record, Giovanni was on the CC list of the "cpufreq:
> > intel_pstate: Use passive mode by default without HWP" patch that this
> > discussion resulted from (and which kind of belongs to the above
> > category).
> > 
> 
> Oh I know, I did not mean to suggest that you did not. He made people
> aware that this was going to be coming down the line and has been looking
> into the "what if schedutil was the default" question.  AFAIK, it's still
> a work-in-progress and I don't know all the specifics but he knows more
> than I do on the topic. I only know enough that if we flipped the switch
> tomorrow that we could be plagued with google searches suggesting it be
> turned off again just like there is still broken advice out there about
> disabling intel_pstate for usually the wrong reasons.
> 
> The passive patch was a clear flag that the intent is that schedutil will
> be the default at some unknown point in the future. That point is now a
> bit closer and this thread could have encouraged a premature change of
> the default resulting in unfair finger pointing at one company's test
> team. If at least two distos check it out and it still goes wrong, at
> least there will be shared blame :/
> 
> > > Other distros assuming they're watching can nominate their own victim.
> > 
> > But no other victims had been nominated at that time.
> 
> We have one, possibly two if Phil agrees. That's better than zero or
> unfairly placing the full responsibility on the Intel guys that have been
> testing it out.
>

Yes. I agree and we (RHEL) are planning to test this soon. I'll try to get
to it.  You can certainly CC me, please, athough I also try to watch for this
sort of thing on list. 


Cheers,
Phil

> -- 
> Mel Gorman
> SUSE Labs
> 

-- 

