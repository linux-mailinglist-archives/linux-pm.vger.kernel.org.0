Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C686300735
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbhAVP13 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbhAVO6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:58:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6FC0617A7;
        Fri, 22 Jan 2021 06:56:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c12so5359726wrc.7;
        Fri, 22 Jan 2021 06:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bCUVYm5PTbXlWccEltwKHodbOdPVGehKn93HfL2DGM=;
        b=t7CvHMhH2VnX6/nw9MHOmL+jH7YzDjLWJxJEob8JyzUUfB0eRR3WfaO++FkmysERJC
         9omrrTyJmdDcan4VKHfMTDAEHo6QRjxnuMZSO1XVhUyylyUM97IWVCmi1X3vu/QvbKF7
         SqM49a5o0J2WWlhWBBvNvf3RCBlcu535dKstKTTqKkyh8qzUq59ON7Anhp/+LXYJx/EA
         vPqB3fiIamti06sq7X1gn9urgNYsvwgzaZPvETJuZ0Hf1cG8Y0iHQrVWORfn+5dWjrSW
         L117IcEy+EFFFdyZ464k0JDDZmx601tCjX9A9L9Lh7PIWuQZ49cN/bmPafNFCuJji4De
         Iryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bCUVYm5PTbXlWccEltwKHodbOdPVGehKn93HfL2DGM=;
        b=r7paTqIdik6VEeTxsEyKQjT4ug23FbtJVAT3YTALX7XNmfb070BVz8kZ6s2VSP6T1G
         n+XZlDmm/1KIyMUMpDLbib4+E8s6zLB/NuytH8WY9n94XJcnlgHImC9oqevHkOxOQE8R
         wwDYsv4aYjxj6GMMWhFd0rBLc/XpV+bhHU6Q6fFIrfzovkQ4R4PVTsmVeKSL+asBK85x
         oGOqpwQWRY65jEL0oQp7qOsbEMcqSdDKzgnapTtMduVxKiOaEjzYyZUECF3kmz0NgJZX
         7MpnmGZJe6GSskF5yywNQsx2JneiohAf/WzgVM3OcC0TmWkdoeYn9D8/FNuP0KgxYrmM
         QjJQ==
X-Gm-Message-State: AOAM533Pjl2sHhR4i6SgCYI1Aey1IGmluc7LBACbzUYxrJelBsXc+bMq
        ofUprc2sQssCOTpS/LnBqyg=
X-Google-Smtp-Source: ABdhPJwZKXjVgEPuYTX3Ov3t+V9Rekl3EjhYmDqvz4Cyk937lWhvMTlS1jZi1KCMEwZ/KZJh+/Ke1A==
X-Received: by 2002:adf:81e4:: with SMTP id 91mr5012620wra.161.1611327377679;
        Fri, 22 Jan 2021 06:56:17 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-45-3-77.retail.telecomitalia.it. [79.45.3.77])
        by smtp.googlemail.com with ESMTPSA id t67sm12061106wmt.28.2021.01.22.06.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:56:17 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/8] drivers: thermal: tsens: Use get_temp_common for msm8960
Date:   Fri, 22 Jan 2021 15:55:55 +0100
Message-Id: <20210122145558.4982-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122145558.4982-1-ansuelsmth@gmail.com>
References: <20210122145558.4982-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rework calibrate function to use common function. Derive the offset from
a missing hardcoded slope table and the data from the nvmem calib
efuses.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 56 +++++++++----------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 248aaa65b5b0..43ebe4d54672 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -67,6 +67,13 @@
 #define S9_STATUS_OFF		0x3674
 #define S10_STATUS_OFF		0x3678
 
+/* Original slope - 200 to compensate mC to C inaccuracy */
+u32 tsens_msm8960_slope[] = {
+			976, 976, 954, 976,
+			911, 932, 932, 999,
+			932, 999, 932
+			};
+
 static int suspend_8960(struct tsens_priv *priv)
 {
 	int ret;
@@ -192,9 +199,7 @@ static int calibrate_8960(struct tsens_priv *priv)
 {
 	int i;
 	char *data;
-
-	ssize_t num_read = priv->num_sensors;
-	struct tsens_sensor *s = priv->sensor;
+	u32 p1[11];
 
 	data = qfprom_read(priv->dev, "calib");
 	if (IS_ERR(data))
@@ -202,49 +207,18 @@ static int calibrate_8960(struct tsens_priv *priv)
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
@@ -313,7 +287,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 static const struct tsens_ops ops_8960 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8960,
-	.get_temp	= get_temp_8960,
+	.get_temp	= get_temp_common,
 	.enable		= enable_8960,
 	.disable	= disable_8960,
 	.suspend	= suspend_8960,
-- 
2.29.2

