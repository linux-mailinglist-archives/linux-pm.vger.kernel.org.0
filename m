Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C35D31E3A6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 01:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBRA5I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 19:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhBRA5I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 19:57:08 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179A2C061788;
        Wed, 17 Feb 2021 16:56:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n8so749266wrm.10;
        Wed, 17 Feb 2021 16:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9D9ZDxx5CQzfMh6nhrt+ev1kEAC8uQU6h5aeibWAEG0=;
        b=HqTMIPMCDOLnpDtdgNrIoF4UTIf2/rTeLCsMKwPPTMsqw47k7ur4A8mXvNf58dBhIt
         aQt57HnTzsGO01qIsKpu8RFWAnCp9LLi/InhiP9bxmL/lwY0RjIwERkd4QLU44hFSAU5
         IvH6AsxESc8OCnu3uraDWsb7aI4iCasTXERk2re0kuApq+gupNnuHmCeyiwC9Pg9cJus
         sgLaQQUk0Cx2OY5tz+iBjd+97Iw8SrZy4/7jCEYuwZOriHsnh42ZiOnO8VLYV0RMl0lR
         8nb9dTAmDtq8BkWqSwOHcdvgsgLcAZEZTZ3xw1kkCXWhWq4dyKXnsdVcybl6ETVVIFaG
         v8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9D9ZDxx5CQzfMh6nhrt+ev1kEAC8uQU6h5aeibWAEG0=;
        b=cxbMutcst7HPuZjlGP8vjpQ9t6HJrhNNa44+98UawV+/IfHH8Akc7SsTh3BaTb8sEX
         gPRHNwbI2rY5eoM9nMHNs199UOcA28KTJDl0T0LhT411ZJh8REAkvLCyRqkPrgLIyy6F
         xs9wN2qcZ6/BmXAWao3LiezVyqi+FvB93qFWrF3C090VK7NXO3kJQV46D+d2TU13Tb2B
         XOeHRYogt8Nd9YODqAthgH/wTzs4e27LVucFQYRli90baXdswQo8decMuJ9UDuGDzZ/v
         soDPYymtui538fx3uMa4LmZgqwl9SOt4EkO7cm9dTH57YjX6kpWKCEKgG3TG4XmYtj72
         ahzw==
X-Gm-Message-State: AOAM531aqtu53Jd/1wO6qL93LjsrDJiyaa+Sx9UGjpkoL5E8soFNVD3Z
        rXf+bK7236j+ooJbY/ZiJXo=
X-Google-Smtp-Source: ABdhPJySpqAsmODd39/QFSr5sPTwK/YVsJHr2n0qStoFX/Cwypq2VANZ5N79n1PwldnB932+6a2FOA==
X-Received: by 2002:a5d:6a0b:: with SMTP id m11mr1709310wru.414.1613609785705;
        Wed, 17 Feb 2021 16:56:25 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-11-13-110.retail.telecomitalia.it. [87.11.13.110])
        by smtp.googlemail.com with ESMTPSA id t16sm6336079wrp.87.2021.02.17.16.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:56:25 -0800 (PST)
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
Subject: [PATCH v10 4/8] drivers: thermal: tsens: Use init_common for msm8960
Date:   Wed, 17 Feb 2021 20:40:06 +0100
Message-Id: <20210217194011.22649-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217194011.22649-1-ansuelsmth@gmail.com>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use init_common and drop custom init for msm8960.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 52 +------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 3f4fc1ffe679..86585f439985 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -173,56 +173,6 @@ static void disable_8960(struct tsens_priv *priv)
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
@@ -346,7 +296,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 };
 
 static const struct tsens_ops ops_8960 = {
-	.init		= init_8960,
+	.init		= init_common,
 	.calibrate	= calibrate_8960,
 	.get_temp	= get_temp_8960,
 	.enable		= enable_8960,
-- 
2.30.0

