Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2831E3B0
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 01:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBRA5z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 19:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhBRA5j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 19:57:39 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6585AC06178B;
        Wed, 17 Feb 2021 16:56:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r21so762141wrr.9;
        Wed, 17 Feb 2021 16:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3t5HlpzfnVIy8I3rrp6+fJk3CMGQGpWhXkRko5P8Hg=;
        b=ARGevDrmISyN/6wbgm2Qw5+C15invQwK6Y1f/W6KdM8Ud8qLecsB9xir9nDFt6noT6
         p1i0aFiNG9GM7ddDT301dzgMCX6mmaNaf1ci5xob9f2nugVpMwvwPqxI1d/NHpXCd+dT
         vJHXHrLIk4Q+v4uo6mlsZX/YWPg0hN60pBCfJTL8g5pj6ObLrao+T1IJkVOBWI2Ghx5a
         7CfO48p5Tz2ljxqdGywWzao2m+8UBeWOsKkqimSs+y4obhAubTIW0D43zPj60pwPrTH/
         jrDUDkj+xtWfpjJI0Ykcdb1UtS39XxzB74SSHVZh+DR3GFMoitPA/EbjZA1F3nr/Op03
         GHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3t5HlpzfnVIy8I3rrp6+fJk3CMGQGpWhXkRko5P8Hg=;
        b=mzk5YGD/925oRJ4IgGzvJdaPt+u22PwF0YH1hLpvh1BI+39qbqm8XZm+/2z93CdP3v
         mUro0i/wKxjNGFmuFoIK0bLeTHAKfUUAEQFciqUfMUyE9tsZe+abPdjYcGEnavM3AoLZ
         XivnOHXtO8SzoK3FDqbMY59eipS2GiCskLDuy8dzDNPlzxqwyk9WWilJjMAKgGTFsI57
         H8PVis5DzfPhTA/TfTCClU+4lt94NEw5MSGlwocTtNN68XWMAhP6QQT9ilNgLLdZ1Z0q
         UJUKRxVsCkNCNhomXVisiPybYRdBef47D2XX3fXx2DIRz9O1lUkx6LlNo4G8/6j1Wi9t
         gXvQ==
X-Gm-Message-State: AOAM530ZCZu/H8bZoy6ujZzzPAy7KDGgA6LT1TQtgA3CuiFI8/OnhNlD
        ND98/fCB8i/8vFEC+/EfpVE=
X-Google-Smtp-Source: ABdhPJyc9ueA2iSTiPuxAYO82lcOzzjqPBPaoLWJxQfDVvWhyqqbT32ZTzaI2i4NvU4BHuVQX7qx1g==
X-Received: by 2002:adf:dd87:: with SMTP id x7mr1701765wrl.389.1613609789978;
        Wed, 17 Feb 2021 16:56:29 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-11-13-110.retail.telecomitalia.it. [87.11.13.110])
        by smtp.googlemail.com with ESMTPSA id t16sm6336079wrp.87.2021.02.17.16.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:56:29 -0800 (PST)
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
Subject: [PATCH v10 6/8] drivers: thermal: tsens: Use get_temp_common for msm8960
Date:   Wed, 17 Feb 2021 20:40:08 +0100
Message-Id: <20210217194011.22649-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217194011.22649-1-ansuelsmth@gmail.com>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
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
2.30.0

