Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550FE62076A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 04:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiKHDb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 22:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiKHDbZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 22:31:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CD62F390
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 19:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667878284; x=1699414284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PJPjXxroY8dyezTitqflYY0emBrgswcHTzkbYUqN99M=;
  b=IlxomwKzlrp+rw80kddEhi2e3/3xl5CWUI3DrECuXVN7WUdq9RTky0wJ
   EKkglt0IpShat8ML1wERXzFgVYl8pXPIb9A8qpyiuaEdMmm+ImJ43VyDt
   JvJdWPGlGOGszYQlYekcuVfx1PhCGiHCXDsshaK7ZenC6P4CkqQHmpHud
   3jPBF6Kiw8sv+cWiA5LvNqdgTk3fcdjCg1CtQgdp553yrw+MSUMvsOi60
   B68wk8Naiw4+FGPBKOEpDskaX34cBcCWNEYS/ya7ffSOqnz8mTr3gkh5Q
   igBrAIh+rkFgvsHht32sCv3Jr3AlrtmcrMjDxqqgEIF2fCLqXNKUtmS+g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372732531"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="372732531"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:31:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614120237"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="614120237"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 19:31:23 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH 3/6] thermal/intel/intel_soc_dts_iosf: Use Intel TCC library
Date:   Tue,  8 Nov 2022 11:33:29 +0800
Message-Id: <20221108033332.27760-4-rui.zhang@intel.com>
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
 drivers/thermal/intel/Kconfig              |  1 +
 drivers/thermal/intel/intel_soc_dts_iosf.c | 33 ++++------------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index 6b938c040d6e..329c0ee934c4 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -32,6 +32,7 @@ config INTEL_SOC_DTS_IOSF_CORE
 	tristate
 	depends on X86 && PCI
 	select IOSF_MBI
+	select INTEL_TCC
 	help
 	  This is becoming a common feature for Intel SoCs to expose the additional
 	  digital temperature sensors (DTSs) using side band interface (IOSF). This
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index 342b0bb5a56d..87fc45b8f8c6 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitops.h>
+#include <linux/intel_tcc.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
@@ -45,32 +46,6 @@
 /* DTS0 and DTS 1 */
 #define SOC_MAX_DTS_SENSORS		2
 
-static int get_tj_max(u32 *tj_max)
-{
-	u32 eax, edx;
-	u32 val;
-	int err;
-
-	err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
-	if (err)
-		goto err_ret;
-	else {
-		val = (eax >> 16) & 0xff;
-		if (val)
-			*tj_max = val * 1000;
-		else {
-			err = -EINVAL;
-			goto err_ret;
-		}
-	}
-
-	return 0;
-err_ret:
-	*tj_max = 0;
-
-	return err;
-}
-
 static int sys_get_trip_temp(struct thermal_zone_device *tzd, int trip,
 			     int *temp)
 {
@@ -415,8 +390,9 @@ struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
 	if (!trip_count || read_only_trip_count > trip_count)
 		return ERR_PTR(-EINVAL);
 
-	if (get_tj_max(&tj_max))
-		return ERR_PTR(-EINVAL);
+	ret = intel_tcc_get_tjmax(cpumask_any(cpu_online_mask), &tj_max);
+	if (ret)
+		return ERR_PTR(ret);
 
 	sensors = kzalloc(sizeof(*sensors), GFP_KERNEL);
 	if (!sensors)
@@ -475,4 +451,5 @@ void intel_soc_dts_iosf_exit(struct intel_soc_dts_sensors *sensors)
 }
 EXPORT_SYMBOL_GPL(intel_soc_dts_iosf_exit);
 
+MODULE_IMPORT_NS(INTEL_TCC);
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

