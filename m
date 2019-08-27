Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F1A9E7A1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 14:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfH0MP3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 08:15:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43976 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfH0MP3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 08:15:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so14009593pfn.10
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IoBQlRXL7J7OURIjzZFYzxBPbGARI4qXRpxSL665hN0=;
        b=qT8LDbims05+D31gjdL6V3SIMgVyFpYvRHN5Pj5xScw+1yljoU1rz2BXLnnLvzrPAd
         9/vqfUBFmnEfRaMChsFTzFb5Ufi8qG0yjoe0SiHY+NvIZ1aE5Cjld+osEK3ChqPmA8HO
         bc+zx9l7k8H/7KYBIcR33rEo4Gehdsm+OojLUfiYdHFJ2KkgSyVSofP8ODdz11u6fl24
         h/anl2d9T10E8CTncRzZfSKvTtF2aMcD3QZDDYz+0MW/R3Ff/1eCF0KJeKgkRK7/kYV3
         qQzkk73bdk87foi7KGhrYWh/ABBcAdRkmRpyodNSrV0KNHQJnOF/ULYK+h2eWSFKKH5N
         h9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IoBQlRXL7J7OURIjzZFYzxBPbGARI4qXRpxSL665hN0=;
        b=go4Txftx+KvXVmjrpp0Ky1l8Cj4NrbX/mWoqY0k5aTHXMQnAMWm4YCnf71couqNpBd
         PGx9WaQ6ilGi9A7fJ8WyXN67a4uwTuAuzZ6+qbxnvlve1MGbwEUfnPu+M1G9E3w/IC0E
         YVjFaztvjsBqoWiYEBNkfpp7rOS77E0JfadwgqbgYH9QNIqzIpDmwXTDLT6iew+mAh0H
         uiuMoOPFK88R5JHU029Js47fy2zSdZ1rQOmFd26VZ23XI0Gga4xAFZMRHm1u9EKrw6/s
         IfC5kCIkpPixRAkmLipXSsExnN9DHnHwOPCQb9+2VXfht+Bd5JQorpWgDxGDdBgkF2wd
         qdsg==
X-Gm-Message-State: APjAAAXU2giKicBlb7pRGItw6u1iLA7xWt/YII+csa+LAdmqYJjwdnat
        htkpegDhXQvOyXYmKnS1otHzig==
X-Google-Smtp-Source: APXvYqyYVvVyl6B9BoybBQVEOe5X6O0QcuGWNbgLUeG0mgA7t9VdnL4bFluVKlxwwldy/ZOHqeZfkg==
X-Received: by 2002:a62:34c4:: with SMTP id b187mr26282986pfa.161.1566908127087;
        Tue, 27 Aug 2019 05:15:27 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id i137sm20147432pgc.4.2019.08.27.05.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:15:26 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 15/15] drivers: thermal: tsens: Add interrupt support
Date:   Tue, 27 Aug 2019 17:44:11 +0530
Message-Id: <a4666f8afa39471658602e06758b04a991f80828.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Depending on the IP version, TSENS supports upper, lower, max, min and
critical threshold interrupts. We only add support for upper and lower
threshold interrupts for now.

TSENSv2 has an irq [status|clear|mask] bit tuple for each sensor while
earlier versions only have a single bit per sensor to denote status and
clear. At each interrupt, we reprogram the new upper and lower threshold
in the .set_trip callback.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 377 ++++++++++++++++++++++++++--
 drivers/thermal/qcom/tsens-v0_1.c   |  11 +
 drivers/thermal/qcom/tsens-v1.c     |  29 +++
 drivers/thermal/qcom/tsens-v2.c     |  13 +
 drivers/thermal/qcom/tsens.c        |  32 ++-
 drivers/thermal/qcom/tsens.h        | 270 ++++++++++++++++----
 6 files changed, 669 insertions(+), 63 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 06b44cfd5eab9..c549f8e1488ba 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -13,6 +13,30 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
+/** struct tsens_irq_data - IRQ status and temperature violations
+ * @up_viol:        upper threshold violated
+ * @up_thresh:      upper threshold temperature value
+ * @up_irq_mask:    mask register for upper threshold irqs
+ * @up_irq_clear:   clear register for uppper threshold irqs
+ * @low_viol:       lower threshold violated
+ * @low_thresh:     lower threshold temperature value
+ * @low_irq_mask:   mask register for lower threshold irqs
+ * @low_irq_clear:  clear register for lower threshold irqs
+ *
+ * Structure containing data about temperature threshold settings and
+ * irq status if they were violated.
+ */
+struct tsens_irq_data {
+	u32 up_viol;
+	int up_thresh;
+	u32 up_irq_mask;
+	u32 up_irq_clear;
+	u32 low_viol;
+	int low_thresh;
+	u32 low_irq_mask;
+	u32 low_irq_clear;
+};
+
 char *qfprom_read(struct device *dev, const char *cname)
 {
 	struct nvmem_cell *cell;
@@ -65,6 +89,14 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	}
 }
 
+static inline u32 degc_to_code(int degc, const struct tsens_sensor *sensor)
+{
+	u64 code = (degc * sensor->slope + sensor->offset) / SLOPE_FACTOR;
+
+	pr_debug("%s: raw_code: 0x%llx, degc:%d\n", __func__, code, degc);
+	return clamp_val(code, THRESHOLD_MIN_ADC_CODE, THRESHOLD_MAX_ADC_CODE);
+}
+
 static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 {
 	int degc, num, den;
@@ -114,6 +146,314 @@ static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
 	return sign_extend32(temp, priv->tempres) * 100;
 }
 
+/**
+ * tsens_mC_to_hw - Return correct value to be written to threshold
+ * registers, whether in ADC code or deciCelsius depending on IP version
+ */
+static int tsens_mC_to_hw(struct tsens_sensor *s, int temp)
+{
+	struct tsens_priv *priv = s->priv;
+
+	if (priv->feat->adc) {
+		/* milliC to C to adc code */
+		return degc_to_code(temp / 1000, s);
+	}
+
+	/* milliC to deciC */
+	return temp / 100;
+}
+
+static inline unsigned int tsens_ver(struct tsens_priv *priv)
+{
+	return priv->feat->ver_major;
+}
+
+/**
+ * tsens_set_interrupt_v1 - Disable an interrupt (enable = false)
+ *                          Re-enable an interrupt (enable = true)
+ */
+static void tsens_set_interrupt_v1(struct tsens_priv *priv, u32 hw_id,
+				   enum tsens_irq_type irq_type, bool enable)
+{
+	u32 index;
+
+	if (enable) {
+		switch (irq_type) {
+		case UPPER:
+			index = UP_INT_CLEAR_0 + hw_id;
+			break;
+		case LOWER:
+			index = LOW_INT_CLEAR_0 + hw_id;
+			break;
+		}
+		regmap_field_write(priv->rf[index], 0);
+	} else {
+		switch (irq_type) {
+		case UPPER:
+			index = UP_INT_CLEAR_0 + hw_id;
+			break;
+		case LOWER:
+			index = LOW_INT_CLEAR_0 + hw_id;
+			break;
+		}
+		regmap_field_write(priv->rf[index], 1);
+	}
+}
+
+/**
+ * tsens_set_interrupt_v2 - Disable an interrupt (enable = false)
+ *                          Re-enable an interrupt (enable = true)
+ */
+static void tsens_set_interrupt_v2(struct tsens_priv *priv, u32 hw_id,
+				   enum tsens_irq_type irq_type, bool enable)
+{
+	u32 index_mask, index_clear;
+
+	if (enable) {
+		switch (irq_type) {
+		case UPPER:
+			index_mask = UP_INT_MASK_0 + hw_id;
+			break;
+		case LOWER:
+			index_mask = LOW_INT_MASK_0 + hw_id;
+			break;
+		}
+		regmap_field_write(priv->rf[index_mask], 0);
+	} else {
+		/* To disable the interrupt flag for a sensor:
+		 *  1. Mask further interrupts for this sensor
+		 *  2. Write 1 followed by 0 to clear the interrupt
+		 */
+		switch (irq_type) {
+		case UPPER:
+			index_mask  = UP_INT_MASK_0 + hw_id;
+			index_clear = UP_INT_CLEAR_0 + hw_id;
+			break;
+		case LOWER:
+			index_mask  = LOW_INT_MASK_0 + hw_id;
+			index_clear = LOW_INT_CLEAR_0 + hw_id;
+			break;
+		}
+		regmap_field_write(priv->rf[index_mask], 1);
+		regmap_field_write(priv->rf[index_clear], 1);
+		regmap_field_write(priv->rf[index_clear], 0);
+	}
+}
+
+/**
+ * tsens_set_interrupt - Disable an interrupt (enable = false)
+ *                       Re-enable an interrupt (enable = true)
+ */
+static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
+				enum tsens_irq_type irq_type, bool enable)
+{
+	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
+		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
+		enable ? "en" : "dis");
+	if (tsens_ver(priv) > VER_1_X)
+		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
+	else
+		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
+}
+
+/**
+ * tsens_threshold_violated - Check if a sensor temperature violated a preset threshold
+ *
+ * Return: 0 if threshold was not violated, 1 if it was violated and negative
+ * errno in case of errors
+ */
+static int tsens_threshold_violated(struct tsens_priv *priv, u32 hw_id,
+				    struct tsens_irq_data *d)
+{
+	int ret;
+
+	ret = regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id], &d->up_viol);
+	if (ret)
+		return ret;
+	ret = regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &d->low_viol);
+	if (ret)
+		return ret;
+	if (d->up_viol || d->low_viol)
+		return 1;
+
+	return 0;
+}
+
+static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
+				struct tsens_sensor *s, struct tsens_irq_data *d)
+{
+	int ret;
+
+	ret = regmap_field_read(priv->rf[UP_INT_CLEAR_0 + hw_id], &d->up_irq_clear);
+	if (ret)
+		return ret;
+	ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
+	if (ret)
+		return ret;
+	if (tsens_ver(priv) > VER_1_X) {
+		ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[LOW_INT_MASK_0 + hw_id], &d->low_irq_mask);
+		if (ret)
+			return ret;
+	} else {
+		/* No mask register on older TSENS */
+		d->up_irq_mask = 0;
+		d->low_irq_mask = 0;
+	}
+
+	d->up_thresh = tsens_hw_to_mC(s, UP_THRESH_0 + hw_id);
+	d->low_thresh = tsens_hw_to_mC(s, LOW_THRESH_0 + hw_id);
+
+	dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u) | clr(%u|%u) | mask(%u|%u)\n",
+		hw_id, __func__, (d->up_viol || d->low_viol) ? "(V)" : "",
+		d->low_viol, d->up_viol, d->low_irq_clear, d->up_irq_clear,
+		d->low_irq_mask, d->up_irq_mask);
+	dev_dbg(priv->dev, "[%u] %s%s: thresh: (%d:%d)\n", hw_id, __func__,
+		(d->up_viol || d->low_viol) ? "(violation)" : "",
+		d->low_thresh, d->up_thresh);
+
+	return 0;
+}
+
+static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
+{
+	if (ver > VER_1_X)
+		return mask & (1 << hw_id);
+
+	/* v1, v0.1 don't have a irq mask register */
+	return 0;
+}
+
+irqreturn_t tsens_irq_thread(int irq, void *data)
+{
+	struct tsens_priv *priv = data;
+	struct tsens_irq_data d;
+	bool enable = true, disable = false;
+	unsigned long flags;
+	int temp, ret, i;
+
+	/*
+	 * Check if any sensor raised an IRQ - for each sensor connected to the
+	 * TSENS block if it set the threshold violation bit.
+	 */
+	for (i = 0; i < priv->num_sensors; i++) {
+		bool trigger = 0;
+		struct tsens_sensor *s = &priv->sensor[i];
+		u32 hw_id = s->hw_id;
+
+		if (IS_ERR(priv->sensor[i].tzd))
+			continue;
+		if (!tsens_threshold_violated(priv, hw_id, &d))
+			continue;
+		ret = get_temp_tsens_valid(s, &temp);
+		if (ret) {
+			dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
+			continue;
+		}
+
+		spin_lock_irqsave(&priv->ul_lock, flags);
+
+		tsens_read_irq_state(priv, hw_id, s, &d);
+
+		if (d.up_viol &&
+		    !masked_irq(hw_id, d.up_irq_mask, tsens_ver(priv))) {
+			tsens_set_interrupt(priv, hw_id, UPPER, disable);
+			if (d.up_thresh > temp) {
+				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
+					priv->sensor[i].hw_id, __func__);
+				/* unmask the interrupt for this sensor */
+				tsens_set_interrupt(priv, hw_id, UPPER, enable);
+			} else {
+				trigger = 1;
+				/* Keep irq masked */
+			}
+		} else if (d.low_viol &&
+			   !masked_irq(hw_id, d.low_irq_mask, tsens_ver(priv))) {
+			tsens_set_interrupt(priv, hw_id, LOWER, disable);
+			if (d.low_thresh < temp) {
+				dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
+					priv->sensor[i].hw_id, __func__);
+				/* unmask the interrupt for this sensor */
+				tsens_set_interrupt(priv, hw_id, LOWER, enable);
+			} else {
+				trigger = 1;
+				/* Keep irq masked */
+			}
+		}
+
+		spin_unlock_irqrestore(&priv->ul_lock, flags);
+
+		if (trigger) {
+			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
+				hw_id, __func__, temp);
+			thermal_zone_device_update(priv->sensor[i].tzd,
+						   THERMAL_EVENT_UNSPECIFIED);
+		} else {
+			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
+				hw_id, __func__, temp);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+int tsens_set_trips(void *_sensor, int low, int high)
+{
+	struct tsens_sensor *s = _sensor;
+	struct tsens_priv *priv = s->priv;
+	struct device *dev = priv->dev;
+	struct tsens_irq_data d;
+	unsigned long flags;
+	int high_val, low_val, cl_high, cl_low;
+	bool enable = true;
+	u32 hw_id = s->hw_id;
+
+	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
+		hw_id, __func__, low, high);
+
+	cl_high = clamp_val(high, -40000, 120000);
+	cl_low  = clamp_val(low, -40000, 120000);
+
+	high_val = tsens_mC_to_hw(s, cl_high);
+	low_val  = tsens_mC_to_hw(s, cl_low);
+
+	spin_lock_irqsave(&priv->ul_lock, flags);
+
+	tsens_read_irq_state(priv, hw_id, s, &d);
+
+	/* Write the new thresholds and clear the status */
+	regmap_field_write(priv->rf[LOW_THRESH_0 + hw_id], low_val);
+	regmap_field_write(priv->rf[UP_THRESH_0 + hw_id], high_val);
+	tsens_set_interrupt(priv, hw_id, LOWER, enable);
+	tsens_set_interrupt(priv, hw_id, UPPER, enable);
+
+	spin_unlock_irqrestore(&priv->ul_lock, flags);
+
+	dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
+		s->hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
+
+	return 0;
+}
+
+int tsens_enable_irq(struct tsens_priv *priv)
+{
+	int ret;
+	int val = tsens_ver(priv) > VER_1_X ? 7 : 1;
+
+	ret = regmap_field_write(priv->rf[INT_EN], val);
+	if (ret < 0)
+		dev_err(priv->dev, "%s: failed to enable interrupts\n", __func__);
+
+	return ret;
+}
+
+void tsens_disable_irq(struct tsens_priv *priv)
+{
+	regmap_field_write(priv->rf[INT_EN], 0);
+}
+
 int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
@@ -319,28 +659,31 @@ int __init init_common(struct tsens_priv *priv)
 		ret = PTR_ERR(priv->rf[SENSOR_EN]);
 		goto err_put_device;
 	}
-	/* now alloc regmap_fields in tm_map */
-	for (i = 0, j = LAST_TEMP_0; i < priv->feat->max_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
-						      priv->fields[j]);
-		if (IS_ERR(priv->rf[j])) {
-			ret = PTR_ERR(priv->rf[j]);
-			goto err_put_device;
-		}
+	priv->rf[INT_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
+						   priv->fields[INT_EN]);
+	if (IS_ERR(priv->rf[INT_EN])) {
+		ret = PTR_ERR(priv->rf[INT_EN]);
+		goto err_put_device;
 	}
 
-	/* Save away resolution of signed temperature value for this IP */
-	priv->tempres = priv->fields[LAST_TEMP_0].msb - priv->fields[LAST_TEMP_0].lsb;
-
-	for (i = 0, j = VALID_0; i < priv->feat->max_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
-						      priv->fields[j]);
-		if (IS_ERR(priv->rf[j])) {
-			ret = PTR_ERR(priv->rf[j]);
-			goto err_put_device;
+	/* This loop might need changes if enum regfield_ids is reordered */
+	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
+		for (i = 0; i < priv->feat->max_sensors; i++) {
+			int idx = j + i;
+
+			priv->rf[idx] = devm_regmap_field_alloc(dev, priv->tm_map,
+								priv->fields[idx]);
+			if (IS_ERR(priv->rf[idx])) {
+				ret = PTR_ERR(priv->rf[idx]);
+				goto err_put_device;
+			}
 		}
 	}
+	/* Save away resolution of signed temperature value for this IP */
+	priv->tempres = priv->fields[LAST_TEMP_0].msb - priv->fields[LAST_TEMP_0].lsb;
 
+	spin_lock_init(&priv->ul_lock);
+	tsens_enable_irq(priv);
 	tsens_debug_init(op);
 
 	return 0;
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 6f26fadf4c279..a267b66e61d6b 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -339,9 +339,20 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	/* INTERRUPT ENABLE */
 	[INT_EN] = REG_FIELD(TM_INT_EN_OFF, 0, 0),
 
+	/* UPPER/LOWER TEMPERATURE THRESHOLDS */
+	REG_FIELD_FOR_EACH_SENSOR11(LOW_THRESH,    TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF,  0,  9),
+	REG_FIELD_FOR_EACH_SENSOR11(UP_THRESH,     TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 10, 19),
+
+	/* UPPER/LOWER INTERRUPTS [CLEAR/STATUS] */
+	REG_FIELD_FOR_EACH_SENSOR11(LOW_INT_CLEAR, TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 20, 20),
+	REG_FIELD_FOR_EACH_SENSOR11(UP_INT_CLEAR,  TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 21, 21),
+
+	/* NO CRITICAL INTERRUPT SUPPORT on v0.1 */
+
 	/* Sn_STATUS */
 	REG_FIELD_FOR_EACH_SENSOR11(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
 	/* No VALID field on v0.1 */
+	/* xxx_STATUS bits: 1 == threshold violated */
 	REG_FIELD_FOR_EACH_SENSOR11(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
 	REG_FIELD_FOR_EACH_SENSOR11(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
 	REG_FIELD_FOR_EACH_SENSOR11(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 10b595d4f6199..86259c9821be8 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -17,6 +17,8 @@
 #define TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF	0x0004
 #define TM_Sn_STATUS_OFF			0x0044
 #define TM_TRDY_OFF				0x0084
+#define TM_HIGH_LOW_INT_STATUS_OFF		0x0088
+#define TM_HIGH_LOW_Sn_INT_THRESHOLD_OFF	0x0090
 
 /* eeprom layout data for qcs404/405 (v1) */
 #define BASE0_MASK	0x000007f8
@@ -167,9 +169,36 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	/* INTERRUPT ENABLE */
 	[INT_EN]     = REG_FIELD(TM_INT_EN_OFF, 0, 0),
 
+	/* UPPER/LOWER TEMPERATURE THRESHOLDS */
+	REG_FIELD_FOR_EACH_SENSOR11(LOW_THRESH,    TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF,  0,  9),
+	REG_FIELD_FOR_EACH_SENSOR11(UP_THRESH,     TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 10, 19),
+
+	/* UPPER/LOWER INTERRUPTS [CLEAR/STATUS] */
+	REG_FIELD_FOR_EACH_SENSOR11(LOW_INT_CLEAR, TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 20, 20),
+	REG_FIELD_FOR_EACH_SENSOR11(UP_INT_CLEAR,  TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 21, 21),
+	[LOW_INT_STATUS_0] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  0,  0),
+	[LOW_INT_STATUS_1] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  1,  1),
+	[LOW_INT_STATUS_2] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  2,  2),
+	[LOW_INT_STATUS_3] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  3,  3),
+	[LOW_INT_STATUS_4] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  4,  4),
+	[LOW_INT_STATUS_5] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  5,  5),
+	[LOW_INT_STATUS_6] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  6,  6),
+	[LOW_INT_STATUS_7] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  7,  7),
+	[UP_INT_STATUS_0]  = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  8,  8),
+	[UP_INT_STATUS_1]  = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  9,  9),
+	[UP_INT_STATUS_2]  = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF, 10, 10),
+	[UP_INT_STATUS_3]  = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF, 11, 11),
+	[UP_INT_STATUS_4]  = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF, 12, 12),
+	[UP_INT_STATUS_5]  = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF, 13, 13),
+	[UP_INT_STATUS_6]  = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF, 14, 14),
+	[UP_INT_STATUS_7]  = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF, 15, 15),
+
+	/* NO CRITICAL INTERRUPT SUPPORT on v1 */
+
 	/* Sn_STATUS */
 	REG_FIELD_FOR_EACH_SENSOR11(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
 	REG_FIELD_FOR_EACH_SENSOR11(VALID,        TM_Sn_STATUS_OFF, 14, 14),
+	/* xxx_STATUS bits: 1 == threshold violated */
 	REG_FIELD_FOR_EACH_SENSOR11(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
 	REG_FIELD_FOR_EACH_SENSOR11(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
 	REG_FIELD_FOR_EACH_SENSOR11(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 0a4f2b8fcab6c..a4d15e1abfddd 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -50,9 +50,22 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* v2 has separate enables for UPPER/LOWER/CRITICAL interrupts */
 	[INT_EN]  = REG_FIELD(TM_INT_EN_OFF, 0, 2),
 
+	/* TEMPERATURE THRESHOLDS */
+	REG_FIELD_FOR_EACH_SENSOR16(LOW_THRESH, TM_Sn_UPPER_LOWER_THRESHOLD_OFF,  0,  11),
+	REG_FIELD_FOR_EACH_SENSOR16(UP_THRESH,  TM_Sn_UPPER_LOWER_THRESHOLD_OFF, 12,  23),
+
+	/* INTERRUPTS [CLEAR/STATUS/MASK] */
+	REG_FIELD_SPLIT_BITS_0_15(LOW_INT_STATUS,  TM_UPPER_LOWER_INT_STATUS_OFF),
+	REG_FIELD_SPLIT_BITS_0_15(LOW_INT_CLEAR,   TM_UPPER_LOWER_INT_CLEAR_OFF),
+	REG_FIELD_SPLIT_BITS_0_15(LOW_INT_MASK,    TM_UPPER_LOWER_INT_MASK_OFF),
+	REG_FIELD_SPLIT_BITS_16_31(UP_INT_STATUS,  TM_UPPER_LOWER_INT_STATUS_OFF),
+	REG_FIELD_SPLIT_BITS_16_31(UP_INT_CLEAR,   TM_UPPER_LOWER_INT_CLEAR_OFF),
+	REG_FIELD_SPLIT_BITS_16_31(UP_INT_MASK,    TM_UPPER_LOWER_INT_MASK_OFF),
+
 	/* Sn_STATUS */
 	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  11),
 	REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 21,  21),
+	/* xxx_STATUS bits: 1 == threshold violated */
 	REG_FIELD_FOR_EACH_SENSOR16(MIN_STATUS,      TM_Sn_STATUS_OFF, 16,  16),
 	REG_FIELD_FOR_EACH_SENSOR16(LOWER_STATUS,    TM_Sn_STATUS_OFF, 17,  17),
 	REG_FIELD_FOR_EACH_SENSOR16(UPPER_STATUS,    TM_Sn_STATUS_OFF, 18,  18),
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 772aa76b50e12..a4335717aeede 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -7,6 +7,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
@@ -78,12 +79,14 @@ MODULE_DEVICE_TABLE(of, tsens_table);
 static const struct thermal_zone_of_device_ops tsens_of_ops = {
 	.get_temp = tsens_get_temp,
 	.get_trend = tsens_get_trend,
+	.set_trips = tsens_set_trips,
 };
 
 static int tsens_register(struct tsens_priv *priv)
 {
-	int i;
+	int i, ret, irq;
 	struct thermal_zone_device *tzd;
+	struct platform_device *pdev;
 
 	for (i = 0;  i < priv->num_sensors; i++) {
 		priv->sensor[i].priv = priv;
@@ -96,7 +99,33 @@ static int tsens_register(struct tsens_priv *priv)
 		if (priv->ops->enable)
 			priv->ops->enable(priv, i);
 	}
+
+	pdev = of_find_device_by_node(priv->dev->of_node);
+	if (!pdev) {
+		dev_err(&pdev->dev, "%s: device node not found in DT\n", __func__);
+		return -ENODEV;
+	}
+
+	irq = platform_get_irq_byname(pdev, "uplow");
+	if (irq < 0) {
+		dev_err(&pdev->dev, "%s: missing irq in dt: uplow\n", __func__);
+		return irq;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq,
+					NULL, tsens_irq_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					dev_name(&pdev->dev), priv);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
+		goto err_put_device;
+	}
+	enable_irq_wake(irq);
 	return 0;
+
+err_put_device:
+	put_device(&pdev->dev);
+	return ret;
 }
 
 static int tsens_probe(struct platform_device *pdev)
@@ -178,6 +207,7 @@ static int tsens_remove(struct platform_device *pdev)
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(priv->debug_root);
+	tsens_disable_irq(priv);
 	if (priv->ops->disable)
 		priv->ops->disable(priv);
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 409395e436f32..b960c77168347 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -13,8 +13,10 @@
 #define CAL_DEGC_PT2		120
 #define SLOPE_FACTOR		1000
 #define SLOPE_DEFAULT		3200
+#define THRESHOLD_MAX_ADC_CODE	0x3ff
+#define THRESHOLD_MIN_ADC_CODE	0x0
 
-
+#include <linux/interrupt.h>
 #include <linux/thermal.h>
 #include <linux/regmap.h>
 
@@ -26,6 +28,11 @@ enum tsens_ver {
 	VER_2_X,
 };
 
+enum tsens_irq_type {
+	LOWER,
+	UPPER,
+};
+
 /**
  * struct tsens_sensor - data for each sensor connected to the tsens device
  * @priv: tsens device instance that this sensor is connected to
@@ -99,22 +106,66 @@ struct tsens_ops {
 	[_name##_##14] = REG_FIELD(_offset + 56, _startbit, _stopbit), \
 	[_name##_##15] = REG_FIELD(_offset + 60, _startbit, _stopbit)
 
-/* reg_field IDs to use as an index into an array */
+#define REG_FIELD_SPLIT_BITS_0_15(_name, _offset)		\
+	[_name##_##0]  = REG_FIELD(_offset,  0,  0),		\
+	[_name##_##1]  = REG_FIELD(_offset,  1,  1),	\
+	[_name##_##2]  = REG_FIELD(_offset,  2,  2),	\
+	[_name##_##3]  = REG_FIELD(_offset,  3,  3),	\
+	[_name##_##4]  = REG_FIELD(_offset,  4,  4),	\
+	[_name##_##5]  = REG_FIELD(_offset,  5,  5),	\
+	[_name##_##6]  = REG_FIELD(_offset,  6,  6),	\
+	[_name##_##7]  = REG_FIELD(_offset,  7,  7),	\
+	[_name##_##8]  = REG_FIELD(_offset,  8,  8),	\
+	[_name##_##9]  = REG_FIELD(_offset,  9,  9),	\
+	[_name##_##10] = REG_FIELD(_offset, 10, 10),	\
+	[_name##_##11] = REG_FIELD(_offset, 11, 11),	\
+	[_name##_##12] = REG_FIELD(_offset, 12, 12),	\
+	[_name##_##13] = REG_FIELD(_offset, 13, 13),	\
+	[_name##_##14] = REG_FIELD(_offset, 14, 14),	\
+	[_name##_##15] = REG_FIELD(_offset, 15, 15)
+
+#define REG_FIELD_SPLIT_BITS_16_31(_name, _offset)		\
+	[_name##_##0]  = REG_FIELD(_offset, 16, 16),		\
+	[_name##_##1]  = REG_FIELD(_offset, 17, 17),	\
+	[_name##_##2]  = REG_FIELD(_offset, 18, 18),	\
+	[_name##_##3]  = REG_FIELD(_offset, 19, 19),	\
+	[_name##_##4]  = REG_FIELD(_offset, 20, 20),	\
+	[_name##_##5]  = REG_FIELD(_offset, 21, 21),	\
+	[_name##_##6]  = REG_FIELD(_offset, 22, 22),	\
+	[_name##_##7]  = REG_FIELD(_offset, 23, 23),	\
+	[_name##_##8]  = REG_FIELD(_offset, 24, 24),	\
+	[_name##_##9]  = REG_FIELD(_offset, 25, 25),	\
+	[_name##_##10] = REG_FIELD(_offset, 26, 26),	\
+	[_name##_##11] = REG_FIELD(_offset, 27, 27),	\
+	[_name##_##12] = REG_FIELD(_offset, 28, 28),	\
+	[_name##_##13] = REG_FIELD(_offset, 29, 29),	\
+	[_name##_##14] = REG_FIELD(_offset, 30, 30),	\
+	[_name##_##15] = REG_FIELD(_offset, 31, 31)
+
+/*
+ * reg_field IDs to use as an index into an array
+ * If you change the order of the entries, check the devm_regmap_field_alloc()
+ * calls in init_common()
+ */
 enum regfield_ids {
 	/* ----- SROT ------ */
 	/* HW_VER */
-	VER_MAJOR = 0,
+	VER_MAJOR,
 	VER_MINOR,
 	VER_STEP,
 	/* CTRL_OFFSET */
-	TSENS_EN =  3,
+	TSENS_EN,
 	TSENS_SW_RST,
 	SENSOR_EN,
 	CODE_OR_TEMP,
 
 	/* ----- TM ------ */
+	/* TRDY */
+	TRDY,
+	/* INTERRUPT ENABLE */
+	INT_EN,	/* v2+ has separate enables for crit, upper and lower irq */
 	/* STATUS */
-	LAST_TEMP_0 = 7,	/* Last temperature reading */
+	LAST_TEMP_0,	/* Last temperature reading */
 	LAST_TEMP_1,
 	LAST_TEMP_2,
 	LAST_TEMP_3,
@@ -130,7 +181,7 @@ enum regfield_ids {
 	LAST_TEMP_13,
 	LAST_TEMP_14,
 	LAST_TEMP_15,
-	VALID_0 = 23,		/* VALID reading or not */
+	VALID_0,		/* VALID reading or not */
 	VALID_1,
 	VALID_2,
 	VALID_3,
@@ -146,38 +197,6 @@ enum regfield_ids {
 	VALID_13,
 	VALID_14,
 	VALID_15,
-	MIN_STATUS_0,		/* MIN threshold violated */
-	MIN_STATUS_1,
-	MIN_STATUS_2,
-	MIN_STATUS_3,
-	MIN_STATUS_4,
-	MIN_STATUS_5,
-	MIN_STATUS_6,
-	MIN_STATUS_7,
-	MIN_STATUS_8,
-	MIN_STATUS_9,
-	MIN_STATUS_10,
-	MIN_STATUS_11,
-	MIN_STATUS_12,
-	MIN_STATUS_13,
-	MIN_STATUS_14,
-	MIN_STATUS_15,
-	MAX_STATUS_0,		/* MAX threshold violated */
-	MAX_STATUS_1,
-	MAX_STATUS_2,
-	MAX_STATUS_3,
-	MAX_STATUS_4,
-	MAX_STATUS_5,
-	MAX_STATUS_6,
-	MAX_STATUS_7,
-	MAX_STATUS_8,
-	MAX_STATUS_9,
-	MAX_STATUS_10,
-	MAX_STATUS_11,
-	MAX_STATUS_12,
-	MAX_STATUS_13,
-	MAX_STATUS_14,
-	MAX_STATUS_15,
 	LOWER_STATUS_0,	/* LOWER threshold violated */
 	LOWER_STATUS_1,
 	LOWER_STATUS_2,
@@ -194,6 +213,70 @@ enum regfield_ids {
 	LOWER_STATUS_13,
 	LOWER_STATUS_14,
 	LOWER_STATUS_15,
+	LOW_INT_STATUS_0,	/* LOWER interrupt status */
+	LOW_INT_STATUS_1,
+	LOW_INT_STATUS_2,
+	LOW_INT_STATUS_3,
+	LOW_INT_STATUS_4,
+	LOW_INT_STATUS_5,
+	LOW_INT_STATUS_6,
+	LOW_INT_STATUS_7,
+	LOW_INT_STATUS_8,
+	LOW_INT_STATUS_9,
+	LOW_INT_STATUS_10,
+	LOW_INT_STATUS_11,
+	LOW_INT_STATUS_12,
+	LOW_INT_STATUS_13,
+	LOW_INT_STATUS_14,
+	LOW_INT_STATUS_15,
+	LOW_INT_CLEAR_0,	/* LOWER interrupt clear */
+	LOW_INT_CLEAR_1,
+	LOW_INT_CLEAR_2,
+	LOW_INT_CLEAR_3,
+	LOW_INT_CLEAR_4,
+	LOW_INT_CLEAR_5,
+	LOW_INT_CLEAR_6,
+	LOW_INT_CLEAR_7,
+	LOW_INT_CLEAR_8,
+	LOW_INT_CLEAR_9,
+	LOW_INT_CLEAR_10,
+	LOW_INT_CLEAR_11,
+	LOW_INT_CLEAR_12,
+	LOW_INT_CLEAR_13,
+	LOW_INT_CLEAR_14,
+	LOW_INT_CLEAR_15,
+	LOW_INT_MASK_0,	/* LOWER interrupt mask */
+	LOW_INT_MASK_1,
+	LOW_INT_MASK_2,
+	LOW_INT_MASK_3,
+	LOW_INT_MASK_4,
+	LOW_INT_MASK_5,
+	LOW_INT_MASK_6,
+	LOW_INT_MASK_7,
+	LOW_INT_MASK_8,
+	LOW_INT_MASK_9,
+	LOW_INT_MASK_10,
+	LOW_INT_MASK_11,
+	LOW_INT_MASK_12,
+	LOW_INT_MASK_13,
+	LOW_INT_MASK_14,
+	LOW_INT_MASK_15,
+	LOW_THRESH_0,		/* LOWER threshold values */
+	LOW_THRESH_1,
+	LOW_THRESH_2,
+	LOW_THRESH_3,
+	LOW_THRESH_4,
+	LOW_THRESH_5,
+	LOW_THRESH_6,
+	LOW_THRESH_7,
+	LOW_THRESH_8,
+	LOW_THRESH_9,
+	LOW_THRESH_10,
+	LOW_THRESH_11,
+	LOW_THRESH_12,
+	LOW_THRESH_13,
+	LOW_THRESH_14,
+	LOW_THRESH_15,
 	UPPER_STATUS_0,	/* UPPER threshold violated */
 	UPPER_STATUS_1,
 	UPPER_STATUS_2,
@@ -210,6 +293,70 @@ enum regfield_ids {
 	UPPER_STATUS_13,
 	UPPER_STATUS_14,
 	UPPER_STATUS_15,
+	UP_INT_STATUS_0,	/* UPPER interrupt status */
+	UP_INT_STATUS_1,
+	UP_INT_STATUS_2,
+	UP_INT_STATUS_3,
+	UP_INT_STATUS_4,
+	UP_INT_STATUS_5,
+	UP_INT_STATUS_6,
+	UP_INT_STATUS_7,
+	UP_INT_STATUS_8,
+	UP_INT_STATUS_9,
+	UP_INT_STATUS_10,
+	UP_INT_STATUS_11,
+	UP_INT_STATUS_12,
+	UP_INT_STATUS_13,
+	UP_INT_STATUS_14,
+	UP_INT_STATUS_15,
+	UP_INT_CLEAR_0,	/* UPPER interrupt clear */
+	UP_INT_CLEAR_1,
+	UP_INT_CLEAR_2,
+	UP_INT_CLEAR_3,
+	UP_INT_CLEAR_4,
+	UP_INT_CLEAR_5,
+	UP_INT_CLEAR_6,
+	UP_INT_CLEAR_7,
+	UP_INT_CLEAR_8,
+	UP_INT_CLEAR_9,
+	UP_INT_CLEAR_10,
+	UP_INT_CLEAR_11,
+	UP_INT_CLEAR_12,
+	UP_INT_CLEAR_13,
+	UP_INT_CLEAR_14,
+	UP_INT_CLEAR_15,
+	UP_INT_MASK_0,		/* UPPER interrupt mask */
+	UP_INT_MASK_1,
+	UP_INT_MASK_2,
+	UP_INT_MASK_3,
+	UP_INT_MASK_4,
+	UP_INT_MASK_5,
+	UP_INT_MASK_6,
+	UP_INT_MASK_7,
+	UP_INT_MASK_8,
+	UP_INT_MASK_9,
+	UP_INT_MASK_10,
+	UP_INT_MASK_11,
+	UP_INT_MASK_12,
+	UP_INT_MASK_13,
+	UP_INT_MASK_14,
+	UP_INT_MASK_15,
+	UP_THRESH_0,		/* UPPER threshold values */
+	UP_THRESH_1,
+	UP_THRESH_2,
+	UP_THRESH_3,
+	UP_THRESH_4,
+	UP_THRESH_5,
+	UP_THRESH_6,
+	UP_THRESH_7,
+	UP_THRESH_8,
+	UP_THRESH_9,
+	UP_THRESH_10,
+	UP_THRESH_11,
+	UP_THRESH_12,
+	UP_THRESH_13,
+	UP_THRESH_14,
+	UP_THRESH_15,
 	CRITICAL_STATUS_0,	/* CRITICAL threshold violated */
 	CRITICAL_STATUS_1,
 	CRITICAL_STATUS_2,
@@ -226,13 +373,38 @@ enum regfield_ids {
 	CRITICAL_STATUS_13,
 	CRITICAL_STATUS_14,
 	CRITICAL_STATUS_15,
-	/* TRDY */
-	TRDY,
-	/* INTERRUPT ENABLE */
-	INT_EN,	/* Pre-V1, V1.x */
-	LOW_INT_EN,	/* V2.x */
-	UP_INT_EN,	/* V2.x */
-	CRIT_INT_EN,	/* V2.x */
+	MIN_STATUS_0,		/* MIN threshold violated */
+	MIN_STATUS_1,
+	MIN_STATUS_2,
+	MIN_STATUS_3,
+	MIN_STATUS_4,
+	MIN_STATUS_5,
+	MIN_STATUS_6,
+	MIN_STATUS_7,
+	MIN_STATUS_8,
+	MIN_STATUS_9,
+	MIN_STATUS_10,
+	MIN_STATUS_11,
+	MIN_STATUS_12,
+	MIN_STATUS_13,
+	MIN_STATUS_14,
+	MIN_STATUS_15,
+	MAX_STATUS_0,		/* MAX threshold violated */
+	MAX_STATUS_1,
+	MAX_STATUS_2,
+	MAX_STATUS_3,
+	MAX_STATUS_4,
+	MAX_STATUS_5,
+	MAX_STATUS_6,
+	MAX_STATUS_7,
+	MAX_STATUS_8,
+	MAX_STATUS_9,
+	MAX_STATUS_10,
+	MAX_STATUS_11,
+	MAX_STATUS_12,
+	MAX_STATUS_13,
+	MAX_STATUS_14,
+	MAX_STATUS_15,
 
 	/* Keep last */
 	MAX_REGFIELDS
@@ -304,6 +476,10 @@ struct tsens_priv {
 	struct regmap			*tm_map;
 	struct regmap			*srot_map;
 	u32				tm_offset;
+
+	/* lock for upper/lower threshold interrupts */
+	spinlock_t			ul_lock;
+
 	struct regmap_field		*rf[MAX_REGFIELDS];
 	struct tsens_context		ctx;
 	const struct tsens_features	*feat;
@@ -321,6 +497,10 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
 int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(struct tsens_sensor *s, int *temp);
 int get_temp_common(struct tsens_sensor *s, int *temp);
+int tsens_enable_irq(struct tsens_priv *priv);
+void tsens_disable_irq(struct tsens_priv *priv);
+int tsens_set_trips(void *_sensor, int low, int high);
+irqreturn_t tsens_irq_thread(int irq, void *data);
 
 /* TSENS target */
 extern const struct tsens_plat_data data_8960;
-- 
2.17.1

