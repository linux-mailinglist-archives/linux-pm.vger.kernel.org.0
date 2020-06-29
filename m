Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A2320D87A
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgF2Tj3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 15:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbgF2Thm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:37:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA8C02F011
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 07:49:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc15so960707pjb.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z33RbBxzw0A0qZX3oGdosGCurOgJdFD5wQlatBMRabs=;
        b=FiCRpvdu6oVdhlPw73k6WrVfElEVkfCsVSafP7hbBreg/JofLqZGds+X09msWPfWq9
         oDNwi9FUPGhez425eYmVaQx/bu73pfN0YUT9P1k5voSgZrx+Bgp5JRep5jjpQ9uBEMgd
         Gc82bYgrLOiiD+/Kx8YXaITc76WlN2zZvX64ws1RVnadez20AA2MwLR1/d0TUoclAFE2
         sWKPmsgi08MvtTn4Y5cdqmyt/aoOVUVpwtW4DWRlNspsAYLP9zoa7VC79KJyaFIZ3xsp
         9Reh+wsYCiKpFNYt5sGRIfDhV9Q4JRb1+EiqC+ctt+RXSLbaWHaVVOLHuivrO4W7Ox1e
         /aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z33RbBxzw0A0qZX3oGdosGCurOgJdFD5wQlatBMRabs=;
        b=GBdiO5Y8OOi+9BMRyxWRYzwxCdFffF4xBwumzKZ8ZNHAJts5pGZZXxvWBaaW84UZuC
         DgT0O/7EnjLqNH7n2fmBZSdwgl6PdfSO5Tq0M1LRExgGK9iks1+dXP6pkF4WuKjT+ALx
         HqeP2438Spv7qVZ5C51mAs1L1JxLrp9vfHpdnvAqqlYLQNjBD0GddtwiSJ3Q4biLSiaF
         Flzgrwun6PTVKfPz+w0jG6dGjW+/N3I9vxf4jXWfznbpKVJ/6EFoq+7oPMU+q1tG69o1
         w9vl8mTOeFqn15to5iNOJH71FwCJLFTaYOYHV/epn5IoJyif37FjW0aYmLUCkcWYwLhI
         esQA==
X-Gm-Message-State: AOAM533IquFwc7Dk5F+UfRFYOM75JQkU9Wmlnv2FSSvuaQA6MDa794LH
        7fxebbmcg4USMQZ+RyIYR79t3w==
X-Google-Smtp-Source: ABdhPJww+5FRdP2kBDO4UXXfN/MfuhDeECw/F5M066X5Otod5dkCTqrBJhAWUFXYfZn6JC9VWzlbvg==
X-Received: by 2002:a17:90a:74ce:: with SMTP id p14mr16612664pjl.133.1593442198677;
        Mon, 29 Jun 2020 07:49:58 -0700 (PDT)
Received: from localhost.localdomain ([80.251.214.228])
        by smtp.gmail.com with ESMTPSA id bg6sm191614pjb.51.2020.06.29.07.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:49:58 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] thermal: qcom: tsens-v0_1: Add support for MSM8939
Date:   Mon, 29 Jun 2020 22:49:26 +0800
Message-Id: <20200629144926.665-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629144926.665-1-shawn.guo@linaro.org>
References: <20200629144926.665-1-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The TSENS integrated on MSM8939 is a v0_1 device with 10 sensors.
Different from its predecessor MSM8916, where 'calib_sel' bits sit in
separate qfprom word, MSM8939 has 'cailb' and 'calib_sel' bits mixed and
spread on discrete offsets.  That's why all qfprom bits are read as one
go and later mapped to calibration data for MSM8939.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 144 +++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c      |   3 +
 drivers/thermal/qcom/tsens.h      |   2 +-
 3 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 959a9371d205..e64db5f80d90 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -48,6 +48,63 @@
 #define MSM8916_CAL_SEL_MASK	0xe0000000
 #define MSM8916_CAL_SEL_SHIFT	29
 
+/* eeprom layout data for 8939 */
+#define MSM8939_BASE0_MASK	0x000000ff
+#define MSM8939_BASE1_MASK	0xff000000
+#define MSM8939_BASE0_SHIFT	0
+#define MSM8939_BASE1_SHIFT	24
+
+#define MSM8939_S0_P1_MASK	0x000001f8
+#define MSM8939_S1_P1_MASK	0x001f8000
+#define MSM8939_S2_P1_MASK_0_4	0xf8000000
+#define MSM8939_S2_P1_MASK_5	0x00000001
+#define MSM8939_S3_P1_MASK	0x00001f80
+#define MSM8939_S4_P1_MASK	0x01f80000
+#define MSM8939_S5_P1_MASK	0x00003f00
+#define MSM8939_S6_P1_MASK	0x03f00000
+#define MSM8939_S7_P1_MASK	0x0000003f
+#define MSM8939_S8_P1_MASK	0x0003f000
+#define MSM8939_S9_P1_MASK	0x07e00000
+
+#define MSM8939_S0_P2_MASK	0x00007e00
+#define MSM8939_S1_P2_MASK	0x07e00000
+#define MSM8939_S2_P2_MASK	0x0000007e
+#define MSM8939_S3_P2_MASK	0x0007e000
+#define MSM8939_S4_P2_MASK	0x7e000000
+#define MSM8939_S5_P2_MASK	0x000fc000
+#define MSM8939_S6_P2_MASK	0xfc000000
+#define MSM8939_S7_P2_MASK	0x00000fc0
+#define MSM8939_S8_P2_MASK	0x00fc0000
+#define MSM8939_S9_P2_MASK_0_4	0xf8000000
+#define MSM8939_S9_P2_MASK_5	0x00002000
+
+#define MSM8939_S0_P1_SHIFT	3
+#define MSM8939_S1_P1_SHIFT	15
+#define MSM8939_S2_P1_SHIFT_0_4	27
+#define MSM8939_S2_P1_SHIFT_5	0
+#define MSM8939_S3_P1_SHIFT	7
+#define MSM8939_S4_P1_SHIFT	19
+#define MSM8939_S5_P1_SHIFT	8
+#define MSM8939_S6_P1_SHIFT	20
+#define MSM8939_S7_P1_SHIFT	0
+#define MSM8939_S8_P1_SHIFT	12
+#define MSM8939_S9_P1_SHIFT	21
+
+#define MSM8939_S0_P2_SHIFT	9
+#define MSM8939_S1_P2_SHIFT	21
+#define MSM8939_S2_P2_SHIFT	1
+#define MSM8939_S3_P2_SHIFT	13
+#define MSM8939_S4_P2_SHIFT	25
+#define MSM8939_S5_P2_SHIFT	14
+#define MSM8939_S6_P2_SHIFT	26
+#define MSM8939_S7_P2_SHIFT	6
+#define MSM8939_S8_P2_SHIFT	18
+#define MSM8939_S9_P2_SHIFT_0_4	27
+#define MSM8939_S9_P2_SHIFT_5	13
+
+#define MSM8939_CAL_SEL_MASK	0x7
+#define MSM8939_CAL_SEL_SHIFT	0
+
 /* eeprom layout data for 8974 */
 #define BASE1_MASK		0xff
 #define S0_P1_MASK		0x3f00
@@ -189,6 +246,76 @@ static int calibrate_8916(struct tsens_priv *priv)
 	return 0;
 }
 
+static int calibrate_8939(struct tsens_priv *priv)
+{
+	int base0 = 0, base1 = 0, i;
+	u32 p1[10], p2[10];
+	int mode = 0;
+	u32 *qfprom_cdata;
+	u32 cdata[6];
+
+	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
+	if (IS_ERR(qfprom_cdata))
+		return PTR_ERR(qfprom_cdata);
+
+	/* Mapping between qfprom nvmem and calibration data */
+	cdata[0] = qfprom_cdata[12];
+	cdata[1] = qfprom_cdata[13];
+	cdata[2] = qfprom_cdata[0];
+	cdata[3] = qfprom_cdata[1];
+	cdata[4] = qfprom_cdata[22];
+	cdata[5] = qfprom_cdata[21];
+
+	mode = (cdata[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL_SEL_SHIFT;
+	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
+
+	switch (mode) {
+	case TWO_PT_CALIB:
+		base1 = (cdata[3] & MSM8939_BASE1_MASK) >> MSM8939_BASE1_SHIFT;
+		p2[0] = (cdata[0] & MSM8939_S0_P2_MASK) >> MSM8939_S0_P2_SHIFT;
+		p2[1] = (cdata[0] & MSM8939_S1_P2_MASK) >> MSM8939_S1_P2_SHIFT;
+		p2[2] = (cdata[1] & MSM8939_S2_P2_MASK) >> MSM8939_S2_P2_SHIFT;
+		p2[3] = (cdata[1] & MSM8939_S3_P2_MASK) >> MSM8939_S3_P2_SHIFT;
+		p2[4] = (cdata[1] & MSM8939_S4_P2_MASK) >> MSM8939_S4_P2_SHIFT;
+		p2[5] = (cdata[2] & MSM8939_S5_P2_MASK) >> MSM8939_S5_P2_SHIFT;
+		p2[6] = (cdata[2] & MSM8939_S6_P2_MASK) >> MSM8939_S6_P2_SHIFT;
+		p2[7] = (cdata[3] & MSM8939_S7_P2_MASK) >> MSM8939_S7_P2_SHIFT;
+		p2[8] = (cdata[3] & MSM8939_S8_P2_MASK) >> MSM8939_S8_P2_SHIFT;
+		p2[9] = (cdata[4] & MSM8939_S9_P2_MASK_0_4) >> MSM8939_S9_P2_SHIFT_0_4;
+		p2[9] |= ((cdata[5] & MSM8939_S9_P2_MASK_5) >> MSM8939_S9_P2_SHIFT_5) << 5;
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] = (base1 + p2[i]) << 2;
+		fallthrough;
+	case ONE_PT_CALIB2:
+		base0 = (cdata[2] & MSM8939_BASE0_MASK) >> MSM8939_BASE0_SHIFT;
+		p1[0] = (cdata[0] & MSM8939_S0_P1_MASK) >> MSM8939_S0_P1_SHIFT;
+		p1[1] = (cdata[0] & MSM8939_S1_P1_MASK) >> MSM8939_S1_P1_SHIFT;
+		p1[2] = (cdata[0] & MSM8939_S2_P1_MASK_0_4) >> MSM8939_S2_P1_SHIFT_0_4;
+		p1[2] |= ((cdata[1] & MSM8939_S2_P1_MASK_5) >> MSM8939_S2_P1_SHIFT_5) << 5;
+		p1[3] = (cdata[1] & MSM8939_S3_P1_MASK) >> MSM8939_S3_P1_SHIFT;
+		p1[4] = (cdata[1] & MSM8939_S4_P1_MASK) >> MSM8939_S4_P1_SHIFT;
+		p1[5] = (cdata[2] & MSM8939_S5_P1_MASK) >> MSM8939_S5_P1_SHIFT;
+		p1[6] = (cdata[2] & MSM8939_S6_P1_MASK) >> MSM8939_S6_P1_SHIFT;
+		p1[7] = (cdata[3] & MSM8939_S7_P1_MASK) >> MSM8939_S7_P1_SHIFT;
+		p1[8] = (cdata[3] & MSM8939_S8_P1_MASK) >> MSM8939_S8_P1_SHIFT;
+		p1[9] = (cdata[4] & MSM8939_S9_P1_MASK) >> MSM8939_S9_P1_SHIFT;
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] = ((base0) + p1[i]) << 2;
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
 static int calibrate_8974(struct tsens_priv *priv)
 {
 	int base1 = 0, base2 = 0, i;
@@ -325,7 +452,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
-/* v0.1: 8916, 8974 */
+/* v0.1: 8916, 8939, 8974 */
 
 static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
@@ -386,6 +513,21 @@ struct tsens_plat_data data_8916 = {
 	.fields	= tsens_v0_1_regfields,
 };
 
+static const struct tsens_ops ops_8939 = {
+	.init		= init_common,
+	.calibrate	= calibrate_8939,
+	.get_temp	= get_temp_common,
+};
+
+struct tsens_plat_data data_8939 = {
+	.num_sensors	= 10,
+	.ops		= &ops_8939,
+	.hw_ids		= (unsigned int []){ 0, 1, 2, 4, 5, 6, 7, 8, 9, 10 },
+
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
+};
+
 static const struct tsens_ops ops_8974 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8974,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 8d3e94d2a9ed..52656a24f813 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -897,6 +897,9 @@ static const struct of_device_id tsens_table[] = {
 	{
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
+	}, {
+		.compatible = "qcom,msm8939-tsens",
+		.data = &data_8939,
 	}, {
 		.compatible = "qcom,msm8974-tsens",
 		.data = &data_8974,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 59d01162c66a..f40b625f897e 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -585,7 +585,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
 extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern struct tsens_plat_data data_8916, data_8974;
+extern struct tsens_plat_data data_8916, data_8939, data_8974;
 
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8976;
-- 
2.17.1

