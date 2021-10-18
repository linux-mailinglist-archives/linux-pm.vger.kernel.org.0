Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27D5431F0E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 16:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhJROM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhJROMx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 10:12:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265B4C0613B0;
        Mon, 18 Oct 2021 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/AJ1aZvoD1O8XJ2XgWz5KdpFOHjRcXj1qqyyjYotoWU=; b=G9+PkVb6L21imdVFvxCbke9v+j
        u05jBR2JSK5hGt09YAkFeoIEn2xxxMQ0dQ6quDx/xB57zu6iBMhAOaf1IsmNFVmGLJP0GA5NdtYK+
        MkJ7NAMsfCbtp3YP/4u9QXZOC9iUapeqFNugBiHh3C0Ro3k/JLMfeeTmgmqpJnJjGH8a8De68g5n7
        aqJ9v2pli1T4DpuCcd57jTUs4mdt4KF2ixc9uOJpF5soGg+lys97+WZVRsJOcYbQZc1yJugXST7MV
        xbg1wWmadYeoRNHsjnzHAXUvAxrXEcJ0z77uh131B/hjzxFPDSr6yOlIgQypOMx6mZzFusbI/DKS3
        8OH2AQmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcSot-00AYmx-UB; Mon, 18 Oct 2021 13:36:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6199D300221;
        Mon, 18 Oct 2021 15:36:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 227952CF42A2E; Mon, 18 Oct 2021 15:36:50 +0200 (CEST)
Date:   Mon, 18 Oct 2021 15:36:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YW14cgrrRWSAzmYn@hirez.programming.kicks-ass.net>
References: <20211009100754.690769957@infradead.org>
 <20211009101445.151888246@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009101445.151888246@infradead.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 09, 2021 at 12:08:00PM +0200, Peter Zijlstra wrote:

> +static inline unsigned int __can_freeze(struct task_struct *p)
> +{
> +	unsigned int state = READ_ONCE(p->__state);
> +
> +	if (!(state & (TASK_FREEZABLE | __TASK_STOPPED | __TASK_TRACED)))
> +		return 0;
> +
> +	/*
> +	 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE, since they
> +	 * can suffer spurious wakeups.
> +	 */
> +	if (state & TASK_FREEZABLE)
> +		WARN_ON_ONCE(!(state & TASK_NORMAL));
> +
> +#ifdef CONFIG_LOCKDEP
> +	/*
> +	 * It's dangerous to freeze with locks held; there be dragons there.
> +	 */
> +	if (!(state & __TASK_FREEZABLE_UNSAFE))
> +		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> +#endif
> +
> +	return TASK_FROZEN;
> +}
> +
> +/* See task_cond_set_special_state(); serializes against ttwu() */
> +static bool __freeze_task(struct task_struct *p)
> +{
> +	return task_cond_set_special_state(p, __can_freeze(p));
> +}

Will found an issue with this, notably task_cond_set_special() only
takes ->pi_lock and as such doesn't serialize against __schedule(),
which then yields the following fun scenario:


	__schedule()					__freeze_task()


	prev_state = READ_ONCE(prev->__state); // INTERRUPTIBLE

							task_cond_set_special_state()
							  ...
							  WRITE_ONCE(prev->__state, TASK_FROZEN);

	if (signal_pending_state(prev_state, prev)) // SIGPENDING
	  WRITE_ONCE(prev->__state, TASK_RUNNING)




And *whoopsie*, freezer things we're frozen, but we're back in the game.


AFAICT the below, which uses the brand-spanking-new task_call_func()
which currently sits in tip/sched/core to also serialize against
rq->lock should avoid this scenario.


--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -233,25 +233,6 @@ struct task_group;
 	} while (0)
 
 /*
- * task_cond_set_special_state() is a cmpxchg like operation on task->state.
- *
- * This operation isn't safe in general and should only be used to transform
- * one (special) blocked state into another, such as:
- *   TASK_STOPPED <-> TASK_FROZEN.
- */
-#define task_cond_set_special_state(task, cond_state)			\
-	({								\
-		struct task_struct *__p = (task);			\
-		unsigned long __flags; /* may shadow */			\
-		unsigned int __state;					\
-		raw_spin_lock_irqsave(&__p->pi_lock, __flags);		\
-		if ((__state = (cond_state)))				\
-			WRITE_ONCE(__p->__state, __state);		\
-		raw_spin_unlock_irqrestore(&__p->pi_lock, __flags);	\
-		!!__state;						\
-	})
-
-/*
  * PREEMPT_RT specific variants for "sleeping" spin/rwlocks
  *
  * RT's spin/rwlock substitutions are state preserving. The state of the
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -101,7 +101,7 @@ static void fake_signal_wake_up(struct t
 	}
 }
 
-static inline unsigned int __can_freeze(struct task_struct *p)
+static int __set_task_frozen(struct task_struct *p, void *arg)
 {
 	unsigned int state = READ_ONCE(p->__state);
 
@@ -123,13 +123,14 @@ static inline unsigned int __can_freeze(
 		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
 #endif
 
+	WRITE_ONCE(p->__state, TASK_FROZEN);
 	return TASK_FROZEN;
 }
 
-/* See task_cond_set_special_state(); serializes against ttwu() */
 static bool __freeze_task(struct task_struct *p)
 {
-	return task_cond_set_special_state(p, __can_freeze(p));
+	/* TASK_FREEZABLE|TASK_STOPPED|TASK_TRACED -> TASK_FROZEN */
+	return task_call_func(p, __set_task_frozen, NULL);
 }
 
 /**
@@ -169,7 +170,7 @@ bool freeze_task(struct task_struct *p)
  * reflects that and the below will refuse to restore the special state and
  * instead issue the wakeup.
  */
-static inline unsigned int __thaw_special(struct task_struct *p)
+static int __set_task_special(struct task_struct *p, void *arg)
 {
 	unsigned int state = 0;
 
@@ -188,6 +189,9 @@ static inline unsigned int __thaw_specia
 		state = TASK_STOPPED;
 	}
 
+	if (state)
+		WRITE_ONCE(p->__state, state);
+
 	return state;
 }
 
@@ -200,7 +204,8 @@ void __thaw_task(struct task_struct *p)
 		goto unlock;
 
 	if (lock_task_sighand(p, &flags2)) {
-		bool ret = task_cond_set_special_state(p, __thaw_special(p));
+		/* TASK_FROZEN -> TASK_{STOPPED,TRACED} */
+		bool ret = task_call_func(p, __set_task_special, NULL);
 		unlock_task_sighand(p, &flags2);
 		if (ret)
 			goto unlock;
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -193,6 +193,17 @@ static bool looks_like_a_spurious_pid(st
 	return true;
 }
 
+static int __set_task_traced(struct task_struct *task, void *arg)
+{
+	unsigned int *state = arg;
+
+	if (!(task->__state & __TASK_TRACED))
+		return 0;
+
+	WRITE_ONCE(task->__state, *state);
+	return *state;
+}
+
 /* Ensure that nothing can wake it up, even SIGKILL */
 static bool ptrace_freeze_traced(struct task_struct *task)
 {
@@ -205,10 +216,12 @@ static bool ptrace_freeze_traced(struct
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
+		unsigned int state = __TASK_TRACED;
+
 		task->ptrace &= ~PT_STOPPED_MASK;
 		task->ptrace |= PT_STOPPED;
 		/* *TASK_TRACED -> __TASK_TRACED */
-		task_cond_set_special_state(task, !!(task->__state & __TASK_TRACED) * __TASK_TRACED);
+		task_call_func(task, __set_task_traced, &state);
 		ret = true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
@@ -233,9 +246,11 @@ static void ptrace_unfreeze_traced(struc
 			task->ptrace &= ~PT_STOPPED_MASK;
 			wake_up_state(task, __TASK_TRACED);
 		} else {
+			unsigned int state = TASK_TRACED;
+
 			task->ptrace |= PT_STOPPED_MASK;
 			/* *TASK_TRACED -> TASK_TRACED */
-			task_cond_set_special_state(task, !!(task->__state & __TASK_TRACED) * TASK_TRACED);
+			task_call_func(task, __set_task_traced, &state);
 		}
 	}
 	spin_unlock_irq(&task->sighand->siglock);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3181,7 +3181,7 @@ int migrate_swap(struct task_struct *cur
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-static inline __wti_match(struct task_struct *p, unsigned int match_state)
+static inline bool __wti_match(struct task_struct *p, unsigned int match_state)
 {
 	unsigned int state = READ_ONCE(p->__state);
 
