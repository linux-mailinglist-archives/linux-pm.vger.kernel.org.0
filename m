Return-Path: <linux-pm+bounces-37461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9CBC35BC6
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 13:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF79188B602
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B12F1FD2;
	Wed,  5 Nov 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIOGxatn"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4FE30AAC2
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347514; cv=none; b=mKUbvtT89yiKwnNPDgWufIILHjq5ekXWvP8fBtoHPz+Xfp2yRdF0A8ymOJJ2Z9w84GmhqHJ4BZ3T/1HFfjHjG5i30N1wm/uScT675KEAokqMmg1eXT3uEPRyx+tqj8Ep/jLQe8R9+df8pxYGgbtQwNBymmSF8mrZxv5SZBGC+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347514; c=relaxed/simple;
	bh=UqnjuxcD9MQN38GQZKVy1H8/olE/Jg0mHGkei6faPR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXFejQp+JC6JzdP7hFzvBX3oNpkt3suUYwDBuSXNtc7ZUn8HOoBHAEnD3eYtRscFCpm+pU/DjcL86/rkMPpcc/l5tpGD5LouGE/3xzZY6HjHWretkGyuP8S2o54K4OH16iqelMWku+JHt/LXSgPefY8qIyaVdcMWuzG7S/eSjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIOGxatn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762347511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVbDoYss/CrkMhspWj4Y09kqO8xeZn9jROt9O+XHEOA=;
	b=LIOGxatnaqfZWE7b8abBK3nPg9P6sAWdl7dvLRtyrVuzUoUHhVIvPlyUqiLWy147DNoro4
	9C/Pa4bYoLgBp/akvilWThL/xbo2P8qxVwr2hFEkEFJYnHyiTwwxv2uB3nsPenEfYbJ1Ws
	FYfe+qgo9i51sGr0f6VsUtqwu/rIqDo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-qj3XRElbMNKVEpmBFXbGAg-1; Wed,
 05 Nov 2025 07:58:26 -0500
X-MC-Unique: qj3XRElbMNKVEpmBFXbGAg-1
X-Mimecast-MFC-AGG-ID: qj3XRElbMNKVEpmBFXbGAg_1762347505
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BA751956095;
	Wed,  5 Nov 2025 12:58:24 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 536E2195608E;
	Wed,  5 Nov 2025 12:58:22 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 7D8C1400FD41F; Wed,  5 Nov 2025 09:57:48 -0300 (-03)
Date: Wed, 5 Nov 2025 09:57:48 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] sched/idle: disable tick in idle=poll idle entry
Message-ID: <aQtJzK7c/FpSWX74@tpad>
References: <aQiWfnnSzxsnwa2o@tpad>
 <20251103123023.GZ3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103123023.GZ3245006@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Nov 03, 2025 at 01:30:23PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 03, 2025 at 08:48:14AM -0300, Marcelo Tosatti wrote:
> > 
> > Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
> > ("tick/nohz: Conditionally restart tick on idle exit") allows
> 
> Quoting a commit usually shortens the hash to 12 charters, no?
> 
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
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> > 
> > v3: Add comment with proper explanation (Frederic Weisbecker)
> >     Add signed-off-by			(Thomas Gleixner)
> > v2: Handle the case where a new timer is added from an interrupt (Frederic Weisbecker)
> > 
> >  include/linux/sched.h    |    2 ++
> >  kernel/sched/core.c      |   10 ++++++++++
> >  kernel/sched/idle.c      |    2 +-
> >  kernel/time/tick-sched.c |    7 +++++++
> >  4 files changed, 20 insertions(+), 1 deletion(-)
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
> >  			cpu_idle_poll();
> >  		} else {
> >  			cpuidle_idle_call();
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index c527b421c865..9ec51da49591 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -408,6 +408,13 @@ void tick_nohz_full_kick_cpu(int cpu)
> >  	if (!tick_nohz_full_cpu(cpu))
> >  		return;
> >  
> > +	/*
> > +	 * When idle=poll, with the tick disabled (therefore idle CPU looping
> > +	 * at cpu_idle_poll), if a new timer is added from an interrupt,
> > +	 * the cpu_idle_poll only exits when TIF_NEED_RESCHED gets set.
> > +	 */
> > +	set_tif_resched_if_polling(cpu);
> > +
> >  	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
> >  }
> 
> I'm confused. Why is this here and not in tick_nohz_start_idle() or
> something?
> 
> 

Hi Peter,

The codepath being followed is:

enqueue_timer -> trigger_dyntick_cpu -> wake_up_nohz_cpu ->
wake_up_full_nohz_cpu -> tick_nohz_full_kick_cpu ->
set_tif_resched_if_polling. 

So we only set the PF_RESCHED bit if there is a pending timer
on the CPU.

Calling unconditionally from tick_nohz_start_idle seems strange:

/**
 * tick_nohz_idle_enter - prepare for entering idle on the current CPU
 *
 * Called when we start the idle loop.
 */
void tick_nohz_idle_enter(void)
{
        struct tick_sched *ts;
        
        lockdep_assert_irqs_enabled();

        local_irq_disable();

        ts = this_cpu_ptr(&tick_cpu_sched);

        WARN_ON_ONCE(ts->timer_expires_base);

        tick_sched_flag_set(ts, TS_FLAG_INIDLE);
        tick_nohz_start_idle(ts);

        local_irq_enable();
}

Can test for TS_FLAG_INIDLE before calling set_tif_resched_if_polling 
(but seems not necessary since tick_nohz_full_kick_cpu will wake up the 
CPU anyway and is a slow path (timer addition)).

What do you think?



