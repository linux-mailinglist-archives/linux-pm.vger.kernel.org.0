Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653EE3E9981
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 22:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhHKUPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 16:15:08 -0400
Received: from foss.arm.com ([217.140.110.172]:57866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231948AbhHKUPI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Aug 2021 16:15:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFBA5D6E;
        Wed, 11 Aug 2021 13:14:43 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FD2B3F40C;
        Wed, 11 Aug 2021 13:14:42 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 1/2] cpu_pm: Make notifier chain use a raw_spinlock_t
Date:   Wed, 11 Aug 2021 21:14:31 +0100
Message-Id: <20210811201432.1976916-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811201432.1976916-1-valentin.schneider@arm.com>
References: <20210811201432.1976916-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Invoking atomic_notifier_chain_notify() requires acquiring a spinlock_t,
which can block under CONFIG_PREEMPT_RT. Notifications for members of the
cpu_pm notification chain will be issued by the idle task, which can never
block.

Making *all* atomic_notifiers use a raw_spinlock is too big of a hammer, as
only notifications issued by the idle task are problematic.

Special-case cpu_pm_notifier_chain by kludging a raw_notifier and
raw_spinlock_t together, matching the atomic_notifier behavior with a
raw_spinlock_t.

Fixes: 70d932985757 ("notifier: Fix broken error handling pattern")
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/cpu_pm.c | 50 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index f7e1d0eccdbc..246efc74e3f3 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -13,19 +13,32 @@
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
-static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
+/*
+ * atomic_notifiers use a spinlock_t, which can block under PREEMPT_RT.
+ * Notifications for cpu_pm will be issued by the idle task itself, which can
+ * never block, IOW it requires using a raw_spinlock_t.
+ */
+static struct {
+	struct raw_notifier_head chain;
+	raw_spinlock_t lock;
+} cpu_pm_notifier = {
+	.chain = RAW_NOTIFIER_INIT(cpu_pm_notifier.chain),
+	.lock  = __RAW_SPIN_LOCK_UNLOCKED(cpu_pm_notifier.lock),
+};
 
 static int cpu_pm_notify(enum cpu_pm_event event)
 {
 	int ret;
 
 	/*
-	 * atomic_notifier_call_chain has a RCU read critical section, which
-	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
-	 * RCU know this.
+	 * This introduces a RCU read critical section, which could be
+	 * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
+	 * this.
 	 */
 	rcu_irq_enter_irqson();
-	ret = atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
+	rcu_read_lock();
+	ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
+	rcu_read_unlock();
 	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
@@ -33,10 +46,13 @@ static int cpu_pm_notify(enum cpu_pm_event event)
 
 static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event event_down)
 {
+	unsigned long flags;
 	int ret;
 
 	rcu_irq_enter_irqson();
-	ret = atomic_notifier_call_chain_robust(&cpu_pm_notifier_chain, event_up, event_down, NULL);
+	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
+	ret = raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up, event_down, NULL);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
 	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
@@ -49,12 +65,17 @@ static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event ev
  * Add a driver to a list of drivers that are notified about
  * CPU and CPU cluster low power entry and exit.
  *
- * This function may sleep, and has the same return conditions as
- * raw_notifier_chain_register.
+ * This function has the same return conditions as raw_notifier_chain_register.
  */
 int cpu_pm_register_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&cpu_pm_notifier_chain, nb);
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
+	ret = raw_notifier_chain_register(&cpu_pm_notifier.chain, nb);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
 
@@ -64,12 +85,17 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
  *
  * Remove a driver from the CPU PM notifier list.
  *
- * This function may sleep, and has the same return conditions as
- * raw_notifier_chain_unregister.
+ * This function has the same return conditions as raw_notifier_chain_unregister.
  */
 int cpu_pm_unregister_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
+	ret = raw_notifier_chain_unregister(&cpu_pm_notifier.chain, nb);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
 
-- 
2.25.1

