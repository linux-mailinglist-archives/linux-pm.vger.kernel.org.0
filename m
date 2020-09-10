Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F38265451
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 23:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgIJVmt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 17:42:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56066 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbgIJM41 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 08:56:27 -0400
Received: from 89-64-87-170.dynamic.chello.pl (89.64.87.170) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.468)
 id 0b9e2c09bd0fb81d; Thu, 10 Sep 2020 14:55:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Claude. Yen" <Claude.Yen@mediatek.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Subject: Re: [PATCH] PM: s2idle: Introduce syscore callbacks in s2idle flow
Date:   Thu, 10 Sep 2020 14:55:06 +0200
Message-ID: <1955367.r5QahNuf3v@kreacher>
In-Reply-To: <1599099247.4435.4.camel@mtksdccf07>
References: <1598943859-21857-1-git-send-email-claude.yen@mediatek.com> <CAJZ5v0hOGEUamXw124q4CnL67o97qRHy9Vv9_F2AQqefDdu3vQ@mail.gmail.com> <1599099247.4435.4.camel@mtksdccf07>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, September 3, 2020 4:14:07 AM CEST Claude. Yen wrote:
> On Tue, 2020-09-01 at 13:57 +0200, Rafael J. Wysocki wrote:
> > On Tue, Sep 1, 2020 at 9:05 AM Claude Yen <claude.yen@mediatek.com> wrote:
> > >
> > > This series based on 5.9-rc1
> > > This patch makes s2idle call existing syscore callbacks. Currently,
> > > when s2idle is selected as system suspend method, callbacks hooked
> > > by register_syscore_ops() will not be triggered. This may induce
> > > unexpected results.
> > 
> > They are not executed by design.
> > 
> > > For example, sched_clock_suspend() was added to s2idle flow in
> > > commit 3f2552f7e9c5 ("timers/sched_clock: Prevent generic sched_clock
> > > wrap caused by tick_freeze()") to fix clock wrap problem. However,
> > > sched_clock_suspend() is originally registered in syscore callback.
> > 
> > I'm not sure why this matters here.
> 
> If functions in syscore callbacks are needed in s2idle, explicit
> migration is needed like commit 3f2552f7e9c5 ("timers/sched_clock:
> Prevent generic sched_clock wrap caused by tick_freeze()").
> Thus, I am wondering if such effort could be saved.

Yes, it could.

You can define platform ops for s2idle and invoke what's needed from there.

> > > With this patch, if another syscore callback is needed in s2idle,
> > > additional migration effort could be saved.
> > 
> > s2idle cannot execute syscore callbacks, because it doesn' take
> > non-boot CPUs offline and it won't do that.
> > 
> > Thanks!
> 
> Yes, the current design of syscore callback needs non-boot CPUs offline.
> Considering the following case: in s2idle flow, there is a status that
> only one CPU is alive and other CPUs have enter deepest idle state.
> This situation is similar to getting non-boot CPUs offline, though all
> CPUs are online from kernel's perspective.

It is only similar AFAICS.

You don't migrate interrupts during s2idle, for example.

> Reply from Stephen mentioned that if an operation is needed in both
> S2R and s2idle, CPU_PM notifier can be utilized. 
> In my opinion, CPU_PM notifier is particularly for CPU entering idle
> state. In contrast, syscore callback is for system going low power
> state. There exists semantic difference between these two callbacks.

Fair enough.

> Could the current design of syscore callback be re-designed as
> system-wide suspend callback?

No, it couldn't.

> Proposed suspend flow in this patch:
> 
>     Freeze tasks
>         |
>         V
>     Device suspend callbacks
>         |
>         |-------------s2idle----------
>         |                            |
>         V                            |
>     Disable nonboot CPUs    Is this CPU last core to enter idle?
>         |                            |
>         V                            |-------------
>     syscore callbacks                |            |
>         |                           No           Yes
>         V                            |            |
>     platform suspend                 V            V
>                                  enter idle     syscore callback
>                                                   |
>                                                   V
>                                                 enter idle
> 

The primary problem with this is that on some architectures (x86 at least)
the syscore things cannot be run during the s2idle flow.

Also there is a way to invoke them through the platform ops as I said.

Thanks!



