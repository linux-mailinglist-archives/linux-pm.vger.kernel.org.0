Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD1651916
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 03:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiLTCrh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 21:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiLTCrf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 21:47:35 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23B713D08
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b13so16607682lfo.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bznsX2h+z33oabqPqT2zDP68/wac9zvw9OoPKtRDAE=;
        b=KtFJlzDt6U2+2UyZMy6x5ImV4btoQUlgR4eSi+3x6u/zk2wPTa0J2GvvZlZIg50kK+
         hL4OgWak6oZ4PkbBemE7sI9V4W5RCW8vlU/t+O6UqaAulDBkqDZP8mMVWCRVnb3X+dL3
         /qNICITXlqGZom0AQAkRbTmWIxU6qOXDO/tniABBF9U3iS3XvsvFqsdPesdwRjMas8nh
         t7Ab/JjofHQJlEf0pR3lICClvDr7pa6KOSPgxSSYMDCjpbUSUfm15hhm+ON40RDXUdjW
         5Wxlg6dgbXXJO8gGgynn2oN8RTeOrzhVJrjzsnyajsm7dbZaxK8NVHfvAEh5kYIxn4JX
         PUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bznsX2h+z33oabqPqT2zDP68/wac9zvw9OoPKtRDAE=;
        b=HRo4O3yjiKZ/sQVRqv9ulNgSuuEEPEBOpOHa6lLif+cECzCBf7nIqjxqrpbsoi7WBR
         j4ewoS5MAKU4VrAVE/8h1sUuOVvIsP7XFbN/qfkuPaeVpask3tiEgtRFn/w1ll/wSpnw
         ZxGeb5euQaIjq0OZvuDAe/pf8XM4NSLiMZkSP/VTQfZUpGibOQaFC6xFl7UcJM4Uk+4z
         kSVxehozY1KKhggwtUzcZeQ09c8G8mrBSc1ccB1XyGANDTzxPP+R+l7aR3w5WIhoVla1
         i1yfD2WkL9F4KKaKKB1bq3ErhPnn90by88/DBM7vBw/VkTK1Yi3/3wAbAUFuIKo76jaV
         Xc3Q==
X-Gm-Message-State: ANoB5pnyMkt2MeAf3saSqFOLek6AgIIYtkeK4CKndYV7RjAumTb2Pnx6
        yMqH+qGx0yZkJpVmEgbmfjlJeQ==
X-Google-Smtp-Source: AA0mqf4cbFodiOG10r4A/LdaWw4mStNmhDE2OOs3S5hswJuvSOYzmr4BkQ+7JmibGJ1JsqP7gWohHQ==
X-Received: by 2002:a19:381c:0:b0:4b6:a6e4:ab7a with SMTP id f28-20020a19381c000000b004b6a6e4ab7amr10710653lfa.8.1671504452496;
        Mon, 19 Dec 2022 18:47:32 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1274866lfs.252.2022.12.19.18.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:47:31 -0800 (PST)
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
Subject: [PATCH v3 11/15] thermal/drivers/tsens: Support using nvmem cells for msm8974 calibration
Date:   Tue, 20 Dec 2022 04:47:17 +0200
Message-Id: <20221220024721.947147-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
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
index caffcf9905b9..6a11b8b196b9 100644
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
index 68aef0ed6182..83bf60fa9008 100644
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
index 645ae02438fa..a9ae8df9f810 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -585,6 +585,7 @@ struct tsens_priv {
 };
 
 char *qfprom_read(struct device *dev, const char *cname);
+int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2, bool backup);
 int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift);
 int tsens_calibrate_common(struct tsens_priv *priv);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
-- 
2.35.1

