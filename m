Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3E4278F9
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 12:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhJIKWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 06:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhJIKWF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 06:22:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60892C061570;
        Sat,  9 Oct 2021 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LxICarhbeWHHk3CYHCWSE0Yu/W+R0CeTpiEeQHRRDkY=; b=aj9ZAhJy5SKUP1bb7KjO3pMek/
        o07ws7VZ8ioIUGOiWamwObPOKfVlbgio2C6xuR9i3IIZRpR4EEm77qoXqVxCm1UEWxD0/+wOaveTu
        /vlgexioQEtQExxneF9YSaKqCXKAZBg4RIBc4vh4Yi2i2klCdncGQzX7cBE2sIheHZuhVTQrIaDGI
        uT5U/Be0eaU+r9+/gWCGilkoS8WoB1xhvZXJLIx6gVzpTTBWo+GKlOfPm0wb3geDngdh0eDPyZiyn
        NFrVbCE4VH26cSg43T0cQ0sAbMg/fWKxL1ij+7qISLO1SEFliBAsB2Wv2Tl2EGghmGex6rWWsnHWI
        mE+Gw9qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZ9Rf-0043WN-Fs; Sat, 09 Oct 2021 10:19:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C407300728;
        Sat,  9 Oct 2021 12:19:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E4C322C6B0487; Sat,  9 Oct 2021 12:19:09 +0200 (CEST)
Message-ID: <20211009101445.090696671@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 09 Oct 2021 12:07:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 5/6] sched,ptrace: Avoid relying on __TASK_TRACED | __TASK_STOPPED
References: <20211009100754.690769957@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make ->ptrace/->jobctl the canonical state, this allows us to play
games with __state (such as freezing).

The wait_task_inactive() usage will be fixed up later, once we have
additional TASK_state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |   27 ++++++++++++++++++++++-----
 kernel/ptrace.c       |   16 +++++++++-------
 2 files changed, 31 insertions(+), 12 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -118,11 +118,9 @@ struct task_group;
 
 #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
 
-#define task_is_traced(task)		((READ_ONCE(task->__state) & __TASK_TRACED) != 0)
-
-#define task_is_stopped(task)		((READ_ONCE(task->__state) & __TASK_STOPPED) != 0)
-
-#define task_is_stopped_or_traced(task)	((READ_ONCE(task->__state) & (__TASK_STOPPED | __TASK_TRACED)) != 0)
+#define task_is_traced(task)		((task)->ptrace & PT_STOPPED)
+#define task_is_stopped(task)		((task)->jobctl & JOBCTL_STOP_PENDING)
+#define task_is_stopped_or_traced(task)	(task_is_stopped(task) || task_is_traced(task))
 
 /*
  * Special states are those that do not use the normal wait-loop pattern. See
@@ -228,6 +226,25 @@ struct task_group;
 	} while (0)
 
 /*
+ * task_cond_set_special_state() is a cmpxchg like operation on task->state.
+ *
+ * This operation isn't safe in general and should only be used to transform
+ * one (special) blocked state into another, such as:
+ *   TASK_STOPPED <-> TASK_FROZEN.
+ */
+#define task_cond_set_special_state(task, cond_state)			\
+	({								\
+		struct task_struct *__p = (task);			\
+		unsigned long __flags; /* may shadow */			\
+		unsigned int __state;					\
+		raw_spin_lock_irqsave(&__p->pi_lock, __flags);		\
+		if ((__state = (cond_state)))				\
+			WRITE_ONCE(__p->__state, __state);		\
+		raw_spin_unlock_irqrestore(&__p->pi_lock, __flags);	\
+		!!__state;						\
+	})
+
+/*
  * PREEMPT_RT specific variants for "sleeping" spin/rwlocks
  *
  * RT's spin/rwlock substitutions are state preserving. The state of the
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -207,7 +207,8 @@ static bool ptrace_freeze_traced(struct
 	    !__fatal_signal_pending(task)) {
 		task->ptrace &= ~PT_STOPPED_MASK;
 		task->ptrace |= PT_STOPPED;
-		WRITE_ONCE(task->__state, __TASK_TRACED);
+		/* *TASK_TRACED -> __TASK_TRACED */
+		task_cond_set_special_state(task, !!(task->__state & __TASK_TRACED) * __TASK_TRACED);
 		ret = true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
@@ -217,7 +218,7 @@ static bool ptrace_freeze_traced(struct
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (READ_ONCE(task->__state) != __TASK_TRACED)
+	if (!task_is_traced(task))
 		return;
 
 	WARN_ON(!task->ptrace || task->parent != current);
@@ -227,13 +228,14 @@ static void ptrace_unfreeze_traced(struc
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (READ_ONCE(task->__state) == __TASK_TRACED) {
+	if (task_is_traced(task)) {
 		if (__fatal_signal_pending(task)) {
 			task->ptrace &= ~PT_STOPPED_MASK;
 			wake_up_state(task, __TASK_TRACED);
 		} else {
 			task->ptrace |= PT_STOPPED_MASK;
-			WRITE_ONCE(task->__state, TASK_TRACED);
+			/* *TASK_TRACED -> TASK_TRACED */
+			task_cond_set_special_state(task, !!(task->__state & __TASK_TRACED) * TASK_TRACED);
 		}
 	}
 	spin_unlock_irq(&task->sighand->siglock);
@@ -269,7 +271,7 @@ static int ptrace_check_attach(struct ta
 	 */
 	read_lock(&tasklist_lock);
 	if (child->ptrace && child->parent == current) {
-		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+//		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
 		/*
 		 * child->sighand can't be NULL, release_task()
 		 * does ptrace_unlink() before __exit_signal().
@@ -280,13 +282,13 @@ static int ptrace_check_attach(struct ta
 	read_unlock(&tasklist_lock);
 
 	if (!ret && !ignore_state) {
-		if (!wait_task_inactive(child, __TASK_TRACED)) {
+		if (!wait_task_inactive(child, __TASK_TRACED)) { // XXX mooo!!!
 			/*
 			 * This can only happen if may_ptrace_stop() fails and
 			 * ptrace_stop() changes ->state back to TASK_RUNNING,
 			 * so we should not worry about leaking __TASK_TRACED.
 			 */
-			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+//			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
 			ret = -ESRCH;
 		}
 	}


