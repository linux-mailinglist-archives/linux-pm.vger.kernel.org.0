Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0630ABC0B2
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 05:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391285AbfIXD1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 23:27:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60430 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394624AbfIXD1O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 23:27:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E8D00200019;
        Tue, 24 Sep 2019 05:27:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E7F832000B6;
        Tue, 24 Sep 2019 05:27:07 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EA7D4402E4;
        Tue, 24 Sep 2019 11:27:02 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, anson.huang@nxp.com
Cc:     daniel.lezcano@linaro.org, leoyang.li@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH v2] thermal: qoriq: add thermal monitor unit version 2 support
Date:   Tue, 24 Sep 2019 11:16:40 +0800
Message-Id: <20190924031640.3159-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thermal Monitor Unit v2 is introduced on new Layscape SoC.
Compared to v1, TMUv2 has a little different register layout
and digital output is fairly linear.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
v2:
	- refine the code: remove redundant variable, rename variable etc.

 drivers/thermal/qoriq_thermal.c | 121 +++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 7b364933bfb1..43617e53554b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -12,7 +12,16 @@
 
 #include "thermal_core.h"
 
-#define SITES_MAX	16
+#define SITES_MAX		16
+#define TMR_DISABLE		0x0
+#define TMR_ME			0x80000000
+#define TMR_ALPF		0x0c000000
+#define TMR_ALPF_V2		0x03000000
+#define TMTMIR_DEFAULT	0x0000000f
+#define TIER_DISABLE	0x0
+#define TEUMR0_V2		0x51009c00
+#define TMU_VER1		0x1
+#define TMU_VER2		0x2
 
 /*
  * QorIQ TMU Registers
@@ -23,17 +32,55 @@ struct qoriq_tmu_site_regs {
 	u8 res0[0x8];
 };
 
-struct qoriq_tmu_regs {
+struct qoriq_tmu_regs_v2 {
+	u32 tmr;		/* Mode Register */
+	u32 tsr;		/* Status Register */
+	u32 tmsr;		/* monitor site register */
+	u32 tmtmir;		/* Temperature measurement interval Register */
+	u8 res0[0x10];
+	u32 tier;		/* Interrupt Enable Register */
+	u32 tidr;		/* Interrupt Detect Register */
+	u8 res1[0x8];
+	u32 tiiscr;		/* interrupt immediate site capture register */
+	u32 tiascr;		/* interrupt average site capture register */
+	u32 ticscr;		/* Interrupt Critical Site Capture Register */
+	u32 res2;
+	u32 tmhtcr;		/* monitor high temperature capture register */
+	u32 tmltcr;		/* monitor low temperature capture register */
+	u32 tmrtrcr;	/* monitor rising temperature rate capture register */
+	u32 tmftrcr;	/* monitor falling temperature rate capture register */
+	u32 tmhtitr;	/* High Temperature Immediate Threshold */
+	u32 tmhtatr;	/* High Temperature Average Threshold */
+	u32 tmhtactr;	/* High Temperature Average Crit Threshold */
+	u32 res3;
+	u32 tmltitr;	/* monitor low temperature immediate threshold */
+	u32 tmltatr;	/* monitor low temperature average threshold register */
+	u32 tmltactr;	/* monitor low temperature average critical threshold */
+	u32 res4;
+	u32 tmrtrctr;	/* monitor rising temperature rate critical threshold */
+	u32 tmftrctr;	/* monitor falling temperature rate critical threshold*/
+	u8 res5[0x8];
+	u32 ttcfgr;	/* Temperature Configuration Register */
+	u32 tscfgr;	/* Sensor Configuration Register */
+	u8 res6[0x78];
+	struct qoriq_tmu_site_regs site[SITES_MAX];
+	u8 res7[0x9f8];
+	u32 ipbrr0;		/* IP Block Revision Register 0 */
+	u32 ipbrr1;		/* IP Block Revision Register 1 */
+	u8 res8[0x300];
+	u32 teumr0;
+	u32 teumr1;
+	u32 teumr2;
+	u32 res9;
+	u32 ttrcr[4];	/* Temperature Range Control Register */
+};
+
+struct qoriq_tmu_regs_v1 {
 	u32 tmr;		/* Mode Register */
-#define TMR_DISABLE	0x0
-#define TMR_ME		0x80000000
-#define TMR_ALPF	0x0c000000
 	u32 tsr;		/* Status Register */
 	u32 tmtmir;		/* Temperature measurement interval Register */
-#define TMTMIR_DEFAULT	0x0000000f
 	u8 res0[0x14];
 	u32 tier;		/* Interrupt Enable Register */
-#define TIER_DISABLE	0x0
 	u32 tidr;		/* Interrupt Detect Register */
 	u32 tiscr;		/* Interrupt Site Capture Register */
 	u32 ticscr;		/* Interrupt Critical Site Capture Register */
@@ -53,10 +100,7 @@ struct qoriq_tmu_regs {
 	u32 ipbrr0;		/* IP Block Revision Register 0 */
 	u32 ipbrr1;		/* IP Block Revision Register 1 */
 	u8 res6[0x310];
-	u32 ttr0cr;		/* Temperature Range 0 Control Register */
-	u32 ttr1cr;		/* Temperature Range 1 Control Register */
-	u32 ttr2cr;		/* Temperature Range 2 Control Register */
-	u32 ttr3cr;		/* Temperature Range 3 Control Register */
+	u32 ttrcr[4];		/* Temperature Range Control Register */
 };
 
 struct qoriq_tmu_data;
@@ -71,7 +115,9 @@ struct qoriq_sensor {
 };
 
 struct qoriq_tmu_data {
-	struct qoriq_tmu_regs __iomem *regs;
+	int ver;
+	struct qoriq_tmu_regs_v1 __iomem *regs;
+	struct qoriq_tmu_regs_v2 __iomem *regs_v2;
 	bool little_endian;
 	struct qoriq_sensor	*sensor[SITES_MAX];
 };
@@ -130,12 +176,23 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 				return PTR_ERR(qdata->sensor[id]->tzd);
 		}
 
-		sites |= 0x1 << (15 - id);
+		if (qdata->ver == TMU_VER1)
+			sites |= 0x1 << (15 - id);
+		else
+			sites |= 0x1 << id;
 	}
 
 	/* Enable monitoring */
-	if (sites != 0)
-		tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
+	if (sites != 0) {
+		if (qdata->ver == TMU_VER1) {
+			tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
+					&qdata->regs->tmr);
+		} else {
+			tmu_write(qdata, sites, &qdata->regs_v2->tmsr);
+			tmu_write(qdata, TMR_ME | TMR_ALPF_V2,
+					&qdata->regs_v2->tmr);
+		}
+	}
 
 	return 0;
 }
@@ -148,16 +205,20 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
 
-	if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
-		dev_err(&pdev->dev, "missing calibration range.\n");
-		return -ENODEV;
+	len = of_property_count_u32_elems(np, "fsl,tmu-range");
+	if (len < 0 || len > 4) {
+		dev_err(&pdev->dev, "invalid range data.\n");
+		return len;
+	}
+
+	val = of_property_read_u32_array(np, "fsl,tmu-range", range, len);
+	if (val != 0) {
+		dev_err(&pdev->dev, "failed to read range data.\n");
+		return val;
 	}
 
-	/* Init temperature range registers */
-	tmu_write(data, range[0], &data->regs->ttr0cr);
-	tmu_write(data, range[1], &data->regs->ttr1cr);
-	tmu_write(data, range[2], &data->regs->ttr2cr);
-	tmu_write(data, range[3], &data->regs->ttr3cr);
+	for (i = 0; i < len; i++)
+		tmu_write(data, range[i], &data->regs->ttrcr[i]);
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
@@ -181,7 +242,12 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	tmu_write(data, TIER_DISABLE, &data->regs->tier);
 
 	/* Set update_interval */
-	tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
+	if (data->ver == TMU_VER1) {
+		tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
+	} else {
+		tmu_write(data, TMTMIR_DEFAULT, &data->regs_v2->tmtmir);
+		tmu_write(data, TEUMR0_V2, &data->regs_v2->teumr0);
+	}
 
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
@@ -190,6 +256,7 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 static int qoriq_tmu_probe(struct platform_device *pdev)
 {
 	int ret;
+	u32 ver;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 
@@ -209,6 +276,12 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_iomap;
 	}
 
+	/* version register offset at: 0xbf8 on both v1 and v2 */
+	ver = tmu_read(data, &data->regs->ipbrr0);
+	data->ver = (ver >> 8) & 0xff;
+	if (data->ver == TMU_VER2)
+		data->regs_v2 = (void __iomem *)data->regs;
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
 	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
-- 
2.17.1

