Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E318525AF0
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 07:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377045AbiEMFAf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 01:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377054AbiEMFAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 01:00:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC8128492B
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 22:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652418032; x=1683954032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aBF7f3OrHKvSil357X/McjEkCTA9M6QmJM7ESNEPKIs=;
  b=NUxSX3KzxGS9iZfSEcFgyaaAjtYW7P471C/K36BTfC+TMDCaEoah47Ei
   4Rox4Erv2wqzNnl++518zxS7/9/L2gWmx1e9KY8ajmVP+EaxG1jMm4E5W
   UZHLryDmv8FU0WFhRYLiBKVRSRNFv3LFJljQIoWrSdvZ83NdD0sVMYvcO
   I0VHeOcHh4FEZlbvX89Y+0/6ci0OKDjhtRgoV39C8y3KKfVt6NGVitYqL
   XLend42p9ogr7otsVZ3nE0Ba5glRwn43cNHUXS8y3VsgNdb1SjlZxKvmn
   04Ncr5nEz1qYdruCxYjik1oNICaxabiNLrF4QLGU0AhPHNPv2JambfzMM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="295475161"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="295475161"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 22:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="712253786"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2022 22:00:31 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] powercap: intel_rapl: add support for ALDERLAKE_N
Date:   Fri, 13 May 2022 13:00:40 +0800
Message-Id: <20220513050040.3387524-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add intel_rapl support for the ALDERLAKE_N platform.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 83da499dd6ec..e45c1c3b0cae 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1107,6 +1107,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
-- 
2.17.1

