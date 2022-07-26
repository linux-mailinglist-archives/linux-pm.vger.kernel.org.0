Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F92581665
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 17:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiGZP3o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbiGZP3n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 11:29:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B3220F4
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 08:29:42 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="349683829"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="349683829"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 08:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="658735563"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2022 08:29:38 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>, Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 2/4] turbostat: cleanup 'automatic_cstate_conversion_probe()'
Date:   Tue, 26 Jul 2022 18:29:33 +0300
Message-Id: <20220726152935.3183492-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726152935.3183492-1-dedekind1@gmail.com>
References: <20220726152935.3183492-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The 'automatic_cstate_conversion_probe()' function has a too long 'if'
statement, convert it to a 'switch' statement in order to improve code
readability a bit.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f9acb2af5bd8..c2f1fa5d59e0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4761,8 +4761,16 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 
 void automatic_cstate_conversion_probe(unsigned int family, unsigned int model)
 {
-	if (is_skx(family, model) || is_bdx(family, model) || is_icx(family, model) || is_spr(family, model))
+	if (family != 6)
+		return;
+
+	switch (model) {
+	case INTEL_FAM6_BROADWELL_X:
+	case INTEL_FAM6_SKYLAKE_X:
+	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 		has_automatic_cstate_conversion = 1;
+	}
 }
 
 void prewake_cstate_probe(unsigned int family, unsigned int model)
-- 
2.35.1

