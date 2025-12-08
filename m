Return-Path: <linux-pm+bounces-39316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22129CADAE0
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 17:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A06A530168D3
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D140B314B8E;
	Mon,  8 Dec 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5rgZm4O"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19875314A6D
	for <linux-pm@vger.kernel.org>; Mon,  8 Dec 2025 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209397; cv=none; b=ibhFJ1GpTfKOhm4UnSsKpoW+ITEPQU65hG/iymY8oUrlAyQ8aFhTAf3yYbBkIOCSziJdvHAa3kWsZHM6F1BHbhM7OvSFZHsPRaJ5qdsasoMHx1ttOstueOxhvRZquWYn4pB0pa/R6vPlpEPoGJA38QwwuoVOj9y8B69Bt218WUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209397; c=relaxed/simple;
	bh=2q2ALs4PWYJO3uYpvFGWgDVSOtTB4DKblx0osb+JV7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlXCYBGicLGvLXmvdLEwHAboNd84slTU+PZA+05dK9XLg0hZFI8bWChstZg0vq+6cc6qdLqa+ET7E6UHztJzWghHIfx8cSX7z1GiBRvh84nEmH68fEps3QzGJZf+yP9w83iyHRtNemUHfNG1uNqfpxP9kED3Gp/bdh1MHF0OfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5rgZm4O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765209395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3coLAM1tNc6Pvt3HN9nPVH3wM9CyR6zCFpstoD9D3U=;
	b=Y5rgZm4O83DhRHZjiBQm1w/wBBDoK3UhzKtCXoftWAZoFnaVYN5YrZJg0Jrqrvx+95CXsz
	agIEA/7ChJX8Fu7Q21dYJrRHiQWAUC9pqqgbET7tB9lPr+qldh2ahoBgumz8wRJTzyWFzZ
	DeC51FfakdjYdt905qJo86jNplI8E9Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-1z4mPtSFNrS4_SgANByTyg-1; Mon,
 08 Dec 2025 10:56:31 -0500
X-MC-Unique: 1z4mPtSFNrS4_SgANByTyg-1
X-Mimecast-MFC-AGG-ID: 1z4mPtSFNrS4_SgANByTyg_1765209390
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA5EC19560AD;
	Mon,  8 Dec 2025 15:56:29 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1085219560B0;
	Mon,  8 Dec 2025 15:56:28 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 86EC1401E16F1; Mon,  8 Dec 2025 12:53:41 -0300 (-03)
Date: Mon, 8 Dec 2025 12:53:41 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] sched/idle: disable tick in idle=poll idle entry
Message-ID: <aTb0haA19YNVpJF7@tpad>
References: <aQiWfnnSzxsnwa2o@tpad>
 <20251103123023.GZ3245006@noisy.programming.kicks-ass.net>
 <aQtJzK7c/FpSWX74@tpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtJzK7c/FpSWX74@tpad>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Nov 05, 2025 at 09:57:48AM -0300, Marcelo Tosatti wrote:
> On Mon, Nov 03, 2025 at 01:30:23PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 03, 2025 at 08:48:14AM -0300, Marcelo Tosatti wrote:
> > > 
> > > Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
> > > ("tick/nohz: Conditionally restart tick on idle exit") allows
> > 
> > Quoting a commit usually shortens the hash to 12 charters, no?
> > 
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
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > 
> > > ---
> > > 
> > > v3: Add comment with proper explanation (Frederic Weisbecker)
> > >     Add signed-off-by			(Thomas Gleixner)
> > > v2: Handle the case where a new timer is added from an interrupt (Frederic Weisbecker)
> > > 
> > >  include/linux/sched.h    |    2 ++
> > >  kernel/sched/core.c      |   10 ++++++++++
> > >  kernel/sched/idle.c      |    2 +-
> > >  kernel/time/tick-sched.c |    7 +++++++
> > >  4 files changed, 20 insertions(+), 1 deletion(-)
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
> > >  			cpu_idle_poll();
> > >  		} else {
> > >  			cpuidle_idle_call();
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index c527b421c865..9ec51da49591 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -408,6 +408,13 @@ void tick_nohz_full_kick_cpu(int cpu)
> > >  	if (!tick_nohz_full_cpu(cpu))
> > >  		return;
> > >  
> > > +	/*
> > > +	 * When idle=poll, with the tick disabled (therefore idle CPU looping
> > > +	 * at cpu_idle_poll), if a new timer is added from an interrupt,
> > > +	 * the cpu_idle_poll only exits when TIF_NEED_RESCHED gets set.
> > > +	 */
> > > +	set_tif_resched_if_polling(cpu);
> > > +
> > >  	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
> > >  }
> > 
> > I'm confused. Why is this here and not in tick_nohz_start_idle() or
> > something?
> > 
> > 
> 
> Hi Peter,
> 
> The codepath being followed is:
> 
> enqueue_timer -> trigger_dyntick_cpu -> wake_up_nohz_cpu ->
> wake_up_full_nohz_cpu -> tick_nohz_full_kick_cpu ->
> set_tif_resched_if_polling. 
> 
> So we only set the PF_RESCHED bit if there is a pending timer
> on the CPU.
> 
> Calling unconditionally from tick_nohz_start_idle seems strange:
> 
> /**
>  * tick_nohz_idle_enter - prepare for entering idle on the current CPU
>  *
>  * Called when we start the idle loop.
>  */
> void tick_nohz_idle_enter(void)
> {
>         struct tick_sched *ts;
>         
>         lockdep_assert_irqs_enabled();
> 
>         local_irq_disable();
> 
>         ts = this_cpu_ptr(&tick_cpu_sched);
> 
>         WARN_ON_ONCE(ts->timer_expires_base);
> 
>         tick_sched_flag_set(ts, TS_FLAG_INIDLE);
>         tick_nohz_start_idle(ts);
> 
>         local_irq_enable();
> }
> 
> Can test for TS_FLAG_INIDLE before calling set_tif_resched_if_polling 
> (but seems not necessary since tick_nohz_full_kick_cpu will wake up the 
> CPU anyway and is a slow path (timer addition)).
> 
> What do you think?

OK, it looks like there are no further comments on this patch.

Frederic, Peter, Thomas, can you ACK ???

Thanks


