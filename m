Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8440AF6A6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 09:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfIKHQ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 03:16:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39148 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfIKHQx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 03:16:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id bd8so9763070plb.6
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2019 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4RhmNFrAjG8zCFd7O6KRoEzlzkP2xNrQ5XZHUG6WYMo=;
        b=hfjY3QENwOjtr0x1P9FLoxQ8HbWVvFtCTxs4dBSSCRszuxmG6vDUnB2snJ2wLMwaiy
         PxWA9K/x4lGty5FbGIw3uvXc0zFpQXNjZTAjjroE1ORwjN456I+yq/koVopZfVNXYMV9
         GsPpNlQa3w92QLUg0IsVmNglJeczEIwAPjpIIJW+Qq/m41zd8tlIRetY4oxp2Duzhr+v
         83QKhXI5MGAevWXXUE+nNqBOUbqTzzw54fjbAm+bXGv78Enxem3zqEizWqaid5Tq1alq
         AJhuUssClO1jk+CYY2EUuMGVxe0U9K3u2LUUn3sXVYhoi1HF1iNz5GpA7jqmkxfZDn92
         CgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4RhmNFrAjG8zCFd7O6KRoEzlzkP2xNrQ5XZHUG6WYMo=;
        b=umiSvpaOgwgQI+7CwY+Hx6JmbjGzBMkfvrWeP1M45YSbYzcXQm5E1utxGsQgb4hNJH
         DPpy8UpTePVYjCZJIOWpcHHBgHlYURzh842YMouPOdGVbgukKzmC8/la4vQXIsjvdSI+
         rE4LBWZ5fTUiz+QIgDbc/EHTrp1cZ+U/fqRbObCtr4JlCpouAsOjxnwQ4Ri+xJbwXZMT
         Zhz6ubY3MxEW3F7GRtGa2GO9ir/vmMekPCZgiKW+BLKHKfEmawz3HBNqEclNk5kKndFw
         8Qrh1UdLPnBHXv6PLawc2K8yrTyrSRn9WnbilxalkmDMQyLpkf2+3vUVYFPXydHgg6kq
         WAVQ==
X-Gm-Message-State: APjAAAVKpA54w3BpaekAjVkqZi+z9ciGZa5UyVwRHezPX73ujUq6CyWD
        dhilVDoHqR8PlFH7ElQSSbH7Yw==
X-Google-Smtp-Source: APXvYqybmviC1oYYajMImnhkYdigS9W28peNqIUfx8Ad4LGRKoYQxfF2Mt5JhZAEecFB9ZEkpcxPXA==
X-Received: by 2002:a17:902:8f97:: with SMTP id z23mr19935097plo.299.1568186211616;
        Wed, 11 Sep 2019 00:16:51 -0700 (PDT)
Received: from localhost ([49.248.201.118])
        by smtp.gmail.com with ESMTPSA id a1sm19631901pgd.74.2019.09.11.00.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 00:16:50 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v3 03/15] drivers: thermal: tsens: Add __func__ identifier to debug statements
Date:   Wed, 11 Sep 2019 12:46:20 +0530
Message-Id: <ae5aee22a3688d04819d5a12576da8d8a25e52b5.1568185732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Printing the function name when enabling debugging makes logs easier to
read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 8 ++++----
 drivers/thermal/qcom/tsens.c        | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c037bdf92c66..7437bfe196e5 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -42,8 +42,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		dev_dbg(priv->dev,
-			"sensor%d - data_point1:%#x data_point2:%#x\n",
-			i, p1[i], p2[i]);
+			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
+			__func__, i, p1[i], p2[i]);
 
 		priv->sensor[i].slope = SLOPE_DEFAULT;
 		if (mode == TWO_PT_CALIB) {
@@ -60,7 +60,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
 				(CAL_DEGC_PT1 *
 				priv->sensor[i].slope);
-		dev_dbg(priv->dev, "offset:%d\n", priv->sensor[i].offset);
+		dev_dbg(priv->dev, "%s: offset:%d\n", __func__, priv->sensor[i].offset);
 	}
 }
 
@@ -209,7 +209,7 @@ int __init init_common(struct tsens_priv *priv)
 	if (ret)
 		goto err_put_device;
 	if (!enabled) {
-		dev_err(dev, "tsens device is not enabled\n");
+		dev_err(dev, "%s: device not enabled\n", __func__);
 		ret = -ENODEV;
 		goto err_put_device;
 	}
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 542a7f8c3d96..06c6bbd69a1a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -127,7 +127,7 @@ static int tsens_probe(struct platform_device *pdev)
 		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
 
 	if (num_sensors <= 0) {
-		dev_err(dev, "invalid number of sensors\n");
+		dev_err(dev, "%s: invalid number of sensors\n", __func__);
 		return -EINVAL;
 	}
 
@@ -156,7 +156,7 @@ static int tsens_probe(struct platform_device *pdev)
 
 	ret = priv->ops->init(priv);
 	if (ret < 0) {
-		dev_err(dev, "tsens init failed\n");
+		dev_err(dev, "%s: init failed\n", __func__);
 		return ret;
 	}
 
@@ -164,7 +164,7 @@ static int tsens_probe(struct platform_device *pdev)
 		ret = priv->ops->calibrate(priv);
 		if (ret < 0) {
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "tsens calibration failed\n");
+				dev_err(dev, "%s: calibration failed\n", __func__);
 			return ret;
 		}
 	}
-- 
2.17.1

