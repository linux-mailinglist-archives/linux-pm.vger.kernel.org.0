Return-Path: <linux-pm+bounces-41100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD9ED3A98B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25B09305D9A3
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC7C35EDDB;
	Mon, 19 Jan 2026 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vJqhYbqP"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781733ADA0;
	Mon, 19 Jan 2026 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827253; cv=none; b=ZWcle/8VIHl7CgK6a4BbB3OVy6e/BpiEo03jwxikYFUeKP2R9IsBrJlzFtOXdqbwhzmBjLj6ee+1pyI9fSlJX/guy3ryn/lTavZGNPMxPFOsRWfk59EwjTp12DMKnatTyDkQ1JpcZQGrvQHMHsefBzui6qvuqT+6dqgajI2nigk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827253; c=relaxed/simple;
	bh=6fcd//7R70x07guaxNai+ickFmIDLdc1YPzmFaHHm4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urDFqYNI0QaVs+gsxXWhNmim4iX17ZSaqVMXs1Ui4+dSDEsF0660L/mrTs6SP4WMTIQvYPx3IZhReajiVxNWiZt0gdVtDTKsOx/ukPNBhkHRrSXiMDtKf2TbTe2A5F93dAfvgrDyUWKdsdB0e7xZDHLv/nn65UExLXcsBjVsAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vJqhYbqP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kMRIv+5PhMX2w16KgQw853ivOAJWaId7zAyJ1dkF8Fs=; b=vJqhYbqP6wfcMsUoLbLcFpjsau
	pI7huCZ4tlxvsg+DVviYeVT2rAjpCdlgMX0xhW6Apw02NRK/rB2eg/iW4NnwEOO0kAErfvYFSPWk9
	734l0Za/d9cxaeQK2uT1eINH9rhHpbR9GKb152FQimp1T2wZb+GGvuUYykgCLszN3VtJW8Lzk4A5U
	I7HWRPBi6JP+TQUFwkIhfciFA57j87zbbzYyjAm85/XKFLKNDHEaIovIzqXa5vwraVeJilH+RIe5m
	eHQCATVnjsYDQz4I6tW/xtza4HMqyNN3M3/QWvIp7iiSqaDuctm2odTrkTJ0rdobU+uL9iBncrkK9
	qn/+5T6Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vholQ-0000000DJVY-0Yog;
	Mon, 19 Jan 2026 12:53:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A58743006CD; Mon, 19 Jan 2026 13:53:47 +0100 (CET)
Date: Mon, 19 Jan 2026 13:53:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/15] sched/idle: Handle offlining first in idle loop
Message-ID: <20260119125347.GT830755@noisy.programming.kicks-ass.net>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116145208.87445-2-frederic@kernel.org>

On Fri, Jan 16, 2026 at 03:51:54PM +0100, Frederic Weisbecker wrote:

>  kernel/sched/idle.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index c174afe1dd17..35d79af3286d 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -260,6 +260,12 @@ static void do_idle(void)
>  {
>  	int cpu = smp_processor_id();
>  
> +	if (cpu_is_offline(cpu)) {

Does it make sense to make that: if (unlikely(cpu_is_offline(cpu))) ?

> +		local_irq_disable();

Also, do we want something like:

		WARN_ON_ONCE(need_resched());

?

> +		cpuhp_report_idle_dead();
> +		arch_cpu_idle_dead();
> +	}
> +
>  	/*
>  	 * Check if we need to update blocked load
>  	 */
> @@ -311,11 +317,6 @@ static void do_idle(void)
>  		 */
>  		local_irq_disable();
>  
> -		if (cpu_is_offline(cpu)) {
> -			cpuhp_report_idle_dead();
> -			arch_cpu_idle_dead();
> -		}
> -
>  		arch_cpu_idle_enter();
>  		rcu_nocb_flush_deferred_wakeup();
>  
> -- 
> 2.51.1
> 

