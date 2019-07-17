Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625436BCE5
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfGQNVU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 09:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQNVU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jul 2019 09:21:20 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 995A221743;
        Wed, 17 Jul 2019 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563369679;
        bh=cU+ZOTGMZmhAI1DZC8HHXC75JkDy+oI7nGSc2naIlPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yaWf7Qbc10OEEYlxruvGmV9OX9wT/f6lVvOuktx1OVoc5klrwhvlWrClC7ILrHCPi
         2d5zjXynjEnnQ1QR1+DuPJuAMHrUDxCYFtutV8em79vVjO5kpFBkymxCaOQNrj/idc
         DIbe/nOQ+J5zxQaxzLdnrCH+ix+hARzs35PAipJc=
Date:   Wed, 17 Jul 2019 15:21:16 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuidle: Always stop scheduler tick on adaptive-tick CPUs
Message-ID: <20190717132115.GB8345@lenoir>
References: <6254683.2O5gIZElE2@kreacher>
 <20190716214024.GA8345@lenoir>
 <CAJZ5v0gB0AHTebjpp87YKA1wmE+tCw5V=eaRE2XDM3nyQYndnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gB0AHTebjpp87YKA1wmE+tCw5V=eaRE2XDM3nyQYndnA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 17, 2019 at 09:55:08AM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 16, 2019 at 11:40 PM Frederic Weisbecker
> <frederic@kernel.org> wrote:
> >
> > On Tue, Jul 16, 2019 at 05:25:10PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Running the scheduler tick on idle adaptive-tick CPUs is not useful
> >
> > Judging by the below change, you mean full dynticks, right?
> 
> Right.
> 
> > > and it may also be not expected by users (as reported by Thomas), so
> > > add a check to cpuidle_idle_call() to always stop the tick on them
> > > regardless of the idle duration predicted by the governor.
> > >
> > > Fixes: 554c8aa8ecad ("sched: idle: Select idle state before stopping the tick")
> > > Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> > > Tested-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  kernel/sched/idle.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > Index: linux-pm/kernel/sched/idle.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/sched/idle.c
> > > +++ linux-pm/kernel/sched/idle.c
> > > @@ -191,7 +191,8 @@ static void cpuidle_idle_call(void)
> > >                */
> > >               next_state = cpuidle_select(drv, dev, &stop_tick);
> > >
> > > -             if (stop_tick || tick_nohz_tick_stopped())
> > > +             if (stop_tick || tick_nohz_tick_stopped() ||
> > > +                 !housekeeping_cpu(dev->cpu, HK_FLAG_TICK))
> >
> > But tick_nohz_tick_stopped() also works on full dynticks CPUs. If the
> > tick isn't stopped on a full dynticks CPU by the time we reach this path,
> > it means that the conditions for the tick to be stopped are not met anyway
> > (eg: more than one task and sched tick is needed, perf event requires the tick,
> > posix CPU timer, etc...)
> 
> First of all, according to Thomas, the patch does make a difference,
> so evidently on his system(s) the full dynticks CPUs enter the idle
> loop with running tick.
> 
> This means that, indeed, the conditions for the tick to be stopped
> have not been met up to that point, but if the (full dynticks) CPU
> becomes idle, that's because it has been made idle on purpose
> (presumably by a user-space "orchestrator" or the sysadmin), so the
> kernel can assume that it will remain idle indefinitely.  That, in
> turn, is when the tick would be stopped on it regardless of everything
> else (even if it wasn't a full dynticks CPU).

Well I think we disagree on that assumption that if a nohz_full CPU is put
idle, it will remain there indefinitely. Nohz_full CPUs aren't really special
in this regard, they can sleep on an IO, wait for a short event just like
any other CPU.

The only difference with other CPUs is that they _might_ enter the idle loop
with the tick already stopped. Ok that should be the case most of the time
with regular full dynticks usecases, but there can be initialization work
or stuff that make the CPU run with periodic tick for some time.

Thanks.

> 
> I guess I should add the above to the changelog.
> 
> > Or am I missing something else?
> 
> Well, if full dynticks CPUs are expected to always enter the idle loop
> with stopped tick, then something appears to be amiss, but I'm not
> sure if that expectation is entirely realistic.
> 
> Cheers!
