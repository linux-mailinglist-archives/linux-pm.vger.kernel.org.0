Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5923B2D5AF7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 13:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbgLJMwS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 07:52:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:26357 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387545AbgLJMwG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 07:52:06 -0500
IronPort-SDR: ljOmEhNXsfUB3Zd1xATnE958FSX1P6Fu5GRQFIT8TBciH40UYVCYhRPTjfjCSDBPqPxSly2EZP
 GJ70g56q5V2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="153481136"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="153481136"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 04:51:21 -0800
IronPort-SDR: zMhGeLDLV+I+Gs/yc8yu1CBaVblxWNO+V1vRFf/q1wFfUjFttEWzHWAJI/PDqRUitkAgGS+SqR
 LkTVDiHHsZIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="408517044"
Received: from srpawnik-nuc8i7beh.iind.intel.com ([10.223.107.144])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2020 04:51:19 -0800
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, rui.zhang@intel.com,
        sumeet.r.pawnikar@intel.com
Subject: [PATCH -next] thermal: intel: pch: use macro for temperature calculation
Date:   Thu, 10 Dec 2020 18:18:01 +0530
Message-Id: <20201210124801.13850-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use macro for temperature calculation

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index d7c05c00881e..41723c6c6c0c 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -167,8 +167,7 @@ static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
 	trip_temp = readw(ptd->hw_base + WPT_CTT);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		/* Resolution of 1/2 degree C and an offset of -50C */
-		ptd->crt_temp = trip_temp * 1000 / 2 - 50000;
+		ptd->crt_temp = GET_WPT_TEMP(trip_temp);
 		ptd->crt_trip_id = 0;
 		++(*nr_trips);
 	}
@@ -177,8 +176,7 @@ static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
 	trip_temp = readw(ptd->hw_base + WPT_PHL);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		/* Resolution of 1/2 degree C and an offset of -50C */
-		ptd->hot_temp = trip_temp * 1000 / 2 - 50000;
+		ptd->hot_temp = GET_WPT_TEMP(trip_temp);
 		ptd->hot_trip_id = *nr_trips;
 		++(*nr_trips);
 	}
@@ -190,12 +188,7 @@ static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)

 static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
 {
-	u16 wpt_temp;
-
-	wpt_temp = WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP);
-
-	/* Resolution of 1/2 degree C and an offset of -50C */
-	*temp = (wpt_temp * 1000 / 2 - 50000);
+	*temp = GET_WPT_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));

 	return 0;
 }
--
2.28.0

