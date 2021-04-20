Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A939365F5A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhDTSeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDTSel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:34:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A19BC06138D;
        Tue, 20 Apr 2021 11:34:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id v6so58463875ejo.6;
        Tue, 20 Apr 2021 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XA8qh0Ts8DSpOtFxtfJGiJPMyRECQNMEtovD7z2ULCI=;
        b=eueUGv9gjMmz3FIx+YWHONGLzRdIU9n0A7H3FlKWIzo0zJ+8uLHJiT888ntzMSoHXL
         SVULNdA8lIaS/RoEwnJ/WVPhACVhF09prlvZRrIzrezs8HRs1m3TjpRWPls6DJtFrlt5
         YS7xT6ofk33OR9tJ6Rz7nP2tX3mh1p2EIui4CoF7qbA008N3wzDFC5orRyIGPukZS91P
         ItCXaEGVhBDLh0i7KXL5F9R8Ex0DU+3RWDXwiuG9XROvLYsMWLI5GLoOrWc/lQ72gWgg
         bIToz+K6x0d/bC4xmfKv2nZrZAv5sVVJEHCRCot9wVf1jnT/r1h5xAVD6Pyt+Bf5INL2
         mf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XA8qh0Ts8DSpOtFxtfJGiJPMyRECQNMEtovD7z2ULCI=;
        b=eoGOOaiXy3I6xsG5W6rn06PsSNh/GZhNup08Hpmr4KhhpD4igxle5IcNG6ez4CHUoN
         D7CvjEjMjtryNwthyb6MUyAIdHd/jajPzOIijqRnnuVDmpwCsIOOWQe0DPiDCTceayDd
         fHzjDXhaYgk0QhLEDqdwI5mPGV3+d7FvZ14MdecbOULzO1Lh4W79rBu4+eFTlIs8qYlc
         1zXIXTLrth7K1N9jyZykYynNuogPmoPQnyaLomPxB4v0GqSanxaiCU2d3EErWmKIuVyd
         JSsLUbM9WDYqnXnhVp3qjK12YWmgE9jnFGcu0J3TeVmPVQBji+hdykisxaDbWX6YenE0
         ey2w==
X-Gm-Message-State: AOAM530UPB218+HjtPcsEgpp5Q9zes+At4XC9H3ngcE7jrSl6qvhO/MB
        wfpoSXXmeeGJC48YdojqAAA=
X-Google-Smtp-Source: ABdhPJwqk1HHjXkR2Ys45K0VpyWvJXLmJx8P+wU6Pl0wWaXEwNextjSI4djt7vCLsp5FrhU7n3BFGw==
X-Received: by 2002:a17:907:270f:: with SMTP id w15mr29243774ejk.462.1618943646893;
        Tue, 20 Apr 2021 11:34:06 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id n10sm13357141ejg.124.2021.04.20.11.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:34:06 -0700 (PDT)
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
Subject: [thermal PATCH v15 4/9] drivers: thermal: tsens: Use init_common for msm8960
Date:   Tue, 20 Apr 2021 20:33:38 +0200
Message-Id: <20210420183343.2272-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183343.2272-1-ansuelsmth@gmail.com>
References: <20210420183343.2272-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use init_common and drop custom init for msm8960.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c | 52 +------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 0dd15e812..83746ee3f 100644
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
-			priv->sensor[i].status = S0_STATUS_OFF + 40;
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
@@ -338,7 +288,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 };
 
 static const struct tsens_ops ops_8960 = {
-	.init		= init_8960,
+	.init		= init_common,
 	.calibrate	= calibrate_8960,
 	.get_temp	= get_temp_8960,
 	.enable		= enable_8960,
-- 
2.30.2

