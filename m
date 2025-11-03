Return-Path: <linux-pm+bounces-37293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D986C2B85A
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 12:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9773A5400
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BD303C8E;
	Mon,  3 Nov 2025 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3jt8Cxq"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922530146E
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170562; cv=none; b=WObrPDJClRQAr9sLMps4luVYKaosDRZOYceAyIiPGmiR9rmLKvgZHnJERHgBemBY93OzX6AmaojNW3IbERkgE/JZqFLZEri2Zf4bkOeuDU8Pt2Wh4MDg22SqDx+MRt/K9z2trIRW/Eh8Pugn5/q/wvaiFd+8aDx0BOo8ltpVygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170562; c=relaxed/simple;
	bh=kUT6MVBnXS9rJ8Jz27OSbNfw2Vw6di1nZ8qI0M1s12g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd8vtrX/fm9TYv89vkhhq2bGpcI3SjOXGCiKcbo2DmWXxDrXWnsnepnfHHpcV80vQ5FrF3rBYBbvN5l+2ls74JCCHlBvgYfMsB9aDL8ISy0m8ew0qLeh5b0LjM/uGMBSyI39JoqotBz0UhFYxMyCZaoSvRC50iAdmnFKr4BbKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3jt8Cxq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762170559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWHaUE+5jl+dykrCUaRiHLHmvTKeS281VYpCKKpXV8o=;
	b=Q3jt8CxqcbSzBfMEaT7lDEXnMGyzfbaOPgeScWuZSm0ZQWXj8hZTY+1p6bsjYyyCBe6ze8
	SxVTiFqSxgzUFLFqxqd6TRcSVeSD4Phaa/odJhTzjxUdai+eoloC+y8WJjgUHJ6nLTc+Xh
	IMgyKEeXldchVvodvRFGhw0LpIHMH/0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-yKSSM1XKN_evZ2TMNfz8Sw-1; Mon,
 03 Nov 2025 06:49:16 -0500
X-MC-Unique: yKSSM1XKN_evZ2TMNfz8Sw-1
X-Mimecast-MFC-AGG-ID: yKSSM1XKN_evZ2TMNfz8Sw_1762170555
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29C8E195422D;
	Mon,  3 Nov 2025 11:49:14 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 662431956056;
	Mon,  3 Nov 2025 11:49:12 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 9CB83400DCFD7; Mon,  3 Nov 2025 08:30:06 -0300 (-03)
Date: Mon, 3 Nov 2025 08:30:06 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] sched/idle: disable tick in idle=poll idle entry
Message-ID: <aQiSPucmKCy4Rn6u@tpad>
References: <aQJWWIDMMUxqDxnR@tpad>
 <aQONGWu1lM27erA3@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQONGWu1lM27erA3@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 30, 2025 at 05:06:49PM +0100, Frederic Weisbecker wrote:
> (Adding more people in Cc)
> 
> Le Wed, Oct 29, 2025 at 03:00:56PM -0300, Marcelo Tosatti a écrit :
> > 
> > Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5 
> > ("tick/nohz: Conditionally restart tick on idle exit") allows
> > a nohz_full CPU to enter idle and return from it with the 
> > scheduler tick disabled (since the tick might be undesired noise).
> > 
> > The idle=poll case still unconditionally restarts the tick when entering
> > idle.
> > 
> > To reduce the noise for that case as well, stop the tick when entering
> > idle, for the idle=poll case.
> > 
> > Change tick_nohz_full_kick_cpu to set NEED_RESCHED bit, to handle the
> > case where a new timer is added from an interrupt. This breaks out of
> > cpu_idle_poll and rearms the timer if necessary.
> > 
> > ---
> > 
> > v2: Handle the case where a new timer is added from an interrupt (Frederic Weisbecker)
> > 
> >  include/linux/sched.h    |    2 ++
> >  kernel/sched/core.c      |   10 ++++++++++
> >  kernel/sched/idle.c      |    2 +-
> >  kernel/time/tick-sched.c |    1 +
> >  4 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index cbb7340c5866..1f6938dc20cd 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2428,4 +2428,6 @@ extern void migrate_enable(void);
> >  
> >  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
> >  
> > +void set_tif_resched_if_polling(int cpu);
> > +
> >  #endif
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f1ebf67b48e2..f0b84600084b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -988,6 +988,11 @@ static bool set_nr_if_polling(struct task_struct *p)
> >  	return true;
> >  }
> >  
> > +void set_tif_resched_if_polling(int cpu)
> > +{
> > +	set_nr_if_polling(cpu_rq(cpu)->idle);
> > +}
> > +
> >  #else
> >  static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
> >  {
> > @@ -999,6 +1004,11 @@ static inline bool set_nr_if_polling(struct task_struct *p)
> >  {
> >  	return false;
> >  }
> > +
> > +void set_tif_resched_if_polling(int cpu)
> > +{
> > +	set_tsk_need_resched(cpu_rq(cpu)->idle);
> > +}
> >  #endif
> >  
> >  static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index c39b089d4f09..428c2d1cbd1b 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -324,7 +324,7 @@ static void do_idle(void)
> >  		 * idle as we know that the IPI is going to arrive right away.
> >  		 */
> >  		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
> > -			tick_nohz_idle_restart_tick();
> > +			tick_nohz_idle_stop_tick();
> 
> Shouldn't we simply remove the tick_nohz_idle_restart_tick() line? The nohz_full
> CPU should have entered here with the tick disabled already.
> 
> Also non-nohz_full systems shouldn't care.

With tick_nohz_idle_restart_tick removed:

<idle>-0 [001] d.h2. 51.356672: hrtimer_start: hrtimer=ffff927ae205c418 function=tick_nohz_handler expires=51360062500 softexpires=51360062500 mode=ABS
<idle>-0 [001] d.h2. 51.357671: hrtimer_cancel: hrtimer=ffff927ae205c418
<idle>-0 [001] d.h1. 51.357671: hrtimer_expire_entry: hrtimer=ffff927ae205c418 function=tick_nohz_handler now=51360063398
<idle>-0 [001] d.h1. 51.357671: hrtimer_expire_exit: hrtimer=ffff927ae205c418
<idle>-0 [001] d.h2. 51.357671: hrtimer_start: hrtimer=ffff927ae205c418 function=tick_nohz_handler expires=51361062500 softexpires=51361062500 mode=ABS
<idle>-0 [001] d.h2. 51.358671: hrtimer_cancel: hrtimer=ffff927ae205c418
<idle>-0 [001] d.h1. 51.358671: hrtimer_expire_entry: hrtimer=ffff927ae205c418 function=tick_nohz_handler now=51361063420
<idle>-0 [001] d.h1. 51.358672: hrtimer_expire_exit: hrtimer=ffff927ae205c418
<idle>-0 [001] d.h2. 51.358672: hrtimer_start: hrtimer=ffff927ae205c418 function=tick_nohz_handler expires=51362062500 softexpires=51362062500 mode=ABS
<idle>-0 [001] d.h2. 51.359671: hrtimer_cancel: hrtimer=ffff927ae205c418
<idle>-0 [001] d.h1. 51.359671: hrtimer_expire_entry: hrtimer=ffff927ae205c418 function=tick_nohz_handler now=51362063447
<idle>-0 [001] d.h1. 51.359672: hrtimer_expire_exit: hrtimer=ffff927ae205c418
<idle>-0 [001] d.h2. 51.359672: hrtimer_start: hrtimer=ffff927ae205c418 function=tick_nohz_handler expires=51363062500 softexpires=51363062500 mode=ABS

CPU 1 is idle and isolated.

> >  			cpu_idle_poll();
> >  		} else {
> >  			cpuidle_idle_call();
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index c527b421c865..efc3653999dc 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -408,6 +408,7 @@ void tick_nohz_full_kick_cpu(int cpu)
> >  	if (!tick_nohz_full_cpu(cpu))
> >  		return;
> >  
> > +	set_tif_resched_if_polling(cpu);
> 
> Perhaps stuff that within wake_up_full_nohz_cpu() and call
> set_nr_if_polling() directly.

Can't call set_nr_if_polling() directly since if TIF_POLLING_NRFLAG is
undefined:

static inline bool set_nr_if_polling(struct task_struct *p)
{
        return false;
}

So the wakeup won't occur. Or am i missing something?


> Also this needs a big comment.

Sure!

Thanks.


