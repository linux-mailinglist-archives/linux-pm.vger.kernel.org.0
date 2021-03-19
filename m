Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E24D342870
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 23:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCSWIa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhCSWIM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 18:08:12 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA9C06175F
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 15:08:11 -0700 (PDT)
Received: from localhost.localdomain (abac242.neoplus.adsl.tpnet.pl [83.6.166.242])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id B75B21F928;
        Fri, 19 Mar 2021 23:08:08 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
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
Subject: [RESEND PATCH v4 2/2] thermal: qcom: tsens-v0_1: Add support for MDM9607
Date:   Fri, 19 Mar 2021 23:08:02 +0100
Message-Id: <20210319220802.198215-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210319220802.198215-1-konrad.dybcio@somainline.org>
References: <20210319220802.198215-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MDM9607 TSENS IP is very similar to the one of MSM8916, with
minor adjustments to various tuning values.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
v4: Remove unneeded braces and newline

 drivers/thermal/qcom/tsens-v0_1.c | 98 ++++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c      |  3 +
 drivers/thermal/qcom/tsens.h      |  2 +-
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 4ffa2e2c0145..f136cb350238 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -190,6 +190,39 @@
 
 #define BIT_APPEND		0x3
 
+/* eeprom layout data for mdm9607 */
+#define MDM9607_BASE0_MASK	0x000000ff
+#define MDM9607_BASE1_MASK	0x000ff000
+#define MDM9607_BASE0_SHIFT	0
+#define MDM9607_BASE1_SHIFT	12
+
+#define MDM9607_S0_P1_MASK	0x00003f00
+#define MDM9607_S1_P1_MASK	0x03f00000
+#define MDM9607_S2_P1_MASK	0x0000003f
+#define MDM9607_S3_P1_MASK	0x0003f000
+#define MDM9607_S4_P1_MASK	0x0000003f
+
+#define MDM9607_S0_P2_MASK	0x000fc000
+#define MDM9607_S1_P2_MASK	0xfc000000
+#define MDM9607_S2_P2_MASK	0x00000fc0
+#define MDM9607_S3_P2_MASK	0x00fc0000
+#define MDM9607_S4_P2_MASK	0x00000fc0
+
+#define MDM9607_S0_P1_SHIFT	8
+#define MDM9607_S1_P1_SHIFT	20
+#define MDM9607_S2_P1_SHIFT	0
+#define MDM9607_S3_P1_SHIFT	12
+#define MDM9607_S4_P1_SHIFT	0
+
+#define MDM9607_S0_P2_SHIFT	14
+#define MDM9607_S1_P2_SHIFT	26
+#define MDM9607_S2_P2_SHIFT	6
+#define MDM9607_S3_P2_SHIFT	18
+#define MDM9607_S4_P2_SHIFT	6
+
+#define MDM9607_CAL_SEL_MASK	0x00700000
+#define MDM9607_CAL_SEL_SHIFT	20
+
 static int calibrate_8916(struct tsens_priv *priv)
 {
 	int base0 = 0, base1 = 0, i;
@@ -452,7 +485,56 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
-/* v0.1: 8916, 8939, 8974 */
+static int calibrate_9607(struct tsens_priv *priv)
+{
+	int base, i;
+	u32 p1[5], p2[5];
+	int mode = 0;
+	u32 *qfprom_cdata;
+
+	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
+	if (IS_ERR(qfprom_cdata))
+		return PTR_ERR(qfprom_cdata);
+
+	mode = (qfprom_cdata[2] & MDM9607_CAL_SEL_MASK) >> MDM9607_CAL_SEL_SHIFT;
+	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
+
+	switch (mode) {
+	case TWO_PT_CALIB:
+		base = (qfprom_cdata[2] & MDM9607_BASE1_MASK) >> MDM9607_BASE1_SHIFT;
+		p2[0] = (qfprom_cdata[0] & MDM9607_S0_P2_MASK) >> MDM9607_S0_P2_SHIFT;
+		p2[1] = (qfprom_cdata[0] & MDM9607_S1_P2_MASK) >> MDM9607_S1_P2_SHIFT;
+		p2[2] = (qfprom_cdata[1] & MDM9607_S2_P2_MASK) >> MDM9607_S2_P2_SHIFT;
+		p2[3] = (qfprom_cdata[1] & MDM9607_S3_P2_MASK) >> MDM9607_S3_P2_SHIFT;
+		p2[4] = (qfprom_cdata[2] & MDM9607_S4_P2_MASK) >> MDM9607_S4_P2_SHIFT;
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] = ((base + p2[i]) << 2);
+		fallthrough;
+	case ONE_PT_CALIB2:
+		base = (qfprom_cdata[0] & MDM9607_BASE0_MASK);
+		p1[0] = (qfprom_cdata[0] & MDM9607_S0_P1_MASK) >> MDM9607_S0_P1_SHIFT;
+		p1[1] = (qfprom_cdata[0] & MDM9607_S1_P1_MASK) >> MDM9607_S1_P1_SHIFT;
+		p1[2] = (qfprom_cdata[1] & MDM9607_S2_P1_MASK) >> MDM9607_S2_P1_SHIFT;
+		p1[3] = (qfprom_cdata[1] & MDM9607_S3_P1_MASK) >> MDM9607_S3_P1_SHIFT;
+		p1[4] = (qfprom_cdata[2] & MDM9607_S4_P1_MASK) >> MDM9607_S4_P1_SHIFT;
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] = ((base + p1[i]) << 2);
+		break;
+	default:
+		for (i = 0; i < priv->num_sensors; i++) {
+			p1[i] = 500;
+			p2[i] = 780;
+		}
+		break;
+	}
+
+	compute_intercept_slope(priv, p1, p2, mode);
+	kfree(qfprom_cdata);
+
+	return 0;
+}
+
+/* v0.1: 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
@@ -540,3 +622,17 @@ struct tsens_plat_data data_8974 = {
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
 };
+
+static const struct tsens_ops ops_9607 = {
+	.init		= init_common,
+	.calibrate	= calibrate_9607,
+	.get_temp	= get_temp_common,
+};
+
+struct tsens_plat_data data_9607 = {
+	.num_sensors	= 5,
+	.ops		= &ops_9607,
+	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4 },
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a687b80..51c36b9e8e69 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -895,6 +895,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,mdm9607-tsens",
+		.data = &data_9607,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index f40b625f897e..cba64c33b4f9 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -585,7 +585,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
 extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern struct tsens_plat_data data_8916, data_8939, data_8974;
+extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8976;
-- 
2.31.0

