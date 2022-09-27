Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F11F5EC651
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiI0OeA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiI0OdO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE775F98F
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c11so15269287wrp.11
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/DpVb9+AKUGgq8A4EZDNel0xrsv5+R31U81PHZWHu7A=;
        b=wWHPNc9KiPFjFJPGPM1cmcCNOLkxsnFdo3qlLmlcGNsDgozzeDodboy37a1hgyU+Em
         8Wf+hHWPHct4UAPPSoCL1fe8+ZfSmUBUm7ZEUPAovTqsZPsCgtuu+DrK0lvVrGsW0R+e
         o5S5pNzCiwisspUCsaQpCZ8RdiC7h77ipIhTihZsjD2TlE5lfZh0rXXpSSejq7gpzj7B
         cSRNNNtVBNFT85TITwi0TGRG3YUj3ju/nGccydy0kyjxHpsGUAjZyo0UYMz/ejEN4GLf
         fdz74xdPkMHBMP1u5CEAsHd2euoQR73mocSVYfMBkEjqgN/nSXLIx8b2ZwQX/FPgmN+B
         dTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/DpVb9+AKUGgq8A4EZDNel0xrsv5+R31U81PHZWHu7A=;
        b=PjPMl8nuOuQYQX0FXZ2Peh4K/KqrfS/HkbDDOMg6LOmfWZWYAOIz9NDjFOituCx0Ww
         yiXvfrrfI5iEpbKUTf7WS1Y1ijCBwBZAqxNui0gku+Gg3yDsKqy2FSZ0H7aPvp60BikA
         c8KAQYEfQRYumxl7p1c5peF9Fw/iFEnclk7pmRNRyApGv519J2zGfTALMqtIU1df0Fa7
         u/dab2B1FXhMzhONOSmo1724SdN2g0agun1TvYTIhLkFmRL6AF51Rr39PgZ1JZ/ck6nc
         aCkVt5+JWJ7Hz8KkVEmOBokSANpdnuToRtRsMjRGW2ojBcwLrdOJPn4ODwv7z0cLbKgv
         +F+w==
X-Gm-Message-State: ACrzQf0DwlbWP8sQtSpKGkd8wYjHbgWqd5NQZoMkHrVoE6tVc9GrBqKO
        l5dfmva4nmP9/ZX0sOxfz+yZdA==
X-Google-Smtp-Source: AMsMyM6HlnqOd9arHzbjJM9erMfyIAzq8I+BPrvB9ienm/bm0vdAoY9IgENNNfK+8T4trX26hz1s2Q==
X-Received: by 2002:adf:ef06:0:b0:228:d60c:cf74 with SMTP id e6-20020adfef06000000b00228d60ccf74mr17020049wro.302.1664289189932;
        Tue, 27 Sep 2022 07:33:09 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH v6 13/29] thermal/drivers/qcom: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:23 +0200
Message-Id: <20220927143239.376737-14-daniel.lezcano@linaro.org>
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

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Amit Kucheria <amitk@kernel.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 39 +++++++++------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index be785ab37e53..127e8c90211c 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -263,17 +263,17 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
 
-static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
+static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
 {
 	struct qpnp_tm_chip *chip = tz->devdata;
-	const struct thermal_trip *trip_points;
+	struct thermal_trip trip;
 	int ret;
 
-	trip_points = of_thermal_get_trip_points(chip->tz_dev);
-	if (!trip_points)
-		return -EINVAL;
+	ret = thermal_zone_get_trip(chip->tz_dev, trip_id, &trip);
+	if (ret)
+		return ret;
 
-	if (trip_points[trip].type != THERMAL_TRIP_CRITICAL)
+	if (trip.type != THERMAL_TRIP_CRITICAL)
 		return 0;
 
 	mutex_lock(&chip->lock);
@@ -299,22 +299,17 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 
 static int qpnp_tm_get_critical_trip_temp(struct qpnp_tm_chip *chip)
 {
-	int ntrips;
-	const struct thermal_trip *trips;
-	int i;
-
-	ntrips = of_thermal_get_ntrips(chip->tz_dev);
-	if (ntrips <= 0)
-		return THERMAL_TEMP_INVALID;
-
-	trips = of_thermal_get_trip_points(chip->tz_dev);
-	if (!trips)
-		return THERMAL_TEMP_INVALID;
-
-	for (i = 0; i < ntrips; i++) {
-		if (of_thermal_is_trip_valid(chip->tz_dev, i) &&
-		    trips[i].type == THERMAL_TRIP_CRITICAL)
-			return trips[i].temperature;
+	struct thermal_trip trip;
+	int i, ret;
+
+	for (i = 0; i < thermal_zone_get_num_trips(chip->tz_dev); i++) {
+
+		ret = thermal_zone_get_trip(chip->tz_dev, i, &trip);
+		if (ret)
+			continue;
+
+		if (trip.type == THERMAL_TRIP_CRITICAL)
+			return trip.temperature;
 	}
 
 	return THERMAL_TEMP_INVALID;
-- 
2.34.1

