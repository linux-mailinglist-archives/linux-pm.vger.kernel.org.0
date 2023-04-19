Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE36E7D04
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjDSOkd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 10:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjDSOkW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 10:40:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB2F5FE9
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 07:40:14 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325079366"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325079366"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 07:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021232698"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="1021232698"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005.fm.intel.com with ESMTP; 19 Apr 2023 07:39:53 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 4/7] intel_idle: improve C-state flags handling robustness
Date:   Wed, 19 Apr 2023 17:39:44 +0300
Message-Id: <20230419143947.1342730-5-dedekind1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230419143947.1342730-1-dedekind1@gmail.com>
References: <20230419143947.1342730-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The following C-state flags are currently mutually-exclusive and should not
be combined:
  * IRQ_ENABLE
  * IBRS
  * XSTATE

There is a warning for the situation when the IRQ_ENABLE flag
is combined with the IBRS flag, but no warnings for other combinations.
This is inconsistent and prone to errors.

Improve the situation by adding warnings for all the unexpected
combinations. Add a couple of helpful commentaries too.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 73ddb1d8cfcf..1de36df15d5a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1896,20 +1896,28 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 		state = &drv->states[drv->state_count];
 
-		if ((state->flags & CPUIDLE_FLAG_IRQ_ENABLE) || force_irq_on) {
-			pr_info("forced intel_idle_irq for state %d\n", cstate);
-			state->enter = intel_idle_irq;
-		}
-
-		if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
-		    state->flags & CPUIDLE_FLAG_IBRS) {
+		if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
+			/*
+			 * Combining with XSTATE with IBRS or IRQ_ENABLE flags
+			 * is not currently supported but this driver.
+			 */
+			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IBRS);
+			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
+			state->enter = intel_idle_xstate;
+		} else if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
+			   state->flags & CPUIDLE_FLAG_IBRS) {
+			/*
+			 * IBRS mitigation requires that C-states are entered
+			 * with interrupts disabled.
+			 */
 			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
 			state->enter = intel_idle_ibrs;
+		} else if ((state->flags & CPUIDLE_FLAG_IRQ_ENABLE) ||
+			   force_irq_on) {
+			pr_info("forced intel_idle_irq for state %d\n", cstate);
+			state->enter = intel_idle_irq;
 		}
 
-		if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
-			state->enter = intel_idle_xstate;
-
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
 		     intel_idle_off_by_default(mwait_hint) &&
-- 
2.38.1

