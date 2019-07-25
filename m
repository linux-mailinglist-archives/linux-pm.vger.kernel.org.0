Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CA275AAE
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 00:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfGYWT5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 18:19:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44290 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfGYWTx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 18:19:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so23713676pgl.11
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XSIL8vzAj1UW9OcfGp680V8IfqHXmj1hG5NOXg9ge7I=;
        b=M+y4KtpUxd5P1yc3oGzN/osdlV3VTAjMx+mIVvbo0OhTZxuYQfLsup0Vy9uVHiia21
         p3lX40Eho4Ifp41K8UzoNJHliiOk+grEDveX/ss761d7xAfCLpNRb0bylgbFvnX+GGDb
         bFTJVjlQ6ZGbJXnS7yeKX0XysMlCBPNa632rgjRoMTCRmj6Ew3anVw0ACX+fgCUhzfXa
         PbH62cvHIDJC6CWL3GzPmdzGWSBiHdq5zPOhviBFvwVDiqsgXUniOroFCcK3vGqEOmZk
         YAUAVxXtZkdPCmTGslOlcKCN+QAwj5QoRtg1ZCnELhsa68DC3s9886Sq+TSrPrdA0pnT
         UmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=XSIL8vzAj1UW9OcfGp680V8IfqHXmj1hG5NOXg9ge7I=;
        b=unHjMDdu+SFGjsix6i8LmcfEV/ktUnaxOI18y0PmLfn6pRgEfajtvAFetsKX2vct1/
         ZYJLqHqa2g9jaVX5EaDRo3vnKi48jLTHG5kujkrBUykx0nAVxMHkbapPvce4MXE7aqss
         iAH+qu1TXy+CqHLEAIvF3nOTyMvFPz0ybbqjFxkNxfwExK3jHUHSfAoOlwRuLG2cyzRr
         j9gTWcStQ/TirH3MTvDZZPMJAThAR64tlqGi4qnJEwZnrxnpq+Dca8RZcIe3/WbCp9kY
         k8XD25GJ/rq5Req3P33gexT6GzaqeKYQbKJTUJAfk+3pdyRzD8wfOno0aIRjOXl+8Nal
         fNyw==
X-Gm-Message-State: APjAAAVL7LK1see1lwPcSuW4kf24HEPHNZJ4npw35zoyVy9/j6sfLKV7
        5HEOjlDPn77AJn5fOhNFwZSg3g==
X-Google-Smtp-Source: APXvYqxwyIrmSjDRcq/VNRfNlI7sxNTpqC1u3VB2fKXWIxmgN9ybSdXsYxUNiuWNSYx3lGAUia5+cQ==
X-Received: by 2002:a65:5183:: with SMTP id h3mr88065777pgq.250.1564093192209;
        Thu, 25 Jul 2019 15:19:52 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id l26sm47761428pgb.90.2019.07.25.15.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:51 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 15/15] drivers: thermal: tsens: Add interrupt support
Date:   Fri, 26 Jul 2019 03:48:50 +0530
Message-Id: <3105ffc275c6e1106a17b8b9ad83a8f1816445eb.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
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
 drivers/thermal/qcom/tsens-common.c | 467 ++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens-v0_1.c   |  11 +
 drivers/thermal/qcom/tsens-v1.c     |  29 ++
 drivers/thermal/qcom/tsens-v2.c     |  18 ++
 drivers/thermal/qcom/tsens.c        |  25 +-
 drivers/thermal/qcom/tsens.h        | 269 +++++++++++++++-
 6 files changed, 806 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 13a875b99094..f94ef79c37bc 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -13,6 +13,22 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
+/* IRQ state, mask and clear */
+struct tsens_irq_data {
+	u32 up_viol;
+	int up_thresh;
+	u32 up_irq_mask;
+	u32 up_irq_clear;
+	u32 low_viol;
+	int low_thresh;
+	u32 low_irq_mask;
+	u32 low_irq_clear;
+	u32 crit_viol;
+	u32 crit_thresh;
+	u32 crit_irq_mask;
+	u32 crit_irq_clear;
+};
+
 char *qfprom_read(struct device *dev, const char *cname)
 {
 	struct nvmem_cell *cell;
@@ -65,6 +81,18 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	}
 }
 
+static inline u32 degc_to_code(int degc, const struct tsens_sensor *sensor)
+{
+	u32 code = (degc * sensor->slope + sensor->offset) / SLOPE_FACTOR;
+
+	if (code > THRESHOLD_MAX_ADC_CODE)
+		code = THRESHOLD_MAX_ADC_CODE;
+	else if (code < THRESHOLD_MIN_ADC_CODE)
+		code = THRESHOLD_MIN_ADC_CODE;
+	pr_debug("%s: raw_code: 0x%x, degc:%d\n", __func__, code, degc);
+	return code;
+}
+
 static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 {
 	int degc, num, den;
@@ -106,6 +134,363 @@ static int tsens_hw_to_mC(char *str, struct tsens_sensor *s, int field, int temp
 	}
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
+		/* milli to C to adc code */
+		return degc_to_code(temp / 1000, s);
+	} else {
+		/* milli to deci C */
+		return (temp / 100);
+	}
+}
+
+static inline unsigned int tsens_ver(struct tsens_priv *priv)
+{
+	return priv->feat->ver_major;
+}
+
+static inline u32 irq_mask(u32 hw_id)
+{
+	return 1 << hw_id;
+}
+
+/**
+ * tsens_set_interrupt_v1 - Disable an interrupt (enable = false)
+ *                          Re-enable an interrupt (enable = true)
+ */
+static void tsens_set_interrupt_v1(struct tsens_priv *priv, const struct tsens_irq_data d,
+				   u32 hw_id, enum tsens_irq_type irq_type, bool enable)
+{
+	if (enable) {
+		switch (irq_type) {
+		case UPPER:
+			regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_id], 0);
+			break;
+		case LOWER:
+			regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_id], 0);
+			break;
+		default:
+			dev_err(priv->dev, "%s: Invalid irq_type\n", __func__);
+			break;
+		}
+	} else {
+		switch (irq_type) {
+		case UPPER:
+			regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_id], 1);
+			break;
+		case LOWER:
+			regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_id], 1);
+			break;
+		default:
+			dev_err(priv->dev, "%s: Invalid irq_type\n", __func__);
+			break;
+		}
+	}
+}
+
+/**
+ * tsens_set_interrupt_v2 - Disable an interrupt (enable = false)
+ *                          Re-enable an interrupt (enable = true)
+ */
+static void tsens_set_interrupt_v2(struct tsens_priv *priv, const struct tsens_irq_data d,
+				   u32 hw_id, enum tsens_irq_type irq_type, bool enable)
+{
+	if (enable) {
+		switch (irq_type) {
+		case UPPER:
+			regmap_field_write(priv->rf[UP_INT_MASK_0 + hw_id], 0);
+			break;
+		case LOWER:
+			regmap_field_write(priv->rf[LOW_INT_MASK_0 + hw_id], 0);
+			break;
+		case CRITICAL:
+			regmap_field_write(priv->rf[CRIT_INT_MASK_0 + hw_id], 0);
+			break;
+		default:
+			dev_err(priv->dev, "%s: Invalid irq_type\n", __func__);
+			break;
+		}
+	} else {
+		/* To disable the interrupt flag for a sensor:
+		 *  1. Mask further interrupts for this sensor
+		 *  2. Write 1 followed by 0 to clear the interrupt
+		 */
+		switch (irq_type) {
+		case UPPER:
+			regmap_field_write(priv->rf[UP_INT_MASK_0 + hw_id], 1);
+			regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_id], 1);
+			regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_id], 0);
+			break;
+		case LOWER:
+			regmap_field_write(priv->rf[LOW_INT_MASK_0 + hw_id], 1);
+			regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_id], 1);
+			regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_id], 0);
+			break;
+		case CRITICAL:
+			regmap_field_write(priv->rf[CRIT_INT_MASK_0 + hw_id], 1);
+			regmap_field_write(priv->rf[CRIT_INT_CLEAR_0 + hw_id], 1);
+			regmap_field_write(priv->rf[CRIT_INT_CLEAR_0 + hw_id], 0);
+			break;
+		default:
+			dev_err(priv->dev, "%s: Invalid irq_type\n", __func__);
+			break;
+		}
+	}
+}
+
+/**
+ * tsens_set_interrupt - Disable an interrupt (enable = false)
+ *                       Re-enable an interrupt (enable = true)
+ */
+static void tsens_set_interrupt(struct tsens_priv *priv, const struct tsens_irq_data d,
+				u32 hw_id, enum tsens_irq_type irq_type, bool enable)
+{
+	/* FIXME: remove tsens_irq_data */
+	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
+		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
+		enable ? "en" : "dis");
+	if (tsens_ver(priv) > VER_1_X)
+		tsens_set_interrupt_v2(priv, d, hw_id, irq_type, enable);
+	else
+		tsens_set_interrupt_v1(priv, d, hw_id, irq_type, enable);
+}
+
+static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
+				struct tsens_sensor *s, struct tsens_irq_data *d)
+{
+	int ret, up_temp, low_temp;
+
+	if (hw_id > priv->num_sensors) {
+		dev_err(priv->dev, "%s Invalid hw_id\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id], &d->up_viol);
+	if (ret)
+		return ret;
+	ret = regmap_field_read(priv->rf[UP_THRESH_0 + hw_id], &up_temp);
+	if (ret)
+		return ret;
+	ret = regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &d->low_viol);
+	if (ret)
+		return ret;
+	ret = regmap_field_read(priv->rf[LOW_THRESH_0 + hw_id], &low_temp);
+	if (ret)
+		return ret;
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
+	d->up_thresh = tsens_hw_to_mC("upthresh", s, UP_THRESH_0, up_temp);
+	d->low_thresh = tsens_hw_to_mC("lowthresh", s, LOW_THRESH_0, low_temp);
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
+	if (ver > VER_1_X) {
+		return mask & (1 << hw_id);
+	} else {
+		/* v1, v0.1 don't have a irq mask register */
+		return 0;
+	}
+}
+
+static unsigned long tsens_filter_active_sensors(struct tsens_priv *priv)
+{
+	int i, ret, up, low;
+	unsigned long mask = 0;
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct tsens_sensor *s = &priv->sensor[i];
+		u32 hw_id = s->hw_id;
+
+		if (IS_ERR(priv->sensor[i].tzd))
+			continue;
+		ret = regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id], &up);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &low);
+		if (ret)
+			return ret;
+		if (up || low)
+			set_bit(hw_id, &mask);
+	}
+	dev_dbg(priv->dev, "%s: hw_id mask: 0x%lx\n",  __func__, mask);
+
+	return mask;
+}
+
+irqreturn_t tsens_irq_thread(int irq, void *data)
+{
+	struct tsens_priv *priv = data;
+	int temp, ret, i;
+	unsigned long flags;
+	bool enable = true, disable = false;
+	unsigned long mask = tsens_filter_active_sensors(priv);
+
+	if (!mask) {
+		dev_err(priv->dev, "%s: Spurious interrupt?\n", __func__);
+		return IRQ_NONE;
+	}
+
+	/* Check if any sensor raised an IRQ - for each sensor connected to the
+	 * TSENS block if it set the threshold violation bit.
+	 */
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct tsens_sensor *s = &priv->sensor[i];
+		struct tsens_irq_data d;
+		u32 hw_id = s->hw_id;
+		bool trigger = 0;
+
+		if (!test_bit(hw_id, &mask))
+			continue;
+		if (IS_ERR(priv->sensor[i].tzd))
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
+			tsens_set_interrupt(priv, d, hw_id, UPPER, disable);
+			if (d.up_thresh > temp) {
+				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
+					priv->sensor[i].hw_id, __func__);
+				/* unmask the interrupt for this sensor */
+				tsens_set_interrupt(priv, d, hw_id, UPPER, enable);
+			} else {
+				trigger = 1;
+				/* Keep irq masked */
+			}
+		} else if (d.low_viol &&
+			   !masked_irq(hw_id, d.low_irq_mask, tsens_ver(priv))) {
+			tsens_set_interrupt(priv, d, hw_id, LOWER, disable);
+			if (d.low_thresh < temp) {
+				dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
+					priv->sensor[i].hw_id, __func__);
+				/* unmask the interrupt for this sensor */
+				tsens_set_interrupt(priv, d, hw_id, LOWER, enable);
+			} else {
+				trigger = 1;
+				/* Keep irq masked */
+			}
+		}
+
+		/* TODO: (amit) REALLY??? */
+		mb();
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
+	tsens_set_interrupt(priv, d, hw_id, LOWER, enable);
+	tsens_set_interrupt(priv, d, hw_id, UPPER, enable);
+
+	/* TODO: (amit) REALLY??? */
+	mb();
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
+	int val = (tsens_ver(priv) > VER_1_X) ? 7 : 1;
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
@@ -334,6 +719,88 @@ int __init init_common(struct tsens_priv *priv)
 			goto err_put_device;
 		}
 	}
+	for (i = 0, j = UPPER_STATUS_0; i < priv->feat->max_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
+			goto err_put_device;
+		}
+	}
+	for (i = 0, j = LOWER_STATUS_0; i < priv->feat->max_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
+			goto err_put_device;
+		}
+	}
+	for (i = 0, j = CRITICAL_STATUS_0; i < priv->feat->max_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
+			goto err_put_device;
+		}
+	}
+	for (i = 0, j = UP_THRESH_0; i < priv->feat->max_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
+			goto err_put_device;
+		}
+	}
+	for (i = 0, j = LOW_THRESH_0; i < priv->feat->max_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
+			goto err_put_device;
+		}
+	}
+	for (i = 0, j = UP_INT_CLEAR_0; i < priv->feat->max_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
+			goto err_put_device;
+		}
+	}
+	for (i = 0, j = LOW_INT_CLEAR_0; i < priv->feat->max_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
+			goto err_put_device;
+		}
+	}
+	for (i = 0, j = UP_INT_MASK_0; i < priv->feat->max_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
+			goto err_put_device;
+		}
+	}
+	for (i = 0, j = LOW_INT_MASK_0; i < priv->feat->max_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
+			goto err_put_device;
+		}
+	}
+
+	priv->rf[INT_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
+						   priv->fields[INT_EN]);
+	if (IS_ERR(priv->rf[INT_EN])) {
+		ret = PTR_ERR(priv->rf[INT_EN]);
+		goto err_put_device;
+	}
+
+	tsens_enable_irq(priv);
+	spin_lock_init(&priv->ul_lock);
 
 	tsens_debug_init(op);
 
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 6f26fadf4c27..d36e16697173 100644
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
+	/* NO CRITICAL INTERRUPT SUPPORT on v1 */
+
 	/* Sn_STATUS */
 	REG_FIELD_FOR_EACH_SENSOR11(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
 	/* No VALID field on v0.1 */
+	/* xxx_STATUS bits: 1 == threshold violated */
 	REG_FIELD_FOR_EACH_SENSOR11(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
 	REG_FIELD_FOR_EACH_SENSOR11(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
 	REG_FIELD_FOR_EACH_SENSOR11(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 10b595d4f619..86259c9821be 100644
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
index 0a4f2b8fcab6..96e29ba14eaf 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -50,9 +50,27 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* v2 has separate enables for UPPER/LOWER/CRITICAL interrupts */
 	[INT_EN]  = REG_FIELD(TM_INT_EN_OFF, 0, 2),
 
+	/* UPPER/LOWER TEMPERATURE THRESHOLDS */
+	REG_FIELD_FOR_EACH_SENSOR16(LOW_THRESH, TM_Sn_UPPER_LOWER_THRESHOLD_OFF,  0,  11),
+	REG_FIELD_FOR_EACH_SENSOR16(UP_THRESH,  TM_Sn_UPPER_LOWER_THRESHOLD_OFF, 12,  23),
+
+	/* UPPER/LOWER INTERRUPTS [CLEAR/STATUS/MASK] */
+	REG_FIELD_SPLIT_BITS_0_15(LOW_INT_STATUS, TM_UPPER_LOWER_INT_STATUS_OFF),
+	REG_FIELD_SPLIT_BITS_0_15(LOW_INT_CLEAR,  TM_UPPER_LOWER_INT_CLEAR_OFF),
+	REG_FIELD_SPLIT_BITS_0_15(LOW_INT_MASK,   TM_UPPER_LOWER_INT_MASK_OFF),
+	REG_FIELD_SPLIT_BITS_16_31(UP_INT_STATUS, TM_UPPER_LOWER_INT_STATUS_OFF),
+	REG_FIELD_SPLIT_BITS_16_31(UP_INT_CLEAR,  TM_UPPER_LOWER_INT_CLEAR_OFF),
+	REG_FIELD_SPLIT_BITS_16_31(UP_INT_MASK,   TM_UPPER_LOWER_INT_MASK_OFF),
+
+	/* CRITICAL_INTERRUPT */
+	REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_STATUS, TM_CRITICAL_INT_STATUS_OFF),
+	REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_CLEAR,  TM_CRITICAL_INT_CLEAR_OFF),
+	REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_MASK,   TM_CRITICAL_INT_MASK_OFF),
+
 	/* Sn_STATUS */
 	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  11),
 	REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 21,  21),
+	/* xxx_STATUS bits: 1 == threshold violated */
 	REG_FIELD_FOR_EACH_SENSOR16(MIN_STATUS,      TM_Sn_STATUS_OFF, 16,  16),
 	REG_FIELD_FOR_EACH_SENSOR16(LOWER_STATUS,    TM_Sn_STATUS_OFF, 17,  17),
 	REG_FIELD_FOR_EACH_SENSOR16(UPPER_STATUS,    TM_Sn_STATUS_OFF, 18,  18),
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 772aa76b50e1..bc83e40ac0cf 100644
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
@@ -78,12 +79,15 @@ MODULE_DEVICE_TABLE(of, tsens_table);
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
+	struct resource *res;
+	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
 
 	for (i = 0;  i < priv->num_sensors; i++) {
 		priv->sensor[i].priv = priv;
@@ -96,7 +100,25 @@ static int tsens_register(struct tsens_priv *priv)
 		if (priv->ops->enable)
 			priv->ops->enable(priv, i);
 	}
+
+	res = platform_get_resource(op, IORESOURCE_IRQ, 0);
+	if (res) {
+		irq = res->start;
+		ret = devm_request_threaded_irq(&op->dev, irq,
+						NULL, tsens_irq_thread,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+						res->name, priv);
+		if (ret) {
+			dev_err(&op->dev, "%s: failed to get irq\n", __func__);
+			goto err_put_device;
+		}
+		enable_irq_wake(irq);
+	}
 	return 0;
+
+err_put_device:
+	put_device(&op->dev);
+	return ret;
 }
 
 static int tsens_probe(struct platform_device *pdev)
@@ -178,6 +200,7 @@ static int tsens_remove(struct platform_device *pdev)
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(priv->debug_root);
+	tsens_disable_irq(priv);
 	if (priv->ops->disable)
 		priv->ops->disable(priv);
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e1d6af71b2b9..aab47337b797 100644
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
 
@@ -26,6 +28,12 @@ enum tsens_ver {
 	VER_2_X,
 };
 
+enum tsens_irq_type {
+	LOWER,
+	UPPER,
+	CRITICAL,
+};
+
 /**
  * struct tsens_sensor - data for each sensor connected to the tsens device
  * @priv: tsens device instance that this sensor is connected to
@@ -99,22 +107,62 @@ struct tsens_ops {
 	[_name##_##14] = REG_FIELD(_offset + 56, _startbit, _stopbit), \
 	[_name##_##15] = REG_FIELD(_offset + 60, _startbit, _stopbit)
 
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
 /* reg_field IDs to use as an index into an array */
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
@@ -130,7 +178,7 @@ enum regfield_ids {
 	LAST_TEMP_13,
 	LAST_TEMP_14,
 	LAST_TEMP_15,
-	VALID_0 = 23,		/* VALID reading or not */
+	VALID_0,		/* VALID reading or not */
 	VALID_1,
 	VALID_2,
 	VALID_3,
@@ -226,13 +274,202 @@ enum regfield_ids {
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
+	/* INTERRUPT_STATUS */
+	LOW_INT_STATUS_0,
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
+	UP_INT_STATUS_0,
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
+	CRIT_INT_STATUS_0,
+	CRIT_INT_STATUS_1,
+	CRIT_INT_STATUS_2,
+	CRIT_INT_STATUS_3,
+	CRIT_INT_STATUS_4,
+	CRIT_INT_STATUS_5,
+	CRIT_INT_STATUS_6,
+	CRIT_INT_STATUS_7,
+	CRIT_INT_STATUS_8,
+	CRIT_INT_STATUS_9,
+	CRIT_INT_STATUS_10,
+	CRIT_INT_STATUS_11,
+	CRIT_INT_STATUS_12,
+	CRIT_INT_STATUS_13,
+	CRIT_INT_STATUS_14,
+	CRIT_INT_STATUS_15,
+	/* INTERRUPT_CLEAR */
+	LOW_INT_CLEAR_0,
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
+	UP_INT_CLEAR_0,
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
+	CRIT_INT_CLEAR_0,
+	CRIT_INT_CLEAR_1,
+	CRIT_INT_CLEAR_2,
+	CRIT_INT_CLEAR_3,
+	CRIT_INT_CLEAR_4,
+	CRIT_INT_CLEAR_5,
+	CRIT_INT_CLEAR_6,
+	CRIT_INT_CLEAR_7,
+	CRIT_INT_CLEAR_8,
+	CRIT_INT_CLEAR_9,
+	CRIT_INT_CLEAR_10,
+	CRIT_INT_CLEAR_11,
+	CRIT_INT_CLEAR_12,
+	CRIT_INT_CLEAR_13,
+	CRIT_INT_CLEAR_14,
+	CRIT_INT_CLEAR_15,
+	/* INTERRUPT_MASK */
+	LOW_INT_MASK_0,
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
+	UP_INT_MASK_0,
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
+	CRIT_INT_MASK_0,
+	CRIT_INT_MASK_1,
+	CRIT_INT_MASK_2,
+	CRIT_INT_MASK_3,
+	CRIT_INT_MASK_4,
+	CRIT_INT_MASK_5,
+	CRIT_INT_MASK_6,
+	CRIT_INT_MASK_7,
+	CRIT_INT_MASK_8,
+	CRIT_INT_MASK_9,
+	CRIT_INT_MASK_10,
+	CRIT_INT_MASK_11,
+	CRIT_INT_MASK_12,
+	CRIT_INT_MASK_13,
+	CRIT_INT_MASK_14,
+	CRIT_INT_MASK_15,
+	/* THRESHOLD */
+	LOW_THRESH_0,
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
+	UP_THRESH_0,
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
+	CRIT_THRESH_0,
+	CRIT_THRESH_1,
+	CRIT_THRESH_2,
+	CRIT_THRESH_3,
+	CRIT_THRESH_4,
+	CRIT_THRESH_5,
+	CRIT_THRESH_6,
+	CRIT_THRESH_7,
+	CRIT_THRESH_8,
+	CRIT_THRESH_9,
+	CRIT_THRESH_10,
+	CRIT_THRESH_11,
+	CRIT_THRESH_12,
+	CRIT_THRESH_13,
+	CRIT_THRESH_14,
+	CRIT_THRESH_15,
 
 	/* Keep last */
 	MAX_REGFIELDS
@@ -302,6 +539,10 @@ struct tsens_priv {
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
@@ -319,6 +560,10 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
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

