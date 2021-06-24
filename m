Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9240B3B2B5E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhFXJ3n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 05:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhFXJ3m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 05:29:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C74C061574;
        Thu, 24 Jun 2021 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HJq7JyHhmABk8L3QGBLRjZPdtxMaLFzHsnnSMC1ABZw=; b=ZJmKQDXJrjfujPiaFSZRaxrkjX
        AxR9+iD7YwG9o0G+A1aRLp7nv7aHw2No+R2WK9bi/7ULzMJZwOOym75yFSpCT67jpVQLFp/X/p/Z8
        hIzQwZ32qidkz9EsURph7rabUpvWSd1XGqhmXWtnj0wLXE4m6os7klnE/TLxvWdTPsusuT1Turqg4
        4OKpdr+2HZpedCC9ckFeHbZe9GDDUHzw1AJnL6N69K0R12yCkH/C1Z859ck1E2h9wV5FdKQO0ZpgY
        bfZqNh6VW8fBHAdrG5uYVmOC8oMlkN6sBFXtT/uB6Lrrm4i6Tc6MTbHkYkFCxVcDNFO0YhDMBuobv
        NBb2E4/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwLdW-00BBs2-N6; Thu, 24 Jun 2021 09:27:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C47053002D7;
        Thu, 24 Jun 2021 11:27:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AE4A02B64C070; Thu, 24 Jun 2021 11:27:07 +0200 (CEST)
Message-ID: <20210624092615.947779232@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:21:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 3/4] ptrace: Track __TASK_TRACED state in p->ptrace
References: <20210624092156.332208049@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Just like we can recover __TASK_STOPPED from p->jobctl, add some bits
to p->ptrace such that we can recover __TASK_TRACED.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/ptrace.h       |   36 +++++++++++++++++++++---------------
 include/linux/sched/signal.h |    6 ++----
 kernel/ptrace.c              |   25 ++++++++++++++++---------
 kernel/signal.c              |    1 +
 4 files changed, 40 insertions(+), 28 deletions(-)

--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -28,30 +28,36 @@ extern int ptrace_access_vm(struct task_
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
 
-#define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
-#define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
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
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -422,10 +422,8 @@ static inline void signal_wake_up(struct
 {
 	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
 }
-static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
-{
-	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
-}
+
+extern void ptrace_signal_wake_up(struct task_struct *t, bool resume);
 
 void task_join_group_stop(struct task_struct *task);
 
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -64,6 +64,12 @@ int ptrace_access_vm(struct task_struct
 	return ret;
 }
 
+void ptrace_signal_wake_up(struct task_struct *t, bool resume)
+{
+	if (resume)
+		t->ptrace &= ~PT_STOPPED_MASK;
+	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
+}
 
 void __ptrace_link(struct task_struct *child, struct task_struct *new_parent,
 		   const struct cred *ptracer_cred)
@@ -197,6 +203,8 @@ static bool ptrace_freeze_traced(struct
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
+		task->ptrace &= ~PT_STOPPED_MASK;
+		task->ptrace |= PT_STOPPED;
 		WRITE_ONCE(task->__state, __TASK_TRACED);
 		ret = true;
 	}
@@ -218,10 +226,13 @@ static void ptrace_unfreeze_traced(struc
 	 */
 	spin_lock_irq(&task->sighand->siglock);
 	if (READ_ONCE(task->__state) == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
+		if (__fatal_signal_pending(task)) {
+			task->ptrace &= ~PT_STOPPED_MASK;
 			wake_up_state(task, __TASK_TRACED);
-		else
+		} else {
+			task->ptrace |= PT_STOPPED_MASK;
 			WRITE_ONCE(task->__state, TASK_TRACED);
+		}
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 }
@@ -835,8 +846,6 @@ static long ptrace_get_rseq_configuratio
 static int ptrace_resume(struct task_struct *child, long request,
 			 unsigned long data)
 {
-	bool need_siglock;
-
 	if (!valid_signal(data))
 		return -EIO;
 
@@ -877,13 +886,11 @@ static int ptrace_resume(struct task_str
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
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2195,6 +2195,7 @@ static void ptrace_stop(int exit_code, i
 			return;
 	}
 
+	current->ptrace |= PT_STOPPED_MASK;
 	set_special_state(TASK_TRACED);
 
 	/*


