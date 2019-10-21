Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41BDE9C4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfJUKgf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 06:36:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41422 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfJUKgd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 06:36:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so6408014plr.8
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 03:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0WsTUto1EYkvMJZ+e6vQdDqYayMlmhgUas0MuLlp+q8=;
        b=BuiQwH1NuI9rAQ1fNEk95k5s7p7HCgQHuiuf4lSnqToB9zfnVQdTxIWcYh+AzYJSgi
         6DZcFpM5mQXM44D1usVII25lesoY3vJwT6lG85Waj5JbOt1YjwX76iaevWi1k0gnAatK
         CemNiPO51im7lMFWfCPsXl00qbm4xeNUKbEFuCnTlIQuLYTLTvQBMxhIZl9dteKECikG
         Zd5tv/df2quGJ+fm4aHBG99HtO8UwW4+HWLe8zO3gHPDaRTEYCsX1+LimJXozZcZ8aiz
         AOttS8XF14h9IVT+9Rwpb5GOtd62RRHXezu86KXVDqW/xqhsej+GFW/fzWyuCgy9HhB7
         2OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0WsTUto1EYkvMJZ+e6vQdDqYayMlmhgUas0MuLlp+q8=;
        b=Z8hbJ4pWXPFq53XKF4Yt0DoM7L+nhzzS/DCf6kpcMWPpUR1Lgu14t5lSjkK2yCaH71
         NdXqgsFUc1507Nth2mrgDc0raee4GjJiYVIJTquytqHoMknFPNGMLqnc2ODJ0pfEYZK1
         rtA9w5LcMiJ8+w+Kx9xR9f+KC4Jht8xg/mj012Ef5oJ1HCdWJOYSARD7vWY7iWFQn/k6
         VJbIk2cV5hrULO8EFeO2++0ORXCTOpbXrMRCOAs1eIqNWKcRp0OPVzn2AU+KxYjM4jN1
         fDuwUHYFOd0VjpqcF0Auap5uLHiMRFd+8AB/VyTBjOFsuZGD0nqGsOJabCx/iB1kUQrU
         GvEA==
X-Gm-Message-State: APjAAAXza24+ipUMv0bJfBNYl5VxdYRVEjU8M37hIM0z3G6ib/W3nei6
        XhWWCttJRLnvPpAoWNH4ipSYDCUwe//tPQ==
X-Google-Smtp-Source: APXvYqz4qY1pzInsqF+/DLgEGRbW7/FZgMPVWcaEtlgxH519WfQrnOuiWr5pEtx/dCuGz95VNs3wkw==
X-Received: by 2002:a17:902:a618:: with SMTP id u24mr23620577plq.112.1571654192631;
        Mon, 21 Oct 2019 03:36:32 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id p36sm6572055pgm.55.2019.10.21.03.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:36:32 -0700 (PDT)
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
Subject: [PATCH v6 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
Date:   Mon, 21 Oct 2019 16:05:33 +0530
Message-Id: <0689917475cf83b7e01f6978504fd37352a5e3ca.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
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
index ea2c46cc6a66a..c34a1a26ce298 100644
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

