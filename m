Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEFF4D1653
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbiCHLeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 06:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiCHLeT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 06:34:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFB33BA47
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 03:33:23 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317891711"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="317891711"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:33:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="780681409"
Received: from powerlab.fi.intel.com (HELO powerlab..) ([10.237.71.25])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2022 03:33:21 -0800
From:   me_gmail@vger.kernel.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Yu Chen <yu.c.chen@intel.com>,
        Kin Cho <kin.cho@oracle.com>
Subject: [PATCH] turbostat: fix PC6 displaying on some systems
Date:   Tue,  8 Mar 2022 13:33:20 +0200
Message-Id: <20220308113320.3869035-1-me_gmail>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,INVALID_MSGID,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

