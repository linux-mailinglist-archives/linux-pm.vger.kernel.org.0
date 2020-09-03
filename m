Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE2225C458
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgICPJd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgICPIf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 11:08:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A03C061244;
        Thu,  3 Sep 2020 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zANyIwCFwmI0089viO54wIY1EtKNXS5UU2MUznvRctw=; b=Xt19bCiqDWoyV9PpNg6GGpyH9f
        WCsHq7tvnfmtYZYDBmMjiLlWj113OpmQwZ5tdmKKR0Vv57P2Xm+elE3a4ZPGVSxz3x6zG2N4wiZgy
        ZdVKnorpy+Y7Inbiu/ScjqXmhyw6c2YNj6QOxpfBW3L2I2YpZBpdJiTAU8wPDakdFDLKUBvTgcTpm
        gix2VPcZd55hc0k06exyNfLnbOkmvVv7HXNEWxIF4kx45nYAKyVDlCULOXt66V9lRnInjb5w6OyAW
        SdLWfaEsXzGPzJYBv146rzRuSKwgpOvJW2IBElhWe5MMn4RzfGOMTnpKjfkF9FqI1RXKYenzXPX5U
        FPY3m3EQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDqqb-0007tU-VS; Thu, 03 Sep 2020 15:08:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 372B6300F7A;
        Thu,  3 Sep 2020 17:08:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A5F92BBB68AD; Thu,  3 Sep 2020 17:08:20 +0200 (CEST)
Date:   Thu, 3 Sep 2020 17:08:19 +0200
From:   peterz@infradead.org
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, rcu@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH] cpu_pm: Remove RCU abuse
Message-ID: <20200903150819.GE1362448@hirez.programming.kicks-ass.net>
References: <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
 <20200901154417.GD20303@codeaurora.org>
 <20200901155014.GF2674@hirez.programming.kicks-ass.net>
 <20200901161340.GC29330@paulmck-ThinkPad-P72>
 <20200901174216.GJ29142@worktop.programming.kicks-ass.net>
 <CAPDyKFqPh7bg16AsitGv2QQHgwOPnWx9DiPPCMuD1EGA5TFFdg@mail.gmail.com>
 <20200902121355.GE1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFrGj+8hOXi7sWxWNv2QP0=mx9pFKLG0JM-L5VNKUPDgeA@mail.gmail.com>
 <20200903135347.GC1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFqduU65YmhBZ8PwDRTZDLtWhWX087LBy0bx56go+ra4Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqduU65YmhBZ8PwDRTZDLtWhWX087LBy0bx56go+ra4Ow@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 03, 2020 at 04:36:35PM +0200, Ulf Hansson wrote:
> On Thu, 3 Sep 2020 at 15:53, <peterz@infradead.org> wrote:
> >  static int cpu_pm_notify(enum cpu_pm_event event)
> >  {
> >         int ret;
> >
> > +       lockdep_assert_irqs_disabled();
> 
> Nitpick, maybe the lockdep should be moved to a separate patch.

Well, the unregister relies on IRQs being disabled here, so I figured
asserting this was a good thing ;-)

Starting the audit below, this might not in fact be true, which then
invalidates the unregister implementation. In particular the notifier in
arch/arm/kernel/hw_breakpoint.c seems to unconditionally enable IRQs.

> > +       ret = raw_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
> 
> Converting to raw_notifiers seems reasonable - if we need to avoid the
> RCU usage.
> 
> My point is, I wonder about if the notifier callbacks themselves are
> safe from RCU usage. For example, I would not be surprised if tracing
> is happening behind them.

A bunch of them seem to call into the clk domain stuff, and I think
there's tracepoints in that.

> Moreover, I am not sure that we really need to prevent and limit
> tracing from happening. Instead we could push rcu_idle_enter|exit()
> further down to the arch specific code in the cpuidle drivers, as you
> kind of all proposed earlier.

Well, at some point the CPU is in a really dodgy state, ISTR there being
ARM platforms where you have to manually leave the cache coherency
fabric and all sorts of insanity. There should be a definite cut-off on
tracing before that.

Also, what is the point of all this clock and power domain callbacks, if
not to put the CPU into an extremely low power state, surely you want to
limit the amount of code that's ran when the CPU is in such a state.

> In this way, we can step by step, move to a new "version" of
> cpu_pm_enter() that doesn't have to deal with rcu_irq_enter_irqson(),
> because RCU hasn't been pushed to idle yet.

That should be easy enough to audit. The thing is that mainline is now
generating (debug) splats, and some people are upset with this.

If you're ok with ARM not being lockdep clean while this is being
reworked I'm perfectly fine with that.

(There used to be a separate CONFIG for RCU-lockdep, but that seems to
have been removed)
