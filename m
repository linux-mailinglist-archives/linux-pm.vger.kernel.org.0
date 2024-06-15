Return-Path: <linux-pm+bounces-9217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E8690953C
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 03:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE171F22779
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 01:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E801FBA;
	Sat, 15 Jun 2024 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RLQe84rk"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9E635;
	Sat, 15 Jun 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718415187; cv=none; b=t8Xex6hsFjl/YtcUj4YU6DwZY5ybRCaHgljxeTAU07eImwFuIn/OP2BWSpTPItwFXl43C6OmMU5iDFmvJPJejx7hUkV4mYT5tM0E3lS+RqIGjz6U4AggqJjmKrzSboLoAyWaGqBz3W4bua2e9gMhIKiqW+Lilwh2YmKooqP6RK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718415187; c=relaxed/simple;
	bh=Xh7AdXgv/aZzKyDmpw0/NDBq3/G/9OvoRMbZ/oWAU9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCPZ+P0AN8/Jbf2nSf4X5UAQHLxFLzmJ9GdKC3gIHoKGhVrmJear2kNEMESf4H9rNRBNaSVgyl8yzCDBkeMrRNZNMmkgiNXa78PhvrTXHbJOPMg0788B+rEyPCbFFipI55f4tyUHQSvuC+89Yu+2P4kdR6+49ZN/FYgBVjaYf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RLQe84rk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y0phalDzwYFs8lOrqhipjQWwNuUXcfzj94wo5TNk17A=; b=RLQe84rkn970WmvW1CB2vk/p+q
	LKzvD3FueaTYqaUyoIjHwTLzdZpiQZX0Db5yaDt/7g3R84yvctFj5Y1f3fz3eMUP441qgwpEaKEBy
	uybAzncGU/4WaApsPGLpfqUSpLwuHG1gEBsYy4Q16EVnqWw7OiVOFVrl0mQJpz4mqdZ+ZMb7c+EP/
	rKXjz536Xg15bGsrK1Y3SH+oy4TcsoDozh19Oz9pEqnxHczNBZkZS58RCetpBwmr9JhyBcqWYxT2o
	VtF9t7WsAScSR0FpkYV4ILbgkrcsmKIoBN5eIyVIUTO5Mm7H2/1DvgUefWqNkvTLbx7Z0rCJFxcAj
	qyJ2FuWg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIIDc-00000004hKr-0l05;
	Sat, 15 Jun 2024 01:30:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D1279300886; Sat, 15 Jun 2024 03:28:14 +0200 (CEST)
Date: Sat, 15 Jun 2024 03:28:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20240615012814.GP8774@noisy.programming.kicks-ass.net>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
 <20240614092801.GL8774@noisy.programming.kicks-ass.net>
 <CAKfTPtBTxhbmh=605TJ9sRw-nFu6w-KY7QpAxRUh5AjhQWa2ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBTxhbmh=605TJ9sRw-nFu6w-KY7QpAxRUh5AjhQWa2ig@mail.gmail.com>

On Fri, Jun 14, 2024 at 12:48:37PM +0200, Vincent Guittot wrote:
> On Fri, 14 Jun 2024 at 11:28, Peter Zijlstra <peterz@infradead.org> wrote:

> > > Vincent [5] pointed out a case where the idle load kick will fail to
> > > run on an idle CPU since the IPI handler launching the ILB will check
> > > for need_resched(). In such cases, the idle CPU relies on
> > > newidle_balance() to pull tasks towards itself.
> >
> > Is this the need_resched() in _nohz_idle_balance() ? Should we change
> > this to 'need_resched() && (rq->nr_running || rq->ttwu_pending)' or
> > something long those lines?
> 
> It's not only this but also in do_idle() as well which exits the loop
> to look for tasks to schedule

Is that really a problem? Reading the initial email the problem seems to
be newidle balance, not hitting schedule. Schedule should be fairly
quick if there's nothing to do, no?

> > I mean, it's fairly trivial to figure out if there really is going to be
> > work there.
> >
> > > Using an alternate flag instead of NEED_RESCHED to indicate a pending
> > > IPI was suggested as the correct approach to solve this problem on the
> > > same thread.
> >
> > So adding per-arch changes for this seems like something we shouldn't
> > unless there really is no other sane options.
> >
> > That is, I really think we should start with something like the below
> > and then fix any fallout from that.
> 
> The main problem is that need_resched becomes somewhat meaningless
> because it doesn't  only mean "I need to resched a task" and we have
> to add more tests around even for those not using polling

True, however we already had some of that by having the wakeup list,
that made nr_running less 'reliable'.

The thing is, most architectures seem to have the TIF_POLLING_NRFLAG
bit, even if their main idle routine isn't actually using it, much of
the idle loop until it hits the arch idle will be having it set and will
thus tickle these cases *sometimes*.

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0935f9d4bb7b..cfa45338ae97 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5799,7 +5800,7 @@ static inline struct task_struct *
> >  __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  {
> >         const struct sched_class *class;
> > -       struct task_struct *p;
> > +       struct task_struct *p = NULL;
> >
> >         /*
> >          * Optimization: we know that if all tasks are in the fair class we can
> > @@ -5810,9 +5811,11 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >         if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
> >                    rq->nr_running == rq->cfs.h_nr_running)) {
> >
> > -               p = pick_next_task_fair(rq, prev, rf);
> > -               if (unlikely(p == RETRY_TASK))
> > -                       goto restart;
> > +               if (rq->nr_running) {
> 
> How do you make the diff between a spurious need_resched() because of
> polling and a cpu becoming idle ? isn't rq->nr_running null in both
> cases ?

Bah, true. It should also check current being idle, which then makes a
mess of things again. Still, we shouldn't be calling newidle from idle,
that's daft.

I should probably not write code at 3am, but the below horror is what
I came up with.

---

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d4bb7b..cfe8d3350819 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6343,19 +6344,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Constants for the sched_mode argument of __schedule().
  *
  * The mode argument allows RT enabled kernels to differentiate a
- * preemption from blocking on an 'sleeping' spin/rwlock. Note that
- * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
- * optimize the AND operation out and just check for zero.
+ * preemption from blocking on an 'sleeping' spin/rwlock.
  */
-#define SM_NONE			0x0
-#define SM_PREEMPT		0x1
-#define SM_RTLOCK_WAIT		0x2
-
-#ifndef CONFIG_PREEMPT_RT
-# define SM_MASK_PREEMPT	(~0U)
-#else
-# define SM_MASK_PREEMPT	SM_PREEMPT
-#endif
+#define SM_IDLE			(-1)
+#define SM_NONE			0
+#define SM_PREEMPT		1
+#define SM_RTLOCK_WAIT		2
 
 /*
  * __schedule() is the main scheduler function.
@@ -6396,11 +6390,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *
  * WARNING: must be called with preemption disabled!
  */
-static void __sched notrace __schedule(unsigned int sched_mode)
+static void __sched notrace __schedule(int sched_mode)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
 	unsigned long prev_state;
+	bool preempt = sched_mode > 0;
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
@@ -6409,13 +6404,13 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
-	schedule_debug(prev, !!sched_mode);
+	schedule_debug(prev, preempt);
 
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
 		hrtick_clear(rq);
 
 	local_irq_disable();
-	rcu_note_context_switch(!!sched_mode);
+	rcu_note_context_switch(preempt);
 
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -6449,7 +6444,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	 * that we form a control dependency vs deactivate_task() below.
 	 */
 	prev_state = READ_ONCE(prev->__state);
-	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
+	if (sched_mode == SM_IDLE) {
+		if (!rq->nr_running) {
+			next = prev;
+			goto picked;
+		}
+	} else if (!preempt && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
@@ -6483,6 +6483,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -6521,9 +6522,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
+		trace_sched_switch(preempt, prev, next, prev_state);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
@@ -6599,7 +6601,7 @@ static void sched_update_worker(struct task_struct *tsk)
 	}
 }
 
-static __always_inline void __schedule_loop(unsigned int sched_mode)
+static __always_inline void __schedule_loop(int sched_mode)
 {
 	do {
 		preempt_disable();
@@ -6644,7 +6646,7 @@ void __sched schedule_idle(void)
 	 */
 	WARN_ON_ONCE(current->__state);
 	do {
-		__schedule(SM_NONE);
+		__schedule(SM_IDLE);
 	} while (need_resched());
 }
 

