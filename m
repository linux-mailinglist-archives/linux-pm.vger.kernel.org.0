Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93E25A5C6
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 08:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIBGtz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIBGtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 02:49:49 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36447C061246
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 23:49:49 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e14so2004590vsa.9
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJdPXnIz2xIWHYrNu+/mihG3qKNrHnPr5aFl3WHMv10=;
        b=DH/HQXxy9pUzTsk+32nhzeQi4lCS6j4pbWuCnV+ayRhusVyJE+GfGavXVg3FzjLLMC
         LK8OEBTw0weBcfnbI/aDRKUU8aoucy4lRc0ONubyzuLNR6ESaRQHJOV8kzKIOVrmsDhx
         6sKNDVNPazQAYMQ8wDo9Wj710fZ3dk88e7r6+SY+TrooZOJgOc2C+e9DCdb5gQukJaW0
         RdR8ylrolO6R0EguiY5+55r0YzTCwBYMAaA4Ppj4bW9q2Na5GTgd7iYIJmUaS2n/yESH
         K5HJquYhKKBPyu0ab/hNPzVNSoSK28EBgg+kpF7M4Fm+DIDbuPkOLQenP+FdV1AcEj1S
         e3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJdPXnIz2xIWHYrNu+/mihG3qKNrHnPr5aFl3WHMv10=;
        b=mHe+XOR2fiShuvcvjrISD6FG3kZsUjU/CJ0CyaggTKlsKKc4tFtLOk5cMY8ZYyxqgr
         SwKXUZPCvrFOTp0hnMuAXW1BPyVjIipHLDYEvlPIjOveGvb4OBWeYtJbYWGkv4PCbpMm
         pw1eWGCsq3CNlWJP4kUoAwj5hdTqX2qAqc8aNLFPjKqfasAs/3fpxeAmNUwyTZfsyAmy
         3nKRmM1UYOp1/RYdziFPNckYNb3X2GW/N3wZx+96f/2fPyXQSrPZuT0L2UihF5faNKVo
         yzr5XaS2fEllsBfEM98+negsfbbE8e4ahdiv4EL+nCVqNN8PA7dRs8i+vTbU9XNJjHDe
         1ASA==
X-Gm-Message-State: AOAM531tJEFbzGXW7wfZd0TAiqsFpP6zRAMdubW0gAe8fn6fe+8Y5GdG
        inWPpk41mwVj90tSDOZG2Y1BsMcXKCnHA9uqYpf3rg==
X-Google-Smtp-Source: ABdhPJzUS+wRt0IpiVg53IZAX+dmleKyjNHbOJx7Kll4a+k/osLJVVjBMrHaFOMzv26GWMEY8wxkUT2x0u85LLknh70=
X-Received: by 2002:a05:6102:5a:: with SMTP id k26mr4733338vsp.52.1599029388083;
 Tue, 01 Sep 2020 23:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72> <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <20200901150047.GB29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200901150047.GB29330@paulmck-ThinkPad-P72>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 08:49:11 +0200
Message-ID: <CAPDyKFptZK-OqnAuJYGnpfPbZ1qw-iSd4t5SuE7SmWic=ms48Q@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
To:     paulmck@kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 1 Sep 2020 at 17:00, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Sep 01, 2020 at 08:46:54AM +0200, Ulf Hansson wrote:
> > + Saravanna, Rafael, Lina
> >
> > On Mon, 31 Aug 2020 at 21:44, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Mon, Aug 31, 2020 at 12:02:31PM +0530, Naresh Kamboju wrote:
> > > > While booting linux mainline kernel on arm64 db410c this kernel warning
> > > > noticed.
> > > >
> > > > metadata:
> > > >   git branch: master
> > > >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > >   git commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
> > > >   git describe: v5.9-rc3
> > > >   make_kernelversion: 5.9.0-rc3
> > > >   kernel-config:
> > > > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-mainline/2965/config
> > > >
> > > > Boot log,
> > > >
> > > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd030]
> > > > [    0.000000] Linux version 5.9.0-rc3 (oe-user@oe-host)
> > > > (aarch64-linaro-linux-gcc (GCC) 7.3.0, GNU ld (GNU Binutils)
> > > > 2.30.0.20180208) #1 SMP PREEMPT Mon Aug 31 00:23:15 UTC 2020
> > > > [    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
> > > > <>
> > > > [    5.299090] sdhci: Secure Digital Host Controller Interface driver
> > > > [    5.299140] sdhci: Copyright(c) Pierre Ossman
> > > > [    5.304313]
> > > > [    5.307771] Synopsys Designware Multimedia Card Interface Driver
> > > > [    5.308588] =============================
> > > > [    5.308593] WARNING: suspicious RCU usage
> > > > [    5.316628] sdhci-pltfm: SDHCI platform and OF driver helper
> > > > [    5.320052] 5.9.0-rc3 #1 Not tainted
> > > > [    5.320057] -----------------------------
> > > > [    5.320063] /usr/src/kernel/include/trace/events/lock.h:37
> > > > suspicious rcu_dereference_check() usage!
> > > > [    5.320068]
> > > > [    5.320068] other info that might help us debug this:
> > > > [    5.320068]
> > > > [    5.320074]
> > > > [    5.320074] rcu_scheduler_active = 2, debug_locks = 1
> > > > [    5.320078] RCU used illegally from extended quiescent state!
> > > > [    5.320084] no locks held by swapper/0/0.
> > > > [    5.320089]
> > > > [    5.320089] stack backtrace:
> > > > [    5.320098] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
> > > > [    5.346354] sdhci_msm 7864900.sdhci: Got CD GPIO
> > > > [    5.346446] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > > > [    5.346452] Call trace:
> > > > [    5.346463]  dump_backtrace+0x0/0x1f8
> > > > [    5.346471]  show_stack+0x2c/0x38
> > > > [    5.346480]  dump_stack+0xec/0x15c
> > > > [    5.346490]  lockdep_rcu_suspicious+0xd4/0xf8
> > > > [    5.346499]  lock_acquire+0x3d0/0x440
> > > > [    5.346510]  _raw_spin_lock_irqsave+0x80/0xb0
> > > > [    5.413118]  __pm_runtime_suspend+0x34/0x1d0
> > > > [    5.417457]  psci_enter_domain_idle_state+0x4c/0xb0
> > > > [    5.421795]  cpuidle_enter_state+0xc8/0x610
> > > > [    5.426392]  cpuidle_enter+0x3c/0x50
> > > > [    5.430561]  call_cpuidle+0x44/0x80
> > > > [    5.434378]  do_idle+0x240/0x2a0
> > >
> > > RCU ignores CPUs in the idle loop, which means that you cannot use
> > > rcu_read_lock() from the idle loop without use of something like
> > > RCU_NONIDLE().  If this is due to event tracing, you should use the
> > > _rcuidle() variant of the event trace statement.
> >
> > In the runtime suspend path, the runtime PM core calls
> > device_links_read_lock() - if the device in question has any links to
> > suppliers (to allow them to be suspended too).
> >
> > device_links_read_lock() calls srcu_read_lock().
>
> Except that it is perfectly legal to invoke srcu_read_lock() from the
> idle loop.  The problem is instead rcu_read_lock() and similar.

Hmm. Sounds like more debugging is needed then, to narrow down the problem.

>
> > It turns out that the device in question (the CPU device that is
> > attached to genpd) didn't have any links before - but that seems to
> > have changed, due to the work done by Saravana (links become created
> > on a per resource basis, parsed from DT during boot).
> >
> > > Note also that Peter Zijlstra (CCed) is working to shrink the portion
> > > of the idle loop that RCU ignores.  Not sure that it covers your
> > > case, but it is worth checking.
> >
> > Thanks for letting me know. Let's see what Peter thinks about this then.
> >
> > Apologize for my ignorance, but from a cpuidle point of view, what
> > does it mean using RCU_NONIDLE()? I guess we should avoid RCU_NONIDLE
> > on bigger code paths?
>
> It means that as far as RCU (and only RCU) is concerned there is an
> exit from idle state for just long enough to execute RCU_NONIDLE()'s
> argument.  This involves an atomic operation on both entry to and exit
> from RCU_NONIDLE(), which in most cases won't be noticeable.  But in some
> cases you might (for example) want to enclose a loop in RCU_NONIDLE()
> rather than doing RCU_NONIDLE() on each pass through the loop.
>
> > I could add RCU_NONIDLE for the calls to pm_runtime_put_sync_suspend()
> > and pm_runtime_get_sync() in psci_enter_domain_idle_state(). Perhaps
> > that's the easiest approach, at least to start with.
> >
> > Or do you have any other ideas?
>
> Here is the list, though it is early in the morning here:
>
> 1.      RCU_NONIDLE().
>
> 2.      Peter's patch, if it turns out to hoist your code out of what
>         RCU considers to be the idle loop.
>
> 3.      If the problem is trace events, use the _rcuidle() variant of the
>         trace event.  Instead of trace_blah(), use trace_blah_rcuidle().
>
> 4.      Switch from RCU (as in rcu_read_lock()) to SRCU (as in
>         srcu_read_lock()).
>
> 5.      Take Peter's patch a step further, moving the rcu_idle_enter()
>         and rcu_idle_exit() calls as needed.  But please keep in mind
>         that these two functions require that irqs be disabled by their
>         callers.
>
> 6.      If RCU_NONIDLE() in inconvenient due to early exits and such,
>         you could use the rcu_irq_enter_irqson() and rcu_irq_exit_irqson()
>         functions that it calls.
>
> Do any of those help?

Yes, they will, in one way or the other. Thanks for providing me with
all the available options.

BTW, I still don't get what good rcu_idle_enter|exit() does, but I am
assuming those need to be called at some point before the CPU goes to
sleep.

Kind regards
Uffe
