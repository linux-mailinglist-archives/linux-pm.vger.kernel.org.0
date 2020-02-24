Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3780C16A697
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 13:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBXM7N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 07:59:13 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33008 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBXM7K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 07:59:10 -0500
Received: by mail-pj1-f66.google.com with SMTP id m7so4044391pjs.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 04:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqSYGy3uAhQaFX5XcekpNuBwKKitmzw+MlVmmyMMb1A=;
        b=pabfJkATAeFWJVxJ8Wew1z+pl2Hm8naA2uR9GViQE1o/tzZjLZfw9ZItx97mYCTqiu
         ihw98BocNfhXoc0hg3/NWOxsRgPE3oSbdwyZs+zTqCaHKXdRhYebK+W5/CKJfg5WyWoN
         v9uIwBMwbzVpFZZKj76XhuQVaCVyPpG0pABEuqo7bGlk1AsIjxRBEVZzWPan5d9ZDJzo
         OsNGmbSQl8xHV0157kFZStnugyjLG+mZRJmvxksOStwkKt6vGDOWMbGshC78N9jd8Jba
         Wtr/6UB31BnEnLNHDObwNBrrdGVq+Z4Sj/fsqaGETkV7uFPRKyNUEIJoCkZ97GFngOGr
         h1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqSYGy3uAhQaFX5XcekpNuBwKKitmzw+MlVmmyMMb1A=;
        b=jNV/lqSXGFIeTz7CAIngpuK/vM2VUcmHC6LJ639m5OBwHyqmoPawuf4ux3YGaBJA7d
         atisiLSsqea6keBDe21wi1MsUi07xCCJxlMJ18M+zBj/clb+/4wIRpjLFgzk3Qo98jei
         CAYoHFud3bxh+xFRy86LixJtOSelYepg09yBkqw9oYrx6XiRrb0L+/DGJgsU3R+EGKr7
         UgbXUs9qlYlol6YRxYpbXlqOHBHA3TB0+PwYk7T71xdeseTPI9KfEVpnk8Fb+OK4ZIVL
         XTjPDWX7XLl71qaiB3Pno96dt6oIO5A9XS+z6VcSsh31Otyzeq+MdGHZDGZoE4wcFWg7
         Kbow==
X-Gm-Message-State: APjAAAXAligcb30LwtQpVEhRTEVJI1wEgZd0Qs4VxXkGzet5x3KXyZXM
        EuvZzEw0x6Oo/lUzn46qf1ve/A==
X-Google-Smtp-Source: APXvYqxFrMvxrUVwDZi4HnRHXCjpZUVSuHQZbX3A2mxh4IGNAVm4X9CWnauFNKmXLuk7ayOj1uk8jg==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10mr50604263plb.288.1582549150123;
        Mon, 24 Feb 2020 04:59:10 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id o6sm12810880pgg.37.2020.02.24.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 04:59:09 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 2/8] drivers: thermal: tsens: Pass around struct tsens_sensor as a constant
Date:   Mon, 24 Feb 2020 18:28:49 +0530
Message-Id: <6639c00c1a068fcdfef4624706f44272ebc38a4a.1582548319.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582548319.git.amit.kucheria@linaro.org>
References: <cover.1582548319.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All the sensor data is initialised at init time. Lock it down by passing
it to functions as a constant.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/57f5fd302213d30b53d9d6b3624758180e8df48b.1582048155.git.amit.kucheria@linaro.org
---
 drivers/thermal/qcom/tsens-8960.c   |  2 +-
 drivers/thermal/qcom/tsens-common.c | 14 +++++++-------
 drivers/thermal/qcom/tsens.h        |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index a383a57cfbbc..2a28a5af209e 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -245,7 +245,7 @@ static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
 	return adc_code * slope + offset;
 }
 
-static int get_temp_8960(struct tsens_sensor *s, int *temp)
+static int get_temp_8960(const struct tsens_sensor *s, int *temp)
 {
 	int ret;
 	u32 code, trdy;
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c8d57ee0a5bb..c2df30a08b9e 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -128,7 +128,7 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
  * Return: Temperature in milliCelsius on success, a negative errno will
  * be returned in error cases
  */
-static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
+static int tsens_hw_to_mC(const struct tsens_sensor *s, int field)
 {
 	struct tsens_priv *priv = s->priv;
 	u32 resolution;
@@ -160,7 +160,7 @@ static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
  *
  * Return: ADC code or temperature in deciCelsius.
  */
-static int tsens_mC_to_hw(struct tsens_sensor *s, int temp)
+static int tsens_mC_to_hw(const struct tsens_sensor *s, int temp)
 {
 	struct tsens_priv *priv = s->priv;
 
@@ -275,7 +275,7 @@ static int tsens_threshold_violated(struct tsens_priv *priv, u32 hw_id,
 }
 
 static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
-				struct tsens_sensor *s, struct tsens_irq_data *d)
+				const struct tsens_sensor *s, struct tsens_irq_data *d)
 {
 	int ret;
 
@@ -346,10 +346,10 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		bool trigger = false;
-		struct tsens_sensor *s = &priv->sensor[i];
+		const struct tsens_sensor *s = &priv->sensor[i];
 		u32 hw_id = s->hw_id;
 
-		if (IS_ERR(priv->sensor[i].tzd))
+		if (IS_ERR(s->tzd))
 			continue;
 		if (!tsens_threshold_violated(priv, hw_id, &d))
 			continue;
@@ -457,7 +457,7 @@ void tsens_disable_irq(struct tsens_priv *priv)
 	regmap_field_write(priv->rf[INT_EN], 0);
 }
 
-int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
+int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
@@ -486,7 +486,7 @@ int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 	return 0;
 }
 
-int get_temp_common(struct tsens_sensor *s, int *temp)
+int get_temp_common(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index be364bf1d5a6..70dc34c80537 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -67,7 +67,7 @@ struct tsens_ops {
 	/* mandatory callbacks */
 	int (*init)(struct tsens_priv *priv);
 	int (*calibrate)(struct tsens_priv *priv);
-	int (*get_temp)(struct tsens_sensor *s, int *temp);
+	int (*get_temp)(const struct tsens_sensor *s, int *temp);
 	/* optional callbacks */
 	int (*enable)(struct tsens_priv *priv, int i);
 	void (*disable)(struct tsens_priv *priv);
@@ -494,8 +494,8 @@ struct tsens_priv {
 char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
-int get_temp_tsens_valid(struct tsens_sensor *s, int *temp);
-int get_temp_common(struct tsens_sensor *s, int *temp);
+int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
+int get_temp_common(const struct tsens_sensor *s, int *temp);
 int tsens_enable_irq(struct tsens_priv *priv);
 void tsens_disable_irq(struct tsens_priv *priv);
 int tsens_set_trips(void *_sensor, int low, int high);
-- 
2.20.1

