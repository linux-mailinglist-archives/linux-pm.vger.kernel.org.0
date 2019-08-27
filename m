Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC6A9E79F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 14:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfH0MPZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 08:15:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43964 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbfH0MPW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 08:15:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so14009428pfn.10
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tpMa3H6oDslAvJvzcnjT35SZi+/Pan/FSKgVHqFgjrU=;
        b=qCwNVOy6HgLQaFN7+4h9IgDrY9FcEPl1q5fmZlMULgrtQfFVT5Q8lss/apTYPIFzPz
         zxH4qf6wxqnt4CRoqrniwyAobXOTwlFI9rNXugc3qeCi1OOlUKjSlFzLRpWXjmfePpbQ
         cVv1xIPUe57QATVsk+kWK5AgQiOF5KlxrBDo/rMDNyWSCw8ptdnsqWHP6xBBRTS+MFxW
         dBsc4lVdmvxX9zgl9iY85qV6AH1DgL+ffnM6G35wkEMC92oE1rUFYnjnjaqCIpNSCgKt
         NwahPa409/XgV/s8XYmdxjAuKjyeoVggJeLgsoBo8RSWrtBkC7euQ8V9eJJSAWAI0ViH
         7slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tpMa3H6oDslAvJvzcnjT35SZi+/Pan/FSKgVHqFgjrU=;
        b=CWDEru/KEBRfCrvZ3LKNtTkK1acR9CJAoZmlh9zTZRn0qAw8Ka/UWcsVAFUIc2AfKW
         UtVwv+/1/RrCf4vsY3LDlNDCKrbE3JHz3it3dl/LCV/tp4lJsR2iqCv94KS4Hb2kCW4O
         HNRjVRfImHx2rJNYaxNlNcvUZkwdXSN60D6a66wfRn3edfiEGsqOnBO+cTA9iaDXGl1Z
         I3rBM+O+OLv6kIv6OnNrMITlAOqb9xXYgk3HM8xE5GffYTgDWXLEXgFzGj6qOKYrkzCH
         tVyrbj4mDF1Au4sQ/hhilPjD6JAHf75Ad2N7Uf0rb4Llucz0dX7GfDlDU9fTvW4GNtB/
         a5bA==
X-Gm-Message-State: APjAAAU8nFzpj8B0QgcJ+xGTRf3a6MRb6cD5v3xwkg9qWJravYmujW3S
        uFPdASlGxSquhv2boG/+f/vM0c6SVoAsSA==
X-Google-Smtp-Source: APXvYqy7yui6VrHAK41VWFuMzxuEhlvvxjIDpFED43y1Y9Y4NBjctm/Z4ludfeOaah4apBoort8Cyw==
X-Received: by 2002:a17:90a:342d:: with SMTP id o42mr25704928pjb.27.1566908121004;
        Tue, 27 Aug 2019 05:15:21 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id p10sm14943262pff.132.2019.08.27.05.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:15:20 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
Date:   Tue, 27 Aug 2019 17:44:10 +0530
Message-Id: <64a3d07ebe5c4cfb4643d91f5f6605e8a4ffa48b.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hide the details of how to convert values read from TSENS HW to mCelsius
behind a function. All versions of the IP can be supported as a result.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 50 +++++++++++++++++++++--------
 drivers/thermal/qcom/tsens.h        |  2 ++
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index ea2c46cc6a66a..06b44cfd5eab9 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -84,13 +84,43 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
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
+	u32 temp = 0;
+	int ret;
+
+	ret = regmap_field_read(priv->rf[field], &temp);
+	if (ret)
+		return ret;
+
+	if (priv->feat->adc) {
+		/* Convert temperature from ADC code to milliCelsius */
+		return code_to_degc(temp, s) * 1000;
+	}
+
+	/* deciCelsius -> milliCelsius along with sign extension */
+	return sign_extend32(temp, priv->tempres) * 100;
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
@@ -108,19 +138,7 @@ int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
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
@@ -310,6 +328,10 @@ int __init init_common(struct tsens_priv *priv)
 			goto err_put_device;
 		}
 	}
+
+	/* Save away resolution of signed temperature value for this IP */
+	priv->tempres = priv->fields[LAST_TEMP_0].msb - priv->fields[LAST_TEMP_0].lsb;
+
 	for (i = 0, j = VALID_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e1d6af71b2b9a..409395e436f32 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -283,6 +283,7 @@ struct tsens_context {
  * struct tsens_priv - private data for each instance of the tsens IP
  * @dev: pointer to struct device
  * @num_sensors: number of sensors enabled on this device
+ * @tempres: number of bits used to represent signed temperature (resolution)
  * @tm_map: pointer to TM register address space
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
@@ -299,6 +300,7 @@ struct tsens_context {
 struct tsens_priv {
 	struct device			*dev;
 	u32				num_sensors;
+	u32				tempres;
 	struct regmap			*tm_map;
 	struct regmap			*srot_map;
 	u32				tm_offset;
-- 
2.17.1

