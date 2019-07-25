Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4A75A82
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 00:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfGYWTF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 18:19:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41006 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfGYWTC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 18:19:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so23445610pff.8
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=T23MbWVpdj6R89qBW0TPjQAQVoCPqSBMgv5aqOKE3hE=;
        b=v6GNbodfdpptvKW4rjgl7pyeu2Vt5rYIFlxde1a1VK0ABaOJD+Pa4K0wwlwE6cQMIS
         /GqpkruBVriaSowoJUeGSCEGNGz9KB3E2Yk9x9LA2acINMqEEc8ClEpfLDQI5IFwqgsj
         qQgC1+kzNIwz8GRETInJAoQunCMiYxXpTXSSqEM9H7W0LNr3j9MM5XOa4JE0vFDgRtko
         gsRXKcOpr3c0K/tXQPkRTRbdcWEEO8C+jHVctIAyykf/uLDlXrAKKciUVkG2x3QA1gz8
         T45Umprp6Nt6hVsIEAe1enB2DwJ0T3umlNaAbuR1LHabU+5skIPhUU6rsbCp1DBa3B2f
         vvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=T23MbWVpdj6R89qBW0TPjQAQVoCPqSBMgv5aqOKE3hE=;
        b=pdRXxRjAhLjlyTB0DsfvNAZEwCiBvPKSnNf0T7b8dgB71K6NZ7XKko0k97KU+nirPo
         SjkP/HzMeR7O9nQiX/bNO6gUS3huuB1tn/mPL8sXxzNPSIVhu24WKgsKJunyocRF7Ctn
         4ZjG28qN9epAu+CCAMEMwVRLi/liPJuNXQpNSHeb3Ws4ZwSTC0wZ9GyXYIgP58UUBQJA
         +2W/RGG9L8nHU7Jwx9HWT/iXxfygWx39M0wjFZa6eMw2dGV/GOsHEoo397xUXY7TZ08V
         X4yzx2kegtFGoe4PJOQAdq4G+ezsjBujOaWj+6owSSrtMZHbiRCSPN7kjG6ONPUo4wXu
         4rFw==
X-Gm-Message-State: APjAAAWHalIhTh4V/9XAYvSfgpxFuXceP7Mc8GnM+76yTaz7vMs/eR8l
        8wIb+/R4/a/8ZgbfWd8MkovRnA==
X-Google-Smtp-Source: APXvYqx05YDaqfmr6kyX0q6onBEPCV3d7poXCFEWMe2D7q7GoEgcQS9s4Sr8E20XyZUrE5gH4Tijug==
X-Received: by 2002:a62:18d4:: with SMTP id 203mr19031577pfy.165.1564093141620;
        Thu, 25 Jul 2019 15:19:01 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id v138sm58504769pfc.15.2019.07.25.15.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:01 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 01/15] drivers: thermal: tsens: Get rid of id field in tsens_sensor
Date:   Fri, 26 Jul 2019 03:48:36 +0530
Message-Id: <9dc86fa912d9b6e21857598ad81ff88564468e5d.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
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
---
 drivers/thermal/qcom/tsens-8960.c   |  4 ++--
 drivers/thermal/qcom/tsens-common.c | 16 +++++++++-------
 drivers/thermal/qcom/tsens.c        | 11 +++++------
 drivers/thermal/qcom/tsens.h        | 10 ++++------
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 8d9b721dadb6..3e1436fda1eb 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -243,11 +243,11 @@ static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
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
index 2fd94997245b..d022e726d074 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -31,7 +31,6 @@ enum tsens_ver {
  * @priv: tsens device instance that this sensor is connected to
  * @tzd: pointer to the thermal zone that this sensor is in
  * @offset: offset of temperature adjustment curve
- * @id: Sensor ID
  * @hw_id: HW ID can be used in case of platform-specific IDs
  * @slope: slope of temperature adjustment curve
  * @status: 8960-specific variable to track 8960 and 8660 status register offset
@@ -40,7 +39,6 @@ struct tsens_sensor {
 	struct tsens_priv		*priv;
 	struct thermal_zone_device	*tzd;
 	int				offset;
-	unsigned int			id;
 	unsigned int			hw_id;
 	int				slope;
 	u32				status;
@@ -61,13 +59,13 @@ struct tsens_ops {
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
@@ -313,8 +311,8 @@ struct tsens_priv {
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

