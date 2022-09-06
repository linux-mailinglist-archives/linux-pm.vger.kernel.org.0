Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46395AF1C1
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 19:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiIFRBm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Sep 2022 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiIFRA1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 13:00:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BC325C72
        for <linux-pm@vger.kernel.org>; Tue,  6 Sep 2022 09:47:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bj14so3080078wrb.12
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2022 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=SAvsaLnOlt88T31BJg3d/NE6I1Fikz4B/1KIa3gznPIlyumnWKkN+Vy8PKEF0QgVZC
         bkGr0XGsjoB9QzG+WNb7LrLxBAbIsCnITif3W6Tz+u35t39t2kL3UMCX3lHsVuRzFtAo
         7O+LALOQ0lw1aNkpeI7+3cCYC/+bb0XmQL/5bVqx6d19e2OrCgM9T8LAvMb6gBf8Ho95
         P3otz7ieT8wLOiH1wVp/OmYtPfUQIllEiNYULV3GyMJRq9d9uyMZbiJF/fbCKzmxZMdj
         SMnWUKaf6et49/2Izb9W7wUwMTTt8alpiho0R6hBk63EL22wNJkRMK7Mqte5mXJDMqhh
         IpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=OrwGF6MO7yuV3p5HAG4JDrJ7RPkH1oRNFemI3wy8NM5v5JjMQQ2lzazDAYYOlakGAg
         yUK9Gte7MjHjYS9kSw3KQ1Bt3QjUWr4n33s3GEYob+m/mwe3CIwVAxyMcQXf75dDrKQ1
         ynvWgCg/C4mTCKdPQHCUsiD7tTXrO1ZJUkCDqmWQmOrP7rORl+rcfrMbnvCHc2ETioP8
         UIotGwmVs532Mk/PhV7O8Fue1TZiESKlnoqiOgqzeobtBYEMSrQ4DfNtF9/UoNLPSQ7/
         jbMdTxGmSzCeFgmBxHtzJo7OMygpfOVo87Gd73nSIsnrxUKhiFwvsomIHuPY2msqWCTo
         HmQg==
X-Gm-Message-State: ACgBeo3IZL+EFLi9IumAyw2R67nNv+fF9/kKqnS6Xa0nWTEmz6Dkh3mY
        S6wUjKKhAHdtm4BIt8veIX8a7Q==
X-Google-Smtp-Source: AA6agR4yqaf3T+RQFZVMp7sDoWHkvl4zxJu4orXD8DRdx9+5cECkQlLXmtyK7XOmfceQibo6YtJ6pA==
X-Received: by 2002:a5d:5581:0:b0:20f:fc51:7754 with SMTP id i1-20020a5d5581000000b0020ffc517754mr29121262wrv.413.1662482873999;
        Tue, 06 Sep 2022 09:47:53 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:53 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 13/30] thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
Date:   Tue,  6 Sep 2022 18:47:03 +0200
Message-Id: <20220906164720.330701-14-daniel.lezcano@linaro.org>
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

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index d6974db7aaf7..45226cab466e 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -482,7 +482,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_sensor *sensor)
 {
 	int ret, i;
-	const struct thermal_trip *trip;
+	struct thermal_trip trip;
 
 	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
 						    sensor->id, sensor,
@@ -495,11 +495,12 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 		return ret;
 	}
 
-	trip = of_thermal_get_trip_points(sensor->tzd);
+	for (i = 0; i < thermal_zone_get_num_trips(sensor->tzd); i++) {
 
-	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
-		if (trip[i].type == THERMAL_TRIP_PASSIVE) {
-			sensor->thres_temp = trip[i].temperature;
+		thermal_zone_get_trip(sensor->tzd, i, &trip);
+
+		if (trip.type == THERMAL_TRIP_PASSIVE) {
+			sensor->thres_temp = trip.temperature;
 			break;
 		}
 	}
-- 
2.34.1

