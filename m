Return-Path: <linux-pm+bounces-41110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 704FED3AC07
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 15:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC81C317B626
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA1538757D;
	Mon, 19 Jan 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="phVpzmPF"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087F37B3FD;
	Mon, 19 Jan 2026 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832784; cv=none; b=swvSPb6XAOCAXcRGZmUAhF3o0B+EOGhQOygkzE1diDuzEQhwthyV2VFVm6Ui8AJ6eNyBu9W2cUd5PGYxCWl6ll3awrRiOiWof5/Kh4oYQ2y/PXz7NFYpK9lkmJpJHzEfx9ApgVgeOucsuzK73XvEOSEtFW6TmmXkzAO5XLszbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832784; c=relaxed/simple;
	bh=m6aD/X2y0FNcAmZ9GWybNcS/CHc+XooX2ctcxGXuAmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2M+PEAyyQ/k+8xivTbiBtcOTWdu8gtv3ZJC+W+pigQQX6vMZJELJipu5AQ2U6xzYk1pWoeUZETM8M7pslUeV6MSaDMufZh9RkmV8JNmuIK/FrsJxDZfmeCnfORjp/pdfw8bAKCzVHB1/6IICWQW4YMJOZUcDqZ0C1bJDYHY0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=phVpzmPF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J7YR6Ss4GR1p+SXEIbKvrV+9SeOL7XVCLDPQxRbp/9Q=; b=phVpzmPFu1Lg5Wwsu+BOkmfOW+
	7MEiiANgQ2k/WAjssImTBsBtsTReEql3LfWeR3eFCTJMcXjNSQuIO7LbmizlIxbjd7SrLLSKCcBSp
	aDO/nN6wrUdvONoFpb1boJnDyyb9lER3VTnG9922Knms3+B9j6HFUVGinLdmiEyvhWAyM1emPfId0
	3ejQrUhO0sHyp8rUFpwu26JS3ZZq0CPSKVHkIzEgF64hdM1+c+1BQTsyQUJrF/KtLBbP6GFbLLb2j
	Jm6wiXTO8fSdUEnK92SIQIyQQDwiIUBCAg2WEYqWULtN4+kC03qtQtM6yeOYdsHHp/DqXmbnbADUG
	Oa7LNwWA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhqCm-0000000CGLf-3TCN;
	Mon, 19 Jan 2026 14:26:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DA8703006CD; Mon, 19 Jan 2026 15:26:07 +0100 (CET)
Date: Mon, 19 Jan 2026 15:26:07 +0100
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
Subject: Re: [PATCH 06/15] tick/sched: Unify idle cputime accounting
Message-ID: <20260119142607.GG830229@noisy.programming.kicks-ass.net>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-7-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116145208.87445-7-frederic@kernel.org>

On Fri, Jan 16, 2026 at 03:51:59PM +0100, Frederic Weisbecker wrote:

> +#ifdef CONFIG_NO_HZ_COMMON
> +void kcpustat_dyntick_start(void)
> +{
> +	if (!vtime_generic_enabled_this_cpu()) {
> +		vtime_dyntick_start();
> +		__this_cpu_write(kernel_cpustat.idle_dyntick, 1);
> +	}
> +}

Why don't we need to make sure steal time is up-to-date at this point?

> +void kcpustat_dyntick_stop(void)
> +{
> +	if (!vtime_generic_enabled_this_cpu()) {
> +		__this_cpu_write(kernel_cpustat.idle_dyntick, 0);
> +		vtime_dyntick_stop();
> +		steal_account_process_time(ULONG_MAX);
> +	}
> +}
> +#endif /* CONFIG_NO_HZ_COMMON */

