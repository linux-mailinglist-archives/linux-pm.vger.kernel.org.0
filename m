Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6106DE99B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 12:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfJUKfz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 06:35:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33177 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfJUKfz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 06:35:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id i76so7567566pgc.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cALbZwSOU8EvtF0iOAGpF4/JluhlENqnhyD2XhJQYmg=;
        b=H0BE8weeGQn2WySiuRb+gKaFVKFQ7KMLVZ3dRmtUOI8X5pcqHTFM7GXNw27rl2sawo
         P7jYI09TXntT0JzSLhGxYPIHV5GSPV6U+4apNg7kDFWtz5vu5CCgmtfyD5nbC02pl5Rl
         47uIDf+hqdDydBjT1xdlYLy21GCjcBGTFliZYzQylLmwe5Ir/cs6FWAuy5wfGfJEIt9t
         VoQiw1oiGRpqByof/t7G6Tn1i/MVgJpqkCMzusZPJwmlgptfgbk/YvIX0QIbnyQr2LSC
         5nfNsPnqowCRjdXzkCDfhdKpRkc4cjTfno9WAppgdirgW2zMsG6FJN3n+FLzNBlNYmIk
         7MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cALbZwSOU8EvtF0iOAGpF4/JluhlENqnhyD2XhJQYmg=;
        b=aJw26pMRh1BTbDTo87FCKkG8OldKPpptb0zuC0jdqWWT+IBT+45MyXlW9d9HJHnQ0C
         gwAyEHhQ7r/XdYEFX8EQbeQFtyIG7Vg30pJCtsfwbGh4AQbzQepouzYDcU46HbLvwHOF
         qsATAWC3Ta8MbKK12qNhdwz0bPvi40qenybp03O/KnY/jK/dd6Ic7VHAFQcIFuBfgsY8
         eZHnDmo0Bnw2SSgwKsBTGMs5WtThlUV82b37ElhUydwO6VdlqxTvOf2SSdWzxn46VcqS
         aIn4hZTKmYHardSj7XIfJKE7LH/Inv+zQ04Yyxn+evCiqJO6l0GvU2affQaC+LdYT7Uj
         nnNg==
X-Gm-Message-State: APjAAAVIsMPX8DarLYMHzi0idN+b7HpP8dkxt0D6gXO8g++wqfstlsIM
        o45425dvBf3TZF9NKlTsP9pTyw==
X-Google-Smtp-Source: APXvYqxwkCdW3hoZGhMouiok1E3s+a9UAP5ShBjMBhUBTUWzHLBGV5I+r7kyAAQ6ox9BpaKt3icvCw==
X-Received: by 2002:a17:90a:aa98:: with SMTP id l24mr27995872pjq.96.1571654152956;
        Mon, 21 Oct 2019 03:35:52 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id r30sm15644244pfl.42.2019.10.21.03.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:35:52 -0700 (PDT)
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
Subject: [PATCH v6 03/15] drivers: thermal: tsens: Add __func__ identifier to debug statements
Date:   Mon, 21 Oct 2019 16:05:22 +0530
Message-Id: <18717de35f31098d3ebc12564c2767b6d54d37d8.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
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

