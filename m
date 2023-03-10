Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671A36B3F12
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 13:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCJMVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 07:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjCJMVV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 07:21:21 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78902112590
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 04:21:17 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="399314629"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="399314629"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 04:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="671066083"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="671066083"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007.jf.intel.com with ESMTP; 10 Mar 2023 04:21:16 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, Linux PM Mailing List <linux-pm@vger.kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH v2 3/3] intel_idle: add C0.2 state for Sapphire Rapids Xeon
Date:   Fri, 10 Mar 2023 14:21:10 +0200
Message-Id: <20230310122110.895093-4-dedekind1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230310122110.895093-1-dedekind1@gmail.com>
References: <20230310122110.895093-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Add Sapphire Rapids Xeon C0.2 state support. This state has a lower exit
latency comparing to C1, and saves energy comparing to POLL (in range of
5-20%).

This patch also improves performance (e.g., as measured by 'hackbench'),
because idle CPU power savings in C0.2 increase busy CPU power budget and
therefore, improve turbo boost of the busy CPU.

Suggested-by: Len Brown <len.brown@intel.com>
Suggested-by: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 58 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 938c17f25d94..0d0e45de610e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -51,11 +51,13 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <linux/units.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/nospec-branch.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/tsc.h>
 #include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
@@ -73,6 +75,8 @@ static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
 static unsigned long auto_demotion_disable_flags;
 
+static u64 umwait_limit;
+
 static enum {
 	C1E_PROMOTION_PRESERVE,
 	C1E_PROMOTION_ENABLE,
@@ -225,6 +229,27 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 	return 0;
 }
 
+/**
+ * intel_idle_umwait_irq - Request C0.x using the 'umwait' instruction.
+ * @dev: cpuidle device of the target CPU.
+ * @drv: cpuidle driver (assumed to point to intel_idle_driver).
+ * @index: Target idle state index.
+ *
+ * Request C0.1 or C0.2 using 'umwait' instruction with interrupts enabled.
+ */
+static __cpuidle int intel_idle_umwait_irq(struct cpuidle_device *dev,
+					   struct cpuidle_driver *drv,
+					   int index)
+{
+	u32 state = flg2MWAIT(drv->states[index].flags);
+
+	raw_local_irq_enable();
+	umwait_idle(rdtsc() + umwait_limit, state);
+	raw_local_irq_disable();
+
+	return index;
+}
+
 /*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
@@ -968,6 +993,13 @@ static struct cpuidle_state adl_n_cstates[] __initdata = {
 };
 
 static struct cpuidle_state spr_cstates[] __initdata = {
+	{
+		.name = "C0.2",
+		.desc = "UMWAIT C0.2",
+		.flags = MWAIT2flg(TPAUSE_C02_STATE) | CPUIDLE_FLAG_IRQ_ENABLE,
+		.exit_latency_ns = 100,
+		.target_residency_ns = 100,
+		.enter = &intel_idle_umwait_irq, },
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -1894,7 +1926,8 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		/* Structure copy. */
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 
-		if ((cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE) || force_irq_on) {
+		if (cpuidle_state_table[cstate].enter == intel_idle &&
+		    ((cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE) || force_irq_on)) {
 			printk("intel_idle: forced intel_idle_irq for state %d\n", cstate);
 			drv->states[drv->state_count].enter = intel_idle_irq;
 		}
@@ -1926,6 +1959,28 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	}
 }
 
+/**
+ * umwait_limit_init - initialize time limit value for 'umwait'.
+ *
+ * C0.1 and C0.2 (later C0.x) idle states are requested via the 'umwait'
+ * instruction. The 'umwait' instruction requires the "deadline" - the TSC
+ * counter value to break out of C0.x (unless it broke out because of an
+ * interrupt or some other event).
+ *
+ * The deadline is specified as an absolute TSC value, and it is calculated as
+ * current TSC value + 'umwait_limit'. This function initializes the
+ * 'umwait_limit' variable to count of cycles per tick. The motivation is:
+ *   * the tick is not disabled for shallow states like C0.x so, so idle will
+ *     not last longer than a tick anyway
+ *   * limit idle time to give cpuidle a chance to re-evaluate its C-state
+ *     selection decision and possibly select a deeper C-state.
+ */
+static void __init umwait_limit_init(void)
+{
+	umwait_limit = (u64)TICK_NSEC * tsc_khz;
+	do_div(umwait_limit, MICRO);
+}
+
 /**
  * intel_idle_cpuidle_driver_init - Create the list of available idle states.
  * @drv: cpuidle driver structure to initialize.
@@ -1933,6 +1988,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 static void __init intel_idle_cpuidle_driver_init(struct cpuidle_driver *drv)
 {
 	cpuidle_poll_state_init(drv);
+	umwait_limit_init();
 
 	if (disabled_states_mask & BIT(0))
 		drv->states[0].flags |= CPUIDLE_FLAG_OFF;
-- 
2.38.1

