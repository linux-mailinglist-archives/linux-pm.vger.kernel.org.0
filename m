Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F94DE9A9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfJUKfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 06:35:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34693 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfJUKfq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 06:35:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id k20so7568070pgi.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LZlCeZrRTo7/0do93bbsot+ttbvRMEOWIgpwlWXPhlQ=;
        b=zL8ZrW5Nswpqr8PYA8T7fIK4mVVnRxIouA8raLosaE/PRRBX49O1fSlHN5VI8HgYBN
         k3HX+93GASSwAaW2Mn08tXvJs0GA6WM37fnYn9PCAIwsmy9SM+ot/qANbHPHBl9ik8YL
         Eo7lRjXkBjDkz5kpZifLl+Po8Enh6n1zjrEPtH6BULz2eWr6eOereG1CV9T3Qsns8ZWV
         4MxHWd2Niz8bHkgJaYiDGSEWO49AUS4v1wTPWJSD/i4QtHqyTz3i4AS/JAxUFD0gxk0c
         7OwwH6stPyXXs2oTWl3kj2bhEK6jjO7x9QEJcBUK3YTC3aVpewXYRIFztzII2rLnuddY
         /dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LZlCeZrRTo7/0do93bbsot+ttbvRMEOWIgpwlWXPhlQ=;
        b=rOktNkbxGeOEwsJIMCoZ7Gtp47/LKTG28nYItSGl4LHVoA1Dhl+hiNxCT4n7OtZRMX
         kzaw/XibRjeXcuEOoeLotDPlzi2Vx4981R3C49aPErlazK8iA3xh8+M/ey82VSbGY48A
         oypv9gkgJ0F9oHOIjwMVYddEgvRXhv0Xkdtjy+Px5cHXmrq8MKuUzOWqEjk95sU7NxKp
         7ccgGuaeYRtdPE0K1WzHCAwxfS+Ba5wLikZwjvnIFrIZZK+xaCkXydSNh9u9qFQmcobx
         oXqrEZHvNgNsjkGQdKEc76Ulzy5wyFSspNdSth6AoXVqqA8jOjeQKE+qRi1TlBbKDJKh
         UvGw==
X-Gm-Message-State: APjAAAVMAHHx01xLB59te7YOSiFep+pNRhoPBqs8yiN2IEAnPBAitPJO
        lvqvf7OQeli9gzvQRmA6Ce7P/A==
X-Google-Smtp-Source: APXvYqwshX4O5zWNP1T1Eiu1EB7HBw2yPucOWeclwK3FwlsDCV3dOt9lJ+kmTxRAA/ffWzcDk2Y8Kg==
X-Received: by 2002:a62:750d:: with SMTP id q13mr21620042pfc.58.1571654145915;
        Mon, 21 Oct 2019 03:35:45 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id t21sm15041040pgi.87.2019.10.21.03.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:35:45 -0700 (PDT)
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
Subject: [PATCH v6 01/15] drivers: thermal: tsens: Get rid of id field in tsens_sensor
Date:   Mon, 21 Oct 2019 16:05:20 +0530
Message-Id: <30206cd47d303d2dcaef87f4e3c7173481a0bddd.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
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
index e46a4e3f25c42..fb77acb8d13b9 100644
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
index 528df88012543..c037bdf92c663 100644
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
index 0627d8615c307..6ed687a6e53cd 100644
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
index b89083b61c383..84e5447c56860 100644
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

