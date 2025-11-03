Return-Path: <linux-pm+bounces-37299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78269C2BAB6
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 13:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D73C1881FF7
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 12:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC22FE57F;
	Mon,  3 Nov 2025 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ib9ny1Od"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1D30C617
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173029; cv=none; b=rPP+gAcZCpmgZpoe0cqFa1wUiu+/On8rcPODcuIWMHjVbHzIzZAYC/tEEqEzGp0KDM/5VO/p+GhVrVUt6zjwxg4Q0bKj9/16Gwtt3O+oHTivahUsSxk++/qQGZWOjoU+vLvPuG0XdvS4Fxfyt8ev1bT4m0k3g6Ud6/PcfHQUVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173029; c=relaxed/simple;
	bh=7UZyhD9GK9Zjc302Yk/ECdUVVsZM2bGjXpiyAcsOwVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl0563ksfLtrjdzzN0Xm9YDKYbes6/uGihPAtEORTTp5AYNPXXC5G68UqkQ6XqkUwCLWpcEkSMU5m4jZAJ/26Z0V8YcOO9LvxySM4OM9SdyAvi7JhK7cHexFOuRO12m60IkrRiKR7rBG+WfWOpTlQAAz6sAGXwn7of4HryWnr64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ib9ny1Od; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z/kn0ov0H0hmjl/LRgH623c40HkibKXrRsxezh1g2cQ=; b=Ib9ny1OdZKFbxFDl1YJXXNwC0a
	rFGdodxJh2y4+X5Q8G8HETc30eg+S8q8ppA5x1kq2q2T9Uz/S+8yvvyAYdh2gojuEYMSMHb19cwQ7
	PLkWS7J2C4Z2j4LHhWSpaJ+RHc0FP4Ak4H4QMuH0rMfsHvO1bFBz89mAeqPooEx2Iia6Gwnu5AfaF
	AACoT8SVKtNFwRR4+C8AGhyTgB/sHuna4F8mTgGNyo/7PeT2soON7zRWIYYZhwEv+qsJeEPgZ+k+a
	smv9TnmZVAB0a/Oz/fGehTNe0QhgNn8tqa9IBAI3z5jOc/Bx3HTGC4nu8FYr12g/A6RZu6dvx5boP
	QaiS+Rog==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFspq-0000000FK8v-1Oxz;
	Mon, 03 Nov 2025 11:34:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1231630023C; Mon, 03 Nov 2025 13:30:23 +0100 (CET)
Date: Mon, 3 Nov 2025 13:30:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] sched/idle: disable tick in idle=poll idle entry
Message-ID: <20251103123023.GZ3245006@noisy.programming.kicks-ass.net>
References: <aQiWfnnSzxsnwa2o@tpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiWfnnSzxsnwa2o@tpad>

On Mon, Nov 03, 2025 at 08:48:14AM -0300, Marcelo Tosatti wrote:
> 
> Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
> ("tick/nohz: Conditionally restart tick on idle exit") allows

Quoting a commit usually shortens the hash to 12 charters, no?

> a nohz_full CPU to enter idle and return from it with the
> scheduler tick disabled (since the tick might be undesired noise).
> 
> The idle=poll case still unconditionally restarts the tick when entering
> idle.
> 
> To reduce the noise for that case as well, stop the tick when entering
> idle, for the idle=poll case.
> 
> Change tick_nohz_full_kick_cpu to set NEED_RESCHED bit, to handle the
> case where a new timer is added from an interrupt. This breaks out of
> cpu_idle_poll and rearms the timer if necessary.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> v3: Add comment with proper explanation (Frederic Weisbecker)
>     Add signed-off-by			(Thomas Gleixner)
> v2: Handle the case where a new timer is added from an interrupt (Frederic Weisbecker)
> 
>  include/linux/sched.h    |    2 ++
>  kernel/sched/core.c      |   10 ++++++++++
>  kernel/sched/idle.c      |    2 +-
>  kernel/time/tick-sched.c |    7 +++++++
>  4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index cbb7340c5866..1f6938dc20cd 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2428,4 +2428,6 @@ extern void migrate_enable(void);
>  
>  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
>  
> +void set_tif_resched_if_polling(int cpu);
> +
>  #endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f1ebf67b48e2..f0b84600084b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -988,6 +988,11 @@ static bool set_nr_if_polling(struct task_struct *p)
>  	return true;
>  }
>  
> +void set_tif_resched_if_polling(int cpu)
> +{
> +	set_nr_if_polling(cpu_rq(cpu)->idle);
> +}
> +
>  #else
>  static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
>  {
> @@ -999,6 +1004,11 @@ static inline bool set_nr_if_polling(struct task_struct *p)
>  {
>  	return false;
>  }
> +
> +void set_tif_resched_if_polling(int cpu)
> +{
> +	set_tsk_need_resched(cpu_rq(cpu)->idle);
> +}
>  #endif
>  
>  static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index c39b089d4f09..428c2d1cbd1b 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -324,7 +324,7 @@ static void do_idle(void)
>  		 * idle as we know that the IPI is going to arrive right away.
>  		 */
>  		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
> -			tick_nohz_idle_restart_tick();
> +			tick_nohz_idle_stop_tick();
>  			cpu_idle_poll();
>  		} else {
>  			cpuidle_idle_call();
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index c527b421c865..9ec51da49591 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -408,6 +408,13 @@ void tick_nohz_full_kick_cpu(int cpu)
>  	if (!tick_nohz_full_cpu(cpu))
>  		return;
>  
> +	/*
> +	 * When idle=poll, with the tick disabled (therefore idle CPU looping
> +	 * at cpu_idle_poll), if a new timer is added from an interrupt,
> +	 * the cpu_idle_poll only exits when TIF_NEED_RESCHED gets set.
> +	 */
> +	set_tif_resched_if_polling(cpu);
> +
>  	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
>  }

I'm confused. Why is this here and not in tick_nohz_start_idle() or
something?

