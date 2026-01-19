Return-Path: <linux-pm+bounces-41141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A6AD3BA77
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 23:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B85B93024251
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 22:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB01917ED;
	Mon, 19 Jan 2026 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln4zoHyb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC35270552;
	Mon, 19 Jan 2026 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768860521; cv=none; b=ofPgYFjzcN3WddnOMzliEtDlp/Pyg+wofkjCJ5ESfDzWDvBEMP1qjyZuyFMXKWXeE1sJpW/BzbS3FFxfd7pWZPWOEPagGTomAkciV0azZXS96DNiF86cmCNJRO2Sp4epv5x39d+HkusAPh3MwqvceBF60J5cBkSXMiSWsKjqnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768860521; c=relaxed/simple;
	bh=Dq7zNmSBxvYzTIrpwfT5zYA1DLiTkgJDeC+0bnh2J04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmFNCnCyAkZa8BxIXIdvdu839a+xERy+dzClXM9vr/3ws68nrnn8UMP5qvR3l5TcmHavEGV0vGkHEaY0no8Wh3zkbNcfDv8MDIn2EJ74FOHbp6deTBf4upiPXL6hxdRynjAPi0m6HnaCs1WC8EpSiAIzvZq6nCZmL/xVmKYZXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln4zoHyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FD9C116C6;
	Mon, 19 Jan 2026 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768860521;
	bh=Dq7zNmSBxvYzTIrpwfT5zYA1DLiTkgJDeC+0bnh2J04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ln4zoHybgtMECcMyqTx/LWGdBOdmyQ98YoneXE9EGheywR/7S8ye4vXbfT9yDYJEM
	 S5GlBxDyxN2QrdY7c7iUdriMrKmDEZBpK9EHhE1jbaNmzlOnl7z350fli+/P8io2cF
	 BlL2DPk7J60CaQUC2Km6nBry5cYb0NK5UjkImi23pySq3aKB1csMZTAtkiwI7nc68i
	 +xX9SF9/zKhiFtfJGgOYjnl4mOIthtugE+sTkgZMRaluThUrDaE53POwUX8EZ5fHui
	 cvMGnW5M89d38Q29Hn1c8PM0+KsTGcaISgLw9Zh2pdm/WWjfogFCxcUK7jWoyu3sSB
	 FeTFC8XVggahA==
Date: Mon, 19 Jan 2026 23:08:38 +0100
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
Subject: Re: [PATCH 09/15] tick/sched: Move dyntick-idle cputime accounting
 to cputime code
Message-ID: <aW6rZsjZidC6wXJS@pavilion.home>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-10-frederic@kernel.org>
 <20260119143552.GH830229@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119143552.GH830229@noisy.programming.kicks-ass.net>

Le Mon, Jan 19, 2026 at 03:35:52PM +0100, Peter Zijlstra a écrit :
> On Fri, Jan 16, 2026 at 03:52:02PM +0100, Frederic Weisbecker wrote:
> 
> > +static void kcpustat_idle_stop(struct kernel_cpustat *kc, ktime_t now)
> >  {
> > +	u64 *cpustat = kc->cpustat;
> > +	ktime_t delta;
> > +
> > +	if (!kc->idle_elapse)
> > +		return;
> > +
> > +	delta = ktime_sub(now, kc->idle_entrytime);
> > +
> > +	write_seqcount_begin(&kc->idle_sleeptime_seq);
> > +	if (nr_iowait_cpu(smp_processor_id()) > 0)
> > +		cpustat[CPUTIME_IOWAIT] = ktime_add(cpustat[CPUTIME_IOWAIT], delta);
> > +	else
> > +		cpustat[CPUTIME_IDLE] = ktime_add(cpustat[CPUTIME_IDLE], delta);
> > +
> > +	kc->idle_entrytime = now;
> > +	kc->idle_elapse = false;
> > +	write_seqcount_end(&kc->idle_sleeptime_seq);
> >  }
> 
> I realize this is mostly code movement; but do we really want to
> preserve ktime_{sub,add}() and all that?
> 
> I mean, we killed that 32bit ktime nonsense ages ago.

Good point, this should just be u64.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

