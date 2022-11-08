Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D4B620AF5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 09:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKHIKQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Nov 2022 03:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKHIKL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2022 03:10:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CF11EAC7
        for <linux-pm@vger.kernel.org>; Tue,  8 Nov 2022 00:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667895010; x=1699431010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=q68VRlmxVz6ergIR4MTTNT5Xi1IMLxnKBOJewHK+hYQ=;
  b=IGpQRq6llm81eLNYWf3uEIAWCxcRcI4Qy28CO9MQL8gp56yN6kvcMBTV
   DDl6VaBRgSPgb4QSQZmhVhmGWjsr50q+CP89JBrskQAioj/wC+qF4SSoB
   vIOzd2C7W3zQrj1Oi4dySihxo2atfuTHExMO9JPDxv0ZFYf37x8/NovoK
   WMfKnPYkD4+ZG53ew2ff3Uy1xPSIdkLqb6THhtgFQvk6uBfpnxPIOVuSI
   JWYSedDJBXz3jk6qRJEyx4qKU0Zh2MtmgpVzeihDwDUVP4uDHdEuYMAnP
   u79ckgkR7TK/OC282f9xbu1obvBHhs1t7EhbRdpL2wLE9EAiNopQu/jKf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372778666"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="372778666"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 00:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="725475882"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="725475882"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2022 00:10:08 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH 2/2] thermal/intel_tcc_cooling: Add TCC cooling support for RaptorLake-S
Date:   Tue,  8 Nov 2022 16:12:20 +0800
Message-Id: <20221108081220.7070-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221108081220.7070-1-rui.zhang@intel.com>
References: <20221108081220.7070-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add RaptorLake to the list of processor models supported by the Intel
TCC cooling driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index f17fa5c81034..ec66d32ab24f 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -57,6 +57,7 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
 	{}
 };
 
-- 
2.25.1

