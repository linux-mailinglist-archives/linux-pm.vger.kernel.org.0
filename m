Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF253539D6
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhDDUfU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhDDUfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:35:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA970C061788;
        Sun,  4 Apr 2021 13:35:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w3so14337866ejc.4;
        Sun, 04 Apr 2021 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDfaDBQwdj1r2Yr+BxzE8VnBhjB9D9cT/n8UjW/MV9w=;
        b=Aze1QDeonXwMNGhzRavTs7Eth2conRKTpO33XAZrCeDHOo7ayejcQ7Cvwr/wmvkv2a
         gvZn4KTuH/Mo+EJcsuHKNiYg7EP/reoW9ulVUBUPCy5nVR2HpQIeXSP7sH6nwHeo4FUZ
         WVsKbyVOQLJ2ukQHBACMcXr+IpXuG0Om/BMep+HVtJ4ALxw48IvRklgAxawAumz4uPYx
         KDi8wnDt/2Jg8rFuh/RTOgGlE7OLtwnGQCU7agK2eA62XApDTvfg2W1zXxv/es3Kr16y
         hnjRBaHV6lAmVUQmW+jOVjhv5mDURsvnJu2io67uzwOM7IShfSOiJTQmrMES771t1/zp
         n6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDfaDBQwdj1r2Yr+BxzE8VnBhjB9D9cT/n8UjW/MV9w=;
        b=XrqpofZJ8VTJhFeoPUIru2AbEhip/x9AYhokJxgmFNIgingd+eMAIDM6R8JXImQ+CX
         IWTur4eG+nJk4EWZPmkBc2zWyZD/jsFBodWYpyCiGFh/ufiJIbGy155dFhwCfCzh3qh5
         3iorHDLWArhWPBGURFUJ+ySRhAKaKazxfveKmzuBJATS7YZoxs6yKlLKTZLqtMdw+HI7
         k74mMCCTIg4Qdk8ZAVUay/ktPZwEBNKJZDhDuyGlHNSk8W6XBxSD/uwi8eihHXvJPXIs
         pXgM01242XD5a8x2d8pxGS7qjfScsthq7xjH8w6OnaOhVDonO9GQJzFq3j/1VbvXF4ZK
         TTLg==
X-Gm-Message-State: AOAM530fC8cXdNSxYIdooZ9Iq7HWpYC4iljuikY5/BiyEw/uEcBGJKai
        N2A6kELtN7h5XoFBnuIOHy8=
X-Google-Smtp-Source: ABdhPJw7a7eaH7hcklDqCOBU6qUiRGu42Eoj2Pptad1kLUo0DqoudmQ+L+fiNxvMZIgyYLUqwi/SFA==
X-Received: by 2002:a17:906:ce4e:: with SMTP id se14mr12246031ejb.54.1617568511454;
        Sun, 04 Apr 2021 13:35:11 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-52-251-187.retail.telecomitalia.it. [79.52.251.187])
        by smtp.googlemail.com with ESMTPSA id s4sm7191140ejf.108.2021.04.04.13.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 13:35:11 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v14 4/9] drivers: thermal: tsens: Use init_common for msm8960
Date:   Sun,  4 Apr 2021 16:48:18 +0200
Message-Id: <20210404144823.31867-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210404144823.31867-1-ansuelsmth@gmail.com>
References: <20210404144823.31867-1-ansuelsmth@gmail.com>
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

