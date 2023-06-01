Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9971F217
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 20:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjFASat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 14:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjFASan (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 14:30:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED1197
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685644242; x=1717180242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TV9+KotZgTt2wCEdDqxarJhA1EkexUK6f2+xSypUoxQ=;
  b=VcrMwIQCOhffYBvwC/Qhblc5czevZDF+rHuSVqPo0cIaOgLT4oec42SU
   t4zxGUFl9APz13lRvqDKIVq7lDp47N9TNrUAKB99sHG8VR4MBhv/wtGW7
   fLoleOciMNjC0i3Ra4Ya406VfD2rQ8npP+ZcQLI5+SAXaPiKWveU7CmGL
   MoIo6ct+hL8X8e+EVpqiaSz0gCScLusZhL7ym/nukt+p8rBSHZHoox8kc
   fcnjgRbEYVAulILGGLwsK48z98RcFkaBlSk0PcwEofjQ/CJPzCyEN9YdI
   ZbGGga0GS7z0cfxgNkKuY/86Nrm9IBPu4rnod1lgH9j8MOlMVsaqKZSa1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="383921632"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="383921632"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657900914"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657900914"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:19 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rafael@kernel.org,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 3/7] intel_idle: Add a sanity check in the new state_update_enter_method function
Date:   Thu,  1 Jun 2023 18:27:57 +0000
Message-Id: <20230601182801.2622044-4-arjan@linux.intel.com>
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

The state_update_enter_method function updates a state's enter function pointer,
but does so assuming that the current function is "intel_idle" or "intel_idle_irq".

In the code currently that's basically the case, but soon this will change.
Add a sanity check early in the function to make the assumption explicit,
and return early if the precondition is not met.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 256c2d42e350..8415965372c7 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1841,6 +1841,14 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 
 static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 {
+	/*
+	 * The updates below are only valid if state->enter is actually the
+	 * 'intel_idle' or 'intel_idle_irq' functions; for all other cases
+	 * we just bow out early.
+	 */
+	if (state->enter != intel_idle && state->enter != intel_idle_irq )
+		return;
+
 	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
 		/*
 		 * Combining with XSTATE with IBRS or IRQ_ENABLE flags
-- 
2.40.1

