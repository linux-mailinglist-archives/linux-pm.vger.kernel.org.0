Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C443F58E276
	for <lists+linux-pm@lfdr.de>; Wed, 10 Aug 2022 00:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiHIWFv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 18:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiHIWFK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 18:05:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05542BC22
        for <linux-pm@vger.kernel.org>; Tue,  9 Aug 2022 15:05:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v3so15833963wrp.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2022 15:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3LbT+i5JAOF13BKiDcy7sF/Ytx5HM8wW7yjSAT5yeTY=;
        b=cxtT92hK+noUuGFyDZmEbq2zUm+A2mKihLtpkMj83w4NhXc4OF2gtY0RwzaqjOObaz
         Wvjvab8q9fsrJ0Pa9HJ7wYon2fNcZDzBxfHAouIJspYTk3Z6nht5gcNidIvdWmUHItLt
         VPWR1N573S0UluAfKvguNUYag5i2zN3KW811cD156aBCZ64h3b2z2x0bNc1VFlQBvVOd
         jTvZqZLtI7fUKBbUZNcdo7qPho3lkM/KcsKsZI5zTQVD54ziIPxU/974TJBTQPB4lJqz
         ATWnN/guGvk5KPi3IqgD+FH2L4B4TMZxHLOV9ZmPRKlhjKnoHlAghRbwYrv3HcgZLcnp
         v/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3LbT+i5JAOF13BKiDcy7sF/Ytx5HM8wW7yjSAT5yeTY=;
        b=pTrXfyfOwILEqw1CA7VGLfcJarFLqu8n6SSFymj0uQJbSABGobIn3fgjZBZY78gsVO
         8xrUG3d9CgE+0PwAADoCgGDQZhVhpTvWaxWf02H4oALvOV28efGNZib8m2dhZr2amckf
         JSCzPMwP78zhcZdw5qHY1DkbgifbfkNkiHSIJHc35hGc+GGcWg7V3ejejCodIe7dcmAf
         quJsNlFtFTD77GikLq+DALMMQL3R6U9SSFB/sQIIpqtfszlOh/cDAV4dA7qdUJbJ9taD
         oVDJfloawSB3yGcKoMgJELEr/r/vX4Zgm8geXhwHaNh4/Kuz+u+xFeqYipcKEJFFXGV0
         5nOQ==
X-Gm-Message-State: ACgBeo2KqhgTKU7FU79rAgKChqCDKvW67ytwC/FNfL/Gkueaf/47sbOw
        zsoQMO4L/AUqDbItcVkq2buvDw==
X-Google-Smtp-Source: AA6agR5Cu6cdrOlw/RnQZUYMoANWaz5D83/mavePTngUcaGqLSHsiHAtOW3HoK/8j8EFCQ1yJzOrRA==
X-Received: by 2002:a5d:5a94:0:b0:221:6cec:2589 with SMTP id bp20-20020a5d5a94000000b002216cec2589mr13883414wrb.336.1660082707471;
        Tue, 09 Aug 2022 15:05:07 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v2 08/26] thermal/drivers/rcar: Use generic thermal_zone_get_trip() function
Date:   Wed, 10 Aug 2022 00:04:18 +0200
Message-Id: <20220809220436.711020-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rcar_thermal.c | 49 +++++-----------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 4df42d70d867..003457810072 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -278,52 +278,16 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 	return rcar_thermal_get_current_temp(priv, temp);
 }
 
-static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
-				      int trip, enum thermal_trip_type *type)
-{
-	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
-	struct device *dev = rcar_priv_to_dev(priv);
-
-	/* see rcar_thermal_get_temp() */
-	switch (trip) {
-	case 0: /* +90 <= temp */
-		*type = THERMAL_TRIP_CRITICAL;
-		break;
-	default:
-		dev_err(dev, "rcar driver trip error\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
-				      int trip, int *temp)
-{
-	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
-	struct device *dev = rcar_priv_to_dev(priv);
-
-	/* see rcar_thermal_get_temp() */
-	switch (trip) {
-	case 0: /* +90 <= temp */
-		*temp = MCELSIUS(90);
-		break;
-	default:
-		dev_err(dev, "rcar driver trip error\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
 	.get_temp	= rcar_thermal_get_temp,
 };
 
 static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
 	.get_temp	= rcar_thermal_get_temp,
-	.get_trip_type	= rcar_thermal_get_trip_type,
-	.get_trip_temp	= rcar_thermal_get_trip_temp,
+};
+
+static struct thermal_trip trips[] = {
+	{ .type = THERMAL_TRIP_CRITICAL, .temperature = 90000 }
 };
 
 /*
@@ -531,9 +495,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
 		} else {
-			priv->zone = thermal_zone_device_register(
-						"rcar_thermal",
-						1, 0, priv,
+			priv->zone = thermal_zone_device_register_with_trips(
+				"rcar_thermal", trips, ARRAY_SIZE(trips), 0, priv,
 						&rcar_thermal_zone_ops, NULL, 0,
 						idle);
 
-- 
2.34.1

