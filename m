Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777A362076C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 04:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiKHDbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 22:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiKHDb2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 22:31:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A552F38D
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 19:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667878287; x=1699414287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CQhm3TGoPzO9TKDsEwlUq9f+5d53qoSPhmg0kb1siZo=;
  b=QnR3xTPryX6M+pPKUXy4kZkyRRfbCPf6tXIxMgL6XoqHbMJq781wbEyc
   PRBlptt4HMFphNRxn25djB4q9zWiFId/rxMfysNYcaMtv6vggzClq23Kc
   WvrGEwgg6xZOnKOmBd3ZB4TKCYjuDZjYQHGU+gu+XWjXO1gI8pigmkOuU
   g5LFL83JMEVz+syV+9VmpfcG5v7CuaoQntsedJuj5BbBfZ3SsdOSki4pf
   NjIhX50JMTbjL0hg+uvmhqPNxNJA5dIvXjK/IUC/i+euCnR3DHEpXJYwJ
   /r96dni1SUfgad1ej6sQJ2JRcLh+eZcvM6P8+EB/4byHykS3q8UZGiHnJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372732554"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="372732554"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:31:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614120251"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="614120251"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 19:31:26 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH 5/6] thermal/x86_pkg_temp_thermal: Use Intel TCC library
Date:   Tue,  8 Nov 2022 11:33:31 +0800
Message-Id: <20221108033332.27760-6-rui.zhang@intel.com>
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
 drivers/thermal/intel/Kconfig                |  1 +
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 40 ++++++--------------
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index dafdb3dd3fc7..fd41c810629b 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -21,6 +21,7 @@ config X86_PKG_TEMP_THERMAL
 	depends on X86_THERMAL_VECTOR
 	select THERMAL_GOV_USER_SPACE
 	select THERMAL_WRITABLE_TRIPS
+	select INTEL_TCC
 	default m
 	help
 	  Enable this to register CPU digital sensor for package temperature as
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index a0e234fce71a..cfe905735c62 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/intel_tcc.h>
 #include <linux/err.h>
 #include <linux/param.h>
 #include <linux/device.h>
@@ -104,38 +105,18 @@ static struct zone_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 	return NULL;
 }
 
-/*
-* tj-max is interesting because threshold is set relative to this
-* temperature.
-*/
-static int get_tj_max(int cpu, u32 *tj_max)
-{
-	u32 eax, edx, val;
-	int err;
-
-	err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
-	if (err)
-		return err;
-
-	val = (eax >> 16) & 0xff;
-	*tj_max = val * 1000;
-
-	return val ? 0 : -EINVAL;
-}
-
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 {
 	struct zone_device *zonedev = tzd->devdata;
-	u32 eax, edx;
+	int ret;
 
-	rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_STATUS,
-			&eax, &edx);
-	if (eax & 0x80000000) {
-		*temp = zonedev->tj_max - ((eax >> 16) & 0x7f) * 1000;
-		pr_debug("sys_get_curr_temp %d\n", *temp);
-		return 0;
-	}
-	return -EINVAL;
+	ret = intel_tcc_get_temp(zonedev->cpu, true, temp);
+	if (ret)
+		return ret;
+
+	*temp *= 1000;
+	pr_debug("sys_get_curr_temp %d\n", *temp);
+	return 0;
 }
 
 static int sys_get_trip_temp(struct thermal_zone_device *tzd,
@@ -345,7 +326,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 
 	thres_count = clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
 
-	err = get_tj_max(cpu, &tj_max);
+	err = intel_tcc_get_tjmax(cpu, &tj_max);
 	if (err)
 		return err;
 
@@ -536,6 +517,7 @@ static void __exit pkg_temp_thermal_exit(void)
 }
 module_exit(pkg_temp_thermal_exit)
 
+MODULE_IMPORT_NS(INTEL_TCC);
 MODULE_DESCRIPTION("X86 PKG TEMP Thermal Driver");
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

