Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AE91BE606
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgD2SOv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2SOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 14:14:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7288C03C1AE
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 11:14:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d24so1126181pll.8
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04WNxnJhiXYXCXBlE2vEsRAkvoVENCHXpxiMuJ1DsD4=;
        b=cHPzCI5li9e76pSS3yrEdeF1XAXzbR/o2mid1JcI19EnhIV+VAVSsWD/kgocgU/Reu
         +DUXFIzXH/qhkaOCk7a6UPBEBzJH0dWnnHBuFFy+06dtQA0tGIUR6s1qYeMlK5x9eHqm
         qWQiCeW49I46cAY/NuqCQorajHsv/FjPCy6L25IHRUBG6TT5+65GidLlBnnpYp8qX/4s
         lS7XRtWkKu6cN9jaf+y/upgKrPbWVyHIAjMxcNymyySQ21h2pdgLylyF5II6ur+jJmAD
         UGS9G5hkV55OQvgl4EtxAEmEsIV12dIg1YAobII7oP3W/ARcmu2Zt7jgrY/HJcnrR4Ys
         Qo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04WNxnJhiXYXCXBlE2vEsRAkvoVENCHXpxiMuJ1DsD4=;
        b=MGB+UhUsx2XQTmo2vouhcUwa6By77F4clwzxRCpczKcCnZ0eMGRhLCSYCi4xH5MBa/
         JQHkYF7SWxrlseQ/aFuxNJqQ4ifwhi9lNpaqFvT+YKlS3vCOn94NbYG83Vcuu4++hqh2
         uH1/LE2WowoqmU3ajsRKZNtaDmN80F4DhFNPepuBBxgdvmrYtAY54vg18jpynCa7nJBo
         4TOrLc89mMbvmaGajEwqDYttq5+ETzrtq5nKRXuxCgDsyk11TW8yI8KRQr0y7B7P6Vhz
         wy3GDoY4TrSPY91clfMG5kapASmeZLWVz/gSXOLhiTcV/K8hPWkbC9ZmiuSBBtmkvWAA
         kl6Q==
X-Gm-Message-State: AGi0Pua8enNnt1rcB6rg8RLSK2Su5YGebg/srP7pJZDZWELht3eOEk/Z
        72geuD/lcjflLuyOc3Yu5/LnXbO08TY=
X-Google-Smtp-Source: APiQypJUXsEagWJYSMZppPX3EWHhVkDSfu8lWg5acXnBz43PtV0/swrclqLTwQlR42Lgk8hN9v1dtg==
X-Received: by 2002:a17:90a:246d:: with SMTP id h100mr4872275pje.58.1588184088643;
        Wed, 29 Apr 2020 11:14:48 -0700 (PDT)
Received: from localhost ([45.127.44.67])
        by smtp.gmail.com with ESMTPSA id y10sm1560807pfb.53.2020.04.29.11.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:14:47 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, daniel.lezcano@linaro.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] drivers: thermal: tsens: Merge tsens-common.c into tsens.c
Date:   Wed, 29 Apr 2020 23:44:17 +0530
Message-Id: <e30e2ba6fa5c007983afd4d7d4e0311c0b57917a.1588183879.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tsens-common.c has outlived its usefuless. It was created expecting lots
of custom routines per version of the TSENS IP. We haven't needed those,
there is now only data in the version-specific files.

Merge the code for tsens-common.c into tsens.c. As a result,
- Remove any unnecessary forward declarations in tsens.h.
- Add a Linaro copyright to tsens.c.
- Fixup the Makefile to remove tsens-common.c.
- Where it made sense, fix some 80-column alignments in the
  tsens-common.c code being copied over.

There is no functional change with this patch.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/Makefile       |   4 +-
 drivers/thermal/qcom/tsens-common.c | 843 ----------------------------
 drivers/thermal/qcom/tsens.c        | 838 +++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h        |   5 -
 4 files changed, 840 insertions(+), 850 deletions(-)
 delete mode 100644 drivers/thermal/qcom/tsens-common.c

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 7c8dc6e366936..ec86eef7f6a6b 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-v0_1.o \
-				   tsens-8960.o tsens-v2.o tsens-v1.o
+qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
+				   tsens-8960.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
deleted file mode 100644
index 172545366636e..0000000000000
--- a/drivers/thermal/qcom/tsens-common.c
+++ /dev/null
@@ -1,843 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- */
-
-#include <linux/debugfs.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/nvmem-consumer.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include "tsens.h"
-
-/**
- * struct tsens_irq_data - IRQ status and temperature violations
- * @up_viol:        upper threshold violated
- * @up_thresh:      upper threshold temperature value
- * @up_irq_mask:    mask register for upper threshold irqs
- * @up_irq_clear:   clear register for uppper threshold irqs
- * @low_viol:       lower threshold violated
- * @low_thresh:     lower threshold temperature value
- * @low_irq_mask:   mask register for lower threshold irqs
- * @low_irq_clear:  clear register for lower threshold irqs
- * @crit_viol:      critical threshold violated
- * @crit_thresh:    critical threshold temperature value
- * @crit_irq_mask:  mask register for critical threshold irqs
- * @crit_irq_clear: clear register for critical threshold irqs
- *
- * Structure containing data about temperature threshold settings and
- * irq status if they were violated.
- */
-struct tsens_irq_data {
-	u32 up_viol;
-	int up_thresh;
-	u32 up_irq_mask;
-	u32 up_irq_clear;
-	u32 low_viol;
-	int low_thresh;
-	u32 low_irq_mask;
-	u32 low_irq_clear;
-	u32 crit_viol;
-	u32 crit_thresh;
-	u32 crit_irq_mask;
-	u32 crit_irq_clear;
-};
-
-char *qfprom_read(struct device *dev, const char *cname)
-{
-	struct nvmem_cell *cell;
-	ssize_t data;
-	char *ret;
-
-	cell = nvmem_cell_get(dev, cname);
-	if (IS_ERR(cell))
-		return ERR_CAST(cell);
-
-	ret = nvmem_cell_read(cell, &data);
-	nvmem_cell_put(cell);
-
-	return ret;
-}
-
-/*
- * Use this function on devices where slope and offset calculations
- * depend on calibration data read from qfprom. On others the slope
- * and offset values are derived from tz->tzp->slope and tz->tzp->offset
- * resp.
- */
-void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
-			     u32 *p2, u32 mode)
-{
-	int i;
-	int num, den;
-
-	for (i = 0; i < priv->num_sensors; i++) {
-		dev_dbg(priv->dev,
-			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
-			__func__, i, p1[i], p2[i]);
-
-		priv->sensor[i].slope = SLOPE_DEFAULT;
-		if (mode == TWO_PT_CALIB) {
-			/*
-			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
-			 *	temp_120_degc - temp_30_degc (x2 - x1)
-			 */
-			num = p2[i] - p1[i];
-			num *= SLOPE_FACTOR;
-			den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
-			priv->sensor[i].slope = num / den;
-		}
-
-		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
-				(CAL_DEGC_PT1 *
-				priv->sensor[i].slope);
-		dev_dbg(priv->dev, "%s: offset:%d\n", __func__, priv->sensor[i].offset);
-	}
-}
-
-static inline u32 degc_to_code(int degc, const struct tsens_sensor *s)
-{
-	u64 code = div_u64(((u64)degc * s->slope + s->offset), SLOPE_FACTOR);
-
-	pr_debug("%s: raw_code: 0x%llx, degc:%d\n", __func__, code, degc);
-	return clamp_val(code, THRESHOLD_MIN_ADC_CODE, THRESHOLD_MAX_ADC_CODE);
-}
-
-static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
-{
-	int degc, num, den;
-
-	num = (adc_code * SLOPE_FACTOR) - s->offset;
-	den = s->slope;
-
-	if (num > 0)
-		degc = num + (den / 2);
-	else if (num < 0)
-		degc = num - (den / 2);
-	else
-		degc = num;
-
-	degc /= den;
-
-	return degc;
-}
-
-/**
- * tsens_hw_to_mC - Return sign-extended temperature in mCelsius.
- * @s:     Pointer to sensor struct
- * @field: Index into regmap_field array pointing to temperature data
- *
- * This function handles temperature returned in ADC code or deciCelsius
- * depending on IP version.
- *
- * Return: Temperature in milliCelsius on success, a negative errno will
- * be returned in error cases
- */
-static int tsens_hw_to_mC(const struct tsens_sensor *s, int field)
-{
-	struct tsens_priv *priv = s->priv;
-	u32 resolution;
-	u32 temp = 0;
-	int ret;
-
-	resolution = priv->fields[LAST_TEMP_0].msb -
-		priv->fields[LAST_TEMP_0].lsb;
-
-	ret = regmap_field_read(priv->rf[field], &temp);
-	if (ret)
-		return ret;
-
-	/* Convert temperature from ADC code to milliCelsius */
-	if (priv->feat->adc)
-		return code_to_degc(temp, s) * 1000;
-
-	/* deciCelsius -> milliCelsius along with sign extension */
-	return sign_extend32(temp, resolution) * 100;
-}
-
-/**
- * tsens_mC_to_hw - Convert temperature to hardware register value
- * @s: Pointer to sensor struct
- * @temp: temperature in milliCelsius to be programmed to hardware
- *
- * This function outputs the value to be written to hardware in ADC code
- * or deciCelsius depending on IP version.
- *
- * Return: ADC code or temperature in deciCelsius.
- */
-static int tsens_mC_to_hw(const struct tsens_sensor *s, int temp)
-{
-	struct tsens_priv *priv = s->priv;
-
-	/* milliC to adc code */
-	if (priv->feat->adc)
-		return degc_to_code(temp / 1000, s);
-
-	/* milliC to deciC */
-	return temp / 100;
-}
-
-static inline enum tsens_ver tsens_version(struct tsens_priv *priv)
-{
-	return priv->feat->ver_major;
-}
-
-static void tsens_set_interrupt_v1(struct tsens_priv *priv, u32 hw_id,
-				   enum tsens_irq_type irq_type, bool enable)
-{
-	u32 index = 0;
-
-	switch (irq_type) {
-	case UPPER:
-		index = UP_INT_CLEAR_0 + hw_id;
-		break;
-	case LOWER:
-		index = LOW_INT_CLEAR_0 + hw_id;
-		break;
-	case CRITICAL:
-		/* No critical interrupts before v2 */
-		return;
-	}
-	regmap_field_write(priv->rf[index], enable ? 0 : 1);
-}
-
-static void tsens_set_interrupt_v2(struct tsens_priv *priv, u32 hw_id,
-				   enum tsens_irq_type irq_type, bool enable)
-{
-	u32 index_mask = 0, index_clear = 0;
-
-	/*
-	 * To enable the interrupt flag for a sensor:
-	 *    - clear the mask bit
-	 * To disable the interrupt flag for a sensor:
-	 *    - Mask further interrupts for this sensor
-	 *    - Write 1 followed by 0 to clear the interrupt
-	 */
-	switch (irq_type) {
-	case UPPER:
-		index_mask  = UP_INT_MASK_0 + hw_id;
-		index_clear = UP_INT_CLEAR_0 + hw_id;
-		break;
-	case LOWER:
-		index_mask  = LOW_INT_MASK_0 + hw_id;
-		index_clear = LOW_INT_CLEAR_0 + hw_id;
-		break;
-	case CRITICAL:
-		index_mask  = CRIT_INT_MASK_0 + hw_id;
-		index_clear = CRIT_INT_CLEAR_0 + hw_id;
-		break;
-	}
-
-	if (enable) {
-		regmap_field_write(priv->rf[index_mask], 0);
-	} else {
-		regmap_field_write(priv->rf[index_mask],  1);
-		regmap_field_write(priv->rf[index_clear], 1);
-		regmap_field_write(priv->rf[index_clear], 0);
-	}
-}
-
-/**
- * tsens_set_interrupt - Set state of an interrupt
- * @priv: Pointer to tsens controller private data
- * @hw_id: Hardware ID aka. sensor number
- * @irq_type: irq_type from enum tsens_irq_type
- * @enable: false = disable, true = enable
- *
- * Call IP-specific function to set state of an interrupt
- *
- * Return: void
- */
-static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
-				enum tsens_irq_type irq_type, bool enable)
-{
-	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
-		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
-		enable ? "en" : "dis");
-	if (tsens_version(priv) > VER_1_X)
-		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
-	else
-		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
-}
-
-/**
- * tsens_threshold_violated - Check if a sensor temperature violated a preset threshold
- * @priv: Pointer to tsens controller private data
- * @hw_id: Hardware ID aka. sensor number
- * @d: Pointer to irq state data
- *
- * Return: 0 if threshold was not violated, 1 if it was violated and negative
- * errno in case of errors
- */
-static int tsens_threshold_violated(struct tsens_priv *priv, u32 hw_id,
-				    struct tsens_irq_data *d)
-{
-	int ret;
-
-	ret = regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id], &d->up_viol);
-	if (ret)
-		return ret;
-	ret = regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &d->low_viol);
-	if (ret)
-		return ret;
-
-	if (priv->feat->crit_int) {
-		ret = regmap_field_read(priv->rf[CRITICAL_STATUS_0 + hw_id],
-					&d->crit_viol);
-		if (ret)
-			return ret;
-	}
-
-	if (d->up_viol || d->low_viol || d->crit_viol)
-		return 1;
-
-	return 0;
-}
-
-static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
-				const struct tsens_sensor *s,
-				struct tsens_irq_data *d)
-{
-	int ret;
-
-	ret = regmap_field_read(priv->rf[UP_INT_CLEAR_0 + hw_id], &d->up_irq_clear);
-	if (ret)
-		return ret;
-	ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
-	if (ret)
-		return ret;
-	if (tsens_version(priv) > VER_1_X) {
-		ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
-		if (ret)
-			return ret;
-		ret = regmap_field_read(priv->rf[LOW_INT_MASK_0 + hw_id], &d->low_irq_mask);
-		if (ret)
-			return ret;
-		ret = regmap_field_read(priv->rf[CRIT_INT_CLEAR_0 + hw_id],
-					&d->crit_irq_clear);
-		if (ret)
-			return ret;
-		ret = regmap_field_read(priv->rf[CRIT_INT_MASK_0 + hw_id],
-					&d->crit_irq_mask);
-		if (ret)
-			return ret;
-
-		d->crit_thresh = tsens_hw_to_mC(s, CRIT_THRESH_0 + hw_id);
-	} else {
-		/* No mask register on older TSENS */
-		d->up_irq_mask = 0;
-		d->low_irq_mask = 0;
-		d->crit_irq_clear = 0;
-		d->crit_irq_mask = 0;
-		d->crit_thresh = 0;
-	}
-
-	d->up_thresh  = tsens_hw_to_mC(s, UP_THRESH_0 + hw_id);
-	d->low_thresh = tsens_hw_to_mC(s, LOW_THRESH_0 + hw_id);
-
-	dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u|%u) | clr(%u|%u|%u) | mask(%u|%u|%u)\n",
-		hw_id, __func__,
-		(d->up_viol || d->low_viol || d->crit_viol) ? "(V)" : "",
-		d->low_viol, d->up_viol, d->crit_viol,
-		d->low_irq_clear, d->up_irq_clear, d->crit_irq_clear,
-		d->low_irq_mask, d->up_irq_mask, d->crit_irq_mask);
-	dev_dbg(priv->dev, "[%u] %s%s: thresh: (%d:%d:%d)\n", hw_id, __func__,
-		(d->up_viol || d->low_viol || d->crit_viol) ? "(V)" : "",
-		d->low_thresh, d->up_thresh, d->crit_thresh);
-
-	return 0;
-}
-
-static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
-{
-	if (ver > VER_1_X)
-		return mask & (1 << hw_id);
-
-	/* v1, v0.1 don't have a irq mask register */
-	return 0;
-}
-
-/**
- * tsens_critical_irq_thread() - Threaded handler for critical interrupts
- * @irq: irq number
- * @data: tsens controller private data
- *
- * Check FSM watchdog bark status and clear if needed.
- * Check all sensors to find ones that violated their critical threshold limits.
- * Clear and then re-enable the interrupt.
- *
- * The level-triggered interrupt might deassert if the temperature returned to
- * within the threshold limits by the time the handler got scheduled. We
- * consider the irq to have been handled in that case.
- *
- * Return: IRQ_HANDLED
- */
-irqreturn_t tsens_critical_irq_thread(int irq, void *data)
-{
-	struct tsens_priv *priv = data;
-	struct tsens_irq_data d;
-	int temp, ret, i;
-	u32 wdog_status, wdog_count;
-
-	if (priv->feat->has_watchdog) {
-		ret = regmap_field_read(priv->rf[WDOG_BARK_STATUS],
-					&wdog_status);
-		if (ret)
-			return ret;
-
-		if (wdog_status) {
-			/* Clear WDOG interrupt */
-			regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
-			regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
-			ret = regmap_field_read(priv->rf[WDOG_BARK_COUNT],
-						&wdog_count);
-			if (ret)
-				return ret;
-			if (wdog_count)
-				dev_dbg(priv->dev, "%s: watchdog count: %d\n",
-					__func__, wdog_count);
-
-			/* Fall through to handle critical interrupts if any */
-		}
-	}
-
-	for (i = 0; i < priv->num_sensors; i++) {
-		const struct tsens_sensor *s = &priv->sensor[i];
-		u32 hw_id = s->hw_id;
-
-		if (IS_ERR(s->tzd))
-			continue;
-		if (!tsens_threshold_violated(priv, hw_id, &d))
-			continue;
-		ret = get_temp_tsens_valid(s, &temp);
-		if (ret) {
-			dev_err(priv->dev, "[%u] %s: error reading sensor\n",
-				hw_id, __func__);
-			continue;
-		}
-
-		tsens_read_irq_state(priv, hw_id, s, &d);
-		if (d.crit_viol &&
-		    !masked_irq(hw_id, d.crit_irq_mask, tsens_version(priv))) {
-			/* Mask critical interrupts, unused on Linux */
-			tsens_set_interrupt(priv, hw_id, CRITICAL, false);
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
-/**
- * tsens_irq_thread - Threaded interrupt handler for uplow interrupts
- * @irq: irq number
- * @data: tsens controller private data
- *
- * Check all sensors to find ones that violated their threshold limits. If the
- * temperature is still outside the limits, call thermal_zone_device_update() to
- * update the thresholds, else re-enable the interrupts.
- *
- * The level-triggered interrupt might deassert if the temperature returned to
- * within the threshold limits by the time the handler got scheduled. We
- * consider the irq to have been handled in that case.
- *
- * Return: IRQ_HANDLED
- */
-irqreturn_t tsens_irq_thread(int irq, void *data)
-{
-	struct tsens_priv *priv = data;
-	struct tsens_irq_data d;
-	bool enable = true, disable = false;
-	unsigned long flags;
-	int temp, ret, i;
-
-	for (i = 0; i < priv->num_sensors; i++) {
-		bool trigger = false;
-		const struct tsens_sensor *s = &priv->sensor[i];
-		u32 hw_id = s->hw_id;
-
-		if (IS_ERR(s->tzd))
-			continue;
-		if (!tsens_threshold_violated(priv, hw_id, &d))
-			continue;
-		ret = get_temp_tsens_valid(s, &temp);
-		if (ret) {
-			dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
-			continue;
-		}
-
-		spin_lock_irqsave(&priv->ul_lock, flags);
-
-		tsens_read_irq_state(priv, hw_id, s, &d);
-
-		if (d.up_viol &&
-		    !masked_irq(hw_id, d.up_irq_mask, tsens_version(priv))) {
-			tsens_set_interrupt(priv, hw_id, UPPER, disable);
-			if (d.up_thresh > temp) {
-				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
-					hw_id, __func__);
-				tsens_set_interrupt(priv, hw_id, UPPER, enable);
-			} else {
-				trigger = true;
-				/* Keep irq masked */
-			}
-		} else if (d.low_viol &&
-			   !masked_irq(hw_id, d.low_irq_mask, tsens_version(priv))) {
-			tsens_set_interrupt(priv, hw_id, LOWER, disable);
-			if (d.low_thresh < temp) {
-				dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
-					hw_id, __func__);
-				tsens_set_interrupt(priv, hw_id, LOWER, enable);
-			} else {
-				trigger = true;
-				/* Keep irq masked */
-			}
-		}
-
-		spin_unlock_irqrestore(&priv->ul_lock, flags);
-
-		if (trigger) {
-			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
-				hw_id, __func__, temp);
-			thermal_zone_device_update(s->tzd,
-						   THERMAL_EVENT_UNSPECIFIED);
-		} else {
-			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
-				hw_id, __func__, temp);
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
-int tsens_set_trips(void *_sensor, int low, int high)
-{
-	struct tsens_sensor *s = _sensor;
-	struct tsens_priv *priv = s->priv;
-	struct device *dev = priv->dev;
-	struct tsens_irq_data d;
-	unsigned long flags;
-	int high_val, low_val, cl_high, cl_low;
-	u32 hw_id = s->hw_id;
-
-	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
-		hw_id, __func__, low, high);
-
-	cl_high = clamp_val(high, -40000, 120000);
-	cl_low  = clamp_val(low, -40000, 120000);
-
-	high_val = tsens_mC_to_hw(s, cl_high);
-	low_val  = tsens_mC_to_hw(s, cl_low);
-
-	spin_lock_irqsave(&priv->ul_lock, flags);
-
-	tsens_read_irq_state(priv, hw_id, s, &d);
-
-	/* Write the new thresholds and clear the status */
-	regmap_field_write(priv->rf[LOW_THRESH_0 + hw_id], low_val);
-	regmap_field_write(priv->rf[UP_THRESH_0 + hw_id], high_val);
-	tsens_set_interrupt(priv, hw_id, LOWER, true);
-	tsens_set_interrupt(priv, hw_id, UPPER, true);
-
-	spin_unlock_irqrestore(&priv->ul_lock, flags);
-
-	dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
-		hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
-
-	return 0;
-}
-
-int tsens_enable_irq(struct tsens_priv *priv)
-{
-	int ret;
-	int val = tsens_version(priv) > VER_1_X ? 7 : 1;
-
-	ret = regmap_field_write(priv->rf[INT_EN], val);
-	if (ret < 0)
-		dev_err(priv->dev, "%s: failed to enable interrupts\n", __func__);
-
-	return ret;
-}
-
-void tsens_disable_irq(struct tsens_priv *priv)
-{
-	regmap_field_write(priv->rf[INT_EN], 0);
-}
-
-int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
-{
-	struct tsens_priv *priv = s->priv;
-	int hw_id = s->hw_id;
-	u32 temp_idx = LAST_TEMP_0 + hw_id;
-	u32 valid_idx = VALID_0 + hw_id;
-	u32 valid;
-	int ret;
-
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	while (!valid) {
-		/* Valid bit is 0 for 6 AHB clock cycles.
-		 * At 19.2MHz, 1 AHB clock is ~60ns.
-		 * We should enter this loop very, very rarely.
-		 */
-		ndelay(400);
-		ret = regmap_field_read(priv->rf[valid_idx], &valid);
-		if (ret)
-			return ret;
-	}
-
-	/* Valid bit is set, OK to read the temperature */
-	*temp = tsens_hw_to_mC(s, temp_idx);
-
-	return 0;
-}
-
-int get_temp_common(const struct tsens_sensor *s, int *temp)
-{
-	struct tsens_priv *priv = s->priv;
-	int hw_id = s->hw_id;
-	int last_temp = 0, ret;
-
-	ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
-	if (ret)
-		return ret;
-
-	*temp = code_to_degc(last_temp, s) * 1000;
-
-	return 0;
-}
-
-#ifdef CONFIG_DEBUG_FS
-static int dbg_sensors_show(struct seq_file *s, void *data)
-{
-	struct platform_device *pdev = s->private;
-	struct tsens_priv *priv = platform_get_drvdata(pdev);
-	int i;
-
-	seq_printf(s, "max: %2d\nnum: %2d\n\n",
-		   priv->feat->max_sensors, priv->num_sensors);
-
-	seq_puts(s, "      id    slope   offset\n--------------------------\n");
-	for (i = 0;  i < priv->num_sensors; i++) {
-		seq_printf(s, "%8d %8d %8d\n", priv->sensor[i].hw_id,
-			   priv->sensor[i].slope, priv->sensor[i].offset);
-	}
-
-	return 0;
-}
-
-static int dbg_version_show(struct seq_file *s, void *data)
-{
-	struct platform_device *pdev = s->private;
-	struct tsens_priv *priv = platform_get_drvdata(pdev);
-	u32 maj_ver, min_ver, step_ver;
-	int ret;
-
-	if (tsens_version(priv) > VER_0_1) {
-		ret = regmap_field_read(priv->rf[VER_MAJOR], &maj_ver);
-		if (ret)
-			return ret;
-		ret = regmap_field_read(priv->rf[VER_MINOR], &min_ver);
-		if (ret)
-			return ret;
-		ret = regmap_field_read(priv->rf[VER_STEP], &step_ver);
-		if (ret)
-			return ret;
-		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
-	} else {
-		seq_puts(s, "0.1.0\n");
-	}
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(dbg_version);
-DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
-
-static void tsens_debug_init(struct platform_device *pdev)
-{
-	struct tsens_priv *priv = platform_get_drvdata(pdev);
-	struct dentry *root, *file;
-
-	root = debugfs_lookup("tsens", NULL);
-	if (!root)
-		priv->debug_root = debugfs_create_dir("tsens", NULL);
-	else
-		priv->debug_root = root;
-
-	file = debugfs_lookup("version", priv->debug_root);
-	if (!file)
-		debugfs_create_file("version", 0444, priv->debug_root,
-				    pdev, &dbg_version_fops);
-
-	/* A directory for each instance of the TSENS IP */
-	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
-	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
-}
-#else
-static inline void tsens_debug_init(struct platform_device *pdev) {}
-#endif
-
-static const struct regmap_config tsens_config = {
-	.name		= "tm",
-	.reg_bits	= 32,
-	.val_bits	= 32,
-	.reg_stride	= 4,
-};
-
-static const struct regmap_config tsens_srot_config = {
-	.name		= "srot",
-	.reg_bits	= 32,
-	.val_bits	= 32,
-	.reg_stride	= 4,
-};
-
-int __init init_common(struct tsens_priv *priv)
-{
-	void __iomem *tm_base, *srot_base;
-	struct device *dev = priv->dev;
-	u32 ver_minor;
-	struct resource *res;
-	u32 enabled;
-	int ret, i, j;
-	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
-
-	if (!op)
-		return -EINVAL;
-
-	if (op->num_resources > 1) {
-		/* DT with separate SROT and TM address space */
-		priv->tm_offset = 0;
-		res = platform_get_resource(op, IORESOURCE_MEM, 1);
-		srot_base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(srot_base)) {
-			ret = PTR_ERR(srot_base);
-			goto err_put_device;
-		}
-
-		priv->srot_map = devm_regmap_init_mmio(dev, srot_base,
-							&tsens_srot_config);
-		if (IS_ERR(priv->srot_map)) {
-			ret = PTR_ERR(priv->srot_map);
-			goto err_put_device;
-		}
-	} else {
-		/* old DTs where SROT and TM were in a contiguous 2K block */
-		priv->tm_offset = 0x1000;
-	}
-
-	res = platform_get_resource(op, IORESOURCE_MEM, 0);
-	tm_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(tm_base)) {
-		ret = PTR_ERR(tm_base);
-		goto err_put_device;
-	}
-
-	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
-	if (IS_ERR(priv->tm_map)) {
-		ret = PTR_ERR(priv->tm_map);
-		goto err_put_device;
-	}
-
-	if (tsens_version(priv) > VER_0_1) {
-		for (i = VER_MAJOR; i <= VER_STEP; i++) {
-			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
-							      priv->fields[i]);
-			if (IS_ERR(priv->rf[i]))
-				return PTR_ERR(priv->rf[i]);
-		}
-		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
-		if (ret)
-			goto err_put_device;
-	}
-
-	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
-						     priv->fields[TSENS_EN]);
-	if (IS_ERR(priv->rf[TSENS_EN])) {
-		ret = PTR_ERR(priv->rf[TSENS_EN]);
-		goto err_put_device;
-	}
-	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
-	if (ret)
-		goto err_put_device;
-	if (!enabled) {
-		dev_err(dev, "%s: device not enabled\n", __func__);
-		ret = -ENODEV;
-		goto err_put_device;
-	}
-
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
-	/* This loop might need changes if enum regfield_ids is reordered */
-	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
-		for (i = 0; i < priv->feat->max_sensors; i++) {
-			int idx = j + i;
-
-			priv->rf[idx] = devm_regmap_field_alloc(dev, priv->tm_map,
-								priv->fields[idx]);
-			if (IS_ERR(priv->rf[idx])) {
-				ret = PTR_ERR(priv->rf[idx]);
-				goto err_put_device;
-			}
-		}
-	}
-
-	if (priv->feat->crit_int) {
-		/* Loop might need changes if enum regfield_ids is reordered */
-		for (j = CRITICAL_STATUS_0; j <= CRIT_THRESH_15; j += 16) {
-			for (i = 0; i < priv->feat->max_sensors; i++) {
-				int idx = j + i;
-
-				priv->rf[idx] =
-					devm_regmap_field_alloc(dev,
-								priv->tm_map,
-								priv->fields[idx]);
-				if (IS_ERR(priv->rf[idx])) {
-					ret = PTR_ERR(priv->rf[idx]);
-					goto err_put_device;
-				}
-			}
-		}
-	}
-
-	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
-		/* Watchdog is present only on v2.3+ */
-		priv->feat->has_watchdog = 1;
-		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
-			priv->rf[i] = devm_regmap_field_alloc(dev, priv->tm_map,
-							      priv->fields[i]);
-			if (IS_ERR(priv->rf[i])) {
-				ret = PTR_ERR(priv->rf[i]);
-				goto err_put_device;
-			}
-		}
-		/*
-		 * Watchdog is already enabled, unmask the bark.
-		 * Disable cycle completion monitoring
-		 */
-		regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
-		regmap_field_write(priv->rf[CC_MON_MASK], 1);
-	}
-
-	spin_lock_init(&priv->ul_lock);
-	tsens_enable_irq(priv);
-	tsens_debug_init(op);
-
-err_put_device:
-	put_device(&op->dev);
-	return ret;
-}
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 2f77d235cf735..8d3e94d2a9ed4 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1,19 +1,857 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2019, 2020, Linaro Ltd.
  */
 
 #include <linux/debugfs.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 #include "tsens.h"
 
+/**
+ * struct tsens_irq_data - IRQ status and temperature violations
+ * @up_viol:        upper threshold violated
+ * @up_thresh:      upper threshold temperature value
+ * @up_irq_mask:    mask register for upper threshold irqs
+ * @up_irq_clear:   clear register for uppper threshold irqs
+ * @low_viol:       lower threshold violated
+ * @low_thresh:     lower threshold temperature value
+ * @low_irq_mask:   mask register for lower threshold irqs
+ * @low_irq_clear:  clear register for lower threshold irqs
+ * @crit_viol:      critical threshold violated
+ * @crit_thresh:    critical threshold temperature value
+ * @crit_irq_mask:  mask register for critical threshold irqs
+ * @crit_irq_clear: clear register for critical threshold irqs
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
+	u32 crit_viol;
+	u32 crit_thresh;
+	u32 crit_irq_mask;
+	u32 crit_irq_clear;
+};
+
+char *qfprom_read(struct device *dev, const char *cname)
+{
+	struct nvmem_cell *cell;
+	ssize_t data;
+	char *ret;
+
+	cell = nvmem_cell_get(dev, cname);
+	if (IS_ERR(cell))
+		return ERR_CAST(cell);
+
+	ret = nvmem_cell_read(cell, &data);
+	nvmem_cell_put(cell);
+
+	return ret;
+}
+
+/*
+ * Use this function on devices where slope and offset calculations
+ * depend on calibration data read from qfprom. On others the slope
+ * and offset values are derived from tz->tzp->slope and tz->tzp->offset
+ * resp.
+ */
+void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
+			     u32 *p2, u32 mode)
+{
+	int i;
+	int num, den;
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		dev_dbg(priv->dev,
+			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
+			__func__, i, p1[i], p2[i]);
+
+		priv->sensor[i].slope = SLOPE_DEFAULT;
+		if (mode == TWO_PT_CALIB) {
+			/*
+			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
+			 *	temp_120_degc - temp_30_degc (x2 - x1)
+			 */
+			num = p2[i] - p1[i];
+			num *= SLOPE_FACTOR;
+			den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
+			priv->sensor[i].slope = num / den;
+		}
+
+		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
+				(CAL_DEGC_PT1 *
+				priv->sensor[i].slope);
+		dev_dbg(priv->dev, "%s: offset:%d\n", __func__,
+			priv->sensor[i].offset);
+	}
+}
+
+static inline u32 degc_to_code(int degc, const struct tsens_sensor *s)
+{
+	u64 code = div_u64(((u64)degc * s->slope + s->offset), SLOPE_FACTOR);
+
+	pr_debug("%s: raw_code: 0x%llx, degc:%d\n", __func__, code, degc);
+	return clamp_val(code, THRESHOLD_MIN_ADC_CODE, THRESHOLD_MAX_ADC_CODE);
+}
+
+static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
+{
+	int degc, num, den;
+
+	num = (adc_code * SLOPE_FACTOR) - s->offset;
+	den = s->slope;
+
+	if (num > 0)
+		degc = num + (den / 2);
+	else if (num < 0)
+		degc = num - (den / 2);
+	else
+		degc = num;
+
+	degc /= den;
+
+	return degc;
+}
+
+/**
+ * tsens_hw_to_mC - Return sign-extended temperature in mCelsius.
+ * @s:     Pointer to sensor struct
+ * @field: Index into regmap_field array pointing to temperature data
+ *
+ * This function handles temperature returned in ADC code or deciCelsius
+ * depending on IP version.
+ *
+ * Return: Temperature in milliCelsius on success, a negative errno will
+ * be returned in error cases
+ */
+static int tsens_hw_to_mC(const struct tsens_sensor *s, int field)
+{
+	struct tsens_priv *priv = s->priv;
+	u32 resolution;
+	u32 temp = 0;
+	int ret;
+
+	resolution = priv->fields[LAST_TEMP_0].msb -
+		priv->fields[LAST_TEMP_0].lsb;
+
+	ret = regmap_field_read(priv->rf[field], &temp);
+	if (ret)
+		return ret;
+
+	/* Convert temperature from ADC code to milliCelsius */
+	if (priv->feat->adc)
+		return code_to_degc(temp, s) * 1000;
+
+	/* deciCelsius -> milliCelsius along with sign extension */
+	return sign_extend32(temp, resolution) * 100;
+}
+
+/**
+ * tsens_mC_to_hw - Convert temperature to hardware register value
+ * @s: Pointer to sensor struct
+ * @temp: temperature in milliCelsius to be programmed to hardware
+ *
+ * This function outputs the value to be written to hardware in ADC code
+ * or deciCelsius depending on IP version.
+ *
+ * Return: ADC code or temperature in deciCelsius.
+ */
+static int tsens_mC_to_hw(const struct tsens_sensor *s, int temp)
+{
+	struct tsens_priv *priv = s->priv;
+
+	/* milliC to adc code */
+	if (priv->feat->adc)
+		return degc_to_code(temp / 1000, s);
+
+	/* milliC to deciC */
+	return temp / 100;
+}
+
+static inline enum tsens_ver tsens_version(struct tsens_priv *priv)
+{
+	return priv->feat->ver_major;
+}
+
+static void tsens_set_interrupt_v1(struct tsens_priv *priv, u32 hw_id,
+				   enum tsens_irq_type irq_type, bool enable)
+{
+	u32 index = 0;
+
+	switch (irq_type) {
+	case UPPER:
+		index = UP_INT_CLEAR_0 + hw_id;
+		break;
+	case LOWER:
+		index = LOW_INT_CLEAR_0 + hw_id;
+		break;
+	case CRITICAL:
+		/* No critical interrupts before v2 */
+		return;
+	}
+	regmap_field_write(priv->rf[index], enable ? 0 : 1);
+}
+
+static void tsens_set_interrupt_v2(struct tsens_priv *priv, u32 hw_id,
+				   enum tsens_irq_type irq_type, bool enable)
+{
+	u32 index_mask = 0, index_clear = 0;
+
+	/*
+	 * To enable the interrupt flag for a sensor:
+	 *    - clear the mask bit
+	 * To disable the interrupt flag for a sensor:
+	 *    - Mask further interrupts for this sensor
+	 *    - Write 1 followed by 0 to clear the interrupt
+	 */
+	switch (irq_type) {
+	case UPPER:
+		index_mask  = UP_INT_MASK_0 + hw_id;
+		index_clear = UP_INT_CLEAR_0 + hw_id;
+		break;
+	case LOWER:
+		index_mask  = LOW_INT_MASK_0 + hw_id;
+		index_clear = LOW_INT_CLEAR_0 + hw_id;
+		break;
+	case CRITICAL:
+		index_mask  = CRIT_INT_MASK_0 + hw_id;
+		index_clear = CRIT_INT_CLEAR_0 + hw_id;
+		break;
+	}
+
+	if (enable) {
+		regmap_field_write(priv->rf[index_mask], 0);
+	} else {
+		regmap_field_write(priv->rf[index_mask],  1);
+		regmap_field_write(priv->rf[index_clear], 1);
+		regmap_field_write(priv->rf[index_clear], 0);
+	}
+}
+
+/**
+ * tsens_set_interrupt - Set state of an interrupt
+ * @priv: Pointer to tsens controller private data
+ * @hw_id: Hardware ID aka. sensor number
+ * @irq_type: irq_type from enum tsens_irq_type
+ * @enable: false = disable, true = enable
+ *
+ * Call IP-specific function to set state of an interrupt
+ *
+ * Return: void
+ */
+static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
+				enum tsens_irq_type irq_type, bool enable)
+{
+	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
+		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
+		enable ? "en" : "dis");
+	if (tsens_version(priv) > VER_1_X)
+		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
+	else
+		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
+}
+
+/**
+ * tsens_threshold_violated - Check if a sensor temperature violated a preset threshold
+ * @priv: Pointer to tsens controller private data
+ * @hw_id: Hardware ID aka. sensor number
+ * @d: Pointer to irq state data
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
+
+	if (priv->feat->crit_int) {
+		ret = regmap_field_read(priv->rf[CRITICAL_STATUS_0 + hw_id],
+					&d->crit_viol);
+		if (ret)
+			return ret;
+	}
+
+	if (d->up_viol || d->low_viol || d->crit_viol)
+		return 1;
+
+	return 0;
+}
+
+static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
+				const struct tsens_sensor *s,
+				struct tsens_irq_data *d)
+{
+	int ret;
+
+	ret = regmap_field_read(priv->rf[UP_INT_CLEAR_0 + hw_id], &d->up_irq_clear);
+	if (ret)
+		return ret;
+	ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
+	if (ret)
+		return ret;
+	if (tsens_version(priv) > VER_1_X) {
+		ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[LOW_INT_MASK_0 + hw_id], &d->low_irq_mask);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[CRIT_INT_CLEAR_0 + hw_id],
+					&d->crit_irq_clear);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[CRIT_INT_MASK_0 + hw_id],
+					&d->crit_irq_mask);
+		if (ret)
+			return ret;
+
+		d->crit_thresh = tsens_hw_to_mC(s, CRIT_THRESH_0 + hw_id);
+	} else {
+		/* No mask register on older TSENS */
+		d->up_irq_mask = 0;
+		d->low_irq_mask = 0;
+		d->crit_irq_clear = 0;
+		d->crit_irq_mask = 0;
+		d->crit_thresh = 0;
+	}
+
+	d->up_thresh  = tsens_hw_to_mC(s, UP_THRESH_0 + hw_id);
+	d->low_thresh = tsens_hw_to_mC(s, LOW_THRESH_0 + hw_id);
+
+	dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u|%u) | clr(%u|%u|%u) | mask(%u|%u|%u)\n",
+		hw_id, __func__,
+		(d->up_viol || d->low_viol || d->crit_viol) ? "(V)" : "",
+		d->low_viol, d->up_viol, d->crit_viol,
+		d->low_irq_clear, d->up_irq_clear, d->crit_irq_clear,
+		d->low_irq_mask, d->up_irq_mask, d->crit_irq_mask);
+	dev_dbg(priv->dev, "[%u] %s%s: thresh: (%d:%d:%d)\n", hw_id, __func__,
+		(d->up_viol || d->low_viol || d->crit_viol) ? "(V)" : "",
+		d->low_thresh, d->up_thresh, d->crit_thresh);
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
+/**
+ * tsens_critical_irq_thread() - Threaded handler for critical interrupts
+ * @irq: irq number
+ * @data: tsens controller private data
+ *
+ * Check FSM watchdog bark status and clear if needed.
+ * Check all sensors to find ones that violated their critical threshold limits.
+ * Clear and then re-enable the interrupt.
+ *
+ * The level-triggered interrupt might deassert if the temperature returned to
+ * within the threshold limits by the time the handler got scheduled. We
+ * consider the irq to have been handled in that case.
+ *
+ * Return: IRQ_HANDLED
+ */
+irqreturn_t tsens_critical_irq_thread(int irq, void *data)
+{
+	struct tsens_priv *priv = data;
+	struct tsens_irq_data d;
+	int temp, ret, i;
+	u32 wdog_status, wdog_count;
+
+	if (priv->feat->has_watchdog) {
+		ret = regmap_field_read(priv->rf[WDOG_BARK_STATUS],
+					&wdog_status);
+		if (ret)
+			return ret;
+
+		if (wdog_status) {
+			/* Clear WDOG interrupt */
+			regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
+			regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
+			ret = regmap_field_read(priv->rf[WDOG_BARK_COUNT],
+						&wdog_count);
+			if (ret)
+				return ret;
+			if (wdog_count)
+				dev_dbg(priv->dev, "%s: watchdog count: %d\n",
+					__func__, wdog_count);
+
+			/* Fall through to handle critical interrupts if any */
+		}
+	}
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		const struct tsens_sensor *s = &priv->sensor[i];
+		u32 hw_id = s->hw_id;
+
+		if (IS_ERR(s->tzd))
+			continue;
+		if (!tsens_threshold_violated(priv, hw_id, &d))
+			continue;
+		ret = get_temp_tsens_valid(s, &temp);
+		if (ret) {
+			dev_err(priv->dev, "[%u] %s: error reading sensor\n",
+				hw_id, __func__);
+			continue;
+		}
+
+		tsens_read_irq_state(priv, hw_id, s, &d);
+		if (d.crit_viol &&
+		    !masked_irq(hw_id, d.crit_irq_mask, tsens_version(priv))) {
+			/* Mask critical interrupts, unused on Linux */
+			tsens_set_interrupt(priv, hw_id, CRITICAL, false);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * tsens_irq_thread - Threaded interrupt handler for uplow interrupts
+ * @irq: irq number
+ * @data: tsens controller private data
+ *
+ * Check all sensors to find ones that violated their threshold limits. If the
+ * temperature is still outside the limits, call thermal_zone_device_update() to
+ * update the thresholds, else re-enable the interrupts.
+ *
+ * The level-triggered interrupt might deassert if the temperature returned to
+ * within the threshold limits by the time the handler got scheduled. We
+ * consider the irq to have been handled in that case.
+ *
+ * Return: IRQ_HANDLED
+ */
+irqreturn_t tsens_irq_thread(int irq, void *data)
+{
+	struct tsens_priv *priv = data;
+	struct tsens_irq_data d;
+	bool enable = true, disable = false;
+	unsigned long flags;
+	int temp, ret, i;
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		bool trigger = false;
+		const struct tsens_sensor *s = &priv->sensor[i];
+		u32 hw_id = s->hw_id;
+
+		if (IS_ERR(s->tzd))
+			continue;
+		if (!tsens_threshold_violated(priv, hw_id, &d))
+			continue;
+		ret = get_temp_tsens_valid(s, &temp);
+		if (ret) {
+			dev_err(priv->dev, "[%u] %s: error reading sensor\n",
+				hw_id, __func__);
+			continue;
+		}
+
+		spin_lock_irqsave(&priv->ul_lock, flags);
+
+		tsens_read_irq_state(priv, hw_id, s, &d);
+
+		if (d.up_viol &&
+		    !masked_irq(hw_id, d.up_irq_mask, tsens_version(priv))) {
+			tsens_set_interrupt(priv, hw_id, UPPER, disable);
+			if (d.up_thresh > temp) {
+				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
+					hw_id, __func__);
+				tsens_set_interrupt(priv, hw_id, UPPER, enable);
+			} else {
+				trigger = true;
+				/* Keep irq masked */
+			}
+		} else if (d.low_viol &&
+			   !masked_irq(hw_id, d.low_irq_mask, tsens_version(priv))) {
+			tsens_set_interrupt(priv, hw_id, LOWER, disable);
+			if (d.low_thresh < temp) {
+				dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
+					hw_id, __func__);
+				tsens_set_interrupt(priv, hw_id, LOWER, enable);
+			} else {
+				trigger = true;
+				/* Keep irq masked */
+			}
+		}
+
+		spin_unlock_irqrestore(&priv->ul_lock, flags);
+
+		if (trigger) {
+			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
+				hw_id, __func__, temp);
+			thermal_zone_device_update(s->tzd,
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
+	tsens_set_interrupt(priv, hw_id, LOWER, true);
+	tsens_set_interrupt(priv, hw_id, UPPER, true);
+
+	spin_unlock_irqrestore(&priv->ul_lock, flags);
+
+	dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
+		hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
+
+	return 0;
+}
+
+int tsens_enable_irq(struct tsens_priv *priv)
+{
+	int ret;
+	int val = tsens_version(priv) > VER_1_X ? 7 : 1;
+
+	ret = regmap_field_write(priv->rf[INT_EN], val);
+	if (ret < 0)
+		dev_err(priv->dev, "%s: failed to enable interrupts\n",
+			__func__);
+
+	return ret;
+}
+
+void tsens_disable_irq(struct tsens_priv *priv)
+{
+	regmap_field_write(priv->rf[INT_EN], 0);
+}
+
+int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
+{
+	struct tsens_priv *priv = s->priv;
+	int hw_id = s->hw_id;
+	u32 temp_idx = LAST_TEMP_0 + hw_id;
+	u32 valid_idx = VALID_0 + hw_id;
+	u32 valid;
+	int ret;
+
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
+	if (ret)
+		return ret;
+	while (!valid) {
+		/* Valid bit is 0 for 6 AHB clock cycles.
+		 * At 19.2MHz, 1 AHB clock is ~60ns.
+		 * We should enter this loop very, very rarely.
+		 */
+		ndelay(400);
+		ret = regmap_field_read(priv->rf[valid_idx], &valid);
+		if (ret)
+			return ret;
+	}
+
+	/* Valid bit is set, OK to read the temperature */
+	*temp = tsens_hw_to_mC(s, temp_idx);
+
+	return 0;
+}
+
+int get_temp_common(const struct tsens_sensor *s, int *temp)
+{
+	struct tsens_priv *priv = s->priv;
+	int hw_id = s->hw_id;
+	int last_temp = 0, ret;
+
+	ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
+	if (ret)
+		return ret;
+
+	*temp = code_to_degc(last_temp, s) * 1000;
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int dbg_sensors_show(struct seq_file *s, void *data)
+{
+	struct platform_device *pdev = s->private;
+	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	seq_printf(s, "max: %2d\nnum: %2d\n\n",
+		   priv->feat->max_sensors, priv->num_sensors);
+
+	seq_puts(s, "      id    slope   offset\n--------------------------\n");
+	for (i = 0;  i < priv->num_sensors; i++) {
+		seq_printf(s, "%8d %8d %8d\n", priv->sensor[i].hw_id,
+			   priv->sensor[i].slope, priv->sensor[i].offset);
+	}
+
+	return 0;
+}
+
+static int dbg_version_show(struct seq_file *s, void *data)
+{
+	struct platform_device *pdev = s->private;
+	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	u32 maj_ver, min_ver, step_ver;
+	int ret;
+
+	if (tsens_version(priv) > VER_0_1) {
+		ret = regmap_field_read(priv->rf[VER_MAJOR], &maj_ver);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[VER_MINOR], &min_ver);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[VER_STEP], &step_ver);
+		if (ret)
+			return ret;
+		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
+	} else {
+		seq_puts(s, "0.1.0\n");
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(dbg_version);
+DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
+
+static void tsens_debug_init(struct platform_device *pdev)
+{
+	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	struct dentry *root, *file;
+
+	root = debugfs_lookup("tsens", NULL);
+	if (!root)
+		priv->debug_root = debugfs_create_dir("tsens", NULL);
+	else
+		priv->debug_root = root;
+
+	file = debugfs_lookup("version", priv->debug_root);
+	if (!file)
+		debugfs_create_file("version", 0444, priv->debug_root,
+				    pdev, &dbg_version_fops);
+
+	/* A directory for each instance of the TSENS IP */
+	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
+	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
+}
+#else
+static inline void tsens_debug_init(struct platform_device *pdev) {}
+#endif
+
+static const struct regmap_config tsens_config = {
+	.name		= "tm",
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+static const struct regmap_config tsens_srot_config = {
+	.name		= "srot",
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+int __init init_common(struct tsens_priv *priv)
+{
+	void __iomem *tm_base, *srot_base;
+	struct device *dev = priv->dev;
+	u32 ver_minor;
+	struct resource *res;
+	u32 enabled;
+	int ret, i, j;
+	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
+
+	if (!op)
+		return -EINVAL;
+
+	if (op->num_resources > 1) {
+		/* DT with separate SROT and TM address space */
+		priv->tm_offset = 0;
+		res = platform_get_resource(op, IORESOURCE_MEM, 1);
+		srot_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(srot_base)) {
+			ret = PTR_ERR(srot_base);
+			goto err_put_device;
+		}
+
+		priv->srot_map = devm_regmap_init_mmio(dev, srot_base,
+						       &tsens_srot_config);
+		if (IS_ERR(priv->srot_map)) {
+			ret = PTR_ERR(priv->srot_map);
+			goto err_put_device;
+		}
+	} else {
+		/* old DTs where SROT and TM were in a contiguous 2K block */
+		priv->tm_offset = 0x1000;
+	}
+
+	res = platform_get_resource(op, IORESOURCE_MEM, 0);
+	tm_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(tm_base)) {
+		ret = PTR_ERR(tm_base);
+		goto err_put_device;
+	}
+
+	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
+	if (IS_ERR(priv->tm_map)) {
+		ret = PTR_ERR(priv->tm_map);
+		goto err_put_device;
+	}
+
+	if (tsens_version(priv) > VER_0_1) {
+		for (i = VER_MAJOR; i <= VER_STEP; i++) {
+			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
+							      priv->fields[i]);
+			if (IS_ERR(priv->rf[i]))
+				return PTR_ERR(priv->rf[i]);
+		}
+		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
+		if (ret)
+			goto err_put_device;
+	}
+
+	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
+						     priv->fields[TSENS_EN]);
+	if (IS_ERR(priv->rf[TSENS_EN])) {
+		ret = PTR_ERR(priv->rf[TSENS_EN]);
+		goto err_put_device;
+	}
+	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
+	if (ret)
+		goto err_put_device;
+	if (!enabled) {
+		dev_err(dev, "%s: device not enabled\n", __func__);
+		ret = -ENODEV;
+		goto err_put_device;
+	}
+
+	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
+						      priv->fields[SENSOR_EN]);
+	if (IS_ERR(priv->rf[SENSOR_EN])) {
+		ret = PTR_ERR(priv->rf[SENSOR_EN]);
+		goto err_put_device;
+	}
+	priv->rf[INT_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
+						   priv->fields[INT_EN]);
+	if (IS_ERR(priv->rf[INT_EN])) {
+		ret = PTR_ERR(priv->rf[INT_EN]);
+		goto err_put_device;
+	}
+
+	/* This loop might need changes if enum regfield_ids is reordered */
+	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
+		for (i = 0; i < priv->feat->max_sensors; i++) {
+			int idx = j + i;
+
+			priv->rf[idx] = devm_regmap_field_alloc(dev,
+								priv->tm_map,
+								priv->fields[idx]);
+			if (IS_ERR(priv->rf[idx])) {
+				ret = PTR_ERR(priv->rf[idx]);
+				goto err_put_device;
+			}
+		}
+	}
+
+	if (priv->feat->crit_int) {
+		/* Loop might need changes if enum regfield_ids is reordered */
+		for (j = CRITICAL_STATUS_0; j <= CRIT_THRESH_15; j += 16) {
+			for (i = 0; i < priv->feat->max_sensors; i++) {
+				int idx = j + i;
+
+				priv->rf[idx] =
+					devm_regmap_field_alloc(dev,
+								priv->tm_map,
+								priv->fields[idx]);
+				if (IS_ERR(priv->rf[idx])) {
+					ret = PTR_ERR(priv->rf[idx]);
+					goto err_put_device;
+				}
+			}
+		}
+	}
+
+	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
+		/* Watchdog is present only on v2.3+ */
+		priv->feat->has_watchdog = 1;
+		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
+			priv->rf[i] = devm_regmap_field_alloc(dev, priv->tm_map,
+							      priv->fields[i]);
+			if (IS_ERR(priv->rf[i])) {
+				ret = PTR_ERR(priv->rf[i]);
+				goto err_put_device;
+			}
+		}
+		/*
+		 * Watchdog is already enabled, unmask the bark.
+		 * Disable cycle completion monitoring
+		 */
+		regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
+		regmap_field_write(priv->rf[CC_MON_MASK], 1);
+	}
+
+	spin_lock_init(&priv->ul_lock);
+	tsens_enable_irq(priv);
+	tsens_debug_init(op);
+
+err_put_device:
+	put_device(&op->dev);
+	return ret;
+}
+
 static int tsens_get_temp(void *data, int *temp)
 {
 	struct tsens_sensor *s = data;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 502acf0e68285..59d01162c66af 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -580,11 +580,6 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
 int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
 int get_temp_common(const struct tsens_sensor *s, int *temp);
-int tsens_enable_irq(struct tsens_priv *priv);
-void tsens_disable_irq(struct tsens_priv *priv);
-int tsens_set_trips(void *_sensor, int low, int high);
-irqreturn_t tsens_irq_thread(int irq, void *data);
-irqreturn_t tsens_critical_irq_thread(int irq, void *data);
 
 /* TSENS target */
 extern struct tsens_plat_data data_8960;
-- 
2.20.1

