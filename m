Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF65781F2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 14:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiGRMPE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiGRMO6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 08:14:58 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 585B425C59;
        Mon, 18 Jul 2022 05:14:47 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,281,1650898800"; 
   d="scan'208";a="126508832"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Jul 2022 21:14:45 +0900
Received: from biju-VirtualBox.ree.adwin.renesas.com (unknown [10.226.36.116])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 552CF40062DF;
        Mon, 18 Jul 2022 21:14:42 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, Pavel Machek <pavel@denx.de>
Subject: [PATCH] thermal/drivers/rzg2l: Fix comments
Date:   Mon, 18 Jul 2022 13:14:40 +0100
Message-Id: <20220718121440.556408-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch replaces 'Capture times'->'Total number of ADC data samples' as
the former does not really explain much.

It also fixes the typo
 * caliberation->calibration

Lastly, as per the coding style /* should be on a separate line.
This patch fixes this issue.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/rzg2l_thermal.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index be07e04c6926..51ae80eda6af 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -47,7 +47,7 @@
 
 #define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
 #define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
-#define TS_CODE_CAP_TIMES	8	/* Capture  times */
+#define TS_CODE_CAP_TIMES	8	/* Total number of ADC data samples */
 
 #define RZG2L_THERMAL_GRAN	500	/* milli Celsius */
 #define RZG2L_TSU_SS_TIMEOUT_US	1000
@@ -80,7 +80,8 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 	int val, i;
 
 	for (i = 0; i < TS_CODE_CAP_TIMES ; i++) {
-		/* TSU repeats measurement at 20 microseconds intervals and
+		/*
+		 * TSU repeats measurement at 20 microseconds intervals and
 		 * automatically updates the results of measurement. As per
 		 * the HW manual for measuring temperature we need to read 8
 		 * values consecutively and then take the average.
@@ -92,16 +93,18 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 
 	ts_code_ave = result / TS_CODE_CAP_TIMES;
 
-	/* Calculate actual sensor value by applying curvature correction formula
+	/*
+	 * Calculate actual sensor value by applying curvature correction formula
 	 * dsensor = ts_code_ave / (1 + ts_code_ave * 0.000013). Here we are doing
 	 * integer calculation by scaling all the values by 1000000.
 	 */
 	dsensor = TS_CODE_AVE_SCALE(ts_code_ave) /
 		(TS_CODE_AVE_SCALE(1) + (ts_code_ave * CURVATURE_CORRECTION_CONST));
 
-	/* The temperature Tj is calculated by the formula
+	/*
+	 * The temperature Tj is calculated by the formula
 	 * Tj = (dsensor − calib1) * 165/ (calib0 − calib1) − 40
-	 * where calib0 and calib1 are the caliberation values.
+	 * where calib0 and calib1 are the calibration values.
 	 */
 	val = ((dsensor - priv->calib1) * (MCELSIUS(165) /
 		(priv->calib0 - priv->calib1))) - MCELSIUS(40);
@@ -122,7 +125,8 @@ static int rzg2l_thermal_init(struct rzg2l_thermal_priv *priv)
 	rzg2l_thermal_write(priv, TSU_SM, TSU_SM_NORMAL_MODE);
 	rzg2l_thermal_write(priv, TSU_ST, 0);
 
-	/* Before setting the START bit, TSU should be in normal operating
+	/*
+	 * Before setting the START bit, TSU should be in normal operating
 	 * mode. As per the HW manual, it will take 60 µs to place the TSU
 	 * into normal operating mode.
 	 */
@@ -217,7 +221,7 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	dev_dbg(dev, "TSU probed with %s caliberation values",
+	dev_dbg(dev, "TSU probed with %s calibration values",
 		rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0)) ?  "hw" : "sw");
 
 	return 0;
-- 
2.25.1

