Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9D55CC23
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiF0NsH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 09:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbiF0Nrj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 09:47:39 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D16276;
        Mon, 27 Jun 2022 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l1b/kY+w6ocJyLqOmM3fFvnsEbyJyvpIJCaxuRyr2Pg=; b=qifHkXLquH/mXgjzggikJ18gI/
        6PyBhinc5gisvID2XlT6Jb3cCyED69n+ji53QqmLLcFayUtag202WYEmp+kqr8sPyQflDy5czw19r
        0pLC67xXRi9fuNmkqO1kZbPEmb3yHR1mNPUsIfersbgz6BmHe9y5QEx5cl3CC4B2Pj+Lny3xXzuUc
        AXZa19k2b/nCzsqdd7eeGsxcqHvytLi4QkpeeOsYtWq26YifpbVkWBtgddahwZPW7Bcv+vm/5Mf7u
        kbt7XHuxOyLbFIMs6p4ZvQJ67HhVVuE1JjD45x8LQcLIjriUQZP8x7TKfs3S0fYuXBHqPob8VqhGr
        NncrQ5ig==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o5oa7-006Cqx-Gn; Mon, 27 Jun 2022 15:15:11 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 3/3] thermal: qcom: tsens: Add data for MSM8909
Date:   Mon, 27 Jun 2022 15:14:15 +0200
Message-Id: <20220627131415.2868938-4-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
References: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MSM8909 SoC has 5 thermal sensors in a TSENS v0.1 block similar to
MSM8916, except that the bit offsets in the qfprom were changed.
Also, some fixed correction factors are needed as workaround because the
factory calibration apparently was not reliable enough.

Add the defines and calibration function for MSM8909 in the existing
tsens-v0_1.c driver to make the thermal sensors work on MSM8909.
The changes are derived from the original msm-3.18 kernel [1] from
Qualcomm but cleaned up and adapted to the driver in mainline.

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.UM.7.7.c26-08600-8x09.0/drivers/thermal/msm-tsens.c

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 119 +++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c      |   3 +
 drivers/thermal/qcom/tsens.h      |   2 +-
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index f136cb350238..e17c4f9d9aa5 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -15,6 +15,48 @@
 #define TM_Sn_STATUS_OFF			0x0030
 #define TM_TRDY_OFF				0x005c
 
+/* eeprom layout data for 8909 */
+#define MSM8909_CAL_SEL_MASK	0x00070000
+#define MSM8909_CAL_SEL_SHIFT	16
+
+#define MSM8909_BASE0_MASK	0x000000ff
+#define MSM8909_BASE1_MASK	0x0000ff00
+#define MSM8909_BASE0_SHIFT	0
+#define MSM8909_BASE1_SHIFT	8
+
+#define MSM8909_S0_P1_MASK	0x0000003f
+#define MSM8909_S1_P1_MASK	0x0003f000
+#define MSM8909_S2_P1_MASK	0x3f000000
+#define MSM8909_S3_P1_MASK	0x000003f0
+#define MSM8909_S4_P1_MASK	0x003f0000
+
+#define MSM8909_S0_P2_MASK	0x00000fc0
+#define MSM8909_S1_P2_MASK	0x00fc0000
+#define MSM8909_S2_P2_MASK_0_1	0xc0000000
+#define MSM8909_S2_P2_MASK_2_5	0x0000000f
+#define MSM8909_S3_P2_MASK	0x0000fc00
+#define MSM8909_S4_P2_MASK	0x0fc00000
+
+#define MSM8909_S0_P1_SHIFT	0
+#define MSM8909_S1_P1_SHIFT	12
+#define MSM8909_S2_P1_SHIFT	24
+#define MSM8909_S3_P1_SHIFT	4
+#define MSM8909_S4_P1_SHIFT	16
+
+#define MSM8909_S0_P2_SHIFT	6
+#define MSM8909_S1_P2_SHIFT	18
+#define MSM8909_S2_P2_SHIFT_0_1	30
+#define MSM8909_S2_P2_SHIFT_2_5	2
+#define MSM8909_S3_P2_SHIFT	10
+#define MSM8909_S4_P2_SHIFT	22
+
+#define MSM8909_D30_WA_S1	10
+#define MSM8909_D30_WA_S3	9
+#define MSM8909_D30_WA_S4	8
+#define MSM8909_D120_WA_S1	6
+#define MSM8909_D120_WA_S3	9
+#define MSM8909_D120_WA_S4	10
+
 /* eeprom layout data for 8916 */
 #define MSM8916_BASE0_MASK	0x0000007f
 #define MSM8916_BASE1_MASK	0xfe000000
@@ -223,6 +265,68 @@
 #define MDM9607_CAL_SEL_MASK	0x00700000
 #define MDM9607_CAL_SEL_SHIFT	20
 
+static int calibrate_8909(struct tsens_priv *priv)
+{
+	u32 *qfprom_cdata, *qfprom_csel;
+	int base0, base1, mode, i;
+	u32 p1[5], p2[5];
+
+	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
+	if (IS_ERR(qfprom_cdata))
+		return PTR_ERR(qfprom_cdata);
+
+	qfprom_csel = (u32 *)qfprom_read(priv->dev, "calib_sel");
+	if (IS_ERR(qfprom_csel)) {
+		kfree(qfprom_cdata);
+		return PTR_ERR(qfprom_csel);
+	}
+
+	mode = (qfprom_csel[0] & MSM8909_CAL_SEL_MASK) >> MSM8909_CAL_SEL_SHIFT;
+	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
+
+	switch (mode) {
+	case TWO_PT_CALIB:
+		base1 = (qfprom_csel[0] & MSM8909_BASE1_MASK) >> MSM8909_BASE1_SHIFT;
+		p2[0] = (qfprom_cdata[0] & MSM8909_S0_P2_MASK) >> MSM8909_S0_P2_SHIFT;
+		p2[1] = (qfprom_cdata[0] & MSM8909_S1_P2_MASK) >> MSM8909_S1_P2_SHIFT;
+		p2[2] = (qfprom_cdata[0] & MSM8909_S2_P2_MASK_0_1) >> MSM8909_S2_P2_SHIFT_0_1;
+		p2[2] |= (qfprom_cdata[1] & MSM8909_S2_P2_MASK_2_5) << MSM8909_S2_P2_SHIFT_2_5;
+		p2[3] = (qfprom_cdata[1] & MSM8909_S3_P2_MASK) >> MSM8909_S3_P2_SHIFT;
+		p2[4] = (qfprom_cdata[1] & MSM8909_S4_P2_MASK) >> MSM8909_S4_P2_SHIFT;
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] = ((base1 + p2[i]) << 2);
+		p2[1] -= MSM8909_D120_WA_S1;
+		p2[3] -= MSM8909_D120_WA_S3;
+		p2[4] -= MSM8909_D120_WA_S4;
+		fallthrough;
+	case ONE_PT_CALIB2:
+		base0 = (qfprom_csel[0] & MSM8909_BASE0_MASK) >> MSM8909_BASE0_SHIFT;
+		p1[0] = (qfprom_cdata[0] & MSM8909_S0_P1_MASK) >> MSM8909_S0_P1_SHIFT;
+		p1[1] = (qfprom_cdata[0] & MSM8909_S1_P1_MASK) >> MSM8909_S1_P1_SHIFT;
+		p1[2] = (qfprom_cdata[0] & MSM8909_S2_P1_MASK) >> MSM8909_S2_P1_SHIFT;
+		p1[3] = (qfprom_cdata[1] & MSM8909_S3_P1_MASK) >> MSM8909_S3_P1_SHIFT;
+		p1[4] = (qfprom_cdata[1] & MSM8909_S4_P1_MASK) >> MSM8909_S4_P1_SHIFT;
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] = (((base0) + p1[i]) << 2);
+		p1[1] -= MSM8909_D30_WA_S1;
+		p1[3] -= MSM8909_D30_WA_S3;
+		p1[4] -= MSM8909_D30_WA_S4;
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
+	kfree(qfprom_csel);
+
+	return 0;
+}
+
 static int calibrate_8916(struct tsens_priv *priv)
 {
 	int base0 = 0, base1 = 0, i;
@@ -534,7 +638,7 @@ static int calibrate_9607(struct tsens_priv *priv)
 	return 0;
 }
 
-/* v0.1: 8916, 8939, 8974, 9607 */
+/* v0.1: 8909, 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
@@ -580,6 +684,19 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
+static const struct tsens_ops ops_8909 = {
+	.init		= init_common,
+	.calibrate	= calibrate_8909,
+	.get_temp	= get_temp_common,
+};
+
+struct tsens_plat_data data_8909 = {
+	.num_sensors	= 5,
+	.ops		= &ops_8909,
+	.feat		= &tsens_v0_1_feat,
+	.fields		= tsens_v0_1_regfields,
+};
+
 static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 7963ee33bf75..cb7bbaa72d89 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -973,6 +973,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
+	}, {
+		.compatible = "qcom,msm8909-tsens",
+		.data = &data_8909,
 	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 1471a2c00f15..752d4718f26e 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -587,7 +587,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
 extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
+extern struct tsens_plat_data data_8909, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8976;
-- 
2.30.2

