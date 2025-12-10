Return-Path: <linux-pm+bounces-39407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A73CACB30F3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 14:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D161305D7A5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD132039E;
	Wed, 10 Dec 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVEYezmZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F2319610
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765374213; cv=none; b=QmiyVDfUjvxfcsu/osoozRiArqXh9UkjL8b3J7Av33GxbnLnPLm56saLQC8mGEj/sN/mOWE+GJrWWy4dCMxZhI3LX2n2mWXsGbn8flKyVhYUEw0ScLN3g7MTMQ+62SfNhnrIMXE/bnsH4SfdiCq7BnYPXNvWwYNnFJSFUdFgGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765374213; c=relaxed/simple;
	bh=NPpZM7Ae0HsxuRjUZdma85paVey91JD3JsdBDjRKZIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxtrZZ4fuYY6lusN6t7gz4SBeamXZIzX+itFizQLQLsTd3mI74mrTcHaynyDR4CEf4UAmsPgPLk6AcRc1YNjm9SfNwSl5UZ/b8TQc84p9xJQxlROoDeqbTSyT9453Do3t/KSN/S6vDrTYsUMJfud8/pOkK31/QNZMsKBD5l+CYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVEYezmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1208C4CEF1;
	Wed, 10 Dec 2025 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765374213;
	bh=NPpZM7Ae0HsxuRjUZdma85paVey91JD3JsdBDjRKZIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVEYezmZF8tHOqjfnvg8CuDIJDXXdAZBzqwXh3rMnWLfvXwAcx9NQA3ApNhrOzi6q
	 X6TJqiGybw6PAl4no/aRcpfsHUvLkdGgYBOCNEvpAzUi9TYUKewlMx129Mh/sN9Jl+
	 PANyuP9pc7mOtVvLiUsRWxeQSPje53+L9AoxLnsIpxqSDj6YIVoXl5pk0dYtmU/sFf
	 5f2jlMAJGF8/RE5bYDYduQU/TMNSxMYNIpY/NrTBCG+mEq84g1GNv8a92fNSXfyMtx
	 AStEuL/rRJd5DHRaa1yL0aGoV2PljjTemjQxPeitXizcwBFD5j0Yz6sDXHCacutYcT
	 8PyN1tT/QQTlA==
Date: Wed, 10 Dec 2025 14:43:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] sched/idle: disable tick in idle=poll idle entry
Message-ID: <aTl5Ah_x3UKWYU57@localhost.localdomain>
References: <aQiWfnnSzxsnwa2o@tpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQiWfnnSzxsnwa2o@tpad>

Le Mon, Nov 03, 2025 at 08:48:14AM -0300, Marcelo Tosatti a écrit :
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

I still think that the polling probably should happen in userspace rather than in
kernelspace. But if we have to go down that road, the tick stop here should only
happen if the CPU is nohz_full. Namely we should have
tick_nohz_full_idle_stop_tick() and provide a comment why we are doing that.

Because aside nohz_full, stopping the tick here is useless and can make things
worse for realtime workloads which may spend time reprogramming the tick while
a high prio task is waiting for the CPU.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

