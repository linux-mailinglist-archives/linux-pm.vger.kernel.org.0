Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491C4295E39
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898036AbgJVMTd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 08:19:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49940 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898032AbgJVMTc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 08:19:32 -0400
Received: from 89-64-87-167.dynamic.chello.pl (89.64.87.167) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 61321c92bea3245f; Thu, 22 Oct 2020 14:19:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
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
Date:   Thu, 22 Oct 2020 14:19:29 +0200
Message-ID: <1790766.jaFeG3T87Z@kreacher>
In-Reply-To: <20201022120213.GG2611@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <34115486.YmRjPRKJaA@kreacher> <20201022120213.GG2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[CC linux-pm and Len]

On Thursday, October 22, 2020 2:02:13 PM CEST Peter Zijlstra wrote:
> On Thu, Oct 22, 2020 at 01:45:25PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, October 22, 2020 12:47:03 PM CEST Viresh Kumar wrote:
> > > On 22-10-20, 09:11, Peter Zijlstra wrote:
> > > > Well, but we need to do something to force people onto schedutil,
> > > > otherwise we'll get more crap like this thread.
> > > > 
> > > > Can we take the choice away? Only let Kconfig select which governors are
> > > > available and then set the default ourselves? I mean, the end goal being
> > > > to not have selectable governors at all, this seems like a good step
> > > > anyway.
> > > 
> > > Just to clarify and complete the point a bit here, the users can still
> > > pass the default governor from cmdline using
> > > cpufreq.default_governor=, which will take precedence over the one the
> > > below code is playing with. And later once the kernel is up, they can
> > > still choose a different governor from userspace.
> > 
> > Right.
> > 
> > Also some people simply set "performance" as the default governor and then
> > don't touch cpufreq otherwise (the idea is to get everything to the max
> > freq right away and stay in that mode forever).  This still needs to be
> > possible IMO.
> 
> Performance/powersave make sense to keep.
> 
> However I do want to retire ondemand, conservative and also very much
> intel_pstate/active mode.

I agree in general, but IMO it would not be prudent to do that without making
schedutil provide the same level of performance in all of the relevant use
cases.

> I also have very little sympathy for userspace.

That I completely agree with.

> We should start by making it hard to use them and eventually just delete
> them outright.

Right, but see above: IMO step 0 should be to ensure that schedutil is a viable
replacement for all users.



