Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888D55AF188
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 19:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbiIFRBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Sep 2022 13:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbiIFRA3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 13:00:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD310D8
        for <linux-pm@vger.kernel.org>; Tue,  6 Sep 2022 09:47:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b5so16357849wrr.5
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2022 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/DpVb9+AKUGgq8A4EZDNel0xrsv5+R31U81PHZWHu7A=;
        b=X1YQe4f852MWDEDIbxLyzt5EWKhqVbyY6KreD6n8q9N6gvC4i5WIAkAzHEI8dxRQw2
         T4b4m7BwfLcHYcdzVERs6l2W8E+H4GpJhLC8IrZYCL528FKDWNHlWXC6PTvkSj6jbCpm
         VCmB3xaFeU0IFsA/r9xJ92FaeOzlD9rTbJUN0L9w1QOY77nEKGDBTYH2+HsDyR7R3ssd
         JLEUG/KkypsRIDRloNuetGhHaNobFHXm4VCxBtHscQYXC2wf9BJtse7X+THpJ5rz10JD
         3jcOl3Mk1zLbgjzqFTdPpzHhw7uYKsp2+pj102XoPdHncWPhOWf/46R+CSvdlP8UCEXO
         +h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/DpVb9+AKUGgq8A4EZDNel0xrsv5+R31U81PHZWHu7A=;
        b=JndkOsoIauLBSuDGzgoRFrWRovJ5HY1pYiWTTePIzLSuWNw7zX23MkwFYkPRd+OiyL
         tXkJ2vISrVUgIcmj68qUSlVkawa9IRUYqkh5zo/YEeoHtHGd9iGyXqnFe4IVgDBwl5S1
         o/cMwHD88UjHh3W4eNjESKxsGT5yTQcppUdqU+bSUL2MxUfYLsmzRA8hv62/xoFWCK+u
         0pZ8qDcu5V6OJYd+AvAqcTQ1Lf8IGDfd24wStzR/m/JZqIrdLZkq7xGG/MPFze4/tTe4
         MoL5tAA7AL/Q6q9wrzWULr6XeVdfv6inuLmMuxr9qjC8TRAWOVhrHXfed1QoPMqLcHsS
         8WhQ==
X-Gm-Message-State: ACgBeo1yvPgz60mCTpJMiEi7UPsQ8BwxHgBGGVzAZIjTCG4NhKFQ/yyG
        2AuUzczHL7TrZI0/DBu5PjPp0yznh8UM3Q==
X-Google-Smtp-Source: AA6agR7726/EhQnxyUAI0pB44o1EaZhJhbR16yBCc7vE9TFIiuCwg9pWS0Hms7JxnJjgbdDiSwJYdQ==
X-Received: by 2002:adf:ec03:0:b0:228:76bd:76fc with SMTP id x3-20020adfec03000000b0022876bd76fcmr6904673wrn.533.1662482875286;
        Tue, 06 Sep 2022 09:47:55 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:54 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-msm@vger.kernel.org (open list:QUALCOMM TSENS THERMAL DRIVER)
Subject: [PATCH v3 14/30] thermal/drivers/qcom: Use generic thermal_zone_get_trip() function
Date:   Tue,  6 Sep 2022 18:47:04 +0200
Message-Id: <20220906164720.330701-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

