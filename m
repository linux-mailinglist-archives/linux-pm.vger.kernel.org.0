Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854C57567A9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jul 2023 17:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjGQPUg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jul 2023 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjGQPUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2023 11:20:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D2312D
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2023 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689607181; x=1721143181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ev0NLhqMBppSxPvvDd1BJ7d4+xX0IL28bOamUgRNnbc=;
  b=LbFoZwY2e3A+UOdFnzg5mvvQip75hHkJ8M6dXzhYSRQ9s/HFNJauqp5j
   OZxwYLKDI/XtXqPaPelGT2haoXJMYDTa8GZ1cD5RIm/QB0J00mj/PeKOJ
   LiDk5ydr9DBBM378+56/NdtFalbXLwf6Jp0d7YAC2tiY2/mjd5N6aJTLb
   bNgd1fptsNG2JnHJ1ek+Zer8Ijy/FL7jCtFG9IKvdyqYszPN2W2WQtGQb
   Pn/Zavu4HvaU/aTxIpqFeTDqdFFxww8X7VAtQHYFBXvmiRY+dG1UwEcHu
   BNSEW1pJZ2sZYhqTzbMbW8wWNXwxwvDfPEZLL7oITSKX52kivmnVrPnKx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429716542"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429716542"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726581585"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726581585"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:19:09 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 2/4] intel_idle: move one more model specific workaround into the newly created seperate function
Date:   Mon, 17 Jul 2023 15:18:54 +0000
Message-ID: <20230717151856.2529029-2-arjan@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717151856.2529029-1-arjan@linux.intel.com>
References: <20230717151856.2529029-1-arjan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

byt_auto_demotion_disable_flag (for baytrail) handling can now be moved into the newly created
model_specific_fixups() function.

This frees up intel_idle_init_cstates_icpu() from containing model specific information direclty

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3bab6500697a..f3eba9b147d2 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1981,6 +1981,11 @@ static void __init model_specific_fixups(void)
 		adl_idle_state_table_update();
 		break;
 	}
+
+	if (icpu->byt_auto_demotion_disable_flag) {
+		wrmsrl(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
+		wrmsrl(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
+	}
 }
 
 static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
@@ -2030,10 +2035,6 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		drv->state_count++;
 	}
 
-	if (icpu->byt_auto_demotion_disable_flag) {
-		wrmsrl(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
-		wrmsrl(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
-	}
 }
 
 /**
-- 
2.41.0

