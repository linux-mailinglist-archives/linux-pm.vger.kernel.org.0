Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58965AB50
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjAATkw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjAATks (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:40:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8274201
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bq39so31102731lfb.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHjZmf7mcbCvS4sfr3HDX2QhshNM+liep6o9d5Gez4Q=;
        b=WuyYP4AJWHVtGg/8EqEI2FUctA9R+fDknN4hv20H99was2UfHQxwuIA6jUWFeAm4Us
         yxfMgj/foetkEGbsUZ2fGMPpYeBt7TgwV9BgZYMG+VflqXGnpquuss8JZFgY4/xbuPYl
         d6jXNh7H02Me3jTQnlIAHBAjdZg8AicfilgbGB0Ix4g3g0vkxjz/ORdjAPQgOaXIWgPZ
         v5d3rmitIkkVGjIunULlZ67T/Fs5GOU9mIt03RZemVMC+aPpjuw+swdSZ154xqQI41D3
         zedhevEajSbeWEax+d5OJ88okgqnHLj+BWT6p3mJatpiYx2ot+gK5m7ZxNHg8gDo7MRL
         QBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHjZmf7mcbCvS4sfr3HDX2QhshNM+liep6o9d5Gez4Q=;
        b=WQB+oyYAUFCltUw4EP57OYLPdprnk3O/IgjDXnhlcJLjuF6UXGCN0GuMlYU5IIMqyN
         I2G0Q8ES1DKTlRkfbKP8ZLyCvGuMZTcBZcFhijGIyQH5Du554Z1jRCO6EOVWYAIGik2E
         /pCZ3/F77TlpXZ0sobW3jw6LBzCge2xn0h/gEWgMUpqo2CwsEYQB0E5eRACoNrWn6sUq
         YAr/UbnCL6KI0dQ9wX0r3zQGduo1y3X+S1m6thQYoXAE5J5e2d5T1bzhnX2uTKob3/BN
         7EworhQZWkNgTfvacGvJvUjPtdJJfd+UGMd9SRIxvZeer2t3pkeBek144dD9U2B3EiIR
         byhg==
X-Gm-Message-State: AFqh2ko7QSE3UPrcvsYNH3v8nIRrJBZdHISmmDqk2ZnbePCVaijMWO3V
        WDdY+vhb2obBqztGCMMuPTrGbA==
X-Google-Smtp-Source: AMrXdXstpZAAPDA1IMazY41mtdHJNLnYrGezfGCitCWVT+BfphioG1So8fvUsyXRTsk5j04CCEK+FA==
X-Received: by 2002:a05:6512:16a8:b0:4b5:a70f:8efc with SMTP id bu40-20020a05651216a800b004b5a70f8efcmr17481416lfb.64.1672602043880;
        Sun, 01 Jan 2023 11:40:43 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:40:43 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 09/20] thermal/drivers/tsens: Support using nvmem cells for calibration data
Date:   Sun,  1 Jan 2023 21:40:23 +0200
Message-Id: <20230101194034.831222-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a unified function using nvmem cells for parsing the calibration
data rather than parsing the calibration blob manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 15 ++++++
 drivers/thermal/qcom/tsens-v1.c   | 11 ++++-
 drivers/thermal/qcom/tsens.c      | 76 +++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h      |  5 ++
 4 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 579028ea48f4..6c9e491f9559 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -229,6 +229,11 @@ static int calibrate_8916(struct tsens_priv *priv)
 	u32 p1[5], p2[5];
 	int mode = 0;
 	u32 *qfprom_cdata, *qfprom_csel;
+	int ret;
+
+	ret = tsens_calibrate_nvmem(priv, 3);
+	if (!ret)
+		return 0;
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
@@ -286,6 +291,11 @@ static int calibrate_8939(struct tsens_priv *priv)
 	int mode = 0;
 	u32 *qfprom_cdata;
 	u32 cdata[4];
+	int ret;
+
+	ret = tsens_calibrate_common(priv);
+	if (!ret)
+		return 0;
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
@@ -486,6 +496,11 @@ static int calibrate_9607(struct tsens_priv *priv)
 	u32 p1[5], p2[5];
 	int mode = 0;
 	u32 *qfprom_cdata;
+	int ret;
+
+	ret = tsens_calibrate_common(priv);
+	if (!ret)
+		return 0;
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 83c2853546d0..5bba75a845c5 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -143,7 +143,11 @@ static int calibrate_v1(struct tsens_priv *priv)
 	u32 p1[10], p2[10];
 	u32 mode = 0, lsb = 0, msb = 0;
 	u32 *qfprom_cdata;
-	int i;
+	int i, ret;
+
+	ret = tsens_calibrate_common(priv);
+	if (!ret)
+		return 0;
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
@@ -209,6 +213,11 @@ static int calibrate_8976(struct tsens_priv *priv)
 	u32 p1[11], p2[11];
 	int mode = 0, tmp = 0;
 	u32 *qfprom_cdata;
+	int ret;
+
+	ret = tsens_calibrate_common(priv);
+	if (!ret)
+		return 0;
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b191e19df93d..ce568a68de4a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -70,6 +70,82 @@ char *qfprom_read(struct device *dev, const char *cname)
 	return ret;
 }
 
+int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
+{
+	u32 mode;
+	u32 base1, base2;
+	u32 p1[MAX_SENSORS], p2[MAX_SENSORS];
+	char name[] = "sXX_pY"; /* s10_p1 */
+	int i, ret;
+
+	if (priv->num_sensors > MAX_SENSORS)
+		return -EINVAL;
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
+	if (ret == -ENOENT)
+		dev_warn(priv->dev, "Please migrate to separate nvmem cells for calibration data\n");
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
+	if (ret < 0)
+		return ret;
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base2", &base2);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		ret = snprintf(name, sizeof(name), "s%d_p1", priv->sensor[i].hw_id);
+		if (ret < 0)
+			return ret;
+
+		ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p1[i]);
+		if (ret)
+			return ret;
+
+		ret = snprintf(name, sizeof(name), "s%d_p2", priv->sensor[i].hw_id);
+		if (ret < 0)
+			return ret;
+
+		ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p2[i]);
+		if (ret)
+			return ret;
+	}
+
+	switch (mode) {
+	case ONE_PT_CALIB:
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] = p1[i] + (base1 << shift);
+		break;
+	case TWO_PT_CALIB:
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] = (p2[i] + base2) << shift;
+		fallthrough;
+	case ONE_PT_CALIB2:
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] = (p1[i] + base1) << shift;
+		break;
+	default:
+		dev_dbg(priv->dev, "calibrationless mode\n");
+		for (i = 0; i < priv->num_sensors; i++) {
+			p1[i] = 500;
+			p2[i] = 780;
+		}
+	}
+
+	compute_intercept_slope(priv, p1, p2, mode);
+
+	return 0;
+}
+
+int tsens_calibrate_common(struct tsens_priv *priv)
+{
+	return tsens_calibrate_nvmem(priv, 2);
+}
+
 /*
  * Use this function on devices where slope and offset calculations
  * depend on calibration data read from qfprom. On others the slope
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 7dd5fc246894..645ae02438fa 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -6,6 +6,7 @@
 #ifndef __QCOM_TSENS_H__
 #define __QCOM_TSENS_H__
 
+#define NO_PT_CALIB		0x0
 #define ONE_PT_CALIB		0x1
 #define ONE_PT_CALIB2		0x2
 #define TWO_PT_CALIB		0x3
@@ -17,6 +18,8 @@
 #define THRESHOLD_MAX_ADC_CODE	0x3ff
 #define THRESHOLD_MIN_ADC_CODE	0x0
 
+#define MAX_SENSORS 16
+
 #include <linux/interrupt.h>
 #include <linux/thermal.h>
 #include <linux/regmap.h>
@@ -582,6 +585,8 @@ struct tsens_priv {
 };
 
 char *qfprom_read(struct device *dev, const char *cname);
+int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift);
+int tsens_calibrate_common(struct tsens_priv *priv);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
-- 
2.39.0

