Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF0EB727
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfJaSh4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:37:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33764 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbfJaSh4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:37:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so3087739plk.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rO1z1JlGDHGdy6zVD5fls33iWqIXWjt9KmTfIa3Qj2w=;
        b=ORqnI9IlV/hEKajizXIQ38aByJEbH16XAIJ47m762ndSW+Cg7/flRjMn9Dex39IfBV
         fk/l/3LRz+65JvRSp7HpTojtAeLqCwLiCM/le6ZAdo+dg851R3QBk+A7Kdka/V0n/oad
         qQqdKuN/+MUc0OmepCu+YWZ3aEZsjh4F55BsTSnZk0pa9wsS+T9Ppjk9FZX65Agq1ZCR
         0y5H4PCwSOodflkhRWihZLipb1RQMKN6J5jvZ7qelvK0F7iZnQAtqFGY8vuG+KwocAdI
         e3wbKqm4FhdhZskFhhNIQRdkmeFtiJcVU/VCoXt7oHb4wjZQbxbvu1x4USkKFXXr9X1Z
         vfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rO1z1JlGDHGdy6zVD5fls33iWqIXWjt9KmTfIa3Qj2w=;
        b=KBB03Zx9RR47RJy+D9FMPTvoYwGlA1KU5oJfe58xq3RYoSVBIX0OnlAYbA0x/hlPNY
         JleJVphkheJBSqiSKmFvPR2Om0OuDDLR8yWcTMit7kixqjlFcZ8Qn5hdk+tHIRbgOARG
         VhTX0gSXVWj0mtBpMr83KLNl/CJEuPNI5AG6l37GxJmFurdGBsGRlYUksKwPE7LVWVC7
         sswI4R/Mdi2Lupfv0ZN73gS5o0ynWcqamngd4hbgt02X3xT4qoIyekmIsR5r1ZttdkNs
         7TS3CoNOreTbp5IXj4j2LK56Dv/SSSFNQfPcYd0ssty64dIEGez+utPowI4Q276m5Jej
         qpLw==
X-Gm-Message-State: APjAAAUXgzAdWlUeIpNVuISB88gB0zd8tOdMqfAeBfZUAYlwu0sxcycs
        CcnVc25hYR6tLR72jxu9kBlt9A==
X-Google-Smtp-Source: APXvYqyuvHjeSOqRZ0bSOASF4vkOaSMXSUwIsLRamzZHoN/oYe4nKmi/z86bYHLLRVAiwuuw2IMtNQ==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8mr7780658plp.129.1572547074428;
        Thu, 31 Oct 2019 11:37:54 -0700 (PDT)
Received: from localhost ([49.248.58.234])
        by smtp.gmail.com with ESMTPSA id x14sm3744161pfm.96.2019.10.31.11.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:37:53 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v7 01/15] drivers: thermal: tsens: Get rid of id field in tsens_sensor
Date:   Fri,  1 Nov 2019 00:07:25 +0530
Message-Id: <30206cd47d303d2dcaef87f4e3c7173481a0bddd.1572526427.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are two fields - id and hw_id - to track what sensor an action was
to performed on. This was because the sensors connected to a TSENS IP
might not be contiguous i.e. 1, 2, 4, 5 with 3 being skipped.

This causes confusion in the code which uses hw_id sometimes and id
other times (tsens_get_temp, tsens_get_trend).

Switch to only using the hw_id field to track the physical ID of the
sensor. When we iterate through all the sensors connected to an IP
block, we use an index i to loop through the list of sensors, and then
return the actual hw_id that is registered on that index.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c   |  4 ++--
 drivers/thermal/qcom/tsens-common.c | 16 +++++++++-------
 drivers/thermal/qcom/tsens.c        | 11 +++++------
 drivers/thermal/qcom/tsens.h        | 10 ++++------
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index e46a4e3f25c4..fb77acb8d13b 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -245,11 +245,11 @@ static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
 	return adc_code * slope + offset;
 }
 
-static int get_temp_8960(struct tsens_priv *priv, int id, int *temp)
+static int get_temp_8960(struct tsens_sensor *s, int *temp)
 {
 	int ret;
 	u32 code, trdy;
-	const struct tsens_sensor *s = &priv->sensor[id];
+	struct tsens_priv *priv = s->priv;
 	unsigned long timeout;
 
 	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 528df8801254..c037bdf92c66 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -83,11 +83,12 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
-int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp)
+int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 {
-	struct tsens_sensor *s = &priv->sensor[i];
-	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
-	u32 valid_idx = VALID_0 + s->hw_id;
+	struct tsens_priv *priv = s->priv;
+	int hw_id = s->hw_id;
+	u32 temp_idx = LAST_TEMP_0 + hw_id;
+	u32 valid_idx = VALID_0 + hw_id;
 	u32 last_temp = 0, valid, mask;
 	int ret;
 
@@ -123,12 +124,13 @@ int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp)
 	return 0;
 }
 
-int get_temp_common(struct tsens_priv *priv, int i, int *temp)
+int get_temp_common(struct tsens_sensor *s, int *temp)
 {
-	struct tsens_sensor *s = &priv->sensor[i];
+	struct tsens_priv *priv = s->priv;
+	int hw_id = s->hw_id;
 	int last_temp = 0, ret;
 
-	ret = regmap_field_read(priv->rf[LAST_TEMP_0 + s->hw_id], &last_temp);
+	ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
 	if (ret)
 		return ret;
 
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 0627d8615c30..6ed687a6e53c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -14,19 +14,19 @@
 
 static int tsens_get_temp(void *data, int *temp)
 {
-	const struct tsens_sensor *s = data;
+	struct tsens_sensor *s = data;
 	struct tsens_priv *priv = s->priv;
 
-	return priv->ops->get_temp(priv, s->id, temp);
+	return priv->ops->get_temp(s, temp);
 }
 
 static int tsens_get_trend(void *data, int trip, enum thermal_trend *trend)
 {
-	const struct tsens_sensor *s = data;
+	struct tsens_sensor *s = data;
 	struct tsens_priv *priv = s->priv;
 
 	if (priv->ops->get_trend)
-		return priv->ops->get_trend(priv, s->id, trend);
+		return priv->ops->get_trend(s, trend);
 
 	return -ENOTSUPP;
 }
@@ -86,8 +86,7 @@ static int tsens_register(struct tsens_priv *priv)
 
 	for (i = 0;  i < priv->num_sensors; i++) {
 		priv->sensor[i].priv = priv;
-		priv->sensor[i].id = i;
-		tzd = devm_thermal_zone_of_sensor_register(priv->dev, i,
+		tzd = devm_thermal_zone_of_sensor_register(priv->dev, priv->sensor[i].hw_id,
 							   &priv->sensor[i],
 							   &tsens_of_ops);
 		if (IS_ERR(tzd))
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index b89083b61c38..84e5447c5686 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -32,7 +32,6 @@ enum tsens_ver {
  * @priv: tsens device instance that this sensor is connected to
  * @tzd: pointer to the thermal zone that this sensor is in
  * @offset: offset of temperature adjustment curve
- * @id: Sensor ID
  * @hw_id: HW ID can be used in case of platform-specific IDs
  * @slope: slope of temperature adjustment curve
  * @status: 8960-specific variable to track 8960 and 8660 status register offset
@@ -41,7 +40,6 @@ struct tsens_sensor {
 	struct tsens_priv		*priv;
 	struct thermal_zone_device	*tzd;
 	int				offset;
-	unsigned int			id;
 	unsigned int			hw_id;
 	int				slope;
 	u32				status;
@@ -62,13 +60,13 @@ struct tsens_ops {
 	/* mandatory callbacks */
 	int (*init)(struct tsens_priv *priv);
 	int (*calibrate)(struct tsens_priv *priv);
-	int (*get_temp)(struct tsens_priv *priv, int i, int *temp);
+	int (*get_temp)(struct tsens_sensor *s, int *temp);
 	/* optional callbacks */
 	int (*enable)(struct tsens_priv *priv, int i);
 	void (*disable)(struct tsens_priv *priv);
 	int (*suspend)(struct tsens_priv *priv);
 	int (*resume)(struct tsens_priv *priv);
-	int (*get_trend)(struct tsens_priv *priv, int i, enum thermal_trend *trend);
+	int (*get_trend)(struct tsens_sensor *s, enum thermal_trend *trend);
 };
 
 #define REG_FIELD_FOR_EACH_SENSOR11(_name, _offset, _startbit, _stopbit) \
@@ -314,8 +312,8 @@ struct tsens_priv {
 char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
-int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp);
-int get_temp_common(struct tsens_priv *priv, int i, int *temp);
+int get_temp_tsens_valid(struct tsens_sensor *s, int *temp);
+int get_temp_common(struct tsens_sensor *s, int *temp);
 
 /* TSENS target */
 extern const struct tsens_plat_data data_8960;
-- 
2.17.1

