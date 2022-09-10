Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD885B4673
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 15:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiIJNM0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIJNMZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 09:12:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F59858508
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662815544; x=1694351544;
  h=from:to:cc:subject:date:message-id;
  bh=kltSkXJe8/01dzPZs1i1NflFPzhJRR4s4qcTRstRxug=;
  b=m0hANpXEv88UlmtyIFdKYy2PLQUoQN2FJUhubtQc3hE5f9HKs6dWO8x9
   8sppcTd8QCIGS7WXIngtVhbD5qmr8KTSsu6MQpODCVUahvfQwH52QZTSD
   Rle5wVLV+OjG5SY5qcvKAxVBj3Ozry26vR/MIy76TW8d3CDcGCd+PGYX8
   OXGCe/jSwoCYpj3ebDul9HzgPLR8Z4UOA+72v66K6mCVIGdMhzVrCwSus
   5BnVUfuYd82qi51yCbddEYbIaO58UxuNXhi/+AG2BGXDQx0YHyg2C5Qgp
   pXi4fhkT1JgmA5nPI+bE5JDyCUFwOOIzd7MP2+iuX7TglHTgQwX66IGHg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="298440980"
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="298440980"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 06:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="677511843"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2022 06:12:22 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com
Subject: [PATCH 1/2] powercap: intel_rapl: Add support for MeteorLake platforms
Date:   Sat, 10 Sep 2022 21:15:41 +0800
Message-Id: <20220910131542.22708-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add intel_rapl support for the MeteorLake platforms, which behave the
same as RaptorLake platforms.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---

Note:
This patch depends on commit 5515d21c6817
("x86/cpu: Add CPU model numbers for Meteor Lake") in the x86/urgent
branch of tip tree.

Note:
This patch is made on top of commit 0d7a23b5f8e1
("powercap: intel_rapl: Add support for RAPTORLAKE_S") in the
linux-next branch of pm tree to avoid conflict.

---
 drivers/powercap/intel_rapl_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 6812c1ca3100..949eb90f5733 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1111,6 +1111,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
 
-- 
2.25.1

