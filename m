Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE2F722BEB
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jun 2023 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjFEPud (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jun 2023 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjFEPti (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 11:49:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910831B4
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685980153; x=1717516153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jWGjcuuEGgWU0hFzgYwZnsaGs11aYXSsOoifvBqgUSM=;
  b=jSbETjE5nZlQ7qmQtjgNbbdR8UNAsNS3Vi6XbJdFaK7n48kSryXNhSWg
   nTEbKpKuUVdN2MxRwz0NzbNJTCOb+f5iWdNDlZ9a3GyZHe2ETbrHdZpIK
   h3s5L6Hd2xvqfzLXHKWBeSiIEn0cAupcz28uqhbjWdjBHopHCs6Elu7/6
   xapqZ7pks8a49aZXr1nXENpENAo5gFiC5Nvx+ZkL8T1PCZ8CfZa1DCXQg
   FE2st1CIBNog+bIi5IxbMOY3Ay5OKMcGHxnfzyBz/Hl7uisdOQqgK6T/v
   NwUe7RkdbaS7M8M4JOsPTIJkOuWr/ri4WE4J7wKo71G2B9PLt9k+YbCPT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="355256224"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="355256224"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="955374798"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="955374798"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:47:35 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rafael@kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 1/4] intel_idle: refactor state->enter manipulation into its own function
Date:   Mon,  5 Jun 2023 15:47:13 +0000
Message-Id: <20230605154716.840930-2-arjan@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605154716.840930-1-arjan@linux.intel.com>
References: <20230605154716.840930-1-arjan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

Since the 6.4 kernel, the logic for updating a state's enter method
based on "environmental conditions" (command line options, cpu sidechannel
workarounds etc etc) has gotten pretty complex.
This patch refactors this into a seperate small, self contained function
(no behavior changes) for improved readability and to make future
changes to this logic easier to do and understand.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 50 ++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index aa2d19db2b1d..c351b21c0875 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1839,6 +1839,32 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 	return true;
 }
 
+static void state_update_enter_method(struct cpuidle_state *state, int cstate)
+{
+	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
+		/*
+		 * Combining with XSTATE with IBRS or IRQ_ENABLE flags
+		 * is not currently supported but this driver.
+		 */
+		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IBRS);
+		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
+		state->enter = intel_idle_xstate;
+	} else if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
+			   state->flags & CPUIDLE_FLAG_IBRS) {
+		/*
+		 * IBRS mitigation requires that C-states are entered
+		 * with interrupts disabled.
+		 */
+		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
+		state->enter = intel_idle_ibrs;
+	} else if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE) {
+		state->enter = intel_idle_irq;
+	} else if (force_irq_on) {
+		pr_info("forced intel_idle_irq for state %d\n", cstate);
+		state->enter = intel_idle_irq;
+	}
+}
+
 static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
 	int cstate;
@@ -1894,28 +1920,8 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 		state = &drv->states[drv->state_count];
 
-		if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
-			/*
-			 * Combining with XSTATE with IBRS or IRQ_ENABLE flags
-			 * is not currently supported but this driver.
-			 */
-			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IBRS);
-			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
-			state->enter = intel_idle_xstate;
-		} else if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
-			   state->flags & CPUIDLE_FLAG_IBRS) {
-			/*
-			 * IBRS mitigation requires that C-states are entered
-			 * with interrupts disabled.
-			 */
-			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
-			state->enter = intel_idle_ibrs;
-		} else if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE) {
-			state->enter = intel_idle_irq;
-		} else if (force_irq_on) {
-			pr_info("forced intel_idle_irq for state %d\n", cstate);
-			state->enter = intel_idle_irq;
-		}
+		state_update_enter_method(state, cstate);
+
 
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
-- 
2.40.1

