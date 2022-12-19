Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B018D650EC2
	for <lists+linux-pm@lfdr.de>; Mon, 19 Dec 2022 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiLSPjU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 10:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiLSPjR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 10:39:17 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228BA11807
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671464357; x=1703000357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=cP0pwvMyQvIEbCrwUdFXadweBwuCrJ7kDmYMN+bfngU=;
  b=RuZnQxJXvoXFAS5LA0+4MMhUf0N3j5YjavHl/7hsz0okCFXaB2pLbC+o
   BH64btiyMiv9puyy8BXxhx7qgPV2YL8HMcS/JOVwNkH0XWuDO4CO9/yzh
   kmDHpEg9HcQtmxRY3M8nlUowrCg+0CevsdqiVh5yCqfbQVYWNbd6QM0A7
   Ph3jT9jimQK+8KkFD65l0Bw6mBmTDWSDKRmF4EsGSFrRo4V1Rf0dK7vZW
   6TPHICcdIXSLBCH+UEsoYC0TcUSWRLmn8gq9RwSplThGM27l6wdiVMH6f
   78lMpsqAa3uNb2cOQuyetsMTZMPI4wLkWsDPegCTB4xzMf02YaJTaqjtd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="307051247"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="307051247"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 07:39:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="774960338"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="774960338"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2022 07:39:15 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 4/6] thermal/intel/intel_tcc_cooling: Use Intel TCC library
Date:   Mon, 19 Dec 2022 23:46:18 +0800
Message-Id: <20221219154620.3630-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219154620.3630-1-rui.zhang@intel.com>
References: <20221219154620.3630-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Cleanup the code by using Intel TCC library for TCC (Thermal Control
Circuitry) MSR access.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/Kconfig             |  1 +
 drivers/thermal/intel/intel_tcc_cooling.c | 37 +++++------------------
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index 329c0ee934c4..dafdb3dd3fc7 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -88,6 +88,7 @@ config INTEL_PCH_THERMAL
 config INTEL_TCC_COOLING
 	tristate "Intel TCC offset cooling Driver"
 	depends on X86
+	select INTEL_TCC
 	help
 	  Enable this to support system cooling by adjusting the effective TCC
 	  activation temperature via the TCC Offset register, which is widely
diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 95adac427b6f..c5b559a123fd 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -7,12 +7,11 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/device.h>
+#include <linux/intel_tcc.h>
 #include <linux/module.h>
 #include <linux/thermal.h>
 #include <asm/cpu_device_id.h>
 
-#define TCC_SHIFT 24
-#define TCC_MASK	(0x3fULL<<24)
 #define TCC_PROGRAMMABLE	BIT(30)
 
 static struct thermal_cooling_device *tcc_cdev;
@@ -20,47 +19,26 @@ static struct thermal_cooling_device *tcc_cdev;
 static int tcc_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 			     *state)
 {
-	*state = TCC_MASK >> TCC_SHIFT;
-	return 0;
-}
-
-static int tcc_offset_update(int tcc)
-{
-	u64 val;
-	int err;
-
-	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
-	if (err)
-		return err;
-
-	val &= ~TCC_MASK;
-	val |= tcc << TCC_SHIFT;
-
-	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
-	if (err)
-		return err;
-
+	*state = 0x3f;
 	return 0;
 }
 
 static int tcc_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
 			     *state)
 {
-	u64 val;
-	int err;
+	int offset = intel_tcc_get_offset(-1);
 
-	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
-	if (err)
-		return err;
+	if (offset < 0)
+		return offset;
 
-	*state = (val & TCC_MASK) >> TCC_SHIFT;
+	*state = offset;
 	return 0;
 }
 
 static int tcc_set_cur_state(struct thermal_cooling_device *cdev, unsigned long
 			     state)
 {
-	return tcc_offset_update(state);
+	return intel_tcc_set_offset(-1, (int)state);
 }
 
 static const struct thermal_cooling_device_ops tcc_cooling_ops = {
@@ -129,6 +107,7 @@ static void __exit tcc_cooling_exit(void)
 
 module_exit(tcc_cooling_exit)
 
+MODULE_IMPORT_NS(INTEL_TCC);
 MODULE_DESCRIPTION("TCC offset cooling device Driver");
 MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

