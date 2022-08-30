Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC65A599C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 04:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiH3C6F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Aug 2022 22:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiH3C6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2022 22:58:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4271A00C0
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 19:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661828283; x=1693364283;
  h=from:to:cc:subject:date:message-id;
  bh=Vwhy5iieYnwCp2qh2blmu/8SLalBLQLd1wS8zv2nnO0=;
  b=kAfpXbM7vgXRVMbENED4GbKyWvCM9vyWViKrqbCCaNPQhg6cRmoll4K1
   itg12EH08FcqT6axTTp56sTHiCEexdpsbD647Wib4KbLMtuZ8xCQk7ocO
   rPsQHNB995vPPUc0GI929JiRg/Fd+1JKeZNj3wfvH4AYrUGIbEFS1NWcf
   yUmeb9n4o9baB/W9aLrxIxSZmOtYoiA+/ltBI3Z9zoAdGeLp/lY1hiQ2d
   lOk47Qt4JeTl5OgS9389HvBwyaB1Yd+1fN6ZCJlei1zcggPOJl9p5wfrh
   tzSEI/4pXM5krLJx7j+iBHQPkN7DaNqWFjPZCZ0A/U65N9aLCe3QlCNA4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295843630"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="295843630"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 19:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="588413821"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2022 19:58:01 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com
Subject: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_S
Date:   Tue, 30 Aug 2022 11:01:34 +0800
Message-Id: <20220830030134.8111-1-rui.zhang@intel.com>
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

Add intel_rapl support for RAPTORLAKE_S platform, which behaves the same
as RAPTORLAKE and RAPTORLAKE_P platforms.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 21d624f9f5fb..6812c1ca3100 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1110,6 +1110,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
 
-- 
2.25.1

