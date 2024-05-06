Return-Path: <linux-pm+bounces-7521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC728BCB95
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 12:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D701A1F22D1E
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE936142629;
	Mon,  6 May 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zt7VphGZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BDB4205F;
	Mon,  6 May 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989927; cv=none; b=CuDlAJGIWJ1nYIj9OfbUbA5TIYesrpo6AtCqIZHUTMOrZoewcYX/sqAD4Z4bFlOy+wZ6dJ4ANSj+7FR95o3oFS8XezR5QrAPzyHUMTo1uhUWFL6ma9gbNALe7R/yH7E1bWYVbLxriPRX80w8sBeTZqq7xjQQ+oxYYVlppzos5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989927; c=relaxed/simple;
	bh=PMC3ofutk9JYD37ah6GDWluGJeD9/vKLh7tqGvV6Wko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKloFXxTPohlxEc+75kiLDGB+EdDV84rmv4hd1oftwtvVrEJ7d/oLX0YWQ/gMwVr+vRjLI8PMuII+x+ITjlAh1M0g+OkhwhhD9URLhag2yxYhLZZaj4n/EMgcq3Wn1Dt/vda8MId8v4J0gTkuM2aDQbid5poTSyLFy0MYc5MFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zt7VphGZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gujvUI0jJiy6Uc9SM3tuP8isJLFkBNShH34rayX/gjo=; b=Zt7VphGZw/XbV3in9sMkbdqs6i
	DwJx/nLZJJZCbciPUllM2ReQnRuJd1CtECfrw1HqokhXeznibZE0ZCacmim4zEzhaJ18FnWX+mRCQ
	+0NaOR8bpvR1InY533f+A7kHhx42/RvF5D5tDqIzQapK6sm7TK4d5qAZcmnnwt5q+4EN45F4zJTtn
	VslpYSI5iUN/GUdaUig2QP+B2/lDr4D5dqtag/FHzN1tu4yl0U1ENY3kOFqVjmPx0pRsIanlBMZiZ
	PtMvVhveUCGLc/GOkRsNhADWH6soXkJ1IOpIoR8C5C+1ACx8PA3il82I+dWRHun3x8K+u7lwIYYm0
	+i1jChLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3vDZ-00000001fVA-1ytr;
	Mon, 06 May 2024 10:05:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1A972300362; Mon,  6 May 2024 12:05:09 +0200 (CEST)
Date: Mon, 6 May 2024 12:05:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
Message-ID: <20240506100509.GL40213@noisy.programming.kicks-ass.net>
References: <20240505233103.168766-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505233103.168766-1-qyousef@layalina.io>

On Mon, May 06, 2024 at 12:31:03AM +0100, Qais Yousef wrote:

> +static inline void update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> +{
> +#ifdef CONFIG_CPU_FREQ
> +	unsigned int flags = 0;
> +
> +#ifdef CONFIG_SMP
> +	if (unlikely(current->sched_class == &stop_sched_class))
> +		return;
> +#endif

why do we care about the stop class? It shouldn't, in general, consume a
lot of cycles.

> +
> +	if (unlikely(current->sched_class == &idle_sched_class))
> +		return;

And why do we care about idle? Specifically this test doesn't capture
force-idle threads. Notably see is_idle_task().

> +
> +	if (unlikely(task_has_idle_policy(current)))
> +		return;
> +
> +	if (likely(fair_policy(current->policy))) {
> +
> +		if (unlikely(current->in_iowait)) {
> +			flags |= SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE;
> +			goto force_update;
> +		}
> +
> +#ifdef CONFIG_SMP
> +		/*
> +		 * Allow cpufreq updates once for every update_load_avg() decay.
> +		 */
> +		if (unlikely(rq->cfs.decayed)) {
> +			rq->cfs.decayed = false;
> +			goto force_update;
> +		}
> +#endif
> +		return;
> +	}
> +
> +	/*
> +	 * RT and DL should always send a freq update. But we can do some
> +	 * simple checks to avoid it when we know it's not necessary.
> +	 */
> +	if (rt_task(current) && rt_task(prev)) {

IIRC dl tasks also match rt_task, so your else clause might not work the
way you've intended.

> +#ifdef CONFIG_UCLAMP_TASK
> +		unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> +		unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);
> +
> +		if (curr_uclamp_min == prev_uclamp_min)
> +#endif
> +			return;
> +	} else if (dl_task(current) && current->dl.flags & SCHED_FLAG_SUGOV) {

Notably DL tasks also match rt_task(), so I don't think this clause
exactly does as you expect. Also, isn't the flags check sufficient on
it's own?

> +		/* Ignore sugov kthreads, they're responding to our requests */
> +		return;
> +	}
> +
> +	flags |= SCHED_CPUFREQ_FORCE_UPDATE;
> +
> +force_update:
> +	cpufreq_update_util(rq, flags);
> +#endif
> +}

But over-all the thing seems very messy, mixing sched_class, policy and
prio based selection methods.

Can't this be cleaned up somewhat?


Notably, if you structure it something like so:

	if (fair_policy(current)) {
		...
		return;
	}

	if (rt_policy(current)) {
		if (dl_task(current) && current->dl.flags & SCHED_FLAG_SUGOV)
			return;
		if (rt_policy(prev) && uclamps_match(current, prev))
			return;
		...
		return;
	}

	/* everybody else gets nothing */
	return;

You get a lot less branches in the common paths, no?




