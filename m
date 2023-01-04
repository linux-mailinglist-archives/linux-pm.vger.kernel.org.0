Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61965D555
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jan 2023 15:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjADORW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Jan 2023 09:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbjADORA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2023 09:17:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D4217424
        for <linux-pm@vger.kernel.org>; Wed,  4 Jan 2023 06:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672841819; x=1704377819;
  h=from:to:cc:subject:date:message-id;
  bh=K2Xq4JISotYBFghaTBAdgS1F9YIJdw76QRERW/X0HNM=;
  b=Y+JbrCWnxYEPHFsGp/eLt8y4xcuFATnf6WDuDN4hY7Y81YELo/8nH1xI
   P92jy99IpISeBsKpTVuZnE8zuIs1MeTyp+4GblSqkWAKWAa7Kf0UKXDRz
   NjdPGd2Le++BkmwOQdBgUBiHSG930Grnl66JlNKDF+4X+MhwcD+7HrdwP
   DerblR1A/RDQ8AsbmNiH68uDsUpWc4ntdr+r5xL2+8mJLGhssC8I9x9sZ
   Wst+QyvkVgl63HOuHurknX2AVujt4nMdWrsGm8wfOI7ghZH5sX+KrtX/B
   f2/8fNEzeb2NT+Mu3MSGNaqFGzkNrBM5gFd0wYe8bACnuf8UmdUXDbx+b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349163459"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="349163459"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 06:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="723658185"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="723658185"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2023 06:16:58 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        len.brown@intel.com
Cc:     artem.bityutskiy@linux.intel.com
Subject: [PATCH] tools/power turbostat: Introduce support for EMR
Date:   Wed,  4 Jan 2023 22:23:53 +0800
Message-Id: <20230104142353.22871-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce support for EMR.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index aba460410dbd..5073e5cdfec5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5463,6 +5463,9 @@ unsigned int intel_model_duplicates(unsigned int model)
 
 	case INTEL_FAM6_ICELAKE_D:
 		return INTEL_FAM6_ICELAKE_X;
+
+	case INTEL_FAM6_EMERALDRAPIDS_X:
+		return INTEL_FAM6_SAPPHIRERAPIDS_X;
 	}
 	return model;
 }
-- 
2.25.1

