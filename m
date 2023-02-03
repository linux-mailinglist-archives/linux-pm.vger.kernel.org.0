Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F6D68A09B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 18:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjBCRol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 12:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjBCRoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 12:44:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484E391891
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 09:44:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d14so5317570wrr.9
        for <linux-pm@vger.kernel.org>; Fri, 03 Feb 2023 09:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gq0E/YoPxBHVucgVAdwG/B9OSJ+hQO93j4O3hXiF4s=;
        b=EiUgBGFg+IZtrkgshrjMw9NhkIw51oabUGEtQG4CGKDSNxdcGtlKaZHYgMyqTzmSCT
         2+gH72tKugYjNsPhOTsLpR2UmbqwX3mxFq3R4Gx2CCQ32AGuvYYtDX+huDJ7+Sm/Ke1U
         RGMWnB7I9Ct4xyauoFNwvdv+uulB3JNgUKX3AG2dQX1m1HsFzKVqv0v8J6Kirl/8JCwi
         RP72dpcYN17OZp1CW/0+sBn8oWC7n8SKV7h9Ary+GtmiAnq+3WGZD0kFchSnLCdcEqcu
         iGcsw5QSIhCNkGxhC8Eqvx0clVKC6y6YFm+22lHgO0ZAPdmZzi9w95LevAB/NVg696mZ
         tKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gq0E/YoPxBHVucgVAdwG/B9OSJ+hQO93j4O3hXiF4s=;
        b=B+kw5A5zmxBSjymUMnl3dtSvBtpJIIGg6WAPWvxb7i7k14qLKYTdLpXaRptmxiY95U
         jkxgK38ENBHGPWbRPTwmMsLC+1bbLGxXe10WGO9/HC+rl9LW1pm58AJ1R/WoSrMBRrSb
         Jg7p8wCH7vPcXFnwaXBfFuhXgk91IlFZvb5h5LsD2iPbED7r8O7mDdiOOeHMrG/xFUAR
         YUwTS9fvDdJzVzVvfnUhVriO8pAlCE8SHXpz3lUh7V851SmZ28UHRJ0b+yw4jo3GM0Bu
         kkqKpHIOZDEhLe/+z3nU/weXLiXfrGmkI66A3Uwbstmc7ts00IBZGps5vh4b9/3SSDcw
         SVsA==
X-Gm-Message-State: AO0yUKVk4jw4wZdq7qsoWJhECIX4MhkVse7ieEneK2S+lEuUJZ5fj/HA
        lX9sLsUaSoJW7qR5nBJUMW/7lg==
X-Google-Smtp-Source: AK7set8fUoYvbB6+sK45Y9YUGmpUfoTPf8N5vlfqm2UyFbejHPZjRFu/7xoxt/Oc9EYva+WL1wOLyA==
X-Received: by 2002:adf:d0cc:0:b0:2bf:e01c:b9d0 with SMTP id z12-20020adfd0cc000000b002bfe01cb9d0mr9257756wrh.13.1675446275662;
        Fri, 03 Feb 2023 09:44:35 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 03/11] thermal/acpi: Convert the acpi thermal trips to an array
Date:   Fri,  3 Feb 2023 18:44:21 +0100
Message-Id: <20230203174429.3375691-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
References: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of having multiple trip points in the structure fields for
each trip type, let's create an array of trip points.

No functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 130 ++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 61 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index e27b0b71fcf8..6b07de78c4c6 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -104,6 +104,15 @@ static struct acpi_driver acpi_thermal_driver = {
 	.drv.pm = &acpi_thermal_pm,
 };
 
+enum {
+	ACPI_THERMAL_TRIP_CRITICAL,
+	ACPI_THERMAL_TRIP_HOT,
+	ACPI_THERMAL_TRIP_PASSIVE,
+	ACPI_THERMAL_TRIP_ACTIVE
+};
+
+#define ACPI_THERMAL_TRIP_MAX (ACPI_THERMAL_TRIP_ACTIVE + ACPI_THERMAL_MAX_ACTIVE)
+
 struct acpi_thermal_state {
 	u8 critical:1;
 	u8 hot:1;
@@ -143,9 +152,7 @@ struct acpi_thermal {
 	volatile u8 zombie;
 	struct acpi_thermal_flags flags;
 	struct acpi_thermal_state state;
-	struct acpi_thermal_trip critical;
-	struct acpi_thermal_trip hot;
-	struct acpi_thermal_trip passive;
+	struct acpi_thermal_trip trips[ACPI_THERMAL_TRIP_MAX];
 	struct acpi_thermal_trip active[ACPI_THERMAL_MAX_ACTIVE];
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
@@ -251,7 +258,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	/* Critical Shutdown */
 	if (flag & ACPI_TRIPS_CRITICAL) {
 		status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
-		tz->critical.temperature = tmp;
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = tmp;
 
 		/*
 		 * Treat freezing temperatures as invalid as well; some
@@ -260,32 +267,32 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		 * ... so lets discard those as invalid.
 		 */
 		if (ACPI_FAILURE(status)) {
-			tz->critical.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
 			acpi_handle_debug(tz->device->handle,
 					  "No critical threshold\n");
 		} else if (tmp <= 2732) {
 			pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
-			tz->critical.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
 		} else {
-			tz->critical.flags.valid = 1;
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 1;
 			acpi_handle_debug(tz->device->handle,
 					  "Found critical threshold [%lu]\n",
-					  tz->critical.temperature);
+					  tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature);
 		}
 
-		if (tz->critical.flags.valid) {
+		if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 			if (crt == -1) {
-				tz->critical.flags.valid = 0;
+				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
 			} else if (crt > 0) {
 				unsigned long crt_k = celsius_to_deci_kelvin(crt);
 
 				/*
 				 * Allow override critical threshold
 				 */
-				if (crt_k > tz->critical.temperature)
+				if (crt_k > tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature)
 					pr_info("Critical threshold %d C\n", crt);
 
-				tz->critical.temperature = crt_k;
+				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = crt_k;
 			}
 		}
 	}
@@ -294,22 +301,22 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	if (flag & ACPI_TRIPS_HOT) {
 		status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
 		if (ACPI_FAILURE(status)) {
-			tz->hot.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 0;
 			acpi_handle_debug(tz->device->handle,
 					  "No hot threshold\n");
 		} else {
-			tz->hot.temperature = tmp;
-			tz->hot.flags.valid = 1;
+			tz->trips[ACPI_THERMAL_TRIP_HOT].temperature = tmp;
+			tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 1;
 			acpi_handle_debug(tz->device->handle,
 					  "Found hot threshold [%lu]\n",
-					  tz->hot.temperature);
+					  tz->trips[ACPI_THERMAL_TRIP_HOT].temperature);
 		}
 	}
 
 	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->passive.flags.valid) ||
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
 	    flag == ACPI_TRIPS_INIT) {
-		valid = tz->passive.flags.valid;
+		valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
@@ -321,53 +328,53 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		}
 
 		if (ACPI_FAILURE(status)) {
-			tz->passive.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 		} else {
-			tz->passive.temperature = tmp;
-			tz->passive.flags.valid = 1;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature = tmp;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
 			if (flag == ACPI_TRIPS_INIT) {
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TC1", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->passive.flags.valid = 0;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 				else
-					tz->passive.tc1 = tmp;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 = tmp;
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TC2", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->passive.flags.valid = 0;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 				else
-					tz->passive.tc2 = tmp;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 = tmp;
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TSP", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->passive.flags.valid = 0;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 				else
-					tz->passive.tsp = tmp;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp = tmp;
 			}
 		}
 	}
-	if ((flag & ACPI_TRIPS_DEVICES) && tz->passive.flags.valid) {
+	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 						 NULL, &devices);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(tz->device->handle,
 					 "Invalid passive threshold\n");
-			tz->passive.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 		} else {
-			tz->passive.flags.valid = 1;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
 		}
 
-		if (memcmp(&tz->passive.devices, &devices,
+		if (memcmp(&tz->trips[ACPI_THERMAL_TRIP_PASSIVE].devices, &devices,
 			   sizeof(struct acpi_handle_list))) {
-			memcpy(&tz->passive.devices, &devices,
+			memcpy(&tz->trips[ACPI_THERMAL_TRIP_PASSIVE].devices, &devices,
 			       sizeof(struct acpi_handle_list));
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
-		if (valid != tz->passive.flags.valid)
+		if (valid != tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 	}
 
@@ -460,9 +467,9 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 	if (ret)
 		return ret;
 
-	valid = tz->critical.flags.valid |
-		tz->hot.flags.valid |
-		tz->passive.flags.valid;
+	valid = tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid |
+		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid |
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
 		valid |= tz->active[i].flags.valid;
@@ -502,7 +509,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->critical.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_CRITICAL;
 			return 0;
@@ -510,7 +517,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	if (tz->hot.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_HOT;
 			return 0;
@@ -518,7 +525,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	if (tz->passive.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_PASSIVE;
 			return 0;
@@ -546,30 +553,30 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->critical.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->critical.temperature,
+					tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
 	}
 
-	if (tz->hot.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->hot.temperature,
+					tz->trips[ACPI_THERMAL_TRIP_HOT].temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
 	}
 
-	if (tz->passive.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->passive.temperature,
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
@@ -595,9 +602,9 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 {
 	struct acpi_thermal *tz = thermal->devdata;
 
-	if (tz->critical.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 		*temperature = deci_kelvin_to_millicelsius_with_offset(
-					tz->critical.temperature,
+					tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature,
 					tz->kelvin_offset);
 		return 0;
 	}
@@ -635,8 +642,9 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 	 * tz->temperature has already been updated by generic thermal layer,
 	 * before this callback being invoked
 	 */
-	i = (tz->passive.tc1 * (tz->temperature - tz->last_temperature)) +
-		(tz->passive.tc2 * (tz->temperature - tz->passive.temperature));
+	i = (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 * (tz->temperature - tz->last_temperature)) +
+		(tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 *
+		(tz->temperature - tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature));
 
 	if (i > 0)
 		*trend = THERMAL_TREND_RAISING;
@@ -681,16 +689,16 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 	int trip = -1;
 	int result = 0;
 
-	if (tz->critical.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid)
 		trip++;
 
-	if (tz->hot.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid)
 		trip++;
 
-	if (tz->passive.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		trip++;
-		for (i = 0; i < tz->passive.devices.count; i++) {
-			handle = tz->passive.devices.handles[i];
+		for (i = 0; i < tz->trips[ACPI_THERMAL_TRIP_PASSIVE].devices.count; i++) {
+			handle = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].devices.handles[i];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -774,23 +782,23 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	acpi_status status;
 	int i;
 
-	if (tz->critical.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid)
 		trips++;
 
-	if (tz->hot.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid)
 		trips++;
 
-	if (tz->passive.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 		trips++;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->active[i].flags.valid;
 	     i++, trips++);
 
-	if (tz->passive.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
 						     		&acpi_thermal_zone_ops, NULL,
-						     		tz->passive.tsp*100,
+						     		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp*100,
 						     		tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
@@ -966,8 +974,8 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
  */
 static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
 {
-	if (tz->critical.flags.valid &&
-	    (tz->critical.temperature % 5) == 1)
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid &&
+	    (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature % 5) == 1)
 		tz->kelvin_offset = 273100;
 	else
 		tz->kelvin_offset = 273200;
-- 
2.34.1

