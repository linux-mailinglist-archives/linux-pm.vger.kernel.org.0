Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5408D22D947
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jul 2020 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgGYSO1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jul 2020 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGYSO0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2020 14:14:26 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B5AC08C5C1;
        Sat, 25 Jul 2020 11:14:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id di22so2094439edb.12;
        Sat, 25 Jul 2020 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HPsh1CbfwqZ6RxopOfc8jWlhPgY+zhZqxrqeOX/954=;
        b=T0W99H2o5WE447V+DDoFdMnIZ67XqL3WTThxh+iyHNxrxPF2DRRxydis3d74EoduOY
         V+ZENZmsoReJCyqYlTOZ/ttsRItUj14yHLcCxC0tAkYO+z0aSWu+ppDKxyE9clW9mq9K
         /VYf4IJHm+00ADr1tA6RI/O7EVE0pg3YoU9qV3JMLyqEboN8fCWCI5o1m85HObgojjCM
         94IeNOAR/74rzW/nxhnuKk3ZfXGLxFUZQygbImvsaXsM9KtJ5C61STO3UEhY3yoGy78G
         Bhn6C6uPEdAXNRDBMNIbx7SijbWCl7V2R41PiEXCh05sJ3zcuhuq6pfhrkfpi5cD8ztO
         kraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HPsh1CbfwqZ6RxopOfc8jWlhPgY+zhZqxrqeOX/954=;
        b=U8zIj5GDzY0/camfLSNLgWvoNQ5JIK6QWdyU756RVearOsgRrMIndCZ96TIc7mNiaY
         DLUw8Sro0NNzOvnZtDcY49oSOjGsGFKY/2AS7XIcoyOy5JEIdN/o70MAsyBDpoiLr47/
         lAFPvQG+XCDNlKdFo56Dcz9+wDE0BTBkk3SxCwx8MkEUXUEyBdPiwWzdkwI3uztjig09
         awdPJMYDcOrj7a49sOCc3vTMfLBbBvBtIjOyYtCIh8hfRxU8DjM91ozt75tvPOpvJ3/H
         u7GpEBAPq7ky4MadE2PdEBUVEZJnWJJ8vPiumcTbWBiHL79D7PTUDFT8fe73KmHkjIJb
         UPHg==
X-Gm-Message-State: AOAM533SaWbmgKyi5heejoWZL26knDwyiTGH4BNnohYZIUHY9d2QHpa6
        +uZUMM75EKb3PxDiU35RVwY=
X-Google-Smtp-Source: ABdhPJwVgY7NdTi79CH5JurpvNI02Kz7ycIWl8R802EXyhAwgidmQifEzWyOsYp9kXF8gPEI//oHQw==
X-Received: by 2002:a05:6402:b6c:: with SMTP id cb12mr14428669edb.116.1595700864299;
        Sat, 25 Jul 2020 11:14:24 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-22-5-125.retail.telecomitalia.it. [79.22.5.125])
        by smtp.googlemail.com with ESMTPSA id qn10sm220922ejb.39.2020.07.25.11.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:14:23 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 1/7] drivers: thermal: tsens: Add VER_0 tsens version
Date:   Sat, 25 Jul 2020 20:13:57 +0200
Message-Id: <20200725181404.18951-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200725181404.18951-1-ansuelsmth@gmail.com>
References: <20200725181404.18951-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VER_0 is used to describe device based on tsens version before v0.1.
These device are devices based on msm8960 for example apq8064 or
ipq806x.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 160 +++++++++++++++++++++++++++--------
 drivers/thermal/qcom/tsens.h |   7 +-
 2 files changed, 132 insertions(+), 35 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9fe9a2b26705..78840c1bc5d2 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -516,6 +516,15 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
 				hw_id, __func__, temp);
 		}
+
+		if (tsens_version(priv) < VER_0_1) {
+			/* Constraint: There is only 1 interrupt control register for all
+			 * 11 temperature sensor. So monitoring more than 1 sensor based
+			 * on interrupts will yield inconsistent result. To overcome this
+			 * issue we will monitor only sensor 0 which is the master sensor.
+			 */
+			break;
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -531,6 +540,13 @@ static int tsens_set_trips(void *_sensor, int low, int high)
 	int high_val, low_val, cl_high, cl_low;
 	u32 hw_id = s->hw_id;
 
+	if (tsens_version(priv) < VER_0_1) {
+		/* Pre v0.1 IP had a single register for each type of interrupt
+		 * and thresholds
+		 */
+		hw_id = 0;
+	}
+
 	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
 		hw_id, __func__, low, high);
 
@@ -550,6 +566,12 @@ static int tsens_set_trips(void *_sensor, int low, int high)
 	tsens_set_interrupt(priv, hw_id, LOWER, true);
 	tsens_set_interrupt(priv, hw_id, UPPER, true);
 
+	/* VER_0 require to set MIN and MAX THRESH */
+	if (tsens_version(priv) < VER_0_1) {
+		regmap_field_write(priv->rf[MIN_THRESH_0], 0);
+		regmap_field_write(priv->rf[MAX_THRESH_0], 120000);
+	}
+
 	spin_unlock_irqrestore(&priv->ul_lock, flags);
 
 	dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
@@ -584,18 +606,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	u32 valid;
 	int ret;
 
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	while (!valid) {
-		/* Valid bit is 0 for 6 AHB clock cycles.
-		 * At 19.2MHz, 1 AHB clock is ~60ns.
-		 * We should enter this loop very, very rarely.
-		 */
-		ndelay(400);
+	/* VER_0 doesn't have VALID bit */
+	if (tsens_version(priv) >= VER_0_1) {
 		ret = regmap_field_read(priv->rf[valid_idx], &valid);
 		if (ret)
 			return ret;
+		while (!valid) {
+			/* Valid bit is 0 for 6 AHB clock cycles.
+			 * At 19.2MHz, 1 AHB clock is ~60ns.
+			 * We should enter this loop very, very rarely.
+			 */
+			ndelay(400);
+			ret = regmap_field_read(priv->rf[valid_idx], &valid);
+			if (ret)
+				return ret;
+		}
 	}
 
 	/* Valid bit is set, OK to read the temperature */
@@ -765,8 +790,8 @@ int __init init_common(struct tsens_priv *priv)
 
 	if (tsens_version(priv) > VER_0_1) {
 		for (i = VER_MAJOR; i <= VER_STEP; i++) {
-			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
-							      priv->fields[i]);
+			priv->rf[i] = devm_regmap_field_alloc(
+				dev, priv->srot_map, priv->fields[i]);
 			if (IS_ERR(priv->rf[i]))
 				return PTR_ERR(priv->rf[i]);
 		}
@@ -775,12 +800,80 @@ int __init init_common(struct tsens_priv *priv)
 			goto err_put_device;
 	}
 
-	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
-						     priv->fields[TSENS_EN]);
-	if (IS_ERR(priv->rf[TSENS_EN])) {
-		ret = PTR_ERR(priv->rf[TSENS_EN]);
-		goto err_put_device;
+	if (tsens_version(priv) >= VER_0_1) {
+		priv->rf[TSENS_EN] = devm_regmap_field_alloc(
+			dev, priv->srot_map, priv->fields[TSENS_EN]);
+		if (IS_ERR(priv->rf[TSENS_EN])) {
+			ret = PTR_ERR(priv->rf[TSENS_EN]);
+			goto err_put_device;
+		}
+
+		priv->rf[SENSOR_EN] = devm_regmap_field_alloc(
+			dev, priv->srot_map, priv->fields[SENSOR_EN]);
+		if (IS_ERR(priv->rf[SENSOR_EN])) {
+			ret = PTR_ERR(priv->rf[SENSOR_EN]);
+			goto err_put_device;
+		}
+		priv->rf[INT_EN] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[INT_EN]);
+		if (IS_ERR(priv->rf[INT_EN])) {
+			ret = PTR_ERR(priv->rf[INT_EN]);
+			goto err_put_device;
+		}
+	} else {
+		priv->rf[TSENS_EN] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[TSENS_EN]);
+		if (IS_ERR(priv->rf[TSENS_EN])) {
+			ret = PTR_ERR(priv->rf[TSENS_EN]);
+			goto err_put_device;
+		}
+
+		priv->rf[TSENS_SW_RST] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[TSENS_EN]);
+		if (IS_ERR(priv->rf[TSENS_EN])) {
+			ret = PTR_ERR(priv->rf[TSENS_EN]);
+			goto err_put_device;
+		}
+
+		/* enable TSENS */
+		regmap_field_write(priv->rf[TSENS_EN], 1);
+
+		priv->rf[LOW_INT_CLEAR_0] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[LOW_INT_CLEAR_0]);
+		if (IS_ERR(priv->rf[LOW_INT_CLEAR_0])) {
+			ret = PTR_ERR(priv->rf[LOW_INT_CLEAR_0]);
+			goto err_put_device;
+		}
+
+		priv->rf[UP_INT_CLEAR_0] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[UP_INT_CLEAR_0]);
+		if (IS_ERR(priv->rf[UP_INT_CLEAR_0])) {
+			ret = PTR_ERR(priv->rf[UP_INT_CLEAR_0]);
+			goto err_put_device;
+		}
+
+		priv->rf[MIN_THRESH_0] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[MIN_THRESH_0]);
+		if (IS_ERR(priv->rf[MIN_THRESH_0])) {
+			ret = PTR_ERR(priv->rf[MIN_THRESH_0]);
+			goto err_put_device;
+		}
+
+		priv->rf[MAX_THRESH_0] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[MAX_THRESH_0]);
+		if (IS_ERR(priv->rf[MAX_THRESH_0])) {
+			ret = PTR_ERR(priv->rf[MAX_THRESH_0]);
+			goto err_put_device;
+		}
+
+		priv->rf[TRDY] = devm_regmap_field_alloc(dev, priv->tm_map,
+							 priv->fields[TRDY]);
+		if (IS_ERR(priv->rf[TRDY])) {
+			ret = PTR_ERR(priv->rf[TRDY]);
+			goto err_put_device;
+		}
 	}
+
 	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
 	if (ret)
 		goto err_put_device;
@@ -790,19 +883,6 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
-	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
-						      priv->fields[SENSOR_EN]);
-	if (IS_ERR(priv->rf[SENSOR_EN])) {
-		ret = PTR_ERR(priv->rf[SENSOR_EN]);
-		goto err_put_device;
-	}
-	priv->rf[INT_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
-						   priv->fields[INT_EN]);
-	if (IS_ERR(priv->rf[INT_EN])) {
-		ret = PTR_ERR(priv->rf[INT_EN]);
-		goto err_put_device;
-	}
-
 	/* This loop might need changes if enum regfield_ids is reordered */
 	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
 		for (i = 0; i < priv->feat->max_sensors; i++) {
@@ -856,7 +936,11 @@ int __init init_common(struct tsens_priv *priv)
 	}
 
 	spin_lock_init(&priv->ul_lock);
-	tsens_enable_irq(priv);
+
+	/* VER_0 interrupt doesn't need to be enabled */
+	if (tsens_version(priv) >= VER_0_1)
+		tsens_enable_irq(priv);
+
 	tsens_debug_init(op);
 
 err_put_device:
@@ -952,10 +1036,18 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 		if (irq == -ENXIO)
 			ret = 0;
 	} else {
-		ret = devm_request_threaded_irq(&pdev->dev, irq,
-						NULL, thread_fn,
-						IRQF_ONESHOT,
-						dev_name(&pdev->dev), priv);
+		/* VER_0 have a different interrupt type */
+		if (tsens_version(priv) > VER_0)
+			ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+							thread_fn, IRQF_ONESHOT,
+							dev_name(&pdev->dev),
+							priv);
+		else
+			ret = devm_request_threaded_irq(&pdev->dev, irq,
+							thread_fn, NULL,
+							IRQF_TRIGGER_RISING,
+							dev_name(&pdev->dev),
+							priv);
 		if (ret)
 			dev_err(&pdev->dev, "%s: failed to get irq\n",
 				__func__);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 59d01162c66a..f1120791737c 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -25,7 +25,8 @@ struct tsens_priv;
 
 /* IP version numbers in ascending order */
 enum tsens_ver {
-	VER_0_1 = 0,
+	VER_0 = 0,
+	VER_0_1,
 	VER_1_X,
 	VER_2_X,
 };
@@ -441,6 +442,10 @@ enum regfield_ids {
 	CRIT_THRESH_14,
 	CRIT_THRESH_15,
 
+	/* VER_0 MIN MAX THRESH */
+	MIN_THRESH_0,
+	MAX_THRESH_0,
+
 	/* WATCHDOG */
 	WDOG_BARK_STATUS,
 	WDOG_BARK_CLEAR,
-- 
2.27.0

