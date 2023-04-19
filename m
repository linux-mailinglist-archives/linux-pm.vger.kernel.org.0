Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6E6E7D09
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjDSOke (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjDSOkW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 10:40:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDD659D7
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 07:40:15 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325079374"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325079374"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 07:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021232730"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="1021232730"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005.fm.intel.com with ESMTP; 19 Apr 2023 07:39:55 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 5/7] intel_idle: fix confusing message
Date:   Wed, 19 Apr 2023 17:39:45 +0300
Message-Id: <20230419143947.1342730-6-dedekind1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230419143947.1342730-1-dedekind1@gmail.com>
References: <20230419143947.1342730-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

By default, all non-POLL C-states are entered with interrupts disable.
There are 2 ways to make 'intel_idle' enter C-states with interrupts
enabled:
  1. Mark the C-state with the 'CPUIDLE_FLAG_IRQ_ENABLE' flag.
  2. Use the 'force_irq_on' module parameter.

The former is the "proper" way of doing it, it is per-C-state and
per-platform. The latter is for debugging purposes only.

The problem is that 'intel_idle' prints the "forced intel_idle_irq"
message in both cases, even though the former case does not needed
this message, because nothing is forced there. This patch addresses the
problem.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 1de36df15d5a..bff0d17aeda4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1912,8 +1912,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 			 */
 			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
 			state->enter = intel_idle_ibrs;
-		} else if ((state->flags & CPUIDLE_FLAG_IRQ_ENABLE) ||
-			   force_irq_on) {
+		} else if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE) {
+			state->enter = intel_idle_irq;
+		} else if (force_irq_on) {
 			pr_info("forced intel_idle_irq for state %d\n", cstate);
 			state->enter = intel_idle_irq;
 		}
-- 
2.38.1

