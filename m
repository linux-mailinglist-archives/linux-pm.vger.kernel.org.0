Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91C8672B40
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 23:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjARW02 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 17:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjARW00 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 17:26:26 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B25E63081
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 14:26:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r30so77828wrr.10
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZiyYIQERyoQDZx5EhXQDAi77/yaNBI4sXFn9DiwCNs=;
        b=YPYqlz+xHhe24OpPAn+LNnN3Koe8wjxIjSvVz5I/7Jjr25c0z3FTjYXb5q6WFGBbtb
         VUUWXDa96j9cU/FWN2b41d2kv8+vPjvlHRJ4M7QmaAoH8VwUzl8/+NeECrYGDTjhfn8O
         KKJXsGQNonRZNVyWUSS35cC3DHPKupzIYZGZLznBjJutXq9ncBOAfnZq2kf+u15yBwb8
         b9BzEBisLqVElsrhI2Q9/Ik7g+KDgW4v8/DzLkzl6UStl78+ofqQ5Dz4ryT/eEAW7Ves
         kJR9yNfZ0kaSkFPL1C99I2XhydDZwlyJH3Lst2Kl+S7pEQuNzPuxCLeRaN9CmEOtpOVw
         wp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZiyYIQERyoQDZx5EhXQDAi77/yaNBI4sXFn9DiwCNs=;
        b=1RE18vul6JqKdCGJqvsrzk3Cu/UghT/vx0J9waWeP2WvfyOL25pWTro+Ux2KXBcBnl
         AyGBBGsCW3QgGImNBuyeDaduJdAgrxASUgVz2s+8scLVEjoBMUPkzv+MR/fmM/pL5Rff
         FpQJLwGnX3XVBwZdX2QYDEaJ7JUy90O3sZQ4aI+KT/3xiyUI6Y8Bx+p7B2lTFIela0al
         VVMgaMx4qxO7+I2XtaeTlg8vQHlAolzs7RPDV4vW/0OgiUqOFFTcx33C9cdKYVLOQlRt
         TgA9dnKY2VQ68ZFUD2uxtxpUR6pBnFL+wpzY+AavbBk9TkNaDh4yDe1rlsdPcO9T/BO9
         e+4g==
X-Gm-Message-State: AFqh2kpOADUzWlKdZRBaes/55Cs9xCzn+/lzeq4bm2qRDQ/2eCbd04RW
        5KMiM3rETAJyIB+psPJJKsGCpQ==
X-Google-Smtp-Source: AMrXdXtcjUpeIxxnEUDjtsSxM6s+gch9zqzPnXBZ0708WwUezrD/yB8TVQbkMm1cx8av67Q/ZUMenA==
X-Received: by 2002:a5d:66c6:0:b0:2bd:d966:7fff with SMTP id k6-20020a5d66c6000000b002bdd9667fffmr8331359wrw.20.1674080782807;
        Wed, 18 Jan 2023 14:26:22 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d62c7000000b002bbeda3809csm26353554wrv.11.2023.01.18.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 14:26:22 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/drivers/armada: Use the thermal_zone_get_crit_temp()
Date:   Wed, 18 Jan 2023 23:26:10 +0100
Message-Id: <20230118222610.186088-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver browses the trip point to find out the critical trip
temperature. However the function thermal_zone_get_crit_temp() does
already that, so the routine is pointless in the driver.

Use thermal_zone_get_crit_temp() instead of inspecting all the trip
points.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/armada_thermal.c | 38 +++++++++++++-------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index db040dbdaa0a..c6d51d8acbf0 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -784,34 +784,26 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 					 int sensor_id)
 {
 	/* Retrieve the critical trip point to enable the overheat interrupt */
-	struct thermal_trip trip;
+	int temperature;
 	int ret;
-	int i;
-
-	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
-
-		ret = thermal_zone_get_trip(tz, i, &trip);
-		if (ret)
-			return ret;
-
-		if (trip.type != THERMAL_TRIP_CRITICAL)
-			continue;
-
-		ret = armada_select_channel(priv, sensor_id);
-		if (ret)
-			return ret;
 
-		armada_set_overheat_thresholds(priv, trip.temperature,
-					       trip.hysteresis);
-		priv->overheat_sensor = tz;
-		priv->interrupt_source = sensor_id;
+	ret = thermal_zone_get_crit_temp(tz, &temperature);
+	if (ret)
+		return ret;
 
-		armada_enable_overheat_interrupt(priv);
+	ret = armada_select_channel(priv, sensor_id);
+	if (ret)
+		return ret;
 
-		return 0;
-	}
+	/*
+	 * A critical temperature does not have a hysteresis
+	 */
+	armada_set_overheat_thresholds(priv, temperature, 0);
+	priv->overheat_sensor = tz;
+	priv->interrupt_source = sensor_id;
+	armada_enable_overheat_interrupt(priv);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int armada_thermal_probe(struct platform_device *pdev)
-- 
2.34.1

