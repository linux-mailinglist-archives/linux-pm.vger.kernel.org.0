Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFFF68A09E
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 18:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjBCRom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 12:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjBCRok (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 12:44:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585A7A6416
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 09:44:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h16so5304093wrz.12
        for <linux-pm@vger.kernel.org>; Fri, 03 Feb 2023 09:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvG3PRWH913fhYfH6droRPy4T3voXfu7htf9rVkWrmY=;
        b=qwNlPSp1MnZRQDOzdvzYvscwlJf/fPN9pAI2O8lFIa3Afq0jZDw8I4kT7BJUuQxbHq
         AjJOO+MkoJCEeYs7T3bye/AAX0bBBi2JFJYOTjHXK15vdfDohAjdBeA7iC/DVIzI8hAL
         iYet/5hpYBv2KbrI3y4GB4ty95bAo2zJegAWkicQFeN2Q++hqIKf6LMyWhcKPyHHXGUq
         EWhGLwO7h1AxG+PMzjwg+UzqVkyNleK5rNS9HNpzl6axS7TFiHDz8+7WASq691E4FotA
         UYfuJSLUYPMNBqWK+Qo+66J8q6HYlimuOMMS+VZl5yfHoP00ogau7hn+DhIKFOoLyQiC
         zOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvG3PRWH913fhYfH6droRPy4T3voXfu7htf9rVkWrmY=;
        b=W1+6oggYTgNiyuZuYm6lYpizN1Jiuo1EHe2CGJwKcmSvrsuCITV39ew3Mf+8GQ44e6
         nXP3vGsSS9X7asoHEsKEavv1uBcYmD54/ViVqjDJMnwtxyqU6EJIPlFDib+50POEnFhM
         3Ecdo0eC1sjLVA2C6XVm0NbyiGOYJ1VmV3hEABCawCBkaLt5MBuwi40JfqYK2Pspbgzg
         HfNUkGUK+0KKugOiHOQONFgF2W8E+I4yBSU9Tn7OTiHp8uyT3iH20zXCer1J8zu2/oyl
         J0q8Jr7b1ZM68g1MvhdWnw1mYmwpGL2GD9UyGuhxsZIXUZFSPNS7lOpvGnqmMljm7LW/
         D1xw==
X-Gm-Message-State: AO0yUKUFy/+75LQo43YgMY5MFs1HWT/A2unp8bic0GtjI0cQfTtp4eLI
        8kvBjA39bj5BIBJTkusT8VZrLQ==
X-Google-Smtp-Source: AK7set/MhNbOiPJdYvvo+t7zZfcPjqCXm0XMkOQ9Lu/PUB5HZnWG0FcHoiaMvOmQLKpU8AbM9LTO1A==
X-Received: by 2002:a5d:6501:0:b0:2c2:de2b:e7cd with SMTP id x1-20020a5d6501000000b002c2de2be7cdmr11285651wru.50.1675446276812;
        Fri, 03 Feb 2023 09:44:36 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:36 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 04/11] thermal/acpi: Move the active trip points to the same array
Date:   Fri,  3 Feb 2023 18:44:22 +0100
Message-Id: <20230203174429.3375691-5-daniel.lezcano@linaro.org>
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

This change does the second pass to move the active trip points in the
thermal trip array.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 71 +++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 6b07de78c4c6..903f0e3d95f5 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -153,7 +153,6 @@ struct acpi_thermal {
 	struct acpi_thermal_flags flags;
 	struct acpi_thermal_state state;
 	struct acpi_thermal_trip trips[ACPI_THERMAL_TRIP_MAX];
-	struct acpi_thermal_trip active[ACPI_THERMAL_MAX_ACTIVE];
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
@@ -379,19 +378,19 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	}
 
 	/* Active (optional) */
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
-		valid = tz->active[i].flags.valid;
+		valid = tz->trips[i].flags.valid;
 
 		if (act == -1)
 			break; /* disable all active trip points */
 
 		if (flag == ACPI_TRIPS_INIT || ((flag & ACPI_TRIPS_ACTIVE) &&
-		    tz->active[i].flags.valid)) {
+		    tz->trips[i].flags.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 						       name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
-				tz->active[i].flags.valid = 0;
+				tz->trips[i].flags.valid = 0;
 				if (i == 0)
 					break;
 
@@ -399,50 +398,50 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					break;
 
 				if (i == 1)
-					tz->active[0].temperature = celsius_to_deci_kelvin(act);
+					tz->trips[0].temperature = celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
 					 * the next higher trip point
 					 */
-					tz->active[i - 1].temperature =
-						(tz->active[i - 2].temperature <
+					tz->trips[i - 1].temperature =
+						(tz->trips[i - 2].temperature <
 						celsius_to_deci_kelvin(act) ?
-						tz->active[i - 2].temperature :
+						tz->trips[i - 2].temperature :
 						celsius_to_deci_kelvin(act));
 
 				break;
 			} else {
-				tz->active[i].temperature = tmp;
-				tz->active[i].flags.valid = 1;
+				tz->trips[i].temperature = tmp;
+				tz->trips[i].flags.valid = 1;
 			}
 		}
 
 		name[2] = 'L';
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->active[i].flags.valid ) {
+		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips[i].flags.valid ) {
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 							 name, NULL, &devices);
 			if (ACPI_FAILURE(status)) {
 				acpi_handle_info(tz->device->handle,
 						 "Invalid active%d threshold\n", i);
-				tz->active[i].flags.valid = 0;
+				tz->trips[i].flags.valid = 0;
 			} else {
-				tz->active[i].flags.valid = 1;
+				tz->trips[i].flags.valid = 1;
 			}
 
-			if (memcmp(&tz->active[i].devices, &devices,
+			if (memcmp(&tz->trips[i].devices, &devices,
 				   sizeof(struct acpi_handle_list))) {
-				memcpy(&tz->active[i].devices, &devices,
+				memcpy(&tz->trips[i].devices, &devices,
 				       sizeof(struct acpi_handle_list));
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 			}
 		}
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
-			if (valid != tz->active[i].flags.valid)
+			if (valid != tz->trips[i].flags.valid)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 
-		if (!tz->active[i].flags.valid)
+		if (!tz->trips[i].flags.valid)
 			break;
 	}
 
@@ -471,8 +470,8 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid |
 		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-		valid |= tz->active[i].flags.valid;
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++)
+		valid |= tz->trips[i].flags.valid;
 
 	if (!valid) {
 		pr_warn(FW_BUG "No valid trip found\n");
@@ -533,7 +532,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->active[i].flags.valid; i++) {
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips[i].flags.valid; i++) {
 		if (!trip) {
 			*type = THERMAL_TRIP_ACTIVE;
 			return 0;
@@ -583,11 +582,11 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-		tz->active[i].flags.valid; i++) {
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE &&
+		tz->trips[i].flags.valid; i++) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->active[i].temperature,
+					tz->trips[i].temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
@@ -719,13 +718,13 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		}
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->active[i].flags.valid)
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (!tz->trips[i].flags.valid)
 			break;
 
 		trip++;
-		for (j = 0; j < tz->active[i].devices.count; j++) {
-			handle = tz->active[i].devices.handles[j];
+		for (j = 0; j < tz->trips[i].devices.count; j++) {
+			handle = tz->trips[i].devices.handles[j];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -791,7 +790,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 		trips++;
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->active[i].flags.valid;
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips[i].flags.valid;
 	     i++, trips++);
 
 	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
@@ -1082,20 +1081,20 @@ static int acpi_thermal_resume(struct device *dev)
 	if (!tz)
 		return -EINVAL;
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->active[i].flags.valid)
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (!tz->trips[i].flags.valid)
 			break;
-		tz->active[i].flags.enabled = 1;
-		for (j = 0; j < tz->active[i].devices.count; j++) {
+		tz->trips[i].flags.enabled = 1;
+		for (j = 0; j < tz->trips[i].devices.count; j++) {
 			result = acpi_bus_update_power(
-					tz->active[i].devices.handles[j],
+					tz->trips[i].devices.handles[j],
 					&power_state);
 			if (result || (power_state != ACPI_STATE_D0)) {
-				tz->active[i].flags.enabled = 0;
+				tz->trips[i].flags.enabled = 0;
 				break;
 			}
 		}
-		tz->state.active |= tz->active[i].flags.enabled;
+		tz->state.active |= tz->trips[i].flags.enabled;
 	}
 
 	acpi_queue_thermal_check(tz);
-- 
2.34.1

