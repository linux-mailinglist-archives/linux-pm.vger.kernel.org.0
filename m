Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C522FF425
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 20:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbhAUTSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 14:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbhAUTSG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 14:18:06 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819BEC0617A7;
        Thu, 21 Jan 2021 11:17:11 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y205so2101981pfc.5;
        Thu, 21 Jan 2021 11:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bCUVYm5PTbXlWccEltwKHodbOdPVGehKn93HfL2DGM=;
        b=dIwoVnESU5Rx+/2SD908/EvsLyfO6j9QDOu1khYe/SoP9JuwImQr53/StGNnDBhKjh
         ISPxsI8TN4E2jQAq91haWROqWgKAQkH6KA7OyjFv4Wfgr1KDi95wqmHeRn09MiOpQGin
         uvhQZ5V7a/x5e4u2rcwYfBlPIj2J1EZWDpNZKs6NgbywANMG0rM+w1y6X6r4wFk/ZJ9I
         swx8K3jOmLxZdiw9766tJGeWswlSMj1iO37HN5lnvc2d7wjg87KoLdtEgmheLktS7SF6
         w/3wT31ZpGpOQhD8VWpBDbELxbkVFNpHNm2AGoCNF4NjXt3XoQHW9q+fhcCFTERV2eK8
         oXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bCUVYm5PTbXlWccEltwKHodbOdPVGehKn93HfL2DGM=;
        b=i5aF+p42u0RIDZoVm6EFGRYaq8PoNTHIqogVzNfPiqo4rahA+iMp/G3nogLuXGwO8q
         nXP9nRaHlwg1IAZsbZm8lM3pB9IR+ji0jmobqSvDjd4rZSURFnAwwizokfwELl8YfJXx
         MS8vYEgyqirifV5qNPBbZzkOcKjllYdQ7JuCF5WvgvWfX9JpCaT3/0ZtUE8GO207MzTd
         lt0xZiH54mU73n0xuccPNDVBMFEzh0kg4eqmljsgYRJnIrVHCbTMSIl0wWFjZbN4rFM0
         JTawZloIxuTOW0ZcJsvHXt9RA08nqgxhnqDiYlqHQdds9Zzo+t+rfIDaGlYRu6+x453K
         k78w==
X-Gm-Message-State: AOAM531dSbWHTyHx+nYtL3ht9tj9gPojKl8lDz1FTHxc4xV2/CpA2MFM
        Fm1r/LCpohMO8gCzSYeDwMk=
X-Google-Smtp-Source: ABdhPJyuFjgXz+YzNsvaxQkREdbWGWptT2114jjZD14FftTHMx31mOG42iXJ8ALyu304Hvi4c7b95A==
X-Received: by 2002:a63:cd08:: with SMTP id i8mr728701pgg.425.1611256631036;
        Thu, 21 Jan 2021 11:17:11 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-41-39-5.retail.telecomitalia.it. [79.41.39.5])
        by smtp.googlemail.com with ESMTPSA id gg6sm11291013pjb.2.2021.01.21.11.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:17:10 -0800 (PST)
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
Subject: [PATCH v8 6/8] drivers: thermal: tsens: Use get_temp_common for msm8960
Date:   Thu, 21 Jan 2021 20:15:58 +0100
Message-Id: <20210121191601.14403-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121191601.14403-1-ansuelsmth@gmail.com>
References: <20210121191601.14403-1-ansuelsmth@gmail.com>
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

