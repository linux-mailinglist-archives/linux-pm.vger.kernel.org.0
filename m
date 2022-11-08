Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251B9620AF4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 09:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiKHIKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Nov 2022 03:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiKHIKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2022 03:10:10 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80AA19C12
        for <linux-pm@vger.kernel.org>; Tue,  8 Nov 2022 00:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667895009; x=1699431009;
  h=from:to:cc:subject:date:message-id;
  bh=JP+wuSUmMKieQ+H4jMdtw/4GiZgYQVaSNROl9AV5UtQ=;
  b=cAyuFGKXVFB+5Zau04HqmhmDBo/rnTxxJQjS2cOFZJN5KJd3Dsi1EBOa
   cQbaB85rtcYjqBcmrsKq64fqYO94PouqvFa/vRWeyGa1Fwu8BWopVJedH
   hAftp//e7TszV59ibiCnYsuJfu9qrAkwAdpfNS2cOI4qE8sbgyotCYsoY
   yJnAVLs/sAT+j3A9Lx5kV/Jqwjm75erWdQCvEbt10E7dxNS/nq35CdrVf
   aGBjj9BhULpnVTpktNIGJrUkGgt0c0U36KJwiGpfgqf24ibLgq6fw+kL8
   0OiaTayYbJK4ZWWIiGOAqkwFtycnr8ELa00a4z4/Lpfetod4VpES+E+GA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372778654"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="372778654"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 00:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="725475870"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="725475870"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2022 00:10:06 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH 1/2] thermal/intel/intel_tcc_cooling: Detect TCC lock bit
Date:   Tue,  8 Nov 2022 16:12:19 +0800
Message-Id: <20221108081220.7070-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When MSR_IA32_TEMPERATURE_TARGET is locked, TCC Offset can not be
updated even if the PROGRAMMABE Bit is set.

Yield the driver on platforms with MSR_IA32_TEMPERATURE_TARGET locked.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
Note that this patch is made based on this patch series
https://patchwork.kernel.org/project/linux-pm/list/?series=693050
---
 drivers/thermal/intel/intel_tcc_cooling.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index ccd62358d4d0..f17fa5c81034 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -13,6 +13,7 @@
 #include <asm/cpu_device_id.h>
 
 #define TCC_PROGRAMMABLE	BIT(30)
+#define TCC_LOCKED		BIT(31)
 
 static struct thermal_cooling_device *tcc_cdev;
 
@@ -80,6 +81,15 @@ static int __init tcc_cooling_init(void)
 	if (!(val & TCC_PROGRAMMABLE))
 		return -ENODEV;
 
+	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
+	if (err)
+		return err;
+
+	if (val & TCC_LOCKED) {
+		pr_info("TCC Offset locked\n");
+		return -ENODEV;
+	}
+
 	pr_info("Programmable TCC Offset detected\n");
 
 	tcc_cdev =
-- 
2.25.1

