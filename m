Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4594867507A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jan 2023 10:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjATJQY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Jan 2023 04:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjATJQY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2023 04:16:24 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845D917C9
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 01:16:03 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387904643"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="387904643"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 01:15:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638098282"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="638098282"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 01:15:29 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] intel_idle: add Emerald Rapids Xeon support
Date:   Fri, 20 Jan 2023 11:15:28 +0200
Message-Id: <20230120091528.142625-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
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

Emerald Rapids (EMR) is the next Intel Xeon processor after Sapphire Rapids
(SPR). EMR C-states are the same as SPR C-states, and we expect that EMR
C-state characteristics (latency and target residency) will be the same as in
SPR. Therefore, this patch adds EMR support by using SPR C-states table.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cfeb24d40d37..bb3d10099ba4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1430,6 +1430,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&idle_cpu_adl_l),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&idle_cpu_adl_n),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
@@ -1862,6 +1863,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		skx_idle_state_table_update();
 		break;
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+	case INTEL_FAM6_EMERALDRAPIDS_X:
 		spr_idle_state_table_update();
 		break;
 	case INTEL_FAM6_ALDERLAKE:
-- 
2.38.1

