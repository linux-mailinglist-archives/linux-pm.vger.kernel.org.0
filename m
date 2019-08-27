Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1BF9E786
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 14:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfH0MOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 08:14:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36968 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfH0MOg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 08:14:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id y9so13641774pfl.4
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cALbZwSOU8EvtF0iOAGpF4/JluhlENqnhyD2XhJQYmg=;
        b=mcxwMmfbWpjURk+sDZRfOKum+Lk7DBNWQwm5AO0dJRtYGIeQgT/zq9OmcUo1FepTVk
         1Zfv/ys1eqatL4TQGiUZ/Ca2kxdXTmfhB6C8iBDNEVGYamkGe1+5b0E3iZQDmV9Bdj1c
         O3skx9Yhfgk+JScWFGWn+dz6r0xisaS/RQ2MUW4nN32dvED1zRFHO8q3oBA5NDkmCwN6
         5Gg+3+UfAUIcALrGTAsnL/abFFaVA8AZeGtC0rEeZJmq4ft4TPKBP642ywo+oDJRzeN9
         nxZHIRWY5+6X0ojlla+nUooceujRC7+Mt5OcmnsWiUe3Pyh8mbzVjL1jgQrFIVCk+Ame
         KPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cALbZwSOU8EvtF0iOAGpF4/JluhlENqnhyD2XhJQYmg=;
        b=WduqF6q7BViDQOnKXlkj17QftYcmJ2H0yqXbLWCnQYXmJBvVhn8aqtTheVTm2M6Kzr
         kpZL3f1R7LR9DbAWoUGElusvgonApAwyb727/yrxOn8JVZG+J050kJX7v1X2cifXZ+6B
         c/HoAGPB4SlQhm5GHgzTH0RQGDtawJR1Fig9A2c3iL/MPGdJOozUSq+Vi543EhB122Jy
         m8ZaDCwB+8XbpjwvmR2EzwjBqpgz3dhmY1m72AURvPBxnV6/jKazBItHeiGoi9aiT9KN
         pUW3+Vw+xydKHQnGHLcutCz2tQ6tN2B7+8Ya9U8bRgSvrHLvK0HtLCdL471T75hZE8RR
         pp+g==
X-Gm-Message-State: APjAAAUB1Pr/S/uB/+jJ8wH9+SX8+Rp6cJSea/FLHscv2ON6fA4ypj5L
        ZPbD8/7C8yvxNgNjyEMfPy9qyA==
X-Google-Smtp-Source: APXvYqzzwYQ+PQW3FGGHUlGlFCWYJGjjnSBcR2EDGQmBj43++CgSd+f7YRVbPjEDs8tLgcX3EeUJGA==
X-Received: by 2002:a63:3009:: with SMTP id w9mr21859082pgw.260.1566908075548;
        Tue, 27 Aug 2019 05:14:35 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id b3sm20264505pfp.65.2019.08.27.05.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:14:34 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 03/15] drivers: thermal: tsens: Add __func__ identifier to debug statements
Date:   Tue, 27 Aug 2019 17:43:59 +0530
Message-Id: <93fa782bde9c66845993ff883532b3f1f02d99e4.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
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
index c037bdf92c663..7437bfe196e50 100644
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
index 542a7f8c3d962..06c6bbd69a1a7 100644
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

