Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF90231E39A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 01:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhBRA5D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 19:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhBRA5B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 19:57:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342AC061756;
        Wed, 17 Feb 2021 16:56:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v15so790841wrx.4;
        Wed, 17 Feb 2021 16:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQALmQZNH/zw+Fq1U4219E8EmqsY5wcsdNNYDr2ZnVQ=;
        b=jqm++is8Df9xxA+3OY73oMZRJ+Adyl8byqhIIHC6ZqzU6MiARKA8WHLl6SahwX/Cyh
         v9l/Q06KoUTDwLSVZdo6hWLNtAnIPIyKgdCBcMuFvB/GsPrLfQ9fixZE2YQYnAaDZfn8
         jvKabas99e5jOpDks2QIjZb3/KfBXnmTPoQig1ewPkpQgPijxUElxrg5qYc1fFNijbWL
         2f1LwKpg/K8UCBhJI1KvHEIFSRcnLCH5ZzAeM4ftnH13Zn3SZKxswWQHnupi3hs1KpJ1
         gWfiD3K27jhjPA+RlbpqBUAf0AECKTy1+UcZZOZFJppZAx6VCyxticoSBuwIoRqCtKVW
         ahiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQALmQZNH/zw+Fq1U4219E8EmqsY5wcsdNNYDr2ZnVQ=;
        b=X4YTpSVcTtxGK8+CVdyosbJIbf4SPfu7Pc0BitcJm6w5bFs0rvXHKm7saqabQcLkhR
         BzG7B9K9Kxed9EKjL69aF2e+oMTIcPAXz5QtKiarsgRKW4SJYtyjvfU7nz3ryN0Gurm6
         GLTbGcnvYkacm5CQ/A7OvjmLkL7NOqmJ1kq1Z7sJcsZ4qMNs5iq/2fWEQWj1WkFRmhoj
         aPlMwvzCZuPD0BQ1eMI7d0fOEqyFTDJCYWlBaWYwFBWiatN+7+hfr02owo+o16LOjiAL
         V4EQXowwjVuEeieWqxHCcMhiIM31UaN44wZKS9nL8wXdEol19vwotPTAiqzFdfYLqeUH
         qqww==
X-Gm-Message-State: AOAM531zKgYbCzW5d4GFxFtU8padAERK/uoT/zD9vxAb7pUAZ35CmMT0
        wHEUSLZbEkFMa6fa5nIe1M4=
X-Google-Smtp-Source: ABdhPJxSeUdkW5BruVw7zQMXULjdG8coy4QqOiFoJRKs4e9jZ+JqcribEu0tdHxlHmlUUPbJJ4pe1A==
X-Received: by 2002:adf:f00c:: with SMTP id j12mr1699740wro.160.1613609779381;
        Wed, 17 Feb 2021 16:56:19 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-11-13-110.retail.telecomitalia.it. [87.11.13.110])
        by smtp.googlemail.com with ESMTPSA id t16sm6336079wrp.87.2021.02.17.16.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:56:18 -0800 (PST)
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
Subject: [PATCH v10 1/8] drivers: thermal: tsens: Add VER_0 tsens version
Date:   Wed, 17 Feb 2021 20:40:03 +0100
Message-Id: <20210217194011.22649-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217194011.22649-1-ansuelsmth@gmail.com>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
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
 drivers/thermal/qcom/tsens.c | 175 +++++++++++++++++++++++++++++------
 drivers/thermal/qcom/tsens.h |   4 +-
 2 files changed, 151 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a687b80..f9126909892b 100644
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
@@ -791,6 +841,57 @@ int __init init_common(struct tsens_priv *priv)
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
+	if (tsens_version(priv) < VER_0_1) {
+		priv->rf[CRIT_THRESH_0] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[CRIT_THRESH_0]);
+		if (IS_ERR(priv->rf[CRIT_THRESH_0])) {
+			ret = PTR_ERR(priv->rf[CRIT_THRESH_0]);
+			goto err_put_device;
+		}
+
+		priv->rf[CRIT_THRESH_1] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[CRIT_THRESH_1]);
+		if (IS_ERR(priv->rf[CRIT_THRESH_1])) {
+			ret = PTR_ERR(priv->rf[CRIT_THRESH_1]);
+			goto err_put_device;
+		}
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
@@ -844,7 +945,11 @@ int __init init_common(struct tsens_priv *priv)
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
@@ -930,7 +1035,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 			      irq_handler_t thread_fn)
 {
 	struct platform_device *pdev;
-	int ret, irq;
+	int ret, irq, irq_type = IRQF_ONESHOT;
 
 	pdev = of_find_device_by_node(priv->dev->of_node);
 	if (!pdev)
@@ -943,9 +1048,12 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
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
@@ -975,6 +1083,19 @@ static int tsens_register(struct tsens_priv *priv)
 			priv->ops->enable(priv, i);
 	}
 
+	/* VER_0 require to set MIN and MAX THRESH
+	 * These 2 regs are set using the:
+	 * - CRIT_THRESH_0 for MAX THRESH hardcoded to 120°C
+	 * - CRIT_THRESH_1 for MIN THRESH hardcoded to   0°C
+	 */
+	if (tsens_version(priv) < VER_0_1) {
+		regmap_field_write(priv->rf[CRIT_THRESH_0],
+				   tsens_mC_to_hw(priv->sensor, 120000));
+
+		regmap_field_write(priv->rf[CRIT_THRESH_1],
+				   tsens_mC_to_hw(priv->sensor, 0));
+	}
+
 	ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
 	if (ret < 0)
 		return ret;
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
2.30.0

