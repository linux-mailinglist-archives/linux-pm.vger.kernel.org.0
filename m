Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651D967B31B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 14:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjAYNSR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 08:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAYNSQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 08:18:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221691DB9C
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 05:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674652696; x=1706188696;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DNYQEQpTMGMtXKDrsgZ/kk/rL3o0A0sAEwFwpTEkRVg=;
  b=VZ6vH7qGTkeis7zh0PqkYEmEwzxUvqTXi5hwctWI5IYFNu2t6OVoffpP
   cQPFHqYAAxz5Ny6lSAJ0ejbeMRBiJdpoP1q9OYAT7DlkeT0ThKSJYNEgG
   SZigxHO8J12ZzCoCMGcD9ufAG+D82TxQEbBq6hU5K6Nvzmd21ZrltoFYq
   F3884j9AnofPNQz4CAD3B8PIDlbrJtqQatJnJF8zCNyvQc7BwTmNWpHzk
   ojf/2Qmw7hJIu4+uB+Y4hoDTAAShVXyLiqYr0v0OYuSalZ+zKYt30Lbz9
   UldZxuJiRmIz7QMo3EFzMl17oS7uok3Pu965cCdCHhy+SpZjuQvrSmIXd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="324252148"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="324252148"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 05:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="662499176"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="662499176"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2023 05:18:14 -0800
From:   antti.laakso@linux.intel.com
To:     linux-pm@vger.kernel.org, lenb@kernel.org
Subject: [PATCH] tools/power turbostat: fix decoding of HWP_STATUS
Date:   Wed, 25 Jan 2023 15:17:50 +0200
Message-Id: <20230125131750.1279959-1-antti.laakso@linux.intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Antti Laakso <antti.laakso@intel.com>

The "excursion to minimum" information is in bit2
in HWP_STATUS MSR. Fix the bitmask used for
decoding the register.

Signed-off-by: Antti Laakso <antti.laakso@intel.com>
Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index aba460410dbd..3d576a7e877b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4426,7 +4426,7 @@ int print_hwp(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	fprintf(outf, "cpu%d: MSR_HWP_STATUS: 0x%08llx "
 		"(%sGuaranteed_Perf_Change, %sExcursion_Min)\n",
-		cpu, msr, ((msr) & 0x1) ? "" : "No-", ((msr) & 0x2) ? "" : "No-");
+		cpu, msr, ((msr) & 0x1) ? "" : "No-", ((msr) & 0x4) ? "" : "No-");
 
 	return 0;
 }
-- 
2.38.1

