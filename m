Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F158ACA3
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 16:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbiHEO6F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240995AbiHEO5v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 10:57:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B238461D54
        for <linux-pm@vger.kernel.org>; Fri,  5 Aug 2022 07:57:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l22so3539256wrz.7
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2022 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ArVwRUUAruWAOrQZrGLPNrMDc/juTBJqw8A6bHO0IRc=;
        b=svz2u3WR78WYhhyAR/zyX7pyBfht1GKnAbOAU6/XcwL0S6ANFKgRQp4vFUwJQVUoFb
         LX2p2ZwR6WavpukNsEOP/ZxUoi2Bbi8I5BkK3OZ06jC5DoOM0fZIKTaiW6cifdSyoK7z
         T7Vky7X516qWF/Ls6OkrjsYDIjSJVEdpgrgZOho15rpHwcz651X8yzK0bItq9K6LqOYs
         VVOYp0JsxHxvgGKxmG6Ink9Pg5cdeGocyFiZIrGVKFfC0UIGJZo7hmb+JiImB/0/Jthy
         UTIA2P2e22QQJbmc6bsB/xDaakW8dAkLuZjB7S4Z6dtfZ3g1ODetr/SmtifkXvAaJLTm
         cTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ArVwRUUAruWAOrQZrGLPNrMDc/juTBJqw8A6bHO0IRc=;
        b=v8aoX4PJnoGGMk6iP91gY8wvQYmWiNuWUfDOzLG0HH4YEOM36PHo5JrtVN+Gt4VBDb
         h0xEaXyLPvSZ38askwRUAqCieZOU1CCi0DGh7yp4JRXI+69woxzB/AYOkvFvmHjC8+kS
         1YyKp9EJ3ymJLCAx4N1xRN5d7/Eerwkqrjp+iZ/UbvF49FtIJoWyPngYOPRIRDySarQV
         AxaaKhoegKg45bS2xI5aYsrh4UiQFje1Ef3p7JqvPsyJiTz13eEdD37zQPEjVjmobqLU
         3pcxmzw80HwIhaHXUnEgGDs7+mhK1AZ2wumjXO/Z6XyUEGiSx4RLu+5DK25dt252MSp/
         l7ow==
X-Gm-Message-State: ACgBeo3pX88jDNvk/bh4v6A/bTDkTDYP0rBNmGtLv34lJ86FI9KYw7Oi
        4aqGpS5sz6qARSy3lDCuaDN+4w==
X-Google-Smtp-Source: AA6agR7puL6VPpiLUw4h8ZUVmcsARjHVSMYrBqA2X3GSjrJIgrFAFtzlnqCrzhx8J7kB3X/44JIF6w==
X-Received: by 2002:a05:6000:120a:b0:21f:dfb:ff12 with SMTP id e10-20020a056000120a00b0021f0dfbff12mr4405609wrx.215.1659711468096;
        Fri, 05 Aug 2022 07:57:48 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:57:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 04/26] thermal/drivers/st: Use generic trip points
Date:   Fri,  5 Aug 2022 16:57:07 +0200
Message-Id: <20220805145729.2491611-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert to the generic trip points

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/st/st_thermal.c | 47 +++++----------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 1276b95604fe..c0d45cdd1c2f 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -134,48 +134,12 @@ static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
 	return 0;
 }
 
-static int st_thermal_get_trip_type(struct thermal_zone_device *th,
-				int trip, enum thermal_trip_type *type)
-{
-	struct st_thermal_sensor *sensor = th->devdata;
-	struct device *dev = sensor->dev;
-
-	switch (trip) {
-	case 0:
-		*type = THERMAL_TRIP_CRITICAL;
-		break;
-	default:
-		dev_err(dev, "invalid trip point\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int st_thermal_get_trip_temp(struct thermal_zone_device *th,
-				    int trip, int *temp)
-{
-	struct st_thermal_sensor *sensor = th->devdata;
-	struct device *dev = sensor->dev;
-
-	switch (trip) {
-	case 0:
-		*temp = mcelsius(sensor->cdata->crit_temp);
-		break;
-	default:
-		dev_err(dev, "Invalid trip point\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static struct thermal_zone_device_ops st_tz_ops = {
 	.get_temp	= st_thermal_get_temp,
-	.get_trip_type	= st_thermal_get_trip_type,
-	.get_trip_temp	= st_thermal_get_trip_temp,
 };
 
+static struct thermal_trip trip;
+
 int st_thermal_register(struct platform_device *pdev,
 			const struct of_device_id *st_thermal_of_match)
 {
@@ -238,9 +202,12 @@ int st_thermal_register(struct platform_device *pdev,
 
 	polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
 
+	trip.temperature = sensor->cdata->crit_temp;
+	trip.type = THERMAL_TRIP_CRITICAL;
+	
 	sensor->thermal_dev =
-		thermal_zone_device_register(dev_name(dev), 1, 0, sensor,
-					     &st_tz_ops, NULL, 0, polling_delay);
+		thermal_zone_device_register_with_trips(dev_name(dev), &trip, 1, 0, sensor,
+							&st_tz_ops, NULL, 0, polling_delay);
 	if (IS_ERR(sensor->thermal_dev)) {
 		dev_err(dev, "failed to register thermal zone device\n");
 		ret = PTR_ERR(sensor->thermal_dev);
-- 
2.25.1

