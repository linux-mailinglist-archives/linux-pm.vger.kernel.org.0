Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9093007A5
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbhAVPnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbhAVO4t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:56:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DDC061788;
        Fri, 22 Jan 2021 06:56:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y187so4580906wmd.3;
        Fri, 22 Jan 2021 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ch8IKvo9eT0XCMxC8iMOyIdf1EBIrdJx0brQO9yCesY=;
        b=SYfsz/O1Aox4iJ3pToBchspRTvbLnUaI3Mg6AllFe4aHAZ8+OFq/I32HGCYLWrjY5k
         kYRJAVZ5HZF+GENsOG6uUSJ/uOlXLOaJLPS/2RS+bLlZ92JVEKHD4mAB9HonXbsngJNf
         loWRuYyfjPYBFfxS3bnGIz6Z+r1rM9P4YCLOdUBVQHkNVmF6CQHK1jpzgPYM4lz76/Rb
         lsm1t8kwN+UwJUqkv20nbw57AwCljTK5wOQ74yYoXjqWE+k0OeEcnJ39Af6V6t+SkN51
         x9LMPRvF1AeQQVJ4bC4EoH5JpyIXwYrvc0uRycHlP2ywUxd5UKPgjTE7EdSK7xeDIPGn
         jLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ch8IKvo9eT0XCMxC8iMOyIdf1EBIrdJx0brQO9yCesY=;
        b=EahQU82UZWpqyMXZ6r9CnBXu3u7HScPbjkt+0TZtiqEoawD9YxmqOoa7pnCS33PsNr
         af8HAjc72ck5lx0U6We5OGS1KAL1aR4iF7RXJ9fWmdSUA8mKxbgbs5uo6M7nVhOHi20d
         C+JyS3/hpN32v5qJRpwt+4r8tDjyLoJZ/8cZqXwj4WOd4p9QnlmLCekmjRmWA+VplbkZ
         T4dgN83a+Yc4ZPGHUscTtqel6ZkIrzqhK6c3z/KSjVzg8/vWxJaLgA6+svaMtqTaP/Tx
         y9bJJIbMqfSnqnvvvQgTtR2HoLgBvWwlZNt2ZmzjyJc9VFK+UAwfz4KxqmrNk8pwcTzm
         fe+g==
X-Gm-Message-State: AOAM5317GDop1FKUB8eMKp/WoLpMSQ7hvYylOC0+Zc3pDIkwD8gbqK9V
        TFKMcFWI8GxBYkCwCoRry1g=
X-Google-Smtp-Source: ABdhPJyLT1y+exfr8wGr/+kmb97MYHPL2RXhOAj2FSg8k56X2x0dyjJYuVkcB5La+X6JugZ8jD11hA==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr4466710wmc.64.1611327367982;
        Fri, 22 Jan 2021 06:56:07 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-45-3-77.retail.telecomitalia.it. [79.45.3.77])
        by smtp.googlemail.com with ESMTPSA id t67sm12061106wmt.28.2021.01.22.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:56:07 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/8] drivers: thermal: tsens: Add VER_0 tsens version
Date:   Fri, 22 Jan 2021 15:55:50 +0100
Message-Id: <20210122145558.4982-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122145558.4982-1-ansuelsmth@gmail.com>
References: <20210122145558.4982-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VER_0 is used to describe device based on tsens version before v0.1.
These device are devices based on msm8960 for example apq8064 or
ipq806x.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 171 +++++++++++++++++++++++++++++------
 drivers/thermal/qcom/tsens.h |   4 +-
 2 files changed, 147 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a687b80..eaeaa1d69d92 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
@@ -515,6 +516,15 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
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
@@ -530,6 +540,13 @@ static int tsens_set_trips(void *_sensor, int low, int high)
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
 
@@ -584,18 +601,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
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
@@ -608,15 +628,29 @@ int get_temp_common(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
-	int last_temp = 0, ret;
+	int last_temp = 0, ret, trdy;
+	unsigned long timeout;
 
-	ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
-	if (ret)
-		return ret;
+	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
+	do {
+		if (priv->rf[TRDY]) {
+			ret = regmap_field_read(priv->rf[TRDY], &trdy);
+			if (ret)
+				return ret;
+			if (!trdy)
+				continue;
+		}
+
+		ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
+		if (ret)
+			return ret;
 
-	*temp = code_to_degc(last_temp, s) * 1000;
+		*temp = code_to_degc(last_temp, s) * 1000;
 
-	return 0;
+		return 0;
+	} while (time_before(jiffies, timeout));
+
+	return -ETIMEDOUT;
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -738,19 +772,31 @@ int __init init_common(struct tsens_priv *priv)
 		priv->tm_offset = 0x1000;
 	}
 
-	res = platform_get_resource(op, IORESOURCE_MEM, 0);
-	tm_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(tm_base)) {
-		ret = PTR_ERR(tm_base);
-		goto err_put_device;
+	if (tsens_version(priv) >= VER_0_1) {
+		res = platform_get_resource(op, IORESOURCE_MEM, 0);
+		tm_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(tm_base)) {
+			ret = PTR_ERR(tm_base);
+			goto err_put_device;
+		}
+
+		priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
+	} else { /* VER_0 share the same gcc regs using a syscon */
+		struct device *parent = priv->dev->parent;
+
+		if (parent)
+			priv->tm_map = syscon_node_to_regmap(parent->of_node);
 	}
 
-	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
-	if (IS_ERR(priv->tm_map)) {
+	if (IS_ERR_OR_NULL(priv->tm_map)) {
 		ret = PTR_ERR(priv->tm_map);
 		goto err_put_device;
 	}
 
+	/* VER_0 have only tm_map */
+	if (!priv->srot_map)
+		priv->srot_map = priv->tm_map;
+
 	if (tsens_version(priv) > VER_0_1) {
 		for (i = VER_MAJOR; i <= VER_STEP; i++) {
 			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
@@ -769,6 +815,10 @@ int __init init_common(struct tsens_priv *priv)
 		ret = PTR_ERR(priv->rf[TSENS_EN]);
 		goto err_put_device;
 	}
+	/* in VER_0 TSENS need to be explicitly enabled */
+	if (tsens_version(priv) == VER_0)
+		regmap_field_write(priv->rf[TSENS_EN], 1);
+
 	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
 	if (ret)
 		goto err_put_device;
@@ -791,6 +841,66 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
+	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
+						     priv->fields[TSENS_EN]);
+	if (IS_ERR(priv->rf[TSENS_EN])) {
+		ret = PTR_ERR(priv->rf[TSENS_EN]);
+		goto err_put_device;
+	}
+
+	priv->rf[TSENS_SW_RST] = devm_regmap_field_alloc(
+		dev, priv->tm_map, priv->fields[TSENS_EN]);
+	if (IS_ERR(priv->rf[TSENS_EN])) {
+		ret = PTR_ERR(priv->rf[TSENS_EN]);
+		goto err_put_device;
+	}
+
+	priv->rf[LOW_INT_CLEAR_0] = devm_regmap_field_alloc(
+		dev, priv->tm_map, priv->fields[LOW_INT_CLEAR_0]);
+	if (IS_ERR(priv->rf[LOW_INT_CLEAR_0])) {
+		ret = PTR_ERR(priv->rf[LOW_INT_CLEAR_0]);
+		goto err_put_device;
+	}
+
+	priv->rf[UP_INT_CLEAR_0] = devm_regmap_field_alloc(
+		dev, priv->tm_map, priv->fields[UP_INT_CLEAR_0]);
+	if (IS_ERR(priv->rf[UP_INT_CLEAR_0])) {
+		ret = PTR_ERR(priv->rf[UP_INT_CLEAR_0]);
+		goto err_put_device;
+	}
+
+	/* VER_0 require to set MIN and MAX THRESH
+	 * These 2 regs are set using the:
+	 * - CRIT_THRESH_0 for MAX THRESH hardcoded to 120°C
+	 * - CRIT_THRESH_1 for MIN THRESH hardcoded to   0°C
+	 */
+	if (tsens_version(priv) < VER_0_1) {
+		priv->rf[CRIT_THRESH_0] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[CRIT_THRESH_0]);
+		if (IS_ERR(priv->rf[CRIT_THRESH_0])) {
+			ret = PTR_ERR(priv->rf[CRIT_THRESH_0]);
+			goto err_put_device;
+		}
+		regmap_field_write(priv->rf[CRIT_THRESH_0],
+				   tsens_mC_to_hw(priv->sensor, 120000));
+
+		priv->rf[CRIT_THRESH_1] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[CRIT_THRESH_1]);
+		if (IS_ERR(priv->rf[CRIT_THRESH_1])) {
+			ret = PTR_ERR(priv->rf[CRIT_THRESH_1]);
+			goto err_put_device;
+		}
+		regmap_field_write(priv->rf[CRIT_THRESH_1],
+				   tsens_mC_to_hw(priv->sensor, 0));
+	}
+
+	priv->rf[TRDY] =
+		devm_regmap_field_alloc(dev, priv->tm_map, priv->fields[TRDY]);
+	if (IS_ERR(priv->rf[TRDY])) {
+		ret = PTR_ERR(priv->rf[TRDY]);
+		goto err_put_device;
+	}
+
 	/* This loop might need changes if enum regfield_ids is reordered */
 	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
 		for (i = 0; i < priv->feat->max_sensors; i++) {
@@ -844,7 +954,11 @@ int __init init_common(struct tsens_priv *priv)
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
@@ -930,7 +1044,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 			      irq_handler_t thread_fn)
 {
 	struct platform_device *pdev;
-	int ret, irq;
+	int ret, irq, irq_type = IRQF_ONESHOT;
 
 	pdev = of_find_device_by_node(priv->dev->of_node);
 	if (!pdev)
@@ -943,9 +1057,12 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 		if (irq == -ENXIO)
 			ret = 0;
 	} else {
-		ret = devm_request_threaded_irq(&pdev->dev, irq,
-						NULL, thread_fn,
-						IRQF_ONESHOT,
+		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
+		if (tsens_version(priv) == VER_0)
+			irq_type = IRQF_TRIGGER_RISING;
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, thread_fn,
+						NULL, irq_type,
 						dev_name(&pdev->dev), priv);
 		if (ret)
 			dev_err(&pdev->dev, "%s: failed to get irq\n",
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index f40b625f897e..8e6c1fd3ccf5 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -13,6 +13,7 @@
 #define CAL_DEGC_PT2		120
 #define SLOPE_FACTOR		1000
 #define SLOPE_DEFAULT		3200
+#define TIMEOUT_US		100
 #define THRESHOLD_MAX_ADC_CODE	0x3ff
 #define THRESHOLD_MIN_ADC_CODE	0x0
 
@@ -25,7 +26,8 @@ struct tsens_priv;
 
 /* IP version numbers in ascending order */
 enum tsens_ver {
-	VER_0_1 = 0,
+	VER_0 = 0,
+	VER_0_1,
 	VER_1_X,
 	VER_2_X,
 };
-- 
2.29.2

