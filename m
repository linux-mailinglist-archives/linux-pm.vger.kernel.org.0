Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4261625B288
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 19:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgIBRBI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 13:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgIBRBG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 13:01:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71B9C20FC3;
        Wed,  2 Sep 2020 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599066065;
        bh=FQd94FvZ+0JdxlW8IVu9M2KpS2tWUoV7vHlAMnmzdWY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wlYKdcu0obZwlYv+H6EbdZJKE5vxKFLmOpmp/5RLKAuBOQ7qKJShXu9cEB9VCf1SA
         feB3YbI33Ooa5MwRF+jRUAgGC4NCV2ogRP+pAoPJQDnXq4JgRfgGs3RxIcNWEEPThl
         R4aukeTc3M/xQi8/SRIwEWVy2W8Y7+yztClKxxrY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 489FD352157A; Wed,  2 Sep 2020 10:01:05 -0700 (PDT)
Date:   Wed, 2 Sep 2020 10:01:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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
        peterz@infrdead.org, Lina Iyer <ilina@codeaurora.org>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
Message-ID: <20200902170105.GJ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72>
 <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <20200901150047.GB29330@paulmck-ThinkPad-P72>
 <CAPDyKFptZK-OqnAuJYGnpfPbZ1qw-iSd4t5SuE7SmWic=ms48Q@mail.gmail.com>
 <20200902135202.GG29330@paulmck-ThinkPad-P72>
 <CAPDyKFqAAjCDSSJ56V+cdy6t0F01sXj_AkNxdXRtAKegf8DDsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqAAjCDSSJ56V+cdy6t0F01sXj_AkNxdXRtAKegf8DDsQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 02, 2020 at 06:07:05PM +0200, Ulf Hansson wrote:
> On Wed, 2 Sep 2020 at 15:52, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Sep 02, 2020 at 08:49:11AM +0200, Ulf Hansson wrote:
> > > On Tue, 1 Sep 2020 at 17:00, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > [ . . . ]
> >
> > > > Here is the list, though it is early in the morning here:
> > > >
> > > > 1.      RCU_NONIDLE().
> > > >
> > > > 2.      Peter's patch, if it turns out to hoist your code out of what
> > > >         RCU considers to be the idle loop.
> > > >
> > > > 3.      If the problem is trace events, use the _rcuidle() variant of the
> > > >         trace event.  Instead of trace_blah(), use trace_blah_rcuidle().
> > > >
> > > > 4.      Switch from RCU (as in rcu_read_lock()) to SRCU (as in
> > > >         srcu_read_lock()).
> > > >
> > > > 5.      Take Peter's patch a step further, moving the rcu_idle_enter()
> > > >         and rcu_idle_exit() calls as needed.  But please keep in mind
> > > >         that these two functions require that irqs be disabled by their
> > > >         callers.
> > > >
> > > > 6.      If RCU_NONIDLE() in inconvenient due to early exits and such,
> > > >         you could use the rcu_irq_enter_irqson() and rcu_irq_exit_irqson()
> > > >         functions that it calls.
> > > >
> > > > Do any of those help?
> > >
> > > Yes, they will, in one way or the other. Thanks for providing me with
> > > all the available options.
> > >
> > > BTW, I still don't get what good rcu_idle_enter|exit() does, but I am
> > > assuming those need to be called at some point before the CPU goes to
> > > sleep.
> >
> > These functions allow RCU to leave idle CPUs undisturbed.  If they
> > were not invoked, RCU would periodically IPI idle CPUs to verify that
> > there were no RCU readers running on them.  This would be quite bad for
> > battery lifetime, among other things.  So the call to rcu_idle_enter()
> > tells RCU that it may safely completely ignore this CPU until its next
> > call to rcu_idle_exit().
> 
> Alright, thanks for explaining this, much appreciated.
> 
> So in one way, we would also like to call rcu_idle_enter(), as soon as
> we know there is no need for the RCU to be active. To prevent
> unnecessary IPIs I mean. :-)

Well, the IPIs don't happen until the better part of a second into
the grace period.  So delaying an rcu_idle_enter() a few microseconds,
as Peter Zijlstra is proposing, is absolutely no problem whatsoever.
And once the rcu_idle_enter() happens, the RCU grace-period kthread's next
scan of the CPUs will see that this CPU needs to be ignored, so no more
IPIs for it until it does the next rcu_idle_exit(), rcu_irq_enter(),
or any of a number of other things that cause RCU to once again pay
attention to that CPU.

							Thanx, Paul
