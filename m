Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB463A8B66
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFOVxS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 17:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhFOVxR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 17:53:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51961C061574;
        Tue, 15 Jun 2021 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N7GqmOX/LrLVjhMA+EGbHb8euLArRMk+/0HSOfKlkms=; b=EYhLqcYbLbuGDX2J4p1lfl4xus
        1R6WpuzXS1jERG1BFYXYI6Cshp6bERYc2+/1DMJj7EnEM1aKRkI1NwyGU/MKV5GqW8UgMQiuCX2vH
        e1vjwiuAeWmGEzFIROLjnTUNFjvQSJ3N/E4s9pxSaOe8+Sfu7i8TX1WR7gqNcWbIznRZ/rLSngjUC
        E1R2CHViHRzY5y3DvRWMK8WE26Dnx+yDC2kVSWW3geZ+Q8HFKCFykqtI4/ps+yBuXR9BCo93VavXc
        NSMnG/ridpr9iiIfUJrS9wQ/seTzpN3wYakA+z4MnFn5uGyx88mCHUcyI4WAm7RgRVkbeP5eZb/1n
        dkYOVQ1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltGwh-007Hsf-5C; Tue, 15 Jun 2021 21:50:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 385F3982227; Tue, 15 Jun 2021 23:50:05 +0200 (CEST)
Date:   Tue, 15 Jun 2021 23:50:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <20210615215005.GD4272@worktop.programming.kicks-ass.net>
References: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
 <20210614154246.GB13677@redhat.com>
 <20210614161221.GC68749@worktop.programming.kicks-ass.net>
 <20210614165422.GC13677@redhat.com>
 <20210614183801.GE68749@worktop.programming.kicks-ass.net>
 <20210615154539.GA30333@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615154539.GA30333@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 15, 2021 at 05:45:39PM +0200, Oleg Nesterov wrote:
> On 06/14, Peter Zijlstra wrote:
> >
> > One more thing; if I add additional state bits to preserve
> > __TASK_{TRACED,STOPPED}, then I need to figure out at thaw time if we've
> > missed a wakeup or not.
> >
> > Do we have sufficient state for that? If so, don't we then also not have
> > sufficient state to tell if a task should've been TRACED/STOPPED in the
> > first place?
> 
> Not sure I understand you, probably not, but I think the answer is "no" ;)

I was thinking something like the below, such that we can then write
something like:

void __thaw_special(struct task_struct *p)
{
	spin_lock(&t->sighand->siglock);

	if (p->ptrace) {
		unsigned int state = __TASK_TRACED;

		if (!(p->ptrace & PT_STOPPED))
			goto unlock;

		if (p->ptrace & PT_STOPPED_FATAL) {
			state |= TASK_WAKEKILL;
			if (__fatal_signal_pending(p))
				goto unlock;
		}

		set_special_state(state);

	} else if ((p->jobctl & JOBCTL_STOP_PENDING) &&
		   !__fatal_signal_pending(p)) {

		set_special_state(TASK_STOPPED);
	}

unlock:
	spin_unlock(&t->sighand->siglock);
}



---
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index b5ebf6c01292..2123d6543125 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -28,30 +28,36 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
  * flags.  When the a task is stopped the ptracer owns task->ptrace.
  */
 
-#define PT_SEIZED	0x00010000	/* SEIZE used, enable new behavior */
-#define PT_PTRACED	0x00000001
-#define PT_DTRACE	0x00000002	/* delayed trace (used on m68k, i386) */
+#define PT_PTRACED	0x00000001						// 0x00000001
+#define PT_DTRACE	0x00000002 /* delayed trace (used on m68k, i386) */	// 0x00000002
 
 #define PT_OPT_FLAG_SHIFT	3
 /* PT_TRACE_* event enable flags */
 #define PT_EVENT_FLAG(event)	(1 << (PT_OPT_FLAG_SHIFT + (event)))
-#define PT_TRACESYSGOOD		PT_EVENT_FLAG(0)
-#define PT_TRACE_FORK		PT_EVENT_FLAG(PTRACE_EVENT_FORK)
-#define PT_TRACE_VFORK		PT_EVENT_FLAG(PTRACE_EVENT_VFORK)
-#define PT_TRACE_CLONE		PT_EVENT_FLAG(PTRACE_EVENT_CLONE)
-#define PT_TRACE_EXEC		PT_EVENT_FLAG(PTRACE_EVENT_EXEC)
-#define PT_TRACE_VFORK_DONE	PT_EVENT_FLAG(PTRACE_EVENT_VFORK_DONE)
-#define PT_TRACE_EXIT		PT_EVENT_FLAG(PTRACE_EVENT_EXIT)
-#define PT_TRACE_SECCOMP	PT_EVENT_FLAG(PTRACE_EVENT_SECCOMP)
-
-#define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
-#define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
+
+#define PT_TRACESYSGOOD		PT_EVENT_FLAG(0)			        // 0x00000008
+#define PT_TRACE_FORK		PT_EVENT_FLAG(PTRACE_EVENT_FORK)	        // 0x00000010
+#define PT_TRACE_VFORK		PT_EVENT_FLAG(PTRACE_EVENT_VFORK)	        // 0x00000020
+#define PT_TRACE_CLONE		PT_EVENT_FLAG(PTRACE_EVENT_CLONE)	        // 0x00000040
+#define PT_TRACE_EXEC		PT_EVENT_FLAG(PTRACE_EVENT_EXEC)	        // 0x00000080
+#define PT_TRACE_VFORK_DONE	PT_EVENT_FLAG(PTRACE_EVENT_VFORK_DONE)	        // 0x00000100
+#define PT_TRACE_EXIT		PT_EVENT_FLAG(PTRACE_EVENT_EXIT)	        // 0x00000200
+#define PT_TRACE_SECCOMP	PT_EVENT_FLAG(PTRACE_EVENT_SECCOMP)	        // 0x00000400
+
+#define PT_SEIZED		0x00010000 /* SEIZE used, enable new behavior */// 0x00010000
+#define PT_STOPPED		0x00020000					// 0x00020000
+#define PT_STOPPED_FATAL	0x00040000					// 0x00040000
+
+#define PT_STOPPED_MASK		(PT_STOPPED|PT_STOPPED_FATAL)
+
+#define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)	// 0x00800000
+#define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT) // 0x01000000
 
 /* single stepping state bits (used on ARM and PA-RISC) */
 #define PT_SINGLESTEP_BIT	31
-#define PT_SINGLESTEP		(1<<PT_SINGLESTEP_BIT)
+#define PT_SINGLESTEP		(1<<PT_SINGLESTEP_BIT)				// 0x80000000
 #define PT_BLOCKSTEP_BIT	30
-#define PT_BLOCKSTEP		(1<<PT_BLOCKSTEP_BIT)
+#define PT_BLOCKSTEP		(1<<PT_BLOCKSTEP_BIT)				// 0x40000000
 
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0d7fec79d28f..0cf806030bfd 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -424,6 +424,8 @@ static inline void signal_wake_up(struct task_struct *t, bool resume)
 }
 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 {
+	if (resume)
+		t->ptrace &= ~PT_STOPPED_MASK;
 	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
 }
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2997ca600d18..4fc4e1f91ecd 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -197,6 +197,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
+		task->ptrace &= ~PT_STOPPED_MASK;
+		task->ptrace |= PT_STOPPED;
 		task->state = __TASK_TRACED;
 		ret = true;
 	}
@@ -218,10 +220,13 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 */
 	spin_lock_irq(&task->sighand->siglock);
 	if (task->state == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
+		if (__fatal_signal_pending(task)) {
+			task->ptrace &= ~PT_STOPPED_MASK;
 			wake_up_state(task, __TASK_TRACED);
-		else
+		} else {
+			task->ptrace |= PT_STOPPED_MASK;
 			task->state = TASK_TRACED;
+		}
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 }
@@ -835,8 +840,6 @@ static long ptrace_get_rseq_configuration(struct task_struct *task,
 static int ptrace_resume(struct task_struct *child, long request,
 			 unsigned long data)
 {
-	bool need_siglock;
-
 	if (!valid_signal(data))
 		return -EIO;
 
@@ -877,13 +880,11 @@ static int ptrace_resume(struct task_struct *child, long request,
 	 * status and clears the code too; this can't race with the tracee, it
 	 * takes siglock after resume.
 	 */
-	need_siglock = data && !thread_group_empty(current);
-	if (need_siglock)
-		spin_lock_irq(&child->sighand->siglock);
+	spin_lock_irq(&child->sighand->siglock);
 	child->exit_code = data;
+	child->ptrace &= ~PT_STOPPED_MASK;
 	wake_up_state(child, __TASK_TRACED);
-	if (need_siglock)
-		spin_unlock_irq(&child->sighand->siglock);
+	spin_unlock_irq(&child->sighand->siglock);
 
 	return 0;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index f7c6ffcbd044..35cdb92b7f1d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2195,6 +2195,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 			return;
 	}
 
+	current->ptrace |= PT_STOPPED_MASK;
 	set_special_state(TASK_TRACED);
 
 	/*
