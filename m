Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAA5EC666
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiI0OeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiI0Od1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7981B8C8E
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r10-20020a1c440a000000b003b494ffc00bso1442061wma.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=p+Fs/P7gXsm/5qHeFX0rzCcy4XeIXDeOEwU0TTt39+U=;
        b=muIwp4KSVFZq74pAsh1gg/E9+tciGaTyRzZsgtdnBHu3UrElsMl5AghtqeKqbhqnrR
         8icu7cnZv4QXBjw9oGE3ZBWIw40TVdJI6RRdsAUYHIWGt8v+MkYrJtOXpdrdXonIJeQq
         Usfmr++skmHKNwPK8I8/inGYFkgzxlVpHDA1lYDRoiZV2NQH69afbtrf15Ft7y+QMHbe
         dO+jDMX2R9QD7/cunWtuXW9DLDyj+u+j4MCxewuRHI9vhdYKuiv0y0/LAwioar31P9B3
         YT/lxEtEyvNMwxLQ0zGPrjeMSEE0GCGdBycdBIssnO5DaS4hM2+Y6H6TFsVjr/XkejS2
         2heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p+Fs/P7gXsm/5qHeFX0rzCcy4XeIXDeOEwU0TTt39+U=;
        b=Fwj6Bvz9zJjPVPUoWSD0GNwl8ZfcfJZj0vgXLc0MPcmus/J3dnrW7Hw/gBSC7llu7g
         F+ESX7RoE3yqC2Vosf/A8k9wb2oJSlnYUqhaX285YBWU/P2SNv+ianuGY66ciY8iXGcA
         iU0vddGS6VDGWvC0hFN+Y2/+vrx6iDJHyPbidkledekeW2BAgpB0XiNPgSXTIHLWtPVa
         PwrK4T/XoNy8TyUYJD6ZOCZOYu9qMoisHwP0FL0Vr7NPlbknefbVp66LvD16cw2YvzXx
         /6XVibrvIQYF+jWR51lT1CcZ9yf1+lfric+uCI2jdxrtQ2DMAzl5w19Q5YuoeQrmo3Et
         tjtg==
X-Gm-Message-State: ACrzQf2uFzrsv/7hxR4zO6ZQT073Oc4pqxaFkAHfVxp96Bog+bcvvVko
        Xx+iuPNZHEEtn1wFVD78s3SWyQ==
X-Google-Smtp-Source: AMsMyM4Z7d+imiOgkK+Q8Dy0fUw1Wvw+a8WjZiD2JrnY3ZAgzrd9MQqDHMAWN/MjVdbd0BtLCMdEKw==
X-Received: by 2002:a7b:cd14:0:b0:3b4:8680:79a7 with SMTP id f20-20020a7bcd14000000b003b4868079a7mr3067311wmj.28.1664289198898;
        Tue, 27 Sep 2022 07:33:18 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 20/29] thermal/drivers/st: Use generic trip points
Date:   Tue, 27 Sep 2022 16:32:30 +0200
Message-Id: <20220927143239.376737-21-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

