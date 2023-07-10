Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29A774D195
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGJJdu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGJJdV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 05:33:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390DB1A8
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 02:31:50 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="344624721"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="344624721"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="865281524"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865281524"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 02:31:07 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 3/4] intel_idle: rename 'intel_idle_hlt_irq_on()'
Date:   Mon, 10 Jul 2023 12:30:59 +0300
Message-Id: <20230710093100.918337-4-dedekind1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710093100.918337-1-dedekind1@gmail.com>
References: <20230710093100.918337-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Rename 'intel_idle_hlt_irq_on()' to 'intel_idle_hlt_irq()' for consistency with
'intel_idle_irq()'.

While on it, fix indentation in 'intel_idle_hlt_irq()' declaration to use tabs
instead of white-spaces.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b930036edbbe..0a835f97de72 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -224,8 +224,8 @@ static __cpuidle int intel_idle_hlt(struct cpuidle_device *dev,
 	return __intel_idle_hlt(dev, drv, index);
 }
 
-static __cpuidle int intel_idle_hlt_irq_on(struct cpuidle_device *dev,
-                                   struct cpuidle_driver *drv, int index)
+static __cpuidle int intel_idle_hlt_irq(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
 {
        int ret;
 
@@ -1900,11 +1900,11 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 	if (state->enter == intel_idle_hlt) {
 		if (force_irq_on) {
 			pr_info("forced intel_idle_irq for state %d\n", cstate);
-			state->enter = intel_idle_hlt_irq_on;
+			state->enter = intel_idle_hlt_irq;
 		}
 		return;
 	}
-	if (state->enter == intel_idle_hlt_irq_on)
+	if (state->enter == intel_idle_hlt_irq)
 		return; /* no update scenarios */
 
 	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
@@ -1949,7 +1949,7 @@ static bool should_verify_mwait(struct cpuidle_state *state)
 {
 	if (state->enter == intel_idle_hlt)
 		return false;
-	if (state->enter == intel_idle_hlt_irq_on)
+	if (state->enter == intel_idle_hlt_irq)
 		return false;
 
 	return true;
-- 
2.40.1

