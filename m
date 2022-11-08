Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F1162076B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 04:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiKHDbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 22:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKHDb1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 22:31:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0B2F39E
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 19:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667878286; x=1699414286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Eczi2fmvA4uOiYb+3UFSugNRt+4J2cDiLmkt92MiNt4=;
  b=bget73ANP8gYTTuVRIJTuVyYyAsOUppIJ6j4k34Owtx91MU+iUwydah/
   ll3NTe0okBXt6XU75ZBKNG8WjFZoppvClPjGZibMRl/B0bMFgUgytIXZa
   VTyQX6iF/GGSHlBFdtFF4GPOx6N/mrZatqJVW+QTh6dEzaxXrCmKKxqgK
   tenZkskzV3Py2iPKreTWFVqsq8Ff6T6nKNx7sYXD0yqseKYYXQeCQuoCw
   KnJO3GIC5M5IuFCVLnvanEIahz2J3nQKKKgpbg0QDliieHRXNv+gP85aG
   tgwaThoD8wme8thPItmQ5e8Nf9aycA/Bt+DapjZ4TNz+tCtTLcEUZloGP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372732539"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="372732539"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:31:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614120243"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="614120243"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 19:31:24 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH 4/6] thermal/intel/intel_tcc_cooling: Use Intel TCC library
Date:   Tue,  8 Nov 2022 11:33:30 +0800
Message-Id: <20221108033332.27760-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221108033332.27760-1-rui.zhang@intel.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/thermal/intel/intel_tcc_cooling.c | 37 +++--------------------
 2 files changed, 6 insertions(+), 32 deletions(-)

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
index 95adac427b6f..8819afb7f23c 100644
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
@@ -20,47 +19,20 @@ static struct thermal_cooling_device *tcc_cdev;
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
-
-	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
-	if (err)
-		return err;
-
-	*state = (val & TCC_MASK) >> TCC_SHIFT;
-	return 0;
+	return intel_tcc_get_offset(cpumask_any(cpu_online_mask), (int *)state);
 }
 
 static int tcc_set_cur_state(struct thermal_cooling_device *cdev, unsigned long
 			     state)
 {
-	return tcc_offset_update(state);
+	return intel_tcc_set_offset(cpumask_any(cpu_online_mask), (int)state);
 }
 
 static const struct thermal_cooling_device_ops tcc_cooling_ops = {
@@ -129,6 +101,7 @@ static void __exit tcc_cooling_exit(void)
 
 module_exit(tcc_cooling_exit)
 
+MODULE_IMPORT_NS(INTEL_TCC);
 MODULE_DESCRIPTION("TCC offset cooling device Driver");
 MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

