Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C365618305F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 13:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgCLMh1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 08:37:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43963 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgCLMhX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 08:37:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8so2615867plt.10
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRZT3EU/Ph9hn5/psUJSQbYIIz1fny8XdJb78cRNVvk=;
        b=fM5PKCY5l26gkOj1gDY7RA/ZuTk6X3nFJ5JXehwD2a0KQgt6UYf7oE8XXjCSgTaIQy
         xlImC/M23fQkPyziHqtMu+Jqr+4f5ceNDDpQFJfDLFiNweYr8aSoaMAI6QQ5RW15C91x
         lwil3h91bTh/pBqHCU8nsd3F8ELjcxxWz9EhkLLRCJZfx+BD3a0e797lbYk6i9ptpO/L
         5SAufvrVQagaszYesT3zJgLgxycyIRmuQwvmxoWMgTlGUws4NyaFOkupQu6vXuka/PlP
         xtSdyTRHUszYhdOxczJmqUyEt02VwRTyvojiGLsH2VIVhOnOw35DA/thA9+vMjJVFx+o
         7ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRZT3EU/Ph9hn5/psUJSQbYIIz1fny8XdJb78cRNVvk=;
        b=oTqK7mgVPkVPR2r1EwnZ8VEejExeuVwhq0WUO94BXqXO+GjjdnUPUMwNMjj7j0DVI2
         w7dereUWoObns+3GiFjtKHsbYmHvS/upcIHtGEsBg+psJjaEHK6Mq5EG1ptXmhMb6Zn0
         Y/Ki8OZHUoCHJukRvI3o+Zi+KQKbGlV4slVC7KBJ4uurqzWrschQp4BlfdvQkBnmLj7S
         /+BYS3fw9gHVhNcElpbIzQPtHe8S+uihPeCdgFnPk9sjDx1Zf2Ug1QLTN1t82RnnhqYi
         8KyYjzbUQPHn9bGTwnu4eGJw1Mi8ipiSHL7XG2PyvBmOxdOSSvxQadiFwfJxoLEQ16hx
         j3mA==
X-Gm-Message-State: ANhLgQ3Xsl5QudbeXAT2RCp5SFyiOkVBr6VOjeghOprOAqwjTwYK9I87
        cpnbGNuIaSwDlJ0eI1LJNdNhX3A1Lyw=
X-Google-Smtp-Source: ADFU+vth/ulWwppoC4SYI44Cv0jUGyGRb1RRghSJXdoEfStHr8MTC36uUMJq4mR401mC1qt97/mBVQ==
X-Received: by 2002:a17:90a:1f8d:: with SMTP id x13mr3971210pja.27.1584016640876;
        Thu, 12 Mar 2020 05:37:20 -0700 (PDT)
Received: from localhost ([45.127.45.7])
        by smtp.gmail.com with ESMTPSA id d23sm4306650pfq.210.2020.03.12.05.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 05:37:19 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 2/8] drivers: thermal: tsens: Pass around struct tsens_sensor as a constant
Date:   Thu, 12 Mar 2020 18:06:59 +0530
Message-Id: <740f9254484c08d65869df578628eb523c0049ff.1584015867.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584015867.git.amit.kucheria@linaro.org>
References: <cover.1584015867.git.amit.kucheria@linaro.org>
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
---
 drivers/thermal/qcom/tsens-8960.c   |  2 +-
 drivers/thermal/qcom/tsens-common.c | 15 ++++++++-------
 drivers/thermal/qcom/tsens.h        |  6 +++---
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index a383a57cfbbcb..2a28a5af209ec 100644
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
index c8d57ee0a5bb2..45e68f999bf61 100644
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
 
@@ -275,7 +275,8 @@ static int tsens_threshold_violated(struct tsens_priv *priv, u32 hw_id,
 }
 
 static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
-				struct tsens_sensor *s, struct tsens_irq_data *d)
+				const struct tsens_sensor *s,
+				struct tsens_irq_data *d)
 {
 	int ret;
 
@@ -346,10 +347,10 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 
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
@@ -457,7 +458,7 @@ void tsens_disable_irq(struct tsens_priv *priv)
 	regmap_field_write(priv->rf[INT_EN], 0);
 }
 
-int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
+int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
@@ -486,7 +487,7 @@ int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 	return 0;
 }
 
-int get_temp_common(struct tsens_sensor *s, int *temp)
+int get_temp_common(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index be364bf1d5a63..70dc34c805377 100644
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

