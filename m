Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB8865AB55
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjAATk7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjAATks (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:40:48 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBA42D6
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so38871907lfb.13
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqICWi6TbRJ1t8BdhHT518ktWAE9yqx7ZrlpL4AUbPY=;
        b=tyMerOVf8yYtBLxZekiae+ryJeQ+4WTJ5318fzJa314kOSSTpEO3yhELJsePY4Emft
         pPd1Y+pgxJpY5u9VyL7PLiWpdPm/u0fCErczI4ixi/IZgjCdutDQZCaGzjvU6O+mzWSH
         08e6Sy57h+Jx5rBZoNiWTZHvyFExwBqQFk6I0n9mLLzEC5Onnt8WEIJkGEKe5cgam6du
         6MjcYti3E90Tfp0eHLQ2mFKvYzx9K8mdByUrjJnIqoAtqjAhBc58KMOWrw9fHhoOMPaU
         ZkheuBTjNjv/NHM+E4lSo7KvlBjx7AAlY7rLddsdCrXUtoX7Ul4G4E4bd39NuyN29MP6
         FBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqICWi6TbRJ1t8BdhHT518ktWAE9yqx7ZrlpL4AUbPY=;
        b=qqF4dCP/Y4Ve5SVnFkMDhNuAFjqIha/93L3rE+Cma+OxjOJJgsptS8SunZXs6YFNRe
         FPjpjqkNjEIqZlY64Vl14iI9P4MSmxlqSNeOHJ0tGACkupNNkjyjoLNmQw0M/pIMYZmP
         a9H3C/MU9D7DIXyQb9pYq8ZrzveuazfHiqu1+/KkipyXPEcM5OWM3c797NkTZIm/n5z5
         kNY1ENsvXD/A2qrQBKfUFEEZ/j+I5zXlrCwJDjBc6Kz82DEhd7689ihInGKVZesbLwPA
         8iU/0CZg7HtkMdUUJaBUA+Grh4moqiNxKMJaTGW1KhBCp5Wm2ETDZa3WHLsY6ksrUMKz
         DCDQ==
X-Gm-Message-State: AFqh2kpNzD/vanB7tcdXkUhJw9UJqFFg2p50KTMK62Xmo5elZIjpgqQB
        AD2gZZVY+jb4ycsV5WubTP1qfDSBgU6PdSw+
X-Google-Smtp-Source: AMrXdXv3k5t6OiQlGkhgs+fMBeP9hlSDHbnFg6srgK45vSYDxcpbeboWk/x5DtkVVb5qXWIDPnvHyQ==
X-Received: by 2002:ac2:498f:0:b0:4a4:86ff:9562 with SMTP id f15-20020ac2498f000000b004a486ff9562mr11805458lfl.38.1672602044701;
        Sun, 01 Jan 2023 11:40:44 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:40:44 -0800 (PST)
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
Subject: [PATCH v6 10/20] thermal/drivers/tsens: Support using nvmem cells for msm8974 calibration
Date:   Sun,  1 Jan 2023 21:40:24 +0200
Message-Id: <20230101194034.831222-11-dmitry.baryshkov@linaro.org>
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

MSM8974 has two sets of calibration data: main one and backup. Add
support for parsing both sets of calibration data from nvmem cells.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 50 +++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c      | 41 ++++++++++++++++++++-----
 drivers/thermal/qcom/tsens.h      |  1 +
 3 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 6c9e491f9559..3c08ad640940 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
 #include "tsens.h"
 
@@ -354,6 +355,50 @@ static int calibrate_8939(struct tsens_priv *priv)
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
@@ -361,6 +406,11 @@ static int calibrate_8974(struct tsens_priv *priv)
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
index ce568a68de4a..6facdb0246a5 100644
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
@@ -89,16 +92,25 @@ int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
 
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
-		ret = snprintf(name, sizeof(name), "s%d_p1", priv->sensor[i].hw_id);
+		ret = snprintf(name, sizeof(name), "s%d_p1%s", priv->sensor[i].hw_id,
+			       backup ? "_backup" : "");
 		if (ret < 0)
 			return ret;
 
@@ -106,7 +118,8 @@ int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
 		if (ret)
 			return ret;
 
-		ret = snprintf(name, sizeof(name), "s%d_p2", priv->sensor[i].hw_id);
+		ret = snprintf(name, sizeof(name), "s%d_p2%s", priv->sensor[i].hw_id,
+			       backup ? "_backup" : "");
 		if (ret < 0)
 			return ret;
 
@@ -136,6 +149,18 @@ int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
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
2.39.0

