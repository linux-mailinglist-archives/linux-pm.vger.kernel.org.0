Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECEE62076D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 04:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiKHDbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 22:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiKHDba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 22:31:30 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A7F2F672
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 19:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667878289; x=1699414289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ea1poUBCd4hPy458r9ilS29cRNF0FN/s2Pc7/4v/umw=;
  b=aYCzQ2jsLlKInTDebNZLwP8q749yDJE/8RKAO5LwWIa+u5mshYiEbcQe
   Pln+2LqGeMpedjnG2JWWRwywLndFlQ4roxt2LB243jRaygH5mnKGbp6ye
   xGzMxZZCJlooHK4TGIuKvw21nFQQYhYSvVh0Vakt30u6M7B+6qviMf8hL
   +1BF0gYSDV5zSqMQNWyWWQTAXGJ7rqM5Y5Pzn+HcDaoO/rJF+sn/II8Ns
   HtKsGqw9zdAwXffoC/MWd44hH4wqybR77GsbgPGU8XwruXTgaIbBwqh2d
   x9PceNyGxGS89pCVZd6M+I7xpW0sRDhDK0ycrVMTN8LkwXt0czco2SnFY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372732572"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="372732572"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:31:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614120257"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="614120257"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 19:31:27 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH 6/6] thermal/x86_pkg_temp_thermal: Add support for handling dynamic tjmax
Date:   Tue,  8 Nov 2022 11:33:32 +0800
Message-Id: <20221108033332.27760-7-rui.zhang@intel.com>
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

Tjmax value retrieved from MSR_IA32_TEMPERATURE_TARGET can be changed at
runtime when the Intel SST-PP (Intel Speed Select Technology -
Performance Profile) level is changed.

Enhance the code to use updated tjmax when programming the thermal
interrupt thresholds.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 22 +++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index cfe905735c62..9a9866a602ec 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -49,7 +49,6 @@ MODULE_PARM_DESC(notify_delay_ms,
 struct zone_device {
 	int				cpu;
 	bool				work_scheduled;
-	u32				tj_max;
 	u32				msr_pkg_therm_low;
 	u32				msr_pkg_therm_high;
 	struct delayed_work		work;
@@ -125,7 +124,7 @@ static int sys_get_trip_temp(struct thermal_zone_device *tzd,
 	struct zone_device *zonedev = tzd->devdata;
 	unsigned long thres_reg_value;
 	u32 mask, shift, eax, edx;
-	int ret;
+	int tj_max, ret;
 
 	if (trip >= MAX_NUMBER_OF_TRIPS)
 		return -EINVAL;
@@ -138,6 +137,11 @@ static int sys_get_trip_temp(struct thermal_zone_device *tzd,
 		shift = THERM_SHIFT_THRESHOLD0;
 	}
 
+	ret = intel_tcc_get_tjmax(zonedev->cpu, &tj_max);
+	if (ret)
+		return ret;
+	tj_max *= 1000;
+
 	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			   &eax, &edx);
 	if (ret < 0)
@@ -145,7 +149,7 @@ static int sys_get_trip_temp(struct thermal_zone_device *tzd,
 
 	thres_reg_value = (eax & mask) >> shift;
 	if (thres_reg_value)
-		*temp = zonedev->tj_max - thres_reg_value * 1000;
+		*temp = tj_max - thres_reg_value * 1000;
 	else
 		*temp = THERMAL_TEMP_INVALID;
 	pr_debug("sys_get_trip_temp %d\n", *temp);
@@ -158,9 +162,14 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
 	struct zone_device *zonedev = tzd->devdata;
 	u32 l, h, mask, shift, intr;
-	int ret;
+	int tj_max, ret;
+
+	ret = intel_tcc_get_tjmax(zonedev->cpu, &tj_max);
+	if (ret)
+		return ret;
+	tj_max *= 1000;
 
-	if (trip >= MAX_NUMBER_OF_TRIPS || temp >= zonedev->tj_max)
+	if (trip >= MAX_NUMBER_OF_TRIPS || temp >= tj_max)
 		return -EINVAL;
 
 	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
@@ -185,7 +194,7 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 	if (!temp) {
 		l &= ~intr;
 	} else {
-		l |= (zonedev->tj_max - temp)/1000 << shift;
+		l |= (tj_max - temp)/1000 << shift;
 		l |= intr;
 	}
 
@@ -336,7 +345,6 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
-	zonedev->tj_max = tj_max;
 	zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
 			thres_count,
 			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
-- 
2.25.1

