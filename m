Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA5F633594
	for <lists+linux-pm@lfdr.de>; Tue, 22 Nov 2022 08:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiKVHAU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Nov 2022 02:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKVHAT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2022 02:00:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B0623BF0;
        Mon, 21 Nov 2022 23:00:18 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315569508"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="315569508"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 23:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="635448177"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="635448177"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007.jf.intel.com with ESMTP; 21 Nov 2022 23:00:15 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH resend] platform/x86: intel-uncore-freq: add Emerald Rapids support
Date:   Tue, 22 Nov 2022 09:00:14 +0200
Message-Id: <20221122070014.3639277-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Make Intel uncore frequency driver support Emerald Rapids by adding its CPU
model to the match table. Emerald Rapids uncore frequency control is the same
as in Sapphire Rapids.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

Re-sending the same patch, but added X86 platform maintainers.

 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 8f9c571d7257..00ac7e381441 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -203,6 +203,7 @@ static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);
-- 
2.37.3

