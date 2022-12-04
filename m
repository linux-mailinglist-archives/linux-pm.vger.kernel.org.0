Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AF6641AFA
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 06:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLDF7a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 00:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLDF7V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 00:59:21 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F004F1A3BF
        for <linux-pm@vger.kernel.org>; Sat,  3 Dec 2022 21:59:19 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c1so13728368lfi.7
        for <linux-pm@vger.kernel.org>; Sat, 03 Dec 2022 21:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMZgZgjVy9HPbAmZZqg2krbkTooRWIvWAVZboE7ieT0=;
        b=j/xS76tWzDnhKGj4jM5QCgwqVfg1q7hbGnZ6ACIQY72F4atFx7j/rf0sm2j+QP7/kD
         RLPBEmSfDtVqg6MgJR14D9CLmkHn18UYJwduMb3+T8zjGOKxtnKVv3t2F73bkQpNYk0d
         W7BDGscTFR7MddMHSauLf+o/P6kyVZsAAuFGmKIpMJVi5M+Oozas/BhWdhgGEvDR+TQ/
         LpwOiky9ajOTGFT4C4QBR/pFsQjsWwvlw0oC88Qqv0O7wD3zkWY/HUa2h86e2yfnXU+Y
         yOpAva8OSv1ncae6+mN8MkIsyECTW9153w/3VBRYIlllPT9K/Yvo/d+L972/UQL32Ptl
         WIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMZgZgjVy9HPbAmZZqg2krbkTooRWIvWAVZboE7ieT0=;
        b=zQMQsYhlvsWlqM9cXKU6kS+76ihZjojYiit4LXAi+w4NEhastZLl8aK5Fm8fjJb243
         6sBp2n+F4maGNyibz2Z7Mivjct/WRPoinKbJJ1N+MbQiRJqGO9ag+2TDLzVkwZYKT7rZ
         zHDsoXvepbkGWiGaNOd9tHVOQolfbC0Tf9EHzlelDrhhOr7Zk/igni/PhfddxKj+Wq3C
         RDN9/uCo6fjr+4C9Xw1WuQ/a7H17BeWV/8+l1QN9iLiO0us4KMb5Skx6o/u5cSmWpaJf
         E38ocNc5N3Z6uBcePh3V8JHaUau8DjNjfZ6J7TVx0iu1kdk5G0O8KUy2gSRgMVDqdWd2
         bXZQ==
X-Gm-Message-State: ANoB5pl7YIi25Fl3RVhYWyCKR84MD1nC8Zrx43GmEx07pAUKpzB9bd/I
        kAx0FXYNuf2C29eKnyBEGE+gPQ==
X-Google-Smtp-Source: AA0mqf6PVnNCQcAQpSPdc4swsCu8ku/+srsX9jHDkrSp+mSqj4KswtZS6V4M4FmdOEJug6zhtRriRQ==
X-Received: by 2002:a05:6512:683:b0:4b4:eadc:5b53 with SMTP id t3-20020a056512068300b004b4eadc5b53mr19450900lfe.156.1670133559514;
        Sat, 03 Dec 2022 21:59:19 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004917a30c82bsm1650028lfo.153.2022.12.03.21.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 21:59:19 -0800 (PST)
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
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 11/15] thermal/drivers/tsens: Support using nvmem cells for msm8974 calibration
Date:   Sun,  4 Dec 2022 07:59:05 +0200
Message-Id: <20221204055909.1351895-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
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

MSM8974 has two sets of calibration data: main one and backup. Add
support for parsing both sets of calibration data from nvmem cells.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 50 +++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c      | 39 +++++++++++++++++++-----
 drivers/thermal/qcom/tsens.h      |  1 +
 3 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index c84abe9b4299..7bb759bad248 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
 #include "tsens.h"
 
@@ -194,6 +195,50 @@ static int calibrate_8916(struct tsens_priv *priv)
 	return 0;
 }
 
+static int calibrate_8974_nvmem(struct tsens_priv *priv)
+{
+	int i, ret, mode;
+	u32 p1[11], p2[11];
+	u32 backup;
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, "use_backup", &backup);
+	if (ret == -ENOENT)
+		dev_warn(priv->dev, "Please migrate to separate nvmem cells for calibration data\n");
+	if (ret < 0)
+		return ret;
+
+	mode = tsens_read_calibration(priv, 2, p1, p2, backup == BKP_SEL);
+	if (mode < 0)
+		return mode;
+
+	if (mode == NO_PT_CALIB) {
+		p1[0] += 2;
+		p1[1] += 9;
+		p1[2] += 3;
+		p1[3] += 9;
+		p1[4] += 5;
+		p1[5] += 9;
+		p1[6] += 7;
+		p1[7] += 10;
+		p1[8] += 8;
+		p1[9] += 9;
+		p1[10] += 8;
+	} else {
+		for (i = 0; i < priv->num_sensors; i++) {
+			/*
+			 * ONE_PT_CALIB requires using addition here instead of
+			 * using OR operation.
+			 */
+			p1[i] += BIT_APPEND;
+			p2[i] += BIT_APPEND;
+		}
+	}
+
+	compute_intercept_slope(priv, p1, p2, mode);
+
+	return 0;
+}
+
 static int calibrate_8974(struct tsens_priv *priv)
 {
 	int base1 = 0, base2 = 0, i;
@@ -201,6 +246,11 @@ static int calibrate_8974(struct tsens_priv *priv)
 	int mode = 0;
 	u32 *calib, *bkp;
 	u32 calib_redun_sel;
+	int ret;
+
+	ret = calibrate_8974_nvmem(priv);
+	if (ret == 0)
+		return 0;
 
 	calib = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(calib))
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9f1f9ca7963d..888c334c0467 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -70,18 +70,21 @@ char *qfprom_read(struct device *dev, const char *cname)
 	return ret;
 }
 
-int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
+int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2, bool backup)
 {
 	u32 mode;
 	u32 base1, base2;
-	u32 p1[MAX_SENSORS], p2[MAX_SENSORS];
-	char name[] = "sXX_pY"; /* s10_p1 */
+	char name[] = "sXX_pY_backup"; /* s10_p1_backup */
 	int i, ret;
 
 	if (priv->num_sensors > MAX_SENSORS)
 		return -EINVAL;
 
-	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
+	ret = snprintf(name, sizeof(name), "mode%s", backup ? "_backup" : "");
+	if (ret < 0)
+		return ret;
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &mode);
 	if (ret == -ENOENT)
 		dev_warn(priv->dev, "Please migrate to separate nvmem cells for calibration data\n");
 	if (ret < 0)
@@ -89,16 +92,24 @@ int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
 
 	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
 
-	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
+	ret = snprintf(name, sizeof(name), "base1%s", backup ? "_backup" : "");
+	if (ret < 0)
+		return ret;
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &base1);
+	if (ret < 0)
+		return ret;
+
+	ret = snprintf(name, sizeof(name), "base2%s", backup ? "_backup" : "");
 	if (ret < 0)
 		return ret;
 
-	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base2", &base2);
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &base2);
 	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < priv->num_sensors; i++) {
-		ret = snprintf(name, sizeof(name), "s%d_p1", i);
+		ret = snprintf(name, sizeof(name), "s%d_p1%s", i, backup ? "_backup" : "");
 		if (ret < 0)
 			return ret;
 
@@ -106,7 +117,7 @@ int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
 		if (ret)
 			return ret;
 
-		ret = snprintf(name, sizeof(name), "s%d_p2", i);
+		ret = snprintf(name, sizeof(name), "s%d_p2%s", i, backup ? "_backup" : "");
 		if (ret < 0)
 			return ret;
 
@@ -136,6 +147,18 @@ int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
 		}
 	}
 
+	return mode;
+}
+
+int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
+{
+	u32 p1[MAX_SENSORS], p2[MAX_SENSORS];
+	int mode;
+
+	mode = tsens_read_calibration(priv, shift, p1, p2, false);
+	if (mode < 0)
+		return mode;
+
 	compute_intercept_slope(priv, p1, p2, mode);
 
 	return 0;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 8d1b83acdb95..c79e1e9783eb 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -579,6 +579,7 @@ struct tsens_priv {
 };
 
 char *qfprom_read(struct device *dev, const char *cname);
+int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2, bool backup);
 int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift);
 int tsens_calibrate_common(struct tsens_priv *priv);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
-- 
2.35.1

