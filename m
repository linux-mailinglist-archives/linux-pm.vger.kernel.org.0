Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87724648532
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiLIP1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiLIP0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0374B8F718
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:33 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lN/gag9sRqUt/38lGwiSw1RikEcAJs6Jm8bsH0719lo=;
        b=alV9Hpw2tCWyu5gDaar1Bmy1hM+4GFdbLulh1cfrzay12efa9M06MMvY07VL+QuTgrPXao
        bvFbI/BwQ8floUTBjwZWmWMVWS+NsphanrGGJpu4XWiYk+lRkXxLABhSBTP8ODmi32ImEV
        wQe0iLIkJF4Xho4TgqPl3LkQMUBZ5vzaUZZP4RORtcQ4KHfWrjgduXb27HfMVTowvK8c3Y
        6vdp9QNgBw5iMx1ELuRVMySESNt4AcSTsB5djIlnW+TNFQ0TP692QyNZd/UmTQUZ5i4/a4
        3ceXdwJsdojdWEJvIb3GhJuRQ3bXwqDom8s5dcIB+TMgxPwZV9IPLRE5wvT5nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lN/gag9sRqUt/38lGwiSw1RikEcAJs6Jm8bsH0719lo=;
        b=Uvw+2LPOeOR2oDrtRbFLZIlgXGO612CJb0nAU+R89WPu9C0vDczWeWFerAfSvXk9GAg/1T
        a8JSqrm2nIVOejBQ==
From:   "thermal-bot for Marek Vasut" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/imx: Add support for loading
 calibration data from OCOTP
Cc:     Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059958874.4906.16345400954748935514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     b1eccb25d015f7dcbe3b6ee5e4e2d15fe50edafa
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b1eccb25d015f7dcbe3b6ee5e4e2d15fe50edafa
Author:        Marek Vasut <marex@denx.de>
AuthorDate:    Fri, 02 Dec 2022 17:23:53 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/imx: Add support for loading calibration data from OCOTP

The TMU TASR, TCALIVn, TRIM registers must be explicitly programmed with
calibration values in OCOTP. Add support for reading the OCOTP calibration
data and programming those into the TMU hardware.

The MX8MM/MX8MN TMUv1 uses only one OCOTP cell, while MX8MP TMUv2 uses 4,
the programming differs in each case.

Based on U-Boot commits:
70487ff386c ("imx8mm: Load fuse for TMU TCALIV and TASR")
ebb9aab318b ("imx: load calibration parameters from fuse for i.MX8MP")

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/imx8mm_thermal.c | 164 ++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index 182cc20..e709c03 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -10,9 +10,11 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
@@ -20,6 +22,22 @@
 #define TER			0x0	/* TMU enable */
 #define TPS			0x4
 #define TRITSR			0x20	/* TMU immediate temp */
+/* TMU calibration data registers */
+#define TASR			0x28
+#define TASR_BUF_SLOPE_MASK	GENMASK(19, 16)
+#define TASR_BUF_VREF_MASK	GENMASK(4, 0)	/* TMU_V1 */
+#define TASR_BUF_VERF_SEL_MASK	GENMASK(1, 0)	/* TMU_V2 */
+#define TCALIV(n)		(0x30 + ((n) * 4))
+#define TCALIV_EN		BIT(31)
+#define TCALIV_HR_MASK		GENMASK(23, 16)	/* TMU_V1 */
+#define TCALIV_RT_MASK		GENMASK(7, 0)	/* TMU_V1 */
+#define TCALIV_SNSR105C_MASK	GENMASK(27, 16)	/* TMU_V2 */
+#define TCALIV_SNSR25C_MASK	GENMASK(11, 0)	/* TMU_V2 */
+#define TRIM			0x3c
+#define TRIM_BJT_CUR_MASK	GENMASK(23, 20)
+#define TRIM_BGR_MASK		GENMASK(31, 28)
+#define TRIM_VLSB_MASK		GENMASK(15, 12)
+#define TRIM_EN_CH		BIT(7)
 
 #define TER_ADC_PD		BIT(30)
 #define TER_EN			BIT(31)
@@ -32,6 +50,25 @@
 #define SIGN_BIT		BIT(7)
 #define TEMP_VAL_MASK		GENMASK(6, 0)
 
+/* TMU OCOTP calibration data bitfields */
+#define ANA0_EN			BIT(25)
+#define ANA0_BUF_VREF_MASK	GENMASK(24, 20)
+#define ANA0_BUF_SLOPE_MASK	GENMASK(19, 16)
+#define ANA0_HR_MASK		GENMASK(15, 8)
+#define ANA0_RT_MASK		GENMASK(7, 0)
+#define TRIM2_VLSB_MASK		GENMASK(23, 20)
+#define TRIM2_BGR_MASK		GENMASK(19, 16)
+#define TRIM2_BJT_CUR_MASK	GENMASK(15, 12)
+#define TRIM2_BUF_SLOP_SEL_MASK	GENMASK(11, 8)
+#define TRIM2_BUF_VERF_SEL_MASK	GENMASK(7, 6)
+#define TRIM3_TCA25_0_LSB_MASK	GENMASK(31, 28)
+#define TRIM3_TCA40_0_MASK	GENMASK(27, 16)
+#define TRIM4_TCA40_1_MASK	GENMASK(31, 20)
+#define TRIM4_TCA105_0_MASK	GENMASK(19, 8)
+#define TRIM4_TCA25_0_MSB_MASK	GENMASK(7, 0)
+#define TRIM5_TCA105_1_MASK	GENMASK(23, 12)
+#define TRIM5_TCA25_1_MASK	GENMASK(11, 0)
+
 #define VER1_TEMP_LOW_LIMIT	10000
 #define VER2_TEMP_LOW_LIMIT	-40000
 #define VER2_TEMP_HIGH_LIMIT	125000
@@ -134,6 +171,129 @@ static void imx8mm_tmu_probe_sel_all(struct imx8mm_tmu *tmu)
 	writel_relaxed(val, tmu->base + TPS);
 }
 
+static int imx8mm_tmu_probe_set_calib_v1(struct platform_device *pdev,
+					 struct imx8mm_tmu *tmu)
+{
+	struct device *dev = &pdev->dev;
+	u32 ana0;
+	int ret;
+
+	ret = nvmem_cell_read_u32(&pdev->dev, "calib", &ana0);
+	if (ret) {
+		dev_warn(dev, "Failed to read OCOTP nvmem cell (%d).\n", ret);
+		return ret;
+	}
+
+	writel(FIELD_PREP(TASR_BUF_VREF_MASK,
+			  FIELD_GET(ANA0_BUF_VREF_MASK, ana0)) |
+	       FIELD_PREP(TASR_BUF_SLOPE_MASK,
+			  FIELD_GET(ANA0_BUF_SLOPE_MASK, ana0)),
+	       tmu->base + TASR);
+
+	writel(FIELD_PREP(TCALIV_RT_MASK, FIELD_GET(ANA0_RT_MASK, ana0)) |
+	       FIELD_PREP(TCALIV_HR_MASK, FIELD_GET(ANA0_HR_MASK, ana0)) |
+	       ((ana0 & ANA0_EN) ? TCALIV_EN : 0),
+	       tmu->base + TCALIV(0));
+
+	return 0;
+}
+
+static int imx8mm_tmu_probe_set_calib_v2(struct platform_device *pdev,
+					 struct imx8mm_tmu *tmu)
+{
+	struct device *dev = &pdev->dev;
+	struct nvmem_cell *cell;
+	u32 trim[4] = { 0 };
+	size_t len;
+	void *buf;
+
+	cell = nvmem_cell_get(dev, "calib");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	memcpy(trim, buf, min(len, sizeof(trim)));
+	kfree(buf);
+
+	if (len != 16) {
+		dev_err(dev,
+			"OCOTP nvmem cell length is %zu, must be 16.\n", len);
+		return -EINVAL;
+	}
+
+	/* Blank sample hardware */
+	if (!trim[0] && !trim[1] && !trim[2] && !trim[3]) {
+		/* Use a default 25C binary codes */
+		writel(FIELD_PREP(TCALIV_SNSR25C_MASK, 0x63c),
+		       tmu->base + TCALIV(0));
+		writel(FIELD_PREP(TCALIV_SNSR25C_MASK, 0x63c),
+		       tmu->base + TCALIV(1));
+		return 0;
+	}
+
+	writel(FIELD_PREP(TASR_BUF_VERF_SEL_MASK,
+			  FIELD_GET(TRIM2_BUF_VERF_SEL_MASK, trim[0])) |
+	       FIELD_PREP(TASR_BUF_SLOPE_MASK,
+			  FIELD_GET(TRIM2_BUF_SLOP_SEL_MASK, trim[0])),
+	       tmu->base + TASR);
+
+	writel(FIELD_PREP(TRIM_BJT_CUR_MASK,
+			  FIELD_GET(TRIM2_BJT_CUR_MASK, trim[0])) |
+	       FIELD_PREP(TRIM_BGR_MASK, FIELD_GET(TRIM2_BGR_MASK, trim[0])) |
+	       FIELD_PREP(TRIM_VLSB_MASK, FIELD_GET(TRIM2_VLSB_MASK, trim[0])) |
+	       TRIM_EN_CH,
+	       tmu->base + TRIM);
+
+	writel(FIELD_PREP(TCALIV_SNSR25C_MASK,
+			  FIELD_GET(TRIM3_TCA25_0_LSB_MASK, trim[1]) |
+			  (FIELD_GET(TRIM4_TCA25_0_MSB_MASK, trim[2]) << 4)) |
+	       FIELD_PREP(TCALIV_SNSR105C_MASK,
+			  FIELD_GET(TRIM4_TCA105_0_MASK, trim[2])),
+	       tmu->base + TCALIV(0));
+
+	writel(FIELD_PREP(TCALIV_SNSR25C_MASK,
+			  FIELD_GET(TRIM5_TCA25_1_MASK, trim[3])) |
+	       FIELD_PREP(TCALIV_SNSR105C_MASK,
+			  FIELD_GET(TRIM5_TCA105_1_MASK, trim[3])),
+	       tmu->base + TCALIV(1));
+
+	writel(FIELD_PREP(TCALIV_SNSR25C_MASK,
+			  FIELD_GET(TRIM3_TCA40_0_MASK, trim[1])) |
+	       FIELD_PREP(TCALIV_SNSR105C_MASK,
+			  FIELD_GET(TRIM4_TCA40_1_MASK, trim[2])),
+	       tmu->base + TCALIV(2));
+
+	return 0;
+}
+
+static int imx8mm_tmu_probe_set_calib(struct platform_device *pdev,
+				      struct imx8mm_tmu *tmu)
+{
+	struct device *dev = &pdev->dev;
+
+	/*
+	 * Lack of calibration data OCOTP reference is not considered
+	 * fatal to retain compatibility with old DTs. It is however
+	 * strongly recommended to update such old DTs to get correct
+	 * temperature compensation values for each SoC.
+	 */
+	if (!of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
+		dev_warn(dev,
+			 "No OCOTP nvmem reference found, SoC-specific calibration not loaded. Please update your DT.\n");
+		return 0;
+	}
+
+	if (tmu->socdata->version == TMU_VER1)
+		return imx8mm_tmu_probe_set_calib_v1(pdev, tmu);
+
+	return imx8mm_tmu_probe_set_calib_v2(pdev, tmu);
+}
+
 static int imx8mm_tmu_probe(struct platform_device *pdev)
 {
 	const struct thermal_soc_data *data;
@@ -186,6 +346,10 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tmu);
 
+	ret = imx8mm_tmu_probe_set_calib(pdev, tmu);
+	if (ret)
+		goto disable_clk;
+
 	/* enable all the probes for V2 TMU */
 	if (tmu->socdata->version == TMU_VER2)
 		imx8mm_tmu_probe_sel_all(tmu);
