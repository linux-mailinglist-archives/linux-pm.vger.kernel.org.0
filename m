Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFC5104A64
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 06:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKUFvB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 00:51:01 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:43464 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKUFvB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 00:51:01 -0500
Received: by mail-pf1-f179.google.com with SMTP id 3so1078338pfb.10
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 21:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JGGvAMwItuoHstBCxzBFlnEPhYOMIX4l46IdZuoC2/M=;
        b=Fz4Sk5GVK5yzfp85dWuOdBmN3v4o/SZkgqWLkcznYBuZpncK+kvROD0g0pgFqHoejx
         QTgjMdMSw6sDhTqB43CpULkdQ/gbixX2e5c1HXIHA+13SaNRpAHQ1S2kKrp03cZ+XnG5
         c97YKLJLOb+t5ibkgqI+zT/ov9ayGp3ddwsm8OruJUm3go7L9jMT8S1mCteS9TZTqjV5
         Dh6jS/sRlwhKHUkRGAdAktDsvXDkr3nyA7Y+5TBAf1yKF1KatCZpL4UK5iQ8EE1zKdOx
         yYUsRmGaFKPQzGfM7hFtoLkH+VxE2+QMW0sl8cinnMKtc4QixHbgnjOQOADrxDAj+Qhc
         iH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JGGvAMwItuoHstBCxzBFlnEPhYOMIX4l46IdZuoC2/M=;
        b=Bc4zeGqrZcXQ6S25VGkSCWqbGaoME4QJfb/5Be6QwfLUwvn9jFzmNK1txJMR9awdHp
         ikK7rWFuEXBI2FRUwl2IIGHKYObU27AfdTrywC34WSOmx5qN7ctsOX8tfgBej4AehtbW
         1YwuwZmxZQxxtBAsq+jyF9TGYs8K2H56w4JJpXbvqEBj+jhoqlVQt0xluTbABs/gID/q
         6b4xMPaUPu9oiBM2GGoVhvQFE16IXHgXqDvGbLv3KWCrkU4AuHdQxxoaSp64oeCuFaMm
         FEtD9w0PXCPZLqZtZ3/XO3NDRrR0JEjZWi427IYAp5VuQ23CFOKgbQlNyvS8GwPU+7oz
         4Bjw==
X-Gm-Message-State: APjAAAWgYkfvdMu9BIITNvBjWKAsmOuzTDnsgcLvXiMeWtC1kOT+aRv4
        eejwg+HYZZ8BsH20aSsWstcJZA==
X-Google-Smtp-Source: APXvYqya8XMLiF/AAZZAFUs8GkqZDwAAd1YByFMk4g0oIU4vDMez4wH0hkEat+T+ZiYrqqKJk4NB4A==
X-Received: by 2002:a63:c60f:: with SMTP id w15mr7481209pgg.33.1574315460190;
        Wed, 20 Nov 2019 21:51:00 -0800 (PST)
Received: from localhost ([14.96.100.229])
        by smtp.gmail.com with ESMTPSA id x2sm1443211pfn.167.2019.11.20.21.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 21:50:59 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org, j-keerthy@ti.com,
        thara.gopinath@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Subject: [PATCH] drivers: thermal: step_wise: add support for hysteresis
Date:   Thu, 21 Nov 2019 11:20:56 +0530
Message-Id: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ram Chandrasekar <rkumbako@codeaurora.org>

Currently, step wise governor increases the mitigation when the
temperature goes above a threshold and decreases the mitigation when the
temperature goes below the threshold. If there is a case where the
temperature is wavering around the threshold, the mitigation will be
applied and removed every iteration, which is not very efficient.

The use of hysteresis temperature could avoid this ping-pong of
mitigation by relaxing the mitigation to happen only when the
temperature goes below this lower hysteresis value.

Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
[Rebased patch from downstream]
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/step_wise.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 6e051cbd824ff..2c8a34a7cf959 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -24,7 +24,7 @@
  *       for this trip point
  *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
  *       for this trip point
- * If the temperature is lower than a trip point,
+ * If the temperature is lower than a hysteresis temperature,
  *    a. if the trend is THERMAL_TREND_RAISING, do nothing
  *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
  *       state for this trip point, if the cooling state already
@@ -115,30 +115,31 @@ static void update_passive_instance(struct thermal_zone_device *tz,
 
 static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 {
-	int trip_temp;
+	int trip_temp, hyst_temp;
 	enum thermal_trip_type trip_type;
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
-	bool throttle = false;
+	bool throttle;
 	int old_target;
 
 	if (trip == THERMAL_TRIPS_NONE) {
-		trip_temp = tz->forced_passive;
+		hyst_temp = trip_temp = tz->forced_passive;
 		trip_type = THERMAL_TRIPS_NONE;
 	} else {
 		tz->ops->get_trip_temp(tz, trip, &trip_temp);
+		hyst_temp = trip_temp;
+		if (tz->ops->get_trip_hyst) {
+			tz->ops->get_trip_hyst(tz, trip, &hyst_temp);
+			hyst_temp = trip_temp - hyst_temp;
+		}
 		tz->ops->get_trip_type(tz, trip, &trip_type);
 	}
 
 	trend = get_tz_trend(tz, trip);
 
-	if (tz->temperature >= trip_temp) {
-		throttle = true;
-		trace_thermal_zone_trip(tz, trip, trip_type);
-	}
-
-	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
-				trip, trip_type, trip_temp, trend, throttle);
+	dev_dbg(&tz->device,
+		"Trip%d[type=%d,temp=%d,hyst=%d]:trend=%d,throttle=%d\n",
+		trip, trip_type, trip_temp, hyst_temp, trend, throttle);
 
 	mutex_lock(&tz->lock);
 
@@ -147,6 +148,18 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 			continue;
 
 		old_target = instance->target;
+		throttle = false;
+		/*
+		 * Lower the mitigation only if the temperature
+		 * goes below the hysteresis temperature.
+		 */
+		if (tz->temperature >= trip_temp ||
+		    (tz->temperature >= hyst_temp &&
+		     old_target != THERMAL_NO_TARGET)) {
+			throttle = true;
+			trace_thermal_zone_trip(tz, trip, trip_type);
+		}
+
 		instance->target = get_target_state(instance, trend, throttle);
 		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
 					old_target, (int)instance->target);
-- 
2.17.1

