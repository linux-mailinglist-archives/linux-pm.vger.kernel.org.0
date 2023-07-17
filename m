Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5437567AA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jul 2023 17:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGQPUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jul 2023 11:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjGQPUO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2023 11:20:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9C010C8
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2023 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689607183; x=1721143183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bUOTX5dw2G75UiT+4rr7b+HzDjYK2xl9bzYO8LnFtu0=;
  b=KbY/BcbEBRDnH12wVFrDdE2lQYYzydTnmMxcXRgrczc9kIaa9u6H/SXK
   K/dwHiuQH5gSok45BkSwFS5HTfVWYDyF/tnMQeA4gn85GsNBJl1CGl4hU
   QQc63eaGokzYTgMySqkd0ptK7iinz8Zj9g6A5ezGP+KmrIv+aOlOraXZa
   BM//XZ5fVgZVbO0bFA6iS6ZrA0Z87DPJ0veCK+dPnqNGMlyj/dnvGZLFt
   sskr2F74xGRL6srcYf4csqX+M5y3sP20GpGGXSLwnbmKUgYE6EA5J1vad
   zvsuvPJvd77YKwumFBMF8NFWlS9rqCpe6h8sNyoy3hGneB3L2KiEA4r1/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429716552"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429716552"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:19:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726581596"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726581596"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:19:12 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 4/4] intel_idle: remove intel_idle_hlt_irq_on
Date:   Mon, 17 Jul 2023 15:18:56 +0000
Message-ID: <20230717151856.2529029-4-arjan@linux.intel.com>
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

PeterZ pointed out that the whole function is redundant as for hlt, it's always "irq on"

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 4dd8081d2406..038322c23e34 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -224,17 +224,6 @@ static __cpuidle int intel_idle_hlt(struct cpuidle_device *dev,
 	return __intel_idle_hlt(dev, drv, index);
 }
 
-static __cpuidle int intel_idle_hlt_irq_on(struct cpuidle_device *dev,
-                                   struct cpuidle_driver *drv, int index)
-{
-       int ret;
-
-       raw_local_irq_enable();
-       ret = __intel_idle_hlt(dev, drv, index);
-       raw_local_irq_disable();
-
-       return ret;
-}
 
 /**
  * intel_idle_s2idle - Ask the processor to enter the given idle state.
@@ -1897,15 +1886,8 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 
 static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 {
-	if (state->enter == intel_idle_hlt) {
-		if (force_irq_on) {
-			pr_info("forced intel_idle_irq for state %d\n", cstate);
-			state->enter = intel_idle_hlt_irq_on;
-		}
+	if (state->enter == intel_idle_hlt)
 		return;
-	}
-	if (state->enter == intel_idle_hlt_irq_on)
-		return; /* no update scenarios */
 
 	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
 		/*
@@ -1949,8 +1931,6 @@ static bool should_verify_mwait(struct cpuidle_state *state)
 {
 	if (state->enter == intel_idle_hlt)
 		return false;
-	if (state->enter == intel_idle_hlt_irq_on)
-		return false;
 
 	return true;
 }
-- 
2.41.0

