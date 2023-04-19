Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88126E7D08
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjDSOke (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjDSOkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 10:40:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D54C3A
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 07:40:14 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325079362"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325079362"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 07:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021232656"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="1021232656"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005.fm.intel.com with ESMTP; 19 Apr 2023 07:39:52 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 3/7] intel_idle: further 'intel_idle_init_cstates_icpu()' cleanup
Date:   Wed, 19 Apr 2023 17:39:43 +0300
Message-Id: <20230419143947.1342730-4-dedekind1@gmail.com>
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

Introduce a temporary 'state' variable for referencing the currently
processed C-state in the 'intel_idle_init_cstates_icpu()' function.

This makes code lines shorter and easier to read.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 190410fc9ce5..73ddb1d8cfcf 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1871,6 +1871,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	}
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
+		struct cpuidle_state *state;
 		unsigned int mwait_hint;
 
 		if (intel_idle_max_cstate_reached(cstate))
@@ -1893,29 +1894,30 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 
 		/* Structure copy. */
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
+		state = &drv->states[drv->state_count];
 
-		if ((drv->states[drv->state_count].flags & CPUIDLE_FLAG_IRQ_ENABLE) || force_irq_on) {
+		if ((state->flags & CPUIDLE_FLAG_IRQ_ENABLE) || force_irq_on) {
 			pr_info("forced intel_idle_irq for state %d\n", cstate);
-			drv->states[drv->state_count].enter = intel_idle_irq;
+			state->enter = intel_idle_irq;
 		}
 
 		if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
-		    drv->states[drv->state_count].flags & CPUIDLE_FLAG_IBRS) {
-			WARN_ON_ONCE(drv->states[drv->state_count].flags & CPUIDLE_FLAG_IRQ_ENABLE);
-			drv->states[drv->state_count].enter = intel_idle_ibrs;
+		    state->flags & CPUIDLE_FLAG_IBRS) {
+			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
+			state->enter = intel_idle_ibrs;
 		}
 
-		if (drv->states[drv->state_count].flags & CPUIDLE_FLAG_INIT_XSTATE)
-			drv->states[drv->state_count].enter = intel_idle_xstate;
+		if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
+			state->enter = intel_idle_xstate;
 
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
 		     intel_idle_off_by_default(mwait_hint) &&
-		     !(drv->states[drv->state_count].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
-			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
+		     !(state->flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
+			state->flags |= CPUIDLE_FLAG_OFF;
 
-		if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
-			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_TIMER_STOP;
+		if (intel_idle_state_needs_timer_stop(state))
+			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
 		drv->state_count++;
 	}
-- 
2.38.1

