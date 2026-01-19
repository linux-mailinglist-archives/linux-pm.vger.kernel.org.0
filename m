Return-Path: <linux-pm+bounces-41139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64356D3BA4E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 23:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DABE3048EF3
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 22:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E14246781;
	Mon, 19 Jan 2026 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBzzATy6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627881917ED;
	Mon, 19 Jan 2026 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768860038; cv=none; b=n09AkiYjmoQmI0I2vD28hNxVsXzYVxPyu32s8Xm8eF7/uemw04EB7eOorVw5rPE4FZfPxcVPGwHpASUPWV6HIhTq8P5GeIG2GgquUjymbMBcUnBThGggQGJZ/kOzbY07ktBNWfKwgI/Fs8MfIlkIIyN5Pf2m683Fteh6v7jss3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768860038; c=relaxed/simple;
	bh=i93O1wnS4zj4pX0251MiaGhsQUiCSCNVJWX9Zn2+X7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLKS1eDy1aqLQ0Wli6ItUbAzcdtS4A6ADKZQsIBuyZnGwgqLAPMgWJ6Dm0WCPvhzgV8zQipiEuT0JgS8YshoD3Yg5Li/OmGY4pAFNG/FdNdWxevpUFLL5PJ1GeF6WSm5W/R78WIkeHzOc1jCcj045uN4Rf2wd10gbcitVMN+0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBzzATy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633DEC116C6;
	Mon, 19 Jan 2026 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768860037;
	bh=i93O1wnS4zj4pX0251MiaGhsQUiCSCNVJWX9Zn2+X7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBzzATy65nCqBqK20u1xQ84huXMH+axu3TXK2L6DC5nd8yziq+TvpuslsmRRobeQT
	 VH7SNLOdLeNcBRj6UUrfbhXFwGgiKoYEVpjMnlb01pfhCGyz7OXEafYW++2K6D93/o
	 FYjzCNlDytNmD4UlzSxcoJdOsxCYn+Z/kz4RlVnQcK5VoZRLga2nmSopJTVQ/YQZ4k
	 dXpEOBgNjZJRJGZ8eFREAdqzrfDqVXrgs/zrjSZSTezsgrTa1GMy5eBjt31vzYB0GM
	 /hOWyVZ3Xz97w+bSw11NPtmhbdCmx3cxXFkj36kBjpJGxbQzNx0ugkqbn5P/9S2WfF
	 SWgWuYyaLSlRw==
Date: Mon, 19 Jan 2026 23:00:35 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH 06/15] tick/sched: Unify idle cputime accounting
Message-ID: <aW6pgzarQ-tnPjl6@pavilion.home>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-7-frederic@kernel.org>
 <20260119142607.GG830229@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119142607.GG830229@noisy.programming.kicks-ass.net>

Le Mon, Jan 19, 2026 at 03:26:07PM +0100, Peter Zijlstra a écrit :
> On Fri, Jan 16, 2026 at 03:51:59PM +0100, Frederic Weisbecker wrote:
> 
> > +#ifdef CONFIG_NO_HZ_COMMON
> > +void kcpustat_dyntick_start(void)
> > +{
> > +	if (!vtime_generic_enabled_this_cpu()) {
> > +		vtime_dyntick_start();
> > +		__this_cpu_write(kernel_cpustat.idle_dyntick, 1);
> > +	}
> > +}
> 
> Why don't we need to make sure steal time is up-to-date at this point?

Yes, there could be steal time since the last tick. It will be included
and accounted in kcpustat_dyntick_stop() and not substracted from system
or idle cputime (but it should!). This wrong behaviour is the same as the
current upstream behaviour. So no known regression.

But check the last patch of the series that tries to fix that:

    sched/cputime: Handle dyntick-idle steal time correctly

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

