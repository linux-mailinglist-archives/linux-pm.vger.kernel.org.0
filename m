Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588B9EB74A
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfJaSiu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:38:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45875 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbfJaSit (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:38:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so4577593pgj.12
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/kNhWSzT1XF3+/kAR7Dxjp13J1ZI+CyyKCX+EYBQmx8=;
        b=IFMn73uTG9BbSfgEHKaiuimXMyJccsgaiQ0Oy5+kW4Y9Dt842SLGrlTH1aiwADNy6G
         MQyALSdfjHdvNhQ0SDYsr/VqsgzvbTwErlam0Dx1Iq2bVbIg+/BJps1PZE1OdfjLLdCM
         iSrh8YVzEr9KXs3vHp6kZH8bTZkisH8sEIPDIGWWQaMPXeZO3tW+Ygd4YAvRq+NxjQsb
         LmPQDG/fW6UB37PoERYIRAMv7Le1UHcqQKXeY1nNKXf9IAiIgxI4A0Zvle0ninOqlj3U
         JdpVSTsoYHvrMurJ4xDDTZ6hnYfs2ZBs9+E18iQ7Rr1VfwmWTmhwe0IsyN+M+TThaPV9
         6ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/kNhWSzT1XF3+/kAR7Dxjp13J1ZI+CyyKCX+EYBQmx8=;
        b=lhaL7T0NZMHz44OPk2nHJYY9UxIqz6mtNKTUutzNue/jNT8ZtvgTT0eqr5RkmfxMoW
         P+I/7DcyYvzIoHY4INhA5RDSpSlGd8u99BRI8br8RYdsLCPGP737agKQIX/SZeTNoDRU
         3E3BJuqyrs6YtzZ8RIYj9afdzKqOS52zkkHwqVTbHb2ZGQsrR51WU/jYmJCM/u1mDYi4
         vxO9QtAAqMo6mJLjphM3ya956IuYreW3Wzz5jcKgNNC8Pz7FEj9WqX/hzLKIMQkPHQiY
         lB/5J8HU6ImSEF84XjTGBBLoKEBYtIX2r/z/DtuICTCKrWxWw9SHQSKzBUT1HhXOErR9
         qQLg==
X-Gm-Message-State: APjAAAXlQYDYcs5RariL5TheFTPgv3bivkyApZCz4GqpYxHAgO3tyswV
        y4ISozXN0yuRjwOWvuWKXRgXPg==
X-Google-Smtp-Source: APXvYqzG7uy2DmSMlUW8qbJAXjrztF7KzFwm3BfR23z8r2DWqHagR1+axEZOh9cjTxOi3H+Us9CkaQ==
X-Received: by 2002:a17:90a:170a:: with SMTP id z10mr9670979pjd.86.1572547128652;
        Thu, 31 Oct 2019 11:38:48 -0700 (PDT)
Received: from localhost ([49.248.58.234])
        by smtp.gmail.com with ESMTPSA id 12sm8846517pjm.11.2019.10.31.11.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:38:48 -0700 (PDT)
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
Subject: [PATCH v7 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
Date:   Fri,  1 Nov 2019 00:07:38 +0530
Message-Id: <0689917475cf83b7e01f6978504fd37352a5e3ca.1572526427.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hide the details of how to convert values read from TSENS HW to mCelsius
behind a function. All versions of the IP can be supported as a result.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/thermal/qcom/tsens-common.c | 49 ++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index ea2c46cc6a66..c34a1a26ce29 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -84,13 +84,46 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
+/**
+ * tsens_hw_to_mC - Return sign-extended temperature in mCelsius.
+ * @s:     Pointer to sensor struct
+ * @field: Index into regmap_field array pointing to temperature data
+ *
+ * This function handles temperature returned in ADC code or deciCelsius
+ * depending on IP version.
+ *
+ * Return: Temperature in milliCelsius on success, a negative errno will
+ * be returned in error cases
+ */
+static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
+{
+	struct tsens_priv *priv = s->priv;
+	u32 resolution;
+	u32 temp = 0;
+	int ret;
+
+	resolution = priv->fields[LAST_TEMP_0].msb -
+		priv->fields[LAST_TEMP_0].lsb;
+
+	ret = regmap_field_read(priv->rf[field], &temp);
+	if (ret)
+		return ret;
+
+	/* Convert temperature from ADC code to milliCelsius */
+	if (priv->feat->adc)
+		return code_to_degc(temp, s) * 1000;
+
+	/* deciCelsius -> milliCelsius along with sign extension */
+	return sign_extend32(temp, resolution) * 100;
+}
+
 int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
 	u32 temp_idx = LAST_TEMP_0 + hw_id;
 	u32 valid_idx = VALID_0 + hw_id;
-	u32 last_temp = 0, valid, mask;
+	u32 valid;
 	int ret;
 
 	ret = regmap_field_read(priv->rf[valid_idx], &valid);
@@ -108,19 +141,7 @@ int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 	}
 
 	/* Valid bit is set, OK to read the temperature */
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
-	if (ret)
-		return ret;
-
-	if (priv->feat->adc) {
-		/* Convert temperature from ADC code to milliCelsius */
-		*temp = code_to_degc(last_temp, s) * 1000;
-	} else {
-		mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
-			       priv->fields[LAST_TEMP_0].lsb);
-		/* Convert temperature from deciCelsius to milliCelsius */
-		*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
-	}
+	*temp = tsens_hw_to_mC(s, temp_idx);
 
 	return 0;
 }
-- 
2.17.1

