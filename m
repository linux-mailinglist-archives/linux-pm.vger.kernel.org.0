Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAFA10CAC0
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfK1OzH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:55:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45897 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1OzG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:55:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1so13001947pgg.12;
        Thu, 28 Nov 2019 06:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tz6cOySRhhfYX2f36nBxCYaBCi3b9m633gEDdn5gfjw=;
        b=lJ5RWnOcf9hz2ftj8KTcQGPpf3wmYM+buvrM43OU3L8IBdlJvDoFySEr6Ue1r2NAvW
         OYp1QSPl6ahDR1CDkXEivs4ODAvYZug9dj9HhQTY1LKZrNkuxAnh401HCWVlZZSFeidX
         rUtYPWdE7gSSX9CMXKAudZf05NeeGvzR6WCiFrrU/rKincHxgWuxSj8IVbwlZ51tUPfY
         HuwA1o5s2Om+mh2dF27jNNQtMZ/mBieMAnprCgL7ckqtM10ghRMSDhDaxqLqg/JtLSWK
         Zq1onyweBBJgqzDy5KgcLWV4MrjHdSxuiDFUhIrcVBHJMpftNWDdngWfHB7G8EWQ+riY
         aCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tz6cOySRhhfYX2f36nBxCYaBCi3b9m633gEDdn5gfjw=;
        b=ae/fE14PBnnP+UluEfSitdnMWmNgfT4e96ftFyJ1LjQ2ABJpPxKhBXFXWcaUSJ10Nt
         O9XL7s/TNP2edMpwKdlExglccLWcXgwo3GdPxIGZ6jiZHQTj+iuMTtaTkJb7PTsa7Mz1
         42wqnXnEUMVz58OQoAGsCE8QHRN5EF1qkrxsvI+4yaM4H7+PECNlmDwdrirZ8R2Z3WC7
         T9g0Bj1WT3oMVAUl0SLobrPLs9T7PDkxMSfsYZnwxr8k3TdUDCaIkZNJD4/375CkVWyy
         +sdhHBy9HpjiAhUJ9bkuDkOfiJsRxPIHKImFm/8ypLE1qqbhorUKkB08THOxSndv7G9d
         1cHg==
X-Gm-Message-State: APjAAAXuhU0dbXQqycYP4z07KIQkRsB43jbvay1mXraOJjp/FOtiKGJS
        KTWCoYtwdhAbHfmRD/eYj2k=
X-Google-Smtp-Source: APXvYqxXpb6vyYoRS/aQShEZodxv0UryrA00GtVnoBcusA/RH5RFqbeXCJm2b9a9wHzCXw69HHgjWg==
X-Received: by 2002:a65:6916:: with SMTP id s22mr11388523pgq.244.1574952905215;
        Thu, 28 Nov 2019 06:55:05 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
        by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:55:04 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 2/8] ACPI: thermal: switch to use <linux/temperature.h> helpers
Date:   Thu, 28 Nov 2019 23:54:33 +0900
Message-Id: <1574952879-7200-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This switches the ACPI thermal zone driver to use celsius_to_deci_kelvin(),
deci_kelvin_to_celsius(), and deci_kelvin_to_millicelsius_with_offset() in
<linux/temperature.h> instead of helpers in <linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/temperature.h>.

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- include <linux/temperature.h> explicitly from thermal drivers
- fix s/temprature/temperature/ typo in commit log
- use deci_kelvin_to_millicelsius_with_offset()

 drivers/acpi/thermal.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d831a61..9f96e66 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -24,6 +24,7 @@
 #include <linux/reboot.h>
 #include <linux/device.h>
 #include <linux/thermal.h>
+#include <linux/temperature.h>
 #include <linux/acpi.h>
 #include <linux/workqueue.h>
 #include <linux/uaccess.h>
@@ -172,7 +173,7 @@ struct acpi_thermal {
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int tz_enabled;
-	int kelvin_offset;
+	int kelvin_offset;	/* in millidegrees */
 	struct work_struct thermal_check_work;
 };
 
@@ -297,7 +298,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			if (crt == -1) {
 				tz->trips.critical.flags.valid = 0;
 			} else if (crt > 0) {
-				unsigned long crt_k = CELSIUS_TO_DECI_KELVIN(crt);
+				unsigned long crt_k =
+					celsius_to_deci_kelvin(crt);
+
 				/*
 				 * Allow override critical threshold
 				 */
@@ -333,7 +336,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
-			tmp = CELSIUS_TO_DECI_KELVIN(psv);
+			tmp = celsius_to_deci_kelvin(psv);
 			status = AE_OK;
 		} else {
 			status = acpi_evaluate_integer(tz->device->handle,
@@ -413,7 +416,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					break;
 				if (i == 1)
 					tz->trips.active[0].temperature =
-						CELSIUS_TO_DECI_KELVIN(act);
+						celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
@@ -421,9 +424,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					 */
 					tz->trips.active[i - 1].temperature =
 						(tz->trips.active[i - 2].temperature <
-						CELSIUS_TO_DECI_KELVIN(act) ?
+						celsius_to_deci_kelvin(act) ?
 						tz->trips.active[i - 2].temperature :
-						CELSIUS_TO_DECI_KELVIN(act));
+						celsius_to_deci_kelvin(act));
 				break;
 			} else {
 				tz->trips.active[i].temperature = tmp;
@@ -519,7 +522,7 @@ static int thermal_get_temp(struct thermal_zone_device *thermal, int *temp)
 	if (result)
 		return result;
 
-	*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(tz->temperature,
+	*temp = deci_kelvin_to_millicelsius_with_offset(tz->temperature,
 							tz->kelvin_offset);
 	return 0;
 }
@@ -624,7 +627,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.critical.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.critical.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -634,7 +637,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.hot.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.hot.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -644,7 +647,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.passive.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.passive.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -655,7 +658,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 		tz->trips.active[i].flags.valid; i++) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.active[i].temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -672,7 +675,7 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 	struct acpi_thermal *tz = thermal->devdata;
 
 	if (tz->trips.critical.flags.valid) {
-		*temperature = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+		*temperature = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.critical.temperature,
 				tz->kelvin_offset);
 		return 0;
@@ -692,7 +695,7 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 
 	if (type == THERMAL_TRIP_ACTIVE) {
 		int trip_temp;
-		int temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+		int temp = deci_kelvin_to_millicelsius_with_offset(
 					tz->temperature, tz->kelvin_offset);
 		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
 			return -EINVAL;
@@ -1043,9 +1046,9 @@ static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
 {
 	if (tz->trips.critical.flags.valid &&
 	    (tz->trips.critical.temperature % 5) == 1)
-		tz->kelvin_offset = 2731;
+		tz->kelvin_offset = 273100;
 	else
-		tz->kelvin_offset = 2732;
+		tz->kelvin_offset = 273200;
 }
 
 static void acpi_thermal_check_fn(struct work_struct *work)
@@ -1087,7 +1090,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
 
 	pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
-		acpi_device_bid(device), DECI_KELVIN_TO_CELSIUS(tz->temperature));
+		acpi_device_bid(device),
+		deci_kelvin_to_celsius(tz->temperature));
 	goto end;
 
 free_memory:
-- 
2.7.4

