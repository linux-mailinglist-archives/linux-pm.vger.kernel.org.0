Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E72C4D48
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 03:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbgKZCMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 21:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbgKZCMg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 21:12:36 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A0C0613D4;
        Wed, 25 Nov 2020 18:12:35 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id mc24so621986ejb.6;
        Wed, 25 Nov 2020 18:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18mjJQ2LV7K44mzxIFRG9iVwB1Fl7ExfbKXsXQSaBWY=;
        b=VFEEaZJnQLGknvWEhR3vwlpib/YvHL9G5/+B/P2XdKjwGZPzD1sucFuNAas/mqgRBV
         4LNHYvZqBQlsXW5KDnr5UO6ckuZV64BO7FGDwMyrlSUjqx3LhyRVh/77+gU/0BEG/R2g
         AiHw4JtUk1POMDj0gz8iTtKnZR5eJTEHTo3AUnoem30/luugzWHXnLbiTPlJI0iLCr8y
         kHZPIwp2vk3w73eTvgR1kMf5/yqXpD7i42l4UhyFxE/BU04WiEBFp2xikmu5NAjg2eZ+
         QbaYm3WdTYr+F4xiZZBDobhJMjpAcxRKgIXp1pJlTl4IuxDEe7mzoXslmxb1gonWpONQ
         n4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18mjJQ2LV7K44mzxIFRG9iVwB1Fl7ExfbKXsXQSaBWY=;
        b=mHy3dnHxlrVbyAEMERODIPFdsL1uoZh3D4b3/s7CN2Aulo5GyDyUqR1sVxR5FxQ/2W
         3jI5XbGQhm8aU0uqjgDWoVHm+A+dTem7cHKFCq2wVDWI3R0OUd3fOXC5yS2JHsEp2Ci+
         TmU9NR0s7IIKlfIZU0ZYZH3wX1b/2pXL6l3IvhOwmhJXXbOodPbzOy/b/TjF983F67xE
         AN5LCW99LkB8kl3ewdBE4gEVWhs+6tMDAU4AAJdXm+m3aYDmQWY3fhCDv4Ijlk1+cLnk
         J2sZ3KTq1jf85Xkt7hEAyhl1N+6FwUQjsm5GYez1dXzNcNOe0OYYjN9dhOcfkQq2m+Tf
         GLtw==
X-Gm-Message-State: AOAM532QkBoCzV3uyv/WBj5nJz5NqKrD9GpYprtVARZAeUl92pj/ska+
        H4KEBTTZBkTG/+qbKinl6OjhTUdiFAAssg==
X-Google-Smtp-Source: ABdhPJyx3iQ4SToqZSbz6dUucuv5772OZh4Yx2yNaCi56Wr42/0zVyLnVbg3xUrvGGJErwt6l2tLMA==
X-Received: by 2002:a17:906:5a97:: with SMTP id l23mr772423ejq.232.1606356754395;
        Wed, 25 Nov 2020 18:12:34 -0800 (PST)
Received: from ansuel-xps20.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id d7sm417276edv.17.2020.11.25.18.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 18:12:33 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/8] driver: thermal: tsens: Use get_temp_common for msm8960
Date:   Wed, 25 Nov 2020 18:48:23 +0100
Message-Id: <20201125174826.24462-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125174826.24462-1-ansuelsmth@gmail.com>
References: <20201125174826.24462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rework calibrate function to use common function. Derive the offset from
a missing hardcoded slope table and the data from the nvmem calib
efuses.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 56 +++++++++----------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index f786f44f5d5d..4cd2cc14bc4c 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -67,6 +67,13 @@
 #define S9_STATUS_OFF		0x3674
 #define S10_STATUS_OFF		0x3678
 
+/* Original slope - 200 to compensate mC to C inaccuracy */
+u32 tsens_msm8960_slope[] = {
+			976, 976, 954, 976,
+			911, 932, 932, 999,
+			932, 999, 932
+			};
+
 static int suspend_8960(struct tsens_priv *priv)
 {
 	int ret;
@@ -192,9 +199,7 @@ static int calibrate_8960(struct tsens_priv *priv)
 {
 	int i;
 	char *data;
-
-	ssize_t num_read = priv->num_sensors;
-	struct tsens_sensor *s = priv->sensor;
+	u32 p1[11];
 
 	data = qfprom_read(priv->dev, "calib");
 	if (IS_ERR(data))
@@ -202,49 +207,18 @@ static int calibrate_8960(struct tsens_priv *priv)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	for (i = 0; i < num_read; i++, s++)
-		s->offset = data[i];
+	for (i = 0; i < priv->num_sensors; i++) {
+		p1[i] = data[i];
+		priv->sensor[i].slope = tsens_msm8960_slope[i];
+	}
+
+	compute_intercept_slope(priv, p1, NULL, ONE_PT_CALIB);
 
 	kfree(data);
 
 	return 0;
 }
 
-/* Temperature on y axis and ADC-code on x-axis */
-static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
-{
-	int slope, offset;
-
-	slope = thermal_zone_get_slope(s->tzd);
-	offset = CAL_MDEGC - slope * s->offset;
-
-	return adc_code * slope + offset;
-}
-
-static int get_temp_8960(const struct tsens_sensor *s, int *temp)
-{
-	int ret;
-	u32 code, trdy;
-	struct tsens_priv *priv = s->priv;
-	unsigned long timeout;
-
-	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
-	do {
-		ret = regmap_read(priv->tm_map, INT_STATUS_ADDR, &trdy);
-		if (ret)
-			return ret;
-		if (!(trdy & TRDY_MASK))
-			continue;
-		ret = regmap_read(priv->tm_map, s->status, &code);
-		if (ret)
-			return ret;
-		*temp = code_to_mdegC(code, s);
-		return 0;
-	} while (time_before(jiffies, timeout));
-
-	return -ETIMEDOUT;
-}
-
 static struct tsens_features tsens_8960_feat = {
 	.ver_major	= VER_0,
 	.crit_int	= 0,
@@ -308,7 +282,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 static const struct tsens_ops ops_8960 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8960,
-	.get_temp	= get_temp_8960,
+	.get_temp	= get_temp_common,
 	.enable		= enable_8960,
 	.disable	= disable_8960,
 	.suspend	= suspend_8960,
-- 
2.29.2

