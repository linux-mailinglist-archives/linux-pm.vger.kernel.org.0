Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D84365F5E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhDTSep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhDTSel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:34:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0322C06138A;
        Tue, 20 Apr 2021 11:34:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so59719401ejc.10;
        Tue, 20 Apr 2021 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgR5/mxzM1+Fj9kTK0T9EAkQTgjyT5GnY4XwENoVN7s=;
        b=IY4QZ7lWFo+GW2wHVUz61EMQBwUw3XHRgDxR/HJvOfWuIeuZrAdQt6A1u2azhu6rOd
         qZPvJ418Ac/ScU1Nzxc79fJ7edY1NMf1eB0gdVTUKsgseenCoCPdxIDoCG1mc0uVzOMj
         UIuEL18A1mBKYggQFWFl0bAt2Ga8K3dI398+jVP+MooLLaWaq/s0zLRhmJpnD3iWdk7z
         7pVTabLKJSc0qSS0qfX07GiVC7aJ4HdRxTaSnK5Ie35e3tryHxG/apiCZchNcAqazQ+S
         KAyaZ72z3L28GC1yf1UbkHRVcvBJ0YHAaXRpYpMHEGUPkH0MCsmOOaY0iQpwg++v80GX
         C3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgR5/mxzM1+Fj9kTK0T9EAkQTgjyT5GnY4XwENoVN7s=;
        b=N0T3KyCTVcpz5BGdLOXr7PuZYngkMhJQr661RHpZMRrt3nnpDK1KYAhD29jBqM7zwT
         NNuUgnN11QzO70V75kcQXBNoMFp8Pbv6U6+PlqZE5kS/rYOK13QsL7549ziNRr33AcT1
         CiVPIE2N4yLadLmzw2njOlsHY/PFt/vETKKzYkQzVu5fXDRrBNkZCIMBx4EdPVR9smBD
         LyRlbm9y6iFcWKB5UJTAc5yM2Sz/q/3INvNyO7w6fl5ubCBjV7tJDgm6UPMrenNTwPxl
         RN0ysWk8P9PXmvJCwJ71lpwz20XhclNhrf6PZbsEYSHT9LszyjjwUN5ootH3E403e6dO
         4a9A==
X-Gm-Message-State: AOAM531ijRu10uZbrdCMXO9/41lP7l+e1RtJlGysBRvQRCskmTWt0trZ
        UMl00umq7FrgCpr1DtQ4/pk=
X-Google-Smtp-Source: ABdhPJxLNol6C8JGwgifsVn8z4e1vEAehiBwRgbY3GliTwEEZ8URLe8sjvI6SAu3RPbh1CgIaD1tog==
X-Received: by 2002:a17:907:3f9f:: with SMTP id hr31mr28658466ejc.349.1618943645397;
        Tue, 20 Apr 2021 11:34:05 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id n10sm13357141ejg.124.2021.04.20.11.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:34:04 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [thermal PATCH v15 3/9] drivers: thermal: tsens: Add VER_0 tsens version
Date:   Tue, 20 Apr 2021 20:33:37 +0200
Message-Id: <20210420183343.2272-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183343.2272-1-ansuelsmth@gmail.com>
References: <20210420183343.2272-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VER_0 is used to describe device based on tsens version before v0.1.
These device are devices based on msm8960 for example apq8064 or
ipq806x. Add support for VER_0 in tsens.c and set the right tsens feat
in tsens-8960.c file.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thermal/qcom/tsens-8960.c |   9 ++
 drivers/thermal/qcom/tsens.c      | 150 ++++++++++++++++++++++++------
 drivers/thermal/qcom/tsens.h      |   4 +-
 3 files changed, 133 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 0d0c2647d..0dd15e812 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -347,8 +347,17 @@ static const struct tsens_ops ops_8960 = {
 	.resume		= resume_8960,
 };
 
+static struct tsens_features tsens_8960_feat = {
+	.ver_major	= VER_0,
+	.crit_int	= 0,
+	.adc		= 1,
+	.srot_split	= 0,
+	.max_sensors	= 11,
+};
+
 struct tsens_plat_data data_8960 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8960,
+	.feat		= &tsens_8960_feat,
 	.fields		= tsens_8960_regfields,
 };
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 562c438ff..be0c5931f 100644
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
@@ -516,6 +517,15 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
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
@@ -531,6 +541,13 @@ int tsens_set_trips(void *_sensor, int low, int high)
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
 
@@ -585,18 +602,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
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
@@ -609,15 +629,29 @@ int get_temp_common(const struct tsens_sensor *s, int *temp)
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
+		if (tsens_version(priv) == VER_0) {
+			ret = regmap_field_read(priv->rf[TRDY], &trdy);
+			if (ret)
+				return ret;
+			if (!trdy)
+				continue;
+		}
 
-	*temp = code_to_degc(last_temp, s) * 1000;
+		ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
+		if (ret)
+			return ret;
 
-	return 0;
+		*temp = code_to_degc(last_temp, s) * 1000;
+
+		return 0;
+	} while (time_before(jiffies, timeout));
+
+	return -ETIMEDOUT;
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -739,19 +773,34 @@ int __init init_common(struct tsens_priv *priv)
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
-		ret = PTR_ERR(priv->tm_map);
+	if (IS_ERR_OR_NULL(priv->tm_map)) {
+		if (!priv->tm_map)
+			ret = -ENODEV;
+		else
+			ret = PTR_ERR(priv->tm_map);
 		goto err_put_device;
 	}
 
+	/* VER_0 have only tm_map */
+	if (!priv->srot_map)
+		priv->srot_map = priv->tm_map;
+
 	if (tsens_version(priv) > VER_0_1) {
 		for (i = VER_MAJOR; i <= VER_STEP; i++) {
 			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
@@ -770,6 +819,10 @@ int __init init_common(struct tsens_priv *priv)
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
@@ -792,6 +845,19 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
+	priv->rf[TSENS_SW_RST] =
+		devm_regmap_field_alloc(dev, priv->srot_map, priv->fields[TSENS_SW_RST]);
+	if (IS_ERR(priv->rf[TSENS_SW_RST])) {
+		ret = PTR_ERR(priv->rf[TSENS_SW_RST]);
+		goto err_put_device;
+	}
+
+	priv->rf[TRDY] = devm_regmap_field_alloc(dev, priv->tm_map, priv->fields[TRDY]);
+	if (IS_ERR(priv->rf[TRDY])) {
+		ret = PTR_ERR(priv->rf[TRDY]);
+		goto err_put_device;
+	}
+
 	/* This loop might need changes if enum regfield_ids is reordered */
 	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
 		for (i = 0; i < priv->feat->max_sensors; i++) {
@@ -807,7 +873,7 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
-	if (priv->feat->crit_int) {
+	if (priv->feat->crit_int || tsens_version(priv) < VER_0_1) {
 		/* Loop might need changes if enum regfield_ids is reordered */
 		for (j = CRITICAL_STATUS_0; j <= CRIT_THRESH_15; j += 16) {
 			for (i = 0; i < priv->feat->max_sensors; i++) {
@@ -845,7 +911,11 @@ int __init init_common(struct tsens_priv *priv)
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
@@ -941,10 +1011,19 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 		if (irq == -ENXIO)
 			ret = 0;
 	} else {
-		ret = devm_request_threaded_irq(&pdev->dev, irq,
-						NULL, thread_fn,
-						IRQF_ONESHOT,
-						dev_name(&pdev->dev), priv);
+		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
+		if (tsens_version(priv) == VER_0)
+			ret = devm_request_threaded_irq(&pdev->dev, irq,
+							thread_fn, NULL,
+							IRQF_TRIGGER_RISING,
+							dev_name(&pdev->dev),
+							priv);
+		else
+			ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+							thread_fn, IRQF_ONESHOT,
+							dev_name(&pdev->dev),
+							priv);
+
 		if (ret)
 			dev_err(&pdev->dev, "%s: failed to get irq\n",
 				__func__);
@@ -973,6 +1052,19 @@ static int tsens_register(struct tsens_priv *priv)
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
index 59d01162c..5dbed0a3f 100644
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
2.30.2

