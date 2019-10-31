Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA340EB72C
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfJaSiE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:38:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35382 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbfJaSiD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:38:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id d13so4971367pfq.2
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4RhmNFrAjG8zCFd7O6KRoEzlzkP2xNrQ5XZHUG6WYMo=;
        b=qUTMy6d6bhUIjRbVvWTqaQYff41vkGPg9vSPWk8F27OXcec8Q9P5c3YgSzKYybjKnu
         +XZ3zBQ19Xix2vb7u4WBk5XOk4p7QGaGdR+U5QHPr3SiB/3TqjfOOzo4lsdnAewE5BsR
         VAKe89jQY1I6jxtCNoHaryTCWukSAxWNBcmKlm+COUQZ+W6VjAtBT18d6B+MMC5Loy5O
         uu4+JFSfAfmS+aVagw6jzy8w69EwKXvzjYSLJdGFMV4/sWzE5XDijSwxI99Pdb6r6BAF
         BJMRHlb0I248IWLKU/C1SyvSap1LGqmU2y58VrPkBuV0Jce5FKluK6wSicJCuNyntsRR
         fumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4RhmNFrAjG8zCFd7O6KRoEzlzkP2xNrQ5XZHUG6WYMo=;
        b=S0kpjDCY1YLxA7rcY2ODZjCJiWt4F+f3wOaA3kKrdHoIakskFXR0SiOmyn4AaLaXPA
         4BuMUZmbHIdVPEh3g30aglWSV+qHv6sRP0y5hQvSeYmfTNCWyMOGoPIcxaEfAXD+yeND
         V9/rFczK2aB1ZZYk9gJe3g5PSwpOB4cyFwIuzvyTI/zYR4HtnlJbYG246amr+VF3vxyR
         EhNBTD95tUsC/GfScC+jjvUB3aElBiymwbdoYNQ0eGOs006JKyezK1Ja95Y+IaUOybLj
         3erzLuJKw90FmQKpl3WtFxQ9/EIj3L1ji495gYjmKDxOGgsMUPsU5F1xpiZ3U3mtm+na
         fuGQ==
X-Gm-Message-State: APjAAAUCYQmMDEkLrStncDrn3NlsQAxu4/n14IbS3+7bdygK1gtSOhds
        zNPtWyWZiFS28LqlfHaeFy50mw==
X-Google-Smtp-Source: APXvYqxMexGvPxFOiGIkps4L8l6q8iOKDr4RfDLeBVB22JFTgql78DXth5A7UzDuZpK0jkqZkFqYPw==
X-Received: by 2002:a17:90a:b88f:: with SMTP id o15mr9580950pjr.5.1572547082657;
        Thu, 31 Oct 2019 11:38:02 -0700 (PDT)
Received: from localhost ([49.248.58.234])
        by smtp.gmail.com with ESMTPSA id e3sm4331139pff.134.2019.10.31.11.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:38:02 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v7 03/15] drivers: thermal: tsens: Add __func__ identifier to debug statements
Date:   Fri,  1 Nov 2019 00:07:27 +0530
Message-Id: <18717de35f31098d3ebc12564c2767b6d54d37d8.1572526427.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
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

