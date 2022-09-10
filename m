Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41E85B464A
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIJMrI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 08:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIJMrI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 08:47:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4100457884
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i26so7225704lfp.11
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6R7WdKZZGEgnNPp4io9kbt+uAo7Q6dEP5JcdXxDYq1o=;
        b=OT851iS7+6MvGfXmA2BERCoBRLb9X0irEqAVYuN+RblIcXjlK23Gw0VOaVfxepUond
         bgTA8V0j/autRRsr9EKk/7oOLVBMMpDYnTrr/eFXMr62tkpGJpJGD1K/zZBrcVZz5iMi
         9jzAdOF7uxxfOH+UAJDES2EX1j2SrGBEjCrajyhXSm7zLlXd0n+dthfL+1xjRuIQLFVL
         I1FE76xT3x8M11KULPPmKaTqZLpTtuc09FGyWQjMgEIl6v/FoSrT316RjYVttN9Laymp
         G7rnHE6YcrwDhveHTRGuOWBoO6n0WYwrWakcgcAPktdgo9F7nrtLZGhoyPS9dPr97z5o
         ZFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6R7WdKZZGEgnNPp4io9kbt+uAo7Q6dEP5JcdXxDYq1o=;
        b=4QlWfXspWX1h2iEBXbTZ2J/7Mm5dhiTx0GiCQMGziEJHK0XtcYv38BYxDCGrviJOZ4
         lUr0nBWQwm6+1Ko/pQ1h1ri5IBYrvgXATsKcMBiQOlhFPOid8Oge4FS+EMiHVEvSRZHz
         gWA7tZ3mEVMDt7tZyXOh0tj00qA93421MDJi1imMSuD7DJt7/Dz5Z9zdtpZiRxv9KcTi
         V3DU5xT3TmmL2SpzPAZHqKhR0Tj1imT9XlRfy0PqeG0N+JNOFR1eoitEqfbNPVLSGkQp
         IE67/9sbCCiOsqlGjphqGOMwZJ1v+6NGUi7cuZ8NreaWR7hkKtzlhXDwnmVbKKoCjqGl
         aM1Q==
X-Gm-Message-State: ACgBeo3XpsWUA/xwe5I8TPdbZBpSAg2Mdfmzda/vkkb+gxQsnc6Qh2hN
        OLhSE9HnamaTX/cYu/eDmYT9WQ==
X-Google-Smtp-Source: AA6agR4IEC6lgocCONOR/A/J5VPjq6hV3cxawX43viUZIazPc0f+DLIAiqlnaC0HGGF0nJY74A1UZg==
X-Received: by 2002:a05:6512:3d9f:b0:497:a108:544f with SMTP id k31-20020a0565123d9f00b00497a108544fmr5475867lfv.688.1662814024379;
        Sat, 10 Sep 2022 05:47:04 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k14-20020a2e920e000000b002677a3ad1d9sm327463ljg.76.2022.09.10.05.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 05:47:03 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 02/10] thermal/drivers/tsens: Support using nvmem cells for calibration data
Date:   Sat, 10 Sep 2022 15:46:53 +0300
Message-Id: <20220910124701.4060321-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a unified function using nvmem cells for parsing the calibration
data rather than parsing the calibration blob manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 15 ++++++++
 drivers/thermal/qcom/tsens-v1.c   |  6 ++-
 drivers/thermal/qcom/tsens.c      | 62 +++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h      |  4 ++
 4 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index f136cb350238..2974eea578f4 100644
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
 	u32 cdata[6];
+	int ret;
+
+	ret = tsens_calibrate_nvmem(priv, 2);
+	if (!ret)
+		return 0;
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
@@ -491,6 +501,11 @@ static int calibrate_9607(struct tsens_priv *priv)
 	u32 p1[5], p2[5];
 	int mode = 0;
 	u32 *qfprom_cdata;
+	int ret;
+
+	ret = tsens_calibrate_nvmem(priv, 2);
+	if (!ret)
+		return 0;
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 573e261ccca7..868d7b4c9e36 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -172,7 +172,11 @@ static int calibrate_v1(struct tsens_priv *priv)
 	u32 p1[10], p2[10];
 	u32 mode = 0, lsb = 0, msb = 0;
 	u32 *qfprom_cdata;
-	int i;
+	int i, ret;
+
+	ret = tsens_calibrate_nvmem(priv, 2);
+	if (!ret)
+		return 0;
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index e49f58e83513..8331b924325a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -70,6 +70,68 @@ char *qfprom_read(struct device *dev, const char *cname)
 	return ret;
 }
 
+int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
+{
+	u32 mode;
+	u32 base1, base2;
+	u32 p1[MAX_SENSORS], p2[MAX_SENSORS];
+	char name[] = "sX_pY";
+	int i, ret;
+
+	if (priv->num_sensors > MAX_SENSORS)
+		return -EINVAL;
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
+	if (ret == -ENOENT)
+		dev_warn(priv->dev, "Please migrate to sepate nvmem cells for calibration data\n");
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
+		ret = snprintf(name, sizeof(name), "s%d_p1", i);
+		if (ret < 0)
+			return ret;
+
+		ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p1[i]);
+		if (ret)
+			return ret;
+
+		p1[i] = (base1 + p1[i]) << shift;
+
+		ret = snprintf(name, sizeof(name), "s%d_p2", i);
+		if (ret < 0)
+			return ret;
+
+		ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p2[i]);
+		if (ret)
+			return ret;
+
+		p2[i] = (base2 + p2[i]) << shift;
+	}
+
+	if (mode == NO_PT_CALIB) {
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
 /*
  * Use this function on devices where slope and offset calculations
  * depend on calibration data read from qfprom. On others the slope
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index ba05c8233356..504ed3394a79 100644
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
@@ -576,6 +579,7 @@ struct tsens_priv {
 };
 
 char *qfprom_read(struct device *dev, const char *cname);
+int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
-- 
2.35.1

