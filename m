Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F6063987E
	for <lists+linux-pm@lfdr.de>; Sat, 26 Nov 2022 23:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKZWsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Nov 2022 17:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKZWsN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2022 17:48:13 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FDC140E4;
        Sat, 26 Nov 2022 14:48:11 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F4160851EB;
        Sat, 26 Nov 2022 23:48:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669502888;
        bh=/4gps0kinVP1b/8VC/KVOsvidIO6lCWPZCZ3PQorOPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXZdwitvsJXCdnWO5U5u1dHcuZTSPBjKfq/0pVmrHJDtYp8U4jj0Un7Rh9GBKwXDR
         cA3YdOBewk3v4LdhBMHrRC+SDhxugCSFbfKC4l2sE35ETbO7bnByOhTCmcNvQPf/Qk
         QQ0vhnGXbBl0tSTEcsw1L1P9R81jCif5IMchQOG9RBLtHSt7eN81e0e4moUy5ILbKq
         LlkPwVf9MWk0BCbpwqg7I5kB9cWtDtgjgZLIpGwk7/nBFs0qAfZUJjui7cT/LEHMDP
         6CR8s2Mw081hx5nvO77db4WuCFUPCeIz1tNZ/jgdpqGqRMFIPap/etCVcbJGkO1Grt
         QP+my53j4qnCQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
        Alice Guo <alice.guo@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: [PATCH 5/5] thermal/drivers/imx: Add support for loading calibration data from OCOTP
Date:   Sat, 26 Nov 2022 23:47:40 +0100
Message-Id: <20221126224740.311625-5-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221126224740.311625-1-marex@denx.de>
References: <20221126224740.311625-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The TMU TASR, TCALIVn, TRIM registers must be explicitly programmed with
calibration values in OCOTP. Add support for reading the OCOTP calibration
data and programming those into the TMU hardware.

The MX8MM/MX8MN TMUv1 uses only one OCOTP cell, while MX8MP TMUv2 uses 4,
the programming differs in each case.

Based on U-Boot commits:
70487ff386c ("imx8mm: Load fuse for TMU TCALIV and TASR")
ebb9aab318b ("imx: load calibration parameters from fuse for i.MX8MP")

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Li Jun <jun.li@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: devicetree@vger.kernel.org
To: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/thermal/imx8mm_thermal.c | 163 +++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e2c2673025a7a..da09c00ac663a 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -20,6 +21,22 @@
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
@@ -32,6 +49,25 @@
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
@@ -128,6 +164,129 @@ static void imx8mm_tmu_probe_sel_all(struct imx8mm_tmu *tmu)
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
+			"OCOTP nvmem cell length is %ld, must be 16.\n", len);
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
@@ -180,6 +339,10 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tmu);
 
+	ret = imx8mm_tmu_probe_set_calib(pdev, tmu);
+	if (ret)
+		goto disable_clk;
+
 	/* enable all the probes for V2 TMU */
 	if (tmu->socdata->version == TMU_VER2)
 		imx8mm_tmu_probe_sel_all(tmu);
-- 
2.35.1

