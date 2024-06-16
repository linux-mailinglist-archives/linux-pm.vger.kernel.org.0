Return-Path: <linux-pm+bounces-9256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B496909E01
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 16:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168541F218FF
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93D12E47;
	Sun, 16 Jun 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTWk6Jr4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DB125B9
	for <linux-pm@vger.kernel.org>; Sun, 16 Jun 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718549851; cv=none; b=i36LsMcrljVvYu7FrHdduM8cKHaZJvZrgZNNdFb9A037IBNOynogtOwuEM9bDdc5Jd082LAoUXNMdJSAUaWD/rCSoKZC02KEMNJTvLuStTtKGuoTuKkWk5D8QJkRug2kQAFiCaM+T+g0v/IAW5MchNuOoo071Xn3vz5inq3i3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718549851; c=relaxed/simple;
	bh=utvuP9IoAszxWoU3ajATZDQZ4+EdgvtsV0c8Mt+Ezag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7KQFhE94IWzEXh7ByrUFojsMSSe6uj9q7M+lwa4CtVB7VxAaAYNyNH1dJa4ddSBw7XX8r8IApflux56B0ypyE+N2XtY3eWmf8VffSgka9frQaLY3nLudXD7UoFmKUrNyz5RQVsqNvIUyZh+G6CIb461fFT+mOx/S7dvfh8whrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BTWk6Jr4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70255d5ddc7so3105798b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Jun 2024 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718549849; x=1719154649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYjghgjKd1ZembdVlTN5XgkOTmluzZxorMJSTjILbTo=;
        b=BTWk6Jr43HB5uLdZ1kqYT9v+Uh1yHBmOszId7TEphwKZUSpQgOgtmAQEVRHOHUk5ps
         dOzp+NiZqGgQJULG+2q5LClsi7eWZphmrcBXSRnji6Nu9zRlX/JWjQ16SJ2IUleL/mqC
         UtNaafyh3gVavNj4wcp6BKuvf891Yw5VP41YO/PXdcu3iWzwmrw9OqPWNMdIajSdonme
         +2UUm+3fARTdxu94y9ofOVvzZ5jYKBw3OyYAKedtLu8mC8egQiKtK+QHgZ6PBxbPBTh7
         BDTzN8M8RXd2dTo62d6smEF6DJRL9lPgRAwzzNKw1sprjApz+yMmWP2kbo02QNJeH6YO
         C9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718549849; x=1719154649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYjghgjKd1ZembdVlTN5XgkOTmluzZxorMJSTjILbTo=;
        b=VWTaJjKBGR+rY1aLeSjwUhPLOTrxSyLUVPndabIs6dZoBUUx3LA9l2/A3ie/SP4vyx
         Tkh8/gwAjhqvBZVTX94sWzVISXZaSbFTjHT1k2pLjqQlDxyqHTvlERnyJhOsIqdcj7ob
         Ctbf+23z4T/6d/s4fgz1DWCel4nxPg4LvZ6+ws3Hgg5yMNaFyZoPE4gNhvPx3spdQKQD
         emPttYLmxdDdD6JuuKVYztKl4IXbvQiaYAIeemZnLXF5arddaU7TQ+hWCRxqExlCR5oi
         CvePqozL1sMZZMR17fC8rJ5sxLVOH6tM7GJcdCPNjlclSNR7tMWZhZH+/Q/e5Z+xWQRt
         v4uA==
X-Forwarded-Encrypted: i=1; AJvYcCUx9R9zA3a79USdJS60IEyY3wehxq5wGXR6jgo8FBGhXox15Pe++FTEADc0yB2vyY0jNl4m7FIxqAOgAueCKm03Qb0+c3EEriU=
X-Gm-Message-State: AOJu0YySoDmqu1TKhtCFLoc36/BeImGhglkmf872Dk/VbfA/ONkp7dDW
	9ay+gOL8EFc3w5hfGm6FDrnwQa6zJl9JwB+HhOtPdbGlu5548irFZe6ClQNLymNZyYsUUIftyH5
	l4AasNUm1rLjEfXzcPJw9YwTMlQ1LJorsAc6+/Q==
X-Google-Smtp-Source: AGHT+IHTgpoQyjqHNervCjt0EPZEZ7aZDOr+YosfkhATeXzbUFa46nGvC/JpQ1fK4xIcVu7QUZh21abUsAxqmPSmJcc=
X-Received: by 2002:a05:6a21:32a5:b0:1b8:a188:53da with SMTP id
 adf61e73a8af0-1bae7f0bb4bmr7762840637.29.1718549848620; Sun, 16 Jun 2024
 07:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613181613.4329-1-kprateek.nayak@amd.com> <20240614092801.GL8774@noisy.programming.kicks-ass.net>
 <CAKfTPtBTxhbmh=605TJ9sRw-nFu6w-KY7QpAxRUh5AjhQWa2ig@mail.gmail.com> <20240615012814.GP8774@noisy.programming.kicks-ass.net>
In-Reply-To: <20240615012814.GP8774@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 16 Jun 2024 16:57:17 +0200
Message-ID: <CAKfTPtD2fUBqw09QDPGgAHyvQRmcvzbq9o3FDsctw=R6HP+=CA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Introducing TIF_NOTIFY_IPI flag
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Andrew Donnellan <ajd@linux.ibm.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Xin Li <xin3.li@intel.com>, 
	Kees Cook <keescook@chromium.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tony Battersby <tonyb@cybernetics.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Brian Gerst <brgerst@gmail.com>, Leonardo Bras <leobras@redhat.com>, 
	Imran Khan <imran.f.khan@oracle.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Rik van Riel <riel@surriel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	David Vernet <void@manifault.com>, Julia Lawall <julia.lawall@inria.fr>, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Jun 2024 at 03:28, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 14, 2024 at 12:48:37PM +0200, Vincent Guittot wrote:
> > On Fri, 14 Jun 2024 at 11:28, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > > Vincent [5] pointed out a case where the idle load kick will fail to
> > > > run on an idle CPU since the IPI handler launching the ILB will check
> > > > for need_resched(). In such cases, the idle CPU relies on
> > > > newidle_balance() to pull tasks towards itself.
> > >
> > > Is this the need_resched() in _nohz_idle_balance() ? Should we change
> > > this to 'need_resched() && (rq->nr_running || rq->ttwu_pending)' or
> > > something long those lines?
> >
> > It's not only this but also in do_idle() as well which exits the loop
> > to look for tasks to schedule
>
> Is that really a problem? Reading the initial email the problem seems to
> be newidle balance, not hitting schedule. Schedule should be fairly
> quick if there's nothing to do, no?

There are 2 problems:
- Because of NEED_RESCHED being set, we go through the full schedule
path for no reason and we finally do a sched_balance_newidle()
- Because of need_resched being set o wake up the cpu, we will not
kick the softirq to run the nohz idle load balance and get a chance to
pull a task on an idle CPU

>
> > > I mean, it's fairly trivial to figure out if there really is going to be
> > > work there.
> > >
> > > > Using an alternate flag instead of NEED_RESCHED to indicate a pending
> > > > IPI was suggested as the correct approach to solve this problem on the
> > > > same thread.
> > >
> > > So adding per-arch changes for this seems like something we shouldn't
> > > unless there really is no other sane options.
> > >
> > > That is, I really think we should start with something like the below
> > > and then fix any fallout from that.
> >
> > The main problem is that need_resched becomes somewhat meaningless
> > because it doesn't  only mean "I need to resched a task" and we have
> > to add more tests around even for those not using polling
>
> True, however we already had some of that by having the wakeup list,
> that made nr_running less 'reliable'.
>
> The thing is, most architectures seem to have the TIF_POLLING_NRFLAG
> bit, even if their main idle routine isn't actually using it, much of

Yes, I'm surprised that Arm arch has the TIF_POLLING_NRFLAG whereas it
has never been supported by the arch

> the idle loop until it hits the arch idle will be having it set and will
> thus tickle these cases *sometimes*.
>
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 0935f9d4bb7b..cfa45338ae97 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -5799,7 +5800,7 @@ static inline struct task_struct *
> > >  __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >  {
> > >         const struct sched_class *class;
> > > -       struct task_struct *p;
> > > +       struct task_struct *p = NULL;
> > >
> > >         /*
> > >          * Optimization: we know that if all tasks are in the fair class we can
> > > @@ -5810,9 +5811,11 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >         if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
> > >                    rq->nr_running == rq->cfs.h_nr_running)) {
> > >
> > > -               p = pick_next_task_fair(rq, prev, rf);
> > > -               if (unlikely(p == RETRY_TASK))
> > > -                       goto restart;
> > > +               if (rq->nr_running) {
> >
> > How do you make the diff between a spurious need_resched() because of
> > polling and a cpu becoming idle ? isn't rq->nr_running null in both
> > cases ?
>
> Bah, true. It should also check current being idle, which then makes a
> mess of things again. Still, we shouldn't be calling newidle from idle,
> that's daft.
>
> I should probably not write code at 3am, but the below horror is what
> I came up with.
>
> ---
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0935f9d4bb7b..cfe8d3350819 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6343,19 +6344,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   * Constants for the sched_mode argument of __schedule().
>   *
>   * The mode argument allows RT enabled kernels to differentiate a
> - * preemption from blocking on an 'sleeping' spin/rwlock. Note that
> - * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
> - * optimize the AND operation out and just check for zero.
> + * preemption from blocking on an 'sleeping' spin/rwlock.
>   */
> -#define SM_NONE                        0x0
> -#define SM_PREEMPT             0x1
> -#define SM_RTLOCK_WAIT         0x2
> -
> -#ifndef CONFIG_PREEMPT_RT
> -# define SM_MASK_PREEMPT       (~0U)
> -#else
> -# define SM_MASK_PREEMPT       SM_PREEMPT
> -#endif
> +#define SM_IDLE                        (-1)
> +#define SM_NONE                        0
> +#define SM_PREEMPT             1
> +#define SM_RTLOCK_WAIT         2
>
>  /*
>   * __schedule() is the main scheduler function.
> @@ -6396,11 +6390,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   *
>   * WARNING: must be called with preemption disabled!
>   */
> -static void __sched notrace __schedule(unsigned int sched_mode)
> +static void __sched notrace __schedule(int sched_mode)
>  {
>         struct task_struct *prev, *next;
>         unsigned long *switch_count;
>         unsigned long prev_state;
> +       bool preempt = sched_mode > 0;
>         struct rq_flags rf;
>         struct rq *rq;
>         int cpu;
> @@ -6409,13 +6404,13 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>         rq = cpu_rq(cpu);
>         prev = rq->curr;
>
> -       schedule_debug(prev, !!sched_mode);
> +       schedule_debug(prev, preempt);
>
>         if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
>                 hrtick_clear(rq);
>
>         local_irq_disable();
> -       rcu_note_context_switch(!!sched_mode);
> +       rcu_note_context_switch(preempt);
>
>         /*
>          * Make sure that signal_pending_state()->signal_pending() below
> @@ -6449,7 +6444,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>          * that we form a control dependency vs deactivate_task() below.
>          */
>         prev_state = READ_ONCE(prev->__state);
> -       if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
> +       if (sched_mode == SM_IDLE) {
> +               if (!rq->nr_running) {
> +                       next = prev;
> +                       goto picked;
> +               }
> +       } else if (!preempt && prev_state) {
>                 if (signal_pending_state(prev_state, prev)) {
>                         WRITE_ONCE(prev->__state, TASK_RUNNING);
>                 } else {
> @@ -6483,6 +6483,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>         }
>
>         next = pick_next_task(rq, prev, &rf);
> +picked:
>         clear_tsk_need_resched(prev);
>         clear_preempt_need_resched();
>  #ifdef CONFIG_SCHED_DEBUG
> @@ -6521,9 +6522,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>                 ++*switch_count;
>
>                 migrate_disable_switch(rq, prev);
>                 psi_sched_switch(prev, next, !task_on_rq_queued(prev));
>
> -               trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
> +               trace_sched_switch(preempt, prev, next, prev_state);
>
>                 /* Also unlocks the rq: */
>                 rq = context_switch(rq, prev, next, &rf);
> @@ -6599,7 +6601,7 @@ static void sched_update_worker(struct task_struct *tsk)
>         }
>  }
>
> -static __always_inline void __schedule_loop(unsigned int sched_mode)
> +static __always_inline void __schedule_loop(int sched_mode)
>  {
>         do {
>                 preempt_disable();
> @@ -6644,7 +6646,7 @@ void __sched schedule_idle(void)
>          */
>         WARN_ON_ONCE(current->__state);
>         do {
> -               __schedule(SM_NONE);
> +               __schedule(SM_IDLE);
>         } while (need_resched());
>  }
>

