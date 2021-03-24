Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA2348400
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 22:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhCXVok (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 17:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhCXVoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 17:44:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD8AC06174A;
        Wed, 24 Mar 2021 14:44:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id jy13so35313728ejc.2;
        Wed, 24 Mar 2021 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiZ/OUht/kOLQVInECTqjo/bGxXXWMawhAot8IzJzB8=;
        b=VbbDJdRCpNaCCNPNYmuFR7FvSYuGVigTDdkuML0ukmfdNFDPmLTFym3RJq9FBOykSM
         bNC2KmyH5CWf2ESliwWpjAsxm4otVWaLFr0q6h8fCiaCUgCtbKO//t5cgu5LcHrw49A0
         7G0px/oL40qoQGXbHMBreMCKerVwFfHStuuU/TKSYrzOce73c/424EhsRqT2Eg+Oxoxe
         9/EKKsUHwUcUSFdYGQz9h0PR/gLvDEw0apJI1xNZJ8zuLfh56RUalZxsuj7wT14TKsly
         vpxlGJpLpV3bXEP87QSW7nlIGKfzgWCSRiZUFYEFUkcakKBLoljbwy8SQsW1NbFfWIe0
         ypTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eiZ/OUht/kOLQVInECTqjo/bGxXXWMawhAot8IzJzB8=;
        b=ChYfXHsAFBUqfnCK83rfCczNmcI1V8mKrWY2FdunZWq2OiN+UfIDiWZ/xF3607Hvs/
         cb6pEHQ5LqGA8C3fVnnyNRu9Usd8gq+ZvS0uKXTuBrRmzzff5IPk4ayy1gUJG5AcAwYG
         x4m1kYEZFo6eeMzmcq9OrETqgdFBOMly0t8+FoOFgxbRzd3oMgzcW4A7JxA61t5V5aNn
         lmPXoldA7IFszeR+81arXTfwKkQ2FN3l28EUTzc9NVwb7YSdjz7Sp6Ctnv/w4gbT0fYW
         a7qYLJ0UD7wjcblDhTv+djvsbCAKsRgBufeBuUCZflH4eBw2c3ttCnbj5jAiYEkptiYR
         +5jQ==
X-Gm-Message-State: AOAM5311E1LTXgjU3yNCbk/NopR0NwjykUPPdvgVtnecgNcqH/2VQ90N
        u7dFPI2L9zDjvu6TlXSH++k=
X-Google-Smtp-Source: ABdhPJw0657aWt0rjTjUMXuSidEn8WNuq/LYrmKuVSe/+dggYcg5MMIhhqObVRRHGG0RhYa+M9R2Rw==
X-Received: by 2002:a17:906:6bd1:: with SMTP id t17mr6003777ejs.319.1616622257378;
        Wed, 24 Mar 2021 14:44:17 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id z9sm1871211edr.75.2021.03.24.14.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:44:17 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v13 6/9] drivers: thermal: tsens: Replace custom 8960 apis with generic apis
Date:   Wed, 24 Mar 2021 22:44:00 +0100
Message-Id: <20210324214404.798-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324214404.798-1-ansuelsmth@gmail.com>
References: <20210324214404.798-1-ansuelsmth@gmail.com>
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
index 95fcccafae14..9cc8a7dd23ae 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -67,6 +67,13 @@
 #define S9_STATUS_OFF		0x3674
 #define S10_STATUS_OFF		0x3678
 
+/* Original slope - 200 to compensate mC to C inaccuracy */
+static u32 tsens_msm8960_slope[] = {
+			976, 976, 954, 976,
+			911, 932, 932, 999,
+			932, 999, 932
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
 static struct tsens_features tsens_8960_feat = {
 	.ver_major	= VER_0,
 	.crit_int	= 0,
@@ -315,7 +289,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
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

