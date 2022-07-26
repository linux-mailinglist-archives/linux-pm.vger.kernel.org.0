Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5EF581666
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiGZP3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiGZP3n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 11:29:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29452183F
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 08:29:42 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="349683833"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="349683833"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 08:29:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="658735574"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2022 08:29:40 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>, Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 3/4] turbostat: fix SPR PC6 limits
Date:   Tue, 26 Jul 2022 18:29:34 +0300
Message-Id: <20220726152935.3183492-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726152935.3183492-1-dedekind1@gmail.com>
References: <20220726152935.3183492-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Sapphire Rapids Xeon (SPR) supports 2 flavors of PC6 - PC6N (non-retention) and
PC6R (retention). Before this patch we used ICX package C-state limits, which
was wrong, because ICX has only one PC6 flavor. With this patch, we use SKX PC6
limits for SPR, because they are the same.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c2f1fa5d59e0..e089b8b41b12 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3743,11 +3743,11 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		has_misc_feature_control = 1;
 		break;
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:	/* SPR */
 		pkg_cstate_limits = skx_pkg_cstate_limits;
 		has_misc_feature_control = 1;
 		break;
 	case INTEL_FAM6_ICELAKE_X:	/* ICX */
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:	/* SPR */
 		pkg_cstate_limits = icx_pkg_cstate_limits;
 		has_misc_feature_control = 1;
 		break;
-- 
2.35.1

