Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695852C4D30
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 03:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbgKZCM2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 21:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbgKZCM0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 21:12:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610E2C0613D4;
        Wed, 25 Nov 2020 18:12:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q16so533084edv.10;
        Wed, 25 Nov 2020 18:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RAarhppgBK7+aX8M/sAYyN7ZA+uJCDtTAY1PkQ2qLQw=;
        b=SNBsC6UVQD2oAq98zCCCBBxHADzjs4AGPCIAfGWmyzOssx2F4xFcSh6vppd+krG/wR
         ScCrRtRxI+EMWpWNhGgRO4UcDhHfXMR8JzDONwsq2vAuV5/YGm5AUh1PpcO/FxcL2V88
         JXqMMxRAlKQtfUyf2kA8eNHfCIo220Y1NJ0PWz2Aq7uVffjwbIRSKFu1LpbGcbP9Yu/+
         PnNqRgR/BE8SfVHMALhDNlWNWNpeQrIbL0IM/0fXmAEWcXvwdXXVpj38fEMJzFvIhzMP
         FJs3GTkb7VhDDrdDiiVhu8TXA0He6fDXgtA6Vll3l37fB1m1rsqTvdbr+iKz4rrh/012
         ZMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RAarhppgBK7+aX8M/sAYyN7ZA+uJCDtTAY1PkQ2qLQw=;
        b=pXYoRqul5II0yYExdjNE6pIYz0ChzxzVaJU12FWYIzzatNKp9cK6wnAqhV294n4LcI
         avzehQyD7a6Y1HydJvNWfD7FEVGkvtw6OBhx+zzAW9NT3JEni2YoA+M5I5R/YasFDUad
         BbPY7yuWIq549J6XrzWxgvM8/AFNI67U7qiEmF8gC8BK4Y9mmpNzH2+isG8aERCkIeXc
         e0r0xbnBOL0rzGhZ2JKKoo8bFSpWO3/cDk6fceS8V17JaxsZdc8Co1cu6dMmChZMb0Ie
         ow71gwBb/kiZ7caI/F15YL3XFqi163KN34zdImQVjDtKJ+78tGGDC9mPGp9f1ULSXWOr
         J2xw==
X-Gm-Message-State: AOAM533juRGkV21RWy+SLAbAuMsyj7HFw8nV4JkciXkFbbmLZ4TugBlv
        xTNs6gQF5J0jEKbJO4SmKiE=
X-Google-Smtp-Source: ABdhPJyoiyLD05+CDmcehT6U9g5YXacwvxvoTS+FMElcbdi4JGSRbambxMDI4brGyTkzIkrXg+6l0Q==
X-Received: by 2002:a50:c050:: with SMTP id u16mr482267edd.177.1606356744957;
        Wed, 25 Nov 2020 18:12:24 -0800 (PST)
Received: from ansuel-xps20.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id d7sm417276edv.17.2020.11.25.18.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 18:12:24 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/8] drivers: thermal: tsens: Add VER_0 tsens version
Date:   Wed, 25 Nov 2020 18:48:18 +0100
Message-Id: <20201125174826.24462-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125174826.24462-1-ansuelsmth@gmail.com>
References: <20201125174826.24462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VER_0 is used to describe device based on tsens version before v0.1.
These device are devices based on msm8960 for example apq8064 or
ipq806x.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 166 +++++++++++++++++++++++++++++------
 drivers/thermal/qcom/tsens.h |   8 +-
 2 files changed, 146 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a687b80..bda965b3ac05 100644
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
@@ -791,6 +841,61 @@ int __init init_common(struct tsens_priv *priv)
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
+	/* VER_0 require to set MIN and MAX THRESH */
+	if (tsens_version(priv) < VER_0_1) {
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
+		regmap_field_write(priv->rf[MIN_THRESH_0], 0);
+		regmap_field_write(priv->rf[MAX_THRESH_0], 120000);
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
@@ -844,7 +949,11 @@ int __init init_common(struct tsens_priv *priv)
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
@@ -930,7 +1039,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 			      irq_handler_t thread_fn)
 {
 	struct platform_device *pdev;
-	int ret, irq;
+	int ret, irq, irq_type = IRQF_ONESHOT;
 
 	pdev = of_find_device_by_node(priv->dev->of_node);
 	if (!pdev)
@@ -943,9 +1052,12 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
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
index f40b625f897e..42c12639582f 100644
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
@@ -441,6 +443,10 @@ enum regfield_ids {
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
2.29.2

