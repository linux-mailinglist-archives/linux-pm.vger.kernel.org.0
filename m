Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F386E8A9C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 08:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjDTGrY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 02:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDTGrX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 02:47:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00CC269E
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 23:47:21 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="410886294"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="410886294"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 23:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691788707"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="691788707"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2023 23:47:19 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rui Zhang <rui.zhang@intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH v2 2/7] intel_idle: cleanup 'intel_idle_init_cstates_icpu()'
Date:   Thu, 20 Apr 2023 09:47:18 +0300
Message-Id: <20230420064718.1981936-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230419143947.1342730-3-dedekind1@gmail.com>
References: <20230419143947.1342730-3-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The 'intel_idle_init_cstates_icpu()' function includes a loop that iterates
over every C-state. Inside the loop, the same C-state data is referenced 2
ways:
 1. as 'cpuidle_state_table[cstate]'
 2. as 'drv->states[drv->state_count]' (but it is a copy of #1, not the same
    object).

Make the code be more consistent and easier to read by using only the 2nd
way. So the code structure would be as follows.

1. Use 'cpuidle_state_table[cstate]'
2. Copy ''cpuidle_state_table[cstate]' to 'drv->states[drv->state_count]'
3. Use only 'drv->states[drv->state_count]' from this point.

Note, this change introduces a checkpatch.pl warning (too long line), but it
will be addressed in the next patch.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Changelog
 * v2
   - Adjust commit message (feedback from Rui Zhang).

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 726a361da422..190410fc9ce5 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1894,24 +1894,24 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		/* Structure copy. */
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 
-		if ((cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE) || force_irq_on) {
+		if ((drv->states[drv->state_count].flags & CPUIDLE_FLAG_IRQ_ENABLE) || force_irq_on) {
 			pr_info("forced intel_idle_irq for state %d\n", cstate);
 			drv->states[drv->state_count].enter = intel_idle_irq;
 		}
 
 		if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
-		    cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IBRS) {
-			WARN_ON_ONCE(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE);
+		    drv->states[drv->state_count].flags & CPUIDLE_FLAG_IBRS) {
+			WARN_ON_ONCE(drv->states[drv->state_count].flags & CPUIDLE_FLAG_IRQ_ENABLE);
 			drv->states[drv->state_count].enter = intel_idle_ibrs;
 		}
 
-		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_INIT_XSTATE)
+		if (drv->states[drv->state_count].flags & CPUIDLE_FLAG_INIT_XSTATE)
 			drv->states[drv->state_count].enter = intel_idle_xstate;
 
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
 		     intel_idle_off_by_default(mwait_hint) &&
-		     !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
+		     !(drv->states[drv->state_count].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
 			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
 
 		if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
-- 
2.38.1

