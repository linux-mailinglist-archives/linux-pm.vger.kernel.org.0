Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD701C1E9F
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 22:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgEAUd0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgEAUdY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 16:33:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB64C061A0C;
        Fri,  1 May 2020 13:33:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so12892335wrx.4;
        Fri, 01 May 2020 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrbBJt85us4GopoIm8IW9NA9I1zB+8Ym9cl0AGHUmuI=;
        b=oGuSdcuThCYSNe68cNTuNU+Y5kW+rHdsxdLgmYBwXuUWwhxiXrpMRF++caL8KlLEHj
         B42CdOXZwVvh3d4ABF8gvWBxLKrMYZgWjlb2G+wYjd/gBauTjOhWGf3mcNNN54blsb1q
         8sFz9ell3fOs8KFeGG26dbjHDHO+6TdXVdukBCv2pxAJqFHQyYFbuqyqvbjuWF0jEx/K
         zNEO+X514Ct60Zbzo5DKk0svLem/5a6QYnjOs0QKSvpXIGA1bK3G9otK0Yp1C5e631pA
         vLesAErGF/h5gpwlzf3uc0tCZRUCs5F6k/d7jFeizS0znuBArR8TgJ1bkvXXqPSKD1qV
         OWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrbBJt85us4GopoIm8IW9NA9I1zB+8Ym9cl0AGHUmuI=;
        b=IjDnSmnNq32ZsyU9bSu6Gun381+5+E2NB2TnQPOdcXqGUxigq2Gba9URlKvFqtV4e6
         gPLKkOB/zTkZbgpU4KqU1ow0z+QtzF/Q817F3UJnFMJu7aU0A1zL6Z3PpJQUqDXYgDvP
         oAGig71h78r8O+FEjvB46PbDEZ145VNbol8YALrdZXTup4a4JOfoFoEp7aFutS0RDuCg
         2884VcEOGC5cCcxE/T6JgPVOqJ3WzzE4RGiNZqwEpNKAP/CIqi5Rtnl84CbgNA5mYXbF
         3AHN2peYqNpRKbNKUoi3EFDbfVPhgRUqJEPEAve9LfdVNLC+7BDVRloC8x/JyUukJfCv
         E0kA==
X-Gm-Message-State: AGi0PuaB3LeZgVbTxkUPIWbOY30uf9tWSZGpLaA82DDzod/sL97/6l8M
        B7uIQZweLFrpP22B1V40zAo=
X-Google-Smtp-Source: APiQypIr1ig8W4B/h5sb1Fw77oe25LePKHikIaGwsWpMnR2OAi7EDd+FV6h1Q20s8wKAApJOfdk8/w==
X-Received: by 2002:adf:ea48:: with SMTP id j8mr5881083wrn.108.1588365202200;
        Fri, 01 May 2020 13:33:22 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id i129sm1104341wmi.20.2020.05.01.13.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:33:21 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal: qcom: tsens-v0_1: Add support for MSM8939
Date:   Fri,  1 May 2020 22:33:10 +0200
Message-Id: <20200501203311.143934-2-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200501203311.143934-1-konradybcio@gmail.com>
References: <20200501203311.143934-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 142 +++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c      |   3 +
 drivers/thermal/qcom/tsens.h      |   2 +-
 3 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 959a9371d205c..29b95886273b7 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -48,6 +48,64 @@
 #define MSM8916_CAL_SEL_MASK	0xe0000000
 #define MSM8916_CAL_SEL_SHIFT	29
 
+/* eeprom layout data for 8939 */
+#define MSM8939_BASE0_MASK           0x000000ff
+#define MSM8939_BASE1_MASK           0xff000000
+#define MSM8939_BASE0_SHIFT
+#define MSM8939_BASE1_SHIFT          24
+
+#define MSM8939_S0_P1_MASK         0x000001f8
+#define MSM8939_S1_P1_MASK         0x001f8000
+#define MSM8939_S2_P1_MASK_0_4     0xf8000000
+#define MSM8939_S2_P1_MASK_5       0x00000001
+#define MSM8939_S3_P1_MASK         0x00001f80
+#define MSM8939_S4_P1_MASK         0x01f80000
+#define MSM8939_S5_P1_MASK         0x00003f00
+#define MSM8939_S6_P1_MASK         0x03f00000
+#define MSM8939_S7_P1_MASK         0x0000003f
+#define MSM8939_S8_P1_MASK         0x0003f000
+#define MSM8939_S9_P1_MASK         0x07e00000
+
+#define MSM8939_S0_P2_MASK         0x00007e00
+#define MSM8939_S1_P2_MASK         0x07e00000
+#define MSM8939_S2_P2_MASK         0x0000007e
+#define MSM8939_S3_P2_MASK         0x0007e000
+#define MSM8939_S4_P2_MASK         0x7e000000
+#define MSM8939_S5_P2_MASK         0x000fc000
+#define MSM8939_S6_P2_MASK         0xfc000000
+#define MSM8939_S7_P2_MASK         0x00000fc0
+#define MSM8939_S8_P2_MASK         0x00fc0000
+#define MSM8939_S9_P2_MASK_0_4     0xf8000000
+#define MSM8939_S9_P2_MASK_5       0x00002000
+
+#define MSM8939_CAL_SEL_MASK	0xc0000000
+#define MSM8939_CAL_SEL_SHIFT	0
+
+
+#define MSM8939_S0_P1_SHIFT        3
+#define MSM8939_S1_P1_SHIFT        15
+#define MSM8939_S2_P1_SHIFT_0_4    27
+#define MSM8939_S2_P1_SHIFT_5      5
+#define MSM8939_S3_P1_SHIFT        7
+#define MSM8939_S4_P1_SHIFT        19
+#define MSM8939_S5_P1_SHIFT        8
+#define MSM8939_S6_P1_SHIFT        20
+//yes, 7 is missing in downstream
+#define MSM8939_S8_P1_SHIFT        12
+#define MSM8939_S9_P1_SHIFT        21
+
+#define MSM8939_S0_P2_SHIFT        9
+#define MSM8939_S1_P2_SHIFT        21
+#define MSM8939_S2_P2_SHIFT        1
+#define MSM8939_S3_P2_SHIFT        13
+#define MSM8939_S4_P2_SHIFT        25
+#define MSM8939_S5_P2_SHIFT        14
+#define MSM8939_S6_P2_SHIFT        26
+#define MSM8939_S7_P2_SHIFT        6
+#define MSM8939_S8_P2_SHIFT        18
+#define MSM8939_S9_P2_SHIFT_0_4    27
+#define MSM8939_S9_P2_SHIFT_5      8
+
 /* eeprom layout data for 8974 */
 #define BASE1_MASK		0xff
 #define S0_P1_MASK		0x3f00
@@ -189,6 +247,73 @@ static int calibrate_8916(struct tsens_priv *priv)
 	return 0;
 }
 
+static int calibrate_8939(struct tsens_priv *priv)
+{
+	int base0 = 0, base1 = 0, i;
+	u32 p1[11], p2[11];
+	int mode = 0;
+	u32 *qfprom_cdata, *qfprom_csel;
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
+	mode = (qfprom_csel[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL_SEL_SHIFT;
+	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
+	switch (mode) {
+	case TWO_PT_CALIB:
+		base1 = (qfprom_cdata[1] & MSM8939_BASE1_MASK) >> MSM8939_BASE1_SHIFT;
+		p2[0] = (qfprom_cdata[0] & MSM8939_S0_P2_MASK) >> MSM8939_S0_P2_SHIFT;
+		p2[1] = (qfprom_cdata[0] & MSM8939_S1_P2_MASK) >> MSM8939_S1_P2_SHIFT;
+		p2[2] = (qfprom_cdata[1] & MSM8939_S2_P2_MASK) >> MSM8939_S2_P2_SHIFT;
+		p2[3] = (qfprom_cdata[1] & MSM8939_S3_P2_MASK) >> MSM8939_S3_P2_SHIFT;
+		p2[4] = (qfprom_cdata[1] & MSM8939_S4_P2_MASK) >> MSM8939_S4_P2_SHIFT;
+		p2[5] = (qfprom_cdata[1] & MSM8939_S5_P2_MASK) >> MSM8939_S5_P2_SHIFT;
+		p2[6] = (qfprom_cdata[1] & MSM8939_S6_P2_MASK) >> MSM8939_S6_P2_SHIFT;
+		p2[7] = (qfprom_cdata[1] & MSM8939_S7_P2_MASK) >> MSM8939_S7_P2_SHIFT;
+		p2[8] = (qfprom_cdata[1] & MSM8939_S8_P2_MASK) >> MSM8939_S8_P2_SHIFT;
+		p2[9] = (qfprom_cdata[1] & MSM8939_S9_P2_MASK_0_4) >> MSM8939_S9_P2_SHIFT_0_4;
+		p2[10] = (qfprom_cdata[1] & MSM8939_S9_P2_MASK_5) >> MSM8939_S9_P2_SHIFT_5;
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] = ((base1 + p2[i]) << 3);
+		/* Fall through */
+	case ONE_PT_CALIB2:
+		base0 = (qfprom_cdata[0] & MSM8939_BASE0_MASK);
+		p1[0] = (qfprom_cdata[0] & MSM8939_S0_P1_MASK) >> MSM8939_S0_P1_SHIFT;
+		p1[1] = (qfprom_cdata[0] & MSM8939_S1_P1_MASK) >> MSM8939_S1_P1_SHIFT;
+		p1[2] = (qfprom_cdata[0] & MSM8939_S2_P1_MASK_0_4) >> MSM8939_S2_P1_SHIFT_0_4;
+		p1[3] = (qfprom_cdata[0] & MSM8939_S2_P1_MASK_5) >> MSM8939_S2_P1_SHIFT_5;
+		p1[4] = (qfprom_cdata[1] & MSM8939_S3_P1_MASK) >> MSM8939_S3_P1_SHIFT;
+		p1[5] = (qfprom_cdata[1] & MSM8939_S4_P1_MASK) >> MSM8939_S4_P1_SHIFT;
+		p1[6] = (qfprom_cdata[1] & MSM8939_S5_P1_MASK) >> MSM8939_S5_P1_SHIFT;
+		p1[7] = (qfprom_cdata[1] & MSM8939_S6_P1_MASK) >> MSM8939_S6_P1_SHIFT;
+		//yes, 7 is missing in downstream
+		p1[8] = (qfprom_cdata[1] & MSM8939_S8_P1_MASK) >> MSM8939_S8_P1_SHIFT;
+		p1[9] = (qfprom_cdata[1] & MSM8939_S9_P1_MASK) >> MSM8939_S9_P1_SHIFT;
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] = (((base0) + p1[i]) << 3);
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
 static int calibrate_8974(struct tsens_priv *priv)
 {
 	int base1 = 0, base2 = 0, i;
@@ -325,7 +450,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
-/* v0.1: 8916, 8974 */
+/* v0.1: 8916, 8939, 8974 */
 
 static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
@@ -386,6 +511,21 @@ struct tsens_plat_data data_8916 = {
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
+	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5, 6, 7, 8, 9 },
+
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
+};
+
 static const struct tsens_ops ops_8974 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8974,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 2f77d235cf735..f654057e96ae1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -59,6 +59,9 @@ static const struct of_device_id tsens_table[] = {
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
index 502acf0e68285..403b15546f648 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -590,7 +590,7 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data);
 extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern struct tsens_plat_data data_8916, data_8974;
+extern struct tsens_plat_data data_8916, data_8939, data_8974;
 
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8976;
-- 
2.26.1

