Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E1A4C9F00
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 09:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiCBIQu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Mar 2022 03:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbiCBIQt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 03:16:49 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEA1B7C44
        for <linux-pm@vger.kernel.org>; Wed,  2 Mar 2022 00:16:06 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="314058971"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="314058971"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 00:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="510913512"
Received: from powerlab.fi.intel.com (HELO powerlab..) ([10.237.71.25])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 00:16:04 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        chang.seok.bae@intel.com
Subject: [PATCH v1 3/3] intel_idle: add core C6 optimization for SPR
Date:   Wed,  2 Mar 2022 10:16:00 +0200
Message-Id: <20220302081600.1751716-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220302081600.1751716-1-dedekind1@gmail.com>
References: <20220302081600.1751716-1-dedekind1@gmail.com>
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

Add a Sapphire Rapids Xeon C6 optimization, similar to what we have for Sky Lake
Xeon: if package C6 is disabled, adjust C6 exit latency and target residency to
match core C6 values, instead of using the default package C6 values.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b2688c326522..e385ddf15b32 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1578,6 +1578,8 @@ static void __init skx_idle_state_table_update(void)
  */
 static void __init spr_idle_state_table_update(void)
 {
+	unsigned long long msr;
+
 	/* Check if user prefers C1E over C1. */
 	if (preferred_states_mask & BIT(2)) {
 		if (preferred_states_mask & BIT(1))
@@ -1591,6 +1593,19 @@ static void __init spr_idle_state_table_update(void)
 		c1e_promotion_enable();
 		disable_promotion_to_c1e = false;
 	}
+
+	/*
+	 * By default, the C6 state assumes the worst-case scenario of package
+	 * C6. However, if PC6 is disabled, we update the numbers to match
+	 * core C6.
+	 */
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
+
+	/* Limit value 2 and above allow for PC6. */
+	if ((msr & 0x7) < 2) {
+		spr_cstates[2].exit_latency = 190;
+		spr_cstates[2].target_residency = 600;
+	}
 }
 
 static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
-- 
2.31.1

