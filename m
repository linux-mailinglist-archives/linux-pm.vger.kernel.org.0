Return-Path: <linux-pm+bounces-41118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C209D3AC75
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 15:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E17E302EECF
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA923ABBD;
	Mon, 19 Jan 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2HzY/XR"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0107522A4E9;
	Mon, 19 Jan 2026 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833369; cv=none; b=S8pdoJ5TNgjlRxwdaX1rlXK0RTWPHjs8qomG0zHqtEfsU0gPTRC0Rna4+E1xH0ekNdROTYOPSuArhEJRwHugr7k4097rctt7RzvtCIPtz0Po1s0PavJOPmKSYiOYra/gtrX8BSbmsYrn7ihiaORVatzwW9zLvEWwvakfexmkBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833369; c=relaxed/simple;
	bh=ntm+khmj31hDPtEYjX20KmZZmZzQw0TMZe6p5iXV14Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrpB7M3iRoNhGpRa6dRitOKQgp5rvwB6soe9sH3NUPQpk9KuWT5tmuxlF2wMlJ3TO93AaNQJ/X4FO4/IajWQXnlgUAlOtBw5pJ74kRsRr9OMmS7ChmPCYI0fnPeznkajoE+9GAIcS7h7WYePqopVtCc9uXHBD2RnhzYiJOmJ39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S2HzY/XR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TX9AK0WImvqy6dbeoXuKKxGGurru6lbB0iFY3euRVeA=; b=S2HzY/XR2q1WCyKLHrFfbS4AxR
	et3K2ZgiAkkP63sYcmvG204nTiWLK0kC3G2PJf6V1KiEUkEeoUezCOh2cnhMiN2s9yjXIHfQoDoHw
	Z90M+Sy8CpezVCfXRh90k543tDcFttQuVEdYT+e/CZKRmgHRPfry/p67XsGwUAQKyrw3tjBPeyjfu
	Xgn1MvzIeMr63yFZdT4arLMfequ48RPuquozifiDFof8bLDa3iemT3EX5mvDbq3wDHJlnpYi064W1
	JHHGkuZ9k7ZQyU5s+uf8z0TG70YZ2y9Q+Z+D8NJClTlgadNZMLaImy6JIizLm9bibrVJ6gAhATKxJ
	RI0mrhLQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhqMD-0000000CHyO-1Lbz;
	Mon, 19 Jan 2026 14:35:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D83BB3006CD; Mon, 19 Jan 2026 15:35:52 +0100 (CET)
Date: Mon, 19 Jan 2026 15:35:52 +0100
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
Subject: Re: [PATCH 09/15] tick/sched: Move dyntick-idle cputime accounting
 to cputime code
Message-ID: <20260119143552.GH830229@noisy.programming.kicks-ass.net>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-10-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116145208.87445-10-frederic@kernel.org>

On Fri, Jan 16, 2026 at 03:52:02PM +0100, Frederic Weisbecker wrote:

> +static void kcpustat_idle_stop(struct kernel_cpustat *kc, ktime_t now)
>  {
> +	u64 *cpustat = kc->cpustat;
> +	ktime_t delta;
> +
> +	if (!kc->idle_elapse)
> +		return;
> +
> +	delta = ktime_sub(now, kc->idle_entrytime);
> +
> +	write_seqcount_begin(&kc->idle_sleeptime_seq);
> +	if (nr_iowait_cpu(smp_processor_id()) > 0)
> +		cpustat[CPUTIME_IOWAIT] = ktime_add(cpustat[CPUTIME_IOWAIT], delta);
> +	else
> +		cpustat[CPUTIME_IDLE] = ktime_add(cpustat[CPUTIME_IDLE], delta);
> +
> +	kc->idle_entrytime = now;
> +	kc->idle_elapse = false;
> +	write_seqcount_end(&kc->idle_sleeptime_seq);
>  }

I realize this is mostly code movement; but do we really want to
preserve ktime_{sub,add}() and all that?

I mean, we killed that 32bit ktime nonsense ages ago.

> -static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
> -{
> -	u64 *cpustat = kcpustat_this_cpu->cpustat;
> -	ktime_t delta;
> -
> -	if (vtime_generic_enabled_this_cpu())
> -		return;
> -
> -	if (WARN_ON_ONCE(!tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)))
> -		return;
> -
> -	delta = ktime_sub(now, ts->idle_entrytime);
> -
> -	write_seqcount_begin(&ts->idle_sleeptime_seq);
> -	if (nr_iowait_cpu(smp_processor_id()) > 0)
> -		cpustat[CPUTIME_IOWAIT] = ktime_add(cpustat[CPUTIME_IOWAIT], delta);
> -	else
> -		cpustat[CPUTIME_IDLE] = ktime_add(cpustat[CPUTIME_IDLE], delta);
> -
> -	ts->idle_entrytime = now;
> -	tick_sched_flag_clear(ts, TS_FLAG_IDLE_ACTIVE);
> -	write_seqcount_end(&ts->idle_sleeptime_seq);
> -
> -	sched_clock_idle_wakeup_event();
> -}

