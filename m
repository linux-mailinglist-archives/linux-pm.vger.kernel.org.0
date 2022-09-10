Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CD35B4671
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 15:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIJNM0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIJNMZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 09:12:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5F58509
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662815545; x=1694351545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=24n3hcGa+f1fm1sS02iKmdfDXYW1deAmkOa7viGUnxc=;
  b=Y8MoelHliyRc/fr9vHbXhO9Zuo8eJfivhcB7PihfiphmPqUqGEm0+0/y
   VleriRki/eizWauH8NjQFo1cnymKrCaRpzQKBri9SV/IbGV0CeGbkxqVS
   l4/HTLP1UgYMFWGCgkdmdHocivJBWFqKyYNFTb7YKDq3Vne6yLCNIa4i6
   6+mTI89MQu5ZpDFHZLNXINbR1JIGAE8dU+RyN011X6ae6LJ7SUlTOYOo/
   PrNWcdTDvVm1eUq7aZDQHtTwvHuW0cJxTuERfYprcRVPAF8VFfsRAOnZM
   sDZcKisOP9mEXIggt+xJNP+q6i/sAPuWM/E0tekl0s0wdMUJVdp2Gwx4D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="298440981"
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="298440981"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 06:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="677511852"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2022 06:12:23 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com
Subject: [PATCH 2/2] tools/power turbostat: Add support for MeteorLake platforms
Date:   Sat, 10 Sep 2022 21:15:42 +0800
Message-Id: <20220910131542.22708-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220910131542.22708-1-rui.zhang@intel.com>
References: <20220910131542.22708-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add turbostat support for MeteorLake platforms, which behave the same
as RaptorLake platforms.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---

Note:
This patch depends on commit 5515d21c6817
("x86/cpu: Add CPU model numbers for Meteor Lake") in the x86/urgent
branch of tip tree.

Note:
This patch is made on top of patch
"tools/power turbostat: add support for RPL-S" at
https://patchwork.kernel.org/project/linux-pm/patch/20220831064957.1773-1-rui.zhang@intel.com/
to avoid conflict.

---
 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index df040d87edd8..597cc2dbc456 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5448,6 +5448,8 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:
+	case INTEL_FAM6_METEORLAKE:
+	case INTEL_FAM6_METEORLAKE_L:
 		return INTEL_FAM6_CANNONLAKE_L;
 
 	case INTEL_FAM6_ATOM_TREMONT_L:
-- 
2.25.1

