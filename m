Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2097322D943
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jul 2020 20:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgGYSOb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jul 2020 14:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGYSOa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2020 14:14:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB4BC08C5C0;
        Sat, 25 Jul 2020 11:14:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so13115585ejb.4;
        Sat, 25 Jul 2020 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhL2ioQIyPmFYhRRN/DKPxOYM1ALuRsGRrOJAhQkVrE=;
        b=e0IQ1pjuEg1zTqkgGtQJfR/mdnIngVwRSZnGYF4xSJYuBQdiuC5hiN1TwsnzsyisNz
         RlqfavEOpzhtVAha9VUxPEhCX83632JjUv8udKTz/W/yrTqw3EJ/ud7RE2zqeKOThRQJ
         O4cz9mZ3cCsk4NLeeNecDdqGcNFoZ/0WThXP9M+dYI1C1gJG+XYzD8zfLGEpW9v3JyRm
         vOj7PnRTfnGX0fBUlPuO0qB527joFGTOgDy+xR5K2DO2BlfUC+lcfQRjw7nHLgCCvpDp
         Pi8lF31an5EacmyEaa6NX2tfoQBgmOFFUtmk0FBBnAt7VeAG6uNuGOsEsO432maxW66m
         J8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhL2ioQIyPmFYhRRN/DKPxOYM1ALuRsGRrOJAhQkVrE=;
        b=O22Q9shtRgnkbdEeHOQc7kE56/0D7Y8Qx3cxSY9Tmt4OKXY0pAJDYq1hpWw0TRN7xF
         dnaYF/0Yt6h/KyRinX7qCb1M2ZK14UA53GOuFGRo5OBgC0haSjn2Y+g8cDOliEUE9dX0
         SQKGXH89sJgbOfbZV2uBibXbchJ5VyB3Y2mnpFiRYTkQf0YveTNXFs6SayawFQHADZdu
         ahXA/LppqugoRTpDjr9Je6GtypUMcX98G7IRkTRFrKwtYaNDsi7U8kwlMyILeZsVKGuB
         1H6y/G/1CcFhlZKOe7r1oub7Ku8H7Ay5PXCtq4Js6foJWPH1MGRPVXd1bh8CNuQrdR6Q
         rv1w==
X-Gm-Message-State: AOAM532s/HKdl/l72ov4Yk0Hq1Tw8YkezOmKVeyxwFVj6rGh0kHOjXvh
        I9tAqw68Lsq4P/n9igO1et4=
X-Google-Smtp-Source: ABdhPJzVhmEvJsfDRjI1JtjzVrr/zW5g+DznU9s+eM3iipMXt2aDvzRGS8IkwmUAUmEo5MSP+QUNYw==
X-Received: by 2002:a17:906:80d3:: with SMTP id a19mr14985457ejx.217.1595700868966;
        Sat, 25 Jul 2020 11:14:28 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-22-5-125.retail.telecomitalia.it. [79.22.5.125])
        by smtp.googlemail.com with ESMTPSA id qn10sm220922ejb.39.2020.07.25.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:14:28 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 3/7] drivers: thermal: tsens: Use init_common for msm8960
Date:   Sat, 25 Jul 2020 20:13:59 +0200
Message-Id: <20200725181404.18951-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200725181404.18951-1-ansuelsmth@gmail.com>
References: <20200725181404.18951-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use init_common and drop custom init for msm8960.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 53 +------------------------------
 1 file changed, 1 insertion(+), 52 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 45cd0cdff2f5..d545cf9888fd 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -51,7 +51,6 @@
 #define MIN_LIMIT_TH		0x0
 #define MAX_LIMIT_TH		0xff
 
-#define S0_STATUS_ADDR		0x3628
 #define INT_STATUS_ADDR		0x363c
 #define TRDY_MASK		BIT(7)
 #define TIMEOUT_US		100
@@ -174,56 +173,6 @@ static void disable_8960(struct tsens_priv *priv)
 	regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
 }
 
-static int init_8960(struct tsens_priv *priv)
-{
-	int ret, i;
-	u32 reg_cntl;
-
-	priv->tm_map = dev_get_regmap(priv->dev, NULL);
-	if (!priv->tm_map)
-		return -ENODEV;
-
-	/*
-	 * The status registers for each sensor are discontiguous
-	 * because some SoCs have 5 sensors while others have more
-	 * but the control registers stay in the same place, i.e
-	 * directly after the first 5 status registers.
-	 */
-	for (i = 0; i < priv->num_sensors; i++) {
-		if (i >= 5)
-			priv->sensor[i].status = S0_STATUS_ADDR + 40;
-		priv->sensor[i].status += i * 4;
-	}
-
-	reg_cntl = SW_RST;
-	ret = regmap_update_bits(priv->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
-	if (ret)
-		return ret;
-
-	if (priv->num_sensors > 1) {
-		reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
-		reg_cntl &= ~SW_RST;
-		ret = regmap_update_bits(priv->tm_map, CONFIG_ADDR,
-					 CONFIG_MASK, CONFIG);
-	} else {
-		reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
-		reg_cntl &= ~CONFIG_MASK_8660;
-		reg_cntl |= CONFIG_8660 << CONFIG_SHIFT_8660;
-	}
-
-	reg_cntl |= GENMASK(priv->num_sensors - 1, 0) << SENSOR0_SHIFT;
-	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
-	if (ret)
-		return ret;
-
-	reg_cntl |= EN;
-	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int calibrate_8960(struct tsens_priv *priv)
 {
 	int i;
@@ -342,7 +291,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 };
 
 static const struct tsens_ops ops_8960 = {
-	.init		= init_8960,
+	.init		= init_common,
 	.calibrate	= calibrate_8960,
 	.get_temp	= get_temp_8960,
 	.enable		= enable_8960,
-- 
2.27.0

