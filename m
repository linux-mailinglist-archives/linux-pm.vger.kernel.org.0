Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C5410F706
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 06:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLCFX5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 00:23:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40106 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfLCFX4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 00:23:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so1241163pfh.7
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 21:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8w3O8kJK6JTKWYTOLIspbo7nR07jsNBKlB261OZVEtM=;
        b=uZAxKqWEcy29faTTXe2jVdbbU5Ut17g1yPUntWjg2iFjIVevIyE6fSSrrXuZV/cOwm
         jjDR0dZf3ysYheXyeY0qdEmfCFZLjxqIMz5IarYDA2syYb91NKkiwKU9Rtptg3SduyBB
         cJ8CavFk9djEqXOQRDMJDEZFxxpKea51/to8/5gijI/xgHx0PGLlYT+1knMm/7ccRht8
         lDHhUfp11oPrbPrySmHowxnNhsg2BUAjqbbJ0zOgkxM+qsx8bI8n0nhPW8cT/wtHY9Bq
         pl7em8fHh+moux7E+yKj9OPBTps7StVesl98lVlv02KTDEPMcoQ6nX787o2QpaPit2Re
         GSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8w3O8kJK6JTKWYTOLIspbo7nR07jsNBKlB261OZVEtM=;
        b=S0Q/l+0Z3NW7U1CpPBCUvZWjTbiMgTjXuH6nPLWUbYuqt6wmps7nKJp4mU0C1u9iBT
         tv3FNsqMyfdTvvof/4d5csFzVhHdP4uZuFPRNATv4lqB3XUTi7dTXhOQNu9G9XWtvMnw
         elaWEsXX++ktxshMhjdmno2flCkA/cnqBJ/gHaiFt4FbXDK7RjmRRaxQtWvCq/FhczGu
         3xdQHSwqgWGKDsXJslvIKxIsQyEGYkrxhPPwGvGdRM2Mr5S5ixlzDBNGVD3FAGPS401h
         TsPEKTtELiEmxvb3LxUAS1Lz+v6hLnDPCPty+2F9mZuqg8VEQW+Hj9VV9qfBJqIc/0CT
         PIhw==
X-Gm-Message-State: APjAAAUoUQam9pzVJYZDhah3xyDUoA3/CpksmEz8XRB2bRPwJ6p5fqqb
        +T++85cZZK6kVS04vpswS0UN8g==
X-Google-Smtp-Source: APXvYqyEzUgxiA1qaPTGx9QEj9sSNAyiQt7FLWNyshKWzynEKcLEukf71AzN8u3Jp8GG5zVeooI4Nw==
X-Received: by 2002:a65:66da:: with SMTP id c26mr3470228pgw.354.1575350635780;
        Mon, 02 Dec 2019 21:23:55 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id l2sm1112425pjf.4.2019.12.02.21.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:23:55 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 5/9] drivers: thermal: tsens: Add critical interrupt support
Date:   Tue,  3 Dec 2019 10:53:26 +0530
Message-Id: <f957e353b0bdb7b3cf8769eec3de44d791729cbf.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TSENS IP v2.x adds critical threshold interrupt support for each sensor
in addition to the upper/lower threshold interrupt. Add support in the
driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 126 ++++++++++++++++++++++++++--
 drivers/thermal/qcom/tsens-v2.c     |   8 +-
 drivers/thermal/qcom/tsens.c        |  26 +++++-
 drivers/thermal/qcom/tsens.h        |  72 ++++++++++++++++
 4 files changed, 221 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index e84e94a6f1a73..4cf550766cf66 100644
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
+		break;
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
@@ -268,7 +283,14 @@ static int tsens_threshold_violated(struct tsens_priv *priv, u32 hw_id,
 	ret = regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &d->low_viol);
 	if (ret)
 		return ret;
-	if (d->up_viol || d->low_viol)
+
+	if (priv->feat->crit_int) {
+		ret = regmap_field_read(priv->rf[CRITICAL_STATUS_0 + hw_id], &d->crit_viol);
+		if (ret)
+			return ret;
+	}
+
+	if (d->up_viol || d->low_viol || d->crit_viol)
 		return 1;
 
 	return 0;
@@ -292,22 +314,36 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 		ret = regmap_field_read(priv->rf[LOW_INT_MASK_0 + hw_id], &d->low_irq_mask);
 		if (ret)
 			return ret;
+		ret = regmap_field_read(priv->rf[CRIT_INT_CLEAR_0 + hw_id], &d->crit_irq_clear);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[CRIT_INT_MASK_0 + hw_id], &d->crit_irq_mask);
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
+	dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u|%u) |"
+		" clr(%u|%u|%u) | mask(%u|%u|%u)\n",
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
@@ -321,6 +357,64 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
 	return 0;
 }
 
+/**
+ * tsens_critical_irq_thread - Threaded interrupt handler for critical interrupts
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
+	unsigned long flags;
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
+			dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
+			continue;
+		}
+
+		spin_lock_irqsave(&priv->ul_lock, flags);
+
+		tsens_read_irq_state(priv, hw_id, s, &d);
+
+		if (d.crit_viol &&
+		    !masked_irq(hw_id, d.crit_irq_mask, tsens_version(priv))) {
+			tsens_set_interrupt(priv, hw_id, CRITICAL, false);
+			if (d.crit_thresh > temp) {
+				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
+					hw_id, __func__);
+			} else {
+				dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
+					hw_id, __func__, temp);
+			}
+			tsens_set_interrupt(priv, hw_id, CRITICAL, true);
+		}
+
+		spin_unlock_irqrestore(&priv->crit_lock, flags);
+	}
+
+	return IRQ_HANDLED;
+}
+
 /**
  * tsens_irq_thread - Threaded interrupt handler for uplow interrupts
  * @irq: irq number
@@ -683,6 +777,22 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
+	if (priv->feat->crit_int) {
+		/* This loop might need changes if enum regfield_ids is reordered */
+		for (j = CRITICAL_STATUS_0; j <= CRIT_THRESH_15; j += 16) {
+			for (i = 0; i < priv->feat->max_sensors; i++) {
+				int idx = j + i;
+
+				priv->rf[idx] = devm_regmap_field_alloc(dev, priv->tm_map,
+									priv->fields[idx]);
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
index 015e7d2015985..70eae517d31b4 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -87,7 +87,7 @@ static const struct thermal_zone_of_device_ops tsens_of_ops = {
 
 static int tsens_register(struct tsens_priv *priv)
 {
-	int i, ret, irq;
+	int i, ret, irq, irq_crit;
 	struct thermal_zone_device *tzd;
 	struct platform_device *pdev;
 
@@ -122,6 +122,30 @@ static int tsens_register(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
+	if (priv->feat->crit_int) {
+		/* We override ret to 0 i.e. don't return errors
+		 * in this block to allow older DTs to continue working.
+		 */
+
+		irq_crit = platform_get_irq_byname(pdev, "critical");
+		if (irq_crit < 0) {
+			dev_warn(&pdev->dev, "Missing critical irq in DT\n");
+			goto err_crit_int;
+		}
+		ret = devm_request_threaded_irq(&pdev->dev, irq_crit,
+						NULL, tsens_critical_irq_thread,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+						dev_name(&pdev->dev), priv);
+		if (ret) {
+			dev_warn(&pdev->dev, "Failed to request critical irq\n");
+			ret = 0;
+			goto err_crit_int;
+		}
+
+		enable_irq_wake(irq_crit);
+	}
+
+err_crit_int:
 	enable_irq_wake(irq);
 
 err_put_device:
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 70dc34c805377..05d5f73178683 100644
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
@@ -460,6 +526,8 @@ struct tsens_context {
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
  *             address space separately
+ * @ul_lock: lock while processing upper/lower threshold interrupts
+ * @crit_lock: lock while processing critical threshold interrupts
  * @rf: array of regmap_fields used to store value of the field
  * @ctx: registers to be saved and restored during suspend/resume
  * @feat: features of the IP
@@ -479,6 +547,9 @@ struct tsens_priv {
 	/* lock for upper/lower threshold interrupts */
 	spinlock_t			ul_lock;
 
+	/* lock for critical threshold interrupts */
+	spinlock_t			crit_lock;
+
 	struct regmap_field		*rf[MAX_REGFIELDS];
 	struct tsens_context		ctx;
 	struct tsens_features		*feat;
@@ -500,6 +571,7 @@ int tsens_enable_irq(struct tsens_priv *priv);
 void tsens_disable_irq(struct tsens_priv *priv);
 int tsens_set_trips(void *_sensor, int low, int high);
 irqreturn_t tsens_irq_thread(int irq, void *data);
+irqreturn_t tsens_critical_irq_thread(int irq, void *data);
 
 /* TSENS target */
 extern struct tsens_plat_data data_8960;
-- 
2.17.1

