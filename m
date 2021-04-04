Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C213539DD
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhDDUfh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhDDUfW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:35:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519F7C0613E6;
        Sun,  4 Apr 2021 13:35:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b7so14375235ejv.1;
        Sun, 04 Apr 2021 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiZ/OUht/kOLQVInECTqjo/bGxXXWMawhAot8IzJzB8=;
        b=DHgxKcJdJl1+vBQUGSCqG+/SLDhkt1Q3G+9lcmhsqkGtWkzG9+qlvfWSavVfqwyP7O
         YevRlqyBeY3QrRdPnPTzGIx30I49xurWtmoPPjiNZlPdJZYtB5hSHKM5xnbQaNCGQq1w
         NHS81GrUBmCC2RDGwLlid+mrcU1W0PEJbVgi/2fujGyk7xollBDoVySOWBhU5bupPAJM
         WABs8j0XP7Bf36lZrOfaC53LmN8uBOAL6HXBIiA1uP91WtBIuwy3MoSS++l6Iw9aGuDF
         O57iHGDdtd3iaiKk6tnmVOK83bLD7HJ9P2E7mOpNshVKfgfQX1sqM6Id30XOrbkYezXm
         ll+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eiZ/OUht/kOLQVInECTqjo/bGxXXWMawhAot8IzJzB8=;
        b=QoeFsj2X/QjfnGZg6W2jo30h2hMoKs4ztiOrR+Mult1xF3Rx/ffnMKPCGUwUs1mQSV
         JHVEc4ZVxTCulj3+WQW0SYkm635Oaabq+9EX1jrGcrGxl8zNLPuh6a2rzRQY4FiLzf6Q
         nLXWRyDA5y3TLRz3f005gd24m8t3Cit0wZxUj7wo9zGZ/Ldll8Coe2IHAd2hxmVGstkY
         a5srQeQv0seuDE/qAKWEy/TDnA/JIvQRUOTuOlvKOBKyZX3Pehue9bDvznOniySomL7I
         NORnIZbFg8iSRzeMtOtJpFGUK0qS36f5AOQ7iM44dPtAxN2jRgOiu95EtoJl7gxu/mCi
         aNQw==
X-Gm-Message-State: AOAM533QS9DgfbHgbou/nUjKHhNnMs/l8KdZQnr5oYCWSqRTyV+Jy12Q
        Ljauv/G8RDQQJSNggwmUkL8=
X-Google-Smtp-Source: ABdhPJwlbubgxeuDgASnmPC8a2FPnxZM7NG/BYBrNI7bca9JRkKuwn6Z7GGA1UMC7K1adhc/GF2OgQ==
X-Received: by 2002:a17:906:2dcb:: with SMTP id h11mr5964602eji.278.1617568514914;
        Sun, 04 Apr 2021 13:35:14 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-52-251-187.retail.telecomitalia.it. [79.52.251.187])
        by smtp.googlemail.com with ESMTPSA id s4sm7191140ejf.108.2021.04.04.13.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 13:35:14 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v14 6/9] drivers: thermal: tsens: Replace custom 8960 apis with generic apis
Date:   Sun,  4 Apr 2021 16:48:20 +0200
Message-Id: <20210404144823.31867-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210404144823.31867-1-ansuelsmth@gmail.com>
References: <20210404144823.31867-1-ansuelsmth@gmail.com>
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

