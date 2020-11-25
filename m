Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0F2C4D3D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 03:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbgKZCMc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 21:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbgKZCMc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 21:12:32 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16340C0613D4;
        Wed, 25 Nov 2020 18:12:32 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id y4so558858edy.5;
        Wed, 25 Nov 2020 18:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSqsyJR1uJjdUfbv6MslglDa94RlSlGvsXMc7VN4ajw=;
        b=hfRE7ombuJxM5u2HDsgC9CqyeDu7oP8SxLwQhGmR4icpgiMGVEqCxPHdB6jvz6TcFS
         Zu25VEQZyiRERrZtMJ4R3eYdDHo2alcbeuHtxcwqCcSvfNEkISjaoOfd09Tu73F+kdTq
         DwDXzcwjISt7pg9uVFp4wIW2Goym2RB/xYj/N7B45N5cYTiPSMqMLD5fYGuKvMlxD9El
         42AA77DnS3cvWaZFNs5bEkqn8hwr1XgsA0UhcNbLcmCxvP48iulafxjCcighQkbb50+S
         CSrJ0KySnCmBos+mVBWzDk2Zigv2BGSTRmf4jhUpXBg04cmqVy4FEuiAsEHVMwcwIY+d
         TDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSqsyJR1uJjdUfbv6MslglDa94RlSlGvsXMc7VN4ajw=;
        b=phlm6dzykgl4+6hB5jSt/HEpjcNLQKDZaLI4Y+3mow/xn702zLaL6vc2F2UT2uVL0s
         Ep4xC+ROWrktgPRa5lH4ybwEG/DaFx1gXSHyW8Ft+fMH3uxEra3gy/v5fZ/a+/gPfeoH
         oqPP6ozCoaPxG4chGVbLsfS/ujfoR+T5JSAvByVkJ6/iLgek+dO4oXsbugcaSKF4wSA3
         7usaj9T/JwBhaTSkOna1RL8sJqYeS0rIHvCfr4G1/uS7ebl7lKJt9Y+n3oxfA39ndjTa
         5aFQQUJ77SJpLQ/urqSIqzyoLBfYgNZIKoKmnoLPSPV+PWCI9nJhR6RruWrLLJyK/wX8
         nbBA==
X-Gm-Message-State: AOAM530BqQRTOVm/ga7sBy/My8mdcw+JukebcIhEuDNj9k7AMpNWem3B
        VW81Mn0c3VEYVX8T6joMhdLAUTNTF86QBg==
X-Google-Smtp-Source: ABdhPJyORc9i/wzDY1nieyUer9Ad9lDzMYPWeOrKJxHEm3+1NLpRWGiGhJLY0GwTZmoIXKcUN+cLew==
X-Received: by 2002:a50:a689:: with SMTP id e9mr477813edc.233.1606356750740;
        Wed, 25 Nov 2020 18:12:30 -0800 (PST)
Received: from ansuel-xps20.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id d7sm417276edv.17.2020.11.25.18.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 18:12:30 -0800 (PST)
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
Subject: [PATCH v7 4/8] drivers: thermal: tsens: Use init_common for msm8960
Date:   Wed, 25 Nov 2020 18:48:21 +0100
Message-Id: <20201125174826.24462-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125174826.24462-1-ansuelsmth@gmail.com>
References: <20201125174826.24462-1-ansuelsmth@gmail.com>
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
index e383dc545bf0..93d2c6c7d1bd 100644
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
@@ -341,7 +291,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 };
 
 static const struct tsens_ops ops_8960 = {
-	.init		= init_8960,
+	.init		= init_common,
 	.calibrate	= calibrate_8960,
 	.get_temp	= get_temp_8960,
 	.enable		= enable_8960,
-- 
2.29.2

