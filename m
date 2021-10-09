Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB4427900
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbhJIKW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 06:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244529AbhJIKWN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 06:22:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF797C061762;
        Sat,  9 Oct 2021 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qSbtiIKzo7h9EVam2t6xHXWuAevMMMnxpqGbRSHxNMU=; b=O+gD68v7EpvMwDxoZSprS7O2vW
        ZMFtYo9YlsfIHEx8N/lfEJ/anTzIqwWBLvFRePD7YXh2ksyanMi1cAdeIENiGsbD0pt4AqMv9KrFx
        KMVyZd7zhdamS6OvC+3Q6+bOEwSuqYrUyX9tP2AQtf3+Bg3/oQBDlkyVqxLEs8ozo4IMUHi80rGxj
        KvSENtIyxUA2oDDyGPBymk6hKUAcwxnI74I9fmoxM7r3vDrElamQYh4gA5NTIJiqc+lWtvdTADGm5
        cPRvM0Y9h9HP1GE3WAeqgy9ULy/+KQ1ykE2w48jJRPOhYcygZsg3rQnr/B50tUpoHXl+VrsSp7ZSO
        gUdH6u2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZ9Re-0043WK-B6; Sat, 09 Oct 2021 10:19:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A3063005BA;
        Sat,  9 Oct 2021 12:19:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E03302C6B0486; Sat,  9 Oct 2021 12:19:09 +0200 (CEST)
Message-ID: <20211009101445.030486548@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 09 Oct 2021 12:07:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 4/6] ptrace: Track __TASK_TRACED state in p->ptrace
References: <20211009100754.690769957@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Just like we can recover __TASK_STOPPED from p->jobctl, add some bits
to p->ptrace such that we can recover __TASK_TRACED.

All these t->ptrace modifications are done under sighand lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/ptrace.h       |    4 ++++
 include/linux/sched/signal.h |    6 ++----
 kernel/ptrace.c              |   27 ++++++++++++++++++---------
 kernel/signal.c              |    1 +
 4 files changed, 25 insertions(+), 13 deletions(-)

--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -45,6 +45,10 @@ extern int ptrace_access_vm(struct task_
 #define PT_TRACE_SECCOMP	PT_EVENT_FLAG(PTRACE_EVENT_SECCOMP)	        // 0x00000400
 
 #define PT_SEIZED		0x00010000 /* SEIZE used, enable new behavior */// 0x00010000
+#define PT_STOPPED		0x00020000					// 0x00020000
+#define PT_STOPPED_FATAL	0x00040000					// 0x00040000
+
+#define PT_STOPPED_MASK		(PT_STOPPED|PT_STOPPED_FATAL)
 
 #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)	// 0x00800000
 #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT) // 0x01000000
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -418,10 +418,8 @@ static inline void signal_wake_up(struct
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
@@ -64,6 +64,14 @@ int ptrace_access_vm(struct task_struct
 	return ret;
 }
 
+void ptrace_signal_wake_up(struct task_struct *t, bool resume)
+{
+	lockdep_assert_task_sighand_held(t);
+
+	if (resume)
+		t->ptrace &= ~PT_STOPPED_MASK;
+	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
+}
 
 void __ptrace_link(struct task_struct *child, struct task_struct *new_parent,
 		   const struct cred *ptracer_cred)
@@ -197,6 +205,8 @@ static bool ptrace_freeze_traced(struct
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
+		task->ptrace &= ~PT_STOPPED_MASK;
+		task->ptrace |= PT_STOPPED;
 		WRITE_ONCE(task->__state, __TASK_TRACED);
 		ret = true;
 	}
@@ -218,10 +228,13 @@ static void ptrace_unfreeze_traced(struc
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
@@ -835,8 +848,6 @@ static long ptrace_get_rseq_configuratio
 static int ptrace_resume(struct task_struct *child, long request,
 			 unsigned long data)
 {
-	bool need_siglock;
-
 	if (!valid_signal(data))
 		return -EIO;
 
@@ -877,13 +888,11 @@ static int ptrace_resume(struct task_str
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
@@ -2228,6 +2228,7 @@ static void ptrace_stop(int exit_code, i
 			return;
 	}
 
+	current->ptrace |= PT_STOPPED_MASK;
 	set_special_state(TASK_TRACED);
 
 	/*


