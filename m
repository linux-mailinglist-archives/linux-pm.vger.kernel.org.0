Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E467C756794
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jul 2023 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjGQPUN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jul 2023 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjGQPTn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2023 11:19:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD850199F
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2023 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689607170; x=1721143170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V8q4dzA/0PGXASxpKzhr8IPLwXqNp2DK9Naa0xXzuPA=;
  b=elqhmp3OU5mJ+Ep5YhwDuEASaUoTskWkj4DRJLvMEfQVeueUZpRzlFF1
   AOQasAdJFlBTosY38ofiblqFxb3a5KAiqE7554jDb9SmUTeT1z9USaE3e
   GeEoZCOorOsmQyzJ2fE/xugp0+qfGiaKewRAjjLDAQyaji2zkw75doz1C
   qSZ66D7mznHy/agwesFwoKfqdBKfYPQAXxGqPPjUWR0gm5f5t3h4dvQv0
   8/7qhqNZMPnZAgGPmmFjcGURk3kaEB6nsQhL1ZJR6oNv1TWJGzsh/ybOb
   iayYBF5rZqKMY8wdIeaQivAw133cag14sTWAkEOohA78ruIL85Bsp5sYU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429716535"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429716535"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726581560"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726581560"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:19:07 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 1/4] intel_idle: refactor and split out model specific fixups into its own function
Date:   Mon, 17 Jul 2023 15:18:53 +0000
Message-ID: <20230717151856.2529029-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.41.0
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

As this list has been growing over time, lets split it into its own function.
That also makes it possible to move other hw workarounds into this function over time.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b930036edbbe..3bab6500697a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1955,10 +1955,8 @@ static bool should_verify_mwait(struct cpuidle_state *state)
 	return true;
 }
 
-static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
+static void __init model_specific_fixups(void)
 {
-	int cstate;
-
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_IVYBRIDGE_X:
 		ivt_idle_state_table_update();
@@ -1983,6 +1981,13 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		adl_idle_state_table_update();
 		break;
 	}
+}
+
+static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
+{
+	int cstate;
+
+	model_specific_fixups();
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
 		struct cpuidle_state *state;
-- 
2.41.0

