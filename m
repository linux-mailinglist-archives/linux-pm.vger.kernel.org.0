Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A7509765
	for <lists+linux-pm@lfdr.de>; Thu, 21 Apr 2022 08:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiDUG0R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Apr 2022 02:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDUG0Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2022 02:26:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E75213EB8
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2022 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650522208; x=1682058208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SjP2GGOzVYsZWeiA6X2lNTMg+72b6cKrC69Ybl3tLLI=;
  b=JAk1YQboPHvFDcDC6KhAjtqNN0JrpnvTZJH+/8XsJElnROD6G9gslLZS
   RA2kcA23blokKNvOCWS+ftmLorhjjCShZV/wBKVkRevaJQO1lbctSj8qA
   ny9HxSalIwbgpZgfKQ2xKuVQxwAbY2L2p1oon9KyJwfx0HIhlBJ94cKSr
   ZYWADKTFg3r+3RBYFUBA2nFQfOH/UUvldnx5d0iumYDezaHzkXyoLvbnw
   DQruM6d4DOvbLWI3RU0yb2N0/GN6dMbe7DMrCjicddjkByXRW71uPFzkN
   IXi4hI6Vp9Q4XW0h7rp9plHRBfCa/lS3ZZ9kNt41ulmCfLt10AgeEK9C/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324696123"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="324696123"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:23:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="510912801"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2022 23:23:26 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     len.brown@intel.com, rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] tools/power turbostat: introduce support for RaptorLake
Date:   Thu, 21 Apr 2022 22:19:08 +0800
Message-Id: <20220421141908.94341-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RaptorLake behaves similarly to AlderLake.
Add support for RaptorLake processor.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bc5ae0872fed..8fe2cd9b6759 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5209,6 +5209,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_LAKEFIELD:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE:
 		return INTEL_FAM6_CANNONLAKE_L;
 
 	case INTEL_FAM6_ATOM_TREMONT_L:
-- 
2.17.1

