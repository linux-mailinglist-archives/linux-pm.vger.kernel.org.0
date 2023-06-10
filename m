Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958AF72AE1F
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jun 2023 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjFJSfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jun 2023 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjFJSf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jun 2023 14:35:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9230F1
        for <linux-pm@vger.kernel.org>; Sat, 10 Jun 2023 11:35:28 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="356683696"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="356683696"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 11:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="688116121"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="688116121"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2023 11:35:23 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH v3 2/2] intel_idle: add C0.2 state for Sapphire Rapids Xeon
Date:   Sat, 10 Jun 2023 21:35:18 +0300
Message-Id: <20230610183518.4061159-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610183518.4061159-1-dedekind1@gmail.com>
References: <20230610183518.4061159-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Add Sapphire Rapids Xeon C0.2 state support. This state has a lower exit
latency comparing to C1, and saves energy comparing to POLL.

C0.2 may also improve performance (e.g., as measured by 'hackbench'), because
idle CPU power savings in C0.2 increase busy CPU power budget and therefore,
improve turbo boost of the busy CPU.

Suggested-by: Len Brown <len.brown@intel.com>
Suggested-by: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 0bf5e9f5bed8..51f56001e2cd 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -130,6 +130,11 @@ static unsigned int mwait_substates __initdata;
 #define flg2MWAIT(flags) (((flags) >> 24) & 0xFF)
 #define MWAIT2flg(eax) ((eax & 0xFF) << 24)
 
+/*
+ * The maximum possible 'umwait' deadline value.
+ */
+#define UMWAIT_MAX_DEADLINE (~((u64)0))
+
 static __always_inline int __intel_idle(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv, int index)
 {
@@ -263,6 +268,32 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
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
+	/*
+	 * Use the maximum possible deadline value. This means that 'C0.x'
+	 * residency will be limited by the global limit in
+	 * 'IA32_UMWAIT_CONTROL'.
+	 */
+	umwait_idle(UMWAIT_MAX_DEADLINE, state);
+	raw_local_irq_disable();
+
+	return index;
+}
+
 /*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
@@ -1006,6 +1037,13 @@ static struct cpuidle_state adl_n_cstates[] __initdata = {
 };
 
 static struct cpuidle_state spr_cstates[] __initdata = {
+	{
+		.name = "C0.2",
+		.desc = "UMWAIT C0.2",
+		.flags = MWAIT2flg(TPAUSE_C02_STATE) | CPUIDLE_FLAG_IRQ_ENABLE,
+		.exit_latency_ns = 200,
+		.target_residency_ns = 200,
+		.enter = &intel_idle_umwait_irq, },
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -1904,7 +1942,9 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 		}
 		return;
 	}
-	if (state->enter == intel_idle_hlt_irq_on)
+
+	if (state->enter == intel_idle_hlt_irq_on ||
+	    state->enter == intel_idle_umwait_irq)
 		return; /* no update scenarios */
 
 	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
@@ -1959,6 +1999,8 @@ static bool should_verify_mwait(struct cpuidle_state *state)
 		return false;
 	if (state->enter == intel_idle_hlt_irq_on)
 		return false;
+	if (state->enter == intel_idle_umwait_irq)
+		return false;
 
 	return true;
 }
-- 
2.40.1

