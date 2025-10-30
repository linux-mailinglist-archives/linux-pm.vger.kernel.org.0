Return-Path: <linux-pm+bounces-37119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB2C21177
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 17:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD76B34FFDB
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5835B359F85;
	Thu, 30 Oct 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILXyX+yU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3052749F2;
	Thu, 30 Oct 2025 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840413; cv=none; b=WygHLGZ4Mz1v1lvJEZvPpQMTwxsTo8kNbV2phrdltf1ehWiZ1i1YlUTw4c1Pv3jknfQeZjc5i2n7NnDdj/8HjpSXYZs+3BxuBf2s5j4qAbKAi1W4QZl068WLQegl+YHXg+3mYG9eCSHqtmlWk7yZgvsOt8586ceTi3OWv/Rjvak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840413; c=relaxed/simple;
	bh=ipXTFEr4mVXC3b/obyxX5MiPhK9d8zV1F0n4WOxjUmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGgM80Ir2OeM6lPwjcaSsBJjuw/1CWQ0SELg+eozq93ejvdSyKuiySRRDehBzZt3DmumRBQcZ7HTgDFfcYGMbOji6USYITwt1Pb1U3R9WFdrC0hzsLEiNGtikShoMIBHO15wUCgYP1/6eLEHF92H91IclRTYDRR+HPfuWlWvFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILXyX+yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F34CC4CEF1;
	Thu, 30 Oct 2025 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761840412;
	bh=ipXTFEr4mVXC3b/obyxX5MiPhK9d8zV1F0n4WOxjUmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILXyX+yUXPn/ghwADl0nVwH1l38pb0WFF4W4dgz+X8DnyP1L7s7IUGJ0oXQF+f2Wb
	 oopE64WQiMoEewgQNlOOydr5FCAJkcGb/f5lVks7NGN4fQIayDWpaoGqzqAdyyERy9
	 ZbRZzZ+HTVlp9DaXpxw+RcK1OcKt0/fkPS857FZbSGszmH3tzD1lFiXcJZmxaJAUuW
	 k8DFGzcbSLUAjkMrwXknRQyfHrn51VEZrqzxB6+Nf6skmJYhIGnHdTWQqX7OX/ONxo
	 RmjAtXlLmk6D/eppceAA6q0XgvfsfPJWGaRkjtSFP1hPPR+0pNA6Bvj9U6VCKUZZch
	 HCFlu2++qjmBw==
Date: Thu, 30 Oct 2025 17:06:49 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] sched/idle: disable tick in idle=poll idle entry
Message-ID: <aQONGWu1lM27erA3@localhost.localdomain>
References: <aQJWWIDMMUxqDxnR@tpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQJWWIDMMUxqDxnR@tpad>

(Adding more people in Cc)

Le Wed, Oct 29, 2025 at 03:00:56PM -0300, Marcelo Tosatti a écrit :
> 
> Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5 
> ("tick/nohz: Conditionally restart tick on idle exit") allows
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
> ---
> 
> v2: Handle the case where a new timer is added from an interrupt (Frederic Weisbecker)
> 
>  include/linux/sched.h    |    2 ++
>  kernel/sched/core.c      |   10 ++++++++++
>  kernel/sched/idle.c      |    2 +-
>  kernel/time/tick-sched.c |    1 +
>  4 files changed, 14 insertions(+), 1 deletion(-)
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

Shouldn't we simply remove the tick_nohz_idle_restart_tick() line? The nohz_full
CPU should have entered here with the tick disabled already.

Also non-nohz_full systems shouldn't care.

>  			cpu_idle_poll();
>  		} else {
>  			cpuidle_idle_call();
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index c527b421c865..efc3653999dc 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -408,6 +408,7 @@ void tick_nohz_full_kick_cpu(int cpu)
>  	if (!tick_nohz_full_cpu(cpu))
>  		return;
>  
> +	set_tif_resched_if_polling(cpu);

Perhaps stuff that within wake_up_full_nohz_cpu() and call
set_nr_if_polling() directly. Also this needs a big comment.

Thanks.

>  	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
>  }
>  
> 

-- 
Frederic Weisbecker
SUSE Labs

