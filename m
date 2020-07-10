Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C2E21BE01
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgGJTqc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 15:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgGJTqP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 15:46:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A852CC08C5DC;
        Fri, 10 Jul 2020 12:46:14 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so7289259ejn.10;
        Fri, 10 Jul 2020 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rujU6IuUKyP/qpmu9fxGZQc5R/2dPvNSFc6+rG5kang=;
        b=qJDGtpsHkdF9sdjuRhmodvwWZCOnF/D1iW+KcIZ/G97kQcWxAUQQ6FbvdntbcDppxg
         QUKHOa76nVuncDuqQcgWKPTxbUlb7Bk3O3GhflzbvUwBV63zB/YTG9h1u8ytcU2BJ7Gv
         +i82XsE3idK3Pktog5jKIn5N5WshSqztxzNAiKsk0doleC2LQ0iy1yQw57NEIkkrmWVT
         6nNPTzBxNELQTiZFRWKgo6xpGrLSqeIJlGyN2ewsYGs0SodHmeTbT9pFR+0CxQJgAi2t
         y5OprsIyFf3nNHHOROXcykdQ+4z8OVtJv7QiQniDCINtTVHDJVIf1RYb+evkYtvKCNfw
         50sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rujU6IuUKyP/qpmu9fxGZQc5R/2dPvNSFc6+rG5kang=;
        b=pvtN+H7NrIUSyzH66/s8JxxA2vjC/Uq4SW8QUEHFjNMYHZz59owe1qUmGo+QZrdx7x
         79CObwlpw0+rik77+/XqeqcwGSbrCkbWENxIXrp0p3GTORJSTYnLin4/ObCdv02x2xNt
         qdeaXjqUf3ibkw5cpxswjQhkuAhwto74vLQ0I/zYGef8DWYEnMinZ9BZ+rx6A7BySfbB
         IMXlp3YAOhQjDsJFBduCLBNb6a8zaQIccxk6leziwcxZtf7tfBIFLOy5ZZ0tp1UCnNTp
         bLSIs1RJ8bpD4YCfNbgcDq3P7kdZ3CSQhjZY4nkYNq8aJLXKf8SIZY96BGA8DFdgfLzW
         puBw==
X-Gm-Message-State: AOAM530r57EbeM/a3OGXS3Xe1UhhddHz50Br1reGY/k1EmqoD0Gryq8t
        teIh0cr1v8My1Ip5GBndtaY=
X-Google-Smtp-Source: ABdhPJw5qRU7e8mITfuQa57XmZonNT5IJKsE4n9E5ekJ0sXeJmzLfE0zkbCSHn8UIocnjMHE08uXuw==
X-Received: by 2002:a17:906:f20d:: with SMTP id gt13mr38231087ejb.117.1594410373307;
        Fri, 10 Jul 2020 12:46:13 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id kt4sm4155768ejb.48.2020.07.10.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:46:12 -0700 (PDT)
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
Subject: [PATCH v2 4/6] drivers: thermal: tsens: add interrupt support for 9860 driver
Date:   Fri, 10 Jul 2020 21:45:55 +0200
Message-Id: <20200710194558.26487-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710194558.26487-1-ansuelsmth@gmail.com>
References: <20200710194558.26487-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interrupt support for 9860 tsens driver used to set thermal trip
point for the system.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 196 +++++++++++++++++++++++++++---
 drivers/thermal/qcom/tsens.h      |   1 +
 2 files changed, 183 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 890baf1b5542..2dc670206896 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -8,6 +8,7 @@
 #include <linux/bitops.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <linux/interrupt.h>
 #include <linux/thermal.h>
 #include "tsens.h"
 
@@ -27,7 +28,6 @@
 /* CNTL_ADDR bitmasks */
 #define EN			BIT(0)
 #define SW_RST			BIT(1)
-#define SENSOR0_EN		BIT(3)
 #define SLP_CLK_ENA		BIT(26)
 #define SLP_CLK_ENA_8660	BIT(24)
 #define MEASURE_PERIOD		1
@@ -41,14 +41,26 @@
 
 #define THRESHOLD_ADDR		0x3624
 /* THRESHOLD_ADDR bitmasks */
+#define THRESHOLD_MAX_CODE		0x20000
+#define THRESHOLD_MIN_CODE		0
 #define THRESHOLD_MAX_LIMIT_SHIFT	24
 #define THRESHOLD_MIN_LIMIT_SHIFT	16
 #define THRESHOLD_UPPER_LIMIT_SHIFT	8
 #define THRESHOLD_LOWER_LIMIT_SHIFT	0
+#define THRESHOLD_MAX_LIMIT_MASK	(THRESHOLD_MAX_CODE << \
+						THRESHOLD_MAX_LIMIT_SHIFT)
+#define THRESHOLD_MIN_LIMIT_MASK	(THRESHOLD_MAX_CODE << \
+						THRESHOLD_MIN_LIMIT_SHIFT)
+#define THRESHOLD_UPPER_LIMIT_MASK	(THRESHOLD_MAX_CODE << \
+						THRESHOLD_UPPER_LIMIT_SHIFT)
+#define THRESHOLD_LOWER_LIMIT_MASK	(THRESHOLD_MAX_CODE << \
+						THRESHOLD_LOWER_LIMIT_SHIFT)
 
 /* Initial temperature threshold values */
-#define LOWER_LIMIT_TH		0x50
-#define UPPER_LIMIT_TH		0xdf
+#define LOWER_LIMIT_TH_8960	0x50
+#define UPPER_LIMIT_TH_8960	0xdf
+#define LOWER_LIMIT_TH_8064	0x9d /* 95C */
+#define UPPER_LIMIT_TH_8064	0xa6 /* 105C */
 #define MIN_LIMIT_TH		0x0
 #define MAX_LIMIT_TH		0xff
 
@@ -57,6 +69,169 @@
 #define TRDY_MASK		BIT(7)
 #define TIMEOUT_US		100
 
+#define TSENS_EN		BIT(0)
+#define TSENS_SW_RST		BIT(1)
+#define TSENS_ADC_CLK_SEL	BIT(2)
+#define SENSOR0_EN		BIT(3)
+#define SENSOR1_EN		BIT(4)
+#define SENSOR2_EN		BIT(5)
+#define SENSOR3_EN		BIT(6)
+#define SENSOR4_EN		BIT(7)
+#define SENSORS_EN		(SENSOR0_EN | SENSOR1_EN | \
+				SENSOR2_EN | SENSOR3_EN | SENSOR4_EN)
+#define TSENS_8064_SENSOR5_EN				BIT(8)
+#define TSENS_8064_SENSOR6_EN				BIT(9)
+#define TSENS_8064_SENSOR7_EN				BIT(10)
+#define TSENS_8064_SENSOR8_EN				BIT(11)
+#define TSENS_8064_SENSOR9_EN				BIT(12)
+#define TSENS_8064_SENSOR10_EN				BIT(13)
+#define TSENS_8064_SENSORS_EN				(SENSORS_EN | \
+						TSENS_8064_SENSOR5_EN | \
+						TSENS_8064_SENSOR6_EN | \
+						TSENS_8064_SENSOR7_EN | \
+						TSENS_8064_SENSOR8_EN | \
+						TSENS_8064_SENSOR9_EN | \
+						TSENS_8064_SENSOR10_EN)
+
+u32 tsens_8960_slope[] = {
+			1176, 1176, 1154, 1176,
+			1111, 1132, 1132, 1199,
+			1132, 1199, 1132
+			};
+
+/* Temperature on y axis and ADC-code on x-axis */
+static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
+{
+	int slope, offset;
+
+	slope = thermal_zone_get_slope(s->tzd);
+	offset = CAL_MDEGC - slope * s->offset;
+
+	return adc_code * slope + offset;
+}
+
+static void notify_uspace_tsens_fn(struct work_struct *work)
+{
+	struct tsens_sensor *s = container_of(work, struct tsens_sensor,
+								notify_work);
+
+	sysfs_notify(&s->tzd->device.kobj, NULL, "type");
+}
+
+static void tsens_scheduler_fn(struct work_struct *work)
+{
+	struct tsens_priv *priv =
+		container_of(work, struct tsens_priv, tsens_work);
+	unsigned int threshold, threshold_low, code, reg, sensor, mask;
+	bool upper_th_x, lower_th_x;
+	int ret;
+
+	ret = regmap_read(priv->tm_map, STATUS_CNTL_ADDR_8064, &reg);
+	if (ret)
+		return;
+	reg = reg | LOWER_STATUS_CLR | UPPER_STATUS_CLR;
+	ret = regmap_write(priv->tm_map, STATUS_CNTL_ADDR_8064, reg);
+	if (ret)
+		return;
+
+	mask = ~(LOWER_STATUS_CLR | UPPER_STATUS_CLR);
+	ret = regmap_read(priv->tm_map, THRESHOLD_ADDR, &threshold);
+	if (ret)
+		return;
+	threshold_low = (threshold & THRESHOLD_LOWER_LIMIT_MASK) >>
+			THRESHOLD_LOWER_LIMIT_SHIFT;
+	threshold = (threshold & THRESHOLD_UPPER_LIMIT_MASK) >>
+		    THRESHOLD_UPPER_LIMIT_SHIFT;
+
+	ret = regmap_read(priv->tm_map, STATUS_CNTL_ADDR_8064, &reg);
+	if (ret)
+		return;
+
+	ret = regmap_read(priv->tm_map, CNTL_ADDR, &sensor);
+	if (ret)
+		return;
+	sensor &= (uint32_t)TSENS_8064_SENSORS_EN;
+	sensor >>= SENSOR0_SHIFT;
+
+	/* Constraint: There is only 1 interrupt control register for all
+	 * 11 temperature sensor. So monitoring more than 1 sensor based
+	 * on interrupts will yield inconsistent result. To overcome this
+	 * issue we will monitor only sensor 0 which is the master sensor.
+	 */
+
+	/* Skip if the sensor is disabled */
+	if (sensor & 1) {
+		ret = regmap_read(priv->tm_map, priv->sensor[0].status, &code);
+		if (ret)
+			return;
+		upper_th_x = code >= threshold;
+		lower_th_x = code <= threshold_low;
+		if (upper_th_x)
+			mask |= UPPER_STATUS_CLR;
+		if (lower_th_x)
+			mask |= LOWER_STATUS_CLR;
+		if (upper_th_x || lower_th_x) {
+			/* Notify user space */
+			schedule_work(&priv->sensor[0].notify_work);
+			pr_debug("Trigger (%d degrees) for sensor %d\n",
+				 code_to_mdegC(code, &priv->sensor[0]), 0);
+		}
+	}
+	regmap_write(priv->tm_map, STATUS_CNTL_ADDR_8064, reg & mask);
+}
+
+static irqreturn_t tsens_isr(int irq, void *data)
+{
+	struct tsens_priv *priv = data;
+
+	schedule_work(&priv->tsens_work);
+	return IRQ_HANDLED;
+}
+
+static void hw_init(struct tsens_priv *priv)
+{
+	int ret;
+	unsigned int reg_cntl = 0, reg_cfg = 0, reg_thr = 0;
+	unsigned int reg_status_cntl = 0;
+
+	regmap_read(priv->tm_map, CNTL_ADDR, &reg_cntl);
+	regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl | TSENS_SW_RST);
+
+	reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18) |
+		    (((1 << priv->num_sensors) - 1) << SENSOR0_SHIFT);
+	regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
+	regmap_read(priv->tm_map, STATUS_CNTL_ADDR_8064, &reg_status_cntl);
+	reg_status_cntl |= LOWER_STATUS_CLR | UPPER_STATUS_CLR |
+			   MIN_STATUS_MASK | MAX_STATUS_MASK;
+	regmap_write(priv->tm_map, STATUS_CNTL_ADDR_8064, reg_status_cntl);
+	reg_cntl |= TSENS_EN;
+	regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
+
+	regmap_read(priv->tm_map, CONFIG_ADDR, &reg_cfg);
+	if (priv->num_sensors > 1)
+		reg_cfg = (reg_cfg & ~CONFIG_MASK) | CONFIG;
+	else
+		reg_cfg = (reg_cfg & ~CONFIG_MASK) |
+			  (CONFIG << CONFIG_SHIFT_8660);
+	regmap_write(priv->tm_map, CONFIG_ADDR, reg_cfg);
+
+	reg_thr |= (LOWER_LIMIT_TH_8064 << THRESHOLD_LOWER_LIMIT_SHIFT) |
+		   (UPPER_LIMIT_TH_8064 << THRESHOLD_UPPER_LIMIT_SHIFT) |
+		   (MIN_LIMIT_TH << THRESHOLD_MIN_LIMIT_SHIFT) |
+		   (MAX_LIMIT_TH << THRESHOLD_MAX_LIMIT_SHIFT);
+
+	regmap_write(priv->tm_map, THRESHOLD_ADDR, reg_thr);
+
+	ret = devm_request_irq(priv->dev, priv->tsens_irq, tsens_isr,
+			       IRQF_TRIGGER_RISING, "tsens_interrupt", priv);
+	if (ret < 0) {
+		dev_err(priv->dev, "request_irq FAIL: %d", ret);
+		return;
+	}
+
+	INIT_WORK(&priv->tsens_work, tsens_scheduler_fn);
+}
+
 static int suspend_8960(struct tsens_priv *priv)
 {
 	int ret;
@@ -186,6 +361,8 @@ static int init_8960(struct tsens_priv *priv)
 		if (i >= 5)
 			priv->sensor[i].status = S0_STATUS_ADDR + 40;
 		priv->sensor[i].status += i * 4;
+		priv->sensor[i].slope = tsens_8960_slope[i];
+		INIT_WORK(&priv->sensor[i].notify_work, notify_uspace_tsens_fn);
 	}
 
 	reg_cntl = SW_RST;
@@ -236,18 +413,9 @@ static int calibrate_8960(struct tsens_priv *priv)
 
 	kfree(data);
 
-	return 0;
-}
-
-/* Temperature on y axis and ADC-code on x-axis */
-static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
-{
-	int slope, offset;
+	hw_init(priv);
 
-	slope = thermal_zone_get_slope(s->tzd);
-	offset = CAL_MDEGC - slope * s->offset;
-
-	return adc_code * slope + offset;
+	return 0;
 }
 
 static int get_temp_8960(const struct tsens_sensor *s, int *temp)
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 59d01162c66a..2f145001e4d5 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -48,6 +48,7 @@ enum tsens_irq_type {
 struct tsens_sensor {
 	struct tsens_priv		*priv;
 	struct thermal_zone_device	*tzd;
+	struct work_struct		notify_work;
 	int				offset;
 	unsigned int			hw_id;
 	int				slope;
-- 
2.27.0

