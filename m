Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F745059A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 11:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfFXJZA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 05:25:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42246 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfFXJZA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 05:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t+NWcpIq2t5tFitqwb+rHdm0mFL7PHUZ9sOhyagF8Hg=; b=WilsIw38sU+nqN0OsUPFG/VRm7
        XRWDCL1SXw+gm6eytlyaHL2NcPnuN0kK80vz7If4P/ZrYoVZbW2oE5LsV6+TqFN2/MqBFMBm3t8jN
        s37KJa7K8f7Jg5VJeGXh0ab4cUcR2Q0XS5x0KlujHtnf2zrgauCYQavTKWmcANSYYSqMuVmRXVS45
        RWv2a0zUM1k6SYbnO2+O/9OnjhmWY3lNmBZbbKq7Vw5CBm5OAcDFOL6Mt7FCN+RM12MmeKkRiSAp6
        EZHjA9jgbCwCQO/Q+FlCUG83vF3rXkrSNm2kAajw8MbSrFRrnFHyhtS5JrIC7ECU/ajR5Ofd9sods
        v9nuFoDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfLCm-0006uy-Lu; Mon, 24 Jun 2019 09:24:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 52F9F203C05DA; Mon, 24 Jun 2019 11:24:02 +0200 (CEST)
Message-Id: <20190624092109.745446564@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Jun 2019 11:18:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, ast@kernel.org, daniel@iogearbox.net,
        akpm@linux-foundation.org, peterz@infradead.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Vasily Averin <vvs@virtuozzo.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/3] notifier: Fix broken error handling pattern
References: <20190624091843.859714294@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current notifiers have the following error handling pattern all
over the place:

	int nr;

	ret = __foo_notifier_call_chain(&chain, val_up, v, -1, &nr);
	if (err & NOTIFIER_STOP_MASK)
		__foo_notifier_call_chain(&chain, val_down, v, nr-1, NULL)

And aside from the endless repetition thereof, it is broken. Consider
blocking notifiers; both calls take and drop the rwsem, this means
that the notifier list can change in between the two calls, making @nr
meaningless.

Fix this by replacing all the __foo_notifier_call_chain() functions
with foo_notifier_call_chain_error() that embeds the above patter, but
ensures it is inside a single lock region.

XXX: It is probably still broken for the RCU (atomic, src) users
(cpu_pm_notifier).

Note: software_resume() error handling was broken afaict.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Vasily Averin <vvs@virtuozzo.com>
Cc: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/notifier.h           |   17 ++-
 kernel/cpu_pm.c                    |   51 +++++------
 kernel/notifier.c                  |  159 +++++++++++++------------------------
 kernel/power/hibernate.c           |   26 ++----
 kernel/power/main.c                |    8 -
 kernel/power/power.h               |    3 
 kernel/power/suspend.c             |   14 +--
 kernel/power/user.c                |   14 ---
 tools/power/pm-graph/sleepgraph.py |    2 
 9 files changed, 118 insertions(+), 176 deletions(-)

--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -165,20 +165,21 @@ extern int srcu_notifier_chain_unregiste
 
 extern int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
-	unsigned long val, void *v, int nr_to_call, int *nr_calls);
 extern int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __blocking_notifier_call_chain(struct blocking_notifier_head *nh,
-	unsigned long val, void *v, int nr_to_call, int *nr_calls);
 extern int raw_notifier_call_chain(struct raw_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __raw_notifier_call_chain(struct raw_notifier_head *nh,
-	unsigned long val, void *v, int nr_to_call, int *nr_calls);
 extern int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __srcu_notifier_call_chain(struct srcu_notifier_head *nh,
-	unsigned long val, void *v, int nr_to_call, int *nr_calls);
+
+extern int atomic_notifier_call_chain_error(struct atomic_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v);
+extern int blocking_notifier_call_chain_error(struct blocking_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v);
+extern int raw_notifier_call_chain_error(struct raw_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v);
+extern int srcu_notifier_call_chain_error(struct srcu_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -15,7 +15,7 @@
 
 static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
 
-static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
+static int cpu_pm_notify(enum cpu_pm_event event)
 {
 	int ret;
 
@@ -25,8 +25,23 @@ static int cpu_pm_notify(enum cpu_pm_eve
 	 * RCU know this.
 	 */
 	rcu_irq_enter_irqson();
-	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
-		nr_to_call, nr_calls);
+	ret = atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
+	rcu_irq_exit_irqson();
+
+	return notifier_to_errno(ret);
+}
+
+static int cpu_pm_notify_error(enum cpu_pm_event event_up, enum cpu_pm_event event_down)
+{
+	int ret;
+
+	/*
+	 * __atomic_notifier_call_chain has a RCU read critical section, which
+	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
+	 * RCU know this.
+	 */
+	rcu_irq_enter_irqson();
+	ret = atomic_notifier_call_chain_error(&cpu_pm_notifier_chain, event_up, event_down, NULL);
 	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
@@ -80,18 +95,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_unregister_noti
  */
 int cpu_pm_enter(void)
 {
-	int nr_calls;
-	int ret = 0;
-
-	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
-	if (ret)
-		/*
-		 * Inform listeners (nr_calls - 1) about failure of CPU PM
-		 * PM entry who are notified earlier to prepare for it.
-		 */
-		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
-
-	return ret;
+	return cpu_pm_notify_error(CPU_PM_ENTER, CPU_PM_ENTER_FAILED);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_enter);
 
@@ -109,7 +113,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
  */
 int cpu_pm_exit(void)
 {
-	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
+	return cpu_pm_notify(CPU_PM_EXIT);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_exit);
 
@@ -131,18 +135,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_exit);
  */
 int cpu_cluster_pm_enter(void)
 {
-	int nr_calls;
-	int ret = 0;
-
-	ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
-	if (ret)
-		/*
-		 * Inform listeners (nr_calls - 1) about failure of CPU cluster
-		 * PM entry who are notified earlier to prepare for it.
-		 */
-		cpu_pm_notify(CPU_CLUSTER_PM_ENTER_FAILED, nr_calls - 1, NULL);
-
-	return ret;
+	return cpu_pm_notify_enter(CPU_CLUSTER_PM_ENTER, CPU_CLUSTER_ENTER_FAILED);
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
 
@@ -163,7 +156,7 @@ EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
  */
 int cpu_cluster_pm_exit(void)
 {
-	return cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
+	return cpu_pm_notify(CPU_CLUSTER_PM_EXIT);
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_exit);
 
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -106,6 +106,19 @@ static int notifier_call_chain(struct no
 }
 NOKPROBE_SYMBOL(notifier_call_chain);
 
+static int notifier_call_chain_error(struct notifier_block **nl,
+				     unsigned long val_up, unsigned long val_down,
+				     void *v)
+{
+	int ret, nr = 0;
+
+	ret = notifier_call_chain(nl, val_up, v, -1, &nr);
+	if (ret & NOTIFY_STOP_MASK)
+		notifier_call_chain(nl, val_down, v, nr-1, NULL);
+
+	return ret;
+}
+
 /*
  *	Atomic notifier chain routines.  Registration and unregistration
  *	use a spinlock, and call_chain is synchronized by RCU (no locks).
@@ -156,43 +169,30 @@ int atomic_notifier_chain_unregister(str
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
 
-/**
- *	__atomic_notifier_call_chain - Call functions in an atomic notifier chain
- *	@nh: Pointer to head of the atomic notifier chain
- *	@val: Value passed unmodified to notifier function
- *	@v: Pointer passed unmodified to notifier function
- *	@nr_to_call: See the comment for notifier_call_chain.
- *	@nr_calls: See the comment for notifier_call_chain.
- *
- *	Calls each function in a notifier chain in turn.  The functions
- *	run in an atomic context, so they must not block.
- *	This routine uses RCU to synchronize with changes to the chain.
- *
- *	If the return value of the notifier can be and'ed
- *	with %NOTIFY_STOP_MASK then atomic_notifier_call_chain()
- *	will return immediately, with the return value of
- *	the notifier function which halted execution.
- *	Otherwise the return value is the return value
- *	of the last notifier function called.
- */
-int __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
-				 unsigned long val, void *v,
-				 int nr_to_call, int *nr_calls)
+int atomic_notifier_call_chain_error(struct atomic_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v)
 {
 	int ret;
 
 	rcu_read_lock();
-	ret = notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
+	ret = notifier_call_chain_error(&nh->head, val_up, val_down, v);
 	rcu_read_unlock();
+
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__atomic_notifier_call_chain);
-NOKPROBE_SYMBOL(__atomic_notifier_call_chain);
+EXPORT_SYMBOL_GPL(atomic_notifier_call_chain_error);
+NOKPROBE_SYMBOL(atomic_notifier_call_chain_error);
 
 int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
 			       unsigned long val, void *v)
 {
-	return __atomic_notifier_call_chain(nh, val, v, -1, NULL);
+	int ret;
+
+	rcu_read_lock();
+	ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
+	rcu_read_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
 NOKPROBE_SYMBOL(atomic_notifier_call_chain);
@@ -285,27 +285,8 @@ int blocking_notifier_chain_unregister(s
 }
 EXPORT_SYMBOL_GPL(blocking_notifier_chain_unregister);
 
-/**
- *	__blocking_notifier_call_chain - Call functions in a blocking notifier chain
- *	@nh: Pointer to head of the blocking notifier chain
- *	@val: Value passed unmodified to notifier function
- *	@v: Pointer passed unmodified to notifier function
- *	@nr_to_call: See comment for notifier_call_chain.
- *	@nr_calls: See comment for notifier_call_chain.
- *
- *	Calls each function in a notifier chain in turn.  The functions
- *	run in a process context, so they are allowed to block.
- *
- *	If the return value of the notifier can be and'ed
- *	with %NOTIFY_STOP_MASK then blocking_notifier_call_chain()
- *	will return immediately, with the return value of
- *	the notifier function which halted execution.
- *	Otherwise the return value is the return value
- *	of the last notifier function called.
- */
-int __blocking_notifier_call_chain(struct blocking_notifier_head *nh,
-				   unsigned long val, void *v,
-				   int nr_to_call, int *nr_calls)
+int blocking_notifier_call_chain_error(struct blocking_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v)
 {
 	int ret = NOTIFY_DONE;
 
@@ -316,18 +297,29 @@ int __blocking_notifier_call_chain(struc
 	 */
 	if (rcu_access_pointer(nh->head)) {
 		down_read(&nh->rwsem);
-		ret = notifier_call_chain(&nh->head, val, v, nr_to_call,
-					nr_calls);
+		ret = notifier_call_chain_error(&nh->head, val_up, val_down, v);
 		up_read(&nh->rwsem);
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__blocking_notifier_call_chain);
+EXPORT_SYMBOL_GPL(blocking_notifier_call_chain_error);
 
 int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 		unsigned long val, void *v)
 {
-	return __blocking_notifier_call_chain(nh, val, v, -1, NULL);
+	int ret = NOTIFY_DONE;
+
+	/*
+	 * We check the head outside the lock, but if this access is
+	 * racy then it does not matter what the result of the test
+	 * is, we re-check the list after having taken the lock anyway:
+	 */
+	if (rcu_access_pointer(nh->head)) {
+		down_read(&nh->rwsem);
+		ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
+		up_read(&nh->rwsem);
+	}
+	return ret;
 }
 EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
 
@@ -370,37 +362,17 @@ int raw_notifier_chain_unregister(struct
 }
 EXPORT_SYMBOL_GPL(raw_notifier_chain_unregister);
 
-/**
- *	__raw_notifier_call_chain - Call functions in a raw notifier chain
- *	@nh: Pointer to head of the raw notifier chain
- *	@val: Value passed unmodified to notifier function
- *	@v: Pointer passed unmodified to notifier function
- *	@nr_to_call: See comment for notifier_call_chain.
- *	@nr_calls: See comment for notifier_call_chain
- *
- *	Calls each function in a notifier chain in turn.  The functions
- *	run in an undefined context.
- *	All locking must be provided by the caller.
- *
- *	If the return value of the notifier can be and'ed
- *	with %NOTIFY_STOP_MASK then raw_notifier_call_chain()
- *	will return immediately, with the return value of
- *	the notifier function which halted execution.
- *	Otherwise the return value is the return value
- *	of the last notifier function called.
- */
-int __raw_notifier_call_chain(struct raw_notifier_head *nh,
-			      unsigned long val, void *v,
-			      int nr_to_call, int *nr_calls)
+int raw_notifier_call_chain_error(struct raw_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v)
 {
-	return notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
+	return notifier_call_chain_error(&nh->head, val_up, val_down, v);
 }
-EXPORT_SYMBOL_GPL(__raw_notifier_call_chain);
+EXPORT_SYMBOL_GPL(raw_notifier_call_chain_error);
 
 int raw_notifier_call_chain(struct raw_notifier_head *nh,
 		unsigned long val, void *v)
 {
-	return __raw_notifier_call_chain(nh, val, v, -1, NULL);
+	return notifier_call_chain(&nh->head, val, v, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
 
@@ -471,42 +443,29 @@ int srcu_notifier_chain_unregister(struc
 }
 EXPORT_SYMBOL_GPL(srcu_notifier_chain_unregister);
 
-/**
- *	__srcu_notifier_call_chain - Call functions in an SRCU notifier chain
- *	@nh: Pointer to head of the SRCU notifier chain
- *	@val: Value passed unmodified to notifier function
- *	@v: Pointer passed unmodified to notifier function
- *	@nr_to_call: See comment for notifier_call_chain.
- *	@nr_calls: See comment for notifier_call_chain
- *
- *	Calls each function in a notifier chain in turn.  The functions
- *	run in a process context, so they are allowed to block.
- *
- *	If the return value of the notifier can be and'ed
- *	with %NOTIFY_STOP_MASK then srcu_notifier_call_chain()
- *	will return immediately, with the return value of
- *	the notifier function which halted execution.
- *	Otherwise the return value is the return value
- *	of the last notifier function called.
- */
-int __srcu_notifier_call_chain(struct srcu_notifier_head *nh,
-			       unsigned long val, void *v,
-			       int nr_to_call, int *nr_calls)
+int srcu_notifier_call_chain_error(struct srcu_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v)
 {
 	int ret;
 	int idx;
 
 	idx = srcu_read_lock(&nh->srcu);
-	ret = notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
+	ret = notifier_call_chain_error(&nh->head, val_up, val_down, v);
 	srcu_read_unlock(&nh->srcu, idx);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__srcu_notifier_call_chain);
+EXPORT_SYMBOL_GPL(srcu_notifier_call_chain_error);
 
 int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
 		unsigned long val, void *v)
 {
-	return __srcu_notifier_call_chain(nh, val, v, -1, NULL);
+	int ret;
+	int idx;
+
+	idx = srcu_read_lock(&nh->srcu);
+	ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
+	srcu_read_unlock(&nh->srcu, idx);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(srcu_notifier_call_chain);
 
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -693,8 +693,8 @@ static int load_image_and_restore(void)
  */
 int hibernate(void)
 {
-	int error, nr_calls = 0;
 	bool snapshot_test = false;
+	int error;
 
 	if (!hibernation_available()) {
 		pm_pr_dbg("Hibernation not available.\n");
@@ -710,11 +710,9 @@ int hibernate(void)
 
 	pr_info("hibernation entry\n");
 	pm_prepare_console();
-	error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
-	if (error) {
-		nr_calls--;
-		goto Exit;
-	}
+	error = pm_notifier_call_chain_error(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
+	if (error)
+		goto Restore;
 
 	ksys_sync_helper();
 
@@ -772,7 +770,8 @@ int hibernate(void)
 	/* Don't bother checking whether freezer_test_done is true */
 	freezer_test_done = false;
  Exit:
-	__pm_notifier_call_chain(PM_POST_HIBERNATION, nr_calls, NULL);
+	pm_notifier_call_chain(PM_POST_HIBERNATION);
+ Restore:
 	pm_restore_console();
 	atomic_inc(&snapshot_device_available);
  Unlock:
@@ -800,7 +799,7 @@ int hibernate(void)
  */
 static int software_resume(void)
 {
-	int error, nr_calls = 0;
+	int error;
 
 	/*
 	 * If the user said "noresume".. bail out early.
@@ -887,11 +886,9 @@ static int software_resume(void)
 
 	pr_info("resume from hibernation\n");
 	pm_prepare_console();
-	error = __pm_notifier_call_chain(PM_RESTORE_PREPARE, -1, &nr_calls);
-	if (error) {
-		nr_calls--;
-		goto Close_Finish;
-	}
+	error = pm_notifier_call_chain_error(PM_RESTORE_PREPARE, PM_POST_RESTORE);
+	if (error)
+		goto Restore;
 
 	pm_pr_dbg("Preparing processes for restore.\n");
 	error = freeze_processes();
@@ -900,7 +897,8 @@ static int software_resume(void)
 	error = load_image_and_restore();
 	thaw_processes();
  Finish:
-	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
+	pm_notifier_call_chain(PM_POST_RESTORE);
+ Restore:
 	pm_restore_console();
 	pr_info("resume from hibernation failed (%d)\n", error);
 	atomic_inc(&snapshot_device_available);
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -79,18 +79,18 @@ int unregister_pm_notifier(struct notifi
 }
 EXPORT_SYMBOL_GPL(unregister_pm_notifier);
 
-int __pm_notifier_call_chain(unsigned long val, int nr_to_call, int *nr_calls)
+int pm_notifier_call_chain_error(unsigned long val_up, unsigned long val_down)
 {
 	int ret;
 
-	ret = __blocking_notifier_call_chain(&pm_chain_head, val, NULL,
-						nr_to_call, nr_calls);
+	ret = blocking_notifier_call_chain_error(&pm_chain_head, val_up, val_down, NULL);
 
 	return notifier_to_errno(ret);
 }
+
 int pm_notifier_call_chain(unsigned long val)
 {
-	return __pm_notifier_call_chain(val, -1, NULL);
+	return blocking_notifier_call_chain(&pm_chain_head, val, NULL);
 }
 
 /* If set, devices may be suspended and resumed asynchronously. */
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -212,8 +212,7 @@ static inline void suspend_test_finish(c
 
 #ifdef CONFIG_PM_SLEEP
 /* kernel/power/main.c */
-extern int __pm_notifier_call_chain(unsigned long val, int nr_to_call,
-				    int *nr_calls);
+extern int pm_notifier_call_chain_error(unsigned long val_up, unsigned long val_down);
 extern int pm_notifier_call_chain(unsigned long val);
 #endif
 
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -352,18 +352,16 @@ static int suspend_test(int level)
  */
 static int suspend_prepare(suspend_state_t state)
 {
-	int error, nr_calls = 0;
+	int error;
 
 	if (!sleep_state_supported(state))
 		return -EPERM;
 
 	pm_prepare_console();
 
-	error = __pm_notifier_call_chain(PM_SUSPEND_PREPARE, -1, &nr_calls);
-	if (error) {
-		nr_calls--;
-		goto Finish;
-	}
+	error = pm_notifier_call_chain_error(PM_SUSPEND_PREPARE, PM_POST_SUSPEND);
+	if (error)
+		goto Restore;
 
 	trace_suspend_resume(TPS("freeze_processes"), 0, true);
 	error = suspend_freeze_processes();
@@ -373,8 +371,8 @@ static int suspend_prepare(suspend_state
 
 	suspend_stats.failed_freeze++;
 	dpm_save_failed_step(SUSPEND_FREEZE);
- Finish:
-	__pm_notifier_call_chain(PM_POST_SUSPEND, nr_calls, NULL);
+	pm_notifier_call_chain(PM_POST_SUSPEND);
+ Restore:
 	pm_restore_console();
 	return error;
 }
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -44,7 +44,7 @@ atomic_t snapshot_device_available = ATO
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
-	int error, nr_calls = 0;
+	int error;
 
 	if (!hibernation_available())
 		return -EPERM;
@@ -71,9 +71,7 @@ static int snapshot_open(struct inode *i
 			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
 		data->mode = O_RDONLY;
 		data->free_bitmaps = false;
-		error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
-		if (error)
-			__pm_notifier_call_chain(PM_POST_HIBERNATION, --nr_calls, NULL);
+		error = pm_notifier_call_chain_error(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
 	} else {
 		/*
 		 * Resuming.  We may need to wait for the image device to
@@ -83,15 +81,11 @@ static int snapshot_open(struct inode *i
 
 		data->swap = -1;
 		data->mode = O_WRONLY;
-		error = __pm_notifier_call_chain(PM_RESTORE_PREPARE, -1, &nr_calls);
+		error = pm_notifier_call_chain_error(PM_RESTORE_PREPARE, PM_POST_RESTORE);
 		if (!error) {
 			error = create_basic_memory_bitmaps();
 			data->free_bitmaps = !error;
-		} else
-			nr_calls--;
-
-		if (error)
-			__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
+		}
 	}
 	if (error)
 		atomic_inc(&snapshot_device_available);
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -146,7 +146,7 @@ from subprocess import call, Popen, PIPE
 	tracefuncs = {
 		'sys_sync': {},
 		'ksys_sync': {},
-		'__pm_notifier_call_chain': {},
+		'pm_notifier_call_chain_error': {},
 		'pm_prepare_console': {},
 		'pm_notifier_call_chain': {},
 		'freeze_processes': {},


