Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14B5D899D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfJPHeg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 03:34:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44512 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbfJPHee (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 03:34:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so9765570pgd.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4RhmNFrAjG8zCFd7O6KRoEzlzkP2xNrQ5XZHUG6WYMo=;
        b=dCFBysYDMtrZWkaWVSQ6gElCAcOUUOzQjnnzXReacAYDRsxxrF6pcSz2vUYJL2wuyb
         9lXXXGhU0BnfZrvH5fd1wExIx5HcCvOX5JGZ4kjGJX9YY0aRYxUxKBGfxDgVQI1iHugg
         lu39ANrG4dMc9P1lRSw56+WhLI5wNhtgGm/2prvVjbTjP8NW7NpOg2A2eiawKKhwC72x
         iajf+VznJ8/MDK2d63PJKKAkokdpE93pXoonLw+cvsX8gg/1dsGHv38NR4OHfVYqamx5
         vmy/y4e2rRfHTyjaN3x5ShfIykPkVL6Q8F5fsnR9ZtSAbcm+cpihcfVCxzl7SqvXiBri
         25Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4RhmNFrAjG8zCFd7O6KRoEzlzkP2xNrQ5XZHUG6WYMo=;
        b=D7HDh3fgYq5TOzjF+NI/TYOvV4iBeMChoIHS+YUebRATY9O4vgUGuFM5Rqs9KQ1OYZ
         kO6ac5tpND9m50Xn/Qkl5vIfxRC6r2bSEWWgFHniNflBlBmVn01vPcz0iKjWuj4uWS5G
         zj/myKtW5Z6Sj8VDkM3tfd1Dr7TRCuqI8Feh6ZUrN53B1D5BmR+iSg1MVVJtwjTolBNa
         3kpQS0Ttp5I0YY7l5+kIl/2H8aWaTA4pqTvN0wzINzgC8vCPvkICkOcgqaULZbM14hgJ
         pNDzwpAatnzVHu5WaNo4FIVTxJ2vubH/HYLELnmF+VwJF90Jt5kDqMPPBg9tL93xEfsI
         4wog==
X-Gm-Message-State: APjAAAWoL7xEDe+QRUmaQSjBwAGxlqBdEewS9hntULmUll4j5PnafeAM
        DQ6F8gyGhGrXVZ1+fmmEv4dIpA==
X-Google-Smtp-Source: APXvYqwihrDW65PEOGJ0kyNKW8RAcSD6I0XTQ+vr82D1QKTjMmX9J5e/RTa7TEUS3fDoL4KiMfmUdA==
X-Received: by 2002:a63:1e04:: with SMTP id e4mr22427676pge.4.1571211273858;
        Wed, 16 Oct 2019 00:34:33 -0700 (PDT)
Received: from localhost ([49.248.175.127])
        by smtp.gmail.com with ESMTPSA id k124sm12361970pga.83.2019.10.16.00.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:34:33 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 03/15] drivers: thermal: tsens: Add __func__ identifier to debug statements
Date:   Wed, 16 Oct 2019 13:04:02 +0530
Message-Id: <18717de35f31098d3ebc12564c2767b6d54d37d8.1571210269.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
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

