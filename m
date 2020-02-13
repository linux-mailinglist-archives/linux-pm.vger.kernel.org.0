Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F715CDC6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 23:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgBMWF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 17:05:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58160 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgBMWFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 17:05:07 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 9838aecf9c4dd2d0; Thu, 13 Feb 2020 23:05:04 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 3/9] intel_idle: Relocate definitions of cpuidle callbacks
Date:   Thu, 13 Feb 2020 23:00:26 +0100
Message-ID: <2912140.PDVJEUYNKe@kreacher>
In-Reply-To: <2960689.qre192dJKD@kreacher>
References: <2960689.qre192dJKD@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Move the definitions of intel_idle() and intel_idle_s2idle() before
the definitions of cpuidle_state structures referring to them to
avoid having to use additional declarations of them (and drop those
declarations).

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 154 ++++++++++++++++++++++------------------------
 1 file changed, 75 insertions(+), 79 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5adc058c705d..e0332d567735 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -83,10 +83,6 @@ struct idle_cpu {
 
 static const struct idle_cpu *icpu;
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
-static int intel_idle(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv, int index);
-static void intel_idle_s2idle(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv, int index);
 static struct cpuidle_state *cpuidle_state_table;
 
 /*
@@ -112,6 +108,81 @@ static struct cpuidle_state *cpuidle_state_table;
 #define flg2MWAIT(flags) (((flags) >> 24) & 0xFF)
 #define MWAIT2flg(eax) ((eax & 0xFF) << 24)
 
+/**
+ * intel_idle - Ask the processor to enter the given idle state.
+ * @dev: cpuidle device of the target CPU.
+ * @drv: cpuidle driver (assumed to point to intel_idle_driver).
+ * @index: Target idle state index.
+ *
+ * Use the MWAIT instruction to notify the processor that the CPU represented by
+ * @dev is idle and it can try to enter the idle state corresponding to @index.
+ *
+ * If the local APIC timer is not known to be reliable in the target idle state,
+ * enable one-shot tick broadcasting for the target CPU before executing MWAIT.
+ *
+ * Optionally call leave_mm() for the target CPU upfront to avoid wakeups due to
+ * flushing user TLBs.
+ *
+ * Must be called under local_irq_disable().
+ */
+static __cpuidle int intel_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int index)
+{
+	struct cpuidle_state *state = &drv->states[index];
+	unsigned long eax = flg2MWAIT(state->flags);
+	unsigned long ecx = 1; /* break on interrupt flag */
+	bool uninitialized_var(tick);
+	int cpu = smp_processor_id();
+
+	/*
+	 * leave_mm() to avoid costly and often unnecessary wakeups
+	 * for flushing the user TLB's associated with the active mm.
+	 */
+	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
+		leave_mm(cpu);
+
+	if (!static_cpu_has(X86_FEATURE_ARAT) && !lapic_timer_always_reliable) {
+		/*
+		 * Switch over to one-shot tick broadcast if the target C-state
+		 * is deeper than C1.
+		 */
+		if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) {
+			tick = true;
+			tick_broadcast_enter();
+		} else {
+			tick = false;
+		}
+	}
+
+	mwait_idle_with_hints(eax, ecx);
+
+	if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
+		tick_broadcast_exit();
+
+	return index;
+}
+
+/**
+ * intel_idle_s2idle - Ask the processor to enter the given idle state.
+ * @dev: cpuidle device of the target CPU.
+ * @drv: cpuidle driver (assumed to point to intel_idle_driver).
+ * @index: Target idle state index.
+ *
+ * Use the MWAIT instruction to notify the processor that the CPU represented by
+ * @dev is idle and it can try to enter the idle state corresponding to @index.
+ *
+ * Invoked as a suspend-to-idle callback routine with frozen user space, frozen
+ * scheduler tick and suspended scheduler clock on the target CPU.
+ */
+static __cpuidle void intel_idle_s2idle(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
+{
+	unsigned long eax = flg2MWAIT(drv->states[index].flags);
+	unsigned long ecx = 1; /* break on interrupt flag */
+
+	mwait_idle_with_hints(eax, ecx);
+}
+
 /*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
@@ -891,81 +962,6 @@ static struct cpuidle_state dnv_cstates[] = {
 		.enter = NULL }
 };
 
-/**
- * intel_idle - Ask the processor to enter the given idle state.
- * @dev: cpuidle device of the target CPU.
- * @drv: cpuidle driver (assumed to point to intel_idle_driver).
- * @index: Target idle state index.
- *
- * Use the MWAIT instruction to notify the processor that the CPU represented by
- * @dev is idle and it can try to enter the idle state corresponding to @index.
- *
- * If the local APIC timer is not known to be reliable in the target idle state,
- * enable one-shot tick broadcasting for the target CPU before executing MWAIT.
- *
- * Optionally call leave_mm() for the target CPU upfront to avoid wakeups due to
- * flushing user TLBs.
- *
- * Must be called under local_irq_disable().
- */
-static __cpuidle int intel_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int index)
-{
-	struct cpuidle_state *state = &drv->states[index];
-	unsigned long eax = flg2MWAIT(state->flags);
-	unsigned long ecx = 1; /* break on interrupt flag */
-	bool uninitialized_var(tick);
-	int cpu = smp_processor_id();
-
-	/*
-	 * leave_mm() to avoid costly and often unnecessary wakeups
-	 * for flushing the user TLB's associated with the active mm.
-	 */
-	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
-		leave_mm(cpu);
-
-	if (!static_cpu_has(X86_FEATURE_ARAT) && !lapic_timer_always_reliable) {
-		/*
-		 * Switch over to one-shot tick broadcast if the target C-state
-		 * is deeper than C1.
-		 */
-		if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) {
-			tick = true;
-			tick_broadcast_enter();
-		} else {
-			tick = false;
-		}
-	}
-
-	mwait_idle_with_hints(eax, ecx);
-
-	if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
-		tick_broadcast_exit();
-
-	return index;
-}
-
-/**
- * intel_idle_s2idle - Ask the processor to enter the given idle state.
- * @dev: cpuidle device of the target CPU.
- * @drv: cpuidle driver (assumed to point to intel_idle_driver).
- * @index: Target idle state index.
- *
- * Use the MWAIT instruction to notify the processor that the CPU represented by
- * @dev is idle and it can try to enter the idle state corresponding to @index.
- *
- * Invoked as a suspend-to-idle callback routine with frozen user space, frozen
- * scheduler tick and suspended scheduler clock on the target CPU.
- */
-static __cpuidle void intel_idle_s2idle(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv, int index)
-{
-	unsigned long eax = flg2MWAIT(drv->states[index].flags);
-	unsigned long ecx = 1; /* break on interrupt flag */
-
-	mwait_idle_with_hints(eax, ecx);
-}
-
 static const struct idle_cpu idle_cpu_nehalem = {
 	.state_table = nehalem_cstates,
 	.auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
-- 
2.16.4





