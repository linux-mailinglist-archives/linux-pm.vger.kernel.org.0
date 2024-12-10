Return-Path: <linux-pm+bounces-18916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400259EB2A9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 15:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA63416F208
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509BC1AAA32;
	Tue, 10 Dec 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NMOJ0+oZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443D1A2547;
	Tue, 10 Dec 2024 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839436; cv=none; b=U4c7qFG6Rygy7ZiKFmqVXovOUks8gUumvwuMMAjjfsnUZ4U2bGVHbYzT4H4weyAyC414d04hsTerQevjwtjY1VapqAbDu/4ENvylaaB4Sou6ZXQ6JV4HS1dzccL6ESKdY8qqNYpRvy2Ems7km2orf0j0sUekLFJ6PtZlbd/4hX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839436; c=relaxed/simple;
	bh=YUaZEyWQPhzd0M3LyPhm8xtppCcWDOIw+DsqTGi2l1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw9PXQZgsm07aqhoWVuqf1g1YoivKi06HdakytCIP252z0Cq6w2iWZgMTaWFkOjrsAriJyaampxialepNeOOKae2MHE3n3LecV32vgamZx/MoBXui84jU+iTELZaX0elh879CT5/gzZ0M3Yg960K5AamlhUkzNzp75j8L/aHiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NMOJ0+oZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5opJ7S4CIZ6mW1PjnXbo1RR9NTyWWpU8YL/cTDYtOAE=; b=NMOJ0+oZSXy//D0eTF0b+tJGnt
	W1LM4Zb9+bJEwYneXmvAO7WbF7upDytD8X5K5kPq0+OqH5W21PGZ2i43PT5XHPTv4DjgHMbREsgsd
	eleNOWDy4iVWFAXXsx0OHk8DJyejENipcNAICLOje1x90p3Tc1qi8JVhzv8+XgPGY228c/B1gu/bX
	wqetXxd2UA7NtP5SbYxJSm32u7BJEbayP4S5Aemdb5XHWwLKnc4AmdrIvG20DDSPQ+meRr5uTCpPR
	dj5jIgigWMtE5gEkWyOSW+7uZRqIlBwTa6+eE1oKEYtXhLhcASAWaxoUe55Y220thzPKhs4591gDK
	RfExKhPg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tL0q2-00000009hMV-2boU;
	Tue, 10 Dec 2024 14:03:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DF78230035F; Tue, 10 Dec 2024 15:03:45 +0100 (CET)
Date: Tue, 10 Dec 2024 15:03:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/5] cpuidle: Handle TIF_NR_POLLING on behalf of
 CPUIDLE_FLAG_MWAIT states
Message-ID: <20241210140345.GS35539@noisy.programming.kicks-ass.net>
References: <20241206130408.18690-1-frederic@kernel.org>
 <20241206130408.18690-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206130408.18690-4-frederic@kernel.org>

On Fri, Dec 06, 2024 at 02:04:06PM +0100, Frederic Weisbecker wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> The current handling of TIF_NR_POLLING is a bit of a maze:
> 
> 1) TIF_NR_POLLING is set on idle entry (one atomic set)
> 
> 2) Once cpuidle has selected an appropriate state and the tick is
>    evaluated and then possibly stopped, TIF_NR_POLLING is cleared
>    (one RmW operation)
> 
> 2) The cpuidle state is then called with TIF_NR_POLLING cleared but if
>    the state polls on (or monitors) need_resched() it sets again
>    TIF_NR_POLLING before sleeping and clears it on wake-up. Summary:
>    another pair of set/clear
> 
> 3) Set back TIF_NR_POLLING (one atomic set)
> 
> 4) goto 2) if need_resched() is not set
> 
> All those costly atomic operations, fully ordered RmW for some of
> them, could be avoided if the cpuidle core knew in advance if the target
> state polls on (or monitors) need_resched(). If so, TIF_NR_POLLING could
> simply be set once upon entering the idle loop and cleared once after
> idle loop exit.
> 
> Start dealing with that with handling TIF_NR_POLLING on behalf of
> mwait based states.
> 
> [fweisbec: _ Handle broadcast properly
>            _ Ignore mwait_idle() as it can be used by default_idle_call()]
> 
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/x86/include/asm/mwait.h |  3 +--
>  drivers/cpuidle/cpuidle.c    | 22 +++++++++++++++++++-
>  include/linux/sched/idle.h   |  7 ++++++-
>  kernel/sched/idle.c          | 40 +++++++++++++-----------------------
>  4 files changed, 42 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 920426d691ce..3634d00e5c37 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -116,7 +116,7 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
>   */
>  static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
>  {
> -	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
> +	if (static_cpu_has_bug(X86_BUG_MONITOR) || !need_resched()) {
>  		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
>  			mb();
>  			clflush((void *)&current_thread_info()->flags);
> @@ -134,7 +134,6 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
>  			}
>  		}
>  	}
> -	current_clr_polling();
>  }
>  
>  /*
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0835da449db8..46c0a2726f67 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -217,10 +217,10 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>  				 int index)
>  {
>  	int entered_state;
> -
>  	struct cpuidle_state *target_state = &drv->states[index];
>  	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>  	ktime_t time_start, time_end;
> +	bool polling;
>  
>  	instrumentation_begin();
>  
> @@ -237,6 +237,23 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>  		broadcast = false;
>  	}
>  
> +	polling = target_state->flags & CPUIDLE_FLAG_MWAIT;
> +
> +	/*
> +	 * If the target state doesn't poll on need_resched(), this is
> +	 * the last check after which further TIF_NEED_RESCHED remote setting
> +	 * will involve an IPI.
> +	 */
> +	if (!polling && current_clr_polling_and_test()) {
> +		if (broadcast)
> +			tick_broadcast_exit();
> +		dev->last_residency_ns = 0;
> +		local_irq_enable();
> +		instrumentation_end();
> +		return -EBUSY;
> +	}
> +
> +
>  	if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
>  		leave_mm();
>  
> @@ -336,6 +353,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>  		dev->states_usage[index].rejected++;
>  	}
>  
> +	if (!polling)
> +		__current_set_polling();
> +
>  	instrumentation_end();
>  
>  	return entered_state;
> diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
> index e670ac282333..3e3482bfb028 100644
> --- a/include/linux/sched/idle.h
> +++ b/include/linux/sched/idle.h
> @@ -68,6 +68,8 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
>  
>  static __always_inline bool __must_check current_clr_polling_and_test(void)
>  {
> +	bool ret;
> +
>  	__current_clr_polling();
>  
>  	/*
> @@ -76,7 +78,10 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
>  	 */
>  	smp_mb__after_atomic();
>  
> -	return unlikely(tif_need_resched());
> +	ret = unlikely(tif_need_resched());
> +	if (ret)
> +		__current_set_polling();
> +	return ret;
>  }
>  
>  #else
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 621696269584..9eece3df1080 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -114,12 +114,13 @@ void __cpuidle default_idle_call(void)
>  		stop_critical_timings();
>  
>  		ct_cpuidle_enter();
> -		arch_cpu_idle();
> +		arch_cpu_idle(); // XXX assumes !polling
>  		ct_cpuidle_exit();
>  
>  		start_critical_timings();
>  		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>  		cond_tick_broadcast_exit();
> +		__current_set_polling();
>  	}
>  	local_irq_enable();
>  	instrumentation_end();
> @@ -128,31 +129,14 @@ void __cpuidle default_idle_call(void)
>  static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
>  			       struct cpuidle_device *dev)
>  {
> +	int ret;
> +
>  	if (current_clr_polling_and_test())
>  		return -EBUSY;
>  
> -	return cpuidle_enter_s2idle(drv, dev);
> -}
> -
> -static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> -		      int next_state)
> -{
> -	/*
> -	 * The idle task must be scheduled, it is pointless to go to idle, just
> -	 * update no idle residency and return.
> -	 */
> -	if (current_clr_polling_and_test()) {
> -		dev->last_residency_ns = 0;
> -		local_irq_enable();
> -		return -EBUSY;
> -	}
> -
> -	/*
> -	 * Enter the idle state previously returned by the governor decision.
> -	 * This function will block until an interrupt occurs and will take
> -	 * care of re-enabling the local interrupts
> -	 */
> -	return cpuidle_enter(drv, dev, next_state);
> +	ret = cpuidle_enter_s2idle(drv, dev);
> +	__current_set_polling();
> +	return ret;
>  }
>  
>  /**
> @@ -213,7 +197,7 @@ static void cpuidle_idle_call(void)
>  		tick_nohz_idle_stop_tick();
>  
>  		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> -		call_cpuidle(drv, dev, next_state);
> +		cpuidle_enter(drv, dev, next_state);
>  	} else {
>  		bool stop_tick = true;
>  
> @@ -227,7 +211,12 @@ static void cpuidle_idle_call(void)
>  		else
>  			tick_nohz_idle_retain_tick();
>  
> -		entered_state = call_cpuidle(drv, dev, next_state);
> +		/*
> +		 * Enter the idle state previously returned by the governor decision.
> +		 * This function will block until an interrupt occurs and will take
> +		 * care of re-enabling the local interrupts.
> +		 */
> +		entered_state = cpuidle_enter(drv, dev, next_state);
>  		/*
>  		 * Give the governor an opportunity to reflect on the outcome
>  		 */
> @@ -235,7 +224,6 @@ static void cpuidle_idle_call(void)
>  	}
>  
>  exit_idle:
> -	__current_set_polling();
>  
>  	/*
>  	 * It is up to the idle functions to re-enable local interrupts
> -- 
> 2.46.0
> 

