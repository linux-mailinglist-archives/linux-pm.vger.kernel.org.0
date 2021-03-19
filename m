Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2F83411B2
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 01:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhCSAxJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 20:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhCSAw6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 20:52:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDFAC06174A;
        Thu, 18 Mar 2021 17:52:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a7so6900801ejs.3;
        Thu, 18 Mar 2021 17:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhzVjouXPgsngkD2GZKpxxvTDB5Ene+sCDfsYKC2JBI=;
        b=NzZcPSh51b9+sRYq73x32j9TceEZSFXi/283SA8vmfiB1XQ8hb6g1+z+Lzhm/gUw/W
         mqr1PuaQqDO8xISlP24Pc+tKkBU+0p30TKYX3SXSmuaAE7GwLflr6dj8z3JXKHrQVyv4
         tipGCupQAkCKimARwWz30lLIuneLOifcdiKkoTttmBPjBnjjm7b1o2uhEEk2k2Ag88Ff
         /BU41yoFU4feTmpW2r9NxH/C5+4g7PVKH3SgcYr67Uh2LU1rAWd0Fh4Vm4bczZURx7Vc
         TMiKdAL06Q7Oafcq9+l5qoZMnlyrNqQFn29QowZ91wnzgDxxxAe+9pDSzfKCIcHDmier
         zFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhzVjouXPgsngkD2GZKpxxvTDB5Ene+sCDfsYKC2JBI=;
        b=TZNR81eEWHu6lhA+ebf/SHPDBFBihCYByUDc8iwxqCWb2SsKJoYe/HdNTAkforGFg0
         BcBVD28Iz5rwvEkTXup8asl2hL6yanwNaqny2Skq/RuuQ60GxnrYzv3hJLNpEXqYPnnY
         DsdYyi+a3KU+DOAsfzHj/GmiIvVU+lJ5/SYgAXMdkatl/clcjPb2QYnkwMJjHTkV8rzO
         enzOsVCbQ2AWFWpSIWhWQVNEyCZFoIp3716fp+ZNiqMJy8Dpk5Lm4H/c9FB6ihs736ug
         Bmv5asbkRisnX1+EsEZp0Qd2IW8XS9R2Cc0fMmhHg3GXNi45n5sVtGnEQUJfNj0Arp3M
         Pjcg==
X-Gm-Message-State: AOAM530RTNrjoAII9+6p+xT3+0KCTnH9du36IprlX5LaWbexb90D0ag9
        wTotmsma350hsipl5ihLP+c=
X-Google-Smtp-Source: ABdhPJz6r6yrfxdQJchyPwB0gjXPqy0jyT+Kco8uiRg0Raw+xN+4XAzhH854nQeRACrgx4hN6gs97g==
X-Received: by 2002:a17:907:216d:: with SMTP id rl13mr1446115ejb.362.1616115176552;
        Thu, 18 Mar 2021 17:52:56 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-95-233-52-6.retail.telecomitalia.it. [95.233.52.6])
        by smtp.googlemail.com with ESMTPSA id q25sm3186976edt.51.2021.03.18.17.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:52:56 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 6/9] drivers: thermal: tsens: Replace custom 8960 apis with generic apis
Date:   Fri, 19 Mar 2021 01:52:24 +0100
Message-Id: <20210319005228.1250-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319005228.1250-1-ansuelsmth@gmail.com>
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
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
index bdc64d4188bf..8c523b764862 100644
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
@@ -195,9 +202,7 @@ static int calibrate_8960(struct tsens_priv *priv)
 {
 	int i;
 	char *data;
-
-	ssize_t num_read = priv->num_sensors;
-	struct tsens_sensor *s = priv->sensor;
+	u32 p1[11];
 
 	data = qfprom_read(priv->dev, "calib");
 	if (IS_ERR(data))
@@ -205,49 +210,18 @@ static int calibrate_8960(struct tsens_priv *priv)
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
@@ -316,7 +290,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
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

