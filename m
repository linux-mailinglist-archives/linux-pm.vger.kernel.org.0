Return-Path: <linux-pm+bounces-9148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FCD908766
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DC21C22EB0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ECB1922E2;
	Fri, 14 Jun 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u/iXU3Cu"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3C2AEE9;
	Fri, 14 Jun 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357294; cv=none; b=WmumhJpjWXEmclV1y3HLvPRj23EBAv+aOS49Pzqn6Vb/nCXE9g6C5cicFNjaDnfyqSoRU0YDUj7kksdSxwO81OSlEOHE16NiSCyfQmw5sNMoG4k3q5k5ObfkzwyWghPYKOCX3ADDs6WFc1imVfUdAjXA6qa0pAHBJsi0JvQH1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357294; c=relaxed/simple;
	bh=prViNruXaplkIxh+X59Uxa4c4C3WYXYBdnkSq4UnATM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2IEEyH24r4Bhv99HXHKIxHx7Xv8DgKmS2rOWbTwOti2XTGVIY4otWoeN5/eduUDLbijP37byBmcz7RXWdeH5lFNpkzB1UNPOkMSOxsSAYq0wrfk9F4ke5kigrASO5NiaRnwvbF8aW7jSS/y6+o/NzN/N7kbenAsOkIVzqgBqKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u/iXU3Cu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k5Jozg+gaCeSQ8tXyXAfQ8zvUH35mGnejlLYGUNU73c=; b=u/iXU3CuapkrBpGgNpXL7oKWw2
	akDjIAg46tPSfA09potIFN7iNNRLBOcOWOruqnNqrpF1A3vztyYK1CNKi+YApQjX3TSGtWpbWvyjk
	2QqPlMXSDtQKcOldgtX8kcSD5J30dKJYqKq6+Uz9Dpx2rr4E2LSxU/hTB06ppUtiMhmkFRH1tWGFL
	SfzhC+xbBy+GIFrMIMF6R5HPq1V6egCAlbsXOj1XPxLUL9MBd97xrATfvTJKkPgIW/99fc5N3cCoO
	8Ohm27l1SS86ljlIsb/2oqUYH2Fu/E6Ki2TnRAQh7OggP52Coo4MDKT6lhmrwNRr9/Jrmz4YKJWVc
	W386n8dQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI3E1-0000000GowQ-3hJA;
	Fri, 14 Jun 2024 09:28:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2A6ED300886; Fri, 14 Jun 2024 11:28:01 +0200 (CEST)
Date: Fri, 14 Jun 2024 11:28:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Xin Li <xin3.li@intel.com>, Kees Cook <keescook@chromium.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tony Battersby <tonyb@cybernetics.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Brian Gerst <brgerst@gmail.com>, Leonardo Bras <leobras@redhat.com>,
	Imran Khan <imran.f.khan@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	David Vernet <void@manifault.com>,
	Julia Lawall <julia.lawall@inria.fr>, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-pm@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 00/14] Introducing TIF_NOTIFY_IPI flag
Message-ID: <20240614092801.GL8774@noisy.programming.kicks-ass.net>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613181613.4329-1-kprateek.nayak@amd.com>

On Thu, Jun 13, 2024 at 06:15:59PM +0000, K Prateek Nayak wrote:
> Effects of call_function_single_prep_ipi()
> ==========================================
> 
> To pull a TIF_POLLING thread out of idle to process an IPI, the sender
> sets the TIF_NEED_RESCHED bit in the idle task's thread info in
> call_function_single_prep_ipi() and avoids sending an actual IPI to the
> target. As a result, the scheduler expects a task to be enqueued when
> exiting the idle path. This is not the case with non-polling idle states
> where the idle CPU exits the non-polling idle state to process the
> interrupt, and since need_resched() returns false, soon goes back to
> idle again.
> 
> When TIF_NEED_RESCHED flag is set, do_idle() will call schedule_idle(),
> a large part of which runs with local IRQ disabled. In case of ipistorm,
> when measuring IPI throughput, this large IRQ disabled section delays
> processing of IPIs. Further auditing revealed that in absence of any
> runnable tasks, pick_next_task_fair(), which is called from the
> pick_next_task() fast path, will always call newidle_balance() in this
> scenario, further increasing the time spent in the IRQ disabled section.
> 
> Following is the crude visualization of the problem with relevant
> functions expanded:
> --
> CPU0							CPU1
> ====							====
> 							do_idle() {
> 								__current_set_polling();
> 								...
> 								monitor(addr);
> 								if (!need_resched())
> 									mwait() {
> 									/* Waiting */
> smp_call_function_single(CPU1, func, wait = 1) {				...
> 	...									...
> 	set_nr_if_polling(CPU1) {						...
> 		/* Realizes CPU1 is polling */					...
> 		try_cmpxchg(addr,						...
> 			    &val,						...
> 			    val | _TIF_NEED_RESCHED);				...
> 	} /* Does not send an IPI */						...
> 	...								} /* mwait exit due to write at addr */
> 	csd_lock_wait() {					} 
> 	/* Waiting */						preempt_set_need_resched();
> 		...						__current_clr_polling();
> 		...						flush_smp_call_function_queue() {
> 		...							func();
> 	} /* End of wait */					}
> }								schedule_idle() {
> 									...
> 									local_irq_disable();
> smp_call_function_single(CPU1, func, wait = 1) {			...
> 	...								...
> 	arch_send_call_function_single_ipi(CPU1);			...
> 						\			...
> 						 \			newidle_balance() {
> 						  \				...
> 					      /* Delay */			...
> 						    \			}
> 					     	     \			...
> 						      \-------------->	local_irq_enable();
> 									/* Processes the IPI */
> --
> 
> 
> Skipping newidle_balance()
> ==========================
> 
> In an earlier attempt to solve the challenge of the long IRQ disabled
> section, newidle_balance() was skipped when a CPU waking up from idle
> was found to have no runnable tasks, and was transitioning back to
> idle [2]. Tim [3] and David [4] had pointed out that newidle_balance()
> may be viable for CPUs that are idling with tick enabled, where the
> newidle_balance() has the opportunity to pull tasks onto the idle CPU.

I don't think we should be relying on this in any way shape or form.
NOHZ can kill that tick at any time.

Also, semantically, calling newidle from the idle thread is just daft.
You're really not newly idle in that case.

> Vincent [5] pointed out a case where the idle load kick will fail to
> run on an idle CPU since the IPI handler launching the ILB will check
> for need_resched(). In such cases, the idle CPU relies on
> newidle_balance() to pull tasks towards itself.

Is this the need_resched() in _nohz_idle_balance() ? Should we change
this to 'need_resched() && (rq->nr_running || rq->ttwu_pending)' or
something long those lines?

I mean, it's fairly trivial to figure out if there really is going to be
work there.

> Using an alternate flag instead of NEED_RESCHED to indicate a pending
> IPI was suggested as the correct approach to solve this problem on the
> same thread.

So adding per-arch changes for this seems like something we shouldn't
unless there really is no other sane options.

That is, I really think we should start with something like the below
and then fix any fallout from that.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d4bb7b..cfa45338ae97 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5799,7 +5800,7 @@ static inline struct task_struct *
 __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	const struct sched_class *class;
-	struct task_struct *p;
+	struct task_struct *p = NULL;
 
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
@@ -5810,9 +5811,11 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
 		   rq->nr_running == rq->cfs.h_nr_running)) {
 
-		p = pick_next_task_fair(rq, prev, rf);
-		if (unlikely(p == RETRY_TASK))
-			goto restart;
+		if (rq->nr_running) {
+			p = pick_next_task_fair(rq, prev, rf);
+			if (unlikely(p == RETRY_TASK))
+				goto restart;
+		}
 
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {

