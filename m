Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C465AF1B6
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 19:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbiIFRCL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Sep 2022 13:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiIFRAx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 13:00:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3D32BF9
        for <linux-pm@vger.kernel.org>; Tue,  6 Sep 2022 09:48:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b17so3006663wrq.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2022 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=p+Fs/P7gXsm/5qHeFX0rzCcy4XeIXDeOEwU0TTt39+U=;
        b=EKosuhPmamKh8eudEZ2RzXf5XbSruIwibMeFNYl82Yy+t7A4utedR5Ygq9u1JiPtiF
         EWtFH+tYTimbNnYMMd0othiT7OZmLs+jTvY7gGZ1DaLD4EHI69QLUnBZn3ebykybLjhm
         yACddMSIDxxOR1w+XBrtrcM6BBng9p5eKv82pX/mfzUMPnWuqjfWe/hPvUVXA3JGV/N2
         FipS2jzylHOn5naGFC9Jr3ISmvXSXKhNgFXUT9UtkVGEg4Yf22kuZ96u/0lb9A8b4UWa
         /HhZjZcyk3zeJXR9wAQfWPCU2K9dR6xbBta1NRKp06O2vzn6jsbBe/Z8V3okVVl+1cwp
         8o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p+Fs/P7gXsm/5qHeFX0rzCcy4XeIXDeOEwU0TTt39+U=;
        b=OeypYZvr2uMG1qdKqyX/oT0ecC+XZc840Cz5vPsFvJrdiUAf5H6NvGkcpflBkVnqgN
         o8DaOC+XGM4y2WhHa4GOhpZbujuAfAAzwjl5NFd4zs6ilpwn0pgwXNX8vHXzAdBFisK3
         MeBpp8n1jNKhlnPk7T0S765hS2o/mOGhuN6bIP6k+B72Q8u7D0rWYY+rXDVPdYXx/3Sp
         nROG+Ph5ru2o3dkTzJ2Hv8LXgl77p22i7ngBJNsveGLo++22osz9MkDP+fYDDxMpKgYn
         GGkrLpd9hxu4xVo4+bb8UdjBPSu1csV6fBUXDvX9G9WeW51V+gDvHy6ooMmg1QKIPIL1
         yzGg==
X-Gm-Message-State: ACgBeo3vlBOQbE9L8cGWH43xpEK84y+NXaVWWvcM3VC2nB9wnYbbxTWD
        SFXNyhU4lx1HSiy7Qh9XLKbxow==
X-Google-Smtp-Source: AA6agR4J05UbRmdHYPYTJtZXUoFCiI/16fLjg7zBs9gpPVM5ZWo/WW23zG1rT35tPKwOfxAKuz3wkw==
X-Received: by 2002:a5d:6d8f:0:b0:225:6285:47fb with SMTP id l15-20020a5d6d8f000000b00225628547fbmr29029509wrs.211.1662482883567;
        Tue, 06 Sep 2022 09:48:03 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:48:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 21/30] thermal/drivers/st: Use generic trip points
Date:   Tue,  6 Sep 2022 18:47:11 +0200
Message-Id: <20220906164720.330701-22-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
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
2.34.1

