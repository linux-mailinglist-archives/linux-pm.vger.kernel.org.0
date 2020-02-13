Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4923D15CDBC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 23:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgBMWFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 17:05:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57327 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgBMWFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 17:05:07 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 73a572daf3199568; Thu, 13 Feb 2020 23:05:05 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/9] intel_idle: Clean up definitions of cpuidle callbacks
Date:   Thu, 13 Feb 2020 22:59:56 +0100
Message-ID: <1923258.fxMWiWM92A@kreacher>
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

Add proper kerneldoc descriptions to intel_idle() and
intel_idle_s2idle(), annotate the latter with __cpuidle and
reorder the declarations of local variables in both of them to
reflect the mwait_idle_with_hints() arguments order.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8d66efc53b89..5adc058c705d 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -892,19 +892,28 @@ static struct cpuidle_state dnv_cstates[] = {
 };
 
 /**
- * intel_idle
- * @dev: cpuidle_device
- * @drv: cpuidle driver
- * @index: index of cpuidle state
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
  *
  * Must be called under local_irq_disable().
  */
 static __cpuidle int intel_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int index)
 {
-	unsigned long ecx = 1; /* break on interrupt flag */
 	struct cpuidle_state *state = &drv->states[index];
 	unsigned long eax = flg2MWAIT(state->flags);
+	unsigned long ecx = 1; /* break on interrupt flag */
 	bool uninitialized_var(tick);
 	int cpu = smp_processor_id();
 
@@ -937,16 +946,22 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 }
 
 /**
- * intel_idle_s2idle - simplified "enter" callback routine for suspend-to-idle
- * @dev: cpuidle_device
- * @drv: cpuidle driver
- * @index: state index
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
  */
-static void intel_idle_s2idle(struct cpuidle_device *dev,
-			     struct cpuidle_driver *drv, int index)
+static __cpuidle void intel_idle_s2idle(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
 {
-	unsigned long ecx = 1; /* break on interrupt flag */
 	unsigned long eax = flg2MWAIT(drv->states[index].flags);
+	unsigned long ecx = 1; /* break on interrupt flag */
 
 	mwait_idle_with_hints(eax, ecx);
 }
-- 
2.16.4





