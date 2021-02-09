Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9DC315760
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 21:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhBIUBG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 15:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhBITym (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 14:54:42 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1297C061356;
        Tue,  9 Feb 2021 11:54:01 -0800 (PST)
Received: from localhost.localdomain (abac187.neoplus.adsl.tpnet.pl [83.6.166.187])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 1F7C61FA91;
        Tue,  9 Feb 2021 20:53:57 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/2] thermal: qcom: tsens-v1: Add support for MSM8994 TSENS
Date:   Tue,  9 Feb 2021 20:53:45 +0100
Message-Id: <20210209195346.457803-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSM8994, despite being heavily based on MSM8974, uses the
1.2 version of TSENS. Also, 8994 being 8994, it has a custom
way of calculating the slope.

Also tested on 8976 (by a person who didn't want to be named)
to make sure the 11->16 max_sensors changes didn't break anything.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 drivers/thermal/qcom/tsens-v1.c               | 291 +++++++++++++++++-
 drivers/thermal/qcom/tsens.c                  |   3 +
 drivers/thermal/qcom/tsens.h                  |   2 +-
 4 files changed, 284 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 95462e071ab4..f194e914a62e 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -31,6 +31,7 @@ properties:
         items:
           - enum:
               - qcom,msm8976-tsens
+              - qcom,msm8994-tsens
               - qcom,qcs404-tsens
           - const: qcom,tsens-v1
 
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 3c19a3800c6d..2127b6edd1ae 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -142,6 +142,99 @@
 #define CAL_SEL_MASK	7
 #define CAL_SEL_SHIFT	0
 
+/* eeprom layout data for 8994 */
+#define MSM8994_BASE0_MASK	0x3ff
+#define MSM8994_BASE1_MASK	0xffc00
+#define MSM8994_BASE0_SHIFT	0
+#define MSM8994_BASE1_SHIFT	10
+
+#define MSM8994_S0_MASK	0xf00000
+#define MSM8994_S1_MASK	0xf000000
+#define MSM8994_S2_MASK	0xf0000000
+#define MSM8994_S3_MASK	0xf
+#define MSM8994_S4_MASK	0xf0
+#define MSM8994_S5_MASK	0xf00
+#define MSM8994_S6_MASK	0xf000
+#define MSM8994_S7_MASK	0xf0000
+#define MSM8994_S8_MASK	0xf00000
+#define MSM8994_S9_MASK	0xf000000
+#define MSM8994_S10_MASK	0xf0000000
+#define MSM8994_S11_MASK	0xf
+#define MSM8994_S12_MASK	0xf0
+#define MSM8994_S13_MASK	0xf00
+#define MSM8994_S14_MASK	0xf000
+#define MSM8994_S15_MASK	0xf0000
+
+#define MSM8994_S0_SHIFT	20
+#define MSM8994_S1_SHIFT	24
+#define MSM8994_S2_SHIFT	28
+#define MSM8994_S3_SHIFT	0
+#define MSM8994_S4_SHIFT	4
+#define MSM8994_S5_SHIFT	8
+#define MSM8994_S6_SHIFT	12
+#define MSM8994_S7_SHIFT	16
+#define MSM8994_S8_SHIFT	20
+#define MSM8994_S9_SHIFT	24
+#define MSM8994_S10_SHIFT	28
+#define MSM8994_S11_SHIFT	0
+#define MSM8994_S12_SHIFT	4
+#define MSM8994_S13_SHIFT	8
+#define MSM8994_S14_SHIFT	12
+#define MSM8994_S15_SHIFT	16
+
+#define MSM8994_CAL_SEL_MASK	0x700000
+#define MSM8994_CAL_SEL_SHIFT	20
+
+#define MSM8994_BASE0_REDUN_MASK	0x7fe00000
+#define MSM8994_BASE1_BIT0_REDUN_MASK	0x80000000
+#define MSM8994_BASE1_BIT1_9_REDUN_MASK	0x1ff
+#define MSM8994_BASE0_REDUN_SHIFT	21
+#define MSM8994_BASE1_BIT0_REDUN_SHIFT_COMPUTE	31
+
+#define MSM8994_S0_REDUN_MASK	0x1e00
+#define MSM8994_S1_REDUN_MASK	0x1e000
+#define MSM8994_S2_REDUN_MASK	0x1e0000
+#define MSM8994_S3_REDUN_MASK	0x1e00000
+#define MSM8994_S4_REDUN_MASK	0x1e000000
+#define MSM8994_S5_REDUN_MASK_BIT0_2	0xe0000000
+#define MSM8994_S5_REDUN_MASK_BIT3	0x800000
+#define MSM8994_S6_REDUN_MASK	0xf000000
+#define MSM8994_S7_REDUN_MASK	0xf0000000
+#define MSM8994_S8_REDUN_MASK	0xf
+#define MSM8994_S9_REDUN_MASK	0xf0
+#define MSM8994_S10_REDUN_MASK	0xf00
+#define MSM8994_S11_REDUN_MASK	0xf000
+#define MSM8994_S12_REDUN_MASK	0xf0000
+#define MSM8994_S13_REDUN_MASK	0xf00000
+#define MSM8994_S14_REDUN_MASK	0xf000000
+#define MSM8994_S15_REDUN_MASK	0xf0000000
+
+#define MSM8994_S0_REDUN_SHIFT	9
+#define MSM8994_S1_REDUN_SHIFT	13
+#define MSM8994_S2_REDUN_SHIFT	17
+#define MSM8994_S3_REDUN_SHIFT	21
+#define MSM8994_S4_REDUN_SHIFT	25
+#define MSM8994_S5_REDUN_SHIFT_BIT0_2	29
+#define MSM8994_S5_REDUN_SHIFT_BIT3	23
+#define MSM8994_S6_REDUN_SHIFT	24
+#define MSM8994_S7_REDUN_SHIFT	28
+#define MSM8994_S8_REDUN_SHIFT	0
+#define MSM8994_S9_REDUN_SHIFT	4
+#define MSM8994_S10_REDUN_SHIFT	8
+#define MSM8994_S11_REDUN_SHIFT	12
+#define MSM8994_S12_REDUN_SHIFT	16
+#define MSM8994_S13_REDUN_SHIFT	20
+#define MSM8994_S14_REDUN_SHIFT	24
+#define MSM8994_S15_REDUN_SHIFT	28
+
+#define MSM8994_REDUN_SEL_MASK		0x7
+#define MSM8994_CAL_SEL_REDUN_MASK	0xe0000000
+#define MSM8994_CAL_SEL_REDUN_SHIFT	29
+
+#define BKP_SEL			0x3
+#define BKP_REDUN_SEL		0xe0000000
+#define BKP_REDUN_SHIFT		29
+
 static void compute_intercept_slope_8976(struct tsens_priv *priv,
 			      u32 *p1, u32 *p2, u32 mode)
 {
@@ -166,6 +259,37 @@ static void compute_intercept_slope_8976(struct tsens_priv *priv,
 	}
 }
 
+static void compute_intercept_slope_8994(struct tsens_priv *priv,
+			      u32 *base0, u32 *base1, u32 *p, u32 mode)
+{
+	int adc_code_of_tempx, i, num, den;
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		dev_dbg(priv->dev,
+			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
+			__func__, i, base0[i], base1[i]);
+
+		priv->sensor[i].slope = SLOPE_DEFAULT;
+		if (mode == TWO_PT_CALIB) {
+			/*
+			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
+			 *	temp_120_degc - temp_30_degc (x2 - x1)
+			 */
+			num = base1[i] - base0[i];
+			num *= SLOPE_FACTOR;
+			den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
+			priv->sensor[i].slope = num / den;
+		}
+
+		adc_code_of_tempx = base0[i] + p[i];
+
+		priv->sensor[i].offset = (adc_code_of_tempx * SLOPE_FACTOR) -
+				(CAL_DEGC_PT1 *	priv->sensor[i].slope);
+		dev_dbg(priv->dev, "%s: offset:%d\n", __func__,
+			priv->sensor[i].offset);
+	}
+}
+
 static int calibrate_v1(struct tsens_priv *priv)
 {
 	u32 base0 = 0, base1 = 0;
@@ -297,14 +421,143 @@ static int calibrate_8976(struct tsens_priv *priv)
 	return 0;
 }
 
-/* v1.x: msm8956,8976,qcs404,405 */
+static int calibrate_8994(struct tsens_priv *priv)
+{
+	int base0[16] = { 0 }, base1[16] = { 0 }, i;
+	u32 p[16];
+	int mode = 0;
+	u32 *calib0, *calib1, *calib2, *calib_mode, *calib_rsel;
+	u32 calib_redun_sel;
+
+	/* 0x40d0-0x40dc */
+	calib0 = (u32 *)qfprom_read(priv->dev, "calib");
+	if (IS_ERR(calib0))
+		return PTR_ERR(calib0);
+
+	dev_dbg(priv->dev, "%s: calib0: [0] = %i, [1] = %i, [2] = %i\n",
+		__func__, calib0[0], calib0[1], calib0[2]);
+
+	/* 0x41c0-0x41c8 */
+	calib1 = (u32 *)qfprom_read(priv->dev, "calib_redun1_2");
+	if (IS_ERR(calib1))
+		return PTR_ERR(calib1);
+
+	dev_dbg(priv->dev, "%s: calib1: [0] = %i, [1] = %i\n",
+		__func__, calib1[0], calib1[1]);
+
+	/* 0x41cc-0x41d0 */
+	calib2 = (u32 *)qfprom_read(priv->dev, "calib_redun3");
+	if (IS_ERR(calib2))
+		return PTR_ERR(calib2);
+
+	dev_dbg(priv->dev, "%s: calib2: [0] = %i\n", __func__, calib2[0]);
+
+	/* 0x4440-0x4448 */
+	calib_mode = (u32 *)qfprom_read(priv->dev, "calib_redun4_5");
+	if (IS_ERR(calib_mode))
+		return PTR_ERR(calib_mode);
+
+	dev_dbg(priv->dev, "%s: calib_mode: [0] = %i, [1] = %i\n",
+		__func__, calib1[0], calib1[1]);
+
+	/* 0x4464-0x4468 */
+	calib_rsel = (u32 *)qfprom_read(priv->dev, "calib_rsel");
+	if (IS_ERR(calib_mode))
+		return PTR_ERR(calib_mode);
+
+	dev_dbg(priv->dev, "%s: calib_rsel: [0] = %i\n", __func__, calib_rsel[0]);
+
+	calib_redun_sel =  calib_rsel[0] & MSM8994_CAL_SEL_REDUN_MASK;
+	calib_redun_sel >>= MSM8994_CAL_SEL_REDUN_SHIFT;
+
+	if (calib_redun_sel == BKP_SEL) {
+		dev_dbg(priv->dev, "%s: Calibrating in REDUN mode, calib_redun_sel = %i",
+			__func__, calib_redun_sel);
+		mode = calib_mode[1] & MSM8994_REDUN_SEL_MASK;
+
+		if (mode == TWO_PT_CALIB) {
+			dev_dbg(priv->dev, "%s: REDUN TWO_PT mode, mode = %i", __func__, mode);
+			base0[0] = (calib1[0] & MSM8994_BASE0_REDUN_MASK) >> MSM8994_BASE0_REDUN_SHIFT;
+			base1[0] = (calib1[0] & MSM8994_BASE1_BIT0_REDUN_MASK) >> MSM8994_BASE1_BIT0_REDUN_SHIFT_COMPUTE;
+			base1[0] |= calib1[1] & MSM8994_BASE1_BIT1_9_REDUN_MASK;
+			p[0] = (calib1[1] & MSM8994_S0_REDUN_MASK) >> MSM8994_S0_REDUN_SHIFT;
+			p[1] = (calib1[1] & MSM8994_S1_REDUN_MASK) >> MSM8994_S1_REDUN_SHIFT;
+			p[2] = (calib1[1] & MSM8994_S2_REDUN_MASK) >> MSM8994_S2_REDUN_SHIFT;
+			p[3] = (calib1[1] & MSM8994_S3_REDUN_MASK) >> MSM8994_S3_REDUN_SHIFT;
+			p[4] = (calib1[1] & MSM8994_S4_REDUN_MASK) >> MSM8994_S4_REDUN_SHIFT;
+			p[5] = (calib1[1] & MSM8994_S5_REDUN_MASK_BIT0_2) >> MSM8994_S5_REDUN_SHIFT_BIT0_2;
+			p[5] |= (calib2[0] & MSM8994_S5_REDUN_MASK_BIT3) >> MSM8994_S5_REDUN_SHIFT_BIT3;
+			p[6] = (calib2[0] & MSM8994_S6_REDUN_MASK) >> MSM8994_S6_REDUN_SHIFT;
+			p[7] = (calib2[0] & MSM8994_S7_REDUN_MASK) >> MSM8994_S7_REDUN_SHIFT;
+			p[8] = (calib2[0] & MSM8994_S8_REDUN_MASK) >> MSM8994_S8_REDUN_SHIFT;
+			p[9] = (calib2[0] & MSM8994_S9_REDUN_MASK) >> MSM8994_S9_REDUN_SHIFT;
+			p[10] = (calib2[0] & MSM8994_S10_REDUN_MASK) >> MSM8994_S10_REDUN_SHIFT;
+			p[11] = (calib2[0] & MSM8994_S11_REDUN_MASK) >> MSM8994_S11_REDUN_SHIFT;
+			p[12] = (calib2[0] & MSM8994_S12_REDUN_MASK) >> MSM8994_S12_REDUN_SHIFT;
+			p[13] = (calib2[0] & MSM8994_S13_REDUN_MASK) >> MSM8994_S13_REDUN_SHIFT;
+			p[14] = (calib2[0] & MSM8994_S14_REDUN_MASK) >> MSM8994_S14_REDUN_SHIFT;
+			p[15] = (calib2[0] & MSM8994_S15_REDUN_MASK) >> MSM8994_S15_REDUN_SHIFT;
+		} else {
+			dev_dbg(priv->dev, "%s: REDUN NON-TWO_PT mode, mode = %i",
+			__func__, mode);
+			for (i = 0; i < 16; i++)
+				p[i] = 532;
+		}
+	} else {
+		dev_dbg(priv->dev, "%s: Calibrating in NOT-REDUN mode, calib_redun_sel = %i",
+			__func__, calib_redun_sel);
+		mode = (calib0[2] & MSM8994_CAL_SEL_MASK) >> MSM8994_CAL_SEL_SHIFT;
+
+		if (mode == TWO_PT_CALIB) {
+			dev_dbg(priv->dev, "%s: NOT-REDUN TWO_PT mode, mode = %i", __func__, mode);
+			base0[0] = (calib0[0] & MSM8994_BASE0_MASK) >> MSM8994_BASE0_SHIFT;
+			base1[0] = (calib0[0] & MSM8994_BASE1_MASK) >> MSM8994_BASE1_SHIFT;
+			p[0] = (calib0[0] & MSM8994_S0_MASK) >> MSM8994_S0_SHIFT;
+			p[1] = (calib0[0] & MSM8994_S1_MASK) >> MSM8994_S1_SHIFT;
+			p[2] = (calib0[1] & MSM8994_S2_MASK) >> MSM8994_S2_SHIFT;
+			p[3] = (calib0[1] & MSM8994_S3_MASK) >> MSM8994_S3_SHIFT;
+			p[4] = (calib0[1] & MSM8994_S4_MASK) >> MSM8994_S4_SHIFT;
+			p[5] = (calib0[1] & MSM8994_S5_MASK) >> MSM8994_S5_SHIFT;
+			p[6] = (calib0[1] & MSM8994_S6_MASK) >> MSM8994_S6_SHIFT;
+			p[7] = (calib0[1] & MSM8994_S7_MASK) >> MSM8994_S7_SHIFT;
+			p[8] = (calib0[1] & MSM8994_S8_MASK) >> MSM8994_S8_SHIFT;
+			p[9] = (calib0[1] & MSM8994_S9_MASK) >> MSM8994_S9_SHIFT;
+			p[10] = (calib0[1] & MSM8994_S10_MASK) >> MSM8994_S10_SHIFT;
+			p[11] = (calib0[2] & MSM8994_S11_MASK) >> MSM8994_S11_SHIFT;
+			p[12] = (calib0[2] & MSM8994_S12_MASK) >> MSM8994_S12_SHIFT;
+			p[13] = (calib0[2] & MSM8994_S13_MASK) >> MSM8994_S13_SHIFT;
+			p[14] = (calib0[2] & MSM8994_S14_MASK) >> MSM8994_S14_SHIFT;
+			p[15] = (calib0[2] & MSM8994_S15_MASK) >> MSM8994_S15_SHIFT;
+		} else {
+			dev_dbg(priv->dev, "%s: NOT-REDUN NON-TWO_PT mode, mode = %i", __func__, mode);
+			for (i = 0; i < 16; i++)
+				p[i] = 532;
+		}
+	}
+
+	/* 8994 does the slope calc a bit differently than others. */
+	for (i = 1; i < 16; i++) {
+		base0[i] = base0[0];
+		base1[i] = base1[0];
+	}
+
+	compute_intercept_slope_8994(priv, base0, base1, p, mode);
+	kfree(calib0);
+	kfree(calib1);
+	kfree(calib2);
+	kfree(calib_mode);
+
+	return 0;
+}
+
+/* v1.x: msm8956/8976, msm8994 (v1.2), qcs404/qcs405 */
 
 static struct tsens_features tsens_v1_feat = {
 	.ver_major	= VER_1_X,
 	.crit_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
-	.max_sensors	= 11,
+	.max_sensors	= 16,
 };
 
 static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
@@ -323,12 +576,12 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	[INT_EN]     = REG_FIELD(TM_INT_EN_OFF, 0, 0),
 
 	/* UPPER/LOWER TEMPERATURE THRESHOLDS */
-	REG_FIELD_FOR_EACH_SENSOR11(LOW_THRESH,    TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF,  0,  9),
-	REG_FIELD_FOR_EACH_SENSOR11(UP_THRESH,     TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 10, 19),
+	REG_FIELD_FOR_EACH_SENSOR16(LOW_THRESH,    TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF,  0,  9),
+	REG_FIELD_FOR_EACH_SENSOR16(UP_THRESH,     TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 10, 19),
 
 	/* UPPER/LOWER INTERRUPTS [CLEAR/STATUS] */
-	REG_FIELD_FOR_EACH_SENSOR11(LOW_INT_CLEAR, TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 20, 20),
-	REG_FIELD_FOR_EACH_SENSOR11(UP_INT_CLEAR,  TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 21, 21),
+	REG_FIELD_FOR_EACH_SENSOR16(LOW_INT_CLEAR, TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 20, 20),
+	REG_FIELD_FOR_EACH_SENSOR16(UP_INT_CLEAR,  TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 21, 21),
 	[LOW_INT_STATUS_0] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  0,  0),
 	[LOW_INT_STATUS_1] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  1,  1),
 	[LOW_INT_STATUS_2] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  2,  2),
@@ -349,14 +602,14 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	/* NO CRITICAL INTERRUPT SUPPORT on v1 */
 
 	/* Sn_STATUS */
-	REG_FIELD_FOR_EACH_SENSOR11(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
-	REG_FIELD_FOR_EACH_SENSOR11(VALID,        TM_Sn_STATUS_OFF, 14, 14),
+	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
+	REG_FIELD_FOR_EACH_SENSOR16(VALID,        TM_Sn_STATUS_OFF, 14, 14),
 	/* xxx_STATUS bits: 1 == threshold violated */
-	REG_FIELD_FOR_EACH_SENSOR11(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
-	REG_FIELD_FOR_EACH_SENSOR11(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
-	REG_FIELD_FOR_EACH_SENSOR11(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
+	REG_FIELD_FOR_EACH_SENSOR16(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
+	REG_FIELD_FOR_EACH_SENSOR16(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
+	REG_FIELD_FOR_EACH_SENSOR16(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
 	/* No CRITICAL field on v1.x */
-	REG_FIELD_FOR_EACH_SENSOR11(MAX_STATUS,   TM_Sn_STATUS_OFF, 13, 13),
+	REG_FIELD_FOR_EACH_SENSOR16(MAX_STATUS,   TM_Sn_STATUS_OFF, 13, 13),
 
 	/* TRDY: 1=ready, 0=in progress */
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
@@ -388,3 +641,17 @@ struct tsens_plat_data data_8976 = {
 	.feat		= &tsens_v1_feat,
 	.fields		= tsens_v1_regfields,
 };
+
+static const struct tsens_ops ops_8994 = {
+	.init		= init_common,
+	.calibrate	= calibrate_8994,
+	.get_temp	= get_temp_tsens_valid,
+};
+
+struct tsens_plat_data data_8994 = {
+	.num_sensors	= 16,
+	.ops		= &ops_8994,
+	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
+	.feat		= &tsens_v1_feat,
+	.fields	= tsens_v1_regfields,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a687b80..96d17afe3460 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -903,6 +903,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8974-tsens",
 		.data = &data_8974,
+	}, {
+		.compatible = "qcom,msm8994-tsens",
+		.data = &data_8994,
 	}, {
 		.compatible = "qcom,msm8976-tsens",
 		.data = &data_8976,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index f40b625f897e..dfbff7f6442c 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -588,7 +588,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8916, data_8939, data_8974;
 
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8976;
+extern struct tsens_plat_data data_tsens_v1, data_8976, data_8994;
 
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_tsens_v2;
-- 
2.30.0

