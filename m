Return-Path: <linux-pm+bounces-39406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B235ECB3084
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 14:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCA7A30CE57A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746582F25F0;
	Wed, 10 Dec 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD+QFVXk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4315ECCC;
	Wed, 10 Dec 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373528; cv=none; b=aofkFtUcWDpDs2pXGJ+7xrIhZXsvyPUuqCP73ReAUs3bRwdrmSC7SealrQjyNqIfMtx6BleKFUC82+n7hkkRkAfPzIi0ne4FUXPqB7telpYMhKDYsFyl8ocA+TsPrmBN/NjwyGvSw+1UB9DkujeQwJemhH1jGxLAPdT/iewMjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373528; c=relaxed/simple;
	bh=VT43Utki0KSpNyeJAOFAem9qF5q/X1l3pkw2rHh004c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7D548uVZ/U9BFd/4aanYly/H8wTS85t8ytMjDh4BGA+cLu7GbaOAP9IkOjo2jNKG175YuVS/kgzntX/SbdEY3wWoIa0yT/YEqjG34BBkUYw7KjA3chdTluou7kkrHvb84uIOrmJiospOSYhCjOWzl/j7VPuXnh6TLNLwyAvJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD+QFVXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D2FC4CEF1;
	Wed, 10 Dec 2025 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765373527;
	bh=VT43Utki0KSpNyeJAOFAem9qF5q/X1l3pkw2rHh004c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mD+QFVXkwXZG8ggAGR+mYTcvBgpm9wNCD/xaOIkHMlCw/96VKvcSPxosz5xR+5m0S
	 2cLVkf/lNaXd/NCEseRMTVFihl7aRKLmh5Z2b4Ruqb2Ya3+JDKxDoQKRRWWYF8JufG
	 L1YDlkuAfDCgd7c24xe8kR2jebG9YDP74A/1FNADchqnx2sun4tWh+dMufbJ/R0eK0
	 q8gs+/WxnmX1WdwG0Fym0ZSpCC8p9OTwhjCPsAMtTcjGwzuiPqUaxg2WIWx2ClT6ds
	 oXKrJg5Gzjs+4YJ3e2K1IElr8cymwuiKCjeKMzv9XKU+rwjh0xxyVlXtyQQwlyG174
	 aRF/5UyUsAUQg==
Date: Wed, 10 Dec 2025 14:32:05 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] sched/idle: disable tick in idle=poll idle entry
Message-ID: <aTl2VdDTRrVu6og_@localhost.localdomain>
References: <aQJWWIDMMUxqDxnR@tpad>
 <aQONGWu1lM27erA3@localhost.localdomain>
 <aQiSPucmKCy4Rn6u@tpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQiSPucmKCy4Rn6u@tpad>

Le Mon, Nov 03, 2025 at 08:30:06AM -0300, Marcelo Tosatti a écrit :
> On Thu, Oct 30, 2025 at 05:06:49PM +0100, Frederic Weisbecker wrote:
> > (Adding more people in Cc)
> > 
> > Le Wed, Oct 29, 2025 at 03:00:56PM -0300, Marcelo Tosatti a écrit :
> > > 
> > > Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5 
> > > ("tick/nohz: Conditionally restart tick on idle exit") allows
> > > a nohz_full CPU to enter idle and return from it with the 
> > > scheduler tick disabled (since the tick might be undesired noise).
> > > 
> > > The idle=poll case still unconditionally restarts the tick when entering
> > > idle.
> > > 
> > > To reduce the noise for that case as well, stop the tick when entering
> > > idle, for the idle=poll case.
> > > 
> > > Change tick_nohz_full_kick_cpu to set NEED_RESCHED bit, to handle the
> > > case where a new timer is added from an interrupt. This breaks out of
> > > cpu_idle_poll and rearms the timer if necessary.
> > > 
> > > ---
> > > 
> > > v2: Handle the case where a new timer is added from an interrupt (Frederic Weisbecker)
> > > 
> > >  include/linux/sched.h    |    2 ++
> > >  kernel/sched/core.c      |   10 ++++++++++
> > >  kernel/sched/idle.c      |    2 +-
> > >  kernel/time/tick-sched.c |    1 +
> > >  4 files changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index cbb7340c5866..1f6938dc20cd 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -2428,4 +2428,6 @@ extern void migrate_enable(void);
> > >  
> > >  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
> > >  
> > > +void set_tif_resched_if_polling(int cpu);
> > > +
> > >  #endif
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index f1ebf67b48e2..f0b84600084b 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -988,6 +988,11 @@ static bool set_nr_if_polling(struct task_struct *p)
> > >  	return true;
> > >  }
> > >  
> > > +void set_tif_resched_if_polling(int cpu)
> > > +{
> > > +	set_nr_if_polling(cpu_rq(cpu)->idle);
> > > +}
> > > +
> > >  #else
> > >  static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
> > >  {
> > > @@ -999,6 +1004,11 @@ static inline bool set_nr_if_polling(struct task_struct *p)
> > >  {
> > >  	return false;
> > >  }
> > > +
> > > +void set_tif_resched_if_polling(int cpu)
> > > +{
> > > +	set_tsk_need_resched(cpu_rq(cpu)->idle);
> > > +}
> > >  #endif
> > >  
> > >  static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
> > > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > > index c39b089d4f09..428c2d1cbd1b 100644
> > > --- a/kernel/sched/idle.c
> > > +++ b/kernel/sched/idle.c
> > > @@ -324,7 +324,7 @@ static void do_idle(void)
> > >  		 * idle as we know that the IPI is going to arrive right away.
> > >  		 */
> > >  		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
> > > -			tick_nohz_idle_restart_tick();
> > > +			tick_nohz_idle_stop_tick();
> > 
> > Shouldn't we simply remove the tick_nohz_idle_restart_tick() line? The nohz_full
> > CPU should have entered here with the tick disabled already.
> > 
> > Also non-nohz_full systems shouldn't care.
> 
> With tick_nohz_idle_restart_tick removed:
> 
> <idle>-0 [001] d.h2. 51.356672: hrtimer_start: hrtimer=ffff927ae205c418 function=tick_nohz_handler expires=51360062500 softexpires=51360062500 mode=ABS
> <idle>-0 [001] d.h2. 51.357671: hrtimer_cancel: hrtimer=ffff927ae205c418
> <idle>-0 [001] d.h1. 51.357671: hrtimer_expire_entry: hrtimer=ffff927ae205c418 function=tick_nohz_handler now=51360063398
> <idle>-0 [001] d.h1. 51.357671: hrtimer_expire_exit: hrtimer=ffff927ae205c418
> <idle>-0 [001] d.h2. 51.357671: hrtimer_start: hrtimer=ffff927ae205c418 function=tick_nohz_handler expires=51361062500 softexpires=51361062500 mode=ABS
> <idle>-0 [001] d.h2. 51.358671: hrtimer_cancel: hrtimer=ffff927ae205c418
> <idle>-0 [001] d.h1. 51.358671: hrtimer_expire_entry: hrtimer=ffff927ae205c418 function=tick_nohz_handler now=51361063420
> <idle>-0 [001] d.h1. 51.358672: hrtimer_expire_exit: hrtimer=ffff927ae205c418
> <idle>-0 [001] d.h2. 51.358672: hrtimer_start: hrtimer=ffff927ae205c418 function=tick_nohz_handler expires=51362062500 softexpires=51362062500 mode=ABS
> <idle>-0 [001] d.h2. 51.359671: hrtimer_cancel: hrtimer=ffff927ae205c418
> <idle>-0 [001] d.h1. 51.359671: hrtimer_expire_entry: hrtimer=ffff927ae205c418 function=tick_nohz_handler now=51362063447
> <idle>-0 [001] d.h1. 51.359672: hrtimer_expire_exit: hrtimer=ffff927ae205c418
> <idle>-0 [001] d.h2. 51.359672: hrtimer_start: hrtimer=ffff927ae205c418 function=tick_nohz_handler expires=51363062500 softexpires=51363062500 mode=ABS
> 
> CPU 1 is idle and isolated.

Suprising, somehow the CPU's tick never interrupted a non-idle section. I guess
it's possible after boot. Or the CPU had tick dependencies before. I was about
to propose stopping the tick right before exiting to userspace but since you're
using idle=poll, I guess userspace must be reached as fast as possible and
therefore you prefer to stop the tick before the next wake-up rather that after?

Also instead of polling in kernel, why not polling in userspace for events? This
sounds like a saner isolation design. Entering/exiting the kernel is always a
risk for something going wrong.

> 
> > >  			cpu_idle_poll();
> > >  		} else {
> > >  			cpuidle_idle_call();
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index c527b421c865..efc3653999dc 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -408,6 +408,7 @@ void tick_nohz_full_kick_cpu(int cpu)
> > >  	if (!tick_nohz_full_cpu(cpu))
> > >  		return;
> > >  
> > > +	set_tif_resched_if_polling(cpu);
> > 
> > Perhaps stuff that within wake_up_full_nohz_cpu() and call
> > set_nr_if_polling() directly.
> 
> Can't call set_nr_if_polling() directly since if TIF_POLLING_NRFLAG is
> undefined:
> 
> static inline bool set_nr_if_polling(struct task_struct *p)
> {
>         return false;
> }
> 
> So the wakeup won't occur. Or am i missing something?

Ok but can you at least move that to wake_up_full_nohz_cpu()?
tick_nohz_full_kick_cpu() is more general and doesn't only concern
new timers.

-- 
Frederic Weisbecker
SUSE Labs

