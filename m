Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59405365F63
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhDTSet (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbhDTSeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:34:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE46C06138B;
        Tue, 20 Apr 2021 11:34:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w3so59796440ejc.4;
        Tue, 20 Apr 2021 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTz+6s25EfUH+8tRBZQTC1iH8pQVmI7eJrWzBFatbxM=;
        b=ig3ww2C/9EEkibf0cn+exIA0ocHp/RAKFTzrfrviPuuuVtb23Q7O5WBxn1R+6kT33a
         6R4qz+V1VLueUeL1KMhoRHSxq0CzjuxaSny/YBPssNKo/C8cK19HjBpwsnAPnkwA9CuS
         1yOy5tNO9kkzSKL2zFBoebMurv+uxZzzVKejefzwzVmMF1xP0smy4NbTWFzM8lOoeJKW
         Dwr0GY/eZMN17S1Gh8RSpUHMdoG3KG0Syv0Wkvh67yN2Kq/Ygwtx9ALsmjo8ygjQ3UiZ
         G6MK0Q3lAlXwjhlLArFaCWhTIMkITvFj+Nxjlb3a/rtRhpihmzCYSfZUYkMawi/1M+ly
         WuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTz+6s25EfUH+8tRBZQTC1iH8pQVmI7eJrWzBFatbxM=;
        b=OiMdvfzarRdqsLintjulJ6hX994eM28IBPfS+GAqzlWIRZder7FqCsNECadR67AnIT
         iHaeE+SWg6oxBPF1jLPSaol1SCAHrKCxXGHZ6G6r8bJBzns31KXBjBxRatTHH5709iRS
         fJxxGUuyZc5pKKzyZLukMnUwU1rOnydGdbNh1UKUlESMTygoOd+X6XshY4LGShgwcKIG
         v8zt2DOWuZmH7UuQ4dsY5rtNCRv7nN/dublTd+NATbhyrQnCzTuoJt6m1iuwBDDgAh59
         SsIOXsjfcikA4OyMTLoh0UZ9Q665OtIOvPNc+0HNijfOJdyfxa3kLxYxiW1Y9wPQvt0B
         cJEA==
X-Gm-Message-State: AOAM531ggZlwM59BDev57SNzNLNJLDQEOJ27Rtflp7F1ZEm7NHCqBf1W
        lsjcZCOfXHM18JavicT8608=
X-Google-Smtp-Source: ABdhPJz0hRgE+ssy2xnPzc27jg3PV3Vy9c10pdn4QzMpdKFjo1wuX2QWzGZdpTE/qdunIs4etMClhQ==
X-Received: by 2002:a17:907:9607:: with SMTP id gb7mr28085390ejc.380.1618943650132;
        Tue, 20 Apr 2021 11:34:10 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id n10sm13357141ejg.124.2021.04.20.11.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:34:09 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [thermal PATCH v15 6/9] drivers: thermal: tsens: Replace custom 8960 apis with generic apis
Date:   Tue, 20 Apr 2021 20:33:40 +0200
Message-Id: <20210420183343.2272-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183343.2272-1-ansuelsmth@gmail.com>
References: <20210420183343.2272-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rework calibrate function to use common function. Derive the offset from
a missing hardcoded slope table and the data from the nvmem calib
efuses.
Drop custom get_temp function and use generic api.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c | 56 +++++++++----------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index a96d37c2b..58112f0df 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -67,6 +67,13 @@
 #define S9_STATUS_OFF		0x3674
 #define S10_STATUS_OFF		0x3678
 
+/* Original slope - 350 to compensate mC to C inaccuracy */
+static u32 tsens_msm8960_slope[] = {
+			826, 826, 804, 826,
+			761, 782, 782, 849,
+			782, 849, 782
+			};
+
 static int suspend_8960(struct tsens_priv *priv)
 {
 	int ret;
@@ -194,9 +201,7 @@ static int calibrate_8960(struct tsens_priv *priv)
 {
 	int i;
 	char *data;
-
-	ssize_t num_read = priv->num_sensors;
-	struct tsens_sensor *s = priv->sensor;
+	u32 p1[11];
 
 	data = qfprom_read(priv->dev, "calib");
 	if (IS_ERR(data))
@@ -204,49 +209,18 @@ static int calibrate_8960(struct tsens_priv *priv)
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
 static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* No VERSION information */
@@ -307,7 +281,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 static const struct tsens_ops ops_8960 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8960,
-	.get_temp	= get_temp_8960,
+	.get_temp	= get_temp_common,
 	.enable		= enable_8960,
 	.disable	= disable_8960,
 	.suspend	= suspend_8960,
-- 
2.30.2

