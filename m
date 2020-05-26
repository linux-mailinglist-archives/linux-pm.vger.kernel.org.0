Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECA31E1B1E
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 08:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgEZGRW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 02:17:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55110 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgEZGRW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 May 2020 02:17:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 937A61A0422;
        Tue, 26 May 2020 08:17:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D3BF11A0324;
        Tue, 26 May 2020 08:17:17 +0200 (CEST)
Received: from titan.ap.freescale.net (titan.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 29E424028B;
        Tue, 26 May 2020 14:17:13 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH v4] thermal: qoriq: Update the settings for TMUv2
Date:   Tue, 26 May 2020 14:02:12 +0800
Message-Id: <20200526060212.4118-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For TMU v2, TMSAR registers need to be set properly to get the
accurate temperature values.
Also the temperature read needs to be converted to degree Celsius
since it is in degrees Kelvin.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
v4:
	- replace the hard-coded number with constant variables
	- update some comments as needed

 drivers/thermal/qoriq_thermal.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 028a6bbf75dc..73049f9bea25 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -11,6 +11,7 @@
 #include <linux/regmap.h>
 #include <linux/sizes.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 
 #include "thermal_core.h"
 #include "thermal_hwmon.h"
@@ -23,6 +24,7 @@
 #define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
+#define TMSARA_V2		0xe
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
 
@@ -50,6 +52,9 @@
 					    * Site Register
 					    */
 #define TRITSR_V	BIT(31)
+#define REGS_V2_TMSAR(n)	(0x304 + 16 * (n))	/* TMU monitoring
+						* site adjustment register
+						*/
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
@@ -85,12 +90,21 @@ static int tmu_get_temp(void *p, int *temp)
 	/*
 	 * REGS_TRITSR(id) has the following layout:
 	 *
+	 * For TMU Rev1:
 	 * 31  ... 7 6 5 4 3 2 1 0
 	 *  V          TEMP
 	 *
 	 * Where V bit signifies if the measurement is ready and is
 	 * within sensor range. TEMP is an 8 bit value representing
-	 * temperature in C.
+	 * temperature in Celsius.
+
+	 * For TMU Rev2:
+	 * 31  ... 8 7 6 5 4 3 2 1 0
+	 *  V          TEMP
+	 *
+	 * Where V bit signifies if the measurement is ready and is
+	 * within sensor range. TEMP is an 9 bit value representing
+	 * temperature in KelVin.
 	 */
 	if (regmap_read_poll_timeout(qdata->regmap,
 				     REGS_TRITSR(qsensor->id),
@@ -100,7 +114,10 @@ static int tmu_get_temp(void *p, int *temp)
 				     10 * USEC_PER_MSEC))
 		return -ENODATA;
 
-	*temp = (val & 0xff) * 1000;
+	if (qdata->ver == TMU_VER1)
+		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
+	else
+		*temp = kelvin_to_millicelsius(val & GENMASK(8, 0));
 
 	return 0;
 }
@@ -192,6 +209,8 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 {
+	int i;
+
 	/* Disable interrupt, using polling instead */
 	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
 
@@ -202,6 +221,8 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
+		for (i = 0; i < SITES_MAX; i++)
+			regmap_write(data->regmap, REGS_V2_TMSAR(i), TMSARA_V2);
 	}
 
 	/* Disable monitoring */
@@ -212,6 +233,7 @@ static const struct regmap_range qoriq_yes_ranges[] = {
 	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
 	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
 	regmap_reg_range(REGS_V2_TEUMR(0), REGS_V2_TEUMR(2)),
+	regmap_reg_range(REGS_V2_TMSAR(0), REGS_V2_TMSAR(15)),
 	regmap_reg_range(REGS_IPBRR(0), REGS_IPBRR(1)),
 	/* Read only registers below */
 	regmap_reg_range(REGS_TRITSR(0), REGS_TRITSR(15)),
-- 
2.17.1

