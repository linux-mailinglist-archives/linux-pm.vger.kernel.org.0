Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABDF183065
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 13:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgCLMhg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 08:37:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36397 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgCLMhf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 08:37:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id c7so3034864pgw.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqsDeGlq+mIkRmw3Uh5Hi9vvU4fW1F4x7HQUjZP4IUs=;
        b=tF5vH/fgNGafAjF5A76x6qgeLa11TZIJiFVjse07yi+svpYEicfieQnJrsiE0pUJNj
         pgcqAg5GrYpRdfxb46AHtQZDomKPXPLYaZOf/wqxViiVoSNyUc8ThMcdxcaMf6rDIUHA
         dqaBIm2XiAfoRP3soRWKA7l1pbp5MpCLjJAhRXiGcDXZpTzEcBrSm10gPoJQ2O5W9G7M
         zOcFux++Pu3aWNRqSR+1GyxXqkI9cRfL9exd8ieL1xmR8Ru18zkSOPIYukWxfke4fJiZ
         q0XQUdPNAVEcPWidURs8lhUHqKP4kbx+y93dLLBQ71xq2h8kvKXjRsN0qlEg/iILejz3
         W0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqsDeGlq+mIkRmw3Uh5Hi9vvU4fW1F4x7HQUjZP4IUs=;
        b=VeGC+aCiso+avQXMB4nyRjQAYgh73TYXx8JpRrpVus3KuQJIOW5S/Bptz/5jLCBo7Y
         qdRiYOomTxz1l0d09wCoAOgF46+g9wLxL0UkdbKEbdWZDUDdBm5Q/2gqQEqzr0rZwIMD
         QmOqP647DqFEuko3akrTzfUSeqe8VUQnR5GYR8Ssws2Nl17d4JLvKEM8q+l9TmJyCM7Y
         /yrYGPuZzLWqqM7nZv+keb/+cdqtSHpsxVcec6bcrXmrKH4Jr4bFhhHmdOczHk5DTSSq
         ZgwdZAIidggVMwkRMQv0TOKqLu5Hi/hntI++Iu8RRdHnCM4arJw5G/fH6dMkUkTnfsGZ
         bhiA==
X-Gm-Message-State: ANhLgQ2xDtsxnU9EFbC9iuRX3TgAN1F+4aWRC54wkOG25eNwZIKVh/zv
        QeqaAeCdsvKX8mSeFKWc/MatZA==
X-Google-Smtp-Source: ADFU+vs2FHrsyZCQf/bFkjU30WGV38JBz9EUV5BLFgoXrD9dQSGgzwA1NoNlFfhtjYs214jmcn59/g==
X-Received: by 2002:a63:f50e:: with SMTP id w14mr7576741pgh.363.1584016653906;
        Thu, 12 Mar 2020 05:37:33 -0700 (PDT)
Received: from localhost ([45.127.45.7])
        by smtp.gmail.com with ESMTPSA id a18sm2061887pfr.109.2020.03.12.05.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 05:37:32 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 5/8] drivers: thermal: tsens: Add critical interrupt support
Date:   Thu, 12 Mar 2020 18:07:02 +0530
Message-Id: <51b22461d4b5f85a817274568459db4579fd4298.1584015867.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584015867.git.amit.kucheria@linaro.org>
References: <cover.1584015867.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TSENS IP v2.x adds critical threshold interrupt support for each sensor
in addition to the upper/lower threshold interrupt. Add support in the
driver.

While the critical interrupts themselves aren't currently used by Linux,
the HW line is also used by the TSENS watchdog. So this patch acts as
infrastructure to enable watchdog functionality for the TSENS IP.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 118 ++++++++++++++++++++++++++--
 drivers/thermal/qcom/tsens-v2.c     |   8 +-
 drivers/thermal/qcom/tsens.c        |  65 +++++++++------
 drivers/thermal/qcom/tsens.h        |  68 ++++++++++++++++
 4 files changed, 223 insertions(+), 36 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index fd3b56d523411..b7d599425605f 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -23,6 +23,10 @@
  * @low_thresh:     lower threshold temperature value
  * @low_irq_mask:   mask register for lower threshold irqs
  * @low_irq_clear:  clear register for lower threshold irqs
+ * @crit_viol:      critical threshold violated
+ * @crit_thresh:    critical threshold temperature value
+ * @crit_irq_mask:  mask register for critical threshold irqs
+ * @crit_irq_clear: clear register for critical threshold irqs
  *
  * Structure containing data about temperature threshold settings and
  * irq status if they were violated.
@@ -36,6 +40,10 @@ struct tsens_irq_data {
 	int low_thresh;
 	u32 low_irq_mask;
 	u32 low_irq_clear;
+	u32 crit_viol;
+	u32 crit_thresh;
+	u32 crit_irq_mask;
+	u32 crit_irq_clear;
 };
 
 char *qfprom_read(struct device *dev, const char *cname)
@@ -189,6 +197,9 @@ static void tsens_set_interrupt_v1(struct tsens_priv *priv, u32 hw_id,
 	case LOWER:
 		index = LOW_INT_CLEAR_0 + hw_id;
 		break;
+	case CRITICAL:
+		/* No critical interrupts before v2 */
+		return;
 	}
 	regmap_field_write(priv->rf[index], enable ? 0 : 1);
 }
@@ -214,6 +225,10 @@ static void tsens_set_interrupt_v2(struct tsens_priv *priv, u32 hw_id,
 		index_mask  = LOW_INT_MASK_0 + hw_id;
 		index_clear = LOW_INT_CLEAR_0 + hw_id;
 		break;
+	case CRITICAL:
+		index_mask  = CRIT_INT_MASK_0 + hw_id;
+		index_clear = CRIT_INT_CLEAR_0 + hw_id;
+		break;
 	}
 
 	if (enable) {
@@ -268,7 +283,15 @@ static int tsens_threshold_violated(struct tsens_priv *priv, u32 hw_id,
 	ret = regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &d->low_viol);
 	if (ret)
 		return ret;
-	if (d->up_viol || d->low_viol)
+
+	if (priv->feat->crit_int) {
+		ret = regmap_field_read(priv->rf[CRITICAL_STATUS_0 + hw_id],
+					&d->crit_viol);
+		if (ret)
+			return ret;
+	}
+
+	if (d->up_viol || d->low_viol || d->crit_viol)
 		return 1;
 
 	return 0;
@@ -293,22 +316,37 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 		ret = regmap_field_read(priv->rf[LOW_INT_MASK_0 + hw_id], &d->low_irq_mask);
 		if (ret)
 			return ret;
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
 	} else {
 		/* No mask register on older TSENS */
 		d->up_irq_mask = 0;
 		d->low_irq_mask = 0;
+		d->crit_irq_clear = 0;
+		d->crit_irq_mask = 0;
+		d->crit_thresh = 0;
 	}
 
 	d->up_thresh  = tsens_hw_to_mC(s, UP_THRESH_0 + hw_id);
 	d->low_thresh = tsens_hw_to_mC(s, LOW_THRESH_0 + hw_id);
 
-	dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u) | clr(%u|%u) | mask(%u|%u)\n",
-		hw_id, __func__, (d->up_viol || d->low_viol) ? "(V)" : "",
-		d->low_viol, d->up_viol, d->low_irq_clear, d->up_irq_clear,
-		d->low_irq_mask, d->up_irq_mask);
-	dev_dbg(priv->dev, "[%u] %s%s: thresh: (%d:%d)\n", hw_id, __func__,
-		(d->up_viol || d->low_viol) ? "(violation)" : "",
-		d->low_thresh, d->up_thresh);
+	dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u|%u) | clr(%u|%u|%u) | mask(%u|%u|%u)\n",
+		hw_id, __func__,
+		(d->up_viol || d->low_viol || d->crit_viol) ? "(V)" : "",
+		d->low_viol, d->up_viol, d->crit_viol,
+		d->low_irq_clear, d->up_irq_clear, d->crit_irq_clear,
+		d->low_irq_mask, d->up_irq_mask, d->crit_irq_mask);
+	dev_dbg(priv->dev, "[%u] %s%s: thresh: (%d:%d:%d)\n", hw_id, __func__,
+		(d->up_viol || d->low_viol || d->crit_viol) ? "(V)" : "",
+		d->low_thresh, d->up_thresh, d->crit_thresh);
 
 	return 0;
 }
@@ -322,6 +360,52 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
 	return 0;
 }
 
+/**
+ * tsens_critical_irq_thread() - Threaded handler for critical interrupts
+ * @irq: irq number
+ * @data: tsens controller private data
+ *
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
 /**
  * tsens_irq_thread - Threaded interrupt handler for uplow interrupts
  * @irq: irq number
@@ -684,6 +768,24 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
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
 	spin_lock_init(&priv->ul_lock);
 	tsens_enable_irq(priv);
 	tsens_debug_init(op);
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index f1c8ec62e69f9..ce5ef0055d136 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -51,8 +51,9 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	[INT_EN]  = REG_FIELD(TM_INT_EN_OFF, 0, 2),
 
 	/* TEMPERATURE THRESHOLDS */
-	REG_FIELD_FOR_EACH_SENSOR16(LOW_THRESH, TM_Sn_UPPER_LOWER_THRESHOLD_OFF,  0,  11),
-	REG_FIELD_FOR_EACH_SENSOR16(UP_THRESH,  TM_Sn_UPPER_LOWER_THRESHOLD_OFF, 12,  23),
+	REG_FIELD_FOR_EACH_SENSOR16(LOW_THRESH,  TM_Sn_UPPER_LOWER_THRESHOLD_OFF,  0,  11),
+	REG_FIELD_FOR_EACH_SENSOR16(UP_THRESH,   TM_Sn_UPPER_LOWER_THRESHOLD_OFF, 12,  23),
+	REG_FIELD_FOR_EACH_SENSOR16(CRIT_THRESH, TM_Sn_CRITICAL_THRESHOLD_OFF,     0,  11),
 
 	/* INTERRUPTS [CLEAR/STATUS/MASK] */
 	REG_FIELD_SPLIT_BITS_0_15(LOW_INT_STATUS,  TM_UPPER_LOWER_INT_STATUS_OFF),
@@ -61,6 +62,9 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	REG_FIELD_SPLIT_BITS_16_31(UP_INT_STATUS,  TM_UPPER_LOWER_INT_STATUS_OFF),
 	REG_FIELD_SPLIT_BITS_16_31(UP_INT_CLEAR,   TM_UPPER_LOWER_INT_CLEAR_OFF),
 	REG_FIELD_SPLIT_BITS_16_31(UP_INT_MASK,    TM_UPPER_LOWER_INT_MASK_OFF),
+	REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_STATUS, TM_CRITICAL_INT_STATUS_OFF),
+	REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_CLEAR,  TM_CRITICAL_INT_CLEAR_OFF),
+	REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_MASK,   TM_CRITICAL_INT_MASK_OFF),
 
 	/* Sn_STATUS */
 	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  11),
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 0e7cf52369326..05d2721320471 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -85,11 +85,42 @@ static const struct thermal_zone_of_device_ops tsens_of_ops = {
 	.set_trips = tsens_set_trips,
 };
 
+static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
+			      irq_handler_t thread_fn)
+{
+	struct platform_device *pdev;
+	int ret, irq;
+
+	pdev = of_find_device_by_node(priv->dev->of_node);
+	if (!pdev)
+		return -ENODEV;
+
+	irq = platform_get_irq_byname(pdev, irqname);
+	if (irq < 0) {
+		ret = irq;
+		/* For old DTs with no IRQ defined */
+		if (irq == -ENXIO)
+			ret = 0;
+	} else {
+		ret = devm_request_threaded_irq(&pdev->dev, irq,
+						NULL, thread_fn,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+						dev_name(&pdev->dev), priv);
+		if (ret)
+			dev_err(&pdev->dev, "%s: failed to get irq\n",
+				__func__);
+		else
+			enable_irq_wake(irq);
+	}
+
+	put_device(&pdev->dev);
+	return ret;
+}
+
 static int tsens_register(struct tsens_priv *priv)
 {
-	int i, ret, irq;
+	int i, ret;
 	struct thermal_zone_device *tzd;
-	struct platform_device *pdev;
 
 	for (i = 0;  i < priv->num_sensors; i++) {
 		priv->sensor[i].priv = priv;
@@ -103,32 +134,14 @@ static int tsens_register(struct tsens_priv *priv)
 			priv->ops->enable(priv, i);
 	}
 
-	pdev = of_find_device_by_node(priv->dev->of_node);
-	if (!pdev)
-		return -ENODEV;
-
-	irq = platform_get_irq_byname(pdev, "uplow");
-	if (irq < 0) {
-		ret = irq;
-		/* For old DTs with no IRQ defined */
-		if (irq == -ENXIO)
-			ret = 0;
-		goto err_put_device;
-	}
-
-	ret = devm_request_threaded_irq(&pdev->dev, irq,
-					NULL, tsens_irq_thread,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					dev_name(&pdev->dev), priv);
-	if (ret) {
-		dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
-		goto err_put_device;
-	}
+	ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
+	if (ret < 0)
+		return ret;
 
-	enable_irq_wake(irq);
+	if (priv->feat->crit_int)
+		ret = tsens_register_irq(priv, "critical",
+					 tsens_critical_irq_thread);
 
-err_put_device:
-	put_device(&pdev->dev);
 	return ret;
 }
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 70dc34c805377..2466115a9881d 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -23,6 +23,7 @@
 
 struct tsens_priv;
 
+/* IP version numbers in ascending order */
 enum tsens_ver {
 	VER_0_1 = 0,
 	VER_1_X,
@@ -32,6 +33,7 @@ enum tsens_ver {
 enum tsens_irq_type {
 	LOWER,
 	UPPER,
+	CRITICAL,
 };
 
 /**
@@ -374,6 +376,70 @@ enum regfield_ids {
 	CRITICAL_STATUS_13,
 	CRITICAL_STATUS_14,
 	CRITICAL_STATUS_15,
+	CRIT_INT_STATUS_0,	/* CRITICAL interrupt status */
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
+	CRIT_INT_CLEAR_0,	/* CRITICAL interrupt clear */
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
+	CRIT_INT_MASK_0,	/* CRITICAL interrupt mask */
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
+	CRIT_THRESH_0,		/* CRITICAL threshold values */
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
 	MIN_STATUS_0,		/* MIN threshold violated */
 	MIN_STATUS_1,
 	MIN_STATUS_2,
@@ -460,6 +526,7 @@ struct tsens_context {
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
  *             address space separately
+ * @crit_lock: lock while processing critical threshold interrupts
  * @rf: array of regmap_fields used to store value of the field
  * @ctx: registers to be saved and restored during suspend/resume
  * @feat: features of the IP
@@ -500,6 +567,7 @@ int tsens_enable_irq(struct tsens_priv *priv);
 void tsens_disable_irq(struct tsens_priv *priv);
 int tsens_set_trips(void *_sensor, int low, int high);
 irqreturn_t tsens_irq_thread(int irq, void *data);
+irqreturn_t tsens_critical_irq_thread(int irq, void *data);
 
 /* TSENS target */
 extern struct tsens_plat_data data_8960;
-- 
2.20.1

