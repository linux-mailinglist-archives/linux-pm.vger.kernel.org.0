Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6FC342456
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 19:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhCSSP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 14:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhCSSPf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 14:15:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC647C06174A;
        Fri, 19 Mar 2021 11:15:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e7so11806747edu.10;
        Fri, 19 Mar 2021 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eq+iLpwCPbGb9bO2at5MhiD5siCS/zbdkyhXYvfzlt0=;
        b=c4cl+QoUuc9tqWmQEZ8t2LCiVUrSbw9/JPvKsf590Ex1hAsB/nh9K4Uu3oUejzli/x
         U58uyiETikcGkk1nynXNqmJ7Ldh/Mqjck/o8bu4FBJloC3pNudeQglMGSa2keAM4UiY+
         0r+mOjfYR+V7XNIIzaZMXMUJxWBjDn8f+LY+SlPGxE9sxBNDZw1tHIJ4wA4dMwVuEi9x
         BRG84hyG4tZ9dJ9KEVzAlSlhH45LJuRiLjvqyMVajdjtbDRjJ7XaIc/lcFcePpAftwrJ
         PeJEqLncV4d1wJinEyCrPDtSTFSF0z8M6XFkQEBpCaYMpKtv14xuJBxwI3sujDSfFHN9
         ZjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eq+iLpwCPbGb9bO2at5MhiD5siCS/zbdkyhXYvfzlt0=;
        b=d6dZk84vb3XY12yG8Rv9ystTKTj+cVQEBE8aYx00lvM2oi4YaJbs0qvBAxo8l8oLkC
         Dd8e5/6IIKNB9Dr3K3cv5Vf3GpAqKqMy3991Nzh2bJB4in3SktRp89yYHESpZNp7hgPM
         HchqYMfzAoH3nrKLn8CAdXD4hngMMTZX15iykFJNB1jl4lNgVhftb95PnhD2InjgkShw
         X++iLzlwy3E/dXZxc5RdDzIDxy04HXQlwM0I28dNBzFRfXgD5fUzerfqW+PyrdvBlsT5
         MPBy84EFqoQMNHpvlabOV2oV05XBTqNjwFSaYqbErtOfJcG3v2m7yrk4f9WORDq1qx5v
         E6NQ==
X-Gm-Message-State: AOAM530vanjwCVZNagZjgYenClIjoT3hKQFOUicMSnNnRGdb/JCta3Uf
        Yk2kKZ1xvh25sUc0GslMhDJ0KeKvB5k=
X-Google-Smtp-Source: ABdhPJxiNypJu/LGe+5Te+3zZ7s86rCTl5xChDe2cnYIlvoqaa14MlfGUrtcyt2aKmJrFiA0MLCsQw==
X-Received: by 2002:a05:6402:2744:: with SMTP id z4mr11167717edd.347.1616177733350;
        Fri, 19 Mar 2021 11:15:33 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id u13sm4170288ejn.59.2021.03.19.11.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:15:33 -0700 (PDT)
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
Subject: [PATCH v12 6/9] drivers: thermal: tsens: Replace custom 8960 apis with generic apis
Date:   Fri, 19 Mar 2021 19:15:09 +0100
Message-Id: <20210319181512.7757-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319181512.7757-1-ansuelsmth@gmail.com>
References: <20210319181512.7757-1-ansuelsmth@gmail.com>
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
index bf8dfaf06428..b139075dd004 100644
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

