Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5B5BFB6E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiIUJor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiIUJn5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:43:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B998492F6B
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c11so8860714wrp.11
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=p+Fs/P7gXsm/5qHeFX0rzCcy4XeIXDeOEwU0TTt39+U=;
        b=YlKrfk8RE2F5000dDu+v0V/biI5dCrVqLGu7QlklQ2VQZuUtUPB5hZtQ7bxnTZLqR4
         ZxJI97ai6fONmSjjXj8o5u48bIuIamdK2YkasqKqvBQrEsDhjWEG1peqy40CKTtjkuYc
         RC+XXmUlOhzDi+ooD3s/96IiEoaFSV7NL8U3HYIi831eYtzdXA95/H9gks84YH0+R3xU
         QINJ8jsNEhqQ7F1YDJJLf9j/U97dGOXwHyV64yOrPcDGLCIGHBaMxriHlK/kh5PL7j80
         hPMHAZPYizCKtptGr+Ae1FM/7ZjpteBiqCm6GaLBALN+yreIxImDNotIOz1DA1FFQACy
         HRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p+Fs/P7gXsm/5qHeFX0rzCcy4XeIXDeOEwU0TTt39+U=;
        b=a7333Lp2T07gLCB/OD7ESZ/3puYTh2zhuZUdXbbkx7S4+amWIejkQMjxOihipaalfB
         pMc3Z1h6CRFibyF/0cofhvPtd1jsmaXGLz7+SyuT5ZplJQcmNnyAR6HlEId8jjxQPisD
         PAXGUJ2DNz96wiwqOmYWVwa4rYr5rqU8FqvnYmm6JkxW0hsTYohsyqiziFJFJ/jvSYhJ
         Sk8PP2qRmjlhN7dKQSbckqkZ6wRzu2b8AFreLl8BTdjy3uDUhRZB0nP9bQHUI7EeGnXp
         h0kIcQdlxgnrjI+rCsfsGgNoYOEPyH2X7POqhEF/9a5Ru3jBgKHI41brJtHNK0BOsZaZ
         TKzg==
X-Gm-Message-State: ACrzQf1X5ssSBtqb3/DOHSirx5/QGXTNZpTWRDPO9QlkRmDaZVD4Zxy6
        8vyugwVoFYdqmpGP1y3LXxoOfQ==
X-Google-Smtp-Source: AMsMyM5lA2FlwPWZwjhbhB8WsnWSj7OG43VpvJgzm7PuJax9Ul+507ve7BJiR4MCIGWCzUJanqIL9w==
X-Received: by 2002:a5d:5942:0:b0:225:7425:4e39 with SMTP id e2-20020a5d5942000000b0022574254e39mr16213887wri.566.1663753432145;
        Wed, 21 Sep 2022 02:43:52 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 21/30] thermal/drivers/st: Use generic trip points
Date:   Wed, 21 Sep 2022 11:42:34 +0200
Message-Id: <20220921094244.606948-22-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
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

