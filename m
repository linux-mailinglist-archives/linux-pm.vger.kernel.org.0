Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5062F2962AC
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 18:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901776AbgJVQ3s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 12:29:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2901774AbgJVQ3s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 12:29:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D823AAC48;
        Thu, 22 Oct 2020 16:29:46 +0000 (UTC)
Date:   Thu, 22 Oct 2020 17:29:43 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Message-ID: <20201022162943.GL32041@suse.de>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher>
 <20201022122949.GW2628@hirez.programming.kicks-ass.net>
 <20201022145250.GK32041@suse.de>
 <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 05:25:14PM +0200, Peter Zijlstra wrote:
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
> 

I know Intel ran a lot of tests, no question about it and no fingers are
being pointed. I know I've had enough bugs patches tested with a battery
of tests on various machines and still ended up with bug reports :)

> > There was some evidence (I don't have the data, Giovanni was looking into
> > it) that HWP was a requirement to make schedutil work well.
> 
> That seems to be the question; Rafael just said the opposite.
> 
> > For distros, switching to schedutil by default would be nice because
> > frequency selection state would follow the task instead of being per-cpu
> > and we could stop worrying about different HWP implementations but it's
> 
> s/HWP/cpufreq-governors/ ? But yes.
> 

I've seen cases where HWP had variable behaviour between CPU
generations. It was hard to quantify and/or figure out because HWP is a
black box.

> > not at the point where the switch is advisable. I would expect hard data
> > before switching the default and still would strongly advise having a
> > period of time where we can fall back when someone inevitably finds a
> > new corner case or exception.
> 
> Which is why I advocated to make it 'difficult' to use the old ones and
> only later remove them.
> 

That's fair.

-- 
Mel Gorman
SUSE Labs
