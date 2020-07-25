Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C4F22D941
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jul 2020 20:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgGYSOd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jul 2020 14:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGYSOd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2020 14:14:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E109BC08C5C0;
        Sat, 25 Jul 2020 11:14:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c10so4961352ejs.5;
        Sat, 25 Jul 2020 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dypi6W7S3VPoD6us+W6vHl+BfPt84Qw7JQkqUWPuGnI=;
        b=R7czV8K90JrZ8kc04hSAZ/Z6kF6sVypYKAn1h3JP0r4nOj8DXckSUPHZQOKSiovbsp
         vKn3kQ4nbZxD2PzsGETAC44nOI9thfrL9l6PCTQ3MdSLghG1Vo2SgUE02lWhxioP8OUR
         nqkmnYCR757CWSLCxUMMrNZzTuGiuMTa2+v4FcMz9VCgqud4byPIhrn6BM4UoyO4ww8o
         yM7p3C+K9YRiqUdt9IguyvRP2/LPg9PzOohkt7nAFnWiAl0GmeSHbfiH5Ilvg+A+Cvyn
         sBDfsxEhMGrVx3U4ja813i8HR0m3MqzYN4PhtCv4YjUHlmeZOPGdiliUlpeeQke8kQuu
         7Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dypi6W7S3VPoD6us+W6vHl+BfPt84Qw7JQkqUWPuGnI=;
        b=kMob4LajpoW+EL6F/lqclK1HefcfiCWZBIwi87qzCh1WHyZuBvfwn5fe0oEfPWgEJ7
         uipOuMNxJMKY2jT0qj5N524XvHya0TB9/GQFMHTIrdavdlvAPm1hpww9bsNuTxXPd4S1
         9gb1JzakSn4lm/QkkbDbSXfVPhRICPJS0NNLsVpPr5ZOwKZLQeAx9vceaDRK2mqvkCDF
         mHLX7HFNu8Yi7i354n3Dsn4DUxW1pBJUsyRUQODUzTeqqyfVfHIo72AHwa2Pe64Z4Q6/
         ypjCx5EsUyrxuZqNs1l6S2Yw6z3Jh/O1baObAMAqJvyA3srTjfPlfgNsGFPOGV/O27x5
         wKRw==
X-Gm-Message-State: AOAM530I29+PcblGLYa28FCQ56WFWF6BR3/+eWsP4DgawEUMBc0ZFxay
        t/+TiQ56DmB3plc9xnt9gOs=
X-Google-Smtp-Source: ABdhPJy/2BgoyFwhgeRpWBTjZxrsh/hqlVqglK2w0zRn1dAv89ozRvS0w5ZbDM5iERyuBFmg5da4Tw==
X-Received: by 2002:a17:907:72cc:: with SMTP id du12mr14322462ejc.357.1595700871550;
        Sat, 25 Jul 2020 11:14:31 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-22-5-125.retail.telecomitalia.it. [79.22.5.125])
        by smtp.googlemail.com with ESMTPSA id qn10sm220922ejb.39.2020.07.25.11.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:14:31 -0700 (PDT)
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
Subject: [RFC PATCH v5 4/7] drivers: thermal: tsens: Fix wrong get_temp for msm8960
Date:   Sat, 25 Jul 2020 20:14:00 +0200
Message-Id: <20200725181404.18951-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200725181404.18951-1-ansuelsmth@gmail.com>
References: <20200725181404.18951-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

msm8960 based tsens have an hardcoded slope. Fix the calibrate function
with the new added slope, change code_to_mdegC to use slope and conver
get_temp to use reg_field.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 43 +++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index d545cf9888fd..42ab8f79bf5b 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -67,6 +67,14 @@
 #define S9_STATUS_OFF		0x3674
 #define S10_STATUS_OFF		0x3678
 
+#define TSENS_FACTOR		1
+
+u32 tsens_msm8960_slope[] = {
+			1176, 1176, 1154, 1176,
+			1111, 1132, 1132, 1199,
+			1132, 1199, 1132
+			};
+
 static int suspend_8960(struct tsens_priv *priv)
 {
 	int ret;
@@ -187,8 +195,10 @@ static int calibrate_8960(struct tsens_priv *priv)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	for (i = 0; i < num_read; i++, s++)
-		s->offset = data[i];
+	for (i = 0; i < num_read; i++, s++) {
+		s->slope = tsens_msm8960_slope[i];
+		s->offset = CAL_MDEGC - (data[i] * s->slope);
+	}
 
 	kfree(data);
 
@@ -198,32 +208,43 @@ static int calibrate_8960(struct tsens_priv *priv)
 /* Temperature on y axis and ADC-code on x-axis */
 static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
 {
-	int slope, offset;
+	int num, degc;
+
+	num = (adc_code * s->slope) + s->offset;
 
-	slope = thermal_zone_get_slope(s->tzd);
-	offset = CAL_MDEGC - slope * s->offset;
+	if (num == 0)
+		degc = num;
+	else if (num > 0)
+		degc = (num + TSENS_FACTOR / 2)
+			/ TSENS_FACTOR;
+	else
+		degc = (num - TSENS_FACTOR / 2)
+			/ TSENS_FACTOR;
 
-	return adc_code * slope + offset;
+	return degc;
 }
 
 static int get_temp_8960(const struct tsens_sensor *s, int *temp)
 {
 	int ret;
-	u32 code, trdy;
+	u32 last_temp = 0, trdy;
 	struct tsens_priv *priv = s->priv;
 	unsigned long timeout;
 
 	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
 	do {
-		ret = regmap_read(priv->tm_map, INT_STATUS_ADDR, &trdy);
+		ret = regmap_field_read(priv->rf[TRDY], &trdy);
 		if (ret)
 			return ret;
-		if (!(trdy & TRDY_MASK))
+		if (!trdy)
 			continue;
-		ret = regmap_read(priv->tm_map, s->status, &code);
+
+		ret = regmap_field_read(priv->rf[LAST_TEMP_0 + s->hw_id], &last_temp);
 		if (ret)
 			return ret;
-		*temp = code_to_mdegC(code, s);
+
+		*temp = code_to_mdegC(last_temp, s);
+
 		return 0;
 	} while (time_before(jiffies, timeout));
 
-- 
2.27.0

