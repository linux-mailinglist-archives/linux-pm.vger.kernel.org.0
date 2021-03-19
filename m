Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5B934244D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 19:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhCSSP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCSSPb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 14:15:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066FDC06174A;
        Fri, 19 Mar 2021 11:15:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t18so11177555ejc.13;
        Fri, 19 Mar 2021 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDfaDBQwdj1r2Yr+BxzE8VnBhjB9D9cT/n8UjW/MV9w=;
        b=d2poE0pR4HjnNZMzGKy7S/uFg/SDDmk2hFzVHHrPkZR4YVUqQxVL19gi9nxaIyvZvW
         SiZy/qgKS3dY3OmfIcWw8BctCK+72zXo1lYoefQRYlfV5shubnrLAEZSdze7drg4yfUe
         gvsIOTT4xXdxUdY19xYanDEZVneJloc/Fsq9NBOpf9Ny2ih3W1+LybwNY1x/kWmca87n
         Ethi1VN8husiYu8iCGN0fPElBTgA2ckzcHoGLoWLvdISwgIcmmMme2wN8lxIKhmbqy86
         skIOfGFVXIz4Odilw0lUmFsQh7pHYB562B+6Yn0KpPsBC6KwCirPNGR7z/m1F7GU7IFI
         owSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDfaDBQwdj1r2Yr+BxzE8VnBhjB9D9cT/n8UjW/MV9w=;
        b=rg/QO1wQz+zPMmok4/aA5MKKLLm64P1TwR3He0uk9l3+Gb8jYyEcHexjrSocuEAv72
         WRHDLRIXmNB/JRaIuyIuhG8Iif8uRzLzNGk0ndiAfFhWtEW7S1L3bInQTMPmyV75E6tj
         X/m9YYiiQCG2B2EUt7utSbVOCC34FlbncWrURLA8MSqFMEcVJEBMs0LW5W0FZqfPheXP
         TqpriCmM7FfKF1mOp2aFv6DfmbyCl9SV2OR8ACfrkbtQO8zBRy5ueAkOtri0KSTN+fzM
         5+yxayumdW+lE2hPZ5LCxDs1eGY8Q9/EpmtwKpm4vGyhJtFwOfimPWtP4MSStBGaT2AX
         OGnw==
X-Gm-Message-State: AOAM5311Bx6HfctapxyhzsXrSKPoi8z7GNpXOrhbn2mtFHQlqRau5E4X
        oGUgp+qPseil7dktbmaLDBE=
X-Google-Smtp-Source: ABdhPJzjXbK6V9cy650T1OYnwLq1B5TSvB2LkgHHNpXYkEbQaPaSwP4hYDzSFWz/b2e9VYYuUFrdgQ==
X-Received: by 2002:a17:906:3b41:: with SMTP id h1mr5647867ejf.506.1616177729629;
        Fri, 19 Mar 2021 11:15:29 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id u13sm4170288ejn.59.2021.03.19.11.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:15:29 -0700 (PDT)
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
Subject: [PATCH v12 4/9] drivers: thermal: tsens: Use init_common for msm8960
Date:   Fri, 19 Mar 2021 19:15:07 +0100
Message-Id: <20210319181512.7757-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319181512.7757-1-ansuelsmth@gmail.com>
References: <20210319181512.7757-1-ansuelsmth@gmail.com>
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
2.30.2

