Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D19244AD7
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 15:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgHNNmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgHNNmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 09:42:18 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB19C061385;
        Fri, 14 Aug 2020 06:42:17 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w17so6832536edt.8;
        Fri, 14 Aug 2020 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3u8FPkwBGURpUG4O0zZuD07e039HFT1NOBLzc7aW0Q=;
        b=XT7UNxnptaTC/K8xFgYOZWfHk+VNHPEYxDwcltkdNAbm9yPW2vbNsN720H1e4lyTT5
         tgkmWc5luW0PuFYYCknIEFVYZ9DVo+BkCaaDzJFuXAq6qBKPj9mSzlrNcG0t2nNWXCIw
         pQpfWe2vY/tdar2GIwtBNI4udSjN48rpxNL0im8w1PcHl4zvZj/Dslf4gJsNKQDVxe1X
         0qNSNfSWdLF2L6YWo5yl3AW8qzNzojxCL1ez9CAn9X46NuAlkp/0C24nzXyhuZI0zv19
         N5vr0SladiuWqgIKKl3PCZIUZr2RLJfNjxLVRfWDQt8DKMwrpcz+I+WZrxXhymvvl/AV
         gw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3u8FPkwBGURpUG4O0zZuD07e039HFT1NOBLzc7aW0Q=;
        b=OV1zlFQV0QxJlSv+/oWj6KdOFCD6DkrtO7uBQ6UApW5OnKnwam78XWwPGieZVS1NpL
         R7UidkRKQNSrlV6rAPKa7yXttwpDc8XaF8uUMehdYFsk3jWWF0RrNdhi7k08DYazjlfP
         5wF/eeqIsr40CxSD/vdaL0mdH0af43CeQV1cstfOdCvQx5D2UQEsoNUDCZ4Oe7Cz206u
         5aXwZTJHO4dIiMLqnDMCer9BcIi97jgZBNAV84JiA0EjzSREGl+VgHjeVTrx/K/m8JBY
         ciCfJGnocq++h8jqEd5YZ5uX6oABRlHJVzzUYU7ZDcAaD3Lm22sgkkkTbwzegTEVzFZc
         R1hg==
X-Gm-Message-State: AOAM530e2zdCRk/IjT+cqn+SsZd0uPdcsnRzbcoCyNMbTAPkrf/3H6Y3
        NJbHLW6t3leJly2gbxKuRfA=
X-Google-Smtp-Source: ABdhPJzCxN+M3JUOZzxAWCy1ld3QQQoeWBPnLMKHQeg8te0L31GcGdbv44028s3dAt97Yy2/KJYKBw==
X-Received: by 2002:a50:d74b:: with SMTP id i11mr2406394edj.136.1597412536669;
        Fri, 14 Aug 2020 06:42:16 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-0-192-118.retail.telecomitalia.it. [87.0.192.118])
        by smtp.googlemail.com with ESMTPSA id s2sm6767118ejd.17.2020.08.14.06.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:42:16 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 4/8] drivers: thermal: tsens: Use init_common for msm8960
Date:   Fri, 14 Aug 2020 15:41:18 +0200
Message-Id: <20200814134123.14566-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814134123.14566-1-ansuelsmth@gmail.com>
References: <20200814134123.14566-1-ansuelsmth@gmail.com>
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
index cb3611299e8f..93d2c6c7d1bd 100644
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

