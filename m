Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75069420987
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhJDKyQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 06:54:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:28336 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhJDKyP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Oct 2021 06:54:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="225696305"
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="225696305"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 03:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="558359816"
Received: from powerlab.fi.intel.com (HELO powerlab..) ([10.237.71.25])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Oct 2021 03:52:25 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH] turbostat: fix PC6 displaying on some systems
Date:   Mon,  4 Oct 2021 13:52:24 +0300
Message-Id: <20211004105224.3145916-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

'MSR_PKG_CST_CONFIG_CONTROL' encodes the deepest allowed package C-state limit,
and turbostat decodes it.

Before this patch: turbostat does not recognize value "3" on Ice Lake Xeon
(ICX), treats it as "unknown", and does not display any package C-states in the
results table.

After this patch: turbostat recognizes value 3 on ICX, treats it as "PC6", and
correctly displays package C-states in the results table.

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

