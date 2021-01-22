Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7924D30078D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbhAVPkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbhAVO5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:57:15 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C2C061794;
        Fri, 22 Jan 2021 06:56:14 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c12so5359508wrc.7;
        Fri, 22 Jan 2021 06:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yP+8b8XvGsdxgGgAFZqhFaVyr9bwBdl4LtN4K2NEQ40=;
        b=f05PEk0c5HWVGdKSSzSm7fRbXgjAkneXwjqBtUS5hRazeOkj213OlHBdTdCNgb8rtQ
         4dQerMKq2A6Nx64Mgcbuxu19WKl1PO1rOEexAzAPu6XP8ydbzoMtzcI9P9DUzp2vx2rv
         DU/GiDVDZQfWVbXZpY1onv/FISZdzrmy20jPs0c9t4Ye1t1N1Xk+11tPXSR9x3JonRzL
         yplshh0tIe5322XtY886fDVEcONrmlHsLC7jjydMgISIOxRWUKIPKovqv2nv9LVWn2FD
         DZO+hliwSWBSRLmkQ70ufzS752M7FV9qNCdLqawShFIYUKFT9osF/ThzkWC+a41k6yfV
         +hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yP+8b8XvGsdxgGgAFZqhFaVyr9bwBdl4LtN4K2NEQ40=;
        b=QMnB1q96/8fHGo7N7zPa4aLZolQkd34kBHiiLW8+raINkDVsdE9/N5uoWw2U3h85Od
         ldqdnkvw+afIaursecjYe1HD4SDzy9eLfIIjhi7WRoGYiKRYS6XHUZlcYRc4TWIqvBAy
         FHM4hxDBFDhQDu/0TVW11rUs6DPZIQo3c0b3efxv1ZpGVDkH3eXwbgcmgO1MiY9n3/9b
         0qtQ26UxRp9xYB9jnBXSn2eibiK827IcFrxwMzk83DGnVyiePV/bWPn+BK40lIXcDYcI
         vP0SGUQDJae45fvfJXaQbWKNQOwVaiyYwCeVKlbnoDV+rmr3IkjhMXg54TNxXQ2pcM8C
         FqLQ==
X-Gm-Message-State: AOAM533V7wd6mie5GVVYNI8N5t/F+rVdxXKqpb2bBzS8xjNC8W12lfp3
        K/NnCiybuDh/3BhqkNhhfqA=
X-Google-Smtp-Source: ABdhPJyRqwyuJ3LS7JNe80cWqU1vQj4b6II8iiTduSfOwyhpUHvZsTxfwYg3SMgpR1SNbwV73LD51Q==
X-Received: by 2002:adf:9e04:: with SMTP id u4mr4913396wre.362.1611327373669;
        Fri, 22 Jan 2021 06:56:13 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-45-3-77.retail.telecomitalia.it. [79.45.3.77])
        by smtp.googlemail.com with ESMTPSA id t67sm12061106wmt.28.2021.01.22.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:56:13 -0800 (PST)
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
Subject: [PATCH v9 4/8] drivers: thermal: tsens: Use init_common for msm8960
Date:   Fri, 22 Jan 2021 15:55:53 +0100
Message-Id: <20210122145558.4982-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122145558.4982-1-ansuelsmth@gmail.com>
References: <20210122145558.4982-1-ansuelsmth@gmail.com>
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
2.29.2

