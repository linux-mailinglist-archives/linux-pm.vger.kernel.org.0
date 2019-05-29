Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF32D3D4
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 04:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfE2Ceg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 22:34:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40072 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2Cef (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 22:34:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so384549pgm.7;
        Tue, 28 May 2019 19:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h4HAswLo5xWylyhxHYQaGkQiPnSlTO4ftDNVwHlm10E=;
        b=BdijjK50B4yGs2xl1j13xH1Nea+/zyun0B4RhsO/A6piYaISkz9mwd6HXAxV2giSbx
         /ZctzsJGZcwcb6rR1cXFLB1ORIxZInUr8qObA+0Kc2EYTzos0bOxznQKvBWp52FWx9sU
         dnZT37oa67uXnAM/fpDYfj0b63duM6O86iOG2MbrtN7xzw8H1zqf1S/r2YbZVQ1VQgI8
         n5kAWrQxtAejzSfZs3Z4sO6CqokjNVtnhS1DKQAIEdsxXdif1mpd0D5V2ffK+dMgFlZG
         0BoOpbnAoycIkR4BoAZZc6Dso7Syz39z8/EDZykdtz1XupQSyrcCYH8MkVG1A1s3PRLt
         cz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h4HAswLo5xWylyhxHYQaGkQiPnSlTO4ftDNVwHlm10E=;
        b=paCgnMLxpKyv0pmSoa2JWUak+oZ8gMSTgvXlpxFr6FiAu9wtqhRBHrPdSeRS8fNkSV
         4u0JO8L58yepnHuAmepNd9snKraSf8AUGDbBQxhyzEsVTUhg8IRTsDiCc2rgriTEQjIt
         f4mgmpXwaRsKt7yw+mtBPLLduN/38+N50RoBlixHGJu2Yh/eECHem7yOiFLGjdjLbYNw
         cVFXfW6PHT6yaCnjbQvKxfq8U7OAZ5M54LVKJepiprs6P6lPYRBkFMU0xwkCuvsHoKkj
         RyaJ9nTUeVY+pHxJGvuWXrTSdSpc3DasJLNZjuzBKjrw4NIYgNBGxW/yXvbHtln8jb3Z
         NTVg==
X-Gm-Message-State: APjAAAU5MEPc5eKLTxCoWn8yVQvsnQ2QcMcQ3sCayghYVO2UZioHV2Ht
        qBMHwxIEykc7j4RQgOXwUYFpun3+
X-Google-Smtp-Source: APXvYqyofbBxvyS5ovPaLMDcXQsE5q3ulrvYaBAWd1va1isSW/QGyl9IdZGEFFsHVqa9GjNYBISZ+w==
X-Received: by 2002:a17:90a:ae10:: with SMTP id t16mr9470350pjq.51.1559097274267;
        Tue, 28 May 2019 19:34:34 -0700 (PDT)
Received: from localhost ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id f16sm10422064pja.18.2019.05.28.19.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 19:34:32 -0700 (PDT)
From:   Eduardo Valentin <edubezval@gmail.com>
To:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, bot@kernelci.org,
        Kevin Hilman <khilman@baylibre.com>,
        kernel-build-reports@lists.linaro.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/1] Revert "drivers: thermal: tsens: Add new operation to check if a sensor is enabled"
Date:   Tue, 28 May 2019 19:34:26 -0700
Message-Id: <1559097266-12780-1-git-send-email-edubezval@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <CAJ=6tTqOW5s_dhEuy3su+R6=tUY_ZiuAuCMG1A8Y-Lz-aHXw2Q@mail.gmail.com>
References: <CAJ=6tTqOW5s_dhEuy3su+R6=tUY_ZiuAuCMG1A8Y-Lz-aHXw2Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit 3e6a8fb3308419129c7a52de6eb42feef5a919a0.

Cc: Andy Gross <agross@kernel.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Suggested-by: Amit Kucheria <amit.kucheria@linaro.org>
Reported-by: Andy Gross <andygro@gmail.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---

Added this for next -rc, as per request.

 drivers/thermal/qcom/tsens-common.c | 14 --------------
 drivers/thermal/qcom/tsens-v0_1.c   |  1 -
 drivers/thermal/qcom/tsens-v2.c     |  1 -
 drivers/thermal/qcom/tsens.c        |  5 -----
 drivers/thermal/qcom/tsens.h        |  1 -
 5 files changed, 22 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 928e8e8..528df88 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -64,20 +64,6 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	}
 }
 
-bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
-{
-	u32 val;
-	int ret;
-
-	if ((hw_id > (priv->num_sensors - 1)) || (hw_id < 0))
-		return -EINVAL;
-	ret = regmap_field_read(priv->rf[SENSOR_EN], &val);
-	if (ret)
-		return ret;
-
-	return val & (1 << hw_id);
-}
-
 static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 {
 	int degc, num, den;
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index a319283..6f26fad 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -334,7 +334,6 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFFSET */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF, 0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF, 1,  1),
-	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF, 3, 13),
 
 	/* ----- TM ------ */
 	/* INTERRUPT ENABLE */
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 1099069..0a4f2b8 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -44,7 +44,6 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFF */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
-	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3, 18),
 
 	/* ----- TM ------ */
 	/* INTERRUPT ENABLE */
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 36b0b52..0627d86 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -85,11 +85,6 @@ static int tsens_register(struct tsens_priv *priv)
 	struct thermal_zone_device *tzd;
 
 	for (i = 0;  i < priv->num_sensors; i++) {
-		if (!is_sensor_enabled(priv, priv->sensor[i].hw_id)) {
-			dev_err(priv->dev, "sensor %d: disabled\n",
-				priv->sensor[i].hw_id);
-			continue;
-		}
 		priv->sensor[i].priv = priv;
 		priv->sensor[i].id = i;
 		tzd = devm_thermal_zone_of_sensor_register(priv->dev, i,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index eefe384..2fd9499 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -315,7 +315,6 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
 int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
-bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
 
 /* TSENS target */
 extern const struct tsens_plat_data data_8960;
-- 
2.1.4

