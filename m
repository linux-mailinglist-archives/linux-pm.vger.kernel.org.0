Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D385BFB4F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiIUJoG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiIUJnp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:43:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C04692F44
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t14so8890636wrx.8
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=HiA3EfjWkOce7HwilnMsNfPhOfemF/8YL8t+8lZHmM5THJGFye6sXuc2WOQuNkuYGc
         IJNRokWV+QLpeV7kcY7pkPnQrjNKVQW/WHEDtcjgUL7e6SXZf7HRAH8XBtRKWUJtSYTq
         K6Zu0noiOKiIdlA3di/oIW7dCCBKLtZONbToCEKVIZTEJz8WBBDQ1yznH05XcRIqUxge
         HZv2MarsMNF+4vTDqZ/BvZiYeKv4Pq6kTKUNLAv6oRTYEc3IhVjQD4D5trYKuHjEg0a7
         g1Dss0cy8Si4/T4uQwqgGNIWj8+htpRKLnUNrGQDk4Ty/Qqa1pTFekXHythD+zjsaA1v
         zbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=DgzXljNiySJ21rjMvidz49fOPEVFvBmsyuP20XaGmolrwV1Jk6cwUe6JavuBawrb5n
         ShfOUYuOHZm3vUjk1+/3DVjrVh8e6MkIVCY/QfS8X4m7mh0VEl1vh12b6xVCUaeiw3sZ
         FCj8xik290Juy+rnAh0pIn6tsf65qMqXdV3b5RgkYIGtJ+fRKr9iRK7p75KRZs6XmJVB
         7fDdPeWCZ5//reakOlk0OKYCEk8sWpPrY0TB9jakTNYIBmCZPU6XGglufcUyzhcgYkZ6
         G4szYUvV0dKdNYt+NNzF5b2sA7uXy4oToke4cQvRLz7QFU4U/9qEGgEkJ+FblUU7DJ+0
         KsKw==
X-Gm-Message-State: ACrzQf39mDwS8mOLysX9vuzPQpX9/qqdaImxeSKbkO+aqAyLtdRYvBYp
        Y+QpM0VzDJIvRg+aId00EuvYdw==
X-Google-Smtp-Source: AMsMyM6NfenDQBTBp7WJSQFB8n58E4eQqGgdYyhShAn/pvOtGqYuaxoJdDoba+Fjvj4KZxef1xoG1Q==
X-Received: by 2002:a5d:5c0a:0:b0:228:db53:22cc with SMTP id cc10-20020a5d5c0a000000b00228db5322ccmr15551040wrb.126.1663753421667;
        Wed, 21 Sep 2022 02:43:41 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 13/30] thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:26 +0200
Message-Id: <20220921094244.606948-14-daniel.lezcano@linaro.org>
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

