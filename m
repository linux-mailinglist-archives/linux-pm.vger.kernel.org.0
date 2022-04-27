Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9335110E4
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 08:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiD0GMK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 02:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiD0GMJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 02:12:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC8966FB9
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 23:08:59 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245749371"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="245749371"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="807873523"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2022 23:08:58 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Jan Beulich <jbeulich@suse.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 2/2] intel_idle: fix SPR C6 optimization
Date:   Wed, 27 Apr 2022 09:08:53 +0300
Message-Id: <20220427060853.3975453-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427060853.3975453-1-dedekind1@gmail.com>
References: <20220427060853.3975453-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch is a fix for the following 5.18-rc1 commit:
	commit 3a9cf77b60dc intel_idle: add core C6 optimization for SPR

The Sapphire Rapids (SPR) C6 optimization was added to the end of the
'spr_idle_state_table_update()' function. However, the function has a
'return' which may happen before the optimization has a chance to run.
And this may prevent the optimization from happening.

This is an unlikely scenario, but possible if user boots with, say,
the 'intel_idle.preferred_cstates=6' kernel boot option.

This patch fixes the issue by eliminating the 'return'.

Suggested-by: Jan Beulich <jbeulich@suse.com>
Reported-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cf5ed4c1d02c..ae8649a809ea 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1581,11 +1581,9 @@ static void __init spr_idle_state_table_update(void)
 	unsigned long long msr;
 
 	/* Check if user prefers C1E over C1. */
-	if (preferred_states_mask & BIT(2)) {
-		if (preferred_states_mask & BIT(1))
-			/* Both can't be enabled, stick to the defaults. */
-			return;
-
+	if ((preferred_states_mask & BIT(2)) &&
+	    !(preferred_states_mask & BIT(1))) {
+		/* Disable C1 and enable C1E. */
 		spr_cstates[0].flags |= CPUIDLE_FLAG_UNUSABLE;
 		spr_cstates[1].flags &= ~CPUIDLE_FLAG_UNUSABLE;
 
-- 
2.35.1

