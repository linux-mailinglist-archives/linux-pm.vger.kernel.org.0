Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956EE3483F7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 22:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhCXVoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 17:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhCXVoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 17:44:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10E6C06174A;
        Wed, 24 Mar 2021 14:44:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ce10so35337093ejb.6;
        Wed, 24 Mar 2021 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDfaDBQwdj1r2Yr+BxzE8VnBhjB9D9cT/n8UjW/MV9w=;
        b=vUXsXDLLIPz+dHxIs1qyHqah5P5b6zDER3POEv9knK5+lCfGyLOvAnuGO7Fotqpkjf
         URaWkj1nIB04yBouJXBa5QBOKhLB+bQw84WRg3zMOfpbiTy8r42/ZBGT9i3S+6IkLH5U
         r5wLQCOJjFOPXFUhDQH+xkl/YcaZ86TUXBUmFUHdVUPTw6Fnyhh5mbTyQH/ClATgW2GR
         6LrkZvX8pOTDgMWn0xyHZrQJfPpvVSyFgaBHqRuqaxFenKWgwsrV24hLJR6lP6U9/X5c
         ATLEJLSgGHFRy1J5qLqkfe3S9tJaShuIJdmUKRyibhgXuVk83JUs6kg2kaQT8rDPR3tO
         erkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDfaDBQwdj1r2Yr+BxzE8VnBhjB9D9cT/n8UjW/MV9w=;
        b=PoF52dT8WqPToxZzSNVLqBzSn9khic67AkYkTBvaxeY4aZl2Y6zvlKqz6dR0rsH7Px
         Nb1Mrr0/qmNu8pR9cBD+lP/QLePRQNgcOfjsIfq9mXbATkuBMqjImWyjfQ3Xn3LuJSpT
         w2357k32Fky+kMv1+GvmsxtsQQw+y63rZFbQEe79N7R0E3mkYeFiWuq3a6kiyku6zBVF
         +yw8txlmR9reWndaIV/t2Q2Glt3PqJokBI5YnaZnSR1B0FPMprjITiOr5l2TRAt8xeI3
         ZYL8OuR38deEWZ09P0LLJw82CUTa9gcCcG/DpA/k6KBuB7WhYXES+djP8TYnETfjYw6D
         Og/w==
X-Gm-Message-State: AOAM530dYbvS6VqOvANH4yREdwfXf8ST73/HKep9eKRwdJZkz4LWsqEu
        zbN9yLoe0GMqJ4P5dt6RCnU=
X-Google-Smtp-Source: ABdhPJwY7GWFxpCGZwvWuF/yUS/E1vr2fJcgOqVNypr/NxEg+g1LyDTWJME5qMHrDPSrt0yl4Wz6dQ==
X-Received: by 2002:a17:906:7842:: with SMTP id p2mr6204945ejm.87.1616622254196;
        Wed, 24 Mar 2021 14:44:14 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id z9sm1871211edr.75.2021.03.24.14.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:44:13 -0700 (PDT)
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
Subject: [PATCH v13 4/9] drivers: thermal: tsens: Use init_common for msm8960
Date:   Wed, 24 Mar 2021 22:43:58 +0100
Message-Id: <20210324214404.798-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324214404.798-1-ansuelsmth@gmail.com>
References: <20210324214404.798-1-ansuelsmth@gmail.com>
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

