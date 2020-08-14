Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D234244AC2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgHNNmX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgHNNmX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 09:42:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77269C061384;
        Fri, 14 Aug 2020 06:42:22 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so9970722eje.7;
        Fri, 14 Aug 2020 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6C8BvSP4USym3ZWGwZolFOiU9vS+iiX1kKb6Zh8Be9I=;
        b=KJL39l7iiLLAHTs44tuWFhWW8lq+YUqBR3Zs4v7imsXOg2TJA2WHI0H5t5wwVbAv+4
         p6wOdObNNiskDkBnZDBRovV/9hIIwPHY9iQ7qrw5S2kCPipfUG6n36osIsjBWy4jHTLO
         4VH4UiqqzvH8A3EioerRDPjIQBy2jJXk/1gMVDUBBdfgpJOu/1FZmGF7/MvEPmeMDrOs
         lEUWJKUn6OJQEOOaz85MxELpPm4cR5OzX0SvaCMsiYxCKK72xJMetHzpe5T13sbSfKA8
         AIQJBU2OzGqI2v/7vmzOX16nooh35EBFnJs/rjdWrJFwHdcgZwza5WtMKJKCCISYQdI5
         9H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6C8BvSP4USym3ZWGwZolFOiU9vS+iiX1kKb6Zh8Be9I=;
        b=IWm3aadfFPjB44E1mEkYSQDBiWgmxJXjYOcqxzP17wMUX2BFiYlfkWHbelwVnNNIC1
         +WuBjZ1K740SfmW0utTujxjwRDohUYOP9dsfMI/M8w99yQLueAVhpO11/Ep0Op4oGRvH
         4KjAeORyXwdhTLDf7oesAWD8CgHC9MU5SwkdAoPor+aYNt9s1Gris09e7VQKgluJIarF
         ibvg/LSxYIDRwH3C1q8rF8Z06r0YZMn+MONPgn728VapFhbNj8bwZVYuUv5r0PrYPQiN
         ejnTW5xuXay2Dzu07zfYmke2cw4GUB6kIkGFl03VCJwIZCNIowAivAXCatdutX1oK3uw
         AIDA==
X-Gm-Message-State: AOAM531SDvWxuto9BtwARy/bJr71ksG4k1J9tnb0efwppwVDCxdLbNEL
        ZndKXF26EYLI6qNCBAGES2w=
X-Google-Smtp-Source: ABdhPJxlN5eoLhcFX7QLuXxFQPmiYh7z5UmvgDAlEeihFYH7LapVxl6crihwIPWkYLiiqM+wGeMV3Q==
X-Received: by 2002:a17:906:3b91:: with SMTP id u17mr2402895ejf.305.1597412541111;
        Fri, 14 Aug 2020 06:42:21 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-0-192-118.retail.telecomitalia.it. [87.0.192.118])
        by smtp.googlemail.com with ESMTPSA id s2sm6767118ejd.17.2020.08.14.06.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:42:20 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 5/8] drivers: thermal: tsens: Fix wrong get_temp for msm8960
Date:   Fri, 14 Aug 2020 15:41:19 +0200
Message-Id: <20200814134123.14566-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814134123.14566-1-ansuelsmth@gmail.com>
References: <20200814134123.14566-1-ansuelsmth@gmail.com>
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
index 93d2c6c7d1bd..ca83c7f838a5 100644
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

