Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7E8576C2E
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jul 2022 08:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiGPG1D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jul 2022 02:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiGPG1A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2022 02:27:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA4A1261B
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 23:26:57 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="284713178"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="284713178"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 23:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="593967595"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007.jf.intel.com with ESMTP; 15 Jul 2022 23:26:56 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH] intel_idle: make SPR C1 and C1E be independent
Date:   Sat, 16 Jul 2022 09:26:55 +0300
Message-Id: <20220716062655.704893-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch partially reverts the changes made by the following commit:

da0e58c038e6 intel_idle: add 'preferred_cstates' module argument

As that commit describes, on early Sapphire Rapids Xeon platforms the C1 and
C1E states were mutually exclusive, so that users could only have either C1 and
C6, or C1E and C6.

However, Intel firmware engineers managed to remove this limitation and make C1
and C1E to be completely independent, just like on previous Xeon platforms.

Therefore, this patch:
 * Removes commentary describing the old, and now non-existing SPR C1E
   limitation.
 * Marks SPR C1E as available by default.
 * Removes the 'preferred_cstates' parameter handling for SPR. Both C1 and
   C1E will be available regardless of 'preferred_cstates' value.

We expect that all SPR systems are shipping with new firmware, which includes
the C1/C1E improvement.

Cc: stable@vger.kernel.org # v5.18+
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 424ef470223d..ba2b485a03ed 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -879,16 +879,6 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.enter = NULL }
 };
 
-/*
- * On Sapphire Rapids Xeon C1 has to be disabled if C1E is enabled, and vice
- * versa. On SPR C1E is enabled only if "C1E promotion" bit is set in
- * MSR_IA32_POWER_CTL. But in this case there effectively no C1, because C1
- * requests are promoted to C1E. If the "C1E promotion" bit is cleared, then
- * both C1 and C1E requests end up with C1, so there is effectively no C1E.
- *
- * By default we enable C1 and disable C1E by marking it with
- * 'CPUIDLE_FLAG_UNUSABLE'.
- */
 static struct cpuidle_state spr_cstates[] __initdata = {
 	{
 		.name = "C1",
@@ -901,8 +891,7 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE |
-					   CPUIDLE_FLAG_UNUSABLE,
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 2,
 		.target_residency = 4,
 		.enter = &intel_idle,
@@ -1724,17 +1713,6 @@ static void __init spr_idle_state_table_update(void)
 {
 	unsigned long long msr;
 
-	/* Check if user prefers C1E over C1. */
-	if ((preferred_states_mask & BIT(2)) &&
-	    !(preferred_states_mask & BIT(1))) {
-		/* Disable C1 and enable C1E. */
-		spr_cstates[0].flags |= CPUIDLE_FLAG_UNUSABLE;
-		spr_cstates[1].flags &= ~CPUIDLE_FLAG_UNUSABLE;
-
-		/* Enable C1E using the "C1E promotion" bit. */
-		c1e_promotion = C1E_PROMOTION_ENABLE;
-	}
-
 	/*
 	 * By default, the C6 state assumes the worst-case scenario of package
 	 * C6. However, if PC6 is disabled, we update the numbers to match
-- 
2.35.1

