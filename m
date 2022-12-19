Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D7A650EC4
	for <lists+linux-pm@lfdr.de>; Mon, 19 Dec 2022 16:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiLSPjZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 10:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiLSPjW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 10:39:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4028411838
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 07:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671464361; x=1703000361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=z54DaDYRtkOEulF9x0NJLtJ7Ea+wxw4HXszOh07R6Qg=;
  b=iUks4BU1LFRz2ER2JQ9rsk2O6/qmHOU+zBmtCXbuEwKLXy+M8pjRs4AM
   n5OrcQwtClM4Yhkd1LwprQMwWUOnqAPLCRA9pDgADZQs3cGCSGExfiSHv
   11aJZKmRSdr2gYe/9xtyNcKOyyTnBJ8MZbhv+yFvtCnhGesDihQhuJqFH
   czkGFmU4cd7pxvy/90MkchA8UEZa/wDi6NEKh3RIdRL1ZAsCDIv1HZrTS
   Mam8WgP4js0G1VlPBIaFtF+EWOQmhTGYu8diyXboEJ09YAmAHVCwtD29z
   DCNNQNWVrGrSM+hJm2IEhZXo0txO9+G/NhhV9lJ2Xzu3MHfFX/J25dtTt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="307051276"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="307051276"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 07:39:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="774960355"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="774960355"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2022 07:39:19 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 6/6] thermal/x86_pkg_temp_thermal: Add support for handling dynamic tjmax
Date:   Mon, 19 Dec 2022 23:46:20 +0800
Message-Id: <20221219154620.3630-7-rui.zhang@intel.com>
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

Tjmax value retrieved from MSR_IA32_TEMPERATURE_TARGET can be changed at
runtime when the Intel SST-PP (Intel Speed Select Technology -
Performance Profile) level is changed.

Enhance the code to use updated tjmax when programming the thermal
interrupt thresholds.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 30 +++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 416ff23da4de..954cbceaf786 100644
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
 
+	tj_max = intel_tcc_get_tjmax(zonedev->cpu);
+	if (tj_max < 0)
+		return tj_max;
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
 
-	if (trip >= MAX_NUMBER_OF_TRIPS || temp >= zonedev->tj_max)
+	tj_max = intel_tcc_get_tjmax(zonedev->cpu);
+	if (tj_max < 0)
+		return tj_max;
+	tj_max *= 1000;
+
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
 
@@ -312,7 +321,7 @@ static int pkg_thermal_notify(u64 msr_val)
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
 	int id = topology_logical_die_id(cpu);
-	u32 tj_max, eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 	struct zone_device *zonedev;
 	int thres_count, err;
 
@@ -326,9 +335,9 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 
 	thres_count = clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
 
-	tj_max = intel_tcc_get_tjmax(cpu);
-	if (tj_max < 0)
-		return tj_max;
+	err = intel_tcc_get_tjmax(cpu);
+	if (err < 0)
+		return err;
 
 	zonedev = kzalloc(sizeof(*zonedev), GFP_KERNEL);
 	if (!zonedev)
@@ -336,7 +345,6 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
-	zonedev->tj_max = tj_max;
 	zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
 			thres_count,
 			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
-- 
2.25.1

