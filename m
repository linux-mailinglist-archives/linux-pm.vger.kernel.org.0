Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC754D1665
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 12:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346440AbiCHLmA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 06:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343635AbiCHLl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 06:41:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EDC2BB08
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 03:41:03 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254603499"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254603499"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="687895182"
Received: from powerlab.fi.intel.com (HELO powerlab..) ([10.237.71.25])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2022 03:41:01 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Yu Chen <yu.c.chen@intel.com>,
        Kin Cho <kin.cho@oracle.com>
Subject: [PATCH resend] turbostat: fix PC6 displaying on some systems
Date:   Tue,  8 Mar 2022 13:41:01 +0200
Message-Id: <20220308114101.3872868-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

'MSR_PKG_CST_CONFIG_CONTROL' encodes the deepest allowed package C-state limit,
and turbostat decodes it.

Before this patch: turbostat does not recognize value "3" on Ice Lake Xeon
(ICX) and Sapphire Rapids Xeon (SPR), treats it as "unknown", and does not
display any package C-states in the results table.

After this patch: turbostat recognizes value 3 on ICX and SPR, treats it as
"PC6", and correctly displays package C-states in the results table.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Note 1: I apologize for submitting this patch several times. I clearly forgot
how to use 'git send-email' and missed the '--dry-run' option. Sorry for this.

Note 2: this patch is a rebased version of the same patch I sent earlier:
https://patchwork.kernel.org/project/linux-pm/patch/20211004105224.3145916-1-dedekind1@gmail.com/

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 47d3ba895d6d..bc5ae0872fed 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2323,7 +2323,7 @@ int skx_pkg_cstate_limits[16] =
 };
 
 int icx_pkg_cstate_limits[16] =
-    { PCL__0, PCL__2, PCL__6, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV,
+    { PCL__0, PCL__2, PCL__6, PCL__6, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV,
 	PCLRSV, PCLRSV
 };
 
-- 
2.31.1

