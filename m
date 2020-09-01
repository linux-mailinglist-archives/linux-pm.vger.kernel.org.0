Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98CE259202
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgIAPAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 11:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgIAPAt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 11:00:49 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22BC0206CD;
        Tue,  1 Sep 2020 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598972448;
        bh=JzIUQF3u39f15CEM94wBRei78s+vKxwzAnubKQpennk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lcD6FQqTyeceUmYzSAoYuNyO2bJ/pq+O+W8qI6LcJG6tu2LpK3eCQGR0qaqLZiSwX
         kgiC8bkrHgcpsQAmPD/FLZnNtSmpsllWjOcAV/H1vrDFb4G1v13zbv5BnuRQSxmZpD
         pcJtC+qgulftC9W1EXSC3ZipTwJilOS4/vW20dlE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DD78035226A5; Tue,  1 Sep 2020 08:00:47 -0700 (PDT)
Date:   Tue, 1 Sep 2020 08:00:47 -0700
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
Message-ID: <20200901150047.GB29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72>
 <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 08:46:54AM +0200, Ulf Hansson wrote:
> + Saravanna, Rafael, Lina
> 
> On Mon, 31 Aug 2020 at 21:44, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Aug 31, 2020 at 12:02:31PM +0530, Naresh Kamboju wrote:
> > > While booting linux mainline kernel on arm64 db410c this kernel warning
> > > noticed.
> > >
> > > metadata:
> > >   git branch: master
> > >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >   git commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
> > >   git describe: v5.9-rc3
> > >   make_kernelversion: 5.9.0-rc3
> > >   kernel-config:
> > > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-mainline/2965/config
> > >
> > > Boot log,
> > >
> > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd030]
> > > [    0.000000] Linux version 5.9.0-rc3 (oe-user@oe-host)
> > > (aarch64-linaro-linux-gcc (GCC) 7.3.0, GNU ld (GNU Binutils)
> > > 2.30.0.20180208) #1 SMP PREEMPT Mon Aug 31 00:23:15 UTC 2020
> > > [    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
> > > <>
> > > [    5.299090] sdhci: Secure Digital Host Controller Interface driver
> > > [    5.299140] sdhci: Copyright(c) Pierre Ossman
> > > [    5.304313]
> > > [    5.307771] Synopsys Designware Multimedia Card Interface Driver
> > > [    5.308588] =============================
> > > [    5.308593] WARNING: suspicious RCU usage
> > > [    5.316628] sdhci-pltfm: SDHCI platform and OF driver helper
> > > [    5.320052] 5.9.0-rc3 #1 Not tainted
> > > [    5.320057] -----------------------------
> > > [    5.320063] /usr/src/kernel/include/trace/events/lock.h:37
> > > suspicious rcu_dereference_check() usage!
> > > [    5.320068]
> > > [    5.320068] other info that might help us debug this:
> > > [    5.320068]
> > > [    5.320074]
> > > [    5.320074] rcu_scheduler_active = 2, debug_locks = 1
> > > [    5.320078] RCU used illegally from extended quiescent state!
> > > [    5.320084] no locks held by swapper/0/0.
> > > [    5.320089]
> > > [    5.320089] stack backtrace:
> > > [    5.320098] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
> > > [    5.346354] sdhci_msm 7864900.sdhci: Got CD GPIO
> > > [    5.346446] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > > [    5.346452] Call trace:
> > > [    5.346463]  dump_backtrace+0x0/0x1f8
> > > [    5.346471]  show_stack+0x2c/0x38
> > > [    5.346480]  dump_stack+0xec/0x15c
> > > [    5.346490]  lockdep_rcu_suspicious+0xd4/0xf8
> > > [    5.346499]  lock_acquire+0x3d0/0x440
> > > [    5.346510]  _raw_spin_lock_irqsave+0x80/0xb0
> > > [    5.413118]  __pm_runtime_suspend+0x34/0x1d0
> > > [    5.417457]  psci_enter_domain_idle_state+0x4c/0xb0
> > > [    5.421795]  cpuidle_enter_state+0xc8/0x610
> > > [    5.426392]  cpuidle_enter+0x3c/0x50
> > > [    5.430561]  call_cpuidle+0x44/0x80
> > > [    5.434378]  do_idle+0x240/0x2a0
> >
> > RCU ignores CPUs in the idle loop, which means that you cannot use
> > rcu_read_lock() from the idle loop without use of something like
> > RCU_NONIDLE().  If this is due to event tracing, you should use the
> > _rcuidle() variant of the event trace statement.
> 
> In the runtime suspend path, the runtime PM core calls
> device_links_read_lock() - if the device in question has any links to
> suppliers (to allow them to be suspended too).
> 
> device_links_read_lock() calls srcu_read_lock().

Except that it is perfectly legal to invoke srcu_read_lock() from the
idle loop.  The problem is instead rcu_read_lock() and similar.

> It turns out that the device in question (the CPU device that is
> attached to genpd) didn't have any links before - but that seems to
> have changed, due to the work done by Saravana (links become created
> on a per resource basis, parsed from DT during boot).
> 
> > Note also that Peter Zijlstra (CCed) is working to shrink the portion
> > of the idle loop that RCU ignores.  Not sure that it covers your
> > case, but it is worth checking.
> 
> Thanks for letting me know. Let's see what Peter thinks about this then.
> 
> Apologize for my ignorance, but from a cpuidle point of view, what
> does it mean using RCU_NONIDLE()? I guess we should avoid RCU_NONIDLE
> on bigger code paths?

It means that as far as RCU (and only RCU) is concerned there is an
exit from idle state for just long enough to execute RCU_NONIDLE()'s
argument.  This involves an atomic operation on both entry to and exit
from RCU_NONIDLE(), which in most cases won't be noticeable.  But in some
cases you might (for example) want to enclose a loop in RCU_NONIDLE()
rather than doing RCU_NONIDLE() on each pass through the loop.

> I could add RCU_NONIDLE for the calls to pm_runtime_put_sync_suspend()
> and pm_runtime_get_sync() in psci_enter_domain_idle_state(). Perhaps
> that's the easiest approach, at least to start with.
> 
> Or do you have any other ideas?

Here is the list, though it is early in the morning here:

1.	RCU_NONIDLE().

2.	Peter's patch, if it turns out to hoist your code out of what
	RCU considers to be the idle loop.

3.	If the problem is trace events, use the _rcuidle() variant of the
	trace event.  Instead of trace_blah(), use trace_blah_rcuidle().

4.	Switch from RCU (as in rcu_read_lock()) to SRCU (as in
	srcu_read_lock()).

5.	Take Peter's patch a step further, moving the rcu_idle_enter()
	and rcu_idle_exit() calls as needed.  But please keep in mind
	that these two functions require that irqs be disabled by their
	callers.

6.	If RCU_NONIDLE() in inconvenient due to early exits and such,
	you could use the rcu_irq_enter_irqson() and rcu_irq_exit_irqson()
	functions that it calls.

Do any of those help?

							Thanx, Paul
