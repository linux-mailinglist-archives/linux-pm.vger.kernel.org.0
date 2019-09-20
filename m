Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317BBB9937
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 23:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfITVws (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 17:52:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36604 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfITVwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 17:52:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so2027023pgb.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4RhmNFrAjG8zCFd7O6KRoEzlzkP2xNrQ5XZHUG6WYMo=;
        b=r+t6NZQ4YCr3fX3XKm0sA+keyVNFZYkHuIoXQ1qZcmVHfcxF+mZCfCrEV7WaEMHvU6
         ZpPYiz6N65E2lKZkGVlZT2tMfvvuD9reA4uDlvVXJsQ56iCvfS9mUXkf3hQF98FW6K9D
         7C85yko7Ix+8mjJFLNXfXwtxTiK5hyDxJH1tnDa69ouo8MSkCedw2uDHWqjUsLu/j5qv
         8Umx1z3Qam7igJcaOv95kEQgfH0QJfL1IiJbtM8gxHrgvCkwKpzb3Ne4uN+dDOd6Nzhy
         8BjaDk98pAY+gYv5pKJxgLdqVdwGQ4E/CP337zXTilxWSS6sdxKuDLl5023hCvUXh1NU
         XkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4RhmNFrAjG8zCFd7O6KRoEzlzkP2xNrQ5XZHUG6WYMo=;
        b=B0Ldv12zRhir1EhkSgpbWnTfIPAXjmusFPISTiRM9pNwRYq1Ab3utuTx/yiB9puXpL
         IH3q1vwuE3apwaTYQKbznU1Ff3fnJ2YAgpWDH5EOxTChQALKdcE1zqkBW/J5yiO2rpZ6
         ca7YepHecW/Si3UhO+cVu5cNrt7NTwKonIKozzn2V+diEH5Igz2SoFycaBBKf3jIbjm8
         ln2DG0dyttgPVQu13RiS3MeWpOE950Zi+A6/cZFJaFfPF4cTrclt416HQ+fZzY5C75wX
         RnHr69IeyTKKIzuTOz+SvU0AW/Saq+c2Y7lHS96gP5pJWg8K7kYur/+tST/8/Wm9Feg5
         Zt0Q==
X-Gm-Message-State: APjAAAX4VDZbkZsISg5pcwTqKa09Bep6rL7cIHZ6vcGWhNGoPHWREfkB
        LXypmhnIqd92JmldcMbQwwztcA==
X-Google-Smtp-Source: APXvYqxMsL5R+Nl92IySaWAz+iTeR7MaYf6w0cRENVIGe5c9KNLQ6mA5RBe4/BYaAYIwEUrmIVb9eg==
X-Received: by 2002:a63:4e02:: with SMTP id c2mr1049906pgb.339.1569016367039;
        Fri, 20 Sep 2019 14:52:47 -0700 (PDT)
Received: from localhost (wsip-98-175-107-49.sd.sd.cox.net. [98.175.107.49])
        by smtp.gmail.com with ESMTPSA id f18sm2960808pgf.58.2019.09.20.14.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 14:52:46 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v4 03/15] drivers: thermal: tsens: Add __func__ identifier to debug statements
Date:   Fri, 20 Sep 2019 14:52:18 -0700
Message-Id: <ae5aee22a3688d04819d5a12576da8d8a25e52b5.1569015835.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
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

