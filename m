Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9085AF18C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbiIFRBq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Sep 2022 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbiIFRA3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 13:00:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A4015833
        for <linux-pm@vger.kernel.org>; Tue,  6 Sep 2022 09:47:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bj14so3080231wrb.12
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2022 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cMvv+kIwS7Npnyybgo7TEwbxPHKi63Y9shqXlNy7AcU=;
        b=o2Drx44fkG4j30Cv18Jj0fH8NYaJNqOoQ2Y9uNDGN/HImEDm1CzWmPt4QyBXERmIFY
         s33uHIZguNwiHpAJJdwH4QT/OyxoQRvY9kqDDbczu8WpzqxXjL9BTIU5BgGKNM4qi/gN
         oaBgvtcbZifPqdSLMRHousXkh/IwwOhRLbx8ALXzHpvVhUUrN0nysGBKD21FqsdU6qWq
         nXTKchuulIad6+GWIl8v5pVFeDG8Lcn4IGtFKR3XuA+qMRKaCj4hgG0tAvXNeHHD0x0S
         JzcmpGWHSqEj+XApFODrGSuC1Szk2oOHcecEDQ4zXDG01bZ/K7SKv1YvygpACAiKUV9g
         GgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cMvv+kIwS7Npnyybgo7TEwbxPHKi63Y9shqXlNy7AcU=;
        b=zsJHB4uUS4pbWfJWHrCBVfiX1si21U3OB/CQxaugpJd+PmbgktlXmJwXw3QJr9fMHZ
         FCGSjMzOCb0U2kQn+Zi07Gcoekcrh7WezOHyqTdiWbpdGoHRJ5PVaIcuCUHvoTUTAb4Y
         VAxW6bVtFnkLITA/1PZGdFL0g/S2WXaaoZ4HG1HqU5l2ip1+brKTuGYea70vUP4/IrlJ
         EvTtnkLWd/+6scHHEItgvq2ZFWDUgEY/ts7UDH9U+isshWJ/2uuRHoM+/j7XOEVE4ORV
         ZgKG49MG119pz9NMmQrcl3afKPe8NTWHhDA/IJnWbhB62hrFCEjOQ3TcR7kL03sbKmrx
         zAkA==
X-Gm-Message-State: ACgBeo1QgXlprGx70ge9sSkC85mRIZ1hYD9vNHQRpCJQkaytJ8o6yofS
        HsGHAkdOeCsWUbuj8wSsZ8gk+Q==
X-Google-Smtp-Source: AA6agR6L/A1f6iTqUUlJYsPdQq4UZhycMAPeB0XlufMbFv05QWUVdUMlwE45Nar+AlIbBaEyxleQCw==
X-Received: by 2002:adf:de83:0:b0:228:d8ad:c0c6 with SMTP id w3-20020adfde83000000b00228d8adc0c6mr2612614wrl.500.1662482876379;
        Tue, 06 Sep 2022 09:47:56 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 15/30] thermal/drivers/armada: Use generic thermal_zone_get_trip() function
Date:   Tue,  6 Sep 2022 18:47:05 +0200
Message-Id: <20220906164720.330701-16-daniel.lezcano@linaro.org>
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
---
 drivers/thermal/armada_thermal.c | 39 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 52d63b3997fe..9444e5a22ca0 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -785,33 +785,34 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 					 int sensor_id)
 {
 	/* Retrieve the critical trip point to enable the overheat interrupt */
-	const struct thermal_trip *trips = of_thermal_get_trip_points(tz);
+	struct thermal_trip trip;
 	int ret;
 	int i;
 
-	if (!trips)
-		return -EINVAL;
-
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++)
-		if (trips[i].type == THERMAL_TRIP_CRITICAL)
-			break;
+	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
 
-	if (i == of_thermal_get_ntrips(tz))
-		return -EINVAL;
+		ret = thermal_zone_get_trip(tz, i, &trip);
+		if (ret)
+			return ret;
+		
+		if (trip.type != THERMAL_TRIP_CRITICAL) 
+			continue;
 
-	ret = armada_select_channel(priv, sensor_id);
-	if (ret)
-		return ret;
+		ret = armada_select_channel(priv, sensor_id);
+		if (ret)
+			return ret;
+		
+		armada_set_overheat_thresholds(priv, trip.temperature,
+					       trip.hysteresis);
+		priv->overheat_sensor = tz;
+		priv->interrupt_source = sensor_id;
 
-	armada_set_overheat_thresholds(priv,
-				       trips[i].temperature,
-				       trips[i].hysteresis);
-	priv->overheat_sensor = tz;
-	priv->interrupt_source = sensor_id;
+		armada_enable_overheat_interrupt(priv);
 
-	armada_enable_overheat_interrupt(priv);
+		return 0;
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int armada_thermal_probe(struct platform_device *pdev)
-- 
2.34.1

