Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C228722BEC
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jun 2023 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjFEPud (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jun 2023 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjFEPt6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 11:49:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B570210C7
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685980173; x=1717516173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l7/dS8deGnMaGMsdTSlUpm4oZl0I8Css07WPimZdFFc=;
  b=Zvy0AvawIKeagaRjUQNOEtsKFQYXYxYeTfV6M092Be7gTMuxDghcXxOl
   LEi/eu2KmGl7lxEf2kIlMGy4A8lgCCKXYC2vgoIF99RPgmSdlYzpfyhVh
   6dDlF1HV4McPE7/jWQqcLHJy+nvOemivk4hqxdwPBKbGjpsrqYWwiB/SS
   Fg9O8XkdJzn/eduBhjgPhZG3IqhEybY1mEMmVxQNJb4JGYYL9L7RciJJm
   OKXfjK053lIh1/TDzO66CRscUDNGYRGvRNZ1NgmY04IIJBQNIlqU1uXbE
   vAlGjk20WmOzcb5ZF/ZJQ33z1bhYaQ8+PgEs8kARmEh+ePT+ZFsyLBzHO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="355256229"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="355256229"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="955374807"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="955374807"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:47:36 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rafael@kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 2/4] intel_idle: clean up the (new) state_update_enter_method function
Date:   Mon,  5 Jun 2023 15:47:14 +0000
Message-Id: <20230605154716.840930-3-arjan@linux.intel.com>
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

