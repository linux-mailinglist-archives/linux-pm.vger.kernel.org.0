Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C36B9945
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 23:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfITVxM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 17:53:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33001 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbfITVxM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 17:53:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so2489444pls.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3XLPlhPImWAomUfs/g8BXhfm3lVXoZB+dL/zQw9KVyY=;
        b=lEv2wwv0SVuY/tTqDvXJSzksXwIRavTm9n2Rm3hSLNHJUGWIlejeRUEPY6e7vxqoTO
         QzS1uexKLsb/OFZ4LMMCx+wOmVjSQSKugPd55NX+3OIbRWvhfwfuMGqPxZH/7toTIDLY
         9aIApMHudMQPQuRIAJB1bQAlQ5w6wnBBFnTo5lRViTCi6DbPEP2j7csIdp/myh69+iP0
         3lQytGe46/oPFUcNaASXHAf4K3fYYaoA/Q/25txOFfi5I/WqoOXeaZ8vWk2MAkxpKvTr
         ob0tfgetkAZKjhxdJv3AAoGj9UF/Mew8l1Ilf7lv+UXuOXuAcJZTXAA3ugSTDvoVLIcq
         TjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3XLPlhPImWAomUfs/g8BXhfm3lVXoZB+dL/zQw9KVyY=;
        b=tZXMscAamPE/vgWFB6uP4G0JH3guYgVuMIx1FN6zp4vQrLCpwZHTMPHyICgpczQSGp
         L12sa6M/lD8O5CI0ivOCgnuCETv5yGRzNAyiUsivs1/kriKzqYoEsHW5BpdlUA2wQG/7
         Dy+a7gSMNAThTL1Yyg4qgY6LCN/TlHnOXuq6+a5du94OOeRFO9402VhbxwUZ86DSepvx
         DGfcv4NnXROFALRj2CmU8AoyEfkc5uee+URqjRH31rZuc71O1Fa60sGa+tYyYaVQEqNY
         xZ37UcVfAcSbtSPIiZxfgt1N2CYUPAImqk0MCNWy/GO2UCA8jyHwkp3/iPwhPrAUUL5O
         tPWg==
X-Gm-Message-State: APjAAAUOJX6bfrlaUYGeWYrO/DDcUaX6mR1TR7/0NSIl1z9WQTFsEbau
        J4h1eQBryFLOnD6QZbZvdyFhkw==
X-Google-Smtp-Source: APXvYqwjSjGlS9koWFrlkYzxbkZfKLnxgo2Qm2BB1kef2ig3XHyGmZjDbh9c5nguvIbMITmCk5E7DQ==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3mr19569285plb.84.1569016391020;
        Fri, 20 Sep 2019 14:53:11 -0700 (PDT)
Received: from localhost (wsip-98-175-107-49.sd.sd.cox.net. [98.175.107.49])
        by smtp.gmail.com with ESMTPSA id b196sm35326pga.56.2019.09.20.14.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 14:53:10 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v4 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
Date:   Fri, 20 Sep 2019 14:52:29 -0700
Message-Id: <aa318f9ba4aa3fd13b05201743acc1ab2c1a0db1.1569015835.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hide the details of how to convert values read from TSENS HW to mCelsius
behind a function. All versions of the IP can be supported as a result.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 50 +++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index ea2c46cc6a66..6b6b3841c2d0 100644
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
@@ -310,6 +331,7 @@ int __init init_common(struct tsens_priv *priv)
 			goto err_put_device;
 		}
 	}
+
 	for (i = 0, j = VALID_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
-- 
2.17.1

