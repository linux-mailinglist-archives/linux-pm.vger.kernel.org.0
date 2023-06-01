Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29CC71F1F9
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjFASav (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjFASao (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 14:30:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F151196
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685644242; x=1717180242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mWfrGVa+PTb4FgQoPCZsWhwVeY1hyETZCVFPyRVU/GM=;
  b=KqdnTM6Dio8UvkCMKgVhm9Ncp6zTcv0PYrLDhLvRlNYAOTZNE8vkR/eA
   MiOn57OD356+ZFyX7YYk39wTLlRLNLuae/UAf6j9l/S40MUy5x1b8YGL8
   QxaxnDM8oy8E0K0jKONBcq5GBOrk3KOhDTcldEd1p58ZOikWsH82jsMzV
   VZqw5G+J2ADKuwIUP3hL5rMP70aTvx8PCxz8/ixqqor6wKwSY/aKMSd/s
   e4hakcWp/z4pGekOWo6sqDZkOcMWRzMqFZsurjFDj9Gr7GQroF5Vu63cW
   Hae9l6r7iSwI1vyGc/SkZ45eKGNbFe+o1KJvqc/G3onyQoUu0x4JPGtl9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="383921626"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="383921626"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657900910"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657900910"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:19 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rafael@kernel.org,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 2/7] intel_idle: clean up the (new) state_update_enter_method function
Date:   Thu,  1 Jun 2023 18:27:56 +0000
Message-Id: <20230601182801.2622044-3-arjan@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601182801.2622044-1-arjan@linux.intel.com>
References: <20230601182801.2622044-1-arjan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arjan van de Ven <arjan.van.de.ven@intel.com>

Now that the logic for state_update_enter_method() is in its own
function, the long if .. else if .. else if .. else if chain
can be simplified by just returning from the function
at the various places. This does not change functionality,
but it makes the logic much simpler to read or modify later.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c351b21c0875..256c2d42e350 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1849,7 +1849,10 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IBRS);
 		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
 		state->enter = intel_idle_xstate;
-	} else if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
+		return;
+	}
+
+	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
 			   state->flags & CPUIDLE_FLAG_IBRS) {
 		/*
 		 * IBRS mitigation requires that C-states are entered
@@ -1857,9 +1860,15 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 		 */
 		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
 		state->enter = intel_idle_ibrs;
-	} else if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE) {
+		return;
+	}
+
+	if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE) {
 		state->enter = intel_idle_irq;
-	} else if (force_irq_on) {
+		return;
+	}
+
+	if (force_irq_on) {
 		pr_info("forced intel_idle_irq for state %d\n", cstate);
 		state->enter = intel_idle_irq;
 	}
-- 
2.40.1

