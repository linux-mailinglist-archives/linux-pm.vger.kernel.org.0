Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2187F1ABC07
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 11:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503066AbgDPJCh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 05:02:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47850 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503146AbgDPI6U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 04:58:20 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E8F23200C33;
        Thu, 16 Apr 2020 10:58:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 30E49200C3E;
        Thu, 16 Apr 2020 10:58:12 +0200 (CEST)
Received: from titan.ap.freescale.net (titan.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 53BD7402A8;
        Thu, 16 Apr 2020 16:58:08 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] thermal: qoriq: Update the settings for TMUv2
Date:   Thu, 16 Apr 2020 16:43:52 +0800
Message-Id: <20200416084352.33604-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For TMU v2, TMSAR registers need to be set properly to get the
accurate temperature values.
Also temperature reading needs to convert to degree Celsius
since it is in degrees Kelvin.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 028a6bbf75dc..c6ab0a0681cb 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -23,6 +23,7 @@
 #define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
+#define TMSARA_V2		0xe
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
 
@@ -50,6 +51,9 @@
 					    * Site Register
 					    */
 #define TRITSR_V	BIT(31)
+#define REGS_V2_TMSAR(n)	(0x304 + 16 * (n))	/* TMU monitoring
+						* site adjustment register
+						*/
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
@@ -100,7 +104,11 @@ static int tmu_get_temp(void *p, int *temp)
 				     10 * USEC_PER_MSEC))
 		return -ENODATA;
 
-	*temp = (val & 0xff) * 1000;
+	/* For TMUv2, temperature reading in degrees Kelvin */
+	if (qdata->ver == TMU_VER1)
+		*temp = (val & 0xff) * 1000;
+	else
+		*temp = (val & 0x1ff) - 273;
 
 	return 0;
 }
@@ -192,6 +200,8 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 {
+	int i;
+
 	/* Disable interrupt, using polling instead */
 	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
 
@@ -202,6 +212,8 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
+		for (i = 0; i < 7; i++)
+			regmap_write(data->regmap, REGS_V2_TMSAR(i), TMSARA_V2);
 	}
 
 	/* Disable monitoring */
@@ -212,6 +224,7 @@ static const struct regmap_range qoriq_yes_ranges[] = {
 	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
 	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
 	regmap_reg_range(REGS_V2_TEUMR(0), REGS_V2_TEUMR(2)),
+	regmap_reg_range(REGS_V2_TMSAR(0), REGS_V2_TMSAR(15)),
 	regmap_reg_range(REGS_IPBRR(0), REGS_IPBRR(1)),
 	/* Read only registers below */
 	regmap_reg_range(REGS_TRITSR(0), REGS_TRITSR(15)),
-- 
2.17.1

